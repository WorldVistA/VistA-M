IBATEI ;ALB/BGA - TRANSFER PRICING INPATIENT TRACKER ; 02-FEB-99
 ;;2.0;INTEGRATED BILLING;**115,210**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
 ; This routine is called from ^IBAMTD and tracks all patient movements
 ; as they relate to patients who are out of network.
 ;
EN ;  Main Entry Point
 I '$P($G(^IBE(350.9,1,10)),"^",2) Q  ; transfer pricing turned off
 I $G(DGPMA)="",$G(DGPMP)="" Q
 N DFN,IBATIEN,DA,IBRTYPE,TYPE,IBA,IBIND,IBPTF,IBDISDT,IBDISPT,IBATFILE
 N IBADMDT,IBSOURCE,IBPREF,PTF,ADMIS,IBDFN,IBREST
 S IBA=$P($S(DGPMA="":DGPMP,1:DGPMA),U,14) Q:IBA<1  ; iba ptr to the admission
 S IBIND=IBA_";DGPM("
 ; $$FINDT checks to see if the entry exist and the entry is not cancelled
 S IBATIEN=$$FINDT^IBATUTL(IBIND)
 I IBATIEN D  G END
 . S DFN=$P($G(^IBAT(351.61,+IBATIEN,0)),U,2) Q:DFN<1
 . ; if the MOVEMENT admission was deleted DELETE entry from 351.61
 . I DGPMA="",($P(DGPMP,U,2)=1) D  Q
 . . D DEL^IBATFILE(IBATIEN)
 . ; if the MOVEMENT deleted a discharge reset transaction STATUS="entered"
 . I DGPMA="",($P(DGPMP,U,2)=3) D  Q
 . . S IBATFILE=$$DISC^IBATFILE(IBATIEN)
 . ; if the MOVEMENT is adding a *DISCHARGE* add the event
 . I DGPMP="",($P(DGPMA,U,2)=3) D  Q
 . . ; Look for ptf in the parent event
 . . Q:'$P(DGPMA,U,14)
 . . S IBPTF=$P($G(^DGPM($P(DGPMA,U,14),0)),U,16) Q:'IBPTF
 . . S IBDISDT=$P($G(^DGPT(IBPTF,70)),U)
 . . Q:IBDISDT']" "
 . . S IBDISPT=$P($G(^DGPM($P(DGPMA,U,14),0)),U,17) Q:'IBDISPT
 . . ; PASS IN=ien 351.61,discharge dt in ptf,discharge movement
 . . S IBATFILE=$$DIS^IBATFILE(IBATIEN,IBDISDT,IBPTF,IBDISPT)
 . . ; <<end of update existing entry>>
 . . ; [if new admission not currently being tracked added to 351.61]
 I DGPMP="",($P(DGPMA,U,2)=1) D  G END
 . ; check to see if this is a tp $$TTP returns '0' if not TP
 . Q:'$$TPP^IBATUTL($P(DGPMA,U,3))
 . S IBADMDT=$P(DGPMA,U),IBSOURCE=$P(DGPMA,U,14)
 . S IBPREF=$$PPF^IBATUTL($P(DGPMA,U,3)) Q:'IBPREF
 . Q:IBSOURCE=""!($P(DGPMA,U,14)="")
 . S IBSOURCE=IBSOURCE_";DGPM("
 . S IBATFILE=$$ADM^IBATFILE($P(DGPMA,U,3),IBADMDT,IBPREF,IBSOURCE)
 ;
 ; Case where we have a discharge but the admission was not recorded 
 I DGPMP="",($P(DGPMA,U,2)=3) D  G END
 . Q:'$$TPP^IBATUTL($P(DGPMA,U,3))
 . ; add the admission and than add the discharge
 . S IBADMDT=$P(DGPMA,U),IBSOURCE=$P(DGPMA,U,14)
 . S IBPREF=$$PPF^IBATUTL($P(DGPMA,U,3)) Q:'IBPREF
 . Q:IBSOURCE=""!($P(DGPMA,U,14)="")
 . S IBSOURCE=IBSOURCE_";DGPM("
 . S IBATFILE=$$ADM^IBATFILE($P(DGPMA,U,3),IBADMDT,IBPREF,IBSOURCE)
 . ; add the discharge
 . Q:'$P(DGPMA,U,14)!(IBATFILE<1)
 . S IBATIEN=+IBATFILE,IBPTF=$P($G(^DGPM($P(DGPMA,U,14),0)),U,16) Q:'IBPTF
 . S IBDISDT=$P($G(^DGPT(IBPTF,70)),U)
 . Q:IBDISDT']" "
 . S IBDISPT=$P($G(^DGPM($P(DGPMA,U,14),0)),U,17) Q:'IBDISPT
 . ; PASS IN=ien 351.61,discharge dt in ptf,discharge movement
 . S IBATFILE=$$DIS^IBATFILE(IBATIEN,IBDISDT,IBPTF,IBDISPT)
 Q
 ;
FINDRT(PTF,ADMIS,IBDFN) ; Find the Rate
 ;
 ;  Input:  PTF=ien to PTF
 ;        ADMIS=ien to DGPM Patient Movement
 ;        IBDFN=ien to Patient File
 ;
 ;  Output:  
 ;       IBREST= if 0^ 2nd piece is error message
 ;             = if 1^ the rate has been calculated.
 N IBATERR,IBRTYPE,IBADMDT,CHARGE,IBPREF,DISSPEC,TYPE,IBCALC,DRG
 I '$G(PTF)!('$G(ADMIS))!('$G(IBDFN)) S IBREST="0^Parmeter passed in to FINDRT was less than one" Q IBREST
 S IBATERR=0,IBADMDT=$P($P($G(^DGPM(+ADMIS,0)),U),".")
 I IBADMDT<1 S IBREST="0^No admission date FOUND for ^dgpm ien="_ADMIS Q IBREST
 S IBRTYPE=$$TYPRATE(PTF)  ; returns bed or drg
 I IBRTYPE["Could not find" Q IBRTYPE  ;no DRG or Rate could be found
 I $P(IBRTYPE,U,2)["DRG" D  Q IBREST
 . S DRG=$P(IBRTYPE,U)
 . ; Find the home facility
 . S IBPREF=$$PPF^IBATUTL(+IBDFN) I 'IBPREF S IBREST="0^No home facility found for DFN="_IBDFN  Q
 . ; Pass in DRG the date of the admission, the pref fac. and return
 . ; CHARGE=1!0^default rate^nego rate^rate to use^tortliability rate
 . S CHARGE=$$INPT^IBATCM(DRG,IBADMDT,IBPREF)
 . I '$P(CHARGE,U)!$P(CHARGE,U,4)<1 S IBREST="0^Could not find a valid charge for the DRG" Q
 . ; Pass in string "DRG",ien 405,DRG, DOLLAR AMOUNT)
 . S IBREST=$$CALCRT("DRG",ADMIS,DRG,$P(CHARGE,U,4))
 . ; if the second piece of IBVALUE is there than we have an
 . ; error (need to do something) if not file away.
 . ; if the filing was successful we need to set IBREST=1 and quit
 . ; otherwise set IBREST="0^give reason for problem
 I $P(IBRTYPE,U,2)["BED" D  Q IBREST  ; price and file the claim
 . S IBREST=$$CALCRT("BED",ADMIS,$P(IBRTYPE,U))
 ;
TYPRATE(X) ;  Pass in PTF ien and return either DRG or Bedsection or ERROR
 ; see if PTF has a DRG
 I '$G(X) S TYPE="0^Parameter passed into TYPRATE(X) has no value" Q TYPE
 N IBPTF,IBPTFD,DIC,DA,DR,DIQ,IBDISCH,IBBED
 S DIC="^DGPT(",DA=X,DR=".01;71;9",DIQ="IBPTF",DIQ(0)="I" D EN^DIQ1
 K DIQ(0) S DIQ="IBPTFD" D EN^DIQ1  ; i need the computed drg value
 I '$D(IBPTF),('$D(IBPTFD)) S TYPE="0^Could not find PTF RECORD" Q TYPE
 I $G(IBPTFD(45,DA,9))="",$G(IBPTF(45,DA,71,"I"))="" S TYPE="0^Could not find a PTF RECORD" Q TYPE
 S DISSPEC=$G(IBPTF(45,DA,71,"I")) ; used in $$calc when calculating outliers
 ; Below if i have a drg and the drg can be priced SELECT drg
 I $G(IBPTFD(45,DA,9)),+$$INPT^IBATCM(IBPTFD(45,DA,9),IBADMDT) S TYPE=$G(IBPTFD(45,DA,9))_U_"DRG"
 E  D
 . S IBDISCH=$G(IBPTF(45,DA,71,"I")) ;gives you the discharge speciality
 . S IBBED=$P($G(^DIC(42.4,+IBDISCH,0)),U,5) ; Bedsection 399.1
 . S TYPE=IBBED_U_"BED"
 Q TYPE
 ;
CALCRT(Z,Y,V,R) ; Calculate LOS, and price out claim.
 ;   INPUT:
 ;         Z = a string either "BED" or "DRG"
 ;         Y = ien for the admission movement
 ;         V = value either bedsection NAME or the drg NUMBER
 ;         R = used only with DRG and it is the dollar value of the drg.
 ;  OUTPUT:
 ;         IBCALC=" if 0^ 2nd piece is error message
 ;                  if 1^ there are 2 possible options that can be returned
 ;         Option 1 - If we are calculating a Bed Section
 ;                  1^calculated amount^"B"
 ;         Option 2 - If we are calculating a DRG
 ;                  1^calculated amt^ien drg^los^hightrim^outlier days
 ;                  ^bedsection rate for the outliers
 ;
 N X,IBBEDPTR,IBLOS,IBDATE,CALCDATE,DRGHIGH,IBBEDRT,IBDIFF,IBBED,IBOUTDT,IBBEDRT,DGPMIFN
 I '$D(Z)!('$D(V))!($G(Y)<1) S IBCALC="0^parameter 'Z' is invalid" Q IBCALC
 S IBCALC=0 I Z'="DRG"&(Z'="BED") S IBCALC="0^parameter is incorrect" Q IBCALC
 ; calculate the LOS  Y=ien for the admission movement
 I '$D(^DGPM(+Y,0)) S IBCALC="0^ien "_Y_" in 405 does not exist" Q IBCALC
 I Z["DRG",($G(R)<1) S IBCALC="0^the drg dollar value for ien "_Y_" was not passed in" Q IBCALC
 S DGPMIFN=Y D ^DGPMLOS
 I $P(X,U,5)<1 S IBCALC="0^no LOS found FOR movement "_Y Q IBCALC
 E  S IBLOS=$P(X,U,5)
 S IBDATE=$P($P($G(^DGPM(+Y,0)),U),".") ; Date of patient movement
 I Z="BED" D  Q IBCALC
 . ;get the pointer to the bedsection
 . S IBBEDPTR=$$MCCRUTL^IBCRU1(V,5) ; 5 distinguishes bedsection in 399.1
 . I IBBEDPTR<1 S IBCALC="0^could not find pointer to bedsection for name: "_V Q
 . S CALCDATE=IBDATE
 . ; below 1=ien to the charge set = TL-INPT(INCLUSIVE)  #363.3
 . S IBCALC=$$ITCHG^IBCRCI(1,IBBEDPTR,CALCDATE)
 . S IBCALC=$P(IBCALC,U)
 . S IBCALC=$S(IBCALC<1:"0^No rate found for bedsect "_Y,1:IBCALC)
 . I IBCALC<1 Q 
 . S IBCALC="1^"_(IBLOS*(IBCALC*.8))_U_"B"
 ;
 ; (*****  calculate DRG outliers here ******)
 I Z="DRG" D  Q IBCALC
 . ; do look up calculate drg value
 . S DRGHIGH=$P($$DRG^IBACSV(+V,IBDATE),U,4)
 . S IBDIFF=$S(DRGHIGH:IBLOS-DRGHIGH,1:0)
 . S IBCALC=R ;==DRG is calculated for the entire los except when there are high trim days
 . ; if you have an outlier and you have a bedsection calc outlier
 . ; disspec is the ptr to speciality from ptf set in $$typrate
 . I IBDIFF>0,(DISSPEC>0) D 
 . . ; DISSPEC ;gives you the discharge speciality
 . . S IBBED=$P($G(^DIC(42.4,+DISSPEC,0)),U,5) ; Name of Bedsection 399.1
 . . S IBBEDPTR=$$MCCRUTL^IBCRU1(IBBED,5) ; Ptr to bedsection
 . . S IBOUTDT=$P($G(^DGPM(+Y,0)),U)
 . . S IBBEDRT=$$ITCHG^IBCRCI(1,IBBEDPTR,IBOUTDT) ; returns rate for bedsection
 . . S IBBEDRT=$P(IBBEDRT,U)
 . . I IBBEDRT>0 S IBBEDRT=(IBBEDRT*.8) ;**BGA-MOD 2/9/2000
 . S IBCALC="1^"_IBCALC_U_V_U_IBLOS_U_DRGHIGH_U_$S(IBDIFF<1:0,1:IBDIFF)_U_$S($G(IBBEDRT)>0:IBBEDRT,1:0)
 . ; All bedsections,drgs and outliers are calculated at 80% of there face value
 Q IBCALC
 ;
END ;
 W !,"Updating Transfer Pricing has been...completed."
 Q
