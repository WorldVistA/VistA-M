LRBLJDM ;AVAMC/REG/CYM - MULTIPLE COMP PREP, INVENTORY ;5/21/97  14:56 ; 12/7/00 7:12am
 ;;5.2;LAB SERVICE;**90,247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S X=^LAB(66,LRV,0),LRP(LRV)=$P(X,"^")_"^"_$P(X,"^",10)_"^"_$P(X,"^",11)_"^"_$P(X,"^",18),LRZ=$P(X,"^",19)
C S DIC="^LAB(66,LRE(4),3,",DIC(0)="AEQMZ" D ^DIC K DIC I Y>0 S (X,Y)=+Y,X=^LAB(66,X,0),LRP(Y)=$P(X,"^")_"^"_$P(X,"^",10)_"^"_$P(X,"^",11)_"^"_$P(X,"^",18) D:'$P(^LAB(66,LRE(4),3,Y,0),"^",2) ONLY D:$D(LRP(Y)) CK G C
 G:'$D(LRP) OUT S S=0 W !,"You have selected the following component(s): " S X=0 F X(1)=0:1 S X=$O(LRP(X)) Q:'X  W !,$P(LRP(X),"^"),?40,"vol(ml):",$J($P(LRP(X),"^",2),5) S S=S+$P(LRP(X),"^",2)
 W !?48,"-----",!?34,"Total vol(ml):",$J(S,5) I S>LRM W !!,$C(7),"Total volume of components greater than unit. SELECTIONS DELETED TRY AGAIN !",!! K LRP S LRZ=0 G C
 W !?5,"All OK " S %=1 D YN^LRU I %'=1 W " SELECTIONS DELETED TRY AGAIN",! K LRP G C
 S LRE(1)=$P(LRE,"^"),LRV(10)=LRV(10)/X(1) I LRV(10)["." S LRV(10)=$P(LRV(10),".")_"."_$E($P(LRV(10),".",2),1,2)
 F LRH=0:0 S LRH=$O(LRP(LRH)) Q:'LRH  S LRV=LRH,LRV(1)=$P(LRP(LRH),"^"),LRM=$P(LRP(LRH),"^",2),LRO(1)=$P(LRP(LRH),"^",3),LRD=$P(LRP(LRH),"^",4) D:LRO(1) F D:LRO(1)="" T D S
 Q
ONLY W !!,$C(7),"Component selected must be the ONLY ONE for this unit.",!," Selection ",$P(LRP(Y),"^")," canceled !",! K LRP(Y) Q
CK I LRZ,$P(X,"^",19) W $C(7),!!,"Cannot select more than one red blood cell product.",!,"Selection ",$P(LRP(Y),"^")," canceled !",! K LRP(Y) Q
 S:'LRZ LRZ=$P(X,"^",19) Q
 ;
T S Y=$P(LRE,"^",6) D D^LRU S LRO(1)=Y Q
 ;
F ;from LRBLJD
 S T(2)="."_$P(LRO(1),".",2)*1440,LRO(1)=$P(LRO(1),".") S X="N",%DT="T" D ^%DT S X=Y,Y=Y_"000",T(3)=$E(Y,9,10)*60+$E(Y,11,12) D H^%DTC S T(5)=T(3)+T(2),%H=%H+LRO(1)+(T(5)\1440),T(5)=T(5)#1440\1
 D D^LRUT I LRO(9)<2 S T(3)=T(5)\60,T(3)=$E("00",1,2-$L(T(3)))_T(3),T(4)=T(5)#60,T(4)=$E("00",1,2-$L(T(4)))_T(4),T(4)=T(3)_T(4) S:+T(4) X=X_"."_T(4)
 S Y=$P(X,"."),X=$P(X,".",2) D D^LRU S LRO(1)=$S(X:Y_"@"_X,1:Y) Q
 ;
S ;from LRBLJD
 S LRE(1)=$P(LRE,"^")_LRV(11) S:'$D(^LRD(65,LRX,9,0)) ^(0)="^65.091PAI^^" S X=^(0),C=$P(X,"^",4)+1,^(0)=$P(X,"^",1,2)_"^"_C_"^"_C,^(C,0)=LRV_"^"_LRE(1)_"^"_2
 D:C>1 SET D ^LRBLJDA Q:'LRCAPA  F A=0:0 S A=$O(^LAB(66,LRV,9,A)) Q:'A  S LRT(A)=""
 D ^LRBLW K LRT S LRT=LRW("MO") Q
SET S C=0 F A=0:0 S A=$O(^LRD(65,LRX,9,A)) Q:'A  S:$P(^(A,0),"^",3)=2 C=C+1
 S $P(^LRD(65,LRX,4),"^",4)="("_C_")" Q
 ;
D I LRCAPA,'$O(^LAB(66,LRV,9,0)) W $C(7),!,!!,"Must enter WKLD CODES in BLOOD PRODUCT FILE (#66)",!,"for ",$P(^LAB(66,LRV,0),U)," to divide unit.",! D OUT Q
 R !,"Enter number of aliquots (1-5): ",A:DTIME I A=""!(A[U) D OUT Q
 S A=+A I A>5!(A<1) W !!,"Answer must be 1,2,3,4, or 5",! G D
 ; Insert logic for ISBT128 units so that splitting follows ISBT128 naming conventions
 G:$$ISBTSPLT(LRX,A) D
 S LR("C")=A,LRM=LRM\A,LRV(10)=LRV(10)/A S:LRV(10)["." LRV(10)=$P(LRV(10),".")_"."_$E($P(LRV(10),".",2),1,2)
 I $$ISISBT($P(LRE,U,4)) D
 .N LRBLPCOD,CNT
 .S LRBLPCOD=$$GET1^DIQ(66,$P(LRE,U,4),.05)
 .S LRV(11)=""
 .S I=0 F CNT=0:1 S I=$O(^LRD(65,LRX,16,I)) Q:'I  ; Count pre-existing child units
 .F B=1:1:LR("C") S $E(LRBLPCOD,($L(LRBLPCOD)-1))=$C(64+CNT+B),LRV=$$FIND1^DIC(66,,,LRBLPCOD,"D"),LRV(1)=$$GET1^DIQ(66,LRV,.01) D S
 I '$$ISISBT($P(LRE,U,4)) F B=1:1:LR("C") S LRV(11)=$C(64+B) D S
 Q
 ;
OUT D K^LRBLJD Q
 ;
ISISBT(PROD) ; This function should only be called within this routine
 ; This function is a boolean of whether a product type is ISBT128 (true) or Codabar (false)
 Q $$GET1^DIQ(66,PROD,.29,"I")
 ;
ISBTSPLT(UIEN,NUM) ; This function should only be called from within this routine
 ; This function checks for an appropriate number of split units for ISBT128 product types
 ; UIEN Unit Internal Entry Number
 ; PROD is the product code
 ; NUM is the number of aliquots requested by the user
 N ANS  ; This is the flag that determines whether the function fails the check
 N I,CHK,CODE,PROD,CNT
 I '$G(UIEN)!('$G(NUM)) Q 1  ; No go if parent unit or number is not indicated
 S PROD=$P(^LRD(65,UIEN,0),"^",4)
 S (ANS,I)=0
 I $$ISISBT(PROD) D  Q ANS
 .S CODE=$$GET1^DIQ(66,PROD,.05),CHK=0
 .I $E(CODE,($L(CODE)-1),$L(CODE))'="00" D  Q  ; Only parent units with '00' at the end of the end of the
 ..;                                           ; product code can be split
 ..S ANS=1
 ..W !,"This ISBT128 unit cannot be split because the product"
 ..W !,"code does not end in '00'.",*7
 .;
 .F CNT=0:1 S I=$O(^LRD(65,UIEN,16,I)) Q:'I  ; Get a count of any child units already created and add them in
 .;                                          ; in the search below
 .F I=1:1:NUM  S $E(CODE,($L(CODE)-1))=$C(64+CNT+I) Q:'$$FIND1^DIC(66,,,CODE,"D")  S CHK=CHK+1
 .I CHK'=NUM D
 ..S ANS=1
 ..W !,(NUM-CHK)," MORE DIVIDED BLOOD PRODUCT ENTR"_$S((NUM-CHK)>1:"IES",1:"Y")_" MUST BE CREATED BEFORE THE PRODUCT"
 ..W !,"TYPE YOU HAVE SELECTED CAN BE SPLIT INTO "_NUM_" UNIT"_$S(NUM>1:"S.",1:"."),*7
 Q ANS
