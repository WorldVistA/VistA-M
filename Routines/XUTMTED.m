XUTMTED ;SEA/RDS - TaskMan: Toolkit, Edit Description ; ;
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
EDIT ;Edit the description field of the task
 N DIR
 S DIR(0)="F^3:70^D XFORM^XUTMTED"
 S DIR("A")="DESCRIPTION"
 I $P(ZTSK(0),U,13)]"" S DIR("B")=$P(ZTSK(0),U,13)
 S DIR("?")="^D HELP^XUTMTED"
 D ^DIR K DIR
 I $D(DTOUT) W $C(7)
 I $D(DIRUT) Q
 S $P(ZTSK(0),U,13)=X
 Q
 ;
XFORM ;EDIT--Input transform for description
 I X=U Q
 N ZT
 F ZT=0:0 Q:X'[U  S X=$P(X,U)_"~"_$P(X,U,2,999)
 Q
 ;
HELP ;EDIT--? help for prompt
 W !!?5,"Answer must be free text from 3 to 70 characters in length."
 W !?5,"Answer with a description of the task."
 W !?5,"Answer should begin with the package of origin."
 Q
 ;
