XUTMTEIO ;SEA/RDS - TaskMan: Toolkit, Edit I/O Device ; ;
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
ASK ;determine whether task should have an io device
 S DIR(0)="YO"
 S DIR("A")="Do you wish to requeue this task to a device"
 S DIR("B")=$S($P(ZTSK(2),U)="":"NO",1:"YES")
 S DIR("?")="^D HELP^XUTMTEIO"
 S DIR("??")="^D HELP2^ZTMEIO"
 D ^DIR
 I $D(DTOUT) W $C(7)
 I $D(DIRUT) Q
 I 'Y S ZTSK(2)="",ZTSK(25)="" Q
 S XUTMUCI="",ZTCPU="",ZTIO=""
 ;
EDIT ;edit task's io device
 S %ZIS="NZ"
 S %ZIS("A")="IO DEVICE: "
 S %ZIS("B")=$S($P(ZTSK(2),U)]"":$P(ZTSK(2),U),1:"")
 D ^%ZIS
 S ZTIO=$S($D(IOS)[0:"",POP:"",$D(ION)[0:"",ION]"":ION,IOS="":"",$D(^%ZIS(1,IOS,0))[0:"",1:$P(^(0),U))
 I ZTIO="" S DIRUT=1 Q
 I IOT="VTRM" D HOME^%ZIS W !,"Tasks can not open virtual terminals.",$C(7),! G EDIT
 S $P(ZTSK(2),U)=ZTIO_$S($D(IOST)[0:"",1:";"_IOST)_$S($D(IO("DOC"))[0:$S($D(IOM)[0:"",1:";"_IOM_$S($D(IOSL)[0:"",1:";"_IOSL)),1:";"_IO("DOC"))
 S $P(ZTSK(2),U,6)="",ZTSK(25)=""
 I $D(IO("HFSIO"))#2 S $P(ZTSK(2),U,6)=IO("HFSIO")
 I $D(IOPAR)#2 S ZTSK(25)=IOPAR
 I $D(IOCPU)#2 S ZTCPU=IOCPU
 I ZTCPU]"",$P(ZTSK(0),U,14)]"",ZTCPU'=$P(ZTSK(0),U,14) S X=$P(XUTMUCI,","),Y=$O(^%ZIS(14.6,"AT",X,$P(ZTSK(0),U,14),ZTCPU,"")) S:Y="" Y=X S XUTMUCI=Y_","_ZTCPU
 ;
HELP ;EDIT--?-help for first prompt
 W !!?5,"Answer must be YES or NO."
 Q
 ;
HELP2 ;EDIT--??-help for first prompt
 W !!?5,"Answer whether this task requires an io device."
 Q
 ;
