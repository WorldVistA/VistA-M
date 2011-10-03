NVSMKPRN ;emc/maw-VistA and VMS device setup utilities main menu; 04/01/04
 ;;Added check for SYSTEM username (9/13/2004) (MBS)
 ;;6.0;EMC SYSTEM UTILITIES; Jan 01, 2002
 ;
 ; -- added to NVSMENU KIDs BUILD   jls          1/21/06  NOON
 ;
 I +$G(DUZ)'>0 D
 .S DUZ=.5
 .S DUZ(0)="@"
 .D DT^DICRW
 .D HOME^%ZIS
 ;
 I $P($ZF("GETJPI",$J,"USERNAME")," ")'="SYSTEM" D
 .W !!," *** WARNING - You are not logged-in using the OpenVMS SYSTEM account.   ***"
 .W !," *** It is recommended that this utility be run from the SYSTEM account. ***"
 .W !," *** You can select ""5"" from the menu below to quit, logout, and then    ***"
 .W !," *** login using the SYSTEM account.                                     ***"
 .W !!," You are currently logged-in using the "_$P($ZF("GETJPI",$J,"USERNAME")," ")_" account.",!
 .S DIR(0)="EA"
    .S DIR("A")="Press <enter> to continue..."
    .W ! D ^DIR K DIR
 ;
 F  D  Q:$D(DIRUT)
 .I $G(IOF)'="" W @IOF
 .W !!,$$CJ^XLFSTR(" ENTERPRISE MANAGEMENT CENTER :: VISTA AND VMS DEVICE UTILITIES ",80,"*")
 .W !,$$CJ^XLFSTR("Version 6.1C -- September 2004",80)
 .S DIR(0)="NAO^1:5"
 .S DIR("A")="Select OPTION: "
 .S DIR("A",1)=" [1] Enter/Edit VistA Device"
 .S DIR("A",2)=" [2] Create a Terminal Type for TCP use"
 .S DIR("A",3)=" [3] Reload VMS LAT table (^XTLATSET)"
 .S DIR("A",4)=" [4] Reload VMS Outbound Telnet table (^NVSTNSET)"
 .S DIR("A",5)=" [5] Quit"
 .S DIR("A",6)=" "
 .W ! D ^DIR K DIR
 .I Y=5 S DIRUT=1
 .I $D(DIRUT) Q
 .S NVSMOPT=Y
 .; enter/edit device...
 .I NVSMOPT=1 D  Q
 ..K NVSDEV
 ..D SELDEV
 ..I $G(NVSDEV("DA"))="" K NVSMOPT Q
 ..D GETDEV^NVSMKPU1(.NVSDEV)
 ..; LPD queue...
 ..I NVSDEV("VMSTYPE")="LPD" D ^NVSMKP1
 ..; telnet queue...
 ..I NVSDEV("VMSTYPE")="TNQ" D ^NVSMKP2
 ..; LAT device...
 ..I NVSDEV("VMSTYPE")="LAT" D ^NVSMKP3
 ..; Outbound telnet...
 ..I NVSDEV("VMSTYPE")="TNA" D ^NVSMKP4
 ..K NVSDEV,NVSMOPT
 .; create subtype...
 .I NVSMOPT=2 D  Q
 ..D ^NVSMKP5
 ..K NVSMOPT
 .; reload LAT...
 .I NVSMOPT=3 D  Q
 ..D ^XTLATSET
 ..K NVSMOPT
 .; reload outbound telnet...
 .I NVSMOPT=4 D
 ..S X="NVSTNSET"
 ..X ^%ZOSF("TEST")
 ..I $T=0 D  Q
 ...W !!,"The routine ^NVSTNSET is not present in this system."
 ...W !,"Aborted."
 ...K NVSMOPT
 ..D ^NVSTNSET
 ..K NVSMOPT
 ;
 K DIRUT,DTOUT,NVSDNS,NVSHOST,X,Y
 Q
 ;
SELDEV ; select add new or edit existing device...
 N DIR,DIRUT,NVSXDEV,X,Y
 S DIR(0)="SA^A:ADD;E:EDIT"
 S DIR("A")="Do you wish to [A]DD a new or [E]DIT an existing device? "
 S DIR("?")="Enter 'A' to add a new or 'E' to edit an existing device"
 W ! D ^DIR K DIR
 I $D(DIRUT) K DIRUT,DTOUT,X,Y Q
 S NVSXDEV=Y
 ; add new device...
 I NVSXDEV="A" D  I $D(DIRUT) K DIRUT,DTOUT,NVSXDEV,X,Y Q
 .S DIR(0)="FAO^1:30^"_$P($G(^DD(3.5,.01,0)),"^",5)
 .S DIR("A")="NEW DEVICE'S NAME: "
 .W ! D ^DIR K DIR
 .I $D(DIRUT) Q
 .S NVSDEV("DA")="NEW"
 .S NVSDEV("NAME")=Y
 .I $D(^%ZIS(1,"B",NVSDEV("NAME"))) D  Q
 ..W $C(7)
 ..W !,"A device by that name already exists.  See record number "
 ..W +$O(^%ZIS(1,"B",NVSDEV("NAME"),0))
 ..R X:2
 ..K NVSDEV
 ..S DIRUT=1
 .; get VMS type...
 .S NVSDEV("VMSTYPE")="?"
 .D VMSTYPE(.NVSDEV)
 .I NVSDEV("VMSTYPE")="?" K NVSDEV
 ; edit existing device...
 I NVSXDEV="E" D
 .K NVSDEV
 .S DIC=3.5
 .S DIC(0)="QEAMZ"
 .W ! D ^DIC K DIC
 .I +Y'>0 Q
 .S NVSDEV("DA")=+Y
 .S NVSDEV("$I")=$P(Y(0),"^",2)
 .S NVSDEV("NAME")=Y(0,0)
 .I NVSDEV("$I")["_LTA" S NVSDEV("VMSTYPE")="LAT"
 .I NVSDEV("$I")["_TNA" S NVSDEV("VMSTYPE")="TNA"
 .I NVSDEV("$I")["$:" D
 ..I $G(^%ZIS(1,NVSDEV("DA"),"VMS"))="" S NVSDEV("VMSTYPE")="?" Q
 ..I $P(^%ZIS(1,NVSDEV("DA"),"VMS"),"^",6)="" S NVSDEV("VMSTYPE")="LPD" Q
 ..S NVSDEV("VMSTYPE")="TNQ"
 .I $G(NVSDEV("VMSTYPE"))="" S NVSDEV("VMSTYPE")="?"
 .W !!,"This device's $I value is: ",NVSDEV("$I")
 .W !,"Based on this, it looks like this device's VMS device type is currently"
 .W !,$S(NVSDEV("VMSTYPE")="LAT":"a LAT device.",NVSDEV("VMSTYPE")="LPD":"an LPD queue.",NVSDEV("VMSTYPE")="TNQ":"a telnet queue.",NVSDEV("VMSTYPE")="TNA":"outbound telnet.",1:"unknown!")
 .W !!,"At this point, you can change the VistA device to another VMS"
 .W !,"device type, or simply edit the data for the existing VMS device"
 .W !,"type."
 .I NVSDEV("VMSTYPE")'="?" W "  Please change or verify VMS device type."
 .I NVSDEV("VMSTYPE")="?" D
 ..W !,"WARNING: I was unable to determine the device's current VMS"
 ..W !,"device type.  You MUST specify a type in order to continue."
 .D VMSTYPE(.NVSDEV)
 .I NVSDEV("VMSTYPE")="?" K NVSDEV
 K NVSXDEV
 Q
 ;
VMSTYPE(DEVDATA) ; select a VMS device type...
 ; DEVDATA = an array passed by reference containing device data
 ; returns DEVDATA("VMSTYPE")=a selected VMS device type or "" if none selected
 N DIR,DIRUT,DTOUT,X,Y
 S DIR(0)="NA^1:4"
 S DIR("A")="Select VMS DEVICE TYPE (1-4): "
 S DIR("A",1)=" 1 = LAT device"
 S DIR("A",2)=" 2 = LPD queue (LPD)"
 S DIR("A",3)=" 3 = Telnet queue (TNQ)"
 S DIR("A",4)=" 4 = Outbound telnet (TNA)"
 S DIR("A",5)=""
 I $G(DEVDATA("VMSTYPE"))'="?" S DIR("B")=$S(DEVDATA("VMSTYPE")="LAT":1,DEVDATA("VMSTYPE")="LPD":2,DEVDATA("VMSTYPE")="TNQ":3,1:4)
 S DIR("?")="Select (by number) what type of VMS device this new VistA device will be"
 W ! D ^DIR K DIR
 I $D(DIRUT) S DEVDATA("VMSTYPE")="?" Q
 S DEVDATA("VMSTYPE")=$S(Y=1:"LAT",Y=2:"LPD",Y=3:"TNQ",1:"TNA")
 Q
