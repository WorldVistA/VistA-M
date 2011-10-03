OOPSSUP1 ;HINES/WAA-S/E Supervisor Edit routine ;04/17/1998
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
EN1(CALLER) ;  Main Entry Point
 S CALLER=$G(CALLER,"S") ; check CALLER
 N SSN,IEN,EDIT,OUT,FORM,SUP,SER
 S EDIT=""
 S (OUT,IEN)=0
 Q:DUZ<1
 Q:$G(^VA(200,DUZ,1))=""
 D INCIDENT(CALLER) Q:IEN<1  ; Select a Employee
 D ^OOPSDIS ; Display header information
 D SELECT  ; Select the form to be processed.
 Q:EDIT=""
 D FORMS ; Process the forms that ther user selected
 L -^OOPS(2260,IEN)
 Q
SELECT ; Select a form
 ; Injury (2162,CA1)
 ; Illness (2162,CA2)
 ; VA form 2162
 ; Get the type of incident
 ; If the supporting global doesn't exist force the 
 ; Supervisor to fill both the 2162 and supporting form.
 N SIGN,INC,SAFE,CAT,INCTYP
 S EDIT=""
 S SIGN=$$EDSTA^OOPSUTL1(IEN,"S")
 S INC=$$GET1^DIQ(2260,IEN,52,"I")
 S SAFE=+$$EDSTA^OOPSUTL1(IEN,"O")
 ; Allow Non-PAID employee - CAT=6
 S CAT=$$GET1^DIQ(2260,IEN,2,"I")
 ; Patch 5 - change logic for other Personnel Types
 I '$$ISEMP^OOPSUTL4(IEN),'SAFE S EDIT="2162" Q  ;Person not EMP/NONPAID
 I SAFE S EDIT=$P("CA1^CA2",U,INC) Q
 ;  ^...The safety officer has sign and ca1 or ca2 can be edited
 S INCTYP=$P("CA1^CA2",U,INC)
 I $P($$EDSTA^OOPSUTL1(IEN,"E"),U,INC),$P($$EDSTA^OOPSUTL1(IEN,"S"),U,INC) S EDIT="2162" Q
 I '$$CHECK^OOPSUTL3(IEN,INCTYP) S EDIT="2162^"_INCTYP Q
 ;     No data has been entered for the ca1/2
 ; ^^^ Force the Super to edit both and once.
 S EDIT=""
 I '$P(SIGN,U,3)
 N DIR,Y
 N PROMPT1,PROMPT2,SEL1,SEL2
 S PROMPT1="1) VA FORM 2162 "
 S PROMPT2="              2) "_$S(INC=1:"Injury (CA1",INC=2:"Illness (CA2",1:"")_")"
 W !," Select form: ",PROMPT1
 W !,PROMPT2
 S DIR(0)="SAO^1:2162;2:"_$S(INC=1:"CA1",INC=2:"CA2",1:"")
 S DIR("A")=" Select form: "
 S DIR("?")=" Select the form to be edited."
 D ^DIR
 I '$D(Y(0)) S EDIT="" Q
 S EDIT=Y(0)
 K MAX,MAX1
 Q
INCIDENT(CALLER) ; Select a case
 N DIC,X
 S DIC="^OOPS(2260,"
 I CALLER="S" S DIC("S")="I $$SUP^OOPSSUP1(Y)"
 I CALLER="O" S DIC("S")="I $$SAFETY^OOPSSUP1(Y)"
 S DIC(0)="AEMNZ",DIC("A")="   Select Case: "
 D ^DIC
 Q:Y<1
 Q:$D(DTOUT)!($D(DUOUT))
 S IEN=$P(Y,U)
 Q
SUP(IEN) ; Supervisor Screen
 N VIEW,ISEMP
 S VIEW=1
 I $$GET1^DIQ(2260,IEN,51,"I") S VIEW=0 ; Case is not open
 I $$GET1^DIQ(2260,IEN,53,"I")'=DUZ,$$GET1^DIQ(2260,IEN,53.1,"I")'=DUZ S VIEW=0 ; Not the Super or Alternate Super
 ; Patch 5 - new $$ for determining if employee
 S ISEMP=$$ISEMP^OOPSUTL4(IEN)
 I 'ISEMP D  ; person is not an employee
 .I +$$EDSTA^OOPSUTL1(IEN,"O") S VIEW=0 Q  ; Safety has signed
 .Q
 I ISEMP D  ; filters emps who have sign, sup who sign & safety who sign
 .S INC=$$GET1^DIQ(2260,IEN,52,"I")
 .I $P($$EDSTA^OOPSUTL1(IEN,"E"),U,INC),$P($$EDSTA^OOPSUTL1(IEN,"S"),U,INC),+$$EDSTA^OOPSUTL1(IEN,"O") S VIEW=0
 .Q
 Q VIEW
SAFETY(IEN) ; Safety officer screen
 N VIEW,INC,ISEMP
 S VIEW=1
 S INC=$$GET1^DIQ(2260,IEN,52,"I")
 I $$GET1^DIQ(2260,IEN,51,"I") S VIEW=0 ; Case is not open
 S ISEMP=$$ISEMP^OOPSUTL4(IEN)
 I 'ISEMP D       ; person is not an employee
 .I +$$EDSTA^OOPSUTL1(IEN,"O") S VIEW=0 Q  ; Safety has signed
 .Q
 I ISEMP  D  ; This will filter emps who have sign, sup who sign and safety who sign
 .I $P($$EDSTA^OOPSUTL1(IEN,"E"),U,INC),$P($$EDSTA^OOPSUTL1(IEN,"S"),U,INC),+$$EDSTA^OOPSUTL1(IEN,"O") S VIEW=0
 .Q
 I $$GET1^DIQ(2260,IEN,53,"I")'=DUZ,$$GET1^DIQ(2260,IEN,53.1,"I")'=DUZ D
 .I $P($$EDSTA^OOPSUTL1(IEN,"E"),U,INC),$P($$EDSTA^OOPSUTL1(IEN,"S"),U,INC),$P($$EDSTA^OOPSUTL1(IEN,"S"),U,3) S VIEW=0
 .Q
 Q VIEW
FORMS ; Process Form
 N I
 ;Patch 7 - new variables used
 N AIEN,AGN,ADD,CITY,STATE,ZIP,PNAME,PADD,PCITY,PSTATE,PZIP,STAT,SIEN
 N FLD,PAY,RET,SAL
 ; Get default fields from PAID
 S FLD=28,SAL=""
 S SAL=$$PAID^OOPSUTL1(IEN,FLD)
 S FLD=26,RET=""
 S RET=$$PAID^OOPSUTL1(IEN,FLD)
 S RET=$S(RET="FULL CSRS":"CSRS",RET="FERS":"FERS",1:"OTHER")
 S FLD=19,PAY=""
 S PAY=$$PAID^OOPSUTL1(IEN,FLD)
 S PAY=$S(PAY="PER ANNUM":"ANNUAL",PAY="PER HOUR":"HOURLY","PER DIEM":"DAILY","BIWEEKLY":"BI-WEEKLY",1:"")
 F I=1:1 S FORM=$P(EDIT,U,I) Q:FORM=""  D  Q:OUT
 .N DR,DIE,SIGN,EDIT,I
 .I (CALLER="S"),($$GET1^DIQ(2260,IEN,53,"I")=DUZ!($$GET1^DIQ(2260,IEN,53.1,"I")=DUZ)) D CLRES^OOPSUTL1(IEN,"S",FORM)
 .I FORM="2162" D ASIST^OOPSSUP3 Q:OUT
 .I FORM="CA1" D CA1^OOPSSUPB Q:OUT
 .I FORM="CA2" D CA2^OOPSSUP2 Q:OUT
 .S DIE="^OOPS(2260,",DA=IEN
 .L +^OOPS(2260,IEN):2
 .E  W !!?5,"Another user is editing this entry. Try later." S OUT=1 Q
 .D ^DIE
 .I ($D(Y)'=0)!($G(DIRUT)=1)  S OUT=1 Q  ; Quit if user exits
 .I $$GET1^DIQ(2260,IEN,53,"I")'=DUZ,$$GET1^DIQ(2260,IEN,53.1,"I")'=DUZ Q
 .D SIGNS(FORM) ; Sign/validate Document
 .Q:'$P(SIGN,U)   ; Quit if user doesn't sign
 .D FILE ; User Signs and files
 .Q
 Q
SIGNS(FORM) ; Sign/validate Document
 N EMP,INC,VALID
 S VALID=0,SIGN=""
 S EMP=$$EDSTA^OOPSUTL1(IEN,"E")
 S INC=$$GET1^DIQ(2260,IEN,52,"I")
 D VALIDATE^OOPSUTL4(IEN,FORM,"S",.VALID)
 I FORM'="2162",'$P(EMP,U,INC) D  Q  ;Employee has not signed yet
 .W !,?10,"The employee has not signed the ",FORM,"." Q
 .Q
 I FORM=2162,CALLER="O",('$P($$EDSTA^OOPSUTL1(IEN,"S"),U,3)) D  Q
 .W !?10,"Supervisor must sign before Safety Officer"
 I 'VALID Q
 S SIGN=$$SIG^OOPSESIG(DUZ,IEN)
 Q
FILE ;File the ES and send a bull
 I FORM="2162" D
 . I CALLER="S" S $P(^OOPS(2260,IEN,"2162ES"),U,1,3)=SIGN D SAFETY^OOPSMBUL(IEN)
 . I CALLER="O" S $P(^OOPS(2260,IEN,"2162ES"),U,4,6)=SIGN
 I FORM="CA1" S $P(^OOPS(2260,IEN,"CA1ES"),U,4,6)=SIGN D SUPS^OOPSMBUL(IEN),UNION^OOPSMBUL(IEN)
 I FORM="CA2" S $P(^OOPS(2260,IEN,"CA2ES"),U,4,6)=SIGN D SUPS^OOPSMBUL(IEN),UNION^OOPSMBUL(IEN)
 Q
