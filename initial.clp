(deftemplate user
   (slot name)
   (slot age)
   (slot experience)
   (multislot skills))


(assert (user (name "John Doe") (age 30) (experience 5) (skills "Java" "Python" "SQL")))
(assert (user (name "Jane Smith") (age 28) (experience 3) (skills "JavaScript" "HTML" "CSS")))





(defrule find-user-by-experience
   ?u <- (user (name ?name) (experience ?exp))
   (test (>= ?exp x))  ; 'x' is the experience you're looking for
   =>
   (printout t "User with experience: " ?name " has " ?exp " years of experience." crlf))


(defrule find-user-by-skills
   ?u <- (user (name ?name) (skills $?skills))
   (test (member$ y $?skills)) ; 'y' is one of the skills you're looking for
   (test (member$ z $?skills)) ; 'z' is another skill you're looking for
   =>
   (printout t "User: " ?name " has skills: " y " and " z "." crlf))


(defrule find-user-by-experience-and-skills
   ?u <- (user (name ?name) (experience ?exp) (skills $?skills))
   (test (>= ?exp x)) ; 'x' is the experience you're looking for
   (test (member$ y $?skills)) ; 'y' is one of the skills you're looking for
   (test (member$ z $?skills)) ; 'z' is another skill you're looking for
   =>
   (printout t "User: " ?name " with " ?exp " years of experience has skills: " y " and " z "." crlf))

