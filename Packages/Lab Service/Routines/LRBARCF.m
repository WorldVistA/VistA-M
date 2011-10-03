LRBARCF ;DALOI/JMC - Lab Label Configuration Utility ;1/13/97 12:36
 ;;5.2;LAB SERVICE;**161,218**;Sep 27, 1994
EN ;
 ;
 N %ZIS,DIC,DIR,DIRUT,DTOUT,DUOUT,J,X,Y
 N LABEL,LRCLRFMT,LRFMT,LRLABEL,LRLABLIO,LRMSG,LRNODE,LRQUIT
 ;
 S LRQUIT=0,LRMSG=""
 ;
 S DIC="^LAB(69.9,1,3.6,",DIC(0)="AEMQZ",DIC("A")="Select LABEL DEVICE: "
 D ^DIC Q:Y<1
 S LRLABLIO=Y(0,0),LRNODE=+Y,LRNODE(0)=Y(0)
 ;
 F J=2:1:3 I $P(LRNODE(0),"^",J)="" D
 . I J=2 S LRMSG="No printer type designated in file #69.9"
 . I J=3 S LRMSG="No label stock designated in file #69.9"
 . S LRQUIT=1
 ;
 I 'LRQUIT,$P(LRNODE(0),"^",2)<1 S LRMSG="This printer type not supported",LRQUIT=1
 ;
 I LRQUIT D  Q
 . I $L(LRMSG) D EN^DDIOL(LRMSG,"","!?12")
 ;
 S DIR(0)=""
 F J=1:1 S LABEL="F"_J,X=$T(@LABEL) Q:X=""  D
 . I $L($P(X,";;",2+$P(LRNODE(0),"^",2))) S DIR(0)=DIR(0)_J_":"_$P(X,";;",2)_";"
 S DIR("A")="Select format to program printer"
 S DIR(0)="SO^"_DIR(0)
 D ^DIR Q:$D(DIRUT)
 ;
 S LRFMT=+Y,LABEL="F"_LRFMT,LRLABEL=$P($T(@LABEL),";;",2+$P(LRNODE(0),"^",2))
 I $P(LRNODE(0),"^",2)=1 D  Q:LRQUIT
 . N DIR,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="YO",DIR("A")="Do you want to clear all existing formats",DIR("B")="NO"
 . D ^DIR
 . I $D(DIRUT) S LRQUIT=1 Q
 . S LRCLRFMT=+Y
 ;
 S IOP=LRLABLIO,%ZIS="Q" D ^%ZIS
 I POP D HOME^%ZIS Q
 I $D(IO("Q")) D  Q
 . N ZTSK
 . S ZTRTN="DQ^LRBARCF",ZTDESC="Program Lab Label Printer"
 . F J="LRFMT","LRLABEL","LRCLRFMT" S ZTSAVE(J)=""
 . D ^%ZTLOAD,^%ZISC
 . D EN^DDIOL("Task "_$S($G(ZTSK):"",1:"NOT ")_"Queued","","!")
 ;
DQ ; Start the programming
 ;
 I LRCLRFMT D CLRFMT^LRBARA
 ;
 I '$D(ZTQUEUED) D
 . U IO(0)
 . D EN^DDIOL("Programming format F"_LRFMT,"","!")
 ;
 U IO
 D @LRLABEL
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 ;
 Q
 ;
 ;
FORMATS ;;Type of label stock;;Download routine for Intermec 3000/4000 Series;;
F1 ;;Local Use;;
F2 ;;Local Use;;
F3 ;;1x2 Plain (Old Style);;FMT^LRBARA;;
F4 ;;1x2 Barcode (Old Style);;FMT^LRBARA;;
F5 ;;1x2 Code 39/128 - UID;;FMT^LRBARA;;
F6 ;;Local Use;;
F7 ;;1x3 Plain (Old Style);;FMT^LRBARC;;
F8 ;;1x3 Barcode (Old Style);;FMT^LRBARC;;
F9 ;;1x3 Code 39/128 - UID;;FMT^LRBARC;;
F10 ;;Local Use;;
F11 ;;Local Use;;
F12 ;;10 Part Barcode (Old Style);;FMT^LRBARB;;
F13 ;;10 Part Code 39/128 - UID;;FMT^LRBARB;;
F14 ;;Reserved - future use;;
F15 ;;Reserved - future use;;
F16 ;;Reserved - future use;;
F17 ;;Reserved - future use;;
F18 ;;Reserved - future use;;
F19 ;;Reserved - future use;;
