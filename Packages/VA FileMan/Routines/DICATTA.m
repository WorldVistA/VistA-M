DICATTA ;SFISC/YJK-DD AUDIT ;2014-12-30  10:20 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1024,1039,1048**
 ;
 ;
SV ;From DICATT & DICATTD
 F %=1:1 S A0=$P($$I,",",%) Q:A0=""  I $D(^DD(A,+Y,A0)) S ^UTILITY("DDA",$J,A,+Y,A0)=^(A0)
 K %,A0 Q
 ;
 ;
 ;
 ;
AUDT ;
 N OLD,NEW
 S B0=DDA(1) I DDA="E" D B G QQ
 S A0="LABEL^.01" I DDA["D" S OLD=$P(^UTILITY("DDA",$J,B0,DA,0),U)
 E  S NEW=$P(^DD(B0,DA,0),U)
 D ADD(.OLD,.NEW) G QQ
 ;
B S A0="",A1=^UTILITY("DDA",$J,B0,DA,0),A2=^DD(B0,DA,0)
 S A3=1,A5="LABEL^TYPE^TYPE",B3=".01^.25^.25"
 F %=1:1:3 I $P(A1,U,%)'=$P(A2,U,%) S $P(A0,",",A3)=$P(A5,U,%),$P(A4,",",A3)=$P(B3,U,%),$P(B1,"^",A3)=$P(A1,U,%),$P(B2,"^",A3)=$P(A2,U,%),A3=A3+1
 I $P(A1,U,5,99)'=$P(A2,U,5,99) S $P(A0,",",A3)="INPUT TRANSFORM",$P(B1,"^",A3)=$P(A1,U,5,99),$P(B2,"^",A3)=$P(A2,U,5,99),$P(A4,",",A3)=.5
 I A0]"" S A0=A0_"^"_A4,A1=B1,A2=B2 D ADD(A1,A2)
 K B3,A1,A2,A3,A4,A5 D B1($$I)
 Q
 ;
 ;
I() Q "0,.1,3,4,8,8.5,9,9.1,10,AUDIT,AX"
 ;
 ;
 ;
B1(B1) F B2=2:1 S %=$P(B1,",",B2) Q:%=""  S:$D(^UTILITY("DDA",$J,B0,DA,%)) A1=^(%) S:$D(^DD(B0,DA,%)) A2=^(%) I $D(A1)!$D(A2) S %=$S(%="AUDIT":1.1,%="AX":1.2,1:%),A0=$S($D(^DD(0,%,0)):$P(^(0),U,1),1:"")_"^"_% D P
 Q
 ;
 ;
DDAUDITQ(FILE) ;ALWAYS DO DD AUDIT
 Q 1
 ;F  Q:'$G(^DD(FILE,0,"UP"))  S FILE=^("UP")
 ;Q $G(^DD(FILE,0,"DDA"))="Y"
 ;
 ;
 ;
UPDATED(FILE,FIELD) I $D(^DD(FILE,FIELD,0)) S ^("DT")=DT
 S ^DD(FILE,0,"DT")=DT
 F  Q:'$G(^DD(FILE,0,"UP"))  S FILE=^("UP")
 S ^DD(FILE,0,"DT")=DT,$P(^DIC(FILE,"%MSC"),U)=$$NOWINT^DIUTL
 Q
 ;
 ;
P ;From ^DIAUTL & B1 above
 I $D(A1),'$D(A2) S DDA="D" D ADD(A1) K A1 Q
 I '$D(A1),$D(A2) S DDA="N" D ADD(,A2) K A2 Q
 I A1'=A2 S DDA="E" D ADD(A1,A2)
 K A1,A2 Q
 ;
 ;
 ;
AUDIT(FILE,FIELD,OLD,NEW,ATTRIB) ;AUDIT the DATA DICTIONARY
 Q:OLD=NEW
 N DA,DDA,A0,B0,J
 S (J(0),B0)=FILE
 S DA=FIELD,DDA="E",A0=$TR(ATTRIB,"^")_"^" I ATTRIB]"" S A0=A0_$O(^DD(0,"B",ATTRIB,0))
 D ADD^DICATTA(OLD,NEW)
 Q
 ;
 ;
ADD(OLD,NEW) ;NEED 'B0' (FILE #), 'DA'(FIELD #), 'OLD' and 'NEW' values, and A0="LENGTH^.23" or whatever.  %D is return variable.  If it is not there, we are not auditing.
 D UPDATED(B0,DA) ;I '$$DDAUDITQ(B0) K %D Q
 N B3,%T
 I '$D(^DDA(B0,0)) S %=$P(^DIC(J(0),0),U),^DDA(B0,0)=$S(B0=J(0):%,1:%_" ("_$P(^DD(B0,0),U,1)_")")_" DD AUDIT^.6I"
 F B3=$P(^(0),U,3):1 I '$D(^(B3)) L +^DDA(B0,B3):0 Q:$T
 S $P(^(0),U,3,4)=B3_U_($P(^(0),U,4)+1),^(B3,0)=DA L -^DDA(B0,B3)
 S %T=$$NOWINT^DIUTL,^DDA(B0,"D",%T,B3)="",^DDA(B0,"E",DUZ,B3)="",^DDA(B0,"B",DA,B3)="",^DDA(B0,B3,0)=DA_U_DDA_U_%T_U_DUZ_U_A0_U_B0
 S:$G(OLD)]"" ^(1)=OLD S:$G(NEW)]"" ^(2)=NEW
 S %D=B3 Q  ;RETURNS %D
 ;
 ;
IT ;From DIU3, DIU31, DICATT2
 S B0=DI,DDA="E" D ADD(A1,A2) G QQ
 ;
IT1 ;From DIU31
 S B0=DI D B1(",3,4,12.1") G QQ
 ;
XS ;From DICE
 I $P(^DD(J(N),DA,1,DQ,0),U,3)["TRIG"!($P(^(0),U,3)["BULL") S DDA="TE" Q:'$D(^(3))  S ^UTILITY("DDA",$J,J(N),DA,3)=^(3) Q
 S %=0 F B1=1:1 S %=$O(^DD(J(N),DA,1,DQ,%)) Q:+%'>0  S ^UTILITY("DDA",$J,J(N),DA,B1)=^(%)
 K B1,% Q
 ;
XA ;From DICE, DICE0, DIKD, DICD
 S B0=J(N),DA=DL,A0="CROSS REFERENCE^1"
 I DDA["T" S DDA="E" D  G QQ
TR .K A1,A2 S:$D(^DD(B0,DA,1,DQ,3)) A2=^(3) S:$D(^UTILITY("DDA",$J,B0,DA,3)) A1=^(3) Q:'$D(A1)&'$D(A2)
 .D ADD($G(A1),$G(A2)) Q
 S %=0 D  I % D ADD(,) I $G(%D)>0 S B1=$S(DDA["D":1.1,1:2.1),A0="^DD(B0,DA,1,DQ," D XL
CK .K A1,A2 F B1=1:1:3 S:$D(^DD(B0,DA,1,DQ,B1)) A1=^(B1) S:$D(^UTILITY("DDA",$J,B0,DA,B1)) A2=^(B1) I $D(A1)!$D(A2) D  Q:%
C ..I ($D(A1)&'$D(A2))!('$D(A1)&$D(A2)) S %=1 Q
 ..S:A1'=A2 %=1
QQ S DDA="" K B0,%D,B1,B2,%,A0,A1,A2,^UTILITY("DDA",$J) Q
 ;
 ;
 ;
 ;
XL Q:$G(%D)'>0  S %=0 F B2=1:1 S %=$O(@(A0_%_")")) Q:+%'>0  S ^DDA(B0,%D,B1,B2,0)=^(%)
 S B2=B2-1,%=$S(B1=1.1:.601,1:.602),^DDA(B0,%D,B1,0)="^"_%_"^"_B2_"^"_B2_"^"_DT
 I DDA["E",B1=2.1 S B1=1.1,A0="^UTILITY(""DDA"",$J,B0,DA," G XL
 K %,B2 Q
