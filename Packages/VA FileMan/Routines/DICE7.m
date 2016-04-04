DICE7 ;SFISC/GFT-BULLETIN X-REFS ;12:38 PM  8 Jun 1995
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 K ^UTILITY("DICE",$J) S ^($J,0)="^^BULLETIN MESSAGE",DOLD=$P(^DD(DI,DL,0),U,1)
 F DIK=1,2 Q:$D(DTOUT)  D M G QQ:X[U!$D(DTOUT) I X]"" S DQI="Y(",DCOND="SENDING OF '"_DREF_"'" D DA,CC^DICE4,DA G QQ:$D(DTOUT) S DHI=0,DLAY=$S($D(DCOND):X,1:"") D S G QQ:X=U
 Q:$D(DTOUT)  G X^DICE0
QQ G QQ^DICE
 ;
DA S DA="^DD("_DI_","_DL_",1,"_DQ_"," Q
 ;
M W !!!,"---"_$P("SET^KILL",U,DIK)_" LOGIC---",!!,"ENTER THE NAME OF A 'BULLETIN' MESSAGE, IF YOU WANT THAT MESSAGE SENT"
 D GET^DICE2 Q:U[X  S DIC=3.6,DIC(0)="ELMQ",DIC("DR")=".01;2;4;11;10" D ^DIC K DIC,DICOMPX G M:Y<0
 S (DREF,^UTILITY("DICE",$J,$P("CREA^DELE",U,DIK)_"TE VALUE"))=$P(Y,U,2),DCOND=DI_U_DL_U_DIK_U_DQ
 S DIE=3.6,DA=+Y,DR=10 D:'$P(Y,U,3) ^DIE S X=DREF,DI=$P(DCOND,U,1),DL=$P(DCOND,U,2),DIK=$P(DCOND,U,3),DQ=$P(DCOND,U,4) Q
 ;
S W "  ..OK",! S DHI=DHI+1
SS S DLOC="PARAMETER #"_DHI I DHI>1 W !,"NOW, IF THE BULLETIN IS TO HAVE "_DHI_" OR MORE PARAMETERS INSERTED,"
 W !,"ENTER A FIELD NAME (FOR EXAMPLE, '"_DOLD_"'),",!,"OR A 'COMPUTED-FIELD' EXPRESSION,",!,"THE VALUE OF WHICH WILL BE PASSED INTO THE '"_DREF_"' MESSAGE,",!,"AS "_DLOC
 S X=$O(^XMB(3.6,"B",DREF,0)) S:X="" X=-1 I X F Y=1:1 Q:'$D(^XMB(3.6,X,4,Y,0))  I ^(0)=DHI F D=1:1 G T:'$D(^XMB(3.6,X,4,Y,1,D,0)) W !?4,"-- ",^(0)
 W !,"(NOTE THAT NO SUCH PARAMETER IS DEFINED FOR THE '"_DREF_"' BULLETIN)"
T W ! D OLD^DICE2 W DLOC_": " R X:DTIME S:'$T DTOUT=1 G:X?.P QQ:X=U!'$T,SET:X="",SS S DSUB=X,DICOMP="?" D ^DICOMP I $D(X)-1 W $C(7),"??",! G SS
 S DHI(DHI)=X_$P(" S Y=X X ^DD(""DD"") S X=Y",1,Y["D"),^UTILITY("DICE",$J,$P("CREA^DELE",U,DIK)_"TE "_DLOC)=DSUB G S
SET W !
 S ^UTILITY("DICE",$J,DIK)="K XMY S XMB="""_DREF_""" D ^XMB:$D(^XMB(3.6,""B"",XMB)) K Y,XMB"
 ;
 F D=1:1 Q:'$D(DHI(D))  D
 . S X="S X=Y(0) "_DHI(D)_" S XMB("_D_")=X"
 . S %=DIK_"."_$E("00",1,3-$L(D))_D
 . S ^UTILITY("DICE",$J,+%)=X
 ;
 S Y=""
 S:$D(DHI(1))#2 Y=" X ""N DIIND F DIIND="_DIK_".001:.001 Q:$D("_DA_"DIIND))[0  X ^(DIIND)"""
 S I="S Y(0)=X,D"_N_"=DA" F %=1:1:N S I=I_",D"_(N-%)_"=DA("_%_")"
 ;
 I $L(DLAY) D
 . S Y=" I X"_Y
 . S:$L(I)+$L(Y)+$L(DLAY)+$L(^(DIK))>238 ^(DIK+.9)=DLAY,DLAY="X "_DA_(DIK+.9)_")"
 . S DLAY=" "_DLAY
 ;
 S:Y]""!$L(DLAY) ^(DIK)=I_DLAY_Y_" "_^(DIK)
