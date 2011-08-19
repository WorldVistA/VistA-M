PRCFACX1 ;WISC@ALTOONA/CTB-CODE SHEET STRING GENERATOR ;10/21/92  10:52 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ENTRY POINT TO GENERATE CODE SHEET MESSAGE STRING
 S U="^" K PRCFDEL,TERM S:'$D(DA) DA=PRCFA("CSDA") K Q,Q0,PRCFCS F I=-1:0 S I=$O(^PRCF(423,DA,I)) Q:I=""!(I'=+I)  S:$D(^(I))'["0" Q(I)=^(I) I $D(^PRCF(423,DA,I,0)) D D1
 S Q=$P(Q(0),U,3),Q=$E(Q,2,($L(Q)-1)),Q("MAP")=$O(^PRCD(422,"B",Q,0)) F I=0:0 S I=$O(^PRCD(422,Q("MAP"),1,I)) Q:I=""  S:$D(^(I,0)) Q("MAPSTR",I)=^(0)
 S PRCFX=0,XL1=160,PRCFCS(PRCFX)="",S=";",C=",",DEL="." I $D(PRCHLOG) S DEL="",XL1=80
 S:"ISM"[PRCFA("SYS") DEL="^"
 S:"IRS"[PRCFA("SYS") DEL=""
 S:"CAP"[PRCFA("SYS") DEL="^" K PRCF("OUT")
 S:"LOG\IRS"[PRCFA("SYS") PRCF("OUT")=""
 S N1=0 F PRCFI=1:1 S N1=$O(Q("MAPSTR",N1)) Q:'N1  F N2=1:1 Q:$P(Q("MAPSTR",N1),"\",N2)=""  K A S A=$P(Q("MAPSTR",N1),"\",N2) D @($S(A'[",":"SINGLE",1:"MULTI")) Q:$D(TERM)
 K PRCFI S:$E(PRCFCS(0),1)="." PRCFCS(0)=$P(PRCFCS(0),".",2,999)
 F I=0:1:PRCFX I PRCFCS(I)["$","IRS\ISM"'[PRCFA("SYS") D A Q
 F K=I+1:1:PRCFX K PRCFCS(K)
 I '$D(DT) D NOW^%DTC S DT=X
 S X=0 F I=-1:0 S I=$O(PRCFCS(I)) Q:I=""  S X=X+1
 L +^PRCF(423,DA):5 I '$T S X="Code Sheet file not available - File lock timeout.*" D MSG^PRCFQ G OUT
 K ^PRCF(423,DA,"CODE") S ^PRCF(423,DA,"CODE",0)="^^"_X_U_X_U_DT_U_U
 L -^PRCF(423,DA,"CODE") S N=-1 F I=1:1 S N=$O(PRCFCS(N)) Q:N=""  S ^PRCF(423,DA,"CODE",I,0)=PRCFCS(N)
 K %,A,B,C,DEL,I,K,N,N1,N2,POP,PRCF("OUT"),PRCFX,Q,S,X,XL1,Y Q
SINGLE N XX S B=$P(A,S,2,3),XX=$G(Q(+B)) S:XX="" Q(+B)="" S Q=$P(Q(+B),U,$P(B,S,2))
 I $P(A,S)["T",$D(^DD(423,+A,2.1)),(^(2.1)["PRCHLOG"!(^(2.1)["PRCF(""OUT"")")) S Y=Q X ^(2.1) S Q=Y
S1 S PRCFCS(PRCFX)=PRCFCS(PRCFX)_$S($L(PRCFCS(PRCFX)):DEL,1:"")_Q
 I $L(PRCFCS(PRCFX))>XL1 S PRCFCS(PRCFX+1)=$E(PRCFCS(PRCFX),XL1+1,999),PRCFCS(PRCFX)=$E(PRCFCS(PRCFX),1,XL1) S PRCFX=PRCFX+1 K QX1,QX2 I Q="$" S TERM=1 Q
 Q
MULTI S A(0)=A,NODE1=""
 ;NOTE: The following will only work for multiple with a total length
 ;in a(zz)'s of no more then 255 characters
 ;
 F ZZ=0:1 Q:'$D(A(ZZ))  I $E(A(ZZ),$L(A(ZZ)))="~" S A(ZZ)=$E(A(ZZ),1,$L(A(ZZ))-1),N1=$O(Q("MAPSTR",N1)) I N1]"" S:$E(Q("MAPSTR",N1))="~" A(ZZ+1)=$P(Q("MAPSTR",N1),"\",1),A(ZZ+1)=$P(A(ZZ+1),"~",2,99),N2=1
 S:$D(A(1)) A(0)=A(0)_","_A(1) K A(1)
 F ZZ=0,1 Q:'$D(A(ZZ))  D  ;BEGIN ZZ LOOP
  . S:NODE1="" NODE1=$P(A(ZZ),S,2) S D1=0,J1=2
  . F DD1=0:0 S D1=$O(Q(NODE1,D1)) Q:'D1  D  ;BEGIN D1 LOOP
  . . F J1=2:1 Q:$P(A(ZZ),C,J1)=""  D  ;BEGIN J1 LOOP
  . . . S A1=$P(A(ZZ),C,J1),B1=$P(A1,S,2,3) S:'$D(Q(NODE1,D1,+B1)) Q(NODE1,D1,+B1)="" D M2
  . . . Q  ;QUIT J1 LOOP
  . . Q  ;QUIT D1 LOOP
  . Q  ;QUIT ZZ LOOP
 Q
M2 S Q=$P(Q(NODE1,D1,+B1),U,$P(B1,S,2)) D S1 Q
 Q
D1 S J=0 F  S J=$O(^PRCF(423,DA,I,J)) Q:'J  S K=-1 F  S K=$O(^PRCF(423,DA,I,J,K)) Q:K=""!(K'=+K)  S:$D(^PRCF(423,DA,I,J,K)) Q(I,J,K)=^(K)
 Q
OUT K B,D,D0,DG,DIC,DIE,DIG,DIH,DIU,DIV,DIW,DLAYGO,DR,K,Q,PRCFCS,PRCFX,S,X,XL1 Q
A I PRCFCS(I)="$" S I=I-1,PRCFCS(I)=$E(PRCFCS(I),1,$L(PRCFCS(I))-1)_"$" Q
 S PRCFCS(I)=$P(PRCFCS(I),"$",1),PRCFCS(I)=$E(PRCFCS(I),1,$L(PRCFCS(I))-1)_"$" Q
DEL ;KILL THE CODE SHEET AND CROSS REFERENCES
 S DIK="^PRCF(423," D WAIT^PRCFYN,^DIK
 W $C(7),"   CODE SHEET DELETED " K K,X,DA S PRCFDEL="" G OUT
 Q
