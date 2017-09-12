RCRCPOST ;ALB/CMS - PRCA*4.5*63 POST ROUTINE ;
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
EN ;Enter from Patch Install
 D GRP,ATT,EVNT,ART,FORM,NDR,SET,INP
 Q
 ;
GRP ;Change AR Group Parameters
 ;AR Group File 342.1
 N DIE,DA,DR,X,Y W !,"Updating AR Group"
 S DIE="^RC(342.1,"
 S DA=$O(^RC(342.1,"B","DISTRICT COUNSEL",0))
 I DA="" G GRP2
 S DR=".01////REGIONAL COUNSEL;2.01////1;2.02////4999"
 D ^DIE
 ;
GRP2 ;AR Group Type File 342.2
 S DIE="^RC(342.2,"
 S DA=$O(^RC(342.2,"B","DISTRICT COUNSEL",0))
 I DA="" G GRPQ
 S DR=".01////REGIONAL COUNSEL;1.01////[RCMS REGIONAL COUNSEL]"
 D ^DIE
GRPQ Q
 ;
ATT ;add RC to AR TRANSMISSION TYPE 349.1
 N D,DA,D0,DIC,DIE,DLAYGO,DR,X,Y K DD,DO W !,"Adding RC to 349.1"
 S DA=$O(^RCT(349.1,"B","RC",0))
 I DA G ATTE
 S X="RC",DIC="^RCT(349.1,",DIC(0)="L",DLAYGO=349.1
 D FILE^DICN K DD,DO I Y<1 G ATTQ
 S DA=+Y
ATTE S DIE="^RCT(349.1,"
 S DR=".02///REGIONAL COUNSEL;.03///1;.04///90"
 D ^DIE
 ;** Ask user to point to their supporting Regional Counsel DOMAIN
ATTQ Q
 ;
EVNT ;Change AR Event File Entry
 N DA W !,"Changing AR Event File"
 S DA=$O(^RC(341.1,"B","DISTRICT COUNSEL PAYMENT",0))
 I 'DA G EVNTQ
 S $P(^RC(341.1,DA,0),U,1)="REGIONAL COUNSEL PAYMENT"
 S ^RC(341.1,"B","REGIONAL COUNSEL PAYMENT",DA)=""
 K ^RC(341.1,"B","DISTRICT COUNSEL PAYMENT",DA)
EVNTQ Q
 ;
ART ;Change AR Transactions containing DC/DOJ
 N DA,RCDC,RCI,RCX W !,"Updating AR Transactions"
 F RCI=3,5,6,7,29 S DA=$O(^PRCA(430.3,"AC",RCI,0)) Q:'DA  D
 .S RCDC=$P(^PRCA(430.3,DA,0),U,1)
 .I RCDC'[" DC" Q
 .I RCI'=3 S RCX=$P(RCDC,"DC/DOJ",1),RCX=RCX_"RC/DOJ"
 .I RCI=3 S RCX=$P(RCDC,"DC",1),RCX=RCX_"RC"
 .S $P(^PRCA(430.3,DA,0),U,1)=RCX
 .S ^PRCA(430.3,"B",RCX,DA)=""
 .K ^PRCA(430.3,"B",RCDC,DA)
ARTQ Q
 ;
FORM ;Change AR Form FL 4-484
 N DA,RCI,X,Y W !,"Updating AR Form"
 S DA=$O(^RC(343,"B","FL 4-484",0))
 I 'DA G FORMQ
 S RCI=0 F  S RCI=$O(^RC(343,DA,1,RCI)) Q:'RCI  D
 .S X=^RC(343,DA,1,RCI,0)
 .I X'["District" Q
 .S Y=$P(X,"District",1),X=$P(X,"District",2)
 .S ^RC(343,DA,1,RCI,0)=Y_"Regional"_X
FORMQ Q
 ;
NDR ;Change File 348 AR NDR Criteria
 N DA,DIE,DR,RCB,RCI,RCN,X,Y W !,"Updating AR NDR Criteria"
 F RCB=1230,1231,1232 S DA=$O(^RC(348,"B",RCB,0)) D
 .S RCN=$P(^RC(348,DA,0),U,2)
 .I RCN'["DISTRICT" Q
 .S Y=$P(RCN,"DISTRICT",1),RCN=$P(RCN,"DISTRICT",2)
 .S RCN=Y_"REGIONAL"_RCN
 .S DR="1////"_RCN S DIE="^RC(348," D ^DIE
NDRQ Q
 ;
SET ;Change DC in File 430 to RC
 N RC,RCI,RCY W !,"Changing Referral Code in File 430"
 S RCI=0 F  S RCI=$O(^PRCA(430,"AD",RCI)) Q:'RCI  D
 .S RCY=0 F  S RCY=$O(^PRCA(430,"AD",RCI,RCY)) Q:'RCY  D
 ..S RC=$P($G(^PRCA(430,RCY,6)),U,5)
 ..I RC="DC" S $P(^PRCA(430,RCY,6),U,5)="RC"
SETQ Q
 ;
INP ;Compile Input Template PRCA BATCH PAYMENT
 N X,Y,DNM,DMAX
 S X="PRCATB",DMAX=$$ROUSIZE^DILF
 S Y=$O(^DIE("B","PRCA BATCH PAYMENT",0))
 I Y D EN^DIEZ
INPQ Q
 ;
 ;RCRCPOST
