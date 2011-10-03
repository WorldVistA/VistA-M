PSNSTCK ;BIR/CCH&WRT-size and type check ; 02/01/99 7:29
 ;;4.0; NATIONAL DRUG FILE;**5**; 30 Oct 98
 ;
 ; reference to ^PSDRUG supported by IA# 221
 ;
 K LIST,^TMP($J,"PSNPSPS"),^TMP($J,"PSNDFPK") S PSNARY=0,DDD=$O(^PS(50.609,"B","OTHER",0)),EEE=$O(^PS(50.608,"B","OTHER",0)) D PACKAGE,ARR0,SIZE
 K DDD,EEE,FFF,GGG
 Q
PACKAGE S PSNFORM=$P(^PSNDF(50.68,PSNFNM,0),"^")
 S K=PSNFNM,X=$$PSPT^PSNAPIS(,K,.LIST) S PTPS="" F  S PTPS=$O(LIST(PTPS)) Q:'PTPS  S XX=LIST(PTPS) F ST=1:1:X S ^TMP($J,"PSNPSPS",$P(XX,"^",2),$P(XX,"^",4))=$P(XX,"^",1)_"^"_$P(XX,"^",3),^TMP($J,"PSNPSPS","OTHER","OTHER")=DDD_"^"_EEE
 Q
SIZE ; Pick Size & Type Combo
 R !?10,"Enter Package Size & Type Combination: ",ANS:DTIME S:'$T ANS="^" I ANS["^" S PSNFL=1 Q
 I ANS["?" D SZ1^PSNHELP K ANS G SIZE
 I ANS="" S PSNSIZE=$O(^PS(50.609,"B","OTHER",0)),PSNTYPE=$O(^PS(50.608,"B","OTHER",0)) G ASK
 I '$D(^TMP($J,"PSNDFPK",ANS)) W !,"Invalid Answer" G SIZE
 G:'$D(^TMP($J,"PSNDFPK",ANS)) SIZE S FFF=$O(^TMP($J,"PSNDFPK",ANS,0)),GGG=$O(^TMP($J,"PSNDFPK",ANS,FFF,0)),PSNSZ=$P(^TMP($J,"PSNDFPK",ANS,FFF,GGG),"^"),PSNTYP=$P(^TMP($J,"PSNDFPK",ANS,FFF,GGG),"^",2),PSNSIZE=PSNSZ,PSNTYPE=PSNTYP
ASK D PKSIZE^PSNOUT,PKTYPE^PSNOUT W !!,"Local drug ",$P(^PSDRUG(PSNB,0),"^",1),!,"matches ",?11,PSNFORM,!,"PACKAGE SIZE: ",PSNSZE,!,"PACKAGE TYPE: ",PSNTPE
 W !!,"< Enter ""Y"" for yes >"
 W !,"< Enter ""N"" for no >"
 W:'$D(Z9) !,"< Press return for next drug or ""^"" to quit>"
 W ?50 R "OK? :  ",ANS:DTIME S:'$T ANS="^" I ANS']"" W ?60,"Drug not matched" S:$D(Z9) PSNFL=1 Q
 I "Nn"[$E(ANS) G @PSNVAR
 I ANS["^" S PSNFL=1 Q
 I "YNyn"'[$E(ANS) D ASK1^PSNHELP G ASK
 Q
ARR0 W !,"CHOOSE FROM: " S PP="" F  S PP=$O(^TMP($J,"PSNPSPS",PP)) Q:PP=""  S QQ="" F  S QQ=$O(^TMP($J,"PSNPSPS",PP,QQ)) Q:QQ=""  S RR=^TMP($J,"PSNPSPS",PP,QQ) D ARR1
 Q
ARR1 S PSNARY=PSNARY+1 S ^TMP($J,"PSNDFPK",PSNARY,PP,QQ)=RR W !?2,PSNARY,"    ",PP,"  ",QQ
 Q
