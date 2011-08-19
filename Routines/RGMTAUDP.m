RGMTAUDP ;BIR/CML,PTD-MPI/PD AUDIT File Print of Patient Data ;01/06/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**19,30,46**;30 Apr 99
 ;Reference to ^DD(2 supported by IA #2695.
 ;Reference to ^DIA(2 and data derived from the AUDIT file (#1.1)
 ;supported by IA #2097 and #2602.
 ;Reference to ^ORD(101 supported by IA #2596
 ;
BEGIN ;
 S QFLG=1
 W @IOF
 W !,"This option prints a customized report of information stored in the AUDIT"
 W !,"file (#1.1) for fields being audited in the PATIENT file (#2).  For a"
 W !,"specified date range, you can view all audited fields or selected fields."
 W !,"You can also opt to print only edits that were done by a specific user."
 W !!,"- If selected fields are viewed, you can choose to see data for all or"
 W !,"  selected patients."
 W !,"- If ALL audited fields are viewed, you must choose patients to examine."
 ;
ASKFLD ;Ask for Data Fields
 I '$O(^DD(2,"AUDIT",0)) W !!,"No fields are currently being audited in the PATIENT file (#2)." G QUIT
 W !
 K DIR S DIR(0)="SAM^A:ALL;S:SELECTED;"
 S DIR("A")="Do you want to see (A)LL or (S)ELECTED audited fields? "
 S DIR("B")="A"
 S DIR("?",1)="Enter:"
 S DIR("?",2)=" ""A"" to see ALL audited fields in the PATIENT file (#2)."
 S DIR("?")=" ""S"" to select specific audited fields."
 D ^DIR G:$D(DIRUT) QUIT S ANS1=Y
 ;
FLDLOOP ;
 W ! K FLD
 ;stuff all fields
 I ANS1="A" D  G ASKPAT
 .S FLD=0 F  S FLD=$O(^DD(2,"AUDIT",FLD)) Q:'FLD  S FLD(FLD)=""
 ;ask for specific fields
 K DIR S DIR(0)="NAOC^.0000001:9999999:7^K:'$D(^DD(2,""AUDIT"",X)) X S RGERR=1"
 S DIR("A")="Select FIELD NUMBER of audited field (enter ""?"" for list): "
 S DIR("?")="^D FLDLIST^RGMTAUDP"
 F QQ=0:0 S RGERR=0 D ^DIR Q:$D(DIRUT)  S FLD(+Y)=""
 ;
ASKPAT ;Ask for Patient
 I '$O(FLD(0))!($D(DUOUT)) S QFLG=1 G QUIT
 I ANS1="A" S ANS2="S" G PATLOOP
 K DIR S DIR(0)="SAM^A:ALL;S:SELECTED;"
 S DIR("A")="Do you want to see audited data for (A)LL or (S)ELECTED patients? "
 S DIR("B")="S"
 S DIR("?",1)="Enter:"
 S DIR("?",2)=" ""A"" to see audited fields for ALL patients."
 S DIR("?")=" ""S"" to select specific patients(s)."
 W ! D ^DIR G:$D(DIRUT) QUIT S ANS2=Y
PATLOOP ;
 W ! K PAT
 I ANS2="A" S PAT("ALL")="" G ASKDT
 ;ask for specific patient(s)
 F QQ=0:0 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: " D ^DIC K DIC Q:Y<0  S RGDFN=+Y D
 .I '$O(^DIA(2,"B",RGDFN,0)) W $C(7),!?5,"This patient has no audit data available for any date." Q
 .S PAT(RGDFN)=""
 ;
ASKDT ;Ask for Date Range
 I '$D(PAT)!($D(DUOUT)) S QFLG=1 G QUIT
 W !!,"Enter date range for data to be included in report."
 K DIR,DIRUT,DTOUT,DUOUT S DIR(0)="DAO^:DT:EPX",DIR("A")="Beginning Date:  " D ^DIR K DIR G:$D(DIRUT) QUIT
 S RGBDT=Y,DIR(0)="DAO^"_RGBDT_":DT:EPX",DIR("A")="Ending Date:  " D ^DIR K DIR G:$D(DIRUT) QUIT S RGEDT=Y
 ;
ASKUSER ;Ask if data is wanted only a specific user
 K USERSCRN
 W ! S DIR(0)="Y",DIR("B")="No",DIR("A")="Do you want to find only the edits made by a specific user"
 D ^DIR K DIR I +Y'=1 G DEV
 ;
 S DIC="^VA(200,",DIC(0)="QEAM",DIC("A")="Select USER: "
 D ^DIC K DIC G:+Y<0 QUIT S USERSCRN=+Y
 ;
DEV W !!,"The right margin for this report is 80.",!!
 I ANS2="A" S IOP="Q" W "Because you selected ALL patients, you MUST queue this report.",!!
 S ZTSAVE("RGBDT")="",ZTSAVE("RGEDT")="",ZTSAVE("ANS2")="",ZTSAVE("FLD(")="",ZTSAVE("PAT(")="",%ZIS("B")=""
 S ZTSAVE("USERSCRN")=""
 D EN^XUTMDEVQ("START^RGMTAUDP","MPI/PD - Print AUDIT File Data from the PATIENT file",.ZTSAVE,.%ZIS) I 'POP Q
 W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
 S QFLG=1 G QUIT
 ;
START ;
 K ^TMP("RGMTAUDP",$J),^TMP("RGMTAUDP2",$J) S U="^"
 S STOP=RGEDT+1
 I ANS2="A" D
 .S CNT=0
 .S RGDFN=0 F  S RGDFN=$O(^DIA(2,"B",RGDFN)) Q:'RGDFN  S CNT=CNT+1 S:'(CNT#10000) ^TMP("RGMTAUDP",$J,"@@@@","CUR DFN")=RGDFN D LOOP
 I ANS2="S" D
 .S RGDFN=0 F  S RGDFN=$O(PAT(RGDFN)) Q:'RGDFN  D LOOP
 G PRT
 ;
LOOP ;Loop on "B" xref of the AUDIT file
 Q:'$D(^DPT(RGDFN,0))
 I ANS2="S" D
 . S PATNM=$P(^DPT(RGDFN,0),U)_U_RGDFN
 . I '$O(^DIA(2,"B",RGDFN,0)) S ^TMP("RGMTAUDP2",$J,"NO AUDIT",PATNM)=" has no audit data available for any date."
 S IEN=0 F  S IEN=$O(^DIA(2,"B",RGDFN,IEN)) Q:'IEN  D
 .I $D(^DIA(2,IEN,0)) S IEN0=(^(0)),EDITDT=$P(IEN0,U,2) I EDITDT>RGBDT,EDITDT<STOP D
 ..S FLD=$P(IEN0,U,3) I $D(FLD(FLD)) D
 ...S USER=$P(IEN0,U,4)
 ...I $D(USERSCRN) I USER'=USERSCRN Q
 ...S PATNM=$P(^DPT(RGDFN,0),U)_U_RGDFN,^TMP("RGMTAUDP",$J,PATNM,EDITDT,IEN)=""
 I ANS2="S" D
 . I '$D(^TMP("RGMTAUDP",$J,PATNM)) S ^TMP("RGMTAUDP2",$J,"NO AUDIT",PATNM)=" has no audit data available for selected parameters."
 Q
 ;
PRT ;Print report
 S (PG,QFLG)=0,U="^",$P(LN,"-",81)="",SITE=$P($$SITE^VASITE(),U,2)
 S PRGBDT=$$FMTE^XLFDT(RGBDT),PRGEDT=$$FMTE^XLFDT(RGEDT)
 D NOW^%DTC S HDT=$$FMTE^XLFDT($E(%,1,12))
 D HDR
 I '$D(^TMP("RGMTAUDP",$J)) W !!,"No audit data found in this date range for specified parameters." G QUIT
 S PATNM="@@@@" F  S PATNM=$O(^TMP("RGMTAUDP",$J,PATNM)) Q:PATNM=""  Q:QFLG  D
 .D:$Y+4>IOSL HDR Q:QFLG
 .W !!,"==> ",$P(PATNM,U),"  (DFN #",$P(PATNM,U,2),")"
 .S EDITDT=0 F  S EDITDT=$O(^TMP("RGMTAUDP",$J,PATNM,EDITDT)) Q:QFLG  Q:'EDITDT  D
 ..S IEN=0 F  S IEN=$O(^TMP("RGMTAUDP",$J,PATNM,EDITDT,IEN)) Q:QFLG  Q:'IEN  D
 ...S PRTDT=$$FMTE^XLFDT($E(EDITDT,1,12))
 ...S IEN0=^DIA(2,IEN,0)
 ...K RGARR D FIELD^DID(2,$P(IEN0,U,3),"","LABEL","RGARR")
 ...S FLD=$G(RGARR("LABEL"))  Q:FLD=""
 ...S USER=$P(IEN0,U,4)
 ...I 'USER S USER="UNKNOWN"
 ...I USER'="UNKNOWN" S DIC="^VA(200,",DIC(0)="MZO",X="`"_USER D ^DIC S USER=$P(Y,"^",2)
 ...S OLD=$G(^DIA(2,IEN,2)) I OLD']"" S OLD="<no previous value>"
 ...S NEW=$G(^DIA(2,IEN,3)) I NEW']"" S NEW="<no current value>"
 ...K OPTDA1,OPTDA2,OPTION,OPTNM I $G(^DIA(2,IEN,4.1)) D
 ....S OPTDA1=+$P(^DIA(2,IEN,4.1),"^")
 ....I OPTDA1 S DIC=19,DR=".01",DA=OPTDA1,DIQ(0)="EI",DIQ="OPTION" D EN^DIQ1 K DIC,DR,DA,DIQ S OPTION=$G(OPTION(19,OPTDA1,.01,"E"))
 ....S OPTDA2=$P(^DIA(2,IEN,4.1),"^",2)
 ....I $P(OPTDA2,";",2)="ORD(101," S DIC=101,DR=".01",DA=+OPTDA2,DIQ(0)="EI",DIQ="OPTION" D EN^DIQ1 K DIC,DR,DA,DIQ S OPTNM=$G(OPTION(101,+OPTDA2,.01,"E")) Q
 ....I +OPTDA2 S DIC=19,DR=".01",DA=+OPTDA2,DIQ(0)="EI",DIQ="OPTION" D EN^DIQ1 K DIC,DR,DA,DIQ S OPTNM=$G(OPTION(19,+OPTDA2,.01,"E")) Q
 ...D:$Y+5>IOSL HDR Q:QFLG  W !!,PRTDT,?20,FLD,?51,USER,!?20,OLD," / ",NEW
 ...I $G(OPTION)'="" W !?3,OPTION I $G(OPTNM)'="" W "/",OPTNM
 I $D(^TMP("RGMTAUDP2",$J,"NO AUDIT")) D
 . S PATNM="@@@@",RGNAUD="" F  S PATNM=$O(^TMP("RGMTAUDP2",$J,"NO AUDIT",PATNM)) Q:PATNM=""  D
 .. Q:QFLG
 .. S RGNAUD=$P(^TMP("RGMTAUDP2",$J,"NO AUDIT",PATNM),U)
 .. W !!,"==> ",$P(PATNM,U),"  (DFN #",$P(PATNM,U,2),")"_RGNAUD
 ;
QUIT ;
 I $E(IOST,1,2)="C-"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 K ^TMP("RGMTAUDP",$J),^TMP("RGMTAUDP2",$J)
 K %,%I,ANS1,ANS2,C,CNT,RGDFN,DIR,DIRUT,DTOUT,DUOUT,EDITDT,FLD,FLDLP,FLDNM,HDR
 K HDT,IEN,IEN0,JJ,LN,NEW,OLD,OPTDA1,OPTDA2,OPTION,OPTNM,PAT,PATNM,PG,PRGBDT,PRGEDT,PRTDT,QFLG,QQ,RGARR,RGBDT,RGNAUD
 K RGEDT,RGERR,SITE,SS,STOP,USER,X,Y,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
HDR ;HEADER
 I $E(IOST,1,2)="C-" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST,1,2)="C-",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST,1,2)="C-") @IOF
 W !,"PATIENT AUDIT LIST at ",SITE," on ",HDT,?72,"Page: ",PG
 W !,"Date Range: ",PRGBDT," to ",PRGEDT
 W !!,"Date/Time Edited",?20,"Field Edited",?51,"Edited By",!?20,"Old Value / New Value"
 W !?3,"Option/Protocol",!,LN
 Q
 ;
FLDLIST ;Help for Field # List
 K RG N DIR S QFLG=0 I RGERR W $C(7)," ??"
 S HDR="Select a FIELD NUMBER from the audited field(s) in the PATIENT file:"
 W @IOF,HDR,!
 S FLDLP=0 F  S FLDLP=$O(^DD(2,"AUDIT",FLDLP)) Q:'FLDLP  Q:QFLG  D
 .I $Y+6>IOSL D  Q:QFLG
 ..S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 ..E  W @IOF,HDR,!
 .K RGARR D FIELD^DID(2,FLDLP,"","LABEL","RGARR")
 .S FLDNM=$G(RGARR("LABEL")) Q:FLDNM=""
 .W !,FLDLP,?13,FLDNM
 Q
