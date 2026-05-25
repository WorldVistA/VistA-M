IBACCWLBILLVE ;EDE/TAZ - ACC (Automated Community Care) Claims - VIEW ENCOUNTER ; 12-SEP-2023 ; 12-SEP-2023
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;THIS ROUTINE ALLOWS THE USER TO VIEW THE X12 ENCOUNTER IN READABLE FORMAT.
 ; 
 ;
 ;S SESSIONKEY="IBACCBILL",IBENCIFN=56620 D EN^IBACCWLBILLVE
EN ;
 N D,D1,SBR,VALMAR,VALMCNT,VALMHDR,VALMSG
 ;
 N IBPARENT S IBPARENT=0  ;TPF;IB*2*770vPURPLE;EBILL-5385 EE DISPLAYS ONE RECORD
 S IBACCWLBILLVELEV=$G(IBACCWLBILLVELEV)+1
 ;
 D EN^VALM("IBACC WL VE BILLING")
 ;
 Q
 ;
HDR ; -- header code
 ;
 S VALMHDR(1)="Special Billing View X12 Encounter Data"
 ;
 Q
 ;
INIT ;EP -- init variables and list array
 N CLM,CLMCNT,CODE,D,D1,HI,HL,IOD,LINEVAR,NODE,SBR,TAX
 N DIAGPTRARR,IBFORM  ;TPF;IB*27*70v38;EBILL-5483  Diagnosis Code Pointer ARRAY
 N DISUSERGROUP,IBTYPEFORM,IBINOUT,USERGROUP  ;TPF;IB*2*770v53;EBILL-6203
 ;
 S IBFORM=$$GET1^DIQ(364.9,IBENCIFN,.06,"E")   ;CMS-1500, UB-04 OR D
 S IBINOUT=$$GET1^DIQ(364.9,IBENCIFN,.05,"I")  ;I OR O
 S IBTYPEFORM="|"_IBINOUT_"_"_$P(IBFORM,"-")_"|"
 ;
 ;BEGIN TPF;IB*2*770v53;EBILL-6203
 S USERGROUP=$P(SESSIONKEY,"IBACC",2)
 S DISUSERGROUP=$$DISUSERGROUP^IBACCWLBILLVE1A(USERGROUP)
 S VALM("TITLE")=" ACC "_DISUSERGROUP_" View Encounter"
 N INCLUDE D GETINCLUSIONS^IBACCWLBILLVE1A(.INCLUDE,USERGROUP,IBINOUT,IBFORM)
 ;
 I '$D(INCLUDE) D  Q
 .W !!,"There are no inclusion parameters set up for"
 .W !,"Form: ",$G(IBFORM)
 .W !,"Pat Type: ",$G(IBINOUT)
 .N DIR
 .D PAUSE^VALM1
 .S VALMBCK="Q"
 ;END TPF;IB*2*770v53;EBILL-6203
 ;
 S D="*",D1=":"
 S (CLM,CLMCNT,HI,HL,SBR,VALMCNT)=0
 S IOD=$$GET1^DIQ(364.9,IBENCIFN,.05,"I")
 F  S CLMCNT=$O(^IBA(364.9,IBENCIFN,1,CLMCNT)) Q:'CLMCNT  S DATA=^(CLMCNT,0) Q:DATA=""  D
 . S NODE=$P(DATA,D,1)
 . ;Nodes not processed:   BHT,CUR,K3,SE,ST
 . I ",AMT,CAS,CL1,CLM,CN1,CR1,CR2,CR3,CRC,CTP,DMG,DN1,DN2,DTP,FRM,HCP,HI,HL,LIN,LQ,LX,MEA,MIA,MOA,NM1,NTE,N3,N4,OI,PAT,PER,PRV,PS1,PWK,QTY,REF,SBR,SV1,SV2,SV3,SV5,SVD,TOO,"'[(","_NODE_",") Q
 . I ",HI,"[(","_NODE_",") S NODE=NODE_"^IBACCWLBILLVE1A"  ;TPF;IB*2*770v770PURPLE;EBILL-9999 SAC SIZE
 . ;I ",CAS,CLM,CRC,DTP,HCP,HI,"[(","_NODE_",") S NODE=NODE_"^IBACCWLBILLVE1"  ;TPF;IB*2*770v770PURPLE;EBILL-9999 SAC SIZE
 . I ",CAS,CLM,CRC,DTP,HCP,"[(","_NODE_",") S NODE=NODE_"^IBACCWLBILLVE1"
 . I ",MIA,NM1,PWK,REF,SBR,"[(","_NODE_",") S NODE=NODE_"^IBACCWLBILLVE2"
 . ;I ",SV1,SV2,SV3,SV5,SVD,"[(","_NODE_",") S NODE=NODE_"^IBACCWLBILLVE3"
 . I ",SV1,SV2,SV3,SV5,SVD,NTE,"[(","_NODE_",") S NODE=NODE_"^IBACCWLBILLVE3"  ;TPF;IB*2*770v53;EBILL-6203
 . D @NODE
 ;
 D SET(""," ")  ;TPF;IB*2*770v53;EBILL-6203
 D SET(""," ")  ;TPF;IB*2*770v53;EBILL-6203
 ;
 ;BEGIN TPF*IB*2*770v38;EBILL-5485,5721
 I $G(IBENCIFN),($D(@VALMAR)) D
 .N IBIFN
 .S @VALMAR@("IEN3649",1)=IBENCIFN
 .S IBIFN=$$GET1^DIQ(364.9,IBENCIFN_",",2.02,"I")
 .S:$G(IBIFN) @VALMAR@("IEN399",1)=IBIFN
 ;END TPF*IB*2*770v38;EBILL-5485,5721
 ;
INITQ ;Exit
 I '$D(@VALMAR) D SET^VALM10(1,"NO DATA FOUND!!")
 Q
 ;
AMT ;Display Amount Patient Paid
 S CODE=$P(DATA,D,2) D  D SET(CODE,$$DOL($P(DATA,D,3)))
 . I CODE="A8" S CODE="Noncovered Charges - Actual" Q
 . I CODE="D" S CODE="Payor Amount Paid" Q
 . I CODE="EAF" S CODE="Amount Owed" Q
 . I CODE="F3" S CODE="Patient Responsibility - Estimated" Q
 . I CODE="F4" S CODE="Postage Claimed Amount" Q
 . I CODE="F5" S CODE="Patient Amount Paid" Q
 . I CODE="GT" S CODE="Service Tax Amount" Q
 . I CODE="N8" S CODE="Facility Tax Amount" Q
 . I CODE="T" S CODE="Sales Tax Amount" Q
 Q
 ;
CL1 ;Institutional Claim Code
 D SET("Admission Type Code",$P(DATA,D,2))
 D SET("Admission Source Code",$P(DATA,D,3))
 D SET("Patient Status Code",$P(DATA,D,4))
 Q
 ;
CN1 ;Display Contract Information
 S CODE=$P(DATA,D,2) D  D SET("Contract Type Code",CODE)
 . I CODE="01" S CODE="Diagnosis Related Group (DRG)" Q
 . I CODE="02" S CODE="Per Diem" Q
 . I CODE="03" S CODE="Variable Per Diem" Q
 . I CODE="04" S CODE="Flat" Q
 . I CODE="05" S CODE="Capitated" Q
 . I CODE="06" S CODE="Percent" Q
 . I CODE="09" S CODE="Other" Q
 . S CODE="UNKNOWN CODE"
 I $P(DATA,D,3)'="" D SET("Contract Amount",$$DOL($P(DATA,D,3)))
 I $P(DATA,D,4)'="" D SET("Contract Percentage",($P(DATA,D,4)*100)_"%")
 I $P(DATA,D,5)'="" D SET("Contract Code",$P(DATA,D,5))
 I $P(DATA,D,6)'="" D SET("Terms Discount Percentage",($P(DATA,D,6)*100)_"%")
 I $P(DATA,D,7)'="" D SET("Contract Version Identifier",$P(DATA,D,7))
 Q
 ;
CR1 ;Display Ambulance Transport Information
 I $P(DATA,D,3)'="" D SET("Patient Weight",$P(DATA,D,3)_$S($P(DATA,D,2)="LB":" Pounds",1:""))
 S CODE=$P(DATA,D,5) D  D SET("Ambulance Transport Reason Code",CODE)
 . I CODE="A" S CODE="Transported to Nearest Facility" Q
 . I CODE="B" S CODE="Transported for Benefit of Preferred Physician" Q
 . I CODE="C" S CODE="Transported for Nearness of Family Members" Q
 . I CODE="D" S CODE="Transported for Care of a Specialist" Q
 . I CODE="E" S CODE="Transferred to Rehabilitation Facility" Q
 . S CODE="UNNKNOWN"
 D SET("Transport Distance",$P(DATA,D,7)_$S($P(DATA,D,6)="DH":" Miles",1:""))
 I $P(DATA,D,10)'="" D SET("Round Trip Purpose Description",$P(DATA,D,10))
 I $P(DATA,D,11)'="" D SET("Stretcher Purpose Description",$P(DATA,D,11))
 Q
 ;
CR2 ;Spinal Manipulation Service Information
 S CODE=$P(DATA,D,9) D  D SET("Patient Condition",CODE)
 . I CODE="A" S CODE="Acute Condition" Q
 . I CODE="C" S CODE="Chronic Condition" Q
 . I CODE="D" S CODE="Non-Acute" Q
 . I CODE="E" S CODE="Non-Life Threatening" Q
 . I CODE="F" S CODE="Routine" Q
 . I CODE="G" S CODE="Symptomatic" Q
 . I CODE="M" S CODE="Acute Manifestation of a Chronic Condition" Q
 . S CODE="UNKNOWN"
 I $P(DATA,D,11)'="" D SET("Patient Condition Description",$P(DATA,D,11))
 I $P(DATA,D,12)'="" D SET("",$P(DATA,D,12))
 Q
 ;
CR3 ;Durable Medical Equipment Certification
 S CODE=$P(DATA,D,2) D  D SET("Certification Type Code",CODE)
 . I CODE="I" S CODE="Initial" Q
 . I CODE="R" S CODE="Renewal" Q
 . I CODE="S" S CODE="Revised" Q
 . S CODE="UNKNOWN"
 D SET("Durable Medical Equipment Duration",$P(DATA,D,4)_$S($P(DATA,D,3)="MO":" Months",1:""))
 Q
 ;
CTP ;Drug Quantity
 N UNIT
 S UNIT=$P($P(DATA,D,6),D1,1) D  D SET("National Drug Unit Count",$P(DATA,D,5)_UNIT)
 . I UNIT="F2" S UNIT=" International Unit(s)" Q
 . I UNIT="GR" S UNIT=" Gram(s)" Q
 . I UNIT="ME" S UNIT=" Milligram(s)" Q
 . I UNIT="ML" S UNIT=" Mililiter(s)" Q
 . I UNIT="UN" S UNIT=" Unit(s)"
 . S UNIT=" "_UNIT
 Q
 ;
DMG ;Demographics
 D SET("Date of Birth",$$DATE($P(DATA,D,3)))
 D SET("Gender",$S($P(DATA,D,4)="F":"Female",$P(DATA,D,4)="M":"Male",1:"Unknown"))
 I $P(DATA,D,11)'="" D SET("Patient Condition Description",$P(DATA,D,11))
 I $P(DATA,D,12)'="" D SET("Patient Condition Description",$P(DATA,D,12))
 Q
 ;
DN1 ;Orthodontic Total Months of Treatment
 S CODE=$P(DATA,D,2) I $L(CODE) D SET("Orthodontic Treatment Months Count",CODE)
 S CODE=$P(DATA,D,3) I $L(CODE) D SET("Orthodontic Treatment Months Remaining Count",CODE)
 S CODE=$P(DATA,D,5) I $L(CODE) D SET("Orthodontic Treatment Indicator",$$YN(CODE))
 Q
 ;
DN2 ;Tooth Status
 D SET("Tooth Number",$P(DATA,D,2))
 S CODE=$P(DATA,D,3) D  D SET("Tooth Status",CODE)
 . I CODE="E" S CODE="To Be Extracted"
 . I CODE="M" S CODE="Missing"
 S CODE=$P(DATA,D,7) D  D SET("Code List Qualifier Code",CODE)
 . I CODE="JP" S CODE="Universal National Tooth Designation System" Q
 Q
 ;
FRM ;Supporting Documentation
 D SET("Question Number/Letter",$P(DATA,D,2))
 S CODE=$P(DATA,D,3) I $L(CODE) D SET("Question Response",$$YN(CODE))
 S CODE=$P(DATA,D,4) I $L(CODE) D SET("Question Response",CODE)
 S CODE=$P(DATA,D,5) I $L(CODE) D SET("Question Response",$$DATE(CODE))
 S CODE=$P(DATA,D,6) I $L(CODE) D SET("Question Response",(CODE*100)_"%")
 Q
 ;
HL ;Display HL Record
 S CODE=$P(DATA,D,4)
 S LINEVAR=$S(CODE=23:"DEPENDENT INFORMATION",CODE=2:"SUBSCRIBER INFORMATION",1:"")
 D SET(LINEVAR,,1,1)
 Q
 ;
LIN ;Drug Identification
 S CODE=$P(DATA,D,3) D  D SET("Product or Service ID Qualifier",CODE)
 . I CODE="EN" S CODE="EAN/UCC-13" Q
 . I CODE="EO" S CODE="AND/UCC-8" Q
 . I CODE="HI" S CODE="HIBC Supplier Labeling Standard Primary Data Message" Q
 . I CODE="N4" S CODE="National Drug Code in 5-4-2 Format" Q
 . I CODE="ON" S CODE="Customer Order Number" Q
 . I CODE="UK" S CODE="GTIN 14-digit Data Structure" Q
 . I CODE="UP" S CODE="UCC-12" Q
 . S CODE="UNKNOWN"
 D SET("National Drug Code or Universal Product Number",$P(DATA,D,4))
 Q
 ;
LQ ;Form Identification Code
 S CODE=$P(DATA,D,2) D  D SET("Form Qualifier Code",CODE)
 . I CODE="AS" S CODE="Form Type Code" Q
 . I CODE="UT" S CODE="CMS DME Certificate of Medical Necessity" Q
 D SET("Form Identifier",$P(DATA,D,3))
 Q
 ;
LX ;Service Line Number
 D SET("Assigned Number",$P(DATA,D,2))
 Q
 ;
MEA ;Test Results
 S CODE=$P(DATA,D,2) D  D SET("Measurement Reference ID Code",CODE)
 . I CODE="OG" S CODE="Orginal (Starting Dosage)" Q
 . I CODE="TR" S CODE="Test Results" Q
 . S CODE="UNKNOWN"
 S CODE=$P(DATA,D,3) D  D SET(CODE,$P(DATA,D,4))
 . I CODE="HT" S CODE="Height" Q
 . I CODE="R1" S CODE="Hemoglobin" Q
 . I CODE="R2" S CODE="Hematocrit" Q
 . I CODE="R3" S CODE="Epoetin Starting Dosage" Q
 . I CODE="R4" S CODE="Creatinine" Q
 . S CODE="UNKNOWN"
 Q
 ;
MOA ;Outpatient Adjudication Information
 S CODE=$P(DATA,D,2) I $L(CODE) D SET("Reimbursement Rate",(CODE*100)_"%")
 S CODE=$P(DATA,D,3) I $L(CODE) D SET("HCPCS Payable amount",$$DOL(CODE))
 S CODE=$P(DATA,D,4) I $L(CODE) D SET("Claim Payment Remark Code",CODE)
 S CODE=$P(DATA,D,5) I $L(CODE) D SET(,CODE)
 S CODE=$P(DATA,D,6) I $L(CODE) D SET(,CODE)
 S CODE=$P(DATA,D,7) I $L(CODE) D SET(,CODE)
 S CODE=$P(DATA,D,8) I $L(CODE) D SET(,CODE)
 S CODE=$P(DATA,D,9) I $L(CODE) D SET("End Stage Renal Disease Payment Amount",$$DOL(CODE))
 S CODE=$P(DATA,D,10) I $L(CODE) D SET("Non-Payable Professional Component Billed Amount",$$DOL(CODE))
 Q
 ;
N3 ;Address line 1
 D SET(,$P(DATA,D,2))
 I $P(DATA,D,3)'="" D SET(,$P(DATA,D,3))
 Q
 ;
N4 ;City, State, and Zip
 D SET(,$P(DATA,D,2)_", "_$P(DATA,D,3)_"  "_$$ZIP($P(DATA,D,4)))
 Q
 ;
OI ;Other Insurance Coverage Information
 D SET("Benefits Assignment Certification Indicator",$$YN($P(DATA,D,4)))
 S CODE=$P(DATA,D,5) I $L(CODE) D SET("Signature Source Code","Signature generated by provider")
 S CODE=$P(DATA,D,7) D  D SET("Release of Information",CODE)
 . I CODE="I" S CODE="Informed Consent to Release Medical Information" Q
 . I CODE="Y" S CODE="Yes, Provider has a Signed Statement Permitting Release" Q
 Q
 ;
PAT ;Display Patient Segment
 S CODE=$P(DATA,D,2) I CODE'="" D  D SET("Relationship to Insured",CODE)
 . I CODE="01" S CODE="Spouse" Q
 . I CODE=19 S CODE="Child" Q
 . I CODE=20 S CODE="Employee" Q
 . I CODE=21 S CODE="Unknown" Q
 . I CODE=39 S CODE="Organ Donor" Q
 . I CODE=40 S CODE="Cadaver Donor" Q
 . I CODE=53 S CODE="Life Partner" Q
 . I CODE="G8" S CODE="Other Relationship" Q
 I $P(DATA,D,7)'="" D SET("Date of Death",$$DATE($P(DATA,D,7)))
 I $P(DATA,D,9)'="" D SET("Weight",$P(DATA,D,9)_$S($P(DATA,D,8)="01":" Actual Pounds",1:""))
 I $P(DATA,D,10)'="" D SET("Pregnant",$S($P(DATA,D,10)="Y":"Yes",1:"No"))
 Q
 ;
PER ;Submitter EDI Contact Information
 N PCE
 D SET("Contact",$P(DATA,D,3))
 F PCE=4,6,8 D
 . I $P(DATA,D,PCE)="EX" D SET("  Extension",$P(DATA,D,PCE+1)) Q
 . I $P(DATA,D,PCE)="EM" D SET("Email",$P(DATA,D,PCE+1)) Q 
 . I $P(DATA,D,PCE)="FX" D SET("Fax",$$PHONE($P(DATA,D,PCE+1)))
 . I $P(DATA,D,PCE)="TE" D SET("Phone",$$PHONE($P(DATA,D,PCE+1))) Q
 Q
 ;
PRV ;Provider Specialty
 S CODE=$P(DATA,D,2) I $L(CODE) D  D SET("Provider Code",CODE)
 . I CODE="AS" S CODE="Assistant Surgeon" Q
 . I CODE="AT" S CODE="Attending" Q
 . I CODE="BI" S CODE="Billing" Q
 . I CODE="PE" S CODE="Performing" Q
 . I CODE="RF" S CODE="Referring" Q
 D SET("Taxonomy Code",$P(DATA,D,4))
 Q
 ;
PS1 ;Purchased Service Information
 D SET("Purchased Service Provider ID",$P(DATA,D,2))
 D SET("Purchased Service Charge Amount",$$DOL($P(DATA,D,3)))
 ;
QTY ;Ambulance Patient Count
 N ADD,TITLE
 S CODE=$P(DATA,D,2) D  D SET(TITLE,$P(DATA,D,3)_ADD)
 . I CODE="PT" S TITLE="Ambulance Patient Count",ADD="Patient(s)" Q
 . I CODE="FL" S TITLE="Obstetric Additional Units",ADD="Unit(s)" Q
 . S ADD=""
 Q
 ;
TOO ;Tooth Information
 N CNT,TSC
 S CODE=$P(DATA,D,2) D  D SET("Code List Qualifier",CODE)
 . I CODE="JP" S CODE="Universal Tooth Designation System"
 D SET("Tooth Code",$P(DATA,D,3))
 S CODE=$P(DATA,D,4) F CNT=1:1:5 S TSC=$P(CODE,D1,CNT) I $L(TSC) D  D SET($S(CNT=1:"Tooth Surface Code",1:""),TSC)
 . I TSC="B" S TSC="Buccal" Q
 . I TSC="D" S TSC="Distal" Q
 . I TSC="F" S TSC="Facial" Q
 . I TSC="I" S TSC="Incisal" Q
 . I TSC="L" S TSC="Lingual" Q
 . I TSC="M" S TSC="Mesial" Q
 . I TSC="O" S TSC="Oclusal"
 Q
 ;
DATE(DATE,TYPE) ;Format Date/Time
 N D1
 S TYPE=$G(TYPE,"D8")
 I TYPE="TM" S D1=DATE G DATEQ
 I TYPE="D8"!(TYPE="DT") D  G DATEQ
 . S D1=$$FMTE^XLFDT($$HL7TFM^XLFDT($E(DATE,1,8)),1)
 . I TYPE="DT" S D1=D1_" "_$E(DATE,9,12)
 S D1=$$FMTE^XLFDT($$HL7TFM^XLFDT($P(DATE,"-",1),1))_"-"_$$FMTE^XLFDT($$HL7TFM^XLFDT($P(DATE,"-",2),1))
DATEQ ;
 Q D1
 ;
DOL(DATA) ;Format Dollars
 S DATA="$"_$FN(DATA,",",2)
 Q DATA
 ;
NAME(DATA) ;Format Person Name
 N LAST,FIRST,MI,SUF
 S LAST=$P(DATA,D,4),FIRST=$P(DATA,D,5),MI=$P(DATA,D,6),SUF=$P(DATA,D,8)
 Q LAST_$S($L(FIRST):", ",1:"")_FIRST_" "_$S($L(MI):MI_" ",1:"")_SUF
 ;
PHONE(NUM) ;Format phone number
 Q "("_$E(NUM,1,3)_") "_$E(NUM,4,6)_"-"_$E(NUM,7,10)
 ;
YN(YN) ;Translate Yes/No element
 Q $S(YN="W":"Not Applicable",YN="U":"Uknown",YN="Y":"Yes",1:"No")
 ;
ZIP(ZIP) ;Format Zip Code
 Q $E(ZIP,1,5)_$S($L(+ZIP>5):"-"_$E(ZIP,6,9),1:"")
 ;
HELP ; -- help code
 ;
 N X
 S X="?" D DISP^XQORM1 W !!
 ;
 Q
 ;
EXIT ; -- exit code
 ;
 I $G(IBACCWLBILLVELEV)>1 S IBACCWLBILLVELEV=IBACCWLBILLVELEV-1 S VALMQUIT=1 Q  ;TPF;IB*2*770v38;EBILL-5485 DO NOT KILL IF CHILD STILL HAS ACTIVE LEVELS
 S IBACCWLBILLVELEV=$G(IBACCWLBILLVELEV)-1
 D CLEAN^VALM10  ;KILLS DATA AND VIDEO CONTROL ARRAYS. KILLS @VALMAR TOO
 ;
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SET(TITLE,VALUE,BLANK,HEADER) ;
 N COL,T1,WIDTH
 ;
 S TITLE=$G(TITLE),VALUE=$G(VALUE)
 Q:TITLE=""&(VALUE="")
 ;I TITLE'="" B:$G(DUZ)=561&(TITLE="Procedure Code") "S+"
 ;I TITLE'="",(VALUE'="") B:$G(DUZ)=561&(TITLE="Procedure Code") "S+"
 ;BEGIN TPF;IB*2*770v53;EBILL-6203
 I $G(TITLE)'="",(TITLE="Payer"),(SBR=1) S STOP=1 Q  ;THIS TOOK CARE OF NOT DISPLAYING THE COMMUNITY CARE PAYER SECTION
 ;                                                     BECAUSE NO SCENARIO SHOWED IT, SBR = SUBSRIBER LEVEL 2000B LOOP. IS THIS VIABLE?
 ;
 I $G(LASTSECTIONHEAD)'="" Q:$P($G(INCLUDE(LASTSECTIONHEAD)),U,4)[("~"_$P(DATA,D)_"~")  ;EXCLUDE SEGMENTS UNDER A CERTAIN SECTION
 I $G(LASTSECTIONHEAD)'="",(TITLE'="") Q:$P($G(INCLUDE(LASTSECTIONHEAD,TITLE)),U,8)[("~"_$P(DATA,D)_"~")
 I '$G(BLANK),$G(HEADER),($G(TITLE)'="") Q:'$D(INCLUDE(TITLE))
 I $G(HEADER),(TITLE'="") S LASTSECTIONHEAD=TITLE
 I LASTSECTIONHEAD'="",(TITLE'="") D
 .I $P($G(INCLUDE(LASTSECTIONHEAD,TITLE)),U,7)'="" X $P($G(INCLUDE(LASTSECTIONHEAD,TITLE)),U,7)  ;TPF;IB*2*770v53;EBILL-6203 ;EXECUTE SPECIAL FIELD FORMAT
 ;
 ;END TPF;IB*2*770v53;EBILL-6203
 I $G(BLANK) S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT," ")
 I $G(HEADER) D  G SETQ
 . I '$D(INCLUDE(LASTSECTIONHEAD)) S STOP=1 Q  ;DO NOT DISPLAY  ;TPF;IB*2*770v53;EBILL-6203
 . I '$L(TITLE) Q
 . S VALMCNT=VALMCNT+1
 . S COL=((IOM/2)-($L(TITLE)/2))\1
 . S WIDTH=$L(TITLE)
 . D CNTRL^VALM10(VALMCNT,COL,WIDTH,IORVON,IORVOFF)
 . S TITLE=$$SETSTR^VALM1(TITLE,"",COL,WIDTH)
 . D SET^VALM10(VALMCNT,TITLE)
 ;
 S LINEVAR=""
 I $L(TITLE),'$D(INCLUDE(LASTSECTIONHEAD,TITLE)) Q   ;TPF;IB*2*770 ;EBILL-6203
 ;
 I $G(LASTSECTIONHEAD)'="",($G(TITLE)'="") D
 .I $P($G(INCLUDE(LASTSECTIONHEAD,TITLE)),U,5)="$" S VALUE=$P($G(INCLUDE(LASTSECTIONHEAD,TITLE)),U,5)_$J(VALUE,0,2)  ;DOLLAR SYMBOL
 .I $P($G(INCLUDE(LASTSECTIONHEAD,TITLE)),U,4)'="" S TITLE=$P($G(INCLUDE(LASTSECTIONHEAD,TITLE)),U,4)        ;FIELD CAPTION OVERRIDE
 ;
 I $L(TITLE)>34 D
 . N J,PCE
 . S T1=""
 . F J=$L(TITLE," "):-1 Q:$L(TITLE)<35  D  I $L(TITLE)<35 D SET1(TITLE,"") S TITLE=T1 Q
 .. S T1=" "_$P(TITLE," ",J)_T1,TITLE=$P(TITLE," ",1,J-1)
 I '$D(INCLUDE(LASTSECTIONHEAD)) Q  ;TPF;IB*2*770 ;EBILL-6203
 I $L(TITLE) S TITLE=TITLE_":"
 D SET1(TITLE,VALUE)
SETQ ;
 Q
 ;
SET1(TITLE,VALUE) ;
 S LINEVAR=$$SETFLD^VALM1(TITLE,LINEVAR,"NODE")
 S LINEVAR=$$SETFLD^VALM1(VALUE,LINEVAR,"DATA")
 S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,LINEVAR)
 Q
