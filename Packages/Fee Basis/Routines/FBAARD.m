FBAARD ;AISC/DMK-VOUCHER AUDIT DELETE REJECTS ENTERED IN ERROR ; 8/31/10 2:43pm
 ;;3.5;FEE BASIS;**114**;JAN 30, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
 S Q="",$P(Q,"=",80)="=",UL="",$P(UL,"-",80)="-",(CNT,FBAAOUT,FBINTOT)=0
 D DT^DICRW
BT K QQ W !! S DIC="^FBAA(161.7,",DIC(0)="AEQMN",DIC("S")="I $G(^(""ST""))=""V""&($P(^(0),U,17)]"""")" D ^DIC K DIC("S") G Q:X="^"!(X=""),BT:Y<0 S FBN=+Y,B=FBN,FZ=^FBAA(161.7,FBN,0),FBTYPE=$P(FZ,"^",3),FBAAON=$P(FZ,"^",2),FBAARA=0
 I FBTYPE="B9",$P(FZ,"^",15)="" S FBCNH=1
 S FBAAB=$P(FZ,"^"),FBAAOB=$P(FZ,"^",8)_"-"_FBAAON,FBCOMM="Rejects deleted from batch "_FBAAB
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) W !!,*7,"Sorry, only Supervisor can Delete reject flag!" G Q
 I '$S(FBTYPE="B3":$D(^FBAAC("AH",B)),FBTYPE="B2":$D(^FBAAC("AG",B)),FBTYPE="B5":$D(^FBAA(162.1,"AF",B)),FBTYPE="B9":$D(^FBAAI("AH",B)),1:0) W !!,*7,"No items rejected in this batch!" G BT
 S DA=FBN,DR="0;ST" W !! D EN^DIQ
 S FBNUM=$P(^FBAA(161.7,B,0),"^",1),FBVD=$P(^(0),"^",12),FBVDUZ=$P(^(0),"^",16)
ASKLL S B=FBN,FBNNP=1 S DIR(0)="Y",DIR("A")="Want line items listed",DIR("B")="NO" D ^DIR K DIR W:Y @IOF D:Y MORE^FBAARJP:FBTYPE="B3",PMORE^FBAARJP:FBTYPE="B5",TMORE^FBAARJP:FBTYPE="B2",CMORE^FBAARJP:FBTYPE="B9" K FBNNP
RD0 S DIR(0)="Y",DIR("A")="Want to delete rejection codes for the entire Batch",DIR("B")="NO",DIR("?")="^D ^FBAARD0" D ^DIR K DIR G Q:$D(DIRUT),^FBAARD1:Y
RD1 S DIR(0)="Y",DIR("A")="Want to delete rejection code for any line items",DIR("B")="NO" D ^DIR K DIR G Q:'Y,Q:$D(DIRUT) D DELT^FBAARD2:FBTYPE="B2",DELM:FBTYPE="B3",DELP^FBAARD2:FBTYPE="B5",DELC^FBAARD0:FBTYPE="B9"
 G Q:$D(FBERR)
RDD ;
FIN N FBFDART
 S FBFDART(161.7,FBN_",",13)=$G(DT)
 S FBFDART(161.7,FBN_",",14)=$G(DUZ)
 S FBFDART(161.7,FBN_",",11)="V"
 D FILE^DIE(,"FBFDART")
 S DIC="^FBAA(161.7,",DA=FBN,DR="0;ST" W !! D EN^DIQ G BT
Q K B,J,K,L,M,X,Y,Z,DIC,ERR,A,A1,A2,CPTDESC,DIRUT,DR,FBAACB,FBAACPT,FBAAON,FBAAOUT,FBAARA,FBIN,FBINOLD,FBINTOT,FBNUM,FBRR,FBTYPE,FBVD,FBVDUZ,FBVP,FZ,FBN,CNT,Q,P3,P4,UL,VAL,FBERR,FBAAMT,FBAAOB,FBCOMM,FBAAB,V,VID
 K FBAC,FBAP,FBDX,FBFD,FBK,FBX,FBPDT,FBSC,FBTD,S,ZS,PRCSCPAN,FBCNH,DUOUT
 Q
ERR S ERR=1 W !!,"Invalid entry, must enter a number between 1 and ",QQ,!,"or an '^' to exit!" Q
GET W !! S DIC="^FBAAA(",DIC(0)="AEQM" D ^DIC Q:X="^"!(X="")  G GET:Y<0 S DA=+Y,J=DA Q
DELM K QQ D GET Q:X="^"!(X="")  I '$D(^FBAAC("AH",B,J)) W !!,*7,"No payments in this batch for that patient!" G DELM
 S QQ=0,FBAAOUT="" W @IOF D HED^FBAACCB
 F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:K'>0!(FBAAOUT)  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:L'>0!(FBAAOUT)  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:M'>0!(FBAAOUT)  D WRITM
RL1 S DIR(0)="Y",DIR("A")="Delete Reject flag for all items for this patient",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G LOOP:Y
RL S ERR=0 S DIR(0)="N^1:"_QQ,DIR("A")="Delete reject for which line item" D ^DIR K DIR Q:$D(DIRUT)  S HX=X
 I '$D(QQ(HX)) W !,*7,"You already deleted that one!!" G RL
ASUR S DIR(0)="Y",DIR("A")="Are you sure you want to delete reject for item number "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RL
 S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2),L=$P(QQ(HX),"^",3),M=$P(QQ(HX),"^",4)
 D STUFF^FBAARD3 Q:$D(FBERR)
RDMORE S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Item Deleted.  ")_"Want to delete another",DIR("B")="YES" D ^DIR K DIR G RL:Y,DELM
WRITM S QQ=QQ+1,QQ(QQ)=J_"^"_K_"^"_L_"^"_M D SET^FBAACCB Q
LOOP F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0!($D(FBERR))  S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2),L=$P(QQ(HX),"^",3),M=$P(QQ(HX),"^",4) D STUFF^FBAARD3 Q:$D(FBERR)
 W !,"...DONE!" G DELM
