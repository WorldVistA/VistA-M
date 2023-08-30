IBAUTL8 ;ALB/MGD - DUPLICATE COPAY TRANSACTION UTILITIES; Sep 30, 2020@15:16:44
 ;;2.0;INTEGRATED BILLING;**630**;21-MAR-94;Build 39
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ****************************************************************************
 ; This routine is designed to implement a series of final checks immediately *
 ; prior to IB releasing a charge over to Accounts Receivable (AR).           *
 ; IBAUTL9 handles the storing of associated information related to any       *
 ; duplicate copays found by IBAUTL8.                                         *
 ; These updates are part being released in IB*2.0*630.                       *
 ; ****************************************************************************
 ;
COPAYCHK(IBDFN,IBN,IBINTACT) ;
 ; Determine if the Copay charge currently being reviewed should be passed over to Accounts Receivable (AR)
 ; Input:
 ;      IBDFN = Pointer to the Patient in file #2
 ;        IBN = Pointer to the charge in file #350
 ;   IBINTACT = Optional - Flag to indicate when the call is being made from an interactive option.
 ;              1:Interactive
 ;                For Interactive call, the IEN of the existing copay charge will be passed
 ;                back and this info will be used to display an error message for the 
 ;                Release Charges 'On Hold' [IB MT RELEASE CHARGES] option and the Pass a Charge
 ;                action on the Cancel/Edit/Add Patient Charges [IB CANCEL/EDIT/ADD CHARGES] option.
 ;              0:Non-Interactive
 ;                For Non-Interactive calls, duplicate copay transaction information
 ;                will be stored in ^XTMP("IB TRANS").
 ;                At the end of the IB nightly background job, any duplicate copay info in
 ;                ^XTMP("IB TRANS") will be sent via MailMan to the IB DUPLICATE TRANSACTIONS mail group.
 ;
 ; Output: IBACTION = Flag to indicate whether the copay charge being reviewed should be passed to AR.
 ;        Flag # - The IEN of the existing Copay charge for the Patient/Date of interest.
 ;                 The charge being reviewed should NOT be passed over to AR.
 ;             0 - There is no existing Copay charge for this Patient/Date.
 ;                 The charge being reviewed should be passed over to AR.
 ;
 ; The checks that occur in the software below are prioritized based on the existing VA rules.
 ;
 N IBACTION,IBAT,IBDATA0,IBEVDT
 ; Initialize return value.
 ; Defaulting to 0 will cause the charge currently being reviewed to be passed over to AR.
 ; Currently, there is no existing check to prevent passing duplicates over to AR so setting
 ; IBACTION = 0 mimics the way the software currently works. Our new checks will set
 ; IBACTION = IEN of existing copay charge to prevent the duplicates charges from occurring.
 S IBACTION=0
 ; Quit if DFN or IBN not defined
 I '+IBDFN!('+IBN) Q IBACTION
 ; If IBINTACT was not passed in, default it to 0:Non-Interactive
 S IBINTACT=$S(IBINTACT'="":IBINTACT,1:0)
 ; Quit if DFN not valid
 I '$D(^DPT(IBDFN)) Q IBACTION
 ; Load the 0 node from File #350 for this record. QUIT if no 0 node
 S IBDATA0=$G(^IB(IBN,0))
 I IBDATA0="" Q IBACTION
 ; Load EVENT DATE (#.17)
 S IBEVDT=$P(IBDATA0,U,17)
 ; If the EVENT DATE is not defined, default to DATE BILLED FROM (#.14)
 I IBEVDT'?7N S IBEVDT=$P(IBDATA0,U,14)
 ; Quit if no valid EVENT DATE or DATE BILLED FROM
 I IBEVDT'?7N Q IBACTION
 ; Load the ACTION TYPE (#.03) for the charge being reviewed
 S IBAT=$P(IBDATA0,U,3)
 ; Quit if Action Type not defined
 I +IBAT<=0 Q IBACTION
 ;
 ; Perform checks for Outpatient Copays.
 ; Action Types = 51 - DG OPT COPAY NEW    74 - DG OBSERVATION COPAY NEW      
 ;               136 - CC (OPT) NEW       203 - CC URGENT CARE (OPT) NEW
 I "^51^74^136^203^"[("^"_IBAT_"^") D OCPYNEW(IBN,IBEVDT,.IBACTION,IBINTACT) Q IBACTION
 ;
 ; Perform checks for Inpatient Per Diem. It is legal to have both an Inpatient Per Diem AND an
 ; Inpatient Copay on the same day provided they are a correct pairing.
 ; Correct pairings are checked during the Inpatient checks.
 ; Action Types = 45 - DG INPT PER DIEM NEW      48 - DG NHCU PER DIEM NEW
 ;               133 - CC (PER DIEM) NEW
 I "^45^48^133^"[("^"_IBAT_"^") D IPDNEW^IBAUTL8A(IBN,IBEVDT,.IBACTION,IBINTACT) Q IBACTION
 ;
 ; Perform checks for Inpatient Copay. It is legal to have both an Inpatient Per Diem AND an
 ; Inpatient Copay on the same day provided they are the correct pairings.
 ; Correct pairings are checked in ICPYNEW.
 ; Tricare: GEN MED INPT COPAY (#15) - can have more than one per day. Bill all of
 ; these charges. There is no need to check for them.
 ; Action Types = 130 - CC (INPT) NEW             16 - DG INPT COPAY (SUR) NEW
 ;                 17 - DG INPT COPAY (SPI) NEW   18 - DG INPT COPAY (PSY) NEW
 ;                 19 - DG INPT COPAY (INT) NEW   20 - DG INPT COPAY (REH) NEW
 ;                 21 - DG INPT COPAY (BLI) NEW   22 - DG INPT COPAY (NEU) NEW
 ;                 23 - DG INPT COPAY (ALC) NEW   24 - DG NHCU COPAY NEW
 ;
 I "^130^16^17^18^19^20^21^22^23^24^"[("^"_IBAT_"^") D ICPYNEW^IBAUTL8C(IBN,IBEVDT,.IBACTION,IBINTACT) Q IBACTION
 ;
 ; Perform checks for Long Term Care (LTC) Copay.
 ; Action Types =  89 - DG LTC OPT ADHC NEW          92 - DG LTC OPT GEM NEW
 ;                 95 - DG LTC OPT RESPITE NEW      105 - DG LTC FEE OPT ADHC NEW
 ;                108 - DG LTC FEE OPT RESPITE NEW
 I "^89^92^95^105^108^"[("^"_IBAT_"^") D LTCNEW^IBAUTL8B(IBN,IBEVDT,.IBACTION,IBINTACT) Q IBACTION
 Q IBACTION
 ;
OCPYNEW(IBN,IBEVDT,IBACTION,IBINTACT) ;
 ; Perform checks for a new Outpatient Copay charge to determine if this charge should be passed over to AR.
 ;   Input:     
 ;          IBN = Pointer to Outpatient Copay charge currently being reviewed in the INTEGRATED BILLING ACTION (#350) file
 ;       IBEVDT = Event Date for the charge currently being reviewed in the INTEGRATED BILLING ACTION (#350) file
 ;     IBACTION = Passed by reference. Passed in as 0:Pass to AR
 ;     IBINTACT = Optional - Flag to indicate when the call is being made from an interactive option.
 ;                1:Interactive        
 ;                0:Non-Interactive
 ;                For more info see COPAYCHK above
 ;                    
 ; Output: IBACTION = 0 if the current charge being reviewed should be passed over to AR
 ;                    # The IEN of the existing Copay charge for the Patient/Date of interest.
 ;                      The charge being reviewed should NOT be passed over to AR.
 ;
 ; Verify incoming value of IBACTION and default to 0 if not defined
 S IBACTION=$S(IBACTION'="":IBACTION,1:0)
 ; Quit if necessary data was not passed in
 I +IBN<=0!(+IBEVDT'?7N) Q
 ; If IBINTACT was not passed in, default it to 0:Non-Interactive
 S IBINTACT=$S(IBINTACT'="":IBINTACT,1:0)
 N IBBFI,IBBFO,IBBOB,IBBPD,IBDFN,IBIEN,IBLTC,IBRSN
 ; Load Patient IEN from IBN passed in
 S IBDFN=+$P($G(^IB(IBN,0)),U,2)
 ; Quit if no IEN in record
 I IBDFN<1 Q
 ; Determine if the Patient has an Inpatient Copay for the Event Date
 S IBBFI=$$BFI^IBAUTL8C(IBDFN,IBEVDT,IBN)
 ; Determine if the Patient has an Per Diem Copay for the Event Date
 S IBBPD=$$BFPD^IBAUTL8A(IBDFN,IBEVDT,IBN)
 ; Determine if the Patient has an Observation Copay for the Event Date
 S IBBOB=$$BFOB^IBAUTL8A(IBDFN,IBEVDT,IBN)
 ; If the Patient has already been charged an Inpatient Copay charge OR an Inpatient Per Diem charge OR
 ; an Outpatient Observation Copay charge for the Event Date, Don't pass Outpatient Copay to AR
 I IBBFI!IBBPD!IBBOB D  Q
 . ; Set return value to NOT pass the charge over to AR
 . S IBACTION=$S(IBBFI:IBBFI,IBBPD:IBBPD,IBBOB:IBBOB,1:0)
 . ; Quit if interactive
 . Q:IBINTACT
 . ; Cancel the Outpatient Copay charge being reviewed with CANCELLATION REASON = 42 - BILLED AT HIGHER TIER RATE
 . ; ### Uncomment for Phase 2 D CNCLCHRG^IBAUTL8A(IBN,42)
 . ; Determine which Cancellation Reason to include in MailMan message
 . I IBBFI>0 S IBIEN=IBBFI,IBRSN="EXISTING INPATIENT COPAY CHARGE WHICH HAS HIGHER PRECEDENCE"
 . I IBBPD>0 S IBIEN=IBBPD,IBRSN="EXISTING INPATIENT PER DIEM CHARGE WHICH HAS HIGHER PRECEDENCE"
 . I IBBOB>0 S IBIEN=IBBOB,IBRSN="EXISTING OBSERVATION COPAY CHARGE WHICH HAS HIGHER PRECEDENCE"
 . ; Record related info into ^XTMP for MailMan message
 . I 'IBINTACT D STORE1^IBAUTL9(IBN,IBIEN,IBRSN)
 . Q
 ;
 ; Determine if the Patient has an Outpatient Copay for the Event Date
 S IBBFO=$$BFO^IBAUTL8A(IBDFN,IBEVDT,IBN)
 ; If the Patient has already been charged an Outpatient Copay for the Event Date, compare current charge being
 ; reviewed to the existing Outpatient Copay charge and determine what action to take.
 I IBBFO D  Q
 . ; Set IBACTION = IEN of Outpatient Copay
 . S IBACTION=IBBFO
 . ; Quit if interactive
 . Q:IBINTACT
 . N IBCTOT,IBETOT
 . ; Load dollar amounts from the 2 charges. IBCTOT = Current Charge Being Reviewed Total, IBETOT = Existing Total
 . S IBCTOT=+$P($G(^IB(IBN,0)),U,7),IBETOT=+$P($G(^IB(+IBBFO,0)),U,7)
 . ; If the current charge being processed is <= to the existing Outpatient Copay charge
 . I IBCTOT<=IBETOT D  Q
 . . ; Cancel current charge being reviewed with CANCELLATION REASON = 4 - ENTERED IN ERROR
 . . ; ### Uncomment for Phase 2 D CNCLCHRG^IBAUTL8A(IBN,4)
 . . ; Record related info into ^XTMP for MailMan message
 . . S IBRSN="EXISTING OUTPATIENT COPAY CHARGE AT SAME OR HIGHER TIER RATE"
 . . D STORE1^IBAUTL9(IBN,IBBFO,IBRSN)
 . ; If the current charge being processed is > than the existing Outpatient Copay charge
 . I IBCTOT>IBETOT D  Q
 . . ; ### Uncomment for Phase 2
 . . ; IBND has to be set to 0 node for call to CANC^IBECEAU4
 . . ; ### N IBND S IBND=$G(^IB(IBN,0))
 . . ; IBFAC and IBSITE needed by Cancel operation below
 . . ; ### N IBFAC,IBSITE
 . . ; Calculate site from site parameters
 . . ; ### D SITE^IBAUTL
 . . ; If not interactive Cancel existing charge with Reason = 42 - BILLED AT HIGHER TIER RATE
 . . ; UNCOMMENT THIS AND TEST MORE ON WHAT HAPPENS IN THE CANCELLATION PROCESS
 . . ; ### I 'IBINTACT D CANC^IBECEAU4(IBBFO,42,1)
 . . ; Record related info into ^XTMP for MailMan message
 . . S IBRSN="ANOTHER OUTPATIENT COPAY CHARGE BILLED AT HIGHER TIER RATE"
 . . D STORE2^IBAUTL9(IBN,IBBFO,IBRSN)
 . . Q
 . Q
 ;
 ; Determine if the Patient has an Long Term Care Copay for the Event Date
 S IBLTC=$$LTC^IBAUTL8B(IBDFN,IBEVDT,IBN)
 ; If the patient has been charged a Long Term Care Copay for the Event Date, set IBACTION and quit
 I IBLTC D  Q
 . ; Set IBACTION = IEN of Outpatient Copay
 . S IBACTION=IBLTC
 . ; Quit if interactive
 . Q:IBINTACT
 . ; Record related info into ^XTMP for MailMan message
 . S IBRSN="AN OUTPATIENT COPAY CHARGE BILLED AT HIGHER TIER RATE"
 . D STORE2^IBAUTL9(IBN,IBLTC,IBRSN)
 Q
