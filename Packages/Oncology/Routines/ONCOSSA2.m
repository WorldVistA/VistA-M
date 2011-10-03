ONCOSSA2 ;WASH ISC/SRR-SURVIVAL ANALYSIS CONT-2  ;7/28/92  18:38
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;
SETGRPS ;define group variables from ONCOS("G") input variable.
 G:'$D(ONCOS("G")) SET1
 S TIN=$P(ONCOS("G"),U,2) G SET3:TIN'="",SET1:'$D(ONCOS("G",1))
 F COND=0:0 S COND=$O(ONCOS("G",COND)) Q:COND=""  S Y=ONCOS("G",COND) D SET4
 K ONCOS("G") S COND=0
 Q
SET1 W !,"You may enter an expression that evaluates between 1 and ",NGRPS
 W !,"or separate conditions for each sub-group."
 S Y="Do you want to enter an expression? Yes// ",Z="" D GETYES^ONCOSINP
 E  G:X["?" SET1 I Y=-1 S NGRPS=1 Q
 E  S COND=0 G SUBGRPS
SET2 R !,"Enter sub-group expression: ",TIN:DTIME
 I TIN[U S NGRPS=1 Q
SET3 D CHKCOND^ONCOSSA1 G:P SET2
 S GRPEXP=TOU,COND=1 F X=1:1:NGRPS S ^TMP($J,"GRP",X)="("_TIN_") = "_X
 W !,"The cases that do not evaluate between 1 and ",NGRPS," are dropped."
 Q
SET4 S COND(COND)=$P(Y,U,3,99),^TMP($J,"GRP",COND)=$P(Y,U,2)
 S X=+Y D SETFD^ONCOSSA1
 Q
 ;
SUBGRPS ;get subgroups
 ;in:  DIC,NGRPS
 ;out: VV,COND,^TMP($J,"GRP") - see ONCOSSA1
 ;do:  ^DIC
 N CONDCT,FLDNAM,FLDNUM,IVAL,OP,VAL S CONDCT=0
 W !,"Enter truth tests that will categorize the cases into ",NGRPS," groups."
SUB1 W !,?6,"-",CONDCT+1,"- Search for field: " R X:DTIME
 I X["?" W !,?6,"Enter a field name." G SUB1
SUB2 I X=""!(X[U) S NGRPS=CONDCT W !," Only ",NGRPS," sub-groups will be considered.",! Q
 D ^DIC I Y<1 W *7,"???" G SUB1
 S FLDNUM=+Y,FLDNAM=$P(Y,U,2)
SUB3 W !,?6,"-",CONDCT+1,"- Condition: " R X:DTIME G:X[U SUB2
 S X=$E(X,1) S:X?1L X=$C($A(X)-32) S OP=$F("=><[!]EGLCMN",X)-1 S:OP>6 OP=OP-6
 I 'OP W !,"Choose from EQUAL TO, LESS THAN, GREATER THAN, CONTAINS, ",!,"          MATCHES or NULL",! G SUB3
 W "  [",$P("EQUAL TO^GREATER THAN^LESS THAN^CONTAINS^MATCHES^NULL",U,OP),"]"
 S OP=$E("=><[?]",OP),VAL=""
SUB4 I OP'="]" W !?6,"-",CONDCT+1,"- Value: " R VAL:DTIME G:X[U SUB2
 I VAL["?" W !,"Enter a value." G SUB4
 S IVAL=VAL,X=FLDNUM D SETFD^ONCOSSA1 S Y=FLDDAT(X)
 I +Y&($P(Y,U,4)]"") S Y=$P(Y,U,4) F %=1:1 S X=$P(Y,";",%) Q:X=""  I VAL=$P(X,":",2) S IVAL=$P(X,":",1) Q
 S:IVAL'=+IVAL IVAL=""""_IVAL_"""" S:OP="]" OP="=""""",IVAL="",VAL=""
 S CONDCT=CONDCT+1,COND(CONDCT)="VAL("_FLDNUM_")"_OP_IVAL
 S ^TMP($J,"GRP",CONDCT)="("_FLDNAM_OP_VAL_")"
 G:CONDCT<NGRPS SUB1
 Q
