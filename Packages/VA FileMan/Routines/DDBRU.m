DDBRU ;SFISC/DCL-BROWSER UTILITIES AND EXTRINSIC FUNCTIONS ; 19JAN2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1045**
 ;
CTRLCH() ;Extrinsic function - returns control characters 1-31
 N I,X S X="" N I F I=1:1:31 S X=X_$C(I)
 Q X
 ;
COL(DDBC) ;Set up colums used by Fileman Print Set DIOEND="D COL^DDBRU()" when calling Browser
 N H,I,P,Q,T,X
 S DDBC=$G(DDBC,"^TMP(""DDBC"",$J)")
 I $D(^TMP("DDBC",$J)) K ^($J)
 S X=0 F  S X=$O(^UTILITY($J,99,X)) Q:X'>0  S T=^(X) D
 .S:T["D ^" H=$P(T,"^",2)
 .S Q=$L(T,"?") I Q>1 F I=1:1:Q S P=+$P(T,"?",I)+1 S @DDBC@(P)=""
 .Q
 I $G(H)]""  F X=1:1 S T=$T(@"HEAD"+X^@H) Q:T=""  D
 .S Q=$L(T,"?") I Q>1 F I=1:1:Q S P=+$P(T,"?",I)+1 S @DDBC@(P)=""
 .Q
 Q
 ;
KTMP K ^TMP("DDB",$J),^TMP("DDBC",$J)
 K ^TMP("DDBLST",$J)
 Q
 ;
TRMERR(DDGLCH) ;Terminal type errors
 N P
 S P(1)=DDGLCH,P(2)=IOST
 D BLD^DIALOG(842,.P)
 Q
 ;
RTN(RTN,TMPGBL) ;
 N I,F,X
 F I=1:1 S X=$T(+I^@RTN) Q:X=""  S F=$F(X," ")-1,$E(X,F)=$E("        ",1,$S(F'>8:8-F,1:1)),@TMPGBL@(I)=$TR(X,$C(9)," ")
 Q
 ;
RTNTB(DDBRTOP,DDBRBOT) ;PASS TOP AND BOTTOM MARGINS
 G DR
 ;
ENDR N DDBENDR S DDBENDR=1
 ;
DR ;Display Routine(s)
 D:'$D(DISYS) OS^DII
 N DESC,RN,RSA,RTN,X,Y
 K ^TMP($J,"DDBDR"),^TMP($J,"DDBDRL"),^UTILITY($J)  ;DR LIST
 X ^DD("OS",DISYS,"RSEL") Q:$O(^UTILITY($J,""))']""
 S RTN=" ",RN=1 F  S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""  D  ; VEN/SMH - Make starting point " " for RTN so it won't crash on Cache
 .S DESC=$P($P($T(+1^@RTN),";",2),"-",2),DESC=$S($L(DESC)>45:$E(DESC,1,45)_"...",1:DESC)
 .S RSA=$NA(^TMP($J,"DDBDR",RN)),RN=RN+1,^TMP($J,"DDBDRL",RTN_$E("        ",1,8-$L(RTN))_": "_DESC)=RSA
 .W !,"...loading ",RTN
 .D RTN^DDBRU(RTN,RSA)
 .Q
 W !,"...building ""Current List"" tables"
 D DOCLIST^DDBR("^TMP($J,""DDBDRL"")","",$G(DDBRTOP),$G(DDBRBOT))
K K ^TMP($J,"DDBDRL"),^TMP($J,"DDBDR"),^UTILITY($J)
 Q
 ;
OUT ;
 D:'$D(DDS) KILL^DDGLIB0($G(DDBFLG))
 D:$G(DDBFLG)'["P" KTMP
 Q
 ;
RE(DDBRTN) G EDIT
RTNEDIT N DDBRTN
EDIT ;ROUTINE EDIT VIA VA FILEMAN SCREEN EDITOR
 ;EITHER PASS ROUTINE NAME RE^DDBRU("ROUTINE_NAME") OR USE
 ;RTNEDIT^DDBRU AND BE PROMPTED FOR ROUTINE NAME
 I '$D(^DD("OS",^DD("OS"),"ZS")) W !,"ROUTINE SAVE NODE NOT DEFINED IN MUMPS OPERATING SYSTEM FILE",! Q
 N DDBRI,DDBRX,X,Y,%,%X,%Y
 I $G(DDBRTN)]"" S X=DDBRTN X ^DD("OS",^DD("OS"),18) I '$T W !,DDBRTN," Invalid",!
 X ^DD("OS",^DD("OS"),"EON")
 R:$G(DDBRTN)="" !,"Enter Routine> ",DDBRTN:DTIME
 I DDBRTN="" W !,"NO ROUTINE SELECTED",! Q
 S X=DDBRTN X ^DD("OS",^DD("OS"),18)
 I '$T W !,"NO SUCH ROUTINE",! Q
 K ^TMP("DDBRTN",$J)
 W !,"Loading ",DDBRTN
 F DDBRI=1:1 S DDBRX=$T(+DDBRI^@DDBRTN) Q:DDBRX=""  S ^TMP("DDBRTN",$J,DDBRI)=$$SP(DDBRX)
 D EDIT^DDW("^TMP(""DDBRTN"",$J)","M",DDBRTN,"Routine: "_DDBRTN)
 K ^UTILITY($J,0)
 S DDBRI=0,$P(^TMP("DDBRTN",$J,1),";",3)=$$NOW
 F  S DDBRI=$O(^TMP("DDBRTN",$J,DDBRI)) Q:DDBRI'>0  S ^UTILITY($J,0,DDBRI)=$$TAB(^(DDBRI))
 S X=DDBRTN
 X ^DD("OS",^DD("OS"),"ZS")
 K ^TMP("DDBRTN",$J),^UTILITY($J,0)
 X ^DD("OS",^DD("OS"),"EON")
 Q
TAB(X) ;CONVERT 1ST SPACE TO TAB IF NO TAB
 N E,L,T
 S X=$G(X)
 Q:X="" ""
 S T=$C(9)
 Q:$E(X)=T X
 S L=$L(X)
 F E=1:1:L Q:$E(X,E)=T  I $E(X,E)=" " S $E(X,E)=T D  Q
 .S E=E+1
 .F  Q:$E(X,E)'=" "  S $E(X,E)=""
 .Q
 Q X
 ;
SP(X) ;MAKE SURE A TAB OR 1ST SPACE IS SET TO SPACES
 N E,L,S,SPS,T
 S X=$G(X)
 Q:X="" ""
 S S=8,$P(SPS," ",S)=" ",T=$E(9)
 I $E(X)=T S $E(X)=" "  ;Q "       "_X
 S L=$L(X)
 F E=1:1:L I $E(X,E)=" " D  S $E(X,E)=$E(SPS,1,S-(E#S)) Q
 .S E=E+1
 .F  Q:$E(X,E)'=" "  S $E(X,E)=""
 .S E=E-1
 .Q
 Q X
 ;
NOW() ;
 N %DT,X,Y
 S %DT="T",X="NOW"
 D ^%DT
 Q $$FMTE^DILIBF(Y,"1U")
 ;
MSMCON ;MSM CONSOLE FOR 132/80 MODES
 ;OR VT TERMINALS
80 W $C(27),"[?",3,$C(108)
 S (IOM,X)=80 X ^DD("OS",^DD("OS"),"RM")
 Q
132 W $C(27),"[?",3,$C(104)
 S (IOM,X)=132 X ^DD("OS",^DD("OS"),"RM")
 Q
