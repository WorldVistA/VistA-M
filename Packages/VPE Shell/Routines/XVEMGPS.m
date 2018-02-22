XVEMGPS ;DJB/VGL**PIECES - Xref,Word Proc,Zero Nodes [07/21/94];2017-08-15  12:45 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
XREF ;Display field if Xref node
 NEW DD,FLAGQ,FNUM,LENGTH,TMP,TMP1
 S FLAGQ=0,FLAG="XREF"
 S TMP="" F I=1:1:(FLAGXREF-1) S TMP=TMP_$P(SUBCHK,ZDELIM,I)_","
 S TMP=GL_"("_TMP_"0)" I '$D(@TMP)#2 D XREFMSG Q
 S TMP1=$P(SUBCHK,ZDELIM,FLAGXREF),TMP1=$$QUOTES(TMP1)
 S XVVX=$P(@TMP,U,2) I XVVX']"" D XREFMSG1 Q
 S XVVX=$$ALPHA(XVVX),DD=$O(^DD(XVVX,0,"IX",TMP1,""))
 I DD]"" S FNUM=$O(^DD(XVVX,0,"IX",TMP1,DD,""))
 I $G(FNUM)']""!($G(DD)']"") D XREFMSG Q
 D INDIV^XVEMKI1(DD,FNUM) I 'FLAGQ D PAUSE^XVEMKC(1)
 Q
XREFMSG ;No data on Xref
 W $C(7),!?1,"The Data Dictionary has no data on this Xref."
 D PAUSE^XVEMKC(2)
 Q
XREFMSG1 ;2nd Piece of zero node doesn't contain DD reference
 W $C(7),!?1,"NODE: "_TMP_" = "_@TMP
 W !!?1,"2nd Piece of above node is missing data dictionary #."
 D PAUSE^XVEMKC(2)
 Q
WP ;Display field if Word Processing node
 NEW DD,FLAGQ,FNUM,I,LENGTH,NODE,TMP,TMP1
 S FLAGQ=0,FLAG="WP"
 S TMP="" F I=1:1:($L(SUBCHK,ZDELIM)-4) S TMP=TMP_$P(SUBCHK,ZDELIM,I)_","
 S TMP=GL_"("_TMP_"0)" I '$D(@TMP)#2 D WPMSG,PAUSE^XVEMKC(1) Q
 S NODE=$P(SUBCHK,ZDELIM,($L(SUBCHK,ZDELIM)-2))
 I +NODE'=NODE S NODE=$$QUOTES(NODE)
 S XVVX=$P(@TMP,U,2),XVVX=$$ALPHA(XVVX)
 I XVVX']"" D WPMSG,PAUSE^XVEMKC(1) Q
 S TMP=$O(^DD(XVVX,"GL",NODE,0,"")),TMP="^DD("_XVVX_","_TMP_",0)"
 S XVVX=$P(@TMP,U,2),XVVX=$$ALPHA(XVVX)
 I XVVX']"" D WPMSG,PAUSE^XVEMKC(1) Q
 S DD=XVVX I DD]"" S FNUM=.01
 I $G(FNUM)']""!($G(DD)="") D WPMSG,PAUSE^XVEMKC(1) Q
 D INDIV^XVEMKI1(DD,FNUM) I 'FLAGQ D PAUSE^XVEMKC(1)
 Q
WPMSG ;Display msg if no data on Word Processing field.
 W $C(7),"   Invalid node."
 Q
QUOTES(STRING) ;Strip off quotes from STRING
 I $G(STRING)']"" Q ""
 S STRING=$E(STRING,2,$L(STRING)-1)
 Q STRING
ALPHA(STRING) ;Strip off alpha from STRING
 NEW I,X S X=""
 F I=1:1:$L(STRING) D
 . I $E(STRING,I)?1N!($E(STRING,I)?1".") S X=X_$E(STRING,I)
 Q X
ZERO ;Display characteristics of zero node
 W @XVV("IOF"),!?1,"Global Pieces(INT VALUE): ",Z1,") ",GLNAM,!,$E(XVVLINE1,1,XVV("IOM"))
 W !?1 S GLVAL=@GLNAM F I=1:1:4 W:I>1 "    " W "(",I,") ",$P(GLVAL,U,I)
 W !!?1,"This is a Zero Node which has the following characteristics:"
 W !?4,"Piece 1 = File name",?32,"Piece 3 = Most recently assigned entry number"
 W !?4,"Piece 2 = File number",?32,"Piece 4 = Total number of entries"
 W !!?1,"The 2nd piece may also be followed by a string of alphabetic characters"
 W !?1,"to indicate various characteristics of the file:"
 W !?4,"D... .01 field is Date/Time"
 W !?4,"N... .01 field is a Number"
 W !?4,"P... .01 field is a Pointer to another file"
 W !?4,"S... .01 field is a Set of Codes"
 W !?4,"V... .01 field is a Variable Pointer"
 W !?4,"A... Adds entries without asking: ARE YOU ADDING A NEW ENTRY?"
 W !?4,"I... File has Identifiers"
 W !?4,"O... User is asked -OK? when a matching entry is found during look-up"
 W !?4,"s... (Lower case 's') File has a screen in ^DD(file,0,""SCR"")."
 W ! D PAUSE^XVEMKC(1)
 Q
