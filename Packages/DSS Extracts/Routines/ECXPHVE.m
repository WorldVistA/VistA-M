ECXPHVE ;ALB/JAM - Pharmacy Volume Edit ; 6/8/09 12:27pm
 ;;3.0;DSS EXTRACTS;**92,120**;Dec 22, 1997;Build 43
 ;
EN ;entry point from menu option
 N DIR,DIRUT,ECXX,Y,STOP,ECPIECE
 N $ESTACK,$ETRAP S $ETRAP="D RESET^ECXPHVE"
 S DIR(0)="SO^P:PRE;I:IVP;U:UDP"
 S DIR("A")="Which extract do you need to edit?"
 D ^DIR I $D(DIRUT) Q
 S ECXX=Y(0),ECPIECE=$S(ECXX="PRE":2,ECXX="IVP":19,1:8)
 S STOP=0 I $P($G(^ECX(728,1,7.1)),"^",ECPIECE)]"" D  I STOP Q
 .W !!,ECXX," Extract running, cannot edit. Try later.",!! S STOP=1
 .K DIR S DIR(0)="E" D ^DIR
 S $P(^ECX(728,1,7.1),"^",ECPIECE)="R"
 D EXTEDT
 Q
 ;
EXTEDT ;Edit extracts - PRE, IVP, or UDP
 N DIC,DIE,DA,DR,DTOUT,DUOUT,Y,D
 S DIC(0)="AENMQZ",DIC("S")="I $$CKREC^ECXPHVE($P(^(0),""^"",3))"
 S DIC("A")="Select "_ECXX_" EXTRACT OR SEQUENCE NUMBER: "
 ;PRE extract (file #727.1) edit Quantity (field #16) & Unit of Issue (field #22)
 I ECXX="PRE" D
 .S DIC="^ECX(727.81,",DR="16;22"
 .D TURNON^DIAUTL(727.81,"16;22","y")
 ;IVP extract (file #727.819) edit Quantity (field #10)&Total Doses per Day (#20)
 I ECXX="IVP" D
 .S DIC="^ECX(727.819,",DR="10;20"
 .D TURNON^DIAUTL(727.819,"10;20","y")
 ;UDP extract (file #727.809) edit Quantity (field #10)
 I ECXX="UDP" D
 .S DIC="^ECX(727.809,",DR="10"
 .D TURNON^DIAUTL(727.809,"10","y")
 F  D  D MIX^DIC1 Q:($D(DTOUT))!($D(DUOUT))!(Y<1)  S DIE=DIC,DA=+Y D ^DIE
 .S D="AC^B"
 .S DIC("W")="W ?30,""  "",$P(^(0),U,2),""  "",?45,$P(^(0),U,3),""  "",?55,$$GET1^DIQ(2,+$P(^(0),U,5),.01,""E"")"
RESET I $G(ECXX)="" Q
 I ECXX="PRE" D TURNON^DIAUTL(727.81,"16;22","e")
 I ECXX="IVP" D TURNON^DIAUTL(727.819,"10;20","e")
 I ECXX="UDP" D TURNON^DIAUTL(727.809,"10","e")
 I $G(ECPIECE) S $P(^ECX(728,1,7.1),"^",ECPIECE)=""
 Q
CKREC(ECXN) ;Checks if record should be edited.
 I ECXN="" Q 0
 I $G(^ECX(727,ECXN,"PURG"))'="" Q 0
 I $G(^ECX(727,ECXN,"TR"))'="" Q 0
 I $G(^ECX(727,ECXN,"Q"))'="" Q 0
 Q 1
