SDAMOW ;ALB/CAW - Waiting Time Report ; 12/1/91
 ;;5.3;Scheduling;**12**;Aug 13, 1993
 ;
EN ; main entry point
 N DIC,SDBEG,SDEND,SDSEL,VAUTD,VAUTC,SDSORT,SDAMLIST
EN1 I '$$INIT G ENQ
 I '$$RANGE G ENQ
 I '$$SELECT G ENQ
 I '$$SORT G ENQ
EN2 I '$$DIV G ENQ
 I SDSORT=5 S (VAUTS,VAUTC)=1 G EN3
 I SDSORT=1!(SDSORT=2) G ENQ:'$$CLINIC
 I SDSORT=3!(SDSORT=4) G ENQ:'$$STOP
EN3 I '$$ASK G EN1
 W !!,$$LINE("Device Selection")
 W !!,"This output requires 132 columns.",!!
 S %ZIS="PMQ" D ^%ZIS I POP G ENQ
 I '$D(IO("Q")) D START^SDAMOW1 G ENQ
 S Y=$$QUE
ENQ D:'$D(ZTQUEUED) ^%ZISC
 K VAUTD,VAUTC,VAUTS Q
 ;
INIT() ; -- init vars
 Q 1
 ;
RANGE() ; select date range
 ;  input: none
 ; output: SDBEG := begin date
 ;         SDEND := end date
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("Date Range Selection")
 Q $$RANGE^SDAMQ(.SDBEG,.SDEND)
 ;
SELECT() ; -- get selection criteria
 ;  input: none
 ; output: SDSEL := criteria selected
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("Type of Report Criteria")
 S X="S^"
 S X=X_"1:Full Report;"
 S X=X_"2:Totals Only;"
 S DIR(0)=X,DIR("A")="Which Report",DIR("B")="Totals Only"
 D ^DIR K DIR S SDSEL=$S($D(DIRUT):0,1:+Y)
 Q SDSEL>0
 ;
SORT() ; -- how to sort
 ;  input: none
 ; output: SDSORT := sort selected
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("Sort Selection")
 W !!,"Note: Top level sort will always be by Division."
 S X="S^"
 S X=X_"1:Clinic, then by Patient;"
 S X=X_"2:Clinic, then by Appointment Date/Time;"
 S X=X_"3:Stop Code, then by Clinic;"
 S X=X_"4:Stop Code, then by Patient;"
 S X=X_"5:Patient then by Appointment Date/Time;"
 S DIR(0)=X,DIR("A")="Within Division Sort By",DIR("B")="Clinic, then by Patient"
 D ^DIR K DIR S SDSORT=$S($D(DIRUT):0,1:+Y)
 Q SDSORT>0
 ;
DIV() ; -- get division data
 ;  input: none
 ; output: VAUTD := divs selected (VAUTD=1 for all)
 ; return: was selection made [ 1|yes   0|no]
 ;
 W:$P($G(^DG(43,1,"GL")),U,2) !!,$$LINE("Division Selection")
 D ASK2^SDDIV I Y<0 K VAUTD
 Q $D(VAUTD)>0
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
STOP() ; -- get stop code data
 ; output: VAUTS := stop codes selected (VAUTS=1 for all)
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("Stop Codes Selection")
 S DIC="^DIC(40.7,",VAUTSTR="stop code",VAUTVB="VAUTS",VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 K VAUTS
STOPQ Q $D(VAUTS)>0
 ;
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
 S ZTDESC="Appointment Management Report",ZTRTN="START^SDAMOW1"
 F X="VAUTD(","VAUTC(","SDSORT","SDSEL","SDBEG","SDEND","VAUTD","VAUTC","VAUTS","VAUTS(" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
 ;
ASK() ; -- ask if ok to use specs
 ;    input: all selection variables
 ;   output: none
 ; return: ok to continue [ 1|yes   0|no]
 ;
 I '$$DISP^SDAMOW1 S Y=0 G ASKQ
 S DIR(0)="Y",DIR("A")="Continue",DIR("B")="Yes" D ^DIR K DIR
ASKQ Q $S($D(DIRUT):0,1:Y)
