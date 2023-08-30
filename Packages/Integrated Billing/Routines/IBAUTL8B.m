IBAUTL8B ;ALB/MGD - DUPLICATE COPAY TRANSACTION UTILITIES CONT.; Sep 30, 2020@15:16:44
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
LTCNEW(IBN,IBEVDT,IBACTION,IBINTACT) ;
 ; Perform checks for a new Long Term Care Copay charge to determine if this charge should be passed over to AR.
 ;   Input:     
 ;          IBN = Pointer to Long Term Care Copay charge currently being reviewed in the INTEGRATED BILLING ACTION (#350) file
 ;       IBEVDT = Event Date for the charge currently being reviewed in the INTEGRATED BILLING ACTION (#350) file
 ;     IBACTION = Passed by reference. Passed in as 0:Pass to AR
 ;     IBINTACT = Optional - Flag to indicate when the call is being made from an interactive option.
 ;                1:Interactive        
 ;                0:Non-Interactive
 ;                For more info see COPAYCHK^IBAUTL8
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
 N IBBFI,IBBFO,IBDFN,IBIEN,IBBOB,IBBPD,IBLTC,IBRSN
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
 . ; Record related info into ^XTMP for MailMan message 
 . S IBRSN="EXISTING OUTPATIENT COPAY CHARGE WHICH HAS HIGHER PRECEDENCE"
 . D STORE1^IBAUTL9(IBN,IBBFO,IBRSN)
 ;
 ; Determine if the Patient has an Long Term Care Copay for the Event Date
 S IBLTC=$$LTC^IBAUTL8B(IBDFN,IBEVDT,IBN)
 ; If the patient has been charged a Long Term Care Copay for the Event Date, set IBACTION and quit
 I IBLTC D  Q
 . ; Set IBACTION = IEN of Outpatient Copay
 . S IBACTION=IBLTC
 . ; Quit if interactive
 . Q:IBINTACT
 . N IBCTOT,IBETOT
 . ; Load dollar amounts from the 2 charges. IBCTOT = Current Charge Being Reviewed Total, IBETOT = Existing Total
 . S IBCTOT=+$P($G(^IB(IBN,0)),U,7),IBETOT=+$P($G(^IB(+IBLTC,0)),U,7)
 . ; If the current charge being processed is <= to the existing LTC Copay charge
 . I IBCTOT<=IBETOT D  Q
 . . ; Cancel current charge being reviewed with CANCELLATION REASON = 4 - ENTERED IN ERROR
 . . ; ### Uncomment for Phase 2 D CNCLCHRG^IBAUTL8A(IBN,4)
 . . ; Record related info into ^XTMP for MailMan message
 . . S IBRSN="EXISTING LTC COPAY CHARGE AT SAME OR HIGHER TIER RATE"
 . . D STORE1^IBAUTL9(IBN,IBLTC,IBRSN)
 . ; If the current charge being processed is > than the existing LTC Copay charge
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
 . . S IBRSN="ANOTHER LTC COPAY CHARGE BILLED AT HIGHER TIER RATE"
 . . D STORE2^IBAUTL9(IBN,IBLTC,IBRSN)
 . . Q
 . Q
 Q
 ;
LTC(DFN,IBDATE,IBNEW) ; Patient Billed For Long Term Care Copay on a specified date?
 ; Input:    DFN - Pointer to the patient in file #2
 ;        IBDATE - Date of the Inpatient Visit
 ;         IBNEW - IEN of new charge in File #350
 ; Output:     0 - Not billed the LTC copay on the visit date
 ;            >0 - Pointer to charge in file #350 that was billed
 ;
 ; Long Term Care Copays charges will be in Billing Group 8 and have Action Types:
 ; Action Types =  89 - DG LTC OPT ADHC NEW          92 - DG LTC OPT GEM NEW
 ;                 95 - DG LTC OPT RESPITE NEW      105 - DG LTC FEE OPT ADHC NEW
 ;                108 - DG LTC FEE OPT RESPITE NEW
 ;
 N IBAMT,IBATYP,IBATYPN,IBCHRG,IBDATA0,IBN,IBSTOPDT
 S (IBATYP,IBATYPN)="",IBAMT=0
 ; Initialize the return variable to 0 - Not billed the Outpatient copay on the visit date
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
 . . ; Load 0 node in File #350 for this record
 . . S IBDATA0=$G(^IB(IBN,0))
 . . ; Quit if ACTION TYPE is not a Long Term Care Copay
 . . Q:"^89^92^95^105^108^"'[("^"_$P(IBDATA0,U,3)_"^")
 . . ; using the ACTION TYPE (#.03) field of the INTEGRATED BILLING ACTION file (#350) set IBATYP = 0 Node of the IB ACTION TYPE file (#350.1)
 . . S IBATYP=$G(^IBE(350.1,+$P(IBDATA0,"^",3),0))
 . . ; Using IBATYP set IBATYPN = NEW ACTION TYPE (#.09)
 . . S IBATYPN=$G(^IBE(350.1,+$P(IBATYP,"^",9),0))
 . . ; Quit if any of the key data for the checks is missing
 . . I IBDATA0=""!(IBATYP="")!(IBATYPN="") Q
 . . ; Check if the BILLING GROUP field (#.11) and the ACTION TYPE (#.03) matches to the
 . . ; specific combinations provided by the SMEs.
 . . ; Check for Billing Group = 8:LTC OPT & charge type = a LTC Copay (89^92^95^105^108)
 . . I $P(IBATYPN,"^",11)=8,("^89^92^95^105^108^"[("^"_$P(IBDATA0,U,3)_"^")) D
 . . . ; IF 1:NEW or 3:UPDATE is contained in the SEQUENCE NUMBER field (#.05) in the IB ACTION TYPE file (#350.1)
 . . . ; AND the STATUS field (#.05) in the INTEGRATED BILLING ACTION file (#350) is one of the following:
 . . . ;    1:INCOMPLETE, 2:COMPLETE, 3:BILLED, 4:UPDATED, 8:ON HOLD, 20:HOLD - RATE 
 . . . ; THEN set IBCHRG = IEN of the duplicate Outpatient Copay
 . . . I "^1^3^"[("^"_$P(IBATYP,"^",5)_"^"),"^1^2^3^4^8^20^"[("^"_+$P(IBDATA0,"^",5)_"^") D
 . . . . ; Compare the TOTAL CHARGE of this LTC Copay charge to any previously identified
 . . . . ; LTC Copay for the same date and save the IEN of the highest charge
 . . . . I +$P(IBDATA0,U,7)>IBAMT S IBAMT=+$P(IBDATA0,U,7),IBCHRG=IBN
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q +$G(IBCHRG)
