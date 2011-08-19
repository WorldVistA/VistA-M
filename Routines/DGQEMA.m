DGQEMA ;RWA/SLC-DHW/OKC-ALB/MIR - EMBOSSER AUTO QUEUE;03/21/85  2:31 PM ; 04 Oct 85  10:24 AM
 ;;5.3;Registration;**73,191**;Aug 13, 1993
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;INPUT:     DFN - patient (NOT killed on exit unless manuel q)
 ;
 ;USED:     DGHD - HOLD? (1 for yes, 2 for no, 0 for ask)
 ;        DGQUAN - how many cards?
 ;             S - type of card (1 for NSC, 2 for SC, 3 for NON-VET,
 ;                               and 9 for FREE TEXT)
 ;          DGFL - 1 if '^', 2 for time-out, otherwise 0
 ;        DGLINE - Lines of text subscripted by line #
 ;           DGE - errors?  Yes if $D(DGE)
 ;
EN S L=0 I $S('$D(DFN):1,'$D(^DPT(+DFN,0)):1,1:0) G END
 S X=$P(^DPT(DFN,0),"^",1) I X?.E1L.E D FUNC S DIE=2,DA=DFN,DR=".01///"_X D ^DIE
CKADD I $D(^DPT(DFN,.11)) S X=$P(^DPT(DFN,.11),"^",1) I X["#" D ADD G CKADD
 I X?.E1L.E D FUNC S DIE=2,DA=DFN,DR=".111///"_X D ^DIE
 I $D(^DPT(DFN,.11)) S X=$P(^DPT(DFN,.11),"^",4) I X?.E1L.E D FUNC S DIE=2,DA=DFN,DR=".114///"_X D ^DIE
 S:'$D(DGHD) DGHD=0
 I $D(^DPT(DFN,"VET")),(^DPT(DFN,"VET")="N") S S=3 G CONT
 I '$D(^DPT(DFN,.3)) D MSG G END
 S X=$P(^DPT(DFN,.3),"^",1)
 S V="" I $D(^DPT(DFN,.361)) S V=$P(^DPT(DFN,.361),"^",1)
 S S=$S(X?1"Y"&(V?1"V"):2,X?1"Y"&(V'?1"V"):1,X?1"N":1,1:"") I S="" G END
 I X?1"Y"&(V'?1"V") W !,"Service connected eligibility NOT verified",!,"Card will be queued as Non service connected (blue)",!
 ;
CONT S S=$O(^DIC(39.1,"C",S,"")) I $S('S:1,'$D(^DIC(39.1,S,0)):1,'$P(^(0),"^",6):1,1:0) W !,"Embosser files not correctly set up...contact your site manager" G END
 S DGX=^DIC(39.1,S,0),S=$P(DGX,"^",6)
 D ERROR^DGQEMA1 ;check that data elements are complete
 I $D(DGE) D OK I 'DGFL G END
 S:'$D(DGQUAN) DGQUAN=$P(DGX,"^",4) S:'DGQUAN DGQUAN=1
 F K=1:1:7 S DGLINE(K)="" F DGI=0:0 S DGI=$O(^DIC(39.1,S,1,K,1,DGI)) Q:'DGI  I $D(^(DGI,0)) S DGJ=^(0) D DATA
 F K=8,9 D FT^DGQEMA1 I DGFL Q
 I DGFL=2 W !,*7,"Data card NOT queued" G END
 S DGTYP=S D ^DGQEMA1 ;hold or print
 ;
END K %,%Y,D,S,X,Y,L,AMT,DA,DGA,DGBLK,DGE,DGFL,DGHD,DGHOL,DGI,DGJ,DGLINE,DGQUAN,DGTYP,DGX,DIC,DIE,DR,DTOUT,I,K,V,Z
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 Q
 ;
FUNC S I=$O(^DD("FUNC","B","UPPERCASE",0)) X:$D(^DD("FUNC",+I,1)) ^DD("FUNC",I,1)
 Q
 ;
ADD S I=$F(X,"#") S X1=$E(X,1,I-2) S X=X1_" "_$E(X,I,99) S DIE=2,DA=DFN,DR=".111///"_X D ^DIE
 K X1 Q
 ;
DATA ;get lines 1-7 for data card per file 39.2
 ;DGJ=ptr to xecutable code^start position^length
 Q:'$D(^DIC(39.2,+DGJ,1))  X ^(1)
 K DGBLK S $P(DGBLK," ",80)=""
 S DGLINE(K)=$E(DGLINE(K)_DGBLK,1,$P(DGJ,"^",2)-1)_$E(Y_DGBLK,1,$P(DGJ,"^",3))
 Q
 ;
 ;
MAN ;manuel Q
 F DGPT=1:1:10 S DIC="^DPT(",DIC(0)="AEQMZ" W ! D ^DIC Q:Y'>0  S DFN=+Y D NUM Q:DGMANFL=2  I 'DGMANFL D EN
 K DFN,DGMANFL,DGPT,DIC,X,Y Q
 ;
NUM ;how many cards...set DGQUAN
 S DGMANFL=0 R !,"Number of cards to print (1-8):  1//",X:DTIME I '$T S DGMANFL=2 Q
 I X["^" S DGMANFL=1 Q
 I X="" S X=1 W X
 I X'>0!(X'<9) W !?3,"Enter the number of cards you wish to print (1-8)" G NUM
 S DGQUAN=X
 Q
 ;
 ;
MSG ;print error message if card can't be printed
 W !,"Service connected or NSC status not entered...cannot print card"
 Q
 ;
 ;
OK ;ask if ok to print data cards if data missing
 S DGFL=0 N S W !,"Do you still wish to emboss a patient data card" S %=2 D YN^DICN
 I %=0 W !?3,"Enter 'Y'es to emboss a card, otherwise, 'N'o." G OK
 I %=1 S DGFL=1
 Q
 ;
 ;
EMBOS ; -- Ask if user wants to emboss (OLD) data card, downloads data to VIC.
 ;    Called from DGREG00, DG10, and DG1010P
 ; -- Download VIC Data
 D VIC^DGQESC5
 Q  ;Do not do old card anymore patch 191
OLD ; -- Creates old card, if flag set in MAS parameter file
 S Y=$P(^DG(43,1,0),U,28) Q:'Y  W !,"EMBOSS (OLD) DATA CARD" S %=2 D YN^DICN I %=-1!(%=2) Q
 I %=0 W !,"  Enter YES to print patient data card for this patient, otherwise respond NO" G OLD
 I %=1 D EN
 Q
 ;
