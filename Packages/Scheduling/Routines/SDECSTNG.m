SDECSTNG ; ALB/WTC - VISTA SCHEDULING - Settings Utilities ;MAY 16,2018@09:48
 ;;5.3;Scheduling;**694,756**;;Build 43
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q  ;
 ;
HELPLINK(SDECY)   ;
 ;
 ;  Extract help text and URLs from SDEC Settings file (#409.98)
 ;
 N SDECI,CTR ;
 S SDECI=0 ;
 S SDECY="^TMP(""SDECSTNG"","_$J_",""HELPLINK"")" ;
 K @SDECY ;
 S @SDECY@(SDECI)="T00030ID^T00030TEXT^T00255URL"_$C(30) ;
 ;
 ;  Get help text, url and source for the national hyperlinks
 ;
 S CTR=0 D LOAD(1) ;
 ;
 ;  Get help text, url and source for the local hyperlinks
 ;
 D LOAD(2) ;
 ;
 ;  Return links
 ;
 S SDECI=SDECI+1 ;
 S @SDECY@(SDECI)=$C(31)
 Q
 ;
LOAD(SITE) ;
 ;
 ;  Load URLs for a site into output array.
 ;
 N DA,X,Y ;
 S DA=0 F  S DA=$O(^SDEC(409.98,SITE,1,DA)) Q:'DA  D  ;
 . ;
 . ;  Generate link based on type, address and mail subject.
 . ;
 . S CTR=CTR+1,X=CTR_"^"_$P(^SDEC(409.98,SITE,1,DA,0),"^",1)_"^" ;
 . S X=X_$S($P(^SDEC(409.98,SITE,1,DA,0),"^",2)=1:"http://",$P(^(0),"^",2)=2:"https://",$P(^(0),"^",2)=3:"mailto:",1:"")_^(1) ;
 . ;
 . ;  If link is a mail link with a subject, append "?subject=" and the encoded subject.
 . ;
 . I $G(^SDEC(409.98,SITE,1,DA,2))'="" S Y=^(2) X "S Y=$ZCONVERT(Y,""O"",""URL"")" S X=X_"?subject="_Y ;
 . S SDECI=SDECI+1,@SDECY@(SDECI)=X_$C(30) Q  ;
 Q
 ;
SERVER ; Entry point for server option to kick off file update.
 ;
 ;  Update SDEC Settings file (#409.98) from messages sent through SDECSETTINGS mail group.
 ;
 ;  SD*5.3*694 wtc/zeb  8/29/2018
 ;
 ; ID of triggering message is in assumed variable XMZ 
 ; Call to XMXAPI covered by IA #2729
 ; Call to XMXUTIL2 covered by IA #2736
 ;
 N MESSAGE,SDECXMZ,X,GUIVERS,EFFDATE,Y,CMTLNGTH,I,HASHTAG,CMTTEXT,ACTION,DIC,DIK,DA,STOPCODE ;
 ;
 S SDECXMZ=$G(XMZ) Q:SDECXMZ=""  ;  Message unknown.
 ;
 D:$$SUBJ^XMXUTIL2($G(^XMB(3.9,SDECXMZ,0)))["SDEC SETTINGS REMOTE UPDATE"  ;
 . ;
 . ;  Check message text for action to take.
 . ;
 . ;F I=1:1 Q:$G(^XMB(3.9,SDECXMZ,2,I,0))=""  S MESSAGE=^(0) D  ;
 . N XMZ,XMER S XMZ=SDECXMZ F  S MESSAGE=$$READ^XMGAPI1() Q:XMER<0  D  ;    Modified to use MailMan API - 756 WTC 7/23/2020 - ICR #1048
 .. ;
 .. ;  Process version change.  Data is "VERSION^version number^effective date (external)"
 .. ;
 .. I $P(MESSAGE,U,1)="VERSION" D  Q  ;
 ... S GUIVERS=$P(MESSAGE,U,2),EFFDATE=$P(MESSAGE,U,3) ;
 ... S Y=$$NETTOFM^SDECDATE(EFFDATE,"N") ;
 ... S $P(^SDEC(409.98,2,0),"^",2,3)=GUIVERS_"^"_Y ;
 .. ;
 .. ;  Process changes to canned comments.  Data is "CANCELLATION COMMENT^action^hash tag^text equivalent"
 .. ;  "action" can be "ADD" or "DELETE".
 .. ;
 .. I $P(MESSAGE,U,1)="CANCELLATION COMMENT" D  Q  ;
 ... S ACTION=$P(MESSAGE,U,2),HASHTAG=$$STRIP($P(MESSAGE,U,3)),CMTTEXT=$$STRIP($P(MESSAGE,U,4)) ;
 ... ;
 ... I ACTION="ADD" D  Q  ;
 .... I CMTTEXT="" D APPERROR^%ZTER("Entry ("_HASHTAG_") could not be added to file #409.88.  Text missing.") Q  ;
 .... S DA=0 F  S DA=$O(^SDEC(409.88,"B",HASHTAG,DA)) Q:'DA  Q:$P(^SDEC(409.88,DA,0),U,3)=1  ;  Find national hashtag match
 .... I DA D APPERROR^%ZTER("Entry ("_HASHTAG_") could not be added to file #409.88.  It already exists.") Q  ;
 .... K DIC,DA S X=HASHTAG,DIC="^SDEC(409.88,",DIC(0)="L",DIC("DR")="1///"_CMTTEXT_";2///1" D FILE^DICN Q:Y>0  ;
 .... D APPERROR^%ZTER("Entry ("_HASHTAG_") could not be added to file #409.88") Q  ;
 ... ;
 ... I ACTION="DELETE" D  Q  ;
 .... K DIK,DA ;
 .... S DIK="^SDEC(409.88," ;
 .... S DA=0 F  S DA=$O(^SDEC(409.88,"B",HASHTAG,DA)) Q:'DA  Q:$P(^SDEC(409.88,DA,0),U,3)=1  ;  Find national hashtag match
 .... I 'DA D APPERROR^%ZTER("Entry ("_HASHTAG_") not on file for deletion from file #409.88") Q  ;
 .... D ^DIK ;
 .. ;
 .. ;  Process changes to VVC stop codes.  Data is "VVC STOP CODE^action^stop code^"
 .. ;  "action" can be "ADD" or "DELETE".
 .. ;
 .. I $P(MESSAGE,U,1)="VVC STOP CODE" D  Q  ;
 ... S ACTION=$P(MESSAGE,U,2),STOPCODE=$$STRIP($P(MESSAGE,U,3)) ;
 ... ;
 ... I 'STOPCODE D APPERROR^%ZTER("Invalid stop code ("_STOPCODE_").  No action taken in file #409.98") Q  ;
 ... I '$O(^DIC(40.7,"C",STOPCODE)) D APPERROR^%ZTER("Undefined stop code ("_STOPCODE_").  No action taken in file #409.98") Q  ;
 ... ;
 ... I ACTION="ADD" D  Q  ;
 .... S DA=$O(^SDEC(409.98,1,3,"B",STOPCODE,0)) ;  Find stop code
 .... I DA D APPERROR^%ZTER("Stop code ("_STOPCODE_") could not be added to file #409.98.  It already exists.") Q  ;
 .... K DIC,DA S DA(1)=1,X=STOPCODE,DIC="^SDEC(409.98,1,3,",DIC(0)="L" D FILE^DICN Q:Y>0  ;
 .... D APPERROR^%ZTER("Stop code ("_STOPCODE_") could not be added to file #409.98") Q  ;
 ... ;
 ... I ACTION="DELETE" D  Q  ;
 .... K DIC,DIK,DA ;
 .... S DA(1)=1,DA=$O(^SDEC(409.98,1,3,"B",STOPCODE,0)) ;  Find stop code
 .... I 'DA D APPERROR^%ZTER("Stop code ("_STOPCODE_") not on file for deletion from file #409.98") Q  ;
 .... S DIK="^SDEC(409.98,1,3," ;
 .... D ^DIK ;
 ;
 N ZTREQ ;
 D ZAPSERV^XMXAPI("S.SDEC SETTINGS REMOTE UPDATE",SDECXMZ) ;
 S ZTREQ="@" ;
 Q  ;
 ;
STRIP(X) ;  Strip off trailing spaces.
 ;
 I $E(X,$L(X))=" " S X=$E(X,1,$L(X)-1),X=$$STRIP(X) ;
 Q X ;
 ;
