DIVR1 ;SFISC/DCM-VERIFY FIELDS API ;9:16 AM  1 Jul 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**7**
 ;
EN ;
 I '$D(DIVRREC) S DIVRREC=""
 N %ZIS,POP,ZTRTN,ZTSAVE,SUB
 S %ZIS="Q" D ^%ZIS  Q:POP
 I $D(IO("Q")) S ZTRTN="DQ^DIVR1",(ZTSAVE("DIVRFILE"),ZTSAVE("DIVRDR"),ZTSAVE("DIVROUT"))="" S SUB="DIVRREC"_$S($D(DIVRREC)=10:"(",1:"") S ZTSAVE(SUB)="" D ^%ZTLOAD Q
DQ N PG,TAB,REC,Y,DATE,I,J,K,DIVRFI0,DIVRFINM,DIVRFIIN,DA,V,DIRUT,R,DE,DIUTIL
 K ^TMP("DIVR1",$J),^TMP("DIERR",$J)
 I $D(ZTQUEUED) S ZTREQ="@"
 S PG=0,TAB=0,REC=0,DIUTIL="VERIFY FIELDS" U IO
 S Y=DT D DD^%DT S DATE=Y
 D DIVRFILE Q:$G(DIERR)
 D DIVRREC
 I '$D(^TMP("DIVR1",$J)),'$G(DIERR) W !!!,?20,"*** NO ERRORS FOUND ***" D Q
 D DIVROUT^DIV,Q
 Q
DIVRFILE S (DIVRFILE,DIVRFIIN)=+DIVRFILE
 Q:'$$VFILE^DILFD(DIVRFILE,"D")
 S DIVRFI0=$$FNO^DILIBF(DIVRFILE),DIVRFINM=$$GET1^DID(DIVRFI0,"","","NAME")
 Q
DIVRREC S R=$D(DIVRREC)
 I $D(DIVRREC)#2,(DIVRREC=""!(DIVRREC="ALL")) S R=0 D IJ^DIVU(DIVRFIIN),H1,DIVRDR Q
 I $D(DIVRREC)#2,$E(DIVRREC)="[" D  Q
 . N Y,D0,DS D DIBT^DIVU(DIVRREC,.Y,DIVRFI0) Q:Y'>0
 . S D0=0 D H2,IJ^DIVU(DIVRFI0) F  S D0=$O(^DIBT(+Y,1,D0)) Q:D0'>0  S DE="",DS=1 D:$$VENTRY^DIEFU(DIVRFI0,+D0,"D") DIVRDR Q:$D(DIRUT)
 I $D(DIVRREC)=10 D  Q
 . N I S I="" D H2,IJ^DIVU(DIVRFIIN)
 . F  S I=$O(DIVRREC(I)) Q:I'>0  S DIVRREC=I D ONE
 D H2,IJ^DIVU(DIVRFIIN)
ONE Q:'$$IENCHK^DIT3(DIVRFIIN,DIVRREC)
 Q:'$$VENTRY^DIEFU(DIVRFIIN,DIVRREC,"D")
 N %,DEPTH,D,DS
 S DEPTH=$L(DIVRREC,",")-1
 F %=1:1:DEPTH S D="D"_(DEPTH-%) N @D S @D=$P(DIVRREC,",",%)
 S DS=DEPTH D DIVRDR
 Q
DIVRDR N FLD,PC,Z,END,OUT,F,Y,Q,S
 S F=1,FLD=0,Q="""",S=";"
 S:$G(DIVRDR)="" DIVRDR="ALL"
 I DIVRDR="ALL" D  Q
 . F  S FLD=$O(^DD(DIVRFILE,FLD)) Q:FLD'>0  D SET Q:$D(DIRUT)
 F  S Z=$G(Z)+1 S PC=$P(DIVRDR,S,Z) Q:PC=""  D  Q:$D(DIRUT)
 . N Z
 . I PC[":" S FLD=$O(^DD(DIVRFILE,+PC),-1),END=+$P(PC,":",2) D  Q
 . . F  S FLD=$O(^DD(DIVRFILE,FLD)) Q:FLD'>0!(FLD>END)  D SET Q:$D(DIRUT)
 . S FLD=PC I $$VFIELD^DILFD(DIVRFILE,PC,"D") D SET  Q
 Q
SET N TYP,IT,T,W,PC3,M,Y,KEY
 S Y=FLD,Y(0)=^DD(DIVRFILE,FLD,0),TYP=$P(Y(0),U,2),IT=$P(Y(0),U,5,99),PC3=$P(Y(0),U,3)
 F T="N","D","P","S","V","F" Q:TYP[T
 F W="FREE TEXT","SET OF CODES","DATE","NUMERIC","POINTER","VARIABLE POINTER","K" I T[$E(W) S:W="K" W="MUMPS" Q
 I TYP["C" Q
 I TYP,$P(^DD(+TYP,.01,0),U,2)["W" Q
 I TYP D MULT Q
 I 'R D:$Y>(IOSL-4) FF Q:$D(DIRUT)  W !!?TAB,$P(^DD(DIVRFILE,FLD,0),U)_" (#"_FLD_")",?40,W
 I TYP["*",TYP'["X" S IT="Q" I $D(^DD(DIVRFILE,FLD,12.1)) X ^(12.1) I $D(DIC("S")) S IT(1)=DIC("S"),IT="X IT(1) E  K X"
 S KEY=$D(^DD("KEY","F",DIVRFILE,FLD))>9
 D XDE
 Q
XDE I F D
 .I R,DIVRFILE=DIVRFIIN S DE="D DA^DIVU(.DA) X DE(99) G Q:$G(DIRUT)" Q
 .D DE^DIVU(DIVRFILE,"","","DE",$G(DS)_U_$G(DS)) S F=0,DE=DE_" D DA^DIVU(.DA) X DE(99) G Q:$G(DIRUT)" Q
 D DE99(DIVRFILE,FLD)
 X DE
 Q
MULT D:$Y>(IOSL-4) FF Q:$D(DIRUT)
 W:'R !!?TAB,$P(^DD(DIVRFILE,FLD,0),U)_"(#"_FLD_") --multiple--"
 N DIVRFILE,FLD,DA,V,I,J,K,F,DE
 S DIVRFILE=+TYP,FLD=0,TAB=TAB+2,F=1 D IJ^DIVU(DIVRFILE)
 F  S FLD=$O(^DD(DIVRFILE,FLD)) Q:FLD'>0  D SET Q:$D(DIRUT)
 S TAB=TAB-2 K @("D"_V)
 Q
R I X?." " Q:TYP'["R"&'KEY  D  Q
 . I X="" S M="Missing"_$S(KEY:" key value",1:"")
 . E  S M="Equals only 1 or more spaces"
 . D X
 D @T Q
P I @("$D(^"_PC3_"X,0))") D F Q
 S M="No '"_X_"' in pointed-to File" D X Q
V I $P(X,S,2)'?1A.AN1"(".ANP,$P(X,S,2)'?1"%".AN1"(".ANP S M=Q_X_Q_" has the wrong format" D X Q
 S M=$S($D(@(U_$P(X,S,2)_"0)")):^(0),1:"")
 I '$D(^DD(DIVRFILE,FLD,"V","B",+$P(M,U,2))) S M=$P(M,U)_" FILE not in the DD" D X Q
 I '$D(@(U_$P(X,S,2)_+X_",0)")) S M=U_$P(X,S,2)_+X_",0) does not exist" D X Q
 D F Q
S S Y=X I TYP'["X" X IT I '$D(X) S M=Q_Y_Q_" fails screen" D X Q
 Q:S_PC3[(S_X_":")  S M=Q_X_Q_" not in Set" D X Q
D N Y,%DT S Y=$F(IT,"%DT=""E") S:Y IT=$E(IT,1,Y-2)_$E(IT,Y,999)
 I TYP["X" X $P(IT," D ^%DT") D ^%DT I Y<0 S M="Invalid date" D X Q
 D F Q
N I TYP["X",X'?.1"-".N.".".N S M="Invalid number" D X Q
 D F Q
K D ^DIM I '$D(X) S M="Invalid M code" D X
 Q
F N Y S Y=X I X'?.ANP S M="Non-printing character" D X
IT Q:TYP["X"  D  Q:$D(X)  S M=Q_Y_Q_" fails Input Transform"
 .N %Y S %Y=Y X IT S Y=%Y
 ;
X S X=$S(V:DA(V),1:DA),^TMP("DIVR1",$J,$S('R:X,$G(DIVRREC)["[":X,(R&($G(DIVROUT)["[")):X,1:DIVRREC))="",X=V,Z=0
 I @(I(0)_"0)")
IEN D FF:$Y>(IOSL-3) Q:$D(DIRUT)
 I 'R D  Q
 .F  Q:'X  W !?5,@("D"_Z),?15,$P(^(@("D"_Z),0),U) S X=X-1,Z=Z+1,@("Y=$D(^("_I(V-X)_",0))")
 .W !?5,@("D"_Z),?15,$S($D(^(@("D"_Z),0)):$P(^(0),U),1:@("D"_Z)),?50,$E(M,1,40) W:V !
 I R D  Q
 .F  Q:'X  W !,@("D"_Z),?10,$P(^(@("D"_Z),0),U) W:Z " (",K(Z),")" S X=X-1,Z=Z+1,@("Y=$D(^("_I(V-X)_",0))")
 .W !,@("D"_Z),?10,$S($D(^(@("D"_Z),0)):$P(^(0),U),1:@("D"_Z)) W:Z " (",K(Z),")" W !?5,$P(^DD(DIVRFILE,FLD,0),U)," (#",FLD,")",?35,W,?50,M W:V !
 Q
 ;
DE99(FI,FD,NP) ;
 N Y
 D GET^DIOU(FI,FD,"X",.Y,"I")
 S DE(99)=Y_" D R " Q
 Q
Q D ^%ZISC
 Q
FF I IOST["C-" N DIR,X,Y S DIR(0)="E" D ^DIR Q:$D(DIRUT)
 I R D H2 Q
H1 W:$Y @IOF W "Verify Fields     File: ",DIVRFI0_" "_DIVRFINM,?(IOM-25) W DATE W ?(IOM-9),"PAGE ",PG+1
 W !,"Field Name (Field #)",?40,"Type"
 W !?5,"Entry #",?15,"Name",?50,"ERROR"
 N L W ! F L=1:1:(IOM-2) W "-"
 S PG=PG+1
 Q
H2 W:$Y @IOF W "Verify Fields     File: ",DIVRFI0_" "_DIVRFINM,?(IOM-25) W DATE W ?(IOM-9),"PAGE ",PG+1
 W !,"Entry #",?10,"Name"
 W !?5,"Field Name (Field #)",?35,"Type",?50,"ERROR"
 N L W ! F L=1:1:(IOM-2) W "-"
 S PG=PG+1
 Q
