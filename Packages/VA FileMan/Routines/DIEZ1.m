DIEZ1 ;SFISC/GFT-COMPILE INPUT TEMPLATE ;30MAY2007
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,11,999,1004,1022,1028**
 ;
 D QF^DIEZ2 S L=2,X="DE S DIE="_Q_",DIC=DIE,DP="_DP_",DL="_DL_",DIEL="_DIEZL_",DU="""" K DG,DE,DB Q:$O("_DIE_"DA,""""))=""""",DS=-1 D L S X=""
DL S DS=$O(^UTILITY($J,U,DS)) S:DS="" DS=-1 I DS<0 K ^UTILITY($J,U) G CN
 S DSN=DS S:+DS'=DS DSN=""""_DSN_"""" S DPP=0,X=X_" I $D(^("_DSN_")) S %Z=^("_DSN_")"
DP S DPP=$O(^UTILITY($J,U,DS,DPP)) I DPP="" D L S X="" G DL
 S %=$O(^(DPP,0)) I +DPP=DPP S Y="P(%Z,U,"_DPP_") S:%]"""" DE("_%_")=%"
 E  S Y="E(%Z,"_+$E(DPP,2,9)_","_+$P(DPP,",",2)_") S:%'?."" "" DE("_%_")=%"
 F %=%:0 S %=$O(^(%)) Q:'%  S Y=Y_",DE("_%_")=%"
 I $L(X)+$L(Y)>240 D L S X=" I "
 S X=X_" S %=$"_Y G DP
 ;
CN F X=" K %Z Q"," ;","W "_$S($D(^DIE(DIEZ,"W")):"S DQ(DQ)=DLB_U_DV_U_U_DW "_^("W"),1:"W !?DL+DL-2,DLB_"": """) D L
 F %=1:1 S X=$E($T(TEXT+%),4,999) Q:X=""  D L
SAVE I $L(DNM_DRN)>8 S DIEZQ=1 W:'$G(DIEZS) $C(7),!,DNM_DRN_$$EZBLD^DIALOG(1503) S:$G(DIEZRLA)]"" DIEZRLAF=0 Q
 S X=DNM_DRN D:'$D(DISYS) OS^DII X ^DD("OS",DISYS,"ZS") N DIR D BLD^DIALOG(8025,DNM_DRN,"","DIR") W:'$G(DIEZS) !,DIR S:$G(DIEZRLA)]"" @DIEZRLA@(DNM_DRN)="",DIEZRLAF=1
 S DRN(+DRN)=U,T=0,DRN=DQ Q
 ;
L S L=L+.001,^UTILITY($J,0,L)=X Q
 ;
 ;DIALOG #1503  'routine name is too long...'
 ;       #8025  'routine filed'
 ;
TEXT ;;
 ;; Q
 ;;O D W W Y W:$X>45 !?9
 ;; I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 ;; W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 K X S X("FIELD")=DIFLD,X("FILE")=DP W "  ("_$$EZBLD^DIALOG(710,.X)_")" K X S X="" Q  ;**
 ;;TR Q:DV["K"&(DUZ(0)'="@")  R X:DTIME E  S (DTOUT,X)=U W $C(7)
 ;; Q
 ;;A K DQ(DQ) S DQ=DQ+1
 ;;B G @DQ
 ;;RE G A:DV["K"&(DUZ(0)'["@"),PR:$D(DE(DQ)) D W,TR
 ;;N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
 ;;RD G QS:X?."?" I X["^" D D G ^DIE17
 ;; I X="@" D D G Z^DIE2
 ;; I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
 ;;T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" I X?.ANP D SET^DIED I 'DDER G V
 ;; K DDER G X
 ;;P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 ;; G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 ;; I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
 ;;V D @("X"_DQ) K YS
 ;;UNIQ I DV["U",$D(X),DIFLD=.01 K % M %=@(DIE_"""B"",X)") K %(DA) K:$O(%(0)) X
 ;;Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
 ;;X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
 ;; S X="?BAD"
 ;;QS S DZ=X D D,QQ^DIEQ G B
 ;;D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
 ;;Y I '$D(DE(DQ)) D O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
 ;;PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
 ;;R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 ;; I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 ;; X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") I %]"" S Y=$S($G(DUZ("LANG"))'>1:%,'DIFLD:%,1:$$SET^DIQ(DP,DIFLD,Y))
 ;;RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
 ;;I I DV'["I",DV'["#" G RD
 ;; D E^DIE0 G RD:$D(X),PR
 ;; Q
 ;;SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 ;; I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 ;; E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 ;; Q
 ;;NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
 ;;KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
