IBAECI ;ALB/BGA-LONG TERM CARE INPATIENT TRACKER ; 09-OCT-01
 ;;2.0;INTEGRATED BILLING;**164,171,176,198,188**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
 ; This routine is called from ^IBAMTD and tracks all patient movements
 ; that are related to Long Term Care (LTC). If the Episode of care is
 ; related to LTC the episode of care is stored in ^IBA(351.8 and will
 ; be further screen when the Monthly Job is run and than Priced.
 ;
 ;
EN ;  Main Entry Point
 ;
 ; === When IBALTC=0 episode not LTC billable so passed to MTC Module
 ;     IBALTC=1 episode is LTC Billable do NOT passed to MTC Module
 ;
 S IBALTC=0
 I $G(DGPMA)="",$G(DGPMP)="" Q
 I DT<$$STDATE^IBAECU1() Q  ;quit if today<effective date
 N IBCL,IBDT,IBDTA,IBLTCST,IBT,IBTS,IBX,IBY,IBZ,IBM,IBV,IBE
 ;
 S IBV=$S($L($G(DGPMP)):"DGPMP",1:"DGPMA") D:+$G(@IBV)>0
 . N IBDT S IBDT=+$G(@IBV)\1
 . N VAIP S VAIP("D")=IBDT_.2359 D IN5^VADPT I $P($$TREATSP^IBAECU2($P($G(^DIC(45.7,+VAIP(8),0)),U,2)),"^",1)="L" D BACKBIL Q
 . I +$G(VAIP(1))>0 S VAIP(1)=$$ORIGADM^IBAECN1(VAIP(1)) I $$ISLTC4DT^IBAECN1(DFN,+$G(VAIP(1)),IBDT_.2359)=1 D BACKBIL
 ; is this related to LTC
 S IBX=0 F  S IBX=$O(^UTILITY("DGPM",$J,6,IBX)) Q:IBX<1  F IBY="A","P" S IBTS=$P($G(^UTILITY("DGPM",$J,6,IBX,IBY)),"^",9) I IBTS,$$LTCSPEC^IBAECU(+$$FACSPEC^IBAECU(IBTS)) S IBALTC=1
 I IBALTC=0 I $D(^UTILITY("DGPM",$J,3)) D
 . N VAIN,VAINDT S VAINDT=+$G(@IBV)\1 D INP^VADPT I $P($$TREATSP^IBAECU2($P($G(^DIC(45.7,+VAIN(3),0)),U,2)),"^",1)="L" S IBALTC=1
 I 'IBALTC Q
 ;
 ; get the earliest date of care for this movement
 S IBDT=+DGPMA
 I DGPMP,(DGPMP<DGPMA!('IBDT)) S IBDT=+DGPMP S IBT=0 F  S IBT=$O(^UTILITY($J,IBT)) Q:IBT<1  S IBX=DGPMDA-1 F  S IBX=$O(^UTILITY($J,IBT,IBX)) Q:IBX<1  F IBZ="A","P" S IBDTA=+$G(^UTILITY($J,IBT,IBX,IBZ)) I IBDTA<IBDT S IBDT=IBDTA
 ;
 ; look up this patient's LTC status
 S IBLTCST=+$$LTCST^IBAECU(DFN,IBDT\1,1)
 ;
 ; are they exempt from LTC care?
 I IBLTCST=1 S IBALTC=1 Q
 ;
 ; no 1010EC send message and quit
 I IBLTCST=0 D  D XMNOEC^IBAECU(DFN,IBDT,.IBE) Q
 . S IBV=$S($L($G(DGPMP)):"DGPMP",1:"DGPMA")
 . S IBE(1)="",IBE(2)="  Event Type:  Inpatient Movement "_$S(IBV="DGPMP"&($G(DGPMA)):"Edited",IBV="DGPMP":"Deleted",1:"Added")
 . S IBE(3)="",IBE(4)="Event Action:  "_$S($P(@IBV,"^",2)=1:"Admission",$P(@IBV,"^",2)=2:"Transfer",$P(@IBV,"^",2)=3:"Discharge",$P(@IBV,"^",2)=6:"Specialty Change",1:"")
 . S IBE(5)="",IBE(6)="    Location:  " D
 . . I $P(@IBV,"^",6) S IBE(6)=IBE(6)_$P($G(^DIC(42,+$P(@IBV,"^",6),0)),"^") Q
 . . I $P(@IBV,"^",14),$P($G(^UTILITY("DGPM",$J,1,$P(@IBV,"^",14),"A")),"^",6) S IBE(6)=IBE(6)_$P($G(^DIC(42,+$P(^("A"),"^",6),0)),"^") Q
 . . I $P(@IBV,"^",14),$P($G(^UTILITY("DGPM",$J,1,$P(@IBV,"^",14),"P")),"^",6) S IBE(6)=IBE(6)_$P($G(^DIC(42,+$P(^("P"),"^",6),0)),"^")
 . . I $P(@IBV,"^",14),$P($G(^DGPM(+$P(@IBV,"^",14),0)),"^",6) S IBE(6)=IBE(6)_$P($G(^DIC(42,+$P(^(0),"^",6),0)),"^") Q
 . . S IBE(6)=IBE(6)_"Unknown"
 ;
 D BACKBIL
 ;
 ; flag LTC for current events
 S IBCL=$$CLOCK^IBAECU(DFN,$S(IBDT<$$STDATE^IBAECU1:$$STDATE^IBAECU1,1:IBDT\1))
 ;
 Q
 ;
BACKBIL ;called from EN
 ; back billing issue? send message and quit
 S IBV=$S($L($G(DGPMP)):"DGPMP",1:"DGPMA")
 I $$LASTMJ^IBAECU()>0,$E(IBDT,1,5)<$E($$LASTMJ^IBAECU(),1,5) D  D XMBACK^IBAECU(DFN,.IBM) Q
 . S IBM(1)="A(n) Added." I $D(IBV),$D(@IBV) D
 . . S IBM(1)="A(n) "_$S($P(@IBV,"^",2)=1:"Admission",$P(@IBV,"^",2)=2:"Transfer",$P(@IBV,"^",2)=3:"Discharge",$P(@IBV,"^",2)=6:"Specialty Change",1:"")_" was "_$S(IBV="DGPMP"&($G(DGPMA)):"Edited",IBV="DGPMP":"Deleted",1:"Added")_"."
 . S IBM(2)=" ",IBM(3)="This may result in a Back Billing issue for LTC.  You should review the"
 . S IBM(4)="patient's records for "_$$FMTE^XLFDT(IBDT)_" to ensure correct billing."
 . S IBM(5)="LTC Billing Clock and LTC charges may have to be manually adjusted."
 Q
 ;
CALC ; tag for completion of manual adding of inpt charges
 ; requires DFN, IBCHG, IBEVDA, IBTO
 ;
 N IBT,IBTYP,IBLOS,IBZ
 ;
 ; get the LOS
 S IBZ=^IB(+IBEVDA,0),IBLOS=$$LOS^IBCU64($S($$BILDATE^IBAECN1>$P(IBZ,"^",17):$$BILDATE^IBAECN1,1:$P(IBZ,"^",17)),$$LASTDT^IBAECU(IBTO),2,$P($P(IBZ,"^",4),":",2))
 ;
 ; update the status
 S IBLTCST=$$LTCST^IBAECU(DFN,IBTO,IBLOS) I IBLTCST<2 W !!,"  This patient is not LTC billable on the date." S IBY=-1 Q
 ;
 ; find the total amount already billed for mo
 D TOT^IBAECU
 ;
 W !!,"  Calculated Monthly Copay Cap Type to be used: INPATIENT ",$S(IBLOS<181:"< 181",1:"> 180")," days."
 W !,"               Calculated Monthly Copay Cap is: $ ",$FN($P(IBLTCST,"^",$S(IBLOS<181:3,1:4)),",",2)
 W !,"                       Total previously billed: $ ",$FN(IBT,",",2)
 ;
 I IBCHG+IBT>$P(IBLTCST,"^",$S(IBLOS<181:3,1:4)) S IBCHG=$P(IBLTCST,"^",$S(IBLOS<181:3,1:4))-IBT
 ;
 ; check for negative $ amount cap
 I $P(IBLTCST,"^",$S(IBLOS<181:3,1:4))<0 S IBCHG=0
 ;
 Q
