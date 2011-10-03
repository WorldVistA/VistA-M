SPNPM1 ;SD/AB,WDE-PROGRAM MEASURE #1 ;5/28/98
 ;;2.0;Spinal cord Dysfunction;**6,8**;01/02/1997
MAIN ;-- This programs main purpose is to retrieve the number of SCD Pts who are SCD-CURRENTLY SERVED by the end of Previous FY and who have any SCI ICD-9 code in a Transmitted PTF record (DENOMINATOR)
 ;-- It also gets the number of SCD-CURRENTLY SERVED Pts (CS by the end of Previous FY) who also have a Primary Care Provider entered into the respective SCD-R records (NUMERATOR)
 ;-- Variable array (SPN) list:
 ;-- DFN = DFN
 ;-- END# = Ending ICD-9 code
 ;-- END_DT = FM-format Ending Date (Last Day of FY)
 ;-- FY = FY (2-digit) used for data calculations
 ;-- I = As FOR Loop parameter for get range of ICD-9 codes
 ;-- ICD_FLG = ICD FLAG (set to 1 if SCI ICD-9 code found)
 ;-- ICD_IEN = IEN in ^ICD9( global
 ;-- ICDPT = SCI ICD-9 Pointer in ^TMP($J,"SPNPMDX","SPNICD") global
 ;-- PC_FLG = Primary Care flag (set to 1 if PC Provider found in SCD-R record)
 ;-- PIECE = Piece containing ICD-9 pointers in ^DGPT(PTF_IEN,70)
 ;-- PROV# = Provider pointer to ^VA(200)
 ;-- PTF_IEN = PTF IEN
 ;-- REG_DT = SCD-R REGISTRATION DATE
 ;-- REG_STAT = SCD-R REGISTRATION STATUS
 ;-- ST# = Starting ICD-9 code
 ;-- TOT_CSREG = Total # SCD CS Pts Registered by end of FY
 ;-- TOT_NO_ICD = Total # SCD CS Pts Registered by end of FY w/o matching SCI ICD-9 codes in any Transmitted PTF record
 ;-- TOT_NO_PTF = Total # SCD CS Pts Registered by end of FY w/o any PTF record
 ;-- TOT_PC = Total # SCD CS Pts Registered by end of FY with PC Provider entered into SCD-R
 ;-- TOT_PTF = Total # SCD CS Pts Registered by end of FY with matching SCI ICD-9 codes in any Transmitted PTF record
 ;-- TOT_PTS = Grand Total of ALL SCD Pts in SCD-R
 K:$D(^TMP($J)) ^($J)
 D GETYR
 D GETSCD
 ;-- Get SCI ICD-9 codes
 D ^SPNPMDX
 ;-- Get DENOMINATOR of PM #1
 D ^SPNPM1D
 ;-- Get NUMERATOR of PM #1
 D ^SPNPM1N
 ;-- Put PM #1 totals into SPNTXT array
 D SETTXT
EXIT K SPN
 K:$D(^TMP($J)) ^($J)
 Q
GETYR ;-- Get FY for previous FY, and set Ending Date (END_DT) to FM FY_0930
 I +$E($G(DT),4,7)<931 S SPN("FY")=$E($G(DT),1,3)-1
 E  S SPN("FY")=$E($G(DT),1,3)
 S SPN("END_DT")=+SPN("FY")_"0930"
 Q
GETSCD ;-- Loop thru SCD Registry file (^SPNL(154)) and get all SCD Pts who are Registered and Curr Served (CS) by end of Previous FY
 S (SPN("DFN"),SPN("TOT_CSREG"),SPN("TOT_PTS"))=0
 F  S SPN("DFN")=$O(^SPNL(154,SPN("DFN"))) Q:'+SPN("DFN")  D
 .;-- Quit if no zero node
 .Q:'$D(^SPNL(154,SPN("DFN"),0))
 .;-- Increment Total # SCD Pts (TOT_PTS)
 .S SPN("TOT_PTS")=SPN("TOT_PTS")+1
 .S SPN("REG_DT")=$P($G(^SPNL(154,SPN("DFN"),0)),U,2),SPN("REG_STAT")=$P($G(^(0)),U,3)
 .;-- Quit if REG_DT null
 .Q:'+SPN("REG_DT")
 .;-- Quit if REG_DT '< END_DT and/or REG_STAT '=1 (SCD-Curr Served)
 .I SPN("REG_DT")>SPN("END_DT")!(SPN("REG_STAT")'=1) Q
 .;-- Okay, then save to ^TMP global
 .S ^TMP($J,"SPNPM1","DFN",SPN("DFN"))="" S SPN("TOT_CSREG")=SPN("TOT_CSREG")+1
 .Q
 Q
SETTXT ;-- Set up SPNTXT message text array
 I $G(SPNPARM("SITE"))="" S SPNPARM("SITE")=$G(^DD("SITE"))
 S $P(SPNTXT(1),U,7)=""
 S $P(SPNTXT(1),U,1)=SPNPARM("SITE")
 ;
 ;  Total # of CS SCD-R Pts Registered by End of FY with matching
 ;   SCI ICD-9 codes in any Transmitted PTF Record = SPN("TOT_PTF")
 ;  *** This is PM #1 DENOMINATOR ***
 S $P(SPNTXT(1),U,2)=SPN("TOT_PTF")
 ;
 ;  Total # of All SCD-R Pts /w PC Provider Entered into
 ;   SCD-R = SPN("TOT_PC")
 ;  *** This is PM #1 NUMERATOR ***
 S $P(SPNTXT(1),U,3)=SPN("TOT_PC")
 ;
 ;  Total # of SCD-R Pts Registered by End of FY  w/o^ matching SCI 
 ;  ICD-9 codes in any Transmitted PTF Record = SPN("TOT_NO_ICD")
 S $P(SPNTXT(1),U,4)=SPN("TOT_NO_ICD")
 ;
 ;  Total CS SCD-R Pts Registered by End of FY  w/o any 
 ;  PTF record = SPN("TOT_NO_PTF")
 S $P(SPNTXT(1),U,5)=SPN("TOT_NO_PTF")
 ;
 ;  Total # of CS SCD-R Pts Registered by End of FY = SPN("TOT_CSREG")
 S $P(SPNTXT(1),U,6)=SPN("TOT_CSREG")
 ;
 ;  Total # of All SCD-R Pts  = SPN("TOT_PTS")
 S $P(SPNTXT(1),U,7)=SPN("TOT_PTS")
 ;
 S SPNDESC="Program Measure 1 "_$G(^DD("SITE"))
 D ^SPNMAIL
 Q
