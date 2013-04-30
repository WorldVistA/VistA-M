FBAARD1 ;AISC/GRR - FEE BASIS VOUCHER AUDIT DELETE REJECT FLAG ;4/17/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
RD S DIR(0)="Y",DIR("A")="Are you sure you want to delete reject code for all locally rejected items in this batch",DIR("B")="NO" D ^DIR K DIR G Q^FBAARD:$D(DIRUT),RD1^FBAARD:'Y
 D WAIT^DICD,ALLM:FBTYPE="B3",ALLT:FBTYPE="B2",ALLP:FBTYPE="B5",ALLC:FBTYPE="B9"
 G Q^FBAARD:$D(FBERR)
 G RDD^FBAARD
ALLM ;
 F J=0:0 S J=$O(^FBAAC("AH",B,J)) Q:J'>0!($D(FBERR))  F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:K'>0!($D(FBERR))  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:L'>0!($D(FBERR))  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:M'>0!($D(FBERR))  D REJM Q:$D(FBERR)
ADONE ;
 W:'$D(FBERR) !!,"Local reject codes for all items have been deleted!"
 Q
REJM ;
 Q:$P($G(^FBAAC(J,1,K,1,L,1,M,"FBREJ")),"^",4)=1  ; skip interface rej.
 S FBAAMT=+$P(^FBAAC(J,1,K,1,L,1,M,0),"^",3)
 D POST^FBAARD3 I $D(FBERR) G PROB
 S FBX=$$DELREJ^FBAARR3("162.03",M_","_L_","_K_","_J_",")
 Q
ALLT ;
 F J=0:0 S J=$O(^FBAAC("AG",B,J)) Q:J'>0!($D(FBERR))  F K=0:0 S K=$O(^FBAAC("AG",B,J,K)) Q:K'>0!($D(FBERR))  D REJT Q:$D(FBERR)
 G ADONE
REJT ;
 Q:$P($G(^FBAAC(J,3,K,"FBREJ")),"^",4)=1  ; skip interface reject
 S FBAAMT=$P(^FBAAC(J,3,K,0),"^",3)
 D POST^FBAARD3 I $D(FBERR) G PROB
 S FBX=$$DELREJ^FBAARR3("162.04",K_","_J_",")
 Q
ALLP ;
 F J=0:0 S J=$O(^FBAA(162.1,"AF",B,J)) Q:J'>0!($D(FBERR))  F K=0:0 S K=$O(^FBAA(162.1,"AF",B,J,K)) Q:K'>0!($D(FBERR))  D REJP Q:$D(FBERR)
 G ADONE
REJP ;
 Q:$P($G(^FBAA(162.1,J,"RX",K,"FBREJ")),"^",4)=1  ; skip interface rej.
 S FBAAMT=+$P(^FBAA(162.1,J,"RX",K,0),"^",16)
 D POST^FBAARD3 I $D(FBERR) G PROB
 S FBX=$$DELREJ^FBAARR3("162.11",K_","_J_",")
 Q
ALLC ;
 F J=0:0 S J=$O(^FBAAI("AH",B,J)) Q:J'>0!($D(FBERR))  I $D(^FBAAI(J,0)) D REJC Q:$D(FBERR)
 G ADONE
REJC ;
 Q:$P($G(^FBAAI(J,"FBREJ")),"^",4)=1  ; skip interface reject
 S FBAAMT=+$P(^FBAAI(J,0),"^",9),FBII78=$P($G(^(0)),"^",5),FBMM=$E($P(^(0),U,6),4,5)
 D INPOST^FBAARD3 I $D(FBERR) G PROB
 S FBX=$$DELREJ^FBAARR3("162.5",J_",")
 K FBMM
 Q
PROB W !!,*7,"There is a problem with your 1358. Unable to delete reject flag!",!
 Q
