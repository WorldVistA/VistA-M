FBAADD ;AISC/GRR-REJECT ENTIRE BATCH ;08AUG86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD S DIR(0)="Y",DIR("A")="Are you sure you want to reject all line items in this batch",DIR("B")="NO" D ^DIR K DIR G Q^FBAAVR:$D(DIRUT),RD1^FBAAVR:'Y
 D CK1358^FBAAUTL1 G Q^FBAAVR:$D(FBERR)
 S FBAARA=$P(FZ,"^",9),FBAAON=$P(FZ,"^",2) I FBAARA'>0!($P(FZ,"^",11)'>0) G NOLINE
RR S DIR(0)="F^2:40",DIR("A")="Enter reason for rejecting (2-40 characters)",DIR("?")="Please enter the reason this item was rejected" D ^DIR K DIR G:$D(DIRUT) Q^FBAAVR S FBRR=X
 D WAIT^DICD,ALLM:FBTYPE="B3",ALLT:FBTYPE="B2",ALLP:FBTYPE="B5",ALLC:FBTYPE="B9"
 G RDD^FBAAVR
ALLM F J=0:0 S J=$O(^FBAAC("AC",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AC",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AC",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AC",B,J,K,L,M)) Q:M'>0  D REJM
ADONE S $P(FZ,"^",9)=0,$P(FZ,"^",10)=0,$P(FZ,"^",11)=0,$P(FZ,"^",17)="Y",^FBAA(161.7,B,0)=FZ
 W !!,"All items in batch flagged as rejected!!" S:FBTYPE'="B9" FBRFLAG=1 Q
REJM S $P(^FBAAC(J,1,K,1,L,1,M,"FBREJ"),"^",3)=$P(^FBAAC(J,1,K,1,L,1,M,0),"^",8),$P(^(0),"^",8)="",FBIN=$P(^(0),"^",16),$P(^("FBREJ"),"^",1)="P",$P(^("FBREJ"),"^",2)=FBRR,^FBAAC("AH",B,J,K,L,M)=""
 K ^FBAAC("AC",B,J,K,L,M),^FBAAC("AJ",B,FBIN,J,K,L,M) Q
ALLT F J=0:0 S J=$O(^FBAAC("AD",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AD",B,J,K)) Q:K'>0  D REJT
 G ADONE
REJT ;SETUP REJECT FIELDS FOR TRAVEL
 S $P(^FBAAC(J,3,K,"FBREJ"),"^",3)=$P(^FBAAC(J,3,K,0),"^",2),$P(^(0),"^",2)="" K ^FBAAC("AD",B,J,K) S ^FBAAC("AG",B,J,K)="",$P(^FBAAC(J,3,K,"FBREJ"),"^",2)=FBRR,$P(^("FBREJ"),"^",1)="P"
 Q
ALLP F J=0:0 S J=$O(^FBAA(162.1,"AE",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAA(162.1,"AE",B,J,K)) Q:K'>0  D REJP
 G ADONE
REJP S $P(^FBAA(162.1,J,"RX",K,"FBREJ"),"^",1)="P",$P(^("FBREJ"),"^",2)=FBRR,$P(^("FBREJ"),"^",3)=B,$P(^(0),"^",17)="",FBPID=$P(^(0),"^",5),^FBAA(162.1,"AF",B,J,K)="" K ^FBAA(162.1,"AE",B,J,K),^FBAA(162.1,"AJ",B,FBPID,J,K)
 Q
ALLC F J=0:0 S J=$O(^FBAAI("AC",B,J)) Q:J'>0  S J(0)="P"_"^"_FBRR_"^"_B,^FBAAI(J,"FBREJ")=J(0),$P(^FBAAI(J,0),"^",17)="",^FBAAI("AH",B,J)="" K ^FBAAI("AC",B,J),^FBAAI("AE",B,$P(^FBAAI(J,0),"^",4),J) D
 .S FBAAMT=-($P(^FBAAI(J,0),"^",9)),FBII78=$P(^(0),"^",5),FBMM=$E($P(^(0),U,6),4,5) D INPOST^FBAARD3
 G ADONE
NOLINE W *7,!!,"Total dollars/Line count of batch is equal zero!",! D Q^FBAAVR G ^FBAAVR
 Q
