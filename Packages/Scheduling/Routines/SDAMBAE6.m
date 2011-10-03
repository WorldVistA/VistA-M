SDAMBAE6 ;ALB/MJK - A/E Protocol; 11 FEB 1993 10:00 am
 ;;5.3;Scheduling;**27,132,76**;08/13/93
 ;; ;
EN ; -- AE entry point for SDAM ADD EDIT protocol
 ;    - assumes SDAMTYP, SDBEG and SDEND defined from appt mgt
 ;    - assumes SDFN is defined if SDAMTYP="P"
 ;
 S VALMBCK=""
 D FULL^VALM1
 S DFLG=0 I SDAMTYP="P" S DFN=SDFN D 2^VADPT I +VADM(6) D  Q:DFLG
 . I SDBEG>+VADM(6) W VADM(7) S DFLG=1 R ZX:10
 D FREE($S(SDAMTYP="P":SDFN,1:""))
ENQ Q
 ;
EN1 ; -- AE entry point for SDCO ADD EDIT NEW protocol
 ;    - assumes SDBEG and SDEND defined from co mgt
 N SDOE0
 S VALMBCK=""
 D FULL^VALM1
 S SDOE0=$G(^SCE(+$G(SDOE),0))
 D FREE(+$P(SDOE0,U,2))
ENQ1 Q
 ;
EN2 ; -- AE entry point for SDADDEDIT option
 S SDVISIT=$$ENCEDIT^PXAPI("ADDEDIT","SD","PIMS","","","","","PO",-1,"AD",1)
 I +SDVISIT<-1 W !!,$P(SDVISIT,U,2)
ENQ2 Q
 ;
FREE(SDFN) ; -- ask to create a standalone stop
 N SDVISIT
 IF SDFN D
 . S SDVISIT=$$ENCEDIT^PXAPI("ADDEDIT","SD","PIMS",SDFN,SDBEG,SDEND,"","PO",-1,"AD",1)
 ELSE  D
 . S SDVISIT=$$ENCEDIT^PXAPI("ADDEDIT","SD","PIMS","",SDBEG,SDEND,"","PO",-1,"AD",1)
 I +SDVISIT<-1 W !!,$P(SDVISIT,U,2)
 S VALMBCK="R"
 ;
FREEQ Q
 ;
