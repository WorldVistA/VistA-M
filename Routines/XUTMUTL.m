XUTMUTL ;SFISC/RWF - TaskMan: Utility ;3/4/96  12:55
 ;;8.0;KERNEL;**20**;Jul 10, 1995
 Q
ENV ;Establish Routine Environment
 K DIRUT,DTOUT,DUOUT ;Clean-up for so we can use them too.
 Q:$D(ZTENV)&$D(ZTKEY)
 I $S($D(DUZ)[0:1,DUZ="":1,1:0) W !?5,"I do not know who you are (your DUZ variable is ",$S($D(DUZ)[0:"undefined).",1:"null).") Q
 I $D(^VA(200,DUZ,0))[0 W !?5,"User # ",DUZ," is not defined in this uci.  I'm not sure who you are." Q
 S ZTKEY=$D(^XUSEC("ZTMQ",DUZ)),ZTNAME=$P(^VA(200,DUZ,0),U) X ^%ZOSF("UCI") S XUTMUCI=Y
 S ZTENV=1 ;Use as a flag to show OK.
 I '$D(ZTQUEUED) D HOME^%ZIS W @IOF
 Q
 ;
LOAD(XUTSK,XUR) ;Load Task data
        S @XUR@(0)=$G(^%ZTSK(XUTSK,0)),@XUR@(.03)=$G(^(.03)),@XUR@(.1)=$G(^(.1)),@XUR@(.2)=$G(^(.2)),@XUR@(.25)=$G(^(.25))
 Q
XQA ;Call from the Alert system
 Q:XQADATA'>0
 N ZTKEY,ZTNAME,XUTMUCI,ZTENV,DIR,DIRUT,Y
 D ENV,EN^XUTMTP(XQADATA)
 S DIR(0)="E" D ^DIR
 Q
 ;
OPTSCH(OPTION,WHEN,DEVICE,FREQ) ;Schedule an Option.
 N DIE,DR,DA ;,XUTMDA
 D FIND^DIC(19.2,,,"X",OPTION,5,,,,"XUTMDA","XUTMMSG")
 Q
