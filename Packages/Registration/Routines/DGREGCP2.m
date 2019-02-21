DGREGCP2 ;ALB/CLT - ADDRESS UTILITIES ;23 May 2017  1:33 PM
 ;;5.3;Registration;**941**;Aug 13, 1993;Build 73
 ;
POBOXRES(DGADDL1,STATE,CNTRY) ;TEST FOR UNALLOWED PO BOX AND GENERAL DELIVERY FOR RESIDENTIAL ADDRESS
 ; DGADDL1 - The address [LINE 1] text
 ; STATE - Internal State Code
 ; CNTRY - Internal Country Code
 ; returns 1 if PO box/general delivery not allowed for this address
 ; called from DGREGRED for validation of residential address on screen 1.1
 N DGCCHK
 ;  If country/state are allowed to have PO box, quit 0
 I $$OKPO(STATE,CNTRY) Q 0
 S DGCCHK=0
 ; Get result from checking for PO/General Delivery
 I $$ISPO(DGADDL1) S DGCCHK=1
 Q DGCCHK
 ;
POBOXPM(DFN) ;Check for PO Box/General Delivery in Permanent Mailing Address
 ; Returns 1 if Perm address contains PO Box or General delivery (allowing for exceptions)
 I '$D(^DPT(DFN,.11)) Q 0
 N DGRESADD,DGADDL1
 S DGRESADD=^DPT(DFN,.11)
 ; allow certain exceptions for countries/states that allow PO Box
 I $$OKPO($P(DGRESADD,U,5),$P(DGRESADD,U,10)) Q 0
 ; get address line 1
 S DGADDL1=$P(DGRESADD,U,1)
 ; return result from checking for PO/General Delivery
 Q $$ISPO(DGADDL1)
 ;
OKPO(STATE,CNTRY) ;PO BOX CHECK FOR CERTAIN COUNTRIES AND STATES
 ; Returns 1 if the country/state allows for PO box/general delivery
 ; Pass in the state and country codes to check
 ;PO Box and general delivery allowed for:  Veteran's Residential address is Alaska(2) or Hawaii (15)
 ;Veteran resides in one of the United States territories (Guam (state 66), American Samoa (state 60), CNMI (Mariana Islands state 69), 
 ; U.S. Virgin Islands (state 78), and Philippines (country code 167))
 ; Philippines check 
 I CNTRY=167 Q 1
 N DGSTATES
 S DGSTATES="^AS^AK^HI^GU^VI^MP^PH^"
 S STATE="^"_$$GET1^DIQ(5,STATE,1)_"^"
 ; If country=USA, check for allowed states/territories
 I CNTRY=1 I DGSTATES[STATE Q 1
 Q 0
ISPO(DGADDL1) ; check address line for presence of PO Box or General Delivery
 ; Returns 1 if the address line DGADDL1 contains PO/General Delivery
 N DGCCHK
 S DGCCHK=0
 ; strip out leading spaces
 F  QUIT:$E(DGADDL1,1)'=" "  S DGADDL1=$E(DGADDL1,2,$L(DGADDL1))
 ; translate to UPPERCASE and strip out any '.' chars (eg as in P.O. Box)
 S DGADDL1=$TR(DGADDL1,"abcdefghijklmnopqrstuvwxyz.","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I $E(DGADDL1,1,3)="PO "!($E(DGADDL1,1,11)="POST OFFICE")!(DGADDL1["GENERAL DELIVERY")!(DGADDL1?1"BOX "1N.ANP)!($E(DGADDL1,1,4)="P O ") S DGCCHK=1
 Q DGCCHK
