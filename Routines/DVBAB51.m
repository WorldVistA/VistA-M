DVBAB51 ;ALB/VM - CAPRI INCOMPETENT PATIENT REPORT ;09/01/00
 ;;2.7;AMIE;**35,149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Input: ZMSG      - Output Array for incompetent report (By Ref)
 ;       BDATE     - Beginning date for report (FM Format)
 ;       EDATE     - Ending date for report (FM Format)
 ;       DVBADLMTR - Indicates if report should be delimitted (Optional)
 ;                    CAPRI currently executes RPC by each day in 
 ;                    date range, so DVBADLMTR should equal the
 ;                    final EDATE in range so that XTMP global
 ;                    can be killed. 
 ;Output: ZMSG contains delimited/non-delimited incompetent report 
STRT(ZMSG,BDATE,EDATE,DVBADLMTR) ;ENTER HERE
 N DVBAFNLDTE
 S DVBABCNT=0,RO="N",RONUM=0
 S DVBAFNLDTE=$S(+$G(DVBADLMTR):+$P(DVBADLMTR,"."),1:0)
 S DVBADLMTR=$S('+$G(DVBADLMTR):"",1:"^")
 K ^TMP($J) G TERM
SET Q:'$D(^DPT(DA,.29))  S ICDAT=^(.29) Q:$P(ICDAT,U,12)'=1&(ICDAT']"")  S INCMP="" S:$P(ICDAT,U)]""!($P(ICDAT,U,12)=1) INCMP=1 Q:INCMP'=1  S ICDAT2=$P(ICDAT,U,2),ICDAT=$P(ICDAT,U)
 S:ICDAT]"" ICDAT=$$FMTE^XLFDT(ICDAT,"5DZ")
 S:ICDAT2]"" ICDAT2=$$FMTE^XLFDT(ICDAT2,"5DZ")
 Q:'$D(^DPT(DA,0))  S DFN=DA D RCV^DVBAVDPT Q:CFLOC'=RONUM&(RO="Y")&(CFLOC'=0)&(CFLOC'=376)
 S ^TMP($J,XCN,CFLOC,MB,DA)=MA_U_RCVAA_U_RCVPEN_U_CNUM_U_ICDAT_U_ICDAT2_U_INCMP
 Q
 ;
PRINTB S MA=$P(DATA,U),RCVAA=$P(DATA,U,2),RCVPEN=$P(DATA,U,3),CNUM=$P(DATA,U,4),ICDAT=$P(DATA,U,5),ICDAT2=$P(DATA,U,6),INCMP=$P(DATA,U,7),DFN=DA,QUIT1=1 D ADM^DVBAVDPT
 S ADMDT=$$FMTE^XLFDT(ADMDT,"5DZ")
 S DCHGDT=$$FMTE^XLFDT(DCHGDT,"5DZ")
 S LADM=ADM,TDIS="UNKNOWN",TO="",DCHPTR=$P(^DGPM(LADM,0),U,17),TDIS=$S($D(^DGPM(+DCHPTR,0)):$P(^(0),U,18),1:"") I TDIS="" S TDIS="Unknown discharge type"
 S:'$D(^DG(405.2,+TDIS,0)) TDIS="Unknown discharge type" I $D(^(0)) S TDIS=$S($P(^DG(405.2,+TDIS,0),U,1)]"":$P(^(0),U,1),1:"Unknown discharge type")
 S:(IOST?1"C-".E)!($D(DVBAON2)) ZMSG(DVBABCNT)=" ",DVBABCNT=DVBABCNT+1
 ;***vm-out*W !!!,?(80-$L(HEAD)\2),HEAD,!,?(80-$L(HEAD1)\2),HEAD1,!!
 ;create delimited/non-delimited report
 D:($G(DVBADLMTR)'="") PRINTD
 D:($G(DVBADLMTR)="") PRINTND
 S DVBAON2=""
 Q
 ;
PRINTND ;create non-delimited incompetent report
 S ZMSG(DVBABCNT)="  Patient Name:    "_PNAM,DVBABCNT=DVBABCNT+1,ZMSG(DVBABCNT)=" ",DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="           Claim No:   "_CNUM,DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="   Claim Folder Loc:   "_CFLOC,DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="      Social Sec No:   "_SSN,DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="     Admission Date:   "_ADMDT,DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="Admitting Diagnosis:   "_DIAG,DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="     Discharge Date:   "_DCHGDT,DVBABCNT=DVBABCNT+1
 I DCHGDT]"" S ZMSG(DVBABCNT)="  Type of Discharge:   "_TDIS_$S(TO]"":" TO "_$S($D(^DIC(4,+TO,0)):$P(^(0),U,1),1:""),1:""),DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="        Bed Service:   "_BEDSEC,DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="          Recv A&A?:   "_$S(RCVAA=0:"NO",RCVAA=1:"YES",1:"Not specified"),DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="           Pension?:   "_$S(RCVPEN=0:"NO",RCVPEN=1:"YES",1:"Not specified"),DVBABCNT=DVBABCNT+1
 ;***vm-out*D ELIG^DVBAVDPT
ELIG S ELIG=DVBAELIG,INCMP=""
 S ZMSG(DVBABCNT)="   Eligibility data:   "
 I ELIG]"" S ELIG=ELIG_" ("_$S(DVBAELST="P":"Pend Ver",DVBAELST="R":"Pend Re-verif",DVBAELST="V":"Verified",1:"Not Verified")_")"
 I $D(^DPT(DA,.29)) S INCMP=$S($P(^(.29),U,12)=1:"Incompetent",1:"")
 S ZMSG(DVBABCNT)=ZMSG(DVBABCNT)_ELIG_$S(((ELIG]"")&(INCMP]"")):", ",1:"")_INCMP,DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="  DATE RULED INCOMP:   "_$S($D(ICDAT)]"":ICDAT_" (VA)",1:"")_$S(ICDAT2]"":" - "_ICDAT2_" (CIVIL)",1:" "),DVBABCNT=DVBABCNT+1
 ;***vm-out*I IOST?1"C-".E W *7,!,"Press RETURN to continue or ""^"" to stop    " R ANS:DTIME S:ANS=U!('$T) QUIT=1 I '$T S DVBAQUIT=1
 Q
 ;
PRINTD ;create delimited incompetent report
 D:('$D(^XTMP("DVBA_INCOMPETENT_RPT"_$J,0))) COLHDR
 S ZMSG(DVBABCNT)=PNAM_DVBADLMTR_CNUM_DVBADLMTR_CFLOC_DVBADLMTR_SSN_DVBADLMTR_ADMDT_DVBADLMTR_DIAG_DVBADLMTR_DCHGDT_DVBADLMTR
 S ZMSG(DVBABCNT)=ZMSG(DVBABCNT)_$S((DCHGDT]""):TDIS_$S(TO]"":" TO "_$S($D(^DIC(4,+TO,0)):$P(^(0),U,1),1:""),1:""),1:"")_DVBADLMTR
 S ZMSG(DVBABCNT)=ZMSG(DVBABCNT)_BEDSEC_DVBADLMTR_""_$S(RCVAA=0:"NO",RCVAA=1:"YES",1:"Not specified")_DVBADLMTR
 S ZMSG(DVBABCNT)=ZMSG(DVBABCNT)_$S(RCVPEN=0:"NO",RCVPEN=1:"YES",1:"Not specified")_DVBADLMTR
 ;
 S ELIG=DVBAELIG,INCMP=""
 I ELIG]"" S ELIG=ELIG_" ("_$S(DVBAELST="P":"Pend Ver",DVBAELST="R":"Pend Re-verif",DVBAELST="V":"Verified",1:"Not Verified")_")"
 I $D(^DPT(DA,.29)) S INCMP=$S($P(^(.29),U,12)=1:"Incompetent",1:"")
 ;
 S ZMSG(DVBABCNT)=ZMSG(DVBABCNT)_ELIG_$S(ELIG]"":", ",1:"")_INCMP_DVBADLMTR_$S($D(ICDAT)]"":ICDAT_" (VA)",1:"")_$S(ICDAT2]"":" - "_ICDAT2_" (CIVIL)",1:"")
 S DVBABCNT=DVBABCNT+1
 Q
 ;
PRINT U IO S QUIT=""
 S XCN="" F M=0:0 S XCN=$O(^TMP($J,XCN)) Q:XCN=""!(QUIT=1)  S CFLOC="" F J=0:0 S CFLOC=$O(^TMP($J,XCN,CFLOC)) Q:CFLOC=""!(QUIT=1)  D PRINT1
 Q
PRINT1 S ADM="" F K=0:0 S ADM=$O(^TMP($J,XCN,CFLOC,ADM)) Q:ADM=""!(QUIT=1)  S DA="" F L=0:0 S DA=$O(^TMP($J,XCN,CFLOC,ADM,DA)) Q:DA=""!(QUIT=1)  S DATA=^(DA) D PRINTB
 Q
 ;
TERM ;D HOME^%ZIS K NOASK
 K NOASK
 ;
SETUP ;W @IOF,!,"VARO INCOMPETENCY REPORT" D NOPARM^DVBAUTL2 
NOPARM  ;check for AMIE parameter setup
 I '$D(^DVB(396.1,1,0)) S ZMSG(DVBABCNT)="No site parameters have been set up in file 396.1.",DVBABCNT=DVBABCNT+1,ZMSG(DVBABCNT)="You must do this before running any reports." S DVBAQUIT=1 H 3
 G:$D(DVBAQUIT) KILL^DVBAUTIL S DTAR=^DVB(396.1,1,0),FDT(0)=$$FMTE^XLFDT(DT,"5DZ")
 S HEAD="INCOMPETENCY REPORT",HEAD1="FOR "_$P(DTAR,U,1)_" ON "_FDT(0)
 ;***vm-out*W !,HEAD1
EN1 ;***vm-out*W !!,"Please enter dates for search, oldest date first, most recent date last.",!!,"Last report was run on " S Y=$P(DTAR,U,5) X ^DD("DD") W Y,!!
 ;***vm-out*D DATE^DVBAUTIL G:X=""!(Y<0) KILL
 S %ZIS="Q" D ^%ZIS K %ZIS G:POP KILL^DVBAUTIL
 ;
QUEUE ;***vm-out*I $D(IO("Q")) S ZTRTN="DEQUE^DVBACMRP",ZTIO=ION,NOASK=1,ZTDESC="AMIE INCOMPETENT VET REPORT" F I="FDT(0)","HEAD","HEAD1","BDATE","EDATE","TYPE","RO","RONUM","NOASK" S ZTSAVE(I)=""
 ;***vm-out*I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",!! G KILL
 ;
GO S MA=BDATE F J=0:0 S MA=$O(^DGPM("AMV1",MA)) Q:$P(MA,".")>EDATE!(MA="")  F DA=0:0 S DA=$O(^DGPM("AMV1",MA,DA)) Q:DA=""  F MB=0:0 S MB=$O(^DGPM("AMV1",MA,DA,MB)) Q:MB=""  D SET I '$D(NOASK) W "."
 I '$D(^TMP($J)) S ZMSG(DVBABCNT)="No data found for parameters entered." H 2 G KILL
 I $D(^TMP($J)) D PRINT K:(DVBAFNLDTE=$P(EDATE,".")) ^XTMP("DVBA_INCOMPETENT_RPT"_$J,0) I $D(DVBAQUIT) K DVBAON2 G KILL^DVBAUTIL
 ;
KILL K:(DVBAFNLDTE=$P(EDATE,".")) ^XTMP("DVBA_INCOMPETENT_RPT"_$J,0)
 D ^%ZISC S X=5 K DVBAON2 D:$D(ZTQUEUED) KILL^%ZTLOAD G FINAL^DVBAUTIL
 ;
DEQUE K ^TMP($J) G GO
 ;
COLHDR ;Column header for delimited report
 S ZMSG(DVBABCNT)="Patient Name"_DVBADLMTR_"Claim No"_DVBADLMTR_"Claim Folder Loc"_DVBADLMTR
 S ZMSG(DVBABCNT)=(ZMSG(DVBABCNT))_"Social Sec No"_DVBADLMTR_"Admission Date"_DVBADLMTR
 S ZMSG(DVBABCNT)=(ZMSG(DVBABCNT))_"Admitting Diagnosis"_DVBADLMTR_"Discharge Date"_DVBADLMTR
 S ZMSG(DVBABCNT)=(ZMSG(DVBABCNT))_"Type of Discharge"_DVBADLMTR_"Bed Service"_DVBADLMTR
 S ZMSG(DVBABCNT)=(ZMSG(DVBABCNT))_"Recv A&A?"_DVBADLMTR_"Pension?"_DVBADLMTR
 S ZMSG(DVBABCNT)=(ZMSG(DVBABCNT))_"Eligibility Data"_DVBADLMTR_"Date Ruled Incomp"
 S DVBABCNT=DVBABCNT+1
 S ^XTMP("DVBA_INCOMPETENT_RPT"_$J,0)=DT_U_DT
 Q
