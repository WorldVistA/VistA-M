FBAADD ;AISC/GRR - REJECT ENTIRE BATCH ;3/22/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 N FBIENS
RD S DIR(0)="Y",DIR("A")="Are you sure you want to reject all line items in this batch",DIR("B")="NO" D ^DIR K DIR G Q^FBAAVR:$D(DIRUT),RD1^FBAAVR:'Y
 I $P(FZ,"^",11)'>0 G NOLINE
 D CK1358^FBAAUTL1 G Q^FBAAVR:$D(FBERR)
RR S DIR(0)="F^2:40",DIR("A")="Enter reason for rejecting (2-40 characters)",DIR("?")="Please enter the reason this item was rejected" D ^DIR K DIR G:$D(DIRUT) Q^FBAAVR S FBRR=X
 D WAIT^DICD,ALLM:FBTYPE="B3",ALLT:FBTYPE="B2",ALLP:FBTYPE="B5",ALLC:FBTYPE="B9"
 W !!,"All items in batch flagged as rejected!!"
 G RD2^FBAAVR
 ;
ALLM F J=0:0 S J=$O(^FBAAC("AC",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AC",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AC",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AC",B,J,K,L,M)) Q:M'>0  S FBIENS=M_","_L_","_K_","_J_"," D REJLN^FBAAVR0
 Q
 ;
ALLT F J=0:0 S J=$O(^FBAAC("AD",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AD",B,J,K)) Q:K'>0  S FBIENS=K_","_J_"," D REJLN^FBAAVR0
 Q
 ;
ALLP F J=0:0 S J=$O(^FBAA(162.1,"AE",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAA(162.1,"AE",B,J,K)) Q:K'>0  S FBIENS=K_","_J_"," D REJLN^FBAAVR0
 Q
 ;
ALLC F J=0:0 S J=$O(^FBAAI("AC",B,J)) Q:J'>0  S FBIENS=J_"," D REJLN^FBAAVR0
 Q
 ;
NOLINE W $C(7),!!,"Line count of batch is equal zero!",!
 G RDD^FBAAVR
