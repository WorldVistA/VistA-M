DDBRWB ;SFISC/DCL-VA FILEMAN BROWSER PROTOCOLS ;NOV 04, 1996@13:56
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
STPB ; Save To Paste Buffer
 I DDBSA=$NA(^TMP("DDWB",$J)) D  G PS^DDBR2
 .N X
 .S X(1)="",X(2)=$$CTXT^DDBR("<< Copy to Paste Buffer RESTRICTED When Viewing Buffer >>","",IOM)
 .W $$WS^DDBR1(.X),$C(7)
 .R X:5
 .Q
 I $E(DDBSA,1,11)="^DI(.84,920" D  G PS^DDBR2
 .N X
 .S X(1)="",X(2)=$$CTXT^DDBR("<<  RESTRICTED Must Exit HELP to Copy to Paste Buffer  >>","",IOM)
 .W $$WS^DDBR1(.X),$C(7)
 .R X:5
 .Q
 N X,XF,XT
GTR S X(1)=$G(X(1)),X(2)="Copy Text Line(s) to Paste Buffer >"
 W $$WS(.X)
 D  G:X=""!(X=U) OUT
 .D EN^DIR0($P(DDBSY,";",3)-1,$L($G(X(2)))+2,30,1,"",100,1,"","KPW",.X)
 .K DIR0
 .Q
 I $E(X)="?" S X(1)="* Enter line or range, separated by "":"", of lines *" G GTR
 I 'X&($E(X)'="*") G OUT
 I $E(X)="*" S X=$TR(X,"a","A"),XF=1,XT=DDBTL
 E  S X=$TR(X,"a-/;|* ","A:::::"),XF=+X,XT=+$P(X,":",2)
 I XF<1!(XF>DDBTL) S X(1)="Must be a valid line or range of lines, from 1 to "_DDBTL G GTR
 I XT,XT<1!(XT>DDBTL) S X(1)="Must be a valid line or range of lines, from 1 to "_DDBTL G GTR
 I XT>0,XT<XF S X(1)="To value must be greater than from value" G GTR
 D SAVE(XF,$S(XT'>0:XF,1:XT),X["A")
 K X
 S X(2)="Text Copied to Buffer"
 W $$WS(.X)
 R X:3
 G OUT
 ;
SAVE(FR,TO,APN) ; Save From To (lines) APN=append to end of current list
 K:'APN ^TMP("DDWB",$J)
 N I,II
 S II=$O(^TMP("DDWB",$J,""),-1)+1
 I DDBZN D  Q
 .F I=FR:1:TO S ^TMP("DDWB",$J,II)=@DDBSA@(I,0),II=II+1
 .Q
 F I=FR:1:TO S ^TMP("DDWB",$J,II)=@DDBSA@(I),II=II+1
 Q
VIEW I DDBSA=$NA(^TMP("DDWB",$J)) S DDBL=0 D SDLR^DDBR0(1),RLPIR^DDBR0 Q
 I $E(DDBSA,1,11)="^DI(.84,920" D  G PS^DDBR2
 .N X
 .S X(1)="",X(2)=$$CTXT^DDBR("<< RESTRICTED Must Exit HELP To View Buffer >>","",IOM)
 .W $$WS^DDBR1(.X),$C(7)
 .R X:5
 .Q
 N DDBHA,DDBHAT S DDBHA=$NA(^TMP("DDWB",$J)),DDBHAT=0
 I $D(^TMP("DDWB",$J))'>9 S ^TMP("DDWB",$J,1)="<  No Text  >",DDBHAT=1
 D BROWSE^DDBR(DDBHA,"PNH","View Paste Buffer",$G(DDBHELPS),"",IOTM-1,IOBM+1)
 K:DDBHAT ^TMP("DDWB",$J)
 W @IOSTBM
 D PSR^DDBR0(1)
 Q
 ;
SWITCH ; Switching Restricted while in View
 N X
 S X(1)="",X(2)=$$CTXT^DDBR("<< RESTRICTED Must Exit View Buffer to SWITCH >>","",IOM)
 W $$WS^DDBR1(.X),$C(7)
 R X:5
 G PS^DDBR2
 ;
OUT D PSR^DDBR0()
 Q
 ;
WS(X) S DX=0,DY=$P(DDBSY,";",3)-3 X IOXY
 W $P(DDGLGRA,DDGLDEL)
 W $TR($J("",IOM)," ",$P(DDGLGRA,DDGLDEL,3))
 W $P(DDGLGRA,DDGLDEL,2)
 W !,$P(DDGLCLR,DDGLDEL),$G(X(1))
 W !,$P(DDGLCLR,DDGLDEL),$G(X(2))
 W !,$P(DDGLCLR,DDGLDEL),$G(X(3))
 S DY=$P(DDBSY,";",3),DX=$L($G(X(2)))+2 X IOXY
 Q ""
