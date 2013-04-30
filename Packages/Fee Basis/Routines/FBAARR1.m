FBAARR1 ;AISC/GRR - FEE BASIS REINITIATE ENTIRE BATCH ;3/28/2012
 ;;3.5;FEE BASIS;**61,132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
RD S DIR(0)="Y",DIR("A")="Are you sure you want to re-initiate all line items in this batch",DIR("B")="NO"
 D ^DIR K DIR G:$D(DIRUT)!'Y RD1^FBAARR
 D WAIT^DICD
 S FBRJV=0
 D ALLM:FBTYPE="B3",ALLT:FBTYPE="B2",ALLP:FBTYPE="B5",ALLC:FBTYPE="B9"
 K FBRJV
 D UNLK^FBAARR
 G BT^FBAARR
 ;
ALLM ; re-initiate all rejected line items in medical (B3) type batch
 K FBILM
 F J=0:0 S J=$O(^FBAAC("AH",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:M'>0  D REJM
 ; Assign new invoice number to moved lines if medical invoice was split
 I $$CKSPLIT^FBAARR(B,.FBILM) S DIR(0)="E" D ^DIR K DIR
ADONE ;
 I '$G(FBRJV) W !!,"All rejected items have been re-initiated!"
 I $G(FBRJV) W !!,"All rejected items (except for voided payments) have been re-initiated!"
 Q
 ;
REJM I $P(^FBAAC(J,1,K,1,L,1,M,0),"^",21)="VP" S FBIN=+$P(^(0),"^",16) D VOID S FBRJV=1 Q
 S FBX=$$DELREJ^FBAARR3("162.03",M_","_L_","_K_","_J_",",FBNB)
 I 'FBX D
 . W !,"Error re-initiating line with IENs = "_M_","_L_","_K_","_J_","
 . W !,"  ",$P(FBX,U,2)
 . S FBERR=1
 ; update list of invoice lines that were moved to the new batch
 S FBILM(FBIN,M_","_L_","_K_","_J_",")=""
 Q
 ;
ALLT F J=0:0 S J=$O(^FBAAC("AG",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AG",B,J,K)) Q:K'>0  D REJT
 G ADONE
REJT ;SETUP REJECT FIELDS FOR TRAVEL
 S FBX=$$DELREJ^FBAARR3("162.04",K_","_J_",",FBNB)
 I 'FBX D
 . W !,"Error re-initiating line with IENs = "_K_","_J_","
 . W !,"  ",$P(FBX,U,2)
 . S FBERR=1
 Q
 ;
ALLP F J=0:0 S J=$O(^FBAA(162.1,"AF",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAA(162.1,"AF",B,J,K)) Q:K'>0  D REJP
 G ADONE
REJP I $P($G(^FBAA(162.1,J,"RX",K,2)),"^",3)="V" S FBIN=J D VOID S FBRJV=1 Q
 S FBX=$$DELREJ^FBAARR3("162.11",K_","_J_",",FBNB)
 I 'FBX D
 . W !,"Error re-initiating line with IENs = "_K_","_J_","
 . W !,"  ",$P(FBX,U,2)
 . S FBERR=1
 Q
 ;
ALLC F J=0:0 S J=$O(^FBAAI("AH",B,J)) Q:J'>0  I $D(^FBAAI(J,0)) D REJC
 G ADONE
REJC I $P(^FBAAI(J,0),"^",14)="VP" S FBIN=J D VOID S FBRJV=1 Q
 S FBX=$$DELREJ^FBAARR3(162.5,J_",",FBNB)
 I 'FBX D
 . W !,"Error re-initiating line with IENs = "_J_","
 . W !,"  ",$P(FBX,U,2)
 . S FBERR=1
 Q
 ;
KILL K A,A1,A2,B,CPTDESC,D0,DA,FBAACPT,FBAAOUT,FBVP,J,K,L,M,X,Y,Z,DIC,ERR,FBIN,FBNB,FBNUM,FBPV,FBRR,FBTYPE,FBVD,FBVDUZ,FZ,I,POP,DR,IOP,V,VID,ZS,FBN,FBOB,FBNOB,CNT,Q,UL,VAL,FBINTOT,PRCS,PRCSI,FBFDC,FBMST,FBTTYPE,FBSTN,FBDCB,FBBN
 K FBAAAP,FBAC,FBAP,FBDX,FBFD,FBK,FBL,FBPDT,FBPROC,FBSC,FBINOLD,FBTD,N,S,FBCNT,FBNBCNT,I,DIRUT,FBEXMPT,FBX
 K FBAAMPI,HX,B2
 Q
 ;
BATCNT ;GET NUMBER OF REJECTS IN OLD BATCH
 S:'$D(FBAAMPI) FBAAMPI=$S($D(^FBAA(161.4,1,"FBNUM")):$P(^("FBNUM"),"^",3),1:100),FBAAMPI=$S(FBAAMPI]"":FBAAMPI,1:100)
 Q:'$D(FBN)  S FBCNT=0
 F I=0:0 S I=$O(^FBAAC("AH",FBN,I)) Q:'I  F J=0:0 S J=$O(^FBAAC("AH",FBN,I,J)) Q:'J  F K=0:0 S K=$O(^FBAAC("AH",FBN,I,J,K)) Q:'K  F L=0:0 S L=$O(^FBAAC("AH",FBN,I,J,K,L)) Q:'L  I $D(^FBAAC(I,1,J,1,K,1,L,"FBREJ")) S FBCNT=FBCNT+1
 Q:'$D(FBNB)
 S FBNBCNT=$S($D(^FBAA(161.7,FBNB,0)):(FBAAMPI-$P(^(0),"^",11)),1:0)
 I FBCNT>FBNBCNT W !!,*7,"New Batch selected does not have enough room to fit the",!,FBCNT," rejects pending from batch ",$P(FZ,"^")," !",!! K FBNB Q
 Q
 ;
VOID W !!,*7,"Invoice #: ",FBIN," has a status of VOID.  Please delete the VOID",!,"before re-initiating this rejected payment."
 Q
