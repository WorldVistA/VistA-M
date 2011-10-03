DIWE5 ;SFISC/GFT-WP, AUX FUNCTIONS ;10/28/96  14:54
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
LNQ ;
 W !,"ANSWER WITH A LINE NUMBER ("_(I'=6)_$P("-"_DWLC,U,DWLC>1)_")"
 I $D(DWL) W !?9,"OR A SPACE TO MEAN THE CURRENT LINE ("_DWL_")" W:DWL>2 !?9,"OR '-' TO MEAN LINE ",DWL-1,", '-2' TO MEAN ",DWL-2,", ",$P("'+' TO MEAN "_(DWL+1)_", ",U,DWL<DWLC)_"ETC."
 W ! Q
 ;
WL W !,"INITIALS:",! S X=$P(DIC,"(",1) Q:$D(@X)<9  S X=$O(@(X_"(0)"))-1,I=0 F  S X=$O(^(X)) Q:X=""  W X,!
 S X=-1 Q
NL W !,"TEXT NAMES:",! S %T2="",I=0 F  S %T2=$O(@(DW_")")) Q:%T2=""  W %T2,?20,^(%T2,0),!
 K %T2 Q
 ;
F ;
 W !!,"Line WIDTH: "_DWLW_"//" R X:DTIME S DWLW=$S(X<10:DWLW,X>255:DWLW,1:X\1)
 W !,"PACK "_$S(DWPK:"ON",1:"OFF")_"//" R X:DTIME S DWPK=$S(X="ON":1,1:0)
 Q
X D ASK^DIWE11 Q:X=""  S DIWL=X,(%,%B)="" X ^%ZOSF("EOFF")
ENT I '$D(DIWL) S DIWL=245
A R X#245:30 E  I '$L(X) D S:$L(%B) G XQ^DIWE11
 S:X="" X=" " I X?.ANP S Y=X G D
 S I=0,Y=""
C S I=I+1 I $E(X,I,999)?.ANP S Y=Y_$E(X,I,999) G D
 S %=$E(X,I),%0=$A(%)
 I %?1C S %="" I %0=9 S %=$E("         ",1,9-($L(Y)-($L(Y)\9*9)))
 S Y=Y_% D S:$L(Y)>DIWL I ":27:13:"[(":"_%0_":") D S
 G C
D D S G D:$L(Y)'<DIWL S %B=Y,Y="" G A
S S:$L(%B) %B=%B_$S($E(Y)=" ":"",1:" ") S %=%B_Y,%2=$L(%) Q:'%2  S Y=""
 I %2>DIWL F %1=DIWL:-1 I %1<$S(DIWL-12>0:DIWL-12,1:4)!(" -"[$E(%,%1)) S Y=$E(%,%1+1+$S($E(%,%1+1)=" ":1,1:0),999),%=$E(%,1,%1-$S($E(%,%1)=" ":1,1:0)) Q
 S %B="",DWLC=DWLC+1,@(DIC_"DWLC,0)")=%
 Q
TQ ;
 W !?4,"IF YOU WANT TO USE TEXT FROM THE '"_J_"' FIELD",!?4,"OF ANOTHER '"
 W I,"' ENTRY, TYPE THE NAME OF THAT ENTRY",!?4,"OTHERWISE, "
 W "USE A COMPUTED-FIELD EXPRESSION TO DESIGNATE SOME W-P TEXT",!
 G Z^DIWE3
 ;
IQ ;
 I $D(DC) W:$D(^DD(+$P(DC,U,2),.01,3)) !?4,^(3),! X:$D(^(4)) ^(4) F %=0:0 S %=$O(^DD(+$P(DC,U,2),.01,21,%)) Q:%'>0  W !,^(%,0)
 W !!,"You are ready to enter a line of text.",!,"If you have no text to enter,just ",$S(DIWPT="":"press the return key.",1:"type in """_DIWPT_"""."),!
 W "Type 'CONTROL-I' (or TAB key) to insert tabs.",!
 W "When text is output, these formatting rules will apply:"
 W !," A)  Lines containing only punctuation characters, or lines containing tabs",!?5,"will stand by themselves, i.e., no wrap-around."
 W !," B)  Lines beginning with spaces will start on a new line."
 W !," C)  Expressions between '|' characters will be evaluated as"
 W !?5,"'computed-field expressions and then be printed as evaluated"
 W !?5,"thus '|NAME|' would cause the current name to be inserted in the text."
 W !!,$C(7),"Want to see a list of allowable formatting 'WINDOWS'" S %=2 D YN^DICN Q:%-1
 W !?5,"SPECIAL FORMATTING INCLUDES: "
FN S %=15 F  S %=$O(^DD("FUNC",%)) Q:%>97  I $D(^(%,10)) W !," |"_$P(^(0),U,1)_$P("(ARGUMENT)",U,$S('$D(^(3)):1,1:^(3)'=0))_"|",?25 W:$D(^(9)) ^(9)
