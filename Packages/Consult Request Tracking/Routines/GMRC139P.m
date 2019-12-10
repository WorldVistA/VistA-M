GMRC139P ;ABV/BL - Patch 139 Post-install;08/20/2019
 ;;3.0;CONSULT/REQUEST TRACKING;**139**;DEC 27, 1997;Build 10
 ;
EN ; Entry point for post install
 ;
 ;    IA:5421
 ;   
 ;    XOBWSN    -   REST web service name
 ;    XOBCXT    -   web service context root  
 ;    XOBCAURL  -   'check availability' url portion to follow context root [optional]
 ; Using existing API for changing of WEB SERVICE value
 N XOBWSN,XOBCXT,XOBCAURL
 ;
 S XOBWSN="DST GET ID SERVICE"
 S XOBCXT="vs/v2/consultFactor"
 S XOBCAURL=""
 D REGREST^XOBWLIB(XOBWSN,XOBCXT,XOBCAURL)
 Q
 ;
