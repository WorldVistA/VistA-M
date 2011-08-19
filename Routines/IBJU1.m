IBJU1 ;ALB/ARH - JBI UTILITIES ; 2/14/95
 ;;Version 2.0 ; INTEGRATED BILLING ;**39**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DATE(X) ; return date in external format
 N Y S Y="" I $G(X)?7N.E S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
 ;
CMPFLD(FILE,FLD,REC) ; return value of computed field
 N D0,IBX,X,Y S X="",D0=REC,IBX=$P($G(^DD(+FILE,+FLD,0)),U,5,999) I IBX'="" X IBX
 Q X
 ;
EXSET(X,D0,D1) ; returns external form of data, given file and field
 N Y,C S Y=X,C=$P(^DD(+D0,+D1,0),"^",2) D Y^DIQ K C
 Q Y
 ;
 ;
FASTEXIT ; -- IBJ EXIT ACTION: sets flag signaling system should be exited
 S VALMBCK="Q"
 D FULL^VALM1
 K DIR S DIR(0)="Y",DIR("A")="Exit option entirely",DIR("B")="NO" D ^DIR
 I $D(DIRUT)!(Y) S IBFASTXT=5
 K DIR,DIRUT
 Q
 ;
BM(LONG,SHORT) ; called as part of MENU PROTOCOLS HEADER code so display is set up with/without actions listed
 ; turn on/off display of actions, extends/contracts bottom margin and number of lines of data display
 N BM S BM=$S(VALMMENU:SHORT,1:LONG)
 I VALM("BM")'=BM S VALMBCK="R",VALM("BM")=BM,VALM("LINES")=(VALM("BM")-VALM("TM"))+1
 Q
 ;
PRTCL(X) ; resets menu protocol to one passed in
 N DIC,Y I $G(X)'="" S DIC=101,DIC(0)="N" D ^DIC I +Y S VALM("PROTOCOL")=+Y_";ORD(101,"
 Q
 ;
FSTRNG(STR,WD,ARRAY) ; returns ARRAY(X) with STR parsed into lines of length WD
 N X,IBI,IBCNT,DIWL,DIWR,DIWF  K ARRAY,^UTILITY($J,"W") S IBCNT=0
 S X=$G(STR) I X'="" S DIWL=1,DIWR=WD,DIWF="" D ^DIWP
 I $D(^UTILITY($J,"W")) S (IBI,IBCNT)=0 F  S IBI=$O(^UTILITY($J,"W",1,IBI)) Q:'IBI  D
 . S IBCNT=IBCNT+1,ARRAY(IBCNT)=$G(^UTILITY($J,"W",1,IBI,0))
 K ^UTILITY($J,"W") S ARRAY=IBCNT
 Q
