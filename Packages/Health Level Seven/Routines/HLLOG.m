HLLOG ;OIFO-O/JLG - (LOG API) ;11/24/2003  16:48
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 Q
 ;
ENTERING(RTN,SUB,COOKIE) ;
 ; RTN -    the routine from which called 
 ; SUB -    the subroutine from which called 
 ; COOKIE - current session id as $H; to be used subsequently 
 ;          in EXITING^HLLOG
 ;
 N SITE,XTMP
 Q:'$$ENABLED
 Q:$G(RTN)=""  Q:$G(SUB)=""  Q:$G(COOKIE)=""
 S SITE=+$P($$SITE^VASITE,U,3)
 S XTMP="HL LOG "_DT
 S:'$D(^XTMP(XTMP,0)) ^XTMP(XTMP,0)=$$FMADD^XLFDT(DT,30)_U_$$NOW^XLFDT_U_"Log data created by call to HLLOG"
 S COOKIE=$H
 S ^XTMP(XTMP,SITE,RTN,SUB,$J,COOKIE,"ENTER")=$$STATS^%ZOSVKR
 Q
 ;
EXITING(RTN,SUB,COOKIE) ;
 ; RTN -    the routine from which called 
 ; SUB -    the subroutine from which called 
 ; COOKIE - current session id as $H; previously used in ENTERING^HLLOG 
 ;
 Q:'$$ENABLED
 Q:$G(RTN)=""  Q:$G(SUB)=""  Q:$G(COOKIE)=""
 S SITE=+$P($$SITE^VASITE,U,3)
 S XTMP="HL LOG "_DT
 S:'$D(^XTMP(XTMP,0)) ^XTMP(XTMP,0)=$$FMADD^XLFDT(DT,30)_U_$$NOW^XLFDT_"U"_"Log data created by call to HLLOG"
 S ^XTMP(XTMP,SITE,RTN,SUB,$J,COOKIE,"EXIT")=$$STATS^%ZOSVKR_U_$$HDIFF^XLFDT($H,COOKIE,2)
 Q
 ;
ENABLED() ;
 ; check that this functionality is enabled
 ;Q $P(^HLCS(869.3,1,0),U,6)
 Q 1
 ;
