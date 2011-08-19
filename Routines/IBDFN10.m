IBDFN10 ;ALB/AAS - ENCOUNTER FORM - (selection routines - mostly for PCE files) ; 5-Jun-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**40**;APR 24, 1997
 ;
LOOK(DIC,SCREEN) ; -- Look up entry
 I +$G(DIC)<1 Q
 S DIC(0)="AEMQZ",DIC("S")=$G(SCREEN) D ^DIC K DIC
 Q
 ;
EDTOP ; -- select Education Topics (from file 9999999.09)
 N X,Y,SCREEN
 I '$D(@IBARY@("SCREEN")) D EDSCRN
 S SCREEN=$G(@IBARY@("SCREEN"))
 D LOOK(9999999.09,SCREEN) I +Y<1 K @IBARY Q  ;kill if nothing selected
 S @IBARY=+Y_"^"_$P(Y(0),"^",1,2)
 Q
EDSCRN ;
 S @IBARY@("SCREEN")="I '$P(^(0),U,3)"
 Q
 ;
IMM ; -- select Immunizations (from file 9999999.14)
 N X,Y,SCREEN
 I '$D(@IBARY@("SCREEN")) D IMSCRN
 S SCREEN=$G(@IBARY@("SCREEN"))
 D LOOK(9999999.14,SCREEN) I +Y<1 K @IBARY Q  ;kill if nothing selected
 S @IBARY=+Y_"^"_$P(Y(0),"^",1,3)
 Q
IMSCRN ;
 S @IBARY@("SCREEN")="I '$P(^(0),U,7)"
 Q
 ;
EXAM ; -- select Exams (from file 9999999.15)
 N X,Y,SCREEN
 I '$D(@IBARY@("SCREEN")) D EXSCRN
 S SCREEN=$G(@IBARY@("SCREEN"))
 D LOOK(9999999.15,SCREEN) I +Y<1 K @IBARY Q  ;kill if nothing selected
 S @IBARY=+Y_"^"_$P(Y(0),"^",1,3)
 Q
EXSCRN ;
 S @IBARY@("SCREEN")="I '$P(^(0),U,4)"
 Q
 ;
TRTMNT ; -- select treatments (from file 9999999.17)
 N X,Y,SCREEN
 I '$D(@IBARY@("SCREEN")) D TRSCRN
 S SCREEN=$G(@IBARY@("SCREEN"))
 D LOOK(9999999.17,SCREEN) I +Y<1 K @IBARY Q  ;kill if nothing selected
 S @IBARY=+Y_"^"_$P(Y(0),"^",1,2)
 Q
TRSCRN ;
 S @IBARY@("SCREEN")="I '$P(^(0),U,4)"
 Q
 ;
SKINTST ; -- select Skin Tests (from file 9999999.28)
 N X,Y,SCREEN
 I '$D(@IBARY@("SCREEN")) D SKSCRN
 S SCREEN=$G(@IBARY@("SCREEN"))
 D LOOK(9999999.28,SCREEN) I +Y<1 K @IBARY Q  ;kill if nothing selected
 S @IBARY=+Y_"^"_$P(Y(0),"^",1,2)
 Q
SKSCRN ;
 S @IBARY@("SCREEN")="I '$P(^(0),U,3)"
 Q
 ;
HF ; -- select Health Factors (from file 9999999.64)
 N X,Y,SCREEN
 I '$D(@IBARY@("SCREEN")) D HFSCRN
 S SCREEN=$G(@IBARY@("SCREEN"))
 D LOOK(9999999.64,SCREEN) I +Y<1 K @IBARY Q  ;kill if nothing selected
 S @IBARY=+Y_"^"_$P(Y(0),"^",1,5)
 Q
HFSCRN ;
 S @IBARY@("SCREEN")="I '$P(^(0),U,10),$P(^(0),U,10)=""F"",'$P(^(0),U,11)"
 Q
 ;
CHECKOUT ;other visit dispositions than checkout
 ;the PCE GDI does not accept this now,but it may in the future
 K DIR S DIR(0)="SO^1:No-show;2:Cancel;3:Rescheduled"
 S DIR("A")="APPOINTMENT DISPOSITION TYPE"
 D ^DIR
 I $D(DIRUT) K @IBARY Q  ;kill if nothing selected
 S @IBARY=+Y_"^"_$S(+Y=1:"No-show",+Y=2:"Cancel",+Y=3:"Rescheduled",1:"")
 K DIR
 Q
