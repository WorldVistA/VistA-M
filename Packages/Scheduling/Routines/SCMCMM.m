SCMCMM ;ALB/REW - MailMessages Utilities ; 11/4/99 9:29am
 ;;5.3;Scheduling;**41,177,205**;AUG 13, 1993
 ;1
PCMAIL(DFN,SCARRAY,SCDATE) ;load standard patient pc info into mail message
 ;  DFN     - ptr to Patient File
 ;  SCARRAY - Literal value of XMTEXT ARRAY
 ;  SCDATE  - Date of interest - default=dt
 ;    Returned: Ending Line Count for Array
 ;
 N SCLNCNT,SCPCTM,SCPHONE,SCPCAT,SCPCPR,SCPCAP
 S SCDATE=$G(SCDATE,DT)
 S SCLNCNT=+$O(@SCARRAY@(9999999),-1)  ; the current number of lines
 S SCPCTM=$$NMPCTM^SCAPMCU2(DFN,SCDATE,1)
 I SCPCTM D
 .S SCPHONE=$P($G(^SCTM(404.51,+SCPCTM,0)),U,2)
 .S:$L(SCPHONE) SCPHONE="      Phone: "_SCPHONE
 .S SCPCTM=$P(SCPCTM,U,2)
 .S SCPCAT=$P($$NMPCPR^SCAPMCU2(DFN,SCDATE,2),U,2)
 .S SCPCPR=$P($$NMPCPR^SCAPMCU2(DFN,SCDATE,1),U,2)
 .S SCPCAP=$P($$NMPCPR^SCAPMCU2(DFN,SCDATE,3),U,2)
 IF $L(SCPCTM) D
 .D SETLN(" ")
 .D SETLN("Current Primary Care Management Data: ")
 .D:$L(SCPCTM) SETLN("  PC Team:                "_SCPCTM_SCPHONE)
 .D:$L(SCPCPR) SETLN("  PC Provider(PCP):       "_SCPCPR)
 .D:$L(SCPCAP) SETLN("  Associate Provider(AP): "_SCPCAP)
 .D:$L(SCPCAT) SETLN("  PC Attending:           "_SCPCAT)
 ELSE  D
 .D SETLN(" ")
 .D SETLN("No Current Primary Care Management Data")
END Q SCLNCNT
 ;
SETLN(TEXT) ;
 ;Note - This is not a stand-alone call - needs scarray,sclncnt
 Q:$G(TEXT)=""
 ; increments SCLNCNT, adds text to @scarray@(sclncnt)
 S SCLNCNT=SCLNCNT+1
 ;
 ;djb/bp Some rtns that call this rtn have text array in ARRY(counter)
 ;and others use ARRY(counter,0). Add code to handle both types.
 ;New code begin
 I $D(@SCARRAY@((SCLNCNT-1),0)) S @SCARRAY@(SCLNCNT,0)=TEXT
 E  S @SCARRAY@(SCLNCNT)=TEXT
 ;New code end
 ;Old code begin
 ;S @SCARRAY@(SCLNCNT)=TEXT
 ;Old code end
 ;
 Q
