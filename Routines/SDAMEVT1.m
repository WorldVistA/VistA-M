SDAMEVT1 ;ALB/MJK - Appt Event Driver Utilities ; 12/1/91
 ;;5.3;Scheduling;**15,63,132**;Aug 13, 1993
 ;
DIV(DIV) ; -- division name
 ; input:  DIV := ifn of med ctr div
 ;
 Q $S('$P($G(^DG(43,1,"GL")),U,2):"",$D(^DG(40.8,+DIV,0)):" ("_$P(^(0),U)_")",1:"")
 ;
OENUL(SDCAP,SDHDL) ; -- null befores or afters
 N SDOE,SDORG
 S SDORG=0
 F  S SDORG=$O(^TMP("SDEVT",$J,SDHDL,SDORG)) Q:'SDORG  D
 .S SDOE=0
 .F  S SDOE=$O(^TMP("SDEVT",$J,SDHDL,SDORG,"SDOE",SDOE)) Q:'SDOE  D
 ..I $D(^TMP("SDEVT",$J,SDHDL,SDORG,"SDOE",SDOE,0,SDCAP)) S ^(SDCAP)=""
 Q
