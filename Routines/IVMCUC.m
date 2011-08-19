IVMCUC ;ALB/KCL/CJM,LBD - DATA COLLECTION DIVISION (DCD) SELECTION CRITERIA ; 07-MAR-95
 ;;2.0;INCOME VERIFICATION MATCH;**9,17,62**;21-OCT-94
 ;
 ;
BT(IEN) ;
 ;Description: logs DCD defined Beneficiary Travel event if DCD criteria are met.
 ;
 N DFN
 Q:'$G(IEN)
 S DFN=$P($G(^DGBT(392.2,IEN,0)),"^",2)
 D:DFN LOGDCD(DFN)
 Q
LOGDCD(DFN,IVMCDT) ;
 ;Description: logs DCD defined events for nightly transmission if DCD criteria are met.
 ;
 ;Input:
 ;  DFN - ien of record in the PATIENT file
 ;  IVMCDT - optional parameter, is the date/time to check, uses DT if not passed in
 ;
 ;
 S:'$G(IVMCDT) IVMCDT=DT
 ;if patient meets DCD criteria, want to log patient for transmission
 I $$DCD(DFN,IVMCDT) D
 .N EVENTS,YEAR
 .S EVENTS("DCD")=1
 .S YEAR=$E(IVMCDT,1,3)-1_"0000"
 .I $$LOG^IVMPLOG(DFN,YEAR,.EVENTS) ;then call was successful
 Q
DCD(DFN,IVMCDT) ;
 ; - Determine if patient meets Data Collection Division (DCD) selection
 ;   criteria and should be transmitted to the HEC.
 ;   ===================================================================
 ;   Veteran meets DCD section criteria if:
 ;          1. MT category based on IVMCDT is Cat A or Cat C
 ;             or GMT (added by IVM*2*62)
 ;
 ;     OR,  2. Completed an Rx-Copay Test based on IVMCDT
 ;
 ;     OR,  3. Primary Eligiblility is NSC and veteran is
 ;             eligible for Medicaid based on IVMCDT
 ;
 ;     OR,  3. Primary Eligiblility is (NOT) one of the following:
 ;              1. NSC, VA PENSION
 ;              2. SC 50% TO 100%
 ;              3. AID & ATTENDANCE
 ;              4. HOUSE BOUND
 ;
 ;               AND,
 ;                      a. Had any Income Screening based on IVMCDT
 ;                 OR,  b. Submitted a claim for BT based on IVMCDT
 ;   ====================================================================
 ;
 ;  Input:     DFN - as  IEN of Patient (#2) file
 ;          IVMCDT - as  Date/Time (Optional - default is today@2359)
 ;
 ; Output:  1 --> if pt meets DCD selection criteria and
 ;                should be sent to IVM Center
 ;          0 --> if pt does not meet DCD selection criteria and 
 ;                should not be sent to IVM Center
 ;
 N IVMCBTCL,IVMCPEL,IVMCFLAG,IVMCIYR,IVMCTEST,VA,VAERR,VAEL
 ;
 S DFN=$G(DFN) I '$D(^DPT(+DFN,0)) G DCDQ
 S IVMCDT=$S($G(IVMCDT):IVMCDT,1:DT) S:'$P(IVMCDT,".",2) IVMCDT=IVMCDT_.2359
 ;
 ; - exclude non-vets
 I $G(^DPT(DFN,"VET"))="N" G DCDQ
 ;
 ; - determine income year
 S IVMCIYR=$$LYR^DGMTSCU1(IVMCDT)
 ;
 ; - flag indicating pt meets DCD selection criteria, transmit
 S IVMCFLAG=1
 ;
MT ; - get last Means Test or Rx Copay Test for patient
 S IVMCTEST=$$LST^DGMTCOU1(DFN,IVMCDT,3)
 I $E($P(IVMCTEST,"^",2),1,3)'=$E(IVMCDT,1,3) G PRIM
 ;
 ; - if pt MT category is A or C based on date of test, transmit
 ;   add check for GMT status (IVM*2*62)
 I IVMCTEST,($P(IVMCTEST,"^",5)=1),"^A^C^G^"[("^"_$P(IVMCTEST,"^",4)_"^") G DCDQ
 ;
 ; - if completed Rx Copay Test based on date of test, transmit
 I IVMCTEST,($P(IVMCTEST,"^",5)=2),($P(IVMCTEST,"^",4)="M"!($P(IVMCTEST,"^",4)="E")) G DCDQ
 ;
PRIM ; - get pt Primary Eligibility
 D ELIG^VADPT S IVMCPEL=$P($G(^DIC(8,+VAEL(1),0)),"^",9)
 ;
 ; - if Primary Elig code is NSC and eligible for Medicaid 
 ;   based on (Date Last Asked?) field, transmit
 I IVMCPEL=5,+$G(^DPT(DFN,.38)),($P($G(^(.38)),"^",2)>($E(DT,1,3)-2_1231.999999)) G DCDQ
 ;
 ; - if pt Primary Eligibility code is on DCD exclusion list,
 ;   do not transmit
 I "^1^2^4^15^"[("^"_IVMCPEL_"^") S IVMCFLAG=0 G DCDQ
 ;
 ; - If pt has any Income Screening (reported income), transmit
 I $$IS(DFN,IVMCIYR) G DCDQ
 ;
 ; - if submitted Beneficiary Travel claim
 S IVMCBTCL=$O(^DGBT(392,"C",DFN,$E(IVMCDT,1,3)_"0000"))
 ;
 ; - check if claim in date range
 G:IVMCBTCL DCDQ
 ;
 ; - otherwise, set flag indicating pt should not be transmitted
 S IVMCFLAG=0
 ;
DCDQ Q $G(IVMCFLAG)
 ;
 ;
IS(DFN,IVMCIYR) ; Has the veteran had Income Screening this year?
 ;  Input:     DFN  --  Pointer to the patient in file #2
 ;         IVMCIYR  --  Income year in question
 ; Output:  Has the vet had income screening?  0 => No | 1 => Yes
 ;
 N IVMCIS,IVMCPR,IVMCIAI S IVMCIS=0
 I '$G(DFN) G ISQ
 ;
 ; - get IEN of Patient Relation (#408.12) file, look at pts dependents
 F IVMCPR=0:0 S IVMCPR=$O(^DGPR(408.12,"B",DFN,IVMCPR)) Q:'IVMCPR  D
 .;
 .; - get IEN of Individual Annual Income (#408.21) file
 .;   get dependents annual income record effective on input date
 .S IVMCIAI=$O(^DGMT(408.21,"AI",+IVMCPR,-IVMCIYR,0))
 .;
 .; - check for reported income
 .I IVMCIAI S IVMCIS=IVMCIS+$S($P($G(^DGMT(408.21,+IVMCIAI,0)),U,8,17)'?."^":1,1:0)
 ;
ISQ Q IVMCIS>0
