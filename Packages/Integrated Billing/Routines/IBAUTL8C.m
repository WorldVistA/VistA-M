IBAUTL8C ;ALB/MGD - DUPLICATE COPAY TRANSACTION UTILITIES CONT.; Sep 30, 2020@15:16:44
 ;;2.0;INTEGRATED BILLING;**630**;21-MAR-94;Build 39
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ****************************************************************************
 ; This routine is designed to implement a series of final checks immediately *
 ; prior to IB releasing a charge over to Accounts Receivable (AR).           *
 ; IBAUTL9 handles the storing of associated information related to any       *
 ; duplicate copays found by IBAUTL8.                                         *                                                              *
 ; These updates are part being released in IB*2.0*630.                       *
 ; ****************************************************************************
 ;
ICPYNEW(IBN,IBEVDT,IBACTION,IBINTACT) ; 
 ; Perform checks for a new Inpatient Copay charge to determine if this charge should be passed over to AR.
 ;   Input:
 ;       IBN = Pointer to Inpatient Copay charge currently being reviewed in the INTEGRATED BILLING ACTION (#350) file
 ;    IBEVDT = Event Date for the charge currently being reviewed in the INTEGRATED BILLING ACTION (#350) file
 ;  IBACTION = Passed by reference. Passed in as 0:Pass to AR
 ;  IBINTACT = Optional - Flag to indicate when the call is being made from an interactive option.
 ;             1:Interactive        
 ;             0:Non-Interactive
 ;             For more info see COPAYCHK above
 ;
 ; Output: IBACTION = 0 if the current charge being reviewed should be passed over to AR
 ;                    # The IEN of the existing Copay charge for the Patient/Date of interest.
 ;                      The charge being reviewed should NOT be passed over to AR.
 ;
 ; Inpatient Copays have precedence over Outpatient Observation Copays.
 ; If we are about to send a new Inpatient Copay over to AR OR if there is an existing Inpatient Copay
 ; already in AR for the patient/date, check to see if there is an existing Outpatient Observation Copay
 ; for the same date, and if there is, cancel the existing Outpatient Observation Copay.
 ;
 ; Verify incoming value of IBACTION and default to 0 if not defined
 S IBACTION=$S(IBACTION'="":IBACTION,1:0)
 ; Quit if necessary data was not passed in
 I +IBN<=0!(+IBEVDT'?7N) Q
 ; If IBINTACT was not passed in, default it to 0:Non-Interactive
 S IBINTACT=$S(IBINTACT'="":IBINTACT,1:0)
 N IBAT1,IBAT2,IBBFI,IBBFO,IBBFOB,IBBPD,IBCTOT,IBDFN,IBETOT,IBDATA0,IBLTC,IBRSN
 ; Load 0 node
 S IBDATA0=$G(^IB(IBN,0))
 ; Load Patient IEN and ACTION TYPE
 S IBDFN=+$P(IBDATA0,U,2),IBAT1=$P(IBDATA0,U,3)
 ; Quit if no IEN in record
 I IBDFN<1 Q
 ; Determine if the Patient has an Inpatient Copay (BG#1 or BG#2) for the Event Date
 S IBBFI=$$BFI^IBAUTL8C(IBDFN,IBEVDT,IBN)
 ; If the patient has NOT been charged an Inpatient Copay charge for the Event Date
 ; Set return value to pass the charge over to AR
 I 'IBBFI D  Q:IBACTION
 . ; Set IBACTION = 0 so Inpatient Copay charge currently being reviewed will be passed over to AR
 . S IBACTION=0
 . ; Since we are going to pass the Inpatient Copay charge currently being reviewed over to AR
 . ; we need to check for the existence of an existing Outpatient Observation Copay
 . S IBBFOB=$$BFOB^IBAUTL8A(IBDFN,IBEVDT,IBN)
 . ; if there is an existing Outpatient Observation Copay, Do the following
 . I +IBBFOB D
 . . ; Set IBACTION = IEN of Outpatient Observation Copay
 . . S IBACTION=IBBFOB
 . . ; Quit if interactive
 . . Q:IBINTACT
 . . ; ###Uncomment for Phase 2
 . . ; IBND has to be set to 0 node for call to CANC^IBECEAU4
 . . ; ### N IBND S IBND=$G(^IB(IBN,0))
 . . ; IBFAC and IBSITE needed by Cancel operation below
 . . ; ### N IBFAC,IBSITE
 . . ; Calculate site from site parameters
 . . ; ### D SITE^IBAUTL
 . . ; Cancel the existing Outpatient Observation Copay charge with
 . . ; CANCELLATION REASON = 42 - BILLED AT HIGHER TIER RATE
 . . ; ### I 'IBINTACT D CANC^IBECEAU4(IBBFI,42,1)
 . . ; Record related info into ^XTMP for MailMan message
 . . S IBRSN="AN INPATIENT COPAY CHARGE BILLED AT HIGHER PRECEDENCE"
 . . D STORE2^IBAUTL9(IBN,IBBFOB,IBRSN)
 . . Q
 . Q
 ; If the Patient has already been charged an Inpatient Copay charge for the Event Date
 I IBBFI D  Q:IBACTION
 . ; Load dollar amounts from the 2 charges
 . S IBCTOT=+$P($G(^IB(IBN,0)),U,7),IBETOT=+$P($G(^IB(+IBBFI,0)),U,7)
 . ; If the Inpatient Copay charge currently being processed is <= to the existing Inpatient Copay charge
 . I IBCTOT<=IBETOT D  Q
 . . ; Set return value to the existing Inpatient Copay charge which will prevent the current charge being sent over to AR
 . . S IBACTION=IBBFI
 . . ; Cancel Inpatient Copay charge currently being reviewed with CANCELLATION REASON = 4 - ENTERED IN ERROR
 . . ; ### Uncomment for Phase 2 D CNCLCHRG^IBAUTL8A(IBN,4)
 . . ; Record related info into ^XTMP for MailMan message
 . . I 'IBINTACT D
 . . . S IBRSN="EXISTING INPATIENT COPAY CHARGE AT SAME OR HIGHER TIER RATE"
 . . . D STORE1^IBAUTL9(IBN,IBBFI,IBRSN)
 . . ; If there is an existing Outpatient Observation Copay charge, cancel it as well
 . . ; with CANCELLATION REASON = 42 - BILLED AT HIGHER TIER RATE
 . . S IBBFOB=$$BFOB^IBAUTL8A(IBDFN,IBEVDT,IBN)
 . . I +IBBFOB D
 . . . ; Quit if interactive
 . . . Q:IBINTACT
 . . . ; Set 2nd piece of IBACTION = IEN of Outpatient Observation Copay
 . . . S $P(IBACTION,U,2)=IBBFOB
 . . . ; ### Uncomment for Phase 2
 . . . ; IBND has to be set to 0 node for call to CANC^IBECEAU4
 . . . ; ### N IBND S IBND=$G(^IB(IBN,0))
 . . . ; IBFAC and IBSITE needed by Cancel operation below
 . . . ; ### N IBFAC,IBSITE
 . . . ; Calculate site from site parameters
 . . . ; ### D SITE^IBAUTL
 . . . ; Cancel existing Outpatient Observation Copay charge
 . . . ; UNCOMMENT THIS AND TEST MORE ON WHAT HAPPENS IN THE CANCELLATION PROCESS
 . . . ; ### I 'IBINTACT D CANC^IBECEAU4(IBBFI,42,1)
 . . . ; Record related info into ^XTMP for MailMan message
 . . . S IBRSN="AN INPATIENT COPAY CHARGE BILLED AT HIGHER PRECEDENCE"
 . . . D STORE2^IBAUTL9(IBN,IBBFOB,IBRSN)
 . . Q
 . ; If the Inpatient Copay charge currently being processed is > than the existing Inpatient Copay charge
 . I IBCTOT>IBETOT D  Q
 . . ; Set return value to the existing Inpatient Copay charge which will prevent the current charge being sent over to AR
 . . S IBACTION=IBBFI
 . . ; ### Uncomment for Phase 2
 . . ; IBND has to be set to 0 node for call to CANC^IBECEAU4
 . . ; ### N IBND S IBND=$G(^IB(IBN,0))
 . . ; IBFAC and IBSITE needed by Cancel operation below
 . . ; ### N IBFAC,IBSITE
 . . ; Calculate site from site parameters
 . . ; ### D SITE^IBAUTL
 . . ; Cancel existing Inpatient Copay charge with Reason = 42 - BILLED AT HIGHER TIER RATE
 . . ; UNCOMMENT THIS AND TEST MORE ON WHAT HAPPENS IN THE CANCELLATION PROCESS
 . . ; ### I 'IBINTACT D CANC^IBECEAU4(IBBFI,42,1)
 . . ; Record related info into ^XTMP for MailMan message
 . . I 'IBINTACT D
 . . . S IBRSN="ANOTHER INPATIENT COPAY CHARGE AT HIGHER TIER RATE"
 . . . D STORE2^IBAUTL9(IBN,IBBFI,IBRSN)
 . . ; If there is an existing Outpatient Observation Copay charge, cancel it as well
 . . ; with CANCELLATION REASON = 42 - BILLED AT HIGHER TIER RATE
 . . S IBBFOB=$$BFOB^IBAUTL8A(IBDFN,IBEVDT,IBN)
 . . I +IBBFOB D
 . . . ; Quit if interactive
 . . . Q:IBINTACT
 . . . ; ### Uncomment for Phase 2
 . . . ; IBND has to be set to 0 node for call to CANC^IBECEAU4
 . . . ; ### N IBND S IBND=$G(^IB(IBN,0))
 . . . ; IBFAC and IBSITE needed by Cancel operation below
 . . . ; ### N IBFAC,IBSITE
 . . . ; Calculate site from site parameters
 . . . ; ### D SITE^IBAUTL
 . . . ; Cancel existing Outpatient Observation Copay charge
 . . . ; UNCOMMENT THIS AND TEST MORE ON WHAT HAPPENS IN THE CANCELLATION PROCESS
 . . . ; ### I 'IBINTACT D CANC^IBECEAU4(IBBFI,42,1)
 . . . ; Record related info into ^XTMP for MailMan message
 . . . S IBRSN="ANOTHER INPATIENT COPAY CHARGE AT HIGHER TIER RATE"
 . . . D STORE2^IBAUTL9(IBN,IBBFOB,IBRSN)
 . . . Q
 . . Q
 . Q
 ; If there wasn't an existing Inpatient Copay charge for the date, continue here.
 ; It is legal to have both an Inpatient Copay charge and an Inpatient Per diem on the same day
 ; for the combinations checked below. Determine if the Patient has an Per Diem Copay for the Event Date
 S IBBPD=$$BFPD^IBAUTL8A(IBDFN,IBEVDT,IBN)
 ; If there was a Per Diem charge for this day check for legal pairings
 I IBBPD D  Q:IBACTION
 . ; Set IBACTION = IEN of existing Per Diem Copay 
 . S IBACTION=IBBPD
 . ; Load Action Type of the Per Diem charge
 . S IBAT2=$P($G(^IB(IBBPD,0)),U,3)
 . ; If 2 copays for a single day are a legal pairing, set IBACTION =0
 . ; If the Action Type is CC INPATIENT (133) and the Per Diem is NOT CC PER DIEM (#130)
 . I IBAT1=130,IBAT2=133 S IBACTION=0
 . ; If the Action Type is one of the copays in Billing Group #2 and the Per Diem
 . ; copay is not INPATIENT PER DIEM (#45) set IBACTION
 . I "^16^17^18^19^20^21^22^23^"[("^"_IBAT1_"^"),IBAT2=45 S IBACTION=0
 . ; If the Action Type is NHCU COPAY (#24) and the Per Diem is NOT NHCU PER DIEM (#48)
 . I IBAT1=24,IBAT2=48 S IBACTION=0
 . ; If an incorrect pairing was found, cancel charge
 . I IBACTION D  Q
 . . ; Quit if interactive
 . . Q:IBINTACT
 . . ; ### Uncomment for Phase 2
 . . ; IBND has to be set to 0 node for call to CANC^IBECEAU4
 . . ; ### N IBND S IBND=$G(^IB(IBN,0))
 . . ; IBFAC and IBSITE needed by Cancel operation below
 . . ; ### N IBFAC,IBSITE
 . . ; Calculate site from site parameters
 . . ; ### D SITE^IBAUTL
 . . ; Cancel existing Outpatient Observation Copay charge
 . . ; UNCOMMENT THIS AND TEST MORE ON WHAT HAPPENS IN THE CANCELLATION PROCESS
 . . ; ### I 'IBINTACT D CANC^IBECEAU4(IBBFI,42,1)
 . . ; Record related info into ^XTMP for MailMan message
 . . S IBRSN="AN INCORRECT INPATIENT COPAY & INPATIENT PER DIEM PAIRING"
 . . D STORE2^IBAUTL9(IBN,IBBPD,IBRSN)
 . . Q
 . Q
 ;
 ; Determine if the Patient has an Outpatient Copay for the Event Date
 S IBBFO=$$BFO^IBAUTL8A(IBDFN,IBEVDT,IBN)
 ; If the Patient has been charged an Outpatient Copay for the Event Date, set IBACTION and quit
 I IBBFO D  Q
 . ; Set IBACTION = IEN of Outpatient Copay
 . S IBACTION=IBBFO
 . ; Quit if interactive
 . Q:IBINTACT
 . ; Record related info into ^XTMP for MailMan message
 . S IBRSN="AN INPATIENT COPAY CHARGE BILLED AT HIGHER PRECEDENCE"
 . D STORE2^IBAUTL9(IBN,IBBFO,IBRSN)
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
 . S IBRSN="AN INPATIENT COPAY CHARGE BILLED AT HIGHER PRECEDENCE"
 . D STORE2^IBAUTL9(IBN,IBLTC,IBRSN)
 Q
 ;
BFI(DFN,IBDATE,IBNEW) ; Patient Billed For Inpatient Copay on a specified date?
 ; Input:    DFN - Pointer to the patient in file #2
 ;        IBDATE - Date of the Inpatient Visit
 ;         IBNEW - IEN of new charge in File #350
 ; Output:     0 - Not billed the OPT copay on the visit date
 ;            >0 - Pointer to charge in file #350 that was billed
 ;
 ; Inpatient Copays charges will have one of the following Billing Group & Action Types:
 ; Billing Group = INPT/NHCU FEE SERVICE (#1)
 ; 130 - CC (INPT) NEW
 ; Billing Group = INPT/NHCU COPAY (#2)
 ;  16 - DG INPT COPAY (SUR) NEW   17 - DG INPT COPAY (SPI) NEW
 ;  18 - DG INPT COPAY (PSY) NEW   19 - DG INPT COPAY (INT) NEW
 ;  20 - DG INPT COPAY (REH) NEW   21 - DG INPT COPAY (BLI) NEW
 ;  22 - DG INPT COPAY (NEU) NEW   23 - DG INPT COPAY (ALC) NEW
 ;  24 - DG NHCU COPAY NEW
 ;
 N IBAMT,IBATYP,IBATYPN,IBCHK,IBCHRG,IBDATA0,IBN,IBSTOPDT
 S (IBATYP,IBATYPN)="",IBAMT=0
 ; Initialize the return variable to 0 - Not billed the Inpatient copay on the visit date
 S IBCHRG=0
 I '$G(DFN)!('$G(IBDATE)) Q +$G(IBCHRG)
 ; Set stop date for loop
 S IBSTOPDT=$P(IBDATE,".",1)
 ; Strip off time portion of DATA and reset IBDATE for looping by subtracting .000001
 S IBDATE=$P(IBDATE,".",1)-.000001
 ; Loop through Date/Time entries (earliest to latest) for the single date being checked
 F  S IBDATE=$O(^IB("ACHDT",DFN,IBDATE)) Q:'IBDATE!($P(IBDATE,".",1)>IBSTOPDT)  D
 . ; Loop through the individual charges
 . S IBN=0
 . F  S IBN=$O(^IB("ACHDT",DFN,IBDATE,IBN)) Q:'IBN  D
 . . ; Quit if entry found in ACHDT is the entry we are currently processing
 . . Q:IBN=IBNEW
 . . ; Initialize legal pair checking
 . . S IBCHK=0
 . . ; Load 0 node in File #350 for this record
 . . S IBDATA0=$G(^IB(IBN,0))
 . . ; Quit if ACTION TYPE is not an Inpatient Copay
 . . Q:"^16^17^18^19^20^21^22^23^24^130^"'[("^"_$P(IBDATA0,U,3)_"^")
 . . ; using the ACTION TYPE (#.03) field of the INTEGRATED BILLING ACTION file (#350) set IBATYP = 0 Node of the IB ACTION TYPE file (#350.1)
 . . S IBATYP=$G(^IBE(350.1,+$P(IBDATA0,"^",3),0))
 . . ; Using IBATYP set IBATYPN = NEW ACTION TYPE (#.09)
 . . S IBATYPN=$G(^IBE(350.1,+$P(IBATYP,"^",9),0))
 . . ; Quit if any of the key data for the checks is missing
 . . I IBDATA0=""!(IBATYP="")!(IBATYPN="") Q
 . . ; Check if the BILLING GROUP field (#.11) and the ACTION TYPE (#.03) matches to the
 . . ; specific combinations provided by the SMEs.
 . . ; Check for Billing Group = 1:INPT/NHCU FEE SERVICE & charge type = CC (INPT) NEW (130)
 . . I $P(IBATYPN,"^",11)=1,($P(IBDATA0,U,3)=130) S IBCHK=1
 . . ; Check for Billing Group = 2:INPT/NHCU COPAY & charge type = INPT COPAY (16^17^18^19^20^21^22^23^24)
 . . I $P(IBATYPN,"^",11)=2,("^16^17^18^19^20^21^22^23^24^"[("^"_$P(IBDATA0,U,3)_"^")) S IBCHK=1
 . . I IBCHK D
 . . . ; IF 1:NEW or 3:UPDATE is contained in the SEQUENCE NUMBER field (#.05) in the IB ACTION TYPE file (#350.1)
 . . . ; AND the STATUS field (#.05) in the INTEGRATED BILLING ACTION file (#350) is one of the following:
 . . . ;    1:INCOMPLETE, 2:COMPLETE, 3:BILLED, 4:UPDATED, 8:ON HOLD, 20:HOLD - RATE 
 . . . ; THEN set Y = IEN of the Duplicate Inpatient Copy
 . . . I "^1^3^"[("^"_$P(IBATYP,"^",5)_"^"),"^1^2^3^4^8^20^"[("^"_+$P(IBDATA0,"^",5)_"^") D
 . . . . ; Compare the TOTAL CHARGE of this Inpatient Copay charge to any previously identified
 . . . . ; Inpatient Copay for the same date and save the IEN of the highest charge
 . . . . I +$P(IBDATA0,U,7)>IBAMT S IBAMT=+$P(IBDATA0,U,7),IBCHRG=IBN
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q +$G(IBCHRG)
