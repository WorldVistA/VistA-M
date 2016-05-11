IBCNERP6 ;DAOU/BHS - eIV PAYER REPORT PRINT ;05-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; Called by IBCNERPA
 ;
 ; Input variables from IBCNERP4 and IBCNERP5:
 ;   IBCNERTN = "IBCNERP4"
 ;   IBCNESPC("BEGDT") = Start Date for dt range
 ;   IBCNESPC("ENDDT") = End Date for dt range
 ;   IBCNESPC("PYR") = Payer IEN for report, if = "", then include all
 ;   IBCNESPC("SORT") = 1 - Payer name OR 2 - Total Inquiries
 ;   IBCNESPC("DTL")= 1 - YES OR 0 - NO - display Rejection detail
 ;   ^TMP($J,IBCNERTN,SORT1,SORT2,SORT3)=InqCreatedCount^InqCancelledCt^
 ;                                       InqQueuedCt^1stTransCount^
 ;                                       RetryCount^Non-ErrorRespCount^
 ;                                       ErrorRespCount^TotRespTime-days^
 ;                                       CommFailRespCount^PendRespCount^
 ;                                       DeactivationDTM
 ;        IBCNERTN = "IBCNERP4"
 ;        SORT1 = PayerName (SORT=1) or -InquiryCount(SORT=2)
 ;        SORT2 = PayerIEN (SORT=1) or PayerName (SORT=2)
 ;        SORT3 = "*" (SORT=1) or PayerIEN (SORT=2)
 ;                                       
 ;   ^TMP($J,IBCNERTN,SORT1,SORT2,SORT3,ERRCD)=InquiryCount
 ;        (see above)
 ;        ERRCD = Error Condition code (ptr to 365.018)
 ;
 ; Must call at appropriate tag
 Q
 ;
 ;
PRINT(RTN,BDT,EDT,PYR,RDTL,SRT,PGC,PXT,MAX,CRT,IBOUT) ; Print data
 ; Input params: RNT = "IBCNERP4" - routine, BDT = starting dt,
 ;  EDT = ending dt, PYR = payer ien,
 ;  RDTL = 0/1, SRT = 0/1, PGC = page ct, PXT = exit flg, MAX = max line
 ;  ct/page, CRT = 0/1
 ;
 ; Init vars
 N EORMSG,NONEMSG,COUNT,TOTDASHS,DISPDATA,SORT1,SORT2,SORT3,CT,PRT1,PRT2,TOTALS
 ;
 S EORMSG="*** END OF REPORT ***"
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S $P(TOTDASHS,"=",89)=""
 S CT=0
 ;
 I '$D(^TMP($J,RTN)) D HEADER W !,?(132-$L(NONEMSG)\2),NONEMSG,!! G PRINT2
 I IBOUT="E" D EXHDR
 S SORT1=""
 F  S SORT1=$O(^TMP($J,RTN,SORT1)) Q:SORT1=""  D  Q:$G(ZTSTOP)!PXT
 .  S PRT1=$S(SORT1="~NO PAYER":"* No Payer Identified",1:SORT1)
 .  S SORT2=""
 .  F  S SORT2=$O(^TMP($J,RTN,SORT1,SORT2)) Q:SORT2=""  D  Q:$G(ZTSTOP)!PXT
 .  .  S PRT2=$S(SORT2="~NO PAYER":"* No Payer Identified",1:SORT2)
 .  .  S SORT3=""
 .  .  F  S SORT3=$O(^TMP($J,RTN,SORT1,SORT2,SORT3)) Q:SORT3=""  D  Q:$G(ZTSTOP)!PXT
 .  .  .  S CT=CT+1
 .  .  .  ; Build lines of data to display
 .  .  .  KILL DISPDATA
 .  .  .  D DATA(.DISPDATA)
 .  .  .  ; Display lines of response
 .  .  .  D LINE(.DISPDATA)
 .  .  .  Q
 .  .  Q
 .  Q
 ;
 ; Display totals line if space is available
 I $G(ZTSTOP)!PXT G PRINTX
 I IBOUT="R" I $Y+1>MAX!('PGC) D HEADER I $G(ZTSTOP)!PXT G PRINTX
 I IBOUT="R" W !,?43,TOTDASHS
 ; Print totals for report
 KILL DISPDATA
 D TOTALS(.DISPDATA)
 ; Display lines of totals
 D LINE(.DISPDATA)
 ;
PRINT2 I $G(ZTSTOP)!PXT G PRINTX
 I IBOUT="R" I $Y+1>MAX!('PGC) D HEADER I $G(ZTSTOP)!PXT G PRINTX
 W !,?(132-$L(EORMSG)\2),EORMSG
 ;
PRINTX ; PRINT exit point
 Q
 ;
HEADER ; Print header info for each page
 ; Assumes vars from PRINT: CRT,PGC,PXT,MAX,SRT,BDT,EDT,PYR,RDTL,MAR
 ; Init vars
 N DIR,X,Y,DTOUT,DUOUT,OFFSET,HDR,DASHES,LIN
 ;
 I CRT,PGC>0,'$D(ZTQUEUED) D  I PXT G HEADERX
 . I MAX<51 F LIN=1:1:(MAX-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S PXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,PXT)=1 G HEADERX
 S PGC=PGC+1
 W @IOF,!,?1,"eIV Payer Report"
 S HDR=$$FMTE^XLFDT($$NOW^XLFDT,1)_"  Page: "_PGC
 S OFFSET=131-$L(HDR)
 W ?OFFSET,HDR
 W !,?1,"Sorted by: "_$S(SRT=1:"Payer",1:"Total Inquiries")
 S HDR="Rejection Detail: "_$S('RDTL:"Not",1:"")_" Included"
 S OFFSET=131-$L(HDR)
 W ?OFFSET,HDR
 S HDR=$$FMTE^XLFDT(BDT,"5Z")_" - "_$$FMTE^XLFDT(EDT,"5Z")
 S OFFSET=132-$L(HDR)\2
 W !,?OFFSET,HDR
 ; Display Payer Range
 S HDR=""
 I PYR="" S HDR="All Payers"
 I HDR="" S HDR=$P($G(^IBE(365.12,PYR,0)),U,1)
 S OFFSET=132-$L(HDR)\2
 W !,?OFFSET,HDR
 W !  ; Skip line
 ; Display column headings
 W !,?70,"***** SENT *****",?88,"*** RECEIVED ***",?106,"AvgResp"
 W !,?1,"Payer [Inactive Date]",?43,"Created",?52," Cancel",?61," Queued",?70,"1st Att",?79,"  Retry",?88,"   Good",?97,"  Error",?106," (Days)",?115,"Timeout",?124,"Pending"
 S $P(DASHES,"=",131)=""
 W !,?1,DASHES
 ;
HEADERX ; HEADER exit pt
 Q
 ;
EXHDR ; format for Excel report  ; 528 - baa
 N HDR,HDR1
 W !,"eIV Payer Report"
 W !,"Sorted by: "_$S(SRT=1:"Payer",1:"Total Inquiries")
 S HDR="Rejection Detail: "_$S('RDTL:"Not",1:"")_" Included"
 W !,HDR
 S HDR=$$FMTE^XLFDT(BDT,"5Z")_" - "_$$FMTE^XLFDT(EDT,"5Z")
 W !,HDR
 S HDR1="Payer [Inactive Date]^Created^Cancel^Queued^SENT 1st Att^Sent Retry^Received Good^Error^AvgResp (Days)^Timeout^Pending"
 W !,HDR1
 Q
 ;
LINE(DISPDATA) ; Print line of data
 ; Assumes vars from PRINT: PGC,PXT,MAX
 ; Init vars
 N CT,II
 ;
 S CT=+$O(DISPDATA(""),-1)
 I IBOUT="R" I $Y+1+CT>MAX D HEADER I $G(ZTSTOP)!PXT G LINEX
 F II=1:1:CT D  Q:$G(ZTSTOP)!PXT
 . I IBOUT="R" I $Y+1>MAX!('PGC) D HEADER I $G(ZTSTOP)!PXT Q
 . I $D(DISPDATA(II)) W !,?1,DISPDATA(II)
 . Q
 ;
LINEX ; LINE exit pt
 Q
 ;
DATA(DISPDATA) ; Gather and format lines of data to be printed
 ; Assumes vars from PRINT: RTN,SRT,SORT1,SORT2,SORT3,RDTL,CT,PRT1,PRT2
 ; Init vars
 N LINECT,INQS,TIME,AVG,APPS,REJS,DASHES2,ERRCD,ERROR,DEACMSG
 N REJDASHS,RPTDATA,FAIL,PEND,RETS,CT2,FIRST,QUED,CANC,PAYER,DEACDT
 ;
 S $P(DASHES2,"-",89)=""
 S $P(REJDASHS,"-",8)=""
 S LINECT=1
 M RPTDATA=^TMP($J,RTN,SORT1,SORT2,SORT3)
 S INQS=+$P(RPTDATA,U,1)
 S CANC=+$P(RPTDATA,U,2)
 S QUED=+$P(RPTDATA,U,3)
 S FIRST=+$P(RPTDATA,U,4)
 S RETS=+$P(RPTDATA,U,5)
 S APPS=+$P(RPTDATA,U,6)
 S REJS=+$P(RPTDATA,U,7)
 S TIME=+$P(RPTDATA,U,8)
 S FAIL=+$P(RPTDATA,U,9)
 S PEND=+$P(RPTDATA,U,10)
 S AVG=$FN($S((APPS+REJS)>0:TIME/(APPS+REJS),1:0),"",2)
 S PAYER=$S(SRT=1:PRT1,1:PRT2)
 I $P(RPTDATA,U,11) D
 . S DEACMSG=" [Inactive"
 . S DEACDT=" "_$$FMTE^XLFDT($P(RPTDATA,U,11)\1,"5Z")
 . I $L(PAYER)+$L(DEACMSG)+$L(DEACDT)<40 S PAYER=PAYER_DEACMSG_DEACDT_"]" Q
 . I $L(PAYER)+$L(DEACMSG)<40 S PAYER=PAYER_DEACMSG_"]" Q
 . S PAYER=$E(PAYER,1,39-$L(DEACMSG))_DEACMSG_"]"
 ; Update Report Totals
 F CT2=1:1:10 S $P(TOTALS,U,CT2)=$P($G(TOTALS),U,CT2)+$P(RPTDATA,U,CT2)
 I IBOUT="E" S DISPDATA(LINECT)=PAYER_U_INQS_U_CANC_U_QUED_U_FIRST_U_RETS_U_APPS_U_REJS_U_AVG_U_FAIL_U_PEND
 I IBOUT="R" D
 .S DISPDATA(LINECT)=$$FO^IBCNEUT1(PAYER,40)_$$FO^IBCNEUT1(INQS,9,"R")_$$FO^IBCNEUT1(CANC,9,"R")_$$FO^IBCNEUT1(QUED,9,"R")_$$FO^IBCNEUT1(FIRST,9,"R")_$$FO^IBCNEUT1(RETS,9,"R")
 .S DISPDATA(LINECT)=DISPDATA(LINECT)_$$FO^IBCNEUT1(APPS,9,"R")_$$FO^IBCNEUT1(REJS,9,"R")_$$FO^IBCNEUT1(AVG,9,"R")_$$FO^IBCNEUT1(FAIL,9,"R")_$$FO^IBCNEUT1(PEND,9,"R")
 S LINECT=LINECT+1
 I 'RDTL!(REJS=0) G DATAX
 ; Include Rejection Detail - if necessary
 I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("",41)_$$FO^IBCNEUT1("Rejection Detail",56)_REJDASHS
 I IBOUT="E" S DISPDATA(LINECT)="Rejection Detail"
 S LINECT=LINECT+1
 S ERRCD=""
 F  S ERRCD=$O(RPTDATA(ERRCD)) Q:ERRCD=""  D
 .  ; Determine Error Condition Description based on ERRCD
 .  ; If just Error Text 4.01 field, then keep it as is
 .  I 'ERRCD D
 ..   S ERROR=$P(ERRCD,U,2,99)
 ..   I IBOUT="E" S DISPDATA(LINECT)=ERROR_U_ERRCD
 ..   I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("",41)_" "_$$FO^IBCNEUT1(ERROR,53)_$$FO^IBCNEUT1(+RPTDATA(ERRCD),9,"R")
 .  ; If IEN, get the code and description
 .  I ERRCD D
 ..   S ERROR=$G(^IBE(365.017,ERRCD,0))
 ..   I IBOUT="E" S DISPDATA(LINECT)=$P(ERROR,U)_$S($P(ERROR,U,2)'="":"-"_$P(ERROR,U,2))_U_+RPTDATA(ERRCD)
 ..   I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("",41)_" "_$$FO^IBCNEUT1($P(ERROR,U)_$S($P(ERROR,U,2)'="":"-"_$P(ERROR,U,2),1:""),53)_$$FO^IBCNEUT1(+RPTDATA(ERRCD),9,"R")
 .  S LINECT=LINECT+1
 .  ; Update Report Totals
 .  S TOTALS(ERRCD)=+$G(TOTALS(ERRCD))+RPTDATA(ERRCD)
 .  Q
 ;
DATAX ; DATA exit pt
 ; Display end of record dashes only if other records follow
 I IBOUT="R" D
 .I $O(^TMP($J,RTN,SORT1,SORT2,SORT3))'=""!($O(^TMP($J,RTN,SORT1,SORT2))'="")!($O(^TMP($J,RTN,SORT1))'="") S DISPDATA(LINECT)=$$FO^IBCNEUT1("",42)_DASHES2,LINECT=LINECT+1
 Q
 ;
TOTALS(DISPDATA) ; Gather and format lines of totals to be printed
 ; Assumes vars from PRINT: RDTL,MAR
 ; Init vars
 N LINECT,INQS,TIME,AVG,APPS,REJS,ERRCD,DASHES,REJDASHS,FAIL,PEND,RETS
 N FIRST,QUED,ERROR,CANC
 ;
 S $P(DASHES,"=",131)=""
 S $P(REJDASHS,"-",8)=""
 S LINECT=1
 S INQS=+$P(TOTALS,U,1)
 S CANC=+$P(TOTALS,U,2)
 S QUED=+$P(TOTALS,U,3)
 S FIRST=+$P(TOTALS,U,4)
 S RETS=+$P(TOTALS,U,5)
 S APPS=+$P(TOTALS,U,6)
 S REJS=+$P(TOTALS,U,7)
 S TIME=+$P(TOTALS,U,8)
 S FAIL=+$P(TOTALS,U,9)
 S PEND=+$P(TOTALS,U,10)
 S AVG=$FN($S((APPS+REJS)>0:TIME/(APPS+REJS),1:0),"",2)
 I IBOUT="E" S DISPDATA(LINECT)="Grand Totals"_U_INQS_U_CANC_U_QUED_U_FIRST_U_RETS_U_APPS_U_AVG_U_FAIL_U_PEND
 I IBOUT="R" D
 .S DISPDATA(LINECT)=$$FO^IBCNEUT1("Grand Totals",40)_$$FO^IBCNEUT1(INQS,9,"R")_$$FO^IBCNEUT1(CANC,9,"R")_$$FO^IBCNEUT1(QUED,9,"R")_$$FO^IBCNEUT1(FIRST,9,"R")_$$FO^IBCNEUT1(RETS,9,"R")
 .S DISPDATA(LINECT)=DISPDATA(LINECT)_$$FO^IBCNEUT1(APPS,9,"R")_$$FO^IBCNEUT1(REJS,9,"R")_$$FO^IBCNEUT1(AVG,9,"R")_$$FO^IBCNEUT1(FAIL,9,"R")_$$FO^IBCNEUT1(PEND,9,"R")
 S LINECT=LINECT+1
 I 'RDTL!(REJS=0) G TOTALSX
 ; Include Rejection Detail - if necessary
 I IBOUT="E" S DISPDATA(LINECT)="Rejection Detail"
 I IBOUT="R" D
 .S DISPDATA(LINECT)=$$FO^IBCNEUT1("",41)_$$FO^IBCNEUT1("Rejection Detail",56)_REJDASHS
 .S LINECT=LINECT+1
 S ERRCD=""
 F  S ERRCD=$O(TOTALS(ERRCD)) Q:ERRCD=""  D
 .  ; If IEN, get the code and description
 .  I ERRCD D
 ..   S ERROR=$G(^IBE(365.017,ERRCD,0))
 ..   I IBOUT="E" S DISPDATA(LINECT)=$P(ERROR,U)_$S($P(ERROR,U,2)'="":"-"_$P(ERROR,U,2),1:"")_U_+TOTALS(ERRCD)
 ..   I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("",41)_" "_$$FO^IBCNEUT1($P(ERROR,U)_$S($P(ERROR,U,2)'="":"-"_$P(ERROR,U,2),1:""),53)_$$FO^IBCNEUT1(+TOTALS(ERRCD),9,"R")
 .  ; If error text display as is
 .  I 'ERRCD D
 ..    S ERROR=$P(ERRCD,U,2,99)
 ..    I IBOUT="E" S DISPDATA(LINECT)=ERROR_U_+TOTALS(ERRCD)
 ..    I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("",41)_" "_$$FO^IBCNEUT1(ERROR,53)_$$FO^IBCNEUT1(+TOTALS(ERRCD),9,"R")
 .  S LINECT=LINECT+1
 .  Q
 ;
TOTALSX ; DATA exit pt
 I IBOUT="R" S DISPDATA(LINECT)=DASHES
 Q
 ;
 ;
