GMVGGR2 ;HOIFO/YH,FT-SET ^TMP($J) GLOBAL ;Nov 06, 2018@14:05
 ;;5.0;GEN. MED. REC. - VITALS;**3,23**;Oct 31, 2002;Build 25
 ;CONTINUTATION OF GMVGGR1
 ; OSE/SMH date i18n changes (c) Sam Habiel 2018 (see code for DATE)
 ; Licensed under Apache 2.0
 ;
 ; This routine uses the following IAs:
 ; #10061 - ^VADPT calls           (supported)
 ;
GRAPH ;
 D:GMR=0 SETV
 I '$D(^TMP($J,"GMRVG")) S GN=GN+1,^TMP($J,GN)="NO DATA",RESULT=$NA(^TMP($J)) Q
 K GMRQUAL S GDT=0 F  S GDT=$O(^TMP($J,"GMRVG",GDT)) Q:GDT'>0  D
 .  S:GMR=0 GN=GN+1,^TMP($J,GN)="^^^^^^^^^^^^^^^^^^^^^" D DATE
 .  S GI="" F  S GI=$O(^TMP($J,"GMRVG",GDT,GI)) Q:GI=""  D
 . . S GK="" F  S GK=$O(^TMP($J,"GMRVG",GDT,GI,GK)) Q:GK=""  D SETA
 D KVAR^VADPT K VA
 ;RETURN CALL ROUTINE WITH QUALIFIERS
 I GMR=1,$D(GMRQUAL) D
 . S (GQ,GQ(1))=""
 . F  S GQ=$O(GMRQUAL(GQ)) Q:GQ=""  D
 . . S I=0,GQ(1)=$S(GQ="T":"TEMPERATURE",GQ="P":"PULSE",GQ="R":"RESPIRATION",GQ="B":"BLOOD PRESSURE",GQ="H":"HEIGHT",GQ="W":"WEIGHT",GQ="CVP":"CVP",GQ="PO2":"PULSE OXIMETRY",GQ="CG":"CIRCUMFERENCE/GIRTH",1:"")
 . . Q:GQ(1)=""  S GN=GN+1,^TMP($J,GN)=GQ(1)_"--- "
 . . S GQ(2)="" F  S GQ(2)=$O(GMRQUAL(GQ,GQ(2))) Q:GQ(2)=""  S I=I+1 S:I>1 ^TMP($J,GN)=^(GN)_"," S ^TMP($J,GN)=^TMP($J,GN)_" "_GQ(2)
 K GQ,GG,GI,GMRVJ,GSYNO,GHOLD,GLINE,GMRQUAL
 K ^TMP($J,"GMR"),^TMP($J,"GMRVG")
 S RESULT=$NA(^TMP($J))
 Q
SETV ;Set patient data in ^TMP($J,"GMRK" global
 D DEM^VADPT,INP^VADPT
 S GN=1,^TMP($J,GN)=$S(VADM(1)'="":VADM(1),1:"         ")_"  "_$S(VADM(2)'="":$E($P(VADM(2),"^",2),8,11),1:" ")_"  "_$S($D(VADM(3)):$P(VADM(3),"^",2),1:" ")_"  "_$S($D(VADM(4)):VADM(4),1:" ")_" (Yrs)"
 S ^TMP($J,GN)=^(GN)_"  "_$S($D(VADM(5)):$P(VADM(5),"^",2),1:" ")
 S GN=2,^TMP($J,GN)="Unit: "_$P($G(VAIN(4)),"^",2)_"   Room: "_$P($G(VAIN(5)),"-",1,2)
 I '$D(GMRVHLOC) S GMRVHLOC=$$HOSPLOC^GMVUTL1(+$G(VAIN(4)))
 S GN=3,^TMP($J,GN)="Division: "_$$DIVISION^GMVUTL1(+GMRVHLOC)
 S GN=4,^TMP($J,GN)=GSTRFIN
 Q
DATE ;
 S:GMR=0 $P(^TMP($J,GN),"^")=$E(GDT,4,5)_"/"_$E(GDT,6,7)_"/"_$E(GDT,2,3)   ; OSE/SMH - Move date conversion from Delphi to here; don't change - to / in Delphi
 I GMR=0,$G(DUZ("LANG"))>1 S $P(^TMP($J,GN),"^")=$$FMTE^XLFDT($P(GDT,".")) ; OSE/SMH - modified for i18n changes
 S:GMR=0 Y=$E($P(GDT,".",2)_"000000",1,6),$P(^TMP($J,GN),"^",2)=$E(Y,1,2)_":"_$E(Y,3,4)_":"_$E(Y,5,6)
 Q
SETA ;Store measurements in ^TMP($J, global
 N GMVNODE
 S GMVNODE=$G(^TMP($J,"GMRVG",GDT,GI,GK))
 S $P(^TMP($J,GN),"^",22)=$P(GMVNODE,U,5)
 S $P(^TMP($J,GN),"^",23)=$P(GMVNODE,U,6)
 S $P(^TMP($J,GN),"^",24)=$P(GMVNODE,U,7)
 S GK(1)=GK
 I GK(1)="Unavailable" S GK(1)="Unavail"
 I GI="I" S:GMR=0 $P(^TMP($J,GN),"^",17)=GK(1) Q
 I GI="O" S:GMR=0 $P(^TMP($J,GN),"^",18)=GK(1) Q
 I GI="PN" S:GMR=0 $P(^TMP($J,GN),"^",19)=GK(1) Q
 S (GMRSITE,GMRSITE(1),GINF,GMRVJ)=""
 I GK(1)'="" D  Q:GMR=1
 . S GMRSITE(1)=$P(GMVNODE,U,1),GMRVJ=$P(GMVNODE,U,2),GINF=$P(GMVNODE,U,4)
 . I GMRSITE(1)'="" D SYNOARY^GMVLGQU
 I GI="R" S $P(^TMP($J,GN),"^",5)=GK(1)_$S(GMRVJ=1:"*",1:"")_"- "_GMRSITE Q
 I GI="H" D  Q
 . S $P(^TMP($J,GN),"^",11)=GK(1)_"- "_GMRSITE,$P(^TMP($J,GN),"^",12)=$S(GK(1)>0:$J(GK(1)*2.54,0,2),1:"") S:GK(1)>0 GMRHT=(GK(1)*2.54)/100
 I GI="PO2" D  Q
 . S (GINF(1),GINF(2))="" I GINF'="" D PO2^GMVLGQU(.GINF)
 . S $P(^TMP($J,GN),"^",6)=GK(1)_$S(GMRVJ=1:"*",1:"")_"- "_GMRSITE_"-"_GINF(1)_"-"_GINF(2)
 I GI="CVP" D  Q
 . S $P(^TMP($J,GN),"^",15)=$S(GK(1)>0!(GK(1)<0):$J(GK(1),0,1),1:GK(1))_$S(GMRVJ=1:"*",1:"")
 . S $P(^TMP($J,GN),"^",16)=$S(GK(1)>0!(GK(1)<0)!($E(GK(1))="0"):$J(GK(1)/1.36,0,1),1:"")_$S(GMRVJ=1:"*",1:"")
 I GI="CG" D  Q
 . S $P(^TMP($J,GN),"^",13)=GK(1)_"- "_GMRSITE,$P(^TMP($J,GN),"^",14)=$S(GK(1)>0:$J(GK(1)/.3937,0,2),1:"")
 I GI="B",GK(1)'="" S $P(^TMP($J,GN),"^",7)=GK(1)_$S(GMRVJ=1:"*",1:"")_"- "_GMRSITE
 I GI="W" S $P(^TMP($J,GN),"^",8)=GK(1)_"- "_GMRSITE,$P(^(GN),"^",9)=$S(GK(1)>0:$J(GK(1)*.45359237,0,2),1:"")
 I GK(1)>0,GI="W" D  Q
  . S GHOLD=GI,GMRBMI="",GMRBMI(1)=GDT,GMRBMI(2)=GK(1) D CALBMI^GMVBMI(.GMRBMI) S GI=GHOLD
  . S $P(^TMP($J,GN),"^",10)=GMRBMI K GMRBMI
 I GI="T" S $P(^TMP($J,GN),"^",3)=GK(1)_$S(GMRVJ=1:"*",1:"")_"- "_GMRSITE Q
 I GI="P" S $P(^TMP($J,GN),"^",4)=GK(1)_$S(GMRVJ=1:"*",1:"")_"- "_GMRSITE
 Q
