LEXDMGU ; ISL Defaults - Manager/User Group        ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; LEXDICS(0)  Filter name
 ; LEXSHOW(0)  Display name
 ; LEXSUB(0)   Vocabulary name
 ; LEXCTX(0)   Shortcut Context name
 ;
 ; LEXC        Counter
 ; LEXI        Incremental counter
 ; LEXL        Location
 ; LEXS        Service
 ; LEXMORE     Flag - Select more users (Y/N)
 ; LEXOVER     Flag - Overwrite user defaults (Y/N)
 ; LEXSEL      User input/selection
 ; LEXUSR      Flag - User has been selected
 ; LEXVER      Flag - Default values are verified (Y/N)
 ; LEXX        Return value
 ;
 ; LEXLIM      Limits (parameter for LEXMETH)
 ; LEXMETH     Method, singel user, by service, by location,
 ;              by both service and location, or all users
 ;
USER(LEXX) ; User or user group by name or by type
 N LEXUSR,LEXMETH,LEXLIM,LEXMORE,LEXOVER,LEXVER
GRP ; Get user/user group
 K DIC,DIR S LEXX=""
 W ! D DM S (LEXX,LEXUSR)=$$USR I LEXX[U G EXIT
GETUSER ; Get user or user group type (Service/Location)
 S (LEXMETH,LEXLIM)=""
 I +LEXX=1 W ! S LEXLIM=$$USER^LEXDM4,LEXMETH="ONE"
 I +LEXX=2 W ! S LEXLIM=$$SERV^LEXDM4,LEXMETH="SEV"
 I +LEXX=3 W ! S LEXLIM=$$LOC^LEXDM4,LEXMETH="LOC"
 I +LEXX=4 D
 . N LEXS,LEXL W ! S LEXS=$$SERV^LEXDM4
 . I LEXS=U!(LEXS="^^")!(+LEXS'>0) S LEXLIM=LEXS Q
 . W ! S LEXL=$$LOC^LEXDM4
 . I LEXL=U!(LEXL="^^")!(+LEXL'>0) S LEXLIM=LEXL Q
 . S LEXLIM=LEXS_";"_LEXL,LEXMETH="SAL"
 I +LEXX=5 S LEXLIM=1,LEXMETH="ALL"
 D LIMIT,METHOD
 Q:+($G(LEXLIM))'>0 LEXLIM
 ; Check defaults - DEFCK^LEXDMGV
 D DEFCK^LEXDMGV
 ; Check user - USERCK^LEXDMGV
 D USERCK^LEXDMGV
 ; Ask to overwrite defaults - $$OVER^LEXDMGO
 S LEXOVER=$$OVER^LEXDMGO
 Q:LEXOVER["^^" "^^"
 ; Verify before setting global - $$VER^LEXDMGV
 S LEXVER=$$VER^LEXDMGV
 S:LEXVER[U LEXS=U S:LEXVER["^^" LEXX="^^" Q:LEXX[U LEXX
 D:+($G(LEXVER))>0 UPDATE^LEXDMGT
 ; More users
 S LEXMORE=0 I +($G(LEXUSR))>0,+($G(LEXUSR))<5 S LEXMORE=1
 I +($G(LEXMORE))>0,LEXX'["^^" D  G:+($G(LEXMORE))>0 GRP
 . S LEXMORE=$$MOREUSR
 Q LEXX
LIMIT ; Check search limits
 Q:+($G(LEXLIM))>0  S:LEXLIM["^^" LEXLIM="^^" Q:LEXLIM[U
 S LEXLIM=U Q
METHOD ; Check search method
 Q:+($G(LEXLIM))>0  S:LEXLIM[U!($G(LEXLIM)="") LEXMETH="" Q
EXIT ; Quit USER selection
 Q LEXX
MOREUSR(LEXX) ; Want to set the current defaults for more users?
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR("A",1)="Do you wish to set the currently selected user"
 S DIR("A")="defaults to another user or group of users?  "
 S DIR("B")="No",(DIR("?"),DIR("??"))="^D MOREHLP^LEXDMGU"
 S DIR(0)="YAO" D ^DIR K DIR S LEXX=+Y Q:$D(DTOUT) "^" S:X[U LEXX=U
 S:X["^^" LEXX="^^" Q:LEXX[U LEXX S LEXX=+Y Q LEXX
MOREHLP ; More user help
 D CD W !,"The defaults you selected may be applied to another user/user group",!
 Q
USR(LEXX) ; Get response for USER
 W ! N Y,DTOUT,DUOUT,DIRUT,DIROUT S DIR("A")="Select 1-5:  "
 S DIR("B")=1,(DIR("?"),DIR("??"))="^D USRHLP^LEXDMGU"
 S DIR(0)="NAO^1:5:0" D ^DIR K DIR S LEXX=+Y
 Q:$D(DTOUT) "^^" S:X[U LEXX=U S:X["^^" LEXX="^^" Q:LEXX[U LEXX
 S:+Y>0&(+Y<6) LEXX=+Y Q LEXX
 Q
USRHLP ; Help for respons to USER
 I X'["?",+X<1!(+X>5) D  Q
 . W !!,"Press <Return> to continue, "
 . W """^"" to exit or select (1-5)" D DM
 I '$L(($G(LEXDICS(0))_$G(LEXSHOW(0))_$G(LEXSUB(0))_$G(LEXCTX(0)))) D  Q
 . W !!,"Press <Return> to continue, "
 . W """^"" to exit or select (1-5)" D DM
 D CD W !,"The default selections listed above may be applied to either"
 W !,"a single user, a user group based on service/location, or all"
 W !,"users.  You may either select a user/user group (1-5), or "
 W !,"press <Return> to continue, or ""^"" to exit." D DM
 Q
CD ; Current defaults
 W !!,"Current default selections:",!
 W !,"    Filter     - "
 W $S($L($G(LEXDICS(0))):$G(LEXDICS(0)),1:"Not selected")
 W !,"    Display    - "
 W $S($L($G(LEXSHOW(0))):$G(LEXSHOW(0)),1:"Not selected")
 W !,"    Vocabulary - "
 W $S($L($G(LEXSUB(0))):$G(LEXSUB(0)),1:"Not selected")
 W !,"    Shortcuts  - "
 W $S($L($G(LEXCTX(0))):$G(LEXCTX(0)),1:"Not selected") W !
 Q
DM ; Display menu
 W !!,"User/User groups:",!
 N LEXC F LEXC=1:1:999 Q:$P($T(UM+LEXC^LEXDMGU),";",2)=""  D
 . W !,"   ",$J($P($T(UM+LEXC^LEXDMGU),";",2),2),"  "
 . W $P($T(UM+LEXC^LEXDMGU),";",3)
 Q
UM ;; User/user group menu data
 ;1;Single User
 ;2;Group based on Service
 ;3;Group based on Hospital Location
 ;4;Group based on both Service and Hospital Location
 ;5;All Users
 ;;
