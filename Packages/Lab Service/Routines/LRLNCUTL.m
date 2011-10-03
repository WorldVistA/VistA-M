LRLNCUTL ;DALOI/RH-LEDI HL7 CODES AND CALCULATE CHECKDIGIT ;11-OCT-1998
 ;;5.2;LAB SERVICE;**215,232**;Sep 27,1994
EN ;
 W @IOF
 W !,$$CJ^XLFSTR("This option allows the user to add/edit",IOM)
 W !,$$CJ^XLFSTR(" Lab Electronic specimen codes in the Topography file.",IOM)
 W !!,$$CJ^XLFSTR("It is recommended that you print a copy of Specimen codes ",IOM)
 W !,$$CJ^XLFSTR(" to assist you in editing SITE/SPECIMENS.",IOM)
START ;BEGINS PRINTING THE REPORT
 D DT^DICRW W !
 S DIR(0)="Y",DIR("A")="Print a copy of the Electronic Code specimens"
 S DIR("B")="NO" D ^DIR Q:$D(DIRUT)
 I Y D ^LRLNCHL7 W !!
 D ADEN
 D EXIT
 Q
ADEN ; ADD/EDIT LEDI HL7 CODE AND TIME ASPECT
 D EXIT
 I $Y+5>IOSL W @IOF
 S DIC=61,DIC(0)="AQEZNM"
 S DIC("A")="Select Topography Specimen to Map: "
 D ^DIC Q:Y<1
 S DA=+Y,DIE="^LAB(61,",DR=".09:.0961" S DIC("S")="I $P(^(0),U,7)=""S""" D ^DIE
 W !! D ADEN
 Q
MOD10 ;Instructions used to Calculate Mod 10 Check Digits
 ;Appendix B of the LOINC User's Guide
 ;Example using 12345
 ;Step 1: assign position to digits, right to left
 ;pos1=5  pos2=4  pos3=3  pos4=2  pos5=1
 ;Step 2: take odd digit pos counting from the right
 ;pos1 - pos3 - pos5  = 531
 ;Step 3: multiply 531*2 = 1062
 ;Step 4: take even digit starting from the right
 ;pos2 - pos4 = 42
 ;Step 5: append Step 4_Step3  = 421062
 ;Step 6: add the digits of Step 5 together
 ;4+2+1+0+6+2 = 15
 ;Step 7: find the next higest multiple of 10
 ;20
 ;Step 8: substract Step 6 from Step 7
 ;20-15 = 5
CHEKDIG(X) ;
 N LREVEN,LRI,LRL,LRSTR,LRODD,LRDIG,LRCHDIG,LRCHSUM
 S LRSTR=""
 S (LRI,LRL)=$L(X) F  S LRSTR=LRSTR_$E(X,LRI),LRI=LRI-1 Q:LRI<1
 S LRODD="" F LRI=1:1:LRL S:LRI#2 LRODD=LRODD_$E(LRSTR,LRI)
 S LRODD=LRODD*2
 S LREVEN="" F LRI=1:1:LRL S:'(LRI#2) LREVEN=LREVEN_$E(LRSTR,LRI)
 S LRCHSUM=LREVEN_LRODD,LRL1=$L(LRCHSUM)
 S LRDIG="" F LRI=1:1:LRL1 S LRDIG=LRDIG+$E(LRCHSUM,LRI)
 F LRI=10:10 S LRCHDIG=LRI-LRDIG Q:LRCHDIG>-1
 Q LRCHDIG
 Q
EXIT K DIC,DA,DIE,X,Y,DUOUT,DTOUT
 Q
