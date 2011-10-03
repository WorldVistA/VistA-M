TIUPNCV7 ;SLC/DJP ;PNs ==> TIU cnv rtns ;5-7-97
 ;;1.0;TEXT INTEGRATION UTILITIES;**3**;Jun 20, 1997
 ;
HELP10 ;Help text for GMRP IEN prompt
 W !!?5,"Enter the Internal Entry Number (IEN)) of the last progress"
 W !?5,"note you want to convert.  By entering an IEN, you can run"
 W !?5,"this conversion while users continue to use the Progress Note"
 W !?5,"options."
 W !!?5,"To complete the conversion, use the RESTART option."
 Q
 ;
FIX ;Will back records out of ^TIU(8925
 ;TIU("HERE") must be set to the starting IEN 
 S DIK="^TIU(8925,",CTR=0
 S BK=TIU("HERE") F  S BK=$O(^TIU(8925,BK)) Q:'BK  D
 . Q:$P(^TIU(8925,BK,13),U,3)'="C"
 . S DA=BK D ^DIK S CTR=CTR+1
 W !!,"COMPLETED... "_CTR_" RECORDS DELETED."
 Q
 ;
PNHALT ;Options allows site to stop conversion
 W !!?12,"****** REQUEST TO HALT CONVERSION ******",!
 I '$P($G(^TIU(8925.97,1,0)),U,5)
 I  W !!?5,"The Progress Note Conversion is not currently running.",! Q
 I $P(^TIU(8925.97,1,2),U,3)>0
 I  W !!?5,"Progress Note Conversion has been stopped."
 I  W !?5,"Use the RESTART option to begin again.",! Q
 W !! K DIR S DIR(0)="Y"
 S DIR("A")="Do you want to HALT the Progress Note Conversion"
 S DIR("B")="NO",DIR("?")="^D HALTHELP^TIUPNCV7" D ^DIR K DIR
 I $D(DIRUT)!(Y=0) W !!?5,"Okay.  Conversion will continue to run.",! Q
 S $P(^TIU(8925.97,1,2),U,3)=1
 W !!?15,"!!!!!!!!  CONVERSION STOPPED !!!!!!!!",!
 S TIUPNLST=$P(^TIU(8925.97,1,0),U,5)
 W !?5,"Last Progress Note record processed is: ^GMR(121,"_TIUPNLST
 K TIUPNLST
 Q
 ;
HALTHELP ;Help Prompt for Halt action
 W !!?5,"Answering ""YES"" to this question will stop the Progress Note"
 W !?5,"Conversion before completion. ""NO"" will allow the conversion"
 W !?5,"to continue.",!
 Q
 ;
MONITOR ;Monitor progress notes conversion
 ;
 W !!?12,"****** MONITORING PROGRESS NOTE CONVERSION ******",!
 I $P($G(^TIU(8925.97,1,0)),U,3)>0 D  Q
 . W !?5,"This conversion has been run..."
 . W !?5,"This option is only for use during the running of the Progress"
 . W !?5,"Notes conversion from ^GMR(121 to ^TIU(8925."
 . H 5 Q
 ; 
AGAIN ;Redisplay monitor information
 N NODE,START,CURRENT,STIME,CNTR,ERRORS,TIME,ETIME,NTIME,BYE,PERMIN
 N PERHR,MIN,NUM,LEFT,ESECS
 D SETVAR
 D DISPLAY
 D RETURN Q:$D(BYE)
 W @IOF W !!?12,"****  MONITORING PROGRESS NOTE CONVERSION  ****",!
 G AGAIN
 Q
 ;
SETVAR ;Using File ^TIU(8925.97, to set and compute variables
 S NODE=^TIU(8925.97,1,0)
 S START=$P(NODE,U,4),CURRENT=$P(NODE,U,5),STIME=$P(NODE,U,2)
 S CNTR=$P(NODE,U,6),ERRORS=$P(NODE,U,7) S:ERRORS'>0 ERRORS=0
 S TIME=$$FMTE^XLFDT(STIME,"1P")
 S NTIME=$$NOW^XLFDT
 S ETIME=$$FMDIFF^XLFDT(NTIME,STIME,3)
 S ESECS=$$FMDIFF^XLFDT(NTIME,STIME,2)
 S MIN=ESECS/60
 S PERMIN=CNTR/+$S(MIN>0:MIN,1:1),PERHR=PERMIN*60
 S NUM=$P(^GMR(121,0),U,4)-$P(^TIU(8925,0),U,4)
 S LEFT=NUM/PERHR,DAYS=LEFT/24
 S REMAIN1=$P(^GMR(121,0),U,4)-CURRENT ;in file
 Q
 ;
DISPLAY ;Displays known information
 W !?5,"  Conversion began:  ",TIME
 W !?5,"   Starting record:  ",START
 W !?5," Processing record:  ",CURRENT
 W !?5," Records processed:  ",CNTR
 W !?5,"Current # of error:  ",ERRORS
 W !?5,"      Elapsed time:  ",ETIME
 W !?5,"    Notes per hour:  ",$P(PERHR,".")
 I LEFT>24 W !?5,"         Days left:  ",$E(DAYS,1,5)
 E  W !?5,"        Hours left:  ",$E(LEFT,1,5)
 W !!?2,"Notes left to convert:  ",REMAIN1
 W !!
 Q
 ; 
RETURN ;Issues RETURN prompt
 N DIR,Y
 F TIULN=1:1:(IOSL-$Y-4) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT) S BYE=1 Q
 Q
 ;
