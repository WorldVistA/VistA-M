IBATCM ;LL/ELZ - TRANSFER PRICING TRANSACTION CHARGES ; 02-MAR-1999
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
TOTAL(IBIEN) ; -- recalculate total and set
 N IBT,IBD,IBTL S IBTL=0
 S IBT=$P(^IBAT(351.61,IBIEN,0),"^",12)
 I IBT["DGPM(" D  Q
 . S IBD=^IBAT(351.61,IBIEN,1)
 . S IBTL=$P(IBD,"^",5)*$P(IBD,"^",6)+$P(IBD,"^",2)
 . D SETTL(IBTL)
 I IBT["SCE(" D  Q
 . N IBX S IBX=0 F  S IBX=$O(^IBAT(351.61,IBIEN,3,IBX)) Q:IBX<1  D
 .. S IBD=^IBAT(351.61,IBIEN,3,IBX,0)
 .. S IBTL=$P(IBD,"^",2)*$P(IBD,"^",3)+IBTL
 . D SETTL(IBTL)
 I IBT["RMPR(660," D SETTL($P($G(^IBAT(351.61,IBIEN,4)),"^",5)) Q
 S IBD=^IBAT(351.61,IBIEN,4)
 S IBTL=$P(IBD,"^",2)*$P(IBD,"^",3)
 D SETTL(IBTL)
 Q
SETTL(X) ; -- files total
 N DIE,DR,DA Q:X<.01
 S DIE="^IBAT(351.61,",DA=IBIEN,DR="6.02///"_$FN(X,"",2)_";.05////P"
 D ^DIE
 Q
INPT(DRG,DATE,FAC) ; -- returns inpatient rates
 ;
 Q $$RATE("TP INPATIENT",DRG,DATE,$G(FAC))
 ;
OPT(CPT,DATE,FAC) ; -- returns outpatient rates
 ;
 Q $$RATE("TP OUTPATIENT",CPT,DATE,FAC)
 ;
RATE(BR,ITEM,DATE,FAC) ; -- returns rates for BR from charge master
 ; CHARGE=1!0^default rate^nego rate^rate to use
 ; if FAC undefined, send back default
 N IBCHARGE,IBFAC
 ;
 ; look up negotiated rates if exist
 I $G(FAC) F IBFAC=FAC,+$$VISN^IBATUTL(FAC) S $P(IBCHARGE,"^",2)=+$$ITCHG^IBCRCI($$TPCS^IBCRU7(BR,IBFAC),ITEM,DATE) Q:$P(IBCHARGE,"^",2)
 ;
 ; find default adjust by .8 and round
 S $P(IBCHARGE,"^")=$FN((+$$ITCHG^IBCRCI($$TPCS^IBCRU7(BR),ITEM,DATE))*.8,"",2)
 ;
 ; set rate to use
 S $P(IBCHARGE,"^",3)=$S($P(IBCHARGE,"^",2):$P(IBCHARGE,"^",2),1:+IBCHARGE)
 ;
 Q $S($P(IBCHARGE,"^",3):"1^",1:"0^")_IBCHARGE
 ;
