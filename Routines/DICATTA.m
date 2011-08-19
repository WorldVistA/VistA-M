DICATTA ;SFISC/YJK-DD AUDIT ;1/4/94  08:21
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
I S B1="0,.1,3,4,8,8.5,9,9.1,10,AUDIT,AX" Q
SV ;
 D I F %=1:1 S A0=$P(B1,",",%) Q:A0=""  I $D(^DD(A,+Y,A0)) S ^UTILITY("DDA",$J,A,+Y,A0)=^(A0)
 K %,A0,B1 Q
 ;
AUDT ;
 S B0=DDA(1) I DDA="E" D B G QQ
 S A0="LABEL^.01" D ADD I DDA["D" S ^DDA(B0,%D,1)=$P(^UTILITY("DDA",$J,B0,DA,0),U,1)
 E  S ^DDA(B0,%D,2)=$P(^DD(B0,DA,0),U,1)
 G QQ
 ;
B S A0="",A1=^UTILITY("DDA",$J,B0,DA,0),A2=^DD(B0,DA,0)
 S A3=1,A5="LABEL^TYPE^TYPE",B3=".01^.25^.25"
 F %=1:1:3 I $P(A1,U,%)'=$P(A2,U,%) S $P(A0,",",A3)=$P(A5,U,%),$P(A4,",",A3)=$P(B3,U,%),$P(B1,"^",A3)=$P(A1,U,%),$P(B2,"^",A3)=$P(A2,U,%),A3=A3+1
 I $P(A1,U,5,99)'=$P(A2,U,5,99) S $P(A0,",",A3)="INPUT TRANSFORM",$P(B1,"^",A3)=$P(A1,U,5,99),$P(B2,"^",A3)=$P(A2,U,5,99),$P(A4,",",A3)=.5
 I A0]"" S A0=A0_"^"_A4,A1=B1,A2=B2 D ADD,E
 K B3,A1,A2,A3,A4,A5 D I
B1 F B2=2:1 S %=$P(B1,",",B2) Q:%=""  S:$D(^UTILITY("DDA",$J,B0,DA,%)) A1=^(%) S:$D(^DD(B0,DA,%)) A2=^(%) I $D(A1)!$D(A2) S %=$S(%="AUDIT":1.1,%="AX":1.2,1:%),A0=$S($D(^DD(0,%,0)):$P(^(0),U,1),1:"")_"^"_% D P
 Q
 ;
P I $D(A1),'$D(A2) S DDA="D" D ADD S ^(1)=A1 K A1 Q
 I '$D(A1),$D(A2) S DDA="N" D ADD S ^(2)=A2 K A2 Q
 I A1'=A2 S DDA="E" D ADD,E
 K A1,A2 Q
 ;
ADD I '$D(^DDA(B0,0)) S %=$P(^DIC(J(0),0),U,1),^DDA(B0,0)=$S(B0=J(0):%,1:%_" ("_$P(^DD(B0,0),U,1)_")")_" DD AUDIT^.6I"
 F B3=$P(^(0),U,3):1 I '$D(^(B3)) L +^DDA(B0,B3):0 Q:$T
 S $P(^(0),U,3,4)=B3_U_($P(^(0),U,4)+1),^(B3,0)=DA L -^DDA(B0,B3)
 S %T=$P($H,",",2),%T=%T#60/100+(%T#3600\60)/100+(%T\3600)/100,%T=DT_%T
 S ^DDA(B0,"D",%T,B3)="",^DDA(B0,"E",DUZ,B3)="",^DDA(B0,"B",DA,B3)="",^DDA(B0,B3,0)=DA_U_DDA_U_%T_U_DUZ_U_A0_U_B0,%D=B3
 K B3,%T,% Q
 ;
E S:A1]"" ^(1)=A1 S:A2]"" ^(2)=A2 Q
 ;
IT ;
 S B0=DI,DDA="E" D ADD,E G QQ
 ;
IT1 ;
 S B1=",3,4,12.1",B0=DI D B1 G QQ
 ;
XS ;
 I $P(^DD(J(N),DA,1,DQ,0),U,3)["TRIG"!($P(^(0),U,3)["BULL") S DDA="TE" Q:'$D(^(3))  S ^UTILITY("DDA",$J,J(N),DA,3)=^(3) Q
 S %=0 F B1=1:1 S %=$O(^DD(J(N),DA,1,DQ,%)) Q:+%'>0  S ^UTILITY("DDA",$J,J(N),DA,B1)=^(%)
 K B1,% Q
 ;
XA ;
 S B0=J(N),DA=DL,A0="CROSS REFERENCE^1"
 I DDA["T" S DDA="E" D TR G QQ
 S %=0 D CK G:'% QQ D ADD S B1=$S(DDA["D":1.1,1:2.1),A0="^DD(B0,DA,1,DQ," D XL
QQ S DDA="" K B0,%D,B1,B2,%,A0,A1,A2,^UTILITY("DDA",$J) Q
 ;
CK K A1,A2 F B1=1:1:3 S:$D(^DD(B0,DA,1,DQ,B1)) A1=^(B1) S:$D(^UTILITY("DDA",$J,B0,DA,B1)) A2=^(B1) I $D(A1)!$D(A2) D C Q:%
 Q
 ;
C I ($D(A1)&'$D(A2))!('$D(A1)&$D(A2)) S %=1 Q
 S:A1'=A2 %=1 Q
 ;
XL S %=0 F B2=1:1 S %=$O(@(A0_%_")")) Q:+%'>0  S ^DDA(B0,%D,B1,B2,0)=^(%)
 S B2=B2-1,%=$S(B1=1.1:.601,1:.602),^DDA(B0,%D,B1,0)="^"_%_"^"_B2_"^"_B2_"^"_DT
 I DDA["E",B1=2.1 S B1=1.1,A0="^UTILITY(""DDA"",$J,B0,DA," G XL
 K %,B2 Q
 ;
TR ;
 K A1,A2 S:$D(^DD(B0,DA,1,DQ,3)) A2=^(3) S:$D(^UTILITY("DDA",$J,B0,DA,3)) A1=^(3) Q:'$D(A1)&'$D(A2)
 I $D(A1),$D(A2) Q:A1=A2  D ADD S ^DDA(B0,%D,1)=A1,^(2)=A2 Q
 D ADD S:$D(A1) ^DDA(B0,%D,1)=A1 S:$D(A2) ^DDA(B0,%D,2)=A2 Q
 ;;
