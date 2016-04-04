DDXP1 ;SFISC/DPC-CREATE/EDIT FOREIGN FORMAT ;1/8/93  09:09
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN1 ;
 K DA S DLAYGO=0
GETFF ;
 W !
 S DIC="^DIST(.44,",DIC(0)="QEALMZ" D ^DIC K DIC
 G:Y=-1 QUIT
 S DDXPFMNM=$P(Y,U,2),DDXPFMNO=+Y
 I $P(Y(0),U,9) D USEDFF G:'($D(DA)#2) GETFF
EDITFF ;
 S:'($D(DA)#2) DA=DDXPFMNO S DDSFILE="^DIST(.44,",DR="[DDXP FF FORM1]"
 D ^DDS
QUIT ;
 K DDXPFMNM,DDXPFMNO,DA,DR,DDSFILE,Y,DLAYGO,X
 Q
USEDFF ;
 W !!,DDXPFMNM_" foreign format has been used to create an Export Template."
 W !,"Therefore, its definition cannot be changed.",!
 S DIR(0)="YA",DIR("A")="Do you want to see the contents of "_DDXPFMNM_" format? ",DIR("B")="NO"
 D ^DIR K DIR Q:$D(DIRUT)
 I Y W !! S DIC="^DIST(.44,",DA=DDXPFMNO D EN^DIQ K DIC,DA
 S DIR(0)="YA",DIR("A")="Do you want to use "_DDXPFMNM_" as the basis for a new format? ",DIR("B")="NO"
 D ^DIR K DIR Q:$D(DIRUT)!('Y)
NEWFF S DIC="^DIST(.44,",DIC(0)="QEAL",DIC("A")="Name for new FOREIGN FORMAT: " W !
 D ^DIC K DIC Q:$D(DTOUT)!($D(DUOUT))!(X="")
 I '$P(Y,U,3) W !,$C(7),$P(Y,U,2)_" is already being used.",!,"Please enter a new name for the format.",! G NEWFF
 S DDXPFMNM=$P(Y,U,2),(DIT("F"),DIT("T"))="^DIST(.44,",DA("F")=DDXPFMNO,(DA("T"),DDXPFMNO)=+Y D EN^DIT0
 S DIE="^DIST(.44,",DA=DDXPFMNO,DR="40///0" D ^DIE K DIT,DIE,DR,Y
 Q
 ;
FORMVAL ;
 N FLDLM,FIXREC,MSGCNT,ERRMSG,USEQT,MAXLEN,SUBNULL S DDSERROR=0,MSGCNT=1
 S FLDLM=$$GET^DDSVAL(DIE,DA,1),FIXREC=$$GET^DDSVAL(DIE,DA,5),USEQT=$$GET^DDSVAL(DIE,DA,8),MAXLEN=$$GET^DDSVAL(DIE,DA,7),SUBNULL=$$GET^DDSVAL(DIE,DA,11)
 I FIXREC D
 . I FLDLM]"" D
 . . S DDSERROR=DDSERROR+1
 . . S ERRMSG(MSGCNT)="You cannot specify a record delimiter and",MSGCNT=MSGCNT+1
 . . S ERRMSG(MSGCNT)="indicate that record lengths are fixed",MSGCNT=MSGCNT+1
 . . S ERRMSG(MSGCNT)="for the same foreign format.",MSGCNT=MSGCNT+1
 . . Q
 . I USEQT D
 . . S DDSERROR=DDSERROR+1
 . . S ERRMSG(MSGCNT)="You cannot choose to have non-numeric fields quoted",MSGCNT=MSGCNT+1
 . . S ERRMSG(MSGCNT)="when you are exporting fixed length records.",MSGCNT=MSGCNT+1
 . . Q
 . I MAXLEN>255 D
 . . S DDSERROR=DDSERROR+1
 . . S ERRMSG(MSGCNT)="You cannot set the Maximum Record Length larger than 255 characters ",MSGCNT=MSGCNT+1
 . . S ERRMSG(MSGCNT)="when you are defining a fixed record length format.",MSGCNT=MSGCNT+1
 . . Q
 . I SUBNULL]"" D
 . . S DDSERROR=DDSERROR+1
 . . S ERRMSG(MSGCNT)="During fixed length exports, null values will always be exported as nothing.",MSGCNT=MSGCNT+1
 . . S ERRMSG(MSGCNT)="So, you cannot specify characters to be substituted for null numeric values.",MSGCNT=MSGCNT+1
 . . Q
 . Q
 I DDSERROR D
 . S ERRMSG(MSGCNT)=" ",MSGCNT=MSGCNT+1
 . S ERRMSG(MSGCNT)="Please correct "_$S(DDSERROR>1:"these discrepancies.",1:"this discrepancy."),MSGCNT=MSGCNT+1
 . S ERRMSG(MSGCNT)="You CANNOT save the form until you correct it!"
 . Q
 D:DDSERROR MSG^DDSUTL(.ERRMSG)
 K:'DDSERROR DDSERROR
 Q
