SCMCMU3 ;ALB/MJK - Discharge Patient from Clinic ; 1/27/05 9:55am
 ;;5.3;Scheduling;**148,157,346**;AUG 13, 1993
 ;
EN(DFN,SCCLN,SCDATE,SCREA) ; -- main entry point
 N SCENR,SCENR0,SCRET
 S SCENR=+$O(^DPT(DFN,"DE","B",+SCCLN,0))
 ;
 ; -- quit pateint never enrolled in clinic
 IF 'SCENR G ENQ
 ;
 S SCENR0=$G(^DPT(DFN,"DE",SCENR,0))
 ;
 ; -- quit if enrollment is currently inactive
 IF $P(SCENR0,U,2)'="" G ENQ
 ;
 D BEFORE^SCMCEV3(DFN) ;setup before values
 ;
 S SCRET=$$DISCH(DFN,SCCLN,SCDATE,SCENR,SCREA)
 IF SCRET=1 D
 . D AFTER^SCMCEV3(DFN) ;setup after values
 . D INVOKE^SCMCEV3(DFN) ; call event driver
ENQ Q $G(SCRET,$$ERR(3))
 ;
DISCH(DFN,SCCLN,SCDATE,SCENR,SCREA) ; -- discharge from clinic
 ;initialize variables
 N SCDT,SCDT0,SCDAT,SCDAT0,DIE,DA,DR,Y,SCNODE,SCRET,SCARRAY,SCCOUNT
 K ^TMP($J,"SDAMA301")
 ; -- check for future apps
 S SCDT=DT+1
 I $G(SCCLN)'="",$G(DFN)'="" D
 .;setup call to SDAPI to retrieve a single future appt
 .S SCARRAY(1)=SCDT,SCARRAY(2)=SCCLN,SCARRAY(3)="R;I"
 .S SCARRAY(4)=DFN,SCARRAY("FLDS")=4,SCARRAY("MAX")=1
 .S SCCOUNT=$$SDAPI^SDAMA301(.SCARRAY)
 .K ^TMP($J,"SDAMA301")
 ;if a future appointment returned
 I SCCOUNT>0 D
 .S SCRET=2
 ;if no future appointments exist
 I SCCOUNT'>0 D
 .S SCDAT=0
 .F  S SCDAT=$O(^DPT(DFN,"DE",SCENR,1,SCDAT)) Q:'SCDAT  D
 .. S SCDAT0=$G(^DPT(DFN,"DE",SCENR,1,SCDAT,0))
 .. I $P(SCDAT0,U,3)]"" Q
 .. S SCNODE=$NA(^DPT(DFN,"DE",SCENR,1,SCDAT))
 .. D LOCK(SCNODE)
 .. S DA(2)=DFN,DA(1)=SCENR
 .. S DIE="^DPT("_DFN_",""DE"","_SCENR_",1,",DA=SCDAT
 .. S DR="3////"_SCDATE_";4////"_SCREA
 .. D ^DIE
 .. D UNLOCK(SCNODE)
 .. S SCRET=1
 ;
DISCHQ Q $$ERR($G(SCRET,3))
 ;
LOCK(NODE) ; -- lock node
 F  L +@NODE:5 IF $T Q
 Q
 ;
UNLOCK(NODE) ; -- unlock node
 L -@NODE
 Q
 ;
ERR(CODE) ;
 Q $P($TEXT(RET+CODE),";;",2)
 ;
 ;
 ; piece [ return code ^ error text ]
RET ; -- return values  
 ;;1^Patient successfully discharged from clinic
 ;;2^Patient has future appointments in clinic
 ;;3^No active enrollment data for clinic
 ;
TEST ;
 W !!,$$EN(7170643,446,DT,"TEST FROM SCMCMU3")
 Q
