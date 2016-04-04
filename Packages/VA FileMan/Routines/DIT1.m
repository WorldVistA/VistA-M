DIT1 ;SFISC/GFT,TKW-TRANSFER DD'S ;30JAN2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6,63,163**
 ;
 K A W !! S A=+Y,E=A
CHK F V=0:0 S V=$O(^DD(A,"SB",V)) Q:'V  S A(V)=0,L(V)=V#1+DHIT
 S A=$O(A(0)),B=A#1+DHIT I A'="" K A(A) G P:$P(DHIT,".")+1'>B,CHK:'$D(^DD(B)),P:DHIT["." S X=$P(^(B,0),U) S:$D(^DIC(B,0)) X=$P(^(0),U)_" FILE" W $P(^DD(A,0),U)_" WOULD COLLIDE WITH "_X,$C(7),! K L,A Q
 S A=$O(L(0)) I A S %X="^DIC("_A_",""%D"",",%Y="^DIC("_L(A)_",""%D""," D %XY^%RCR
 D WAIT^DICD F A="^DIE(","^DIPT(","^DIBT(" F V=0:0 S V=$O(@(A_"V)")) Q:'V  I $D(^(V,0)),$P(^(0),U,4)-Y=0 S ^UTILITY("DITR",$J,A,V)=$P(^(0),U)
 S A="F B=0:0 Q:F=DTO!'$F(W,DTO)  S W=$P(W,DTO)_F_$P(W,DTO,2,9)"
 I $O(^UTILITY("DITR",$J,""))]"" W !,"DO YOU WANT TO COPY '",$P(Y,U,2),"'S TEMPLATES INTO YOUR NEW FILE" D YN^DICN W ! D:%=1
 .S E="I DIK=""^DIBT("",%Z=1,$D(L(+W)) S $P(W,U)=L(+W)"
 .F DIK="^DIE(","^DIPT(","^DIBT(" S V=$P(@(DIK_"0)"),U,3),%X=DIK_"Z,",%Y=DIK_"V," D ^DIT2,IXALL^DIK
GO S Y=DLAYGO K ^UTILITY("DITR",$J),^DD(Y,"B"),^(.01),^("IX"),^("RQ"),^(0,"IX"),E
 S @("V=$P("_DTO_"0),U,2)"),@("^(0)=$P("_DTO(0)_"0),U,1,2)_$P(V,DDF(1),2)_U_U")
DD W ! S L=$O(L(L)) Q:L=""  S Y=L(L),B=0,V=$O(^DD(L,0,"NM",0)),^DD(Y,0)=^DD(L,0) I V]"",$O(^(0,"NM",0))="" S ^(V)=""
 S V=-1 I $D(^DD(L,0,"UP")) S ^DD(Y,0,"UP")=^("UP")#1+DHIT
ID S V=$O(^DD(L,0,"ID",V)) I V]"",$D(^(V))#2 S W=^(V) X A S ^DD(Y,0,"ID",V)=W G ID
 F V=0:0 S V=$O(^DD(L,V)) Q:'V  W "." D MOVEFLD
 D IXKEY(.L,DTO,Y,F)
 S DA(1)=Y,DIK="^DD("_Y_"," D IXALL^DIK K %A,%B,%C,%Z
 G DD
 ;
MOVEFLD S W=$G(^DD(L,V,0)),D=$P(W,U,2),%Z=0,%A="" Q:W=""
 I D["C" D  Q  ;copy COMPUTED FIELD, replacing Y variable with DIT
 .N DITN
 .S D=$P(W,U,5,99),^DD(Y,V,0)=$P(W,U,1,4)_"^N DIT "_$$DITRPL(D)
 .S ^DD(Y,V,9)="^",^DD(Y,V,9.1)=$G(^DD(L,V,9.1))
 .F DITN=9.01,9.02 S W=$G(^DD(L,V,DITN)) I W]"" D Y S ^DD(Y,V,DITN)=W
 .S DITN=9.15 F  S DITN=$O(^DD(L,V,DITN)) Q:DITN=""  I $D(^(DITN))#2 S ^DD(Y,V,DITN)=$$DITRPL(^(DITN))
MULFLD I D S L(+D)=D#1+DHIT,W=$P(W,U)_U_L(+D)_$P(D,+D,2,9)_U_$P(W,U,3,99)
 E  X A ;D Y ;DO NOT REPLACE NUMBERS IN THE '0' NODE --GFT 1/30/2010
 S ^DD(Y,V,0)=W,%B=0
N S %B=$O(@("^DD(L,V,"_%A_"%B)")) G:((%B=5)&(%A="")) N I %B="" Q:'%Z  S @("%B="_$P(%A,",",%Z)),%Z=%Z-1,%A=$P(%A,",",1,%Z)_$E(",",%Z>0) G N
 I @("$D(^DD(L,V,"_%A_"%B))#2") S W=^(%B) D D S @("^DD(Y,V,"_%A_"%B)=W")
 I @("$D(^DD(L,V,"_%A_"%B))<9") G N
 S:+%B'=%B %B=""""_%B_"""" S %A=%A_%B_",",%Z=%Z+1,%B="" G N
 ;
DITRPL(W) S W=$$REPLACE(W,"Y("_L_","_V_",","DIT(") D D Q W
 ;
D X A
Y ;REPLACE THE NUMBERS; CALLED FROM DIT2
 N O
 F O=0:0 S O=$O(L(O)) Q:'O  S W=$$REPLACE(W,O,L(O))
 Q
 ;
REPLACE(X,OLD,NEW) ;
 N %,C
 S C=$L(NEW)-$L(OLD)
 F %=0:0 S %=$F(X,OLD,%) Q:%<1  I C+$L(X)<256,$E(X,%)'=".",$E(X,%-$L(OLD)-1)'?1N S X=$E(X,1,%-$L(OLD)-1)_NEW_$E(X,%,9999),%=%+C
 Q X
 ;
IXKEY(DIFRN,DIFRGBL,DITON,DITOGBL) ; transfer KEY and INDEX file entries
 ; DIFRN=from file#, DIFRN(DIFRN)=from file list, DIFRGBL=from file global, DITON=to file#, DITOGBL=to file global
 N A,B,E,F,V,Y
 N DIFRNAME,DIFRD0,DIG,DITOD0,DIL1,DIL2,DIL3,DIFRPRT,I,X S DIFRNAME=""
 S DIL1=$L(DIFRGBL)
 S DIL3=$O(DIFRN("")) S:DIL3 DIL3=$F(DIFRGBL,DIL3) S:DIL3 DIL3=DIL3-1,DIFRPRT=$E(DIFRGBL,1,DIL3)
 ; INDEX file entries
 F  S DIFRNAME=$O(^DD("IX","BB",DIFRN,DIFRNAME)) Q:DIFRNAME=""  D
 . S DIFRD0=$O(^DD("IX","BB",DIFRN,DIFRNAME,0)) Q:'DIFRD0
 . S DITOD0=$O(^DD("IX","BB",DITON,DIFRNAME,0)) I DITOD0 D ERR("IX",DITON,DIFRNAME) Q
 . S DITOD0=$$NXTNO^DICLIB("^DD(""IX"",","","U")
 . M ^DD("IX",DITOD0)=^DD("IX",DIFRD0)
 . K ^DD("IX",DITOD0,11.1,"AC"),^("B"),^("BB")
 . I DIFRGBL'=DITOGBL!(DIFRN'=DITON) S DIG="^DD(""IX"","_DITOD0_")" D ADJ
 . S DIK="^DD(""IX"",",DA=DITOD0 D IX1^DIK
 . Q
 ; KEY file entries
 S DIFRNAME=""
 F  S DIFRNAME=$O(^DD("KEY","BB",DIFRN,DIFRNAME)) Q:DIFRNAME=""  D
 . S DIFRD0=$O(^DD("KEY","BB",DIFRN,DIFRNAME,0)) Q:'DIFRD0
 . S DITOD0=$O(^DD("KEY","BB",DITON,DIFRNAME,0)) I DITOD0 D ERR("KEY",DITON,DIFRNAME) Q
 . S DITOD0=$$NXTNO^DICLIB("^DD(""KEY"",","","U")
 . M ^DD("KEY",DITOD0)=^DD("KEY",DIFRD0)
 . K ^DD("KEY",DITOD0,2,"B"),^("BB"),^("S")
 . I DIFRGBL'=DITOGBL!(DIFRN'=DITON) S DIG="^DD(""KEY"","_DITOD0_")" D ADJ
 . S DIK="^DD(""KEY"",",DA=DITOD0 D IX1^DIK
 . Q
 Q
ADJ ; Change data to contain new file number and global reference.
 F  S DIG=$Q(@DIG),X=$QS(DIG,2) Q:X'=DITOD0  D
 . S X=@DIG,I=0
 . I DIFRGBL'=DITOGBL F  S I=$F(X,DIFRGBL,I) Q:'I  D
 . . S $E(X,I-DIL1,I-1)=DITOGBL,I=I+$L(DITOGBL)-DIL1
 . Q:DIFRN=DITON  N DIF,DIT
 . F DIF=0:0 S DIF=$O(DIFRN(DIF)) Q:'DIF  S DIT=DIFRN(DIF),DIL2=$L(DIF),I=0 F  D  Q:'I
 . . S I=$F(X,DIF,I) Q:'I  Q:$E(X,I,999)
 . . I DIL3,$E(X,(I-DIL3+1),(I-DIL1+DIL3-1))=DIFRPRT Q
 . . S $E(X,I-DIL2,I-1)=DIT,I=I+$L(DIT)-DIL2
 . S @DIG=X Q
 Q
 ;
ERR(DITYPE,DITON,DIFRNAME) ;
 ;DITYPE=IX or KEY, DITON=file/subfile#, DIFRNAME=Index/Key name
 N DIPAR,DIER S DIPAR(1)=$S(DITYPE="IX":"INDEX",1:"KEY")
 S DIPAR(2)=DIFRNAME,DIPAR(3)=DITON
 D BLD^DIALOG(9548,.DIPAR),MSG^DIALOG("WE")
 Q
 ;
 ; Error list
 ;9548 - |1| '|2|' for file |3| already exists.
 ;
 Q
 ;
P W $C(7),"FILE #"_+Y_" SHOULD ONLY BE TRANSFERRED TO A FILE WHOSE NUMBER",!?8,"ALSO "_$S(Y#1:"ENDS WITH '"_(Y#1)_"'",1:"IS INTEGER") K L,A Q
 ;
