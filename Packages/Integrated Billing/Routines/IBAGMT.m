IBAGMT ;WOIFO/AAT-GEOGRAPHIC MEANS TEST UTILITIES ;7-JUN-02
 ;;2.0;INTEGRATED BILLING;**179,183,202**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
 ;GMT Effective Date
 ;~~~~~~~~~~~~~~~~~~
GMTEFD() Q 3021001
 ;
 ;
 ;Is this a GMT Action Type?
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~
 ;Input: IBATYP - IEN of Action Type file (#350.1)
 ;Output: 1- yes, 0-no
ISGMTTYP(IBATYP) N IBBG ; Billing group
 S IBBG=+$P($G(^IBE(350.1,+$G(IBATYP),0)),"^",11)
 ;All Inpatient Means Test Billing Groups:
 ;IBBG=1: INPT/NHCU FEE SERVICE
 ;IBBG=2: INPT/NHCU COPAY
 ;IBBG=3: INPT/NHCU PER DIEM
 Q (IBBG>0)&(IBBG<4) ; Return 'true' for MT Inpatient types
 ;
 ;
 ;Does the patient have GMT Copayment Status?
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ;Input: DFN - IEN of the Patient
 ;       IBDT - date of status
 ;Output: Boolean value (1- yes, 0-no)
ISGMTPT(DFN,IBDT) N IBGMT ;
 S DFN=+DFN
 I '$G(IBDT) S IBDT=DT
 I IBDT<$$GMTEFD() Q 0  ;Prior to the GMT effective date
 I $T(GMT^DGMTUB)="" Q 0
 S IBGMT=$$GMT^DGMTUB(DFN,IBDT)
 Q $S(IBGMT<0:0,1:IBGMT)
 ;
 ; Is the bill GMT-related? (That means 'True' if at least one charge is GMT-related).
 ; ~~~~~~~~~~~~~~~~~~~~~~~~
 ; Input: IBNAM - the Bill's Name (not IEN !)
 ; Output: 1 - Yes, 0 - No
ISGMTBIL(IBNAM) N IBACT,IBRES
 S IBRES=0 ;Default Result
 I IBNAM'="" S IBACT=0 F  S IBACT=$O(^IB("ABIL",IBNAM,IBACT)) Q:'IBACT  D  Q:IBRES
 . I $P($G(^IB(IBACT,0)),"^",21) S IBRES=1
 Q IBRES
 ;
HOLD(X) ;The function is disabled
 Q 0 ; Stub function
 ;
 ; The rule to convert MT Charge to GMT rate (20%, rounded).
 ; Input: MT Charge
 ; Output: GMT Charge
REDUCE(IBCRG) Q +$J(IBCRG*.2,"",2)
 ;
 ;
 ; The API Call, used by Enrollment during the GMT Comversion, disabled.
RELHOLD(DFN,IBFORCE) N IBACT,IBDT,X,IBODT,IBGMTEFD,IBLIMIT,IBCNT
 Q "-1^The function is disabled"
