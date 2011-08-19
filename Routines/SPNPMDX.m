SPNPMDX ;SD/AB-GET SCI ICD9 CODES FOR 344.0x, 344.1, 806.xx, 907.2, 952.xx ;4/17/98
 ;;2.0;Spinal Cord Dysfunction;**6,25**;01/02/1997;Build 2
MAIN ;-- Called by ^SPNPM1, ^SPNPM2B, & ^SPNPM4 (Program Measures routines)
 K:$D(^TMP($J,"SPNPMDX","SPNICD")) ^("SPNICD")
 D GETICD
EXIT ;
 Q
GETICD ;-- For hardcoded range (start and end #s) collect all ICD codes and store into ^TMP($J,"SPNPMDX","SCNICD") global
 ;-- Create temporary storage for all ICD codes in the range:
 ;-- 344.00 thru 344.09
 S SPN("ST#")=343.99
 S SPN("END#")=344.09
 F SPN("I")=SPN("ST#"):.01:SPN("END#") D
 .I $D(^ICD9("BA",SPN("I"))) D
 ..;-- Get IEN in ICD9 global (file 80)
 ..S SPN("ICD_IEN")=0
 ..F  S SPN("ICD_IEN")=$O(^ICD9("BA",SPN("I"),SPN("ICD_IEN"))) Q:'+SPN("ICD_IEN")  D
 ...;-- Now set temp global
 ...S ^TMP($J,"SPNPMDX","SPNICD",SPN("ICD_IEN"))=$P($$ICDDX^ICDCODE(SPN("ICD_IEN")),"^",2)
 ...Q
 ..Q
 .Q
 ;-- Create temporary storage for ICD codes:
 ;-- 344.1 and 907.2
 F SPN("I")=344.1,907.2 D
 .I $D(^ICD9("BA",SPN("I"))) D
 ..;-- Get IEN in ICD9 global (file 80)
 ..S SPN("ICD_IEN")=$O(^ICD9("BA",SPN("I"),0))
 ..;-- Now set temp global
 ..S ^TMP($J,"SPNPMDX","SPNICD",SPN("ICD_IEN"))=$P($$ICDDX^ICDCODE(SPN("ICD_IEN")),"^",2)
 ..Q
 .Q
 ;-- Create temporary storage for all ICD codes in the range:
 ;-- 806.00 thru 806.99
 S SPN("ST#")=805.99
 S SPN("END#")=806.99
 F SPN("I")=SPN("ST#"):.01:SPN("END#") D
 .I $D(^ICD9("BA",SPN("I"))) D
 ..;-- Get IEN in ICD9 global (file 80)
 ..S SPN("ICD_IEN")=0
 ..F  S SPN("ICD_IEN")=$O(^ICD9("BA",SPN("I"),SPN("ICD_IEN"))) Q:'+SPN("ICD_IEN")  D
 ...;-- Now set temp global
 ...S ^TMP($J,"SPNPMDX","SPNICD",SPN("ICD_IEN"))=$P($$ICDDX^ICDCODE(SPN("ICD_IEN")),"^",2)
 ...Q
 ..Q
 .Q
 ;-- Create temporary storage for all ICD codes in the range:
 ;-- 952.00 thru 952.99
 S SPN("ST#")=951.99
 S SPN("END#")=952.99
 F SPN("I")=SPN("ST#"):.01:SPN("END#") D
 .I $D(^ICD9("BA",SPN("I"))) D
 ..;-- Get IEN in ICD9 global (file 80)
 ..S SPN("ICD_IEN")=0
 ..F  S SPN("ICD_IEN")=$O(^ICD9("BA",SPN("I"),SPN("ICD_IEN"))) Q:'+SPN("ICD_IEN")  D
 ...;-- Now set temp global
 ...S ^TMP($J,"SPNPMDX","SPNICD",SPN("ICD_IEN"))=$P($$ICDDX^ICDCODE(SPN("ICD_IEN")),"^",2)
 ...Q
 ..Q
 .Q
 Q
