XVEMSY1 ;DJB/VSHL**Init cont.. [10/17/97 8:45pm];2017-08-16  10:46 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
CLH ;Resequence Command Line History nodes
 NEW I,TYPE,X
 F TYPE="VSHL","VEDD","VGL","VRR" D  ;
 . I $D(^XVEMS("CLH",XVV("ID"),TYPE))'>9 KILL ^(TYPE) Q
 . S X=""
 . F I=1:1 S X=$O(^XVEMS("CLH",XVV("ID"),TYPE,X)) Q:X=""!(I>20)  I X>I S ^(I)=^(X) KILL ^(X)
 . S ^XVEMS("CLH",XVV("ID"),TYPE)=(I-1)
 . S X=20
 . F  S X=$O(^XVEMS("CLH",XVV("ID"),TYPE,X)) Q:X=""  KILL ^(X)
 Q
IDMSG ;ID message when you first login the VShell.
 W !!,"==========================< I D   N U M B E R >=========================="
 W !,"Enter your VShell ID number. Your User QWIK commands will not be"
 W !,"accessible if your ID is incorrect."
 W !!,"For first time users: Your ID number can be a number from .1 to 999999,"
 W !,"2 decimal digits. It can match your DUZ number but it doesn't have to."
 W !,"The VShell will use your ID to store data that pertains only to you. If"
 W !,"VA KERNEL routine ^XUP is not in this UCI, you will need to enter your"
 W !,"ID number each time you enter the VShell from this UCI."
 W !,"========================================================================="
 Q
IDHELP ;User hit "?" at ID prompt
 W !!,"Any QWIK commands you may have set up are stored with your ID number."
 W !,"Enter that number now or these QWIKs will not be accessible. Enter a"
 W !,"number from .1 to 999999, 2 decimal digits. If you are using the VA KERNEL"
 W !,"and your DUZ is defined, then your DUZ is offered as a default."
 W !!,"ID NUMBERS CURRENTLY IN USE:  " I '$D(^XVEMS("ID")) W "None",! Q
 NEW ID
 S ID=""
 F  S ID=$O(^XVEMS("ID","SHL",ID)) Q:ID=""  D
 . W ID
 . I $X>70 W ! Q
 . W $S($O(^XVEMS("ID","SHL",ID))]"":", ",1:"  ")
 F  S ID=$O(^XVEMS("PARAM",ID)) Q:ID=""  D
 . Q:$D(^XVEMS("ID","SHL",ID))
 . W ID
 . I $X>70 W ! Q
 . W $S($O(^XVEMS("PARAM",ID))]"":", ",1:"  ")
 F  S ID=$O(^XVEMS("QU",ID)) Q:ID=""  D
 . Q:$D(^XVEMS("ID","SHL",ID))
 . Q:$D(^XVEMS("PARAM",ID))
 . W ID
 . I $X>70 W ! Q
 . W $S($O(^XVEMS("QU",ID))]"":", ",1:"  ")
 W !
 Q
HD ;Login Heading
 D RVCHK^XVEMSY2 ;Check reverse video in the TERMINAL TYPE file.
 W !!,"VPE . . . Victory Programmer Environment . . . . . . . . . . . . David Bolduc"
 W !,"^,H,HALT=Quit   ?=Help   <F1>1,<F1>2=User QWIKs   <F1>3,<F1>4=System QWIKs",!
 Q
 ;===========================VA KERNEL===============================
XQY0MSG ;Invalid Kernel menu option
 W $C(7),!!,"VA KERNEL"
 W !,"If you're trying to access the VPE VSHELL from the VA KERNEL menu"
 W !,"system, the name of the option must contain the word 'VSHELL'."
 W !,"You must rename your VSHELL menu option."
 W !!,"PROGRAMMER MODE"
 W !,"If you're trying to access the VSHELL from Programmer Mode, XQY0"
 W !,"must first be killed."
 W !
 I $$YN^XVEMKU1("Shall I kill XQY0? ",2)=1 D  ;
 . KILL XQY0
 . W "   XQY0 killed..",!
 Q
AUDIT ;Audit support for VA KERNEL
 ;NOTE: May cause problems in MSM NT (DO^%XUCI)
 Q:'$D(^%ZOSF("PROGMODE"))
 Q:'$D(^%ZOSF("UCI"))
 Q:'$D(^%ZOSF("UCICHECK"))
 Q:'$$EXIST^XVEMKU("%ZOSV")
 Q:'$$EXIST^XVEMKU("%XUCI")
 ;
 ;Programmer Mode Log
 NEW %,%UCI,%XUCI,PGM,X,XQZ,XUCI,XUSLNT,XUVOL,Y,XVER
 X ^%ZOSF("PROGMODE")
 I 'Y X ^%ZOSF("UCI") S XUCI=Y,XQZ="PRGM^ZUA[MGR]",XUSLNT=1,XUVOL=$S($D(^%ZOSF("VOL")):^("VOL"),1:"") D DO^%XUCI
 Q
