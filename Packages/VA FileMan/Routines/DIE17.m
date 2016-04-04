DIE17 ;SFISC/GFT-COMPILED TMPLT UTIL ;03:47 PM  13 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,11,999**
 ;
 I $D(DTOUT) S X="" G OUT
 G:$A(X)-94 X:'$P(DW,";E",2),@("T^"_DNM)
 I $D(DIE("NO^")),X=U,DIE("NO^")'["OUTOK" W !?3,"EXIT NOT ALLOWED " S D="" G X
 I $D(DIE("NO^")),X?1"^"1.E,DIE("NO^")'["BACK" W !?3,"JUMPING NOT ALLOWED " S D="" G X
 I $L(X,"^")-1>1 S X=$E(X,2,99) G DIE17
 S X=$P(X,U,2),DIC(0)="E" G OUT
Z ;
 S DL=1,X=0
OUT ;
 I 0[X S DM=DW D FILE G ABORT:DL=1,R
 S DIC="^DD("_DP_"," G OJ:'$D(^DIE(DIEZ,"AB")) S DIEZAB=$S(DL=1:U,1:DNM(DL,0)_U_DNM(DL)) I X?1"@".N,$D(^("AB",DIEZAB,X)) S DNM=^(X) G JMP
 S DDBK=0 I $D(DIE("NO^")),DIE("NO^")["BACK" D DR S DDBK=1,DIC("S")="I $D(^DIE(DIEZ,""AB"",DIEZAB,Y)) D S^DIE0"
 E  S DIC("S")="I $D(^DIE(DIEZ,""AB"",DIEZAB,Y)),DIC(0)[""F""!'$D(^(Y,""///""))"
 S DIC="^DD("_DP_"," D ^DIC S DIC=DIE I Y<0 S D="" W:DDBK !?3,"JUMPING FORWARD NOT ALLOWED "
 I DDBK K DR S DR(1,DP)=^DIE(DIEZ,"ROU"),DR=DI
 K A0,A1,DDBK,DIC,DTOUT G X:Y<0 S DNM=^DIE(DIEZ,"AB",DIEZAB,+Y)
JMP K DIEZAB D FILE S Y=DNM,DNM=$P(Y,U,2),DQ=+Y,D=0 D @("DE^"_DNM) G @Y
 ;
OJ I X?1"@".N,$D(^DIE("AF",X,DIEZ)) S DNM=^(DIEZ)
 E  S DIC("S")="I $D(^DIE(""AF"","_DP_",Y,DIEZ)),DIC(0)[""F""!'$D(^(DIEZ,""///""))" D ^DIC K DIC S DIC=DIE G X:Y<0 S DNM=^DIE("AF",DP,+Y,DIEZ)
 G JMP
F ;
 S DC=$S($D(X)#2:X,1:0) D FILE S X=DC Q
FILE ;
 K DQ Q:$D(DG)<9  S DQ="",DU=-2,DG="$D("_DIE_DA_",DU))"
Y S DQ=$O(DG(DQ)),DW=$P(DQ,";",2) G DE:$P(DQ,";",1)=DU
 I DU'<0 S ^(DU)=DV,DU=-2
 G E1:DQ="" S DU=$P(DQ,";",1),DV="" I @DG S DV=^(DU)
DE I 'DW S DW=$E(DW,2,99),DE=DW-$L(DV)-1,%=$P(DW,",",2)+1,X=$E(DV,%,999),DV=$E(DV,0,DW-1)_$J("",$S(DE>0:DE,1:0))_DG(DQ) S:X'?." " DV=DV_$J("",%-DW-$L(DG(DQ)))_X G Y
PC S $P(DV,U,DW)=DG(DQ) G Y
 ;
IX D:$D(DE(DQ))#2 @DE(DQ)
K K DE(DQ)
E1 S DQ=$O(DE(" ")) I DQ'="" G IX:$D(DG(DQ)),K
 K DG,DE,DIFLD S DQ=0 Q
1 ;
 D FILE
R D UP G @("R"_DQ_U_DNM)
 ;
UP S DNM=DNM(DL),DQ=DNM(DL,0) K DTOUT,DNM(DL) I $D(DIEC(DL)) D DIEC^DIE1 G U
 S DIEL=DIEL-1,%=2,DA=DA(1) K DA(1)
DA I $D(DA(%)) S DA(%-1)=DA(%) K DA(%) S %=%+1 G DA
 S DIIENS=$P(DIIENS,",",2,999)
U S DL=DL-1 Q
 ;
X W:X'["?"&'$D(ZTQUEUED) $C(7),"??" G Z:$D(DB(DQ))
B G @(DQ_U_DNM)
N ;
 D DOWN S DA=$P(DC,U,4),$P(DIIENS,",")=DA,D=0 S ^DISV(DUZ,$E(DIC,1,28))=$E(DIC,29,999)_DA
D1 S @("D"_DIEL)=DA G @(DGO)
M ;
 S DD=X D DOWN S DO(2)=$P(DC,"^",2),DO=DOW_"^"_DO(2)_"^"_$P(DC,"^",4,5),DIC(0)="LM"_$S($D(DB(DNM(DL,0))):"X",1:"QE") I @("'$D("_DIC_"0))") S ^(0)="^"_DO(2)
 E  I DO(2)["I" S %=0,DIC("W")="" D W^DIC1
 K DIC("PTRIX") M DIC("PTRIX")=DIE("PTRIX")
 K DICR S D="B",DLAYGO=DP\1,X=DD D X^DIC K DIC("PTRIX")
 I Y>0 S DA=+Y,$P(DIIENS,",")=DA,X=$P(Y,U,2),D=$P(Y,U,3) G D1
 D UP G @(DQ_U_DNM)
 ;
DOWN S DL=DL+1,DNM(DL)=DNM,DNM(DL,0)=DQ D FILE
 F %=DL+1:-1:1 I $D(DA(%)) S DA(%+1)=DA(%)
 S DA(1)=DA,DIC=DIE_DA_","""_$P(DC,U,3)_""",",DIEL=DIEL+1,DIIENS=","_DIIENS Q
ABORT D E S Y(DM)="" Q
0 ;
 D FILE
E D FIREREC K:$D(DIEZTMP)#2 @DIEZTMP
 K DIP,Y,DE,DOW,DB,DP,DW,DU,DC,DV,DH,DIL,DNM,DIEZ,DLB,DIEL,DGO,DICRREC Q
DR ;
 N F,DA I $E(DR)="[" S %X="^DIE(DIEZ,""DR"",",%Y="DR(" D %XY^%RCR S DR=DR(DL,DP) Q
 S F=0 D DICS^DIA F DDW=1:1 S DDW1=$P(DR,";",DDW) Q:DDW1=""  I $D(^DD(DI,+DDW1,0)),+$P(^(0),U,2)!(DDW1[":") S X=+DDW1,D(F)=+$P(DDW1,":",2) S:'D(F) D(F)=X D RANGE^DIA1
 K DDW,DDW1 Q
 ;
FIREREC ;Fire the record level xrefs
 Q:'$D(DIEZRXR)&$S($D(DIEZTMP)#2:'$D(@DIEZTMP@("R")),1:1)
 N DA,DIE,DIEZXR,DIIENS,DIKEY,DP
 ;
 S DP=0 F  S DP=$O(DIEZRXR(DP)) Q:'DP  D
 . S DIIENS=" " F  S DIIENS=$O(DIEZRXR(DP,DIIENS)) Q:DIIENS=""  D
 .. S DIE=DIEZRXR(DP,DIIENS)
 .. D DA^DILF(DIIENS,.DA)
 .. S DIEZXR=0 F  S DIEZXR=$O(DIEZRXR(DP,DIEZXR)) Q:DIEZXR'=+DIEZXR  D
 ... I $D(DIEZAR(DP,DIEZXR))#2 N DIEXEC S DIEXEC="K" D @DIEZAR(DP,DIEZXR)
 ;
 ;Fire record level indexes for triggered fields not in the template
 S DP=0 F  S DP=$O(@DIEZTMP@("R",DP)) Q:'DP  D
 . S DIIENS=" " F  S DIIENS=$O(@DIEZTMP@("R",DP,DIIENS)) Q:DIIENS=""  D
 .. D DA^DILF(DIIENS,.DA)
 .. D FIRE^DIKC(DP,.DA,"KS",$NA(@DIEZTMP@("R")),"F^^K",.DIKEY,$E("C",$G(DIOPER)="A"))
 ;
 ;If any keys are invalid, restore values
 D:$D(DIKEY)>9 RESTORE^DIE1(.DIKEY,DIEZTMP)
 ;
 K DIEFIRE,DIEZRXR,@DIEZTMP@("V")
 Q
 ;
 ;===========
 ;  $$UNIQUE
 ;===========
 ;Called from compiled routine.
 ;Look at actual (untruncated) values in the matching indexes.
 ;Return 1 if unique.
 ;In:
 ; DIUIR    = Root of matching uniqueness index
 ; DISETX   = Entry point to set X array
 ; DIMAXL(order#) = max length of subscript with order #
 ;
UNIQUE(X,DA,DIUIR,DISETX,DIMAXL) ;
 N DIDASV,DIIENS,DIIENSC,DINDX,DINS,DIUNIQ,DIXSV,I,O
 ;
 M DIDASV=DA,DIXSV=X
 S DIIENSC=$$IENS(.DA)
 ;
 S DIUNIQ=1,DINS=$QL(DIUIR),DINDX=DIUIR
 F  S DINDX=$Q(@DINDX) Q:$NA(@DINDX,DINS)'=DIUIR  D  Q:'DIUNIQ
 . ;Set DA array, quit if this is index for current record
 . S DIIENS=$E(DINDX,$L(DIUIR)+1,$L(DINDX)-1),L=$L(DIIENS,",")
 . S DA=$P(DIIENS,",",L) F I=1:1:L-1 S DA(I)=$P(DIIENS,",",L-I)
 . S DIIENS=$$IENS(.DA) Q:DIIENS=DIIENSC
 . I '$D(DIMAXL) S DIUNIQ=0 Q
 . ;
 . ;Set the X array for the indexed record and compare
 . D @(DISETX_"(""ONFILE"")")
 . S O=0 F  S O=$O(DIMAXL(O)) Q:'O  Q:X(O)'=DIXSV(O)
 . S:'O DIUNIQ=0
 ;
 K DA,X M DA=DIDASV,X=DIXSV
 Q DIUNIQ
 ;
UNIQFERR ;The field is part of a key and is not unique
 I '$D(ZTQUEUED),'$D(DDS) D
 . W $C(7)_"??"
 . W:'$D(DB(DQ)) !,"     ",$$EZBLD^DIALOG(3094)
 K DIEFXREF S ^("N")=@DIEZTMP@("V",DP,DIIENS,DIFLD,"O")
 G:$D(DB(DQ)) Z
 S X="?BAD"
 G @("QS^"_DNM)
 ;
IENS(DA) ;Return IENS from DA array
 N I,IENS
 S IENS=$G(DA)_"," F I=1:1:$O(DA(" "),-1) S IENS=IENS_DA(I)_","
 Q IENS
 ;
TRIG ;Save info for record level indexes on a triggered field.
 ;Called by DICR (via @DICRREC)
 N DIE,DIE17RXR,OLD,XR
 S OLD=DIU
 ;
 ;Get record level indexes on triggered field
 D LOADFLD^DIKC1(DIH,DIG,"KS","",$NA(@DIEZTMP@("V")),"","DIE17RXR","",.RLIST,"f")
 Q:RLIST=""
 ;
 S DIE=$$OREF^DILF($NA(@$$FROOTDA^DIKCU(DIH)))
 I $D(^DIE("AF",DIH,DIG,DIEZ)) D
 . N N,PC,RL,XR
 . S RL=RLIST
 . F  D  Q:RL=""
 .. F PC=1:1:$L(RL,U) S XR=$P(RL,U,PC) S:XR DIEZRXR(DIH,XR)=""
 .. S N=$G(N)+1,RL=$G(RLIST(N))
 . S DIEZRXR(DIH,DICRIENS)=DIE
 E  M @DIEZTMP@("R")=DIE17RXR S @DIEZTMP@("R",DIH,DICRIENS)=DIE
 ;
 ;Save the old value of the field
 S @DIEZTMP@("V",DIH,DICRIENS,DIG,"O")=OLD S:$D(^("F"))[0 ^("F")=OLD
 Q
