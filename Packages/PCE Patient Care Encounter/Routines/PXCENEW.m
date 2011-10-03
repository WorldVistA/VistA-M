PXCENEW ;ISL/dee - Used to change the screening on the display of visit and appointments ;12/17/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**14**;Aug 12, 1996
 ;; ;
 Q
 ;
NEWHOSL ;Entry point for selecting new hospital location
 D FULL^VALM1
 Q:'$$NEWLOC($G(PXCEHLOC))
 D NEWHOSL1
 G MAKELIST
 ;
NEWHOSL1 ;Entry point from initial selection of hospital location
 I $P(PXCEVIEW,"^",1)'="H" D
 . S $P(PXCEVIEW,"^",1)="H"
 . D SETDATES^PXCE
 S SDAMTYP="C"
 D PATKILL^PXCEPAT
 Q
 ;
NEWHLOC ;
 D FULL^VALM1
 N X,Y,DONE
 S DONE=0
 I PXCEVIEW'["H" D
 . N DIR,DA
 . S DIR(0)="Y"
 . S DIR("A")="Include all Clinics: "
 . S DIR("B")="Yes"
 . D ^DIR
 . I Y K PXCEHLOC S DONE=1
 I 'DONE Q:'$$NEWLOC($G(PXCEHLOC))
 G MAKELIST
 ;
NEWLOC(HOSPLOC) ;
 N NEWHLOC
 S NEWHLOC=$P($$LOCATION($G(HOSPLOC)),"^")
 I NEWHLOC'>0,("~H~P~"'[("~"_$P(PXCEVIEW,"^")_"~")) S VALMQUIT=1
 I NEWHLOC'>0 Q 0
 S PXCEHLOC=NEWHLOC
 Q 1
 ;
LOCATION(HOSPLOC) ; Select a hospital location
 N DIR,DA,X,Y
 S DIR(0)="9000010,.22O"
 S:$G(HOSPLOC)]"" DIR("B")=$P(^SC(HOSPLOC,0),"^",1)
 D ^DIR
 Q Y
 ;
CLINICST(CLINIC) ; Select a Clinic Stop Code
 N DIC,DA,X,Y
 S DIC="^DIC(40.7,"
 S DIC(0)="AEM"
 S DIC("S")="I $P(^(0),U,3)="""""
 S:$G(CLINIC)]"" DIC("B")=$P(^DIC(40.7,CLINIC,0),"^",1)
 D ^DIC
 Q Y
 ;
MAKELIST ;
 I PXCEVIEW["V" D
 . D @$S(PXCEVIEW["H":"MAKELIST^PXCEHLOC",PXCEVIEW["P":"MAKELIST^PXCEPAT",1:"QUIT")
 E  I PXCEVIEW["A" D @$S(PXCEVIEW["H":"CLNSDAM3^PXCESDA3",PXCEVIEW["P":"PATSDAM1^PXCESDA1",1:"QUIT")
 Q
 ;
QUIT Q
 ;
