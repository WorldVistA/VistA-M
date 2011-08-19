HLUOPT ;AISC/SAW-Main Menu for HL7 Module ;07/26/99  08:47
 ;;1.6;HEALTH LEVEL SEVEN;**57**;Oct 13, 1995
AP ;Enter/Edit DHCP Application Parameters
 F  D  Q:Y<0
 . N DA,DIC,DDSFILE,DR
 . S DIC="^HL(771,",DIC(0)="AEMQLZ"
 . W @IOF,! D ^DIC Q:Y<0
 . S DA=+Y,DDSFILE=DIC,DR="[HL7 APP]"
 . D ^DDS S Y=0
 Q
 ;
SP ;Enter/Edit Non-DHCP Application Parameters
 S DIC="^HL(770,",DIC(0)="AEMQL",DLAYGO=770 W ! D ^DIC K DLAYGO G EXIT:Y<0
 I $P(Y,"^",3) N HLX,HLX1 S HLX=+Y
 S DA=+Y,DIE=DIC,DR=".01;3;2;4//245;5//3;6;7//2.1;8;9//30;10;14;100" D ^DIE
 I $D(HLX) D
 .S HLX1=$G(^HL(770,HLX,0)) K DA,DD,DIE,DO,DR S DIC="^HL(771,",X=$P(HLX1,"^"),DIC(0)="" D FILE^DICN S DA=+Y
 .I DA S DIE="^HL(771,",DR="2///a;3///"_$P(HLX1,"^",3) D ^DIE K DIE,DR
 .S DIE="^HL(770,",DR="12///"_DA,DA=HLX D ^DIE
 G SP
APP ;Print/Display Application Parameters
 S DIC="^HL(771,",L=0,FLDS="[CAPTIONED]",BY="@.01",FR="?",TO="?",DHD="HL7 DHCP Application Parameters" D EN1^DIP D:$E(IOST,1,2)="C-" HOLD G EXIT
SPP ;Print/Display Site Parameters
 S DIC="^HL(770,",L=0,FLDS="[CAPTIONED]",BY="@.01",FR="?",TO="?",DHD="HL7 Non-DHCP Application Parameters" D EN1^DIP D:$E(IOST,1,2)="C-" HOLD G EXIT
MT ;Print/Display Message Type
 S DIC="^HL(771.2,",L=0,FLDS="[CAPTIONED]",BY="@.01",FR="",TO="",DHD="HL7 Message Types" D EN1^DIP D:$E(IOST,1,2)="C-" HOLD G EXIT
SN ;Print/Display Segment Name
 S DIC="^HL(771.3,",L=0,FLDS="[CAPTIONED]",BY="@.01",FR="",TO="",DHD="HL7 Segment Names" D EN1^DIP D:$E(IOST,1,2)="C-" HOLD G EXIT
DT ;Print/Display Data Type
 S DIC="^HL(771.4,",L=0,FLDS="[CAPTIONED]",BY="@.01",FR="",TO="",DHD="HL7 Data Types" D EN1^DIP D:$E(IOST,1,2)="C-" HOLD G EXIT
VERS ;Print/Display Version Number
 S DIC="^HL(771.5,",L=0,FLDS="[CAPTIONED]",BY="@.01",FR="",TO="",DHD="HL7 Version Numbers" D EN1^DIP D:$E(IOST,1,2)="C-" HOLD G EXIT
FIELD ;Print/Display Fields
 S DIC="^HL(771.1,",L=0,FLDS="[CAPTIONED]",BY="@.01",FR="?",TO="?",DHD="HL7 Fields" D EN1^DIP D:$E(IOST,1,2)="C-" HOLD G EXIT
PLPT ;Print/Display Log of Awaiting or Pending Tramsmissions
 S DIC="^HL(772,",L=0,FLDS="[CAPTIONED]",BY="@20,@.01",DIS(0)="S HLX=+$G(^HL(772,D0,""P"")) I HLX<3!(HLX>7)",FR="A,?",TO="Z,?",DHD="Log of HL7 Transmissions in Awaiting or Pending Status" D EN1^DIP D:$E(IOST,1,2)="C-" HOLD K HLX G EXIT
PLFT ;Print/Display Log of Failed Transmissions
 S DIC="^HL(772,",L=0,FLDS="[CAPTIONED]",BY="@20,@.01",FR="E,?",TO="EZ,?",DHD="Log of Failed HL7 Transmissions" D EN1^DIP D:$E(IOST,1,2)="C-" HOLD G EXIT
LOG ;Start/Stop HL7 Log of Transmissions
 W !!,"Select the Non-DHCP Application for which you wish to start/stop the HL7 log",!,"of transmissions."
 W ! S DIC="^HL(770,",DIC(0)="AEMQ" D ^DIC G EXIT:Y<0 S DA=+Y,HLDEV=$P(^HL(770,DA,0),"^",6) I HLDEV']"" W !!,*7,"You must define an HL7 Device for this Non-DHCP Application before you can",!,"start the log.",!
 I HLDEV]"" W !!,"The HL7 log is currently turned ",$S($D(^HL(770,"ALOG",HLDEV,DA)):"on.",1:"off."),!
 S DIE=DIC,DR=$S(HLDEV']"":"6R;",1:"")_50,DIE("NO^")="OUTOK" D ^DIE
 W ! S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Do you want to purge existing log entries" D ^DIR I Y=1,HLDEV]"" K ^TMP("HL",HLDEV)
EXIT K BY,DA,DHD,DIC,DIE,DIR,DR,FLDS,FR,L,HLDEV,TO,X,Y Q
 ;
LLED ;Logical Link Edit, file 870
 F  D  Q:Y<0
 . N DA,DIC,DDSFILE,DR
 . S DIC="^HLCS(870,",DIC(0)="AEMQLZ"
 . W @IOF,! D ^DIC Q:Y<0
 . S DA=+Y,DR="[HL7 LOGICAL LINK]",DDSFILE=DIC
 . D ^DDS S Y=0
 Q
 ;
INTED ;Interface edit, file 101
 F  D  Q:Y<0
 . N DA,DIC,DDSFILE,DR
 . S DIC="^ORD(101,",DIC(0)="AEMQLZ",DIC("S")="N Z S Z=$P(^(0),U,4) I Z=""E""!(Z=""S"")"
 . W @IOF,! D ^DIC Q:Y<0
 . S DA=+Y,DR="[HL7 INTERFACE]",DDSFILE=DIC
 . D ^DDS S Y=0
 Q
 ;
HOLD ;Hold Screen at End of Display
 N DIR
 S DIR(0)="E" D ^DIR
 Q
 
