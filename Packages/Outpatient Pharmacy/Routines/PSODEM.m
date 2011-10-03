PSODEM ;BHAM ISC/SAB - PATIENT DEMOGRAPHICS ; 02/17/93 12:29
 ;;7.0;OUTPATIENT PHARMACY;**5,19,233,258,326**;DEC 1997;Build 11
GET S DFN=DA D 6^VADPT,PID^VADPT U IO W @IOF,!,VADM(1)
 I +VAPA(9) W !?5,"(TEMP ADDRESS from "_$P(VAPA(9),"^",2)_" till "_$S($P(VAPA(10),"^",2)]"":$P(VAPA(10),"^",2),1:"(no end date)")_")"
 W !,VAPA(1),?40,"DOB:   ",$S(+VADM(3):$P(VADM(3),"^",2),1:"UNKNOWN") W:VAPA(2)]"" !,VAPA(2) W:VAPA(3)]"" !,VAPA(3)
 W !,VAPA(4),?40,"PHONE: "_VAPA(8),!,$P(VAPA(5),"^",2)_"  "_$S(VAPA(11)]"":$P(VAPA(11),"^",2),1:VAPA(6)),?40,"ELIG:  "_$P(VAEL(1),"^",2) W:+VAEL(3) !?40,"SC%:   "_$P(VAEL(3),"^",2)
 I $D(^PS(55,DFN,0)) W:$P(^(0),"^",2) !,"CANNOT USE SAFETY CAPS." I +$P(^(0),"^",4) W ?40,"DIALYSIS PATIENT."
 I $G(^PS(55,DFN,1))]"" S X=^(1) W !!?5,"Pharmacy Narrative: " F I=1:1 Q:$P(X," ",I,99)=""  W:$X+$L($P(X," ",I))+$L(" ")>IOM ! W $P(X," ",I)," "
RE S (WT,HT)="",X="GMRVUTL" X ^%ZOSF("TEST") I $T D
 .F GMRVSTR="WT","HT" S VM=GMRVSTR D EN6^GMRVUTL S @VM=X,$P(@VM,"^")=$E($P(@VM,"^"),4,5)_"/"_$E($P(@VM,"^"),6,7)_"/"_($E($P(@VM,"^"),1,3)+1700)
 .S X=$P(WT,"^",8),Y=$J(X/2.2,0,2),$P(WT,"^",9)=Y,X=$P(HT,"^",8),Y=$J(2.54*X,0,2),$P(HT,"^",9)=Y
 Q:$G(POERR)
 W !!,"WEIGHT(Kg): " W:+$P(WT,"^",8) $P(WT,"^",9)_" ("_$P(WT,"^")_")" W ?41,"HEIGHT(cm): " W:$P(HT,"^",8) $P(HT,"^",9)_" ("_$P(HT,"^")_")" K VM,WT,HT
 S PSLC=0 G MA:$P($G(^DPT(DFN,.17)),"^",2)'="I"
 I '$D(VAEL(1)) D ELIG^VADPT W !!,"ELIGIBILITY: ",$P(VAEL(1),"^",2) W:+VAEL(3) ?$X+5,"SC%: "_$P(VAEL(3),"^",2) S PSLC=PSLC+2
MA K SC W !,"DISABILITIES: " S PSLC=PSLC+2
 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  S I1=$S($D(^DPT(DFN,.372,I,0)):^(0),1:"") D:+I1
 .S PSDIS=$S($P($G(^DIC(31,+I1,0)),"^")]""&($P($G(^(0)),"^",4)']""):$P(^(0),"^"),$P($G(^DIC(31,+I1,0)),"^",4)]"":$P(^(0),"^",4),1:""),PSCNT=$P(I1,"^",2)
 .X:($X+$L(PSDIS)+7)>(IOM-8) "W !?14 S PSLC=PSLC+1" W PSDIS,"-",PSCNT,"% (",$S($P(I1,"^",3):"SC",1:"NSC"),"), "
 .I $E(IOST)="C",$Y+4>IOSL,$D(PSTYPE) K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DTOUT W @IOF,?13
 X "N X S X=""GMRADPT"" X ^%ZOSF(""TEST"") Q" I $T D:'$D(PSOPTPST) GMRA
Q K SC,I1,VAROOT,Y,AL,I,X,Y,PSCNT,PSLC,PSDIS D:$G(PSTYPE)']"" KVA^VADPT Q
GMRA K ^TMP($J,"AL") S GMRA="0^0^111" D ^GMRADPT I GMRAL D
 .F DR=0:0 S DR=$O(GMRAL(DR)) Q:'DR  S ^TMP($J,"AL",$S('$P(GMRAL(DR),"^",5):1,1:2),$P(GMRAL(DR),"^",7),$P(GMRAL(DR),"^",2))=""
 .W !!,"ALLERGIES: " S (DR,TY)="" F I=0:0 S TY=$O(^TMP($J,"AL",1,TY)) Q:TY=""  F D=0:0 S DR=$O(^TMP($J,"AL",1,TY,DR)) Q:DR=""  W:$X+$L(DR)+$L(", ")>IOM !?11 W DR_", " D
 ..I $E(IOST)="C",$Y+4>IOSL,$D(PSTYPE) W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DTOUT W @IOF,?18
 .W !!,"ADVERSE REACTIONS: " S (DR,TY)="" F I=0:0 S TY=$O(^TMP($J,"AL",2,TY)) Q:TY=""  F D=0:0 S DR=$O(^TMP($J,"AL",2,TY,DR)) Q:DR=""  W:$X+$L(DR)+$L(", ")>IOM !?19 W DR_", " D
 ..I $E(IOST)="C",$Y+4>IOSL,$D(PSTYPE) W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DTOUT W @IOF,?18
 I $G(GMRAL)']"" F AD="ALLERGIES:","ADVERSE REACTIONS:" W !!,AD I $G(PSOFROM)="" F ADL=1:1:IOM-($L(AD)+5) W "_"
 I GMRAL=0 W !!,"ALLERGIES: NKA",!!,"ADVERSE REACTIONS:"
 W ! K TY,D,I,GMRA,GMRAL,DR,AD,ADL,^TMP($J,"AL") Q
