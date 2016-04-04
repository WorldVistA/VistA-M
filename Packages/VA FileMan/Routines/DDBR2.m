DDBR2 ;SFISC/DCL-VA FILEMAN BROWSER ;2JAN2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**162,999,1042**
 ;
 Q
SWITCH(DDBLST,DDBRET) ;Switch to another document in list or FileMan Database
 I $E(DDBSA,1,11)="^DI(.84,920" D EXIT^DDBR0 Q  ;!(DDBSA="^XTMP(""DDBDOC"")") Q
 I DDBSA=$NA(^TMP("DDWB",$J)) G EXIT^DDBR0:$G(DDBRET)["R",SWITCH^DDBRWB Q
 N DDBLN,DDBZ,DIC,DIR,X,Y,DIRUT,DIROUT,DUOUT,DILN
 S DILN=DDBRSA(DDBRSA,"DDBSRL")-2
 S:$G(DDBLST)="" DDBLST="^TMP(""DDBLST"",$J)" S DDBLN=$S($D(@DDBLST@("A",DDBSA)):^(DDBSA),1:$O(@DDBLST@(" "),-1)+1)
 I DDBFLG["R",'$D(@DDBLST) D SFR() G PS
 I DDBFLG["A" D SFR() G PS
 I $G(DDBRET)["R" D  G:$G(Y) PS Q
 .Q:DDBPSA'>0
 .Q:'$D(@DDBLST@("APSA",DDBPSA))  S X=^(DDBPSA) S:$D(@DDBLST@("A",X)) Y=^(X)
 .I $G(Y) S DDBPSA=DDBPSA-1 N DDBPSA D SAVEDDB(DDBLST,DDBLN),USAVEDDB(DDBLST,+Y)
 .Q
BRMC D BRM
 I $D(@DDBLST) D
 .I $O(@DDBLST@(" "),-1)=1,$G(@DDBLST@(1,"DDBSA"))=DDBSA Q
 .;W "Current list: ",!
 .S DDBZ=$G(@DDBLST@("A",DDBSA),0)
 .;S X=0 F  S X=$O(@DDBLST@(X)) Q:X'>0  W:X'=DDBZ !,$J(X,3),"  ",$E(@DDBLST@(X,0),1,75)
 .W !
 .K DIR0
CUR .I DDBFLG'["R" S DIR(0)="Y",DIR("A")=$$EZBLD^DIALOG(8142),DIR("B")="YES" D ^DIR Q:$D(DIRUT)!(Y'>0)  ;"Do you wish to select from current list"
 .S DIC=$$OREF^DIQGU(DDBLST),DIC(0)="EMQ",DIC("S")="I +Y'=DDBZ",DIC("W")="W:$E(^(0))=U ^(0)",X="??" D ^DIC  ;K DIC("S") Q:Y'>0
 .S DIC(0)="AEMQ"
 .D ^DIC K DIC("S") Q:Y'>0
 .D SAVEDDB(DDBLST,DDBLN),USAVEDDB(DDBLST,+Y)
 .S DIROUT=1
 N DDBLNA
 S:DDBFLG["R" DIROUT=1
 I '$D(DIROUT) D LIST^DDBR3(.DDBLNA)
 I $G(DDBLNA,-1)=-1 G PS
 I $G(DDBLNA(6))=DDBSA G PS  ;if current document selected again
 I $G(DDBLNA(6))]"",$D(@DDBLST@("APSA",DDBSA)) G PS  ;if already in list
NO I DDBLNA'>0 W $C(7),!!,$$EZBLD^DIALOG(1404),DDBLNA(5) H 3 ;**
 D:DDBLNA>0 SAVEDDB(DDBLST,DDBLN),WP(.DDBLNA)
PS D PSR^DDBR0(1)
 Q
 ;
WP(DDBX) ;
 S DDBSA=DDBX(6)
 S DDBPMSG=DDBX(5)
 S DDBHDR=$$CTXT^DDBR(DDBPMSG,$J("",IOM+1),IOM)
 S DDBTL=$P(@DDBSA@(0),"^",3)
 S DDBTPG=DDBTL\DDBSRL+(DDBTL#DDBSRL'<1)
 S DDBZN=1
 S DDBDM=0
 S DDBSF=1
 S DDBST=IOM
 S DDBC="^TMP(""DDBC"",""DDBC"",$J)"
 I '$D(@DDBC) F I=1,22:22:176 S @DDBC@(I)=""
 S DDBL=0
 Q
 ;
SAVEDDB(DDBLIST,IEN,NSAPSA) ;Save local varialbes into ^TMP("DDBLIST",$J,IEN)
 ;DDBS  array to save list
 ;IEN   internal entry
 ;NSAPSA Not Set "APSA" x-ref if undefined, pass 1 to not set NSAPSA (optional - default is to set "APSA")
 S NSAPSA=+$G(NSAPSA)
 N I,X
 F I="HDR","HDRC","SA","ZN","DM","PMSG","L","C","TL","SF","ST","RE","RPE" S X="DDB"_I,@DDBLIST@(IEN,X)=@X
 ;I $D(DDBFNO) S @DDBLIST@(IEN,DDBFNO)=DDBFNO  ;decided to keep it the same throughout the browse session (Next Find String)
 S @DDBLIST@(IEN,0)=DDBPMSG
 S:'$D(@DDBLIST@(0)) ^(0)="CURRENT LIST^1"
 S:'$D(@DDBLIST@("A",DDBSA)) @DDBLIST@("A",DDBSA)=IEN
 S:'$D(@DDBLIST@("B",DDBPMSG,IEN)) @DDBLIST@("B",DDBPMSG,IEN)=""
 I $G(DDBRET)["R",DDBRPE=DDBRE Q
 Q:NSAPSA
 S X=$O(@DDBLST@("APSA"," "),-1)+1
 I $G(@DDBLIST@("APSA",X-1))=DDBSA S DDBPSA=X-1 Q
 S @DDBLIST@("APSA",X)=DDBSA,DDBPSA=X
 Q
 ;
USAVEDDB(DDBLIST,IEN) ;Unsave varialbes in ^TMP("DDBLIST",$J,IEN) to locals
 ;DDBS  array to save list
 ;IEN   internal entry
 N I,X
 F I="HDR","HDRC","SA","ZN","DM","PMSG","L","C","TL","SF","ST","RE","RPE" S X="DDB"_I,@X=@DDBLIST@(IEN,X)
 S DDBTPG=DDBTL\DDBSRL+(DDBTL#DDBSRL'<1)
 ;I $D(@DDBLIST@(IEN,"DDBFNO")) S DDBFNO=@DDBLIST@(IEN,"DDBFNO")
 Q
 ;
 ;
CTXT(X,T,W) ;Center X in T which is W characters wide (usually spaces) and W for screen width
 Q:X="" $G(T)
 N HW
 S W=$G(W,79),HW=W\2
 S $E(T,HW-($L(X)\2),HW-($L(X)\2)+$L(X))=X Q T
OREF(X) N X1,X2 S X1=$P(X,"(")_"(",X2=$$OR2($P(X,"(",2)) Q:X2="" X1 Q X1_X2_","
OR2(%) Q:%=")"!(%=",") "" Q:$L(%)=1 %  S:"),"[$E(%,$L(%)) %=$E(%,1,$L(%)-1) Q %
 ;
BRM ;BROWSE MANAGER SCREEN
 N DX,DY,X
 S DX=0,DY=$P(DDBSY,";"),X=$$CTXT^DDBR("BROWSE SWITCH MANAGER",$J("",IOM+1),IOM)
 X IOXY
 W $P(DDGLVID,DDGLDEL,6)  ;rvon
 W $P(DDGLVID,DDGLDEL,4)  ;uon
 W X
 W $P(DDGLVID,DDGLDEL,10)  ;rvoff
 F DY=$P(DDBSY,";",2):1:$P(DDBSY,";",4) X IOXY W $P(DDGLCLR,DDGLDEL)
 W $P(DDGLVID,DDGLDEL,6)  ;rvon
 W $P(DDGLVID,DDGLDEL,4)  ;uon
 W X
 W $P(DDGLVID,DDGLDEL,10)  ;rvoff
 W @IOSTBM
 S DY=$P(DDBSY,";",2)
 X IOXY
 Q
 ;
SFR(Y) N X
 S X(1)="",X(2)=$$CTXT^DDBR("<< "_$$EZBLD^DIALOG($S($G(Y):7076.1,1:7076))_" >>","",IOM) ;** 'SWITCH FUNCTION RESTRICTED'
 W $$WS^DDBR1(.X),$C(7)
 R X:3
 Q
