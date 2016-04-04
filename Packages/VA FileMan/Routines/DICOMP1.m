DICOMP1 ;SFISC/GFT-EVALUATE COMPUTED FLD EXPR ;2014-12-27  1:37 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6,44,76,152,1045,1048**
 ;
 F  Q:'$D(DPS(DPS,"ST"))  D DPS^DICOMPW S K=K+1,K(K)=X ;MAY NEED TO UNSTACK
 G 0:DPS
INIT S T=99,DLV0=0,X="",K=1 D ST ;ST will build code to get top=level values
NN I $D(K(K,1)) S DLV0=K(K,1) K K(K,1) D ST ;'1' flags a change in levels
 I $D(K(K,9)) F %=1:1:K K DATE(%)
 G S:$D(K(K))[0,K1:K(K)=""
 I " "[$E(K(K)) D
 .Q:X=""
 .I K(K)?1" S ".E D  Q
AS ..D EX I $L(K(K))+$L(X)>160 D M Q
 ..S K(K)=$E(K(K),4,999),X=X_","
 .D EX:W,M:$L(X)+$L(K(K))>180
 E  I 'W D M:$L(X)+$L(K(K))>165 S X=X_" S X=",W=6
 D:K(K)?1P
P .I "\/"[K(K),$G(K(K+1))'?.NP S K=K+1,K(K)=",X=$S("_K(K)_":X"_K(K-1)_K(K)_",1:""*******"")"
 .I $L(X)>150,$F(DPUNC,K(K))>3 D M,SX
 G A:'$D(DATE(K))
DATE ;FIRST WE HANDLE CONCATENATION OF SOMETHING TO DATE
 I $G(K(K-1))="_",X?.E1"_" S X=$E(X,1,$L(X)-1) D EXTRASB S Y=$$DGI^DICOMP,X=X_" S "_Y_"=X,X="_K(K)_" S Y=X X ^DD(""DD"") S X="_Y_"_Y",K(K)="" K DATE(K) G A
 S Y=1 I $G(K(K-1))="+" S X=X_"0,X2=X,X1="_K(K) G DTC ;we're going to add the number 'X' to the date
2 G A:$D(K(K+2))[0
 K DATE(K)
 I $D(DATE(K+2))[0,$F("+-",K(K+1))>1 S X=X_K(K)_",X1=X,X2="_K(K+1)_K(K+2),DATE(K+2)=1 ;Date + or - a non-date
 E  G A:K(K+1)'="-" K DATE(K+2) S X=X_K(K)_",X1=X,X2="_K(K+2),Y=0 ;we're going to subtract a date from another date
 S K=K+2
DTC S K=K+1,X=X_",X="""" D"_$P(":X2 ^ C",U,Y+1)_"^%DTC:X1"
 G S:'$D(K(K)) D SX G NN:'Y S K=K-1,K(K)="" G 2
 ;
A S W='$D(K(K,2)),X=X_K(K)
K1 S K=K+1 G NN:$D(K(K))#2
S S I="" F  S I=$O(M(I)),W=0 Q:I=""  D M:$L(X)>235 S K=$O(M(I,"")),X=X_" S D"_I_"="_$S(DA:DQI_(K+80),1:"I("_K_",0")_")"
 S I=-1 D SS S:X?.E1" S X=X" X=$E(X,1,$L(X)-6) I X'?1"S X="1N.NP!(DICOMP["Z") G Q
0 ;NO GOT!  Come here when parsing fails
 K X,DIM,DATE I DUZ(0)="@",DICOMP'["X" D  ;If user is a programmer, and "X" does not prohibit it, try his input as pure MUMPS
 .Q:DICO'[" "
 .S DIM=1 I $L(DICO," ")=2 F Y="OPEN","CLOSE","BREAK","USE" D  I '$D(DIM) Q
 ..I $E(Y)=$P(DICO," ")!(Y=$P(DICO," ")) K DIM
 .I $D(DIM) S X=DICO D ^DIM
 S DICOMP="",DLV=DICO(1)
Q I DICOMP'["S" S K=DICO(1) F  S K=$O(I(K)) Q:K=""  K I(K),J(K)
 I $D(X) S:$D(DICO("DIERR")) X="N DIERR "_X I $G(DICOMPQI),DICOMP'["Z" S X="N Y "_X ;NEW Y ONLY IF WE ARE NOT IN THE MIDDLE OF RECURSION FROM RCR^DICOMPZ
Y K Y I $D(DICO("RCR")) S Y=DICO("RCR")
 E  S Y=DLV_$E("W",$D(DPS("W")))_$S($G(DBOOL)=1:"B",$D(DATE)>9:"D",1:"")_$E("X",$D(DIM))_$E("L",$D(DICO(2)))
 S Y=Y_DIMW
 I $D(DICO("PT")) S Y=Y_"p"_DICO("PT")
 K K,DLV,DICOMP,DICMX Q
 ;
ST S W=0,DG="" F  S DG=$O(DG(DLV0,DG)),Y=$P(DG,U,2) Q:DG=""  D
 .I Y]"" S:+Y'=Y Y=""""_Y_"""" S I=DQI_DG(DLV0,DG)_")=$S($D(^(" D:T-DG!(DG<DLV0)  S I=I_Y_")):^("_Y_"),1:"""")" G VP
 ..N T,QI,%
X ..S I=$P(I,U),%=DG\100*100
 ..F T=0:1:DG#100 S QI=I(%) S I=I_QI_$E(",",1,T)_$S(DICOMP["T"&(DG<DICO(0)):"I("_%_",0)",1:"D"_T)_",",%=%+1
 ..K DG(DLV0,DG)
 ..;do not change above code to use "$G" until you change E2+4^DIP0 !
C .F  S %=$O(DG(DLV0,DG,0)) Q:'%  D  K DG(DLV0,DG,%) ;for Computed Fields
 ..S I=" X ""N I,Y ""_$P(^DD("_J(DG)_","_%_",0),U,5,99)"
 ..I DICOMP["T",DG<DICO(0) D
 ...N W,SV S SV=X,X="N D0 S D0=I("_DG_",0)"_I D EXTRASB S I=X,X=SV
 ..S I=I_" S "_DQI_DG(DLV0,DG,%)_")=X"
 ..D EX:W,M:$L(X)+$L(I)>180 S X=X_I
 .Q:$D(DG(DLV0,DG))[0
 .S I=DG(DLV0,DG) I I?.N S I=$S(DA:DQI_(DLV0+I+80),1:"I("_(DLV0+I)_",0")_")=$G(D"_I_")"
 .E  S I=DQI_+DG_")="_I
 .K DG(DLV0,DG) G OV:DG?.N1A
VP .I $G(DICV)["V" S I=I_"_$C(59)_"""_$E(I(0),2,99)_""""
OV .I $L(I)+$L(X)>180 D M
 .S:'W X=X_" S " S X=X_I_",",W=2
 D EX S W=0 Q
 ;
M D SS,EX
EXTRASB D DIMP^DICOMPZ(X) S W=0 Q
 ;
SS Q:$A(X)-32  S X=$E(X,2,999) G SS
 ;
EX S X=$E(X,1,$L(X)-W+1) Q
 ;
SX S X=X_" S X=X",W=1
 Q
