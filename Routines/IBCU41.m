IBCU41 ;ALB/ARH - THIRD PARTY BILLING UTILITIES (OP VISIT DATES) ;6-JUN-93
 ;;2.0;INTEGRATED BILLING;**80,106,51,294**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
OPV(DATE,IFN) ;input transform for outpatient visit dates (399,43,.01)
 ;input:  DATE - to add
 ;        IFN  - bill to add to
 ;returns: 1 - if OK to add
 ;         0 - if not
 N X,Y S X=1
 I '$$OPV2(DATE,IFN,1) S X=0
 I '$$OPV1(IFN,1) S X=0
 S Y=$$APPT^IBCU3(DATE,$P($G(^DGCR(399,IFN,0)),U,2),1)
 S Y=$$DUPCHK(DATE,IFN,1)
 Q X
 ;
OPV1(IFN,DISP,CNT) ;edit checks for adding visit dates, if any of these fail then no visit date should be added to the bill
 ;these are the types of checks that if they fail a message should be displayed to the user
 ;does not check date passed in against existing dates, assumes new visit date
 ;input:  IFN  - required, internal file number of bill to check
 ;        DISP - if true then error messager will be printed, if any
 ;        CNT  - number of visit dates user wants to add to bill
 ;returns: "1^warning message" - if OK to add more visit dates to the bill
 ;         "0^error message" - if no more visit dates should added to the bill
 ;
 N X,Y S Y=1 S:$G(CNT)="" CNT=1 S:$G(UN)="" UN=$G(^DGCR(399,+IFN,"U"))
 I '$P(UN,U,1) S Y="0^No 'Statement From' date on file ... Can't enter OP visit dates ..." G OPV1E
 I '$P(UN,U,2) S Y="0^No 'Statement To' date on file ... Can't enter OP visit dates ..." G OPV1E
 G:'$O(^DGCR(399,IFN,"OP",0))&(CNT<2) OPV1E
 I $P($G(^DGCR(399,IFN,"OP",0)),U,4)+CNT>30 S Y="0^Maximum of 30 visit dates allowed per bill!" G OPV1E
 I +$P($G(^DGCR(399,+IFN,0)),U,19)'=2,$D(^DGCR(399,IFN,"CP","ASC")) S Y="0^Only one visit date allowed on bills with Billable Amb. Surg. Codes!" G OPV1E
 ;warnings:
 I +Y,+$P($G(^DIC(36,$S(+$G(^DGCR(399,IFN,"MP")):+^("MP"),$$MCRWNR^IBEFUNC(+$$CURR^IBCEF2(IFN)):+$$CURR^IBCEF2(IFN),1:0),0)),U,8) S Y="1^This insurance Company will only accept one visit per bill!" G OPV1E
OPV1E I +$G(DISP),$P(Y,U,2)'="" W !,?10,$P(Y,U,2)
 Q Y
 ;
OPV2(DATE,IFN,DISP,UN) ;edit checks for adding visit dates, if any if these fail then the given date should not be added to the bill
 ;these are the types of checks that determine if a particular visit date should be presented to the user for possible addition to the bill
 ;does not check date passed in against existing dates, assumes new visit date
 ;also being used for Procedure Date (399,304,1) input transform
 ;input:  DATE - required, date to check for addition to the bill
 ;        IFN  - required, internal file number of bill to check
 ;        DISP - if true then error messager will be printed, if any
 ;        UN   - the "U" node of the bill, pass if alrady defined in a var
 ;returns: "1^warning message" - if date is OK to add to the bill
 ;         "0^error message" - if date should not be added to the bill
 ;
 N X,Y S Y=1,DATE=$P(DATE,".",1) S:$G(UN)="" UN=$G(^DGCR(399,+IFN,"U"))
 I DATE<+UN S Y="0^Can't enter a visit date prior to the 'Statement From' date ..." G OPV2E
 I DATE>+$P(UN,U,2) S Y="0^Can't enter a visit date later than the 'Statement To' date ..." G OPV2E
OPV2E I +$G(DISP),$P(Y,U,2)'="" W !,?10,$P(Y,U,2)
 Q Y
 ;
DUPCHK(DATE,IFN,DISP,DFN,RTG) ;Check for duplicate billing of opt visit - checks for given visit date on other
 ;bills with the same rate type and that have not been cancelled (if not IFN then use DFN and RTG)
 ;input:   DATE - visit date to check
 ;         IFN - internal file number of bill date is being added to
 ;         DISP - true if error message should be printed before exit, if any
 ;         DFN - patient'S IFN (required only if IFN is not passed)
 ;         RTG - rate group to check for (""), if no rate group (0 passed and/or no IFN) then any bill found for
 ;               visit date will cause error message
 ;returns: 0 - if another bill was not found with this visit date, patient, and rate type
 ;         (dup IFN)_"^error message" - if duplicate date found, same rate group, IFN of other bill w/visit date
 ;(initially set up to check for same rate group because MT billing was done on the UB-82 so it was valid to have multiple bills with different rate groups for the same episode)
 N IFN2,Y,X S Y=0,DATE=$P(+$G(DATE),".",1),IFN=+$G(IFN),X=$G(^DGCR(399,IFN,0))
 S DFN=$S(+$G(DFN):$G(DFN),1:$P(X,U,2)),RTG=$S($G(RTG)'="":RTG,1:$P(X,U,7)) G:'DFN DUPCHKE
 I '$D(^DGCR(399,"AOPV",DFN,DATE)) G DUPCHKE
 S IFN2=0 F  S IFN2=$O(^DGCR(399,"AOPV",DFN,DATE,IFN2)) Q:'IFN2  I IFN2'=IFN D  Q:+Y
 . S X=$G(^DGCR(399,IFN2,0)) I $P(X,U,13)=7 Q  ; bill for date cancelled
 . I +RTG,RTG'=$P(X,U,7) Q  ; different rate group
 . S Y=IFN2_"^A "_$P($G(^DGCR(399.3,+$P(X,U,7),0)),U,1)_" bill ("_$P(X,U,1)_") exists for visit date ("_$$DAT1^IBOUTL(DATE)_")."
DUPCHKE I +$G(DISP),+Y W !,?10,$P(Y,U,2)
 Q Y
 ;
CTCHK(IBIFN) ; if professional/institutional bill passed in has a corresponding institutional/professional
 ; bill defined return it's bill number
 ; check/match: patient, bill type, event date, rate type, payer seq, statement from, statement to, not cancelled
 ;
 N IBFND,IB0,IBCT,IBDFN,IBEVDT,IBBT,IBRT,IBSEQ,IBSTDTS,IBCT1,IBIFN1,IB01 S IBFND=0
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),IBCT=$P(IB0,U,27) I 'IBCT G CTCHKQ
 S IBDFN=$P(IB0,U,2),IBEVDT=$P(IB0,U,3),IBBT=$P(IB0,U,5),IBRT=$P(IB0,U,7),IBSEQ=$P(IB0,U,21)
 S IBSTDTS=$P($G(^DGCR(399,IBIFN,"U")),U,1,2),IBCT1=$S(IBCT=1:2,IBCT=2:1,1:"") I 'IBCT1 G CTCHKQ
 ;
 S IBIFN1=0 F  S IBIFN1=$O(^DGCR(399,"D",IBEVDT,IBIFN1)) Q:'IBIFN1  D  Q:IBFND
 . S IB01=$G(^DGCR(399,IBIFN1,0))
 . I $P(IB01,U,13)=7 Q         ; cancelled bill
 . I IBDFN'=$P(IB01,U,2) Q     ; patient
 . I IBCT1'=$P(IB01,U,27) Q    ; charge type
 . I IBBT'=$P(IB01,U,5) Q      ; bill type/classification
 . I IBRT'=$P(IB01,U,7) Q      ; rate type
 . I '$P($G(^DGCR(399,IBIFN1,"S")),U,7),IBSEQ'=$P(IB01,U,21) Q    ; payer sequence (applies to non-MRA claims only; IB*2*294 modification)
 . I IBSTDTS'=$P($G(^DGCR(399,IBIFN1,"U")),U,1,2) Q     ; from/thru dates
 . S IBFND=IBIFN1              ; found a match
 . Q
 ;
CTCHKQ Q IBFND
