GMTSPP ;SLC/KER - Define HS Print-by-Location Parameters ; 09/21/2001
 ;;2.7;Health Summary;**2,30,47**;Oct 20, 1995
 ;
 ; External References
 ;    DBIA 10003  DD^%DT
 ;    DBIA 10006  ^DIC
 ;    DBIA  2051  FIND^DIC
 ;    DBIA 10018  ^DIE
 ;    DBIA  2056  $$GET1^DIQ
 ;    DBIA 10026  ^DIR
 ;                  
MAIN ; Print by Location
 K DIC,DIE,DIR
 S DIC=19.2,DIC(0)="F",X="GMTS TASK STARTUP" S Y=$$SDT(X)
 I Y<0 D ALERT K X,Y G MAIN1
 I Y>DT D QUEOK K Y G MAIN1
 D ALERT
MAIN1 ; Controls Branching
 F  D GETDATA Q:$D(PPQIT)!$D(DTOUT)
 K CLINIC,DIROUT,DIRUT,DTOUT,DUOUT,GMTSIFN,GMTSLOC,J1,J2,NEWTYP,PPQIT,X,B,C,D0,DI,DIJ,DISYS,DP,DQ,P
 Q
QUEOK ; Informs user of print time if queued to print
 D DD^%DT S QTIM=Y K Y
 W !!,"For your information:",!
 W "Health Summary Batches are queued to print nightly at ",QTIM,!
 W "and should be available for distribution by early morning.",!
 K QTIM
 Q
ALERT ; Warns user that summaries have not been queued
 W !!,"                                ***Alert***",!!
 W "Health Summary batches have not been queued to print or date is not current.",!
 W "Please ask your IRM SERVICE to queue option GMTS TASK STARTUP",!
 W "to run nightly.  Parameters may be set now but will not produce",!
 W "Health Summaries until option is queued."
 Q
GETDATA ; Selects Location/Health Summary Type and Edits parameters
 S DIC=44,DIC(0)="AEMQZ",DIC("A")="Select Hospital Location: ",DIC("S")="I ""WCOR""[$P(^(0),U,3)" W ! D ^DIC K DIC
 I Y=-1 K X,Y S PPQIT=1 Q
 S GMTSLOC=+Y,GMTSLNM=$P(Y,U,2),CLINIC=$S("COR"[$P(Y(0),U,3):1,1:0) K X,Y
 I $O(^GMT(142,"D",GMTSLOC,0)) D DISPLAY
 K GMTSLNM
 S DIC=142,DIC(0)="AEQ",DIC("A")="Select Health Summary Type: " S Y=$$TYPE^GMTSULT K DIC
 I X="" K X,Y Q
 I Y=-1 K X,Y S PPQIT=1 Q
 S GMTSIFN=+Y,NEWTYP=1,TYP1=0
 F  S TYP1=$O(^GMT(142,"D",GMTSLOC,TYP1)) Q:TYP1=""  I GMTSIFN=TYP1 S NEWTYP=0 Q
 S GMTSUM=$P(Y,U,2),GMTSNEW=0,EXISTS=1,GMTSQIT=0 K X,Y D LIST^GMTSRM
 K GMTSNEW,EXISTS,GMTSQIT,GMTSUM,TYP1
 Q:$D(DUOUT)  I $D(DIRUT) S PPQIT=1 Q
 I NEWTYP=1 D NEW Q
 S DIR(0)="Y",DIR("A")="Do you wish to delete this Health Summary Type from the nightly print",DIR("B")="NO"
 W ! D ^DIR K DIR
 Q:$D(DUOUT)  I $D(DIRUT) S PPQIT=1 Q
 S DIE="^GMT(142,"_GMTSIFN_",20,",DIE("NO^")="OUTOK",DA(1)=GMTSIFN
 S DA=$O(^GMT(142,"D",GMTSLOC,GMTSIFN,0)),DEL=0
 I Y=1 S DR=".01///@",DEL=1
 K X,Y
 E  S:CLINIC DR=".02;I $P($G(^GMT(142.99,1,0)),U,2)'=""Y"" S Y=""@1"";.03;@1;.04//0" S:'CLINIC DR=".02;I $P($G(^GMT(142.99,1,0)),U,2)'=""Y"" S Y=0;.03" W !
 D ^DIE
 I DEL W !!,"**Print for Health Summary Type deleted**"
 K DIE,DA,DR,X,Y,DEL
 Q
DISPLAY ; Displays Health Summary Types associated with Location
 W !!,"At present the following Health Summary Types are printed for ",GMTSLNM,":"
 W !?70,"Action",!?2,"Type",?32,"Device" W:CLINIC ?54,"Days Ahead" W ?70,"Profile",!
 S DEVFLG=0
 S TYP=0 F J1=1:1 S TYP=$O(^GMT(142,"D",GMTSLOC,TYP)) Q:TYP=""  D WRITE
 I DEVFLG W !!,"*This Type will not print since Device is invalid or has not been entered"
 W !!,"You may edit a Health Summary Type from the list or enter a new Type",!
 K TYP,DEVFLG
 Q
WRITE ; Writes Health Summary Type with parameters
 S TYPNM=$P(^GMT(142,TYP,0),U),LOCIFN=$O(^GMT(142,"D",GMTSLOC,TYP,0))
 S DATA=^GMT(142,TYP,20,LOCIFN,0),DEV=$P(DATA,U,2)
 S X="`"_DEV,DIC=3.5,DIC(0)="" D ^DIC
 I +Y'>0 S DEVFLG=1
 S DEVNM=$S(+Y>0:$P(Y,U,2),DEV="":"None",1:DEV_" (Invalid)")
 W !,$S(+Y'>0:"*",1:" "),TYPNM,?32,$E(DEVNM,1,21),?59,$P(DATA,U,4),?72,$S($P(DATA,U,3)="Y":"Yes",1:"No") K DIC,X,Y
 K DATA,DAYS,DEV,DEVNM,LOCIFN,TYPNM
 Q
NEW ; Sets parameters for new Health Summary Type
 S (NI,LI)=0 I $D(^GMT(142,GMTSIFN,20,0)) F  S NI=$O(^GMT(142,GMTSIFN,20,NI)) Q:NI'>0  S LI=NI
 S:'$D(^GMT(142,GMTSIFN,20,0)) ^(0)="^142.2P^^"
 S DIE="^GMT(142,"_GMTSIFN_",20,",DA(1)=GMTSIFN,DA=LI+1,DIE("NO^")="OUTOK"
 I CLINIC S DR=".01////"_GMTSLOC_";.02;I $P($G(^GMT(142.99,1,0)),U,2)'=""Y"" S Y=""@1"";.03;@1;.04//0"
 E  S DR=".01////"_GMTSLOC_";.02;I $P($G(^GMT(142.99,1,0)),U,2)'=""Y"" S Y=0;.03"
 W ! D ^DIE K DIE,DA,DR,X,Y,NI,LI,J3
 Q
SDT(X) ; Get the last schedule date/time
 N GMTSM,GMTSR,GMTSI,GMTSE,GMTSDA S (GMTSI,GMTSM)=0
 D FIND^DIC(19.2,,,"X",X,5,,,,"GMTSDA")
 F  S GMTSI=$O(GMTSDA("DILIST",2,GMTSI)) Q:GMTSI'>0  D
 . S GMTSE=GMTSDA("DILIST",2,GMTSI) Q:+GMTSE'>0
 . S GMTSR=$$GET1^DIQ(19.2,(GMTSE_","),2,"I")
 . S:+GMTSR>GMTSM GMTSM=+GMTSR
 S X=$S(+($G(GMTSM))>0:+($G(GMTSM)),1:-1) Q X
