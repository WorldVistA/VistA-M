VAQDIS12 ;ALB/JFP - PDX,SELECTION SCREEN FOR DISPLAY BY REQUESTOR;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Main entry point for the list processor
 I '($D(DUZ)) W !,"Duz required for this option" D PAUSE^VALM1 QUIT
 ;
 N VAQDZN,VAQFLAG,VAQECNT,VAQRSLT,VAQUNSOL,X0,STATUS,TRDE
 S VAQDZN=$S($D(DUZ):$P(^VA(200,DUZ,0),U,1),1:"")
 K XQORS,VALMEVL
 D EN^VALM("VAQ DIS REQUESTOR PDX10") ; -- Protocol = VAQ PDX9 (MENU)
 QUIT
 ;
INIT ; -- Builds array of PDX transactions by requestor
 K ^TMP("VAQD1",$J),^TMP("VAQIDX",$J)
 ;
 D STATPTR^VAQUTL95 ; -- Sets PDX status pointers (vaq-rslt,vaq-unsol)
 ;
 D:$D(XRTL) T0^%ZOSV ; -- Capacity start
 S TRDE="",(VAQECNT,VALMCNT)=0
 F  S TRDE=$O(^VAT(394.61,"AC",VAQDZN,TRDE))  Q:TRDE=""  D SETD
 I VAQECNT=0 D
 .S VAQTRN=0,X=$$SETSTR^VALM1(" ","",1,79) D TMP
 .S X=$$SETSTR^VALM1(" ** PDX results not found for this requestor... ","",1,80) D TMP
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; -- Capacity stop
 QUIT
 ;
SETD ; -- Set data for display in list processor
 S VAQCSTAT=$P($G(^VAT(394.61,TRDE,0)),U,2)
 ; -- Filter out transaction without results
 I ((VAQCSTAT)'=VAQRSLT)&((VAQCSTAT)'=VAQUNSOL) QUIT
 ; -- Filter out transactions marked as purged OR excides life cap
 S VAQFLAG=$$EXPTRN^VAQUTL97(TRDE)
 Q:VAQFLAG=1
 ;
 S X0=$$TRNDATA^VAQUTL92(TRDE) ; -- Extracts data from transaction file
 S STATUS=$S(VAQCSTAT'="":$P($G(^VAT(394.85,VAQCSTAT,0)),U,2),1:" ")
 S:VAQADT'="" DATETIME=VAQADT_" (Rs)"
 S:VAQADT="" DATETIME=VAQRDT_" (Rq)"
 S VAQECNT=VAQECNT+1
 S X=$$SETFLD^VALM1(VAQECNT,"","ENTRY")
 S X=$$SETFLD^VALM1(VAQADOM,X,"DOMAIN")
 S X=$$SETFLD^VALM1(DATETIME,X,"DATE")
 S X=$$SETFLD^VALM1(VAQTRN,X,"TRNO")
 D TMP
 S X=$$SETSTR^VALM1(VAQPTNM,"",7,80) D TMP
 S X=$$SETSTR^VALM1(" ","",1,80) D TMP ; -- null line
 D KILLTRN^VAQUTL92 ; -- Cleans up variables set in TRNDATA
 QUIT
 ;
HD ; -- Make header line for list processor
 S X=$$SETSTR^VALM1("Requestor: "_VAQDZN,"",1,79)
 S VALMHDR(1)=" ",VALMHDR(2)=X,VALMHDR(3)=" "
 QUIT
 ;
SEL ; -- Selects patient to display, checks sensative patient
 N VALMY,SDI,SDAT
 S:'$D(VAQBCK) VAQBCK=0
 D EN^VALM2($G(XQORNOD(0)),"S")
 Q:'$D(VALMY)
 S SDI=""
 S SDI=$O(VALMY(SDI))  Q:SDI=""
 S SDAT=$G(^TMP("VAQIDX",$J,SDI))
 S VAQTRN=$P(SDAT,U,2),DFN=""
 S (VAQDFN,DFN)=$O(^VAT(394.61,"B",VAQTRN,DFN))
 I $P($G(^VAT(394.61,DFN,0)),U,4)=1 D WORKLD^VAQDIS11
 D EP^VAQDIS15 ; -- Display segments
 I VAQBCK=1 K VALMBCK QUIT
 D INIT
 S VALMBCK="R"
 QUIT
 ;
TMP ; -- Set the array used by list processor
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQD1",$J,VALMCNT,0)=$E(X,1,79)
 S ^TMP("VAQD1",$J,"IDX",VALMCNT,VAQECNT)=""
 S ^TMP("VAQIDX",$J,VAQECNT)=VALMCNT_"^"_VAQTRN
 QUIT
 ;
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 ;
 K VAQFLAG,VAQECNT,VAQRSLT,VAQUNSOL,X0,STATUS,TRDE
 K POP,VAQBCK,VAQDFN,DFN,ENTRY
 K DATETIME,VAQCSTAT
 K VAQADFL ; -- set in VAQDIS01 (display min)
 K ^TMP("VAQD1",$J),^TMP("VAQIDX",$J)
 QUIT
 ;
END ; -- End of code
 QUIT
