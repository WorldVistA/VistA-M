FSCSTUR ;SLC/STAFF-NOIS Site Tracking Update Reporting ;9/6/98  22:12
 ;;1.1;NOIS;;Sep 06, 1998
 ;
PACK ; from FSCLMP
 N DIR,X,Y K DIR
 W !!,"Choose method of reviewing package installs"
 W !,"1) All packages installed"
 W !,"2) Sites that have installed a package"
 W !,"3) Packages installed at a site"
 S DIR(0)="NOA^1:3:0",DIR("A")="Select number: "
 S DIR("?",1)="Enter the number of the selection."
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I Y=1 D ALL Q
 I Y=2 D PACKAGE Q
 I Y=3 D SITE Q
 Q
 ;
ALERT ; from FSCSTU via alerts
 S FSCSTU="ALERT" D INSTALLS^FSCLM
 Q
 ;
IN ; from FSCLMP
 I $G(VALMAR)["FSC INSTALLS" W !,"You are already using this option.",$C(7) H 2 Q
 I $G(VALMAR)["FSC MODIFY LISTS" W !,"Unable to use this option from this screen.",$C(7) H 2 Q
 S FSCSTU="" D INSTALLS^FSCLM
 S VALMBCK=$S($G(FSCEXIT):"Q",1:"R")
 Q
 ;
ALL ; from FSCLMP
 N DATE,OK
 D DATE(.DATE,.OK) I 'OK Q
 S FSCSTU="ALL" D ENTRY^FSCLMI,HEADER^FSCLMI
 Q
 ;
PACKAGE ; from FSCLMP
 N DATE,OK,PACKAGE
 D PACKS(.PACKAGE,.OK) I 'OK Q
 D DATE(.DATE,.OK) I 'OK Q
 S FSCSTU="PACKAGE" D ENTRY^FSCLMI,HEADER^FSCLMI
 Q
 ;
SITE ; from FSCLMP
 N DATE,OK,SITE
 D SITES(.SITE,.OK) I 'OK Q
 D DATE(.DATE,.OK) I 'OK Q
 S FSCSTU="SITE" D ENTRY^FSCLMI,HEADER^FSCLMI
 Q
 ;
DATE(DATE,OK) ; from FSCSTUP
 N DIR,X,Y K DIR
 S OK=1
 S DIR(0)="DA^2900101:DT:EPX",DIR("A")="Display beginning date: " S DIR("B")="T-7"
 S DIR("?",1)="Enter the date to display backto from today."
 S DIR("?",2)="Enter '^' to exit or '??' for more help."
 S DIR("?")="^D HELP^%DTC,HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) S OK=0 Q
 S DATE=Y
 Q
 ;
PACKS(PACKAGE,OK) ;
 S OK=0
 N DIR,Y K DIR
 S DIR(0)="PAO^7105.5:EM",DIR("A")="Package: "
 S DIR("?",1)="Enter the package to review."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S PACKAGE=+Y,OK=1
 Q
 ;
SITES(SITE,OK) ; from FSCSTUP
 S OK=0
 N DIR,Y K DIR
 S DIR(0)="PAO^7105.1:EM",DIR("A")="Site: "
 S DIR("?",1)="Enter the site to review."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S SITE=+Y,OK=1
 Q
 ;
XREF(USER) ; from dd 7105.2, 7105.241, 7105.242, 7105.243, 7105.244
 S USER=+$G(USER),^FSC("SPEC","AX",USER)="" K ^FSC("SPEC","AU",USER)
 Q
