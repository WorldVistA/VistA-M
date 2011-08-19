FHWORA1 ; HISC/GJC/JH - OE/RR Procedure Call (Assessments) 2 of 2;1/31/97  12:56 ;11/6/97  15:28
 ;;5.5;DIETETICS;;Jan 28, 2005
SETUP ; Set up our ^TMP($J,"FHASM",DFN) global.  Called from FHWORA
 S DTP=ADT D DTP^FH
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=$$CJ^XLFSTR("Date of Assessment: "_$E(DTP,1,9),80," ")
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=" "
 ;
 S X1=$S(HGT\12:HGT\12_"'",1:"")_$S(HGT#12:" "_(HGT#12)_"""",1:"")
 S X2=+$J(HGT*2.54,0,0)_" cm" K STR S $P(STR," ",81)=""
 S STR1="Height:       "_$S(FHUNIT'="M":X1,1:X2)_" ("_$S(FHUNIT'="M":X2,1:X1)_")",TAB=0
 I HGP'="" S STR1=STR1_" "_$S(HGP="K":"knee hgt",HGP="S":"stated",1:"")
 S STR=$$STRING(STR,STR1,TAB)
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 ;
 S X1=WGT_" lbs",X2=+$J(WGT/2.2,0,1)_" kg"
 S STR1="Weight:       "_$S(FHUNIT'="M":X1,1:X2)_" ("_$S(FHUNIT'="M":X2,1:X1)_")",TAB=0
 I WGP'="" S STR1=STR1_" "_$S(WGP="A":"anthro",WGP="S":"stated",1:"")
 S STR=$$STRING(STR,STR1,TAB)
 S DTP=DWGT D DTP^FH S TAB=50,STR1="Weight Taken:    "_DTP
 S STR=$$STRING(STR,STR1,TAB)
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 ;
 S (X1,X2)="" I UWGT S X1=UWGT_" lbs",X2=+$J(UWGT/2.2,0,1)_" kg"
 K STR S $P(STR," ",81)="",TAB=0,STR1="Usual Weight: "_$S(FHUNIT'="M":X1,1:X2)_" ("_$S(FHUNIT'="M":X2,1:X1)_")"
 S STR=$$STRING(STR,STR1,TAB)
 S STR1="Weight/Usual Wt:  "_$S(UWGT:($J(WGT/UWGT*100,3,0)_"%"),1:"")
 S TAB=50 S STR=$$STRING(STR,STR1,TAB)
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 ;
 S X1=IBW_" lbs",X2=+$J(IBW/2.2,0,1)_" kg"
 K STR S $P(STR," ",81)="",TAB=0
 S STR1="Ideal Weight: "_$S(FHUNIT'="M":X1,1:X2)_" ("_$S(FHUNIT'="M":X2,1:X1)_")"
 S STR=$$STRING(STR,STR1,TAB)
 S TAB=50,STR1="Weight/IBW:       "_$S(IBW:($J(WGT/IBW*100,3,0)_"%"),1:"")
 S STR=$$STRING(STR,STR1,TAB)
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 ;
 I AMP S TAB=6 K STR S $P(STR," ",81)="",STR1="Ideal weight adjusted for amputation",STR=$$STRING(STR,STR1,TAB),^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 ;
 S TAB=0 K STR S $P(STR," ",81)=""
 S STR1="Frame Size:   "_$S(FRM="S":"Small",FRM="M":"Medium",FRM="L":"Large",1:"")
 S STR=$$STRING(STR,STR1,TAB),TAB=50
 S STR1="Body Mass Index:  "_BMI S:BMIP'="" STR1=STR1_" ("_BMIP_"%)"
 S STR=$$STRING(STR,STR1,TAB)
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 ;
 I FHASMNT(1)]"" D
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=" " K STR
 . S $P(STR," ",81)="",TAB=26
 . S STR1="Anthropometric Measurements"
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=$$STRING(STR,STR1,TAB)
 . K STR S $P(STR," ",81)=""
 . S TAB=35,STR1="%ile",STR=$$STRING(STR,STR1,TAB)
 . S TAB=71,STR1="%ile",STR=$$STRING(STR,STR1,TAB)
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=$$STRING(STR,STR1,TAB)
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=" "
 . K STR S $P(STR," ",81)="",TAB=4
 . S STR1="Triceps Skinfold (mm)",STR=$$STRING(STR,STR1,TAB)
 . I TSF D
 .. S TAB=31,STR1=$J(+TSF,3,0),STR=$$STRING(STR,STR1,TAB)
 .. S TAB=36,STR1=$J(TSFP,3),STR=$$STRING(STR,STR1,TAB)
 .. Q
 . S TAB=43,STR1="Arm Circumference (cm)"
 . S STR=$$STRING(STR,STR1,TAB)
 . I ACIR D
 .. S TAB=67,STR1=$J(+ACIR,3,0),STR=$$STRING(STR,STR1,TAB)
 .. S TAB=72,STR1=$J(ACIRP,3),STR=$$STRING(STR,STR1,TAB)
 .. Q
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 . K STR S $P(STR," ",81)="",TAB=4,STR1="Subscapular Skinfold (mm)"
 . S STR=$$STRING(STR,STR1,TAB)
 . I SCA D
 .. S TAB=31,STR1=$J(+SCA,3,0),STR=$$STRING(STR,STR1,TAB)
 .. S TAB=36,STR1=$J(SCAP,3),STR=$$STRING(STR,STR1,TAB)
 .. Q
 . S TAB=43,STR1="Bone-free AMA (cm2)"
 . S STR=$$STRING(STR,STR1,TAB)
 . I BFAMA D
 .. S TAB=67,STR1=$J(+BFAMA,3,0),STR=$$STRING(STR,STR1,TAB)
 .. S TAB=72,STR1=$J(BFAMAP,3),STR=$$STRING(STR,STR1,TAB)
 .. Q
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 . K STR S $P(STR," ",81)=""
 . S TAB=4,STR1="Calf Circumference (cm)",STR=$$STRING(STR,STR1,TAB)
 . I CCIR>0 D
 .. S TAB=31,STR1=$J(+CCIR,3,0),STR=$$STRING(STR,STR1,TAB)
 .. S TAB=36,STR1=$J(CCIRP,3),STR=$$STRING(STR,STR1,TAB)
 .. Q
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 . Q
 ;
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=" "
 K STR S $P(STR," ",81)="",TAB=32,STR1="Laboratory Data"
 S STR=$$STRING(STR,STR1,TAB)
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 K STR S $P(STR," ",81)="",TAB=5,STR1="Test",STR=$$STRING(STR,STR1,TAB)
 S TAB=30,STR1="Result    units",STR=$$STRING(STR,STR1,TAB)
 S TAB=51,STR1="Ref.   range",STR=$$STRING(STR,STR1,TAB)
 S TAB=67,STR1="Date",STR=$$STRING(STR,STR1,TAB)
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 ;
 S (I,X3)=0 F  S I=$O(FHLAB(I)) Q:I'>0  D LAB^FHWORA(I)
 I 'X3 D
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=" ",TAB=5
 . K STR S $P(STR," ",81)=""
 . S STR1="No laboratory data available last "_$S($D(^FH(119.9,1,3)):$P(^(3),"^",2),1:90)_" days"
 . S STR=$$STRING(STR,STR1,TAB),^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 . Q
 ;
 S N=PRO/6.25,^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=" ",TAB=0
 K STR S $P(STR," ",81)="",STR1="Energy Requirements:  "_KCAL_" Kcal/day"
 S STR=$$STRING(STR,STR1,TAB)
 I N D
 . S TAB=50,STR1="Kcal:N  "_$J(KCAL/N,0,0)_":1"
 . S STR=$$STRING(STR,STR1,TAB)
 . Q
 I NB'="" D
 . S TAB=67,STR1="N-Bal: "_NB
 . S STR=$$STRING(STR,STR1,TAB)
 . Q
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 K STR S $P(STR," ",81)="",TAB=0,STR1="Protein Requirements: "_PRO_" gm/day"
 S STR=$$STRING(STR,STR1,TAB)
 I N D
 . S TAB=50,STR1="NPC:N   "_$J(KCAL-(PRO*4)/N,0,0)_":1"
 . S STR=$$STRING(STR,STR1,TAB)
 . Q
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 ;
 S:FLD'="" ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))="Fluid Requirements:   "_FLD_" ml/day"
 ;
 I FHAPPER]"" D
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=" "
 . K STR S $P(STR," ",81)="",TAB=0,STR1="Appearance: "
 . S STR=$$STRING(STR,STR1,TAB)
 . S TAB=20,$E(STR,(TAB+1),(TAB+$L(FHAPPER)))=FHAPPER
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 . Q
 I XD D
 . N Y S Y=$L($P($G(^FH(115.3,XD,0)),"^"))
 . S Y(0)=$P($G(^FH(115.3,XD,0)),"^")
 . S TAB=0 K STR S $P(STR," ",81)="",STR1="Nutrition Class: "
 . S STR=$$STRING(STR,STR1,TAB)
 . S TAB=20,$E(STR,(TAB+1),(TAB+Y))=Y(0)
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 . Q
 I RC D
 . N Y S Y=$L($P($G(^FH(115.4,RC,0)),"^",2))
 . S Y(0)=$P($G(^FH(115.4,RC,0)),"^",2)
 . S TAB=0 K STR S $P(STR," ",81)="",STR1="Nutrition Status: "
 . S STR=$$STRING(STR,STR1,TAB)
 . S TAB=20,$E(STR,(TAB+1),(TAB+Y))=Y(0)
 . S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 . Q
 D COMMENT^FHWORA ; display nutritional assessment comments
 K STR S STR="" S:SIGN1'="" STR=SIGN1
 K SIGN1 Q:STR=""
 S ^TMP($J,"FHASM",DFN,$$CNT^FHWORA(CNT))=STR
 Q
STRING(STR,STR1,TAB) ; Build our data string
 S $E(STR,(TAB+1),(TAB+$L(STR1)))=STR1
 Q STR
