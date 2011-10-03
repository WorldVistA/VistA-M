EASECU ;ALB/PHH,LBD,AMA - LTC Co-Pay Test Utilities ; 22 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,34,40,79**;Mar 15, 2001;Build 3
 ;
LST(DFN,DGDT,DGMTYPT) ;Last LTC Co-Pay test for a patient
 ;         Input  -- DFN   Patient IEN
 ;                   DGDT  Date/Time  (Optional- default today@2359)
 ;                DGMTYPT  Type of Test (Optional - if not defined 
 ;                                       LTC Co-Pay will be assumed)
 ;         Output -- LTC Co-Pay Test IEN^Date of Test
 ;                   ^Status Name^Status Code^Source of Test
 N DGIDT,DGMTFL1,DGMTI,DGNOD,Y I '$D(DGMTYPT) S DGMTYPT=3
 S DGIDT=$S($G(DGDT)>0:-DGDT,1:-DT) S:'$P(DGIDT,".",2) DGIDT=DGIDT_.2359
 F  S DGIDT=+$O(^DGMT(408.31,"AID",DGMTYPT,DFN,DGIDT)) Q:'DGIDT!$G(DGMTFL1)  D
 . F DGMTI=0:0 S DGMTI=+$O(^DGMT(408.31,"AID",DGMTYPT,DFN,DGIDT,DGMTI)) Q:'DGMTI!$G(DGMTFL1)  D
 . . S DGNOD=$G(^DGMT(408.31,DGMTI,0)) I DGNOD S DGMTFL1=1,Y=DGMTI_"^"_$P(^(0),"^")_"^"_$$MTS(+$P(^(0),"^",3))_"^"_$P(DGNOD,"^",23)
 Q $G(Y)
 ;
MTS(DGMTS) ;LTC Co-Pay test status -- default current
 ;         Input  -- DGMTS  LTC Co-Pay Test Status IEN
 ;         Output -- Status Name^Status Code
 N Y
 I $G(DGMTS) S Y=$P($G(^DG(408.32,DGMTS,0)),"^",1,2)
 Q $G(Y)
 ;
EXMPT(DFN) ;Check if veteran is exempt from LTC co-payments:
 ; If the veteran has a compensable SC disability, OR
 ; If the veteran is a single, NSC pensioner not in receipt of A&A
 ; and HB benefits
 ;   Input   -- DFN  Patient IEN
 ;   Output  -- 0 = veteran not exempt
 ;              1 = veteran has compensable SC disability
 ;              2 = veteran is single NSC pensioner (no A&A, HB)
 N X,Y,ELG
 S Y=0
 ; if service connected percentage is greater than 10% OR service
 ; connected percentage is less than 10% and annual VA
 ; check amount is greater than 0, then exempt type 1
 S X=$G(^DPT(DFN,.36)),ELG=$P($G(^DIC(8,+X,0)),U,9)
 I ELG=1!($P($G(^DPT(DFN,.3)),U,2)'<10) S Y=1 G EXMPTQ
 I ELG=3,$P($G(^DPT(DFN,.3)),U,2)<10,$P($G(^DPT(DFN,.362)),U,20)>0 S Y=1 G EXMPTQ
 ; if Service Connected quit
 I $P($G(^DPT(DFN,.3)),U)="Y" G EXMPTQ
 ; if Marital Status = 'Married' or 'Separated' quit
 S X=$P($G(^DIC(11,+$P($G(^DPT(DFN,0)),U,5),0)),U,3)
 I "^M^S^"[("^"_X_"^") G EXMPTQ
 ; if not receiving VA pension quit
 S X=$G(^DPT(DFN,.362)) I $P(X,U,14)'="Y" G EXMPTQ
 ; if receiving A&A or HP benefits quit
 I $P(X,U,12)="Y"!($P(X,U,13)="Y") G EXMPTQ
 S Y=2
EXMPTQ Q Y
 ;
DIS(DFN) ;Display patient's current LTC Copay Test status and test date
 ; Input --  DFN   IEN of Patient file
 ; Output -- None
 N DGX,DGMTI,DGMTDT,DGMTS
 Q:'$G(DFN)
 S DGX=$$LST(DFN) Q:'DGX
 S DGMTI=+DGX,DGMTDT=$P(DGX,U,2),DGMTS=$P(DGX,U,3) S:DGMTS="" DGMTS="UNKNOWN"
 W !,"LTC Copayment Status: ",DGMTS,"   Last Test: " S Y=DGMTDT X ^DD("DD") W Y
 ; If last test is over a year old and patient is not deceased or not
 ; exempt due to eligibility (compensable SC) or LTC before 11/30/99
 ; display message that a new test is required
 I $$FMDIFF^XLFDT(DT,DGMTDT)>364 D
 . I $P($G(^DPT(DFN,.35)),U) Q
 . I "^1^4^"[(U_$P($G(^DGMT(408.31,DGMTI,2)),U,7)_U) Q
 . W " **NEW TEST REQUIRED**"
 I $P($G(^DGMT(408.31,DGMTI,0)),U,11)=0 W !,"Patient INELIGIBLE to Receive LTC Services -- Did Not Agree to Pay Copayments"
 Q
 ;
FORM(DGMTI) ; Return the version of the 10-10EC form used to complete
 ; the LTC Copay Test passed in DGMTI
 ;     Input:  DGMTI - LTC Copay Test (IEN file #408.31)
 ;     Output: 0 = Original format
 ;             1 = Revised format
 I '$G(DGMTI) Q 0
 Q $P($G(^DGMT(408.31,DGMTI,2)),U,10)
 ;
 ;EAS*1.0*79 - Instead of changing DIS (in case another routine
 ;             calls it), copied it but also used LTC Admission Date
DISDT(DFN,EASADM) ;Display patient's LTC Copay Test status for a given LTC Admission Date
 ; Input -- DFN - IEN of Patient file
 ;          EASADM - LTC Admission Date
 ; Output -- None
 N DGX,DGMTI,DGMTDT,DGMTS
 Q:'$G(DFN)  Q:'$G(EASADM)
 S DGX=$$LST(DFN,EASADM) Q:'DGX
 S DGMTI=+DGX,DGMTDT=$P(DGX,U,2),DGMTS=$P(DGX,U,3) S:DGMTS="" DGMTS="UNKNOWN"
 W !,"LTC Copayment Status: ",DGMTS,"   Last Test: " S Y=DGMTDT X ^DD("DD") W Y
 ; If last test is over a year old and patient is not deceased or not
 ; exempt due to eligibility (compensable SC) or LTC before 11/30/99
 ; display message that a new test is required
 I $$FMDIFF^XLFDT(DT,DGMTDT)>364 D
 . I $P($G(^DPT(DFN,.35)),U) Q
 . I "^1^4^"[(U_$P($G(^DGMT(408.31,DGMTI,2)),U,7)_U) Q
 . W " **NEW TEST REQUIRED**"
 I $P($G(^DGMT(408.31,DGMTI,0)),U,11)=0 W !,"Patient INELIGIBLE to Receive LTC Services -- Did Not Agree to Pay Copayments"
 Q
