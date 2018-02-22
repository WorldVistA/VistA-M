XVEMSCL ;DJB/VSHL**Command Line History ;2017-08-15  4:45 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; CHLSET, CLHEDIT Remove refs to code in globals -> routines (c) 2016 Sam Habiel
 ;
EN(TYPE) ;TYPE=SHL/VEDD/VGL/VRR
 NEW CD,FLAGCLH,HOLD,X
 S FLAGCLH="CLH",HOLD=0,TYPE=$G(TYPE)
 D @$S(XVVSHC="<AL>":"LIST",1:"STEP")
EX ;
 I TYPE="VSHL",XVVSHC="TOO LONG" W ! D CLHSET("VSHL",CD) ;Shell's CLH. Line was too long, but save 245 characters to CLH.
 D CLEANUP
 Q
 ;===================================================================
STEP ;Step thru Commands 1 at a time
 Q:'$D(^XVEMS("CLH",XVV("ID"),TYPE))
 I XVVSHC="<AU>" S X=$S(HOLD>0:HOLD-1,1:+^XVEMS("CLH",XVV("ID"),TYPE))
 I XVVSHC="<AD>" S X=$S(HOLD>0:HOLD+1,1:$O(^XVEMS("CLH",XVV("ID"),TYPE,"")))
 Q:$G(X)'>0  Q:'$D(^XVEMS("CLH",XVV("ID"),TYPE,X))
 S CD=^XVEMS("CLH",XVV("ID"),TYPE,X)
STEP1 D SCREEN^XVEMKEA("",0,XVV("IOM")-2)
 I XVVSHC="<ESCQ>" D QWIK^XVEMSCU(CD) Q
 I XVVSHC="<RET>" S XVVSHC="**"_CD Q
 I XVVSHC="<AU>"!(XVVSHC="<AD>") S HOLD=X G STEP
 I XVVSHC="<ESCH>" D HELP^XVEMSCU G STEP1
 Q
 ;===================================================================
LIST ;List Command History (<AL>)
 W @XVV("IOF"),!?19,"C O M M A N D   L I N E   H I S T O R Y"
 S X="" F  S X=$O(^XVEMS("CLH",XVV("ID"),TYPE,X)) Q:X=""  W !?1,X,") ",^(X)
 W !
LIST1 R !?1,"Select: ",X:500 S:'$T X="^" I "^"[X Q
 I '$D(^XVEMS("CLH",XVV("ID"),TYPE)) W "   Command Line History for ",TYPE," is empty" G LIST1
 I '$D(^XVEMS("CLH",XVV("ID"),TYPE,X)) W "   Select number from left hand column" G LIST1
 S CD=^XVEMS("CLH",XVV("ID"),TYPE,X)
LIST2 D SCREEN^XVEMKEA("",0,XVV("IOM")-2)
 I XVVSHC="<ESCQ>" D QWIK^XVEMSCU(CD) Q
 I XVVSHC="<RET>" S XVVSHC="**"_CD
 I XVVSHC="<ESCH>" D HELP^XVEMSCU G STEP1
 Q
 ;===================================================================
CLEANUP ;Clean up extra characters if user hits arrow keys at the wrong time
 NEW I,Y X XVV("EOFF")
 F I=1:1:3 R *Y:0 ;If user types arrow key in wrong place
 X XVV("EON")
 Q
 ;=====================VPE modules call here==========================
CLHSET(TYPE,VALUE) ;Store Command Line.
 ;TYPE=SHL/VEDD/VGL/VRR
 ;VALUE=Command Line
 Q:$G(TYPE)']""  Q:$G(VALUE)']""
 NEW X
 I '$D(XVV("ID")) D ZS3^XVSS ; X ^XVEMS("ZS",3)
 ;-> Don't save if it matches last 2 commands
 S X=$G(^XVEMS("CLH",XVV("ID"),TYPE))
 I X>0 Q:$G(^(TYPE,X))=VALUE  Q:$G(^(X-1))=VALUE
 S X=$G(^XVEMS("CLH",XVV("ID"),TYPE))+1,^(TYPE)=X,^(TYPE,X)=VALUE
 I X>20 S X=$O(^XVEMS("CLH",XVV("ID"),TYPE,"")) KILL ^(X)
 Q
CLHEDIT(TYPE,PROMPT) ;Edit Command Line - TYPE=VEDD/VGL/VRR
 NEW CD,FLAGCLH S FLAGCLH=">>"
 S TYPE=$G(TYPE),PROMPT=$G(PROMPT) I TYPE']"" Q "^"
 I '$D(XVV("ID")) D ZS3^XVSS ; X ^XVEMS("ZS",3) ;Reset VShell variables
 D SCREEN^XVEMKEA(PROMPT,1,XVV("IOM")-2) I XVVSHC="<RET>" Q CD
 I XVVSHC="<AR>",$G(FLAGVPE)["VEDD",$G(FLAGDEF)]"" S CD=FLAGDEF Q CD
 I ",<ESC>,<ESCH>,<F1E>,<F1Q>,<TO>,"[(","_XVVSHC_",") S CD=$S(XVVSHC="<ESCH>":"?",1:"^") Q CD
 I "<AU>,<AD>,<AL>,<AR>"'[XVVSHC Q XVVSHC
 D EN(TYPE) S:XVVSHC?1"**".E XVVSHC=$P(XVVSHC,"**",2,99) S:XVVSHC="^" XVVSHC=""
 Q XVVSHC
