SPNPM2B ;SD/AB-PROGRAM MEASURE #2 (CONTINUATION) ;4/9/98
 ;;2.0;Spinal Cord Dysfunction;**6**;01/02/1997
MAIN ;-- Called by MAIN^SPNPM2
 D ^SPNPMDX ;-- Collect SCI ICD-9 codes
 D GETPTF
 D GETICD
EXIT ;
 Q
GETPTF ;-- Get all Pts in ^TMP($J,"SPNPM2","TOT_ONSET",DFN) who have a PTF Admission Date on or after Date of Onset but before END_DT (End Date of FY)
 Q:'$D(^TMP($J,"SPNPM2","TOT_ONSET"))
 S SPN("DFN")=0
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","TOT_ONSET",SPN("DFN"))) Q:'+SPN("DFN")  D
 .S SPN("ONS_DT")=^TMP($J,"SPNPM2","TOT_ONSET",SPN("DFN"))
 .Q:'$D(^DGPT("B",SPN("DFN")))
 .S (SPN("PTF_IEN"),SPN("PTF_FLG"))=0
 .F  S SPN("PTF_IEN")=$O(^DGPT("B",SPN("DFN"),SPN("PTF_IEN"))) Q:'+SPN("PTF_IEN")!(+SPN("PTF_FLG"))  D
 ..;-- Set PTF Admission Date (PTF_ADMDT) and Discharge Date (PTF_DCDT)
 ..S SPN("PTF_ADMDT")=$P($G(^DGPT(SPN("PTF_IEN"),0)),U,2),SPN("PTF_DCDT")=$P($G(^DGPT(SPN("PTF_IEN"),70)),U)
 ..Q:'+SPN("PTF_ADMDT")
 ..;-- check to see if PTF Admission Date is on or after Date of Onset and before SPN("END_DT")
 ..I SPN("PTF_ADMDT")'<SPN("ONS_DT")&(SPN("PTF_ADMDT")'>SPN("END_DT")) D
 ...;-- Okay, now check to make sure PTF record indicates a SCI/D Dx. quit otherwise
 ...S SPN("ICD_FLG")=0 D CHKICD I +SPN("ICD_FLG") D
 ....;-- Now make sure PTF Record has been Transmitted and Type=PTF, quit otherwise
 ....I $P($G(^DGPT(SPN("PTF_IEN"),0)),U,6)'=3&($P($G(^(0)),U,11)'=1) Q
 ....;-- Okay, then set into ^TMP($J,"SPNPM2","TOT_PTF",DFN)
 ....S ^TMP($J,"SPNPM2","TOT_PTF",SPN("DFN"))=SPN("PTF_ADMDT")_"^"_SPN("PTF_DCDT")_"^"_SPN("ONS_DT")_"^"_SPN("PTF_IEN") S SPN("PTF_FLG")=1 ;W "P"
 ....Q
 ...Q
 ..Q
 .Q
 Q
GETICD ;-- Get all SCD pts who have any ICD-9 codes in any PTF record
 ;-- Store into ^TMP($J,"SPNPM2","TOT_ICD",DFN) global
 ;-- Quit if '$D(^TMP($J,"SPNPM2","ALL_SCD"))
 Q:'$D(^TMP($J,"SPNPM2","ALL_SCD"))
 ;-- Inititalze SPN("DFN")
 S SPN("DFN")=0
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","ALL_SCD",SPN("DFN"))) Q:'+SPN("DFN")  D
 .;-- Quit if no PTF record found for this Pt
 .Q:'$D(^DGPT("B",SPN("DFN")))
 .;-- Check every PTF record for this Pt for any SCI ICD-9 codes
 .D CHKPTF
 .Q
 Q
CHKPTF ;-- Called from GETICD, check all Transmitted PTF records for this patient to see if any contain SCI ICD-9 codes
 S SPN("PTF_IEN")=0,SPN("ICD_FLG")=0
 F  S SPN("PTF_IEN")=$O(^DGPT("B",SPN("DFN"),SPN("PTF_IEN"))) Q:'+SPN("PTF_IEN")!(+SPN("ICD_FLG"))  D
 .;-- Quit if PTF record doesn't have STATUS=3 (Transmitted) or TYPE OF RECORD'=1 (PTF)
 .I $P($G(^DGPT(SPN("PTF_IEN"),0)),U,6)'=3!($P($G(^(0)),U,11)'=1) Q
 .;-- Look for SCI Dx codes, if SCI ICD-9 code found set flag (ICD_FLG=1)
 .D CHKICD
 .;-- If ICD_FLAG set to 1 then store into ^TMP($J,"SPNPM2","TOT_ICD",DFN) global
 .I +$G(SPN("ICD_FLG")) S ^TMP($J,"SPNPM2","TOT_ICD",SPN("DFN"))="" ;W "I"
 .Q
 Q
CHKICD ;-- Called from GETPTF and CHKPTF, check for matching SCI ICD-9 codes (in ICD temp global)
 ;-- If SCI ICD-9 code found then set flag (ICD_FLG=1)
 F SPN("PIECE")=10,11,16,17,18,19,20,21,22,23,24 D  Q:+SPN("ICD_FLG")
 .S SPN("ICDPT")=$P($G(^DGPT(SPN("PTF_IEN"),70)),U,SPN("PIECE"))
 .I +SPN("ICDPT"),$D(^TMP($J,"SPNPMDX","SPNICD",SPN("ICDPT"))) S SPN("ICD_FLG")=1
 .Q
 Q
