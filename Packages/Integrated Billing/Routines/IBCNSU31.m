IBCNSU31 ;ALB/ARH - INSURANCE UTILITY FILING TIME FRAME ; 09-FEB-09
 ;;2.0;INTEGRATED BILLING;**399**;21-MAR-94;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PTFTF(DFN,IBSDT) ; Patient Filing Time Frame: check if service date is within the Filing Time Frame of the patients insurance
 ; returns true if the date of service is within the FTF of any of the patients active policies
 ; medicare is included because some secondaries allow their FTF from the MRA submission rather than DOS
 N IBDD,IBPOL,IBPLN,IBCOV S IBCOV=0 G:'$G(DFN) PTFTFQ  S IBSDT=$G(IBSDT)\1 I IBSDT'?7N S IBSDT=DT
 D ALL^IBCNS1(DFN,"IBDD",4,IBSDT) ; all active insurance policies and medicare
 ;
 S IBPOL=0 F  S IBPOL=$O(IBDD(IBPOL)) Q:'IBPOL  D  Q:IBCOV
 . S IBPLN=+$P($G(IBDD(IBPOL,0)),U,18) Q:'IBPLN
 . I +$$PLFTF(IBPLN,IBSDT) S IBCOV=1
 ;
PTFTFQ Q IBCOV
 ;
PLFTF(IBPLN,IBSDT,IBINS) ; Plan/Company Filing Time Frame: check if service date is within Plan or Company Filing Time Frame and Today
 ; if both the plan and company have a FTF then plan FTF has precedence and is used
 ; IBPLN - pointer to plan (355.3), will check both the plan and company FTF
 ; IBSDT - date of service to determine if FTF has expired, ie. FTF plus the service date is before today
 ; IBINS - optional, if passed only used if there is no plan company
 ; returns COV ^ DATE where COV is true if the date is covered, DATE of FTF applied, if any
 ;
 N IBPLN0,IBINS0,IBFDT,IBX,IBCOV S IBFDT="",IBCOV=1
 S IBPLN0=$G(^IBA(355.3,+$G(IBPLN),0)) I +IBPLN0 S IBINS=+IBPLN0
 S IBINS0=$G(^DIC(36,+$G(IBINS),0)) S IBSDT=$G(IBSDT)\1 I IBSDT'?7N S IBSDT=DT
 ;
 I +$P(IBINS0,U,18) S IBX=$$FTF(+$P(IBINS0,U,18),+$P(IBINS0,U,19),IBSDT) S IBFDT=IBX
 I +$P(IBPLN0,U,16) S IBX=$$FTF(+$P(IBPLN0,U,16),+$P(IBPLN0,U,17),IBSDT) S IBFDT=IBX
 ; 
 I +IBFDT S IBCOV="1^"_IBFDT I DT>IBFDT S IBCOV="0^"_IBFDT
 ;
 Q IBCOV
 ;
FTF(IBFTF,IBVAL,IBSDT) ; Filing Time Frame: return date at end of Filing Time Frame from Service Date OR null if none/not known
 ; IBFTF - pointer to standard FTF in 355.13
 ; IBVAL - value associated with the FTF
 ; IBSDT - service date
 N IBX,IBYR,IBFYR,IBEND S IBFTF=+$G(IBFTF),IBVAL=+$G(IBVAL),IBSDT=$G(IBSDT)\1 I IBSDT'?7N S IBSDT=DT
 S IBFYR=$E(IBSDT,1,3)+1,IBEND="" I 'IBVAL,+$$FTFV(IBFTF) S IBFTF=0
 ;
 I IBFTF=1 S IBX=IBVAL,IBEND=$$FMADD^XLFDT(IBSDT,IBX)
 I IBFTF=2 S IBX=IBVAL*30,IBEND=$$FMADD^XLFDT(IBSDT,IBX)
 I IBFTF=3 S IBX=IBVAL*365,IBEND=$$FMADD^XLFDT(IBSDT,IBX)
 I IBFTF=4 S IBX=IBVAL+365,IBEND=$$FMADD^XLFDT(IBSDT,IBX)
 I IBFTF=5 S IBX=IBVAL,IBYR=IBFYR_"0101",IBEND=$$FMADD^XLFDT(IBYR,IBX)
 I IBFTF=6 S IBX=IBVAL*30,IBYR=IBFYR_"0101",IBEND=$$FMADD^XLFDT(IBYR,IBX)
 I IBFTF=7 S IBYR=IBFYR_"1231",IBEND=IBYR
 ;
 Q IBEND
 ;
FTFN(IBPLN,IBINS) ; Plan/Company Filing Time Frame Name: return plan or companies standard filing time frame for display
 N IBX,IBFTF,IBVAL,IBFTFN S (IBFTFN,IBFTF)=""
 I +$G(IBINS) S IBX=$G(^DIC(36,+IBINS,0)) I +$P(IBX,U,18) S IBFTF=+$P(IBX,U,18),IBVAL=+$P(IBX,U,19)
 I +$G(IBPLN) S IBX=$G(^IBA(355.3,+IBPLN,0)) I +$P(IBX,U,16) S IBFTF=+$P(IBX,U,16),IBVAL=+$P(IBX,U,17)
 ;
 I +IBFTF S IBFTF=$G(^IBE(355.13,+IBFTF,0)) S IBFTFN=$S(+$P(IBFTF,U,2):IBVAL_" ",1:"")_$P(IBFTF,U,1)
 Q IBFTFN
 ;
FTFV(IBFTF) ; return true if a Standard Filing Time Frame requires a Value
 Q +$P($G(^IBE(355.13,+$G(IBFTF),0)),U,2)
