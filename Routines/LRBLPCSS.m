LRBLPCSS ;AVAMC/REG - PRE-OP COMPONENT SELECTION ;11/7/94  13:50 ;
 ;;5.2;LAB SERVICE;**1,247,315**;Sep 27, 1994;Build 25
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;Reference to ^SRF is supported by ECR# 927
 ;Reference to ^%DT Supported by ICR# 10003
 ;Reference to C^%DTC Supported by ICR# 10000
 ;Reference to ^DIC Supported by ICR# 2051
 I '$D(^SRF) W "  *** No operation schedule file ***" G A
 I '$D(^SRF("ADT",DFN)) W !!,LRP," not in operation schedule file." G A
 S X="T",%DT="" D ^%DT S X1=Y,X2=-1 D C^%DTC S X=X+.99 K A
 S C=0 F B=0:0 S X=$O(^SRF("ADT",DFN,X)) Q:'X  S A=0 F B(1)=0:0 S A=$O(^SRF("ADT",DFN,X,A)) Q:'A  S C=C+1,Y=^SRF("ADT",DFN,X,A) D D^LRU S A(C)=Y_"^"_$S($D(^SRF(A,"OP")):^("OP"),1:"")
 I 'C W !!,"No operations pending." G A
 I C=1 W !!,"Operation scheduled: " S X=1 D B Q
 W !!?5,"Date:",?20,"Operation:" S A=0 F B=0:1 S A=$O(A(A)) Q:'A  W !,$J(A,2),") ",$P(A(A),"^")," ",$P(A(A),"^",2)
P W !!,"Select OPERATION (1-",B,"): " R X:DTIME Q:X["^"!(X="")  I X<1!(X>B)!(+X'=X) W $C(7),!,"Select a number from 1 to ",B G P
 D B Q
B W "  ",$P(A(X),"^"),!,$P(A(X),"^",2) S X=$P(A(X),"^",3)
 N LRX
 S LRX=X,LRX=$$CPTD^ICPTCOD(LRX,"LRX")
 I +LRX'=-1 D
 . W !,"CPT file number: ",X
 . F I=1:1:LRX W !,LRX(I)
 . Q
 S X=$O(^LAB(66.5,LRCPT,1,0)) I 'X S LRCPT=0 D W Q
C F X=0:0 S X=$O(^LAB(66,LRCPT,1,X)) Q:'X  S X(1)=^(X,0) W !,"Component: ",$S($D(^LAB(66,X,0)):$P(^(0),"^"),1:""),?52,"MSBOS:",$P(X(1),"^",2)
 Q
 ;
A Q:'$D(^ICPT(0))  W ! S DIC="^ICPT(",DIC(0)="AEQMZ",DIC("A")="Select OPERATION: ",DIC("S")="I $P(^(0),""^"",3),$P(^DIC(81.1,$P(^DIC(81.1,$P(^ICPT(Y,0),""^"",3),0),""^"",3),0),""^"")=""SURGERY""" D ^DIC K DIC Q:Y<1  S X=+Y
 D:'$D(^LAB(66.5,X,0)) SET S Y=$O(^LAB(66.5,X,1,0)) I 'Y D W Q
 W !,"CPT file number: ",X
 N LRX
 S LRX=X,LRX=$$CPTD^ICPTCOD(LRX,"LRX")
 I +LRX'=-1 F I=1:1:LRX W !,LRX(I)
 S LRCPT=X D C Q
 ;
SET ; also from MSB^LRBLS
 L +^LAB(66.5):15 S DA=X,^LAB(66.5,X,0)=X,Z=^LAB(66.5,0),^(0)=$P(Z,"^",1,2)_"^"_X_"^"_($P(Z,"^",4)+1) L -^LAB(66.5) X:$D(^DD(66.5,.01,1,1,1)) ^(1) Q
EN ;
 I '$D(^LAB(66.5,LRCPT,1,C)) W !!,"No maximum surgical blood order entered in file 66.5 for this component.",!,"No maximum surgical blood order criteria checking can be done.",! Q
 S A=$P(^LAB(66.5,LRCPT,1,C,0),"^",2)
 Q:X'>A  W $C(7),!!,"Number exceeds maximum surgical blood order number (",A,") for this component",!,"for this procedure.  Request still OK " S %=2 D YN^LRU S:%=1 LRR=1 I %'=1 S Y=0 D DEL^LRBLPCS
 D:$D(LRR)
 . S LRK(C)="",LRK(C,1)="MSBOS:"_A_" operation: "
 . S LRK(C,1)=LRK(C,1)_$P($$CPT^ICPTCOD(LRCPT),"^",3)
 . Q
 Q
 ;
W W !!,"No maximum surgical blood orders for this operation.",!,"No maximum surgical blood order criteria checking can be done.",! Q
 ;
 ;called from LRBLPCS
 ;LRR set =1 if max surg blood criteria not met
