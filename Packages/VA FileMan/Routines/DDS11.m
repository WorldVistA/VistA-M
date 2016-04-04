DDS11 ;SFISC/MLH,MKO-LOAD DATA ;2015-01-02  6:19 PM; LOAD DATA TO BE SHOWN ON SCREEN
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1005,151**
 ;
 ;Input variables:
 ;  DDSBK   = Block #
 ;  DDSPG   = Page # (needed for form-only fields)
 ;  DDSREFT = Temporary global location
 ;  DDP     = File number of block
 ;  DIE     = Global root of block
 ;  DDSDA   = DA,DA(1),...
 ;  DDSNFO  = Flag means don't reload form only fields
 ;
EN(DDSBK,DDSNFO) ;replace call to top of routine
 ;
 N X,Y
 S DDS1REFD=$NA(@DDSREFT@("F"_DDP,DDSDA))
 ;
 S DDS1FO=0
 F  S DDS1FO=$O(^DIST(.404,DDSBK,40,DDS1FO)) Q:'DDS1FO  D LD
 ;
 I DDP,DDSDA S @DDS1REFD@("GL")=DIE
 ;
 K DDS1REFD,DDS1FLD,DDS1FO,DDS1KEY,DDS1LN,DDS1ND,DDS1PC,DDS1UI,DDS1DV
 K DDS1D1,DDS1D2,DDS1D3
 Q
 ;
LD ;Load data for a field
 ;
 ;Get form only fields
 I $P($G(^DIST(.404,DDSBK,40,DDS1FO,0)),U,3)=2,$P($G(^(20)),U)]"" D  Q
 . Q:$G(DDSNFO)
 . N DDP
 . S DDP=0,DDS1FLD=DDS1FO_","_DDSBK
 . Q:"^1^3^"[(U_$G(@DDSREFT@("F0",DDSDA,DDS1FLD,"F"))_U)
 . S Y=""
 . I $D(@DDSREFT@("F0",DDSDA,DDS1FLD,"F"))[0,$G(^DIST(.404,DDSBK,40,DDS1FO,3))]"" D DEF(^(3),$G(^(3.1)))
 . S (@DDSREFT@("F0",DDSDA,DDS1FLD,"D"),^("O"))=Y
 ;
 ;Get DD fields
 S DDS1FLD=$G(^DIST(.404,DDSBK,40,DDS1FO,1)) Q:DDS1FLD?."^"
 Q:"^1^3^"[(U_$G(@DDS1REFD@(DDS1FLD,"F"))_U)
 ;
 S DDS1LN=$G(^DD(DDP,DDS1FLD,0)) Q:DDS1LN?."^"
 S DDS1PC=$P(DDS1LN,U,4),DDS1ND=$P(DDS1PC,";"),DDS1PC=$P(DDS1PC,";",2)
 S DDS1DV=$P(DDS1LN,U,2),X=$P(DDS1LN,U,3)
 ;
 D @($S(DDS1FLD=.001:"L3",DDS1PC=0:"L2",1:"L1"))
 ;
 I DDS1DV["O"!(DDS1DV["P")!(DDS1DV["V")!(DDS1DV["D")!(DDS1DV["S") D
 . Q:$D(@DDS1REFD@(DDS1FLD,"X"))
 . D:Y]"" XFORM
 . S @DDS1REFD@(DDS1FLD,"X")=Y
 ;
 I DDS1PC=0,DDS1DV,DDS1DV'["W",$D(@DDS1REFD@(DDS1FLD,"X"))[0 S ^("X")=Y
 Q
 ;
L1 ;Get non-multiple field
 S DDS1LN=$G(@(DIE_"DA,DDS1ND)"))
 I $E(DDS1PC)'="E" S Y=$P(DDS1LN,U,DDS1PC)
 E  S Y=$E(DDS1LN,+$E(DDS1PC,2,999),$P(DDS1PC,",",2)) S:Y?." " Y=""
 ;
 K @DDS1REFD@(DDS1FLD,"X")
 I Y="",$D(@DDS1REFD@(DDS1FLD,"F"))[0,$D(^DIST(.404,DDSBK,40,DDS1FO,3))#2 D DEF(^(3),$G(^(3.1)))
MUMPS I $G(DUZ(0))'="@",DDS1DV["K" S $P(@DDS1REFD@(DDS1FLD,"A"),U,4)=1,Y=$TR($J("",$L(Y))," ","*") ;**151
 S @DDS1REFD@(DDS1FLD,"D")=Y
 ;
 ;Get key info
 I '$D(@DDS1REFD@(DDS1FLD,"K")) D
 . S DDS1KEY=0
 . F  S DDS1KEY=$O(^DD("KEY","F",DDP,DDS1FLD,DDS1KEY)) Q:'DDS1KEY  D
 .. S DDS1UI=$P(^DD("KEY",DDS1KEY,0),U,4) Q:'DDS1UI
 .. Q:$P($G(^DD("IX",DDS1UI,0)),U,6)'="F"
 .. S ^("K")=$G(@DDS1REFD@(DDS1FLD,"K"))_DDS1UI_U
 Q
 ;
L2 ;Get multiple field
 S DDS1SUB=+$P(DDS1LN,U,2) Q:$D(^DD(DDS1SUB,.01,0))[0
 S DDS1DV=DDS1SUB_$P(^DD(DDS1SUB,.01,0),U,2),X=$P(^(0),U,3)
 S DDS1DIC=DIE_DA_","""_DDS1ND_""","
 ;
 D:DDS1DV'["W"
 . I $D(^DIST(.404,DDSBK,40,DDS1FO,3))#2 D  D L22
 .. D DEF(^DIST(.404,DDSBK,40,DDS1FO,3),$G(^(3.1)),1)
 .. S DDS1RN=$S($G(Y)="FIRST":$O(@(DDS1DIC_"0)")),$G(Y)="LAST":$O(@(DDS1DIC_""" "")"),-1),1:+$G(Y))
 . E  I $D(DUZ)#2,$L(DDS1DIC)<29,$D(^DISV(DUZ,DDS1DIC))#2 S DDS1RN=^(DDS1DIC) D L22
 . E  S DDS1RN=$S($D(@(DDS1DIC_"0)"))#2:$P(^(0),U,3),1:$O(^(0))) D L22
 . E  S (Y,@DDS1REFD@(DDS1FLD,"D"))=""
 ;
 S @DDS1REFD@(DDS1FLD,"M")=$S(DDS1DV["W":0,1:1)_DDS1DIC_U_DDS1SUB
 K DDS1DIC,DDS1RN,DDS1SUB
 Q
L22 ;
 I DDS1RN>0,$D(@(DDS1DIC_+DDS1RN_",0)"))#2 S Y=$P(^(0),U),@DDS1REFD@(DDS1FLD,"D")=+DDS1RN
 Q
 ;
DEF(DDS1LN3,DDS1LN31,DDS1MULT) ;Get default
 N DDS1PTR,DDS1OT
 Q:DDS1LN3=""
 I DDS1LN3'="!M" S Y=DDS1LN3
 E  I DDS1LN31'?."^" X DDS1LN31 S:$D(Y)[0 Y=""
 Q:Y=""!$G(DDS1MULT)
 ;
 K DIR
 I DDS1FLD["," D
 . S DIR(0)=$P(^DIST(.404,DDSBK,40,DDS1FO,20),U)_$P(^(20),U,2,3)
 . S:DIR(0)?1"DD".E DIR(0)=$P(DIR(0),U,2,999)
 . I $E($P(DIR(0),U))="P" S DDS1PTR=1
 E  D
 . S DIR(0)=DDP_","_DDS1FLD
 . S DDS1PTR=$P($G(^DD(DDP,DDS1FLD,0)),U,2)
 . S DDS1OT=DDS1PTR["O",DDS1PTR=DDS1PTR["P"
 S DIR("V")="",(X,DIR("B"))=Y
 D ^DIR
 ;
 I DDER S Y=""
 I Y]"" D
 . I $G(DDS1PTR) S Y=$P(Y,U)
 . S $P(@DDSREFT@("F"_DDP,DDSDA,DDS1FLD,"F"),U)=3
 . I $G(DDS1PTR),$G(DDS1OT),$D(^DD(DDP,DDS1FLD,2))#2 K Y(0),Y(0,0)
 . S:$D(Y(0)) @DDSREFT@("F"_DDP,DDSDA,DDS1FLD,"X")=$S($D(Y(0,0))#2:Y(0,0),1:Y(0))
 . S DDSCHG=1
 K DDER,DIR
 Q
 ;
L3 ;Get number field
 S (@DDS1REFD@(.001,"D"),Y)=DA
 Q
 ;
EXT(DDP,DDS1FLD,Y) ;Return external form of Y
 N DDS1DV,X
 S DDS1DV=$P(^DD(DDP,DDS1FLD,0),U,2),X=$P(^(0),U,3)
 I DDS1DV'["O",DDS1DV'["P",DDS1DV'["V",DDS1DV'["D",DDS1DV'["S" Q Y
 I DDS1DV'["O",Y="" Q ""
 D XFORM
 Q Y
 ;
XFORM ;
 N DDS1N
 I DDS1DV["O",+DDS1FLD,$D(^DD(DDP,+DDS1FLD,2))#2 X ^(2) Q
 I DDS1DV["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) Q:'$D(^(Y,0))  S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DDS1DV=$P(^(0),U,2) G XFORM
 I DDS1DV["V",+$P(Y,"E"),$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)"))#2 S X=+$P($P(^(0),U,2),"E") Q:$D(^(+$P(Y,"E"),0))[0  S Y=$P(^(0),U) I $D(^DD(+$P(X,"E"),.01,0))#2 S DDS1DV=$P(^(0),U,2),X=$P(^(0),U,3) G XFORM
 I DDS1DV["D" X ^DD("DD")
 I DDS1DV["S" D
 .I +DDS1FLD,$G(^DD(DDP,+DDS1FLD,0))[X S Y=$$SET^DIQ(DDP,+DDS1FLD,Y) ;FOREIGN-LANGUAGE SET VALUE
 .E  D PARSET^DIQ(X,.Y)
 Q
