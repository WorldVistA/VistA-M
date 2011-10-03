IBEFUNC1 ;ALB/ARH - CPT BILLING EXTRINSIC FUNCTIONS ; 11/27/91
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;created front-ends for extrinsic functions for use until all versions of file man can use them
FCC ;
 S IBCHGX=$$CPTCHG($S('$D(IBCDX):"",1:IBCDX),$S('$D(IBDIVX):"",1:IBDIVX),$S('$D(IBDTX):"",1:IBDTX))
 Q
 ;
CPTCHG(CODE,DIV,DATE) ;ambulatory procedure billing charge on a date
 ;assumes current date if none passed in (to disallow guessing on division pass in +DIV)
 ;assumes first active division if (DIV=""!'$D(DIV)) passed in
 ;returns - the charge if code is valid and active in Billing on DATE
 ;        - "" if unable to calc charge or there was none
 ;              division or rate group inactive on date or not defined in file
 N X,%,%H,%I,Y
 S Y=-1 G:'$D(CODE) ENDCHG
 S:'$D(DATE) DATE=DT S DATE=$E(DATE,1,7) I DATE'?7N S DATE=DT
 S:'$D(DIV) DIV="" I DIV="" S DIV=$$MCDIV(DIV,DATE)
 I +$$CPTBSTAT(CODE,DATE) S X=DATE_"^"_DIV_"^"_+CODE D RATE^IBAUTL1
ENDCHG Q $S(Y<0:"",1:Y)
 ;
FCBS ;
 S IBSTX=$$CPTBSTAT($S('$D(IBCDX):"",1:IBCDX),$S('$D(IBDTX):"",1:IBDTX))
 Q
 ;
CPTBSTAT(CODE,DATE) ;ambulatory procedure billing status on a date
 ;assumes current date if none passed in
 ;returns - ""          if CODE had never been a billing code on/before DATE given or DATE before BASC start date
 ;        - 0^INACTIVE  if CODE billing inactive on DATE given or rate group inactive on DATE
 ;        - 1^ACTIVE    if CODE billing active on DATE given
 N LN,ST,%,%H,%I,X
 S ST="" I '$D(CODE) G ENDST
 S:'$D(DATE) DATE=DT S DATE=$E(DATE,1,7) I DATE'?7N S DATE=DT
 I $$STDATE^IBCU63>DATE G ENDST
 I $D(^IBE(350.4,+$O(^(+$O(^IBE(350.4,"AIVDT",+CODE,-(DATE+1))),0)),0)) S LN=^(0),ST=+$P(LN,"^",4)
 I ST,$P($G(^IBE(350.2,+$P(LN,"^",3),0)),"^",2)>DATE S ST=""
 S ST=ST_$S(ST'="":"^"_$P($P($P(^DD(350.4,.04,0),"^",3),ST_":",2),";",1),1:"")
ENDST Q ST
 ;
FCR ;
 S IBRGX=$$CPTRG($S('$D(IBCDX):"",1:IBCDX),$S('$D(IBDTX):"",1:IBDTX))
 Q
 ;
CPTRG(CPT,DATE) ;find the rate group for the CPT on the given date
 ;assumes current date if none passed in
 ;returns - a rate group name
 ;        - "" if no rate group listed for date, or CPT or DATE is ""
 N RATE,%,%H,%I,X
 G:'$D(CPT) ENDRG
 S:'$D(DATE) DATE=DT S DATE=$E(DATE,1,7) I DATE'?7N S DATE=DT
 I $D(^IBE(350.4,+$O(^(+$O(^IBE(350.4,"AIVDT",+CPT,-(DATE+1))),0)),0)) S RATE=$P($P($G(^IBE(350.1,+$P(^(0),"^",3),0)),"^",1)," ",2,999)
ENDRG Q $S($D(RATE):RATE,1:"")
 ;
FMCD ;
 S IBDIVX=$$MCDIV($S('$D(IBDIVX):"",1:IBDIVX),$S('$D(IBDTX):"",1:IBDTX))
 Q
 ;
MCDIV(DIV,DATE) ;find the medical center division
 ; if DATE is not defined then assumes current date
 ;returns - DIV passed in, if its status is active for date given
 ;        - first active division found, if DIV was inactive or ""
 ;        - if all divisions are inactive for the given date, returns ""
 N I,NDIV,INACT,%,%H,%I,X S DIV=$G(DIV)
 ;I '$D(DIV) S DIV="" G ENDIV
 S:'$D(DATE) DATE=DT S DATE=$E(DATE,1,7) I DATE'?7N S DATE=DT
 S NDIV=+$O(^(+$O(^IBE(350.5,"AIVDT",+DIV,-(DATE+1))),0))
 I '$P($G(^IBE(350.5,NDIV,0)),"^",4) S DIV="" F I=1:1 S DIV=$O(^IBE(350.5,"AIVDT",DIV)) Q:DIV=""!('$D(INACT(+DIV))&($P($G(^IBE(350.5,+$O(^(+$O(^IBE(350.5,"AIVDT",+DIV,-(DATE+1))),0)),0)),"^",4)))  S INACT(DIV)=""
ENDIV Q DIV
 ;
RC(D0,D1,DATE) ;find BASC charge for particular revenue code entry (399,42)
 ;input:   D0 = bill ifn,   D1 = revenue code sub-file IFN
 ;         if DATE not passed then assums STATEMENT FROM date of bill
 ;returns: dollar amount if rev code has an active BASC CPT, otherwise ""
 N X,Y,DA S X="",DATE=$P($G(DATE),".") I DATE'?7N S DATE=+$G(^DGCR(399,D0,"U"))
 S Y=$G(^DGCR(399,D0,"RC",D1,0)) I +$P(Y,U,6),+$P(Y,U,7) S X=+$$CPTCHG^IBEFUNC1(+$P(Y,U,6),+$P(Y,U,7),DATE)
 Q X
 ;
CP(D0,D1) ;find BASC charge for particular procedure entry (399,304)
 ;input:    D0 = bill IFN,   D1 = procedure code sub-file IFN
 ;returns:  dollar amount if CPT is BASC active, otherwise ""
 N X,Y,DA S X="",Y=$G(^DGCR(399,D0,"CP",D1,0)) I $P(Y,U,1)[";ICPT(",+$P(Y,U,2),+$P(Y,U,6) S X=$$CPTCHG^IBEFUNC1(+Y,+$P(Y,U,6),+$P(Y,U,2))
 Q X
