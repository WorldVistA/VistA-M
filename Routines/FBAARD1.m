FBAARD1 ;AISC/GRR-FEE BASIS VOUCHER AUDIT DELETE REJECT FLAG ;8AUG86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD S DIR(0)="Y",DIR("A")="Are you sure you want to delete reject code for all rejected items in this      batch",DIR("B")="NO" D ^DIR K DIR G Q^FBAARD:$D(DIRUT),RD1^FBAARD:'Y
 D WAIT^DICD,ALLM:FBTYPE="B3",ALLT:FBTYPE="B2",ALLP:FBTYPE="B5",ALLC:FBTYPE="B9"
 G Q^FBAARD:$D(FBERR)
 G RDD^FBAARD
ALLM S (TM1,TM2)=0
 F J=0:0 S J=$O(^FBAAC("AH",B,J)) Q:J'>0!($D(FBERR))  F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:K'>0!($D(FBERR))  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:L'>0!($D(FBERR))  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:M'>0!($D(FBERR))  D REJM Q:$D(FBERR)
 Q:$D(FBERR)
 D INVCNT
ADONE S $P(FZ,"^",9)=($P(FZ,"^",9)+TM1),$P(FZ,"^",11)=($P(FZ,"^",11)+TM2),$P(FZ,"^",17)="",^FBAA(161.7,B,0)=FZ,FBAARA=TM1
 W !!,"Reject codes for all items have been deleted!" Q
REJM S FBAAMT=+$P(^FBAAC(J,1,K,1,L,1,M,0),"^",3) D POST^FBAARD3 I $D(FBERR) G PROB
 S $P(^FBAAC(J,1,K,1,L,1,M,0),"^",8)=$P(^FBAAC(J,1,K,1,L,1,M,"FBREJ"),"^",3),^FBAAC("AC",B,J,K,L,M)="" K ^FBAAC("AH",B,J,K,L,M),^FBAAC(J,1,K,1,L,1,M,"FBREJ")
 S TM1=TM1+$P(^FBAAC(J,1,K,1,L,1,M,0),"^",3),TM2=TM2+1
 S FBIN=$P(^FBAAC(J,1,K,1,L,1,M,0),"^",16),^FBAAC("AJ",B,FBIN,J,K,L,M)=""
 Q
ALLT S (TM1,TM2)=0 F J=0:0 S J=$O(^FBAAC("AG",B,J)) Q:J'>0!($D(FBERR))  F K=0:0 S K=$O(^FBAAC("AG",B,J,K)) Q:K'>0!($D(FBERR))  D REJT Q:$D(FBERR)
 G ADONE
REJT ;SETUP REJECT FIELDS FOR TRAVEL
 S FBAAMT=$P(^FBAAC(J,3,K,0),"^",3) D POST^FBAARD3 I $D(FBERR) G PROB
 S $P(^FBAAC(J,3,K,0),"^",2)=$P(^FBAAC(J,3,K,"FBREJ"),"^",3) K ^FBAAC("AG",B,J,K) S ^FBAAC("AD",B,J,K)="" K ^FBAAC(J,3,K,"FBREJ") S TM1=TM1+$P(^FBAAC(J,3,K,0),"^",3),TM2=TM2+1
 Q
ALLP S (TM1,TM2)=0 F J=0:0 S J=$O(^FBAA(162.1,"AF",B,J)) Q:J'>0!($D(FBERR))  F K=0:0 S K=$O(^FBAA(162.1,"AF",B,J,K)) Q:K'>0!($D(FBERR))  D REJP Q:$D(FBERR)
 G ADONE
REJP S FBAAMT=+$P(^FBAA(162.1,J,"RX",K,0),"^",16) D POST^FBAARD3 I $D(FBERR) G PROB
 S $P(^FBAA(162.1,J,"RX",K,0),"^",17)=B,FBPID=$P(^(0),"^",5),TM1=TM1+$P(^(0),"^",16),^FBAA(162.1,"AE",B,J,K)="",^FBAA(162.1,"AJ",B,FBPID,J,K)="",TM2=TM2+1 K ^FBAA(162.1,"AF",B,J,K),^FBAA(162.1,J,"RX",K,"FBREJ")
 Q
ALLC S (TM1,TM2)=0 F J=0:0 S J=$O(^FBAAI("AH",B,J)) Q:J'>0!($D(FBERR))  I $D(^FBAAI(J,0)) D REJC Q:$D(FBERR)
 S $P(FZ,"^",10)=$P(FZ,"^",10)+TM2 G ADONE
REJC S FBAAMT=+$P(^FBAAI(J,0),"^",9),FBII78=$P($G(^(0)),"^",5),FBMM=$E($P(^(0),U,6),4,5) D INPOST^FBAARD3 I $D(FBERR) G PROB
 S $P(^FBAAI(J,0),"^",17)=$P(^FBAAI(J,"FBREJ"),"^",3),^FBAAI("AC",B,J)="",^FBAAI("AE",B,$P(^FBAAI(J,0),"^",4),J)="" K FBMM,^FBAAI("AH",B,J),^FBAAI(J,"FBREJ") S TM1=TM1+FBAAMT,TM2=TM2+1 Q
PROB W !!,*7,"There is a problem with your 1358. Unable to delete reject flag!",! Q
 ;
INVCNT ;GET # OF INVOICES IN A BATCH
 N I,CNT
 S (I,CNT)=0
 ;FBN=ien of batch in 161.7
 ;will go through "AJ" x-ref in 162 to get total invoices in medical
 ;batch.
 Q:'$G(FBN)
 F  S I=$O(^FBAAC("AJ",FBN,I)) Q:'I  S CNT=CNT+1
 S $P(FZ,U,10)=CNT
 Q
