ECXUCBOC ;ALB/TJL-CBOC Activity Report ; 10/20/03 11:19am
 ;;3.0;DSS EXTRACTS;**49**;July 1, 2003
 ;
EN ; entry point
 N X,Y,DATE,PG,COUNT,ECRUN,ECXDESC,ECXSAVE,ECXTL,YYYYMM,ECXJOB
 N ECSD,ECSD1,ECSTART,ECED,ECEND,ECXERR,QFLG
 S (QFLG,COUNT,PG)=0
 ; get today's date
 D NOW^%DTC S DATE=X,Y=$E(%,1,12) D DD^%DT S ECRUN=$P(Y,"@") K %DT
 ;D BEGIN Q:QFLG
 D SELECT Q:QFLG
 S ECXDESC="CBOC Activity Report"
 S ECXSAVE("EC*")=""
 W !!,"This report requires 80-column format."
 D EN^XUTMDEVQ("PROCESS^ECXUCBOC",ECXDESC,.ECXSAVE)
 I POP W !!,"No device selected...exiting.",! Q
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
BEGIN ; display report description
 W @IOF
 W !,"This report prints a listing of all Clinical (CLI) records"
 W !,"that have a Community Based Outpatient Clinic (CBOC) status of"
 W !,"Y (=Yes).  Reports are grouped by Feeder Key, Division, and"
 W !,"Clinic; detail lines include Patient Name, SSN, and Date of Visit."
 W !,"Totals for unique SSNs and unique Dates of Visit will be displayed"
 W !,"at the Clinic, Division, Feeder Key, and Report levels."
 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 W:$Y!($E(IOST)="C") @IOF,!!
 Q
 ;
SELECT ; user inputs for start date
 N OUT,DONE,LIST,IEN,ECXFROM,ECXEND,ECXRUN,ECXCNT,ECXDIV,LN
 W @IOF
 S (PG,QFLG)=0,$P(LN,"-",80)=""
 D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S HDT=Y D LISTHDR
 S IEN=0 F  S IEN=$O(^ECX(727,IEN)) Q:IEN=""  Q:QFLG  D:$Y+4>IOSL LISTHDR Q:QFLG  I $G(^ECX(727,IEN,"HEAD"))="CLI" D
 .I $G(^ECX(727,IEN,"PURG")) Q
 .I '$D(^ECX(727,IEN,0)) Q
 .I $P(^ECX(727,IEN,0),U,4)<3030101 Q
 .S ECXJOB=$P(^ECX(727,IEN,0),U)
 .S ECXFROM=$TR($$FMTE^XLFDT($P(^ECX(727,IEN,0),U,4),"5DF")," ","0")
 .S ECXEND=$TR($$FMTE^XLFDT($P(^ECX(727,IEN,0),U,5),"5DF")," ","0")
 .S ECXRUN=$TR($$FMTE^XLFDT($P(^ECX(727,IEN,0),U,2),"5DF")," ","0")
 .S ECXCNT=$P(^ECX(727,IEN,0),U,6)
 .S ECXDIV=$P($G(^ECX(727,IEN,"DIV")),U) I ECXDIV D
 ..S DA=ECXDIV,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 ..D EN^DIQ1 S ECXDIV=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 .D:$Y+3>IOSL LISTHDR Q:QFLG
 .W !?4,ECXJOB,?14,ECXRUN,?28,$J(ECXCNT,9),?41,ECXFROM," - ",ECXEND,?71,ECXDIV
 .S LIST(ECXJOB)=1
 S LO=$O(LIST(0)),HI=$O(LIST(" "),-1)
 S DIR(0)="L^"_LO_":"_HI_"",DIR("A")="Create the CBOC Activity Report for the following extract"
 W ! D ^DIR K DIR I $D(DIRUT) K LIST S QFLG=1 Q
 S JJ=0,Y=","_Y
 F  S JJ=$O(LIST(JJ)) Q:'JJ  S JZ=","_JJ_"," I Y'[JZ K LIST(JJ)
 I '$D(LIST) W !!,"Invalid choice.  Please try again." S DIR(0)="E" W ! D ^DIR K DIR D  Q:QFLG  G SELECT
 .I 'Y S QFLG=1
 S ECXJOB=X
 S Y=$P(^ECX(727,ECXJOB,0),U,4) D DD^%DT
 S ECSTART=$P(Y," ")_$P(Y,",",2)
 Q
 ;
LISTHDR ;
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF W !,"Selectable Clinic Extracts for CBOC Activity Report",?72,"Page: ",PG
 W !!,"Extract #",?15,"Run Date",?28,"Rec Count",?42,"Date Range of Extract",?68,"Division",!,LN
 Q
 ;
PROCESS ; entry point for queued report
 N ECXD,QFLG,PG,RECDA,LN,COUNT
 N FKEY,DIV,CLIN,SSN,DFN,VDATE,KEY
 N TSSN,FSSN,DSSN,CSSN,TVISIT,FVISIT,DVISIT,CVISIT
 N OLDFKEY,OLDDIV,OLDCLIN,OLDSSN,OLDDFN,OLDVDATE,OLDKEY,HEADKEY
 S (QFLG,COUNT,PG)=0,ZTREQ="@",ECXD="-",$P(LN,"-",80)=""
 K ^TMP($J)
 W @IOF
 ;
 ; set report created indicator
 K DA,DIC,DD,DO
 S DA(1)=1
 I '$D(^ECX(728,DA(1),"CBOC","B",ECXJOB)) D
 .S DLAYGO=728,DIC(0)="L",DIC("P")=$P(^DD(728,68,0),U,2)
 .S DIC="^ECX(728,"_DA(1)_",""CBOC"",",X=ECXJOB
 .D FILE^DICN
 ;
 I $O(^ECX(727.827,"AC",ECXJOB,0))="" D  Q
 .W !,"No extract records exist for the selected extract."
 S RECDA=0
 F  S RECDA=$O(^ECX(727.827,"AC",ECXJOB,RECDA)) Q:'RECDA  D ISCBOC
 ;
 I '$D(^TMP($J)) W !,"No records were found with a CBOC Indicator value of ""Y""." S QFLG=1 Q
 ;
 S (TSSN,FSSN,DSSN,CSSN,TVISIT,FVISIT,DVISIT,CVISIT)=0
 S RECDA=$O(^TMP($J,"AKEY",""))
 S HEADKEY=RECDA
 D HEADER Q:QFLG  D DETAIL Q:QFLG  D INCVIS D INCSSN D SETOLD
 ;
 ; process all CBOC records
 F  S RECDA=$O(^TMP($J,"AKEY",RECDA)) Q:RECDA=""  D  Q:QFLG
 .S HEADKEY=OLDKEY
 .; key fields match, so print detail record and increment total(s)
 .I $P(RECDA,ECXD,1,3)=OLDKEY D  Q
 ..D DETAIL Q:QFLG
 ..D INCVIS
 ..S SSN=$P(RECDA,ECXD,4)
 ..I '$D(^TMP($J,"C",OLDCLIN,SSN)) D INCSSN S OLDSSN=SSN
 .;
 .; if fkey changed, print "C","D", and "F" totals
 .I $P(RECDA,ECXD)'=OLDFKEY D  Q:QFLG
 ..D CLINTOT Q:QFLG  D DIVTOT Q:QFLG  D FKEYTOT Q:QFLG
 .E  D  Q:QFLG
 ..I $P(RECDA,ECXD,2)'=OLDDIV D
 ...D CLINTOT Q:QFLG  D DIVTOT Q:QFLG
 ..E  D CLINTOT Q:QFLG
 .;
 .; something changed, so print subheader and detail line
 .Q:QFLG  S HEADKEY=RECDA
 .D HEADER2 Q:QFLG
 .D DETAIL Q:QFLG
 .D INCVIS
 .D INCSSN
 .D SETOLD
 .Q
 Q:QFLG
 ; print totals for clinic, division, feeder key, and grand totals
 S HEADKEY=OLDKEY
 D CLINTOT Q:QFLG
 D DIVTOT Q:QFLG
 D FKEYTOT Q:QFLG
 D GTOTAL Q:QFLG
 Q
 ;
ISCBOC ;
 I $P(^ECX(727.827,RECDA,2),U,15)="Y" D SETKEY
 Q
 ;
INCVIS ;
 S TVISIT=TVISIT+1
 S FVISIT=FVISIT+1
 S DVISIT=DVISIT+1
 S CVISIT=CVISIT+1
 Q
 ;
INCSSN ;
 N ZSSN,ZF,ZD,ZC
 S ZSSN=$P(RECDA,ECXD,4)
 S ZF=$P(RECDA,ECXD,1)
 S ZD=$P(RECDA,ECXD,2)
 S ZC=$P(RECDA,ECXD,3)
 I '$D(^TMP($J,"SSN",ZSSN)) S ^TMP($J,"SSN",ZSSN)="" S TSSN=TSSN+1
 I '$D(^TMP($J,"F",ZF,ZSSN)) S ^TMP($J,"F",ZF,ZSSN)="" S FSSN=FSSN+1
 I '$D(^TMP($J,"D",ZD,ZSSN)) S ^TMP($J,"D",ZD,ZSSN)="" S DSSN=DSSN+1
 I '$D(^TMP($J,"C",ZC,ZSSN)) S ^TMP($J,"C",ZC,ZSSN)="" S CSSN=CSSN+1
 Q
 ;
SETOLD ;
 S OLDKEY=$P(RECDA,ECXD,1,3)
 S OLDFKEY=$P(RECDA,ECXD)
 S OLDDIV=$P(RECDA,ECXD,2)
 S OLDCLIN=$P(RECDA,ECXD,3)
 S OLDSSN=$P(RECDA,ECXD,4)
 Q
 ;
SETKEY ;
 N CLIN,DIV,FKEY,DFN,SSN,VDATE
 S CLIN=$P(^ECX(727.827,RECDA,0),U,12)
 S DIV=$P(^ECX(727.827,RECDA,2),U,8)
 S FKEY=$P(^ECX(727.827,RECDA,0),U,10)
 S DFN=$P(^ECX(727.827,RECDA,0),U,5)
 S SSN=$P(^ECX(727.827,RECDA,0),U,6)
 S VDATE=$P(^ECX(727.827,RECDA,0),U,9)_"."_$P(^ECX(727.827,RECDA,0),U,14)
 S KEY=FKEY_ECXD_DIV_ECXD_CLIN_ECXD_SSN_ECXD_DFN_ECXD_VDATE
 S ^TMP($J,"AKEY",KEY)=""
 Q
 ;
DETAIL ; print detail line
 N DFN,PTNAME,DISPDT,DISPTM
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S COUNT=COUNT+1
 ;S QFLG=0
 I $Y+3>IOSL D HEADER Q:QFLG
 ; get patient name using DFN
 S DFN=$P(RECDA,ECXD,5)
 S PTNAME=$S(DFN'="":$P(^DPT(DFN,0),U),1:"")
 S DISPDT=$P(RECDA,ECXD,6)
 S DISPTM=$E(DISPDT,9,14)
 S DISPDT=$E(DISPDT,1,4)-1700_$E(DISPDT,5,8)
 S DISPDT=DISPDT_DISPTM
 W !,PTNAME,?36,$P(RECDA,ECXD,4),?51,$$FMTE^XLFDT(DISPDT,1)
 Q
 ;
CLINTOT ;
 S COUNT=COUNT+2
 I $Y+3>IOSL D HEADER Q:QFLG
 W !!,?5,"Total Unique SSNs for Clinic:"
 W ?35,$J(CSSN,10),?50,$J(CVISIT,10),?61,"Clinic Visits"
 S (CSSN,CVISIT)=0 S OLDCLIN=$P(RECDA,ECXD,3) K ^TMP($J,"C")
 Q
 ;
DIVTOT ;
 S COUNT=COUNT+1
 I $Y+3>IOSL D HEADER Q:QFLG
 W !,?3,"Total Unique SSNs for Division:"
 W ?35,$J(DSSN,10),?50,$J(DVISIT,10),?61,"Division Visits"
 S (DSSN,DVISIT)=0 S OLDDIV=$P(RECDA,ECXD,2) K ^TMP($J,"D")
 Q
 ;
FKEYTOT ;
 S COUNT=COUNT+1
 I $Y+3>IOSL D HEADER Q:QFLG
 W !,?1,"Total Unique SSNs for Feeder Key:"
 W ?35,$J(FSSN,10),?50,$J(FVISIT,10),?61,"Feeder Key Visits"
 S (FSSN,FVISIT)=0 S OLDFKEY=$P(RECDA,ECXD) K ^TMP($J,"F")
 Q
 ;
GTOTAL ;
 S COUNT=COUNT+1
 I $Y+3>IOSL D HEADER Q:QFLG
 W !,"Total Unique SSNs (entire report):"
 W ?35,$J(TSSN,10),?50,$J(TVISIT,10),?61,"Total Visits"
 Q
 ;
CLOSE ;
 I $E(IOST)="C",'QFLG D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 Q
 ;
HEADER ;header and page control
 D HEADER1 Q:QFLG
 D HEADER2 Q:QFLG
 Q
HEADER1 ;header1 and page control
 N SS,JJ
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,"CBOC Activity Report"
 W ?(73-$L(PG)),"Page: "_PG
 W !,ECSTART,?50,"Report Run Date: "_ECRUN
 Q
 ;
HEADER2 ;display whenever feeder key, division, or clinic changes
 I $Y+8>IOSL D HEADER1 Q:QFLG
 N CLINIC
 S CLINIC=$$GET1^DIQ(44,$P($P(HEADKEY,ECXD,3),U),.01,)
 W !!,"Feeder Key: ",$P(HEADKEY,ECXD)
 W ?31,"Division: ",$P(HEADKEY,ECXD,2)
 W ?51,"Clinic: ",$E(CLINIC,1,20)
 W !!,"Patient",?39,"SSN",?51,"Visit Date/Time"
 W !,LN
 Q
