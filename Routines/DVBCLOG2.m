DVBCLOG2 ;ALB/GTS-LOG A 2507 REQUEST CONT; 11/17/94  1:30 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
CLINSF ;** Reset 2507 when priority changed from Insufficient
 S DA=REQDA,DIE="^DVB(396.3,",DR="44///@;45///@"
 D ^DIE
 K DA,DIE,DR,Y
 Q
 ;
INSUF ;** Enter Insuffient 2507 info
 W @IOF
 S DVBADFN=$P(^DVB(396.3,REQDA,0),"^",1),DVBADA="",DVBASTAT="C"
 D REQARY^DVBCUTL5 ;**Set up ^TMP of 2507's
 I $D(^TMP("DVBC",$J)) DO REQSEL^DVBCUTL5 S DVBASEL=+Y ;** Select 2507
 I '$D(^TMP("DVBC",$J)) S DVBASEL=0
 I +DVBASEL>0 DO  ;** Update ORIGINAL 2507 REQUEST
 .S DVBAORD=""
 .D FINDDA^DVBCUTL5 ;** Loop through ^TMP and get selected DA
 .K DA,DIE,DR,Y
 .S DA=REQDA,DIE="^DVB(396.3,",DR="44////"_DVBADA D ^DIE
 K DA,DIE,DR,Y,DIR,X,^TMP("DVBC",$J),DVBAORD,DVBAMORE,DVBACNT,DVBALP
 K DVBAPNAM,DVBASEL,DVBAOUT,DVBADA,DVBADFN,DVBADT,DVBADTOT
 ;
 ;** If 2507 not linked to completed 2507 and not time or '^' out
 ;**  when selecting 2507, enter 2507 PROCESSING TIME
 ;**   NOTE: I '$D(DVBAOUT) removed 2/3/95 because killed above
 I $D(^DVB(396.3,REQDA,5)),(+$P(^DVB(396.3,REQDA,5),U,1)'>0) DO
 .K DTOUT,DUOUT,Y
 .S DA=REQDA,DIE="^DVB(396.3,"
 .S DR="45"
 .D ^DIE
 .S:$D(DTOUT) DVBADTOT=""
 .I $D(DTOUT)!($D(Y)) S DVBAOUT=""
 I '$D(^DVB(396.3,REQDA,5)) DO
 .K DTOUT,DUOUT,Y
 .S DA=REQDA,DIE="^DVB(396.3,"
 .S DR="45"
 .D ^DIE
 .S:$D(DTOUT) DVBADTOT=""
 .I $D(DTOUT)!($D(Y)) S DVBAOUT=""
 K DIE,DR,DA
 S DA=REQDA
 ;
 ;**If 2507 not linked and 2507 Processing Time not entered
 I '$D(DVBADTOT) DO
 .I $D(^DVB(396.3,REQDA,5)),((+$P(^DVB(396.3,REQDA,5),U,1)'>0)&($P(^DVB(396.3,REQDA,5),U,2)="")) D PASS1
 .I '$D(^DVB(396.3,REQDA,5)) D PASS1
 K DVBADTOT
 Q
 ;
PASS1 ;** Insufficient 2507 selection error on edit of newly created 2507
 S TVAR(1,0)="0,0,0,1,0^You must either select a request to link or enter the 2507 Processing Time."
 S TVAR(2,0)="0,0,0,1,0^Enter 0 if you don't know the processing time of the original request."
 D WR^DVBAUTL4("TVAR")
 K TVAR
 S DVBAOUT=""
 Q
