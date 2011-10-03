LEXDM3 ; ISL Default Misc - Name Default          ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; LEXFIL    Flag for Filter v.s. Display
 ; LEXX      Value returned
 ; LEXY      Local Value of Y
 ;
NAME(LEXX) ; Filter/Display name - S X=$$NAME^LEXDM3
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT W !!
 S LEXX=$S($D(LEXFIL):"User defined filter",1:"User defined display")
 S DIR("A")=$S($D(LEXFIL):"Filter name:  ",1:"Display name:  ")
 S (DIR("?"),DIR("??"))="^D NH^LEXDM3"
 S DIR(0)="FAO^2:30" D ^DIR,NR
 Q LEXX
NH ; Name Help
 W !!,"You may give a name to the ",$S($D(LEXFIL):"filter",1:"display")," you have created.  This name is"
 W !,"informational and will only be used if you elect to display your"
 W !,"current defaults.  This name should represent the purpose of the"
 W !,$S($D(LEXFIL):"filter",1:"display"),", and must be 2-30 characters in length."
 Q
NR ; Name Reformat
 N LEXY S LEXY=Y S:Y["^^" LEXX=LEXY Q:LEXY[U
 I $$UP^XLFSTR(Y)'[$$UP^XLFSTR(LEXX) D
 . S LEXY=$$UP^XLFSTR($E(Y,1))_$$LOW^XLFSTR($E(Y,2,$L(Y)))
 . S:LEXY'="" LEXX=LEXX_"/"_LEXY
 Q
