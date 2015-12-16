DGPT50MS ;ALB/MTC,HIOFO/FT - 501 Edits Cont ;1/26/15 4:18pm
 ;;5.3;Registration;**142,729,884**;Aug 13, 1993;Build 31
 ;
 ;no external references
 ;
 ; Edits for legionnaire's, suicide, drug and psych indicators
 ;
LEG ;legionnaire's indicator
 ;this code was commented out prior to DG*5.3*884. ft 10/30/14
 ;I ((+DGPTMD1=482.8)!(+DGPTMD2=482.8)!(+DGPTMD3=482.8)!(+DGPTMD3=482.8)!(+DGPTMD4=482.8)!(+DGPTMD5=482.8))&("12"'[DGPTMLG) S DGPTERC=531 Q
 Q
SUI ;suicide indicator
 ; -- 850 - aas - hard coded ICD codes
 ; -- Suicide Category is inactive JUL 1,2006
 Q:DGPTFMT=3  ;DGPTMSU is not sent with ICD10. ft 10/30/14
 N I,DGINACT
 S DGPTMSX=0
 I DGPTFMT=2 F I=1:1:5 I ($E(@("DGPTMD"_I),1,3)="E95")&("012345678"[$E(@("DGPTMD"_I),4)) S DGPTMSX=1 Q:DGPTMSX
 Q:'DGPTMSX
 I '$D(DGSCDT) D DC
 S DGINACT=$$GET1^DIQ(45.88,"2,",.03,"I")
 I DGINACT]"",$D(DGSCDT) Q:DGSCDT>DGINACT
 I "123"'[DGPTMSU S DGPTERC=532 Q
 Q
DRUG ;drug/substance abuse
 ; -- 850 - aas - hard coded ICD codes
 ; -- Substance Abuse Category is inactive JUL 1,2006
 Q:DGPTFMT=3  ;DGPTMDG is no longer set with new record layout when ICD10 is turned on, post DG*5.3*883. ft 10/30/14
 I DGPTFMT=2 D  ;should be 4 spaces per DG*5.3*683. ft 10/30/14
 .I DGPTMDG'?4" " S DGPTERC=533 Q
 ;N I,DGINACT
 ;S DGPTMSX=0
 ;I DGPTFMT=2 F I=1:1:5 I ($E(@("DGPTMD"_I),1,4)="304.")&("013456"[$E(@("DGPTMD"_I),5))&("0123"[$E(@("DGPTMD"_I),6)) S DGPTMSX=1 Q:DGPTMSX
 ;G:DGPTMSX DRG1
 ;I DGPTFMT=2 F I=1:1:5 I ($E(@("DGPTMD"_I),1,4)="305.")&("234579"[$E(@("DGPTMD"_I),5))&("0123"[$E(@("DGPTMD"_I),6)) S DGPTMSX=1 Q:DGPTMSX
DRG1 ;
 ;Q:'DGPTMSX
 ;I '$D(DGSCDT) D DC
 ;S DGINACT=$$GET1^DIQ(45.88,"4,",.03,"I")
 ;I DGINACT]"",$D(DGSCDT) Q:DGSCDT>DGINACT
 ;I DGPTMDG'?1A3N S DGPTERC=533 Q
 ;I $E(DGPTMDG,1)'="A" S DGPTERC=533 Q
 ;I ($E(DGPTMDG,2,4))<1!($E(DGPTMDG,2,4)>18) S DGPTERC=533 Q
 Q
AXIV ;psychiatry axis iv code
 Q:DGPTFMT=3  ;this field is inactive when ICD10 becomes active. ft 10/30/14
 N I
 S DGPTMSX=0 F I=1:1:5 I ($E(@("DGPTMD"_I),1,3)'<290)&($E(@("DGPTMD"_I),1,3)<320) S DGPTMSX=1 Q:DGPTMSX
 Q:'DGPTMSX
 I "0123456"'[DGPTMXIV S DGPTERC=534 Q
 Q
AXV1 ;psychiatry axis v code
 Q:DGPTFMT=3  ;this field is inactive when ICD10 becomes active. ft 10/30/14
 Q:'DGPTMSX
 I (DGPTMXV1<1)!(DGPTMXV1>90) S DGPTERC=535 Q
 Q
AXV2 ;psychiatry axis v code
 Q:DGPTFMT=3  ;this field is inactive when ICD10 becomes active. ft 10/30/14
 Q:'DGPTMSX
 Q:DGPTMXV2="  "
 I (DGPTMXV2<1)!(DGPTMXV2>90) S DGPTERC=535 Q
 Q
SRVC ;service indicator
 I " 12"'[DGPT50SR S DGPTERC=530
 Q
APSSN ;attending physician ssn
 ;new field with new 501 record layout in DG*5.3*884. ft (10/30/14)
 I (DGPTAPSSN'?9" ")&(DGPTAPSSN'?9N) S DGPTERC=501
 Q
DC ;get discharge date
 S DGSCDT=$S('$D(^DGPT(PTF,70)):DT,^(70):+^(70),1:DT)
 Q
