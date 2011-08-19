XTSUMCK1 ;Boise/MAW,SFISC/RSD-process routine checksum job results ;10/04/96  12:37
 ;;8.0;KERNEL;**44**;Jul 10, 1995
 ;this routine is normally called via an ALERT process...
 W !!,"ROUTINE CHECKSUM REPORT"
 I '$D(^XTMP("XTSUMCK",DUZ,"SYS")) W *7,!!,"ERROR -- NO data to retrieve!" Q
 D EN^XUTMDEVQ("DQ^XTSUMCK1","Print Routine Checksum Results","")
 W !
 Q
DQ ;TaskMan and display/print entry point
 N DIR,DIRUT,XTX,XTUCI,XTROU,XTSYS,XTUL,XTPG,XTY,XTCNT,X,Y
 Q:'$D(^XTMP("XTSUMCK",DUZ))  S XTX=^(DUZ)
 S $P(XTUL,"-",IOM)="",XTPG=0,XTUCI=$P($P(XTX,U,2),",")
 I $E(IOST)="C" W @IOF
 D HDR
 W !?31,"JOB STARTED: ",$$FMTE^XLFDT($P(XTX,U,5))
 W !?33,"JOB ENDED: ",$$FMTE^XLFDT($P(XTX,U))
 S XTSYS="",DIR(0)="E"
 F  S XTSYS=$O(^XTMP("XTSUMCK",DUZ,"SYS",XTSYS)) Q:XTSYS=""  D  Q:$D(DIRUT)
 .Q:$$CHK(4)
 .W !!,"UCI,VOL: ",XTUCI,",",XTSYS," -- "
 .S XTY=^XTMP("XTSUMCK",DUZ,"SYS",XTSYS) W:$P(XTY,U) $$FMTE^XLFDT($P(XTY,U))
 .W " -- ",$P(XTY,U,3)
 .S XTROU=""
 .F XTCNT=0:1 S XTROU=$O(^XTMP("XTSUMCK",DUZ,"SYS",XTSYS,XTROU)) Q:XTROU=""  S Y=^(XTROU) D  Q:$D(DIRUT)
 ..Q:$$CHK(2)
 ..W !?2,XTROU,?12,Y
 .W !!,?15,+$P(XTY,U,6)," Routine checked, ",XTCNT," failed.",!
 K ^XTMP("XTSUMCK",DUZ)
 I $E(IOST)="P" W @IOF
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
CHK(Y) ;Y=excess lines, return 1 to exit & DIRUT is set
 Q:$Y<(IOSL-Y) 0
 I $E(IOST,1,2)="C-" D ^DIR Q:'Y 1
 W @IOF D HDR
 Q 0
 ;
HDR S XTPG=XTPG+1
 W !!,"MASTER ROUTINE SET USED RESIDES ON UCI,VOL: ",$P(XTX,U,2),?70,"PAGE ",XTPG,!,XTUL,!
 Q
