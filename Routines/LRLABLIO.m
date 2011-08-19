LRLABLIO ;DALOI/TGA/JMC - TESTS LABEL PRINTER ;8/8/89  11:17
 ;;5.2;LAB SERVICE;**107,161,218**;Sep 27, 1994
 ;
 ; Reference to File #3.5 supported by DBIA #2469
 ;
1 ;
 S U="^" Q:$D(LRLABLIO)
 ;
 N %ZIS,DIR,DIRUT,DTOUT,DUOUT,IOP,LRLABEL,POP,X,Y
 ;
 ; Setup handle for user's "HOME" device.
 D OPEN^%ZISUTL("LRHOME","HOME")
 ;
 S %ZIS("B")="LABLABEL"
 ;
 ; Check if label device assigned to this user's HOME Device file entry.
 I $G(IOS) D
 . S X=$$GET1^DIQ(3.5,IOS_",",101,"E")
 . I $L(X) S %ZIS("B")=X
 ;
 I %ZIS("B")="LABLABEL",$D(^LAB(69.9,1,3.5,+$G(DUZ(2)),0)) D
 . ; Get this division's default printer
 . S %ZIS("B")=$P($G(^LAB(69.9,1,3.5,+DUZ(2),0)),U,3)
 I %ZIS("B")="" S %ZIS("B")="LABLABEL"
 S %ZIS("A")="Print labels on: ",%ZIS="NQ"
 ; Setup handle for user's LABEL device.
2 D OPEN^%ZISUTL("LRLABEL",,.%ZIS)
 I POP!(IO=IO(0)) D BD Q
 S LRLABLIO=ION_";"_IOST_";"_IOM_";"_IOSL
 I $D(IO("Q")) S LRLABLIO("Q")=1
 I $E(IOST,1)'="P" D  G:Y'=1 2
 . N DIR,DIRUT,DTOUT,DUOUT
 . D USE^%ZISUTL("LRHOME")
 . S DIR(0)="YAO",DIR("A",1)="NOT printing on a printer.",DIR("A")="Are you sure"
 . D ^DIR
 ; Device on another cpu, can't test.
 I $D(IOCPU) D  Q
 . N MSG
 . S MSG="Device "_ION_" is on CPU '"_IOCPU_"' - Unable to test"
 . D USE^%ZISUTL("LRHOME")
 . D EN^DDIOL(MSG,"","!?5")
 . D K
 ;
3 I $D(LRLABLIO("Q")) D K Q
 D USE^%ZISUTL("LRHOME")
 W !
 K DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YAO",DIR("A")="Do you wish to test the label printer: ",DIR("B")="NO"
 S DIR("?")="Enter 'YES' if you want to test the printer, 'NO' if you do not."
 D ^DIR
 I $D(DIRUT) D BD Q
 I Y<1 G K ; Don't want to test
 D OPEN^%ZISUTL("LRLABEL",LRLABLIO)
 I POP D  G 1
 . D USE^%ZISUTL("LRHOME")
 . D EN^DDIOL("Device in use - try later","","!")
 . K LRLABLIO
 N LRAA
 S LRAA=0
 D LBLTYP^LRLABLD
 ;
T ; Print test label
 D USE^%ZISUTL("LRHOME")
 K DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !!,"Using label routine: ",LRLABEL,!
 S DIR(0)="E"
 S DIR("A",1)="Load and position label stock as appropriate for this printer."
 S DIR("A")="Press return when ready"
 D ^DIR
 I Y'=1 D BD Q
 ;
 N I,N,PNM,SSN
 N LRACC,LRBAR,LRBARID,LRCE,LRDAT,LRINFW,LRLLOC,LRPREF,LRAN,LRRB,LRTOP,LRTS,LRUID,LRURG,LRURG0,LRURGA,LRXL
 ;
 ; Set up variables for test label
 S PNM="TEST-LABEL-DO-NOT-USE",SSN="000-00-0000P",LRDAT="XX/XX/XX",LRLLOC="LAB",LRRB=1
 S LRACC="SITE-TEST-LABEL",LRCE="9999999",LRPREF="SMALL "
 S LRTOP="TEST-TUBE",LRTS(1)="Don't-use",LRTS(2)="this-label"
 S LRINFW="Patient  info  field",(LRBARID,LRUID)="0000000000",LRAN="000",I=1,N=1,LRXL=0
 S (LRURG,LRURG0)=1
 S LRURGA=$$URGA^LRLABLD(LRURG0)
 ;
 D LRBAR^LRLABLD
 D USE^%ZISUTL("LRLABEL"),@LRLABEL
 D USE^%ZISUTL("LRHOME")
 ;
 K DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="YAO",DIR("A")="Label OK: ",DIR("B")="YES"
 S DIR("?")="Enter 'YES' if label printed correctly, 'NO' if it did not."
 D ^DIR
 I $D(DIRUT) G BD
 I Y=1 G K
 ;
 K DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="YAO",DIR("A")="Test printer again: ",DIR("B")="YES"
 S DIR("?")="Enter 'YES' to test label printing, 'NO' to quit testing."
 D ^DIR
 I $D(DIRUT) G BD
 I Y=1 G T
 G K
 ;
BD ; Bad device - abort, timeout, unsuccessful selection
 K LRLABLIO
K ; Close devices
 D CLOSE^%ZISUTL("LRLABEL")
 D CLOSE^%ZISUTL("LRHOME")
 Q
