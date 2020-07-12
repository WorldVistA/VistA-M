PXRMICK1 ;SLC/PKR - Integrity checking routines continue. ;10/24/2018
 ;;2.0;CLINICAL REMINDERS;**45**;Feb 04, 2005;Build 566
 ;
 ;===============
OUTPUT(NOUT,TEXT) ;Output TEXT array.
 I $G(PXRMDONE) Q
 N ANS,EXIT,IND
 S EXIT=0
 F IND=1:1:NOUT D
 . W !,TEXT(IND)
 . I ($Y+2>IOSL),$E(IOST,1,2)="C-" D
 .. W !,"Press ENTER to continue or '^' to exit: "
 .. R ANS:DTIME
 .. S EXIT=('$T)!(ANS="^")
 .. I 'EXIT W #
 . I EXIT Q
 I EXIT S PXRMDONE=1
 Q
 ;
 ;===============
TCHKALL ;Check all terms.
 N IEN,NAME,OK,OUTPUT,POP,PXRMDONE,TEXT
 W #!,"Check the integrity of all reminder terms."
 D ^%ZIS Q:POP
 U IO
 S NAME="",PXRMDONE=0
 F  S NAME=$O(^PXRMD(811.5,"B",NAME)) Q:(NAME="")!(PXRMDONE)  D
 . S IEN=$O(^PXRMD(811.5,"B",NAME,""))
 . W !!,"Checking "_NAME_" (IEN="_IEN_")"
 . K OUTPUT
 . S OK=$$TERM^PXRMICHK(IEN,.OUTPUT,1)
 D ^%ZISC
 Q
 ;
 ;===============
TCHKONE ;Check selected terms.
 N DIC,DTOUT,DUOUT,IEN,OK,OUTPUT,Y
 S DIC="^PXRMD(811.5,"
 S DIC(0)="AEMQ"
 S DIC("A")="Select Reminder Term: "
GETTERM ;Get the term to check.
 W !
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT)) Q
 I Y=-1 Q
 S IEN=$P(Y,U,1)
 W #
 K OUTPUT
 S OK=$$TERM^PXRMICHK(IEN,.OUTPUT,1)
 G GETTERM
 Q
 ;
