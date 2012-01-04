BPSOSC2 ;BHAM ISC/FCS/DRS - Certification testing ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,8,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ; SETBPS - Overwrite BPS array with values from BPS Certification file
 ; Input
 ;    ENTRY - IEN for BPS Certification (#9002313.31)
 ; Output
 ;    BPS Array - This is newed in BPSOSCA and is shared by all BPSOSC* routines
 ;                and others
SETBPS(ENTRY) ;
 ;
 I $G(ENTRY)="" Q
 ;
 ; Initialize some variables
 N A,B,N,X,DUR,FIELD,CNT,CNT2
 ;
 ; If there is a payer in the Certification File, reset transaction header
 ;   values based on this payer sheet
 I $P(^BPS(9002313.31,ENTRY,0),"^",4) D
 . S BPS("NCPDP","IEN")=$P(^BPS(9002313.31,ENTRY,0),"^",4)
 . S BPS("NCPDP","Version")=$P($G(^BPSF(9002313.92,BPS("NCPDP","IEN"),1)),U,2)
 ;
 ; Get the Maximum claims per transmission
 S BPS("NCPDP","# Meds/Claim")=+$P($G(^BPS(9002313.31,ENTRY,0)),U,6)
 I BPS("NCPDP","# Meds/Claim")=0 S BPS("NCPDP","# Meds/Claim")=1
 ;
 ; Loop through claim header fields
 S A=0,N=1
 F  S A=$O(^BPS(9002313.31,ENTRY,1,A)) Q:'A  D
 . S X=^BPS(9002313.31,ENTRY,1,A,0)
 . S FIELD=$P(^BPSF(9002313.91,$P(X,U),0),U)
 . D SETBPS1(FIELD,$P(X,U,2))
 ;
 ; Loop through prescription fields
 ; Set variable DUR for first DUR record
 S N=0,DUR=1
 F  S N=$O(^BPS(9002313.31,ENTRY,2,N)) Q:'N  D
 . S A=0
 . F  S A=$O(^BPS(9002313.31,ENTRY,2,N,1,A)) Q:'A  D
 .. S X=^BPS(9002313.31,ENTRY,2,N,1,A,0)
 .. S FIELD=$P(^BPSF(9002313.91,$P(X,U),0),U)
 .. D SETBPS1(FIELD,$P(X,U,2),N)
 . ;
 . ; Submission Clarification Codes
 . K BPS("RX",N,"Submission Clarif Code")
 . S A=0,CNT=0
 . F  S A=$O(^BPS(9002313.31,ENTRY,2,N,2,A)) Q:'A  D
 .. S X=^BPS(9002313.31,ENTRY,2,N,2,A,0)
 .. I X]"" S CNT=CNT+1,BPS("RX",N,"Submission Clarif Code",CNT)=X
 . ;
 . ; Other Amount Claimed
 . K BPS("Insurer","Other Amt Qual")
 . S A=0,CNT=0
 . F  S A=$O(^BPS(9002313.31,ENTRY,2,N,4,A)) Q:'A  D
 .. S X=^BPS(9002313.31,ENTRY,2,N,4,A,0)
 .. I X]"" D
 ... S CNT=CNT+1
 ... S BPS("Insurer","Other Amt Value",CNT)=$P(X,U,1)
 ... S BPS("Insurer","Other Amt Qual",CNT)=$P(X,U,2)
 . ;
 . ; COB data
 . K BPS("RX",N,"OTHER PAYER")
 . S A=0,CNT=0
 . F  S A=$O(^BPS(9002313.31,ENTRY,2,N,3,A)) Q:'A  D
 .. S CNT=CNT+1
 .. S BPS("RX",N,"OTHER PAYER",CNT,0)=$G(^BPS(9002313.31,ENTRY,2,N,3,A,0))
 .. ; Other Payer Paid Amounts
 .. S B=0,CNT2=0
 .. F  S B=$O(^BPS(9002313.31,ENTRY,2,N,3,A,1,B)) Q:'B  D
 ... S CNT2=CNT2+1
 ... S BPS("RX",N,"OTHER PAYER",CNT,"P",CNT2,0)=$G(^BPS(9002313.31,ENTRY,2,N,3,A,1,B,0))
 .. I CNT2'=0 S $P(BPS("RX",N,"OTHER PAYER",CNT,0),U,6)=CNT2
 .. ; Other Payer Reject Codes
 .. S B=0,CNT2=0
 .. F  S B=$O(^BPS(9002313.31,ENTRY,2,N,3,A,2,B)) Q:'B  D
 ... S CNT2=CNT2+1
 ... S BPS("RX",N,"OTHER PAYER",CNT,"R",CNT2,0)=$G(^BPS(9002313.31,ENTRY,2,N,3,A,2,B,0))
 .. I CNT2'=0 S $P(BPS("RX",N,"OTHER PAYER",CNT,0),U,7)=CNT2
 .. ; Other Payer-Patient Paid Amounts
 .. S B=0,CNT2=0
 .. F  S B=$O(^BPS(9002313.31,ENTRY,2,N,3,A,3,B)) Q:'B  D
 ... S CNT2=CNT2+1
 ... S BPS("RX",N,"OTHER PAYER",CNT,"PP",CNT2,0)=$G(^BPS(9002313.31,ENTRY,2,N,3,A,3,B,0))
 .. I CNT2'=0 S $P(BPS("RX",N,"OTHER PAYER",CNT,0),U,8)=CNT2
 .. ; Benefit Stages
 .. S B=0,CNT2=0
 .. F  S B=$O(^BPS(9002313.31,ENTRY,2,N,3,A,4,B)) Q:'B  D
 ... S CNT2=CNT2+1
 ... S BPS("RX",N,"OTHER PAYER",CNT,"BS",CNT2,0)=$G(^BPS(9002313.31,ENTRY,2,N,3,A,4,B,0))
 .. I CNT2'=0 S $P(BPS("RX",N,"OTHER PAYER",CNT,0),U,9)=CNT2
 . S BPS("RX",N,"OTHER PAYER",0)=CNT
 ;
 ; Construct a few other fields that weren't already set
 ; Patient Name is needed by BPSOSCE
 S BPS("Patient","Name")=$G(BPS("Patient","Last Name"))_","_$G(BPS("Patient","First Name"))
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
 ;;115;"Insurer","Medicaid ID Number"
 ;;201;"Site","NPI"
 ;;202;"Service Provider ID Qual"
 ;;301;"Insurer","Group #"
 ;;302;"Insurer","Policy #"
 ;;303;"Insurer","Person Code"
 ;;304;"Patient","DOB"
 ;;305;"Patient","Sex"
 ;;306;"Insurer","Relationship"
 ;;307;"Patient","Place of Service"
 ;;308;"Patient","Other Coverage Code"
 ;;309;"Insurer","Eligibility Clarification Code"
 ;;310;"Patient","First Name"
 ;;311;"Patient","Last Name"
 ;;312;"Cardholder","First Name"
 ;;313;"Cardholder","Last Name"
 ;;314;"Home Plan"
 ;;322;"Patient","Street Address"
 ;;323;"Patient","City"
 ;;324;"Patient","State"
 ;;325;"Patient","Zip"
 ;;326;"Patient","Phone #"
 ;;331;"Patient","Patient ID Qualifier"
 ;;332;"Patient","SSN"
 ;;344;"RX",N,"Quantity Intended"
 ;;345;"RX",N,"Days Supply Intended"
 ;;350;"Patient","Patient E-Mail Address"
 ;;357;"Claim",N,"Delay Reason Code"
 ;;359;"Insurer","Medigap ID"
 ;;360;"Insurer","Medigap Indicator"
 ;;361;"Insurer","Provider Accept Assign Ind"
 ;;364;"RX",N,"Prescriber First Name"
 ;;365;"RX",N,"Prescriber Street Address"
 ;;366;"RX",N,"Prescriber City Address"
 ;;367;"RX",N,"Prescriber State/Province Address"
 ;;368;"RX",N,"Prescriber Zip/Postal Zone"
 ;;384;"Patient","Patient Residence"
 ;;391;"Claim",N,"Patient Assignment Indicator"
 ;;401;"RX",N,"Date Filled"
 ;;402;"RX",N,"RX IEN"
 ;;403;"RX",N,"Refill #"
 ;;405;"RX",N,"Days Supply"
 ;;406;"RX",N,"Compound Code"
 ;;407;"RX",N,"NDC"
 ;;408;"RX",N,"DAW"
 ;;409;"RX",N,"Gross Amount Due"
 ;;411;"RX",N,"Prescriber NPI"
 ;;412;"RX",N,"Dispensing Fee"
 ;;414;"RX",N,"Date Written"
 ;;415;"RX",N,"# Refills"
 ;;418;"RX",N,"Level of Service"
 ;;419;"RX",N,"Origin Code"
 ;;421;"RX",N,"Primary Care Provider NPI"
 ;;423;"RX",N,"Basis of Cost Determination"
 ;;424;"RX",N,"Diagnosis Code"
 ;;426;"RX",N,"Usual & Customary"
 ;;427;"RX",N,"Prescriber Last Name"
 ;;429;"RX",N,"Unit Dose Indicator"
 ;;430;"RX",N,"Gross Amount Due"
 ;;433;"RX",N,"Patient Paid Amount"
 ;;436;"RX",N,"Alt. Product Type"
 ;;438;"RX",N,"Incentive Amount"
 ;;439;"RX",N,"DUR",DUR,439
 ;;440;"RX",N,"DUR",DUR,440
 ;;441;"RX",N,"DUR",DUR,441
 ;;442;"RX",N,"Quantity"
 ;;444;"RX",N,"Provider NPI"
 ;;445;"Claim",N,"Original Product Code"
 ;;453;"Claim",N,"Original Product ID Qual"
 ;;455;"RX",N,"Rx/Service Ref Num Qual"
 ;;460;"RX",N,"Quantity Prescribed"
 ;;461;"Claim",N,"Prior Auth Type"
 ;;462;"Claim",N,"Prior Auth Num Sub"
 ;;463;"Claim",N,"Intermediary Auth Type ID"
 ;;464;"Claim",N,"Intermediary Auth ID"
 ;;465;"RX",N,"Provider ID Qualifier"
 ;;466;"RX",N,"Prescriber ID Qualifier"
 ;;467;"RX",N,"Prescriber Billing Location"
 ;;468;"RX",N,"Primary Care Prov ID Qual"
 ;;469;"Patient","Primary Care Prov Location Code"
 ;;470;"RX",N,"Primary Care Prov Last Name"
 ;;473;"RX",N,"DUR",DUR,473
 ;;474;"RX",N,"DUR",DUR,474
 ;;475;"RX",N,"DUR",DUR,475
 ;;476;"RX",N,"DUR",DUR,476
 ;;481;"Insurer","Flat Sales Tax Amt Sub"
 ;;482;"Insurer","Percentage Sales Tax Amt Sub"
 ;;483;"Insurer","Percent Sales Tax Rate Sub"
 ;;484;"Insurer","Percent Sales Tax Basis Sub"
 ;;498;"RX",N,"Prescriber Phone #"
 ;;524;"Insurer","Plan ID"
 ;;600;"RX",N,"Unit of Measure"
 ;;*
