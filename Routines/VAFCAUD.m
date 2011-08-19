VAFCAUD ;BIR/CML-MPI/PD AUDIT FILE PRINT FOR A SPECIFIED PATIENT ;2/25/09
 ;;5.3;Registration;**477,712**;Aug 13, 1993;Build 7
 ;Reference to ^DIA(2 and data derived from the AUDIT file (#1.1)
 ;is supported by IA #2097 and #2602.
 ;Reference to ^ORD(101 supported by IA #2596
 S QFLG=1
 S RPCFLG=0 ;is this from an rpc call
BEGIN ;
 W !!,"This option prints information from the AUDIT file (#1.1) for a"
 W !,"selected patient and date range."
 W !!,"For the PATIENT file (#2) entry selected, the report prints the"
 W !,"patient name and DFN, date/time the field was edited, the user who"
 W !,"made the change, the field edited, the old value, and the new value."
 W !,"The option or protocol (if available) will also be displayed."
 D ASK1
 I $G(VAFCDFN) D ASK2
 I $G(VAFCBDT),$G(VAFCEDT) D DEV
 G QUIT
 ;
ASK1 ;Ask for PATIENT
 W !
 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: " D ^DIC K DIC Q:Y<0  S VAFCDFN=+Y
 I '$O(^DIA(2,"B",VAFCDFN,0)),'$O(^DIA(2,"B",VAFCDFN_",1",0)) W !!,"This patient has no audit data available for any date." G ASK1   ;**712
 Q
 ;
ASK2 ;Ask for Date Range
 ;I '$D(VAFCDFN)&($D(DFN)) S VAFCDFN=DFN
 W !!,"Enter date range for data to be included in report."
 K DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="DAO^:DT:EPX",DIR("A")="Beginning Date:  " D ^DIR K DIR Q:$D(DIRUT)  S VAFCBDT=Y
 S DIR(0)="DAO^"_VAFCBDT_":DT:EPX",DIR("A")="Ending Date:  " D ^DIR K DIR Q:$D(DIRUT)  S VAFCEDT=Y
 Q
 ;
DEV W !!,"The right margin for this report is 80.",!!
 S ZTSAVE("VAFCBDT")="",ZTSAVE("VAFCEDT")="",ZTSAVE("VAFCDFN")=""
 D EN^XUTMDEVQ("START^VAFCAUD(VAFCDFN,VAFCBDT,VAFCEDT,RPCFLG)","MPI/PD - Print AUDIT File Data for a Specific Patient",.ZTSAVE) I 'POP Q
 W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
 G QUIT
 ;
START(VAFCDFN,VAFCBDT,VAFCEDT,RPCFLG) ;
 N IEN
 K ^TMP("VAFCAUD",$J)
 ;
LOOP ;Loop on "B" xref of the AUDIT file
 S STOP=VAFCEDT+1
 S IEN=0 F  S IEN=$O(^DIA(2,"B",VAFCDFN,IEN)) Q:'IEN  D
 .I $D(^DIA(2,IEN,0)) S EDITDT=$P(^(0),U,2) I EDITDT>VAFCBDT,EDITDT<STOP D
 ..S ^TMP("VAFCAUD",$J,EDITDT,IEN)=""
 ;
 ;find any audit data for audited fields that are multiples  - **712
 F QQ=1:1 S SUB=VAFCDFN_","_QQ Q:'$D(^DIA(2,"B",SUB))  S IEN=0 F  S IEN=$O(^DIA(2,"B",SUB,IEN)) Q:'IEN  D
 .I $D(^DIA(2,IEN,0)) S EDITDT=$P(^(0),U,2) I EDITDT>VAFCBDT,EDITDT<STOP S ^TMP("VAFCAUD",$J,EDITDT,IEN)=""
 ;
PRT ;Print report
 S (PG,QFLG)=0,U="^",$P(LN,"-",81)="",SITE=$P($$SITE^VASITE(),U,2)
 S PVAFCBDT=$$FMTE^XLFDT(VAFCBDT),PVAFCEDT=$$FMTE^XLFDT(VAFCEDT)
 D NOW^%DTC S HDT=$$FMTE^XLFDT($E(%,1,12))
 D HDR
 I '$O(^TMP("VAFCAUD",$J,0)) W !!,"No audit data found in this date range for this patient." Q
 S EDITDT=0 F  S EDITDT=$O(^TMP("VAFCAUD",$J,EDITDT)) Q:QFLG  Q:'EDITDT  D
 .S IEN=0 F  S IEN=$O(^TMP("VAFCAUD",$J,EDITDT,IEN)) Q:QFLG  Q:'IEN  D
 ..S PRTDT=$$FMTE^XLFDT($E(EDITDT,1,12))
 ..S IEN0=^DIA(2,IEN,0)
 ..S FILE=2,FIELD=$P(IEN0,"^",3) I FIELD["," S FILE=+$P(^DD(2,$P(FIELD,","),0),"^",2),FIELD=$P(FIELD,",",2)   ;**712
 ..K VAFCARR1 D FIELD^DID(FILE,FIELD,"","LABEL","VAFCARR1")   ;**712
 ..S FLD=$G(VAFCARR1("LABEL")) Q:FLD=""
 ..S USER=$P(IEN0,U,4)
 ..I 'USER S USER="UNKNOWN"
 ..I USER'="UNKNOWN" S DIC="^VA(200,",DIC(0)="MZO",X="`"_USER D ^DIC S USER=$P(Y,"^",2)
 ..S OLD=$G(^DIA(2,IEN,2)) I OLD']"" S OLD="<no previous value>"
 ..S NEW=$G(^DIA(2,IEN,3)) I NEW']"" S NEW="<no current value>"
 ..K OPTDA1,OPTDA2,VAFCOPTN,OPTNM I $G(^DIA(2,IEN,4.1)) D
 ...S OPTDA1=+$P(^DIA(2,IEN,4.1),"^")
 ...I OPTDA1 S DIC=19,DR=".01",DA=OPTDA1,DIQ(0)="EI",DIQ="VAFCOPTN" D EN^DIQ1 K DIC,DR,DA,DIQ S VAFCOPTN=$G(VAFCOPTN(19,OPTDA1,.01,"E"))
 ...S OPTDA2=$P(^DIA(2,IEN,4.1),"^",2)
 ...I $P(OPTDA2,";",2)="ORD(101," S DIC=101,DR=".01",DA=+OPTDA2,DIQ(0)="EI",DIQ="VAFCOPTN" D EN^DIQ1 K DIC,DR,DA,DIQ S OPTNM=$G(VAFCOPTN(101,+OPTDA2,.01,"E")) Q
 ...I +OPTDA2 S DIC=19,DR=".01",DA=+OPTDA2,DIQ(0)="EI",DIQ="VAFCOPTN" D EN^DIQ1 K DIC,DR,DA,DIQ S OPTNM=$G(VAFCOPTN(19,+OPTDA2,.01,"E")) Q
 ..I 'RPCFLG D:$Y+4>IOSL HDR Q:QFLG
 ..W !,PRTDT,?20,FLD,?51,USER,!?20,OLD," / ",NEW
 ..I $G(VAFCOPTN)'="" W !?3,VAFCOPTN
 ..I $G(OPTNM)'="" W:$G(VAFCOPTN)="" !?3 W "/",$G(OPTNM)
 ..W !
 Q
 ;
QUIT ;
 I '$G(RPCFLG),$E(IOST,1,2)="C-"&('$G(QFLG)) S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 I '$G(RPCFLG) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP("VAFCAUD",$J)
 K %,%I,C,VAFCDFN,EDITDT,FLD,HDT,IEN,IEN0,JJ,LN,NEW,OLD,OPTDA1,OPTDA2,VAFCOPTN,OPTNM,PG,PVAFCBDT,PVAFCEDT,PRTDT,POP
 K QFLG,VAFCARR1,VAFCBDT,VAFCEDT,RPCFLG,SITE,SS,STOP,USER,X,Y,ZTSK
 K SUB,FILE,FIELD,QQ   ;**712
 Q
 ;
HDR ;HEADER
 I 'RPCFLG I $E(IOST,1,2)="C-" S SS=22-$Y F JJ=1:1:SS W !
 I 'RPCFLG I $E(IOST,1,2)="C-",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1
 I 'RPCFLG W:$Y!($E(IOST,1,2)="C-") @IOF
 W !,"PATIENT AUDIT LIST at ",SITE," on ",HDT,?70,"Page: ",PG
 W !,"Patient: ",$P(^DPT(VAFCDFN,0),U)," (DFN #",VAFCDFN,")"
 W !,"Date Range: ",PVAFCBDT," to ",PVAFCEDT
 W !!,"Date/Time Edited",?20,"Field Edited",?51,"Edited By"
 W !?20,"Old Value / New Value",!?3,"Option/Protocol",!,LN
 Q
