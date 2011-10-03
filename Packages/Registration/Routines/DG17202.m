DG17202 ;BHM/RGY,ALS-Create new request for patient demographic change ;FEB 20, 1998
 ;;5.3;Registration;**172**;Aug 13, 1993
ADD(FILE) ;
 NEW DIC,D0,DIE,DA,X,DLAYGO,DR,RGOK,EVN,DINUM
 F EVN=+$P(^XTMP("DGTMP",FILE,0),"^",3)+1:1 L +^XTMP("DGTMP",FILE,EVN):0 I $T S RGOK=0 D  L -^XTMP("DGTMP",FILE,EVN) Q:RGOK
 .I $D(^XTMP("DGTMP",FILE,EVN)) Q
 .S DINUM=EVN,DIC="^XTMP(""DGTMP"","_FILE_",",DIC(0)="L",DLAYGO=FILE,X=EVN K DD,D0 D FILE^DICN K DIC,DLAYGO,D0
 .S RGOK=1
 .Q
 Q EVN
ADDR(FILE,NAME) ;
 NEW DIC,D0,DIE,DA,X,DLAYGO,DR,RGOK,EVN,DINUM
 F EVN=+$P(^DIC(FILE,0),"^",3)+1:1 L +^DIC(FILE,EVN):0 I $T S RGOK=0 D  L -^DIC(FILE,EVN) Q:RGOK
 .I $D(^DIC(FILE,EVN)) Q
 .S DINUM=EVN,DIC="^DIC("_FILE_",",DIC(0)="L",DLAYGO=FILE,X=NAME K DD,D0 D FILE^DICN K DIC,DLAYGO,D0
 .S RGOK=1
 .Q
 Q EVN
CONV ;Start conversion process
 NEW TASK
 I '$$CHK() Q
 I '$$CHK2() Q
 L +^XTMP("DGTMP",390.1,"ASTOP"):1 E  Q
 F TASK=0:0 S TASK=$O(^XTMP("DGTMP",390.1,TASK)) Q:'TASK  I $P(^XTMP("DGTMP",390.1,TASK,0),"^",9)="" D TASK(TASK) I $G(^XTMP("DGTMP",390.1,"ASTOP"))="YES" D SEND G Q1
 D SEND,JOBKILL
Q1 Q
SEND ;
 L -^XTMP("DGTMP",390.1,"ASTOP")
 D BROAD^DG17204
 Q
TASK(TASK) ;Convert a file (task)
 NEW GLOB,ENTRY,NODE,OV,PIECE,N0,NV,TYPE,COUNT,FIELD
 S N0=$G(^XTMP("DGTMP",390.1,TASK,0)) I N0="" Q
 S COUNT=0,GLOB="^"_$P(N0,"^",4),NODE=$P(N0,"^",5),FIELD=$P(N0,"^",3),PIECE=$P(N0,"^",6),TYPE=$P(N0,"^",7)
 I $P(^XTMP("DGTMP",390.1,TASK,0),"^",9)]"" Q
 I '$$CHK1(TYPE) D NOW^%DTC S $P(^XTMP("DGTMP",390.1,TASK,0),"^",9)=% K % Q
 F ENTRY=$P(N0,"^",8):0 S ENTRY=$O(@(GLOB_ENTRY_")")) Q:'ENTRY  D  I $G(^XTMP("DGTMP",390.1,"ASTOP"))="YES" G OUT
 .S OV=$P($G(@(GLOB_ENTRY_","_NODE_")")),"^",PIECE)
 .S NV=$$GETNV(TYPE,OV)
 .I NV'=-1,NV'=OV D
 ..S DIE=GLOB,DA=ENTRY,DR=FIELD_"////^S X="""_$S(NV="":"@",1:NV)_"""" D ^DIE
 ..I NV'="" S X=$P(^XTMP("DGTMP",390.2,$O(^XTMP("DGTMP",390.2,$S(TYPE=13:"AC",1:"AD"),OV,0)),0),"^",9),$P(^(0),"^",9)=X+1
 ..Q
 .S $P(^XTMP("DGTMP",390.1,TASK,0),"^",8)=ENTRY
 .Q
 S $P(^XTMP("DGTMP",390.1,TASK,0),"^",9)=$$NOW^XLFDT
OUT Q
GETNV(TYPE,VALUE) ;
 NEW NV
 I VALUE=0 Q ""
 I VALUE="" Q -1
 ;IF POINTS TO A INVALID VALUE SET TO NULL
 I '$D(^DIC(TYPE,VALUE,0)) Q ""
 ;IF POINTS TO A NEW ENTRY...IT WAS A BROKEN POINTER TO BEGIN WITH
 I $P($G(^XTMP("DGTMP",390.2,+$O(^XTMP("DGTMP",390.2,$S(TYPE=13:"AC",1:"AD"),VALUE,0)),0)),"^",8)=1 Q ""
 S NV=$P(^XTMP("DGTMP",390.2,$O(^XTMP("DGTMP",390.2,$S(TYPE=13:"AC",1:"AD"),VALUE,0)),0),"^",$S(TYPE=13:6,1:7))
 I NV Q NV
 Q VALUE
CHK() ;IS CONVERSION NECESSARY?
 FOR X=0:0 S X=$O(^XTMP("DGTMP",390.2,X)) Q:'X  I $P(^XTMP("DGTMP",390.2,X,0),"^",8)!'$P(^(0),"^",3) Q
 Q X>0
CHK1(FILE) ;IS CONVERSION FOR A FILE NECESSARY?
 FOR X=0:0 S X=$O(^XTMP("DGTMP",390.2,X)) Q:'X  I $P(^XTMP("DGTMP",390.2,X,0),"^",2)=FILE I $P(^XTMP("DGTMP",390.2,X,0),"^",8)!'$P(^(0),"^",3) Q
 Q X>0
CHK2() ;ARE ALL THE NONSTANDARD ENTRIES MAPPED?
 FOR X=0:0 S X=$O(^XTMP("DGTMP",390.2,X)) Q:'X  I '$P(^XTMP("DGTMP",390.2,X,0),"^",3),$P(^(0),"^",6)="",$P(^(0),"^",7)="" Q
 Q '(X>0)
CHK3() ;DID THE CONVERSION RUN TO COMPLETION?
 I '$$CHK() Q 1
 FOR X=0:0 S X=$O(^XTMP("DGTMP",390.1,X)) Q:'X  I '$P(^XTMP("DGTMP",390.1,X,0),"^",9) Q
 Q '(X>0)
JOB ;Start background job
 NEW ZTIO,ZTDTH,ZTASK,ZTRTN,ZTDESC,DIR,DIRUT
 I '$$CHK() W !!,"*** Conversion is not necessary! ***",!!,"Uninstalling patch..." D JOBKILL W "...done!" Q
 I '$$CHK2() W !!,"*** Not all non-standard entries have been mapped...see DG172 options ***",! Q
 L +^XTMP("DGTMP",390.1,"ASTOP"):1 E  W !,"*** Job appears to already be running! ***",! Q
 W ! D MESS^DG17204("CONV") W !
 S DIR("A")="Are you sure you want to start the conversion process"
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR Q:$D(DIRUT)!'Y
 L -^XTMP("DGTMP",390.1,"ASTOP")
 S ^XTMP("DGTMP",390.1,"ASTOP")="NO"
 S ZTIO="",ZTRTN="CONV^DG17202",ZTDESC="Marital/Religion File Conversion" D ^%ZTLOAD
 I $D(ZTSK) W !,"*** Task #: "_ZTSK_" ***",!
 S ZTREQ="@"
 K ZTSK,Y
 Q
STOP ;Stop background job
 NEW DIR,DIRUT
 L +^XTMP("DGTMP",390.1,"ASTOP"):1 E  D  Q
   .S DIR("A")="Are you sure you want to stop the background conversion process",DIR(0)="Y",DIR("B")="NO"
   .D ^DIR K DIR Q:$D(DIRUT)!'Y
   .S ^XTMP("DGTMP",390.1,"ASTOP")="YES"
   .W !!,"*** Job will stop soon ***",! K Y
   .Q
 L -^XTMP("DGTMP",390.1,"ASTOP")
 W !,"*** Conversion process is NOT running! ***",!
 Q
JOBKILL ;
 NEW OPT,FILE,DA,DR,DIE,IDEL,NON,PI,ITEM
 FOR NON=0:0 S NON=$O(^XTMP("DGTMP",390.2,NON)) Q:'NON  I '$P(^(NON,0),"^",3) D
 .S DIE=$P(^(0),"^",2),DA=$S(DIE=11:$P(^(0),"^",5),1:$P(^(0),"^",4)),DR=".01///@",DIE="^DIC("_DIE_"," D ^DIE
 .Q 
 F FILE=390.1,390.2 S DIU="^XTMP(""DGTMP"","_FILE_",",DIU(0)="DT" D EN^DIU2
 K DIU
 S OPT="RGPR PRE-IMP MENU" S PI=$$FIND1^DIC(19,"","OX",OPT)
 I PI D FIND^DIC(19,"",.01,"M","DG172 ") S ITEM="" F  S ITEM=$O(^TMP("DILIST",$J,1,ITEM)) Q:ITEM=""  S IDEL=$$DELETE^XPDMENU(OPT,$P(^TMP("DILIST",$J,1,ITEM),U))
 S OPT="DG172" F  S OPT=$O(^DIC(19,"B",OPT)) Q:$E(OPT,1,5)'="DG172"  S DIE="^DIC(19,",DA=$O(^(OPT,0)),DR=".01///@",DIDEL=19 D ^DIE K DIDEL
 Q
