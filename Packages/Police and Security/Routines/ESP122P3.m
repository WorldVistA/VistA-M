ESP122P3 ;ALB/JAP; POST-INSTALL FOR ES*1*22 cont.;3/98
 ;;1.0;POLICE & SECURITY;**22**;Mar 31, 1994
 ;
COMPLETE ;complete the conversion process
 N ESPC,ESPU,ESPUSER,DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y,POP,ZTRTN,ZTDESC,ZTSK,ZTREQ
 ;warn user
 W @IOF
 W !!?20,"Patch ES*1*22 Conversion Completion",!
 W !?5,"Continuing with this process will 'COMPLETE' the conversion process"
 W !?5,"for patch ES*1*22."
 W !
 W !?5,"This means that --"
 W !
 W !?5,"(1) The records in the ESP OFFENSE REPORT file (#912)"
 W !?5,"    will no longer be available for conversion."
 W !?5,"(2) The menu option Conversion Management for ESP*1*22"
 W !?5,"    [ESP CONVERISON FOR ES*1*22] will be placed out-of-order."
 W !?5,"(3) The Conversion Completion Report will be printed with your"
 W !?5,"    name as Completer."
 W !?5,"(4) A mail message will be sent to Police management (i.e.,"
 W !?5,"    through the ESP VACO 48 HR CRITERIA Mail Group) regarding"
 W !?5,"    this conversion completion."
 W !?5,"(5) A mail message will be sent to IRM staff (i.e., through"
 W !?5,"    the IRM and/or PATCHES Mail Group) which instructs IRM to"
 W !?5,"    delete the conversion routines from the system."
 W !
 ;ask if ready to complete
 S DIR(0)="YA",DIR("A")="Do you wish to proceed with Completion?: "
 D ^DIR K DIR W !!
 Q:($D(DIRUT))!($D(DIROUT))
 Q:(X="")!(Y="")!(Y=0)
 ;if user responded with 'yes', then complete
 S (ESPC,ESPU)=1,ESPUSER=DUZ
 S IOP="Q" D ^%ZIS
 I POP D
 .W !,"No device selected...exiting.",!
 Q:POP
 W !,"Proceeding with Completion...",!
 I $D(IO("Q")) D
 .S ZTRTN="FINISH^ESP122P3",ZTDESC="Patch ES*1*22 Conversion Completion",ZTREQ="@"
 .S ZTSAVE("ESPC")="",ZTSAVE("ESPU")="",ZTSAVE("ESPUSER")=""
 .D ^%ZTLOAD
 .I $G(ZTSK)>0 D  Q
 ..W !,"Request queued as Task #",ZTSK,".",!
 ..W !,"Patch ES*1*22 Conversion queued for Completion.",!
 ..K X,Y,DIR
 ..S DIR(0)="E" D ^DIR K DIR
 .I '$G(ZTSK) D
 ..W !,"Request to queue cancelled...exiting.",!
 ..W !,"Patch ES*1*22 Conversion will NOT be completed.",!
 ..S POP=1
 ..K X,Y,DIR
 ..S DIR(0)="E" D ^DIR K DIR
 D HOME^%ZIS
 Q
 ;
FINISH ;print report and finalize process
 N LN,OOO,X,Y,DIC,DIE,DA,DR,XMDUX,XMSUB,XMY,XMTEXT,XMDT,ESPDATE,ESPMSG
 U IO
 S $P(LN,"=",80)="",PAGE=0
 D NOW^%DTC S Y=$E(%,1,12),ESPDATE=$$FMTE^XLFDT(Y,"5")
 D HDR
 W !
 W !,"The Conversion process on the ESP OFFENSE REPORT file (#912)"
 W !,"for patch ES*1*22 has been completed."
 W !
 W !,"Completed by: "_$P($G(^VA(200,ESPUSER,0)),U,1)
 W !,"Completed on: "_ESPDATE
 W !
 W !,"The List of Converted Entries in File #912 and"
 W !,"the List of Unconverted Entries in File #912 reports follow.",!
 S RUNDT=ESPDATE D CONV^ESP122P1
 S RUNDT=ESPDATE D USER^ESP122P1
 I IO'=IO(0) D ^%ZISC
 ;put conversion option out-of-order
 S OOO="Completed by user# "_DUZ_" on "_X
 S DIC="^DIC(19,",X="ESP CONVERSION FOR ES*1*22" D ^DIC
 Q:Y=-1
 S DA=+Y
 S DIE="^DIC(19,",DR="2///^S X=OOO" D ^DIE
 ;send message to police staff
 S XMDUZ=ESPUSER,XMSUB="Conversion Completion for ES*1*22"
 S XMY(XMDUZ)="",XMY("G.ESP VACO 48 HR CRITERIA@"_^XMB("NETNAME"))="",XMTEXT="ESPMSG("
 S ESPMSG(1)="The Conversion process on the ESP OFFENSE REPORT file (#912)"
 S ESPMSG(2)="for patch ES*1*22 has been completed."
 S ESPMSG(3)=" "
 S ESPMSG(4)="Completed by: "_$P($G(^VA(200,XMDUZ,0)),U,1)
 S ESPMSG(5)="Completed on: "_ESPDATE
 S ESPMSG(6)=" "
 S ESPMSG(7)="No further conversion will be allowed on file #912"
 S ESPMSG(8)="using ES*1*22 routines."
 S ESPMSG(9)=" "
 S ESPMSG(10)="**IMPORTANT**"
 S ESPMSG(11)=" "
 S ESPMSG(12)="The Crime Statistics report for each month since October 1, 1997,"
 S ESPMSG(13)="**must** be regenerated.  Use the Generate Crime Statistics"
 S ESPMSG(14)="[ESP GENERATE CRIME STATISTICS] option to accomplish this."
 D ^XMD
 K ESPMSG,XMY
 ;send message to irm staff
 S XMDUZ=ESPUSER,XMSUB="Delete Routines for ES*1*22"
 S DIC="^XMB(3.8,",DIC(0)="",X="PATCHES" D ^DIC I +Y>0 S XMY("G.PATCHES@"_^XMB("NETNAME"))=""
 S DIC="^XMB(3.8,",DIC(0)="",X="IRM" D ^DIC I +Y>0 S XMY("G.IRM@"_^XMB("NETNAME"))=""
 S XMY(XMDUZ)="",XMTEXT="ESPMSG("
 S ESPMSG(1)="The Conversion process on the ESP OFFENSE REPORT file (#912)"
 S ESPMSG(2)="for patch ES*1*22 has been completed."
 S ESPMSG(3)=" "
 S ESPMSG(4)="Completed by: "_$P($G(^VA(200,XMDUZ,0)),U,1)
 S ESPMSG(5)="Completed on: "_ESPDATE
 S ESPMSG(6)=" "
 S ESPMSG(7)="The following routines may be deleted from your system:"
 S ESPMSG(8)="   ESP122PT"
 S ESPMSG(9)="   ESP122PR"
 S ESPMSG(10)="   ESP122PM"
 S ESPMSG(11)="   ESP122P1"
 S ESPMSG(12)="   ESP122P2"
 S ESPMSG(13)="   ESP122P3"
 D ^XMD
 Q
 ;
HDR ;report header
 W @IOF
 S PAGE=PAGE+1
 W !,"Patch ES*1*22 Conversion Completion Report ",?55,"Page: ",PAGE
 W !?52,"Printed: ",ESPDATE
 W !,LN
 Q
