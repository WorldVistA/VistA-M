IBCNRRP3 ;BHAM ISC/CMW - GROUP PLAN WORKSHEET REPORT PRINT ;03-MAR-2004
 ;;2.0;INTEGRATED BILLING;**251,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; ePHARM GROUP PLAN WORKSHEET REPORT
 ;
 ; Called by IBCNRRP1
 ;
 ; Input variables from IBCNRRP1 and IBCNRRP2:
 ;   IBCNRRTN = "IBCNRRP1"
 ;   IBCNRSPC("BEGDT") = Start Date for dt range
 ;   IBCNRSPC("ENDDT") = End Date for dt range
 ;   IBCNRSPC("SORT") = 1 - By Insurance/Group; 2 - Total Claims; 
 ;                      3 - Total Charges; 4 - Exceptions
 ;   IBCNRSPC("MATCH") = 1 - Matched Only; 0 - All;
 ;    
 ;   ^TMP(IBCNRRTN,1); ^TMP(IBCNRRTN,2); ^TMP(IBCNRRTN,3)
 ; Must call at appropriate tag
 Q
 ;
 ;
EN(IBCNRRTN,IBCNRSPC) ; Entry pt.
 ;
 ; Init vars
 N CRT,MAXCNT,IBPGC,IBBDT,IBEDT,IBMAT,IBPY,IBPXT,IBSRT,IBDTL
 N X,Y,DIR,DTOUT,DUOUT,LIN,TOTALS
 ;
 S IBBDT=$G(IBCNRSPC("BEGDT"))
 S IBEDT=$G(IBCNRSPC("ENDDT"))
 S IBSRT=$G(IBCNRSPC("SORT"))
 S IBMAT=$G(IBCNRSPC("MATCH"))
 S (IBPXT,IBPGC)=0
 ;
 ; Determine IO parameters
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 ;
 D PRINT(IBCNRRTN,IBBDT,IBEDT,IBSRT,MAXCNT,IBPGC,IBMAT)
 I $G(ZTSTOP)!IBPXT G EXIT3
 I CRT,IBPGC>0,'$D(ZTQUEUED) D
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 ;
EXIT3 ; Exit pt
 Q
 ;
PRINT(RTN,BDT,EDT,SRT,MAX,PGC,MAT) ; Print data
 ; Input params: RNT = "IBCNRRP1" - routine, BDT = starting dt,
 ;  EDT = ending dt
 ;  SRT = 1/2/3
 ;  MAT = 1/0
 ;
 ; Init vars
 N EORMSG,NONEMSG,TOTDASHS,DISPDATA,SORT,CT,PRT1,PRT2
 ;
 S EORMSG="*** END OF REPORT ***"
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S $P(TOTDASHS,"=",89)=""
 S CT=0
 ;
 I '$D(^XTMP(RTN)) D HEADER W !,?(132-$L(NONEMSG)\2),NONEMSG,!! G PRINT2
 ;
 ; Build lines of data to display
 K ^TMP("IBCNR",$J,"RPTDATA")
 D DATA
 K ^TMP("IBCNR",$J,"DSPDATA")
 D DISP
 ; Display lines of response
 D LINE
 K ^TMP("IBCNR",$J,"DSPDATA"),^TMP("IBCNR",$J,"RPTDATA")
 Q
 ;
PRINT2 I $G(ZTSTOP)!IBPXT G PRINTX
 I $Y+1>MAX!('PGC) D HEADER I $G(ZTSTOP)!$G(IBPXT) G PRINTX
 W !,?(132-$L(EORMSG)\2),EORMSG
 ;
PRINTX ; PRINT exit point
 Q
 ;
HEADER ; Print header info for each page
 ; Assumes vars from PRINT: CRT,PGC,IBPXT,MAX,SRT,BDT,EDT,PYR,RDTL,MAR
 ; Init vars
 N DIR,X,Y,DTOUT,DUOUT,OFFSET,HDR,DASHES,DASHES2,LIN
 ;
 I CRT,PGC>0,'$D(ZTQUEUED) D  I IBPXT G HEADERX
 . I MAX<51 F LIN=1:1:(MAX-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S IBPXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 G HEADERX
 S PGC=PGC+1
 W @IOF,!,?1,"ePHARM GROUP PLAN WORKSHEET REPORT"
 S HDR=$$FMTE^XLFDT($$NOW^XLFDT,1)_"  Page: "_PGC
 S OFFSET=80-$L(HDR)
 W ?OFFSET,HDR
 W !,?1,"Claims with Pharmacy Coverage Sorted by: "_$S(SRT=1:"Insurance/Group",SRT=2:"Max. Total Claims",1:"Max. Total Charges")
 S HDR=$$FMTE^XLFDT(BDT,"5Z")_" - "_$$FMTE^XLFDT(EDT,"5Z")
 S OFFSET=80-$L(HDR)\2
 W !,?OFFSET,HDR
 ; Display column headings
 W !,?1,"Insurance Company Name",?40,"Insurance Company Address"
 W !,?3,"Group Name/Number",?42,"Pharmacy Plan",?60," BIN",?70,"PCN"
 S $P(DASHES,"=",80)=""
 W !,?1,DASHES
 ;
HEADERX ; HEADER exit pt
 Q
 ;
LINE ; Print line of data
 ; Assumes vars from PRINT: PGC,IBPXT,MAX
 ; Init vars
 N CT,II
 ;
 S CT=+$O(^TMP("IBCNR",$J,"DSPDATA",""),-1)
 I $Y+1+CT>MAX D HEADER I $G(ZTSTOP)!IBPXT G LINEX
 F II=1:1:CT D  Q:$G(ZTSTOP)!IBPXT
 . I $Y+1>MAX!('PGC) D HEADER I $G(ZTSTOP)!IBPXT Q
 . W !,?1,^TMP("IBCNR",$J,"DSPDATA",II)
 . Q
 ;
LINEX ; LINE exit pt
 Q
 ;
DATA ; Gather and format lines of data to be printed
 ; Assumes vars from PRINT: RTN,SRT,SRT,RDTL,CT,PRT1,PRT2
 ; Init vars
 ;
 ;Loop through and sort TMP file
 N CNT,IBINS,IBINSNM,IBGRP,IBGRPNM,IBGRPNB,RPDT,RPTOT,RPTCNT,RPTCHG
 N IBGRP0,IBGRP6,IBGRPNM,IBPLBIN,IBPLNNM,IBPLPCN,IBPPIEN
 S IBINS=0,CNT=0
 F  S IBINS=$O(^XTMP(RTN,IBINS)) Q:IBINS=""  D
 . ;get insurance company name
 . S IBINSNM=$P($G(^DIC(36,IBINS,0)),U)
 . I IBINSNM="" S IBINSNM="NO NAME EXISTS"
 . S IBGRP=0
 . F  S IBGRP=$O(^XTMP(RTN,IBINS,IBGRP)) Q:IBGRP=""  D
 .. ;get group info
 .. S IBGRP0=$G(^IBA(355.3,IBGRP,0))
 .. ;get pharmacy plan info
 .. S IBGRP6=$G(^IBA(355.3,IBGRP,6))
 .. I 'IBGRP6,$G(MAT) Q  ; Matched only
 .. I IBGRP0 D
 ... S (IBGRPNM,IBGRPNB)=""
 ... S IBGRPNM=$P($G(IBGRP0),U,3) I $G(IBGRPNM)="" S IBGRPNM="<blank>"
 ... S IBGRPNB=$P($G(IBGRP0),U,4) I $G(IBGRPNB)="" S IBGRPNB="<blank>"
 ... S RPDT=IBGRPNB
 .. I IBGRP6 D
 ... S (IBPPIEN,IBPLNNM,IBPLPCN)=""
 ... S IBPPIEN=$P($G(IBGRP6),U)
 ... S IBPLNNM=$P($G(^IBCNR(366.03,IBPPIEN,0)),U,2)
 ... S IBPLBIN=$P($G(^IBCNR(366.03,IBPPIEN,10)),U,2)
 ... S IBPLPCN=$P($G(^IBCNR(366.03,IBPPIEN,10)),U,3)
 ... S RPDT=$G(RPDT)_U_$G(IBPLNNM)_U_$G(IBPLBIN)_U_$G(IBPLPCN)
 .. E  S RPDT=$G(RPDT)_U_U_U
 .. S RPDT=$G(RPDT)_U_$P($G(IBGRP6),U,2,3)
 .. S RPTOT=^XTMP(RTN,IBINS,IBGRP)
 .. S RPTCNT=$P(RPTOT,U),RPTCHG=$P(RPTOT,U,2)
 .. I SRT=1 D  Q
 ... S ^TMP("IBCNR",$J,"RPTDATA",SRT,IBINSNM,IBINS,IBGRPNM,IBGRP)=$G(RPDT)
 .. I SRT=2 D  Q
 ... S ^TMP("IBCNR",$J,"RPTDATA",-$G(RPTCNT),IBINSNM,IBINS,IBGRPNM,IBGRP)=$G(RPDT)
 .. I SRT=3 D  Q
 ... S ^TMP("IBCNR",$J,"RPTDATA",-$G(RPTCHG),IBINSNM,IBINS,IBGRPNM,IBGRP)=$G(RPDT)
 .. I SRT=4 D  Q
 ... I '$G(IBGRP6) Q
 ... N OK S OK=1
 ... I $G(IBPLBIN)'="",$P(IBGRP6,U,2)'="",IBPLBIN'=$P(IBGRP6,U,2) S OK=0
 ... I $G(IBPLPCN)'="",$P(IBGRP6,U,3)'="",IBPLPCN'=$P(IBGRP6,U,3) S OK=0
 ... I 'OK S ^TMP("IBCNR",$J,"RPTDATA",SRT,IBINSNM,IBINS,IBGRPNM,IBGRP)=$G(RPDT)
 Q
 ;
DISP ;set up display data
 N CNT,DISP1,DISP2,DISP3,DISP4,DISP5,DISPD,DASHES2
 N IBCNADR,IBCIN11,IBCINST,I
 S DISP1="",CNT=0,$P(DASHES2,"-",80)=""
 F  S DISP1=$O(^TMP("IBCNR",$J,"RPTDATA",DISP1)) Q:DISP1=""  D
 . S DISP2=""
 . F  S DISP2=$O(^TMP("IBCNR",$J,"RPTDATA",DISP1,DISP2)) Q:DISP2=""  D
 .. S DISP3=0
 .. F  S DISP3=$O(^TMP("IBCNR",$J,"RPTDATA",DISP1,DISP2,DISP3)) Q:DISP3=""  D
 ... S DISP4=""
 ... F  S DISP4=$O(^TMP("IBCNR",$J,"RPTDATA",DISP1,DISP2,DISP3,DISP4)) Q:DISP4=""  D
 .... S DISP5=0
 .... F  S DISP5=$O(^TMP("IBCNR",$J,"RPTDATA",DISP1,DISP2,DISP3,DISP4,DISP5)) Q:DISP5=""  D
 ..... S DISPD=$G(^TMP("IBCNR",$J,"RPTDATA",DISP1,DISP2,DISP3,DISP4,DISP5))
 ..... ;get insurance addr
 ..... S IBCIN11=$G(^DIC(36,DISP3,.11))
 ..... S IBCINST=$S($P(IBCIN11,U,5)="":"--",1:$P($G(^DIC(5,$P(IBCIN11,U,5),0)),U,2))
 ..... S IBCNADR=$E($P(IBCIN11,U),1,15)_","_$E($P(IBCIN11,U,4),1,10)_","_IBCINST_" "_$E($P(IBCIN11,U,6),1,5)
 ..... S CNT=CNT+1
 ..... ;insurance co and group/plan
 ..... S ^TMP("IBCNR",$J,"DSPDATA",CNT)=$$FO^IBCNEUT1(DISP2,40)_$$FO^IBCNEUT1(IBCNADR,35,"L")
 ..... ;bin; pcn; and pharmacy plan
 ..... S CNT=CNT+1
 ..... S ^TMP("IBCNR",$J,"DSPDATA",CNT)=$$FO^IBCNEUT1(DISP4_"/"_$P(DISPD,U),35,"L")_$$FO^IBCNEUT1("  "_$P(DISPD,U,2),24,"L")_$$FO^IBCNEUT1(" "_$P(DISPD,U,3),10,"L")_$$FO^IBCNEUT1($P(DISPD,U,4),10,"L")
 ..... S I=$$FO^IBCNEUT1("",60)_$$FO^IBCNEUT1($P(DISPD,U,5),10,"L")_$$FO^IBCNEUT1($P(DISPD,U,6),10,"L")
 ..... I $TR(I," ")'="" S CNT=CNT+1,^TMP("IBCNR",$J,"DSPDATA",CNT)=I
 ..... S CNT=CNT+1
 ..... S ^TMP("IBCNR",$J,"DSPDATA",CNT)=$$FO^IBCNEUT1(DASHES2,79,"L")
 ;
DATAX ; DATA exit pt
 K RPTDATA
 Q
 ;
