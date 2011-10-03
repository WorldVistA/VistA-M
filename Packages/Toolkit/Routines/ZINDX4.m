%INDX4 ;ISC/REL,GRK - PROCESS DO, GO TO, WRITE & FOR COMMANDS ;8/17/92  16:32 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
DG1 I ARG="" S:'IND("DO1") IND("DO")=IND("DO")+1,IND("DO1")=1 Q
DG S (LBL,PGM,OFF,PRM)="",S=1,L="+^:," S:$E(ARG,1,2)="@^" S=3
 D LOOP S LBL=$E(ARG,1,I-1)
 I CH="+" S (J,S)=I+1,ERR=30 D ^%INDX1:$E(ARG)'="@" S:$E(ARG,I)="^" S=I+1 D LOOP S OFF=$E(ARG,J,I-1) I OFF'?.N S GRB=GRB_$C(9)_OFF
 I CH="^" S S=I+1 D LOOP S PGM=$E(ARG,S,I-1)
 I CH=":" S S=I+1,L="," D LOOP S S=$E(ARG,S,I-1) I S'="" S GRB=GRB_$C(9)_S
 S ARG=$E(ARG,I+1,999)
 I $E(LBL)="@" S GRB=GRB_$C(9)_$E(LBL,2,999),LBL="@("
 I $E(PGM)="@" S GRB=GRB_$C(9)_$E(PGM,2,999),PGM="@("
 I LBL[")" S PRM=$$INSIDE(LBL,"(",")"),LBL=$P(LBL,"(")
 I PGM[")" S PRM=$$INSIDE(PGM,"(",")"),PGM=$P(PGM,"(")
 I PRM]"" S GRB=GRB_$C(9)_PRM D PC
 S:OFF'="" LBL=LBL_"+"_OFF
 S S="",LOC="I" I PGM'="" S S=S_PGM_" ",LOC="X"
 S:LBL'="" S=S_LBL I S'="" D ST
 G:ARG'="" DG K LBL,PGM,OFF,PRM Q
LOOP F I=S:1 S CH=$E(ARG,I) D QUOTE:CH=Q,PAREN:CH="(",ERRCP:CH=")" Q:L[CH
 Q
PAREN S PC=1
 F I=I+1:1 S CH=$E(ARG,I) Q:PC=0!(CH="")  I "()"""[CH D QUOTE:CH=Q S PC=PC+$S("("[CH:1,")"[CH:-1,1:0)
 S ERR=5 D:PC ^%INDX1 Q
QUOTE F I=I+1:1 S CH=$E(ARG,I) Q:CH=""!(CH=Q)
 I CH="" S ERR=6 G ^%INDX1
 Q
ST S R=$F(S,"(") S:R>1 S=$E(S,1,R-1) S:"IX"[LOC IND("COM")=IND("COM")_","_S
 S:'$D(V(LOC,S)) V(LOC,S)="" S:LOC="L"&(V(LOC,S)'["*") V(LOC,S)=V(LOC,S)_"*" Q
 Q
FR Q:$E(ARG,1)="@"  S S=2,L="=" D LOOP I CH="" S ERR=8 G ^%INDX1
 S GK="*",STR=$E(ARG,1,I-1),ARG=$E(ARG,I+1,999) D ARGG^%INDX2
 Q
WR S STR=ARG D ^%INDX9 S ARG=""
 F  D INC^%INDX2 Q:S=""  D
 . I S="?" S ERR=49 D:","[S1 ^%INDX1 Q
 . D ARG^%INDX2
 . Q
 Q
ERRCP S ERR=5 D ^%INDX1 Q
SET S ARG=$E(ARG,1,I-1)_","_$E(ARG,I+1,999) Q
XE S GRB=GRB_$C(9)_ARG,ARG="" Q
REP S L=",:",S=1 D LOOP I CH=":" S ARG=$E(ARG,I+1,999),L="," D LOOP
 S ARG=$E(ARG,I+1,999) Q:ARG=""  G REP
ZC I "ILRS"'[$E(CM,2)!($E(CM,2)="") S ARG="" Q  ;Zcommands
 S COM=$E(CM,1,2) Q:CM="ZI"  G:CM="ZR" ZR
U1 S L=",",S=1 D LOOP S S=$E(ARG,1,I-1),ARG=$E(ARG,I+1,999)
 S:$E(S,1)="@" S=$E(S,2,999),GRB=GRB_$C(9)_S Q:ARG=""  G U1
ZR Q:ARG=""  S L=":,",S=1 D LOOP S S=$E(ARG,1,I-1),ARG=$E(ARG,I+1,999)
 I $E(S,1)="@" S GRB=GRB_$C(9)_S G ZR
 S:S["+" GRB=GRB_$C(9)_$P(S,"+",2,999) G ZR
LO S GRB=GRB_$C(9)_ARG,ARG="" Q
Q ;QUIT
 D SEP(LIN," ",.S)
 I IND("PP") S ERR=$S(ARG?1A&(S>1):9,$E(ARG)=";":49,1:0) D:ERR ^%INDX1 Q
 S ERR=$S(ARG?1A&(S>1):9,$E(ARG)=";":9,$L(ARG)>1&(S<2):0,S=0:0,1:9) S:ERR LIN=ARG_" "_LIN,ARG="" S:$E(ARG)=";" ARG="" G:ERR ^%INDX1
 Q
PT(X) ;Tag for parameter passing
 S ^UTILITY($J,1,RTN,"P",LAB)=X Q
PC ;Parameter passing call
 N LOC S LOC="P" D ST Q
INSIDE(X,X1,X2) ;Return the data inside the param x1,x2
 S J=$L(X,X2)-1,J=$S(J<1:1,1:J)
 Q $P($P(X,X2,1,J),X1,2,99)
SEP(ST,SP,RV) ;String,Separters,Return array)
 ;N M,N
 F N=1:1 S %=$E(ST,N) D SQT:%=Q Q:SP[%
 S RV=N-1,RV(1)=$E(ST,1,N) Q
SQT F N=N+1:1 Q:Q[$E(ST,N)
 Q
