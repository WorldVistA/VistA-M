IBCU64 ;ALB/ARH - AUTOMATED BILLER (INPT CONT) ;8/6/93
 ;;2.0;INTEGRATED BILLING;**14,80,130,51,137,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; DBIA REFERENCE TO ^DGPM, DGPM("AMV1" , "ATID1", "APTF" = DBIA419
 ; DBIA REFERENCE TO PLASIH^DGUTL2 = DBIA421
 ; DBIA REFERENCE TO APLD^DGUTL2 =
 ;
LOS1(IFN,IBDTS) ; returns length of stay for a  bill's date range
 ; If actual leave dates needed, pass IBDTS by reference
 ;  Returns IBDTS(begin leave dt)=end leave dt)
 N X,Y,DFN,IBADM,IBPMCA S (X,IBPMCA)=0,Y=$G(^DGCR(399,+$G(IFN),0)) G:Y="" LOS1Q I $P(Y,U,8)'="" D
 . ; find patient movement, based on admit date and DFN from PTF
 . S DFN=+$P(Y,U,2),IBADM=+$P(Y,U,3) I 'IBADM Q
 . S IBPMCA=$O(^DGPM("AMV1",+IBADM,+DFN,0))
 S X=$G(^DGCR(399,+IFN,"U"))
 S X=$$LOS($P(X,U,1),$P(X,U,2),$P(Y,U,6),IBPMCA,.IBDTS)
LOS1Q Q X
 ;
AD(IBPMCA) ; returns inpatient admit and discharge date, DFN, PTF, Facility Treating Specialty, if one/both don't exist "0^0"
 N X,Y S X="0^0" I '$G(IBPMCA) G ADQ
 S Y=$G(^DGPM(+IBPMCA,0)) ; get patient movement data
 S X=+Y_"^"_+$G(^DGPM(+$P(Y,U,17),0))_"^"_$P(Y,U,3)_"^"_$P(Y,U,16)_"^"_$P(Y,U,9)
ADQ Q X
 ;
LOS(IBBDT,IBEDT,BTF,IBPMCA,IBDTS) ; calculate the inpatient length of stay for a given time period
 ;parameters are input variables into DGUTL2, which calculates days absent or on pass
 ;if the pat movment IFN is not available then can't check of absence or pass days
 ;LOS: discharge date is not added except for inpt interim first and continuous where discharge date is added,
 ;    absent or pass days not added,
 ;    admission and discharge on same day has LOS=1, discharge date=admission date+1 also has an LOS=1
 ; Array returned (if passed by reference) IBDTS=# of leave days
 ;                IBDTS(begin date)=end date for all leave periods 
 N X,IBX,IBY,IBDISDT,IBADM,DFN,IBA S IBX=0 I '$G(IBBDT)!'$G(IBEDT) G LOSQ
 I IBBDT=IBEDT!($G(BTF)=2)!($G(BTF)=3) S IBEDT=$$FMADD^XLFDT(IBEDT,1) ; inclusive if interim continuous or first
 S IBX=$$FMDIFF^XLFDT(IBEDT,IBBDT,1) ; difference between begin and end date
 I +$G(IBPMCA) S IBY=$$AD(IBPMCA) I +IBY S IBADM=+IBY\1,IBDISDT=$P(IBY,U,2)\1,DFN=$P(IBY,U,3) D
 . ; maximum date range is the admit thru discharge range
 . S:IBBDT<IBADM IBBDT=IBADM I +IBDISDT&(IBEDT>IBDISDT) S IBEDT=IBDISDT
 . S IBX=$$FMDIFF^XLFDT(IBEDT,IBBDT,1) I (IBBDT\1)=(IBEDT\1) S IBX=1
 . S IBX=IBX-$$NONCOV(IBBDT,IBEDT,IBPMCA,.IBDTS) ; subtract days absent or on pass
LOSQ Q $S(IBX>0:IBX,1:0)
 ;
DUPCHKI(DT1,DT2,PTF,RTG,DISP,IFN) ;Check for duplicate billing of inpt admission - checks for overlapping date range on other
 ;bills with the same rate type and that have not been cancelled
 ;input:   DT1 - beginning of date range to check
 ;         DT2 - ending of date range to check
 ;         PTF - ptr to PTF record
 ;         DISP - true if error message should be printed before exit, if any
 ;         RTG - rate group to check for, if no rate group (0 passed and/or no IFN) then any bill found for
 ;          visit date will cause error message
 ;         IFN - existing bill to check against, if passed will use variables from this bill if they are not passed in
 ;returns: 0 - if another bill was not found for this admission with this date range, patient, and rate type
 ;         (dup IFN)_"^error message" - if duplicate date found, same rate group then IFN of bill
 N IFN2,Y,X,X1 S Y=0,(X,X1)="",IFN=+$G(IFN) I +IFN S X=$G(^DGCR(399,IFN,0)),X1=$G(^DGCR(399,IFN,"U"))
 S RTG=$S($G(RTG)'="":+RTG,1:+$P(X,U,7)),PTF=$S(+$G(PTF):+PTF,1:+$P(X,U,8)) G:'PTF DCIQ
 S DT1=$S(+$G(DT1):+DT1,1:$P(X1,U,1)),DT2=$S(+$G(DT2):+DT2,1:$P(X1,U,2)) G:'DT1!'DT2 DCIQ
 S DT1=DT1\1,DT2=DT2\1 I (DT1>DT2)!('$D(^DGCR(399,"APTF",PTF))) G DCIQ
 S IFN2=0 F  S IFN2=$O(^DGCR(399,"APTF",PTF,IFN2)) Q:'IFN2  I IFN'=IFN2 D  Q:+Y
 . S X1=$G(^DGCR(399,IFN2,0)) I $P(X1,U,13)=7 Q  ; bill cancelled
 . I +RTG,$P(X1,U,7)'=RTG Q  ; different rate group
 . S X=$G(^DGCR(399,IFN2,"U")) I (DT2<+X)!(DT1>+$P(X,U,2)) Q
 . S Y=IFN2_"^A "_$P($G(^DGCR(399.3,+$P(X1,U,7),0)),U,1)_" bill ("_$P(X1,U,1)_") exists overlapping this date range."
DCIQ I +$G(DISP),+Y W !,?10,$P(Y,U,2)
 Q Y
 ;
ADM(DFN,IBDT) ; -- send back Admission and Discharge Dates for a patient on IBDT (or now) if any, 0 otherwise
 ;returns 'Adm Dt^Disch Dt^PM ptr^PTF ptr' if patient was admitted at any time during IBDT or before discharge date and time
 N IBNDT,IBINPT,IBADM,IBADT1,IBADT2,IBDIS,IBNOW,%,X,Y S IBNOW=$$NOW^XLFDT
 S IBINPT=0,IBDT=$G(IBDT) G:'$D(^DPT(+$G(DFN),0)) ADME I 'IBDT S IBDT=IBNOW
 S IBNDT=9999999.999999-((IBDT\1)+.99999),IBADT2=IBNOW
 F  S IBNDT=$O(^DGPM("ATID1",DFN,IBNDT)) Q:'IBNDT  D  Q:+IBINPT
 . S IBADM=+$O(^DGPM("ATID1",DFN,IBNDT,0)),IBADT1=$G(^DGPM(+IBADM,0)) Q:IBADT1=""
 . S IBDIS=$P(IBADT1,U,17) I +IBDIS S IBADT2=+$G(^DGPM(+IBDIS,0)),IBDIS=IBADT2
 . I $P(IBADT2,".",2)="" S $P(IBADT2,".",2)=999999
 . I (+IBADT1\1)'>(IBDT\1),(IBADT2'<IBDT!((+IBADT1\1)=(+IBDT\1))) S IBINPT=+IBADT1_U_+IBDIS_U_IBADM_U_$P(IBADT1,U,16)
ADME Q IBINPT
 ;
PTFADM(PTF) ; given a PTF #, return the Patient Movement Admission entry pointer (405)
 N IBX S IBX="" I +$G(PTF) S IBX=$O(^DGPM("APTF",+PTF,0))
 Q IBX
 ;
NONCOV(IBBDT,IBEDT,IBPMCA,IBDTS) ; Determine the total # of non billable
 ;   days in an inpt date range
 ; variables are input to DGUTL2 call
 ; Array IBDTS(movement from date)=movement to date is returned if passed
 ; by reference
 ;
 N Z,IBZ
 S Z=+$$APLD^DGUTL2(IBPMCA,.IBZ,IBBDT,IBEDT,"B")
 I Z>0,$G(IBZ(0))>0 S IBDTS=+IBZ(0) D
 . S Z=0 F  S Z=$O(IBZ(Z)) Q:'Z  S IBDTS(+$P(IBZ(Z),U))=$P(IBZ(Z),U,2)
 Q +$G(IBZ(0))
 ;
PPS(IBIFN,IBPTF) ; Calculate the claim's default PPS - prospective payment system code.
 ; Also known as the DRG - diagnosis-related group.
 ; This field is a trigger from the .08 field PTF entry# to field# 170 for the PPS.
 ; IB*2*400 addition
 ; Input - IBIFN - ien to file 399
 ;         IBPTF - ien to file 45 - value of the .08 field
 NEW PPS S PPS=""
 I '$$INPAT^IBCEF(IBIFN) G PPSX                             ; pps field is for inpatients only
 I $$FT^IBCEF(IBIFN)'=3 G PPSX                              ; pps field is for UB claims only
 S PPS=+$$GET1^DIQ(45,+$G(IBPTF)_",",9,"")                  ; value of the discharge DRG from PTF
 I $$DRGTD^IBACSV(PPS,$$BDATE^IBACSV(IBIFN))="" S PPS=""    ; make sure DRG description exists
PPSX ;
 Q PPS
 ;
PPSC(IBIFN) ; Trigger condition for setting the PPS field (field# 170)
 ; Function value=1 if it is OK to fire the trigger
 N OK S OK=0
 I +$P($G(^DGCR(399,IBIFN,"U1")),U,15) G PPSCX      ; pps value already on file
 I '$$INPAT^IBCEF(IBIFN) G PPSCX                    ; must be an inpatient claim
 I $$FT^IBCEF(IBIFN)'=3 G PPSCX                     ; must be a UB claim
 S OK=1
PPSCX ;
 Q OK
 ;
