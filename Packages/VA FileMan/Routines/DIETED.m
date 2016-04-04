DIETED ;SFISC/GFT SCREEN-EDIT AN INPUT TEMPLATE ;15NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**111,142**
 ;
 N DIC,DIET,DRK,DIETED,I,J,DDSCHG
 S DIC=.402,DIC(0)="AEQ" D ^DIC Q:Y<1
 S DIET=+Y D E
 D PUT
K K ^UTILITY("DIETEDIAB",$J),^UTILITY("DIETED",$J)
 Q
 ;
EDIT(DIET) ; Edit Template using Screen Editor
 N DRK,DIETED,I,J
E N DUOUT,DTOUT,DP,DI,D0,DIETROW,DIETEDER,DIETH,DR,F,L,DB
 D:'$D(DISYS) OS^DII X ^DD("OS",DISYS,"EON")
 I '$D(^DIE(DIET,0)) W !,"NO TEMPLATE SELECTED",! Q
 S DIETED="Input Template """_$P(^(0),U)_""""
 W "..."
 D GET("^TMP(""DIETED"",$J)")
 S DIETH="Editing "_DIETED,DIETROW=1,DRK=$P(^DIE(DIET,0),U,4)
DDW D EDIT^DDW("^TMP(""DIETED"",$J)","M",DIETH,"(File "_DRK_")",DIETROW)
 I $D(DUOUT)!$D(DTOUT) K DR G KL
 D K K I,J
 D PROCESS("^TMP(""DIETED"",$J)")
 X ^DD("OS",DISYS,"EON")
 S DIETROW=$O(DIETEDER(0)) I DIETROW S DIETH="ERROR!  Re-editing "_DIETED K DIETEDER G DDW
 S DDSCHG=1
KL K ^TMP("DIETED",$J)
 I '$D(DR) W $C(7),$$EZBLD^DIALOG(8077) Q
 M ^UTILITY("DIETED",$J)=DR
 Q
 ;
GET(DIETA,DIT) ;put displayable template into @DIETA
 N DIAO,DIETREL,DIETAD,DB,DIAT,I,J,L,DIAR,DIAB
 K @DIETA
 I '$D(DIT) S DIT=$NA(^DIE(DIET))
 S (DR,DIAT)="",(DIETAD,L,DIAO,DB,DIAR)=0,F=-1
 S J(0)=$P(@DIT@(0),U,4)
 M DI=^("DIAB") S DI=J(0)
 D DOWN
1 S Y=$P(DIAT,";",DB) I "Q"[Y G NDB:Y="" S DB=DB+1 G 1
 S %=+Y I Y?.NP,$P(Y,":",2),Y'["/" S Y=+Y_"-"_$P(Y,":",2),%=""
 I %_"T~"=Y!(%_"t~"=Y),$P($G(^DD(DI,%,0)),U,2) S Y=% ;HWH-1103-40934 -- ignore TITLE of MULTIPLE
 S DIETREL="",DIAB=$G(DI(DB,DIAR-1,DI,DIAO)) E  S:Y?1"^".E DIETREL=Y S:DIAB]"" Y=DIAB
 I Y?1"]".E S Y=$E(Y,2,999)
 I DIAB="",%,$D(^DD(DI,%,0)) S Y=$P(^(0),U)_$P(Y,%,2,999)
 S DB=DB+1,DIETAD=DIETAD+1,@DIETA@(DIETAD)=$J("",F*3)_Y I DIETREL]"" D  G 1 ;Put it in!
 .S L=L\100+1*100,(J(L),DI)=$P(DIETREL,U,2) D DOWN ;Relational jump
 I % S %=+$P($G(^DD(DI,%,0)),U,2) I %,$P($G(^DD(%,.01,0)),U,2)'["W" S L=L+1,(J(L),DI)=% D DOWN ;Down to a multiple
 I Y="ALL" G UP
 G 1
 ;
DOWN S F=F+1,DIAR(F)=DIAR,DIAR=DIAR+1,%=$P(DIAT,";",DB) S:%?1"^"1.NP DB=DB+1,DIAR=$P(%,U,2)
 S DB(F)=DB,DB=1,DIAO(F)=DIAO,DIAO=0
DIAT S DIAT=$G(@DIT@("DR",DIAR,DI),"ALL") Q
 ;
NDB I DIAO'<0 S DIAO=DIAO+1 I $D(@DIT@("DR",DIAR,DI,DIAO)) S DIAT=^(DIAO),DB=1 G 1
 S DIAO=-1
UP Q:'F  K I(L),J(L) S L=$O(J(L),-1)
 S DIAR=DIAR(F),DB=DB(F),DIAO=DIAO(F),DI=J(L),DIAT=$S(DIAO<0:"",DIAO:@DIT@("DR",DIAR,J(L),DIAO),1:$G(@DIT@("DR",DIAR,DI))),F=F-1 G 1
 ;
 ;
 ;
 ;
PROCESS(DIETA) ;puts nodes into ^UTILITY("DIETED")
 N DIAB,LINE,DXS,L,DIAP,DIETSL,DQI,DIETSAVE,DIETAB,ERR,DIAR
 K DR S F=0,(DI,J(0))=DRK,I(0)=^DIC(J(0),0,"GL"),DIAP="",(L,DIETAB)=0,DXS=1,DIAR=1
 F LINE=1:1 Q:'$D(@DIETA@(LINE))  K ERR S X=^(LINE) D
 .I X?1"^".E S LINE=999999999 K DR Q
 .D LINE(X)
 .I $D(ERR) W "LINE ",LINE S DIETEDER(LINE)=ERR,LINE=-LINE Q  ;stop if we find one error
 I LINE<0 W " ERROR!"
 Q
 ;
LINE(X) ;Process one LINE from the screen
 N D,DIC,DICMX,DV,DATE,Y,DICOMPX,DICOMP,DRR
 F D=$L(X):-1:1 Q:$A(X,D)>32  S X=$E(X,1,D-1)
 F D=0:1 Q:$A(X)-32  S X=$E(X,2,999) ;strip off 'D' leading spaces
 Q:X=""
OUT I D<DIETAB,L K I(L),J(L) S L=$O(J(L),-1),DIAP=DIAP(F),DIAR=DIAR(F),DIETAB=$G(DIETAB(F),D),F=F-1,DI=J(L) G OUT ;out-dentation means go up a level (or more)
 S DIETAB=D
 I X?1"@"1.N S Y=X G DR
ALL D DICS^DIA I X="ALL" D  Q
 .S ^UTILITY("DIETEDIAB",$J,1,DIAR-1,DI,DIAP\1000)=X
 .N D,DA,DG D RANGE^DIA1
 S DV="",J=$P(X,"-",2) I +J=J,$P(X,"-")=+X,J>X D  G X:Y="",DR
 .N D,DA,DG S D(F)=J D RANGE^DIA1 S Y=DA
SEMIC I X[";" S Y=X,X=$P(X,";") D  G X:'$D(Y) S DIAB=Y
 .F %=2:1:$L(Y,";") S D=$P(Y,";",%),D=$S(D="DUP":"d",D="REQ":"R","""R""d"""[D:"",$A(D)=34:$E(D,2,$F(D,"""",2)-2),D="T":D,1:""),DV=D_$C(126)_DV I $A(D)>45&($A(D)<58)!(D[":")!(D="") K Y Q
DIC S DIC(0)="OZ",DIC="^DD(DI," D ^DIC
 I Y>0 S Y=+Y_DV D DR S %=+$P(Y(0),U,2) D:%  Q
 .I $P($G(^DD(+%,.01,0)),U,2)["W" Q
 .S L=L+1,(DI,J(L))=+%,I(L)=""""_$P($P(Y(0),U,4),";")_"""" D D
 S (Y,DIETSAVE)=X I DUZ(0)="@",X'?.E1":" S X=$S(X["//^":$P(X,"//^",2),1:X),X=$S(X[";":$P(X,";"),1:X) D ^DIM G:$D(X) DR:X=DIETSAVE I DIETSAVE["//^",'$D(X) G X
 F DIETSL="///+","//+","///","//" I DIETSAVE[DIETSL S DP=$P(DIETSAVE,DIETSL,2,9) I DP'?1"/".E&(DP'?1"^".E)!(DUZ(0)="@") G DEF
 I DIETSAVE?.E1":" S:'$D(DIAB) DIAB=DIETSAVE K X S X=DIETSAVE,DICOMP=L_"WE",DQI="Y(",DA="DR(99,"_DXS_",",DICMX=1 D ^DICOMPW G L:$D(X) ;as in E^DIA3
X S ERR=1 Q
 ;
L I $D(X)>1  M DR(99,DXS)=X S DXS=DXS+1
 S %=-1,L=$S(Y>L:+Y,1:L\100+1*100),Y=U_DP_U_U_X_" S X=$S(D(0)>0:D(0),1:"""")" K X
 D DR S DI=+DP D D
 Q
 ;
D N % S F=F+1,DIAR(F)=DIAR F %=F+1:.01 Q:'$D(DR(%,DI))
 S:%["." @DRR=@DRR_U_%_";",DIAP=DIAP+1 S DIAR=%
 S DIAP(F)=DIAP,DIAP=0,DIETAB(F)=DIETAB Q
 ;
DEF S X=DIETSAVE D  S X=$P(DIETSAVE,DIETSL),DV=DV_DIETSL_DP G X:DV[";",DIC ;as in DEF^DIA3
 .S X="DA,DV,DWLC,0)=X" F J=L:-1 Q:I(J)[U  S X="DA("_(L-J+1)_"),"_I(J)_","_X
 .S DICMX="S DWLC=DWLC+1,"_I(J)_X,DA="DR(99,"_DXS_",",X=DP,DQI="X(",DICOMP=L_"T"
 .D EN^DICOMP,DICS^DIA
XEC .I $D(X),Y["m" S DIC("S")="S %=$P(^(0),U,2) I %,$D(^DD(+%,.01,0)),$P(^(0),U,2)[""W"",$D(^DD(DI,Y,0)) "_DIC("S") ;as in XEC^DIA3
 .S Y=0 F  S Y=$O(X(Y)) Q:Y=""  S @(DA_"Y)=X(Y)")
 .S Y=-1 I $D(X) S Y="Q",DXS=DXS+1,DP=U_X D
 ..D  S:'$D(DIAB) DIAB=DIETSAVE ;assume "YOU MEAN as a VARIABLE"
 ...N DIAB D DR
 .I DP="@",DIETSL="//" S DA=U_U
 .Q
 ;
DR ;takes 'Y' and puts it into 'DR' array
 N %,B
 S (DRR,B)=$NA(DR(DIAR,DI)),%=$O(@DRR@(""),-1)
 I % S DRR=$NA(@DRR@(%))
 I '$D(@DRR) S @DRR="",DIAP=0
 I $L(Y)+$L(@DRR)>230 S DRR=$NA(@B@(%+1)),DIAP=DIAP\1000+1*1000,@DRR=""
 S @DRR=@DRR_Y_";"
 S DIAP=DIAP+1
DIAB I $D(DIAB) S ^UTILITY("DIETEDIAB",$J,DIAP#1000,DIAR-1,DI,DIAP\1000)=DIAB K DIAB
 Q
 ;
PUT ;save template
 I '$D(^UTILITY("DIETED",$J)) Q
 N DIC
 S DIC("B")=DIET
SAVEAS S DIC=.402,DIC("A")="Save revised "_DIETED_" as: ",DIC(0)="AEQL",DIC("S")="I $P(^(0),U,4)=DRK"
 D ^DIC
 Q:Y<0  I $O(^DIE(+Y,0))]"" W !,$C(7),"Are you sure you want to overwrite this '",$P(Y,U,2)," 'Template" S %=1 D YN^DICN I %-1 Q:%<2  K DIC("B") G SAVEAS
 L +^DIE(+Y)
 S ^DIE("F"_J(0),$P(Y,U,2),+Y)=1
 S $P(^DIE(+Y,0),U,4)=J(0)
 L -^DIE(+Y)
 D SAVEFLDS(+Y)
 Q
 ;
SAVEFLDS(Y) ;
 N X,DP,DMAX
 Q:'$D(^UTILITY("DIETED",$J))!'$G(Y)
NOW D NOW^%DTC S $P(^DIE(Y,0),U,2)=+$J(%,0,4)
 S $P(^DIE(Y,0),U,5)=$G(DUZ)
 K ^DIE(Y,"DR") M ^DIE(+Y,"DR")=^UTILITY("DIETED",$J)
 K ^DIE(Y,"DIAB") M ^DIE(+Y,"DIAB")=^UTILITY("DIETEDIAB",$J)
 S X=$S('$D(^DIE(+Y,"ROU")):1,^("ROU")'[U:1,$D(^("ROUOLD")):^("ROUOLD"),1:1),DP=+$P(^(0),U,4),DMAX=^DD("ROU") I X'=1,$D(^DD("OS",DISYS,"ZS")) D EN^DIEZ
 D K
 Q
