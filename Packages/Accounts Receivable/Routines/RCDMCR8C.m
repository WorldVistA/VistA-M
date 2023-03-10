RCDMCR8C ;ALB/LB - Pension Report Exempt Charge Reconciliation Report - Input/output; Jun 16, 2021@14:23
 ;;4.5;Accounts Receivable;**384**;JUN 16, 2021;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to PATIENT in ICR #7277
 ; Reference to INTEGRATED BILLING ACTION in ICR #4541
 ; Reference to IB ACTION TYPE in ICR #4538
 ; See RCDMCR8A for detailed description
 ;
GETSTRT(IBIEN) ; Get start date for InPatient / LTC
 N IBSDT,RESULT S IBSDT="",RESULT=""
 S RESULT=$P(^IB(IBIEN,0),U,4)
 I +RESULT=405!(+RESULT=45) S IBSDT=$$GET1^DIQ(350,IBIEN_",",.14,"I")
 Q IBSDT
 ;
GETIB(IBIEN,IBMODE) ; Get all Outpatient Dates, Inpatient Dates and RX Dates/drugs
 ; Input:
 ;  IBIEN - IEN of IB entry (File 350, ^IB)
 ;  IBMODE - 0 if we are in AR mode, 1 if we are in IB mode.
 ; Output:
 ;  0 if we don't get anything out of this IB
 ;  Othewise 1 ^ Outpatient Date ^ Discharge Date ^ RX/Refill Date ^ IB Status ^ RX NUM ^ RX Name ^ CHGAMT
 N IBDET,IENS,ACTTYPE,RESULT,DTBILLFR,BILGROUP,OPDT,DISCHARG,RXDT,STATUS,OUT,I0,PARENT,PARENTOK,DFN
 N CHGAMT,RXNAM,RXNUM,VAERR,VAIP
 S OUT=0
 S I0=$G(^IB(IBIEN,0))
 S DFN=$P(I0,U,2)
 I 'DFN Q OUT
 S ACTTYPE=$P(I0,U,3)
 S DTBILLFR=$P(I0,U,14)
 S STATUS=$P(I0,U,5)
 S PARENT=$$PARENTC^RCDMCR5B(IBIEN),CHGAMT=$P($G(^IB(PARENT,0)),U,7)
 ;S CHGAMT=$$GET1^DIQ(350,$$PARENTC^RCDMCR5B(IBIEN)_",",.07,"I")
 ; only take parents if running in AR mode?
 S PARENT=$$PARENTE^RCDMCR5B(IBIEN)
 I '$$GET1^DIQ(350,PARENT_",",.11,"I") S PARENT=IBIEN
 I +$G(IBMODE)=0 S PARENTOK=0 D  I 'PARENTOK Q OUT
 . I IBIEN=PARENT S PARENTOK=1 Q
 . I $P(I0,U,11),$P(I0,U,11)'=$$GET1^DIQ(350,PARENT_",",.11,"I") S PARENTOK=1 ; it is OK to take a child IB if parent is not part of same bill.
 S RESULT=$P(^IB(PARENT,0),U,4)
 ;Quit if RESULTING FROM field is blank
 Q:RESULT="" OUT
 ;Get Billing Group in the IB Action Type File. If internal Set 
 ;Code value is 4, then this is an Outpatient Visit (From STMT^IBRFN1)
 ;and can use Date Billed From for the Outpatient Visit Date
 S BILGROUP=$P($G(^IBE(350.1,+ACTTYPE,0)),U,11)
 I BILGROUP>6 Q OUT
 ;Outpatient Event
 I BILGROUP=4!($P(RESULT,":",1)=44)!($P(RESULT,":",1)=409.68) D
 . I $P(RESULT,":",1)=44 S OPDT=$P($P(RESULT,";",2),":",2)
 . I $P(RESULT,":",1)=409.68 S OPDT=$P($G(^SCE(+$P(RESULT,":",2),0)),U)
 . I $G(OPDT)'>0 S OPDT=DTBILLFR
 . I OPDT S OUT=1_U_OPDT
 ;Inpatient Event
 I $P(RESULT,":",1)=405!($P(RESULT,":",1)=45) D
 . D KVAR^VADPT
 . S VAIP("E")=$P($P(RESULT,";",1),":",2)
 . ;Call to get Inpatient data
 . D IN5^VADPT
 . I VAERR>0 D KVAR^VADPT Q
 . S DISCHARG=$P($G(VAIP(17,1)),U,1)
 . I DISCHARG S OUT=1_U_U_DISCHARG
 . D KVAR^VADPT
 ;RX Event
 I $P(RESULT,":",1)=52 D
 . ;Set up for RX Refills
 . I $P(RESULT,";",2)]"" D
 . . N RXIEN,RXFIEN
 . . S RXFIEN=$P($P(RESULT,";",2),":",2),RXIEN=$P($P(RESULT,";",1),":",2)
 . . S RXDT=$P($G(^PSRX(RXIEN,1,RXFIEN,0)),U,18) ; released data
 . . S:RXDT="" RXDT=$P($G(^PSRX(RXIEN,1,RXFIEN,0)),U) ; refill date
 . . S RXNUM=$P($G(^PSRX(RXIEN,0)),U)
 . . S RXNAM=$P($G(^PSRX(RXIEN,0)),U,6) S:RXNAM RXNAM=$P($G(^PSDRUG(RXNAM,0)),U)
 . . I RXDT S OUT=1_U_U_U_RXDT_U_U_RXNUM_U_RXNAM
 . ;Set up for RX Data (No refill)
 . I $P(RESULT,";",2)']"" D
 . . N RXIEN
 . . S RXIEN=$P(RESULT,":",2)
 . . S RXDT=$P($G(^PSRX(RXIEN,2)),U,13) ; released date
 . . S:RXDT="" RXDT=$P($G(^PSRX(RXIEN,2)),U,2) ; fill date
 . . S:RXDT="" RXDT=$P($G(^PSRX(RXIEN,2)),U,5) ; dispensed date
 . . S RXNUM=$P($G(^PSRX(RXIEN,0)),U)
 . . S RXNAM=$P($G(^PSRX(RXIEN,0)),U,6) S:RXNAM RXNAM=$P($G(^PSDRUG(RXNAM,0)),U)
 . . I RXDT S OUT=1_U_U_U_RXDT_U_U_RXNUM_U_RXNAM
 S OPDT=$P(I0,U,14) I 'OUT,RESULT'="",OPDT'="" S OUT=1_U_OPDT
 I 'OUT Q OUT
 S $P(OUT,U,5)=STATUS
 S $P(OUT,U,8)=CHGAMT
 Q OUT
