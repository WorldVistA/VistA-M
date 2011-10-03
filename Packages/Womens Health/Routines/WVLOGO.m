WVLOGO ;HCIOFO/FT,JR IHS/ANMC/MWR - DISPLAY LOGO WHEN ENTERING PKG; ;12/7/98  15:55
 ;;1.0;WOMEN'S HEALTH;**3**;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  DISPLAYS LOGO.  GETS VERSION FROM LINE 2 OF THIS ROUTINE.
 ;
 D SETVARS^WVUTL5
 N WVVER,Y
 ;
 S Y=$P($P($T(WVLOGO+1),";;",2),";")
 ;
 W @IOF
 I '$D(DUZ(2)) D  Q
 .W !!!,"DUZ(2) is undefined.  Contact your Site Manager.",!!
 .D DIRZ^WVUTL3
 W !?3,"Women's Health Main Menu v",Y,?55,$E($P(^DIC(4,DUZ(2),0),U),1,24)
 Q
 ;
CHECK ;EP
 ;---> UPON ENTRY VIA MAIN MENU (OR LAB DATA ENTRY MENU), CHECKS TO
 ;---> SEE THAT USER'S DUZ(2) IS SET UP AS A PACKAGE SITE.
 I '$G(DUZ(2)) D WARN D  D CHKOUT Q
 .W !?5,"Your DUZ(2) variable is not defined."
 I '$D(^WV(790.02,DUZ(2),0)) D WARN D  D CHKOUT,CHKOUT1 Q
 .W !?5,"Women's Health Site Parameters have NOT been set for the site"
 .W !?5,"you are logged on as: ",$P(^DIC(4,DUZ(2),0),U)
 Q
 ;
WARN ;EP
 W @IOF,!!?35,"WARNING",!?34,"---------",!!
 Q
CHKOUT ;EP
 W !!?5,"At this point you should back out of the Women's Health"
 W !?5,"package and contact your site manager or the person in charge"
 W !?5,"of the Women's Health Software.",!
 Q
CHKOUT1 ; Message when no site parameter entry
 W !?5,"Or, if you wish to set up site parameters for this site,"
 W !?5,"you may proceed to the Edit Site Parameters option and enter"
 W !?5,"parameters for this site.  (Synonyms: MF-->FM-->ESP)",!
 D DIRZ^WVUTL3
 Q
