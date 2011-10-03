FBAAODP ;AISC/GRR-DELETE PAYMENT ;02APR86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S:'$D(^FBAAC(DFN,1,0)) ^FBAAC(DFN,1,0)="^162.01P^0^0"
RDV W !! S DIC="^FBAAC("_DFN_",1,",DIC(0)="AEQM",DA(1)=DFN D ^DIC G Q:X="^"!(X=""),RDV:Y<0 S (FBV,DA)=+Y
 I '$D(^FBAAC(DFN,FBV,"AD")) W !,"Vendor has no prior claims",! G RDV
 D EN1^FBAAVS
RDATE K FBSDI,FBAACPI W !! I '$D(^FBAAC(DFN,1,FBV,1,0)) S ^FBAAC(DFN,1,FBV,1,0)="^162.02DA^0^0"
 S DA(2)=DFN,DA(1)=FBV,DIC(0)="AEQM",DIC("A")="Date of Service: ",DIC="^FBAAC("_DFN_",1,"_FBV_",1," D ^DIC K DIC,DA G RDV:X="^"!(X=""),RDATE:Y<0 S FBSDI=+Y,FBAADT=$P(Y,"^",2)
 I '$D(^FBAAC(DFN,1,FBV,1,FBSDI,1,0)) S ^FBAAC(DFN,1,FBV,1,FBSDI,1,0)="^162.03A^0^0"
LOOK G CHKE
Q K FBAADT,FBX,FBAACP,FBAAOBN,FBAAODUZ,FBAAOPA,FBAACPI,FBSDI,FBMOD Q
CHKE S DIC="^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,",DIC(0)="AEQM",DA(3)=DFN,DA(2)=FBV,DA(1)=FBSDI D ^DIC Q:X=""!(X="^")  G RDATE:Y<0 S (FBAACPI,DA)=+Y D SETO
 I FBAABE'=FBAAOBN W !,*7,"Sorry, that payment is not in the Batch you selected!",*7 G RDATE
RD W ! S DIR("A")="Are you sure you want to delete this payment record",DIR("B")="No",DIR(0)="Y" D ^DIR K DIR Q:$D(DIRUT)  I 'Y G RDATE
 S DIK=DIC D ^DIK D  K A,B,J,K W !,"Payment record Deleted!",! G RDATE
 .; reset batch total and line count
 . I +$G(FBAABE) N DA,FBTOTAL,FBLCNT D CNTTOT^FBAARB(+FBAABE) D
 ..S DA=+FBAABE,DIE="^FBAA(161.7,",DR="10////^S X=FBLCNT;8////^S X=FBTOTAL;S:FBLCNT!(FBTOTAL) Y="""";9///@" D ^DIE K DIE,DR
 ..S:FBTOTAL=0 $P(^FBAA(161.7,+FBAABE,0),U,9)=""
 ..S:FBLCNT=0 $P(^FBAA(161.7,+FBAABE,0),U,11)=""
 Q
SETO S FBAAOPA=$S($P(Y,"^",3)=1:0,$D(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,0)):$P(^(0),"^",3),1:0),FBAAODUZ=$P(^(0),"^",7),FBAAOBN=$P(^(0),"^",8)
 S FY=$E(FBAADT,1,3)+1700+$S($E(FBAADT,4,5)>9:1,1:0)
 Q
