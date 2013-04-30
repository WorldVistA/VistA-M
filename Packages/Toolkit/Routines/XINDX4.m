XINDX4 ;ISC/REL,GRK - PROCESS DO, GO TO, WRITE & FOR COMMANDS ;08/05/08  13:59
 ;;7.3;TOOLKIT;**20,61,68,110,128,133**;Apr 25, 1995;Build 15
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ;DO and GO; IND("DO1") checks if we already checked a DO at this level
DG1 I ARG="" S:'IND("DO1") IND("DO")=IND("DO")+1,IND("DO1")=1 Q
DG S (LBL,PGM,OFF,PRM)="",S=1,L="+^:," S:$E(ARG,1,2)="@^" S=3
 D LOOP S LBL=$E(ARG,1,I-1)
 ;Cache Object method contain ".", check if label is an object or begins with ##
 I $P(LBL,"(")["."!($E(LBL,1,2)="##") Q
 I CH="+" S (J,S)=I+1,ERR=30 D ^XINDX1:$E(ARG)'="@" S:$E(ARG,I)="^" S=I+1 D LOOP S OFF=$E(ARG,J,I-1) I OFF'?.N S GRB=GRB_$C(9)_OFF
 I CH="^" S S=I+1 D LOOP S PGM=$E(ARG,S,I-1)
 I CH=":" S S=I+1,L="," D LOOP S S=$E(ARG,S,I-1) I S'="" S GRB=GRB_$C(9)_S
 S ARG=$E(ARG,I+1,999)
 I $E(LBL)="@" S GRB=GRB_$C(9)_$E(LBL,2,999),LBL="@("
 I $E(PGM)="@" S GRB=GRB_$C(9)_$E(PGM,2,999),PGM="@("
 I LBL[")" S PRM=$$INSIDE(LBL,"(",")"),LBL=$P(LBL,"(")
 I PGM[")" S PRM=$$INSIDE(PGM,"(",")"),PGM=$P(PGM,"(")
 I $L(PRM) S GRB=GRB_$C(9)_$$PRUNE($$CNG(PRM,",,",","),",") ;strip null parameters
 I $G(IND("DOL")),CM="G",PGM]"" D E^XINDX1(63) ;can't goto another routine out of block structure
 S:OFF'="" LBL=LBL_"+"_OFF
 S S="",LOC="I" I PGM'="" S S=PGM_" ",LOC="X"
 S:LBL_PGM["&" LOC="X"
 S:LBL'="" S=S_LBL I S'="" D ST
 G:ARG'="" DG K LBL,PGM,OFF,PRM
 Q
LOOP F I=S:1 S CH=$E(ARG,I) D QUOTE:CH=Q,PAREN:CH="(",ERRCP:CH=")" Q:L[CH
 Q
PAREN S PC=1
 F I=I+1:1 S CH=$E(ARG,I) Q:PC=0!(CH="")  I "()"""[CH D QUOTE:CH=Q S PC=PC+$S("("[CH:1,")"[CH:-1,1:0)
 S ERR=5 D:PC ^XINDX1
 Q
QUOTE F I=I+1:1 S CH=$E(ARG,I) Q:CH=""!(CH=Q)
 I CH="" S ERR=6 G ^XINDX1
 Q
ST S R=$F(S,"(") S:R>1 S=$E(S,1,R-1) S:"IX"[LOC IND("COM")=IND("COM")_","_S
 S:'$D(V(LOC,S)) V(LOC,S)="" S:LOC="L"&(V(LOC,S)'["*") V(LOC,S)=V(LOC,S)_"*" Q
 Q
FR Q:$E(ARG,1)="@"  S S=2,L="=" D LOOP I CH="" S ERR=8 G ^XINDX1
 S GK="*",STR=$E(ARG,1,I-1),ARG=$E(ARG,I+1,999) D ARGG^XINDX2
 Q
WR N S0,WR S STR=ARG,WR="#!,",S0="" ;Need to handle /controlmnemonic
 D ^XINDX9 S ARG=""
 F  D INC^XINDX2 Q:S=""  D  S S0=S
 . I S="?" D:WR[S1 E^XINDX1(49) Q
 . I S="!",WR'[$E(S0) D E^XINDX1(59) Q  ;Look for var!
 . I S="!","#!?,"'[$E(S1) D E^XINDX1(59) Q  ;Look for !var
 . D ARG^XINDX2
 . Q
 Q
ERRCP S ERR=5 D ^XINDX1
 Q
SET S ARG=$E(ARG,1,I-1)_","_$E(ARG,I+1,999)
 Q
XE S GRB=GRB_$C(9)_ARG,ARG=""
 Q
REP S L=",:",S=1 D LOOP I CH=":" S ARG=$E(ARG,I+1,999),L="," D LOOP
 S ARG=$E(ARG,I+1,999) Q:ARG=""
 G REP
 ;
ZC I "ILRS"'[$E(CM,2)!($E(CM,2)="") S ARG="" Q  ;Zcommands
 S COM=$E(CM,1,2) Q:CM="ZI"  G:CM="ZR" ZR
U1 S L=",",S=1 D LOOP S S=$E(ARG,1,I-1),ARG=$E(ARG,I+1,999)
 S:$E(S,1)="@" S=$E(S,2,999),GRB=GRB_$C(9)_S Q:ARG=""  G U1
ZR Q:ARG=""  S L=":,",S=1 D LOOP S S=$E(ARG,1,I-1),ARG=$E(ARG,I+1,999)
 I $E(S,1)="@" S GRB=GRB_$C(9)_S G ZR
 S:S["+" GRB=GRB_$C(9)_$P(S,"+",2,999)
 G ZR
LO ;Lock -- Look for timeouts
 N LK
 I ARG="" Q
 S S=1
 F  D  Q:CH=""
 . I "+-"'[$E(ARG,S) D E^XINDX1(61)
 . S L="-:,",LK=0 D LOOP S S=I+1
 . I CH="-" S L="," D LOOP S S=I+1 Q
 . I CH=":" S L=",",LK=1 D LOOP S S=I+1
 . I CH="," D:'LK E^XINDX1(60) S LK=0 Q
 . I CH="" D:'LK E^XINDX1(60) Q
 . Q
 S GRB=GRB_$C(9)_ARG,ARG=""
 Q
Q ;QUIT followed by comment or in structure Do or For loop, must have 2 spaces
 I $E(ARG)=";"!$G(IND("DOL"))!$G(IND("F")) S ARG="",ERR=9 G ^XINDX1
 Q
PT(X) ;Tag for parameter passing
 S ^UTILITY($J,1,RTN,"P",LAB)=X
 Q
PC ;Parameter passing call
 N LOC S LOC="P" D ST
 Q
INSIDE(X,X1,X2) ;Return the data inside the param x1,x2
 S J=$L(X,X2)-1,J=$S(J<1:1,1:J)
 Q $P($P(X,X2,1,J),X1,2,99)
 ;
SEP(ST,SP,RV) ;String,Separters,Return array)
 N %,N,Q S Q=$C(34) ;QUOTE
 F N=1:1 S %=$E(ST,N) D SQT:%=Q Q:SP[%
 S RV=N-1,RV(1)=$E(ST,1,N)
 Q
 ;
SQT F N=N+1:1 Q:Q[$E(ST,N)
 Q
CNG(S1,S2,S3) ;String,replace,with
 ;
 F  Q:S1'[S2  S S1=$P(S1,S2)_S3_$P(S1,S2,2,999)
 Q S1
PRUNE(S1,S2) ;String,prune char from front and back
 F  Q:$E(S1)'=S2  S S1=$E(S1,2,999)
 F  Q:$E(S1,$L(S1))'=S2  S S1=$E(S1,1,$L(S1)-1)
 Q S1
