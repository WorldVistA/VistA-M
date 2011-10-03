HLERCHK ;SFCIOFO/JC - Interface Debugger ;02/25/2004  14:25
 ;;1.6;HEALTH LEVEL SEVEN;**57,96,108**;Oct 13, 1995
 ;This routine requires the following to work:
 ;EVENT DRIVER PROTOCOL TYPE
 ;It will report inconsistencies with the event driver, susbscribers,
 ;applications and logical links (if defined)
 W !,"This routine searches for HL7 protocols with possible errors."
 S DIR(0)="FAOU"
 S DIR("A")="Select an EVENT DRIVER Protocol: "
 S DIR("B")="All"
 S DIR("?")="^D DICQ^HLERCHK"
 D ^DIR
 K DIC,DA,DR I Y="All" S HLANS=0 G ASKDEV
 S X=Y S DIC="^ORD(101,",DIC(0)="EMQZ"
 S DIC("S")="I $P(^(0),U,4)=""E"""
 D ^DIC
 Q:$D(DTOUT)!($D(DUOUT))
 Q:+Y=-1
 S HLANS=+Y
ASKDEV ;
 S %ZIS="MQ"
 D ^%ZIS
 G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 .S ZTDESC="HL7 Interface Debugger",ZTRTN="EN^HLERCHK",ZTSAVE("*")=""
 .S ZTDTH=$H D ^%ZTLOAD
 .D HOME^%ZIS
 .W !,$S($D(ZTSK):"Queued to task number: "_ZTSK,1:"NOT QUEUED")
EN ;
 U IO
 I $D(ZTQUEUED) S ZTREQ="@"
 W !,"             ** HL7 INTERFACE DEBUGGER **"
 S HL57=0 I $D(^ORD(101,"AHL21")) S HL57=1
 ;patch HL*1.6*96 start: add application ack for HL7 v2.4, and others.
 S HLACK="ACK,ADR,ARD,EDR,ERP,MCF,MFK,MFR,ORF,ORG,ORR,OSR,RAR,RCI,RCL,"
 S HLACK=HLACK_"RDR,RDY,RER,RGR,ROR,RRA,RRD,RRE,RRG,RRI,RSP,RTB,SQR,"
 S HLACK=HLACK_"TBR,VXR,VXX"
 ;patch HL*1.6*96 end
 ;patch HL*1.6*108 start: add application ack for HL7 v2.5.
 S HLACK=HLACK_",BRP,BRT,ORB,ORI"
 ;patch HL*1.6*108 end
 I 'HLANS S HLPIEN=0 F  S HLPIEN=$O(^ORD(101,HLPIEN)) Q:HLPIEN<1  D
 .Q:$P(^ORD(101,HLPIEN,0),U,4)'="E"
 .D CHKED(HLPIEN)
 I +HLANS D CHKED(+HLANS)
 D EXIT
 Q
DICQ ;
 N X,Y,DIC
 S X="??"
 S DIC="^ORD(101,",DIC(0)="EQ"
 S DIC("S")="I $P(^(0),U,4)=""E"""
 D ^DIC
 Q
CHKED(PP) ;Check Event Driver Protocols
 K ERR,HLPN,HL770,HLVSP,HLVSN,HLSAPP,HLSAPN,HLMTPP,HLMTPN,HLETPP,HLETPN S ERR=0
 S HLPN=$P($G(^ORD(101,PP,0)),U)
 I HLPN="" S ERR=ERR+1,ERR(ERR)="Protocol is UNDEFINED." Q
 I $P(^ORD(101,PP,0),U,3)]"" S ERR=ERR+1,ERR(ERR)="**PROTOCOL DISABLED**" Q
 S HL770=$G(^ORD(101,PP,770))
 I HL770="" S ERR=ERR+1,ERR(ERR)="Missing data for all key fields." Q
VSN ;Version
 S HLVSP=$P(HL770,U,10)
 I HLVSP<1 S ERR=ERR+1,ERR(ERR)="Version ID is required."
 S HLVSN="" I HLVSP S HLVSN=$P($G(^HL(771.5,HLVSP,0)),U)
APP ;Sending App
 S HLSAPP=$P(HL770,U),HLSAPN=""
 I 'HLSAPP S ERR=ERR+1,ERR(ERR)="Missing Required Sending Application."
 I HLSAPP S HLSAPN=$P($G(^HL(771,HLSAPP,0)),U)
 I HLSAPP,HLSAPN="" S ERR=ERR+1,ERR(ERR)="Broken pointer to App Param (file 771)."
 I HLSAPP D CHKAPP(HLSAPP)
MT ;Message Type
 S HLMTPP=$P(HL770,U,3),HLMTPN=""
 I 'HLMTPP S ERR=ERR+1,ERR(ERR)="Missing required Message Type."
 I HLMTPP S HLMTPN=$P($G(^HL(771.2,HLMTPP,0)),U)
 I HLMTPP,HLMTPN="" S ERR=ERR+1,ERR(ERR)="Broken pointer to Msg Type (file 771.2)."
 I HLMTPN]"",HLACK[HLMTPN S ERR=ERR+1,ERR(ERR)="For Event Driver-Message Type cannot be an acknowledgement."
ET ;Event Type
 S HLETPP=$P(HL770,U,4),HLETPN=""
 S HLETPN="" I HLETPP S HLETPN=$P($G(^HL(779.001,HLETPP,0)),U)
 I HLETPN="" S ERR=ERR+1,ERR(ERR)="Broken pointer to Event Type (file 779.001)."
 I 'HLETPP,$G(HLVSN)>2.1 S ERR=ERR+1,ERR(ERR)="Event type is required for versions greater than 2.1."
OUT1 S $P(LINE,"_",75)=""
 W !,LINE
 W !,"Event Driver: ",HLPN
 W !!,"Sending Application: ",HLSAPN
 W !,"Version: ",$G(HLVSN),"   ","Message Type(770.3): ",$G(HLMTPN),"   ","Event Type: ",$G(HLETPN)
 W !!,"Event Driver Error Summary:",!
 I $G(ERR)<1 W !,"No Event Driver Errors Found."
 I $G(ERR) S N=0 F  S N=$O(ERR(N)) Q:N<1  W !,N,". ",ERR(N)
SUB ;Check Subscribers
 S HL770=$G(^ORD(101,PP,770))
 I HL770="" S ERR=ERR+1,ERR(ERR)="Missing data for all key fields." Q
 S HLNODE="^ORD(101,PP,10)"
 I HL57 S HLNODE="^ORD(101,PP,775)"
 I '$D(@HLNODE) W !,"No Subscribers Found."
 S HLX=0 F  S HLX=$O(@HLNODE@(HLX)) Q:HLX<1  S HLSUBP=$P(@HLNODE@(HLX,0),U) D CHKSUB(HLSUBP)
 Q
CHKSUB(PP) ;Scan Subscribers
 K ERR,HLPN,HL770,HLVSP,HLVSN,HLRAPP,HLRAPN,HLMTPP,HLMTPN,HLETPP,HLETPN S ERR=0
 S HLPN=$P($G(^ORD(101,PP,0)),U)
 I HLPN="" S ERR=ERR+1,ERR(ERR)="Subscriber Protocol is UNDEFINED." Q
 I $P(^ORD(101,PP,0),U,3)]"" S ERR=ERR+1,ERR(ERR)="**SUBSCRIBER PROTOCOL DISABLED**" Q
 S HL770=$G(^ORD(101,PP,770))
 I HL770="" S ERR=ERR+1,ERR(ERR)="Missing data for all key fields." Q
 S HLRAPP=$P(HL770,U,2),HLRAPN=""
 I 'HLRAPP S ERR=ERR+1,ERR(ERR)="Missing Required Receiving Application."
 I HLRAPP S HLRAPN=$P($G(^HL(771,HLRAPP,0)),U)
 I HLRAPP,HLRAPN="" S ERR=ERR+1,ERR(ERR)="Broken pointer to App Param (file 771)."
 I HLRAPP D CHKAPP(HLRAPP)
 S HLMTPN="",HLMTPP=$P(HL770,U,11) I HLMTPP D  ;Response Message Type
 .I HLMTPP S HLMTPN=$P($G(^HL(771.2,HLMTPP,0)),U)
 .I HLMTPP,HLMTPN="" S ERR=ERR+1,ERR(ERR)="Broken pointer to Msg Type (file 771.2)."
 .I HLMTPN]"",HLACK'[HLMTPN S ERR=ERR+1,ERR(ERR)="Message Type must be an appropriate response/acknowledgement."
 S HLETPP=$P(HL770,U,4),HLETPN=""
 I HLETPP S HLETPN=$P($G(^HL(779.001,HLETPP,0)),U)
 I HLETPP,HLETPN="" S ERR=ERR+1,ERR(ERR)="Broken pointer to Event Type (file 779.001)."
 I $G(^ORD(101,PP,774))=""&($G(^ORD(101,PP,771)))="" S ERR=ERR+1,ERR(ERR)="Missing Processing Routine and Routing Logic."
 I $G(^ORD(101,PP,774))=""&($P(HL770,U,7))="" S ERR=ERR+1,ERR(ERR)="WARNING-Missing both Logical Link and Routing Logic. Will be local only."
OUT2 ;Print Subscriber Errors
 S $P(STAR,"*",40)=""
 W !,?10,STAR
 W !,?10,"For Subscriber: ",$G(HLPN)
 W !!,?10,"Receiving Application: ",$G(HLRAPN)
 W !,?10,"Message Type (770.11): ",$G(HLMTPN),"   ","Event Type: ",$G(HLETPN),!
 I 'ERR W !,?10,"No Subscriber Errors Found."
 F ERR=1:1:ERR W !,?10,ERR,". ",ERR(ERR)
 Q
CHKAPP(APP)     ;Check Application parameters
 Q:'$D(^HL(771,APP))
 I $P(^HL(771,APP,0),U,2)="I" S ERR=ERR+1,ERR(ERR)="Application is INACTIVE."
 Q
EXIT    ;
 K ZTSK,HL57,HL770,HLACK,HLETPN,HLETPP,HLMTPN,HLMTPP,HLNODE,HLPIEN,HLPN,HLRAPP,HLSAPN,HLSAPP,HLSUBP,HLVSN,HLVSP,HLX,LINE,STAR,SAPP,ERR
 Q
