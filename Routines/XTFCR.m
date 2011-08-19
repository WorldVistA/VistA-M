XTFCR ;SF-ISC.SEA/JLI - FLOW CHART GENERATOR FOR MUMPS ROUTINES ;9/21/93  09:53 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
 W !!,"FLOW CHART GENERATOR FOR MUMPS ROUTINES",!
 W !,"< COND >  = CONDITIONAL, if 'COND' is true code to the left is performed"
 W !!,"[ LINE^ROU ]   = DO or SUBROUTINE call to location LINE of routine ROU,",!,"                 control returns to commands following this in sequence"
 W !!,"{ LINE^ROU } = GO TO, control is transferred to the location LINE in",!,"               routine ROU.",!
ENTRY S XTLEV="A" K ^TMP($J),^UTILITY($J) X ^%ZOSF("RSEL") I '($D(^UTILITY($J))\10) G EXIT
 S %X="^UTILITY($J,",%Y="^TMP($J," D %XY^%RCR K ^UTILITY($J)
 S %ZIS="MQ" D ^%ZIS Q:POP  G:'$D(IO("Q")) DQ S ZTRTN="DQ^XTFCR" S %DT="FXTRAQE",%DT("A")="QUEUE to run WHEN:",%DT("B")="NOW" D ^%DT G:Y'>0 EXIT
 S X=+Y D H^%DTC S Y=Y_"0000",Y=%H_","_($E(Y,9,10)*60+$E(Y,11,12)*60) S ZTDTH=Y S ZTDESC="Flow Chart Routine",ZTSAVE("^TMP($J,")="",ZTSAVE("XTLEV")="",ZTIO=ION_";"_IOM_";"_IOSL
 D ^%ZTLOAD I $D(ZTSK) W !!,"TASK QUEUED",!
 G EXIT
 ;
DQ ; Entry point for tasked job
 S XTROU="@" F I=0:0 S XTROU=$O(^TMP($J,XTROU)) Q:XTROU=""  K ^(XTROU) S ^TMP($J,0,XTROU)=""
 S XT="",XTROU="@" F I=0:0 S XTROU=$O(^TMP($J,0,XTROU)) Q:XTROU=""  D ROU Q:XT=U
 D ^%ZISC K XTROU,XT
 G EXIT
 ;
ROU ;
 K ^TMP($J,XTLEV,"FC") W:IOST["C-" !,XTROU,! S XCNP=0,DIF="^TMP($J,0,"""_XTROU_""",",X=XTROU X ^%ZOSF("LOAD") K XCNP,DIF
 S XTIFLG=0,XTENTR=0,XTCOND=0 F I=0:0 S I=$O(^TMP($J,0,XTROU,I)) Q:I'>0  S X=^(I,0) D LINE^XTFC0
 U IO D ^XTFCR1 U 0
 K XTIFLG,XTENTR,XTCOND
 Q
 ;
EXIT ;
 K I,K,N,X,Y,Z,XTIJ,XTL1,XTL2,XTLEV,XTNAM,XTPCOND,XTTFLG,XTX1,XTX2,XTX2B,XTXCOND,XTZA,XTZX,XTZX1,^TMP($J),C
 Q
