LEXDMGO ; ISL Defaults - Manager/Overwrite         ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; LEXOVER     Flag - Overwrite user defaults (Y/N)
 ; LEXDNAM     Default name
 ; LEXDVAL     Default value
 ; LEXX        Return value
 ; 
OVER(LEXX) ; Replace existing defaults
 S LEXX=$$OVERW Q LEXX
OVERW(LEXX) ; Ask to overwrite (replace)
 W !
OVERP ; Get user response
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR("A")="Replace existing user defaults?  "
 S DIR("B")="No",DIR(0)="YAO",DIR("?")="^D OVRH^LEXDMGO"
 S DIR("??")="^D OVRH^LEXDMGO" D ^DIR K DIR I Y[U S LEXX=Y Q LEXX
 S LEXX=0 S:+Y>0 LEXX=1 Q LEXX
OVRH ; Overwrite help
 W !!,"  By answering No:"
 W !!,"    Existing defaults will have precedence over the selected changes"
 W !,"    Replacing or deleting existing defaults will not be allowed"
 W !,"    Adding defaults where none previously existed will be allowed"
 W !!,"  By answering Yes:"
 W !!,"    Selected changes will have precedence over existing defaults"
 W !,"    Adding defaults where none previously existed will be allowed",!
 D DISCHG Q
OVRCHG ; Display effects of overwrite changes
 I +($G(LEXOVER))>0 D  Q
 . W !,"Replace existing defaults:"
 . W "  Yes, existing defaults will be changed",! D DISCHG
 I +($G(LEXOVER))'>0 D  Q
 . W !!,"Replace existing defaults:"
 . W "  No, existing defaults will remain unaltered",!
 Q
DISCHG ; Display changes
 D CHG("LEXDICS","filter"),CHG("LEXSHOW","display")
 D CHG("LEXSUB","vocabulary"),CHG("LEXCTX","shortcuts")
 Q
CHG(LEXDVAL,LEXDNAM) ; Changes
 I $G(@LEXDVAL)="" D  Q
 . W !,"  No changes made to the default ",LEXDNAM
 I $G(@LEXDVAL)'="@" D  Q
 . W !,"  Existing ",LEXDNAM," will be replaced"
 I $G(@LEXDVAL)="@" D
 . W !,"  Existing ",LEXDNAM," will be deleted"
 Q
