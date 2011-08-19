IBAECO ;ALB/BGA - LONG TERM CARE OUTPATIENT TRACKER ;16-OCT-01
 ;;2.0;INTEGRATED BILLING;**164,171,176,188,312**;21-MAR-94
 ;;Per VHA DIRECTIVE 10-93-142, this routine should not be modified.
 ;
 ; Comment- This routine is invoked via the appointment driver ^IBAMTS
 ;          This program checks for check outs and determines if
 ;          the person checking out is ELIGIBLE for Long Term Care
 ;          and determines if the encounter was related to LTC.
 ;          If the episode of care is related to LTC and the patient
 ;          is eligible to receive care and is compliant with all
 ;          the LTC business rules than the entry is added to
 ;          the LTC transaction file #351.8.
 ;
 ; Determine if this encounter has a status of checked out
EN N IBEVT,IBEV0,DFN,IBSDHDL,IBORG,IBOE,IBLTCST,IBCL,IBDT,IBST,IBM
 N IBSWINFO S IBSWINFO=$$SWSTAT^IBBAPI()                   ;IB*2.0*312
 S IBSDHDL=0
 ;
 ; === ON/OFF Switch by date if before 11/15/06 software will not run
 ; === IBALTC=0 the Encounter is not LTC Billable pass to MT Module
 ; === IBALTC=1 Encounter is LTC Billable do NOT Pass to MTC
 ;
 S IBALTC=0
 ;I DT<$$STDATE^IBAECU1() Q  ;quit if today<effective date
 F  S IBSDHDL=$O(^TMP("SDEVT",$J,IBSDHDL)) Q:'IBSDHDL  D
 . S IBORG=0 F  S IBORG=$O(^TMP("SDEVT",$J,IBSDHDL,IBORG)) Q:'IBORG  D
 . . S IBOE=0 F  S IBOE=$O(^TMP("SDEVT",$J,IBSDHDL,IBORG,"SDOE",IBOE)) Q:'IBOE  S IBEVT=$G(^(IBOE,0,"AFTER")),IBEV0=$G(^("BEFORE")) D
 . . . ;
 . . . Q:$P(IBEVT,U,6)  ; do not evaluate sibling encounters
 . . . Q:$P(IBEVT,U,12)=8  ; do not evaluate inpatient encounters
 . . . ;
 . . . ; set variables
 . . . S DFN=$P(IBEVT,U,2),IBDT=$S(+IBEVT:+IBEVT,1:+IBEV0),IBST=$P(IBEVT,U,3)
 . . . Q:IBDT<$$STDATE^IBAECU1
 . . . Q:'DFN!('IBDT)
 . . . ;
 . . . ; Do NOT PROCESS on VistA if IBDT>=Switch Eff Date  ;CCR-930
 . . . I +IBSWINFO,(IBDT+1)>$P(IBSWINFO,"^",2) Q           ;IB*2.0*312
 . . . ;
 . . . ; stop code preset and LTC event?
 . . . I 'IBST Q
 . . . I '$$LTCSTOP^IBAECU(IBST) Q
 . . . ;
 . . . ; set flag to stop MT billing
 . . . S IBALTC=1
 . . . ;
 . . . ; LTC patient check
 . . . S IBLTCST=+$$LTCST^IBAECU(DFN,IBDT\1,1)
 . . . ;
 . . . ; no 1010EC on file
 . . . I IBLTCST=0 D  D XMNOEC^IBAECU(DFN,.IBDT,.IBM) Q
 . . . . S IBM(1)="",IBM(2)="  Event Type:  Outpatient Encounter"
 . . . . S IBM(3)="",IBM(4)="Event Action:  "_$S($P(IBEV0,"^",12)'=2&($P(IBEVT,"^",12)=2):"Checked Out",IBEVT&(IBEV0):"Edited",IBEV0:"Deleted",1:"Added")
 . . . . S IBM(5)="",IBM(6)="    Location:  "_$S($P(IBEVT,"^",4):$P($G(^SC(+$P(IBEVT,"^",4),0)),"^"),$P(IBEVO,"^",4):$P($G(^SC(+$P(IBEVO,"^",4),0)),"^"),1:"")
 . . . ;
 . . . ; is this a back billing issue, if so, send message and quit
 . . . I $$LASTMJ^IBAECU()>0,$$LASTMJ^IBAECU()>IBDT D  D XMBACK^IBAECU(DFN,.IBM) Q
 . . . . S IBM(1)="An Outpatient Encounter was "_$S(IBEVT&(IBEV0):"Edited",IBEV0:"Deleted",1:"Added")_"."
 . . . . S IBM(2)="This may result in a Back Billing issue for LTC.  You should review the"
 . . . . S IBM(3)="patient's records for "_$$FMTE^XLFDT(IBDT)_" to ensure correct billing."
 . . . . S IBM(4)="LTC Billing Clock and LTC charges may have to be manually adjusted."
 . . . ;
 . . . ; add LTC clock/update last event date (if not LTC exempt)
 . . . I IBLTCST=2 S IBCL=$$CLOCK^IBAECU(DFN,IBDT\1)
 . . . ;
 ;
 Q
 ;
CALC ; used to calculate the outpatient charge
 ; variables needed DFN, IBLTCST, IBCHG, IBFR
 ; this will adjust IBCHG so the patient is not above their calculated
 ; copay cap for the month.
 N IBTYP,IBT
 ;
 ; find all LTC charges and set flag to determine inpt or opt
 ; cap to be used.
 D TOT^IBAECU
 ;
 W !!,"  Calculated Monthly Copay Cap Type to be used: ",$S(IBTYP="I":"IN",1:"OUT"),"PATIENT"
 W !,"               Calculated Monthly Copay Cap is: $ ",$FN($P(IBLTCST,"^",$S(IBTYP="I":3,1:5)),",",2)
 W !,"                       Total previously billed: $ ",$FN(IBT,",",2)
 ;
 I IBCHG+IBT>$P(IBLTCST,"^",$S(IBTYP="I":3,1:5)) S IBCHG=$P(IBLTCST,"^",$S(IBTYP="I":3,1:5))-IBT
 ;
 ; check for negative $ amount cap
 I $P(IBLTCST,"^",$S(IBTYP="I":3,1:5))<0 S IBCHG=0
 ;
 Q
