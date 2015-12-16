DGPTAE02 ;ALB/MTC,HIOFO/FT - 701 Edit Checks ;3/12/15 1:51pm
 ;;5.3;Registration;**8,22,39,114,176,251,247,270,446,418,482,466,683,729,884**;Aug 13, 1993;Build 31
 ;10/06/1999 ACS - Added Place of Disposition codes M,Y,Z to the
 ;validity checks
 ;5/15/2000 ACS - Added Treating Specialty 37 as a valid code
 ;5/16/2000 MM  - Added Treating Specialties 38 & 39 as valid codes
 ;5/26/2000 JRP - Place of Disposition code M valid for station
 ;                types 10, 11, 30, and 40
 ;09/27/2006 JRC - Added Treating Specialties 13, 30, 48, 49, 78,
 ;                 82 and 97
 ;
CHECK ;
 I (DGPTSP1'?1AN)!(DGPTSP2'?1AN) S DGPTERC=1 Q
 I DGPTSP1="0"&((DGPTSP2'?1AN)!(DGPTSP2="0")) S DGPTERC=1 G EXIT
 ; No zero or double zeroes allowed
 I DGPTSP1=5 G EXIT
 ; All codes 50-59 allowable
 ; New code 95:p-418
 ; New code 96;p-446
EXIT ;
 K DGPTSP1,DGPTSP2
 Q
 ;
DISPTY ;
 N I
 S DGPTERC=0
 Q:"1"[DGPTDTY
 I DGPTDTY=2 S DGPTERC=707 F I=10,11,30,40,42 I DGPTSTTY["^"_I_"^" S DGPTERC=0 Q
 I DGPTERC Q
 ;
 ;-- if dis type = To Non-Bed Care then VA aus and Out pat = no
 ;I DGPTDTY=2,((DGPTDVA'=2)!(DGPTDOP'=3)) S DGPTERC=707 Q
 ;
 I DGPTDTY=3&(DGPTSTTY'["^42^") S DGPTERC=707 Q
 ;-- if dis type = Transfer then Out pat cannot be yes
 I DGPTDTY=5,DGPTDOP=1 S DGPTERC=707
 ;-- if dis type = Transfer then Out pat cannot be yes, rec sta'=""
 I DGPTDTY=5,DGPTDOP'=1,'DGPTDRF S DGPTERC=711 Q
 ;-- if dis type irr, death w/aotopsy then va asp, op care, pod = ""
 I "467"[DGPTDTY,(DGPTDOP!DGPTDVA!DGPTDPD) S DGPTERC=707 Q
 Q
OP ;
 Q:"13"'[DGPTDOP
 S DGPTERC=708 F I=10,11,40,42 I DGPTSTTY["^"_I_"^" S DGPTERC=0 Q
 Q
POD ;place of disposition
 N I
 Q:"X012347BCDFGHJKL "[DGPTDPD
 ; if POD NHCU then Out=no VA aus=yes
 I DGPTDPD=5,((DGPTDOP'=3)!(DGPTDVA'=1)) S DGPTERC=710 Q
 ; if POD NHCU then Out=no VA aus=yes, rec station'=""
 I DGPTDPD=5,DGPTDOP=3,DGPTDVA=1,'DGPTDRF S DGPTERC=711 Q
 I "PR"[DGPTDPD,((DGPTSTTY'["^10^")!(DGPTSTTY'["^11^")) S DGPTERC=710 Q
 I DGPTDPD="M" S DGPTERC=710 F I=10,11,30,40 I DGPTSTTY["^"_I_"^" S DGPTERC=0 Q
 I DGPTDPD="T" S DGPTERC=710 F I=10,11,40 I DGPTSTTY["^"_I_"^" S DGPTERC=0 Q
 I "UYZ"[DGPTDPD S DGPTERC=710 F I=10,11,20:1:27,30,40:1:42 I DGPTSTTY["^"_I_"^" S DGPTERC=0 Q
 Q
LEAVE ;
 S DGPTLVDY=0
 S DGPTL3=0 F  S DGPTL3=$O(^TMP("AEDIT",$J,"N501",DGPTL3)) Q:DGPTL3=""  S DGPTLVDY=DGPTLVDY+$E(^TMP("AEDIT",$J,"N501",DGPTL3),49,51)+$E(^TMP("AEDIT",$J,"N501",DGPTL3),52,54)
 I (DGPTLVDY+DGPTDAS)>DGPTELP S DGPTERC=745
 K DGPTL3,DGPTLVDY
 Q
 ;
CANDP ;compensation and pension status
 I "12345678"'[DGPTDCP S DGPTERC=714 Q
 ;-- if no POS then no edit
 Q:DGPTPOS2=9
 ;-- if WWI then no edit
 Q:DGPTPOS2=1
 ;-- if POW then no edit
 I $L(DGPTPOW)=1,("23456789AB"[DGPTPOW) Q
 D CONSIS Q:DGPTERC
 D STATYP Q:DGPTERC
 D CPMT Q:DGPTERC
 Q
CONSIS ;
 I ("01234578X"[DGPTPOS2)&("1234567"'[DGPTDCP) S DGPTERC=736 Q
 I ("ABCD"[DGPTPOS2) Q
 I DGPTPOS2="Z"&("1234567"'[DGPTDCP) S DGPTERC=736 Q
 Q:"012345678ABCDXZ"[DGPTPOS2
 S:DGPTDCP'=8 DGPTERC=736
 Q
STATYP ;
 Q:(DGPTSTTY["^30^")!(DGPTSTTY="^")!(DGPTSTTY="")
 ;Note: There is not sufficient information contained in the
 ;station type to adequately perform the error check of Means Test
 ;indicator vs admissions date.  This issue should be revisited in 5.4.
 ;For now, error code 143 (previously set as 744) will not be checked
 ;in order to be sure that an error is not erroneously generated.
 Q
MT ;means test
 I DGPTMTC="X "&((+DGPTDTS)'<2860701) S DGPTERC=143 Q
 Q:DGPTMTC="X "
 I DGPTDTS<2860701 S DGPTERC=143 Q
 Q
 ;
CPMT ;-- mt and c&p checks
 I DGPTMTC="N ",DGPTDCP'=8 S DGPTERC=753 Q
 I DGPTMTC="AN","24567"'[DGPTDCP S DGPTERC=753 Q
 I ((DGPTMTC="B ")!(DGPTMTC="C ")!(DGPTMTC="G ")),"2467"'[DGPTDCP S DGPTERC=753 Q
 I DGPTMTC="AS","1234567"'[DGPTDCP S DGPTERC=753 Q
 Q
LEG ;legionnaires indicator
 ;I DGPTDDXE=482.8&("12"'[DGPT70LG) S DGPTERC=731 Q
 Q
SUI ;suicide indicator
 ; -- 850 - aas - hard coded ICD codes
 ; -- Suicide Category is inactive JUL 1,2006
 N DGINACT
 I ($E(DGPTDDXE,1,3)="E95")&("12345678"[$E(DGPTDDXE,4))&("12"'[DGPT70SU) D
 . I '$D(DGSCDT) D DC
 . S DGINACT=$$GET1^DIQ(45.88,"2,",.03,"I")
 . I DGINACT]"",$D(DGSCDT) Q:DGSCDT>DGINACT
 . S DGPTERC=732 Q
 Q
DRUG ;drug/substance abuse
 ; -- 850 - aas - hard coded ICD codes
 ; -- Substance Abuse Category is inactive JUL 1,2006
 I DGPT70DR'?4" " S DGPTERC=733 ;should be spaces as of DG*5.3*683. 11/13/14 
 ;S DGPTMSX=0
 ;I ($E(DGPTDDXE,1,4)="304.")&("013456"[$E(DGPTDDXE,5))&("0123"[$E(DGPTDDXE,6)) S DGPTMSX=1
 ;I ($E(DGPTDDXE,1,4)="305.")&("234579"[$E(DGPTDDXE,5))&("0123"[$E(DGPTDDXE,6)) S DGPTMSX=1
 ;Q:'DGPTMSX
 ;N DGINACT
 ;I $E(DGPT70DR,1)'="A"!($E(DGPT70DR,2,4)<1)!(+$E(DGPT70DR>16)) D
 ;. I '$D(DGSCDT) D DC
 ;. S DGINACT=$$GET1^DIQ(45.88,"4,",.03,"I")
 ;. I DGINACT]"",$D(DGSCDT) Q:DGSCDT>DGINACT
 ;. S DGPTERC=733
 ;S DGPTMSX=0
 Q
AXIV ;physical sxis class
 ;this code will not be called when ICD10 is turned on. ft 11/13/14
 I $E(DGPTDDXE,1,3)>295,$E(DGPTDDXE,1,3)<320,"0123456"'[DGPT70X4 S DGPTERC=734
 Q
AXV1 ;physical axis assessment 1
 ;this code will not be called when ICD10 is turned on. ft 11/13/14
 I (DGPTDXV1<0)!(DGPTDXV1>90) S DGPTERC=735 Q
 Q
AXV2 ;physical axis assessment 2
 ;this code will not be called when ICD10 is turned on. ft 11/13/14
 Q:DGPTDXV2="  "
 I (DGPTDXV2<0)!(DGPTDXV2>90) S DGPTERC=735 Q
 Q
DC ;find discharge date
 S DGSCDT=$S('$D(^DGPT(PTF,70)):DT,^(70):+^(70),1:DT)
 Q
RACE ;Race
 I "1234567X "'[DGPT70RACE S DGPTERC=713
 Q
TSC ;treatment for service condition
 I "12YN "'[DGPT70TSC S DGPTERC=746
 Q
AO ;agent orange
 I "YN "'[DGPT70AO S DGPTERC=747
 Q
IR ;ionizing radiation
 I "YN "'[DGPT70IR S DGPTERC=748
 Q
SWA ;southwest asia
 I "YN "'[DGPT70SWA S DGPTERC=749
 Q
MST ;military sexual trauma
 I "YN "'[DGPT70MST S DGPTERC=752
 Q
HNC ;head & neck cancer (aka environmental contaminants)
 I "YN "'[DGPT70HNC S DGPTERC=754
 Q
ETHNIC ;ethnicity
 I '$F("^D ^DO^DP^DS^DU^H ^HO^HP^HS^HU^N ^NO^NP^NS^NU^U ^UO^UP^US^UU^  ^",U_DGPT70ETHNIC_U) S DGPTERC=704
 Q
RACE16 ;races 1-6
 N DGLIST
 S DGLIST="^A ^AO^AP^AS^AU^B ^BO^BP^BS^BU^C ^CO^CP^CS^CU^D ^DO^DP^DS^DU^3 ^30^3P^3S^3U^8 ^80^8P^8S^8U^9 ^9O^9P^9S^9U^"
 I $F(DGLIST,U_DGPTRACE16_U) S DGPTREC=757+DGLOOP
 Q
CV ;combat veteran
 I "012YN "'[DGPT70COMVET S DGPTERC=755
 Q
SHAD ;shipboard hazard and defense
 I "012YN "'[DGPT70SHAD S DGPTERC=756
 Q
DXLSPOA ;check dxls poa value
 I "YNUW "'[DGPTDXLSPOA S DGPTERC=720
 Q
