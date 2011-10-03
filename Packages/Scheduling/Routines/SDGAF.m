SDGAF ;ALB/EDS-ROY,G - GAF Scoring Capture ; 7-10-1998
 ;;5.3;Scheduling;**149**;Aug 13, 1993
EN(DFN) ;Entry point for getting prior GAF data and updating
 K DTOUT,DUOUT,DIRUT,DIROUT
 N SDGAF,SDGAFDT,SDNGAFDT,SDGAFSC,SDNGAFSC,SDGAFPR,SDNGAFPR,DIR
 S SDGAF=$$NEWGAF^SDUTL2(DFN)
 S SDGAFDT=$P(SDGAF,"^",3),SDGAFSC=$P(SDGAF,"^",2),SDGAFPR=$P(SDGAF,"^",4)
SCORE ;
 S DIR("A")="GAF Score",DIR(0)="N^1:100:0"
 D ^DIR K DIR G:$$OUT() ABORT
 S SDNGAFSC=Y
 S DIR("A")="Is this the correct GAF Score"
 D YN G:$$OUT() ABORT
 G:'Y SCORE
DATE ;
 S DIR("A")="Date/Time of New GAF Score"
 S DIR(0)="D^"_$S(SDGAFDT]"":SDGAFDT,1:"")_":NOW:EXT"
 S DIR("B")="NOW"
 D ^DIR K DIR("B") G:$$OUT() ABORT
 S SDNGAFDT=Y
 S DIR("A")="Is this the correct Date/Time"
 D YN G:$$OUT() ABORT
 G:'Y DATE
PROV ;
 S DIC=200,DIC(0)="AEQM"
 S DIC("S")="I $$OKPROV^SDGAF(Y)"
 S DIC("A")="Provider determining GAF Score: " D ^DIC K DIC
 G:$$OUT() ABORT
 I Y<0 W !,"You must enter a Provider!" G PROV
 S SDNGAFPR=+Y
 S DIR("A")="Is this the correct Provider"
 D YN G:$$OUT() ABORT
 G:'Y PROV
 S DIR("A")="Is the information entered correct",DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR G:$$OUT() ABORT
 G:'Y SCORE
 D UPD^YSGAF(DFN,SDNGAFSC,SDNGAFDT,SDNGAFPR,"O")
 Q
 ;
OKPROV(IEN) ; Screen for provider lookup using person class
 Q ($D(^XUSEC("SD GAF SCORE",IEN)))
 ;
ABORT ;User aborted the process
 W !,"No Updating Done!",!
 K DIR
 S DIR(0)="E" D ^DIR K DIR
 Q
OUT() ;Check for user abort
 I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) Q 1
 Q 0
 ;
YN ;Yes/No Reader logic, default to No
 S DIR("B")="NO",DIR(0)="Y" D ^DIR K DIR("B")
 Q
