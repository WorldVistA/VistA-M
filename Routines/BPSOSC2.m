BPSOSC2 ;BHAM ISC/FCS/DRS - certification testing ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ; SETBPS - Overwrite BPS array with values from BPS Certfication file
 ; Input
 ;    ENTRY - IEN for BPS Certification (#9002313.31)
 ; Output
 ;    BPS Array - This is newed in BPSOSCA and is shared by all BPSOSC* routines
 ;                and others
SETBPS(ENTRY) ;
 ;
 I $G(ENTRY)="" Q
 ; If there is a payer in the Certification File, reset transaction header
 ;   values based on this payer sheet
 N XDATA
 I $P(^BPS(9002313.31,ENTRY,0),"^",4) D
 . S BPS("NCPDP","IEN")=$P(^BPS(9002313.31,ENTRY,0),"^",4)
 . S XDATA=$G(^BPSF(9002313.92,BPS("NCPDP","IEN"),1))
 . S BPS("NCPDP","Version")=$P(XDATA,U,2)
 . S BPS("NCPDP","# Meds/Claim")=$P(XDATA,U,3)
 . S BPS("NCPDP","Software Vendor/Cert ID")=$P(XDATA,U,13)
 ;
 ; DMB 11/28/2006 - Existing Code, not sure if this is needed.
 S BPS("Patient","SSN")=""
 ;
 ; Loop through claim header fields
 N A,N S A=0
 F  S A=$O(^BPS(9002313.31,ENTRY,1,A)) Q:'A  D
 . N X S X=^BPS(9002313.31,ENTRY,1,A,0)
 . N FIELD S FIELD=$P(^BPSF(9002313.91,$P(X,U),0),U)
 . D SETBPS1(FIELD,$P(X,U,2))
 ;
 ; Loop through prescription fields
 S N=0
 F  S N=$O(^BPS(9002313.31,ENTRY,2,N)) Q:'N  D
 . N A S A=0
 . F  S A=$O(^BPS(9002313.31,ENTRY,2,N,1,A)) Q:'A  D
 .. S X=^BPS(9002313.31,ENTRY,2,N,1,A,0)
 .. N FIELD S FIELD=$P(^BPSF(9002313.91,$P(X,U),0),U)
 .. D SETBPS1(FIELD,$P(X,U,2),N)
 ;
 ; Construct a few other fields that weren't already set
 ; DMB 11/28/2006 - Existing Code, not sure if this is needed.
 S BPS("Patient","Name")=$G(BPS("Patient","Last Name"))_","_$G(BPS("Patient","First Name"))
 I '$D(BPS("RX",1,"Quantity")) S BPS("RX",1,"Quantity")=$G(BPS("RX",1,"Metric Decimal Quantity"))
 Q
 ;
 ; Overwrite BPS array values
SETBPS1(FIELD,VALUE,N) ;
 N OK S OK=0
 N I F I=1:1 Q:$T(TABLE+I)[";;*"  D  Q:OK
 . N X S X=$T(TABLE+I)
 . I $P(X,";",3)'=FIELD Q
 . S @("BPS("_$P(X,";",4)_")=VALUE")
 . S OK=1
 Q
 ;
TABLE ;;
 ;;101;"NCPDP","BIN Number"
 ;;102;"NCPDP","Version"
 ;;103;"Transaction Code"
 ;;104;"NCPDP","PCN"
 ;;109;"Transaction Count"
 ;;110;"NCPDP","Software Vendor/Cert ID"
 ;;111;"NCPDP","Segment Identification"
 ;;201;"Site","Pharmacy #"
 ;;202;"Service Provider ID Qual"
 ;;301;"Insurer","Group #"
 ;;302;"Insurer","Policy #"
 ;;303;"Insurer","Person Code"
 ;;304;"Patient","DOB"
 ;;305;"Patient","Sex"
 ;;306;"Insurer","Relationship"
 ;;308;"Patient","Other Coverage Code"
 ;;307;"Customer Location"
 ;;309;"Eligibility Clarification Code"
 ;;310;"Patient","First Name"
 ;;311;"Patient","Last Name"
 ;;312;"Cardholder","First Name"
 ;;313;"Cardholder","Last Name"
 ;;322;"Patient","Street Address"
 ;;323;"Patient","City"
 ;;324;"Patient","State"
 ;;325;"Patient","Zip"
 ;;326;"Patient","Phone #"
 ;;331;"Patient","Patient ID Qualifier"
 ;;332;"Patient","SSN"
 ;;337;"Insurer","COB/Other Payments Counter"
 ;;338;"Insurer","Other Payer Coverage Type"
 ;;339;"Insurer","Other Payer ID Qualifier"
 ;;340;"Insurer","Other Payer ID"
 ;;341;"Insurer","Other Payer Amount Paid Count"
 ;;342;"Insurer","Other Payer Amount Paid Qual."
 ;;401;"RX","Date Filled"
 ;;402;"RX",N,"RX Number"
 ;;403;"RX",N,"Refill #"
 ;;404;"RX",N,"Quantity"
 ;;405;"RX",N,"Days Supply"
 ;;406;"RX",N,"Compound Code"
 ;;407;"RX",N,"NDC"
 ;;408;"RX",N,"DAW"
 ;;409;"RX",N,"Ingredient Cost"
 ;;410;"RX",N,"Sales Tax"
 ;;411;"RX",N,"Prescriber ID"
 ;;412;"RX",N,"Dispensing Fee"
 ;;414;"RX",N,"Date Written"
 ;;415;"RX",N,"# Refills"
 ;;416;"RX",N,"Preauth #"
 ;;418;"RX",N,"Level of Service"
 ;;419;"RX",N,"Origin Code"
 ;;420;"RX",N,"Clarification"
 ;;421;"RX",N,"Primary Prescriber"
 ;;422;"RX",N,"Clinic ID"
 ;;423;"RX",N,"Basis of Cost Determination"
 ;;424;"RX",N,"Diagnosis Code"
 ;;426;"RX",N,"Usual & Customary"
 ;;427;"RX",N,"Prescriber Last Name"
 ;;429;"RX",N,"Unit Dose Indicator"
 ;;430;"RX",N,"Gross Amount Due"
 ;;431;"RX",N,"Other Payor Amount"
 ;;433;"RX",N,"Patient Paid Amount"
 ;;436;"RX",N,"Alt. Product Type"
 ;;438;"RX",N,"Incentive Amount"
 ;;439;"RX",N,"DUR","DUR Conflict Code",439
 ;;440;"RX",N,"DUR","DUR Intervention Code",440
 ;;441;"RX",N,"DUR","DUR Outcome Code",441
 ;;442;"RX",N,"Metric Decimal Quantity"
 ;;443;"RX",N,"Primary Payor Denial Date"
 ;;444;"RX",N,"Provider ID"
 ;;455;"RX",N,"Rx/Service Ref Num Qual"
 ;;460;"RX",N,"Quantity"
 ;;461;"Claim",N,"Prior Auth Type"
 ;;462;"Claim",N,"Prior Auth Num Sub"
 ;;465;"RX",N,"Provider ID"
 ;;466;"RX",N,"Prescriber ID Qualifier"
 ;;467;"RX",N,"Prescriber Location Code"
 ;;468;"RX",N,"Primary Care Prov ID Qual"
 ;;469;"RX",N,"Primary Care Prov ID"
 ;;470;"RX",N,"Primary Care Prov Last Name"
 ;;471;"Insurer","Other Payer Reject Count"
 ;;472;"Insurer","Other Payer Reject Code"
 ;;473;"RX",N,"DUR","DUR/PPS CODE COUNTER",473
 ;;478;"Insurer","Other Amt Claim Sub Cnt"
 ;;479;"Insurer","Other Amt Claim Sub Qual"
 ;;480;"Insurer","Other Amt Claim Submitted"
 ;;481;"Insurer","Flat Sales Tax Amt Sub"
 ;;482;"Insurer","Percentage Sales Tax Amt Sub"
 ;;483;"Insurer","Percent Sales Tax Rate Sub"
 ;;484;"Insurer","Percent Sales Tax Basis Sub"
 ;;498;"RX",N,"Prescriber Phone #"
 ;;*
