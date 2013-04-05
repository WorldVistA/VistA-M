ONCOTNM ;Hines OIFO/GWB - TNM coding ;02/22/11
 ;;2.11;ONCOLOGY;**1,6,15,22,25,28,30,33,35,36,41,42,43,51,52,53,54,56**;Mar 07, 1995;Build 10
 ;
 ;INPUT TRANSFORM, OUTPUT TRANSFORM and HELP for:
 ;CLINICAL T   (165.5,37.1)
 ;CLINICAL N   (165.5,37.2)
 ;CLINICAL M   (165.5,37.3)
 ;PATHOLOGIC T (165.5,85)
 ;PATHOLOGIC N (165.5,86)
 ;PATHOLOGIC M (165.5,87)
 ;OTHER T      (165.5,93)
 ;OTHER N      (165.5,98)
 ;OTHER M      (165.5,99)
 ;
IN ;INPUT TRANSFORM
 D SETVAR
 G EX:(ST="")!(TX="")
 S X=$TR(X,"abcdilmopsuvx","ABCDILMOPSUVX")
 I (X="X")!(X="IS")!(X="A") G IN1
 S XX=$E(X)
 S X=$S(XX?1.A:$E(X,2,$L(X)),1:X) I X="" K X G EX
IN1 S TRANSFRM="INPUT" D FILSC
 I $D(^ONCO(FIL,SC,ONCOX_ONCOED)) S ONCOX=ONCOX_ONCOED G CKIN
 I $D(^ONCO(FIL,SC,ONCOX_(ONCOED-1))) S ONCOX=ONCOX_(ONCOED-1) G CKIN
 I $D(^ONCO(FIL,SC,ONCOX_(ONCOED-2))) S ONCOX=ONCOX_(ONCOED-2)
CKIN D CK I 'XD0 S X=$TR(X,"abcd","ABCD") D CK
 I 'XD0 K X
 E  D
 .S TD=$P(^ONCO(FIL,SC,ONCOX,XD0,0),U,1)
 .I ONCOX["T" S T=$S(TD="CBA":"Primary tumor cannot be assessed",TD="NET":"No evidence of primary tumor",TD="CIS":"Carcinoma 'in situ'",TD="TIAS":"Tumor invades adjacent structures",TD="TIAO":"Tumor invades adjacent organs",1:TD)
 .I ONCOX["N" S T=$S(TD="NCA":"Regional lymph nodes cannot be assessed",TD="NRN":"No regional lymph node metastasis",TD="MET":"Metastasis in regional lymph node(s)",1:TD)
 .I ONCOX["M" S T=TD
 I ONCOED>6,STGIND="P",ONCOX["M",$G(X)'[1 K X
 D EX
 Q
 ;
CK ;Check for existence of code
 S XD0=$G(^ONCO(FIL,SC,ONCOX,"X",X))
 Q
 ;
OT ;OUTPUT TRANSFORM
 D SETVAR
 G EX:(ST="")!(TX="")
 D @$S(ONCOED<3:"OT12",1:"OT3456")
 Q
 ;
OT12 ;1st and 2nd editions
 S:Y'="" Y=$E(ONCOX)_Y
 Q
 ;
OT3456 ;3rd, 4th, 5th, 6th and 7th editions
 S TRANSFRM="OUTPUT" D FILSC
 I Y="" G EX
 I $D(^ONCO(FIL,SC,ONCOX_ONCOED)) S ONCOX=ONCOX_ONCOED G CKOT
 I $D(^ONCO(FIL,SC,ONCOX_(ONCOED-1))) S ONCOX=ONCOX_(ONCOED-1) G CKOT
 I $D(^ONCO(FIL,SC,ONCOX_(ONCOED-2))) S ONCOX=ONCOX_(ONCOED-2)
CKOT S XD0=$G(^ONCO(FIL,SC,ONCOX,"X",Y)) G EX:XD0=""
 S TC=^ONCO(FIL,SC,ONCOX,XD0,0),MM=""
 D TC
 I ONCOED<7 S Y=$E(ONCOX)_$P(TC,U,2)_MM_" "_TT G OTEX
 I (ONCOED=7)&($E(ONCOX)="M") S Y=$E(ONCOX)_Y(0)_MM G OTEX
 I ONCOED=7 S Y=$E(ONCOX)_Y(0)_MM
 ;I (ONCOED=7)&($E(ONCOX)="M") S Y=$E(ONCOX)_$P(TC,U,2)_MM G OTEX 
 ;I ONCOED=7 S Y=$E(ONCOX)_$P(TC,U,1)_MM
OTEX S YSTRING=$E(Y,2,99)
 S YSTRING=$TR(YSTRING,"ABCDEIMOLSUX","abcdeimolsux")
 S Y=$E(Y,1)_YSTRING
 G EX
 ;
TC I $E(ONCOX)="T" D
 .S TT=$S(Y="X":"Primary tumor cannot be assessed",Y=0:"No evidence of primary tumor",1:$P(TC,U))
 .S TT=$S(TT="TIAS":"Tumor invades adjacent structures",1:TT)
 .N MC,MM,MT,XXDTDX
 .S MT=$P($G(^ONCO(165.5,D0,2)),U,31) ;MULTIPLE TUMORS (165.5,69)
 .S MC=$P($G(^ONCO(165.5,D0,24)),U,16) ;MULTIPLICITY COUNTER (165.5,196)
 .S XXDTDX=$P($G(^ONCO(165.5,D0,0)),U,16)
 .I XXDTDX<3070000 S MM=MT
 .I XXDTDX>3069999 S MM=MC I (+MM=0)!(+MM=1)!(MM>87) S MM=""
 .I MM'="" S MM=$S(+MM>1:"m"_+MM,1:"m")
 E  I $E(ONCOX)="N" S TT=$S($P(TC,U,1)="NCA":"Regional lymph nodes cannot be assessed",$P(TC,U,1)="NRN":"No regional lymph node metastasis",ST=58:"NA",1:$P(TC,U)),TT=$S(TT="MET":"Metastasis in regional lymph node(s)",1:TT)
 E  I $E(ONCOX)="M" S TT=$P(TC,U) Q
 Q
 ;
HP ;HELP
 D SETVAR
 G EX:(ST="")!(TX="")
 D @$S(ONCOED<3:"P12",1:"P3456")
 Q
 ;
P12 ;1st and 2nd edition
 D EN^DDIOL("Enter the appropriate TNM code.",,"!!")
 Q
 ;
P3456 ;3rd, 4th, 5th, 6th and 7th editions
 S TRANSFRM="HELP" D FILSC
 I $D(^ONCO(FIL,SC,ONCOX_ONCOED)) S ONCOX=ONCOX_ONCOED
 ;
 ;Full text help from AJCC STAGING GROUPS (164.33)
 N S,SUB
 S S=SC
 I ONCOED>6,FIL=164.33,(S=31)!(S=25)!(S=39)!(S=41)!(S=50)!(S=51)!(S=55)!(S=56)!(S=57)!(S=58)!(S=59)!(S=60)!(S=61)!(S=62)!(S=63)!(S=64)!(S=66) S SUB=$S($E(ONCOX,1)="T":7,$E(ONCOX,1)="N":8,1:9) I $D(^ONCO(164.33,S,SUB)) D  D EN^DDIOL(" ") Q
 .S HIEN=0 F  S HIEN=$O(^ONCO(164.33,SC,SUB,HIEN)) Q:HIEN'>0  D
 ..I STGIND="P",ONCOX["M",(^ONCO(164.33,SC,SUB,HIEN,0)'["M1")&(^ONCO(164.33,SC,SUB,HIEN,0)'="Distant Metastasis (M)")&(^ONCO(164.33,SC,SUB,HIEN,0)'="")&(^ONCO(164.33,SC,SUB,HIEN,0)'=" ") Q
 ..D EN^DDIOL(^ONCO(164.33,SC,SUB,HIEN,0),,"!?1")
 ;
 I ONCOED>5,FIL=164.33,(SC=22)!(SC=23)!(SC=25)!(SC=29)!(SC=30)!(SC=35)!(SC=39)!(SC=41)!(SC=50)!(SC=51)!(SC=55)!(SC=61)!(SC=62)!(SC=63) S SUB=$S($E(ONCOX,1)="T":4,$E(ONCOX,1)="N":5,1:6) I $D(^ONCO(164.33,SC,SUB)) D  D EN^DDIOL(" ") K SUB Q
 .S HIEN=0 F  S HIEN=$O(^ONCO(164.33,SC,SUB,HIEN)) Q:HIEN'>0  D
 ..I ONCOED>6,STGIND="P",ONCOX["M",(^ONCO(164.33,SC,SUB,HIEN,0)'["M1")&(^ONCO(164.33,SC,SUB,HIEN,0)'="Distant Metastasis (M)")&(^ONCO(164.33,SC,SUB,HIEN,0)'="") Q
 ..D EN^DDIOL(^ONCO(164.33,SC,SUB,HIEN,0),,"!?1")
 ;
 I ONCOED>4,ONCOED<7,FIL=164.33,(SC=22)!(SC=23)!(SC=25)!(SC=29)!(SC=30)!(SC=35)!(SC=39)!(SC=41)!(SC=50)!(SC=51) S SUB=$S($E(ONCOX,1)="T":1,$E(ONCOX,1)="N":2,1:3) I $D(^ONCO(164.33,SC,SUB)) D  D EN^DDIOL(" ") K SUB Q
 .S HIEN=0 F  S HIEN=$O(^ONCO(164.33,SC,SUB,HIEN)) Q:HIEN'>0  D EN^DDIOL(^ONCO(164.33,SC,SUB,HIEN,0),,"!?1")
 ;
 ;Full text help from ICDO TOPOGRAPHY (164)
 I ONCOED>6 S SUB=$S($E(ONCOX,1)="T":11,$E(ONCOX,1)="N":12,1:13) I $D(^ONCO(164,SC,SUB)) D  D EN^DDIOL(" ") K SUB Q
 .S HIEN=0 F  S HIEN=$O(^ONCO(164,SC,SUB,HIEN)) Q:HIEN'>0  D
 ..I ONCOED>6,STGIND="P",SUB=13,(^ONCO(164,SC,SUB,HIEN,0)["M0")!(^ONCO(164,SC,SUB,HIEN,0)["MX") D  Q
 ...I SC=67500 S HIEN=HIEN+5 Q
 ..D EN^DDIOL(^ONCO(164,SC,SUB,HIEN,0),,"!?1")
 ;
 I ONCOED>5 S SUB=$S($E(ONCOX,1)="T":8,$E(ONCOX,1)="N":9,1:10) I $D(^ONCO(164,SC,SUB)) D  D EN^DDIOL(" ") K SUB Q
 .S HIEN=0 F  S HIEN=$O(^ONCO(164,SC,SUB,HIEN)) Q:HIEN'>0  D EN^DDIOL(^ONCO(164,SC,SUB,HIEN,0),,"!?1")
 ;
 I ONCOED>4 S SUB=$S($E(ONCOX,1)="T":5,$E(ONCOX,1)="N":6,1:7) I $D(^ONCO(164,SC,SUB)) D  D EN^DDIOL(" ") K SUB Q
 .S HIEN=0 F  S HIEN=$O(^ONCO(164,SC,SUB,HIEN)) Q:HIEN'>0  D EN^DDIOL(^ONCO(164,SC,SUB,HIEN,0),,"!?1")
 ;
 S XD0=0
 D EN^DDIOL($S(ONCOX["T":" Primary Tumor (T)",ONCOX["N":" Regional Lymph Nodes (N)",ONCOX["M":" Distant Metastasis (M)",1:""))
 D EN^DDIOL(" ")
 F  S XD0=$O(^ONCO(FIL,SC,ONCOX,XD0)) Q:XD0'>0  D
 .N Y,T
 .S Y=^(XD0,0),T=$P(Y,U)
 .I ONCOX["T" D
 ..I $P(Y,U,2)'=88 D EN^DDIOL("T"_$P(Y,U,2),,"!?1")
 ..D EN^DDIOL($S(T="CBA":"Primary tumor cannot be assessed",T="NET":"No evidence of primary tumor",T="CIS":"Carcinoma 'in situ'",T="TIAS":"Tumor invades adjacent structures",T="TIAO":"Tumor invades adjacent organs",1:T),,"?12")
 .E  I ONCOX["N" I $P(Y,U,2)'=88 D EN^DDIOL("N"_$P(Y,U,2),,"!?1") D EN^DDIOL($S(T="NCA":"Regional lymph nodes cannot be assessed",T="NRN":"No regional lymph node metastasis",T="MET":"Regional lymph nodes metastasis",1:T),,"?13")
 .E  I ONCOX["M" D
 ..I ONCOED>6,STGIND="P",($P(Y,U,2)="X")!($P(Y,U,2)=0) Q
 ..I $P(Y,U,2)'=88 D EN^DDIOL("M"_$P(Y,U,2),,"!?1") D EN^DDIOL(T,,"?6")
 D EN^DDIOL(" ") Q
 ;
SETVAR ;Set variables
 S ST=$P(^ONCO(165.5,D0,0),U,1)              ;SITE/GP
 S TX=$P($G(^ONCO(165.5,D0,2)),U,1)          ;PRIMARY SITE
 Q:TX=""
 S HT=$$HIST^ONCFUNC(D0)                     ;Histology
 S HT14=$E(HT,1,4)
 S SC=$P(^ONCO(164,TX,0),U,11)               ;T & N CODES
 S DATEDX=$P(^ONCO(165.5,D0,0),U,16)         ;DATE DX
 S YR=$E($P($G(^ONCO(165.5,D0,0)),U,16),1,3) ;DATE DX (Year)
 S ONCOED=$S(YR<283:1,YR<288:2,YR<292:3,YR<298:4,YR<303:5,YR<310:6,1:7)
 S SD=$P($G(^ONCO(165.5,D0,"CS3")),U,1)      ;SCHEMA DISCRIMINATOR
 S FIL=164
 Q
 ;
FILSC ;Get file (FIL) and IEN (SC) for appropriate TNM list
 ;
 ;PART II: HEAD AND NECK
 ;Mucosal Melanoma of the Head and Neck
 N TC
 S TC=$E(TX,3,4)
 I ONCOED>6,(HT>87199)&(HT<87910),((TC="00")!(TC="01")!(TC="02")!(TC="03")!(TC="04")!(TC="05")!(TC="06")!(TC="09")!(TC=10)!(TC=11)!(TC=12)!(TC=13)!(TC=32)!(TX=67300)!(TX=67310)!(TX=67311)!(TX=67140)!(TX=67142)!(TX=67148)) S FIL=164.33,SC=61 Q
 ;
 ;PART III: DIGESTIVE SYSTEM
 ;Esophagus and Esophagastric Junction
 I ONCOED>4,ONCOED<7,TX=67151,ONCOX="M" S FIL=164,SC=67154 Q
 I ONCOED>4,ONCOED<7,TX=67152,ONCOX="M" S FIL=164,SC=67155 Q
 I ONCOED>4,ONCOED<7,TX=67153,ONCOX="M" S FIL=164,SC=67153 Q
 I ONCOED>4,ONCOED<7,TX=67154,ONCOX="M" S FIL=164,SC=67154 Q
 I ONCOED>4,ONCOED<7,TX=67155,ONCOX="M" S FIL=164,SC=67155 Q
 I ONCOED>6,(TX=67161)!(TX=67162),(SD="010")!(SD="020")!(SD="040")!(SD="060") S FIL=164,SC=67150 Q
 I ONCOED>6,TX=67160,((HT14>7999)&(HT14<8153)!(HT14>8153)&(HT14<8232)!(HT14>8242)&(HT14<8246)!(HT14>8249)&(HT14<8577)!(HT14>8939)&(HT14<8951)!(HT14>8979)&(HT14<8982)) S FIL=164,SC=67150 Q
 ;
 ;Appendix, 7th Edition
 I ONCOED>6,TX=67181 D  Q
 .I (HT14=8153)!(HT14=8240)!(HT14=8241)!(HT14=8242)!(HT14=8246)!(HT14=8249) S FIL=164.33,SC=62 Q
 .S FIL=164,SC=67181
 ;
 ;Gastrointestinal Stromal Tumor (GIST), 7th Edition
 I ($E(HT,1,4)=8935)!($E(HT,1,4)=8936),(($E(TX,3,4)=15)!($E(TX,3,4)=16)!($E(TX,3,4)=17)!($E(TX,3,4)=18)!($E(TX,3,4)=21)!($E(TX,3,4)=48)!(TX=67199)!(TX=67209)),ONCOED>6 S FIL=164.33,SC=56 Q
 ;
 ;Neuroendocrine Tumor (Stomach), 7th Edition
 I (($E(HT,1,4)=8153)!($E(HT,1,4)=8240)!($E(HT,1,4)=8241)!($E(HT,1,4)=8242)!($E(HT,1,4)=8246)!($E(HT,1,4)=8249)),$E(TX,3,4)=16,ONCOED>6 S FIL=164.33,SC=57 Q
 ;
 ;Neuroendocrine Tumor (Duodenum/Ampulla/Jejunum/Ileum), 7th Edition
 I (($E(HT,1,4)=8153)!($E(HT,1,4)=8240)!($E(HT,1,4)=8241)!($E(HT,1,4)=8242)!($E(HT,1,4)=8246)!($E(HT,1,4)=8249)),(($E(TX,3,4)=17)!(TX=67241)),ONCOED>6 S FIL=164.33,SC=58 Q
 ;
 ;Neuroendocrine Tumor (Colon or Rectum), 7th Edition
 I $$MELANOMA^ONCOU55(D0),(($E(TX,3,4)=44)!($E(TX,3,4)=51)!($E(TX,3,4)=60)!(TX=67632)) S FIL=164.33,SC=22 Q
 I (($E(HT,1,4)=8153)!($E(HT,1,4)=8240)!($E(HT,1,4)=8241)!($E(HT,1,4)=8242)!($E(HT,1,4)=8246)!($E(HT,1,4)=8249)),(($E(TX,3,4)=18)!(TX=67199)!(TX=67209)),ONCOED>6 S FIL=164.33,SC=59 Q
 ;
 ;Intrahepatic Bile Ducts
 I ONCOED>6,TX=67221 S FIL=164,SC=67221 Q
 ;
 ;Gallbladder
 I ONCOED>6,TX=67240,SD="030" S FIL=164,SC=67239 Q
 ;
 ;Extraheptic Bile Ducts
 I ((TX=67240)!(TX=67248)!(67249)),ONCOED=3,ONCOX="N" S FIL=164.33,SC=15 Q
 ;
 ;Perihilar Bile Duct
 ;I ONCOED>6,TX=67240,(SD="040")!(SD="070") S FIL=164.33,SC=63 Q
 ;
 ;Distal Bile Duct
 I ONCOED>6,TX=67240,(SD="040")!(SD="070") S FIL=164.33,SC=63 Q
 ;
 ;PART VI: SKIN
 ;Merkel Cell Carcinoma
 I ONCOED>6,$E(HT,1,4)=8247,((TX=67440)!(TX=67442)!(TX=67443)!(TX=67444)!(TX=67445)!(TX=67446)!(TX=67447)!(TX=67448)!(TX=67449)!($E(TX,3,4)=51)!($E(TX,3,4)=60)!(TX=67632)) S FIL=164.33,SC=60 Q
 ;
 ;Melanoma of the Skin
 I $$MELANOMA^ONCOU55(D0),(($E(TX,3,4)=44)!($E(TX,3,4)=51)!($E(TX,3,4)=60)!(TX=67632)) S FIL=164.33,SC=22 Q
 ;
 ;PART VII: BREAST
 ;Breast
 I $E(TX,1,4)=6750,ONCOX="N" D  Q
 .I STGIND="C" Q
 .I STGIND="P" S FIL=164.33,SC=23
 ;
 ;PART VIII: GYNECOLOGIC SITES
 ;Vulva
 I ONCOED>4,$E(TX,3,4)=51,ONCOX="M" S FIL=164,SC=67518 Q
 ;
 ;Vagina - 3rd and 4th editions
 I TX=67529,ONCOX="N",ONCOED<5 D  Q
 .S ONCUL=$P($G(^ONCO(165.5,D0,24)),U,4)
 .I ONCUL="U" Q
 .I ONCUL="L" S FIL=164.33,SC=52 Q
 ;
 ;Corpus Uteri - 7th edition
 I ONCOED>6,($E(TX,3,4)=54)!($E(TX,3,4)=55) D
 .I (HT14>7999)&(HT14<8791) S FIL=164,SC=67540 Q
 .I (HT14>8979)&(HT14<8982) S FIL=164,SC=67540 Q
 .I (HT14>9699)&(HT14<9702) S FIL=164,SC=67540 Q
 .I (HT14>8889)&(HT14<8899) S FIL=164.33,SC=25 Q
 .I (HT14>8929)&(HT14<8932) S FIL=164.33,SC=25 Q
 .I HT14=8933 S FIL=164.33,SC=64 Q
 ;
 ;Ovary and Primary Peritoneal Carcinoma - 7th edition
 I ONCOED>6,(TX=67481)!(TX=67482)!(TX=67488) D
 .I (HT14>7999)&(HT14<8577) S FIL=164,SC=67569 Q
 .I (HT14>8929)&(HT14<9111) S FIL=164,SC=67569 Q
 ;
 ;Gestational Trophoblastic Tumors - 5th, 6th and 7th editions
 ;I ONCOED>4,TX=67589,ONCOX="M" S FIL=164,SC=67540 Q
 I $$GTT^ONCOU55(D0),ONCOED>4,ONCOX="M" S FIL=164,SC=67589 Q
 ;I ONCOED=5,(($E(TX,3,4)=54)!($E(TX,3,4)=55)) S ONCOED=4
 ;
 ;PART IX: GENITOURINARY SITES
 ;Penis
 I $E(TX,3,4)=60,ONCOED>6,ONCOX="N",STGIND="C" S FIL=164.33,SC=31 Q
 I $E(TX,3,4)=60,ONCOED>6,ONCOX="N",STGIND="P" S FIL=164,SC=67600 Q
 ;
 ;Prostate
 I TX=67619,ONCOED>4,ONCOX="T",STGIND="P" S FIL=164.33,SC=29 Q
 I TX=67619,ONCOED=6,ONCOX="N",STGIND="P" S FIL=164.33,SC=29 Q
 I TX=67619,ONCOX="M" S FIL=164.33,SC=$S(ONCOED>3:29,1:3) Q
 ;
 ;Testis - 5th and 6th editions
 I $E(TX,3,4)=62,ONCOED>4,ONCOX="N",STGIND="P" S FIL=164.33,SC=30 Q
 I $E(TX,3,4)=62,ONCOED>4,ONCOX="M" S FIL=164,SC=67620 Q
 ;
 ;Urethra - Urothelial (Transitional Cell) Carcinoma of the Prostate
 I ONCOED>4,TX=67619,(HT=81203)!(HT=81303)!(HT=81223)!(HT=81202) D  Q
 .I ONCOX="T" S FIL=164.33,SC=35
 .I ONCOX="N" S FIL=164,SC=67680
 .I ONCOX="M" S FIL=164.33,SC=3
 ;
 ;PART X: OPHTHALMIC SITES
 ;Malignant Melanoma of the Eyelid -3rd and 4th editions
 I TX=67441,ONCOED<5,$$MELANOMA^ONCOU55(D0) S FIL=164.33,SC=37 Q
 ;
 ;Malignant Melanoma of the Conjunctiva
 I $$MELANOMA^ONCOU55(D0),TX=67690 S FIL=164.33,SC=$S(STGIND="P":50,1:39) Q
 ;
 ;Malignant Melanoma of the Uvea
 I TX=67693 S FIL=164.33,SC=51 Q
 I TX=67694,($P($G(^ONCO(165.5,D0,2)),U,22)="C")!($P($G(^ONCO(165.5,D0,"CS3")),U,1)="010") S FIL=164.33,SC=51 Q
 ;
 ;Retinoblastoma
 I TX=67692,STGIND="P" S FIL=164.33,SC=41 Q
 ;
 ;Ocular Adnexal Lymphoma
 I ONCOED>6,(TX=67441)!(TX=67690)!(TX=67695)!(TX=67696) D
 .I (HT14>9589)&(HT14<9700) S FIL=164.33,SC=66 Q
 .I (HT14>9701)&(HT14<9739) S FIL=164.33,SC=66 Q
 .I (HT14>9810)&(HT14<9819) S FIL=164.33,SC=66 Q
 .I (HT14>9819)&(HT14<9838) S FIL=164.33,SC=66 Q
 ;
 ;PART XI: CENTRAL NERVOUS SYSTEM
 ;Brain - 3rd and 4th editions
 I ((TX=67700)!($E(TX,3,4)=71)),ONCOED<5 D
 .I ONCOX="T" S SC=$S($P($G(^ONCO(165.5,D0,2)),U,7)="I":67710,1:67700) Q
 .I TRANSFRM'="OUTPUT",ONCOX="N" D EN^DDIOL(" This category does not apply to this site.",,"?12")
 ;
 ;PART XII: LYMPHOID NEOPLASMS
 ;Mycosis fungoides and Sezary Disease of Skin, Vulva, Penis, Scrotum
 ;9700/3 and 9701/3
 ;C44.0-C44.9, C51.0-C51.2, C51.8-C51.9, C60.0-C60.2, C60.8-C60.9, C63.2
 I (HT=97003)!(HT=97013),($E(TX,3,4)=44)!($E(TX,3,4)=51)!($E(TX,3,4)=60)!(TX=67632),ONCOED>5 S FIL=164.33,SC=55 Q
 ;
 ;Bone metastasis
 I ONCOX="M",((HT14>8797)&(HT14<9137))!((HT14>9141)&(HT14<9583)) S FIL=164,SC=67400 Q
 ;
 I ONCOX="M",'$D(^ONCO(FIL,SC,"M"_ONCOED)) S FIL=164.33,SC=3
 ;
 Q
 ;
EX ;Exit
 K FIL,HIEN,HT,HT14,MM,ONCOX,ONCUL,SC,SD,ST,TC,TD,TRANSFRM,TT,TX,XD0
 K XX,YR,YSTRING
 Q
 ;
CLEANUP ;Cleanup
 K D0,DATEDX,ONCOED,STGIND
