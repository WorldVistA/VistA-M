SPNPM2 ;SD/AB-PROGRAM MEASURE #2 ;5/26/98
 ;;2.0;Spinal Cord Dysfunction;**6**;01/02/1997
MAIN ;-- This program will 1st collect all SCD-R Pts into the ^TMP($J,"SPNPM2","ALL_SCD") global then it will collect into 4 seperate ^TMP($J,"SPNPM2") as follows:
 ;-- TOT_ADM = All SCD-R Pts /w FY 97 admissions
 ;-- TOT_DIS = All SCD-R Pts /w FY 97 disharges
 ;-- TOT_ONSET = All SCD-R Pts /w Date of Onset between 4/1/96 and 9/30/97
 ;-- TOT_ICD = All SCD-R Pts /w any SCI ICD-9 codes in any PTF record
 ;-- TOT_PTF = All SCD-R Pts /w PTF records meeting PM #2 Denominator criteria
 ;-- This program also calls ^SPNPM2B which calls ^SPNPMDX which collects all SCI ICD9 codes into the ^TMP($J,"SPNPMDX","SPNICD",ICD_IEN) global
 ;
 ;-- SPN Variable Array List:
 ;-- ADM_DT = admission date
 ;-- BEG_DT = beginning date (for loop)
 ;-- BEG_DT1 = variable/changing beginning date
 ;-- DC_DT = discharge date
 ;-- DFN = DFN
 ;-- END# = ending number (ICD9)
 ;-- END_DT = ending date (for loop)
 ;-- E_NODE = "E" node of file 154 global
 ;-- FIM_DT = FIM date
 ;-- FIM_IEN = FIM IEN (in file 154.1)
 ;-- FY = fiscal year
 ;-- I = FOR loop variable
 ;-- ICDPT = pointer from PTF file to ICD9 Dx file
 ;-- ICD_FLG = ICD9 flag (set to 1 if SCI Dx found)
 ;-- ICD_IEN = IEN in ICD9 Dx file (#80)
 ;-- ONSET_DT = beginning SCD onset date (for loop)
 ;-- ONS_DT = actual SCD onset date found from file 154 record
 ;-- ONS_FLG = SCD onset date flag (set to 1 if date is between 4/1/96 and 9/30/97)
 ;-- PIECE = piece in 70 node of PTF file global (ICD9 pointer) 
 ;-- PTF_ADMDT = PTF record admission date
 ;-- PTF_DCDT = PTF record discharge date
 ;-- PTF_FLG = PTF flag (set to 1 if PTF record is correct type, is transmitted, has at least one SCI ICD9 code, and admission date on or after Onset Date)
 ;-- PTF_IEN = IEN in PTF file
 ;-- ST# = starting number for ICD9 code FOR loop
 ;-- TOT_ADM = total # SCD Pts with FY admissions
 ;-- TOT_CNT = total count (used to count total of all SCD Pts)
 ;-- TOT_DENOM1 = denominator total based on FY admissions
 ;-- TOT_DENOM2 = denominator total based on discharges
 ;-- TOT_DIS = total # of SCD-R Pts /w FY discharges
 ;-- TOT_FIM = total # of FIMS found (1-2)
 ;-- TOT_ICD = total # of SCD-R Pts /w any SCI ICD9 codes in any PTF record
 ;-- TOT_NUM = Numerator total for PM #2
 ;-- TOT_ONSET = total # of SCD-R Pts /w SCD Onset Date between 4/1/96 and 9/30/97
 ;-- TOT_PTF = Denominator total for PM #2
 ;-- TOT_SCORE = FIM total score (from file 154.1)
 ;
 K:$D(^TMP($J)) ^($J)
 ;-- Get previous FY information, BEG_DT and END_DT
 D GETYR
 D GETALL
 D GETADM
 D GETDIS
 D GETONS
 ;-- Get PTF and ICD info
 D ^SPNPM2B
 ;-- Now get Denominator totals
 D ^SPNPM2D
 ;-- Get Numerator
 D ^SPNPM2N
 ;-- Print Results
 D ^SPNPM2C
EXIT K SPN
 K:$D(^TMP($J)) ^($J)
 Q
GETYR ;-- Get FY for previous FY, and set Ending Date (END_DT) to FM FY_0930
 I +$E($G(DT),4,7)<931 S SPN("FY")=$E($G(DT),1,3)-1
 E  S SPN("FY")=$E($G(DT),1,3)
 S SPN("END_DT")=+SPN("FY")_"0930"
 S SPN("BEG_DT")=+(SPN("FY")-1)_"1001"
 S SPN("ONSET_DT")=+(SPN("FY")-1)_"0401"
 Q
GETALL ;-- Get all SCD-R patients and store into ^TMP($J,"SPNPM2","ALL_SCD",DFN) global
 S SPN("DFN")=0
 F  S SPN("DFN")=$O(^SPNL(154,SPN("DFN"))) Q:'+SPN("DFN")  D
 .;-- Quit if no Zero Node
 .Q:'$D(^SPNL(154,SPN("DFN"),0))
 .;-- Set ^TMP($J,"SPNPM2","ALL_SCD",DFN)
 .S ^TMP($J,"SPNPM2","ALL_SCD",SPN("DFN"))=""
 .Q
 Q
GETADM ;-- Get all SCD pts who have had admissions in FY 97
 ;-- Loop thru date range (BEG_DT thru END_DT) in Pt Movement file (^DGPM)
 ;-- Store into ^TMP($J,"SPNPM2","TOT_ADM",DFN) global
 ;-- Initialize DFN variable
 S SPN("DFN")=0,SPN("END_DT")=SPN("END_DT")+.999
 F  S SPN("DFN")=$O(^DGPM("APTT1",SPN("DFN"))) Q:'+SPN("DFN")  D
 .S SPN("BEG_DT1")=SPN("BEG_DT")-.001
 .F  S SPN("BEG_DT1")=$O(^DGPM("APTT1",SPN("DFN"),SPN("BEG_DT1"))) Q:'+SPN("BEG_DT1")!(SPN("BEG_DT1")>SPN("END_DT"))  D
 ..;-- Get PTF pointer# from PM_IEN
 ..;S SPN("PM_IEN")=$O(^DGPM("APTT1",SPN("DFN"),SPN("BEG_DT1"),0))
 ..;S SPN("PTF_IEN")=$P($G(^DGPM(SPN("PM_IEN"),0)),U,16)
 ..;-- Check to see if Pt in SCD-R, if so then set ^TMP($J,"SPNPM2","TOT_ADM",DFN) global
 ..I +$D(^SPNL(154,SPN("DFN"),0)) S ^TMP($J,"SPNPM2","TOT_ADM",SPN("DFN"))=""
 ..Q
 .Q
 Q
GETDIS ;-- Get all SCD pts who have had discharges in FY 97
 ;-- Loop thru date range (BEG_DT thru END_DT) in Pt Movement file (^DGPM)
 ;-- Store into ^TMP($J,"SPNPM2","TOT_DIS",DFN) global
 ;-- Initialize DFN variable
 S SPN("DFN")=0
 F  S SPN("DFN")=$O(^DGPM("APTT3",SPN("DFN"))) Q:'+SPN("DFN")  D
 .S SPN("BEG_DT1")=SPN("BEG_DT")-.001
 .F  S SPN("BEG_DT1")=$O(^DGPM("APTT3",SPN("DFN"),SPN("BEG_DT1"))) Q:'+SPN("BEG_DT1")!(SPN("BEG_DT1")>SPN("END_DT"))  D
 ..;-- Get PTF pointer# from PM_IEN
 ..;S SPN("PM_IEN")=$O(^DGPM("APTT3",SPN("DFN"),SPN("BEG_DT1"),0))
 ..;S SPN("PTF_IEN")=$P($G(^DGPM(SPN("PM_IEN"),0)),U,16)
 ..;-- Check to see if Pt in SCD-R, if so then set ^TMP($J,"SPNPM2","TOT_DIS",DFN) global
 ..I +$D(^SPNL(154,SPN("DFN"),0)) S ^TMP($J,"SPNPM2","TOT_DIS",SPN("DFN"))=""
 ..Q
 .Q
 Q
GETONS ;-- Get all SCD pts who have an ETIOLOGY /w a DATE OF ONSET between 4/1/96 and 9/30/97
 ;-- Store into ^TMP($J,"SPNPM2","TOT_ONSET",DFN) global
 ;-- Quit if '$D(^TMP($J,"SPNPM2","ALL_SCD"))
 Q:'$D(^TMP($J,"SPNPM2","ALL_SCD"))
 ;-- Inititalze SPN("DFN")
 S SPN("DFN")=0
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","ALL_SCD",SPN("DFN"))) Q:'+SPN("DFN")  D
 .;-- Initialize Onset flag (ONS_FLG) - this flag=1 if DATE OF ONSET is between 4/1/96 and 9/30/97
 .S SPN("ONS_FLG")=0
 .I +$D(^SPNL(154,SPN("DFN"),"E",0)) D
 ..S SPN("E_NODE")=0
 ..F  S SPN("E_NODE")=$O(^SPNL(154,SPN("DFN"),"E",SPN("E_NODE"))) Q:'+SPN("E_NODE")!(SPN("ONS_FLG")=1)  D
 ...S SPN("ONS_DT")=$P($G(^SPNL(154,SPN("DFN"),"E",SPN("E_NODE"),0)),U,2)
 ...;-- If ONS_DT>0 and then ONST_DT is between 4/1/96 and 9/30/97, then set ONS_FLG and store into ^TMP($J,"SPNPM2","TOT_ONSET",DFN)
 ...I SPN("ONS_DT")>0,SPN("ONS_DT")>2960331&(SPN("ONS_DT")<2971001) S ^TMP($J,"SPNPM2","TOT_ONSET",SPN("DFN"))=SPN("ONS_DT") S SPN("ONS_FLG")=1
 ...Q
 ..Q
 .Q
 Q
