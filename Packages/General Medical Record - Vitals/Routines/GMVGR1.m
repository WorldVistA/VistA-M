GMVGR1 ;HIOFO/YH,FT-SET ^TMP($J) GLOBAL ;11/29/02  13:34
 ;;5.0;GEN. MED. REC. - VITALS;**1**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10061 - ^VADPT calls           (supported)
 ; #10104 - ^XLFSTR calls          (supported)
 ;
GRAPH ;CONTINUTATION OF GMVGR0
 S (GCNT,GCNTD,GPG)=0 D DEM^VADPT,INP^VADPT,SETV
 F GK="H","W","T","P","R","B","I","O","PO2","CVP","CG","PN" D
 . S ^TMP($J,"GTNM",GK)=0 F GI=0:0 S GI=$O(^TMP($J,"GMRVG",GK,GI)) Q:GI'>0  S GJ="" F X=0:0 S GJ=$O(^TMP($J,"GMRVG",GK,GI,GJ)) Q:GJ=""  S ^TMP($J,"GTNM",GK)=^TMP($J,"GTNM",GK)+1,^TMP($J,"GDT",GI)=""
 S GTNM=0 F X=0:0 S X=$O(^TMP($J,"GDT",X)) Q:X'>0  S GTNM=GTNM+1
 S GPG=$S(GTNM=0:1,1:GTNM\10+''(GTNM#10)),GDT1=0
 F GPGS=1:1:GPG D
 . F GI=1:1:200 S ^TMP($J,"GMRK","G"_GI)=""
 . K GMRQUAL S ^TMP($J,"GMRK","G199")="Page "_GPGS D SETP,DATE S ^TMP($J,"GMRK","G200")=GMRRMBD
 . D PAGE,EN1^GMVGR2,EN2^GMVGR3,EN3^GMVGR4,EN4^GMVGR6 S ^TMP($J,"GMRK","G50M")=0.2,^TMP($J,"GMRK","G82M")=0.6
 D KVAR^VADPT K VA Q
PAGE ;Set temp. and pulse starting point in the graph
 D SETV
 I ^TMP($J,"GMRK","G50")="" F GI=51:1:59 S ^TMP($J,"GMRK","G50")=^TMP($J,"GMRK","G"_GI),^TMP($J,"GMRK","G50M")=0.2+(1.6*(GI-50)) Q:^TMP($J,"GMRK","G50")'=""
 I ^TMP($J,"GMRK","G82")="" F GI=83:1:91 S ^TMP($J,"GMRK","G82")=^TMP($J,"GMRK","G"_GI),^TMP($J,"GMRK","G82M")=0.6+(1.6*(GI-82)) Q:^TMP($J,"GMRK","G82")'=""
 I $D(GMRQUAL) D LEGEND^GMVLGQU
 K GG,GI,GMRVJ,GSYNO Q
SETV ;Set patient data in ^TMP($J,"GMRK" global
 S ^TMP($J,"GMRK","G194")=$S(VADM(1)'="":VADM(1),1:"         ")_"  "_$S(VADM(2)'="":$P(VADM(2),"^",2),1:" "),GDOB=$S($D(VADM(3)):$P(VADM(3),"^",2),1:" "),GAGE=$S($D(VADM(4)):VADM(4),1:" ")
 S ^TMP($J,"GMRK","G197")=$S($D(VADM(5)):$P(VADM(5),"^",2),1:" "),^TMP($J,"GMRK","G198")=$S($D(GMRWARD(1)):"Unit: "_GMRWARD(1),1:"Unit:  ")
 S GMRRMBD=$S('(VAIN(5)=""):"Room: "_$P(VAIN(5),"-",1,2),1:"Room:  "),^TMP($J,"GMRK","G196")=$S($D(GDOB)&($D(GAGE)):GDOB_" ("_GAGE_")",1:" ")
 I '$D(GMRVHLOC) S GMRVHLOC=$$HOSPLOC^GMVUTL1(+$G(VAIN(4)))
 S GMRDIV="Division: "_$$DIVISION^GMVUTL1(+GMRVHLOC)
 Q
DATE F GCNTD=1:1:10 S:$L(GDT1) GDT1=$O(^TMP($J,"GDT",GDT1)) S ^TMP($J,"GMRK","G"_GCNTD)=$S($L(GDT1):$E(GDT1,4,5)_"-"_$E(GDT1,6,7)_"-"_$E(GDT1,2,3),1:"") D DATE1
 Q
DATE1 S Y=$E($P(GDT1,".",2)_"0000",1,4),^TMP($J,"GMRK","G"_(GCNTD+16))=$S($L(GDT1):$E(Y,1,2)_":"_$E(Y,3,4),1:"") D SETD
 Q
SETD F GI="H","W","T","P","R","B","I","O","C","PN" S GJ=$F("WTXPXRBIOCH",GI),GK=$S($L(GDT1):$O(^TMP($J,"GMRVG",GI,GDT1,"")),1:"") D SETA
 F GI="PO2","CVP","CG" S GJ=0,GK=$S($L(GDT1):$O(^TMP($J,"GMRVG",GI,GDT1,"")),1:"") D SETA
 Q
SETA ;Store measurements in ^TMP($J,"GMRK" global
 I GK="Unavailable" S GK="Unavail"
 I GI="PN" S ^TMP($J,"GMRK","G"_(1660+GCNTD))=GK Q
 S (GMRSITE,GMRSITE(1),GMRINF,GMRVJ)=""
 I GK'="" D
 . S GMRSITE(1)=$P($G(^TMP($J,"GMRVG",GI,GDT1,GK)),"^"),GMRVJ=$P($G(^(GK)),"^",2),GMRINF=$P($G(^(GK)),"^",4)
 . I GMRSITE(1)'="" D SYNOARY^GMVLGQU
 I GI="H" D  Q
 . S ^TMP($J,"GMRK","G"_(270+GCNTD))=GK_" "_GMRSITE,^TMP($J,"GMRK","G"_(290+GCNTD))=$S(GK>0:$J(GK*2.54,0,2),1:"") S:GK>0 GMRHT=(GK*2.54)/100
 I GI="C" S ^TMP($J,"GMRK","G"_(1640+GCNTD))=GK_"  "_^TMP($J,"GMRK","G"_(1640+GCNTD)) Q
 I GI="PO2"!(GI="CVP")!(GI="CG") D  Q
 . I GI="PO2" D
 . . S (GMRINF(1),GMRINF(2))="" I GMRINF'="" D PO2^GMVLGQU(.GMRINF)
 . . S ^TMP($J,"GMRK","G"_(1100+GCNTD))=GK_$S(GMRVJ=1:"*",1:" ")
 . . S ^TMP($J,"GMRK","G"_(1130+GCNTD))=GMRINF(1)
 . . S ^TMP($J,"GMRK","G"_(1150+GCNTD))=GMRINF(2)
 . . S ^TMP($J,"GMRK","G"_(1170+GCNTD))=GMRSITE
 . . Q
 . I GI="CVP" D
 . . S ^TMP($J,"GMRK","G"_(1200+GCNTD))=$S(GK>0!(GK<0):$J(GK,0,1),1:GK)_$S(GMRVJ=1:"*",1:" ")
 . . S ^TMP($J,"GMRK","G"_(1230+GCNTD))=$S(GK>0!(GK<0)!($E(GK)="0"):$J(GK/1.36,0,1),1:"")_$S(GMRVJ=1:"*",1:" ")
 . . Q
 . I GI="CG" D
 . . S ^TMP($J,"GMRK","G"_(1250+GCNTD))=GK_" "_GMRSITE,^TMP($J,"GMRK","G"_(1320+GCNTD))=$S(GK>0:$J(GK/.3937,0,2),1:"")
 . . Q
 I GI="B",GK'="" S ^TMP($J,"GMRK","G"_(250+GCNTD))=$S($L(GMRSITE," ")>3:$P(GMRSITE," ",2,4),1:GMRSITE) S:$L(GMRSITE," ")>3 ^TMP($J,"GMRK","G"_(1640+GCNTD))=$P(GMRSITE," ")
 I '(GI="T"!(GI="P")) D  Q
 . I GI="C" S GMRSITE=$S($L(GMRSITE," ")>3:"  "_$P(GMRSITE," "),1:"")
 . S ^TMP($J,"GMRK","G"_(GJ*16+GCNTD+1))=GK_$S(GMRVJ=1&(GI'="C"):"*",1:" ")_$S(GI="B":"",1:GMRSITE) S:GI="W" ^TMP($J,"GMRK","G"_(310+GCNTD))=$S(GK>0:$J(GK/2.2,0,2),1:"")
 . I GK>0,GI="W" D
 . . S GMRBMI="",GMRBMI(1)=GDT1,GMRBMI(2)=GK D CALBMI^GMVBMI(.GMRBMI)
 . . S ^TMP($J,"GMRK","G"_(330+GCNTD))=GMRBMI K GMRBMI
 I GI="T",GK>0 S ^TMP($J,"GMRK","G"_(GJ*16+GCNTD+1))=106-GK
 I GK'="",GI="P","UNAVAILABLEPASSREFUSED"'[$$UP^XLFSTR(GK) D
 . I GMRSITE(1)["RADIAL"!(GMRSITE(1)["APICAL")!(GMRSITE(1)["BRACHIAL") D
 . . S ^TMP($J,"GMRK","G"_(GJ*16+GCNTD+1))=170-GK/10
 S ^TMP($J,"GMRK","G"_(GJ+1*16+GCNTD+1))=GK_$S(GMRVJ=1:"*",1:" ")_$S(GI="T":GMRSITE,GI="P"&($L(GMRSITE," ")>3):"  "_$P(GMRSITE," "),1:"")
 I GI="T",GK>0 S ^TMP($J,"GMRK","G"_(210+GCNTD))=$S(GMRVJ=1:"T*",1:"T")
 I GI="P",GK'="","UNAVAILABLEPASSREFUSED"'[$$UP^XLFSTR(GK) D
 . I GMRSITE(1)["RADIAL"!(GMRSITE(1)["APICAL")!(GMRSITE(1)["BRACHIAL") S ^TMP($J,"GMRK","G"_(230+GCNTD))=$S(GMRVJ=1:"P*",1:"P")
 . S ^TMP($J,"GMRK","G"_(1300+GCNTD))=$S($L(GMRSITE," ")>3:$P(GMRSITE," ",2,4),1:GMRSITE)
 I GK>0,GI="T" S ^TMP($J,"GMRK","G"_(GJ*16+GCNTD+1))=$S(^("G"_(GJ*16+GCNTD+1))<1.5:1.5,^("G"_(GJ*16+GCNTD+1))>12.7:12.7,1:^("G"_(GJ*16+GCNTD+1))) S:^("G"_(GJ*16+GCNTD+1))<1.6!(^("G"_(GJ*16+GCNTD+1))>12.6) ^TMP($J,"GMRK","G"_(210+GCNTD))="T**"
 I GK'="",GI="P","UNAVAILABLEPASSREFUSED"'[$$UP^XLFSTR(GK) D
 . I GMRSITE(1)["RADIAL"!(GMRSITE(1)["APICAL")!(GMRSITE(1)["BRACHIAL") D
 . . S ^TMP($J,"GMRK","G"_(GJ*16+GCNTD+1))=$S(^("G"_(GJ*16+GCNTD+1))<1.5:1.5,^("G"_(GJ*16+GCNTD+1))>12.7:12.7,1:^("G"_(GJ*16+GCNTD+1)))
 . . S:^TMP($J,"GMRK","G"_(GJ*16+GCNTD+1))<1.6!(^("G"_(GJ*16+GCNTD+1))>12.6) ^TMP($J,"GMRK","G"_(230+GCNTD))="P**"
 Q
SETP ;INITIALIZE ^TMP FOR HEIGHT, WEIGHT AND V/M QUALIFIERS
 ;250+I: BP QUALIFIER  270+I: HEIGHT IN INCH  290+I: HEIGHT IN CM
 ;310+I:WEIGHT IN KG  330+I: BMI
 ;1100+I: PULSE OXIMETRY DATA  1130+I: PULSE OX. L/MIN
 ;1150+I: PULSE OX. %  1170+I: PULSE OX. METHOD
 ;1200+I: CVP DATA IN CM H2O  1230+I: CVP DATA IN MMHG
 ;1250+I: C/G DATA IN INCH  1270+I: C/G QUALIFIER  1300+I: PULSE QUALIFIER
 ;1320+I: C/G DATA IN CM 1640+I: THIRD PIECE OF BP 1660+I: PAIN
 F I=1:1:10 D
 . S (^TMP($J,"GMRK","G"_(210+I)),^("G"_(230+I)),^("G"_(250+I)),^("G"_(270+I)),^("G"_(290+I)),^("G"_(310+I)),^("G"_(330+I)),^("G"_(1300+I)))=""
 . S (^TMP($J,"GMRK","G"_(1100+I)),^("G"_(1130+I)),^("G"_(1150+I)),^("G"_(1170+I)),^("G"_(1200+I)),^("G"_(1230+I)),^("G"_(1250+I)),^("G"_(1270+I)))=""
 . S (^TMP($J,"GMRK","G"_(1320+I)),^("G"_(1640+I)),^("G"_(1660+I)))=""
 Q
