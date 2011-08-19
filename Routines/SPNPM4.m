SPNPM4 ;SD/AB,WDE-PROGRAM MEASURE #4 ;5/28/98
 ;;2.0;Spinal Cord Dysfunction;**6,8**;01/02/1997
MAIN ;-- This program will collect all SCD-R Pts who are SCD-CURRENTLY SERVED and registered on or before previous FY into the ^TMP($J,"SPNPM4","REGCS_FY",DFN) global 
 ;-- Other temp globals used or created are:
 ;-- ^TMP($J,"SPNPMDX","SPNICD",DFN)
 ;-- ^TMP($J,"SPNPM2","ALL_SCD",DFN)
 ;-- ^TMP($J,"SPNPM2","TOT_ICD",DFN)
 ;-- ^TMP($J,"SPNPM4","TOT_DENOM",DFN)
 ;
 ;-- SPN Variable Array list:
 ;-- BEG_DT = Beginning Date (FOR loop)
 ;-- DFN = DFN
 ;-- END# = Ending number (ICD9)
 ;-- END_DT = Ending Date (FOR loop)
 ;-- EVAL_FLGO = Annual Rehab Evaluation Offered Flag
 ;-- EVAL_FLGR = Annual Rehab Evaluation Received Flag
 ;-- FY = Previous FY
 ;-- I = Variable used in FOR Loop for ICD9 codes
 ;-- ICDPT = Pointer from PTF file to ICD9 Dx file (#80)
 ;-- ICD_FLG = ICD9 flag (set to 1 if SCI Dx found)
 ;-- ICD_IEN = IEN in ICD9 Dx file (#80)
 ;-- OFFRD_DT = Date Annual Rehab Eval Offered
 ;-- ONSET_DT = SCD Date of Onset
 ;-- PIECE = Piece in 70 node of PTF file (#45)
 ;-- PTF_IEN = IEN in PTF file (#45)
 ;-- RECVD_DT = Date Annual Rehab Eval Received
 ;-- REG_DT = Registration Date
 ;-- REG_STAT = Registration Status
 ;-- REHAB_NODE = Annual Rehab Evaluation Node in ^SPNL(154,DFN,"REHAB")
 ;-- ST# = Starting number for ICD9 code FOR Loop
 ;-- TOT_CNT = Total # of All SCD Pts
 ;-- TOT_CSREG = Total of SCD Pts who are CS and registered on or before End of Previous FY
 ;-- TOT_DEN = Denominator Total for PM #4
 ;-- TOT_NUM = Numerator Total for PM #4 (Offered and Received)
 ;-- TOT_NUMO = Numerator Total for PM #4 (Offered)
 ;-- TOT_NUMR = Numerator Total for PM #4 (Received)
 ;
 ;-- 1st get previous FY info
 D GETYR^SPNPM2
 D CHKALL
 D CHKREG
 D CHKICD
 D GETDEN
 ;-- Get PM #2 Numerator
 D ^SPNPM4N
 ;-- Put PM #2 totals into SPNTXT array
 D SETTXT
EXIT K SPN
 K:$D(^TMP($J,"SPNPMDX")) ^("SPNPMDX")
 K:$D(^TMP($J,"SPNPM2")) ^("SPNPM2")
 K:$D(^TMP($J,"SPNPM4")) ^("SPNPM4")
 Q
CHKALL ;-- Check for existence of $D(^TMP($J,"SPNPM2","ALL_SCD")), create if necessary
 I $D(^TMP($J,"SPNPM2","ALL_SCD")) Q
 ;-- Otherwise create this temp global
 D GETALL^SPNPM2
 Q
CHKREG ;-- Check to see if Pt in ^TMP($J,"SPNPM2","ALL_SCD",DFN) is registered on or before End of Given FY AND is SCD-CURRENTLY SERVED
 ;-- Quit if '$D(^TMP($J,"SPNPM2","ALL_SCD"))
 Q:'$D(^TMP($J,"SPNPM2","ALL_SCD"))
 S (SPN("DFN"),SPN("TOT_CSREG"))=0
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","ALL_SCD",SPN("DFN"))) Q:'+SPN("DFN")  D
 .;-- Get Registration Date (REG_DT) and Regisration Status (REG_STAT) of DFN
 .S SPN("REG_DT")=$P($G(^SPNL(154,SPN("DFN"),0)),U,2),SPN("REG_STAT")=$P($G(^(0)),U,3)
 .;-- Quit if REG_DT is null
 .Q:'+SPN("REG_DT")
 .;-- Quit if REG_DT '< END_DT and REG_STAT '= 1 (1=SCD-CURRENTLY SERVED)
 .I SPN("REG_DT")>SPN("END_DT")!(SPN("REG_STAT")'=1) Q
 .;-- Okay then save to ^TMP($J,"SPNPM4","REGCS_FY",DFN) global
 .S ^TMP($J,"SPNPM4","REGCS_FY",SPN("DFN"))=SPN("REG_DT")_"^"_SPN("REG_STAT") S SPN("TOT_CSREG")=SPN("TOT_CSREG")+1
 .Q
 Q
CHKICD ;-- Check for the existence of ^TMP($J,"SPNPM2","TOT_ICD"), if not exist then create
 Q:$D(^TMP($J,"SPNPM2","TOT_ICD"))
 ;-- Okay then create this temp global
 D ^SPNPMDX,GETICD^SPNPM2B
 Q
GETDEN ;-- Get Denominator
 ;-- Check if Pt (DFN) is in both ^TMP($J,"SPNPM4","REGCS_FY") ^TMP($J,"SPNPM2","TOT_ICD") globals
 ;-- Quit if '$D(^TMP($J,"SPNPM2","ALL_SCD"))
 Q:'$D(^TMP($J,"SPNPM2","ALL_SCD"))
 ;-- Loop thru ^TMP($J,"SPNPM2","ALL_SCD",DFN) Pts, initialize Denominator counter (TOT_DEN)
 S (SPN("DFN"),SPN("TOT_DEN"))=0
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","ALL_SCD",SPN("DFN"))) Q:'+SPN("DFN")  D
 .I +$D(^TMP($J,"SPNPM4","REGCS_FY",SPN("DFN"))),+$D(^TMP($J,"SPNPM2","TOT_ICD",SPN("DFN"))) D
 ..;-- Count and collect the Denominator
 ..S SPN("TOT_DEN")=SPN("TOT_DEN")+1,^TMP($J,"SPNPM4","TOT_DENOM",SPN("DFN"))=""
 ..Q
 .Q
 Q
SETTXT ;-- Put PM #4 totals into SPNTXT array
 I $G(SPNPARM("SITE"))="" S SPNPARM("SITE")=$G(^DD("SITE"))
 S $P(SPNTXT(1),U,7)=0
 ;
 S $P(SPNTXT(1),U,1)=SPNPARM("SITE")
 ;
 ;   Program Measure #4 Denominator = SPN("TOT_DEN")
 S $P(SPNTXT(1),U,2)=SPN("TOT_DEN")
 ;
 ;   Program Measure #4 Numerator (Offered and Received) = SPN("TOT_NUM")
 S $P(SPNTXT(1),U,3)=SPN("TOT_NUM")
 ;
 ;   Program Measure #4 Numerator (Offered) = SPN("TOT_NUMO")
 S $P(SPNTXT(1),U,4)=SPN("TOT_NUMO")
 ;
 ;   Program Measure #4 Numerator (Received) = SPN("TOT_NUMR")
 S $P(SPNTXT(1),U,5)=SPN("TOT_NUMR")
 ;
 ;   Total SCD-R Pts Currently Served by End of FY =  SPN("TOT_CSREG")
 S $P(SPNTXT(1),U,6)=SPN("TOT_CSREG")
 ;
 ;   Total # ALL SCD-R Pts = SPN("TOT_CNT")
 S $P(SPNTXT(1),U,7)=SPN("TOT_CNT")
 ;
 S SPNDESC="Program Measure 4 "_^DD("SITE")
 D ^SPNMAIL
 Q
