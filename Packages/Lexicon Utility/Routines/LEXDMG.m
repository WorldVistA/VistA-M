LEXDMG ; ISL Defaults - Manager Options           ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; LEXDICS     Filter
 ; LEXDICS(0)  Filter name
 ; LEXSHOW     Display
 ; LEXSHOW(0)  Display name
 ; LEXSUB      Vocabulary
 ; LEXSUB(0)   Vocabulary name
 ; LEXCTX      Shortcut Context
 ; LEXCTX(0)   Shortcut Context name
 ;
 ; LEXAP       Application
 ; LEXCHG      Flag for 1) defaults changed 0) not changed
 ; LEXDNAM     Default name
 ; LEXDVAL     Default value
 ; LEXGET      Executable code which gets the default values
 ; LEXMAX      Maximum number of defaults
 ; LEXMGR      Flag - Manager
 ; LEXRTN      Routine name which sets the defaults values
 ; LEXSEL      User input/selection
 ;
 W @IOF
 N LEXDICS,LEXSHOW,LEXSUB,LEXCTX,LEXMAX
 N LEXAP,LEXCHG,LEXDNAM,LEXDVAL,LEXGET
 N LEXRTN,LEXSEL,LEXMGR
 S (LEXMGR,LEXSEL,LEXDICS,LEXDICS(0),LEXSHOW,LEXSHOW(0))=""
 S (LEXSUB,LEXSUB(0),LEXCTX,LEXCTX(0))="",LEXMAX=4
APPS ; Defaults for an application
 S LEXCHG=0
APP ; Get the application(s) - $$FI^LEXDM4
 S LEXAP=$$FI^LEXDM4
 I LEXAP="" W !!,"No application(s) selected",! G EXIT
 D DEFMENU G DEFOPT
DEFMENU ; Edit Defaults Menu
 W !!,"Lexicon Defaults:"
 W !!,"  1   Filter     "
 W $S($L($G(LEXDICS(0))):"- ",1:""),$G(LEXDICS(0))
 W:'$L($G(LEXDICS(0))) "  Unselected"
 W !,"  2   Display    "
 W $S($L($G(LEXSHOW(0))):"- ",1:""),$G(LEXSHOW(0))
 W:'$L($G(LEXSHOW(0))) "  Unselected"
 W !,"  3   Vocabulary "
 W $S($L($G(LEXSUB(0))):"- ",1:""),$G(LEXSUB(0))
 W:'$L($G(LEXSUB(0))) "  Unselected"
 W !,"  4   Shortcuts  "
 W $S($L($G(LEXCTX(0))):"- ",1:""),$G(LEXCTX(0))
 W:'$L($G(LEXCTX(0))) "  Unselected"
 W ! Q
DEFOPT ; Get user input LEXSEL from ^DIR
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 G:$G(LEXSEL)["^^" EXIT
 S DIR("A")="Select default to modify (1-"_LEXMAX_"):  "
 S DIR("?")="^D DEFHLP^LEXDMG"
 S DIR(0)="NAO^1:"_LEXMAX_":0" D ^DIR
 S LEXSEL=$S($D(DTOUT):"",X["^^":"^^",X[U&(X'["^^"):U,1:X) K DIR
 G:LEXSEL=U APPS G:LEXSEL="^^" EXIT
 G:+LEXSEL=0&(LEXCHG=0) EXIT G:+LEXSEL=0&(LEXCHG>0) USR
 ; Get Filter - $$MGR^LEXDFL
 I +LEXSEL=1 D  G DEFOPT
 . D GETDEF("LEXDICS","LEXDICS(0)","$$MGR^LEXDFL")
 ; Get Display - $$MGR^LEXDCC
 I +LEXSEL=2 D  G DEFOPT
 . D GETDEF("LEXSHOW","LEXSHOW(0)","$$MGR^LEXDCC")
 ; Get Vocabulary - $$MGR^LEXDVO
 I +LEXSEL=3 D  G DEFOPT
 . D GETDEF("LEXSUB","LEXSUB(0)","$$MGR^LEXDVO")
 ; Get Shortcut Context - $$MGR^LEXDCX
 I +LEXSEL=4 D  G DEFOPT
 . D GETDEF("LEXCTX","LEXCTX(0)","$$MGR^LEXDCX")
 Q
DEFHLP ; Help
 W !!,"Enter 1-",LEXMAX," to modify defaults, ""^"" for previous menu,"
 W:'LEXCHG " or ""^^""/<Return> to exit"
 W:LEXCHG " ""^^"" to exit, or",!,"<Return> to continue."
 D DEFMENU Q
GETDEF(LEXDVAL,LEXDNAM,LEXRTN) ; Get the default values - X LEXGET
 N LEXGET S LEXGET="S "_LEXDVAL_"="_LEXRTN X LEXGET
 S:@LEXDVAL="^^" LEXSEL="^^"
 S @LEXDNAM=$P(@LEXDVAL,U,$L(@LEXDVAL,U))
 S @LEXDVAL=$P(@LEXDVAL,U,1,($L(@LEXDVAL,U)-1))
 S:@LEXDVAL="" @LEXDNAM="No Change"
 S:@LEXDVAL'="" LEXCHG=1 D:LEXSEL'["^^" DEFMENU Q
USR ; Set defaults for a User or User Group - $$USER^LEXDMGU
 S LEXSEL=$$USER^LEXDMGU
 I $D(LEXSEL),LEXSEL=U D DEFMENU G DEFOPT
EXIT ; Cleanup and quit
 Q
