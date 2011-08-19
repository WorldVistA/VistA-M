FBAARR1 ;AISC/GRR-FEE BASIS RE-INITIATE ENTIRE BATCH ;7/12/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD S DIR(0)="Y",DIR("A")="Are you sure you want to re-initiate all line items in this batch",DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RD1^FBAARR
 S FZ=^FBAA(161.7,FBNB,0) D WAIT^DICD,ALLM:FBTYPE="B3",ALLT:FBTYPE="B2",ALLP:FBTYPE="B5",ALLC:FBTYPE="B9"
 K FBRJV G BT^FBAARR
ALLM ; re-initiate all rejected line items in medical (B3) type batch
 K FBILM
 S (TM1,TM2)=0 F J=0:0 S J=$O(^FBAAC("AH",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:M'>0  D REJM
 ; Assign new invoice number to moved lines if medical invoice was split
 I $$CKSPLIT^FBAARR(B,.FBILM) S DIR(0)="E" D ^DIR K DIR
ADONE S $P(FZ,"^",9)=($P(FZ,"^",9)+TM1),$P(FZ,"^",11)=($P(FZ,"^",11)+TM2),^FBAA(161.7,FBNB,0)=FZ I '$G(FBRJV) S $P(^FBAA(161.7,B,0),"^",17)="" W !!,"All rejected items have been re-initiated!" Q
 I $G(FBRJV) W !!,"All rejected items (except for voided payments) have been re-initiated!" Q
REJM I $P(^FBAAC(J,1,K,1,L,1,M,0),"^",21)="VP" S FBIN=+$P(^(0),"^",16) D VOID S FBRJV=1 Q
 S $P(^FBAAC(J,1,K,1,L,1,M,0),"^",8)=FBNB,FBIN=+$P(^(0),"^",16),^FBAAC("AC",FBNB,J,K,L,M)="" K ^FBAAC("AH",B,J,K,L,M),^FBAAC(J,1,K,1,L,1,M,"FBREJ")
 ; update list of invoice lines that were moved to the new batch
 S FBILM(FBIN,M_","_L_","_K_","_J_",")=""
 S TM1=TM1+$P(^FBAAC(J,1,K,1,L,1,M,0),"^",3),TM2=TM2+1
 S ^FBAAC("AJ",FBNB,FBIN,J,K,L,M)="" Q
ALLT S (TM1,TM2)=0 F J=0:0 S J=$O(^FBAAC("AG",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AG",B,J,K)) Q:K'>0  D REJT
 G ADONE
REJT ;SETUP REJECT FIELDS FOR TRAVEL
 S $P(^FBAAC(J,3,K,0),"^",2)=FBNB K ^FBAAC("AG",B,J,K) S ^FBAAC("AD",FBNB,J,K)="" K ^FBAAC(J,3,K,"FBREJ") S TM1=TM1+$P(^FBAAC(J,3,K,0),"^",3),TM2=TM2+1
 Q
ALLP S (TM1,TM2)=0 F J=0:0 S J=$O(^FBAA(162.1,"AF",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAA(162.1,"AF",B,J,K)) Q:K'>0  D REJP
 G ADONE
REJP I $P($G(^FBAA(162.1,J,"RX",K,2)),"^",3)="V" S FBIN=J D VOID S FBRJV=1 Q
 S FBPID=$P(^FBAA(162.1,J,"RX",K,0),"^",5),$P(^(0),"^",17)=FBNB,TM1=TM1+$P(^(0),"^",16),^FBAA(162.1,"AE",FBNB,J,K)="",^FBAA(162.1,"AJ",FBNB,FBPID,J,K)="",TM2=TM2+1 K ^FBAA(162.1,"AF",B,J,K),^FBAA(162.1,J,"RX",K,"FBREJ")
 Q
ALLC S (TM1,TM2,TM3)=0 F J=0:0 S J=$O(^FBAAI("AH",B,J)) Q:J'>0  I $D(^FBAAI(J,0)) D REJC
 S $P(FZ,"^",10)=$P(FZ,"^",10)+TM3 G ADONE
REJC I $P(^FBAAI(J,0),"^",14)="VP" S FBIN=J D VOID S FBRJV=1 Q
 S $P(^FBAAI(J,0),"^",17)=FBNB,$P(^(0),"^",16)="",^FBAAI("AC",FBNB,J)="",^FBAAI("AE",FBNB,$P(^FBAAI(J,0),"^",4),J)="" K ^FBAAI("AH",B,J),^FBAAI(J,"FBREJ") S TM1=TM1+$P(^FBAAI(J,0),"^",9),TM2=TM2+1,TM3=TM3+1 Q
 Q
KILL K A,A1,A2,B,CPTDESC,D0,DA,FBAACPT,FBAAOUT,FBVP,J,K,L,M,X,Y,Z,DIC,ERR,FBIN,FBNB,FBNUM,FBPV,FBRR,FBTYPE,FBVD,FBVDUZ,FZ,I,POP,DR,IOP,V,VID,ZS,FBN,FBOB,FBNOB,CNT,Q,UL,VAL,FBINTOT,PRCS,PRCSI,FBFDC,FBMST,FBTTYPE,FBSTN,FBDCB,FBBN
 K FBAAAP,FBAC,FBAP,FBDX,FBFD,FBK,FBL,FBPDT,FBPROC,FBSC,FBINOLD,FBTD,TM1,TM2,TM3,N,S,FBCNT,FBNBCNT,I,DIRUT,FBEXMPT
 Q
BATCNT ;GET NUMBER OF REJECTS IN OLD BATCH
 S:'$D(FBAAMPI) FBAAMPI=$S($D(^FBAA(161.4,1,"FBNUM")):$P(^("FBNUM"),"^",3),1:100),FBAAMPI=$S(FBAAMPI]"":FBAAMPI,1:100)
 Q:'$D(FBN)  S FBCNT=0
 F I=0:0 S I=$O(^FBAAC("AH",FBN,I)) Q:'I  F J=0:0 S J=$O(^FBAAC("AH",FBN,I,J)) Q:'J  F K=0:0 S K=$O(^FBAAC("AH",FBN,I,J,K)) Q:'K  F L=0:0 S L=$O(^FBAAC("AH",FBN,I,J,K,L)) Q:'L  I $D(^FBAAC(I,1,J,1,K,1,L,"FBREJ")) S FBCNT=FBCNT+1
 Q:'$D(FBNB)
 S FBNBCT=$S($D(^FBAA(161.7,FBNB,0)):(FBAAMPI-$P(^(0),"^",11)),1:0)
 I FBCNT>FBNBCT W !!,*7,"New Batch selected does not have enough room to fit the",!,FBCNT," rejects pending from batch ",$P(FZ,"^")," !",!! K FBNB Q
 Q
VOID W !!,*7,"Invoice #: ",FBIN," has a status of VOID.  Please delete the VOID",!,"before re-initiating this rejected payment."
 Q
