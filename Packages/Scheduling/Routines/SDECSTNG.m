SDECSTNG ; ALB/WTC - VISTA SCHEDULING - Settings Utilities ;MAY 16,2018@09:48
 ;;5.3;Scheduling;**694**;;Build 61
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
 N SDECXMZ,X,GUIVERS,EFFDATE,Y,CMTLNGTH,I ;
 ;
 S SDECXMZ=$G(XMZ) Q:SDECXMZ=""  ;  Message unknown.
 ;
 D:$$SUBJ^XMXUTIL2($G(^XMB(3.9,SDECXMZ,0)))["SDEC SETTINGS REMOTE UPDATE"  ;
 . ;
 . ;  Check message text for action to take.
 . ;
 . F I=1:1 Q:$G(^XMB(3.9,SDECXMZ,2,I,0))=""  S X=^(0) D  ;
 .. ;
 .. ;  Process version change.  Data is "VERSION^version number^effective date (external)"
 .. ;
 .. I $P(X,"^",1)="VERSION" D  Q  ;
 ... S GUIVERS=$P(X,"^",2),EFFDATE=$P(X,"^",3) ;
 ... S Y=$$NETTOFM^SDECDATE(EFFDATE,"N") ;
 ... S $P(^SDEC(409.98,2,0),"^",2,3)=GUIVERS_"^"_Y ;
 ;
 N ZTREQ ;
 D ZAPSERV^XMXAPI("S.SDEC SETTINGS REMOTE UPDATE",SDECXMZ) ;
 S ZTREQ="@" ;
 Q  ;
 ;
