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

(deffacts applicants
    (applicant (id 0) (edlevel "Master") (gender "Man") (mainbranch "Dev") (accessibility "No") (yearscode 7) (yearscodepro 4) (country "Sweden") (skills "C++" "Python" "Git" "PostgreSQL"))
    (applicant (id 1) (edlevel "Undergraduate") (gender "Man") (mainbranch "Dev") (accessibility "No") (yearscode 12) (yearscodepro 5) (country "Spain") (skills "Bash/Shell" "HTML/CSS" "JavaScript" "Node.js" "SQL" "TypeScript" "Git" "Express" "React.js" "Vue.js" "AWS" "PostgreSQL"))

    (applicant (id 2) (edlevel "Master") (gender "Man") (mainbranch "Dev") (accessibility "No") (yearscode 15) (yearscodepro 6) (country "Germany") (skills "C" "C++" "Java" "Perl" "Ruby" "Git" "Ruby on Rails"))
    
    (applicant (id 3) (edlevel "Undergraduate") (gender "Man") (mainbranch "Dev") (accessibility "No") (yearscode 9) (yearscodepro 6) (country "Canada") (skills "Bash/Shell" "HTML/CSS" "JavaScript" "PHP" "Ruby" "SQL" "Git" "jQuery" "Laravel" "Ruby on Rails" "AWS" "MySQL" "PostgreSQL"))
    (applicant (id 4) (edlevel "PhD") (gender "Man") (mainbranch "NotDev") (accessibility "No") (yearscode 40) (yearscodepro 30) (country "Singapore") (skills "C++" "Python"))
    (applicant (id 5) (edlevel "Master") (gender "Man") (mainbranch "Dev") (accessibility "No") (yearscode 9) (yearscodepro 2) (country "France") (skills "JavaScript" "Python" "Docker" "Git" "MySQL"))

    (applicant (id 6) (edlevel "Master") (gender "Man") (mainbranch "Dev") (accessibility "No") (yearscode 26) (yearscodepro 18) (country "Germany") (skills "C++" "HTML/CSS" "Java" "JavaScript" "Kotlin" "Node.js" "TypeScript" "Docker" "Git" "Kubernetes" "Angular" "Express" "Spring" "AWS" "Heroku" "DynamoDB" "PostgreSQL"))
    
    (applicant (id 7) (edlevel "Master") (gender "Man") (mainbranch "NotDev") (accessibility "No") (yearscode 14) (yearscodepro 5) (country "Switzerland") (skills "C++" "Python" "Docker" "Git"))
    (applicant (id 8) (edlevel "Undergraduate") (gender "Man") (mainbranch "Dev") (accessibility "No") (yearscode 39) (yearscodepro 21) (country "United Kingdom of Great Britain and Northern Ireland") (skills "Python" "Git" "PostgreSQL"))
    (applicant (id 9) (edlevel "Master") (gender "Man") (mainbranch "Dev") (accessibility "No") (yearscode 20) (yearscodepro 16) (country "Russian Federation") (skills "Delphi" "Java" "SQL" "Docker" "Git" "PostgreSQL"))
)



(defrule filter-rule-generated
   (applicant (id ?id) (country "Germany") (edlevel "Master") (gender "Man") (mainbranch "Dev") (accessibility "No") (yearscode ?yc) (yearscodepro ?ycp) (skills $?skills))
    (test (>= ?yc 10))
    (test (>= ?ycp 5))
    (test (member$ "Kotlin" $?skills))
=>
   (assert (result ?id)))



(defrule filter-rule
   (applicant (id ?id) (skills $?skills))
    (test (member$ "Kotlin" $?skills))
=>
   (assert (result ?id)))

(defrule filter-rule-generated
 (applicant (id ?id) (yearscode ?yc) (yearscodepro ?ycp) (skills $?skills))
 (test (member$ "Java" $?skills))
 (test (member$ "Kotlin" $?skills))
  => (assert (result ?id)))