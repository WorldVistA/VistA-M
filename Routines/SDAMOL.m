SDAMOL ;ALB/CAW - Retroactive Appt. List; 4/15/92
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 ;
 ;
EN ; main entry point
 ;
 N DIC,SDBEG,SDEND,SDBD,SDED,SDSEL,VAUTD,VAUTC,VAUTS,SDNPDB
 I '$$INIT G ENQ
 I '$$NPDB G ENQ
 I '$$RANGE() G ENQ
 I '$$DIV() G ENQ
 I '$$SELECT() G ENQ
 I SDSEL=1,'$$STOP() G ENQ
 I SDSEL=2,'$$CLINIC() G ENQ
 W !! S %ZIS="PMQ" D ^%ZIS I POP G ENQ
 I '$D(IO("Q")) D MAIN^SDAMOL1 G ENQ
 S Y=$$QUE
ENQ D:'$D(ZTQUEUED) ^%ZISC
 K ^TMP("SDRL",$J),^TMP("SDRAL",$J)
 Q
 ;
INIT() ; -- init vars
 S SDDIV=0
 Q 1
 ;
RANGE() ; select date range
 ;  input: none
 ; output: SDBEG := begin date
 ;         SDEND := end date
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("Date Range Selection")
 N BEGDATE,ENDDATE
 S (SDBEG,SDEND)=0
 S SDT00="AEX" D DATE^SDUTL I $D(SDED) S SDBEG=SDBD,SDEND=SDED+.2359
 Q SDEND
DIV() ; -- get division data
 ;  input: none
 ; output: VAUTD := divs selected (VAUTD=1 for all)
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("Division Selection")
 D ASK2^SDDIV I Y<0 K VAUTD
 Q $D(VAUTD)>0
STOP() ; -- get stop code data
 ;  input: none
 ; output: VAUTS := stop codes selected (VAUTS=1 for all)
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("Stop Code Selection")
 S VAUTSTR="Stop Code",VAUTNI=2,VAUTVB="VAUTS"
 S DIC="^DIC(40.7,",DIC(0)="AEMQZ",DIC("S")="I $P(^(0),U,3)="""""
 D FIRST^VAUTOMA I Y<0 K VAUTS
 Q $D(VAUTS)>0
SELECT() ; -- get selection criteria
 ;  input: none
 ; output: SDSEL := criteria selected
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("Visit Selection Criteria")
 S DIR(0)="S^1:Stop Code(s);2:Clinic(s)"
 S DIR("A")="Find Visits By",DIR("B")="Stop Code(s)"
 D ^DIR K DIR S SDSEL=$S($D(DIRUT):0,1:+Y)
 Q SDSEL>0
 ;
CLINIC() ; -- get clinic data
 ;  input: VAUTD  := divisions selected
 ; output: VAUTC := clinic selected (VAUTC=1 for all)
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("Clinic Selection")
 D CLINIC^SDAMO0
 I Y<0 K VAUTC
CLINICQ Q $D(VAUTC)>0
 ;
NPDB() ; -- get which type of database check (credit or database)
 ;  input: none
 ; output: SDNPDB -- type of database check [WORLOAD | DATABASE]
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("NPDB Close-Out Check Selection")
 S DIR(0)="S^D:Database Update Only;W:Workload Credit"
 S DIR("A")="Type of Close-Out Check",DIR("B")="Workload Credit"
 D ^DIR K DIR
 ;
 ; -- set piece number related to CLOSEOUT^SCDXFU04 call or 0
 S SDNPDB=$S($D(DIRUT):0,Y="D":1,Y="W":2,1:0)
 Q SDNPDB>0
 ;
LINE(STR) ; -- print line
 ;  input: STR := text to insert
 ; output: none
 ; return: text to use
 ;
 N X
 S:STR]"" STR=" "_STR_" "
 S $P(X,"_",(IOM/2)-($L(STR)/2))=""
 Q X_STR_X
 ;
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Retroactive Appointment List",ZTRTN="MAIN^SDAMOL1"
 F X="VAUTD(","SDBEG","SDEND","VAUTD","VAUTC","VAUTC(","VAUTS","VAUTS(","SDSEL","SDBD","SDED","SDNPDB" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
 ;
