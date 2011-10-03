RMPRHL ;PHX/JLT-ENTER/EDIT/PRINT HOME LIAISON VISITS ;8/29/1994
 ;;3.0;PROSTHETICS;;Feb 09, 1996
OP ;OPEN HOME/LIAISON VISITS
 W ! D DIV4^RMPRSIT G:$D(X) EXIT K DA,Y,DIR S DIR(0)="665.1,.01O",DIR("A")="Enter HOME/LIAISON VISIT DATE OPENED" D ^DIR G:$D(DIRUT)!($D(DTOUT)) EXIT S DIC(0)="ZL",DIC="^RMPR(665.1,",X=Y,DLAYGO=665.1
 K D0,DD,DO D FILE^DICN K DLAYGO G:+Y'>0 OP
 K DIR S (RMPRA,DA)=+Y,DIE=DIC,RMPRSEM=";"
 L +^RMPR(665.1,RMPRA,0):1 I $T=0 W $C(7),?5,!,"Someone else is editing this record" G EXIT
 S DR="1;I $P(^RMPR(665.1,DA,0),U,2)="""" S Y="""";6////^S X=RMPR(""STA"");I $P($P(^RMPR(665.1,DA,0),U,2),RMPRSEM,2)[""DPT("" S Y=""@1"";2//^S X=""LIAISON"";3;5;S Y=""@3"";@1;2//^S X=""HOME"";3;5;"
 S DR=DR_"@3;4;I '$P(^RMPR(665.1,DA,0),U,5) S Y="""";4.5"
 D ^DIE L -^RMPR(665.1,RMPRA,0) I $P(^RMPR(665.1,DA,0),U,2)=""!($P(^(0),U,3)="")!($P(^(0),U,4)="") S DIK="^RMPR(665.1," D ^DIK W !!,?5,$C(7),"Deleted...",! G OP
 I '$P(^RMPR(665.1,DA,0),U,5)!($P(^(0),U,6)="") S DR="4///@;4.5///@" D ^DIE W !!,?5,$C(7),"VISIT HAS NOT BEEN CLOSED OUT"
 G OP
CL ;CLOSE HOME/LIAISON VISITS
 W !! D DIV4^RMPRSIT G:$D(X) EXIT S DIC(0)="AEQM",DIC=665.1,DIC("A")="Select HOME/LIAISON VISIT DATE OPENED: ",DIC("W")="W "" "" D DSP^RMPRHL",DIC("S")="I $P(^(0),U,7)=RMPR(""STA"")" K Y D ^DIC G:+Y'>0 EXIT
 S RMPRA=+Y L +^RMPR(665.1,RMPRA,0):1 I $T=0 W $C(7),?5,!,"Someone else is Editing this entry!"  G EXIT
 S DA=+Y,DIE=DIC,DR="4;I '$P(^RMPR(665.1,DA,0),U,5) S Y="""";4.5" W ! D ^DIE I '$P(^RMPR(665.1,DA,0),U,5)!($P(^(0),U,6)="") S DR="4///@;4.5///@" D ^DIE W !!,?5,$C(7),"VISIT HAS NOT BEEN CLOSED OUT"
 L -^RMPR(665.1,RMPRA,0) G CL
ED ;EDIT/DELETE HOME/LIAISON VISITS
 W ! D DIV4^RMPRSIT G:$D(X) EXIT
 S DIC("S")="I $P(^(0),U,7)=RMPR(""STA"")",DIC(0)="AEQM",DIC=665.1,DIC("A")="Select HOME/LIAISON VISIT DATE OPENED: ",DIC("W")="W "" "" D DSP^RMPRHL" D ^DIC G:+Y'>0 EXIT
 S RMPRA=+Y L +^RMPR(665.1,RMPRA,0):1 I $T=0 W !,$C(7),?5,"Someone else is Editing this entry!" G EXIT
 S DA=+Y,DIE=DIC,DR=".01;1R;2;3;5;I '$P(^RMPR(665.1,DA,0),U,5) S Y="""";4;4.5" D ^DIE I $D(DA) I '$P(^RMPR(665.1,DA,0),U,5)!($P(^(0),U,6)="") S DR="4///@;4.5///@" D ^DIE
 L -^RMPR(665.1,RMPRA,0) G ED
PO ;PRINT OPEN HOME/LIAISON VISITS
 S L=0,BY="[RMPR OPEN VISITS]",DIC="^RMPR(665.1,",FLDS="[RMPR OPEN VISITS]",DHIT="S $P(RL,""-"",IOM)="""" W:$Y>6 RL",DIOEND="I IOST[""C-"" S RX=""I $Y<21 F  W ! Q:$Y>21"",DIR(0)=""E"" X RX D ^DIR" D EN1^DIP G EXIT
CV ;PRINT CLOSED HOME/LIAISON VISITS
 S L=0,BY="[RMPR CLOSED VISITS]",DIC="^RMPR(665.1,",FLDS="[RMPR CLOSED VISITS]",DHIT="S $P(RL,""-"",IOM)="""" W:$Y>6 RL",DIOEND="I IOST[""C-"" S RX=""I $Y<21 F  W ! Q:$Y>21"",DIR(0)=""E"" X RX D ^DIR" D EN1^DIP G EXIT
EXIT K RX,DA,RL,Y,DIC,DR,DIR,DIE,DIK,FLDS,DHIT,L,BY,RMPRSEM,RMPRA Q
DSP ;DISPLAY HOME/LIAISON VISITS
 I $P($P(^RMPR(665.1,+Y,0),";",2),U,1)="DIC(4," D DSPI Q
 I $P($P(^RMPR(665.1,+Y,0),";",2),U,1)="PRC(440," D DSPV Q
 W ?20,$E($P(^DPT(+$P(^RMPR(665.1,+Y,0),U,2),0),U),1,20),?40,"  ",$S($P(^RMPR(665.1,+Y,0),U,3)'="":$S($P(^(0),U,3)["H":"HOME",1:"LIAISON"),1:""),?60 I $P(^(0),U,4) W $E($P(^VA(200,$P(^(0),U,4),0),U),1,15) Q
DSPI W ?20,$E($P(^DIC(4,+$P(^RMPR(665.1,+Y,0),U,2),0),U),1,20),?40," ",$S($P(^RMPR(665.1,+Y,0),U,3)'="":$S($P(^(0),U,3)["H":"HOME",1:"LIAISON"),1:""),?60 I $P(^(0),U,4) W $E($P(^VA(200,$P(^(0),U,4),0),U),1,15) Q
DSPV W ?20,$E($P(^PRC(440,+$P(^RMPR(665.1,+Y,0),U,2),0),U),1,20),?40," ",$S($P(^RMPR(665.1,+Y,0),U,3)'="":$S($P(^(0),U,3)["H":"HOME",1:"LIAISON"),1:""),?60 I $P(^(0),U,4) W $E($P(^VA(200,$P(^(0),U,4),0),U),1,15) Q
TRS ;INPUT TRANSFORM FOR TOTAL HOURS
 ;Hours field, under Technician mult., in file 664.3
 I +X'=X!(X>999)!(X<0)!(X?.E1"."3N.N) K X Q
 I $P(X,".",2)="" Q
 I $P(X,".",2)="5" Q
 I $P(X,".",2)="75" Q
 I $P(X,".",2)="25" Q
 K X Q
 ;END
