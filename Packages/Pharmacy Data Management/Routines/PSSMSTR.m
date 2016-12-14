PSSMSTR ;BIR/PWC-Send Master Drug File to External Interface ;04/05/04
 ;;1.0;PHARMACY DATA MANAGEMENT;**82,193**;09/30/97;Build 17
 ;Reference to ^PS(59 supported by IA # 1976
 ;
 ;This routine will loop through the Drug file and send all drugs
 ;to each dispensing machine for each outpatient site file.
 ;It will only send to each site that has a dispensing machine running
 ;HL7 V.2.4 and has the Master File Update enabled.
 ;As part of Pharmacy Interface Automation Project (PIA), this routine
 ;is modified to send all drugs to an active Pharmacy Automated Dispensing
 ;Equipment (PADE), located at the point of care areas such as 
 ;Inpatient wards, Outpatient Clinics etc.
 ;Task this job out
 ;
EN ; Begin processing PSS Master File All send drugs via HL7
 W @IOF N ZTSAVE,ZTRTN,ZTDESC,ZTIO,ZTDTH,X,Y
 D KV
 S DIR("A")="Send Drug file to which External Interface below?"
 S DIR(0)="SO^1:Outpatient Interface (OPAI);2:Inpatient Interface (PADE)"
 S DIR("?",1)="  Option 1 is for sending to the Outpatient Pharmacy Automation Interface."
 S DIR("?",2)="  Option 2 is for sending to the Pharmacy Automated Dispensing Equipment (PADE)"
 S DIR("?",3)="  located at the point of care."
 S DIR("?",4)="  OR Enter '^' to quit."
 S DIR("?",5)=""
 S DIR("?")="*Caution: This is usually done on the initial setup of the dispensing equipment."
 D ^DIR Q:'Y
 W !!,"You selected to send the Drug file to the "_Y(0),!
 I Y=1 D  Q
 . S ZTRTN="BUILD^PSSMSTR",ZTDESC="MASTER DRUG FILE UPDATE",ZTIO=""
 . S ZTDTH=$H D NOW^%DTC S PSSDTM=% D ^%ZTLOAD
 ;*193 - PADE
 N SPNAM,PROT S SPNAM="PSS MFNM01 SERVER"
 S PROT=$O(^ORD(101,"B",SPNAM,0))
 I '$$SNDHL7() W !!,"*Drug transmission is not setup for PADE",!! H 2 G EN
 I 'PROT W !!,"Drug Update Protocol "_SPNAM_" is NOT Installed",!! H 2 G EN
EN1 ;
 W !!,?5,"This only sends your Drug selections as NEW additions to PADE"
 W !?5,"If you need to send drug updates, then use the PSS DRUG/ENTER EDIT option"
 W !
 D KV
 S DIR("A")="Send all or selected drugs to the PADE system?"
 S DIR(0)="SO^1:Send all drugs marked for a package;2:Send selected drugs"
 S DIR("?",1)="  Option 1 is for sending all the active drugs by package"
 S DIR("?",2)="  Option 2 is for sending selected drugs only"
 S DIR("?",3)="  OR Enter '^' to quit."
 S DIR("?",4)=""
 S DIR("?")="*Caution: Option 1 is usually done on the initial setup of the dispensing equipment."
 D ^DIR G:'Y EN
 N PSSPADE S PSSPADE=1
 G:Y=2 SDRG
 I '$D(^XUSEC("PSS PADE INIT",DUZ)) D  G EN1
 .W $C(7),!!,?9,"**You need the PSS PADE INIT key."
 .W !,?11,"Please contact your Pharmacy Coordinator for access",! H 2
 N PSSCPK S PSSCPK=""
 I '$D(IOINORM)!('$D(IOINHI)) N IORVOFF,IORVON,IOINHI,IOINORM D
 .S X="IORVOFF;IORVON;IOINHI;IOINORM" D ENDR^%ZISS
 W !,"WARNING - With this option, you will be sending a large number of"
 W !,"drugs from your drug file to ""build"" a working database or drugs"
 W !,"on your PADE system. It is imperative to ",IORVON_IOINHI,"NOT",IOINORM_IORVOFF," RUN this option if you"
 W !,"already have a working formulary of drugs on your PADE system;"
 W !,"as resending may overwrite modifications to the fields that you"
 W !,"have made on your PADE system.",!!
 D KV ; CHECK FOR APPLICATION PACKAGE USAGE U,IV or Ward Stock
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to continue"
 S DIR("?")="Enter Y for Yes or N for No." D ^DIR K DIR
 G:'Y EN
 D KV W !
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to send drugs marked for UD package"
 S DIR("?")="Enter Y for Yes or N for No." D ^DIR K DIR
 G:$D(DIRUT) EN1
 S:Y PSSCPK="U"
 W !
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to send drugs marked for IV package"
 S DIR("?",1)="This option will look for 'I' in the application package field"
 S DIR("?",2)="of the drug file (#50) in determining if the drug is marked for"
 S DIR("?",3)="this package. The system will NOT check to see if there is an"
 S DIR("?",4)="additive or solution associated with the drug in determining if"
 S DIR("?",5)="it will be sent."
 S DIR("?",6)=""
 S DIR("?")="Enter Y for Yes or N for No." D ^DIR K DIR
 G:$D(DIRUT) EN1
 S:Y PSSCPK=$G(PSSCPK)_"I"
 W !
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to send drugs marked for Ward Stock package"
 S DIR("?",1)="This option will only look for 'W' in the application package field"
 S DIR("?",2)="of the drug file (#50) in determining if the drug is marked for"
 S DIR("?",3)="this package. It is possible for drugs to be used in the AR/WS"
 S DIR("?",4)="package but NOT marked with a 'W' in the application package field."
 S DIR("?",5)="Those drugs would not be sent with this option and must be added to"
 S DIR("?",6)="your PADE system manually."
 S DIR("?",7)=""
 S DIR("?")="Enter Y for Yes or N for No." D ^DIR K DIR
 G:$D(DIRUT) EN1
 G:PSSCPK=""&('Y) EN1
 S:Y PSSCPK=$G(PSSCPK)_"W"
EPD ;
 W !!,"Drug File Queued to be sent to PADE" H 2
 ;D PADE
 ;Q
 S ZTRTN="PADE^PSSMSTR",ZTDESC="MASTER DRUG FILE UPDATE TO PADE",ZTIO=""
 S ZTSAVE("PSSCPK")="",ZTSAVE("PSSPADE")="",ZTDTH=$H D NOW^%DTC S PSSDTM=% D ^%ZTLOAD
 Q
 ;
BUILD ;
 N XX,DVER,DMFU,DNSNAM,DNSPORT
 F XX=0:0 S XX=$O(^PSDRUG(XX)) Q:'XX  D
 . F YY=0:0 S YY=$O(^PS(59,YY)) Q:'YY  D
 .. S DVER=$$GET1^DIQ(59,YY_",",105,"I") Q:DVER'="2.4"  ;HL7 2.4
 .. S DMFU=$$GET1^DIQ(59,YY_",",105.2) Q:DMFU'="YES"    ;enable MFU
 .. S DNSNAM=$$GET1^DIQ(59,YY_",",2006)    ;DNS name of dispense machine
 .. S DNSPORT=$$GET1^DIQ(59,YY_",",2007)   ;Port # of dispense machine
 .. I DNSNAM'="" D DRG^PSSDGUPD(XX,"NEW",DNSNAM,DNSPORT)
 K XX,YY,DVER,DMFU,DNSNAM,DNSPORT
 Q
 ;
PADE ;
 N PSSG,PSSAP,PSSDRG,SPNAM,I S SPNAM="PSS MFNM01 SERVER"
 S PSSDRG=0,PSSAP=""
 F  S PSSDRG=$O(^PSDRUG(PSSDRG)) Q:'PSSDRG  D
 .Q:$G(^PSDRUG(PSSDRG,"I"))&($P($G(^("I")),"^")<DT)
 .S PSSAP=$P($G(^(2)),"^",3),PSSG=0 Q:PSSAP=""
 .F I=1:1:$L(PSSCPK) I PSSAP[$E(PSSCPK,I) S PSSG=1 Q
 .Q:'PSSG
 .D SPADE
 Q
 ;
SPADE ;
 N XX,VR,DNSNAM,DNSPORT,PSSD,PSSNM
 S XX=0 F  S XX=$O(^PS(58.7,XX)) Q:'XX  D
 .S PSSD=$G(^PS(58.7,XX,0))
 .Q:PSSD=""
 .S PSSNM=$P(PSSD,"^"),DNSNAM=$P(PSSD,"^",2),DNSPORT=$P(PSSD,"^",3)
 .Q:PSSNM=""!(DNSNAM="")!(DNSPORT="")  ;CHECK PADE, DNS NAME & PORT ARE DEFINED
 .S VR=$P(PSSD,"^",4) Q:VR&(VR<DT)  ;INACTIVE DATE CHECK
 .S VR=$P(PSSD,"^",5) Q:VR="X"!(VR="")  ;SEND DRUG UPDATE
 .D PROCESS1^PSSHLDFS(SPNAM,PSSDRG,"MAD",DNSNAM,DNSPORT)
 Q
SNDHL7() ; Check if at least one PADE vendor equipment is setup to accept 
 ; HL7 Drug messages.
 ;  Input  - None
 ;  Output - 1, send HL7 message
 ;           0, don't send message
 ;
 N XX,VR,FLG,SPNAM,DNSNAM,DNSPORT,PSSD,PSSNM
 S (FLG,XX)=0 F  S XX=$O(^PS(58.7,XX)) Q:'XX!(FLG)  D
 .S PSSD=$G(^PS(58.7,XX,0))
 .Q:PSSD=""
 .S PSSNM=$P(PSSD,"^"),DNSNAM=$P(PSSD,"^",2),DNSPORT=$P(PSSD,"^",3)
 .Q:PSSNM=""!(DNSNAM="")!(DNSPORT="")  ;CHECK PADE, DNS NAME & PORT ARE DEFINED
 .S VR=$P(PSSD,"^",4) Q:VR&(VR<DT)  ;INACTIVE DATE CHECK
 .S VR=$P(PSSD,"^",5) Q:VR="X"!(VR="")  ;SEND NONE
 .S FLG=$S(VR="U":1,VR="N":2,1:3)  ;SEND DRUG MESSAGES
 Q FLG
 ;
KV K DIR,DIRUT,DUOUT,DTOUT
 Q
 ;
SDRG ;
 W !!,?5,"You may select a single Drug or several Drugs",!!
 N PSSDRUG K DIC,DUOUT,DTOUT S DIC(0)="QEAM",DIC="^PSDRUG("
 S DIC("S")="I $S('$D(^PSDRUG(+Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)"
 F  D ^DIC Q:Y<0  D
 . S PSSDRUG(+Y)=""
 K DA,DIC
 I $G(DUOUT)!($G(DTOUT))!('$O(PSSDRUG(""))) G EN
 N PSSDRG,SPNAM S SPNAM="PSS MFNM01 SERVER"
 S PSSDRG=0
 F  S PSSDRG=$O(PSSDRUG(PSSDRG)) Q:'PSSDRG  D SPADE
 Q
 ;
