XVIRPOST ;SF/RWF - Post init for virgin install ;07/07/95  13:36
 ;;8.0;KERNEL - VIRGIN INSTALL;;Jul 10, 1995
A W !,"Post init for virgin install"
 S DUZ=0,DUZ(0)="@" D NOW^%DTC S DT=X
 I $D(^VA(200,.5,0))[0 D POST
 I $O(^VA(200,.9))'>0 D F200
 I $O(^DIC(4.2,0))'>0 D DOMAIN
 I $O(^DIC(4,0))'>0 D INST
 I $O(^DIC(49,0))'>0 D SERV
 Q
DOMAIN W !,"We have added FORUM to the domain file."
 S DIC=4.2,DLAYGO=4,X="FORUM.VA.GOV",DIC(0)="LM" D ^DIC
 W !,"Now you need to enter the NETWORK MailMan domain name that will be use",!,"on the network and for the name of the Kernel site parameter entry."
 W !,"Use the format 'xxx.VA.GOV'"
 S DIC=4.2,DLAYGO=4,DIC(0)="AEMQL" D ^DIC I '$P(Y,U,3) W !,"You must enter the name of your local network mail node ",!,"so you may enter your KERNEL SITE PARAMITERS." G DOMAIN
 S ^XTV(8989.3,1,0)=+Y,^XMB(1,1,0)=+Y
 S DIK="^XTV(8989.3," D IXALL^DIK S DIK="^XMB(1," D IXALL^DIK
 K DIC Q
 ;
INST W !!,"Now lets add your Institution."
 S DIC=4,DLAYGO=4,DIC(0)="AEMQL" D ^DIC I Y'>0 W !,"You will need an entry in this file." G INST
 K DIC Q
 ;
SERV W !!,"Now to add 'IRM' to the service/section file."
 S DIC=49,DLAYGO=49,DIC(0)="MQL",X="IRM" D ^DIC
 K DIC Q
 ;
F200 W !!,"Now to add yourself to the NEW PERSON file."
 F XV1=200 S DIK=$G(^DIC(XV1,0,"GL")),X=@(DIK_"0)"),$P(^(0),"^",3)=$P(X,"^",3)\1
 S DIC=200,DIC(0)="AEMQL",DLAYGO=200 D ^DIC
 F XV2=200 S DIK=^DIC(XV2,0,"GL"),DIK(1)=".01" D ENALL^DIK K DIK
 K DIK,DIC,XV2 Q
 ;
POST ;Add postmaster
 S ^VA(200,.5,0)="POSTMASTER"
 F XV1=200 S DA=.5,DIK=$G(^DIC(XV1,0,"GL")),DIK(1)=.01 D EN1^DIK
 F XV1=200 S DIK=$G(^DIC(XV1,0,"GL")),X=@(DIK_"0)"),$P(^(0),"^",3)=$P(X,"^",3)\1
 K DIK,DIC,DA,XV1 Q
