PSGVBWU ;BIR/CML3,MV-GET ORDERS FOR COMPLETE/VERIFY ; 6/2/10 10:44am
 ;;5.0; INPATIENT MEDICATIONS ;**3,44,47,67,58,110,111,196,241**;16 DEC 97;Build 10
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PS(51.1 is supported by DBIA #2177
 ;
ECHK(DFN,O,DT,SD) ;
 N OK S OK=0
 I $P($G(^PS(55,DFN,5,O,0)),U,9)'["D" S ND=$G(^(0)) Q:ND="" 0  S ND4=$G(^(4)) D
 .;I "DE"'[$P($G(^PS(55,DFN,5,O,0)),U,9) S ND=$G(^(0)) Q:ND="" 0  S ND4=$G(^(4)) D
 .I $S(SD>PSGDT:$S(ND="":1,'$P(ND4,U,$S(PSJSYSU:PSJSYSU,1:1)):1,$P(ND4,U,13):1,$P(ND4,U,19):1,$P(ND4,U,23):1,1:$P(ND4,U,16)),$P(ND,U,7)="O":$S(ND4="":1,1:'$P(ND4,U,$S(PSJSYSU:PSJSYSU,1:1))),1:$P(ND4,U,16)) S OK=1
 Q OK
ECHK2(DFN,O,DT,SD) ;
 N OK S OK=0
 ;*PSJ*5*241: Include one-time IV orders
 N SCH,STYPE S STYPE=0,SCH=$P($G(^PS(55,DFN,"IV",O,0)),U,9)
 S:SCH]"" SCH=$O(^PS(51.1,"APPSJ",SCH,STYPE)) S:SCH]"" STYPE=$P(^PS(51.1,SCH,0),U,5)
 I $P($G(^PS(55,DFN,"IV",O,0)),U,17)'["D" S ND=$G(^(0)) Q:ND="" 0  S ND4=$G(^(4)) D:(SD>PSGDT)!((SD>PSJPAD)&($G(STYPE)="O"))
 . I (+PSJSYSU=1)&('$P(ND4,U,+PSJSYSU)) S OK=1 Q
 . I (+PSJSYSU=3)&('$P(ND4,U,+PSJSYSU+1)) S OK=1 Q
 Q OK
 ;
SET ;
 I ON["P",$G(PSJCOM)]"",$G(PRNTON)=+PSJCOM Q
 I ON["P",$G(PSJCOM)]"" S PRNTON=+PSJCOM,ON=+PSJCOM
 S PSJPRIO=$S($G(PSJPRIO)="S":"A",1:"Z"),^TMP("PSJON",$J,PSJPRIO,LD_U_ON)=""
 Q
 ;
CNTORDRS ; Display # pending orders by type and ward group
 K ^TMP("PSJ",$J) D:$G(IOST(0)) ENS^%ZISS
 N DFN,DIRUT,ON,TYP,PSGODT,PSJWD,PSJWG,X,X1,X2
 S X1=$P(PSGDT,"."),X2=-2 D C^%DTC S PSGODT=X_(PSGDT#1)
 W !!,"Searching for Pending and Non-Verified orders"
 F STAT="P","N","I" F DFN=0:0 S DFN=$O(^PS(53.1,"AS",STAT,DFN)) Q:'DFN  D
 .W "." S PSJWG=$$WGNM($P($G(^DPT(DFN,.1)),U))
 .F ON=0:0 S ON=$O(^PS(53.1,"AS",STAT,DFN,ON)) Q:'ON  D
 .. N OWG,A,CGN,CGNM
 ..;GMZ:PSJ*5*196;Display order totals on all clinic groups in which a clinic belongs.
 .. S OWG=PSJWG I PSJWG="ZZ",$D(^PS(53.1,ON,"DSS")) S A=^("DSS") D CGNM(A,OWG,.CGNM) D
 ... I '$D(CGNM) S CGN=$P(^SC(+A,0),"^")_"^C",PSJWG=$P(^SC(+A,0),"^")_"^C" D
 ....I CGN]"" S TYP=$P($G(^PS(53.1,ON,0)),U,4),OTYP=$S((STAT="P")&(TYP="F"):1,(STAT="P")&(TYP="I"):1,(STAT="P")&(TYP="U"):2,TYP="F":3,TYP="I":3,1:4) D CNTSET(PSJWG,OTYP) S PSJWG=OWG Q 
 ... S PSJSQ="" F  S PSJSQ=$O(CGNM(+A,PSJSQ)) Q:PSJSQ=""  D
 .... S (PSJWG,CGN)=$P(CGNM(+A,PSJSQ),"^",1)_"^CG" I CGN]"" S TYP=$P($G(^PS(53.1,ON,0)),U,4),OTYP=$S((STAT="P")&(TYP="F"):1,(STAT="P")&(TYP="I"):1,(STAT="P")&(TYP="U"):2,TYP="F":3,TYP="I":3,1:4) D CNTSET(PSJWG,OTYP) S PSJWG=OWG
 .. Q:$G(CGN)]""  S TYP=$P($G(^PS(53.1,ON,0)),U,4),OTYP=$S((STAT="P")&(TYP="F"):1,(STAT="P")&(TYP="I"):1,(STAT="P")&(TYP="U"):2,TYP="F":3,TYP="I":3,1:4) D CNTSET(PSJWG,OTYP) S PSJWG=OWG
 ;
 I '$D(^XTMP("PSJPVNV")) D
 .N PSJXR S PSJXR=$S(+PSJSYSU=3:"APV",1:"ANV") F DFN=0:0 S DFN=$O(^PS(55,PSJXR,DFN)) Q:'DFN  D
 ..W "." D IN5^VADPT S PSJPAD=+VAIP(3) K VAIP F PSGORD=0:0 S PSGORD=$O(^PS(55,PSJXR,DFN,PSGORD)) Q:'PSGORD  D
 ...S PSGST=$P($G(^PS(55,DFN,5,PSGORD,0)),U,7),PSGFD=$P($G(^(2)),U,4) I ((PSGST="O")&(PSJPAD>0)&(PSGFD>PSJPAD))!((PSGST'="O")&(PSGFD'<PSGODT)) I $$ECHK(DFN,PSGORD,PSGDT,PSGFD) S PSJWD=$P($G(^DPT(DFN,.1)),U) I PSJWD]"" D
 ....S PSJWG=$$WGNM(PSJWD)
 .... N OWG,A
 ....;*PSJ*5*241:Rewrote CGNM call (5 lines)
 .... N CGNM,PSJWG1 S OWG=PSJWG I PSJWG="ZZ",$D(^PS(55,DFN,5,PSGORD,8)) S A=^(8) D CGNM(A,OWG,.CGNM) D
 ..... I '$D(CGNM) S PSJWG=$P(^SC(+A,0),"^")_"^C" D:PSJWG]"" CNTSET(PSJWG,4)
 ..... I $D(CGNM) S PSJWG="" F  S PSJWG=$O(CGNM(+A,PSJWG)) Q:PSJWG=""   D
 ......S PSJWG1=$P(CGNM(+A,PSJWG),U,1)_"^CG" D CNTSET(PSJWG1,4)
 .... D:(OWG'="ZZ")!('$D(^PS(55,DFN,5,PSGORD,8))) CNTSET(PSJWG,4) S PSJWG=OWG
 .N PSJXR S PSJXR=$S(+PSJSYSU=3:"APIV",1:"ANIV") F DFN=0:0 S DFN=$O(^PS(55,PSJXR,DFN)) Q:'DFN  D
 ..W "." D IN5^VADPT S PSJPAD=+VAIP(3) K VAIP F PSGORD=0:0 S PSGORD=$O(^PS(55,PSJXR,DFN,PSGORD)) Q:'PSGORD  D
 ...S PSGFD=$P($G(^PS(55,DFN,"IV",PSGORD,0)),U,3) I $$ECHK2(DFN,PSGORD,PSGDT,PSGFD) S PSJWD=$P($G(^DPT(DFN,.1)),U) I PSJWD]"" D
 ....S PSJWG=$$WGNM(PSJWD)
 .... N OWG,A
 ....;*PSJ*5*241: Rewrote CGNM call (5 lines)
 .... N CGNM,PSJWG1 S OWG=PSJWG I PSJWG="ZZ",$D(^PS(55,DFN,"IV",PSGORD,"DSS")) S A=^("DSS") D CGNM(A,OWG,.CGNM) D
 ..... I '$D(CGNM) S PSJWG=$P(^SC(+A,0),"^")_"^C" D:PSJWG]"" CNTSET(PSJWG,3)
 ..... I $D(CGNM) S PSJWG="" F  S PSJWG=$O(CGNM(+A,PSJWG)) Q:PSJWG=""  D
 ...... S PSJWG1=$P(CGNM(+A,PSJWG),U,1)_"^CG" D CNTSET(PSJWG1,3)
 .... D:(OWG'="ZZ")!('$D(^PS(55,DFN,5,PSGORD,8))) CNTSET(PSJWG,3) S PSJWG=OWG
 I $D(^XTMP("PSJPVNV")) S PSJWD="" F  S PSJWD=$O(^DPT("CN",PSJWD)) Q:PSJWD=""  S PSJWG=$$WGNM(PSJWD) F DFN=0:0 S DFN=$O(^DPT("CN",PSJWD,DFN)) Q:'DFN  D
 .; removed ref to ^DGPM
 .;S PSJPAD=9999999.9999999-$O(^DGPM("ATID1",DFN,0))
 .D IN5^VADPT S PSJPAD=+VAIP(3) K VAIP
 .W "."
 .F PSJST="C","O","OC","P","R" F PSGFD=$S(PSJST="O":PSJPAD,1:PSGODT):0 S PSGFD=$O(^PS(55,DFN,5,"AU",PSJST,PSGFD)) Q:'PSGFD  D
 ..F PSGORD=0:0 S PSGORD=$O(^PS(55,DFN,5,"AU",PSJST,PSGFD,PSGORD)) Q:'PSGORD  I $$ECHK(DFN,PSGORD,PSGDT,PSGFD) D
 ... N OWG,A
 ...;*PSJ*5*241: Rewrote CGNM call (5 lines)
 ... N CGNM,PSJWG1 S OWG=PSJWG I PSJWG="ZZ",$D(^PS(55,DFN,"IV",PSGORD,"DSS")) D CGNM(A,OWG,.CGNM) D
 .... I '$D(CGNM) S PSJWG=$P(^SC(+A,0),"^")_"^C" D:PSJWG]"" CNTSET(PSJWG,3)
 .... I $D(CGNM) S PSJWG="" F  S PSJWG=$O(CGNM(+A,PSJWG)) Q:PSJWG=""  D
 ..... S PSJWG1=$P(CGNM(+A,PSJWG),U,1)_"^CG" D CNTSET(PSJWG1,3)
 ... D:(OWG'="ZZ")!('$D(^PS(55,DFN,5,PSGORD,8))) CNTSET(PSJWG,3) S PSJWG=OWG
 .F SD=+PSJPAD:0 S SD=$O(^PS(55,PSGP,"IV","AIS",SD)) Q:'SD  F O=0:0 S O=$O(^PS(55,PSGP,"IV","AIS",SD,O)) Q:'O  S ON=O_"V" I $$ECHK2(PSGP,O,PSGDT,SD) D
 .. N OWG,A
 ..;*PSJ*5*241: Rewrote CGNM call (5 lines)
 .. N CGNM,PSJWG1 S OWG=PSJWG I PSJWG="ZZ",$D(^PS(55,DFN,"IV",PSGORD,"DSS")) D CGNM(A,OWG,.CGNM) D
 ... I '$D(CGNM) S PSJWG=$P(^SC(+A,0),"^")_"^C" D:PSJWG]"" CNTSET(PSJWG,3)
 ... I $D(CGNM) S PSJWG="" F  S PSJWG=$O(CGNM(+A,PSJWG)) Q:PSJWG=""  D
 .... S PSJWG1=$P(CGNM(+A,PSJWG),U,1)_"^CG" D CNTSET(PSJWG1,3)
 .. D:(OWG'="ZZ")!('$D(^PS(55,DFN,5,PSGORD,8))) CNTSET(PSJWG,3) S PSJWG=OWG
 ;
DISPLAY ;
 N H,I
 D CNTHEAD I '$D(^TMP("PSJ",$J)) W ?21,"No pending/non-verified orders found.",! Q
 S H("WG")="Ward Groups",H("CG")="Clinic Groups",H("C")="Clinics"
 F I="WG","CG","C" I $D(^TMP("PSJ",$J,I)) D
 . I I'="CG" W !,H(I),!!
 . I I="CG" W !,H(I),?13,"- The same order may be listed under more than 1 Clinic Group;",!,?15,"Therefore sum of Orders listed may not match total number of",!,?15,"pending orders. ",!!
 . S WG="" F  S WG=$O(^TMP("PSJ",$J,I,WG)) Q:WG=""!$D(DIRUT)  S X=$G(^(WG)) D
 .. ;W $S(WG="ZZ":"^OTHER",1:WG),?30,$J(+X,6),?44,$J(+$P(X,U,2),6),?58,$J(+$P(X,U,3),6),?72,$J(+$P(X,U,4),6),!
 .. W $S(WG="ZZ":"^OTHER",1:WG),?26,$J(+X,6),?36,$J(+$P(X,U,2),6),?51,$J(+$P(X,U,3),6),?63,$J(+$P(X,U,4),6),!
 .. I $Y>(IOSL-2) N DIR S DIR(0)="E" D ^DIR Q:$D(DIRUT)  D CNTHEAD
 Q
CNTSET(WG,X) ; Update counters for ward group totals
 ; Input: WG - Ward Group IEN
 ;         X - piece identifying order type.
 I $P(WG,"^",2)="" S $P(^TMP("PSJ",$J,"WG",WG),U,X)=$P($G(^TMP("PSJ",$J,"WG",WG)),U,X)+1 Q
 I $P(WG,"^",2)]"" S $P(^TMP("PSJ",$J,$P(WG,"^",2),$P(WG,"^")),U,X)=$P($G(^TMP("PSJ",$J,$P(WG,"^",2),$P(WG,"^"))),U,X)+1 Q
 Q
 ;
WGNM(WD) ; DETERMINE WARD GROUP NAME
 N WG
 I WD]"" S WG=+$O(^PS(57.5,"AB",+$O(^DIC(42,"B",WD,0)),0)),WG=$P($G(^PS(57.5,WG,0)),U)
 S:$G(WG)="" WG="ZZ"
 Q WG
 ;
CGNM(A,WGN,CGNM) ;DETERMINE CLINIC GROUP NAME
 N B,CGN
 ;I $P(A,"^",2)="" Q WGN
 S (B,CGN)="" F  S B=$O(^PS(57.8,"AC",+A,B)) Q:B=""  D
 . S CGNM(+A,B)=$P(^PS(57.8,B,0),"^")
 I $P(CGN,"^")="" S CGN=$P(^SC(+A,0),"^")_"^C"
 Q
 ;
CNTHEAD ; Header for order count.
 ;W @IOF,!,?16,"Pending/Non-Verified Order Totals by Ward Group",!!,?29,"Pending",?43,"Pending",?57,"Pending",!
 ;W "Ward Group",?30,"Fluids",?48,"IV",?55,"Unit Dose",?66,"Non-Verified",!!
 W @IOF,!,?16,"Pending/Non-Verified Order Totals by Ward Group/Clinic Location",!!,?33,"Pending",?56,"Non-Verified",!
 W "Ward Group/Clinic Location",?30,"IV",?40,"UD",?55,"IV",?67,"UD",!
 Q
 ;
ENGORD ; get and sort order
 N PSJCOM,PRNTON
 D NOW^%DTC S PSGDT=+$E(%,1,12),X1=$P(%,"."),X2=-2 D C^%DTC S PSGODT=X_(PSGDT#1),HDT=$$ENDTC^PSGMI(PSGDT),UDU=$P(PSJSYSU,";",3)>1 K ^TMP("PSJON",$J)
 W !!,"...a few moments, please..."
 I PSJTOO'=2 F PSGO2=+PSJPAD:0 S PSGO2=$O(^PS(55,PSGP,5,"AUS",PSGO2)) Q:'PSGO2  Q:PSGO2>PSGDT  F PSGO3=0:0 S PSGO3=$O(^PS(55,PSGP,5,"AUS",PSGO2,PSGO3)) Q:'PSGO3  I $D(^PS(55,PSGP,5,PSGO3,0)) S PSGO4=^(0) I "DEH"'[$E($P(PSGO4,"^",9)) D ENUH
 K PSGO1,PSGO2,PSGO3,PSGO4
 I PSJTOO'=1 F SD="I","P" F O=0:0 S O=$O(^PS(53.1,"AS",SD,PSGP,O)) Q:'O  D
 .S ND=$G(^PS(53.1,O,0)),PSJPRIO=$P($G(^(.2)),U,4),PSJCOM=$P($G(^(.2)),U,8),LD=$P($G(^PS(53.1,O,0)),U,16),ON=O_"P"
 .I $S(PSJPAC=3:1,PSJPAC=1&($P(ND,U,4)="U"):1,PSJPAC=2&($P(ND,U,4)'="U"):1,+$P(ND,U,13)&$G(PSJRNF):1,+$P(ND,U,13)&$G(PSJIRNF):1,1:0) D SET
 Q:PSJTOO=2
 F ST="C","O","OC","P","R" F SD=+PSJPAD:0 S SD=$O(^PS(55,PSGP,5,"AU",ST,SD)) Q:'SD  F O=0:0 S O=$O(^PS(55,PSGP,5,"AU",ST,SD,O)) Q:'O  S ON=O_"U" I $$ECHK(PSGP,O,PSGDT,SD) S LD=$P($G(^PS(55,PSGP,5,O,0)),U,16) D SET
 F O=0:0 S O=$O(^PS(53.1,"AS","N",PSGP,O)) Q:'O  S LD=$P($G(^PS(53.1,O,0)),U,16),PSJCOM=$P($G(^(.2)),U,8) S ON=O_"P" D SET
 F SD=+PSJPAD:0 S SD=$O(^PS(55,PSGP,"IV","AIS",SD)) Q:'SD  F O=0:0 S O=$O(^PS(55,PSGP,"IV","AIS",SD,O)) Q:'O  S ON=O_"V" I $$ECHK2(PSGP,O,PSGDT,SD) S LD=$P($G(^PS(55,PSGP,"IV",O,2)),U) D SET
 Q
 ;
ENUH ;
 S $P(^PS(55,PSGP,5,PSGO3,0),"^",9)="E" D EN1^PSJHL2(PSGP,"SC",PSGO3_"U")
 Q
GOTOP ; Skip to a specific patient in list.
 I '$$HIDDEN^PSJLMUTL("JUMP") S VALMBCK="R" Q
 K PSJGOTO,DIR S DIR(0)="SM^J:Jump to a specific patient;E:Exit",DIR("A")="Select Action: ",DIR("B")="Exit" D ^DIR
 Q:"JE"'[Y
 I Y="E" S PSJGOTO=Y Q
 K DIR S DIR(0)="PO^2:AEMQZ",DIR("S")="I $P(^(0),U)]"""",$D(^TMP(""PSJSELECT"",$J,""B"",$P(^(0),U)))",DIR("??")="^D GOTOPH^PSGVBWU" D ^DIR I Y<0 S PSGTOTO=Y Q
 S VALMBCK="R",PSJGOTO=$S($P(Y,U,2)="":"E",1:$O(^TMP("PSJSELECT",$J,"B",$P(Y,U,2),0)))
 Q
 ;
GOTOPH ;
 F X=0:0 S X=$O(^TMP("PSJSELECT",$J,X)) Q:'X  W !,$P($G(^TMP("PSJSELECT",$J,X)),U) I X#IOSL=0 N DIR S DIR(0)="E" D ^DIR Q:$D(DIRUT)
 Q
 Q
