USRLM1 ; SLC/MAM - User Class Membership functions and proc's Cont ; 03/04/10
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**33**;Jun 20, 1997;Build 7
 ;======================================================================
WHOISTMP(CLASS,NAME01) ; Given a Class, return list of CURRENT members into ^TMP
 ; Uses 8930.3 xref ACU
 ; CLASS is pointer to file 8930
 ; MEMBER is name of array (local or global) in which members are
 ;        returned in order by user/x-ref by name
 ;        main = ^tmp("USRWHO",$j,"USRWHO2",user)
 ;        x-ref= ^tmp("USRWHO",$j,"USRWHO2","b",usrnm,user)
 ;  -- used by whois2 call
 ; NAME01 is optional. If NAME01>0 use .01 Class Name in returned data.
 N USER,USRNM,USRCLNM,USRCNT,USRDA,EFFCTV,EXPIRES,USRI,USRMC,USRTIT,IENS
 S USER=0,USRCNT=+$P($G(@MEMBER@(0)),U,3)
 F  S USER=$O(^USR(8930.3,"ACU",CLASS,USER)) Q:+USER'>0  D
 . S USRDA=$O(^USR(8930.3,"ACU",CLASS,USER,0)) Q:+USRDA'>0  ;User membership DA
 . S EFFCTV=$P($G(^USR(8930.3,+USRDA,0)),U,3)
 . S EXPIRES=$P($G(^USR(8930.3,+USRDA,0)),U,4)
 . S USRNM=$$PERSNAME(+USER)
 . S IENS=+USER_",",USRTIT=$$GET1^DIQ(200,IENS,8,,,"ERR") ; Title ICR 10060
 . S USRMC=$$GET1^DIQ(200,IENS,28,,,"ERR") ;MAIL CODE ICR 10060
 . S USRCLNM=$$CLNAME^USRLM(+CLASS,+$G(NAME01))
 . S ^TMP("USRWHO",$J,"USRWHO2",USER)=USER_U_USRDA_U_USRCLNM_U_EFFCTV_U_EXPIRES_U_USRNM_U_USRTIT_U_USRMC
 . S ^TMP("USRWHO",$J,"USRWHO2","B",USRNM,USER)=""
 . S USRCNT=+$G(USRCNT)+1
 I '$D(^TMP("USRWHO",$J,"USRWHO2",0))#2 S ^TMP("USRWHO",$J,"USRWHO2",0)=CLASS_U_$P($G(^USR(8930,+CLASS,0)),U)_U
 S $P(^TMP("USRWHO",$J,"USRWHO2",0),U,3)=USRCNT
 S USRI=0 F  S USRI=$O(^USR(8930,+CLASS,1,USRI)) Q:+USRI'>0  D
 . N USRSUB S USRSUB=+$G(^USR(8930,+CLASS,1,USRI,0)) Q:+USRSUB'>0
 . D WHOISTMP(USRSUB,+$G(NAME01)) ; Recurs to find members of subclass
 Q
 ;====================================================================== 
WHOIS1(MEMBER,CLASS,NAME01) ; Given a Class, return list of CURRENT members.
 ;Used in CANDEL^USRLM but can't find where CANDEL is used. 
 ; WHOIS2^USRLM does the same thing more efficiently.  Putting WHOIS here just in case...
 ; CLASS is pointer to file 8930
 ; MEMBER is name of array (local or global) in which members are
 ;        returned in alphabetical order by name
 ; NAME01 is optional. If NAME01>0 use .01 Class Name, not Display name.
 N USER,USRCLNM,USRCNT,USRDA,EFFCTV,EXPIRES,USRI,USRNAME,EFFCTV1,EXPIRES1
 K ^TMP("USRWHOIS",$J)
 S USER=0,USRCNT=+$P($G(@MEMBER@(0)),U,3)
 F  S USER=$O(^USR(8930.3,"ACU",CLASS,USER)) Q:+USER'>0  D
 . S USRDA=""
 . F  S USRDA=$O(^USR(8930.3,"ACU",CLASS,USER,USRDA)) Q:USRDA=""  D
 .. S EFFCTV=$P($G(^USR(8930.3,+USRDA,0)),U,3) S:EFFCTV="" EFFCTV1="0000000"
 .. S EXPIRES=$P($G(^USR(8930.3,+USRDA,0)),U,4) S:EXPIRES="" EXPIRES1=9999999
 .. S USRCLNM=$$CLNAME^USRLM(+CLASS,+$G(NAME01))
 .. S USRNAME=$$GET1^DIQ(200,USER,.01)
 .. S ^TMP("USRWHOIS",$J,USRNAME,$S(EFFCTV="":EFFCTV1,1:EFFCTV),$S(EXPIRES="":EXPIRES1,1:EXPIRES))=USER_U_USRDA_U_USRCLNM_U_EFFCTV_U_EXPIRES
 .. S USRCNT=+$G(USRCNT)+1
 I $D(^TMP("USRWHOIS",$J)) D
 . S USRNAME="" F  S USRNAME=$O(^TMP("USRWHOIS",$J,USRNAME)) Q:USRNAME=""  D
 .. S EFFCTV="" F  S EFFCTV=$O(^TMP("USRWHOIS",$J,USRNAME,EFFCTV)) Q:EFFCTV=""  Q:EFFCTV>DT  D
 ... S EXPIRES="" F  S EXPIRES=$O(^TMP("USRWHOIS",$J,USRNAME,EFFCTV,EXPIRES),-1) Q:EXPIRES=""  Q:EXPIRES<DT  D
 .... S @MEMBER@(USRNAME)=$G(^TMP("USRWHOIS",$J,USRNAME,EFFCTV,EXPIRES))
 I '$D(@MEMBER@(0)) S @MEMBER@(0)=CLASS_U_$P($G(^USR(8930,+CLASS,0)),U)_U
 S $P(@MEMBER@(0),U,3)=USRCNT
 S USRI=0 F  S USRI=$O(^USR(8930,+CLASS,1,USRI)) Q:+USRI'>0  D
 . N USRSUB S USRSUB=+$G(^USR(8930,+CLASS,1,USRI,0)) Q:+USRSUB'>0
 . D WHOIS1(MEMBER,USRSUB,+$G(NAME01)) ; Recurs to find members of subclass
 K ^TMP("USRWHOIS",$J)
 Q
PERSNAME(USER) ; Receives pointer to 200, returns name field
 N X S X=$$GET1^DIQ(200,USER,.01) ; ICR 10060
 Q $S($L(X):X,1:"UNKNOWN")
