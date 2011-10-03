IBCEF51 ;ALB/TMP - MRA/EDI ACTIVATED UTILITIES CONTINUED ;06-FEB-96
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;
BTYP(IBX,IBOK,IBASK) ; Select bill types to include/exclude
 ; IBX(364.41,y,x) = passed by reference.  Array containing bill type
 ;          restrictions data subscripted by x=field # in file 364.41
 ;          and y = sequential #
 ; IBOK is passed by reference and is returned as 1 if action is
 ;       successful, 0 if not
 ; IBASK = flag =1 to ask for all 3 fields (edit bill type)
 ;              =0 to ask for only bill type field (add rule)
 ;
 N IBABORT,IBCT,IBOUT,IBEXC,IBZ,DUOUT,DTOUT,Y,X,IBY,DA
 S (IBOUT,IBEXC,IBOK,IBABORT)=0
 S IBCT=$O(IBX(364.41,""),-1)
 S Z=0 F  S Z=$O(IBX(364.41,Z)) Q:'Z  I $D(IBX(364.41,Z,.01)) S IBY(IBX(364.41,Z,.01))=""
 F  Q:IBOUT  F IBZ=.01,.02,.03 I $S($G(IBASK):1,1:IBZ=.01) D  Q:IBOUT
 . I IBZ=.01 D  Q:IBOUT
 .. S DIR("A")=$S(IBCT:"NEXT ",1:"")_"BILL TYPE"_$S('IBEXC:"",1:" TO EXCLUDE")_": " W !
 . S DIR(0)="364.41,"_IBZ_$S(IBZ=.01:"AO"_$S('IBEXC:"",1:"^^I $E(Y)=""-"""),1:"O")
 . I $D(IBX),IBZ=.01 D
 .. N Z,CT
 .. S DIR("?",1)="Enter the bill types to include/exclude.  To include, enter the"
 .. S DIR("?",2)="3 digit bill type.  To exclude, precede the 3 digit bill type with a minus (-)"
 .. S DIR("?",3)="You may use 'X' as a wild card.  Use XXX to include all bill types."
 .. S DIR("?",4)="If XXX is entered, the rest of the entries must be bill type exclusions."
 .. S CT=4
 .. I $O(IBX(364.41,""))'="" S DIR("?",5)="The current bill types entered for this rule are:" D
 ... S Z="",CT=5 F  S Z=$O(IBY(Z)) Q:Z=""  S CT=CT+1,DIR("?",CT)=$J("",5)_Z
 .. S DIR("?")=DIR("?",CT) K DIR("?",CT)
 . ;
 . D ^DIR K DIR
 . ;
 . I $D(DUOUT)!$D(DTOUT)!(Y="") D  Q
 .. I Y'="" S Y="",IBOK=0,IBABORT=1 K IBX(364.41) ; Time out or '^'
 .. S:$S(IBZ'=.01:0,1:Y="") IBOUT=1
 . ;
 . I IBZ'=.01 S IBX(364.41,IBCT,IBZ)=Y Q
 . ;
 . Q:Y=""
 . I '$$BTOK(Y,.IBY,0) Q
 . ;
 . S IBCT=IBCT+1,IBY(Y)=""
 . S IBX(364.41,IBCT,.01)=Y
 . ;
 . I Y="XXX" D  S IBEXC=1
 .. N IB
 .. S IB=0 F  S IB=$O(IBX(364.41,IB)) Q:'IB  I $E($G(IBX(364.41,IB,.01)))'="-" K IBX(364.41,IB)
 .. S IB="" F  S IB=$O(IBY(IB),-1) Q:IB=""!($E(IB)="-")  I IB'="XXX" K IBY(IB)
 .. S IBX(364.41,IBCT,.01)="XXX"
 .. W !,"  ALL BILL TYPES INCLUDED - ONLY EXCLUSIONS ALLOWED NOW",!
 I 'IBABORT,'$G(IBCT) W !,"Warning ... this rule will not work unless you enter at least one bill type",! S IBOK=1
 I IBABORT W !,"Timed out or '^' entered ... bill types not added",!
 Q
 ;
INSCO(IB,IBOK,IBDA1) ; Select insurance co option and, if 
 ; appropriate, the individual companies to include/exclude for the rule
 ; IB = passed by reference
 ;      (.07) = Returned as the internal value selected for insurance co
 ;              option
 ;      (364.4*,x) = Array is returned containing ins co data subscripted
 ;                   by x=field # in appropriate subfile
 ; IBOK is passed by reference and is returned as 1 if action is
 ;       successful, 0 if not
 ; IBDA1 = the ien of the rule being changed
 ;
 N IBCT,IBT,DIR,X,Y
 S IBOK=1,IBCT=0
 F  D  Q:'IBOK!(IBCT)
 . N DA
 . S Y=+$G(IB(.07)),DA=IBDA1
 . S DIR(0)="364.4,.07A",DIR("A")="INSURANCE CO OPTION: "
 . I '$G(IB(.07)) D ^DIR K DIR,DA
 . I Y'>0 S IBOK=0 Q  ; Required
 . S IB(.07)=+Y,IBCT=0
 . I IB(.07)=3 S IBCT=999 Q
 . S IBT=$S(IB(.07)=1:364.43,1:364.42)
 . ;Loop until all have been entered and null entry has been detected
 . F  S DIR(0)=IBT_",.01AO",DIR("A")="Select Insurance Co to "_$S(IBT["43":"in",1:"ex")_"clude for this rule: " D ^DIR K DIR Q:Y'>0  D
 .. S IB(IBT,+Y)="",IBCT=IBCT+1
 . I $D(DUOUT) W !,*7,"Entries deleted!",! K IB(IBT) S IBCT=0 Q
 . I 'IBCT W !,*7,"Warning ... no insurance companies entered",! S IBCT=1
INSQ Q
 ;
BTOK(Y,IBY,SUP) ; Check that bill type is valid for rule
 ; Function returns 1 if OK, 0 if not
 ;
 ; Y = bill type being 'added' to subfile for bill type restrictions
 ; IBY = array subscripted by bill types on file for rule
 ; SUP = 0 if do not suppress messages
 ;     = 1 suppress messages
 ;
 S IBOK=1
 I $S($D(IBY("XXX")):0,1:$E(Y)="-") D  ; For exclude, must have included some of bill type first
 . I Y?1"-"3N S Z=$E(Y,2)_"XX",Z0=$E(Y,2,3)_"X" Q:$D(IBY(Z))!$D(IBY(Z0))  D:'$G(SUP) INVAL(Y,1) S IBOK=0 Q
 . I Y?1"-"2N1"X" S Z=$E(Y,2)_"XX" Q:$D(IBY(Z))  D:'$G(SUP) INVAL(Y,1) S IBOK=0 Q
 ;
 I 'IBOK G BTOKQ
 ;
 I $D(IBY("XXX")),$E(Y)'="-" D:'$G(SUP) INVAL(Y,2) S IBOK=0 G BTOKQ ; Can't include others with 'ALL'
 I $D(IBY(Y)) D:'$G(SUP) INVAL(Y,3) S IBOK=0 G BTOKQ ;Bill type dup
 ;
 I $D(IBY("-"_Y)) D:'$G(SUP) INVAL(Y,4) S IBOK=0 ; Include/exclude for same bill type
 ;
BTOKQ Q IBOK
 ;
INVAL(Y,MES) ; Print invalid message
 ; Y = the bill type in error
 ; MES = the message # to print
 W !,"Cannot add this bill type restrictions because:"
 W !,?4
 I MES=1 W "In order to exclude, you must include at least one bill type including the",!,?6," excluded bill type first"
 I MES=2 W "You already have 'XXX' (all bill types) - can only EXCLUDE bill types now"
 I MES=3 W "You have already entered this bill type"
 I MES=4 W "You have included and excluded the same bill type"
 W !
 Q
 ;
