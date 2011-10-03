OOPSVAL1 ;HINES/WAA,GTD-Validate and Sign data Routines ;3/25/98
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
 ;  Note:  At EMP+18 added check to see if code being executed from
 ;         the broker.  ASISTS V2.0
 ;
EN1(CALLER) ;  Main Entry Point
 ;INPUT:
 ;     CALLER = "E" FOR EMPLOYEE
 ;            = "S" FOR SUPERVISOR
 ;            = "O" FOR SAFETY OFFICER
 ;            = "W" FOR WORKER'S COMP
 ;
 N SSN,IEN,SIGN,EDIT,FORM,GRP,SUP,I,CIT,HSA,STA,ZIP
 S IEN=0
 Q:DUZ<1
 Q:$G(^VA(200,DUZ,1))=""
 I CALLER="E" S SSN=$P(^VA(200,DUZ,1),U,9) Q:$D(^OOPS(2260,"SSN",SSN))<1
 D  Q:IEN<1
 .N DIC,X
 .S DIC="^OOPS(2260,"
 .I CALLER="E" S DIC("S")="I $$EMPSCR^OOPSVAL1(Y)"
 .I CALLER="S" S DIC("S")="I $$SUPSCR^OOPSVAL1(Y)"
 .I CALLER="O" S DIC("S")="I $$SAFSCR^OOPSVAL1(Y)"
 .I CALLER="W" S DIC("S")="I $$WCSCR^OOPSVAL1(Y)"
 .S DIC("S")=DIC("S")_",'$$GET1^DIQ(2260,Y,51,""I"")"
 .S DIC(0)="AEMNZ",DIC("A")="   Select Case: "
 .D ^DIC
 .Q:Y<1
 .Q:$D(DTOUT)!($D(DUOUT))
 .S IEN=$P(Y,U)
 .Q
 I CALLER="O" D
 .S FORM="2162"
 .D FORM
 .Q
 I CALLER="E" D
 .S FORM=$$GET1^DIQ(2260,IEN,52,"I")
 .S FORM=$S(FORM=1:"CA1",FORM=2:"CA2",1:"")
 .I FORM'="" D FORM
 .Q
 I CALLER="S" D
 .N CNT,PAUSE,OUT,FORM,EDIT
 .S (PAUSE,OUT)=0
 .; Do block below needed so that for loop below only runs for "S"
 .D
 ..N INC,STAT,ESTAT
 ..S INC=$$GET1^DIQ(2260,IEN,52,"I")
 ..S STAT=$$EDSTA^OOPSUTL1(IEN,"S")
 ..; added check for employee having signed CA1
 ..S ESTAT=$$EDSTA^OOPSUTL1(IEN,"E")
 ..; if employee signed ok to let super select if no forms signed
 ..I $P(ESTAT,U,INC) D
 ...I '$P(STAT,U,INC),'$P(STAT,U,3) D SELECT^OOPSSUP1 Q
 ...S EDIT=$S('$P(STAT,U,3):2162,'$P(STAT,U,INC):$P("CA1^CA2",U,INC),1:"")
 ..I '$P(ESTAT,U,INC) D  ;  Employee has not signed CA1/CA2
 ...I '$P(STAT,U,3) S EDIT=2162 Q
 ...S EDIT=""
 .I EDIT="" Q
 .F CNT=1:1 S FORM=$P(EDIT,U,CNT) Q:FORM=""  D:PAUSE END Q:OUT  D
 ..D FORM S PAUSE=1
 ..Q
 .Q
 I CALLER="W" D
 .S FORM=$$GET1^DIQ(2260,IEN,52,"I")
 .S FORM=$S(FORM=1:"CA1",FORM=2:"CA2",1:"")
 . N DIR,Y
 . S WOK=1
 . W !
 . S DIR("A")="OK to transmit to DOL"
 . S DIR(0)="SBM^Y:Yes;N:No"
 . D ^DIR
 . I Y="Y",FORM'="" D FORM
 .Q
EXIT ;
 K SUP,WOK                      ; left over from ^OOPSDIS
 Q
EMPSCR(IEN) ;
 N VIEW
 S VIEW=1
 I '$$EMP^OOPSUTL1(IEN,SSN) S VIEW=0
 E  D
 .N INC
 .S INC=$$GET1^DIQ(2260,IEN,52,"I")
 .I $P($$EDSTA^OOPSUTL1(IEN,"E"),U,INC) S VIEW=0
 .Q
 Q VIEW
SUPSCR(IEN) ;
 N VIEW
 S VIEW=1
 I '$$SUPSCR^OOPSUTL2(DUZ,IEN) S VIEW=0
 E  D
 .N INC,STAT,ESTAT,CAT
 .S CAT=$$GET1^DIQ(2260,IEN,2,"I")              ; Personnel status
 .S INC=$$GET1^DIQ(2260,IEN,52,"I")             ; Injury/Illness
 .S STAT=$$EDSTA^OOPSUTL1(IEN,"S")              ; sup signed forms
 .S ESTAT=$$EDSTA^OOPSUTL1(IEN,"E")             ; emp signed forms
 .; Added Non-PAID employee to check, not emp, 2162 signed
 .; Patch 5 - logic changed for new Personnel Categories
 .I '$$ISEMP^OOPSUTL4(IEN),$P(STAT,U,3) S VIEW=0 Q
 .; super signed 2162 and CA1/CA2
 .I $P(STAT,U,INC),$P(STAT,U,3) S VIEW=0 Q
 .; emp not signed CA1/CA2, super signed 2162, not signed CA1/CA2 - no
 .I '$P(ESTAT,U,INC),$P(STAT,U,3),'$P(STAT,U,INC) S VIEW=0 Q
 .Q
 Q VIEW
WCSCR(IEN) ; Patch 8 - Worker's Comp Screen
 N INC,VIEW,ESTAT,STAT
 S VIEW=1
 S INC=$$GET1^DIQ(2260,IEN,52,"I")
 S ESTAT=$$EDSTA^OOPSUTL1(IEN,"E")             ;really defensive code
 I '$P(ESTAT,U,INC) S VIEW=0                   ;should never be needed
 S STAT=$$EDSTA^OOPSUTL1(IEN,"S")              ;super must have signed
 I '$P(STAT,U,INC) S VIEW=0
 I $$GET1^DIQ(2260,IEN,66)'="" S VIEW=0        ;Case sent to DOL
 I $$GET1^DIQ(2260,IEN,67)'="" S VIEW=0        ;WC already signed
 I $$GET1^DIQ(2260,IEN,51,"I")'=0 S VIEW=0     ;Case is not open
 I '$$ISEMP^OOPSUTL4(IEN) S VIEW=0             ;not employee
 Q VIEW
SAFSCR(IEN) ;
 N VIEW
 S VIEW=1
 I '$$SAFETY^OOPSUTL2(IEN) S VIEW=0
 I $$EDSTA^OOPSUTL1(IEN,"O") S VIEW=0
 Q VIEW
END ;End of Form pause
 N DIR
 W !
 S DIR(0)="E" D ^DIR
 S:$D(DIRUT) OUT=1 Q
 Q
FORM ;Select Form
 D:'$G(PAUSE,0) ^OOPSDIS
 N OUT
 I CALLER="E" D  Q:$G(OUT)
 . I $$GET1^DIQ(2260,IEN,71,"I")'="Y" D BOR^OOPSEMP1
 . I $$GET1^DIQ(2260,IEN,71,"I")'="Y" D  Q
 .. W !?5,"Claim cannot be signed until the Bill of Rights Statement is understood."
 .. D WCPBOR^OOPSMBUL(IEN)
 .. S OUT=1
 I '$G(OUT) D SIGN(FORM) Q:(+SIGN=0)
 I CALLER="E",($$GET1^DIQ(2260,IEN,71,"I")="Y") D EMP
 I CALLER="S" D SUP
 I CALLER="O" D SAF
 I CALLER="W" D WCP
 Q
SIGN(FORM) ; Sign/validate Document
 N EMP,INC,VALID,OUT
 S VALID=0,SIGN=""
 S INC=$$GET1^DIQ(2260,IEN,52,"I")
 D VALIDATE^OOPSUTL4(IEN,FORM,CALLER,.VALID)
 I 'VALID D END Q
 S SIGN=$$SIG^OOPSESIG(DUZ,IEN)
 Q
EMP ; Employee Sign off
 N RECORD,UNIREP,X,X1,X2
 S UNIREP=""
 S RECORD=$G(^OOPS(2260,IEN,"CA"))
 S X=$P($G(^VA(200,DUZ,20)),U,2)
 S X1=DUZ
 I FORM="CA1" D
 . I '$$BROKER^XWBLIB S $P(^OOPS(2260,IEN,"CA1ES"),U,1,3)=SIGN
 . S X2=$$CA1SUM^OOPSUTL6()
 I FORM="CA2" D
 . I '$$BROKER^XWBLIB S $P(^OOPS(2260,IEN,"CA2ES"),U,1,3)=SIGN
 . S X2=$$CA2SUM^OOPSUTL6()
 D EN^XUSHSHP
 S $P(RECORD,U,9)=1
 S $P(RECORD,U,7)=X
 S ^OOPS(2260,IEN,"CA")=RECORD
 D EMP^OOPSMBUL(IEN)
 ; patch 10 - bill of rights enhancement
 I (CALLER="E")&('$$BROKER^XWBLIB) D
 . D CONSENT
 . I $$GET1^DIQ(2260,IEN,72,"I")="Y" D UNION
 . I UNIREP D CONSENT^OOPSMBUL(IEN,UNIREP)
 Q
SUP ;Supervisor Sign off
 I FORM="CA1" S $P(^OOPS(2260,IEN,"CA1ES"),U,4,6)=SIGN
 I FORM="CA2" S $P(^OOPS(2260,IEN,"CA2ES"),U,4,6)=SIGN
 I FORM="2162" S $P(^OOPS(2260,IEN,"2162ES"),U,1,3)=SIGN D SAFETY^OOPSMBUL(IEN)
 ; Patch 8
 I FORM'="2162" D SUPS^OOPSMBUL(IEN),UNION^OOPSMBUL(IEN)
 Q
WCP ; Patch 8
 I FORM="CA1" S $P(^OOPS(2260,IEN,"WCES"),U,1,3)=SIGN
 I FORM="CA2" S $P(^OOPS(2260,IEN,"WCES"),U,1,3)=SIGN
 N DA,DR,DIE
 I $P(SIGN,U) D
 . S DR="",DIE="^OOPS(2260,",DA=IEN
 . S DR(1,2260,1)="67////^S X=$P(SIGN,U)"
 . S DR(1,2260,5)="68////^S X=$P(SIGN,U,2)"
 . S DR(1,2260,10)="69////^S X=$P(SIGN,U,3)"
 . D ^DIE
 D WCP^OOPSMBUL(IEN,"S")
 Q
SAF ; Safety Officer Sign off
 I FORM="2162" S $P(^OOPS(2260,IEN,"2162ES"),U,4,6)=SIGN
 Q
CONSENT ; patch 10 - Employee consent to release information to union
 N DIC,DIE,DA,DR,OOPS
 S DA=IEN,DIC="^OOPS(2260,",OUT=""
 K DIQ S DIQ(0)="IE"
 S DIQ="OOPS",DR=".01;2;3;4;7;13;14;16;17;18;52;53;53.1" D EN^DIQ1
 S DR=""
 W !!,"My consent is given for the release of case number "_OOPS(2260,IEN,.01,"E")
 W !,"information for review by local bargaining units for accident and"
 W !,"illness tracking purposes only.  Name, address, social security "
 W !,"number, date of birth, and telephone number will not be included"
 W !,"in the information provided to the bargaining units."
 W !!,"With your consent, the following information will be provided"
 W !,"to the local bargaining unit for your review."
 W !!,"Dt/Tme Occurrence: ",OOPS(2260,IEN,4,"E")
 W ?40,"   Inj/Ill: ",OOPS(2260,IEN,52,"E")
 W !," Personnel Status: ",OOPS(2260,IEN,2,"E")
 W ?40,"       Sex: ",OOPS(2260,IEN,7,"E")
 W !,"   Station Number: ",OOPS(2260,IEN,13,"I")
 W ?40," Education: ",$E(OOPS(2260,IEN,18,"E"),1,26)
 W !,"  Cost Center/Org: ",OOPS(2260,IEN,14,"E")
 W ?40," Grade/Stp: ",OOPS(2260,IEN,16,"E")_"/"_OOPS(2260,IEN,17,"E")
 W !,"       Supervisor: ",$E(OOPS(2260,IEN,53,"E"),1,19)
 W ?40,"Type Incid: ",$E(OOPS(2260,IEN,3,"E"),1,26)
 W !,"  Secondary Super: ",$E(OOPS(2260,IEN,53.1,"E"),1,20),!
 S DR(1,2260,1)="72Consent Given://^S X=""N"""
 W !!?5,"If you give consent, you will be prompted to select the"
 W !?5,"Union to send the bulletin to.  The bulletin will be sent"
 W !?5,"immediately after the Union has been selected.",!
 S DIE="^OOPS(2260,"
 D ^DIE I $D(Y) S OUT=1
 Q
UNION ; Get the Union Representative's DUZ
 N DIC,DA,Y
 S DIC="^OOPS(2263.7,",DIC(0)="AEQZ"
 S DIC("A")="Select UNION to send bulletin to: "
 D ^DIC
 I +Y S UNIREP=$$GET1^DIQ(2263.7,+Y,2,"I")
 I 'UNIREP D
 . W !!?3,"Cannot sent a bulletin to Union, No Union Representative name was selected"
 . W !?3,"or one is not on file.  Contact your Workers' Compensation Specialist."
 Q
