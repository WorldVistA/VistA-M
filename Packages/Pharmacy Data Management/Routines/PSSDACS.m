PSSDACS ;BIR/WRT-loops thru file 50 and sends MM message if a "N" is in APPLICATION PACKAGES' USE field ; 10/22/97 15:21
 ;;1.0;PHARMACY DATA MANAGEMENT;**3**;9/30/97
 ; POST-INSTALL ROUTINE
BEGIN K ^TMP($J,"PSSBT")
 D SETOP,START,REBD
 N DIFROM D MESS
DONE K NBR,PSSDUZ,NM
 Q
SETOP S ^TMP($J,"PSSBT","*1",1)="The following entries need to be reviewed as to how they are marked package-",^TMP($J,"PSSBT","*2",2)="wise as to Drug Accountability/Inventory Interface vs. Controlled Substances."
 S ^TMP($J,"PSSBT","*3",3)="If entries need to be marked or unmarked, use the ""Controlled Substances Menu"".",^TMP($J,"PSSBT","*4",4)="Select ""Supervisor (CS) Menu"", then select ""Set Up CS (Build Files) Menu""."
 S ^TMP($J,"PSSBT","*5",5)="Select ""Enter/Edit Menu"" and then select ""Mark/Unmark for Controlled SubstancesUse"" option.",^TMP($J,"PSSBT","*6",6)="  ",^TMP($J,"PSSBT","*7",7)="  "
 Q
START S NM="" F  S NM=$O(^PSDRUG("B",NM)) Q:NM=""  S NBR=$O(^PSDRUG("B",NM,0)) I $P($G(^PSDRUG(NBR,2)),"^",3)["N" D SETIT
 Q
SETIT S ^TMP($J,"PSSBT",$P(^PSDRUG(NBR,0),"^"),NBR)=$P(^PSDRUG(NBR,0),"^")
 Q
REBD S NME="" F  S NME=$O(^TMP($J,"PSSBT",NME)) Q:NME=""  S NDA=$O(^TMP($J,"PSSBT",NME,0)) S NUM=$S('$D(NUM):9,1:NUM+1),^TMP($J,"PSSWRT",NUM,0)=$P(^TMP($J,"PSSBT",NME,NDA),"^")
 Q
MESS S XMDUZ="PHARMACY DATA MANAGEMENT PACKAGE",XMSUB="DRUGS TO BE REVIEWED (DA vs CS)",XMTEXT="^TMP($J,""PSSWRT"",",XMY(DUZ)=""
 I $D(^XUSEC("PSAMGR")) F PSSDUZ=0:0 S PSSDUZ=$O(^XUSEC("PSAMGR",PSSDUZ)) Q:'PSSDUZ  S XMY(PSSDUZ)=""
 I $D(^XUSEC("PSA ORDERS")) F PSSDUZ=0:0 S PSSDUZ=$O(^XUSEC("PSA ORDERS",PSSDUZ)) Q:'PSSDUZ  S XMY(PSSDUZ)=""
 I $D(^XUSEC("PSDMGR")) F PSSDUZ=0:0 S PSSDUZ=$O(^XUSEC("PSDMGR",PSSDUZ)) Q:'PSSDUZ  S XMY(PSSDUZ)=""
 D ^XMD K ^TMP($J,"PSSBT"),^TMP($J,"PSSWRT"),XMY,NUM,XMDUZ,XMTEXT,PSSDUZ,XMSUB
 Q
