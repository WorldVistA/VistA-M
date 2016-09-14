SDECERR ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ;  ERROR  = General error catch routine used by @^%ZOSF("TRAP")
 ;  ERR    = Error logging routine
 ;
ERROR ;
 D ERR("Error")
 Q
 ;
ERR(SDECERR) ;Error processing
 ; SDECERR = Error text OR error code
 ; SDECI   = pointer into return global array (might decide to pass this in for clarity)
 I +SDECERR S SDECERR=SDECERR+134234112 ;vbObjectError
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECERR_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
ERR1(ERRCODE,ERRTXT,SDECI,SDECY) ;Error processing
 ; ERRCODE = represents Return code in first ^ piece
 ; ERRTXT  = represents Message text in 2nd ^ piece
 ; SDECI   = pointer into return global array
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=ERRCODE_"^"_ERRTXT_$C(30,31)
 Q
