;----------------------------------------------------------------------------
; CLASSES
;----------------------------------------------------------------------------
(defclass PERSON
	(is-a USER)
	(role concrete)
	(slot company)
	(slot devicetype))

(defclass DEVICENAME
	(is-a USER)
	(slot company)
	(slot price)
	(slot suggested_device))

;----------------------------------------------------------------------------
; DEFAULT INSTANCES
;----------------------------------------------------------------------------

(definstances PERSON-INSTANCES
	(client of PERSON))

(definstances DEVICE-INSTANCES
	(which_device of DEVICENAME))

;----------------------------------------------------------------------------
; INITIAL USER INPUTS AND VALIDATIONS
;----------------------------------------------------------------------------


(deffunction member (?item $?list)
    (if (member$ ?item ?list)
        then TRUE
        else FALSE))

(deffunction user-input-validation (?question $?valid-input)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member ?answer ?valid-input)) do
      (printout t "Please enter a valid input as mentioned in the question!" crlf)
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))
   ?answer
)

   
; RULE TO GET THE USER INPUT
(defrule GetCompanion(declare (salience 10))
    =>
    (printout t crlf)
    (printout t "--------------------------------------------------------------------------------------------------------" crlf)
    (printout t "------------------------ WELCOME TO THE E-GARAGE ------------------------" crlf)
    (printout t "------------An Expert System for recommending Electronic devices-----------------" crlf)
    (printout t crlf)    
    (send [client] put-devicetype
    (user-input-validation "What do you want to buy? (mobile/tablet/laptop):  "mobile tablet laptop)))
   
;----------------------------------------------------------------------------
; RULES OF THE EXPERT SYSTEM TO SELECT THE DEVICE
;----------------------------------------------------------------------------

; RULE TO SELECT PERFECT MOBILE PHONE
(defrule buy_mobile
	?ins <- (object (is-a PERSON) (devicetype mobile))
	=> 
	(printout t crlf)
	(printout t "Let me select a Mobile suitable to buy in your budget..." crlf crlf)
   	(send [which_device] put-price
    (user-input-validation "Enter your preferred Price Range (under400$/ 400$-700$ / 700$-1000$ / above1000$):  "
    		under400$ 400$-700$ 700$-1000$ above1000$)))
   	 
; RULE TO SELECT PERFECT TABLET
(defrule buy_tablet
	?ins <- (object (is-a PERSON) (devicetype tablet))
	=> 
	(printout t crlf)
	(printout t "Let me select a Tablet suitable to buy in your budget..." crlf crlf)
    (send [which_device] put-price
  	(user-input-validation "Enter your preferred Price Range (under500$ / above500$): " 
  		under500$ above500$)))
   	 
; RULE TO SELECT PERFECT LAPTOP
(defrule buy_laptop
	?ins <- (object (is-a PERSON) (devicetype laptop))
	=> 
	(printout t crlf)
	(printout t "Let me select a laptop suitable to buy in your budget..." crlf crlf)
	(send [which_device] put-price
    (user-input-validation "Enter your preferred Price Range (under1500$ / above1500$): "
         under1500$ above1500$)))
   	 
; RULE TO TABLET ABOVE 500$
(defrule tab_above500$
	(and ?ins <- (object (is-a DEVICENAME) (price above500$))
	(object (is-a PERSON)(devicetype tablet)))
	=> 
	(printout t crlf)
	(printout t "Let me select a Tablet above 500$..." crlf crlf)
	(send [which_device] put-company
    (user-input-validation "Enter your preferred company (apple/samsung/lenovo):  "
        apple samsung lenovo)))

; RULE TO TABLET UNDER 500$
(defrule tab_under500$
	(and ?ins <- (object (is-a DEVICENAME) (price under500$))
	(object (is-a PERSON)(devicetype tablet)))
	=> 
	(printout t crlf)
	(printout t "Let me select a Tablet under 20k..." crlf crlf)
	(send [which_device] put-company
    (user-input-validation "Enter your preferred company (lenovo/google):  "
        lenovo google)))

   	
; RULE TO LAPTOP ABOVE 1.5K$
(defrule lap_above_1.5K$
	(and ?ins <- (object (is-a DEVICENAME) (price above1500$))
	(object (is-a PERSON)(devicetype laptop)))
	=> 
	(printout t crlf)
	(printout t "Let me select a laptop above 1.5K Dollars..." crlf crlf)
   	(send [which_device] put-company
   	(user-input-validation "Enter your preferred company (apple):  "
         apple)))

    ; RULE TO LAPTOP UNDER 1.5K$
(defrule lap_under1500$
	(and ?ins <- (object (is-a DEVICENAME) (price under1500$))
	(object (is-a PERSON)(devicetype laptop)))
	=> 
	(printout t crlf)
	(printout t "Let me select a laptop under 1.5K dollars..." crlf crlf)
   	(send [which_device] put-company
   	(user-input-validation "Enter your preferred company (hp/dell/lenovo):  "
         hp dell lenovo)))

; RULE TO MOBILE UNDER 400$
(defrule mob_under400$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile))
	(object (is-a DEVICENAME) (price under400$)))
	=> 
	(printout t crlf)
	(printout t "Let me select a Mobile Phone Under 400 dollars..." crlf crlf)
   	(send [client] put-company
   	(user-input-validation "Select your preferred company(oneplus/motorola/sony): "
         oneplus motorola sony)))

; RULE TO MOBILE 400$ - 700$
(defrule mob_400$700$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile))
	(object (is-a DEVICENAME) (price 400$-700$)))
	=> 
	(printout t crlf)
	(printout t "Let me select a Mobile Phone in range 400$ - 700$..." crlf crlf)
   	(send [client] put-company
   	(user-input-validation "What is your preferred comapny? (oneplus/samsung/apple):  "
         oneplus samsung apple)))
   	 
; RULE TO MOBILE 700$ - 100$
(defrule mob_700$1000$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile))
	(object (is-a DEVICENAME) (price 700$-1000$)))
	=> 
	(printout t crlf)
	(printout t "Let me select a Mobile Phone in range 700$ - 1000$..." crlf crlf)   	(send [client] put-company
   	(user-input-validation "What is your preferred company? (google/apple/samsung):  "
         google apple samsung)))
 
; RULE TO MOBILE ABOVE 1000$
(defrule mob_above1000$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile))
	(object (is-a DEVICENAME) (price above1000$)))
	=> 
	(printout t crlf)
	(printout t "Let me select a Mobile Phone above 1000$..." crlf crlf) 
   	(send [client] put-company
   	(user-input-validation "What is your preferred company? (google/apple/samsung):  "
         google apple samsung)))
 
; RULE TO BUY MOBILE ONEPLUS UNDER 400$
(defrule mob_oneplus_under400$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company oneplus))
	(object (is-a DEVICENAME) (price under400$)))
	=> 
	(send [which_device] put-suggested_device "Oneplus Nord N10 ($250) || Oneplus Nord N30 ($300)"))

; RULE TO BUY MOBILE MOTOROLA UNDER 400$
(defrule mob_motorola_under400$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company motorola))
	(object (is-a DEVICENAME) (price under400$)))
	=> 
	(send [which_device] put-suggested_device "Motorla edge 5G ($250) || Motorola Think Phone ($399)"))

; RULE TO BUY MOBILE SONY UNDER 400$
(defrule mob_sony_under400$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company sony))
	(object (is-a DEVICENAME) (price under400$)))
	=> 
	(send [which_device] put-suggested_device "Xperia 10V ($300) || Xperia 10 Plus ($350)"))

; RULE TO BUY MOBILE ONEPLUS 400$-700$
(defrule mob_oneplus_400$700$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company oneplus))
	(object (is-a DEVICENAME) (price 400$-700$)))
	=> 
	(send [which_device] put-suggested_device "Oneplus 10Pro ($550) || Oneplus 11 ($650)"))
	
; RULE TO BUY MOBILE SAMSUNG 400$-700$
(defrule mob_samsung_400$700$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company samsung))
	(object (is-a DEVICENAME) (price 400$-700$)))
	=> 
	(send [which_device] put-suggested_device "Galaxy S22 Ultra 128GB($500) || Galaxy S23 FE 128GB($699)"))
	
; RULE TO BUY MOBILE APPLE 400$-700$
(defrule mob_apple_400$700$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company apple))
	(object (is-a DEVICENAME) (price 400$-700$)))
	=> 
	(send [which_device] put-suggested_device "Iphone 13 Pro 128GB ($520) || Iphone 13 Pro Max 128GB($620)"))

; RULE TO BUY MOBILE GOOGLE 700$ - 1000$
(defrule mob_google_700$1000$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company google))
	(object (is-a DEVICENAME) (price 700$-1000$)))
	=> 
	(send [which_device] put-suggested_device " Google Pixel 7a ($799) || Google Pixel 7 Pro ($999)"))
	
; RULE TO BUY MOBILE APPLE 700$ - 1000$
(defrule mob_apple_700$1000$ 
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company apple))
	(object (is-a DEVICENAME) (price 700$-1000$)))
	=> 
	(send [which_device] put-suggested_device "Iphone 15 Pro ($999) || Iphone 15 ($799) || Iphone 14 Pro ($899)"))
	
; RULE TO BUY MOBILE SAMSUNG 700$ - 1000$
(defrule mob_samsung_700$1000$  
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company samsung))
	(object (is-a DEVICENAME) (price 700$-1000$)))
	=> 
	(send [which_device] put-suggested_device "Galaxy S23 ($750) || Galaxy Z-Flip 5($999)"))

; RULE TO BUY MOBILE GOOGLE ABOVE 1000$
(defrule mob_google_above1000$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company google))
	(object (is-a DEVICENAME) (price above1000$)))
	=> 
	(send [which_device] put-suggested_device "Google Pixel 8 Pro ($1199) || Google Pixel Fold ($1449)"))
	
; RULE TO BUY MOBILE APPLE ABOVE 1000$
(defrule mob_apple_above1000$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company apple))
	(object (is-a DEVICENAME) (price above1000$)))
	=> 
	(send [which_device] put-suggested_device "Iphone 15 Pro Max ($1499) || Iphone 14 Pro Max ($1299) || Iphone 15 Plus ($1199)"))
	
; RULE TO BUY MOBILE SAMSUNG ABOVE 1000$
(defrule mob_samsung_above1000$
	(and ?ins <- (object (is-a PERSON) (devicetype mobile) (company samsung))
	(object (is-a DEVICENAME) (price above1000$)))
	=> 
	(send [which_device] put-suggested_device "Galaxy S23 Ultra($1350) || Galaxy Z-Fold 5 ($1799)"))
	
; RULE TO BUY LENOVO TABLET UNDER 500$
(defrule tab_lenovo_under500$
	(and ?ins <- (object (is-a DEVICENAME) (price under500$) (company lenovo))
	(object(is-a PERSON)(devicetype tablet)))
	=> 
	(send ?ins put-suggested_device "Lenovo Tab 11Pro($320) || Lenovo Idea pad Duet5($499) || Lenovo Idea pad Duet 3($379)"))

; RULE TO BUY GOOGLE TABLET UNDER 500$
(defrule tab_google_under500$
	(and ?ins <- (object (is-a DEVICENAME) (price under500$) (company google))
	(object(is-a PERSON)(devicetype tablet)))
	=> 
	(send ?ins put-suggested_device "Google Pixel Tablet($499)")) 

; RULE TO BUY APPLE TABLET ABOVE 500$
(defrule tab_apple_above500$
	(and ?ins <- (object (is-a PERSON) (devicetype tablet))
	(object (is-a DEVICENAME) (company apple)(price above500$)))
	=> 
	(send [which_device] put-suggested_device "Ipad Air 10 ($599)  ||  Ipad 10 Pro  ($799)"))
	
; RULE TO BUY SAMSUNG TABLET ABOVE 500$
(defrule tab_samsung_above500$
	(and ?ins <- (object (is-a PERSON) (devicetype tablet))
	(object (is-a DEVICENAME) (company samsung)(price above500$)))
	=> 
	(send [which_device] put-suggested_device "Galaxy Tab S9 Ultra ($1299) || Galaxy Tab S9 FE ($549) || Galaxy S8 Ultra ($699)"))
	
; RULE TO BUY LENOVO TABLET ABOVE 500$
(defrule tab_lenovo_above500$
	(and ?ins <- (object (is-a PERSON) (devicetype tablet))
	(object (is-a DEVICENAME) (company lenovo)(price above500$)))
	=> 
	(send [which_device] put-suggested_device "Lenovo Yoga smart ($750) || Lenovo Tab M10($699)"))
	
; RULE TO BUY APPLE LAPTOP ABOVE 1.5K $
(defrule lap_apple_above1500$
	(and ?ins <- (object (is-a DEVICENAME) (price above1500$)(company apple))
	(object (is-a PERSON) (devicetype laptop)))
	=> 
	(send ?ins put-suggested_device "Mac M3 Pro($1999) || Mac M3 Max($2499) || Mac M3 ($1499)"))
	
; RULE TO BUY LENOVO LAPTOP BELOW 1.5K $
(defrule lap_lenovo_below_1500$
	(and ?ins <- (object (is-a DEVICENAME) (price under1500$)(company lenovo))
	(object (is-a PERSON) (devicetype laptop)))
	=> 
	(send ?ins put-suggested_device "Lenovo Yoga 7($750) || Lenovo Thinkpad 11($999)"))
	
; RULE TO BUY HP LAPTOP BELOW 1.5K $
(defrule lap_hp_below1500$
	(and ?ins <- (object (is-a DEVICENAME) (price under1500$)(company hp))
	(object (is-a PERSON) (devicetype laptop)))
	=> 
	(send ?ins put-suggested_device "HP Envy ($799) || HP Spectre ($1350)"))
	
(defrule lap_dell_below1500$
	(and ?ins <- (object (is-a DEVICENAME) (price under1500$)(company dell))
	(object (is-a PERSON) (devicetype laptop)))
	=> 
	(send ?ins put-suggested_device "Dell XPS ($1499) || Dell Inspiron ($999)"))
	(printout t crlf)
	(printout t "Let me select a Laptop Under 1500$..." crlf)) 
	
;----------------------------------------------------------------------------
; PRINTS THE FINAL SUGGESSION	
;----------------------------------------------------------------------------

; RULE TO PRINT THE SUGGESTED DEVICE
(defrule choose_device (declare (salience -1))
	(object (is-a DEVICENAME) (suggested_device ?mov))
	=>
	(printout t crlf)
	(printout t "-------------------------------------------------------------------------------------------------------------------------------" crlf)
    (printout t "The recommended Device which best suits your needs is: " ?mov crlf)
    (printout t "-------------------------------------------------------------------------------------------------------------------------------" crlf))