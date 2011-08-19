LEXDMGV ; ISL Defaults - Manager/Verify            ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; LEXDICS     Filter
 ; LEXDICS(0)  Filter name
 ; LEXDICS(1)  Filter - Add, Delete, No Change
 ; LEXSHOW     Display
 ; LEXSHOW(0)  Display name
 ; LEXSHOW(1)  Display - Add, Delete, No Change
 ; LEXSUB      Vocabulary
 ; LEXSUB(0)   Vocabulary name
 ; LEXSUB(1)   Vocabulary - Add, Delete, No Change
 ; LEXCTX      Shortcut Context
 ; LEXCTX(0)   Shortcut Context name
 ; LEXCTX(1)   Shortcut Context - Add, Delete, No Change
 ;
 ; LEXUSER     User (text, not pointer)
 ; LEXX        Returned value
 ; LEXLIM      Limits (parameter for LEXMETH)
 ; LEXMETH     Method, singel user, by service, by location,
 ;              by both service and location, or all users
 ;
VER(LEXX) ; Verify defaults before commiting to the global
 W @IOF
 D DDEF,DDU,OVRCHG^LEXDMGO
 W ! N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR("A")="Is this correct?  "
 S DIR("B")="Yes"
 S (DIR("?"),DIR("??"))="^D VERH^LEXDMGV"
 S DIR(0)="YAO" D ^DIR K DIR I X["^^" Q "^^"
 Q:X[U U S LEXX=+Y Q LEXX
VERH ; Verify help
 W !!,"By answering ""Yes"" you will be setting the look-up defaults for the Clinical"
 W !,"Lexicon for the selected applications and users."
 W !!,"Is this correct"
 Q
DDEF ; Display defaults
 N LEXC S LEXC=0
 I (+($$ACT)) D
 . W !,"Set user defaults:",!
 I $D(LEXDICS(1)) D
 . S LEXC=LEXC+1 W !,"  ",LEXC,"  Filter      ",LEXDICS(1)
 . W:$G(LEXDICS(1))["Add" ", ",$P($G(LEXDICS(0))," (",1)
 I $D(LEXSHOW(1)) D
 . S LEXC=LEXC+1 W !,"  ",LEXC,"  Display     ",$G(LEXSHOW(1))
 . W:$G(LEXSHOW(1))["Add" ", ",$P($G(LEXSHOW(0))," (",1)
 I $D(LEXSUB(1)) D
 . S LEXC=LEXC+1 W !,"  ",LEXC,"  Vocabulary  ",$G(LEXSUB(1))
 . W:$G(LEXSUB(1))["Add" ", ",$P($G(LEXSUB(0))," (",1)
 I $D(LEXCTX(1)) D
 . S LEXC=LEXC+1 W !,"  ",LEXC,"  Shortcuts   ",$G(LEXCTX(1))
 . W:$G(LEXCTX(1))["Add" ", ",$P($G(LEXCTX(0))," (",1)
 W:(+($$ACT)) !
 Q
ACT(LEXX) ; Check for Default Action
 I $D(LEXDICS(1))!($D(LEXSHOW(1))) Q 1
 I $D(LEXSUB(1))!($D(LEXCTX(1))) Q 1
 Q 0
NAM(LEXX) ; Check for Default Names
 I $D(LEXDICS(0))!($D(LEXSHOW(0))) Q 1
 I $D(LEXSUB(0))!($D(LEXCTX(0))) Q 1
 Q 0
VAL(LEXX) ; Check for Default Values
 I $D(LEXDICS)!($D(LEXSHOW)) Q 1
 I $D(LEXSUB)!($D(LEXCTX)) Q 1
 Q 0
DDU ; Display users
 Q:'$D(LEXMETH)  N LEXUSER S LEXUSER=$P(LEXMETH,U,2) Q:'$L(LEXUSER)
 W !,"For ",LEXUSER,! Q
DEFCK ; Check defaults
 S LEXDICS(1)=$S($G(LEXDICS)="":"No Change",$G(LEXDICS)="@":"Deleted",1:"Added")
 S LEXSHOW(1)=$S($G(LEXSHOW)="":"No Change",$G(LEXSHOW)="@":"Deleted",1:"Added")
 S LEXSUB(1)=$S($G(LEXSUB)="":"No Change",$G(LEXSUB)="@":"Deleted",1:"Added")
 S LEXCTX(1)=$S($G(LEXCTX)="":"No Change",$G(LEXCTX)="@":"Deleted",1:"Added")
 Q
USERCK ; Check user
 I LEXMETH="ONE",+LEXLIM>0 S $P(LEXMETH,U,2)="user:  "_$P(LEXLIM,U,2)
 I LEXMETH="SEV",+LEXLIM>0 S $P(LEXMETH,U,2)="users in Service/Section:  "_$P(LEXLIM,U,2)
 I LEXMETH="LOC",+LEXLIM>0 S $P(LEXMETH,U,2)="users in Hospital Location:  "_$P(LEXLIM,U,2)
 I LEXMETH="SAL",+LEXLIM>0 S $P(LEXMETH,U,2)="users in Service/Location:  "_$P($P(LEXLIM,";",1),U,2)_"/"_$P($P(LEXLIM,";",2),U,2)
 I LEXMETH="ALL",+LEXLIM>0 S $P(LEXMETH,U,2)="users:  All Users"
 Q
