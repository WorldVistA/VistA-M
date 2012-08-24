LR105PO ;DALISC/FHS - LR*5.2*105 POST INSTALL ROUTINE KIDS INSTALL"
 ;;5.2;LAB SERVICE;**105**;Feb 14, 1996
EN ;
 S X=$$ADD^XPDMENU("LR LIM/WKLD MENU","LR WKLD CODE EDIT PRINT")
 W !!,"Option [LR WKLD CODE EDIT PRINT] was ",$S(X:"added",1:"NOT ADDED")," to [LR LIM/WKLD] MENU",!!
 S DA=$O(^LAB(64.2,"B","DSS ACC",0)) G:DA DIS
 L +^LAB(64.2):1 I '$T W !,"^LAB(64.2) GLOBAL IS LOCKED BY ANOTHER USER",!,"DSS ACC suffix not added.",!! H 5 G BB
 K DIE,DIC,DA,DR S DLAYGO=64,DIC="^LAB(64.2,",DIC(0)="L",X="DSS ACC" D ^DIC
 I Y<1 W !?5,"Not able to install new workload code.",! L -^LAB(64.2) G BB
 K DIE,DIC,DA,DR,DLAYGO,X S DIE="^LAB(64.2,",DA=+Y,DLAYGO=64.2
 S DR="1///^S X=.9999;6////38;11////1;12////10"
 D ^DIE L -^LAB(64.2)
DIS K DIC,DIE,DR,DLAYGO G:'$G(DA) BB
 S S=0,DIC="^LAB(64.2," D EN^DIQ
 W !!?5,"This new Workload Code Suffix has been added to ^LAB(64.2 ",!!
BB ;G END ;Blood bank's multi-divisional test sites should uncomment this line.
 K DA,DIK S DA(1)=65,DA=.16,DIK="^DD(65," D ^DIK K DA,DIK
 W !!," The DIVISION #.16 field has been deleted from the BLOOD INVENTORY #65",!!
END ;
 I '$D(^LRO(64.03,0))#2 W !!,"Database Error",!?5,"Your system is missing the ^LRO(64.03) Global" G STOP
 W !,$$CJ^XLFSTR("Preparing to purge data from WKLD LOG FILE (#64.03)",80)
 L +^LRO(64.03):5 I $T W !!,$$CJ^XLFSTR("Purging data <Please wait> ",80),! D  G STOP
 . S X=$P(^LRO(64.03,0),U,1,2) K ^LRO(64.03) S ^LRO(64.03,0)=X
 . W !,"Turning [OFF] COLLECT WKLD LOG FILE (#616) field in LABORATORY SITE (#69.9) file",!!
 . S $P(^LAB(69.9,1,"NITE"),U,6)="" W !?5,"Laboratory DSS Site Preparation completed",!!
 W !!!,$$CJ^XLFSTR("Unable to Lock the ^LRO(64.03) Global - Contact the CS Clin2",80)
 W !,$$CJ^XLFSTR("for assistance. The Patch install is complete but data in file #64.03",80)
 W !!,$$CJ^XLFSTR("was NOT PURGED.",80),!
STOP L -^LRO(64.03)
 S:$D(^LAM(0))#2 $P(^(0),U,3)=99999
 W !!,$$CJ^XLFSTR("Post install completed",80),!!
 K DIE,DIC,DA,DR,DLAYGO,X,Y,S Q
