LRBLPED ;AVAMC/REG/CRT - PEDIATRIC UNIT PREPARATION ;7/30/95  15:36 ; 12/18/00 2:19pm
 ;;5.2;LAB SERVICE;**72,247,267,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;
 ; References to ^DD(65, and ^DD(66, are supported in DBIA3261
 ;
 Q  D END S LR("M")=1,X="BLOOD BANK" D ^LRUTL G:Y=-1 END S %DT="T",X="N" D ^%DT S LRN=Y,LRM=$P(Y,".") W !?15,"Division: ",LRAA(4)
 I LRCAPA S X="PEDIATRIC UNIT PREPARATION",X("NOCODES")=1 D X^LRUWK G:'$D(X) END K X
 S LR(3)="" D BAR^LRBLB
P W !! S X=$$READ^LRBLB("Blood component for pediatric prep: ") G:X=""!(X["^") END I X=" " W $C(7),"  SPACE BAR not allowed." G P
 I LR,$E(X,1,$L(LR(2)))=LR(2) D
 .D P^LRBLB
 E  W $$STRIP^LRBLB(.X)  ; Strip off the data identifiers just in case
 I '$D(X) W $C(7),!,"Code not entered in BLOOD PRODUCT file or not product label.",! G P
 S DIC=66,DIC(0)="EQMZ",DIC("S")="I $$SCRN^LRBLPED" D ^DIC K DIC G:X["?" P I Y<1 W $C(7),!,"Either not an entry in BLOOD COMPONENT FILE (#66) or",!,"Must enter MAX AGE FOR PEDIATRIC USE field for the entry in file 66." G P
 S X=0,LRO=+$P(Y(0),U,22) I 'LRO!('$D(^LAB(66,LRO,0))) W $C(7),!,$P(^DD(66,.22,0),U)," must be entered for this component",!,"and pediatric product selection must be an entry in the Blood Product file." S X=1
 I '$P(Y(0),U,23) W $C(7),!,$P(^DD(66,.23,0),U)," must be entered for this component" S X=1
 G:X P S LRC=+Y F A=0:0 S A=$O(^LAB(66,LRO,9,A)) Q:'A  S LRT(A)=""
 I LRCAPA,$D(LRT)'=11 W $C(7),!!,"Must have WKLD codes entered in Blood Product file for ",$P(^LAB(66,LRO,0),U) G END
 S LRD=$P(Y(0),U,17),LRZ=$P(^LAB(66,$P(Y(0),U,22),0),U,18),LRP=$P(Y(0),U,22),LRA=-(LRD-$P(Y(0),U,21)),LRV=$P(Y(0),U,10),LRV(.4)=LRV*.4\1,LRV(.6)=LRV*.6\1,LRS=$P(Y(0),U,23),LR(66,.135)=$P(^LAB(66,LRO,0),U,17)
 I 'LRV W $C(7),!!,"Volume of component must be entered in BLOOD COMPONENT file",!?20,"for ",$P(Y,U,2),"." G P
U K LRF,Z S Z=0 W !! S X=$$READ^LRBLB("Select UNIT: ") G:X=""!(X[U) END I X["?"!(X[" ")!(X'?.ANP) D H G U
 I LR,$E(X,1,$L(LR(2)))=LR(2) D
 .D ^LRBLBU
 E  W $$STRIP^LRBLB(.X)  ; Strip off the data identifiers just in case
 G:'$D(X) U
 S DIC=65,DIC(0)="EQM",DIC("W")="W "" "",$P(^(0),U)",DIC("S")="I $P(^(0),U,16)=DUZ(2),$P(^(0),U,4)=LRC,$S('$D(^(4)):1,$P(^(4),U)="""":1,1:0)" D ^DIC K DIC G:Y<1 U S X=$P(^LRD(65,+Y,0),U)
 S LRP=$$LRP(+Y)
 I LRP=0 G U
 S LRJ=X D ALL G P
ALL S Q=$O(^LRD(65,"AI",LRC,LRJ,0)) I Q S A=LRJ,Q=$O(^LRD(65,"AI",LRC,A,0)) Q:'Q  W !?3 D I G:$D(LRF) ^LRBLPED1
 K ^TMP($J) W !?3 S A(2)="",Z(1)=1,A=LRJ D D G ^LRBLPED1:$D(LRF) I A(2)?1P W $C(7) Q
 I LRJ'["E",LRJ=+LRJ,+$O(^LRD(65,"AI",LRJ))=X S A=LRJ_"?" D D
 G ^LRBLPED1:$D(LRF) W $C(7) Q
 ;
H I '$D(^LRD(65,"AI",LRC)) W $C(7),!!,"No units to choose from !",! Q
 I X'["??" W !,"ANSWER WITH ",$P(^DD(65,.01,0),U),!,"DO YOU WANT THE ENTIRE ",$P(^LRD(65,0),U)," LIST ? " S %="" D RX^LRU Q:%'=1
 S (A,A(2))=0,A(1)=$Y+21 W !?3 F B=0:0 S A=$O(^LRD(65,"AI",LRC,A)) Q:A=""  F Q=0:0 S Q=$O(^LRD(65,"AI",LRC,A,Q)) Q:'Q  D:$Y>A(1)!'$Y MORE Q:A(2)?1P  D I
 Q
I I Q[".",Q<LRN K ^LRD(65,"AI",LRC,A,Q) Q
 I Q<LRM K ^LRD(65,"AI",LRC,A,Q) Q
 S V=$O(^LRD(65,"AI",LRC,A,Q,0)) I $D(^LRD(65,V,4)),$P(^(4),"^")]"" K ^LRD(65,"AI",LRC,A,Q,V) Q
 I $D(^LRD(65,V,8)),+^(8) Q
 Q:'$D(^LRD(65,V,0))  S LRF=V_"^"_^(0) D OK Q:'$D(LRF)
 S Z=Z+1 W:$D(Z(1)) $J(Z,2) W ?7,$P(LRF,"^",2),?20,$J($P(LRF,"^",8),2)," ",$P(LRF,"^",9) S (LRE,Y)=$P(LRF,"^",7) D DT^LRU W ?28,Y
 W $J($S(LRB=0:"<1",1:LRB),4)," ",$S(LRB>1:"DAYS",1:"DAY ")," OLD  ",$J($P(LRF,"^",12),3) W:'$P(LRF,"^",12)&($P(LRF,"^",12)'=0) " ? " W " ml"
 W !?3 Q
 ;
D K LRF F B=0:0 S A=+$O(^LRD(65,"AI",LRC,A)) Q:$E(A,1,$L(LRJ))'=LRJ  F Q=0:0 S Q=$O(^LRD(65,"AI",LRC,A,Q)) Q:'Q!($A(A)>122)  D I I $D(LRF) S ^TMP($J,Z)=LRF K LRF I Z#5=0 D C Q:A(2)?1P
 D:Z#5&('$D(LRF)) C Q
 ;
OK S O=0 F O(1)=0:0 S O=$O(^LRD(65,V,2,O)) Q:'O  I $D(^LRD(65,"AP",O,V)) Q
 I O>0 K LRF Q
 S X1=$P(LRF,"^",7),X2=LRA D C^%DTC I X<LRM K LRF Q
 S X1=$P(LRF,"^",7),X2=-LRD D C^%DTC S X1=LRM,X2=X D ^%DTC S LRB=X Q
 ;
MORE R "'^' TO STOP: ",A(2):DTIME I A(2)?1P S A=$C(126) Q
 S A(1)=A(1)+21 S:$Y<22 A(1)=$Y+21 W $C(13),$J("",15),$C(13),?3 Q
C I Z=1 S A(2)=1 G F
 W $C(13),"TYPE '^' TO STOP OR",!,"CHOOSE 1-",Z R ": ",A(2):DTIME I A(2)?1P!'$T S A=$C(126) Q
 I A(2)="" W !?3 Q
F I A(2)>0,A(2)<(Z+1) S LRF=^TMP($J,A(2))
 S A(2)="^",A=$C(126) Q
END D V^LRU Q
 ;
SCRN() ; Screen for BLOOD PRODUCT file (#66)
 ;
 N X,PCODE,PEDICODE,ANS
 ;
 S ANS=0
 S X=^(0) ; from ^LAB(66,X,0)
 S PCODE=$P(X,U,5)
 ;
 I $P(X,U,21) S ANS=1 ; Max Age for Pediatric Product field defined
 I $P(X,U,29) D  ; ISBT-128
 .I '$P(X,U,22) S ANS=0 Q  ;No Pediatric Product defined
 .I $E(PCODE,($L(PCODE)-1),$L(PCODE))'="00" S ANS=0 Q
 .S PEDICODE=$$GET1^DIQ(66,$P(X,U,22),.05)
 .; Pediatric Product Code must end in alpha+0
 .I $E(PEDICODE,($L(PEDICODE)-1),$L(PEDICODE))'?1A1"0" S ANS=0
 Q ANS
 ;
LRP(DA) ; Find & return Product Code to be used for next child
 ;
 ; INPUT:  DA = IEN of PARENT UNIT RECORD on File #65
 ; OUTPUT: LRP = IEN of Child Product Code (file #66) if ISBT-1128
 ;            or IEN of Parent Product Code (file #66) if Codabar
 ;            or 0 if invalid.
 ;
 N LRBLAST,LRBLBP,LRBLSFX,LRP,LRBLPC
 ;
 S B=0
 ;
 Q:'$$GET1^DIQ(65,DA,".04:.29","I") $$GET1^DIQ(65,+DA,".04:.22","I") ; not ISBT-128, return the IEN of 
 ;                                                                   ; the pediatric type for the product
 S LRBLPC=$$GET1^DIQ(65,+DA,".04:.05") ; Parent Product Code
 ;
 S LRBLAST=$O(^LRD(65,+DA,16,""),-1)
 I LRBLAST>25 S B=91
 S LRBLSFX=$E("ABCDEFGHIJKLMNOPQRSTUVWXYZ",LRBLAST+1)_"0"
 S LRBLBP=$E(LRBLPC,1,$L(LRBLPC)-2)_LRBLSFX
 S LRP=$O(^LAB(66,"D",LRBLBP,0))
 I 'LRP D  Q 0
 .D EN^DDIOL("Pediatric Preparation cannot proceed with this unit until another","","!!")
 .D EN^DDIOL("record is created for this product type in the BLOOD PRODUCT file.","","!")
 Q LRP
 ;
