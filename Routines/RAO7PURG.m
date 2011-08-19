RAO7PURG ;HISC/GJC-Purge order request ;9/5/97  08:58
 ;;5.0;Radiology/Nuclear Medicine;**18**;Mar 16, 1998
 ;;last modification by SS May 9,2000 for P18
EN1(RAOIFN) ; 'RAOIFN' is the ien in file 75.1
 ; Create and send HL7 Purge order request msg to CPRS
 N RA0,RATAB,RAVAR,RAVARBLE
 S RATAB=1 D EN1^RAO7UTL S RA0=$G(^RAO(75.1,RAOIFN,0)) Q:RA0']""
 S RAVAR="RATMP(",RAVARBLE="RATMP"
 ; msh
 S @(RAVAR_RATAB_")")=$$MSH^RAO7UTL("ORM^O01") ;P18 event type
 ; pid
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")=$$PID^RAO7UTL(RA0)
 ; orc
 S RATAB=RATAB+1
 S @(RAVAR_RATAB_")")="ORC"_RAHLFS_"Z@"_RAHLFS_$P(RA0,"^",7)_"^OR"_RAHLFS_RAOIFN_"^RA"
SHIP ; ship message to MSG^RAO7UTL which fires of the HL7 message to CPRS
 D MSG^RAO7UTL("RA EVSEND OR",.@RAVARBLE)
 Q
EN2(RAMSG) ; Process purge message from oe/rr (cprs) to Rad/Nuc Med
 ; Input: RAMSG - HL7 purge request message
 ; ************************* Variables *********************************
 ; RAMSH3=sending facility
 ; RAORC2=<cprs_order_ien>_"^OR"
 ; RAORC3=<rad/nuc med_order_ien>_"^RA"
 ; RAPID3=patient internal identifier (ien)
 ; RAPID5=patient external identifier (name)
 ; *********************************************************************
 D BRKOUT^RAO7UTL1 ; defines RAORC2, RAORC3, RAPID3, RAPID5, RAMSH3
 ; & RADIV(.119)
 N RAFNTDR,RAOIFN,RAORD0 S (RAERR,RALINEX,RAPURGE)=0
 F  S RALINEX=$O(RAMSG(RALINEX)) Q:RALINEX'>0  D  Q:RAERR
 . S RASEG=$G(RAMSG(RALINEX)) Q:$P(RASEG,RAHLFS)="MSH"
 . S RAHDR=$P(RASEG,RAHLFS),RADATA=$P(RASEG,RAHLFS,2,999)
 . D @$S(RAHDR="PID":"PID",RAHDR="ORC":"ORC",1:"ERR")
 . Q
 Q:RAERR  S RAORD0=$G(^RAO(75.1,+RAORC3,0))
 S:$$ONLIN(RAORD0) RAERR=24 Q:RAERR  ; last activity date for order
 ; is before the 'Order Data Cut-Off' for the img type
 S:$P(RAORD0,"^",5)>5 RAERR=24 Q:RAERR  ; can't purge orders that are
 ; in the following stauses: active, scheduled or unreleased
 S:$P(RAORD0,"^",7)="" RAERR=24 Q:RAERR  ; missing CPRS order pointer
 S:$$GET1^DIQ(100,+$P(RAORD0,"^",7)_",",.01)="" RAERR=24 Q:RAERR  ; ptr
 ; data to file 100 (CPRS Order) is invalid
 S RAPUROK=$$PUROK^RAPURGE1(RAORD0,DT),RAOIFN=+RAORC3
 D:RAPUROK ENPUR^RAPURGE1
 Q  ;returns to RAO7RO with RAPUROK set to send OK msg to CPRS
ORC ; breakdown the 'ORC' segment
 S RAERR=$$EN3^RAO7VLD(75.1,+RAORC3)
 S:RAERR RAERR=22 Q:RAERR  ; bad filler number
 S:+RAORC2'>0 RAERR=16 Q:RAERR  ; bad placer number
 S:+RAORC2'=$P($G(^RAO(75.1,+RAORC3,0)),"^",7) RAERR=16 Q:RAERR  ; bad placer number
 Q
PID ; breakdown the 'PID' segment
 S RAERR=$$EN2^RAO7VLD(2,RAPID3,RAPID5) S:RAERR RAERR=2 ; bad patient id
 Q
ERR ; error control - file 'soft' errors with CPRS
 N RAVAR S RAVAR("XQY0")=""
 D ERR^RAO7UTL("HL7 message missing 'PID' & 'ORC' segments",.RAMSG,.RAVAR)
 Q
 ;
ONLIN(RAORD0) ; Check to see if order activity occurred within the number
 ; of days specified for an order, based on its i-type cut-off parms
 ; Input: RAORD0-zero node for our order (75.1)
 ; Output: 1-if order activity occurred later than cut-off date
 ;         0-if no order activity later than cut-off date
 ; The 18th piece of 0 node for file 75.1 is 'Last Activity Date/Time'
 N RAONLIN,RAX
 ; if no img type on order, dflt to gen'l rad img type
 S RAX=$G(^RA(79.2,$S($P(RAORD0,"^",3)="":+$O(^RA(79.2,0)),1:$P(RAORD0,"^",3)),.1))
 S RAONLIN=-$S($P(RAX,"^",6)>29:$P(RAX,"^",6),1:90)
 Q:($P(RAORD0,"^",18)\1)<($$FMADD^XLFDT(DT,RAONLIN)) 0
 Q 1
