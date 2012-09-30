DVBAB54 ;ALB/VM - CAPRI ADMISSION REPORT ; 3/5/12 11:31am
 ;;2.7;AMIE;**35,149,179**;Apr 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Input: ZMSG  - Output Array for SC Veteran Admission report (By Ref)
 ;       BDATE     - Beginning date for eport (FM Format)
 ;       EDATE     - Ending date for report (FM Format)
 ;       DVBADLMTR - Indicates if report should be delimited (Optional)
 ;                    CAPRI currently executes RPC by each day in 
 ;                    date range, so DVBADLMTR should equal the
 ;                    final EDATE in range so that XTMP global
 ;                    can be killed.
 ;Output: ^TMP("DVBAR",$J) contains delimited/non-delimited SC Veteran Admission report 
STRT(ZMSG,BDATE,EDATE,DVBADLMTR)  ;ENTER HERE
 N DVBAFNLDTE,MA1
 S DVBABCNT=0,RO="N",RONUM=0
 S DVBAFNLDTE=$S(+$G(DVBADLMTR):+$P(DVBADLMTR,"."),1:0)
 S DVBADLMTR=$S('+$G(DVBADLMTR):"",1:"^")
 K ^TMP($J) G TERM
SET Q:'$D(^DPT(DA,0))  S DFN=DA,DVBASC="" D SC^DVBAVDPT Q:DVBASC'="Y"  Q:CFLOC'=RONUM&(RO="Y")&(CFLOC'=0)&(CFLOC'=376)  S MA1=$P(MA,".",1),^TMP($J,MA1,XCN,CFLOC,MB,DA)=MA
 Q
 ;
PRINTB S ADMDT=$P(DATA,U),DFN=DA D ADM^DVBAVDPT
 ;W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 ;W !!!,?(80-$L(HEAD)\2),HEAD,!,?(80-$L(HEAD1)\2),HEAD1,!!
 S:ADMDT]"" ADMDT=$E(ADMDT,4,5)_"/"_$E(ADMDT,6,7)_"/"_$E(ADMDT,2,3) S:DCHGDT]"" DCHGDT=$E(DCHGDT,4,5)_"/"_$E(DCHGDT,6,7)_"/"_$E(DCHGDT,2,3)
 ;create delimited/non-delimited report
 D:($G(DVBADLMTR)'="") PRINTD
 D:($G(DVBADLMTR)="") PRINTND
 S DVBAON2=""
 Q
 ;
PRINTND ;create non-delimited admission report
 S ^TMP("DVBAR",$J,DVBABCNT)="",DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="",DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="          Patient Name:   "_PNAM,DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="              Claim No:   "_CNUM,DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="      Claim Folder Loc:   "_CFLOC,DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="         Social Sec No:   "_SSN,DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="        Admission Date:   "_ADMDT,DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="   Admitting Diagnosis:   "_DIAG,DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="        Discharge Date:   "_DCHGDT,DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="           Bed Service:   "_BEDSEC,DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="             Recv A&A?:   "_$S(RCVAA=0:"NO",RCVAA=1:"YES",1:"Not specified"),DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="              Pension?:   "_$S(RCVPEN=0:"NO",RCVPEN=1:"YES",1:"Not specified"),DVBABCNT=DVBABCNT+1
 ;D ELIG^DVBAVDPT
ELIG S ELIG=DVBAELIG,INCMP=""
 I ELIG]"" S ELIG=ELIG_" ("_$S(DVBAELST="P":"Pend Ver",DVBAELST="R":"Pend Re-verif",DVBAELST="V":"Verified",1:"Not Verified")_")"
 I $D(^DPT(DA,.29)) S INCMP=$S($P(^(.29),U,12)=1:"Incompetent",1:"")
 S ^TMP("DVBAR",$J,DVBABCNT)="      Eligibility data:   "_ELIG_$S(((ELIG]"")&(INCMP]"")):", ",1:""),DVBABCNT=DVBABCNT+1
 I $X>60 S ^TMP("DVBAR",$J,DVBABCNT)=INCMP,DVBABCNT=DVBABCNT+1
 ;Q
 ;***VM-OUT*I IOST?1"C-".E W *7,!,"Press RETURN to continue or ""^"" to stop    " R ANS:DTIME S:ANS=U!('$T) QUIT=1 I '$T S DVBAQUIT=1
 Q
 ;
PRINTD ;create delimited admission report
 N ELIG,INCMP
 D:('$D(^XTMP("DVBA_SCADMSSN_RPT"_$J,0))) COLHDR
 S ^TMP("DVBAR",$J,DVBABCNT)=PNAM_DVBADLMTR_CNUM_DVBADLMTR_CFLOC_DVBADLMTR_SSN_DVBADLMTR_ADMDT_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=^TMP("DVBAR",$J,DVBABCNT)_DIAG_DVBADLMTR_DCHGDT_DVBADLMTR_BEDSEC_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=^TMP("DVBAR",$J,DVBABCNT)_$S(RCVAA=0:"NO",RCVAA=1:"YES",1:"Not specified")_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=^TMP("DVBAR",$J,DVBABCNT)_$S(RCVPEN=0:"NO",RCVPEN=1:"YES",1:"Not specified")_DVBADLMTR
 S ELIG=DVBAELIG,INCMP=""
 I ELIG]"" S ELIG=ELIG_" ("_$S(DVBAELST="P":"Pend Ver",DVBAELST="R":"Pend Re-verif",DVBAELST="V":"Verified",1:"Not Verified")_")"
 I $D(^DPT(DA,.29)) S INCMP=$S($P(^(.29),U,12)=1:"Incompetent",1:"")
 S ^TMP("DVBAR",$J,DVBABCNT)=^TMP("DVBAR",$J,DVBABCNT)_ELIG_$S(((ELIG]"")&(INCMP]"")):", ",1:"")_INCMP
 S DVBABCNT=DVBABCNT+1
 Q
 ;
PRINT K MA S QUIT=""
 S MA="" F G=0:0 S MA=$O(^TMP($J,MA)) Q:MA=""!(QUIT=1)  S XCN="" F M=0:0 S XCN=$O(^TMP($J,MA,XCN)) Q:XCN=""!(QUIT=1)  S CFLOC="" F J=0:0 S CFLOC=$O(^TMP($J,MA,XCN,CFLOC)) Q:CFLOC=""!(QUIT=1)  D PRINT1
 Q
PRINT1 S ADM="" F K=0:0 S ADM=$O(^TMP($J,MA,XCN,CFLOC,ADM)) Q:ADM=""!(QUIT=1)  S DA="" F L=0:0 S DA=$O(^TMP($J,MA,XCN,CFLOC,ADM,DA)) Q:DA=""!(QUIT=1)  S DATA=^(DA) D PRINTB
 Q
 ;
TERM ;D HOME^%ZIS K NOASK
 ;
 ;W @IOF,!,"VARO SERVICE-CONNECTED ADMISSION REPORT" D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) KILL^DVBAUTIL
 S DTAR=^DVB(396.1,1,0),FDT(0)=$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3)
 S HEAD="SERVICE-CONNECTED ADMISSION REPORT",HEAD1="FOR "_$P(DTAR,U,1)_" ON "_FDT(0)
 ;W !,HEAD1
 ;W !!,"Please enter dates for search, oldest date first, most recent date last.",!!,"Last report was run on " S Y=$P(DTAR,U,8) X ^DD("DD") W Y,!!
 ;D DATE^DVBAUTIL
 ;G:X=""!(Y<0) KILL
 ;S %ZIS="Q" D ^%ZIS K %ZIS G:POP KILL^DVBAUTIL
 ;
 ;I $D(IO("Q")) S ZTRTN="DEQUE^DVBASCRP",ZTIO=ION,NOASK=1,ZTDESC="AMIE SC ADMISSION REPORT" F I="FDT(0)","HEAD","HEAD1","BDATE","EDATE","TYPE","RO","RONUM","NOASK" S ZTSAVE(I)=""
 ;I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",!! G KILL
 ;
GO S MA=BDATE F J=0:0 S MA=$O(^DGPM("AMV1",MA)) Q:$P(MA,".")>EDATE!(MA="")  F DA=0:0 S DA=$O(^DGPM("AMV1",MA,DA)) Q:DA=""  F MB=0:0 S MB=$O(^DGPM("AMV1",MA,DA,MB)) Q:MB=""  D SET W:'$D(NOASK) "."
 I '$D(^TMP($J)) S ^TMP("DVBAR",$J,DVBABCNT)="No data found for parameters entered." H 2 G KILL
 D PRINT K:(DVBAFNLDTE=$P(EDATE,".")) ^XTMP("DVBA_SCADMSSN_RPT"_$J,0)
 I $D(DVBAQUIT) K DVBAON2 D:$D(ZTQUEUED) KILL^%ZTLOAD G KILL^DVBAUTIL
 ;
KILL K:(DVBAFNLDTE=$P(EDATE,".")) ^XTMP("DVBA_SCADMSSN_RPT"_$J,0)
 S ZMSG=$NA(^TMP("DVBAR",$J))
 D:$D(ZTQUEUED) KILL^%ZTLOAD D ^%ZISC S X=8 K DVBAON2 G FINAL^DVBAUTIL
 ;
DEQUE K ^TMP($J) G GO
 ;
COLHDR ;Column header for delimited report
 S ^TMP("DVBAR",$J,DVBABCNT)="Patient Name"_DVBADLMTR_"Claim No"_DVBADLMTR_"Claim Folder Loc"_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=(^TMP("DVBAR",$J,DVBABCNT))_"Social Sec No"_DVBADLMTR_"Admission Date"_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=(^TMP("DVBAR",$J,DVBABCNT))_"Admitting Diagnosis"_DVBADLMTR_"Discharge Date"_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=(^TMP("DVBAR",$J,DVBABCNT))_"Bed Service"_DVBADLMTR_"Recv A&A?"_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=(^TMP("DVBAR",$J,DVBABCNT))_"Pension?"_DVBADLMTR_"Eligibility Data"
 S DVBABCNT=DVBABCNT+1
 ;set global entry so header is only created once for job ($J)
 S ^XTMP("DVBA_SCADMSSN_RPT"_$J,0)=DT_U_DT
 Q
