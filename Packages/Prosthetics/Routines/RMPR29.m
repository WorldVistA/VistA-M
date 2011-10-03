RMPR29 ;PHX/JLT-ENTER/EDIT 2529-3 [ 10/01/94  5:29 AM ]
 ;;3.0;PROSTHETICS;**12,41,62,128**;Feb 09, 1996
 ;RVD patch #62 - PCE and suspense link
CREATE ;CREATE 2529-3
 K RMPREDIT,RMPRTMP,RMPR25,^TMP($J,"RMPRPCE") D DIV4^RMPRSIT G:$D(X) EXIT1
 D GETPAT^RMPRUTIL I '$D(RMPRDFN) G EXIT1
VIEW ;CREATE 2529-3 VIA LAB MENU
 N RMPRDA,RMPRWO,RMPRJOB S RMPRF=4 D ^RMPRPAT I $D(RMPRKILL) G EXIT
 S DIC="^RMPR(664.1,",DIC(0)="ZL",X=DT
 S DLAYGO=664.1 D FILE^DICN K DLAYGO,DIC
 G:+Y'>0 EXIT1
 S RMPRDA=+Y,$P(^RMPR(664.1,RMPRDA,0),U,2)=RMPRDFN,$P(^(0),U,3)=RMPR("STA"),$P(^(0),U,17)="I"
 S IDEF=$$STA^RMPR31U(RMPR("STA"))
 S DA=RMPRDA,DIK="^RMPR(664.1," D IX1^DIK
 K DR,DA,DIC,Y,DIE D KVAR^VADPT
 S DFN=$P(^RMPR(664.1,RMPRDA,0),U,2),VAIP("D")="L"
 D IN5^VADPT S VAINDT=$P($G(VAIP(3)),U) D INP^VADPT
 I VAIN(1) S DR=".11R;.04R//^S X=$G(IDEF);2R;12//^S X=$P(VAIN(4),U,2);12.1//^S X=$P(VAIN(2),U,2);12.2//^S X=VAIN(9);12.3//^S X=$P(VAIN(3),U,2);12.4;.09R"
 I 'VAIN(1) S DR=".11R;.04R//^S X=$G(IDEF);2R;.09R"
EDT ;EDIT/DELETE 2529-3
 I $G(RMPRDA)>0,$G(RMPRDA)'="" G ST
 K DR,DIC D DIV4^RMPRSIT G:$D(X) EXIT1
 S RMPREDIT=1
 S DIC="^RMPR(664.1,",DIC(0)="AEQM",DR=".01"
 ;screen on complete, delete status
 S DIC("S")="I $P(^(0),U,17)'=""D""&($P(^(0),U,17)'=""C"")"
 S DIC("W")="D EN3^RMPRD1"
 D ^DIC K DIC
 G:+Y'>0 EXIT1 S RMPRDA=+Y
 I $G(RMPRDA)'>0 Q
 L +^RMPR(664.1,RMPRDA,0):1
 I '$T W $C(7),!!,?5,"Someone is already editing this entry" G EXIT
 D DSP^RMPR29R K DIR
 S DIR(0)="Y",DIR("A")="Would you like to Edit this Entry"
 S DIR("B")="YES" D ^DIR
 G:$D(DTOUT)!($D(DIRUT)) EXIT K DKILL,IKILL G:+Y=0 DEL
ST ;set data in 2529-3 file
 S RMPRDFN=$P(^RMPR(664.1,RMPRDA,0),U,2),DA=RMPRDA,DIE="^RMPR(664.1,"
 I '$D(DR),'$D(^RMPR(664.1,RMPRDA,"CDR")) S DR=".11R;.04;2R;.09R"
 I '$D(DR),$D(^RMPR(664.1,RMPRDA,"CDR")) S DR=".11R;.04R;2R;12;12.1;12.2;12.3;12.4;.09R"
 D ^DIE G:$D(Y)!($D(DTOUT)) CHK^RMPR29D
GD ;Display work order
 D DIS^RMPR29W(RMPRDFN,RMPRDA) G:$G(X)="^" CHK^RMPR29D G:+Y'>0 ITM
 K DR,DA,DIC,DIE
 S DIC="^RMPR(664.1,"_RMPRDA_",1,"
 S DIC("P")="664.15PA",DA(1)=RMPRDA
 S DIC(0)="EQMZL",X=Y(0,0),ELG=$P(Y(0),U,3)
 D ^DIC
 I +Y'>0 K DIC G GD
 S DIE=DIC K DIC
 S DA(1)=RMPRDA,DA=+Y
 S DR="1///^S X=ELG;.01;1"
 D ^DIE G:$D(DTOUT)!($D(Y)) CHK^RMPR29D G GD
ITM ;EDIT 2529-3 ITEM
 K DIR S DA=RMPRDA,DIC="^RMPR(664.1,"_RMPRDA_",2,"
 S DIC("P")="664.16PA",DA(1)=RMPRDA,DIC(0)="AEQMZL"
 S DIC("W")="S RA=$P(^(0),U,1) I +RA W ?16,$$ITM^RMPR31U(RA)"
 D ^DIC K DIC G:+Y'>0 CHK^RMPR29D
 S RY=$P(Y,U,2) D ITA^RMPR29U(RY)
 S DA=+Y,DIE="^RMPR(664.1,"_RMPRDA_",2,"
 S DR="8R;9R;13;7;2R;3R;12"
 D ^DIE G:$D(DTOUT) CHK^RMPR29D
 S RMTYPE=$P(^RMPR(664.1,RMPRDA,2,DA,0),U,7)
 I $D(DA) S RDATA=RMTYPE_"^"_RMPRDA_"^"_DA D CHKCPT^RMPR29U(RDATA)
 I $D(DA) S RY=$P(^RMPR(664.1,DA(1),2,DA,0),U),HCPCS=$P($G(^(2)),U,1),RMCPT=$P($G(^(2)),U,2) D ITA^RMPR29U(RY)
 K RMTYPE,RDATA,RMCPT
D G ITM
LAB ;ASK TO POST REQUEST
 S DIR(0)="Y",DIR("A")="Would you like to review this request"
 S DIR("B")="YES" D ^DIR G:$D(DTOUT)!($D(DIRUT)) EXIT
 I Y=1 S IOP="HOME" D PRT^RMPR29R
 K DIR S DIR(0)="Y",DIR("A")="Would you like to post this request"
 S DIR("B")="YES" D ^DIR G:$D(DTOUT)!($D(DIRUT)) EXIT
 I +Y=0 W !!,?5,$C(7),"Request not posted!!" G:$D(RMPR25) RDL G EXIT
 ;set temp transaction flag if needed
 K RMPRTMP I $P(^RMPR(664.1,RMPRDA,0),U,15)'=RMPR("STA") S RMPRTMP=1
 S RMPRWO=$P(^RMPR(664.1,RMPRDA,0),U,13) G:RMPRWO'="" SG S SCR=$P(^(0),U,11)
 D CR^RMPR29U(SCR)
 I '$D(RMPRWO) W !!,?5,$C(7),"Request not posted!!" G EXIT
SG ;set 2529-3 global
 S $P(^RMPR(664.1,RMPRDA,0),U,13)=$G(RMPRWO)
 ;set no admin count/no lab count
 I $P(^RMPR(664.1,RMPRDA,0),U,15)=RMPR("STA")&($P(^(0),U,4)'=RMPR("STA")) S $P(^(0),U,23)=1
 I $P(^RMPR(664.1,RMPRDA,0),U,15)'=RMPR("STA") S $P(^(0),U,20)=1 S:$D(RMPR25) $P(^RMPR(664.1,RMPRDA,0),U,23)=1 S DIE="^RMPR(664.1,",DA=RMPRDA,DR="16///^S X=""PC""" D ^DIE
 I '$P(^RMPR(664.1,RMPRDA,0),U,20) S DIE="^RMPR(664.1,",DA=RMPRDA,DR="16///^S X=""P""" D ^DIE
 S $P(^RMPR(664.1,RMPRDA,0),U,5)=DUZ,$P(^(0),U,18)=DT D ^RMPR29A
 I $G(RMPRWO)'="" W !!,?5,"Assigned Work Order Number: ",RMPRWO D:'$D(RMPRTMP) LOC^RMPR29R
 ;added by #62
 I $G(DA660),'$D(^RMPR(660,DA660,10)) D
 .S (RMPCAMIS,RMPRDFN)=""
 .S RMPCAMIS=$G(^RMPR(660,DA660,"AMS"))
 .S:$D(^RMPR(660,DA660,0)) RMPRDFN=$P(^RMPR(660,DA660,0),U,2)
 .I RMPCAMIS,RMPRDFN S ^TMP($J,"RMPRPCE",660,DA660)=RMPCAMIS_"^"_RMPRDFN
 ;suspense record inquiry
 D LINK^RMPRS
 W !! S DIR(0)="Y",DIR("A")="Would you like to print this 2529-3  request"
 S DIR("B")="YES" D ^DIR G:$D(DTOUT)!($D(DIRUT)) EXIT
 I Y=1 D PRT^RMPR29R
 ;
EXIT ;common exit point for both RMPR29 and RMPR29A
 ;
 L:+$G(RMPRDA) -^RMPR(664.1,+RMPRDA,0)
 S:$D(RMPR25)&($D(RMPRDA)) RMPRRDA=RMPRDA
 I '$D(RMPR25)&('$D(RMPREDIT)) W !! S DIR(0)="Y",DIR("A")="Would you like to Process another 2529-3 Request",DIR("B")="YES" D ^DIR G:+Y=1 CREATE
 D KVAR^VADPT
 K ^TMP($J,"RMPRPCE")
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
EXIT1 ;exit on error
 L:+$G(RMPRDA) -^RMPR(664.1,+RMPRDA,0)
 N RMPR,RMPRSITE D KVAR^VADPT,KILL^XUSCLEAN Q
DEL ;delete status 2529-3
 K DIR,Y
 S DIR(0)="Y",DIR("A")="Would you like to Delete this 2529-3 Entry"
 S DIR("B")="NO" D ^DIR G:$D(DTOUT)!($D(DIRUT)) EXIT1
 ;if not drop into edit mode
 I +Y=0 G:$D(DKILL) GD G:$D(IKILL) ITM G CHK^RMPR29D
 ;if it has a work order number, only mark as deleted
 ;delete entry in the 2319 record.
 N BO
 S BO=0
 F  S BO=$O(^RMPR(664.1,RMPRDA,2,BO)) Q:BO'>0  D
 .S DA=$P(^RMPR(664.1,RMPRDA,2,BO,0),U,5)
 .Q:DA=""
 .S DIK="^RMPR(660," D ^DIK
 W !,?5,"Updated 10-2319"
 K DA,DIK
 I $P(^RMPR(664.1,RMPRDA,0),U,13)'="" S DIE="^RMPR(664.1,",DA=RMPRDA,DR="16///^S X=""D""" D ^DIE W !,?5,$C(7),"Marked As Deleted..." G EXIT
RDL ;delete record
 ;the record is only deleted from 664.1 when the user creats a new
 ;and then at end say's no do not post.  Once it is posted, then
 ;it must only be marked as deleted.
 S DA=RMPRDA,DIK="^RMPR(664.1,"
 D ^DIK K DIK W !!,?5,$C(7),"Deleted..."
 ;delete the 2319 record
 N BO
 S DA=0,BO=0
 F  S BO=$O(^RMPR(664.1,RMPRDA,2,BO)) Q:BO'>0  D
 .S DA=$P(^RMPR(664.1,RMPRDA,2,BO,0),U,5)
 .Q:DA=""
 .S DIK="^RMPR(660," D ^DIK
 K DIK,DA,RMPRDA
 W !!,?5,"Updated 10-2319",!
 G EXIT
