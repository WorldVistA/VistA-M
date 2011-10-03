PXRMGECP ;SLC/JVS -GEC-Prompts ;7/14/05  10:43
 ;;2.0;CLINICAL REMINDERS;**2,4**;Feb 04, 2005;Build 21
 Q
EN ;Entry Point
 ;^DISV(  = DBIA #510
 N POP,DIROUT,DIRUT,DUOUT,LOCNP,MENU,PROV,Y
 N DETAIL,FORMAT,INC
 ;D INIT^PXRMGECW
 S X="IOUON;IOUOFF;IORVOFF;IORVON" D ENDR^%ZISS
 W IOUOFF,IORVOFF
 W @IOF
 W !,"All Reports will print on 80 Columns"
 K DIR
 S DIR("A")="Select Option or ^ to Exit"
 I $D(^DISV(DUZ,"PXRMGEC","EN")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","EN"))
 S DIR(0)="S^1:Category;2:Patient;3:Provider by Patient;4:Referral Date;5:Location;6:Referral Count Totals;7:Category-Referred Service;8:Summary (Score);9:'Home Help' Eligibility;10:Restore or Merge Referrals"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIRUT)!($D(DIROUT))
 ;DBIA #510
 S MENU=Y,^DISV(DUZ,"PXRMGEC","EN")=MENU
 I MENU=1 D CAT
 I MENU=2 D PATIENT
 I MENU=3 D PRO
 I MENU=4 D DR
 I MENU=5 D LOCDIR^PXRMGECO
 I MENU=6 D CT^PXRMGECO
 I MENU=7 D RS^PXRMGECO
 I MENU=8 D SUM^PXRMGECO
 I MENU=9 D HOME^PXRMG2R2
 I MENU=10 D EN^PXRMGECJ
 D KILL^%ZISS
 Q
 ;==========================================================
 ;
CAT ;#1 Start List and array of GEC Categories
 ;
 N CAT,CATNA,CNT,STAY,NUM,CATIEN,CATARY,BDT,EDT,CATDA,SYN
 W @IOF
 W "GEC Referral Categories"
 S CNT=0
 S SYN="" F  S SYN=$O(^AUTTHF("D",SYN)) Q:SYN=""  D
 .I $E(SYN,1,3)="GEC",$E(SYN,5)="C" D
 ..S CAT=0 F  S CAT=$O(^AUTTHF("D",SYN,CAT)) Q:CAT=""  D
 ...Q:$P($G(^AUTTHF(CAT,0)),"^",11)=1
 ...S CATNA=$P($G(^AUTTHF(CAT,0)),"^",1)
 ...S CATNA=$P(CATNA," ",3,7)
 ...S CATARY(CATNA,CAT)=""
 S CATNA="" F  S CATNA=$O(CATARY(CATNA)) Q:CATNA=""  D
 .S CAT=$O(CATARY(CATNA,0))
 .S CNT=CNT+1
 .S CATDA(CNT,CAT)=""
 .W:CNT#2=1 !,CNT,?4,CATNA
 .W:CNT#2=0 ?35,CNT,?39,CATNA
SC ;=====Select Categories
 W !
 S DIR("A",1)="Select Categories from the list above using"
 S DIR("A",2)="Commas and/or Dashes for ranges of numbers."
 S DIR("A")="Select Categories or ^ to exit"
 I $D(^DISV(DUZ,"PXRMGEC","SC")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","SC"))
 S DIR(0)="L^1:"_CNT
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIROUT)
 Q:$D(DIRUT)
 S ^DISV(DUZ,"PXRMGEC","SC")=X
 N LEN,IME,MEY
 S LEN=$L(Y,",")
 S MEY=0 F IME=1:1:LEN-1 S MEY=$P(Y,",",IME) D
 .S CATMEY(MEY)=""
 S STAY=0 F  S STAY=$O(CATDA(STAY)) Q:STAY=""  D
 .I '$D(CATMEY(STAY)) K CATDA(STAY)
 S NUM=0 F  S NUM=$O(CATDA(NUM)) Q:NUM=""  D
 .S CATIEN($O(CATDA(NUM,0)))=""
 K CATDA,CATMEY
CATBDT D BDT Q:$D(DIROUT)!$D(DIRUT)
CATEDT D EDT Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G CATBDT
CATPAT D PAT Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G CATEDT
CATFOR D FOR Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G CATPAT
CATIOO D CATIO Q:$D(DIROUT)
 Q
BDT ;=====Select Beginning Date
 ;--Return BDT as DATE
 W !
 S DIR("A",1)="Select a Beginning Historical Date."
 S DIR("A")="BEGINNING date or ^ to exit"
 I $D(^DISV(DUZ,"PXRMGEC","BDT")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","BDT"))
 S DIR(0)="D^2880101:"_DT_":EX"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIROUT)!($D(DIRUT))
 S ^DISV(DUZ,"PXRMGEC","BDT")=X
 S BDT=Y
 Q
 ;
EDT ;=====Select Ending Date
 ;--Return EDT as DATE
 W !
 S DIR("A",1)="Select Ending Date."
 S DIR("A")="ENDING date or ^ to exit"
 I $D(^DISV(DUZ,"PXRMGEC","EDT")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","EDT"))
 S DIR(0)="D^"_BDT_":"_DT_":EX"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIROUT)!($D(DIRUT))
 S ^DISV(DUZ,"PXRMGEC","EDT")=X
 S EDT=Y
 Q
 ;=====Select Patients
PAT ;--Return DFNONLY as Patient DFN
 W @IOF
 K DIR,DIR("A")
 K DFNONLY
 S DIR("A")="Select Patients or ^ to exit"
 I $D(^DISV(DUZ,"PXRMGEC","PAT")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","PAT"))
 S DIR(0)="S^A:All Patients;M:Multiple Patients"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIROUT)!($D(DIRUT))
 S ^DISV(DUZ,"PXRMGEC","PAT")=X
 I Y="A" S DFNONLY=0
 I Y="M" D PATLU
 Q
 ;
FOR ;=====Formatted or Delimited Report
 ;--Return FORMAT equal to Y
 S DIR("A")="Select Report Format or ^ to exit"
 I $D(^DISV(DUZ,"PXRMGEC","FOR")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","FOR"))
 S DIR(0)="S^F:Formatted;D:Delimited"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIRUT)!($D(DIROUT))
 S ^DISV(DUZ,"PXRMGEC","FOR")=X
 S FORMAT=Y
 Q
 ;
CATIO ;=====Select IO device
 Q:'$D(BDT)!('$D(EDT))!('$D(DFNONLY))!'$D(FORMAT)
 N %ZIS
 S %ZIS="QM" D ^%ZIS
 I POP Q
 I $D(IO("Q")) D
 .S ZTRTN="HFCD^PXRMGECQ"
 .S ZTDESC="Gec Report Printing"
 .S ZTSAVE("*")=""
 .D ^%ZTLOAD K IO("Q") Q
 ;=====Call Report
 E  D HFCD^PXRMGECR
 D HOME^%ZIS
 D ^%ZISC
 S:'$D(DIRUT)&('$D(DUOUT))&('$D(DIROUT)) DIR(0)="E" D ^DIR K DIR(0),Y
 Q
 ;
 ;================SUB ROUTINES==============================
PROV ;Select Provider
 W @IOF
 N DIC,Y
 S PROV=0
 K PROVARY
 S DIC="^VA(200,"
 S DIC(0)="QAMEZ"
PROVR D ^DIC
 I Y=-1 K DIC,DIC(0),Y Q
 I +Y>0 S PROVARY(+Y)=""
 S PROV=+Y
 G PROVR
 Q
 ;
PATLU ;Patient Look up
 N Y,DIC
 S DFNONLY=0
 K DFNARY
 S DIC="^DPT("
 S DIC(0)="QAMEZ"
PATLUR D ^DIC
 I Y=-1 K DIC,DIC(0),Y Q
 I +Y>0 S DFNONLY=+Y,DFNARY(+Y)=""
 G PATLUR
 Q
 ;
 ;================================================================
PRO ; #3 Start of Provider by Patient Report
 N BDT,EDT,DFNONLY
 W @IOF
 K DIR
 I $D(^DISV(DUZ,"PXRMGEC","PRO")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","PRO"))
 S DIR(0)="S^A:All Providers;M:Multiple Providers"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIRUT)!($D(DUOUT))
 Q:$D(DIROUT)
 S ^DISV(DUZ,"PXRMGEC","PRO")=X
 I Y="A" S PROV=0
 I Y="M" D PROV Q:'$D(PROVARY)
 Q:$D(DIRUT)!($D(DIROUT))
PROBDT D BDT Q:$D(DIRUT)!($D(DIRUT))
PROEDT D EDT Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G PROBDT
PROFOR D FOR Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G PROEDT
PROIOO D PROIO Q:$D(DIROUT)
 Q
 ;
PROIO ;=====Select IO device
 N %ZIS
 S %ZIS="QM" D ^%ZIS
 I POP Q
 I $D(IO("Q")) D
 .S ZTRTN="DFN2^PXRMGECQ"
 .S ZTDESC="GEC PROVIDER REPORT"
 .S ZTSAVE("*")=""
 .D ^%ZTLOAD K IO("Q") Q
 ;=====Call Report
 E  D DFN2^PXRMGECS
 D HOME^%ZIS
 D ^%ZISC
 S:'$D(DIRUT)&('$D(DUOUT))&('$D(DIROUT)) DIR(0)="E" D ^DIR K DIR(0),Y
 Q
 ;=================================================================
DR ; #4 Referral Date
 ;
DRPAT D PAT Q:$D(DIROUT)!($D(DIRUT))
DRBDT D BDT Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G DRPAT
DREDT D EDT Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G DRBDT
DRALL D ALL Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G DREDT
DRFOR D FOR Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G DRALL
DRIOO D DRIO Q:$D(DIROUT)
 Q
 ;
ALL ;=====Select All Referrals or
 ;--Return INC equal to Y
 I $D(^DISV(DUZ,"PXRMGEC","ALL")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","ALL"))
 S DIR(0)="S^I:Incomplete Referrals Only;C:Complete Referrals Only;B:Both Complete and Incomplete"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIRUT)!($D(DUOUT))
 S ^DISV(DUZ,"PXRMGEC","ALL")=X
 I Y="I" S INC=0
 I Y="C" S INC=1
 I Y="B" S INC=2
 Q
 ;
DRIO ;=====Select IO device
 N %ZIS
 S %ZIS="QM" D ^%ZIS
 I POP Q
 I $D(IO("Q")) D
 .S ZTRTN="DR^PXRMGECQ"
 .S ZTDESC="GEC REPORT"
 .S ZTSAVE("*")=""
 .D ^%ZTLOAD K IO("Q") Q
 ;=====Call Report
 E  D DR^PXRMGECR
 D HOME^%ZIS
 D ^%ZISC
 S:'$D(DIRUT)&('$D(DUOUT))&('$D(DIROUT)) DIR(0)="E" D ^DIR K DIR(0),Y
 Q
 ;
 ;==================================================================
PATIENT ; #2 Start of Patient Report
 ;
PATPAT D PAT Q:$D(DIROUT)!($D(DIRUT))
PATBDT D BDT Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G PATPAT
PATEDT D EDT Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G PATBDT
PATFOR D FOR Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G PATEDT
PATIOO D PATIO Q:$D(DIROUT)
 Q
 ;
PATIO ;=====Select IO device for Patient Report
 N %ZIS
 S %ZIS="QM" D ^%ZIS
 I POP Q
 I $D(IO("Q")) D
 .S ZTRTN="HS1^PXRMGECQ"
 .S ZTDESC="GEC PATIENT REPORT"
 .S ZTSAVE("*")=""
 .S ZTSAVE("FORMAT")=""
 .S ZTSAVE("EDT")=""
 .S ZTSAVE("BDT")=""
 .S ZTSAVE("DFNONLY")=""
 .I $D(DFNARY) S ZTSAVE("DFNARY(")=""
 .D ^%ZTLOAD K IO("Q") Q
 ;=====Call Report
 E  D HS1^PXRMGECR
 D HOME^%ZIS
 D ^%ZISC
 S:'$D(DIRUT)&('$D(DUOUT))&('$D(DIROUT)) DIR(0)="E" D ^DIR K DIR(0),Y
 Q
 ;=========================================================
