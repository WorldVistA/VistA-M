SPNPM2C ;SD/AB,WDE-PRINT RESULTS OF PROGRAM MEASURE #2 ;5/28/98
 ;;2.0;Spinal Cord Dysfunction;**6,8**;01/02/1997
MAIN ;-- Called from MAIN^SPNPM2C
 D SETTXT
EXIT ;
 Q
SETTXT ;-- Put PM #2 totals into SPNTXT array
 I $G(SPNPARM("SITE"))="" S SPNPARM("SITE")=$G(^DD("SITE"))
 S $P(SPNTXT(1),U,10)=""
 S $P(SPNTXT(1),U,1)=SPNPARM("SITE")
 ;
 ;    Program Measure #2 Denominator = SPN("TOT_PTF")
 S $P(SPNTXT(1),U,2)=SPN("TOT_PTF")
 ;
 ;    Program Measure #2 Numerator = SPN("TOT_NUM")
 S $P(SPNTXT(1),U,3)=SPN("TOT_NUM")
 ;
 ;    Total # (Denominator) based on FY admissions = SPN("TOT_DENOM1")
 S $P(SPNTXT(1),U,4)=SPN("TOT_DENOM1")
 ;
 ;    Total # (Denominator) based on FY discharges = SPN("TOT_DENOM2")
 S $P(SPNTXT(1),U,5)=SPN("TOT_DENOM2")
 ;
 ;    Total SCD Pts /w FY Admissions= SPN("TOT_ADM")
 S $P(SPNTXT(1),U,6)=SPN("TOT_ADM")
 ;
 ;    Total SCD Pts /w FY Discharges = SPN("TOT_DIS")
 S $P(SPNTXT(1),U,7)=SPN("TOT_DIS")
 ;
 ;    Total SCD Pts /w SCD Onset Date^"
 ;    Between "_$$DTCONV(SPN("ONSET_DT"))
 ;    &  $$DTCONV(SPN("END_DT"))  SPN("TOT_ONSET")
 S $P(SPNTXT(1),U,8)=SPN("TOT_ONSET")
 ;
 ;    Total SCD Pts /w any SCI Transmitted PTF/ICD9
 ;     codes =  SPN("TOT_ICD")
 S $P(SPNTXT(1),U,9)=SPN("TOT_ICD")
 ;
 ;    Total ALL SCD Pts = SPN("TOT_CNT")
 S $P(SPNTXT(1),U,10)=SPN("TOT_CNT")
 ;
 S SPNDESC="Program measure 2 for "_^DD("SITE")
 D ^SPNMAIL
 Q
DTCONV(X) ;-- Function to convert FM dates to human-readable format
 S X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q X
