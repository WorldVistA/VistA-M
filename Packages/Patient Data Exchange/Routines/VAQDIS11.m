VAQDIS11 ;ALB/JFP - PDX,SELECTION SCREEN FOR DISPLAY BY PATIENT;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Main entry point for the list processor
 K XQORS,VALMEVL
 N VAQSSN,VAQPAT,VAQFLAG,VAQECNT,VAQRSLT,VAQUNSOL,X0,STATUS,TRDE
 D EN^VALM("VAQ DIS PATIENT PDX9") ; -- Protocol = VAQ PDX9 (MENU)
 QUIT
 ;
INIT ; -- Builds array of PDX trans for the patient entered (SSN) or name
 K ^TMP("VAQD1",$J),^TMP("VAQIDX",$J)
 ;
 S TRDE="",(VAQECNT,VALMCNT)=0
 S VAQPAT=$P($G(^VAT(394.61,+VAQDFN,"QRY")),U,1)
 S VAQSSN=$P($G(^VAT(394.61,+VAQDFN,"QRY")),U,2)
 I (VAQSSN="")&(VAQPAT="") D MSG1 QUIT
 ;
 D STATPTR^VAQUTL95 ; -- Sets PDX status pointers (vaq-rslt,vaq-unsol)
MAIN ; -- Main processing loop
 F  S TRDE=$O(^VAT(394.61,$S(VAQSSN'="":"SSN",1:"NAME"),$S(VAQSSN'="":VAQSSN,1:VAQPAT),TRDE))  Q:TRDE=""  D SETD
 I VAQECNT=0 D MSG2 QUIT
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
 S X=$$SETSTR^VALM1(" ","",1,80) D TMP ; -- null line
 D KILLTRN^VAQUTL92 ; -- Cleans up variables set in TRNDATA
 QUIT
 ;
HD ; -- Make header line for list processor
 S X0=$$TRNDATA^VAQUTL92(VAQDFN)
 D HD1^VAQEXT02
 D KILLTRN^VAQUTL92
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
 I $P($G(^VAT(394.61,DFN,0)),U,4)=1 D WORKLD
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
WORKLD ; -- Updates workload file
 S X=$$WORKDONE^VAQADS01("SNSTVE",DFN,$G(DUZ))
 I X<0 W !,"Error updating workload file (SNSTVE)... "_$P(X,U,2)
 QUIT
 ;
MSG1 ; -- Message 1
 S VAQTRN=0,X=$$SETSTR^VALM1(" ","",1,79) D TMP
 S X=$$SETSTR^VALM1(" ** Insufficient Information for Patient Look-up...","",1,80) D TMP
 QUIT
 ;
MSG2 ; -- Message 2
 S VAQTRN=0,X=$$SETSTR^VALM1(" ","",1,79) D TMP
 S X=$$SETSTR^VALM1(" ** PDX results not found for patient entered... ","",1,80) D TMP
 QUIT
 ;
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 ;
 K VAQADFL ; -- set in VAQDIS01 (display min)
 K VAQSSN,VAQPAT,VAQFLAG,VAQECNT,VAQRSLT,VAQUNSOL,X0,STATUS,TRDE,VAQBCK
 K ENTRY,DATETIME,VAQECNT
 K ^TMP("VAQD1",$J),^TMP("VAQIDX",$J)
 QUIT
 ;
END ; -- End of code
 QUIT
