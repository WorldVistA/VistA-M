SPNPM2N ;SD/AB-GET NUMERATOR FOR PM #2 ;4/9/98
 ;;2.0;Spinal Cord Dysfunction;**6**;01/02/1997
MAIN ;-- Called from MAIN^SPNPM2
 ;-- This program will get the NUMERATOR for Program Measure #2
 ;-- The program will loop thru the ^TMP($J,"SPNPM2","TOT_PTF",DFN) global which contains all SCD Pts who have PTF records associated with their SCD DATE OF ONSET in the SCD-R file
 ;-- The NUMERATOR count will be the number of these patients who have a least 2 FIM scores between the Admission Date and Discharge Date in the respective PTF record
 ;-- Quit if no ^TMP($J,"SPNPM2","TOT_PTF") global found
 ;  WDE/added the set below to take in-account for no global found
 S SPN("TOT_NUM")=0
 I '$D(^TMP($J,"SPNPM2","TOT_PTF")) D EXIT Q
 D LOOP
EXIT ;
 Q
LOOP ;-- Loop thru the ^TMP($J,"SPNPM2","TOT_PTF",DFN) global
 S (SPN("DFN"),SPN("TOT_NUM"))=0
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM2","TOT_PTF",SPN("DFN"))) Q:'+SPN("DFN")  D
 .;--Initialize Total # FIM counter (TOT_FIM)
 .S SPN("TOT_FIM")=0
 .;-- See if FIM data exists for this Pt, if so check FIM and Dates Recorded
 .I $D(^SPNL(154.1,"AA",2,SPN("DFN"))) D
 ..;-- Get Admission and D/C Dates
 ..S SPN("ADM_DT")=$P($G(^TMP($J,"SPNPM2","TOT_PTF",SPN("DFN"))),U),SPN("DC_DT")=$P($G(^(SPN("DFN"))),U,2)
 ..S SPN("FIM_DT")=0
 ..F  S SPN("FIM_DT")=$O(^SPNL(154.1,"AA",2,SPN("DFN"),SPN("FIM_DT"))) Q:'+SPN("FIM_DT")  D
 ...;-- Check to see if FIM Date is between Admission and D/C Dates, if not then quit
 ...I SPN("FIM_DT")<SPN("ADM_DT")&(SPN("FIM_DT")>SPN("DC_DT")) Q
 ...S SPN("FIM_IEN")=0
 ...F  S SPN("FIM_IEN")=$O(^SPNL(154.1,"AA",2,SPN("DFN"),SPN("FIM_DT"),SPN("FIM_IEN"))) Q:'+SPN("FIM_IEN")  D
 ....;-- Find out if Total FIM Score achieved, if so count as completed FIM score
 ....S SPN("TOT_SCORE")=$$EN3^SPNFUTL0(SPN("FIM_IEN"))
 ....I SPN("TOT_SCORE")'["ERR" S SPN("TOT_FIM")=SPN("TOT_FIM")+1
 ....Q
 ...Q
 ..Q
 .I SPN("TOT_FIM")>1 S SPN("TOT_NUM")=SPN("TOT_NUM")+1
 .Q
 Q
