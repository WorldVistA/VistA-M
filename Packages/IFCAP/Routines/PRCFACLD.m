PRCFACLD ;WISC@ALTOONA/CTB-CODE SHEET PRELOAD ;10 Sep 89/3:08 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 G:'$D(F) DOUT D TT^PRCFAC G:'% DOUT D NEWCS^PRCFAC G:'$D(DA) DOUT
SE K %CS F I=0,"TRANS" S %CS(I)=^PRCF(423,PRCFA("CSDA"),I)
 S N=0 F I=1:1 S N=$O(F(N)) Q:'N  D A
 S N="" F I=1:1 S N=$O(%CS(N)) Q:'N  S ^PRCF(423,PRCFA("CSDA"),N)=%CS(N)
 I $D(DR) S DIE="^PRCF(423,",DA=PRCFA("CSDA") D ^DIE
 K %CS,%DA,%DD,%DIC,%DIC1,%FN1,%FN2,%INPT,%NODE,%PIECE Q
A S %DA=$P(F(N),",",2),%DD=$P(F(N),","),%DIC=$P(F(N),",",3)
 S:%DIC="" %DIC=^DIC(%DD,0,"GL") S %DIC=%DIC_%DA_","
 S J=0 F I=1:1 S J=$O(F(N,J)) Q:'J  D B
 Q
B Q:F(N,J)=""  S %FN1=$P(F(N,J),";"),%FN2=$P(F(N,J),";",2),%INPT=$P(F(N,J),";",3) I %FN1'=+%FN1 X %FN1 G C
 S Y=$P(^DD(%DD,%FN1,0),"^",4),%NODE=$P(Y,";"),%PIECE=$P(Y,";",2)
 S %DIC1=%DIC_%NODE_")" S Y=@(%SDIC1),X=$P(Y,"^",%PIECE)
C S Y=$P(^DD(423,%FN2,0),"^",4,99),%NODE=$P($P(Y,"^"),";"),%PIECE=$P($P(Y,"^"),";",2) I %INPT["I"!($D(F("IT"))) S %INTRANS=$P(Y,"^",2,99) X %INTRANS K %INTRANS
D S:$D(X) $P(%CS(%NODE),"^",%PIECE)=X Q
DOUT K F,PRCFA S %=0 Q
