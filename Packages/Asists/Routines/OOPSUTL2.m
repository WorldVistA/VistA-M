OOPSUTL2 ;HINES/WAA-Utilities Routines ;3/24/98
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
CARE2(IEN) ; Update location field
 N LOC,GEN
 S GEN=$$GET1^DIQ(2260,IEN,27,"I")
 S LOC=$$GET1^DIQ(2261.4,GEN,2,"I")
 S $P(^OOPS(2260,IEN,"2162B"),U,1)=LOC
 Q
VCHAR ; Write error message if invalid character
 W !,"Invalid character entered (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <)",!,"please edit.",!
 Q
DEVSZ(IEN,DEV) ; This screens responses to the DEVICE SIZE table based on whether
 ; the OBJECT CAUSING INJURY field contains the word Needle or Syringe 
 ;
 ;  Input:  IEN - Internal Record Number of claim
 ;          DEV - Internal Record Number in ^OOPS(2262.2)
 ; Output: VIEW - if 1, can select, if 0, not available
 ;
 N OBJECT,VIEW
 S VIEW=0
 S OBJECT=$$UP^OOPSUTL4($$GET1^DIQ(2260,IEN,38))
 S TYPE=$$GET1^DIQ(2262.2,DEV,1,"I")
 I (OBJECT["NEEDLE")&(TYPE="N"!(TYPE="NS")) S VIEW=1
 I (OBJECT["SYRINGE")&(TYPE="S"!(TYPE="NS")) S VIEW=1
 Q VIEW
EQUIP() ; This will ask if the product failed
 N ANS,DIR,Y
 S ANS=0
 S DIR(0)="YO^"
 S ANS=0,DIR("B")=$S($P($G(^OOPS(2260,IEN,"2162D")),U,7)'="":"YES",1:"NO")
 S DIR("A")="WAS THERE AN EQUIPMENT/DEVICE/PRODUCT FAILURE"
 S DIR("?")="Enter Yes or No to indicate that it was a failure of an device."
 D ^DIR
 I Y=1 S ANS=1
 I ANS'=1,$P($G(^OOPS(2260,IEN,"2162D")),U,7)'="" S $P(^("2162D"),U,7)=""
 Q ANS
DISP ; disp text for prompt
 W !,"Was the exposed part:"
 W !,"      Skin,"
 W !,"      Eyes(Conjunctiva),"
 W !,"      Nose(mucosa),"
 W !,"      Mouth(mucosa)"
 W !,"      Other"
 W !
 Q
CARE(IEN,GEN) ; Select Patient Care Area
 N AREA,TYPE,VIEW
 S VIEW=0
 S AREA=$$GET1^DIQ(2260,IEN,26,"I")
 I AREA="" S AREA="U"
 I AREA="U" S VIEW=1
 E  D
 .S TYPE=$$GET1^DIQ(2261.4,GEN,2,"I")
 .I AREA=TYPE S VIEW=1
 .Q
 Q VIEW
 ;
 N AREA,OTHER
 N SELECT,DIR,Y,DEFAULT,INC
 S INC=$$GET1^DIQ(2260,IEN,52,"I")
 S SELECT=""
 ;W !
 ;W !,"  Select the Area Type:",!
 ;W !,"                  1) Patient"
 ;W !,"                  2) Non-patient"
 ;W !,"                  3) Unknown",!
 S DIR(0)="SAO^1:Patient;2:Non-patient;3:Unknown"
 S DIR("A")="GENERAL SETTING OF "_$S(INC=1:"INJURY",INC=2:"ILLNESS",1:"")_": "
 S DIR("?")="Select the area type to be used."
 S SELECT=$$GET1^DIQ(2260,IEN,27,"I")
 S SELECT=$S(SELECT'="":$$GET1^DIQ(2261.4,SELECT,2,"I"),1:"")
 S:SELECT'="" SELECT=$S(SELECT="P":"Patient",SELECT="N":"Non-patient",1:"")
 S:SELECT'="" DIR("B")=SELECT
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S Y(0)="",AREA=-1
 S (OTHER,AREA)=$S(Y(0)="Patient":"P",Y(0)="Non-patient":"N",Y(0)="Unknown":"",1:"-1")
 I AREA'=-1 D
 .I AREA'="",$E(AREA,1)=$E(SELECT,1) S DEFAULT=$$GET1^DIQ(2261.4,$$GET1^DIQ(2260,IEN,27,"I"),.01,"E")
 .D
 ..N DIC,X
 ..S DIC="^OOPS(2261.4,"
 ..I AREA'="" S DIC("S")="I $$GET1^DIQ(2261.4,Y,2,""I"")=AREA"
 ..I $D(DEFAULT) S DIC("B")=DEFAULT
 ..S DIC("A")=$S(AREA="P":"PATIENT ",AREA="N":"NON-PATIENT ",1:" ")_"CARE AREA: ",DIC(0)="AQEMNZ"
 ..D ^DIC
 ..I $D(DTOUT)!($D(DUOUT)) S AREA=-1 Q
 ..I Y<1 S AREA=-1 Q
 ..S AREA=$P(Y,U)
 ..Q
 .Q
 I AREA>0 S AREA=AREA_U_OTHER
 Q AREA
SAFETY(IEN,OPEN) ; Safety Officer Screen
 N VIEW
 S VIEW=0,OPEN=$G(OPEN,0)
 ;I FORM=
 I OPEN,'$P(^OOPS(2260,IEN,0),U,6) S VIEW=1
 I 'OPEN,$P(^OOPS(2260,IEN,0),U,6)'=2,$P($$EDSTA^OOPSUTL1(IEN,"S"),U,3) S VIEW=1
 Q VIEW
SUPSCR(SUP,IEN,OPEN) ; Supervisor screen
 ; Input
 ;   SUP the DUZ of the Supervisor
 ;   IEN the IEN of the ENTRY in file 2260
 ;
 ; Output
 ;   VIEW 1 Sup can see
 ;        0 Sup can't see
 N VIEW
 S VIEW=0,OPEN=$G(OPEN,0)
 I $$OPEN^OOPSUTL1(IEN,OPEN) D  ;Form can be selected
 .N INJ
 .S INJ=$$GET1^DIQ(2260,IEN,52,"I")
 .I ($$GET1^DIQ(2260,IEN,53,"I")'=DUZ)&($$GET1^DIQ(2260,IEN,53.1,"I")'=DUZ) Q  ; Not the Primary or secondary super
 .I $$EDSTA^OOPSUTL1(IEN,"O") Q
 .;     ^^^ 2162 has been signed by the Safety Officer
 .
 .I ($P($$EDSTA^OOPSUTL1(IEN,"S"),U,INJ)),($P($$EDSTA^OOPSUTL1(IEN,"S"),U,3)) Q  ; Form can not be selected because both
 . ;the 2162 and the CA1/2 have been signed
 .S VIEW=1
 .Q
 Q VIEW
AGNINFO ;Patch 7 - default Agency info if available
 S AIEN=$P(^OOPS(2260,IEN,"2162A"),"^",9)
 S AGN=$$GET1^DIQ(4,AIEN,.01,"E")
 S ADD=$$GET1^DIQ(4,AIEN,1.01,"E")
 S CITY=$$GET1^DIQ(4,AIEN,1.03,"E")
 S STATE=$$GET1^DIQ(4,AIEN,.02,"E")
 S ZIP=$$GET1^DIQ(4,AIEN,1.04,"E")
 Q
PHINFO  ;Patch 7 - default physician data, if available
 S STAT=0
 S AIEN=$P(^OOPS(2260,IEN,"2162A"),"^",9)
 ; get physician data for correct STATION
 F  S STAT=$O(^OOPS(2262,1,1,STAT)) Q:STAT'>0  I ($P(^OOPS(2262,1,1,STAT,0),"^")=AIEN) Q  ;found match, quit
 I STAT D
 .S SIEN=STAT_",1,"
 .S PNAME=$$GET1^DIQ(2262.03,SIEN,1)
 .S PADD=$$GET1^DIQ(2262.03,SIEN,2)
 .S PCITY=$$GET1^DIQ(2262.03,SIEN,3)
 .S PSTATE=$$GET1^DIQ(2262.03,SIEN,4)
 .S PZIP=$$GET1^DIQ(2262.03,SIEN,5)
 .S PTITLE=$$GET1^DIQ(2262.03,SIEN,"6:1")
 Q
RWS ;Regular Work Schedule
 N Y S DIR(0)="LA^1:7"
 S DIR("?",1)="     Enter the employee's work schedule at the time of the incident."
 S DIR("?",2)="     The numbers 1-7 correspond to the days of the week."
 S DIR("?",3)="       1 = Sunday"
 S DIR("?",4)="       2 = Monday"
 S DIR("?",5)="       3 = Tuesday"
 S DIR("?",6)="       4 = Wednesday"
 S DIR("?",7)="       5 = Thursday"
 S DIR("?",8)="       6 = Friday"
 S DIR("?",9)="       7 = Saturday"
 S DIR("?",10)="     Enter the day numbers as a range or list separated by commas."
 S DIR("?",11)=""
 S DIR("?",12)="     Examples: For Mon-Fri     enter 2-6 (or 2,3,4,5,6)"
 S DIR("?",13)="               For Wed-Sat     enter 4-7 (or 4,5,6,7)"
 S DIR("?")="               For Mon,Wed,Fri enter 2,4,6"
 D ^DIR
 I $P(X,"-",2)>7 W !,"     Range exceeds 1-7 limit." G RWS
 Q:$D(DIRUT)
 S:ITEM=21 $P(^OOPS(2260,D0,"CA1F"),U,11)=Y
 S:ITEM=22 $P(^OOPS(2260,D0,"CA2I"),U,8)=Y
 Q
EXCEPT ; Exception statement
 W !," ",ITEM,". A supervisor who knowingly certifies to any false statement,"
 W !,"     misrepresentation, concealment of fact, etc., in respect of"
 W !,"     this claim may also be subject to appropriate felony criminal"
 W !,"     prosecution."
 W !
 W !,"     I certify that the information given above and that furnished"
 W !,"     by the employee is true to the best of my knowledge with the"
 W !,"     following exception."
 W !
 Q
MKNUM(INSTR) ; Strip/Convert num numerics from a string - Patch 11
 ;   Input  - INSTR  - Character String that should be a number
 ;  Output  - NUMOUT - String stripped of all non-numeric characters.
 N K,NUMOUT
 S NUMOUT=""
 F K=1:1:$L(INSTR) I ($A(INSTR,K)>47)&($A(INSTR,K)<58) S NUMOUT=NUMOUT_$E(INSTR,K)
 Q NUMOUT
RWSOT ;Regular Work Schedule output transform
 N I,HOLD
 S HOLD=""
 F I=1:1:($L(Y)/2) S HOLD=HOLD_$P("Sun,Mon,Tue,Wed,Thu,Fri,Sat",",",$P(Y,",",I))_","
 S Y=$E(HOLD,1,($L(HOLD)-1))
 Q 
UNION(IEN) ;
 ; Input: IEN   = Internal Entry Number of entry in file 2260
 ; Output VALID = 1 Valid to be seen by Union
 ;              = 0 Not Valid to be seen by Union
 N VALID
 S VALID=0
 I $$EDSTA^OOPSUTL1(IEN,"O"),$P($$EDSTA^OOPSUTL1(IEN,"S"),U,3) S VALID=1
 Q VALID
