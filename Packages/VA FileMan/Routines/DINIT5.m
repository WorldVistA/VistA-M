DINIT5 ;SFISC/GFT-INITIALIZE VA FILEMAN ;25SEP2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1040**
 ;
DOPT K ^DOPT("DDS"),^("DICR"),^("DDU"),^("DIAR"),^("DIAU"),^("DIBT"),^("DICATT"),^("DICR"),^("DID"),^("DIFG"),^("DII"),^("DII1"),^("DIS"),^("DIT"),^("DIU"),^("DIX"),^("DIAX"),^("DDXP")
 S ^DOPT("DICATT",0)="DATA TYPE^1.01"
 F I=1:1:9 S ^DOPT("DICATT",I,0)=$P("DATE/TIME^NUMERIC^SET OF CODES^FREE TEXT^WORD-PROCESSING^COMPUTED^POINTER TO A FILE^VARIABLE-POINTER^MUMPS",U,I)
 S ^DOPT("DIS",0)="CONDITION^1.01",^DOPT("DID",0)="LISTING FORMAT^1.01",^DOPT("DICR",0)="TYPE OF INDEXING^1.01"
 F I=1:1:6 S ^DOPT("DIS",I,0)=$P("NULL^^1;CONTAINS^[^1;MATCHES^^1;LESS THAN^<^;EQUALS^=^1;GREATER THAN^>^",";",I) S:I-1&(I-3) ^DOPT("DIS","B",$P(^(0),U,2),I)=1
 F I=1:1:9 S ^DOPT("DID",I,0)=$P("STANDARD^BRIEF^CUSTOM-TAILORED^MODIFIED STANDARD^TEMPLATES ONLY^GLOBAL MAP^CONDENSED^INDEXES ONLY^KEYS ONLY",U,I)
 F I=1:1:7 S ^DOPT("DICR",I,0)=$P("REGULAR^KWIC^MNEMONIC^MUMPS^SOUNDEX^TRIGGER^BULLETIN",U,I)
 F I="DID","DIS","DICATT","DICR" S DIK="^DOPT("""_I_"""," D IXALL^DIK
 S DIK="^DD(""FUNC""," D IXALL^DIK
 D DT^DICRW I '$D(^DD("VERSION")) D FIX S %="" F I=0:0 S %=$O(^DISV(%)) G V:%="" K ^DISV(%)
 F I=2:1:6 W ".." I ^("VERSION")<$P("^14.3^14.7^16^16.07^16.39",U,I) D @("FIX"_I) Q
V K ^DD(0,"B","HELP FRAME") G ^DINIT6
 ;
FIX ;
 N DIDUZ
 S U="^",DH="DIC("
 F D=0:1 Q:$O(^DIBT(D))'>0
 S DIDUZ=0 F  S DIDUZ=+$O(^DISV(DIDUZ)) Q:'DIDUZ  S I=0 F  S I=$O(^DISV(DIDUZ,I)) Q:I'>0  I $O(^(I,0))>0 D PUT
 S DIK="^DIBT(" D IXALL^DIK G FIX2
 ;
PUT S X=^(0),Y=U_$P(X,U,2) I Y]U,@("$D("_Y_"0))") S DIC=+$P(^(0),U,2) I $D(^DIC(DIC,0,"GL")),^("GL")=Y G GOT
 Q
GOT S D=D+1,^DIBT(D,0)=$P(X,U,1)_U_$P(X,U,3)_U_U_+DIC_U_DIDUZ
 S X=0 F  S X=$O(^DISV(DIDUZ,I,X)) Q:X'>0  S ^DIBT(D,1,X)=""
 S Y="",X=0 F  S Y=$O(^DISV(DIDUZ,I,0,Y)) Q:Y=""  S ^DIBT(D,"DIS",Y)=^(Y)
 S Y=-1 Q
 ;
UP S D=0 F  S D=$O(^DD(J,D)) Q:D'>0  I $D(^(D,0)),$P(^(0),U,2)>J S J(+$P(^(0),U,2))=J
 S:D="" D=-1 S J=$O(J(0)) S:J="" J=-1 Q:J<0  S ^DD(J,0,"UP")=J(J) K J(J) G UP
 ;
FIX2 S I=1 F  S I=$O(^DIC(I)) Q:I'>0  I $D(^(I,0,"GL")),@("$D("_^("GL")_"0))"),$P(^(0),U,2)["N",'$D(^DD(I,.001)) S ^(.001,0)="NUMBER^N^^ ^K:$L(X)>9 X I $D(X) K:+X'=X!(X'>0) X",^DD(I,"B","NUMBER",.001)=""
 S I=0 F  S I=$O(^DD(I)) Q:I'>0  S J=0 F  S J=$O(^DD(I,J)) Q:J'>0  S X=$P(^(J,0),U,2),F=$F(X,"P") I 'X,F,'$E(X,F,99),@("$D(^"_$P(^(0),U,3)_"0))") S P=+$P(^(0),U,2),^(0)=$P(^DD(I,J,0),U,1)_U_$E(X,1,F-1)_P_$E(X,F,99)_U_$P(^(0),U,3,99)
 ;
FIX3 S I=.9 F  S I=$O(^DIPT(I)) Q:I'>0  I $D(^(I,0)) S X=$P(^(0),U,3) I $P(^(0),U,6)="" S ^(0)=$P(^(0)_"^^^^",U,1,5)_U_X
 S:I="" I=-1 S DD=1 F  S DD=$O(^DD(DD)) Q:DD'>0  S %=0 F  S %=$O(^DD(DD,"SB",%)) Q:%=""  S ^DD(%,0,"UP")=DD
 S:DD="" DD=-1 S %=-1
 ;
FIX4 S F=1 F  S F=$O(^DD(F)) Q:F'>0  I $D(^(F,"GR")) K ^("GR") S DIK="^DD("_F_",",DA(1)=F D IXALL^DIK
 ;
FIX5 S F=1 F  S F=$O(^DIC(F)) Q:F'>0  S I=$S($D(^(F,0,"DT")):^("DT"),1:0),J=$S($D(^("U")):^("U"),1:0) S:I!J ^DIC(F,"%A")=J_U_I
 ;
FIX6 K J S F=1 F  S (J,F)=$O(^DIC(F)) Q:F'>0  D UP
 S:F="" (F,J)=-1
