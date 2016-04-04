DICATT4 ;SFISC/XAK-DELETE A FIELD ;12:39 PM  7 Mar 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**26,52,82,106**
 ;
DIEZ S DI=A,DA=D0 D DIPZ^DIU0
 K ^DD(A,0,"ID",D0),^DD(A,0,"SP",D0)
EN I $O(@(I(0)_"0)"))>0 D
 .N X,T,Y,Z,MUL
 .S MUL=+$P(O,U,2)
 .S %=1,Y=$P(O,U,4),X=$P(Y,";"),Y=$P(Y,";",2),Z=$S(+X=X:X,1:""""_X_"""")_")",E="^("_Z
 .I $O(^DD(A,"GL",X,""))="" S T="K ^(M,"_Z G F
 .I Y S T="U_$P("_E_",U,"_(Y+1)_",999) K:"_E_"?.""^"" "_E S:Y>1 T="$P("_E_",U,1,"_(Y-1)_")_U_"_T
 .E  S X=+$E(Y,2,4),Y=+$P(Y,",",2) Q:'X!'Y  S T="$E("_E_",1,"_(X-1)_")_$J("""","_(Y-X+1)_")_$E("_E_","_(Y+1)_",999)"
 .S T="I $D(^(M,"_Z_")#2 S "_E_"="_T
F .I '$D(DIU(0)) W $C(7),!,"OK TO DELETE '",$P(M,U),"' FIELDS IN THE EXISTING ENTRIES" D YN^DICN I %-1 D:'$D(DIU) DELXRF(A,D0) Q
KILLIX .I $D(DICATT4M) D  S M="" F  S M=$O(^DD(J(0),0,"IX",M)) Q:M=""  I $O(^(M,MUL,0)) K @(I(0)_""""_M_""")")
 ..D INDEX^DIKC(J(0),"","","","KiRW"_MUL)
 .E  D:'$D(DIU) DELXRF(A,D0,1,J(0))
 .S M="",X=DICL,Y=I(0) I $D(DQI) K @(I(0)_""""_DQI_""")")
L .S O="M" S:X O=O_"("_X_")" S Y=Y_O,M=M_"F "_O_"=0:0 S "_O_"=$O("_Y_")) Q:"_O_"'>0  "
 .S X=X-1 I X+1 S Y=Y_","_I(DICL-X)_"," G L
 .S M=M_"X T"_$P(" W "".""",U,$S('$D(DIU(0)):1,DIU(0)["E":1,1:0))
 .X M ;HERE'S THE LOOP WHERE WE KILL THE VALUES!
N Q:$D(DIU)!$D(DICATT4M)  G N^DICATT
 ;
NEW ;Delete the data in the multiple
 S DICATT4M=$NA(^DD(A,D0))
 S DICATT4M("SB")=$NA(^DD(A,"SB",+$P(O,U,2),D0))
 S ^DD(A,D0,0)=O,^DD(A,"SB",+$P(O,U,2),D0)=""
 D DICATT4
 K @DICATT4M,@DICATT4M("SB"),DICATT4M
 ;
 ;Kill the DD globals and go back to N^DICATT
 D KDD G N^DICATT
 ;
VP ; VARIABLE POINTER
 S DA(2)=DA(1),DA(1)=DA,DICATT=DA I $D(DICS) S DICSS=DICS K DICS
V S DA(2)=A,DA(1)=DICATT,DIC="^DD("_A_","_DICATT_",""V"",",DIC("P")=".12P",DIC(0)="QEAMLI",DIC("W")="W:$S($D(^DIC(+^(0),0)):$P(^(0),U)'=$P(^DD(DA(2),DA(1),""V"",+Y,0),U,2),1:0) ?30,$P(^(0),U,2)" D ^DIC S DIE=DIC K DIC
 I Y>0 S DA=+Y,Z="P",DR=".01:.04;"_$S($P($G(^DD(+$P(Y,U,2),0,"DI")),U,2)["Y":".06///n",1:".06T")_";S:DUZ(0)'=""@"" Y=0;.05;I ""n""[X K ^DD(DA(2),DA(1),""V"",DA,1),^(2) S Y=0;S DIE(""NO^"")=""BACK"";1;2;" S:$P(Y,U,3) DIE("NO^")=""
 I Y>0 D ^DIE K DIE W ! S:$D(DTOUT) DA=DICATT G CHECK^DICATT:$D(DTOUT),V
 S Z="V^",DIZ=Z,C="Q",L=18,DA=DICATT,DA(1)=A S:$D(DICSS) DICS=DICSS K DICSS,DR,DIE,DA(2),DICATT G CHECK^DICATT:$D(DTOUT)!(X=U),^DICATT1
 Q
HELP ;
 W !?5,"Enter a MUMPS statement that sets DIC(""S"") to code that sets $T."
 W !?5,"Those entries for which $T=1 will be selectable."
 I Z?1"P".E D  Q
 . W !?5,"The naked reference will be at the zeroeth node of the pointed to"
 . W !?5,"file, e.g., ^DIZ(9999,Entry Number,0).  The internal entry number"
 . W !?5,"of the entry that is being processed in the pointed to file will be"
 . W !?5,"in the variable Y."
 W !?5,"The variable Y will be equal to the internally-stored code of the item"
 W !?5,"in the set which is being processed."
 Q
KDD ;
 I '$D(DIANC) S X=A F  S DIANC(X)="" Q:$D(^DD(X,0,"UP"))[0  S X=^("UP")
 S DQ=$O(DQ(0)),X=0 I DQ="" S DQ=-1 K DIANC Q
 D KIX(.DIANC,DQ)
 F  S X=$O(^DD(DQ,"SB",X)) Q:'X  S DQ(X)=0
 N DIFLD S DIFLD=0 F  S DIFLD=$O(^DD(DQ,DIFLD)) Q:'DIFLD  D
 . I $D(^DD(DQ,DIFLD,9.01)) S X=^(9.01),Y=DIFLD D KACOMP
 . D KTRB(.DIANC,DQ,DIFLD)
 . S X=$P($G(^DD(DQ,DIFLD,0)),U,2) I X'["P",X'["V" Q
 . I X["P" S X=+$P(X,"P",2) K:X ^DD(X,0,"PT",DQ,DIFLD) Q
 . F %=0:0 S %=$O(^DD(DQ,DIFLD,"V",%)) Q:'%  S X=+$G(^(%,0)) K:X ^DD(X,0,"PT",DQ,DIFLD)
 . Q
 K DQ(DQ),^DD(DQ),^DD("ACOMP",DQ),^DDA(DQ)
 S Y=0 F  S Y=$O(DIANC(Y)) Q:'Y  K ^DD(Y,"TRB",DQ)
 D DELXR(DQ)
 S Y=0 F  S Y=$O(^DIE("AF",DQ,Y)) Q:Y=""  S %=0 F  S %=$O(^DIE("AF",DQ,Y,0)) Q:%=""  K ^(%),^DIE(%,"ROU")
 S Y=0 F  S Y=$O(^DIPT("AF",DQ,Y)) G KDD:Y="" S %=0 F  S %=$O(^DIPT("AF",DQ,Y,0)) Q:%=""  K ^(%),^DIPT(%,"ROU")
 ;
KIX(DIANC,DIFIL) ;
 N F,NM
 S F=0 F  S F=$O(DIANC(F)) Q:'F  D
 . S NM="" F  S NM=$O(^DD(F,0,"IX",NM)) Q:NM=""  K:$D(^(NM,DIFIL)) ^(DIFIL)
 Q
KACOMP N DA,I,% S DA(1)=DQ,DA=Y X ^DD(0,9.01,1,1,2) Q
 ;
KTRB(DIANC,DIFIL,DIFLD) ;Kill 5 node of triggered field
 ;Also kill "TRB" nodes here if triggered field is in another file
 N %,F,DITFLD,DITFIL,DIXR,DIXR0
 S DIXR=0
 F  S DIXR=$O(^DD(DIFIL,DIFLD,1,DIXR)) Q:'DIXR  S DIXR0=$G(^(DIXR,0)) D:$P(DIXR0,U,3)="TRIGGER"
 . S DITFIL=$P(DIXR0,U,4),DITFLD=$P(DIXR0,U,5) Q:'DITFIL!'DITFLD
 . S %=0
 . F  S %=$O(^DD(DITFIL,DITFLD,5,%)) Q:'%  I $P($G(^(%,0)),U,1,3)=(DIFIL_U_DIFLD_U_DIXR) D  Q
 .. K ^DD(DITFIL,DITFLD,5,%) Q:DITFIL=DIFIL!$D(DIANC(DITFIL))
 .. S F=DITFIL
 .. F  K ^DD(F,"TRB",DIFIL) S F=$G(^DD(F,0,"UP")) Q:'F!$D(DIANC(+F))
 Q
DELXR(DIFIL) ;Delete the Key and Index file entries for file DIFIL
 Q:'$G(DIFIL)
 N DA,DIK
 ;
 ;Kill keys on file DIFIL
 S DIK="^DD(""KEY"","
 S DA=0 F  S DA=$O(^DD("KEY","B",DIFIL,DA)) Q:'DA  D ^DIK
 ;
 ;Kill indexes on file DIFIL
 S DIK="^DD(""IX"","
 S DA=0 F  S DA=$O(^DD("IX","AC",DIFIL,DA)) Q:'DA  D ^DIK
 Q
 ;
DELXRF(DIFIL,DIFLD,DIFLG,DITOPFIL) ;Delete Keys and Indexes on field
 ;If DIFLG=1, also delete the Indexes from the data global.
 Q:'$G(DIFIL)!'$G(DIFLD)
 N DA,DIK
 ;
 ;Execute the kill logic for all indexes defined on the field
 ;for all entries in the file.
 I $G(DIFLG) D
 . S:$G(DITOPFIL)="" DITOPFIL=$$FNO^DILIBF(DIFIL)
 . D:DITOPFIL INDEX^DIKC(DITOPFIL,"",DIFLD,"","RKW"_DIFIL)
 ;
 ;Kill keys on file/field
 S DIK="^DD(""KEY"","
 S DA=0 F  S DA=$O(^DD("KEY","F",DIFIL,DIFLD,DA)) Q:'DA  D ^DIK
 ;
 ;Kill indexes on file/field
 S DIK="^DD(""IX"","
 S DA=0 F  S DA=$O(^DD("IX","F",DIFIL,DIFLD,DA)) Q:'DA  D ^DIK
 Q
