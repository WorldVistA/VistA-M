SPNPM2D ;SD/AB-GET DENOMINATOR FOR PM #2 ;4/9/98
 ;;2.0;Spinal Cord Dysfunction;**6**;01/02/1997
MAIN ;-- Called from MAIN^SPNPM2
 ;-- Get ADMISSION DENOMINATOR for PM #2
 D GETDEN1
 ;-- Get DISCHARGE DENOMINATOR for PM #2
 D GETDEN2
 D GETADM
 D GETDIS
 D GETONS
 D GETICD
 D GETPTF ;-- THIS RETURNS PTF DENOMINATOR TOTAL FOR PM #2
EXIT ;
 Q
GETDEN1 ;-- Loop thru all Pts in ^TMP($J,"SPNPM2","ALL_SCD",DFN) and determine if Pt has admission during given FY, has DATE OF ONSET between 4/1/96 and 9/30/97, and has an SCI ICD-9 code in any PTF record
 ;-- Get ADMISSION DENOMINATOR (TOT_DENOM1) for PM #2
 ;-- Initalize SPN("DFN"), SPN("TOT_CNT"), and SPN("TOT_DENOM1") variables
 S (SPN("DFN"),SPN("TOT_CNT"),SPN("TOT_DENOM1"))=0
 ;-- Quit if '$D(^TMP($J,"SPNPM2","ALL_SCD"))
 Q:'$D(^TMP($J,"SPNPM2","ALL_SCD"))
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","ALL_SCD",SPN("DFN"))) Q:'+SPN("DFN")  D
 .S SPN("TOT_CNT")=SPN("TOT_CNT")+1
 .;-- Check to see if Pt is in "TOT_ADM", "TOT_ONSET", and "TOT_ICD" nodes of ^TMP($J,"SPNPM2") global
 .;-- If so then increment TOT_DENOM1 counter and store into ^TMP($J,"SPNPM2","DENOM1",DFN)
 .I $D(^TMP($J,"SPNPM2","TOT_ADM",SPN("DFN")))&($D(^TMP($J,"SPNPM2","TOT_ONSET",SPN("DFN"))))&($D(^TMP($J,"SPNPM2","TOT_ICD",SPN("DFN")))) D
 ..S SPN("TOT_DENOM1")=SPN("TOT_DENOM1")+1
 ..Q
 .Q
 Q
GETDEN2 ;-- Loop thru all Pts in ^TMP($J,"SPNPM2","ALL_SCD",DFN) and determine if Pt has discharge during given FY, has DATE OF ONSET between 4/1/96 and 9/30/97, and has an SCI ICD-9 code in any PTF record
 ;-- Get DISCHARGE DENOMINATOR (TOT_DENOM2) for PM #2
 ;-- Initalize SPN("DFN"), SPN("TOT_CNT"), and SPN("TOT_DENOM2") variables
 S (SPN("DFN"),SPN("TOT_CNT"),SPN("TOT_DENOM2"))=0
 ;-- Quit if '$D(^TMP($J,"SPNPM2","ALL_SCD"))
 Q:'$D(^TMP($J,"SPNPM2","ALL_SCD"))
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","ALL_SCD",SPN("DFN"))) Q:'+SPN("DFN")  D
 .S SPN("TOT_CNT")=SPN("TOT_CNT")+1
 .;-- Check to see if Pt is in "TOT_DIS", "TOT_ONSET", and "TOT_ICD" nodes of ^TMP($J,"SPNPM2") global
 .;-- If so then increment TOT_DENOM2 counter and store into ^TMP($J,"SPNPM2","DENOM2",DFN)
 .I $D(^TMP($J,"SPNPM2","TOT_DIS",SPN("DFN")))&($D(^TMP($J,"SPNPM2","TOT_ONSET",SPN("DFN"))))&($D(^TMP($J,"SPNPM2","TOT_ICD",SPN("DFN")))) D
 ..S SPN("TOT_DENOM2")=SPN("TOT_DENOM2")+1
 ..Q
 .Q
 Q
GETADM ;-- Get total count for ^TMP($J,"SPNPM2","TOT_ADM",DFN) nodes
 S (SPN("DFN"),SPN("TOT_ADM"))=0
 ;-- Quit if '$D(^TMP($J,"SPNPM2","TOT_ADM"))
 Q:'$D(^TMP($J,"SPNPM2","TOT_ADM"))
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","TOT_ADM",SPN("DFN"))) Q:'+SPN("DFN")  D
 .S SPN("TOT_ADM")=SPN("TOT_ADM")+1
 .Q
 Q
GETDIS ;-- Get total count for ^TMP($J,"SPNPM2","TOT_DIS",DFN) nodes
 S (SPN("DFN"),SPN("TOT_DIS"))=0
 ;-- Quit if '$D(^TMP($J,"SPNPM2","TOT_DIS"))
 Q:'$D(^TMP($J,"SPNPM2","TOT_DIS"))
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","TOT_DIS",SPN("DFN"))) Q:'+SPN("DFN")  D
 .S SPN("TOT_DIS")=SPN("TOT_DIS")+1
 .Q
 Q
GETONS ;-- Get total count for ^TMP($J,"SPNPM2","TOT_ONSET",DFN) nodes
 S (SPN("DFN"),SPN("TOT_ONSET"))=0
 ;-- Quit if '$D(^TMP($J,"SPNPM2","TOT_ONSET"))
 Q:'$D(^TMP($J,"SPNPM2","TOT_ONSET"))
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","TOT_ONSET",SPN("DFN"))) Q:'+SPN("DFN")  D
 .S SPN("TOT_ONSET")=SPN("TOT_ONSET")+1
 .Q
 Q
GETICD ;-- Get total count for ^TMP($J,"SPNPM2","TOT_ICD",DFN) nodes
 S (SPN("DFN"),SPN("TOT_ICD"))=0
 ;-- Quit if '$D(^TMP($J,"SPNPM2","TOT_ICD"))
 Q:'$D(^TMP($J,"SPNPM2","TOT_ICD"))
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","TOT_ICD",SPN("DFN"))) Q:'+SPN("DFN")  D
 .S SPN("TOT_ICD")=SPN("TOT_ICD")+1
 .Q
 Q
GETPTF ;-- Get total count for ^TMP($J,"SPNPM2","TOT_PTF",DFN) nodes - THIS IS DENOMINATOR FOR PM #2!
 S (SPN("DFN"),SPN("TOT_PTF"))=0
 ;-- Quit if '$D(^TMP($J,"SPNPM2","TOT_PTF"))
 Q:'$D(^TMP($J,"SPNPM2","TOT_PTF"))
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","TOT_PTF",SPN("DFN"))) Q:'+SPN("DFN")  D
 .S SPN("TOT_PTF")=SPN("TOT_PTF")+1
 .Q
 Q
