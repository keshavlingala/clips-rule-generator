import clips

class Applicant:

    def __init__(self,id,edlevel,gender,mainbranch,accessibility,yearscode,yearscodepro,country,skills):
        self.id=id
        self.edlevel=edlevel
        self.gender=gender
        self.mainbranch=mainbranch
        self.accessibility=accessibility
        self.yearscode=yearscode
        self.yearscodepro=yearscodepro
        self.country=country
        self.skills=skills

    def __str__(self):
        return f"""
        Applicant ID: {self.id} 
        Education Level: {self.edlevel}
        Gender: {self.gender}
        Main Branch of Expertise: {self.mainbranch}
        Accessibility: {self.accessibility}
        Years of Coding: {self.yearscode}
        Years of Professional Coding: {self.yearscodepro}
        Country: {self.country}
        Skills: {self.skills}
        """


all_applicants={}


template_string = """
(deftemplate applicant
   (slot id (type INTEGER))
   (slot edlevel)
   (slot gender)
   (slot mainbranch)
   (slot accessibility)
   (slot yearscode (type INTEGER))
   (slot yearscodepro (type INTEGER))
   (slot country)
   (multislot skills))
"""

env = clips.Environment()

env.build(template_string)

applicant = env.find_template('applicant')

print('Welcome to Recruitment Matching System')
print('--------------------------------------')


print('Loading Dataset...')

with open('stackoverflow_full.csv','r') as f:
    for line in f.readlines()[1:]:
        line=line.split(',')
        id=line[0]
        accessibility=line[2]
        edulevel=line[3]
        gender=line[5]
        mainbranch=line[7]
        yearscode=line[8]
        yearscodepro=line[9]
        country=line[10]
        skills=line[12]
        all_applicants[id]=Applicant(id,edulevel,gender,mainbranch,accessibility,yearscode,yearscodepro,country,skills)
        applicant.assert_fact(
            id=int(id),
            edlevel=edulevel,
            gender=gender,
            mainbranch=mainbranch,
            accessibility=accessibility,
            yearscode=int(yearscode),
            yearscodepro=int(yearscodepro),
            country=country,
            skills=skills.split(';'),
        )

print('Dataset Loaded!')

def generate_defrule(country,edlevel,gender,mainbranch,accessibility,yearscode,yearscodepro,skills):
    rule_gen='(defrule filter-rule-generated (applicant (id ?id) \n'
    if country!='':
        rule_gen+=f'(country "{country}") \n'
    if edlevel!='':
        rule_gen+=f'(edlevel "{edlevel}") \n'

    if gender!='':
        rule_gen+= f'(gender "{gender}") \n'
    
    if mainbranch!='':
        rule_gen+= f'(mainbranch "{mainbranch}") \n'
    
    if accessibility!='':
        rule_gen+= f'(accessibility "{accessibility}") \n'

    rule_gen+='(yearscode ?yc) (yearscodepro ?ycp) (skills $?skills))\n'

    if yearscode!='':
        rule_gen+= f'(test (>= ?yc {yearscode})) \n'
    
    if yearscodepro!='':
        rule_gen+= f'(test (>= ?ycp {yearscodepro})) \n'

    for skill in skills:
        if skill!='':
            rule_gen+= f'(test (member$ "{skill}" $?skills)) \n'

    rule_gen+='=> (assert (result ?id)))'
    return rule_gen

while True:
    print('Enter the Details of the Applicant to find the match')
    print('----------------------------------------------------------')

    country=input('Enter Country:')
    edlevel=input('Enter Education Level(Master/Undergraduate/PhD/NoHigherEd/Other):')
    gender = input('Enter Gender (Man/Woman/NonBinary): ')
    mainbranch = input('Enter Main Branch of Expertise (Dev/NotDev): ')
    accessibility = input('Enter Accessibility (Yes/No): ')
    yearscode = input('Enter Years of Coding: ')
    yearscodepro = input('Enter Years of Professional Coding: ')
    skills = input('Enter Skills (separated by space): ').split(' ')
    print('----------------------------------------------------------')
    rule=generate_defrule(country,edlevel,gender,mainbranch,accessibility,yearscode,yearscodepro,skills)
    env.build(rule)

    env.run()

    print('-'*50)
    print('Generated Rule for the Query:')
    print(rule)
    print('-'*50)
    results= [fact for fact in env.facts() if fact.template.name=='result']
    print('Number of Results:',len(results))
    for fact in results:
        print('----------------------------------------------------------')
        print(all_applicants[str(fact[0])])
        print('----------------------------------------------------------')

    print('Do you want to continue? (y/n)')
    if input()=='n':
        break