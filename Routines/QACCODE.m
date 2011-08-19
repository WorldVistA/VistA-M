QACCODE ;HISC/CEW - Enter/Edit a Local Contact Issue Code ;1/30/95  09:02
 ;;2.0;Patient Representative;**3**;07/25/1995
 ;*********Variable List*********************************
 ;ALPHCODE    =The major heading (ALPHA) code
 ;QASPECT     =The IEN of the Quality Aspect
 ;NEXNUM      =Next free number
 ;NUM         =The last code number
 ;NEWIEN      =The IEN of the new code
 ;QACIEN      =The IEN of the Issue
 ;
 ;
 ;
 ;
 ; This option no longer in use, as Issue Codes can no longer be
 ; entered or edited
 W !!?5,"Issue Codes can no longer be entered or edited."
 W !?5,"Only National Issue Codes are valid."
 W !?5,"The Issue Code list will be periodically evaluated and updated."
 Q
SLCHEAD ;
 ;Selects code to edit code text and status or a major heading
 ;under which a new code will reside.
 W ! K DIC S DIC="^QA(745.2,",DIC(0)="AEQZ"
 S DIC("A")="Select ISSUE CODE: "
 S DIC("S")="I ($P(^(0),U,5)'=""N""!($P(^(0),U,2)=1)),($P(^(0),U,1)?2U.N)"
 D ^DIC K DIC G:Y'>0 EXIT
 S ALPHCODE=Y(0,0),NUM=99,QASPECT=$P(Y(0),"^",4),QACIEN=+Y
 ;Find out if selection is a major code (ALPHA only) heading
 ;to ENTER a new code text or else a numbered code for EDITing.
 I $P(Y(0),U,2)="1" S FLAG=0 D ENTER G SLCHEAD
 E  D EDIT G SLCHEAD
ENTER ;Enter a new code text.  Code number is built in background.
 F  S NUM=$O(^QA(745.2,"AH",ALPHCODE,NUM)) D  Q:FLAG=1
 .I NUM'>200 S NEXNUM=ALPHCODE_"201" S FLAG=1 Q
 .S NEXNUM=ALPHCODE_(NUM+1)
 .I '$D(^QA(745.2,"B",NEXNUM)) S FLAG=1
 .Q
 I $E(NEXNUM,2,4)>999 W !,"Only 999 issue codes allowed per heading! Select a different heading." G SLCHEAD
 K DIR S DIR("A")="Are you adding '"_NEXNUM_"' as a new Contact Issue Code",DIR("0")="Y",DIR("B")="YES"
 D ^DIR K DIR Q:($D(DIRUT))!(Y=0)
 S DIC(0)="EMQLZ",DIC="^QA(745.2,",X=NEXNUM
 D FILE^DICN G EXIT:Y<1 K DIC
 S NEWIEN=+Y
 L +^QA(745.2,NEWIEN):0 I '$T W "Try again later." G SLCHEAD
 K DIE S DIE="^QA(745.2,",DA=NEWIEN,DR="1////0;3////"_QASPECT_";4////L;2;5"
 D ^DIE K DIE L -^QA(745.2,NEWIEN)
 Q
EDIT ;Edit an existing code text.
 L +^QA(745.2,QACIEN):0 I '$T W "Try again later." G SLCHEAD
 K DIE S DIE="^QA(745.2,",DA=QACIEN,DR="2;4;5"
 D ^DIE K DIE L -^QA(745.2,QACIEN)
 Q
EXIT ;
 K DIC,DIE,QACIEN,ALPHCODE,NEXNUM,NEWIEN,NUM,Y,X,FLAG
 K DA,DIRUT,DR,QASPECT
 Q
