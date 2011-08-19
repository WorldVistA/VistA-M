TIUPNCVU ;SLC/DAN - Final pass through ^GMR(121 for conversion ;4/22/98@14:08:17
 ;;1.0;TEXT INTEGRATION UTILITIES;**9**;Jun 20, 1997
EN ; Entry Point
 I +$$VERSION^XPDUTL("TIU")'>0 W !,"YOU MUST INSTALL TIU BEFORE RUNNING THIS OPTION!",$C(7) Q  ;Make sure TIU is installed first.
WHY F TIUWN=1:1 S TIULINE=$P($T(@("EXPLAIN+"_TIUWN)),";;",2) Q:TIULINE="STOP"  W !,TIULINE
 S TIURUN=$$READ^TIUU("Y","Are you sure you want to run this","NO")
 I '+TIURUN W !,"Ok, come back when you're sure." D CLEAN Q
 ;Agreed to run it, now check to see if PN conversion is currently running.
 I $P(^TIU(8925.97,1,0),U,3)="" W !!,"It appears as though the Progress Notes conversion is running.",!,"Please run this after the conversion finishes." D CLEAN Q
 W !! S TIUECS=$$ASKCOS I 'TIUECS D CLEAN Q
 ;
DEVICE ;Allows user to queue this option
 S %ZIS="Q" D ^%ZIS I POP D CLEAN Q
 I $D(IO("Q")) S ZTDESC="Final conversion pass",ZTRTN="DQ^TIUPNCVU",ZTIO=ION,ZTSAVE("TIUECS")="" D ^%ZTLOAD W !,"Request ",$S($D(ZTSK):"Queued",1:"Cancelled"),! D ^%ZISC,CLEAN,HOME^%ZIS Q
 ;
DQ ;Move through ^GMR(121 and convert any remaining notes
 W:$E(IOST,1,2)="C-" !,"Working..." S (TIUATC,TIUCVTED)=0
 S GMRIEN=0 F  S GMRIEN=$O(^GMR(121,GMRIEN)) Q:'+GMRIEN  D:'$D(^GMR(121,"CNV",GMRIEN)) CONVERT(GMRIEN) W:$E(IOST,1,2)="C-"&'(GMRIEN#1000) "." ;Convert if not already done.
 W !!,"CONVERSION IS COMPLETE!"
 W !!,"Total entries processed: ",$P(^GMR(121,0),"^",4),!,"Attempted to convert: ",TIUATC,!,"Converted: ",TIUCVTED
 ;
CLEAN ;KILL VARIABLES
 K TIUWN,TIULINE,TIURUN,TIUECS,%ZIS,POP,IO("Q"),ZTRTN,ZTDESC,ZTIO,ZTSAVE,GMRIEN,TIU,EMER,Y,TIUATC,TIUCVTED,DIR,ZTSK
 Q
 ;
CONVERT(Y) ;Sets needed variables and calls the convert individual note process
 N DPTIEN S EMER=1 S DPTIEN=$P(^GMR(121,Y,0),"^",2) I DPTIEN,$E($P(^DPT(DPTIEN,0),"^",9),1,4)'="0000" S TIUATC=TIUATC+1
 D EMERG^TIUPNCV4
 I $D(^GMR(121,"CNV",GMRIEN)) S TIUCVTED=TIUCVTED+1
 S:GMRIEN>$P(^TIU(8925.97,1,0),"^",5) $P(^TIU(8925.97,1,0),"^",5)=GMRIEN ;Update PN last entry processed
 Q
 ;
ASKCOS() ;Ask for cosigner to be used for notes that are signed but uncosigned and req cosignature
 W !,"For notes that are signed but are uncosigned, an expected",!,"cosigner must be identified before notes can be moved to TIU."
 W !!,"Please identify a user who will become the expected cosigner for",!,"these notes.  The clinical coordinator is recommended.",!
 W !,"Once these are moved to TIU the above named cosigner can edit the notes",!,"and put in the correct expected cosigner.",!
 N DIR,Y S DIR(0)="P^200:AEMQ",DIR("A")="Enter EXPECTED COSIGNER" D ^DIR
 Q +Y
 ;
EXPLAIN ;Explain what this option does
 ;;This option will process all remaining unconverted progress notes.
 ;;Notes that cannot be converted will be identified, along with the
 ;;the reason they could not be converted, as the process runs.
 ;;It is HIGHLY RECOMMENDED that you queue this option to a printer
 ;;so you can review the notes that did not convert.
 ;;
 ;;This option should be run after you have completed the final progress notes
 ;;conversion pass.  This will move all remaining notes (including
 ;;unsigned and uncosigned) to TIU.
 ;;
 ;;Notes that are reported as not converting, that you subsequently
 ;;fix, should be moved using the SINGLE PROGRES NOTES CONVERSION option.
 ;;
 ;;STOP
