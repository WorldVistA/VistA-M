OOPSPRT2 ;HINES/WAA-Print CA1/CA2 Routines ;3/24/98
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
 ; This routine is to display all the report that a person has
 ; access to.
EN1(CALLER) ;
 ; Input:
 ;    Caller O = Safety Officer
 ;           S = Supervisor
 ;           E = Employee
 ; 
 N OUT,CASE,FORM
 S OUT=0
 S IEN=$$SELECT(CALLER) Q:IEN="0"
 I IEN="-1" S CASE="",FORM=$$FORM Q:FORM="-1"
 E  S CASE=$P(IEN,U,2),FORM="CA"_$$GET1^DIQ(2260,+IEN,52,"I")
 D PRINT
 D EXIT
 Q
EXIT ;
 K IO("Q")
 Q
FORM() ;Select a form to print
 N FORM
 ; Injury CA1
 ; Illness CA2
 N DIR,Y
 W !,"                  1) Injury (CA1)"
 W !,"                  2) Illness (CA2)"
 W !
 S DIR(0)="SAO^1:CA1;2:CA2"
 S DIR("A")="Select Form: "
 S DIR("?")="Select the form to be printed."
 D ^DIR
 I '$D(Y(0)) S FORM="-1"
 E  S FORM=Y(0)
 Q FORM
SELECT(CALLER) ; Select a case to print
 ;INPUT:
 ;     CALLER = "E" FOR EMPLOYEE
 ;            = "S" FOR SUPERVISOR
 ;            = "O" FOR SAFETY OFFICER
 N SSN,IEN,CASE
 S IEN=0,CASE=""
 I $G(DUZ)<1 Q "0"  ; Bad or no DUZ   
 I $G(^VA(200,DUZ,1))="" Q "0"  ; Person is not a valid user in 200
 I CALLER="E" D  I CASE="0" Q "0"  ; Setup SSN
 .S SSN=$P(^VA(200,DUZ,1),U,9)
 .I $D(^OOPS(2260,"SSN",SSN))<1 S CASE="0" ; Ensure entry is in 2260
 .Q
 D
 .N DIC,X,Y
 .S DIC="^OOPS(2260,"
 .I CALLER="E" S DIC("S")="I $$EMP^OOPSPRT2(Y)"
 .I CALLER="S" S DIC("S")="I $$SUP^OOPSPRT2(Y)"
 .I CALLER="O" S DIC("S")="I $$SAF^OOPSPRT2(Y)"
 .S DIC(0)="AEMNZ",DIC("A")="   Select Case: "
 .D ^DIC
 .I $D(DTOUT)!($D(DUOUT)) S Y=0
 .S CASE=Y
 .Q
 Q CASE
EMP(IEN) ; Employee
 N VIEW
 S VIEW=1
 I $$GET1^DIQ(2260,Y,51,"I")=2 S VIEW=0
 I '$$EMP^OOPSUTL1(IEN,SSN,1) S VIEW=0
 Q VIEW
SUP(IEN) ; Supervisor
 N VIEW
 S VIEW=1
 I $$GET1^DIQ(2260,Y,51,"I")=2 S VIEW=0
 I $$GET1^DIQ(2260,IEN,53,"I")'=DUZ,$$GET1^DIQ(2260,IEN,53.1,"I")'=DUZ S VIEW=0
 Q VIEW
SAF(IEN) ; Safety Officer
 N VIEW
 S VIEW=1
 I $$GET1^DIQ(2260,Y,51,"I")=2 S VIEW=0
 Q VIEW
DEVICE ; This is the device selection routine.
 ;
 S %ZIS="QM" D ^%ZIS I POP S OUT=1 Q
 I $D(IO("Q")) D  Q
 .S ZTRTN="PRINT^OOPSPRT2",ZTDESC="Print a "_FORM
 .S ZTSAVE("OUT")=""
 .S ZTSAVE("CASE")=""
 .S ZTSAVE("FORM")=""
 .D ^%ZTLOAD D HOME^%ZIS Q
 .Q
 Q
PRINT ; This is the main print portion of the routine
 I FORM="CA1" S FORM="CA-1"
 I FORM="CA2" S FORM="CA-2"
 D EN1^OOPSPCA(CASE,FORM)
 Q
END ; exit the report
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
