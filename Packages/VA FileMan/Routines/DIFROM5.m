DIFROM5 ;SFISC/XAK-CREATES RTN ENDING IN 'INIT' ;03:14 PM  28 Nov 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 S DIFRF=0,DIFRRXT="567890ABCDEFGHIJKLMNOPQRUVWXZ",DIFRRN=E,DIFRTX=0
 S DIFRRMAX=$S($G(DIFRM)>1999:DIFRM,$G(^DD("ROU"))>1999:^("ROU"),1:2000)
 F DIFRIR=1:1 S X=0,Q=" Q",DNAME=DIFRRN_$E(DIFRRXT,DIFRIR) D  Q:DIFRF'>0
 .S DIFRS=510
 .F  S DIFRF=$O(F(DIFRF)) Q:DIFRF'>0  D  Q:DIFRS>DIFRRMAX
 ..S X=X+1
 ..S DH=$P(@(F(DIFRF,0)_"0)"),U,2)
 ..S ^UTILITY($J,X,0)=" ;;"_DH_";"_F(DIFRF)_";"_F(DIFRF,0)_";"_$S($D(F(DIFRF,DIFRF)):F(DIFRF,DIFRF),1:"")_";"_$TR(F(DIFRF,-222),"^",";"),DIFRS=DIFRS+$L(^UTILITY($J,X,0))
 ..S X=X+1
 ..S ^UTILITY($J,X,0)=" ;;"_F(DIFRF,-223),DIFRS=DIFRS+$L(^UTILITY($J,X,0))
 ..Q
 .S DH=$S(DIFRIR=1:" K ^UTILITY(""DIF"",$J) S DIFRDIFI=1",1:"")
 .S DH=DH_" F I=1:1:"_X_" S ^UTILITY(""DIF"",$J,DIFRDIFI)=$T(IXF+I),DIFRDIFI=DIFRDIFI+1"
 .S ^UTILITY($J,.5,0)="IXF ;;"_$P(DPK(0),U,1,2)
 .S DIFRTX=DIFRTX+X,D=-9999,DIFROM=X D ZI^DIFROM3 K ^UTILITY($J)
 .Q
 S Q=$S('$D(^DIC(9.4,DPK,"INIT")):1,$P(^("INIT"),U)?1PA.E:$P(^("INIT"),U),1:1)
 S DRN=^DD("VERSION"),X=DIFROM
 S ^UTILITY($J,5,0)=" F DIF=1:2:"_DIFRTX_" S %=^UTILITY(""DIF"",$J,DIF),DIK=$P(%,"";"",5),N=$P(%,"";"",3),D=$P(%,"";"",4)_U_N D D K DIFQ(N)"
 S ^UTILITY($J,9,0)=" L  S DUZ=DIDUZ W:"_(DIFRTX>0)_" !"_$S(Q:",$C(7),""OK, I'M DONE."",!",1:"")_",""NO""_$P(""TE THAT FILE"",U,DSEC)_"" SECURITY-CODE PROTECTION HAS BEEN MADE"""
 I 'Q S ^UTILITY($J,9.1,0)=" D ^"_Q_",NOW^%DTC S DIFROM(""INIT"")=%"
 S ^UTILITY($J,9.11,0)=" I DIFROM F DIF=1:2:"_DIFRTX_" S %=^UTILITY(""DIF"",$J,DIF),N=+$P(%,"";"",3) I N,$P(%,"";"",8)=""y"" S ^DD(N,0,""VR"")=DIFROM"
 S ^UTILITY($J,9.12,0)=" I DIFROM(0)>0 F %=""PRE"",""INI"",""INIT"" S:$D(DIFROM(%)) $P(^DIC(9.4,DIFROM(0),%),U,2)=DIFROM(%)"
 S ^UTILITY($J,9.13,0)=" I $G(DIFQN) S $P(^(0),U,3,4)=$P(DIFQN,U,2)_U_($P(^DIC(0),U,4)+DIFQN) K DIFQN"
 S ^UTILITY($J,9.2,0)=" S:DIFROM(0)>0 ^DIC(9.4,DIFROM(0),""VERSION"")=DIFROM G Q^DIFROM0"
 S ^UTILITY($J,9.3,0)="D S:$D(^DIC(+N,0))[0 ^(0)=D S X=$D(@(DIK_""0)"")),^(0)=D_U_$S(X#2:$P(^(0),U,3,9),1:U)"
 S ^UTILITY($J,9.4,0)=" S DIFQR=DIFQR(+N) I ^DD(""VERSION"")>17.5,$D(^DD(+N,0,""DIK""))#2 S X=^(""DIK""),Y=+N,DMAX=^DD(""ROU"") D EN^DIKZ"
 S ^UTILITY($J,9.5,0)=" I DIFQR D IXALL^DIK:$O(@(DIK_""0)"")) W ""."""
 S ^UTILITY($J,9.6,0)=" Q"
 S ^UTILITY($J,9.7,0)="R G REP^"_E_2
 F DD=1:1 S E=$T(T+DD) Q:E=""  S E=$E(E,4,999) S:E="IXF ;;" E=E_$P(DPK(0),U,1,2)_";"_DUZ S ^UTILITY($J,9+DD,0)=E
 S DIFROM=10 G ^DIFROM6
T ;;
 ;; ;
 ;;1 S N=+$P(DIF(I),";",3),DIF=$P(DIF(I),";",4),S=$P(DIF(I),";",5)
 ;; W !!?3,N,?13,DIF,$P("  (Partial Definition)",U,$P(DIF(I),";",6)),$P("  (including data)",U,$P(DIF(I),";",13)="y") S Z=$S($D(^DIC(N,0))#2:^(0),1:"")
 ;; I Z="" S DIFQ(N)=1,DIFQN=$G(DIFQN)+1_U_N G S
 ;; I $L($P(Z,DIF)) W $C(7),!,"*BUT YOU ALREADY HAVE '",$P(Z,U),"' AS FILE #",N,"!" D R Q:DIFQ  G S:$D(DIFKEP(N)),1
 ;; S DIFQ(N)=$P(DIF(I),";",7)'="n"
 ;; I $L(Z) W $C(7),!,"Note:  You already have the '",$P(Z,U),"' File." S DIFQ(0)=1
 ;; S %=$E(^UTILITY("DIF",$J,I+1),4,245) I %]"" X % S DIFQ(N)=$T W:'$T !,"Screen on this Data Dictionary did not pass--DD will not be installed!" G S
 ;; I $L(Z),$P(DIF(I),";",10)="y" S DIR("A")="Shall I write over the existing Data Definition",DIR("??")="^D DD^DIFROMH1",DIR("B")="YES",DIR(0)="Y" D ^DIR S DIFQ(N)=Y
 ;;S S DIFQR(N)=0 Q:$P(DIF(I),";",13)'="y"!$D(DIRUT)
 ;; I $P(DIF(I),";",15)="y",$O(@(S_"0)"))>0 S DIF=$P(DIF(I),";",14)="o",DIR("A")="Want my data "_$P("merged with^to overwrite",U,DIF+1)_" yours",DIR("??")="^D DTA^DIFROMH1",DIR(0)="Y" D ^DIR S DIFQR(N)=$S('Y:Y,1:Y+DIF) Q
 ;; S %=$P(DIF(I),";",14)="o" W !,$C(7),"I will ",$P("MERGE^OVERWRITE",U,%+1)," your data with mine." S DIFQR(N)=%+1
 ;; Q
 ;;Q W $C(7),!!,"NO UPDATING HAS OCCURRED!" G Q^DIFROM0
 ;; ;
 ;;PKG S X=$P($T(IXF),";",3),DIC="^DIC(9.4,",DIC(0)="",DIC("S")="I $P(^(0),U,2)="""_$P(X,U,2)_"""",X=$P(X,U) D ^DIC S DIFROM(0)=+Y K DIC
 ;; Q
 ;; ;
 ;;IXF ;;
