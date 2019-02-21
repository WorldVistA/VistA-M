PSOERXEN ;ALB/BWF - eRx Utilities/RPC's ; 6/1/2018 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**508**;DEC 1997;Build 295
 ;
 Q
EN ;
 N PSNPINST,DIR,Y,CODE
 I '$$CHKKEY^PSOERX(DUZ) D  Q
 .W !,"You do not have the appropriate key to access this option." S DIR(0)="E" D ^DIR K DIR
 D:'$D(PSOPAR) ^PSOLSET I '$D(PSOPAR) D MSG^PSODPT D EX^PSOERX Q
 D:'$D(PSOPINST) INST^PSOORFI2 I $G(PSOIQUIT) K PSOIQUIT D EX^PSOERX Q
 S PSNPINST=$$GET1^DIQ(59,PSOSITE,101,"I")
 I 'PSNPINST W !,"NPI Institution must be defined to continue." S DIR(0)="E" D ^DIR K DIR Q
 I '($D(PSOPRMPT)) D
 .S DIR(0)="S^PT:PATIENT(Grouped);RX:PRESCRIPTION RECEIVED DATE;E:EXIT"
 .S DIR("B")="PT"
 .S DIR("?")="     PT - Patient Centric View"
 .S DIR("?",1)="     RX - Traditional Holding Queue View"
 .S DIR("A")="Select By: (PT/RX)"
 .D ^DIR K DIR
 .I $G(Y)="RX" D EN^PSOERX Q
 .I $G(Y)="PT" D
 ..S DIR(0)="SO^A:ALL;1:NEW;2:IN PROGRESS;3:WAIT;4:HOLD;5:CCR"
 ..S DIR("L")=""
 ..S DIR("L",1)="     Select By: Status"
 ..S DIR("L",2)=""
 ..S DIR("L",3)="  A     All"
 ..S DIR("L",4)="  1     New"
 ..S DIR("L",5)="  2     In Process"
 ..S DIR("L",6)="  3     Wait"
 ..S DIR("L",7)="  4     Hold"
 ..S DIR("L",8)="  5     CCR"
 ..S DIR("B")="A"
 ..S DIR("?")=" "
 ..S DIR("?",1)="     All - View all patients with actionable prescriptions"
 ..S DIR("?",2)="     New - View patients with prescriptions in the 'NEW' status"
 ..S DIR("?",3)="     In Process - View patients with prescriptions in the 'IN PROCESS' status"
 ..S DIR("?",4)="     Wait - View patients with prescriptions in the 'WAIT' status"
 ..S DIR("?",5)="     Hold - View patients with prescriptions in the 'HOLD' status"
 ..S DIR("?",6)="     CCR - View patients with prescriptions in the 'CCR' status"
 ..D ^DIR K DIR
 ..I Y["^" S CODE=0 Q
 ..S CODE=$S(Y=1:$$PRESOLV^PSOERXA1("N","ERX"),Y=2:$$PRESOLV^PSOERXA1("I","ERX"),Y=3:$$PRESOLV^PSOERXA1("W","ERX"),1:"A")
 ..I Y=4 D
 ...S DIR(0)="SO^S:SINGLE CODE;A:ALL HOLD CODES",DIR("B")="A"
 ...S DIR("?")=" ",DIR("?",1)="  Single code - Allows selection of a single hold code",DIR("?",2)="  All Hold Codes - Selects all available hold codes"
 ...D ^DIR K DIR
 ...I Y=U S CODE=0 Q
 ...I Y="S" S CODE=$P($$ESTAT(),U)
 ...I Y="A" S CODE="AH"
 ..I Y=5 D
 ...S DIR("B")="A",DIR(0)="SO^S:SINGLE CODE;A:ALL CCR CODES"
 ...S DIR("?")=" ",DIR("?",1)="  Single code - Allows selection of a single CCR code",DIR("?",2)="  All CCR Codes - Selects all available CCR codes"
 ...D ^DIR K DIR
 ...I Y=U S CODE=0 Q
 ...I Y="S" S CODE=$P($$ESTAT2("RXN^RXD^RXW^RXF^CAO^CAH^CAP^CAR^CAX^CAF"),U)
 ...I Y="A" S CODE="CCR"
 ..Q:CODE=0
 ..D EN^PSOERXC1(,,CODE)
 .I $G(Y)="E" Q
 D FULL^VALM1
 Q
ESTAT() ;
 ; prompt for erx status
 N Y,DIC,X
 S DIC("A")="Select eRx Status: "
 S DIC=52.45,DIC(0)="AEQ",DIC("S")="I $D(^PS(52.45,""TYPE"",""ERX"",Y)),$E($P(^PS(52.45,Y,0),U))=""H"""
 S DIC("W")="W "" - "",$P($G(^(0)),""^"",2)"
 D ^DIC K DIC
 I X=U!($D(DUOUT)) Q 0
 I Y<1 Q ""
 Q Y
ESTAT2(LST) ;
 N I,DONE,DIC,Y,X,CODE,CARY,CIEN
 S DONE=0
 F I=1:1 D  Q:DONE
 .S CODE=$P(LST,U,I) I CODE="" S DONE=1 Q
 .S CIEN=$$PRESOLV^PSOERXA1(CODE,"ERX")
 .S CARY(CIEN)=""
 S DIC("A")="Select eRx Status: "
 S DIC=52.45,DIC(0)="AEQ",DIC("S")="I $D(^PS(52.45,""TYPE"",""ERX"",Y)),$D(CARY(Y))"
 S DIC("W")="W "" - "",$P($G(^(0)),""^"",2)"
 D ^DIC K DIC
 I X=U!($D(DUOUT)) Q 0
 I Y<1 Q ""
 Q Y
