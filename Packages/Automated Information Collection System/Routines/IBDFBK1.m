IBDFBK1 ;ALB/AAS - AICS broker Utilities ;23-May-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
GETFS(RESULT,IBDF) ;
 ; -- broker call back to return the formspec in IBDFS for form FORMID
 ;
 N FORMID,START,STOP,GLB,IBD
 ;
 S FORMID=$G(IBDF("FORMID"))
 S START=$G(IBDF("START"),0) ; Default is zero
 S STOP=$G(IBDF("STOP"),50) ; Default is 50
 ;S GLB=$G(IBDF("GLB")) ; Pass in global later.
 ;
 I $G(FORMID)="" S RESULT(1)="$$FORMID INVALID$$" G GETFSQ
 I +FORMID'=FORMID S FORMID=$E($P(FORMID,"."),3,8)
 I +FORMID<1 S RESULT(1)="$$FORMID INVALID$$" G GETFSQ
 ;
 K RESULT
 I '$D(^IBD(359.2,FORMID,10)) D SCAN^IBDFBKS(FORMID)
 I '$D(^IBD(359.2,FORMID,10)) S RESULT(1)="$$FORMID INVALID$$" G GETFSQ
 ;
 F IBD=START:1:STOP S RESULT(IBD)=$G(^IBD(359.2,FORMID,10,IBD,0)) I RESULT(IBD)="",$O(^IBD(359.2,FORMID,10,IBD))="" S RESULT(IBD)="$$END$$" Q
 ;
GETFSQ Q
 ;
IMAGEID(RESULT,TEST) ;
 ; -- broker call back to return the next image id to save unknonw forms
 S RESULT=0
 L +^IBD(357.97,.03):2
 S RESULT=$P(^IBD(357.97,1,0),"^",3)+1
 S:RESULT<1 RESULT=1 S:RESULT>999999 RESULT=1
 S $P(^IBD(357.97,1,0),"^",3)=RESULT
 L -^IBD(357.97,.03)
 Q
 ;
ETIME(RESULT,IBDF) ; -- broker call back
 ; -- store elapsed time and user inputting data
 ; -- called by manual data entry (ibdfde1)
 ;
 N NODE
 S RESULT=0
 I '$G(IBDF("FORM")) G ETQ
 S NODE=$G(^IBD(357.96,+IBDF("FORM"),0)) I NODE="" G ETQ
 S FDAROOT(357.96,+IBDF("FORM")_",",.15)=$G(IBDF("SECONDS"))+$P(NODE,"^",15)
 I $P(NODE,"^",16)="" S FDAROOT(357.96,+IBDF("FORM")_",",.16)=$G(IBDF("USER"))
 D FILE^DIE("","FDAROOT","IBDFERR")
 S RESULT=1
 K PXCA
ETQ Q
 ;
WSERR(RESULT,FORMID) ; -- broker call back
 ; -- store error occuring on workstation
 ;    occures when user cancels recognition.
 ;
 S FORMID=+$G(FORMID("FORMID")),FORMID("SOURCE")=1
 D LOGERR^IBDF18E2(FORMID("ERRNO"),.FORMID)
 S RESULT=1
WSERRQ Q
 ;
IMAGENM(RESULT,IBDF) ; -- broker call back
 ; -- store names of images stored and their location
 ;    along with the form id information
 ;
 N X,Y,NAME,PATH,FDA,IENS,FDAIEN,IBDERR
 S RESULT=0
 I $G(^IBD(357.96,+$G(IBDF("FORMID")),0))=""!($G(IBDF("IMAGE"))="") G IMGNMQ
 ;
 F I=1:1 S X=$P(IBDF("IMAGE"),"\",I) Q:X=""  S NAME=$P(IBDF("IMAGE"),"\",I),PATH=$P(IBDF("IMAGE"),"\",1,I-1)
 S IENS="+1,"_IBDF("FORMID")_","
 S FDA(357.963,IENS,.01)=NAME
 S FDA(357.963,IENS,.02)=PATH
 S FDA(357.963,IENS,.03)=$G(IBDF("PAGE"))
 S FDA(357.963,IENS,.04)=$G(IBDF("WSID"))
 S FDA(357.963,IENS,.05)=$G(DUZ)
 S FDA(357.963,IENS,.06)=$$NOW^XLFDT
 ;
 ; -- flag is as received if page already received
 S SCANPG=+$O(^IBD(357.96,IBDF("FORMID"),9,"B",IBDF("PAGE"),0))
 I $P($G(^IBD(357.96,+$G(IBDF("FORMID")),9,SCANPG,0)),"^",2) S FDA(357.963,IENS,.07)=1
 ;
 D UPDATE^DIE("","FDA","FDAIEN","IBDERR")
 I '$D(IBDERR) S RESULT=1
IMGNMQ Q
 ;
FORMID(RESULT,FORMNO) ;
 ; -- broker call back to turn a formId into patient name/ssn/clinic/appt/formtype/status
 ;
 N IBID
 S RESULT="^^^^"
 S IBID=+$P($G(FORMNO)," ",3)
 Q:'$G(IBID)
 S RESULT=$$FINDPT^IBDF18C(IBID)
 Q
 ;
VALIDAV(IBDUSER,IBDFKEY) ;
 ; -- broker call back to validate security key, make sure duz array set
 ;    for xwb1t17
 ; -- Output User Info 
 ;    Piece 1 = DUZ           Piece 4 = Site
 ;    Piece 2 = DUZ(0)        Piece 5 = UCI/VOL
 ;    Piece 3 = UserName      Piece 6 = Security key if held
 ;
 ; -- Invalid User codes
 ;    piece 1 = 0  =: Null or "^" in codes
 ;    piece 1 = -1 =: Invalid access code pair
 ;    piece 1 = -2 =: Invalid user (terminated, etc.)
 ;
 I '$D(DT) D DT^DICRW
 N X,Y,KEY,XUM,XUSER,XQUR,XUF,XUENV,NODE
 S NODE=$G(^VA(200,+$G(DUZ),0))
 D UCI^%ZOSV S UCI=Y
 S KEY=""
 I $G(IBDFKEY)'="" I $D(^XUSEC(IBDFKEY,+DUZ)) S KEY=IBDFKEY
 S IBDUSER=DUZ_"^"_$P(NODE,"^",4)_"^"_$P(NODE,"^")_"^"_$P($$SITE^VASITE,"^",2)_"^"_UCI_"^"_KEY
 Q
 ;
SECM(RESULT,IBDUZ) ;
 ; -- broker call back to return array of secondary menus in array RESULT
 ;
 I +$G(IBDUZ)<1 S RESULT(1)="No user Identified" G SECMQ
 ;
 N COUNT,MENU,IEN
 S COUNT=0,MENU=0
 F  S MENU=$O(^VA(200,+IBDUZ,203,MENU)) Q:'MENU  D
 . S IEN=+$G(^VA(200,+IBDUZ,203,MENU,0))
 . S COUNT=COUNT+1,RESULT(COUNT)=$$GET1^DIQ(19,+IEN,.01) I RESULT(COUNT)']"" S RESULT(COUNT)="Unknown"
 ;
 I COUNT<1 S RESULT(1)="No Secondary Menus"
 ;
SECMQ Q
 ;
TESTI ; -- test storing image name
 S IBDF("IMAGE")="c:\vista\aics\a8001.tif"
 S IBDF("WSID")="A"
 S IBDF("PAGE")=1
 S IBDF("FORMID")=800
 D IMAGENM(.RESULT,.IBDF)
 Q
