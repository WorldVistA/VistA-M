DIE0 ;SFISC/GFT-BRANCHING, UP-ARROWING ;23DEC2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**60,142,1004,1005,1021**
 ;
 G Q^DIE1:$D(DTOUT) G:X'?1"^".E T^DIED:$P($P(DQ(DQ),U,4),";E",2),X
 I $D(DIE("NO^")),X=U,DIE("NO^")'["OUTOK" W !?3,$$EZBLD^DIALOG(3095) G X ;**
 I $D(DIE("NO^")),X?1"^"1E.E,DIE("NO^")'["BACK" W !?3,$$EZBLD^DIALOG(3096) G X ;**
 I $L(X,"^")-1>1 S X=$E(X,2,99) G DIE0
 S X=$P(X,U,2),DIC(0)="E"
OUT I X=""!(DP<0) S DIK=X,DC=$S($D(DQ(DQ))#2:$P(DQ(DQ),U,4),1:DQ) G OUT^DIE1
 I DR]"" G A:X?1"@".N S DIC("S")="D S^DIE0" S:'$D(DR(DIE1,DP)) DR(DIE1,DP)=DR
 S DDBK=0,DIC="^DD("_DP_"," D ^DIC I Y>0 D S
 E  W:DDBK !?3,$$EZBLD^DIALOG(3097)
 K DTOUT,DIC,DDBK,DDFND,DDONE,A0,A1,A2
 I Y<0 S DG=DK,DH=":"_DM G X
 S DI=$S(DH[":":+Y,1:DH),DK=DG D ^DIE1:$D(DG)>9 K DG,DB,DE,DQ,DIFLD S DQ=0 G JMP^DIE
X W:X'["?"&'$D(ZTQUEUED) $C(7),"??" G B^DIED:'$D(DB(DQ)),B^DIE1
 ;
BR ;From ^DIED
 S Y=U,X=$G(X) X DQ(0,DQ) D:$D(DIEFIRE)#2 FIREREC^DIE1 G A^DIED:$D(Y)[0,A^DIED:Y=U S D=$S(+Y=Y:9999,1:DQ),X="" I 0[Y S DQ=0 G OUT ;MAKE SURE 'X' EXISTS, AFTER W-P
D S D=D+1 I '$D(DQ(D)) G D:$D(DQ(0,D)) S DQ=9999,X=Y,DIC(0)="FO" G OUT
 G D:$P(DQ(D),Y,1)]"" S DQ=D G RE^DIED
 ;
O ;From ^DIE
 K DQ S (DI,DV,DM)=0 I X]"",$D(@(U_$P(DC,U,3)_X_",0)"))#2 D S^DIE1,DIEC
 S DQ=0 G MORE^DIE
 ;
DIEC S DIE=U_$P(DC,U,3),DIEC(DL)=DA F %=1:1 Q:'$D(DA(%))  S DIEC(DL,%)=DA(%)
 K DA,DB,DE,DG F %=0:1:DIEL-1 S DA="D"_%,DIEC(DL,0,%)=@DA K @DA
 S:$D(DIETMP)#2 DIEC(DL,"IENS")=DIIENS,DIIENS=X_","
 S DIEL=0,(D0,DA)=X Q
 ;
DIEZ ;
 I X="" G @("A"_U_DNM)
 S D=0,DL=DL+1,DNM(DL)=DNM,DNM(DL,0)=DQ,DIEL=DIEL+1 D DIEC G @DGO
 ;
A I $D(DR(DIE1,DP))>9 D OA ;Branching to "@N"
 E  F DG=1:1 S DH=$P(DR(DIE1,DP),";",DG) G X:DH="" I DH=X S:$D(DOV) DOV=0 S DR=DR(DIE1,DP) Q
 S DK=DG,DI=X D ^DIE1 G JMP^DIE
OA S %=0 F  S %=$O(DR(DIE1,DP,%)) Q:%=""  F DG=1:1 S DH=$P(DR(DIE1,DP,%),";",DG) Q:DH=""  I DH=X S DR=DR(DIE1,DP,%),DOV=%,%=9999 Q
 S %=-1 Q
 ;
E ;UNEDITABLE & DINUM fields
 I X="@" Q:DV'["I"  G NO
 Q:X[U!(X?."?")!DV!$D(DITC)
NO W:'$D(DB(DQ)) $C(7),"   NO EDITING!!" K X
Q Q
 ;
 ;
 ;
S ;SCREEN fields;  out= $T
 N DDR S (%,DDFND)=0,DDR=DR(DIE1,DP),DDBK=0,Y=+Y
 I $D(DIE("NO^")),DIE("NO^")["BACK" S DDBK=1
 D S1 I DDFND Q
 I 'DDONE,$D(DR(DL,DP))>9 F %=-1:0 S %=$O(DR(DIE1,DP,%)) Q:%=""  S DDR=DR(DIE1,DP,%) D S1 Q:DDONE!DDFND
 Q
S1 ;selectable?
 S DDONE=0 F DG=1:1 D S2 Q:DDFND!DDONE!(DH="")
 I DDFND S DOV=%,DR=$G(DR(DIE1,DP,%),$G(DR(DIE1,DP)))
 Q
S2 ;parse for ;-piece
 S DH=$P(DDR,";",DG) Q:(DH["///"&(DIC(0)'["F"))!'DH
 ;list
 I 'DDBK,+DH=Y S DDFND=1 Q
 I DDBK,+DH=DIFLD,+DH'=Y S DDONE=1 Q
 I DDBK,+DH=Y S DDFND=1 Q
 Q:$P(DH,"//")'[":"
 ;range
 S A0=+$P(DH,":",1),A1=+$P(DH,":",2)
 I 'DDBK,Y'<A0,Y'>A1 S DDFND=1 Q
 F A2=A0-.000001:0 S A2=$O(^DD(DP,A2)) Q:A2>A1!'A2  S:A2=DIFLD&(A2'=Y)&DDBK DDONE=1 Q:DDONE  I A2=Y,(A2'>DIFLD) S DDFND=1 Q
 Q
