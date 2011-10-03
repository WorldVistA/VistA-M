XUTMR1 ;SEA/RDS - Taskman: Requeue Interface, Part Two ;06/06/95  14:59
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
 ;Continued From XUTMR
 ;
 S ZTPRI="" G:'ZTKEY REQ
PROG ;Programmer Parameters Edit:  Partition Size And Priority
 K DIR
 S DIR(0)="NO^1:10:0",DIR("A")="Task priority: ",DIR("?",1)="Please enter an integer between 1 (low) and 10 (high) to specify the task's",DIR("?")="priority.  (Optional)"
 S:$P(ZTREC,U,15)]"" DIR("B")=$P(ZTREC,U,15)
 D ^DIR K DIR I $L(Y) G NEXT:$D(DIRUT) S:Y>0 ZTPRI=Y
 ;
REQ ;Dequeue, Modify, And Requeue Task
 ;
 D DQ^%ZTLOAD
 S $P(ZTREC,U,3)=DUZ,$P(ZTREC,U,5)=$H,$P(ZTREC,U,6)=ZTDTH,$P(ZTREC,U,15)="",ZTREC2=ZTIO_"^^^^"_$P(ZTREC2,U,5)_"^"
 S:ZTCPU]"" $P(ZTREC,U,14)=ZTCPU I ZTKEY,ZTPRI]"" S $P(ZTREC,U,15)=ZTPRI
 S ^%ZTSK(ZTSK,0)=ZTREC
 K ^%ZTSK(ZTSK,.25),^(.21),^(.26) S:$D(ZTIO("H"))#2 $P(ZTREC2,U,6)=ZTIO("H"),^%ZTSK(ZTSK,.25)=ZTIO("P") S ^%ZTSK(ZTSK,.2)=ZTREC2
 K ZTRTN,ZTIO,ZTREC,ZTREC2,ZTREC25
 D REQ^%ZTLOAD
 W !!!,"Task requeued!" H 1
NEXT L -^%ZTSK(ZTSK)
 G LKUP^XUTMR
 ;
Q ;Cleanup And End Of Taskman Requeue Interface
 K %,%DT,%H,%T,%ZTD,%ZTDTH,%ZTI,%ZTIO,%ZTN,%ZTO,%ZTOS,%ZTU,XUTMUCI,%ZTYN,%ZTYND,X,Y,ZTCPU,ZTDTH,ZTIO,ZTKEY,ZTPAR,ZTPRI,ZTREC,ZTREC2,ZTSK
 D HOME^%ZIS Q
 ;
