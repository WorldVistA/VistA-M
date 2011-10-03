PSORENW2 ;IHS/DSD/JCM - displays renew rx information for edit ; 12/09/92  10:14 am
 ;;7.0;OUTPATIENT PHARMACY;**46,103**;DEC 1997
 ; This routine displays the entered new rx information and
 ; asks if correct, if not allows editing of the data.
 ;------------------------------------------------------------
START ;
 S (PSORENW("DFLG"),PSORENW2("QFLG"))=0
 D DISPLAY ; Displays information
 D ASK G:PSORENW2("QFLG")!PSORENW("DFLG") END
EN D EDIT
 G:'$G(PSORX("FN")) START
END D EOJ
 Q
 ;------------------------------------------------------------
DISPLAY ;
 W !!,"Rx # ",PSORENW("NRX #")
 W ?23,$E(PSORENW("FILL DATE"),4,5),"/",$E(PSORENW("FILL DATE"),6,7),"/",$E(PSORENW("FILL DATE"),2,3)
 W !,$G(PSORX("NAME")),?30,"#",PSORENW("QTY")
 S X=PSORENW("SIG") D SIGONE^PSOHELP W !,$E($G(INS1),2,250),!!,$S($G(PSODRUG("TRADE NAME"))]"":PSODRUG("TRADE NAME"),1:PSODRUG("NAME"))
 W !,PSORENW("PROVIDER NAME"),?25,PSORX("CLERK CODE")
 W !,"# of Refills: ",PSORENW("# OF REFILLS"),!
 Q
 ;
ASK ;
 K DIR,X,Y
 S DIR("A")="Is this correct",DIR(0)="Y",DIR("B")=$S(+$G(PSEXDT):"NO",1:"YES") D ^DIR K DIR
 I $D(DIRUT) S PSORENW("DFLG")=1 G ASKX
 I Y,+$G(PSEXDT) D  K PSOELSE G ASKX
 .K PSOELSE I $G(POERR) S PSOELSE=1 D
 ..S Y=PSORENW("FILL DATE") X ^DD("DD") S VALMSG=Y_" fill date is greater than possible expiration date of "
 ..S Y=$P(PSEXDT,"^",2) X ^DD("DD") S VALMSG=VALMSG_Y_"."
 .I '$G(PSOELSE) D
 ..S Y=PSORENW("FILL DATE") X ^DD("DD") W !!,$C(7),Y_" fill date is greater than possible expiration date of "
 ..S Y=$P(PSEXDT,"^",2) X ^DD("DD") W Y_".",!
 I Y S PSORENW2("QFLG")=1
ASKX K X,Y,DIRUT,DTOUT,DUOUT,SIG
 Q
 ;
EDIT ;
 S PSORX("EDIT")=1
 D INIT^PSORENW3,EN^PSOORNE4(.PSORENW),STOP^PSORENW1 ;D EN^PSORENW2
 ;D ^PSORENW3
 S PSORENW("DFLG")=0
 Q
 ;
EOJ ;
 K PSORENW2,PSORX("EDIT"),PSORENW("EDIT"),PSOQUIT
 Q
