XVEMRM1 ;DJB/VRR**FndTag,LctStrg,Goto,More,Param ;2017-08-15  4:20 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
GETTAG ;Get tag from scroll array and convert to external format
 S TG=$P(TMP," "_$C(30),1) I TG?1.N1." " S TG="" Q
 F  Q:$E(TG)'=" "  S TG=$E(TG,2,999) ;Strip starting spaces
 Q
 ;====================================================================
FINDTAG(TXT) ;Find line tag that contains TXT
 I $G(^TMP("XVV","IR"_VRRS,$J,YND))=" <> <> <>" W $C(7) Q
 I $G(TXT)']"" Q
 NEW FLAGQ,I,TG,TMP
 S FLAGQ=0
 F I=YND+1:1 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,I)) Q:TMP']""  Q:TMP=" <> <> <>"  D  Q:FLAGQ
 . Q:TMP'[$C(30)  D GETTAG Q:TG'[TXT
 . ;Note: FLAGMENU=YND^XVVT("TOP")^YCUR^XCUR
 . S FLAGMENU=I_"^"_I_"^"_1,FLAGQ=1 Q
 I 'FLAGQ S (XCUR,YCUR)=0 D MSG^XVEMRUM(16)
 Q
 ;====================================================================
LCTSTRG(TXT) ;Locate string TXT
 I $G(^TMP("XVV","IR"_VRRS,$J,YND))=" <> <> <>" W $C(7) Q
 I $G(TXT)']"" Q
 NEW FLAGQ,I,I1,LN,TG,TMP
 S FLAGQ=0,LN=""
 F I=YND+1:1 S TMP=^TMP("XVV","IR"_VRRS,$J,I) Q:TMP=" <> <> <>"  Q:TMP[$C(30)  Q:TMP']""
 Q:TMP=" <> <> <>"!(TMP']"")  S YND=I
 D GETTAG S LN=TG_" "_$P(TMP,$C(30),2,999)
 F I=YND+1:1 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,I)) D  Q:FLAGQ  Q:TMP=" <> <> <>"  Q:TMP']""
 . I TMP=" <> <> <>" D  Q
 . . Q:LN'[TXT  S FLAGQ=1
 . . F I1=I-1:-1:1 Q:$G(^TMP("XVV","IR"_VRRS,$J,I1))[$C(30)
 . . S FLAGMENU=I1_"^"_I1_"^"_1
 . I TMP'[$C(30) S LN=LN_$E(TMP,10,999) Q  ;Scrolled part of line
 . I LN[TXT D  S FLAGQ=1 Q
 . . F I1=I-1:-1:1 Q:$G(^TMP("XVV","IR"_VRRS,$J,I1))[$C(30)
 . . S FLAGMENU=I1_"^"_I1_"^"_1
 . D GETTAG S LN=TG_" "_$P(TMP,$C(30),2,999)
 I 'FLAGQ S (XCUR,YCUR)=0 D MSG^XVEMRUM(16)
 Q
 ;====================================================================
GOTO ;Go to a line
 NEW HELP,LN,NUM,X
 S HELP="   Enter line # or Tag+Offset. I'll move to that line."
 S LN=$$GETLINE^XVEMREJ("LINE",HELP,1)
 I LN["+" D ^XVEMRMG Q  ;Goto Tag+Offset
 Q:LN'>0
 ;Convert node array number to line number
 S (NUM,X)=0
 F  S X=$O(^TMP("XVV","IR"_VRRS,$J,X)) Q:X'>0  D  Q:NUM=LN
 . I ^(X)[$C(30) S NUM=NUM+1
 ;Show at least 1 line of code
 I X'>0 S X=$O(^TMP("XVV","IR"_VRRS,$J,""),-1) S:X>1 X=X-1
 S FLAGMENU=X_"^"_X_"^"_1
 Q
 ;====================================================================
MORE ;MORE Menu
 D ENDSCR^XVEMKT2
 W !?5,"CALL = Insert programmer call"
 W !?5,"I    = Run %INDEX"
 W !?5,"J    = Join 2 lines you select"
 W !?5,"JC   = Join next line to current line"
 W !?5,"LC   = Locate and change all occurrences of a string"
 W !?5,"RS   = Routine search"
 W !?5,"S    = Display routine size"
 W !?5,"SV   = Save changes"
 W !?5,"VEDD = Branch to Electronic Data Dictionary"
 W !?5,"VGL  = Branch to Global Lister"
 W !?5,"FMC  = Fileman calls"
 W !?5,"ASC  = ASCII table"
 W !?5,"PUR  = Purge Clipboard"
 W !?5,"P    = Edit Parameters"
 D PAUSE^XVEMKC(2),REDRAW^XVEMRM
 Q
PARAM ;Set parameter
 D ENDSCR^XVEMKT2
 I $G(XVV("ID"))'>0 D  D PAUSE^XVEMKC(2) Q
 . W $C(7),!!?1,"You're VPE ID is not defined. Aborting.."
 W !?1,"When you want to add a new line of code to the routine you are editing,"
 W !?1,"you hit <RETURN> to open a new line. By setting the following parameter,"
 W !?1,"you can control how this process works."
 W !!?5,"1. Open a new line BELOW the current line, regardless of"
 W !?5,"   where on the current line the cursor is located."
 W !!?5,"2. Open a new line ABOVE the current line if the cursor"
 W !?5,"   is at the start of the line. Open a new line BELOW the"
 W !?5,"   current line if the cursor is at the end of the line."
 W !?5,"   If the cursor is located anywhere else, BREAK the line."
 NEW DEF,RET
 W ! S DEF=$G(^XVEMS("E","PARAM",XVV("ID"),"RETURN"))
PARAM1 W !?5,"Enter number of your choice: " I DEF]"" W DEF_"//"
 R RET:300 S:'$T RET="^" S:RET="" RET=DEF I "^"[RET Q
 I RET'?1N!(RET<1)!(RET>2) D  G PARAM1
 . W !?5,"Enter a number from 1 to 2, or ^ to quit."
 S ^XVEMS("E","PARAM",XVV("ID"),"RETURN")=RET
 Q
