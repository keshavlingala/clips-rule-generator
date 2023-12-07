
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



with open('stackoverflow_full.csv','r') as f:
    with open('dataset.clp','w') as f2:
        f2.write('(deffacts applicants\n')
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
            # all_applicants[id]=Applicant(id,edulevel,gender,mainbranch,accessibility,yearscode,yearscodepro,country,skills)
            skillstr=''
            for skill in skills.split(';'):
                skillstr+=f'"{skill}" '
            f2.write(f'(applicant (id {id}) (edlevel "{edulevel}") (gender "{gender}") (mainbranch "{mainbranch}") (accessibility "{accessibility}") (yearscode {yearscode}) (yearscodepro {yearscodepro}) (country "{country}") (skills {skillstr}))\n')
        f2.write(')\n')
   