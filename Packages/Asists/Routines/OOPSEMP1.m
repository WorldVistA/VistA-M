OOPSEMP1 ;HINES/WAA,GTD-E/E Employee data Routines ;3/25/98
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
 ; Employee/Person Address is now only stored in the 2162A node
 ; of file 2260.  Prior to patch 3 it was stored in the CA1A and
 ; CA2A nodes depending on which form was entered.  The address
 ; is only 'pulled' from this location when printing either form.
 ;
EN1(CALLER) ;  Main Entry Point
 ;INPUT:
 ;     CALLER = "E" FOR EMPLOYEE
 ;            = "S" FOR SUPERVISOR
 ;            = "O" FOR SAFETY OFFICER
 ;            = "W" FOR WORKERS COMP
 ;
 N SSN,IEN,FLD,ODESC,CAT,PAYP,OUT
 S IEN=0,MAX1=528
 Q:DUZ<1
 Q:$G(^VA(200,DUZ,1))=""
 I CALLER="E" D  Q:$G(SSN)=""  Q:$D(^OOPS(2260,"SSN",SSN))<1
 .S SSN=$P(^VA(200,DUZ,1),U,9)
 .I '$G(SSN) W !!,"No SSN on file for this Employee" Q
 .I $D(^OOPS(2260,"SSN",SSN))<1 D
 ..W !!,"An Accident Report has not been created for this Employee"
 D  Q:IEN<1
 .N DIC,X,INT
 .S DIC="^OOPS(2260,"
 .I CALLER="E" S DIC("S")="I $$EMP^OOPSUTL1(Y,SSN)"
 .I CALLER="S" S DIC("S")="I $$SUP^OOPSEMP1(DUZ,Y)"
 .I CALLER="O" S DIC("S")="I $$SAFE^OOPSEMP1(Y)"
 .; PATCH 10
 .I CALLER="W" S DIC("S")="I $$SCR^OOPSWCSE(Y)"
 . ; Patch 5 - new Personnel status logic, make sure it's an employee
 .S DIC("S")=DIC("S")_",$$ISEMP^OOPSUTL4(Y)"
 .S DIC(0)="AEMNZ",DIC("A")="   Select Case: "
 .D ^DIC
 .Q:Y<1
 .Q:$D(DTOUT)!($D(DUOUT))
 .S IEN=$P(Y,U)
 .Q
FORM S FORM=$$GET1^DIQ(2260,IEN,52,"I")
 S FORM=$S(FORM=1:"CA1",FORM=2:"CA2",1:"")
 Q:FORM=""
 ; Patch 8 - changed call from local subroutine, only Signature that
 ; can be cleared is Employee.
 I CALLER="E" D CLRES^OOPSUTL1(IEN,CALLER,FORM)
 ; Patch 8 - Get Occupation Desc from paid, only call if employee
 S FLD=16,ODESC=""
 I $$GET1^DIQ(2260,IEN,2,"I")=1 S ODESC=$$PAID^OOPSUTL1(IEN,FLD)
 ; Get Pay Plan from PAID, if Per Status (CAT) = 2 Set PAYP = "VO"
 S PAYP="",CAT=""
 S CAT=$$GET1^DIQ(2260,IEN,2,"I")
 I CAT<3 D
 . I CAT=1 S PAYP=$$PAID^OOPSUTL1(IEN,20) I $G(PAYP)'="" S PAYP=$$PAYP^OOPSUTL1(PAYP)
 . I CAT=2 S PAYP="VO"
 ; patch 10 - Bill of Rights enhancement
 I CALLER="E" S OUT="" D  I OUT G EXIT      ; if OUT, ^'d out of option
 . I $$GET1^DIQ(2260,IEN,71,"I")'="Y" D BOR
 . I $$GET1^DIQ(2260,IEN,71,"I")'="Y" D WCPBOR^OOPSMBUL(IEN)
 . Q:OUT
 N DR,DIE,SIGN2,OOPS
 ; Patch 8 - had to split routine due to size
 I FORM="CA1" D ^OOPSEMPB
 I FORM="CA2" D ^OOPSEMP2
 S DIE="^OOPS(2260,",DA=IEN
 D ^DIE
 I $D(Y)'=0 G EXIT
 I CALLER="E" D
 . N SIGN
 . ; patch 10 - bill of rights enhancement
 . I $$GET1^DIQ(2260,IEN,71,"I")'="Y" D  Q
 .. W !?5,"Claim cannot be signed until the Bill of Rights Statement is understood."
 . D SIGN(FORM)
 . Q:$G(SIGN)=""
 . I $P(SIGN,U) D EMP^OOPSVAL1          ; new call patch 8
 I CALLER="W" D
 . W !!,"Checking for Safety and Emp Health Ok to sign for Employee."
 . D WCPS4E^OOPSWCSE
EXIT ; quit the routine
 K HSA,CIT,MAX,MAX1,STA,ZIP
 Q
SAFE(IEN) ; Safety Officer Screen
 N VIEW,FORM,TYPE
 S VIEW=1
 S (TYPE,FORM)=$$GET1^DIQ(2260,IEN,52,"I"),FORM=$S(FORM=1:"CA1",FORM=2:"CA2",1:"")
 ; Patch 8 - if ok to send to DOL cant edit
 I $$GET1^DIQ(2260,IEN,67)'="" S VIEW=0
 I $P($$EDSTA^OOPSUTL1(IEN,"E"),U,TYPE) S VIEW=0   ;Emp Signed
 I $P($$EDSTA^OOPSUTL1(IEN,"S"),U,TYPE) S VIEW=0           ;Super Signed
 I $$GET1^DIQ(2260,IEN,51,"I")'=0 S VIEW=0                 ;Case not open
 Q VIEW
SUP(DUZ,IEN) ; Supervisor Screen
 N VIEW,FORM,SIGN,FORMS
 S VIEW=1
 S (FORMS,FORM)=$$GET1^DIQ(2260,IEN,52,"I"),FORM=$S(FORM=1:"CA1",FORM=2:"CA2",1:"")
 I $P($$EDSTA^OOPSUTL1(IEN,"E"),U,FORMS) S VIEW=0 ; Employee Signed
 I $P($$EDSTA^OOPSUTL1(IEN,"S"),U,FORMS) S VIEW=0 ; Super Signed
 I $$GET1^DIQ(2260,IEN,51,"I")'=0 S VIEW=0 ; Case is not open
 ; Patch 8 - if ok to send to DOL cant edit
 I $$GET1^DIQ(2260,IEN,67)'="" S VIEW=0
 I $$GET1^DIQ(2260,IEN,53,"I")'=DUZ,$$GET1^DIQ(2260,IEN,53.1,"I")'=DUZ S VIEW=0 ; Not Supervisor for case
 Q VIEW
SIGN(FORM) ; Sign/validate Document
 N EMP,INC,VALID
 S VALID=0,SIGN=""
 S INC=$$GET1^DIQ(2260,IEN,52,"I")
 W ! D VALIDATE^OOPSUTL4(IEN,FORM,"E",.VALID)
 I 'VALID Q
 I CALLER="E" D
 . I $$GET1^DIQ(200,DUZ,20.4)="" D
 .. W !!,"Please enter a Signature Code.",!
 .. D ^XUSESIG
 . S SIGN=$$SIG^OOPSESIG(DUZ,IEN)
 Q
BOR ; patch 10 - does employee understand Bill of Rights
 N DIE,DA,DR
 S DA=IEN,DIE="^OOPS(2260,",DR=""
 W !
 S DR(1,2260,1)="71I have read and understood the Employee Bill of Rights:"
 D ^DIE I $D(Y) S OUT=1
 Q
