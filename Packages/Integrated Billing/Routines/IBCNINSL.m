IBCNINSL ;AITC/TAZ/VAD - GENERAL INSURANCE UTILITIES - LOOKUP ;8/20/20 12:46p.m.
 ;;2.0;INTEGRATED BILLING;**664,687,737**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;IB*2.0*664/TAZ/VAD - Cloned code from VAUTOMA to increase functionality
 ;
 ; IA #2171 used in tag INSTS
 ;
 ;Tags DIVISION, CLINIC, PATIENT, and WARD need to be updated to work with the new functionality in a future patch
DIVISION ;
 Q
 ;S ARRAY="IBUTD",DIC="^DG(40.8,",IBUTNI=2,IBUTSTR="division" G FIRST
 ;
CLINIC ;
 Q
 ;S DIC="^SC(",DIC("S")="I $P(^(0),U,3)=""C""&'+$P($G(^(""OOS"")),U,1)&'+$P($G(^(""OOS"")),U,2)&$S(IBUTD:1,$D(IBUTD(+$P(^(0),U,15))):1,'+$P(^(0),U,15)&$D(IBUTD(+$O(^DG(40.8,0)))):1,1:0)",IBUTSTR="clinic",ARRAY="IBUTC" G FIRST
 ;
PATIENT ;
 Q
 ;S DIC="^DPT(",IBUTSTR="patient",ARRAY="IBUTN" K DIC("IGNORE") G FIRST
 ;
INST(ARRAY,PROMPT) ;  Institution/Facility Lookup
 ;INPUT:
 ; ARRAY    - Results of lookup to be used by calling routine
 ; PROMPT   - Text to be used when prompting for an entry
 ;
 N IBUTNI,FAC
 S SCREEN="I $$INSTS^IBCNINSL(+$G(Y))"
 D LOOKUP(4,PROMPT,"FAC",1,,.SCREEN)
 M ARRAY=FAC
 Q
 ;
INSTS(IEN) ;Screen for Institution   IA #2171
 ;Called by:
 ;         - Instution Lookup INST^IBCNINSL
 ;         - Sending SITE Setup - TFL^IBCNIUF
 ;Input:
 ;IEN      - Internal Entry Number $G(Y)
 ;
 N ARRAY,OK,PRNT,PSTA,STA
 S OK=0
 I $$WHAT^XUAF4(IEN,13)'="VAMC" G INSTSQ         ;Not a VAMC
 S STA=$$STA^XUAF4(IEN) I STA="" G INSTSQ        ;No Station Number
 I '$$ACTIVE^XUAF4(IEN) G INSTSQ                 ;Inactive
 S PRNT=$$PRNT^XUAF4(STA),PSTA=$P(PRNT,U,2)
 S OK=$S(PRNT="":0,PSTA="":1,PSTA=STA:1,1:0)
INSTSQ ;Exit Screen
 Q OK
 ;
INSCO(ARRAY) ; Insurance Company Lookup
 ;INPUT:
 ; ARRAY    - Results of lookup to be used by calling routine
 ;
 N IBUTNI,INSCO
 D LOOKUP(36,"Insurance Company","INSCO")
 M ARRAY=INSCO
 Q
 ;
PAYER(APP,ARRAY) ;Payer Lookup
 ;INPUT:
 ; APP     - PAYER APPLICATION to include in lookup
 ; ARRAY    - Results of lookup to be used by calling routine
 ;
 ;IB*737/TAZ - Removed references to "~NO PAYER" which was an input parameter
 ;
 N IBUTNI,PAYER,SCREEN
 I $G(APP)'="" S SCREEN="I $$PYRAPP^IBCNEUT5("""_APP_""",$G(Y))'="""""
 D LOOKUP(365.12,"Payer","PAYER",,,.SCREEN)
 M ARRAY=PAYER
 Q
 ;
LOOKUP(FILE,IBPROMPT,ARRAY,IBALL,IBONE,SCREEN) ; Perform a lookup on the selected Dictionary
 ;variables:
 ; ARRAY          - The array of results of selection.  If not defined will return in 
 ;                   * ^TMP($J,"IBCNINSL",<Uppercased IBPROMPT>)
 ;                   * Passed by reference
 ;                     You can use a local or global array but a local array may cause problems
 ; FILE           - FILE number for lookup
 ; IBALL          - Prompt for All
 ; IBPROMPT       - Prompt for Dictionary
 ; IBONE          - Return 1 selection
 ; SCREEN         - Filter entries
 ;                   * This is set up in the calling subroutine and used.  It must be Newed/Killed there.
 ;
 ;Get 1st Entry
 N DIC,DIR,IBI,QUIT,REMOVE,X,Y
 I '$D(ARRAY) S ARRAY=$NA(^TMP($J,"IBCNINSL",$$UP^XLFSTR(IBPROMPT)))
 K @ARRAY S (@ARRAY,IBI,QUIT,Y)=0 S IBUTNI=$G(IBUTNI,2)
FIRST S DIR(0)="FAO",DIR("A")="Select "_IBPROMPT_": ",DIR("?")="^D QQ^IBCNINSL" S:$G(IBALL) DIR("B")="ALL"
 S DIC=FILE,DIC(0)="BEQZ" S:$G(SCREEN)]"" DIC("S")=SCREEN
 D ^DIR K DIR
 G ERR:(X="^")!'$T D:X["?" QQ,^DIC G:X="" QUIT I X="ALL",$G(IBALL) S @ARRAY=1 G QUIT
 S DIC=FILE,DIC(0)="BEQZ"
 I $G(SCREEN)'="" S DIC("S")=SCREEN
 S X=Y D ^DIC G:Y'>0 FIRST S IBI=1 D SET
 ;
 I $G(IBONE) G QUIT
 S IBALL=0
 ;
 ;Prompt for subsequent entries
 F IBI=IBI:1 D  Q:QUIT
 . S REMOVE=0
 . S DIR(0)="FAO",DIR("A")="Select another "_IBPROMPT_": ",DIR("?")="^D QQ^IBCNINSL"
 . D ^DIR K DIR
 . I (X="^")!'$T!(X']"") S QUIT=1 Q
 . I X["?" D QQ
 . I $E(X)="-" S REMOVE=1,X=$E(X,2,$L(X))
 . S DIC=FILE,DIC(0)="BEQZ"
 . I $G(SCREEN)'="" S DIC("S")=SCREEN
 . D ^DIC I Y'>0 Q
 . D SET
 ;
 G QUIT
 ;
SET ;Set into or remove from ARRAY 
 N J
 I $G(REMOVE) D  G SETQ
 . S J=$S(IBUTNI=2:+Y,1:$P(Y(0),"^"))
 . I '$D(@ARRAY@(J)) W *7,"...not on list...can't remove" Q
 . W *7,"...removed from list..."
 . K @ARRAY@(J)
 I $S($D(@ARRAY@($P(Y(0),U))):1,$D(@ARRAY@(+Y)):1,1:0) W !?3,*7,"You have already selected that ",IBPROMPT,".  Try again." G SETQ
 I IBUTNI=1 S @ARRAY@($P(Y(0),U))=+Y G SETQ
 I IBUTNI=3 S @ARRAY@($P(Y(0,0),U))=+Y G SETQ
 S @ARRAY@(+Y)=$P(Y(0),U)
SETQ ;
 Q
 ;
QQ ;Display Help
 N DIC,IBJ,IBJ1,PROMPT
 S PROMPT=IBPROMPT I "yY"[$E(PROMPT,$L(PROMPT)) S PROMPT=$E(PROMPT,1,$L(PROMPT)-1)_"ies"
 W !,"ENTER:"
 I $G(IBALL) W !?5,"- ALL (Default) for all ",PROMPT,", or"
 W !?5,"- Individual ",IBPROMPT
 W !?5,"- RETURN once all ",PROMPT," have been selected"
 I $O(@ARRAY@(0))]"" D
 . W !?5,"- An entry preceeded by a minus [-] sign to remove that entry from list."
 . W !!,"NOTE, you have already selected:"
 . S IBJ=0 F IBJ1=0:0 S IBJ=$O(@ARRAY@(IBJ)) Q:IBJ=""  W !?8,$S(IBUTNI=1:IBJ,1:@ARRAY@(IBJ))
 W !
 S DIC=FILE,DIC(0)="BEQZ" S:$G(SCREEN)]"" DIC("S")=SCREEN D ^DIC
 Q
 ;
ERR S Y=-1
QUIT S:'$D(Y) Y=1
 Q
 ;
