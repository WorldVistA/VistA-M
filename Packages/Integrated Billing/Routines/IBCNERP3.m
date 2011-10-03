IBCNERP3 ;DAOU/BHS - IBCNE eIV RESPONSE REPORT PRINT ;03-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eIV - Insurance Verification
 ;
 ; Called by IBCNERPA
 ; Input from IBCNERP1/2:
 ;  IBCNERTN="IBCNERP1" - Driver rtn
 ;  IBCNESPC("BEGDT")=Start Dt,  IBCNESPC("ENDDT")=End Dt
 ;  IBCNESPC("PYR")=Pyr IEN OR "" for all
 ;  IBCNESPC("PAT")=Pat IEN OR "" for all
 ;  IBCNESPC("TYPE")=A (All Responses) OR M (Most Recent Responses) for
 ;   unique Pyr/Pt pair
 ;  IBCNESPC("SORT")=1 (PyrNm) OR 2 (PatNm)
 ;  IBCNESPC("TRCN")=Trace #^IEN, if non-null, all params null
 ;  IBCNESPC("RFLAG")=Report Flag used to indicate which report is being
 ;   run.  Response Report (0), Inactive Report (1), or Ambiguous
 ;   Report (2).
 ;  IBCNESPC("DTEXP")=Expiration date used in the inactive policy report
 ;
 ;  Based on structure of eIV Response File (#365)
 ;  ^TMP($J,IBCNERTN,S1,S2,CT,0) based on ^IBCN(365,DA,0)
 ;    IBCNERTN="IBCNERP1", S1=PyrName(SORT=1) or PatNm(SORT=2),
 ;    S2=PatName(SORT=1) or PyrName(SORT=2), CT=Seq ct
 ;  ^TMP($J,IBCNERTN,S1,S2,CT,1) based on ^IBCN(365,DA,1)
 ;  ^TMP($J,IBCNERTN,S1,S2,2,EBCT) based on ^IBCN(365,DA,2)
 ;    EBCT=E/B IEN (365.02)
 ;  ^TMP($J,IBCNERTN,S1,S2,2,EBCT,NTCT)=based on ^IBCN(365,DA,2,EB,NT)
 ;   NTCT=Notes Ct, may not be Notes IEN, if line wrapped (365.021)
 ;  ^TMP($J,IBCNERTN,S1,S2,2,CNCT) based on ^IBCN(365,DA,3)
 ;   CNCT=Cont Pers IEN (365.03)
 ;  ^TMP($J,IBCNERTN,S1,S2,4,CT)= err txt based on ^IBCN(365,DA,4)
 ;   CT=1/2 if >60 ch long
 ;  ^TMP($J,IBCNERTN,S1,S2,5,CT)= based on # lines of comments reqd
 ;   CT=1 to display future retransmission date
 ; Must call at appropriate tag
 Q
 ;
PRINT(RTN,BDT,EDT,PYR,PAT,TYP,SRT,PGC,PXT,MAX,CRT,TRC,EXP,IPRF) ; Print data
 ; Input: RTN="IBCENRP1", BDT=start dt, EDT=end dt, PYR=pyr ien,
 ;  PAT= pat ien, TYP=A/M, SRT=1/2, PGC=page ct, PXT=exit flg,
 ; MAX=max line ct/pg, CRT=1/0, TRC=trc#, EXP=earliest expiration date
 N EORMSG,NONEMSG,SORT1,SORT2,CNT,CNFLG,ERFLG,PRT1,PRT2  ;,DISPDATA
 N OPRT1,OPRT2 ; Original values for PRT1 and PRT2, respectively
 S EORMSG="*** END OF REPORT ***"
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S (SORT1,SORT2)=""
 I '$D(^TMP($J,RTN)) D HEADER W !,?(80-$L(NONEMSG)\2),NONEMSG,!!
 F  S SORT1=$O(^TMP($J,RTN,SORT1)) Q:SORT1=""  D  Q:PXT!$G(ZTSTOP)
 . S (OPRT1,PRT1)=$S(SORT1="~NO PAYER":"* No Payer Identified",1:SORT1)
 . S SORT2="" F  S SORT2=$O(^TMP($J,RTN,SORT1,SORT2)) Q:SORT2=""  D  Q:PXT!$G(ZTSTOP)
 . . S (OPRT2,PRT2)=$S(SORT2="~NO PAYER":"* No Payer Identified",1:SORT2)
 . . S CNT="" F  S CNT=$O(^TMP($J,RTN,SORT1,SORT2,CNT)) Q:CNT=""  D  Q:PXT!$G(ZTSTOP)
 . . . D SSDB ; add SSN (from ^DPT) and DOB to patient header info
 . . . D HEADER
 . . . I $G(ZTSTOP)!PXT Q
 . . . K DISPDATA  ; Init disp
 . . . D DATA^IBCNERPE(.DISPDATA),LINE(.DISPDATA)  ; build/display data
 ;
 I $G(ZTSTOP)!PXT G PRINTX
 S (CNFLG,ERFLG)=0
 I $Y+1>MAX!('PGC) D HEADER I $G(ZTSTOP)!PXT G PRINTX
 W !,?(80-$L(EORMSG)\2),EORMSG
PRINTX ;
 Q
 ;
HEADER ; Print hdr info
 N X,Y,DIR,DTOUT,DUOUT,OFFSET,HDR,LIN,HDR
 I CRT,PGC>0,'$D(ZTQUEUED) D  I PXT G HEADERX
 . I MAX<51 F LIN=1:1:(MAX-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!($D(DUOUT)) S PXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 G HEADERX
 S PGC=PGC+1
 W @IOF,!,?1,$S($G(IPRF)=1:"eIV Inactive Policy Report",$G(IPRF)=2:"eIV Ambiguous Policy Report",1:"eIV Response Report") I TRC'="" W " by Trace #"
 S HDR=$$FMTE^XLFDT($$NOW^XLFDT,1)_"  Page: "_PGC,OFFSET=79-$L(HDR)
 W ?OFFSET,HDR
 I TRC'="" S HDR="Trace #: "_TRC,OFFSET=80-$L(HDR)\2 W !,?OFFSET,HDR
 I TRC="" D
 . W !,?1,"Sorted by: "_$S(SRT=1:"Payer",1:"Patient")_" Name"
 . S HDR="Responses Displayed: "_$S(TYP="M":"Most Recent",1:"All")
 . S OFFSET=79-$L(HDR)
 . W ?OFFSET,HDR
 . I $G(IPRF)=1 W !,?1,"Earliest Policy Expiration Date: ",$$FMTE^XLFDT(EXP,"5Z"),!
 . S HDR=$$FMTE^XLFDT(BDT,"5Z")_" - "_$$FMTE^XLFDT(EDT,"5Z")
 . S OFFSET=80-$L(HDR)\2
 . W !,?OFFSET,HDR
 . ; Disp SORT1 rng
 . S HDR=""
 . I SRT=1,PYR="" S HDR="All Payers"
 . I SRT=2,PAT="" S HDR="All Patients"
 . I HDR="" D
 ..  I SRT=1 S HDR=$P($G(^IBE(365.12,PYR,0)),U,1) Q
 ..  S HDR=$P($G(^DPT(PAT,0)),U,1)
 . S OFFSET=80-$L(HDR)\2
 . W !,?OFFSET,HDR
 . ; Disp SORT2 rng
 . S HDR=""
 . I SRT=1,PAT="" S HDR="All Patients"
 . I SRT=2,PYR="" S HDR="All Payers"
 . I HDR="" D
 .. I SRT=1 S HDR=$P($G(^DPT(PAT,0)),U,1) Q
 .. S HDR=$P($G(^IBE(365.12,PYR,0)),U,1)
 . S OFFSET=80-$L(HDR)\2
 . W !,?OFFSET,HDR
 W !
 ; Build disp
 I SORT1'="",SORT2'="" D
 . W !,?1,$$FO^IBCNEUT1($S(TRC'=""!(SRT=1):"  Payer: ",1:"Patient: "),9)_$E(PRT1,1,69)
 . W !,?1,$$FO^IBCNEUT1($S(TRC'=""!(SRT=1):"Patient: ",1:"  Payer: "),9)_$E(PRT2,1,69)
 . W !
HEADERX ;
 Q
 ;
LINE(DISPDATA) ;  Print data
 N LNCT,LNTOT,NWPG
 S LNTOT=+$O(DISPDATA(""),-1)
 S (CNFLG,ERFLG,NWPG)=0
 F LNCT=1:1:LNTOT D  Q:$G(ZTSTOP)!PXT
 . I $Y+1>MAX!('PGC) D HEADER S NWPG=1 I $G(ZTSTOP)!PXT Q
 . I DISPDATA(LNCT)="Contact Information:"!(DISPDATA(LNCT)="Error Information:"),$Y+3>MAX S (CNFLG,ERFLG)=0 D HEADER S NWPG=1 I $G(ZTSTOP)!PXT Q
 . I CNFLG,DISPDATA(LNCT)="",$G(DISPDATA(LNCT+1))="Error Information:" S CNFLG=0
 . I NWPG,CNFLG W !,?1,"Contact Information: (cont'd)",!
 . I NWPG,ERFLG W !,?1,"Error Information: (cont'd)",!
 . I 'NWPG!(NWPG&(DISPDATA(LNCT)'="")) W !,?1,DISPDATA(LNCT)
 . I NWPG S NWPG=0
 . I DISPDATA(LNCT)["Contact Information:" S ERFLG=0,CNFLG=1
 . I DISPDATA(LNCT)["Error Information:" S CNFLG=0,ERFLG=1
 . Q
 S (CNFLG,ERFLG)=0
LINEX ; 
 Q
 ;
SSDB ; Display last 4 digits of SSN and DOB to facilitate pt. identification
 ; $$SSN^IBCNEDEQ(DFN) returns SSN followed by DOB
 ;
 N DFN
 S DFN=$P($G(^TMP($J,RTN,SORT1,SORT2,CNT,0)),U,2)
 I DFN D
 . I SRT=1!TRC S PRT2=OPRT2_$$SSN^IBCNEDEQ(DFN) Q
 . S PRT1=OPRT1_$$SSN^IBCNEDEQ(DFN)
 Q
