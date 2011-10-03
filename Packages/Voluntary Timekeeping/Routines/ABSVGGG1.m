ABSVGGG1 ;EAP ALTOONA  ;9/24/97  3:08 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;**7**;JULY 1994;
 W:'$D(DUZ) !,"NO DUZ DEFINED, CALL IRM!!!"
 Q:'$D(DUZ)
 S DIR(0)="SO^1:FACILITY;2:STATE;3:VISN;4:ALL"
 S DIR("L",1)="     Select one of the following:"
 S DIR("L",2)=" "
 S DIR("L",3)="      1   FACILITY"
 S DIR("L",4)="      2   STATE"
 S DIR("L",5)="      3   VISN"
 S DIR("L")="      4   ALL"
 S DIR("?")="Enter a code from the list"
 D ^DIR K DIR G:$D(DIRUT) END
 S X="Remember, the output from this report is designed to be displayed/printed in 132 column format.  Anything less may be unreadable.*!" D MSG^ABSVQ
 S TYPE=+Y D @TYPE Q:'$D(BY)
 S DIC="^ABS(503339.2,",L=0,FLDS="[ABSV DIRECTORY PRINT]" D EN1^DIP
END K ALT2,K,POP,T,DIC,L,BY,FLDS,DIRUT,DIR(0),DIR("L")
 K FO,FI,ON,SI,TH,TW,ZN,TYPE
 QUIT
1 S DIC=503339.2,DIC(0)="AEMNZQ",DIC("A")="Select Facility Identifier: " D ^DIC
 I Y<0 D NO QUIT
 S BY=".01",(FR,TO)=$P(Y,"^",2) QUIT
2 S DIC=5,DIC(0)="AEMNZQ" D ^DIC
 I Y<0 D NO QUIT
 S BY="6",(FR,TO)=$P(Y,"^",2) QUIT
3 S DIR(0)="NA^1:22:0",DIR("A")="Select VISN Number: "
 D ^DIR
 K DIR
 I $$DIR^ABSVU2 QUIT
 S BY="2",(FR,TO)=+Y QUIT
4 S BY=1,FR="A",TO="ZZZ" QUIT
NO S X="No Selection Made, Option Terminating!*" D MSG^ABSVQ QUIT
