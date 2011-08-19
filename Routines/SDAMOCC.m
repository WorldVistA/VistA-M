SDAMOCC ;IOFIO BAYPINES/TEH - AM Mgt Reports ; 12/1/91
 ;;5.3;Scheduling;**487**;Aug 13, 1993
 ;
EN ; main entry point
 N DIC,SDBEG,SDEND,SDSEL,VAUTD,VAUTC,SDSORT,SDAMLIST,Y,VAUTNI,VAUTSTR,VAUTVB,DIRUT
EN1 I '$$INIT G ENQ
 ;
ASKBDT ;
 W !!,$$LINE("Date Range Selection"),!
 S %DT="AEX",%DT("A")="Select Beginning Date: "
 D ^%DT S SDBEG=Y
 I X="^" Q
 I Y=-1 W !!,"Invalid Date!",! G ASKBDT
 K %DT,Y
ASKEDT ;
 S %DT="AEX",%DT("A")="Select Ending Date: "
 D ^%DT S SDEND=Y
 I X="^" Q
 I Y=-1 W !!,"Invalid Date!",! G ASKEDT
 I SDEND<SDBEG W !!,"Ending Date must be equal to or greater than Beginning Date." G ASKEDT
 K %DT,Y
 ;I '$$RANGE G ENQ
 S SDSEL=1
 S SDSEL=SDSEL+4 ; for backwards compatibility
 G STATS^SDAMOC
ENQ Q
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
 W !!,$$LINE("Statisitcs Criteria")
 S X="S^"
 S X=X_"1:Statistics;"
 S X=X_"2:Division(s) Only Statistics"
 S DIR(0)=X,DIR("A")="Which Visits",DIR("B")="Statistics"
 D ^DIR K DIR S SDSEL=$S($D(DIRUT):0,1:+Y)
 Q SDSEL>0
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
 ; output: VAUTC := stop codes selected (VAUTC=1 for all)
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("Stop Codes Selection")
 S DIC="^DIC(40.7,",VAUTSTR="stop code",VAUTVB="VAUTC",VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 K VAUTC
STOPQ Q $D(VAUTC)>0
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
