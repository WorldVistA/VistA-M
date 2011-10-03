IBAMTV2 ;ALB/CPM - CREATE CHARGES FOR BILLABLE EPISODES ; 01-JUN-94
 ;;2.0;INTEGRATED BILLING;**15,153,204**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BLD ; Create back charges for an array of episodes.
 ;
 ; Input: IBSTART  --  First date that the patient is Means Test billable
 ;          IBEND  --  Last date that the patient is Means Test billable
 ;            DFN  --  Pointer to the patient in file #2
 ;
 ;        ^TMP("IBAMTV",$J,episode date) = 1^2^3, where
 ;                         1 = adm date for inpatient care
 ;                             visit date for outpatient care
 ;                         2 = disch/last bill date for inpatient care
 ;                             null for outpatient care
 ;                         3 = null for inpatient care
 ;                             softlink for outpatient care
 ;
 S IBJOB=9,(IBWHER,IBY,Y)=1,IBDUZ=$S($G(DUZ):DUZ,1:.5)
 D SITE^IBAUTL I Y<1 S IBY=Y G BLDQ
 D SERV^IBAUTL2 I IBY<1 G BLDQ
 ;
 ; - is there an old clock to use?
 S IBCLDA=$$OLDCL(DFN,+$O(^TMP("IBAMTV",$J,0)))
 I IBCLDA D CLDATA^IBAUTL3,DED^IBAUTL3
 ;
 ; - bill all episodes of care
 S IBEPDT=0 F  S IBEPDT=$O(^TMP("IBAMTV",$J,IBEPDT)) Q:'IBEPDT  S IBEPSTR=$G(^(IBEPDT)) I IBEPSTR D @$S($P(IBEPSTR,"^",2):"INPT",1:"OPT") Q:IBY<0
 I IBY<0 G BLDQ
 ;
 ; - close clock if over a year old
 I IBCLDA,$$FMDIFF^XLFDT(DT,IBCLDT)>364 K IBCLDOL D CLOCKCL^IBAUTL3
 ;
BLDQ I IBY<0 D ^IBAERR1
 D KILL1^IBAMTC K IBEPDT,IBEPSTR
 Q
 ;
 ;
INPT ; Bill inpatient care.
 S IBEVDA=0
 I IBCLDA S IBCLCT=$$FMDIFF^XLFDT(+IBEPSTR,IBCLDT)
 S IBBDT=$$FMTH^XLFDT(+IBEPSTR,1)
 S IBEDT=$$FMTH^XLFDT($P(IBEPSTR,"^",2),1)-1
 D ^IBAUTL4 G:IBY<0 INPTQ
 ;
 I $G(IBCHPDA) D UPD(IBCHPDA)
 I $G(IBCHCDA) D UPD(IBCHCDA)
 I IBCLDA D CLUPD^IBAUTL3
 I IBEVDA,$D(IBDT) S IBEVCLD=IBDT D @($S($$CLEV():"EVCLOSE",1:"EVUPD")_"^IBAUTL3")
 ;
INPTQ K IBCHPDA,IBCHCDA,IBCHG,IBCHFR,IBCHTO,IBCHTOTL,IBBS,IBNH,IBTRAN,IBATYP,IBDATE
 K IBEVDA,IBEVDT,IBEVCLD,IBEVCAL,IBEVNEW,IBEVOLD,IBTOTL,IBDESC,IBIL,IBSL
 Q
 ;
OPT ; Bill the Outpatient copayment.
 ;  Input:  IBEPSTR  --  1^2^3, where
 ;                        1 => visit date
 ;                        2 => null
 ;                        3 => softlink (may be null)
 ;              DFN  --  Pointer to the patient in file #2
 ;
 N %,IBSTOPDA,IBTYPE
 ;
 I IBCLDA,$$FMDIFF^XLFDT(+IBEPSTR,IBCLDT)>364 K IBCLDOL D CLOCKCL^IBAUTL3 G:IBY<0 OPTQ
 I 'IBCLDA S IBCLDT=+IBEPSTR D CLADD^IBAUTL3 G:IBY<0 OPTQ S (IBCLDAY,IBCLDOL)=0
 ;
 ; - build the charge
 I $P(IBEPSTR,"^",3) S IBSL="409.68:"_$P(IBEPSTR,"^",3)
 S IBX="O",(IBFR,IBTO,IBDT,IBEVDT)=+IBEPSTR
 ;
 ; look up the copay tier info
 S %=$$GETSC^IBEMTSCU(IBSL,IBEVDT) I % S IBSTOPDA=%
 ;  get the rate, ibtype = primary or specialty
 S IBTYPE=$P($G(^IBE(352.5,+$G(IBSTOPDA),0)),"^",3) G:IBTYPE=0 OPTQ
 ;  if the type is not defined, must be a local created sc, set it to primary
 I 'IBTYPE S IBTYPE=1
 ;
 ;
 D TYPE^IBAUTL2 G:IBY<0 OPTQ
 S IBUNIT=1,IBEVDA="*"
 D ADD^IBECEAU3 G:IBY<0 OPTQ
 ;
 ; - place charge in the 'review' status
 D UPD(IBN)
 ;
OPTQ K IBUNIT,IBFR,IBTO,IBSL,IBEVDA,IBX,IBDESC,IBATYP,IBCHG,IBRTED,IBN,IBBS,IBEVDT
 Q
 ;
 ;
OLDCL(DFN,IBDT) ; Can an old billing clock be used?
 ;  Input:     DFN  --  Pointer to the patient in file #2
 ;            IBDT --  Date of first potentially billable episode
 ; Output:       0  --  No old billing clock available
 ;              >0  --  Pointer to old billing clock in file #351
 I '$G(DFN) G OLDCLQ
 N IBX,IBY,IBZ,IBST S IBST=0
 S IBX=-(IBDT+.1) F  S IBX=$O(^IBE(351,"AIVDT",DFN,IBX)) Q:'IBX  D  Q:IBST
 .S IBY=0 F  S IBY=$O(^IBE(351,"AIVDT",DFN,IBX,IBY)) Q:'IBY  D  Q:IBST
 ..S IBZ=$G(^IBE(351,IBY,0)) Q:'IBZ!($P(IBZ,"^",4)=3)
 ..I $$FMDIFF^XLFDT(IBDT,$P(IBZ,"^",3))<365 S IBST=1
OLDCLQ Q +$G(IBY)
 ;
UPD(IBN) ; Place the charge in a review status.
 ;  Input:   IBN  --  Pointer to the charge in file #350
 S DIE="^IB(",DA=IBN,DR=".05////21" D ^DIE K DIE,DA,DR
 Q
 ;
CLEV() ; Should the event record be closed?
 ;  Input:  variables   IBEVDA  --  Pointer to event in file #350
 ;                       IBEND  --  Last date through which to bill
 ; Output:    1  --  yes, close event
 ;            0  --  don't close event
 N IBX,IBZ S IBX=0
 I '$G(IBEVDA)!'$G(IBEND) S IBX=1 G CLEVQ
 I IBEND<$$FMADD^XLFDT(DT,-1) S IBX=1 G CLEVQ
 S IBZ=+$P($P($G(^IB(IBEVDA,0)),"^",4),":",2),IBZ=$P($G(^DGPM(IBZ,0)),"^",14)
 I IBZ,$P($G(^DGPM(IBZ,0)),"^",17) S IBX=1
CLEVQ Q IBX
