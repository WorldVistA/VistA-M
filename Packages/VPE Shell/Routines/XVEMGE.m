XVEMGE ;DJB/VGL**Edit Global Node ;2017-08-15  12:28 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in EDITS1+15 (c) 2016 Sam Habiel
 ;
EDITV ;Edit node's value
 NEW CD1,FLAGQ,NEW,ND,NODE,OLD,TAB,TEMP,TEMP1,X
 NEW CD,XVVSHC ;^XVEMKEA returns CD,XVVSHC,XVV
EDITV1 Q:'$$GETND()
 I '$D(^TMP("XVV","VGL"_GLS,$J,ND)) D MSG^XVEMGUM(1) G EDITV1
 S NODE=^(ND)
 S (CD,CD1)=@NODE
 ;I CD?.E1C.E D MSG^XVEMGUM(26) G EDITV1 ;Control characters
 I XVV("OS")=9 S DX=0,DY=XVVT("S2") X XVVS("CRSR") W @XVVS("BLANK_C_EOS")
 D CURSOR^XVEMKU1(0,15,1)
 W !,@XVV("RON"),!?32,"EDIT GLOBAL VALUE",?XVV("IOM"),@XVV("ROFF"),!!
 S TEMP=NODE I $L(NODE)>40 S TEMP="" D  ;
 . I $L(NODE)<XVV("IOM") W NODE Q
 . W $E(NODE,1,XVV("IOM")),!?1,$E(NODE,XVV("IOM")+1,999)
 D EDIT^XVEMKE(TEMP_" = ")
 D:$G(XVVSHC)="TOO LONG" PAUSE^XVEMKU(1) D KILLCHK^XVEMKU(CD)
 I CD'=CD1 S @NODE=CD D RESET^XVEMGE1 ;Adj scroll array
 Q
EDITS ;Edit node's subscript
 ;D NOTEMSG^XVEMGE1 Q
 NEW CD1,FLAGQ,NEW,ND,NODE,OLD,TAB,TEMP,TEMP1
 NEW CD,XVVSHC ;^XVEMKEA returns CD,XVVSHC,XVV
EDITS1 Q:'$$GETND()
 I '$D(^TMP("XVV","VGL"_GLS,$J,ND)) D MSG^XVEMGUM(12) G EDITS1
 S NODE=^(ND)
 I $D(@NODE)>1 D MSG^XVEMGUM(23) G EDITS1 ;Don't delete node with decendents
 S CD=$P(NODE,"(",2,999),(CD,CD1)=$E(CD,1,$L(CD)-1) ;Set CD=Subscript Only
 I CD']"" D MSG^XVEMGUM(14,1) Q
 I XVV("OS")=9 S DX=0,DY=XVVT("S2") X XVVS("CRSR") W @XVVS("BLANK_C_EOS")
 D CURSOR^XVEMKU1(0,15,1)
 W !,@XVV("RON"),!?29,"EDIT GLOBAL SUBSCRIPT",?XVV("IOM"),@XVV("ROFF")
 W !!?1,NODE D EDIT^XVEMKE($J("",$F(NODE,"(")-1))
 Q:CD=CD1  I CD']"" D KILLND Q
 I $L(CD)>127 W ! D MSG^XVEMGUM(13,1) Q
 S CD=$P(NODE,"(",1)_"("_CD_")"
 S $ETRAP="D ERROR S $EC="""""
 I $D(@CD)#2 D MSG^XVEMGUM(12,1) Q  ;Don't overwrite existing node
 S TEMP=@NODE KILL @NODE S @CD=TEMP
 S ^TMP("XVV","VGL"_GLS,$J,ND)=CD
 D RESET^XVEMGE1 ;Adj scroll array
 Q
GETND() ;Get node. 0=No node selected  1=Node selected
 S ND=$$GETREF^XVEMKTR("IG"_GLS) I ND="^" Q 0
 I ND="***" W $C(7) Q 0
 Q ND
EDITR ;Edit a range of nodes
 ;D NOTEMSG^XVEMGE1 Q
 NEW RNG D MSG^XVEMGUM(24)
 S RNG=$$GETRANG^XVEMKTR("VGL"_GLS) Q:RNG="^"  D RANGE^XVEMGE1(RNG)
 Q
KILLND ;Edit subscript - Kill node
 NEW ANS
 W !?2,"Do you want to delete this node? Yes// "
 R ANS:300 Q:'$T!(ANS="^")  S:ANS="" ANS="YES"
 S ANS=$$ALLCAPS^XVEMKU(ANS)
 I "NY"'[$E(ANS) W "   Y=Yes  N=No" G KILLND
 Q:$E(ANS)'="Y"  KILL @NODE D DELETE^XVEMGE1
 Q
ERROR ;Invalid subscript was entered
 W $C(7),!!?3,"Invalid subscript." D PAUSE^XVEMKU(1)
 Q
STRIP ;Strip off control characters
 NEW ASK,CD,CD1,I,ND,NODE,TMP
STRIP1 Q:'$$GETND()
 I '$D(^TMP("XVV","VGL"_GLS,$J,ND)) D MSG^XVEMGUM(1) G STRIP1
 S NODE=^(ND)
 S CD=@NODE
 I CD'?.E1C.E D MSG^XVEMGUM(25) G STRIP1
 IF CD'?.E1C.E W "  No control characters found" G STRIP1
 S CD1=""
 F I=1:1:$L(CD) S TMP=$E(CD,I) I TMP'?1C S CD1=CD1_TMP
 Q:CD=CD1  ;No change
 R "  Strip control characters? Y//",ASK:300 S:'$T ASK="^"
 I ASK'="",$E(ASK)'="y",$E(ASK)'="Y" G STRIP1
 S @NODE=CD1
 D RESET^XVEMGE1 ;Adj scroll array
 Q
