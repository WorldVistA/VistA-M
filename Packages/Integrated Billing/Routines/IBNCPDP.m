IBNCPDP ;OAK/ELZ - APIS FOR NCPCP/ECME ;1/9/08  17:27
 ;;2.0;INTEGRATED BILLING;**223,276,363,383,384,411,435,452,550**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Reference to $$PSSBILSD^PSS50 supported by IA# 6245
 ;
RX(DFN,IBD) ; IB Billing Determination
 ; this is called by PSO for all prescriptions issued, return is
 ; a response to bill ECME or not with array for billing data elements
 ; third piece of return is an Eligibility indicator for the prescription
 ;
 ; IBD("IEN")         = Prescription IEN
 ;    ("FILL NUMBER") = Fill number (0 is initial)
 ;    ("DOS")         = Date of Service
 ;    ("RELEASE DATE")= Date of the Rx release in FileMan format
 ;    ("NDC")         = NDC number for drug
 ;    ("DEA")         = DEA special handling info
 ;    ("COST")        = cost of medication being dispensed
 ;    ("AO")          = Agent Orange (0,1 OR Null)
 ;    ("EC")          = Environmental Contaminant (0,1 OR Null)
 ;    ("HNC")         = Head/neck cancer (0,1 OR Null)
 ;    ("IR")          = Ionizing radiation (0,1 OR Null)
 ;    ("MST")         = Military sexual trauma (0,1 OR Null)
 ;    ("SC")          = Service connected (0,1 OR Null)
 ;    ("CV")          = Combat Veteran (0,1 OR Null)
 ;    ("QTY")         = Quantity of med dispensed
 ;    ("EPHARM")      = #9002313.56 ien (E-PHARMACY division)
 ;
 ;
 ; IBD("INS",n,1) = insurance array to bill in n order (see SETINSUR^IBNCPDP1 for details)
 ;                  file 355.3 ien (group)^bin^pcn^Payer Sheet B1^group id^
 ;                  cardholder id^patient relationship code^
 ;                  cardholder first name^cardholder last name^
 ;                  home plan state^Payer Sheet B2^Payer Sheet B3^
 ;                  Software/Vendor Cert ID ^ Ins Name^Payer Sheet E1^
 ;                  Payer Sheet B1 ien^B2 ien^B3 ien^E1 ien^Pharmacy Person Code
 ;                  
 ;
 ;    ("INS",n,2) = dispensing fee^basis of cost determination^
 ;                  awp or tort rate or cost^gross amount due^
 ;                  administrative fee^ingredient cost^usual & customary charge
 ;                  (see RATEPRIC^IBNCPDP1 for details)
 ;
 ;   for basis of cost determination the following is used:
 ;      "07" would be sent for Usual & Customary
 ;      "01" would be sent for AWP
 ;      "05" would be sent for Cost calculations
 ;
 ;    ("INS",n,3) = group name^ins co ph 3^plan ID^
 ;                  insurance type (V=VETERAN, T=TRICARE, C=CHAMPVA)^
 ;                  insurance company (#36) ien^COB field (.2) in 2.312 subfile^
 ;                  2.312 subfile ien (pt. insurance policy ien)^
 ;                  maximum NCPDP transactions (366.03,10.1)
 ;                  (see SETINSUR^IBNCPDP1 for details)
 ;
 N IBRES,IBNB
 S IBRES=$$RX^IBNCPDP1(DFN,.IBD)
 ;remove "Not ECME billable: " from the reason text
 S IBNB="Not ECME billable: "
 I IBRES[IBNB S IBRES=$P(IBRES,U)_U_$P($P(IBRES,U,2),IBNB,2)_U_$P(IBRES,U,3)
 Q IBRES
 ;
 ;
STORESP(DFN,IBD) ; this is an API for pharmacy/ecme to use to relay
 ; results of billing using the ecme software.  If electronic billing is
 ; successful, then bills will be established.  If not, then we will
 ; flag the entry in ct for paper or not billable.
 ;
 ; IBD("STATUS")       = Bill status (PAID, REJECTED,REVERSED
 ;                        CLOSED,RELEASED,or SUBMITTED)
 ;    ("DOS")          = Date of Service
 ;    ("PRESCRIPTION") = Prescription IEN from drug file (#52)
 ;    ("FILL NUMBER")  = Fill or refill number
 ;    ("BILLED")       = Amount billed
 ;    ("PAID")         = Amount paid
 ;    ("BCID")         = Reference number to the claim for payment
 ;                       BCID stands for Bill Claim ID
 ;    ("PLAN")         = IEN of the the entry in the GROUP INSURANCE
 ;                       PLAN file(#355.3)(captured from the
 ;                       $$RX^IBNCPDP call)
 ;    ("COPAY")        = Patient's copay from ECME response
 ;    ("RX NO")        = RX number from file 52
 ;    ("DRUG")         = IEN of file #50 DRUG
 ;    ("DAYS SUPPLY")  = Days Supply
 ;    ("QTY")          = Quantity Dispensed (should be from the Rx fill or refill 52/52.1)
 ;    ("NDC")          = NDC
 ;    ("CLOSE REASON") = Optional, Pointer to the IB file #356.8
 ;                      "CLAIMS TRACKING NON-BILLABLE REASONS"
 ;    ("CLOSE COMMENT")= Optional, if the close reason is defined
 ;                       then the Close Comment parameter may be
 ;                       sent to IB
 ;    ("DROP TO PAPER")= Optional, this parameter may be set to 1(TRUE)
 ;                       for certain Close Claim Reasons, indicating
 ;                       that that the closed episode still may be
 ;                       "dropped to paper" - passed to the Autobiller
 ;    ("RELEASE COPAY")= Optional, if the claim is being closed, setting
 ;                       this parameter to 1 (TRUE) indicates that the
 ;                       patients copay should be released off hold
 ;    ("DIVISION")     = Pointer to the MC DIVISION file (#40.8)
 ;    ("AUTH #")       = ECME approval/authorization number
 ;    ("CLAIMID")      = Reference Number to ECME
 ;    ("EPHARM")       = Optional, #9002313.56 ien (E-PHARMACY division)
 ;    ("RTYPE")        = Optional, rate type specified by user during
 ;                       manual ePharmacy processing
 ;    ("PRIMARY BILL") = Optional, if this is to be a secondary bill,
 ;                       this is the primary bill the secondary relates
 ;    ("PRIOR PAYMENT")= Optional, on secondary bills this is the offset
 ;                       to be applied from the primary payment.
 ;    ("RXCOB")        = Optional, COB indicator (secondary = 2)
 ;
 ;
 ; Return is the bill number for success or 1 if not billable.
 ; "0^reason" indicates not success
 ;
 ;
 Q $$ECME^IBNCPDP2(DFN,.IBD)
 ;
 ;
UPAWP(IBNDC,IBAWP,IBADT) ; used to update AWPs.  This is an API that
 ; pharmacy will call.
 ;
 ;  IBNDC = NDC number to update with the price.
 ;  IBAWP = average wholesale price of the NDC
 ;  IBADT  = effective date of change (optional, default it today)
 ;
 ;  return will be a positive number indicating success.
 ;  if it is unsuccessful, then "0^reason" will be returned.
 ;
 Q $$UPAWP^IBNCPDP3(IBNDC,IBAWP,$G(IBADT,DT))
 ;
BILLABLE(DRUG,ELIG,IBRMARK,IBBDAR) ; used to pass the ePharmacy Billable Status 
 ;
 ;Input:
 ;  DRUG = PRESCRIPTION File #52 IEN (required)
 ;  ELIG = BILLING ELIGIBILITY INDICATOR (T,C,V) field #85 of file 52 or 52.1. If not defined, assume "V".
 ;
 ;Output:
 ;  IBRMARK = "DRUG NOT BILLABLE" - only set if drug not billable (pass by reference)
 ;   IBBDAR = (optional) array values returned regarding drug file billable fields (pass by reference)
 ;  Function Value:   1 if drug is billable, 0 if drug is not billable
 ;
 N IBRES,EPHNODE
 S IBRES=0,IBRMARK="DRUG NOT BILLABLE"    ; assume not billable as default
 ;
 I '$G(DRUG) G BILLQ
 I $G(ELIG)="" S ELIG="V"
 ;
 S EPHNODE=$$PSSBILSD^PSS50(DRUG)        ;using PSS API to obtain this information IA# 6245
 ;
 ; set the values into the array 
 S IBBDAR("DRUG-BILLABLE")=$P(EPHNODE,U,1)
 S IBBDAR("DRUG-BILLABLE TRICARE")=$P(EPHNODE,U,2)
 S IBBDAR("DRUG-BILLABLE CHAMPVA")=$P(EPHNODE,U,3)
 ;
 ; If Elig is VET:
 ;  and ePharmacy Billable field is YES, then drug is billable.
 ;  Otherwise, drug is non-billable.
 I ELIG="V" D  G BILLQ
 . I $P(EPHNODE,U,1) S IBRES=1 K IBRMARK Q
 . Q
 ;
 ;If Elig is TRICARE:
 ; And ePharmacy Billable TRICARE field is YES, then drug is billable
 ; And ePharmacy Billable TRICARE field is NO, then drug is non-billable
 ; And ePharmacy Billable field is YES and ePharmacy Billable TRICARE field is unanswered, then drug is billable
 ; Otherwise, drug is non-billable
 ;
 I ELIG="T" D  G BILLQ
 . I $P(EPHNODE,U,2) S IBRES=1 K IBRMARK Q                         ; TRICARE billable true
 . I $P(EPHNODE,U,1),$P(EPHNODE,U,2)="" S IBRES=1 K IBRMARK Q      ; TRICARE billable unanswered + ePharm billable true
 . Q
 ;
 ;If Elig is CHAMPVA:
 ;  And ePharmacy Billable CHAMPVA field is YES, then drug is billable
 ;  And ePharmacy Billable CHAMPVA field is NO, then drug is non-billable
 ;  And ePharmacy Billable field is YES and ePharmacy Billable CHAMPVA is unanswered, then drug is billable
 ;  Otherwise, drug is non-billable
 ;
 I ELIG="C" D  G BILLQ
 . I $P(EPHNODE,U,3) S IBRES=1 K IBRMARK Q                         ; CHAMPVA billable true
 . I $P(EPHNODE,U,1),$P(EPHNODE,U,3)="" S IBRES=1 K IBRMARK Q      ; CHAMPVA billable unanswered + ePharm billable true
 . Q
 ;
BILLQ ;
 Q IBRES
 ;
