DICOMP0 ;SFISC/GFT-EVALUATE COMPUTED FLD EXPR ;2014-12-27  1:50 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6,76,114,144,152,999,1005,1015,1022,1024,1025,1026,1048**
 ;
 N DICOMPI
SETFUNC I DPS,$D(DPS(DPS,"SET")),'$D(W(DPS)) S T="""",D=$P(X,T)_$P(X,T,2) G BAD:$L(D)+2\5-1!(D'?.UN)!(D?1"D".E)!(DUZ(0)'="@") S X=T_D_T,DICOMPX(D)=D,Y=0 Q
LIT I X?1"""".E1"""" S Y=0,%=$E(X,2,$L(X)-1) K:%[""" X "!(%[""" D @") Y S X=""""_$$CONVQQ^DILIBF(%)_"""" Q
L S T=DLV,DICN=X
TRY G M:'$D(J(T))!'$D(I(T)),M:+J(T)'=J(T),M:$G(^DD(J(T),.01,0))="",UP:$P(^(0),U,2)["W" S DIC="^DD("_J(T)_",",DG=$O(^DD(J(T),0,"NM",0))_" "
 S DIC("S")=$S(W="["!($E(I,M,M+1)="'[")!$D(DICMX):"I ",1:"S %=$P(^(0),U,2) I '%,%'[""m"",")_"$$SCREEN^DICOMP0"
 D DICS^DICOMPY:DUZ(0)'="@"
R I X?1"#"1.NP S X=$E(X,2,99) D ^DIC G:Y>0 A:DLV,X S X="#"_X ;HERE IS WHERE WE PROCESS THE NUMBER OR NAME OF A FIELD
 D ^DIC G A:Y>0
N I $P(X,DG)="",X=DICN S X=$P(X,DG,2,9) G R
NUMBER I X=$$EZBLD^DIALOG(7099) S Y=.001,Y(0)=0 G D ;**CCO/NI THE WORD 'NUMBER' IN A COMPUTED EXPRESSION
UP S T=T-1,X=DICN G M:T<0,TRY:$D(J(T)) F T=T-99:1 G TRY:'$D(J(T+1))
 ;
A F D=M:1:$L(I)+1 Q:$F(X,$E(I,1,D))-1-D  S W=$E(I,D+1)
 I DICOMP["?",DICN'="#.01",$P(Y,U,2)'=DICN,DG_$P(Y,U,2)'=DICN D  G BAD:%<0,N:%-1
 .N N S N(1)=DICN,N(2)=DG,N(3)=$P(Y,U,2) W !,$$EZBLD^DIALOG(8201,.N) S %=1 D YN^DICN ;**CCO/NI (SAME)
 E  S DICO("BACK",T)=+Y
 S M=D
X I $D(DICOMPX)#2 S %Y=J(T)_U_+Y_$E(";",1,$L(DICOMPX)) S:";"_DICOMPX_";"'[(";"_%Y) DICOMPX=%Y_DICOMPX
 ;Take internal value of V-P Field for VPFILE Function --forgot about it when we realized that FILE Function exits!
D S D=$P(Y(0),"^",2),%=T\100*100,DICN=+Y,DICOMPI=W=")" I D["V"&DICOMPI&$D(DPS($$NEST^DICOMP,"VPFILE")) S DICO("PT")=1
 E  S DICOMPI=DICOMPI&$D(DPS($$NEST^DICOMP,"INTERNAL"))
 D DATE:D["D"&'DICOMPI
 I D["m"!D D MUL^DICOMPZ(D) Q
 I $D(DICOMPX(1,J(T),+Y)) S X=DICOMPX(1,J(T),+Y) G O
 I D["C" S:'$D(DG(%,T,+Y)) DG(%)=DG(%)+1,DG(%,T,+Y)=DG(%) S X=DQI_DG(%,T,+Y)_")" Q:D'["p"!DICOMPI  S DICN=+$P(D,"p",2),%Y=$G(^DIC(DICN,0,"GL")) Q:%Y=""  G POINT
GET I DICOMP["G",T#100=0 S X="$$GET^DDSVAL("_J(T)_",D0,"_+Y_",,"""_$E("E",'DICOMPI)_""")" G O
 D G^DICOMPY ;This will set return value X equal to something like "$P(Y(2),U,3)"
O Q:DICOMPI
 S T=J(T)
S ;
 S %=DLV0,DG=W=":"&'$D(DPS(DPS,"$S"))
OUT I D["O"&(D'["P"!'DG)!(D["V"&'$D(DPS(DPS,"FILE"))) D  Q  ;&'$D(DPS(DPS,"INTERNAL"))OUTPUT TRANSFORM ON FIELD
 .S X="$$EXTERNAL^DIDU("_T_","_DICN_","""","_X_")",DICO("DIERR")=1 ;$$EXTERNAL may set an error condition, so stifle DIERR
SET I D["S" S DG(%)=DG(%)+1,DG(%,DG(%))="$C(59)_$P($G(^DD("_T_","_DICN_",0)),U,3)",X="$P($P("_DQI_DG(%)_"),$C(59)_"_X_"_"":"",2),$C(59))" ;S X="$$SET^DIQ("_T_","_DICN_","_X_")"
 Q:D'["P"  S %Y=U_$P(Y(0),U,3),DICN=+$P(@(%Y_"0)"),U,2)
POINT I W=":" G MR:'$$OKFILE^DICOMPX(DICN,DICOMP)
 I W'=":" S D=$P($G(^DD(DICN,.01,0)),U,2) I D'["V",D'["S",D'["P" D DATE:D["D" S X="$P($G("_%Y_"+"_X_",0)),U)" Q
P G P^DICOMPX
 ;
M S T=$F(X," IN ") I T S X=$E(X,1,T-5),W=":",M=T-4,I=X_W_$E(I,T,999),T=$F(I," FILE",M) S:T&$F(DPUNC,$E(I,T)) I=$E(I,1,T-6)_$E(I,T,999) G DICOMP0
 G MR:$L(X)>30 S DICF=X,T=$O(^DD("FUNC","B",X,0))
 G LITDATE:'$D(^DD("FUNC",+T,3)),LITDATE:^(3)
 I $G(^(1))'="" D 2^DICOMP S Y(0)=0,K=K+1,K(K)=X D DATE:$G(^(2))?1"D".E,DPS^DICOMPW Q
 G MR:X'?1"PRIOR"4.U S Y=X,X="$P($$LAST^DIAUTL("_J(DLV0)_",D0,""*""),U)" I Y["USER",$D(^VA(200)) S $E(X,$L(X))=",2)",DICN=200,%Y="^VA(200," G POINT
 G DATE
 ;
LITDATE S %DT="T" I $L(X)>2 D ^%DT I Y>0 S X=Y,Y(0)=0 D DATE Q  ;may be a literal date like "30DEC1944"
BACKPNT S T=$O(^DIC("B",X)) I T]"",$P(T,X)=""!$D(^(X)),$D(J(0)) S T=DLV0 D ^DICOMPV I D>0 Q  ;try backwards-pointer  TOOK OFF CHECK FOR DICOMPW VARIABLE 3/28/2000
MR I M'>$L(I),+X'=X D MR^DICOMP G L:X]""
DDD I DICOMP["?",$D(^DDD("C")),DICOMP'["d" ; S T=$$EN^DICOMPU(X,.J,DICOMP,.DICMX) G BAD:$D(DUOUT) I T]"" W "  (",T,")" D   I $D(X),$D(Y) S:Y["m" DIMW="m" D:Y["D" DATE S K=K+1,K(K)=X_" S X=X" D DPS^DICOMPW S DLV=+Y Q
 ;.D ST^DICOMPX S D=$E(I,M,999),DICOMP=$TR(DICOMP,"?")_"d" D RCR^DICOMPZ(T) S M=0,I=D
BAD K Y Q
 ;
DATE ;
 S DATE(K+1)=1 Q
 ;
SCREEN() ;Screen out certain fields as we process an atom
 I $D(DICO("BACK"))=11,$G(DICO("BACK",T))=Y Q 0
 I Y=DA,DICO(1)=T Q 0 ;Computed field cannot refer to itself!
 I $P(^(0),U,2) Q '$G(DBOOL) ;A multiple cannot be manipulated as a Boolean!
 I $P(^(0),U,2)'["P" Q 1
 N P S P=$P(^(0),U,3) I P]"",$D(@(U_P_"0)")) Q 1 ;Only allow a pointer that points to an existing file!
 Q 0
