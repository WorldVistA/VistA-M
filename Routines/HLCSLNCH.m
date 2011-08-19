HLCSLNCH ;ALB/MTC/JC - START AND STOP THE LLP ;07/26/2007  17:10
 ;;1.6;HEALTH LEVEL SEVEN;**6,19,43,49,57,75,84,109,122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This program is callable from a menu
 ;It allows the user to Start and Stop the Lower Layer
 ;Protocol in the Background or in the foreground
 ;
 ;Required or Optional INPUT PARAMETERS
 ;             None
 ;
 ;
 ;Output variables
 ;             HLDP=IEN of Logical Link in file #870
 ;(optional)HLTRACE=if SET it launches the LLP in the Foreground
 ;(optional)   ZTSK=if defined LLP was launched in the
 ;background
 ;
 ;
START ; Start up the lower level protocol
 N DIC,DIRUT,DTOUT,DUOUT,HLDP,HLDAPP,HLJ,HLQUIT,HLTRACE
 N HLPARM0,HLPARM4,HLTYPTR,HLBGR,X,Y,ZTCPU,ZTSK,ZTRTN,ZTDESC
 W !!,"This option is used to launch the lower level protocol for the"
 W !,"appropriate device.  Please select the node with which you want"
 W !,"to communicate",!
 ; patch HL*1.6*122
 S POP=0
 S DIC="^HLCS(870,",DIC(0)="QEAMZ" D ^DIC G:Y<0 STARTQ
 S HLDP=+Y,HLDAPP=Y(0,0),HLTYPTR=+$P(Y(0),U,3),HLPARM0=Y(0)
 ;-- check if parameter have been setup
 ;-- check for LLP type
 I 'HLTYPTR W !!,$C(7),"A Lower Layer Protocol must be selected before start-up can occur." G STARTQ
 ;-- get TCP information
 S HLPARM4=$G(^HLCS(870,HLDP,400))
 ;-- get routine (background job for LLP)
 S HLBGR=$G(^HLCS(869.1,HLTYPTR,100))
 ;-- get environment check routine (HLQUIT should be defined in fails)
 S HLENV=$G(^HLCS(869.1,HLTYPTR,200))
 ;
 I HLBGR="" W !!,$C(7),"No routine has been specified for this LLP." G STARTQ
 ;
 ;-- execute environment check routine if HLQUIT is defined then terminate
 I HLENV'="" X HLENV G:$D(HLQUIT) STARTQ
 ; patch HL*1.6*122 start
 ; Multi-Servers: TCP service (GT.M, DSM, and Cache/VMS) is controlled
 ; by the external service
 I $P(HLPARM4,U,3)="M",$S(^%ZOSF("OS")'["OpenM":1,1:$$OS^%ZOSV["VMS") D  G STARTQ
 . W !,$C(7),"This LLP is a multi-threaded server. It is controlled by external service, i.e. TCPIP/UCX. You must use the external service to start this LLP."
 . Q
 ; patch HL*1.6*122 end
 ;
 I $P(HLPARM0,U,10) W !,$C(7),"The LLP was last started on ",$$DAT2^HLUTIL1($P(HLPARM0,U,10)),"." G STP1:$P(HLPARM0,U,5)'="Error"
 I $P(HLPARM0,U,11) W !,"The LLP was last shutdown on ",$$DAT2^HLUTIL1($P(HLPARM0,U,11)),"."
 ; patch HL*1.6*122 start
 ; comment out-should be taken care of by the code 2 line above
 ; I $P(HLPARM0,U,5)'="Error",'($P(HLPARM4,U,3)="C"&("N"[$P(HLPARM4,U,4))),$P(HLPARM0,U,10)]""&($P(HLPARM0,U,11)=""),$P(HLPARM0,U,12) W !,"The LLP appears to be online already !"
 ; I $$TASK^HLUTIL1($P(HLPARM0,U,12)) D  G STARTQ
 ; . W !,$C(7),"NOTE: The lower level protocol for this application is already running."
 N HLTEMP
 S HLTEMP=0
 I $P(HLPARM0,U,12) D  G:HLTEMP STARTQ
 . N ZTSK
 . S ZTSK=$P(HLPARM0,U,12)
 . D STAT^%ZTLOAD
 . I "12"[ZTSK(1) D
 .. W !,$C(7),"NOTE: The lower level protocol for this application is already running."
 .. I '$P(^HLCS(870,HLDP,0),"^",10) S $P(^HLCS(870,HLDP,0),"^",10)=$$NOW^XLFDT
 .. S HLTEMP=1
 ; patch HL*1.6*122 end
 I $P(HLPARM4,U,3)="C"&("N"[$P(HLPARM4,U,4)) D  G STARTQ
 .;4=status 9=Time Started, 10=Time Stopped, 11=Task Number
 .;14=Shutdown LLP, 3=Device Type, 18=Gross Errors
 .N HLJ,X
 . ; patch HL*1.6*122-comment out
 . ; I $P(HLPARM0,U,15)=0 W !,"This LLP is already enabled!" Q
 .L +^HLCS(870,HLDP,0):2
 .E  W !,$C(7),"Unable to enable this LLP !" Q
 .S X="HLJ(870,"""_HLDP_","")"
 .S @X@(4)="Enabled",@X@(9)=$$NOW^XLFDT,@X@(14)=0
 .D FILE^HLDIE("","HLJ","","START","HLCSLNCH") ;HL*1.6*109
 .L -^HLCS(870,HLDP,0)
 .W !,"This LLP has been enabled!"
 .Q
 I $P(HLPARM4,U,6),$D(^%ZIS(14.7,+$P(HLPARM4,U,6),0)) S ZTCPU=$P(^(0),U) W !,"This LLP will start on node ",ZTCPU," if it is run in the Background.",!
 ;
 ; patch HL*1.6*122 start, for tcp link
 I HLTYPTR=4 D  Q
 . S Y="B"
 . D STARTJOB
 ; patch HL*1.6*122 end
 ;
 W ! S DIR(0)="SM^F:FOREGROUND;B:BACKGROUND;Q:QUIT"
 S DIR("A")="Method for running the receiver"
 S DIR("B")="B"
 S DIR("?",1)="Enter F for Foreground (and trace)"
 S DIR("?",2)="      B for Background (normal) or"
 S DIR("?")="      Q to quit without starting the receiver"
 D ^DIR K DIR
 Q:(Y=U)!(Y="Q")
 ;
STARTJOB ;
 S HLX=$G(^HLCS(870,HLDP,0))
 ;-- foreground
 I Y="F" S HLTRACE=1 D  G STARTQ
 . S $P(^HLCS(870,HLDP,0),"^",10)=$$NOW^XLFDT
 . D MON^HLCSTCP("Start")
 . X HLBGR
 ;-- background
 I Y="B" D  G STARTQ
 . S ZTRTN=$P(HLBGR," ",2),HLTRACE="",ZTIO="",ZTDTH=$H
 . S ZTDESC=HLDAPP_" Low Level Protocol",ZTSAVE("HLDP")=""
 . D ^%ZTLOAD
 . ; patch HL*1.6*122 start
 . I $D(ZTSK) D
 .. K HLTRACE
 .. D MON^HLCSTCP("Tasked")
 .. S $P(^HLCS(870,HLDP,0),"^",10)=$$NOW^XLFDT
 . ; patch HL*1.6*122 end
 . W !,$S($D(ZTSK):"Job was queued as "_ZTSK_".",1:"Unable to queue job.")
 ;
 Q
 ;
STARTQ ;
 I $G(POP) W !,?5,"-Unable to Open the Device !",!,!,?6,"Check that Port is Logged Out, and that the",!,?6,"Lower Level Protocol is not Already Running."
 Q
 ;
STOP ; Shut down a lower level protocol..
 N DIC,DIRUT,DTOUT,DUOUT,HLDP,HLDAPP,HLJ,HLPARM0,HLPARM4,X,Y
 W !!,"This option is used to shut down the lower level protocol for the"
 W !,"appropriate device.  Please select the link which you would"
 W !,"like to shutdown.",!
 S DIC="^HLCS(870,",DIC(0)="QEAMZ" D ^DIC K DIC Q:Y<0
 S HLDP=+Y,HLDAPP=Y(0,0),HLPARM0=Y(0),HLPARM4=$G(^HLCS(870,HLDP,400))
 ; patch HL*1.6*122
 ; Multi-Servers: TCP service (GT.M, DSM, and Cache/VMS) is controlled
 ; by the external service
 I $P(HLPARM4,U,3)="M",$S(^%ZOSF("OS")'["OpenM":1,1:$$OS^%ZOSV["VMS") D  Q
 . W !,$C(7),"This LLP is a multi-threaded server. It is controlled by external service, i.e. TCPIP/UCX. You must use the external service to disable this LLP."
 . Q
 ;
 I $P(HLPARM0,U,15) W !,$C(7),"The lower level protocol is already ",$P(HLPARM0,U,5),"." Q
 I $P(HLPARM0,U,10) W !,$C(7),"The lower level protocol was started on ",$$DAT2^HLUTIL1($P(HLPARM0,U,10)),"."
STP1 ;
 W ! S DIR(0)="Y",DIR("A")="Okay to shut down this job" D ^DIR K DIR
 I 'Y!($D(DIRUT))!($D(DUOUT)) W !!,"The job will not be shut down." Q
S ;
 F  L +^HLCS(870,HLDP,0):2 Q:$T
 ;4=status,10=Time Stopped,9=Time Started,11=Task Number,3=Device Type,14=shutdown
 S X="HLJ(870,"""_HLDP_","")",@X@(4)="Halting",@X@(10)=$$NOW^XLFDT,(@X@(11),@X@(9))="@",@X@(14)=1
 I $P(HLPARM4,U,3)="C"&("N"[$P(HLPARM4,U,4)),'$P(HLPARM0,U,12) S @X@(4)="Shutdown"
 D FILE^HLDIE("","HLJ","","STOP","HLCSLNCH") ; HL*1.6*109
 ; patch HL*1.6*122 start
 ; I ^%ZOSF("OS")["OpenM",(($P(HLPARM4,U,3)="M"&($$OS^%ZOSV'["VMS"))!($P(HLPARM4,U,3)="S")) D
 ; I ^%ZOSF("OS")'["DSM",(($P(HLPARM4,U,3)="M"&($$OS^%ZOSV'["VMS"))!($P(HLPARM4,U,3)="S")) D
 I ($P(HLPARM4,U,3)="S")!(($P(HLPARM4,U,3)="M")&($S(^%ZOSF("OS")'["OpenM":0,1:$$OS^%ZOSV'["VMS"))) D
 . ;pass task number to stop listener
 . S:$P(HLPARM0,U,12) X=$$ASKSTOP^%ZTLOAD(+$P(HLPARM0,U,12))
 . ; D CALL^%ZISTCP($P(HLPARM4,U),$P(HLPARM4,U,2),10)
 . ; I POP D HOME^%ZIS U IO W !,"Unable to shutdown logical link!!!",$C(7),$C(7) Q
 . ; U IO W "**STOP**"
 . ; W !
 . ; D CLOSE^%ZISTCP
 . ; patch HL*1.6*122 end
 L -^HLCS(870,HLDP,0)
 W !,"The job for the "_HLDAPP_" Lower Level Protocol will be shut down."
 Q
 ;
STOPQ Q
