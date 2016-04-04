DIVRPTR ;GFT/GFT - CHECK POINTER FIELDS (PROGRAMMER CALL) ;28FEB2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 N DIB,DIC K DIRUT
 D DT^DICRW,L^DICRW1 Q:'$D(DIC)
 D ^%ZIS Q:POP  U IO D HDR
 F A=$O(^DD(+Y),-1):0 S A=$O(^DD(A)) Q:'A!$D(DIRUT)  D IJ^DIUTL(A) Q:J(0)>DIB(1)  F DIFLD=0:0 S DIFLD=$O(^DD(A,DIFLD)) Q:'DIFLD!$D(DIRUT)  S X=$P($G(^(DIFLD,0)),U,2) I 'X F T="P","V" I X[T D CK(A,DIFLD,T) S X=""
 D ^%ZISC Q
 ;
CK(A,DIFLD,T) ;CHECK FIELD DIFLD, DATA DICTIONARY A, TYPE T
 N W,I,J,V,DIVTMP,DG,E,DIVZ,DE,DR,P4,M
 K ^UTILITY("DIVR",$J)
 D IJ^DIUTL(A) S V=$O(J(""),-1)
 S DIVZ=$P(^DD(A,DIFLD,0),U,3),DR=$P(^(0),U,2),P4=$P(^(0),U,4)
 I T="P" S DIVZ=$$CREF^DILF(U_DIVZ) I '$D(@DIVZ@(0)) D SUBHD W !,"POINTED-TO FILE (#",+$P(DR,"P",2),") IS MISSING!!",! Q
 D 0 S X=P4,Y=$P(X,";",2),X=$P(X,";")
 I +X'=X S X=""""_X_"""" I Y="" S DE=DE_"S X=DA D "_T G XEC
 S M="S X=$S($D(^(DA,"_X_")):$"_$S(Y:"P(^("_X_"),U,"_Y,1:"E(^("_X_"),"_$E(Y,2,9))_"),1:"""") D "_T
 I $L(M)+$L(DE)>250 S DE=DE_"X DE(1)",DE(1)=M
 E  S DE=DE_M
XEC K DIC,M,Y X DE
Q S M=$O(^UTILITY("DIVR",$J,0)),E=$O(^(M)),DK=J(0)
 K ^UTILITY("DIVR",$J)
 Q
 ;
 ;
0 ;
 K DA
 S Y=I(0),DE="",X=V
L S DA="DA" S:X DA=DA_"("_X_")" S Y=Y_DA,DE=DE_"F "_DA_"=0:0 Q:$D(DIRUT)  ",%="S "_DA_"=$O("_Y_"))" I V>2 S DE(X+X)=%,DE=DE_"X DE("_(X+X)_")"
 E  S DE=DE_%
 S DE=DE_" Q:"_DA_"'>0  S D"_(V-X)_"="_DA_" "
 S X=X-1 Q:X<0  S Y=Y_","_I(V-X)_"," G L
 ;
 ;
 ;
 ;
V ;VARIABLE POINTER
 Q:'X  I $P(X,";",2)'?1A.AN1"(".ANP,$P(X,";",2)'?1"%".AN1"(".ANP S M=""""_X_""""_" has the wrong format" G X
 S M=$S($D(@(U_$P(X,";",2)_"0)")):^(0),1:"")
 I '$D(^DD(A,DIFLD,"V","B",+$P(M,U,2))) S M=$P(M,U)_" FILE not in the DD" G X
 I '$D(@(U_$P(X,";",2)_+X_",0)")) S M=U_$P(X,";",2)_+X_",0) does not exist" G X
 Q
 ;
P ;REGULAR POINTER
 Q:'X  I $D(@DIVZ@(X,0)) Q
 S M="No '"_X_"' in "_$P(@DIVZ@(0),U)_" File"
X I $O(^UTILITY("DIVR",$J,0))="" D SUBHD
 S ^UTILITY("DIVR",$J,X)="",M=">>"_M_"<<"
 S DG=$$IENS^DILF(.DA),J=V
 F J=V:-1:0 W !,?V-J*2,$O(^DD(J(V-J),0,"NM",0)),": `",+$P(DG,",",J+1),?V-J*2+10,"  " S W="E" D  I W="" S W="I" D  ;TRY EXTERNAL FORM FIRST, THEN INTERNAL
 .S W=$$GET1^DIQ(J(V-J),$P(DG,",",J+1,99),.01,W) W W
 W "  " W:$X+$L(M)>IOM !?30 W M
 D LF Q
 ;
 ;
LF ;Issue a line feed or EOP read
 I $Y+3<IOSL W ! Q
 I IOST?1"C-".E D
 . N DIR,X,Y
 . S DIR(0)="E" W ! D ^DIR
 I '$D(DIRUT) D HDR,SUBHD W "continued",!
 Q
 ;
HDR ;Print header
 W @IOF,"DANGLING POINTER REPORT",!
 Q
 ;
SUBHD N I,Y W !!!,"FILE ",J(0),"  '",$$LABEL^DIALOGZ(A,DIFLD),"' ("
 S Y=" File #"_J(0)
 F I=1:1 Q:'$D(J(I))  S Y=" Sub-File #"_J(I)_" of"_Y
 S Y="Field #"_DIFLD_" in"_Y
 I $P($G(^DD(A,DIFLD,0)),U,2) S Y="Multiple "_Y
 W Y,")"
 Q
