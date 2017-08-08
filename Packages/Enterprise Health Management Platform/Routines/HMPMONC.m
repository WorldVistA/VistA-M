HMPMONC ;ASMR/BL, change auto-refresh rate ;Sep 13, 2016 20:03:08
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6644 - routine refactored, 7 September 2016
 ;
C ; monitor action: change auto-refresh rate
 ;   issues prompt to user
 D TED^XPAREDIT("HMPMON DASHBOARD USR","AB",DUZ_";VA(200,") S HMPRATE=$$RATE ; set new auto-refresh rate
 Q
 ;
RATE() ; extrinsic variable, return auto-refresh rate
 N RATE ; auto-refresh rate
 ; the 1 below indicates one per entity, "I" is internal format
 S RATE=$$GET^XPAR("ALL","HMPMON DASHBOARD UPDATE",1,"I")  ; get parameter
 S:RATE="" RATE=30  ; default to 30 seconds
 Q RATE
 ;
SETSYS ; HMPMON SET SYS DASHBOARD RATE option, interactive
 N HMPSYSN S HMPSYSN=$$GET1^DIQ(8989.3,"1,",.01,"I")  ; DOMAIN NAME from KERNEL SYSTEM PARAMETERS file
 D TED^XPAREDIT("HMPMON DASHBOARD SYS","AB",HMPSYSN_";DIC(4.2,")  ;parameter entity is domain
 Q
 ;
SETPKG ; HMPMON SET PKG DASHBOARD RATE option, interactive
 ; get package name for HMP prefix
 N HMPKGN S HMPKGN=$$FIND1^DIC(9.4,,"QX","HMP","C")  ; lookup by PREFIX, "QX" - quick, exact 
 D TED^XPAREDIT("HMPMON DASHBOARD PKG","AB",HMPKGN_";DIC(9.4,")  ;parameter entity is package
 Q
 ;
