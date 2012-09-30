DVBAB53 ;ALB/SPH - CAPRI DISCHARGE REPORT ; 3/5/12 11:30am
 ;;2.7;AMIE;**35,99,100,149,179**;Apr 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Input: ZMSG      - Output Array for discharge report (By Ref)
 ;       BDATE     - Beginning date for eport (FM Format)
 ;       EDATE     - Ending date for report (FM Format)
 ;       ADTYPE    - Valid discharge code values include:
 ;                       A : Recieving A&A
 ;                       P : Pension
 ;                       S : Service Connected
 ;                       L : All discharge types
 ;       DVBADLMTR - Indicates if report should be delimitted (Optional)
 ;                    CAPRI currently executes RPC by each day in
 ;                    date range, so DVBADLMTR should equal the
 ;                    final EDATE in range so that XTMP global
 ;                    can be killed.
 ;Output: ^TMP("DVBAR",$J) contains delimited/non-delimited discharge report
STRT(ZMSG,BDATE,EDATE,ADTYPE,DVBADLMTR)    ;
 N DVBAFNLDTE,MA1
 I BDATE'["." S BDATE=BDATE-.0001   ; DVBA*2.7*99
 S DVBABCNT=0
 S RONUM=0
 S RO="N"
 S HEAD="",HEAD1=""
 S DVBAFNLDTE=$S(+$G(DVBADLMTR):+$P(DVBADLMTR,"."),1:0)
 S DVBADLMTR=$S('+$G(DVBADLMTR):"",1:"^")
 K ^TMP($J) G TERM
 ;
SET Q:'$D(^DPT(DA,0))  S DFN=DA,DVBASC="" D RCV^DVBAVDPT Q:CFLOC'=RONUM&(RO="Y")&(CFLOC'=0)&(CFLOC'=376)  Q:ADTYPE="S"&(DVBASC'="Y")  Q:ADTYPE="A"&(RCVAA'=1)  Q:ADTYPE="P"&(RCVPEN'="1")
 S TDIS=$S($D(^DGPM(+MB,0)):$P(^(0),U,18),1:"")
 I $D(^DG(405.2,+TDIS,0)) DO
 . ; I '$D(^TMP("DVBA",$J,"DUP",+TDIS)) Q   ; DVBA*2.7*99 commented out
 .I '$D(DISTYPE(+TDIS)) Q
 .S TDIS=$S($P(^DG(405.2,+TDIS,0),U,1)]"":$P(^(0),U,1),1:"Unknown discharge type")
 .S MA1=$P(MA,".",1)
 .S ^TMP($J,MA1,XCN,CFLOC,MB,DA)=RCVAA_U_RCVPEN_U_CNUM_U_TDIS
 .Q
 Q
 ;
PRINTB S RCVAA=$P(DATA,U),RCVPEN=$P(DATA,U,2),CNUM=$P(DATA,U,3),TDIS=$P(DATA,U,4),DFN=DA,QUIT1=1 D DCHGDT^DVBAVDPT
 W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 W !!!,?(80-$L(HEAD)\2),HEAD,!,?(80-$L(HEAD1)\2),HEAD1,!!
 ;create delimited/non-delimited report
 D:($G(DVBADLMTR)'="") PRINTD
 D:($G(DVBADLMTR)="") PRINTND
 Q
 ;
PRINTND ;create non-delimited discharge report
 S ^TMP("DVBAR",$J,DVBABCNT)="",DVBABCNT=DVBABCNT+1
 ;
 S ^TMP("DVBAR",$J,DVBABCNT)="          Patient Name:    "_PNAM  S DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="              Claim No:    "_CNUM  S DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="      Claim Folder Loc:    "_CFLOC  S DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="         Social Sec No:    "_SSN  S DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="        Discharge Date:    "_$$FMTE^XLFDT(DCHGDT,"5DZ"),DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="     Type of Discharge:    "_TDIS,DVBABCNT=DVBABCNT+1
 D LOS^DVBAUTIL
 S ^TMP("DVBAR",$J,DVBABCNT)="        Length of Stay:    "_LOS_$S(LOS="":"Discharged same day",LOS=1:" day",1:" days"),DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="           Bed Service:    "_BEDSEC,DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="             Recv A&A?:    "_$S(RCVAA="0":"NO",RCVAA="1":"YES",1:"Not specified"),DVBABCNT=DVBABCNT+1
 S ^TMP("DVBAR",$J,DVBABCNT)="              Pension?:    "_$S(RCVPEN="0":"NO",RCVPEN="1":"YES",1:"Not specified"),DVBABCNT=DVBABCNT+1
 ;
 ;
 ; ELIG INFO...
 S ELIG=DVBAELIG,INCMP=""
 ;S ZMSG(DVBABCNT)="      Eligibility data:    "
 I ELIG]"" S ELIG=ELIG_" ("_$S(DVBAELST="P":"Pend Ver",DVBAELST="R":"Pend Re-verif",DVBAELST="V":"Verified",1:"Not Verified")_")"
 I $D(^DPT(DA,.29)) S INCMP=$S($P(^(.29),U,12)=1:"Incompetent",1:"")
 S ^TMP("DVBAR",$J,DVBABCNT)="      Eligibility data:    "_ELIG_$S(((ELIG]"")&(INCMP]"")):", ",1:"")  S DVBABCNT=DVBABCNT+1
 W:$X>60 !?26 S ^TMP("DVBAR",$J,DVBABCNT)=INCMP  S DVBABCNT=DVBABCNT+1
 Q
 ;END OF ELIG INFO
 ;
 ;I IOST?1"C-".E W *7,!,"Press RETURN to continue or ""^"" to stop    " R ANS:DTIME S:ANS=U!('$T) QUIT=1 I ANS=U S DVBAQUIT=1
 S DVBAON2=""
 Q
 ;
PRINTD ;create delimited discharge report
 N ELIG,INCMP
 D:('$D(^XTMP("DVBA_DISCHARGE_RPT"_$J,0))) COLHDR
 S ^TMP("DVBAR",$J,DVBABCNT)=PNAM_DVBADLMTR_CNUM_DVBADLMTR_CFLOC_DVBADLMTR_SSN_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=^TMP("DVBAR",$J,DVBABCNT)_$$FMTE^XLFDT(DCHGDT,"5DZ")_DVBADLMTR_TDIS_DVBADLMTR
 D LOS^DVBAUTIL
 S ^TMP("DVBAR",$J,DVBABCNT)=^TMP("DVBAR",$J,DVBABCNT)_LOS_$S(LOS="":"Discharged same day",LOS=1:" day",1:" days")_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=^TMP("DVBAR",$J,DVBABCNT)_BEDSEC_DVBADLMTR_$S(RCVAA="0":"NO",RCVAA="1":"YES",1:"Not specified")_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=^TMP("DVBAR",$J,DVBABCNT)_$S(RCVPEN="0":"NO",RCVPEN="1":"YES",1:"Not specified")_DVBADLMTR
 ;
 S ELIG=DVBAELIG,INCMP=""
 I ELIG]"" S ELIG=ELIG_" ("_$S(DVBAELST="P":"Pend Ver",DVBAELST="R":"Pend Re-verif",DVBAELST="V":"Verified",1:"Not Verified")_")"
 I $D(^DPT(DA,.29)) S INCMP=$S($P(^(.29),U,12)=1:"Incompetent",1:"")
 ;
 S ^TMP("DVBAR",$J,DVBABCNT)=^TMP("DVBAR",$J,DVBABCNT)_ELIG_$S(((ELIG]"")&(INCMP]"")):", ",1:"")_INCMP
 S DVBABCNT=DVBABCNT+1
 Q
 ;
PRINT U IO S QUIT=""
 S MA="" F G=0:0 S MA=$O(^TMP($J,MA)) Q:MA=""!(QUIT=1)  S XCN="" F M=0:0 S XCN=$O(^TMP($J,MA,XCN)) Q:XCN=""!(QUIT=1)  S CFLOC="" F J=0:0 S CFLOC=$O(^TMP($J,MA,XCN,CFLOC)) Q:CFLOC=""!(QUIT=1)  D PRINT1
 Q
PRINT1 S ADM="" F K=0:0 S ADM=$O(^TMP($J,MA,XCN,CFLOC,ADM)) Q:ADM=""!(QUIT=1)  S DA="" F L=0:0 S DA=$O(^TMP($J,MA,XCN,CFLOC,ADM,DA)) Q:DA=""!(QUIT=1)  S DATA=^(DA) D PRINTB
 Q
 ;
TERM ;D HOME^%ZIS K NOASK
 ;
SETUP ;W @IOF,!,"VARO DISCHARGE REPORT" D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) KILL^DVBAUTIL S DTAR=^DVB(396.1,1,0),FDT(0)=$$FMTE^XLFDT(DT,"5DZ")
 S DSRP=1
 ;S HEAD1="FOR "_$P(DTAR,U,1)_" ON "_FDT(0) W !,HEAD1
 ;
EN1 ;W !!,"Please enter dates for search, oldest date first, most recent date last.",!!,"Last report was run on " S Y=$P(DTAR,U,4) X ^DD("DD") W Y,!!
 ;D DATE^DVBAUTIL
 ;G:X=""!(Y<0) KILL
 ;
ADTYPE ;D ADTYPE^DVBAUTL2 G:$D(DVBAQUIT) KILL^DVBAUTIL
 ;W @IOF
 ;K DVBACEPT
 D EN^DVBAB99("DVBA DISCHARGE TYPES")
 D ACCEPT^DVBALD
 I '$D(DVBACEPT) D KILL^DVBAUTIL Q
 I '$O(^TMP("DVBA",$J,"DUP",0)) D KILL^DVBAUTIL Q
 M DISTYPE=^TMP("DVBA",$J,"DUP")
 ;
 ; DVBA*2.7*100 - commented out next line
 ; W !!! S %ZIS="Q" D ^%ZIS K %ZIS G:POP KILL^DVBAUTIL
 ;
QUEUE I $D(IO("Q")) S ZTRTN="DEQUE^DVBADSRT",ZTIO=ION,NOASK=1,ZTDESC="AMIE DISCHARGE REPORT" F I="DISTYPE(","ADTYPE","DVBATYPS","BDATE","BDATE1","EDATE","FDT(0)","HEAD","HEAD1","HD","RO","RONUM","NOASK" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",! G KILL
 ;
GO S MA=BDATE F J=0:0 S MA=$O(^DGPM("AMV3",MA)) Q:MA>EDATE!(MA="")  W:'$D(NOASK) "." F DA=0:0 S DA=$O(^DGPM("AMV3",MA,DA)) Q:DA=""  F MB=0:0 S MB=$O(^DGPM("AMV3",MA,DA,MB)) Q:MB=""  D SET
 I '$D(^TMP($J)) D  H 2 G KILL
 .N DVBAERTXT S DVBAERTXT="No data found for parameters entered."
 .U IO W !!,*7,DVBAERTXT,!!
 .S:($G(DVBADLMTR)'="") ^TMP("DVBAR",$J,DVBABCNT)=DVBAERTXT
 D PRINT K:(DVBAFNLDTE=$P(EDATE,".")) ^XTMP("DVBA_DISCHARGE_RPT"_$J,0)
 I $D(DVBAQUIT) K DVBAON2,DISTYPE G KILL^DVBAUTIL
 ;
KILL K:(DVBAFNLDTE=$P(EDATE,".")) ^XTMP("DVBA_DISCHARGE_RPT"_$J,0)
 S ZMSG=$NA(^TMP("DVBAR",$J))
 D ^%ZISC D:$D(ZTQUEUED) KILL^%ZTLOAD S X=4 K DVBAON2,DISTYPE G FINAL^DVBAUTIL
 ;
DEQUE K ^TMP($J) G GO
 ;
COLHDR ;Column header for delimited report
 S ^TMP("DVBAR",$J,DVBABCNT)="Patient Name"_DVBADLMTR_"Claim No"_DVBADLMTR_"Claim Folder Loc"_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=(^TMP("DVBAR",$J,DVBABCNT))_"Social Sec No"_DVBADLMTR_"Discharge Date"_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=(^TMP("DVBAR",$J,DVBABCNT))_"Type of Discharge"_DVBADLMTR_"Length of Stay"_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=(^TMP("DVBAR",$J,DVBABCNT))_"Bed Service"_DVBADLMTR_"Recv A&A?"_DVBADLMTR
 S ^TMP("DVBAR",$J,DVBABCNT)=(^TMP("DVBAR",$J,DVBABCNT))_"Pension?"_DVBADLMTR_"Eligibility Data"
 S DVBABCNT=DVBABCNT+1
 ;set global entry so header is only created once for job ($J)
 S ^XTMP("DVBA_DISCHARGE_RPT"_$J,0)=DT_U_DT_U_BDATE_U_EDATE
 Q
