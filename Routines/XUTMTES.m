XUTMTES ;SEA/RDS - TaskMan: Toolkit, Edit Start Time ; ;
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
EDIT ;Edit start time of task
 N DIR
 S DIR(0)="DO^::AERSX"
 S DIR("A")="START TIME"
 I $P(ZTSK(0),U,6)]"" S DIR("B")=$$HTE^XLFDT($P(ZTSK(0),U,6))
 S DIR("?")="^D HELP^XUTMTES"
 S DIR("??")="^D HELP2^XUTMTES"
 D ^DIR K DIR
 I $D(DTOUT) W $C(7)
 I $D(DIRUT) Q
 S $P(ZTSK(0),U,6)=$$FMTH^XLFDT(Y)
 Q
 ;
HELP ;?-help for start time prompt
 W !!?5,"Answer must be a valid date and time."
 Q
 ;
HELP2 ;??-help for start time prompt
 W !!?5,"Answer when the task should start running.",!
 D HELP^%DTC
 Q
 ;
