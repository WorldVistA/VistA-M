OOPSCC ;HINES CIOFO/GWB-CREATE ASISTS CASE ;3/5/98
 ;;2.0;ASISTS;;Jun 03, 2002
 N CAT,DATE,SUP,FYEAR,GRP,I,IEN2260,OOPS,IEN450,EMP,IEN200,PAID,VIEW
 N DLAYGO
 S DIE("NO^")="BACKOUTOK",VIEW=0
 D NOW^%DTC
 S DATE=X,FYEAR="",FYEAR=$$FYEAR^OOPSCSN(X),NUM=$$NEWR^OOPSCSN(FYEAR)
 S (NAME,SEX,SSN,DOB,STN,CCT,OCC,GRD,STP,EDU,ANS,PAID)=""
 W @IOF
 W !!," Case number ",NUM," will be assigned to this incident.",!
 K DD,DO
 S DLAYGO=2260,DIC="^OOPS(2260,",DIC(0)="QLZ",X=NUM D FILE^DICN G:Y=-1 EXIT
 S IEN2260=+Y
PS K DR S DIE="^OOPS(2260,",DA=IEN2260,DR="2 PERSONNEL STATUS........."
 D ^DIE
 G:$D(Y)'=0 DELETE S CAT=X
 I CAT=1 D  G:Y=-1 DELETE               ; Employee in ^PRSPC (PAID)
 .S DIC="^PRSPC(",DIC("A")=" PERSON INVOLVED..........: ",DIC("B")=NAME
 .S DIC("W")="W ?30,$E($P(^(0),U,9),6,9)"
 .S DIC(0)="QEAMZ" D ^DIC Q:Y=-1
 .S IEN450=+Y,NAME=$P(Y,U,2)
 .N Y K DIQ S DIC="^PRSPC(",DR="6;8;10;13;16;31;32;38;458;604",DA=IEN450
 .S DIQ="OOPS",DIQ(0)="IE" D EN^DIQ1
 .S STN=OOPS(450,IEN450,6,"I")
 .S SSN=OOPS(450,IEN450,8,"I")
 .S EDU=OOPS(450,IEN450,10,"E"),EDU=$E(EDU,1)_$$LOW^XLFSTR($E(EDU,2,45))
 .S GRD=OOPS(450,IEN450,13,"I")
 .S OCC=OOPS(450,IEN450,16,"I")
 .S CCT=OOPS(450,IEN450,458,"I")
 .S SEX=OOPS(450,IEN450,31,"I")
 .S DOB=OOPS(450,IEN450,32,"I")
 .S STP=OOPS(450,IEN450,38,"I")
 ;
 ; New Personnel Status = Non-Paid Employee. Get fields from ^VA(200
 ; If Person in PAID file (PAID=1) don't allow adding as non-paid emp
 ; If no SSN in file 200, set PAID=1, prevent hard errors
 I CAT=6 D  G:(Y=-1!(PAID)) DELETE
 .S DIC="^VA(200,",DIC("A")=" PERSON INVOLVED..........: ",DIC("B")=NAME
 .S DIC("W")="W ?30,$E($P(^(1),U,9),6,9)"
 .S DIC(0)="QEAMZ" D ^DIC Q:Y=-1
 .S IEN200=+Y,NAME=$P(Y,U,2)
 .; Make sure the person is not a PAID Employee - Patch 3
 .S PAID=0
 .; If no SSN, Can't continue - Patch 3
 .I '$$GET1^DIQ(200,IEN200,9,"I") D  Q
 ..W !,"No SSN on file in the New Person file. Must enter to create case."
 ..S PAID=1
 .N Y K DIQ S DIC="^VA(200,",DR="4;5;9",DA=IEN200
 .S DIQ="OOPS",DIQ(0)="IE" D EN^DIQ1
 .S SEX=OOPS(200,IEN200,4,"I")
 .S DOB=OOPS(200,IEN200,5,"I")
 .S SSN=OOPS(200,IEN200,9,"I")
 .I $D(^PRSPC("SSN",SSN)) D
 ..W !,"This person (SSN) is a 'PAID' Employee, Please Re-enter"
 ..S PAID=1
 K DR S DIE="^OOPS(2260,",DA=IEN2260,DR=""
 I CAT=1 D                           ; Employee in ^PRSPC (PAID)
 .S DR(1,2260,1)="1///^S X=NAME"
 .S DR(1,2260,2)="5///^S X=SSN"
 .S DR(1,2260,3)="6///^S X=DOB"
 .S DR(1,2260,4)="7///^S X=SEX"
 .S DR(1,2260,5)="14///^S X=CCT"
 .S DR(1,2260,6)="15///^S X=$E(OCC,1,4)"
 .S DR(1,2260,7)="16///^S X=GRD"
 .S DR(1,2260,8)="17///^S X=STP"
 .S DR(1,2260,9)="18///^S X=EDU"
 I CAT=6 D                           ; Employee not in ^PRSPC (Non-PAID)
 .S DR(1,2260,1)="1///^S X=NAME"
 .S DR(1,2260,2)="5///^S X=SSN"
 .S DR(1,2260,3)="6///^S X=DOB"
 .S DR(1,2260,4)="7///^S X=SEX"
 I CAT'=1&(CAT'=6) D                 ; Everyone else
 .S DR(1,2260,1)="1 PERSON INVOLVED.........."
 .S DR(1,2260,2)="5 SSN......................"
 .; Patch 5 - get data for non-employee personnel
 . S DR(1,2260,3)="I X="""" W !,""Social Security Number is Required"" S Y=5"
 .S DR(1,2260,4)="6 DOB......................"
 .S DR(1,2260,5)="I X="""" W !,""Date of Birth is required"" S Y=6"
 .S DR(1,2260,6)="7 SEX......................"
 .S DR(1,2260,7)="I X="""" W !,""Sex is Required"" S Y=7"
 ;
 ; Patch 5 - Check for Duplicate Cases
 S DR(1,2260,10)="I $$DUP^OOPSCC() S Y=""@3"""
 S DR(1,2260,15)="8 HOME STREET ADDRESS......"
 S DR(1,2260,16)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=8"
 S DR(1,2260,20)="9 CITY....................."
 S DR(1,2260,21)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=9"
 S DR(1,2260,25)="10 STATE...................."
 S DR(1,2260,30)="11 ZIP CODE................."
 S DR(1,2260,35)="12 HOME PHONE NUMBER........"
 ; Patch 8 - add error checking on phone for DOL requirements
 S DR(1,2260,40)="I $TR(X,""/-*#"","""")'?10N W !?3,""Phone number must include area code and 7 digits only.  Example 703-123-8789"" S Y=12"
 ; Patch 5 - Collect Station Number for everyone, allow changing PAID
 S DR(1,2260,45)="13 STATION NUMBER...........//^S X=STN"
 S DR(1,2260,50)="52 INJURY/ILLNESS..........."
 S DR(1,2260,51)="S Y=$S(X=1:""@1"",1:""@2"")"
 S DR(1,2260,52)="@1"
 S DR(1,2260,55)="4 DATE/TIME INJURY OCCURRED"
 S DR(1,2260,56)="I $P(X,""."",2)="""" W !,""Time is REQUIRED in this response."" S Y=4"
 S DR(1,2260,57)="S Y=3"
 S DR(1,2260,58)="@2"
 S DR(1,2260,60)="4 DATE 1ST AWARE OF ILLNESS"
 S DR(1,2260,65)="3 TYPE OF INCIDENT........."
 ; patch 5 - changed for new category types
 S SUP=$S((CAT=1!(CAT>6)):" SUPERVISOR...............",CAT=2:" VOLUNTARY SVC SUPERVISOR.",CAT=3:" CONTRACT ADMINISTRATOR...",1:" SAFETY OFFICER...........")
 S DR(1,2260,70)="53"_SUP
 S DR(1,2260,75)="53.1 SECONDARY SUPERVISOR....."
 S DR(1,2260,76)="56////^S X=DUZ"
 ; Since the AAC is requiring an Occupation code for volunteers
 ; it will be hard coded if the CAT=2 (Volunteer) so claim will not
 ; reject at the AAC (WCMIS)
 I CAT=2 S DR(1,2260,80)="15////^S X=9999"
 S DR(1,2260,85)="@3"
 S DR(1,2260,90)="I VIEW W !!?4,""This Case will be DELETED!"""
 D ^DIE G:$D(Y)'=0!(VIEW) DELETE            ; VIEW = Duplicate Patch 5
 S DIR(0)="S^E:Edit;S:Save;D:Delete",DIR("A")=" Case action" D ^DIR K DIR
 I Y="E" S ANS="E" G PS
 I Y="S" D  D CASE^OOPSMBUL(IEN2260) D:((CAT=1)!(CAT=6))&(SSN'="") BOR^OOPSMBUL(IEN2260):$D(^VA(200,"SSN",SSN)) G EXIT
 .K DR S DIE="^OOPS(2260,",DA=IEN2260,DR="51///0" D ^DIE K DIE
 .W !!," Case number ",NUM," has been saved.",!
 I (Y="D")!($D(DIRUT)) G DELETE
 G EXIT
DUP() ; Patch 5 Finds Open Cases w/Matching names, Cases checked for
 ;   being a duplicate must have a Status of OPEN
 ;
 ; Input Variables:
 ;   IEN2260 - IEN of Current Case
 ;   SSN     - SSN of Current Case
 ; Output Variables
 ;   VIEW    - returns 1 if user indicates case is a duplicate
 ;             which triggers system to delete the case and exit
 ;           - returns 0 if user indicates case is not a duplicate
 ;             and system continues normal processing.
 ;
 N ARR,FILE,FLD,IX,SCR,SSN,STR,X,Y
 S FILE=2260,FLD=5
 S SSN=$$GET1^DIQ(2260,IEN2260,5,"I")
 S IX="SSN",ARR="OOPS",VIEW=0
 S SCR="I ($$GET1^DIQ(FILE,Y,51,""I"")<1)&(Y'=IEN2260)"
 S SCR=SCR_"&($$GET1^DIQ(FILE,Y,5,""I"")=SSN)"
 D LIST^DIC(FILE,,FLD,,,,,IX,SCR,,ARR)
 I $G(OOPS("DILIST",0)) D
 .W !!,"The following case(s) are Open with SSN: "_SSN,!
 .N DIC,DA,DR,OPID,Y
 .S DIC="^OOPS(2260,",(DA,DR,OPID)=0
 .F  S OPID=$O(OOPS("DILIST",2,OPID)) Q:OPID=""  D
 ..S DA=OOPS("DILIST",2,OPID),STR=^OOPS(2260,DA,0) D
 ...W !?2,"CASE NUMBER: ",$P(STR,U),?40,"PERSON INVOLVED: ",$E($P(STR,U,2),1,25)
 ...W !?2,"PERSONNEL STATUS:",$$GET1^DIQ(FILE,DA,2,"E"),?40,"PAY PLAN: ",$P(STR,U,13)
 ...W !?2,"TYPE OF INCIDENT: ",$$GET1^DIQ(FILE,DA,3,"E")
 ...W !?2,"DATE/TIME OF OCCURRENCE: ",$$GET1^DIQ(FILE,DA,4,"E")
 ...W !?2,"CASE STATUS: ",$$GET1^DIQ(FILE,DA,51,"E")
 ...W ?40,"INJURY/ILLNESS: ",$$GET1^DIQ(FILE,DA,52,"E")
 ...W !?2,"SUPERVISOR: ",$$GET1^DIQ(FILE,DA,53,"E")
 ...W !?2,"PERSON ENTERING STUB RECORD: ",$$GET1^DIQ(FILE,DA,56,"E"),!
 . K DIR S DIR(0)="Y"
 . S DIR("A")=" Is the Current entry a DUPLICATE Case: "
 . D ^DIR K DIR
 . I Y S VIEW=1
 Q VIEW
DELETE ;Delete incomplete case
 S DIK="^OOPS(2260,",DA=IEN2260 D ^DIK K DIK
END W !!," Case ",NUM," deleted"
EXIT K DA,DIC,DIE,DR,NUM,NAME,SEX,SSN,DOB,STN,CCT,OCC,GRD,STP,EDU,ANS
 Q
