PRCUCV1 ;WISC@ALTOONA/CTB-CONVERSION OF ALL IFCAP SIGNATURE CODES ; 06/07/93  12:00 PM
V ;;5.0;IFCAP;;4/21/95
 N COUNT,RANGE,DIR,OPTION,TYPE
 S X="    This conversion will convert ALL signature codes in all IFCAP files to be converted to a new format."
 D MSG^PRCFQ
 ;build list of conversions
 ;421.5
 S COUNT=0
 S X(20)=$P(^PRSN(20,0),"^",4),COUNT=COUNT+X(20)
 S X(421.5)=$P(^PRCF(421.5,0),"^",4),COUNT=COUNT+X(421.5)
 S X(421.2)=$P(^PRCF(421.2,0),"^",4),COUNT=COUNT+X(421.2)
 S X(421)=$P(^PRCF(421,0),"^",4),COUNT=COUNT+X(421)
 S X(443)=$P(^PRC(443,0),"^",4),COUNT=COUNT+X(443)
 S X(423)=$P(^PRCF(423,0),"^",4),COUNT=COUNT+X(423)
 ;S X(443.6)=$P(^PRC(443.6,0),"^",4),COUNT=COUNT+X(443.6)
 S X(442)=$P(^PRC(442,0),"^",4)*12,COUNT=COUNT+X(442)
 S X(442.9)=$P(^PRC(442.9,0),"^",4),COUNT=COUNT+X(442.9)
 S X(410)=$P(^PRCS(410,0),"^",4)*5,COUNT=COUNT+X(410)
 S X=0 F  S X=$O(X(X)) Q:'X  W !,"FILE: ",X,"  -  ",?16 S Y=$FN(X(X),","),Y="            "_Y,Y=$E(Y,$L(Y)-11,$L(Y)) W Y," Records - estimated"
 W !,?16 S Y=$FN(COUNT,","),Y="            "_Y,Y=$E(Y,$L(Y)-11,$L(Y)) W Y,"  Estimated individual conversions."
 D ENCON^PRCFQ W !!
A ;S DIR(0)="SA^1:All at once;2:Do not convert at this time",DIR("?")="^D SETOFCDS^PRCUCV2",DIR("A")="Enter Type Requested: " D ^DIR
 ;I $G(DIRUT)_$G(DUOUT)_$G(DTOUT)_$G(DIROUT) K DIRUT,DUOUT,DTOUT,DIROUT S X="  <No further action taken>" D MSG^PRCFQ QUIT
 S Y=1
 S TYPE=+Y
 ;S %A="ARE YOU SURE",%=2,%B="" D ^PRCFYN G A:%=2 I %<0 S X="  <No further action taken>" D MSG^PRCFQ QUIT
 ;I TYPE=2 G ^PRCUX0
 I TYPE=1 S %ZIS="Q" D ^%ZIS I POP QUIT
 I $G(IO("Q"))=1 D  QUIT
 . S ZTDESC="IFCAP CONVERSION",ZTRTN="^PRCUCV3" D ^%ZTLOAD
 . W !,"IFCAP CONVERSION IS SUBMITTED TO THE TASK MANAGE WITH TASK NUMBER ",ZTSK
 . QUIT
 D ^PRCUCV3
 QUIT
 S X="To meet the criterion outlined by the VA Inspector General, you must run this conversion in the near future."
 W !! D MSG^PRCFQ
 S X="Failure to run at this time will NOT affect the operation of IFCAP in any way." W ! D MSG^PRCFQ
