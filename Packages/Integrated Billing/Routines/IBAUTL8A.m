IBAUTL8A ;ALB/MGD - DUPLICATE COPAY TRANSACTION UTILITIES CONT.; Sep 30, 2020@15:16:44
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
IPDNEW(IBN,IBEVDT,IBACTION,IBINTACT) ;
 ; Perform checks for a new Inpatient Per Diem charge to determine if this charge should be passed over to AR.
 ;   Input:     IBN = Pointer to Inpatient Per Diem charge currently being reviewed in the INTEGRATED BILLING ACTION (#350) file
 ;           IBEVDT = Event Date for the charge currently being reviewed in the INTEGRATED BILLING ACTION (#350) file
 ;         IBACTION = Passed by reference. Passed in as 0:Pass to AR
 ;         IBINTACT = Optional - Flag to indicate when the call is being made from an interactive option.
 ;                    1:Interactive        
 ;                    0:Non-Interactive
 ;                    For more info see COPAYCHK above
 ;
 ; Output: IBACTION = 0 if the current charge being reviewed should be passed over to AR
 ;                    # The IEN of the existing Copay charge for the Patient/Date of interest.
 ;                      The charge being reviewed should NOT be passed over to AR.
 ;
 ; Verify incoming value of IBACTION and default to 0 if not defined
 S IBACTION=$S(IBACTION'="":IBACTION,1:0)
 ; Quit if necessary data was not passed in
 I +IBN<=0!(+IBEVDT'?7N) Q IBACTION
 ; If IBINTACT was not passed in, default it to 0:Non-Interactive
 S IBINTACT=$S(IBINTACT'="":IBINTACT,1:0)
 N IBBFI,IBBFO,IBBFOB,IBLTC,IBBPD,IBDFN,IBRSN,IBCTOT,IBETOT,IBAT1,IBAT2
 ; Load Patient IEN from IBN passed in
 S IBDFN=+$P($G(^IB(IBN,0)),U,2)
 ; Quit if no IEN in record
 I IBDFN<1 Q IBACTION
 ; Determine if the Patient has already been charged an Inpatient Copay for the Event Date
 S IBBFI=$$BFI^IBAUTL8C(IBDFN,IBEVDT,IBN)
 ; Take actions based on there being an existing Inpatient Copay
 I IBBFI D  Q:IBACTION
 . ; Set IBACTION = IEN of existing Inpatient Copay 
 . S IBACTION=IBBFI
 . ; Check for legal pairings
 . ; Load Action Types of the two charges
 . S IBAT1=$P($G(^IB(IBN,0)),U,3),IBAT2=$P($G(^IB(IBBFI,0)),U,3)
 . ; If 2 copays for a single day are a legal pairing, set IBACTION =0
 . ; If the Action Type is CC INPATIENT (133) and the Per Diem is CC PER DIEM (#130)
 . I IBAT1=133,IBAT2=130 S IBACTION=0
 . ; If the Action Type is one of the copays in Billing Group #2 and the Per Diem
 . ; copay is INPATIENT PER DIEM (#45) set IBACTION =0
 . I IBAT1=45,("^16^17^18^19^20^21^22^23^"[("^"_IBAT2_"^")) S IBACTION=0
 . ; If the Action Type is NHCU COPAY (#24) and the Per Diem is  NHCU PER DIEM (#48) set IBACTION =0
 . I IBAT1=48,IBAT2=24 S IBACTION=0
 . ; Quit if interactive
 . Q:IBINTACT
 . ; Record related info into ^XTMP for MailMan message
 . S IBRSN="AN INPATIENT COPAY CHARGE BILLED AT HIGHER PRECEDENCE"
 . D STORE1^IBAUTL9(IBN,IBBFI,IBRSN)
 ;
 ; Determine if the Patient has already been charged an Inpatient Per Diem charge for the Event Date
 S IBBPD=$$BFPD^IBAUTL8A(IBDFN,IBEVDT,IBN)
 ; If the Patient has already been charged an Inpatient Per Diem charge for the Event Date
 I IBBPD D  Q
 . ; Set return value to NOT pass the charge over to AR
 . S IBACTION=IBBPD
 . ; Quit if interactive
 . Q:IBINTACT
 . ; Load dollar amounts from the 2 charges
 . S IBCTOT=+$P($G(^IB(IBN,0)),U,7),IBETOT=+$P($G(^IB(+IBBPD,0)),U,7)
 . ; If the current charge being processed is <= to the existing Inpatient Per Diem charge
 . I IBCTOT<=IBETOT D  Q
 . . ; Cancel current charge with CANCELLATION REASON = 4 - ENTERED IN ERROR
 . . ; ### Uncomment for Phase 2 D CNCLCHRG^IBAUTL8A(IBN,4)
 . . ; Record related info into ^XTMP for MailMan message
 . . S IBRSN="EXISTING INPATIENT PER DIEM CHARGE AT SAME OR HIGHER TIER RATE"
 . . D STORE1^IBAUTL9(IBN,IBBPD,IBRSN)
 . . Q
 . ; If the current charge being processed is > than the existing Inpatient Per Diem charge
 . I IBCTOT>IBETOT D  Q
 . . ; IBND has to be set to 0 node for call to CANC^IBECEAU4
 . . ; ### N IBND S IBND=$G(^IB(IBN,0))
 . . ; IBFAC and IBSITE needed by Cancel operation below
 . . ; ### N IBFAC,IBSITE
 . . ; Calculate site from site parameters
 . . ; ### D SITE^IBAUTL
 . . ; Cancel existing charge with Reason = 42 - BILLED AT HIGHER TIER RATE
 . . ; UNCOMMENT THIS AND TEST MORE ON WHAT HAPPENS IN THE CANCELLATION PROCESS
 . . ; ### I 'IBINTACT D CANC^IBECEAU4(IBBPD,42,1)
 . . ; Record related info into ^XTMP for MailMan message
 . . S IBRSN="ANOTHER INPATIENT PER DIEM CHARGE BILLED AT HIGHER TIER RATE"
 . . D STORE2^IBAUTL9(IBN,IBBPD,IBRSN)
 . . Q
 . Q
 ;
 ; Determine if the Patient has an Outpatient Observation Copay for the Event Date
 S IBBFOB=$$BFOB^IBAUTL8A(IBDFN,IBEVDT,IBN)
 ; if there is an existing Outpatient Observation Copay, Do the following
 I +IBBFOB D  Q
 . ; Set IBACTION = IEN of Outpatient Observation Copay
 . S IBACTION=IBBFOB
 . ; Quit if interactive
 . Q:IBINTACT
 . ; ###Uncomment for Phase 2
 . ; IBND has to be set to 0 node for call to CANC^IBECEAU4
 . ; ### N IBND S IBND=$G(^IB(IBN,0))
 . ; IBFAC and IBSITE needed by Cancel operation below
 . ; ### N IBFAC,IBSITE
 . ; Calculate site from site parameters
 . ; ### D SITE^IBAUTL
 . ; Cancel the existing Outpatient Observation Copay charge with
 . ; CANCELLATION REASON = 42 - BILLED AT HIGHER TIER RATE
 . ; ### I 'IBINTACT D CANC^IBECEAU4(IBBFI,42,1)
 . ; Record related info into ^XTMP for MailMan message
 . S IBRSN="AN INPATIENT PER DIEM CHARGE BILLED AT HIGHER PRECEDENCE"
 . D STORE2^IBAUTL9(IBN,IBBFOB,IBRSN)
 . Q
 ;
 ; Determine if the Patient has an Outpatient Copay for the Event Date
 S IBBFO=$$BFO^IBAUTL8A(IBDFN,IBEVDT,IBN)
 ; If the Patient has already been charged an Outpatient Copay for the Event Date, set IBACTION and quit
 I IBBFO D  Q
 . ; Set IBACTION = IEN of Outpatient Copay
 . S IBACTION=IBBFO
 . ; Quit if interactive
 . Q:IBINTACT
 . ; ###Uncomment for Phase 2
 . ; IBND has to be set to 0 node for call to CANC^IBECEAU4
 . ; ### N IBND S IBND=$G(^IB(IBN,0))
 . ; IBFAC and IBSITE needed by Cancel operation below
 . ; ### N IBFAC,IBSITE
 . ; Calculate site from site parameters
 . ; ### D SITE^IBAUTL
 . ; Cancel the existing Outpatient Observation Copay charge with
 . ; CANCELLATION REASON = 42 - BILLED AT HIGHER TIER RATE
 . ; ### I 'IBINTACT D CANC^IBECEAU4(IBBFI,42,1)
 . ; Record related info into ^XTMP for MailMan message
 . S IBRSN="AN INPATIENT PER DIEM CHARGE BILLED AT HIGHER PRECEDENCE"
 . D STORE2^IBAUTL9(IBN,IBBFO,IBRSN)
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
 . ; ###Uncomment for Phase 2
 . ; IBND has to be set to 0 node for call to CANC^IBECEAU4
 . ; ### N IBND S IBND=$G(^IB(IBN,0))
 . ; IBFAC and IBSITE needed by Cancel operation below
 . ; ### N IBFAC,IBSITE
 . ; Calculate site from site parameters
 . ; ### D SITE^IBAUTL
 . ; Cancel the existing Outpatient Observation Copay charge with
 . ; CANCELLATION REASON = 42 - BILLED AT HIGHER TIER RATE
 . ; ### I 'IBINTACT D CANC^IBECEAU4(IBBFI,42,1)
 . ; Record related info into ^XTMP for MailMan message
 . S IBRSN="AN INPATIENT PER DIEM CHARGE BILLED AT HIGHER PRECEDENCE"
 . D STORE2^IBAUTL9(IBN,IBLTC,IBRSN)
 Q
 ;
BFO(DFN,IBDATE,IBNEW) ; Patient Billed For Outpatient Copay on a specified date?
 ; Input:    DFN - Pointer to the patient in file #2
 ;        IBDATE - Date of the Inpatient Visit
 ;         IBNEW - IEN of new charge in File #350
 ; Output:     0 - Not billed the OPT copay on the visit date
 ;            >0 - Pointer to charge in file #350 that was billed
 ;
 ; Outpatient Copays charges will be in Billing Group 4 and have Action Types:
 ; Action Types = 51 - DG OPT COPAY NEW         136 - CC (OPT) NEW
 ;               203 - CC URGENT CARE (OPT) NEW
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
 . . ; Quit if ACTION TYPE is not an Outpatient Copay
 . . Q:"^51^136^203^"'[("^"_$P(IBDATA0,U,3)_"^")
 . . ; using the ACTION TYPE (#.03) field of the INTEGRATED BILLING ACTION file (#350) set IBATYP = 0 Node of the IB ACTION TYPE file (#350.1)
 . . S IBATYP=$G(^IBE(350.1,+$P(IBDATA0,"^",3),0))
 . . ; Using IBATYP set IBATYPN = NEW ACTION TYPE (#.09)
 . . S IBATYPN=$G(^IBE(350.1,+$P(IBATYP,"^",9),0))
 . . ; Quit if any of the key data for the checks is missing
 . . I IBDATA0=""!(IBATYP="")!(IBATYPN="") Q
 . . ; Check if the BILLING GROUP field (#.11) and the ACTION TYPE (#.03) matches to the
 . . ; specific combinations provided by the SMEs.
 . . ; Check for Billing Group = 4:OPT COPAY & charge type = an OPT COPAY (51^136^203)
 . . I $P(IBATYPN,"^",11)=4,("^51^136^203^"[("^"_$P(IBDATA0,U,3)_"^")) D
 . . . ; IF 1:NEW or 3:UPDATE is contained in the SEQUENCE NUMBER field (#.05) in the IB ACTION TYPE file (#350.1)
 . . . ; AND the STATUS field (#.05) in the INTEGRATED BILLING ACTION file (#350) is one of the following:
 . . . ;    1:INCOMPLETE, 2:COMPLETE, 3:BILLED, 4:UPDATED, 8:ON HOLD, 20:HOLD - RATE 
 . . . ; THEN set IBCHRG = IEN of the duplicate Outpatient Copay
 . . . I "^1^3^"[("^"_$P(IBATYP,"^",5)_"^"),"^1^2^3^4^8^20^"[("^"_+$P(IBDATA0,"^",5)_"^") D
 . . . . ; Compare the TOTAL CHARGE of this Outpatient Copay charge to any previously identified
 . . . . ; Outpatient Copay for the same date and save the IEN of the highest charge
 . . . . I +$P(IBDATA0,U,7)>IBAMT S IBAMT=+$P(IBDATA0,U,7),IBCHRG=IBN
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q +$G(IBCHRG)
 ;
BFOB(DFN,IBDATE,IBNEW) ; Patient Billed For Outpatient Observation Copay on a specified date?
 ; Input:    DFN - Pointer to the patient in file #2
 ;        IBDATE - Date of the Outpatient Visit
 ;         IBNEW - IEN of new charge in File #350
 ; Output:     0 - Not billed the OPT copay on the visit date
 ;            >0 - Pointer to charge in file #350 that was billed
 ;
 ; Outpatient Observation Copays charges will have the following Billing Group & Action Types:
 ; Billing Group = 4 - OPT COPAY
 ;  74 - DG OBSERVATION COPAY NEW
 ;
 N IBAMT,IBATYP,IBATYPN,IBCHRG,IBDATA0,IBN,Y,IBSTOPDT
 S (IBATYP,IBATYPN)="",IBAMT=0
 ; Initialize the return variable to 0 - Not billed the Outpatient Observation Copay on the visit date
 S IBCHRG=0
 I '$G(DFN)!'$G(IBDATE) Q +$G(IBCHRG)
 ; Set stop date for loop
 S IBSTOPDT=$P(IBDATE,".",1)
 ; Strip off time portion of DATA and reset IBDATE for looping by subtracting .000001
 S IBDATE=$P(IBDATE,".",1)-.000001
 ; Loop through Date/Time entries (earliest to latest) for the single date being checked
 F  S IBDATE=$O(^IB("ACHDT",DFN,IBDATE)) Q:'IBDATE!($P(IBDATE,".",1)>IBSTOPDT)  D
 . ; Loop through the individual charges
 . S IBN=0
 . F  S IBN=$O(^IB("ACHDT",DFN,IBDATE,IBN)) Q:'IBN  D
 . . ; Quit it entry found in ACHDT is the entry we are currently processing
 . . Q:IBN=IBNEW
 . . ; Load 0 node in File #350 for this record
 . . S IBDATA0=$G(^IB(IBN,0))
 . . ; Quit if ACTION TYPE is not an Outpatient Observation Copay
 . . Q:$P(IBDATA0,U,3)'=74
 . . ; using the ACTION TYPE (#.03) field of the INTEGRATED BILLING ACTION file (#350) set IBATYP = 0 Node of the IB ACTION TYPE file (#350.1)
 . . S IBATYP=$G(^IBE(350.1,+$P(IBDATA0,"^",3),0))
 . . ; Using IBATYP set IBATYPN = NEW ACTION TYPE (#.09)
 . . S IBATYPN=$G(^IBE(350.1,+$P(IBATYP,"^",9),0))
 . . ; Quit if any of the key data for the checks is missing
 . . I IBDATA0=""!(IBATYP="")!(IBATYPN="") Q
 . . ; IF the BILLING GROUP field (#.11) in the IB ACTION TYPE file (#350.1) is OPT COPAY (#4)
 . . ; AND the SEQUENCE NUMBER (#.05) in the IB ACTION TYPE file (#350.1) is
 . . ;     1:INCOMPLETE OR 3:BILLED
 . . ; AND the STATUS field (#.05) in the INTEGRATED BILLING ACTION file (#350) is one of the following:
 . . ;     1:INCOMPLETE, 2:COMPLETE, 3:BILLED, 4:UPDATED, 8:ON HOLD, 20:HOLD - RATE 
 . . ; THEN set IBCHRG = IEN of the Outpatient Observation Copay
 . . I $P(IBATYPN,"^",11)=4,"^1^3^"[("^"_$P(IBATYP,"^",5)_"^"),"^1^2^3^4^8^20^"[("^"_+$P(IBDATA0,"^",5)_"^") D
 . . . ; Compare the TOTAL CHARGE of this Outpatient Observation Copay charge to any previously identified
 . . . ; Outpatient Observation Copay and save the IEN of the highest charge
 . . . I +$P(IBDATA0,U,7)>IBAMT S IBAMT=+$P(IBDATA0,U,7),IBCHRG=IBN
 . . Q
 . Q
 Q +$G(IBCHRG)
 ;
BFPD(DFN,IBDATE,IBNEW) ; Patient Billed For Per Diem Copay on a specified date?
 ; Input:    DFN - Pointer to the patient in file #2
 ;        IBDATE - Date of the Outpatient Visit
 ;         IBNEW - IEN of charge in File #350
 ; Output:     0 - Not billed the OPT copay on the visit date
 ;            >0 - Pointer to charge in file #350 that was billed
 ;
 ; Valid Per Diem charges have the following Billing Group & Action Types:
 ; Billing Group = 3 - INPT/NHCU PER DIEM
 ;   45 DG INPT PER DIEM NEW        48 DG NHCU PER DIEM NEW
 ;  133 CC (PER DIEM) NEW
 ;
 N IBAMT,IBATYP,IBATYPN,IBCHRG,IBDATA0,IBN,IBSTOPDT
 S (IBATYP,IBATYPN)="",IBAMT=0
 ; Initialize the IBCHRG to 0 - Not billed a Per Diem on the visit date
 S IBCHRG=0
 I '$G(DFN)!'$G(IBDATE) Q +$G(IBCHRG)
 ; Set stop date for loop
 S IBSTOPDT=$P(IBDATE,".",1)
 ; Strip off time portion of DATA and reset IBDATE for looping by subtracting .000001
 S IBDATE=$P(IBDATE,".",1)-.000001
 ; Loop through Date/Time entries (earliest to latest) for the single date being checked
 F  S IBDATE=$O(^IB("ACHDT",DFN,IBDATE)) Q:'IBDATE!($P(IBDATE,".",1)>IBSTOPDT)  D
 . ; Loop through the individual charges
 . S IBN=0
 . F  S IBN=$O(^IB("ACHDT",DFN,IBDATE,IBN)) Q:'IBN  D
 . . ; Quit it entry found in ACHDT is the entry we are currently processing
 . . Q:IBN=IBNEW
 . . ; Load 0 node in File #350 for this record
 . . S IBDATA0=$G(^IB(IBN,0))
 . . ; Quit if ACTION TYPE is not an Per Diem Copay
 . . Q:"^45^48^133^"'[("^"_$P(IBDATA0,U,3)_"^")
 . . ; using the ACTION TYPE (#.03) field of the INTEGRATED BILLING ACTION file (#350) set IBATYP = 0 Node of the IB ACTION TYPE file (#350.1)
 . . S IBATYP=$G(^IBE(350.1,+$P(IBDATA0,"^",3),0))
 . . ; Using IBATYP set IBATYPN = NEW ACTION TYPE (#.09)
 . . S IBATYPN=$G(^IBE(350.1,+$P(IBATYP,"^",9),0))
 . . ; Quit if any of the key data for the checks is missing
 . . I IBDATA0=""!(IBATYP="")!(IBATYPN="") Q 
 . . ; IF the BILLING GROUP field (#.11) in the IB ACTION TYPE file (#350.1) is INPT/NHCU PER DIEM (#3)
 . . ; AND the SEQUENCE NUMBER (#.05) in the IB ACTION TYPE file (#350.1) is
 . . ;     1:INCOMPLETE OR 3:BILLED
 . . ; AND the STATUS field (#.05) in the INTEGRATED BILLING ACTION file (#350) is one of the following:
 . . ;     1:INCOMPLETE, 2:COMPLETE, 3:BILLED, 4:UPDATED, 8:ON HOLD, 20:HOLD - RATE 
 . . ; THEN set IBCHRG = IEN of the Per Diem copay
 . . I $P(IBATYPN,"^",11)=3,"^1^3^"[("^"_$P(IBATYP,"^",5)_"^"),"^1^2^3^4^8^20^"[("^"_+$P(IBDATA0,"^",5)_"^") D
 . . . ; Compare the TOTAL CHARGE of this Per Diem Copay charge to any previously identified
 . . . ; Per Diem Copay and save the IEN of the highest charge
 . . . I +$P(IBDATA0,U,7)>IBAMT S IBAMT=+$P(IBDATA0,U,7),IBCHRG=IBN
 . . Q
 . Q
 Q +$G(IBCHRG)
 ;
CNCLCHRG(IBN,IBCANRSN) ; Cancel a charge that will never be passed over to AR
 ; OR an existing charge in AR which is being replaced by a new charge at a higher Tier Rate.
 ;   Input:      IBN = IEN of record in the INTEGRATED BILLING ACTION (#350) file to edit
 ;          IBCANRSN = the value to set into the CANCELLATION REASON (#.1) field in internal format
 ;  Output: None
 ;
 ; The patch will initially be released as a info gathering patch so the set logic is currently
 ; commented out.
 Q  ; ### remove to activate #630 functionality
 N IBFDA
 ; Quit if no valid IBN
 Q:+IBN<=0
 ; If the CANCELLATION REASON was not passed in, set it to 4 - ENTERED IN ERROR
 S IBCANRSN=$S(IBCANRSN'="":IBCANRSN,1:4)
 ; Set STATUS (#.05) to Cancelled (IEN=10)
 S IBFDA(350,IBN,.05)=10
 ; Set CANCELLATION REASON (#.1) to value passed in
 S IBFDA(350,IBN,.1)=IBCANRSN
 ; Cancel charge currently being reviewed
 D FILE^DIE(,"IBFDA")
 Q
