DINIT ;SFISC/GFT,XAK-INITIALIZE VA FILEMAN ;1:06 PM  30 Mar 1999
V ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D KL^DINIT6
N ;
 D VERSION N DIFROM S DIFROM=VERSION W !!,X D DT^DICRW
 I $G(^DD("VERSION"))]"",^DD("VERSION")_"z"]](VERSION_"z") D
 . W $C(7),!!,"*** WARNING!!  VA FileMan version "_^DD("VERSION")_" is currently loaded on this system.",!,"This Initialization will bring in VA FileMan version "_VERSION_", an earlier version!!",!!
 S Y=$G(^DD("OS")) I Y,"1,2,3,4,5,6,10,11,12,13,15,"[(Y_",") W $C(7),!!,"Your defined operating system entry "_$P($G(^DD("OS",Y,0)),U)_" does not support the",!,"1995 M Standards.",!!,"You may not initialize VA FileMan V21." G KL^DINIT6
DO W !!,"Initialize VA FileMan now?  NO//" R Y:60 G:Y["^"!("Nn"[$E(Y))!('$T) KL^DINIT6
 I "Yy"'[$E(Y) W !,"Answer YES to begin Initializing VA FileMan" G DO
NA W !!,"SITE NAME: " I $D(^DD("SITE")) W ^("SITE"),"// "
 R X:60 G KL^DINIT6:X="^"!'$T I X="",$D(^("SITE"))#2 S X=^("SITE")
 I X'?1AN.ANP W "  ENTER THE NAME OF THIS INSTALLATION SITE",!! G NA
 S %X=X
NO W !!,"SITE NUMBER: " W:$D(^DD("SITE",1)) ^(1),"// "
 R X:60 G KL^DINIT6:X="^"!'$T I $D(^(1)),X="" S X=^(1)
 S:X>0 ^DD("SITE")=%X,^DD("SITE",1)=X
 I X'>0 W "  ENTER A NUMBER, CORRESPONDING TO YOUR INSTITUTION" G NO
 ;***** REMOVE AFTER V21 INIT *****
 ;D
 ;. N DIREC F DIREC=0:0 S DIREC=$O(^DI(.84,DIREC)) Q:'DIREC  Q:DIREC>10000  K ^DI(.84,DIREC,5)
 ;. Q
 ;*********************************
 K ^DD(0) D ^DINIT0,^DINIT11B
 D OSETC
 W ! S Y=1 D OS G KL^DINIT6:Y<0
 W !!,"Now loading other FileMan files--please wait." G GO
 ;
 ;
OS W ! S DIC="^DD(""OS"",",DIC(0)="IAQE",DIC("A")="TYPE OF MUMPS SYSTEM YOU ARE USING: " I $D(^DD("OS"))#2 S (DITZS,DIC("B"))=^("OS") S:DITZS=7 (DITZS,DIC("B"))=18
 E  S (DITZS,^DD("OS"))=100
 D ^DIC K DIC G Q:Y<0 S (DITZS,^DD("OS"))=+Y
 I $D(^%ZTSK),$D(^%ZOSF("OS"))#2,$D(^("MGR"))#2 D
 . S ZTRTN="OS^%RCR",ZTUCI=^%ZOSF("MGR"),ZTDTH=$H,ZTIO="",ZTSAVE("DITZS")=""
 . S ZTDESC="Set Operating System" D ^%ZTLOAD Q
Q K DITZS,ZTSK Q
VERSION ;
 S VERSION=$P($T(V),";",3),X="VA FileMan V."_VERSION Q
 ;
GO S I=$C(126),DIT=$P($H,",",2)
 S $P(^DIBT(0),U,1,2)="TEMPLATE^.4I",$P(^DIE(0),U,1,2)="TEMPLATE^.4I",$P(^DIPT(0),U,1,2)="TEMPLATE^.4I",^(.01,0)="CAPTIONED^",^("F",1)="S DIC=DCC,DA=D0 D EN^DIQ"
 S ^DIPT(.02,0)="FILE SECURITY CODES^^^1",^("F",1)=".01;L20"_I_"0;R13"_I_31_I_33_I_35_I_34_I_32_I_21_I_20
 S ^DIA(0)="AUDIT^1.1I"
 K ^DD(.4),^(.41),^("^"),^(.403),^(.4031),^(.40315),^(.403115),^(.4032),^(.404),^(.40415),^(.4044),^(.404421),^(1.2)
 K ^DIC(.403),^(.404),^(1.2)
 K ^DD(.44),^(.441),^(.4411),^(.447),^(.448),^(.411),^(.42),^(.81),^DIC(.44),^(.81)
 F I=.2,.4,.401,.402,.5,.6,.83,1.1,1.11,1.12,1.13 K ^DIC(I,"%D")
 K ^DIC(.46),^DD(.46),^(.461),^(.463)
 K ^DIC(.11),^(.31) F I=.11,.111,.112,.114,.31,.312 K ^DD(I)
 F I=1.521,1.52101,1.5211,1.5212,1.5213,1.5214,1.5215,1.5216,1.5217,1.5218,1.5219,1.52191,1.52192 K ^DIC(I),^DD(I)
 G ^DINIT0F0
 ;
OSETC ;BRING IN MUMPS OS, DIALOG & LANGUAGE DD AND DATA FOR FILEMAN
 N DN,R,D,DDF,DDT,DTO,DFR,DFN,DTN,DMRG,I,Z,D0
 W !!,"Now loading MUMPS Operating System File"
 D ^DINIT21,OSDD^DINIT24
 S ^DIC(.7,0)="MUMPS OPERATING SYSTEM^.7",^(0,"GL")="^DD(""OS""," D A^DINIT3
 S ^DIC(.7,"%D",0)="^^5^5^2940908^"
 S ^DIC(.7,"%D",1,0)="This file stores operating system-specific code.  Since the code to invoke"
 S ^DIC(.7,"%D",2,0)="some operating system utilities that FileMan uses varies among operating"
 S ^DIC(.7,"%D",3,0)="systems, code to perform these utilities is stored in and executed from"
 S ^DIC(.7,"%D",4,0)="this file.  During the FileMan INIT process an operating system is"
 S ^DIC(.7,"%D",5,0)="selected so that FileMan knows which entry to use from this file."
 K ^DD("OS","B"),DA,DIK S DA(1)=.7 S DIK="^DD(.7," D X^DINIT3
 K DA,DIK S DIK="^DD(""OS""," D X^DINIT3
 D
 . N I,DA,DIK F I=1,2,3,4,5,6,7,10,11,12,13,14,15 S DA=I,DIK="^DD(""OS""," D ^DIK
 . Q
 ;
 K ^UTILITY(U,$J),^UTILITY("DIK",$J) W !!,"Now loading DIALOG and LANGUAGE Files"
 S DN="^DINIT" F R=1:1:39 D @(DN_$$B36(R)) W "."
 S $P(^DIC(.84,0),U,1,2)="DIALOG^.84",$P(^DI(.84,0),U,1,2)="DIALOG^.84I" I $D(^DIC(.84,0,"GL")) D A1^DINIT3
 S $P(^DIC(.85,0),U,1,2)="LANGUAGE^.85",$P(^DI(.85,0),U,1,2)="LANGUAGE^.85I" I $D(^DIC(.85,0,"GL")) D A1^DINIT3
 F I=.84,.841,.842,.844,.845,.847,.8471,.85 D XX^DINIT3
 D DATA
 Q
 ;
DATA W "." S (D,DDF(1),DDT(0))=$O(^UTILITY(U,$J,0)) Q:D'>0
 S DTO=0,DMRG=1,DTO(0)=^(D),Z=^(D)_"0)",D0=^(D,0),@Z=D0,DFR(1)="^UTILITY(U,$J,DDF(1),D0,",DKP=0 F D0=0:0 S D0=$O(^UTILITY(U,$J,DDF(1),D0)) S:D0="" D0=-1 Q:'$D(^(D0,0))  S Z=^(0) D I^DITR
 K ^UTILITY(U,$J,DDF(1)),DDF,DDT,DTO,DFR,DFN,DTN G DATA
 ;
B36(X) Q $$N1(X\(36*36)#36+1)_$$N1(X\36#36+1)_$$N1(X#36+1)
N1(%) Q $E("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",%)
