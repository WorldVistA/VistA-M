YSD4POST ;DALISC/LJA -Post-init for the Mental Health 5.01 [ 04/10/94  12:43 PM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
CTRL ;
 D END
 D START ;          Give 'em a "starting" message
 D OUT^YSD4PRE0 ;   Place out of order message on all DSM options
 D YSONIT ;         Install the YS PATIENT MOVEMENT protocol
 D DELOPT ;         Delete obsolete options
 D DELTEMP ;        Delete obsolete 'YSPN*' templates
 D SETP ;           Update parameter data
 D PROGMSG ;        Progress message
 D DSMCK^YSD4POS0 ; Check DSM conversion environment
 ;                  (Note: YSD4OK var from DSMCK evaluated by DSMCONV...)
 D DSMCONV ;        Convert DSM data
 D OUT ;            Take out of order message off all DSM options
 D KILLALL^YSD4UT01 ; Kill all variables used in the DSM conversion
 D END
 QUIT
 ;
START ; Start of Post Init Process
 W !!,"Starting Post-init process..."
 H 2
 QUIT
YSONIT ;
 W !!,"Adding the YS PATIENT MOVEMENT to the DGPM MOVEMENT EVENTS protocol..."
 D ^YSONIT
 QUIT
 ;
DELOPT ;  Delete obsolete options
 N DA,DIK,YSNM,YSNO
 W !!,"Deleting obsolete options..."
 F YSNM="YSCENHX","YSCENPATL","YSCENPROB","YSCENTPT","YSCENUP","YSDIAGP","YSKEY","YS SITE-FILE 19" D
 .  S YSNO=+$O(^DIC(19,"B",YSNM,0)) QUIT:YSNO'>0
 .  I $D(^DIC(19,"AC",+YSNO)) D  QUIT
 .  .  W !!,"The ",YSNM," option is being used by other options and cannot be deleted",!!
 .  S DA=+YSNO,DIK="^DIC(19,"
 .  D ^DIK
 QUIT
 ;
DELTEMP ;  Delete obsolete templates
 N DA,DIK,YSPNTEMP
 W !!,"Deleting obsolete YSPN* print templates .... "
 S YSPNTEMP="YSPN",DIK="^DIC(19,",DA=""
 F  S YSPNTEMP=$O(^DIPT("B",YSPNTEMP)) Q:$E(YSPNTEMP,1,4)'="YSPN"!(YSPNTEMP'="")  D
 .  F  S DA=$O(^DIPT("B",YSPNTEMP,DA)) Q:DA'>0  D
 .  .  I $D(^DIPT(+DA,0)) D ^DIK W "."
 QUIT
 ;
SETP ; Set Mental Health Parameters
 W !!,"Setting MH Parameters data..."
 S $P(^YSA(602,1,0),U,2)="5.01",$P(^(0),U,4)=0
 QUIT
 ;
PROGMSG ;
 W !!,"All post-init tasks have now been completed, except the conversion of DSM3"
 W !,"and DSM-III-R data to the new DSM file.  This will be done now..."
 H 4
 QUIT
 ;
DSMCONV ;  Calls CTRL^YSD4DSM to convert DSM data
 ;
 ;  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 ;  Note!!! Do NOT call this subroutine directly w/o setting YSD4OK
 ;          by calling DSMCK.
 ;  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 ;
 I 'YSD4OK D  QUIT  ;->
 .  W !!,"Discontinuing the post-init conversion of DSM data..."
 .  H 2
 ;
 ;  All OK.  Continue with DSM conversion...
 ;
 D CONVERT^YSD4DSM ;    Do the conversion!!!
 QUIT
 ;
OUT ;Return options to service on all DSM options
 W !!,"Returning Options to Service" H 2
 N DA,DIE,DR
 S (DA,YSOPTION)=""
 F YSOPTION="YSCENED","YSCENDIA","YSCENGED","YSCENMEDS","YSCENPP","YSCENTMHX","YSCENWL","YSDIAGE","YSDIAGP-DX","YSDIAGP-DXLS","YSPATPROF","YSPLDX" D
 .  S DA=+$O(^DIC(19,"B",YSOPTION,0)) QUIT:DA'>0
 .  I $P($G(^DIC(19,+DA,0)),U,3)="Out of Order - Installing Mental Health V. 5.01" D  QUIT
 .  .  S DIE=19,DR="2///@"
 .  .  D ^DIE
 QUIT
 ;
END ;
 K DA,DIK,DIR,Y
 K YSD40,YSD4CNT3,YSD4CNTR,YSD4CONT,YSD4NO,YSD4OK,YSNM,YSNO
 QUIT
 ;
EOR ;YSD4POST - Post-init for the Mental Health 5.01 ;4/11/94 11:40
