SPNPM1N ;SD/AB-SCD PROGRAM MEASURE #1, GET THE NUMERATOR ;4/9/98
 ;;2.0;Spinal Cord Dysfunction;**6**;01/02/1997
MAIN ;-- Called from MAIN^SPNPM1
 ;-- This program will return PM #1 Numerator which is the number of people in the SCD-R who have a REGISTRATION STATUS of SCD-CURRENTLY SERVED by the end of FY 97 AND who have a Primary Care Provider entered in the SCD-R.
 D TMPLOOP
EXIT ;
 Q
TMPLOOP ;-- Loop thru ^TMP($J,"SPNPM1","DFN") and get total of all Pts who have a Primary Care Provider entered into the SCD-R file
 ;-- Quit if ^TMP global not found
 I '$D(^TMP($J,"SPNPM1","DFN")),'$D(^TMP($J,"SPNPMDX","SPNICD")) Q
 S (SPN("DFN"),SPN("TOT_PC"))=0
 F  S SPN("DFN")=$O(^TMP($J,"SPNPM1","DFN",SPN("DFN"))) Q:'+SPN("DFN")  D
 .D PCCHK I +SPN("PC_FLG") S SPN("TOT_PC")=SPN("TOT_PC")+1
 .Q
 Q
PCCHK ;-- Called from TMPLOOP, check to see if Pt has a PC Provider in file 154 (SCD-R file), and PC provider does NOT have a termination date in file 200, i.e. a valid provider
 ;-- Inititalize Primary Care Provider Flag (PC_FLG)=0, set to 1 if PC Prrovider found
 S SPN("PC_FLG")=0
 Q:'$D(^SPNL(154,SPN("DFN"),"CARE"))  ;-- Quit if no CARE node found
 I +$P($G(^SPNL(154,SPN("DFN"),"CARE")),U) D
 .S SPN("PROV#")=$P(^SPNL(154,SPN("DFN"),"CARE"),U) I SPN("PROV#")>0 D
 ..;-- Check for valid Provider 
 ..I +$D(^VA(200,SPN("PROV#"),0)) D
 ...;-- If valid PC Provider entered into SCD-R set PC_FLG=0
 ...I $P($G(^VA(200,SPN("PROV#"),0)),U,11)="" S SPN("PC_FLG")=1
 ...Q
 ..Q
 .Q
 Q
