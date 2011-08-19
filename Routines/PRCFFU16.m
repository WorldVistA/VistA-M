PRCFFU16 ;WISC/SJG-PO OBLIGATION UTILITY ;8/18/94  17:03
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN(IEN) ; Called from PO obligation processing
 ; IEN - Internal entry number from 442
 W !,"Editing Auto Accrual information...",!
 D POVENO^PRCFFU15(IEN)
 S (ACCEDIT,AUTOACC,EXIT)=0
 N FILE S FILE=$$FILE
 D GENDIQ^PRCFFU7(FILE,IEN,".1;29;30","IEN","")
 I $G(PRCTMP(FILE,IEN,29,"E"))="" D PROMPT I 'Y!($D(DIRUT)) D:EXIT MSG5 Q
 I $G(PRCTMP(FILE,IEN,29,"E"))'="" S OB=IEN D MSG1,PROMPT1 I Y!($D(DIRUT)) D:EXIT MSG5 Q
 W ! D MSG3,MSG4
 I EXIT D MSG5 Q
 W ! D CHK
 I (NEWDATE="")&(NEWACC="YES") D
 .K MSG W !!
 .S MSG(1)="This Purchase Order Obligation does not have an Ending Date, but the"
 .S MSG(2)="Auto Accrual flag is set to 'YES'.",MSG(3)="  "
 .S MSG(4)="The Auto Accrual flag will be corrected and set to 'NO'."
 .D EN^DDIOL(.MSG) W ! K MSG D EDIT H 3
 .Q
 S DIE=442,DA=IEN,DR="29////^S X=NEWDATE;30////^S X=NEWACC"
 I $P(PRCFA("MOD"),U)="M",'PRCFA("RETRAN") S DIE=443.6
 D ^DIE K DIE,DR
 D TAG33^PRCFFU9
 KILL AUTOACC,NEWACC,NEWDATE,OLDACC,OLDDATE,CONTEND,CONTENDA,CONTENDE,CONTENDI
 QUIT
 ;
EDIT S DIE=442,DA=IEN,DR="30///^S X=""N"""
 I $P(PRCFA("MOD"),U)="M",'PRCFA("RETRAN") S DIE=443.6
 D ^DIE K DIE,DR
 Q
PROMPT ; Prompt user
 D EN^DDIOL("This "_$$LABEL^PRCFFU15_" Obligation appears to be for services.")
 S DIR(0)="Y",DIR("A")="Will this Purchase Order Obligation need to be accrued in FMS",DIR("B")="YES"
 S DIR("?")="  '^' to exit this option."
 S DIR("?",1)="Enter one of the following:"
 S DIR("?",2)="  'NO' or 'N' if no accrual is needed OR it is for one month."
 S DIR("?",3)="  'YES' or 'Y' if the Obligation covers more than one month AND accrual is",DIR("?",4)="   needed."
 S DIR("?",5)="  'RETURN' for YES."
 S DIR("??")="^D MSG2^PRCFFU15"
 D ^DIR K DIR W !
 I 'Y!($D(DIRUT)) N YY S YY=Y D EDIT,TAG33^PRCFFU9,MSG5 S Y=YY Q
 S NEWACC=Y(0)
 Q
MSG1 ; Display current auto accrual information
 D MSG1^PRCFFU15
 Q
PROMPT1 ; Prompt for correct values
 S DIR(0)="Y",DIR("A")="Are these Auto Accrual values correct",DIR("B")="YES",DIR("??")="^D MSG2^PRCFFU15"
 W ! D ^DIR K DIR W !
 I Y S EXIT=0,PRCFA("ACCEDIT")=1
 Q
MSG3 ; Prompt for Ending Date
 S NEWDATE=$G(PRCTMP(FILE,IEN,29,"I")),EXIT=0
 S DIR(0)="D",DIR("A")="END DATE FOR P.O. SERVICE ORDER"
 I $G(PRCTMP(FILE,IEN,29,"E"))]"" S DIR("B")=$G(PRCTMP(FILE,IEN,29,"E"))
 I $G(PRCTMP(FILE,IEN,29,"E"))="" D
 .I $D(CONTENDA)>9 D
 ..N END,CONT S END="",CONT=$O(CONTENDA(END))
 ..S CONTEND=$P(CONTENDA(CONT),U)
 ..I CONTEND]"" S DIR("B")=CONTEND
 ..Q
 .I $D(CONTENDA)<9 D
 ..N COM S COM=$G(PRCTMP(FILE,IEN,.1,"I")),Y=$P($$EOM^PRCFFU16(COM),U,2)
 ..D DD^%DT S DIR("B")=Y
 ..Q
 .Q
 D ^DIR K DIR
 I $D(DIRUT) S EXIT=1 Q
 I Y S NEWDATE=Y
 S X1=NEWDATE,X2=$G(PRCTMP(FILE,IEN,.1,"I")) D ^%DTC I X<0 W ! D EN^DDIOL("The Ending Date cannot come before the Purchase Order Date - "_$G(PRCTMP(FILE,IEN,.1,"E"))) W ! G MSG3
 D CHK1(NEWDATE)
 Q
MSG4 ; Prompt for Auto Accrual
 Q:EXIT
 S NEWACC=$G(PRCTMP(FILE,IEN,30,"I")),EXIT=0
 S DIR(0)="Y",DIR("A")="AUTO ACCRUAL FLAG",DIR("B")="YES"
 I $G(PRCTMP(FILE,IEN,30,"E"))="" D
 .S X1=NEWDATE,X2=$G(PRCTMP(FILE,IEN,.1,"I")) D ^%DTC I X<31 S DIR("B")="NO"
 I $G(PRCTMP(FILE,IEN,30,"E"))]"" S DIR("B")=$G(PRCTMP(FILE,IEN,30,"E"))
 D ^DIR K DIR
 I $D(DIRUT) S EXIT=1 Q
 S NEWACC=$S($E(Y,1)="Y":1,$E(Y,1)="N":0,$G(DIRUT)=1:0,'Y:0,Y:1,1:1)
 Q
MSG5 ; Exit message
 D MSG5^PRCFFU15
 Q
MSG6 ; Returning message
 D EN^DDIOL("Returning to Obligation processing...")
 Q
CHK ;
 S OLDDATE=$G(PRCTMP(FILE,IEN,29,"I"))
 S OLDACC=$G(PRCTMP(FILE,IEN,33,"I"))
 I OLDDATE=NEWDATE&(OLDACC=NEWACC) Q
 I OLDDATE'=NEWDATE S (PRCFA("ACCEDIT"),ACCEDIT)=1
 I OLDACC'=NEWACC S (PRCFA("ACCEDIT"),ACCEDIT)=1
 Q
FILE() ; Determine file for lookup
 I $D(PRCFA("MOD")),$P(PRCFA("MOD"),U)="E" S FILE=442
 I $D(PRCFA("MOD")),$P(PRCFA("MOD"),U)="M" D
 .I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=0 S FILE=443.6
 .I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 S FILE=442
 .Q
 Q FILE
EOM(DATE) ; Determine end-of-month default date
 N YR,MON,EOM,LEAP,DEF
 S YR=$E(DATE,1,3)+1700,MON=+$E(DATE,4,5)
 S LEAP=$S(YR#400=0:1,YR#4=0&'(YR#100=0):1,1:0)
 S EOM=$P("31~"_(28+LEAP)_"~31~30~31~30~31~31~30~31~30~31","~",MON)
 S FMEOM=$E(DATE,1,5)_EOM,DEF=MON_"/"_EOM
 Q DEF_U_FMEOM
CHK1(DATE) ;Check for Ending date crossover to next FY.
 S X="0930"_PRC("FY") D ^%DT
 S X2=Y ; end of fiscal year for PO
 S X=DATE D ^%DT
 S X1=Y D ^%DTC
 I X>0 W ! D EN^DDIOL("NOTE: The Ending Date for P.O. Service Order exceeds the End of the Fiscal Year!")
 W !
 Q
