FBAARD ;AISC/DMK - DELETE REJECTS ENTERED IN ERROR ;4/4/2012
 ;;3.5;FEE BASIS;**114,132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
 S Q="",$P(Q,"=",80)="=",UL="",$P(UL,"-",80)="-",(CNT,FBAAOUT,FBINTOT)=0
 D DT^DICRW
 I '$D(^XUSEC("FBAAREJECT",DUZ)) W !!,$C(7),"Sorry, you must hold the FBAAREJECT flag to use this option!" G Q
BT K QQ W !! S DIC="^FBAA(161.7,",DIC(0)="AEQMN",DIC("S")="I $G(^(""ST""))=""F""&($P(^(0),U,17)]"""")" D ^DIC K DIC("S") G Q:X="^"!(X=""),BT:Y<0 S FBN=+Y,B=FBN
 L +^FBAA(161.7,FBN):$G(DILOCKTM,3)
 I '$T W !,"Another user is editing this batch.  Try again later." G BT
 S FZ=^FBAA(161.7,FBN,0),FBTYPE=$P(FZ,"^",3),FBAAON=$P(FZ,"^",2),FBAARA=0
 I FBTYPE="B9",$P(FZ,"^",15)="" S FBCNH=1
 S FBAAB=$P(FZ,"^"),FBAAOB=$P(FZ,"^",8)_"-"_FBAAON,FBCOMM="Rejects deleted from batch "_FBAAB
 I '$S(FBTYPE="B3":$D(^FBAAC("AH",B)),FBTYPE="B2":$D(^FBAAC("AG",B)),FBTYPE="B5":$D(^FBAA(162.1,"AF",B)),FBTYPE="B9":$D(^FBAAI("AH",B)),1:0) W !!,*7,"No items rejected in this batch!" L -^FBAA(161.7,FBN) G BT
 S DA=FBN,DR="0:1;ST" W !! D EN^DIQ
 S FBNUM=$P(^FBAA(161.7,B,0),"^",1),FBVD=$P(^(0),"^",12),FBVDUZ=$P(^(0),"^",16)
ASKLL S B=FBN,FBNNP=1 S DIR(0)="Y",DIR("A")="Want line items listed",DIR("B")="NO" D ^DIR K DIR W:Y @IOF D:Y MORE^FBAARJP:FBTYPE="B3",PMORE^FBAARJP:FBTYPE="B5",TMORE^FBAARJP:FBTYPE="B2",CMORE^FBAARJP:FBTYPE="B9" K FBNNP
RD0 S DIR(0)="Y",DIR("A")="Want to delete local rejection codes for the entire Batch",DIR("B")="NO",DIR("?")="^D ^FBAARD0" D ^DIR K DIR G Q:$D(DIRUT),^FBAARD1:Y
RD1 S DIR(0)="Y",DIR("A")="Want to delete local rejection code for any line items",DIR("B")="NO" D ^DIR K DIR G Q:'Y,Q:$D(DIRUT) D DELT^FBAARD2:FBTYPE="B2",DELM:FBTYPE="B3",DELP^FBAARD2:FBTYPE="B5",DELC^FBAARD0:FBTYPE="B9"
 G Q:$D(FBERR)
RDD ;
 S DIC="^FBAA(161.7,",DA=FBN,DR="0:1;ST" W !! D EN^DIQ
 L -^FBAA(161.7,FBN)
 G BT
Q ; clean-up
 I $G(FBN) L -^FBAA(161.7,FBN)
 K B,J,K,L,M,X,Y,Z,DIC,A,A1,A2,CPTDESC,DIRUT,DR,FBAACB,FBAACPT,FBAAON,FBAAOUT,FBAARA,FBIN,FBINOLD,FBINTOT,FBNUM,FBRR,FBTYPE,FBVD,FBVDUZ,FBVP,FZ,FBN,CNT,Q,P3,P4,UL,VAL,FBERR,FBAAMT,FBAAOB,FBCOMM,FBAAB,V,VID
 K FBAC,FBAP,FBDX,FBFD,FBK,FBX,FBPDT,FBSC,FBTD,S,ZS,PRCSCPAN,FBCNH,DUOUT
 Q
DELM ; specify line items rejected in error for batch type B3
 ; select patient
 S J=$$ASKVET^FBAAUTL1("I $D(^FBAAC(""AH"",B,+Y))")
 Q:'J
 K QQ
 S QQ=0,FBAAOUT="" W @IOF D HED^FBAACCB
 F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:K'>0!(FBAAOUT)  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:L'>0!(FBAAOUT)  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:M'>0!(FBAAOUT)  D WRITM
 I QQ=0 W !,"No local rejects found in batch for this patient!" G DELM
RL1 S DIR(0)="Y",DIR("A")="Delete Reject flag for all items for this patient",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G LOOP:Y
RL S DIR(0)="N^1:"_QQ,DIR("A")="Delete reject for which line item"
 D ^DIR K DIR Q:$D(DIRUT)  S HX=X
 I '$D(QQ(HX)) W !,*7,"You already deleted that one!!" G RL
ASUR S DIR(0)="Y",DIR("A")="Are you sure you want to delete reject for item number "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RL
 S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2),L=$P(QQ(HX),"^",3),M=$P(QQ(HX),"^",4)
 D STUFF Q:$D(FBERR)
RDMORE S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Item Deleted.  ")_"Want to delete another",DIR("B")="YES" D ^DIR K DIR G RL:Y,DELM
WRITM ;
 Q:$P($G(^FBAAC(J,1,K,1,L,1,M,"FBREJ")),"^",4)=1  ; skip interface rej.
 S QQ=QQ+1,QQ(QQ)=J_"^"_K_"^"_L_"^"_M D SET^FBAACCB
 Q
STUFF ;
 N FBX
 S FBAAMT=+$P(^FBAAC(J,1,K,1,L,1,M,0),"^",3)
 D POST^FBAARD3 G PROB^FBAARD1:$D(FBERR)
 S FBX=$$DELREJ^FBAARR3("162.03",M_","_L_","_K_","_J_",")
 I 'FBX D
 . W !,"1358 was updated, but error occured while deleting the reject"
 . W !,"flag for line with IENS = "_M_","_L_","_K_","_J_","
 . W !,"  ",$P(FBX,"^",2)
 . S FBERR=1
 K QQ(HX)
 Q
LOOP F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0!($D(FBERR))  S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2),L=$P(QQ(HX),"^",3),M=$P(QQ(HX),"^",4) D STUFF Q:$D(FBERR)
 W !,"...DONE!" G DELM
