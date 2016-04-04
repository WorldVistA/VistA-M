DITR1 ;SFISC/GFT-FIND ENTRY MATCHES ;18-MAR-2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**41,999,1044**
 ;
 S W=DMRG,X=$P(Z,U),%=DFL\2,Y=@("D"_%),A=1 S:$G(DIFRDKP) DIFRNOAD=$D(@DIFRSA@("^DD",DIFRFILE,DDT(DTL),.01,0))
 N DIMATCH S DIMATCH=0
 G WORD:$P(^DD(DDT(DTL),.01,0),U,2)["W",Q:X="",ON:'W
 S V="" N DIKEY S DIKEY=$O(^DD("KEY","AP",DDT(DTL),"P",0))
 I DIKEY S A=0 D MATCHKEY(DIKEY,.V,.A,.DIMATCH) Q:A
 K DINUM I ^DD(DDT(DTL),.01,0)["DINUM" D  Q
 . I $P(^DD(DDT(DTL),.01,0),U,2)["P" D DINUM Q
 . S V=X,DA=Y,Y=0,D0=$S($D(D0):D0,$D(DFR):DFR,1:"") D DA
 . X $P(^DD(DDT(DTL),.01,0),U,5,99)
 . S X=V,Y=DA I '$D(DINUM) S A=1 Q
 . S Y=DINUM K DINUM D DINUM Q
 I $D(^DD(DDT(DTL),.001,0)) D HAS001 Q
 I DIKEY D  Q
 . I V>0 S Y=V D OLD Q
 . D NEW Q
 S V=0 D:'$D(DISYS) OS^DII
 N DISUBLN,DISUBMX
 S DISUBLN=$$SUBLN(DDT(DTL))
 S DISUBMX=+$P(^DD("OS",DISYS,0),U,7) S:'DISUBMX DISUBMX=63
B I DISUBLN=0 F A=1:1 S V=$O(@(DTO(DTL)_V_")")) G NEW:V'>0 I $D(^(V,0)),$P(^(0),U)=X D MATCH G OLD:'$D(A) S A=1
 S V=$S($O(@(DTO(DTL)_"""B"",$E(X,1,DISUBMX),V)"))>0:$O(^(V)),1:$O(@(DTO(DTL)_"""B"",$E(X,1,DISUBLN),V)"))) G NEW:V'>0
 I $D(@(DTO(DTL)_V_",0)")),$P(^(0),X)="" D MATCH G OLD:'$D(A)
 G B
 ;
DA Q:'%  S DA(%)=@("D"_Y),Y=Y+1,%=%-1 G DA
 ;
DINUM I DIKEY,V>0,V'=Y S A=1 Q
 I @("'$D("_DTO(DTL)_"Y))") D ADD Q
 I DIKEY S:Y'=V A=1 D:'A OLD Q
 S V=Y D MATCH I $D(A) S A=1 Q
 D OLD Q
 ;
HAS001 ; If file has .001 field, .01 and Identifiers/Keys must match
 I DIKEY,V>0,V'=Y S A=1 Q
 I @("$G("_DTO(DTL)_"Y,0))']""""") D ADD Q
 I DIKEY S:Y'=V A=1 D:'A OLD Q
 S V=Y N DIZERO S DIZERO=@(DTO(DTL)_"Y,0)") I $P(DIZERO,U)'=X S A=1 Q
 D MATCH I $D(A) S A=1 Q
 D OLD Q
 ;
NEW S W=0
ON I @("$D("_DTO(DTL)_"Y))") G OLD:W S DITRCNT=$G(DITRCNT)+1,Y=DITRCNT G ON
ADD G:$G(DIFRDKP) Q:DIFRNOAD S @("V="_DTO(DTL)_"0)"),^(0)=$P(V,U,1,2)_U_Y_U_($P(V,U,4)+1),^(Y,0)=X
OLD I DIMATCH,$G(DIFRDKPR),$G(DIFRDKPD),'DTL D REPLACE
 S DTO(DTL+1)=DTO(DTL)_Y_",",DTN(DTL+1)=0,A=0
Q Q
 ;
WORD I $G(DIFRDKP) Q:$D(@DIFRSA@("^DD",DIFRFILE,DDT(DTL),.01))
 S @("V=$O("_DTO(DTL)_"0))") X:V'>0!'DKP "K "_$E(DTO(DTL),1,$L(DTO(DTL))-1)_") S:$D("_DFR(DFL)_"0)) "_DTO(DTL)_"0)=^(0)","F V=0:0 S V=$O("_DFR(DFL)_"V)) Q:V'>0  S:$D(^(V,0)) "_DTO(DTL)_"V,0)=^(0)" S (DFL,DTL)=DFL-1 Q
 ;
MATCH S A=1 I Y'=V,$D(^DD(DDT(DTL),.001,0)) Q
 S Y=V,I=.01 N DIOUT,DIFL,DIREC
I S DIOUT=0
 F  S I=$O(^DD(DDT(DTL),0,"ID",I)) Q:'I  D I2 Q:DIOUT
 Q:DIOUT
 S DIMATCH=1 K A Q
 ;
I2 S DIFL=DDT(DTL),DIREC=I I '$D(^DD(DIFL,DIREC,0))#2 Q:'DIKEY  S DIOUT=1 Q
 K B D P Q:W=""
 S B=W
I3 ; Entry point for initial matching on KEY values
 I DTO S A=$P(A,";",2)_U_$P(A,";",1) D  Q:%'>0
 . F %=0:0 S %=$O(^UTILITY("DITR",$J,DDF(DFL+1),%)) Q:%'>0  Q:^(%)=A
 E  S %=I
 S DIFL=DDF(DFL+1),DIREC=% I '$D(^DD(DIFL,DIREC,0)) Q:'DIKEY  S DIOUT=1 Q
 D P I W="" Q:'DIKEY  S DIOUT=1 Q
 I W=B!(DIKEY) Q
 S Y=@("D"_(DFL\2)),DIOUT=1 Q
 ;
P S A=$P(^DD(DIFL,DIREC,0),U,4)
 S %=$P(A,";",2),W=$P(A,";")
 I @("'$D("_$S('$D(B):DTO(DTL)_"Y,",DFL:DFR(DFL)_"DFN(DFL),",1:DFR(1))_"W))") S W="" Q
 I % S W=$P(^(W),U,%)
 E  S W=$E(^(W),+$E(%,2,9),$P(%,",",2))
 Q:DIKEY
UP I %["F" S W=$$UP^DILIBF(W)
 Q
 ;
MATCHKEY(DIKEY,V,A,DIMATCH) ; Match Primary Key fields
 ; DIKEY=IEN of Primary Key, V=IEN of matching record on target file, A set to 1 if errors are encountered.
 N %,B,S,W,Y,DIOUT,DIENS,DIFL,DIERR,DIREC,DIVAL
 S S="",DIOUT=0
 F  S S=$O(^DD("KEY",DIKEY,2,"S",S)) Q:'S!(DIOUT)  S DIREC="" F  S DIREC=$O(^DD("KEY",DIKEY,2,"S",S,DIREC)) Q:'DIREC!(DIOUT)  S DIFL="" F  S DIFL=$O(^DD("KEY",DIKEY,2,"S",S,DIREC,DIFL)) Q:'DIFL!(DIOUT)  D
 . I DIFL'=DDT(DTL)!('$D(^DD(DDT(DTL),DIREC,0))#2) S DIOUT=1 Q
 . S %=$P(^DD(DIFL,DIREC,0),U,4),I=DIREC,(B,W)=""
 . D  Q:DIOUT  I W="" S DIOUT=1 Q
 .. N A,DIFL,DIREC S A=% D I3 Q
 . S DIVAL(S)=W Q
 S A=0 I DIOUT S A=1 Q
 N KEYN,DA,DIENS,DIERR
 S KEYN=$P($G(^DD("IX",+$P(^DD("KEY",DIKEY,0),U,4),0)),U,2) I KEYN="" S A=1 Q
 S DIENS="," I $G(D1) S %=DFL\2,Y=0,D0=$S($G(D0):D0,$G(DFR):DFR,1:"") I D0 D DA S DIENS=$$IENS^DILF(.DA)
 S V=$$FIND1^DIC(DDT(DTL),DIENS,"QXK",.DIVAL,,,"DIERR")
 I $G(DIERR) S A=1 Q
 I V>0 S DIMATCH=1
 S A=0 Q
 ;
REPLACE ;
 N DA,DIK,DISAV0 S DISAV0=$P(@(DIFROOT_"0)"),U,3,4)
 K @DIFRSA@("TMP")
 I DIFRDKPS M @DIFRSA@("TMP",DIFRFILE,Y)=@(DTO(DTL)_Y_")")
 S DA=Y,DIK=DIFROOT
 N %,A,B,D0,DDF,DDT,DFL,DFR,DINUM,DTL,DTN,DTO,I,W,X,Y,Z
 D ^DIK
 S DIFRDKPD=0,$P(@(DIFROOT_"0)"),U,3,4)=DISAV0
 Q
 ;
SUBLN(DIFILE) ; Return maximum subscript length for "B" index.
 N I,DIWHEREB,DISUBLN S DIWHEREB=""
 S DIWHEREB=$O(^DD("IX","BB",DIFILE,"B",0))
 I 'DIWHEREB,$D(^DD(DIFILE,0,"IX","B",DIFILE,.01)) S DIWHEREB=0
 I DIWHEREB="" Q 0
 I DIWHEREB D
 . S I=$O(^DD("IX","F",DIFILE,.01,DIWHEREB,0)) Q:'I
 . S DISUBLN=+$P($G(^DD("IX",DIWHEREB,11.1,I,0)),U,5)
 . S:'DISUBLN DISUBLN=999
 I 'DIWHEREB F I=0:0 S I=$O(^DD(DIFILE,.01,1,I)) Q:'I  I $P($G(^(I,0)),U,2)="B" D  Q
 . S I=$G(^DD(DIFILE,.01,1,I,1)),DISUBLN=+$P(I,"$E(X,1,",2) Q
 Q:$G(DISUBLN) DISUBLN
 Q 30
 ;
