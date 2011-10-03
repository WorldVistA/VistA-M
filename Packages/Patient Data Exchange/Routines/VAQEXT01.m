VAQEXT01 ;ALB/JFP - PDX, PROCESS EXTERNAL (MANUAL),PROCESS SCREEN;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;**14,35**;NOV 17, 1993
EP ; -- Main entry point for the list processor
 K XQORS,VALMEVL
 N VALMCNT S VALMCNT=0
 D EN^VALM("VAQ PROCESS PDX3")
 QUIT
 ;
INIT ; -- Builds array of PDX transactions for manual processing
 ;    (transactions with status VAQ-PROC)
 ;    NOTE: VAQ-PROC is a hard coded mnemonic, ^VAT(394.85,
 ;
 K ^TMP("VAQR3",$J),^TMP("VAQR3","VAQIDX",$J)
 N STATPT,TRDE,NODE,ND,X,Y,K,J,DATETIME,SEGMENT,SEGDE,SEG,SDI,VALMY,SDAT
 N VAQECNT,VAQTRNO,VAQPTNM,VAQISSN,VAQIDOB,VAQEDOB,VAQPTID,VAQAUST
 N VAQAUADD,VAQRES,VAQTRDE,VAQDFN,VAQDOM,VAQSIG,VAQTRN,VAQESSN,VAQLMT
 N VAQRST,VAQCST
 ;
 D:$D(XRTL) T0^%ZOSV
 S (STATPT,TRDE,RELPTR)="",(VAQECNT,VALMCNT)=0
 S STATPT=$O(^VAT(394.85,"B","VAQ-PROC",STATPT))
 S RELPTR=$O(^VAT(394.85,"B","VAQ-RQACK",RELPTR))
 F  S TRDE=$O(^VAT(394.61,"STATUS",STATPT,TRDE))  Q:TRDE=""  D SETD
 I VAQECNT=0 D
 .S VAQTRNO=0,X=$$SETSTR^VALM1(" ","",1,79) D TMP
 .S X=$$SETSTR^VALM1(" ** No pending transactions queued for manual processing... ","",1,80) D TMP
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV
 QUIT
 ;
SETD ; -- Set data for display in list processor
 ; -- Filter out transactions marked as purged OR exceed life cap
 S VAQFLAG=$$EXPTRN^VAQUTL97(TRDE)
 Q:VAQFLAG=1
 Q:$$CLOSTRAN^VAQUTL97(TRDE,"RQST2")  ; Filter out (and mark for purging) transactions from closed domains.
 F ND=0,"QRY","RQST1","RQST2","ATHR1","ATHR2" S NODE(ND)=$G(^VAT(394.61,TRDE,ND))
 ; -- release status set, skip entry
 S VAQCST=+$P(NODE(0),U,2),VAQRST=+$P(NODE(0),U,5)
 I ($P($G(^VAT(394.85,VAQCST,0)),U,1)'="VAQ-PROC") QUIT
 I ($P($G(^VAT(394.85,VAQRST,0)),U,1)'="VAQ-RQACK") QUIT
 D SETD1
 D SEG^VAQEXT06 ; -- gather segments
 D DISDEMO
 D DISSEG
 S X=$$SETSTR^VALM1(" ","",1,80) D TMP ; -- null line
 D DISMAX^VAQEXT06
 S X=$$SETSTR^VALM1(" ","",1,80) D TMP ; -- null line
 QUIT
 ;
SETD1 ; -- Extracts data for display
 S VAQTRNO=$P(NODE(0),U,1)
 S (Y,VAQTDTE)=$P(NODE("RQST1"),U,1)
 X ^DD("DD") S DATETIME=Y_" (Rq)"
 S VAQDOM=$P(NODE("RQST2"),U,1)
 S VAQPTNM=$P(NODE("QRY"),U,1)
 S VAQISSN=$P(NODE("QRY"),U,2)
 S VAQIDOB=$P(NODE("QRY"),U,3),VAQEDOB=$$DOBFMT^VAQUTL99(VAQIDOB)
 S VAQPTID=$P(NODE("QRY"),U,4)
 S VAQRQST=$P(NODE("RQST2"),U,1),VAQRQADD=$P(NODE("RQST2"),U,2)
 I VAQISSN'="" S VAQRES=$$RES^VAQUTL99(VAQRQADD,VAQISSN) ;-- reason for manual
 I VAQISSN="" S VAQRES=$$RES^VAQUTL99(VAQRQADD,VAQPTNM) ;-- reason for manual
 ; -- Check to see if requested segments exceed max time/occurrence limits
 ;W !,"VAQRES = ",VAQRES
 I $P(VAQRES,U,1)>0 D
 .S VAQLMT=$$AUTO^VAQEXT05(TRDE)
 .I (+VAQLMT)<0 S VAQRES=VAQLMT
 QUIT
 ;
DISDEMO ; -- Displays the entries requiring manual process
 S VAQECNT=VAQECNT+1
 S X=$$SETSTR^VALM1("Entry #   : "_VAQECNT,"",1,39)
 S X=$$SETSTR^VALM1("  Trans #: "_VAQTRNO,X,40,39) D TMP
 S X=$$SETSTR^VALM1("Patient   : "_VAQPTNM,"",1,39)
 S X=$$SETSTR^VALM1("Date/Time: "_DATETIME,X,40,39) D TMP
 I VAQPTID="" D
 .S VAQESSN=$$DASHSSN^VAQUTL99(VAQISSN)
 .S X=$$SETSTR^VALM1("Patient SS: "_VAQESSN,"",1,39)
 S:VAQPTID'="" X=$$SETSTR^VALM1("Patient ID: "_VAQPTID,"",1,39)
 S X=$$SETSTR^VALM1("      DOB: "_VAQEDOB,X,40,39) D TMP
 S X=$$SETSTR^VALM1("Domain    : "_VAQDOM,"",1,39)
 S X=$$SETSTR^VALM1("   Reason: "_$P(VAQRES,U,2),X,40,39) D TMP
 QUIT
 ;
DISSEG ; -- Displays selected segments
 F K=0:0 S K=$O(SEGMENT($J,K))  Q:K=""  D
 .S SEGMENT=SEGMENT($J,K)
 .I K=1 S X=$$SETSTR^VALM1("Segments  : "_SEGMENT,"",1,80) D TMP
 .I K'=1 S X=$$SETSTR^VALM1("          : "_SEGMENT,"",1,80) D TMP
 QUIT
 ;
TMP ; -- Set the array used by list processor
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQR3",$J,VALMCNT,0)=$E(X,1,79)
 S ^TMP("VAQR3",$J,"IDX",VALMCNT,VAQECNT)=""
 S ^TMP("VAQR3","VAQIDX",$J,VAQECNT)=VALMCNT_"^"_VAQTRNO
 Q
 ;
HD ; -- Make header line for list processor
 S VALMHDR(1)="PDX Activity Requiring Manual Processing"
 QUIT
 ;
EXIT ; -- Task entries for batch processing, Cleans up variables 
 I $D(VAQTRN) D TASK^VAQEXT04
 ;
 K ^TMP("VAQR3",$J),^TMP("VAQR3","VAQIDX",$J)
 K STATPT,TRDE,NODE,ND,X,Y,K,J,DATETIME,SEGMENT,SEGDE,SEG,SDI,VALMY,SDAT
 K VAQECNT,VAQTRNO,VAQPTNM,VAQISSN,VAQIDOB,VAQEDOB,VAQPTID,VAQAUST
 K VAQAUADD,VAQRES,VAQTRDE,VAQDFN,VAQDOM,VAQSIG,VAQTRN
 K VAQFLAG,VAQTDTE,VAQESSN,VAQLMT
 K RELPTR,VAQCST,VAQRST
 Q
 ;
END ; -- End of code
 QUIT
