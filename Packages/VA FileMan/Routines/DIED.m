DIED ;SFISC/GFT,XAK-MAJOR INPUT PROCESSOR ;3FEB2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,21,11,59,96,999,1004,1022**
 ;
O D W W Y W:$X>48 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 I Y]"" W "// " I 'DV,DV["I",$D(DE(DQ))#2 K X S X("FIELD")=DIFLD,X("FILE")=DP,X="  ("_$$EZBLD^DIALOG(3090,$$LABEL^DIALOGZ(DP,DIFLD))_")" W:$L(X)+$X>78 !?9 W X K X S X="" Q  ;**
TR Q:$P(DQ(DQ),U,2)["K"&(DUZ(0)'="@")  R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
W I $P(DQ(DQ),U,2)["K"&(DUZ(0)'="@") Q
 I $D(DIE("W")) X DIE("W") Q
 W !?DL+DL-2,$P(DQ(DQ),U,1)_": " Q
 ;
DQ ;
 S:$D(DTIME)[0 DTIME=300 S DQ=1 G B
A K DQ(DQ) S DQ=DQ+1
B S DIFLD=$S($D(DIFLD(DQ)):DIFLD(DQ),1:-1)
 I '$D(DQ(DQ)) G E^DIE1:'$D(DQ(0,DQ)),BR^DIE0
RE ;
 S DIP=$P(DQ(DQ),U,1),DV=$P(DQ(DQ),U,2),DU=$P(DQ(DQ),U,3) G:DV["K"&(DUZ(0)'="@") A G PR:$D(DE(DQ)) D W,TR I $D(DTOUT) K DQ,DG G QY^DIE1
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:$P(DC,U,2)-DP(0),A
RD G ^DIE0:X[U,^DIE2:X="@" I X?."?" G A:$D(DB(DQ)),^DIEQ ;MAC-1201-61253
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DIP)) S X=^(DIP) I DV'["D",DV'["S" W "  "_X
T G M^DIE1:DV,^DIE3:DV["V",P:DV'["S" I X?.ANP D SET I 'DDER G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G AST:DV["*" D NOSCR S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5,99)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V S DIER=1 X $P(DQ(DQ),U,5,99) K DIER,YS
UNIQ I $P(DQ(DQ),U,2)["U",$D(X),DIFLD=.01 K % M %=@(DIE_"""B"",X)") K %(DA) K:$O(%(0)) X
Z K DIC("S"),DLAYGO I $D(X),X?.ANP,X'=U D LOADXR G:'$$KEYCHK UNIQFERR S DG($P(DQ(DQ),U,4))=X S:DV["d" ^DISV(DUZ,"DIE",DIP)=X G A
X W:'$D(ZTQUEUED) $C(7) W:'$D(DDS)&'$D(ZTQUEUED) "??"
 G B^DIE1
 ;
PR I $D(DE(DQ,0)) S Y=DE(DQ,0) G F:Y?1"/".E I $D(DE(DQ))=10 D Y:$E(Y)=U,O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
 S DG=DV,Y=DE(DQ),X=DU I DG["O",$D(^DD(DP,DIFLD,2)) X ^(2) G S
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G S:'$D(^(Y,0)) S Y=$P(^(0),U,1),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G S:'$D(^(+Y,0)) S Y=$P(^(0),U,1) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") I %]"" S Y=$S($G(DUZ("LANG"))'>1:%,'DIFLD:%,1:$$SET^DIQ(DP,DIFLD,Y))
S D O I $D(DTOUT) K DQ,DG G QY^DIE1
 I X="" S X=DE(DQ) X:$D(DICATTZ) $P(DQ(DQ),U,5,99) G A:'DV,A:DC<2 G N^DIE1
 G RD:DQ(DQ)'["DINUM" D E^DIE0 G RD:$D(X),PR
 ;
F S DB(DQ)=1,X=$E(Y,2,999),DH=$F(DQ(DQ),"%DT=""E") I DH S DQ(DQ)=$E(DQ(DQ),1,DH-2)_$E(DQ(DQ),DH,999)
 I X?1"/".E S X=$E(X,2,999),DH=""
 X:$E(X,1)=U $E(X,2,999) G:X="" A:'DV,A:'$P(DC,U,4),N^DIE1 I $D(DE(DQ))#2,DV["I"!(DQ(DQ)["DINUM") D E^DIE0
 G X:'$D(X),RD:DH]"",RD:X="@",M^DIE1:DV,Z
 ;
Y X $E(Y,2,999) S Y=X I DV["D",Y?7N.NP X ^DD("DD")
Q Q
 ;
SET ;FROM COMPILED TEMPLATES,TOO
 N DIR,DILANG
 I $D(DB(DQ)),'$D(DIQUIET) N DIQUIET S DIQUIET=1
 I $G(DUZ("LANG"))>1,$D(^DD(DP,+$G(DIFLD),0)) S DILANG=$$SETIN^DIALOGZ D
 .I DILANG'=DU S DU=DILANG Q
 .K DILANG
 S DIR(0)="SV"_$E("o",$D(DB(DQ)))_U_DU,DIR("V")=1 S:$D(DIC("S")) DIR("S")=DIC("S") D ^DIR Q:DDER
 I $D(DILANG) S %=$F(";"_DILANG,";"_Y) I % S Y=$P($P($P(^DD(DP,DIFLD,0),U,3),";",Y),":") ;Return the 'REAL' internal value
 S %=Y(0),X=Y
 I $D(^DD(DP,DIFLD,12.1)) X ^(12.1) I $D(DIC("S")) X DIC("S") E  S DDER=1 Q
 W:'$D(DB(DQ)) "  "_%
 Q
 ;
 ;
AST ;G V:DV["'",AST^DIE9
 I DV["'" D
 . D SCRNL(.DICONT)
 E  D SCRL(.DICONT)
 I DICONT="V" K DICONT G V:$D(DNM)[0,@("V^"_DNM)
 I DICONT="X" K DICONT G X:$D(DNM)[0,@("X^"_DNM)
 I DICONT="Z" K DICONT G Z:$D(DNM)[0,@("Z^"_DNM)
 Q
 ;
RW G RW^DIR2
 ;
LOADXR ;Load all index file xrefs for a field
 Q:$D(DIETMP)[0
 N FLIST,RLIST,OLD
 ;
 I $G(DICRREC)]"" N DP,DIFLD,DIIENS S OLD=DIU,DP=DIH,DIFLD=DIG,DIIENS=DICRIENS
 E  S OLD=$G(DE(DQ))
 ;
 ;Get field- and record-level xrefs
 D LOADFLD^DIKC1(DP,DIFLD,"KS","",$NA(@DIETMP@("V")),"DIEFXREF",$NA(@DIETMP@("R")),.FLIST,.RLIST)
 I FLIST="",RLIST="" Q
 S:RLIST]"" @DIETMP@("R",DP,DIIENS)=DIE
 ;
 ;Save the old value of the field
 S @DIETMP@("V",DP,DIIENS,DIFLD,"O")=OLD S:$D(^("F"))[0 ^("F")=OLD
 I $G(DICRREC)="",$G(DE(DQ,0))?1"//".E S @DIETMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIETMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
 ;
KEYCHK() ;If this is a key field, return 0 if not unique.
 N DIEKCHK
 Q:$D(DIETMP)[0 1
 Q:'$D(DIEFXREF) 1
 Q:$G(DE(DQ,0))?1"//".E 1
 S @DIETMP@("V",DP,DIIENS,DIFLD,"N")=X
 S DIEKCHK=$$KEYCHK^DIKK2(DP,.DA,DIFLD,"DIEFXREF",DIIENS,"","N")
 K @DIETMP@("V",DP,DIIENS,DIFLD,"N")
 Q DIEKCHK
 ;
UNIQFERR ;The field is part of a key and is not unique
 I '$D(ZTQUEUED),'$D(DDS) D
 . W $C(7)_"??"
 . W:'$D(DB(DQ)) !,"     ",$$EZBLD^DIALOG(3094)
 K DIEFXREF S ^("N")=@DIETMP@("V",DP,DIIENS,DIFLD,"O")
 G B^DIE1
 ;
NKEY ;No value was assigned to this key field
 I '$D(ZTQUEUED),'$D(DDS) W $C(7)_"??  ",$$EZBLD^DIALOG(3092.2)
 G B^DIE1
 ;
NOSCR ;No screen
 N DIXRL
 D GETXRL(DP,DIFLD,+$P(DV,"P",2),.DIXRL)
 I DV'["'",$G(DIXRL)]"",(U_DIXRL_U)'["^B^" S DIXRL=DIXRL_"^B"
 D DIC($G(DIXRL))
 Q
 ;
SCRNL(DICONT) ;Screen, No LAYGO allowed
 N DIFRST,DILAST,DIXRL
 K DICONT
 ;
 D GETXRL(DP,DIFLD,+$P(DV,"P",2),.DIXRL)
 G:$G(DIXRL)="" EXIT
 ;
 D:$D(DNM)#2 @("D^"_DNM)
 D PARSE($P(DQ(DQ),U,5,999),.DIFRST,.DILAST)
 G:'$D(DIFRST) EXIT
 ;
 X DIFRST
 D DIC(DIXRL) S X=+Y
 X:Y>0 DILAST
 S DICONT=$S('$D(X):"X",X<0:"X",1:"Z")
 Q
 ;
SCRL(DICONT) ;Screen, LAYGO allowed
 N DICALL,DICSS,DIFRST,DILAST,DIXRL
 K DICONT
 ;
 D GETXRL(DP,DIFLD,+$P(DV,"P",2),.DIXRL)
 D:$D(DNM) @("D^"_DNM)
 D PARSE($P(DQ(DQ),U,5,999),.DIFRST,.DILAST)
 G:'$D(DIFRST) EXIT
 ;
 K D X DIFRST I '$D(DIC("S")),$G(DIXRL)="" S DICONT="V" Q
 S DICSS=$G(DIC("S"))
 ;
 I $G(DIXRL)="" S DIXRL=$G(D)
 E  S:(U_DIXRL_U)'["^B^" DIXRL=DIXRL_"^B"
 D DIC($G(DIXRL))
 S X=+Y
 ;
 I $P(Y,U,3) S Y=+Y X:$D(@(DIC_Y_",0)")) DICSS E  D  S DICONT="X" Q
 . N DV,DU,DA
 . S DA=Y,DIK=DIC D ^DIK
 ;
 X:Y>0 DILAST
 S DICONT=$S('$D(X):"X",X<0:"X",1:"Z")
 Q
 ;
EXIT ;Cleanup and set flag to continue by executing the input transform
 K DIC("PTRIX")
 S DICONT="V"
 Q
 ;
DIC(D) ;Make the appropriate ^DIC call based on D
 I $G(D)]"",$P(D,U,2)="" S DIC(0)=$TR(DIC(0),"M")
 E  S:DIC(0)'["M" DIC(0)="M"_DIC(0)
 ;
 I $P($G(D),U)="" D
 . D ^DIC
 E  I $P(D,U,2)]"" D
 . D MIX^DIC1
 E  D IX^DIC
 K DIC("PTRIX")
 Q
 ;
PARSE(IT,FRST,LAST) ;Parse input transform
 N CALL,I
 F CALL=" D ^DIC"," D IX^DIC"," D MIX^DIC1","" Q:IT[CALL
 I CALL="" K FRST,LAST Q
 S FRST=$P(IT,CALL),LAST=$P(IT,CALL_" ",2,999)
 I FRST?.E1" " D  S FRST=$E(FRST,1,I)
 . F I=$L(FRST)-1:-1:0 Q:$E(FRST,I)'=" "
 Q
 ;
GETXRL(FIL,FLD,PFIL,LIST) ;Get list of indexes from DIE("PTRIX")
 K DIC("PTRIX"),LIST Q:'$D(DIE("PTRIX"))
 M DIC("PTRIX")=DIE("PTRIX")
 ;
 S LIST=$G(DIE("PTRIX",FIL,FLD,PFIL))
 K:LIST="" LIST
 Q
