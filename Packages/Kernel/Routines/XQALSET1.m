XQALSET1 ;ISC-SF.SEA/JLI - SETUP ALERTS (OVERFLOW) ;4/9/07  10:26
 ;;8.0;KERNEL;**285,443**;Jul 10, 1995;Build 4
 ;;
 Q
GROUP ;
 N XQI,XQL,XQL1,XQL2,XQLIST
 S XQL=$E(XQJ,3,$L(XQJ)) ; P443 - changed from code that forced upper case
 I $D(^TMP("XQAGROUP",$J,XQL)) Q  ; P443 group has already been processed - prevent cycling
 S ^TMP("XQAGROUP",$J,XQL)="" ; P443 mark that the group has been seen
 S XQI=$$FIND1^DIC(3.8,,"X",XQL) Q:XQI'>0
 N XQLIST D LIST^DIC(3.81,","_XQI_",",".01","I",,,,,,,.XQLIST) I XQLIST("ORDER")>0 D
 . N XQI F XQI=0:0 S XQI=$O(@XQLIST@("ID",XQI)) Q:XQI'>0  S XQA(^(XQI,.01))=""
 . Q
 K @XQLIST,XQLIST D LIST^DIC(3.811,","_XQI_",",".01",,,,,,,,.XQLIST) I XQLIST("ORDER")>0 D
 . N XQAGROUP M XQAGROUP=@XQLIST@("ID") ; P443 - store group list data locally so it is not over written by recursive call to LIST^DIC
 . N XQI F XQI=0:0 S XQI=$O(XQAGROUP(XQI)) Q:XQI'>0  N XQJ S XQJ="G."_XQAGROUP(XQI,.01) D GROUP ; P443 - change to reference XQAGROUP
 . Q
 K @XQLIST,XQLIST
 K XQA(XQJ)
 D CHEKACTV(.XQA)
 Q
 ;
 ; Check and remove any entries in array that don't have active surrogates and aren't active
CHEKACTV(XQARRAY) ;
 N XQJ
 F XQJ=0:0 S XQJ=$O(XQARRAY(XQJ)) Q:XQJ'>0  I $$CHEKUSER(XQJ)'>0 K XQARRAY(XQJ)
 Q
 ;
CHEKUSER(XQAUSER) ; Returns 0 if no valid user or surrogate, otherwise returns IEN of user or surrogate
 N VALUE
 S VALUE=$$ACTVSURO^XQALSURO(XQAUSER)
 I VALUE'>0 S VALUE=XQAUSER I '$$ACTIVE^XUSER(XQAUSER) Q 0
 Q VALUE
 ;
