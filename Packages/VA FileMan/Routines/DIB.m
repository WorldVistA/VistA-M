DIB ;SFISC/GFT,XAK-CREATE A NEW FILE ;9JUN2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**107,1002**
 ;
 W !! K DLAYGO,DTOUT D W^DICRW G Q:$D(DTOUT) K DICS,DIA Q:Y<0
1 I '$D(@(DIC_"0)")) W !!,$C(7),"DATA GLOBAL DOES NOT EXIST!" K DIC Q
 I $P($G(^DD(+$P(@(DIC_"0)"),U,2),0,"DI")),U,2)["Y" W !!,$C(7),"RESTRICTED"_$S($P(^("DI"),U)["Y":" (ARCHIVE)",1:"")_" FILE - NO EDITING ALLOWED!" Q
 S:$D(@(DIC_"0)")) DIA=DIC,X=^(0),(DI,J(0),DIA("P"))=+$P(X,U,2)
 D QQ S DR="",(L,DRS,DIAP,DB,DSC)=0,F=-1,I(0)=DIA,DXS=1
 D EN^DIA:$O(^DD(DI,.01))>0 I $D(DR) G ^DIA2
Q K DI,DLAYGO,DIA,I,J
QQ K ^UTILITY($J),DIAT,DIAB,DIZ,DIAO,DIAP,DIAA,IOP,DSC,DHIT,DRS,DIE,DR,DA,DG,DIC,F,DP,DQ,DV,DB,DW,D,X,Y,L,DIZZ Q
 ;
DIE ;
 S F=+Y,(DG,X)="^DIZ("_F_","
 I DUZ(0)="@" W !!,"INTERNAL GLOBAL REFERENCE: "_DG R "// ",X:DTIME S:'$T X="^" S:X="" X=DG I X?."?" W !,"TYPE A GLOBAL NAME, LIKE '^GLOBAL(' OR '^GLOBAL(4,'",!,"OR JUST HIT 'RETURN' TO STORE DATA IN '"_DG_"'" G DIE
 ;
 I X?1"^".E S X=$P(X,U,2,9) I X?.P G ABORT
 I X?1.AN W $C(7)_"  ??" G DIE
 ;
 S DG=X
 D VALROOT(.X,.%)
 I %'=1 G DIE:DUZ(0)="@"&(DG'=X),ABORT
 ;
 W !
 W:DG'=X !?2,"Global reference selected: ^"_X,!
 S DG=U_X
 ;
SET D WAIT^DICD S $P(^DIC(F,0),U,2)=F,^("%A")=DUZ_U_DT,X=$P(^(0),U,1),^(0,"GL")=DG
 I DUZ(0)]"" F %="DD","DEL","RD","WR","LAYGO","AUDIT" S ^DIC(F,0,%)=DUZ(0)
 I DUZ(0)'="@",$S($D(^VA(200,"AFOF")):1,1:$D(^DIC(3,"AFOF"))) D SET1
 S %="" I @("$D("_DG_"0))") S %=^(0)
 S @(DG_"0)=X_U_F_U_$P(%,U,3,9)")
 K ^DD(F) S ^(F,0)="FIELD^^.01^1",^DD(F,.01,0)="NAME^RF^^0;1^K:$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) X"
 S ^(3)="NAME MUST BE 3-30 CHARACTERS, NOT NUMERIC OR STARTING WITH PUNCTUATION" W !?5,"A FreeText NAME Field (#.01) has been created."
 S DA="B",^DD(F,.01,1,0)="^.1",^(1,0)=F_U_DA,X=DG_""""_DA_""",$E(X,1,30),DA)",^(1)="S "_X_"=""""",^(2)="K "_X
 S DIK="^DIC(",DA=F D IX1^DIK
 S DLAYGO=F,DIK="^DD(DLAYGO,",DA=.01,DA(1)=DLAYGO G IX1^DIK
 ;
ABORT ;Delete file and abort
 W !!?9,$C(7)_"No new file created!"
 S DIK="^DIC(",DA=F
 K DG
 G ^DIK
 ;
VALROOT(X,%) ;Validate the root in X
 ;Returns:
 ;  X = open root
 ;  % = 0 : invalid root
 ;      1 : valid root
 ;
 N CREF,FNUM,N,OREF,PROMPT,QLEN,ROOT
 ;
 S (OREF,X)=$$OREF^DILF(X)
 S:$E(OREF)=U OREF=$E(OREF,2,999)
 ;
 ;Check syntax
 I OREF?1(1A,1"%").AN1"("
 E  I OREF?1(1A,1"%").AN1"("1.E1","
 E  I OREF?1"["1.E1"]"1(1A,1"%").AN1"("
 E  I OREF?1"["1.E1"]"1(1A,1"%").AN1"("1.E1","
 E  I OREF?1"|"1.E1"|"1(1A,1"%").AN1"("
 E  I OREF?1"|"1.E1"|"1(1A,1"%").AN1"("1.E1","
 E  W $C(7)_"  ?? Bad syntax" S %=0 Q
 ;
 S CREF=U_$$CREF^DILF(OREF)
 ;
 ;Check whether files stored in ancestors
 S %=1
 S QLEN=$QL($NA(@CREF))
 F N=QLEN:-1:0 D  Q:'%
 . S ROOT=$NA(@CREF,N)
 . Q:ROOT="^DIC"&(N'=QLEN)
 . S FNUM=+$P($P($G(@ROOT@(0)),U,2),"E")
 . I FNUM D  Q:'%
 .. S OROOT=$$OREF^DILF(ROOT)
 .. I $G(^DIC(FNUM,0,"GL"))=OROOT D
 ... W !!,$C(7)_"  ERROR -- "_OROOT_" already used by File #"_FNUM_"!"
 ... S %=0
 . I N=QLEN,$O(@CREF@(0))]"" D
 .. W !,$C(7)
 .. S PROMPT=" -- ^"_OREF_" already exists!"
 .. I DUZ(0)'="@" S %=0 W !,"  ERROR"_PROMPT
 .. E  D YN("  WARNING"_PROMPT_"  --OK",.%)
 Q
 ;
YN(PROMPT,%) ;Prompt yes/no
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR(0)="Y"
 S:$G(PROMPT)]"" DIR("A")=PROMPT
 S DIR("B")="No"
 D ^DIR
 S %=Y=1
 Q
 ;
EN ; Enter here when the user is allowed to select his fields
 S DIC=DIE S:DIC DIC=$S($D(^DIC(DIC,0,"GL")):^("GL"),1:"")
 D 1:DIC]"" K DIC Q
 ;
SET1 ;
 I $D(^VA(200,"AFOF")) S:'$D(^VA(200,DUZ,"FOF",0)) ^(0)="^200.032PA^"_+F_"^1" S ^(+F,0)=F_"^1^1^1^1^1^1"
 I $D(^DIC(3,"AFOF")) S:'$D(^DIC(3,DUZ,"FOF",0)) ^(0)="^3.032PA^"_+F_"^1" S ^(+F,0)=F_"^1^1^1^1^1^1"
 S DIK=$S($D(^VA(200)):"^VA(200,DUZ,""FOF"",",1:"^DIC(3,DUZ,""FOF"","),DA=F,DA(1)=DUZ D IX1^DIK
 Q
