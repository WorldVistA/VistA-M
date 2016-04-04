DID1 ;SFISC/XAK,JLT-STD DD LIST ;2014-12-24  12:06 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**7,76,105,152,999,1003,1004,1021,1039,1044,1046**
 ;
 S DJ(Z)=D0,DDL1=14,DDL2=32 G B
 ;
L S DJ(Z)=0
A S DJ(Z)=$O(^DD(F(Z),DJ(Z))) I DJ(Z)'>0 S:DJ(Z)="" DJ(Z)=-1 W !! S Z=Z-1 Q
B S N=^DD(F(Z),DJ(Z),0) K DDF I $D(DIGR),Z<2!(DJ(Z)-.01) X DIGR E  G ND
 D HD:$Y+$L(X)+6>IOSL Q:M=U  W !!,F(Z),",",DJ(Z)
LABEL W ?(Z+Z+12),$P(N,U),?DDL2+4," "_$P(N,U,4)
 F X=0:0 S X=$O(^DD(F(Z),DJ(Z),.008,X)) Q:'X  S W=$P($G(^(X,0)),U) I W]"",$D(^DI(.85,X,0)) S I=$P(^(0),U,2)_": " W !?(Z+Z+12-$L(I)),I,W ;**CCO/NI DISPLAY FOREIGN LABELS
 S X=$P(N,U,2)
WP I X,$D(^DD(+X,.01,0)) S W=$P(^(0),U,2) I W["W" D  S X=""
 .S X="WORD-PROCESSING #"_+X D  S X="(NOWRAP)" D:W["L"  S X="(IGNORE ""|"")" D:W["X"!(W["x")  S X="(UNEDITABLE)" D:W["I"  S X="(AUDITED)" D:$G(^("AUDIT"))]""
 ..W:$L(X)+$X+5>IOM !?18 W "   ",X
 F W="BOOLEAN","COMPUTED","FREE TEXT","SET","DATE","NUMBER","POINTER","K","VARIABLE POINTER","m","p" I X[$E(W) D VP^DIDX:$E(W)="V" S:W="K" W="MUMPS" S:W="p" W="POINTER" S:W="m" W="MULTIPLE" W ?40," "_W G ND:M=U
TYPE S W=+$P(X,"t",2) I W,$D(^DI(.81,W,0)) S W=" ("_$P(^(0),U)_" Data Type)" D W G ND:M=U
 I +X S W=" Multiple" S W=W_" #"_+X D W G ND:M=U
 I X["V" S I=0 F  S I=$O(^DD(F(Z),D0,"V",I)) Q:I'>0  S %Y=$P(^(I,0),U) I $D(^DIC(%Y,0)),$D(@(^(0,"GL")_"0)")) S ^UTILITY($J,"P",$E($P(^(0),U),1,30),0)=%Y,^(F(Z),DJ(Z))=0
 I 'X D
P .N Y,NM S:X["P" Y=U_$P(N,U,3),NM=+$P(X,"P",2) I X["C" S NM=+$P(X,"p",2) I NM S Y=$G(^DIC(NM,0,"GL"))
 .Q:'$D(Y)  N PF I Y[U,$D(@(Y_"0)")) S W=" TO "_$P(^(0),U)_" FILE (#"_NM_")",PF=$E($P(^(0),U),1,30)
 .E  S PF="UNDEFINED FILE"_$S(NM:" (#"_NM_")",1:""),W="  ***** TO AN "_PF_$S(Y[U:", STORED IN "_$$CREF^DILF(Y),1:"")_" *******",PF="}"_PF,NM="" W:($L(W)+$X)'<IOM !
 .S ^UTILITY($J,"P",PF,0)=NM,^(F(Z),DJ(Z))=0
 .D W
MP I X'["V" D RT^DIDX G:M=U ND
S I X["S" D  G ND:M=U
 .N N1,LANG
 .S N1=$P(N,U,3) F %1=1:1 S Y=$P(N1,";",%1) Q:Y=""  W ! S W="'"_$P(Y,":")_"' FOR "_$P(Y,":",2)_"; " D W Q:M=U  D
 ..F LANG=0:0 S LANG=$O(^DD(F(Z),DJ(Z),.007,LANG)) Q:'LANG  I $D(^(LANG,0)) W " (",$P(^(0),";",%1),")"
 G RD:$D(DINM) I X["C" S W=$P(N,U,5,99) W !?DDL1,"MUMPS CODE: " D W G ND:M=U G RD
 I "Q"'[$P(N,U,5) W !?DDL1,"INPUT TRANSFORM:" S W=$P(N,U,5,99) D W G ND:M=U
OT I $D(^DD(F(Z),DJ(Z),2))#2 W !?DDL1,"OUTPUT TRANSFORM:" D  D W G ND:M=U
 .I $P(^(0),U,2)'["O" S W="NOT EXECUTABLE!!  -- SPECIFIER NEEDS AN ""O""!"
 .E  S W=$S($D(^DD(F(Z),DJ(Z),2.1)):^(2.1),1:^(2))
RD D ^DID2:$O(^DD(F(Z),DJ(Z),2.99))]"" G ND:M=U I 'X S W="UNEDITABLE" W:X["I" ! D W:X["I" G N
 I $O(^DD(+X,0,"ID",""))]"" W !?DDL1,"IDENTIFIED BY:" S W="" F %=0:0 S %=$O(^DD(+X,0,"ID",%)) S:%>0 W=W_$P(^DD(+X,%,0),U)_"(#"_%_")"_$S($P(^(0),U,2)["R":"[R]",1:"")_", " I %'>0 S:W?.E1", " W=$E(W,1,$L(W)-2) D W G ND:M=U Q
 ;
 ;Print "WRITE" identifiers
 I '$D(DINM) S %=" " F  S %=$O(^DD(+X,0,"ID",%)) Q:%=""  D  Q:M=U
 . N DIDLN,DIDPG
 . S DIDLN(1)=$G(^DD(+X,0,"ID",%)) Q:DIDLN(1)?."^"
 . S DIDLN(0)=""""_%_""":    "
 . S DIDLN(0)=$J("",DDL2-DDL1-$L(DIDLN(0)))_DIDLN(0)
 . S DIDPG("H")="W """" D H^DIDH S:M=U PAGE(U)=1"
 . D WRPHI^DIKCP1(.DIDLN,IOM-1-DDL2,DDL1,DDL2-DDL1,1,.DIDPG)
 G:M=U ND
 ;
 I $D(^DD("KEY","B",+X)) D  G:M=U ND
 . N DIDPG
 . S DIDPG("H")="W """" S DC=DC+1 D ^DIDH1 S:M=U PAGE(U)=1"
 . D PRINT^DIKKP(+X,"","L"_DDL1_"C"_(DDL2-DDL1),.DIDPG)
 I $D(^DD("IX","B",+X)) D  G:M=U ND
 . N DIDPG
 . S DIDPG("H")="W """" S DC=DC+1 D ^DIDH1 S:M=U PAGE(U)=1"
 . D LIST^DIKCP(+X,"","L"_DDL1_"C"_(DDL2-DDL1),.DIDPG)
 S Z=Z+1,DDL1=DDL1+2,DDL2=DDL2+2,F(Z)=+X
 D L
N K DDN1 I X["X" S DDN1=1 W !,?DDL1,"NOTES:",?DDL2,"XXXX--CAN'T BE ALTERED EXCEPT BY PROGRAMMER" W ! G ND:M=U
 S W=0 I $O(^DD(F(Z),DJ(Z),5,W))'="",'$D(DDN1) W !?DDL1,"NOTES:"
TR S W=$O(^DD(F(Z),DJ(Z),5,W)) S:W="" W=-1 G IX:W'>0 S I=^(W,0),%=+I I '$D(^DD(%,$P(I,U,2),0))!$D(W(I)) K ^DD(F(Z),DJ(Z),5,W) G TR
 S W(I)=0 S WS=W D WR^DIDH1 W ! S W=WS K WS G TR
IX S F=0 F  G ND:M=U S F=$O(^DD(F(Z),DJ(Z),1,F)) Q:F'>0  W !?DDL1,"CROSS-REFERENCE:" D IX1
 S:F="" F=-1
 I $D(^DD("IX","F",F(Z),DJ(Z))) D  S:M=U DN=0
 . N DIDPG,DIDFLAG
 . S DIDPG("H")="W """" S DC=DC+1 D ^DIDH1 S:M=U PAGE(U)=1"
 . S DIDFLAG="L"_DDL1_"C"_(DDL2-DDL1)_"T1"
 . D PRINT^DIKCP(F(Z),DJ(Z),$E("R",$G(DIDRANGE))_"FS"_DIDFLAG_$E("N",$D(DINM)#2),.DIDPG) Q:M=U
 . D:'$G(DIDRANGE) LIST^DIKCP(F(Z),DJ(Z),"RS"_DIDFLAG,.DIDPG)
ND S X="" G:M'=U A:Z>1 Q
IX1 S W=^(F,0)_" " K DDF W ?DDL2,W,! G ND:M=U D TP:$P(W,U,3)["TRIG" I '$D(DINM) S X=0 F %=0:0 S X=$O(^DD(F(Z),DJ(Z),1,F,X)) Q:X=""  I X'="%D",X'="DT" S W=^(X) S:$L(W)<248 W=X_")= "_W K:X=3 DDF D W W ! G ND:M=U
 Q:'$D(^("%D"))
 ;
 N DIDI,DIDN,DIDZ,DIWF,DIWL,DIWR,X
 K ^UTILITY($J,"W")
 S DIWF="W",DIWL=DDL2+1,DIWR=IOM,DIDZ=Z
 S DIDN=$P($G(^DD(F(DIDZ),DJ(DIDZ),1,F,"%D",0)),U,3),DIDI=0
 F  S DIDI=$O(^DD(F(DIDZ),DJ(DIDZ),1,F,"%D",DIDI)) Q:'DIDI!(DIDN&(DIDI>DIDN))  S X=^(DIDI,0) D ^DIWP I $D(DN),'DN S M=U Q
 I M'=U D ^DIWW I $D(DN),'DN S M=U
 I M'=U W !
 E  K DIOEND
 S Z=DIDZ
 K ^UTILITY($J,"W")
 Q
 ;
TP S X=+$P(^(0),U,4) I F(Z)-X,$D(^DIC(X,0))#2 S ^UTILITY($J,"P",$E($P(^(0),U,1),1,30),0)=X,^(F(Z),DJ(Z))=6
 Q
W F K=0:0 W:$D(DDF) ! S:(($L(W)+DDL2)>IOM) DDL2=32 W ?DDL2 S %Y=$E(W,IOM-$X,999) W $E(W,1,IOM-$X-1) Q:%Y=""  S W=%Y,DDF=1
 K:'X DDF Q:$Y+6<IOSL
HD S DC=DC+1 D ^DIDH Q
