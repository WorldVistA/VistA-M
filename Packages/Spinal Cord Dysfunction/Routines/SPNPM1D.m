SPNPM1D ;SD/AB-PROGRAM MEASURE #1 - GET THE DENOMINATOR ;4/9/98
 ;;2.0;Spinal Cord Dysfunction;**6**;01/02/1997
MAIN ;-- Called from MAIN^SPNPM1
 ;-- This will get the denominator of PM #1 which is the number of SCD-R who have a REGISTRATION STATUS of SCD - CURRENTLY served by the end of FY 97 AND who have any of the given SCI ICD9 codes in the PTF file (for any date)
 ;-- Note: PTF file (#45) goes back to 1977, although regular use of PTF was from 1984 to present
 D TMPLOOP
EXIT ;
 Q
TMPLOOP ;-- Loop thru ^TMP($,"SPNPM1","DFN") and get total of all Pts who have a PTF SCI ICD-9 code (from any Transmitted PTF record)
 ;-- Quit if ^TMP global not found
 I '$D(^TMP($J,"SPNPM1","DFN")),'$D(^TMP($J,"SPNPMDX","SPNICD")) Q
 S (SPN("DFN"),SPN("TOT_NO_PTF"),SPN("TOT_NO_ICD"),SPN("TOT_PTF"),SPN("TOT_ICD"))=0
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM1","DFN",SPN("DFN"))) Q:'+SPN("DFN")  D
 .;-- Quit if NO PTF records for this patient, but 1st increment TOT_NO_PTF record counter
 .I '+$D(^DGPT("B",SPN("DFN"))) S SPN("TOT_NO_PTF")=SPN("TOT_NO_PTF")+1 Q
 .;-- Check every PTF record for this Pt for any SCI ICD-9 codes
 .D CHKPTF
 .;-- If ICD_FLG=1 (SCD Pt has PTF record /w SCI ICD-9 code) increment TOT-PTF counter 
 .I +SPN("ICD_FLG") S SPN("TOT_PTF")=SPN("TOT_PTF")+1
 .;-- Else increment TOT_NO_ICD counter
 .E  S SPN("TOT_NO_ICD")=SPN("TOT_NO_ICD")+1
 .Q
 Q
CHKPTF ;-- Called from TMPLOOP, check all Transmitted PTF records for this patient to see if any contain SCI ICD-9 codes
 S (SPN("PTF_IEN"),SPN("ICD_FLG"))=0
 F  S SPN("PTF_IEN")=$O(^DGPT("B",SPN("DFN"),SPN("PTF_IEN"))) Q:'+SPN("PTF_IEN")!(+SPN("ICD_FLG"))  D
 .;-- Quit if PTF record doesn't have STATUS=3 (Transmitted) or TYPE OF RECORD'=1 (PTF)
 .Q:$P($G(^DGPT(SPN("PTF_IEN"),0)),U,6)'=3!($P($G(^DGPT(SPN("PTF_IEN"),0)),U,11)'=1)
 .;-- Look for SCI Dx codes
 .D CHKICD ;-- If SCI ICD-9 code found set flag (ICD_FLG=1)
 .Q
 Q
CHKICD ;-- Called from CHKPTF, check for matching SCI ICD-9 codes (in ICD temp global)
 F SPN("PIECE")=10,11,16,17,18,19,20,21,22,23,24 D  Q:+SPN("ICD_FLG")
 .S SPN("ICDPT")=$P($G(^DGPT(SPN("PTF_IEN"),70)),U,SPN("PIECE"))
 .I +SPN("ICDPT"),$D(^TMP($J,"SPNPMDX","SPNICD",SPN("ICDPT"))) S SPN("ICD_FLG")=1
 .Q
 Q
