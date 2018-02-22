XVEMGE1 ;DJB/VGL**Edit Global Node - Range [2/25/99 3:22pm];2017-08-15  12:26 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
RESET ;Reset scroll array. NUM1,NUM2=Node range.
 NEW CHK,GLNAM,I,NUM,NUM1,NUM2,PKGS,PKGV,TEMP
 S PKGV="VGL"_GLS,PKGS="IG"_GLS
 S GLNAM=^TMP("XVV",PKGV,$J,ND)
 D GETRANGE,ARRAY,@$S(NUM=NUM2:"EQUAL",NUM<NUM2:"LESS",1:"MORE")
 Q
GETRANGE ;Get range of scroll array nodes - NUM1 to NUM2
 S NUM1=$$GETSCR^XVEMKTR(ND,PKGS)
 S NUM2=$O(^TMP("XVV",PKGS,$J,"SCR",NUM1))-1
 I NUM2'>0 S CHK=0 F I=NUM1:1 D  Q:CHK  S NUM2=I
 . I '$D(^TMP("XVV",PKGS,$J,I)) S CHK=1 Q
 . I $G(^TMP("XVV",PKGS,$J,I))=" <> <> <>" S CHK=1
 Q
ARRAY ;Set up temp array with new value. Return NUM=# of lines
 NEW LN,SP,VAL
 S @("LN="_GLNAM)
 I LN?.E1C.E S LN=$$CC^XVEMGI(LN) ;Control characters
 S SP=$J(ND,3)_") "_GLNAM
 S LN=SP_" = "_LN,SP=$L(SP)
 F NUM=NUM1:1 D  Q:LN']""
 . S TEMP(NUM)=$E(LN,1,XVV("IOM")-1)
 . S LN=$E(LN,XVV("IOM"),9999) Q:LN']""
 . I $L(GLNAM)<40 S LN=$J("",SP)_" = "_LN Q
 . I NUM=NUM1,($L(GLNAM)+10)>XVV("IOM") S LN="          "_LN Q
 . S LN="          = "_LN
 Q
EQUAL ;Edited node takes same number as array nodes
 F I=NUM1:1:NUM2 S ^TMP("XVV",PKGS,$J,I)=TEMP(I)
 Q
LESS ;Edited node takes fewer than array nodes
 F I=NUM1:1:NUM S ^TMP("XVV",PKGS,$J,I)=TEMP(I)
 F I=(NUM+1):1:NUM2 S ^TMP("XVV",PKGS,$J,I)=""
 Q
MORE ;Edited node takes more than array nodes
 D EQUAL NEW END,I,NEWLINES,START
 S END=0,NEWLINES=NUM-NUM2,START=NUM2+1
 F I=START:1 Q:'$D(^TMP("XVV",PKGS,$J,I))  S END=I
 F I=END:-1:START D  ;
 . S ^TMP("XVV",PKGS,$J,I+NEWLINES)=^TMP("XVV",PKGS,$J,I)
 . Q:'$D(^TMP("XVV",PKGS,$J,"SCR",I))  S ^(I+NEWLINES)=^(I)
 F I=START:1:NUM S ^TMP("XVV",PKGS,$J,I)=TEMP(I) KILL ^("SCR",I)
 Q
DELETE ;Node deleted
 NEW CHK,I,NUM1,NUM2,PKGS,PKGV
 S PKGV="VGL"_GLS,PKGS="IG"_GLS
 Q:'$D(^TMP("XVV",PKGV,$J,ND))  D GETRANGE
 F I=NUM1:1:NUM2 S ^TMP("XVV",PKGS,$J,I)=""
 KILL ^TMP("XVV",PKGV,$J,ND)
 Q
 ;====================================================================
RANGE(RNG) ;Edit a range of subscripts or values
 NEW ADJ,CD,FD,I,II,ND,NEW,NODE,OLD,START
 Q:$G(RNG)']""
 D CURSOR^XVEMKU1(0,XVVT("S2")+XVVT("FT")-2,1)
 R "Replace: ",OLD:XVV("TIME") Q:OLD=""
 R !,"With: ",NEW:XVV("TIME")
 I RNG["^" D  Q
 . F ND=$P(RNG,"^",1):1:$P(RNG,"^",2) D RANGE1
 I RNG["," D  Q
 . F I=1:1:$L(RNG,",") S ND=$P(RNG,",",I) D RANGE1
 Q
RANGE1 ;Replace OLD with NEW
 Q:'$D(^TMP("XVV","VGL"_GLS,$J,ND))  Q:^(ND)']""
 S NODE=^(ND),CD=@NODE I CD'[OLD Q
 S START=0,ADJ=$L(NEW)-$L(OLD) ;ADJ will adjust START if NEW is different length than OLD
 F II=1:1:($L(CD,OLD)-1) S FD=$F(CD,OLD,START),START=FD+ADJ,CD=$E(CD,1,(FD-$L(OLD)-1))_NEW_$E(CD,FD,999)
 Q:CD']""  S @NODE=CD
 Q
NOTEMSG ;Message about editing a subscript and editing a range of nodes.
 D ENDSCR^XVEMKT2
 W $C(7),!!?3,"NOTE: The code for this option has been developed, but I haven't"
 W !?3,"used it enough to feel it's been thoroughly tested. If there is a"
 W !?3,"demand for this option, I can make it available in a future version."
 W !?3,"Contact BOLDUC,DAV@FORUM.VA.GOV if you wish to make your feelings"
 W !?3,"known." D PAUSE^XVEMKC(2)
 Q
