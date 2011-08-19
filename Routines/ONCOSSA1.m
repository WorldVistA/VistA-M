ONCOSSA1 ;WASH ISC/SRR-SURVIAL ANALYSIS CONT-1 ;4/16/92  18:31
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;
CHKCOND ;check condition
 ;in:  DIC,TIN,^DD(FNUM
 ;out: P     = 0 if OK
 ;     TOU   = condition
 ;     FLDDAT(f) = 1^node^piece^codes for real; 0^expression for computed
 ;do:  ^DIM
 N C,E,FLDOK,FLD,L,Q
 S E=1,(FLDOK,P)=0,TOU="",Q=$C(34)
 F L=1:1:$L(TIN) S C=$E(TIN,L),TOU=TOU_C S:C=Q E=1-E I C?1U,E D CHK
 I P W !,?20,"Re-enter condition - may need explicit quotes." Q
 I 'FLDOK W !,?20,"No valid fields - please re-enter." S P=1 Q
 S X="S X="_TOU D ^DIM I $D(X)=0 S P=1 W !,"   Check MUMPS syntax."
 Q
 ;
CHK ;check for field
 S FLD=C
CHK1 S L=L+1,C=$E(TIN,L),TOU=TOU_C I C?1UN!(C=" ") S FLD=FLD_C G CHK1
 Q:FLD'?1U.UNP  S X=FLD D ^DIC
 I Y=-1 W !,?20,"Field ",FLD," ???" S P=1 Q
 S FLDOK=1,X=+Y D SETFD
 S Y=$F(TOU,FLD),X=$E(TOU,1,Y-1-$L(FLD))_"VAL("_X_")"_$E(TOU,Y,99),TOU=X
 Q
 ;
SETFD ;set FLDDAT( with field info
 ;in:  X,^DD(FNUM,
 ;out: FLDDAT(,Y
 Q:$D(FLDDAT(X))!'$D(^DD(FNUM,X,0))  S Y=^(0)
 I $P(Y,U,2)["C" S Y="0"_U_$P(Y,U,5,99)
 E  S %=$S($P(Y,U,2)["S":U_$P(Y,U,3),1:""),Y=$P(Y,U,4),Y="1"_U_$P(Y,";",1)_U_+$P(Y,";",2)_%
 S FLDDAT(X)=Y
 Q
 ;
GET ;get specs for survival analysis
 ;in:  ^DD(FNUM,
 ;out: LEN    = conversion divisor^duration unit^interval unit
 ;     COND   = 1 for subgroup expression, 0 for group conditions
 ;        (n) = nth group condition
 ;     FLDDAT = see CHKCOND
 ;     MAXTIME= maximum time allowed
 ;     NGRPS  = number of subgroups
 ;     MORTEXP= dead expression
 ;     LENEXP = duration expression
 ;     GRPEXP = subgroup expression
 ;     PLOT   = 1 for curves plotted
 ;     ^TMP($J,"GRP",n) = title for nth group
 ;do:  CHKCOND,^DIC,^DIM
 N DIC,P,TIN,TOU
 S DIC="^DD(FNUM,",DIC("S")="I +$P(^(0),U,2)=0 "
 S DIC("A")="Select survival DURATION field: "
 S LEN=$S($D(ONCOS("D")):ONCOS("D"),1:""),TIN=$P(LEN,U,1)
 I TIN'="" W !,"DURATION field: ",TIN G GET11
GET1 S DIC(0)="AEQ" D ^DIC Q:Y<0  S TIN=$P(Y,U,2)
GET11 S DIC(0)="E" D CHKCOND G:P GET1 S LENEXP=TOU,TIN=$P(LEN,U,2) G:TIN'="" GET21
GET2 W !,"DURATION unit (Day, Wk, Mo, Yr): " R TIN:DTIME E  S TIN="^"
 I TIN[U S Y=-1 Q
GET21 S TIN=$E(TIN,1) S:TIN?1L TIN=$C($A(TIN)-32)
 I '$F("DWMY",TIN) W !,"Enter a time unit letter such as 'D' for Days" G GET2
 S $P(LEN,U,1,2)=$S(TIN="D":"365.25^Days",TIN="W":"52^Weeks",TIN="M":"12^Mos",1:"1^Yrs")
 S MAXTIME=+LEN*10,TIN=$P(LEN,U,3) G:TIN'="" GET23
GET22 W !,"INTERVAL unit (Mo, Yr): Yr// " R TIN:DTIME E  S TIN="^"
 S:TIN="" TIN="Y" I TIN[U S Y=-1 Q
GET23 S TIN=$E(TIN,1) S:TIN?1L TIN=$C($A(TIN)-32)
 I '$F("MY",TIN) W !,"Enter 'M' for Months or 'Y' for Years" G GET22
 I TIN="Y" S $P(LEN,U,3)="Yrs"
 E  S $P(LEN,U,3)="Mos",TIN=$P(LEN,U,1),$P(LEN,U,1)=TIN/12
GET3 I $D(ONCOS("S")) S TIN=ONCOS("S") W !,"STATUS expression: ",TIN G GET4
 W !,"Enter survival STATUS expression: " R TIN:DTIME E  S TIN="^"
 I TIN[U S Y=-1 Q
 G:TIN'?."?" GET4 W !!,"Enter an expression like 'STATUS=0' to indicate"
 W !,"that the patient is dead.  In this example, 'STATUS' is"
 W !,"the name of a field that is a set of codes, for which 1 means"
 W !,"'living' and 0 means 'dead'.",! G GET3
GET4 D CHKCOND G:P GET3 S MORTEXP=TOU
 I $D(ONCOS("G")) S NGRPS=+ONCOS("G") G:NGRPS GET41
 R !,"Number of sub-groups: 1// ",NGRPS:DTIME E  S NGRPS="^"
 S:NGRPS="" NGRPS=1 I NGRPS[U S Y=-1 Q
GET41 I NGRPS=1 S COND=1,GRPEXP=1
 E  D SETGRPS^ONCOSSA2 G:NGRPS=1 GET41
 I $D(ONCOS("L")) S PLOT=$S(ONCOS("L")["P":1,1:0) Q:ONCOS("L")["Y"  G GET5
 S Y="Do you want curves plotted? No// "
 D GETYES^ONCOSINP Q:Y=-1  S PLOT=$T
GET5 W ! S Y="Survival analysis for "
 S Y=Y_$S(TEMPL:"template "_HEADER,1:"ALL cases")
 S Y=Y_" - OK? Yes// " D GETYES^ONCOSINP S:'$T Y=-1
 Q
