LAKUR1 ;SLC/RWF - URINALYSIS Part 2 ; 9/19/87  18:36 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 K TY S T3=0 D INIT F N1=0:0 S N1=$O(^TMP("LA",$J,N1)) Q:N1>30!(N1'>0)  S I3=^(N1,3),I4=^(4) I I3 S TYPE=I4 W ! D RESULT
 D HD1,HD4,HD2
L F J=0:0 Q:FLAG!DONE  S DX=0,DY=22 X XY W !,?40,*13,"URINE: " R TYPE#1:DTIME D CHECK
 D STORE:DONE
 K X,A,DATYP,X,DD,DA,CODE,TYPE,CONT,DONE,J,K,T1,T2,T3,KEY,TY Q
CHECK I '$T!(TYPE=U) S FLAG=1 Q
 S LINE=$S(TYPE="":"STOP",TYPE="!":"COM","\[]"[TYPE:"PAGE",KEY'[TYPE:"HELP",1:"RESULT") D @LINE Q
RESULT S Y=KEY(TYPE) W *13,$P(^LAB(60,^TMP("LA",$J,Y,0),0),U,1) W:$D(TY(T3,TYPE)) "  ",TY(T3,TYPE),"//" R "  ",X:DTIME I '$T!(X=U) S FLAG=1 Q
DELETE Q:X=""  I X="@"&$D(TY(T3,TYPE)) K TY(T3,TYPE) Q
 S DD=^TMP("LA",$J,Y,"DD") D SET:$P(DD,U,2)["S" X $P(DD,U,5,99) I $D(X) S TY(T3,TYPE)=X Q
HELP2 S DX=0,DY=22 W !,$C(7),$S($D(^DD(63.04,DA,3)):^(3),1:"") I $P(DD,U,2)'["S" R X:2 Q
 F K=1:1 Q:$P(LRSET,";",K)=""  W !,"You can enter '",$P($P(LRSET,";",K),":",1),"' which stands for ",$P($P(LRSET,";",K),":",2)
 R !,"Press return to continue ",X:DTIME D HD1,HD2 Q
 Q
HELP I TYPE'="?" W *13,$C(7),"  INVALID KEY" R X:2 Q
 S DX=0,DY=LRDY,X=0 X XY F I1=T3*30+1:9:T2 W !!!!,?7 F I=I1:1:I1+8 Q:I>T2  S X=$S($D(^TMP($J,T3,I)):^(I),1:"^"),K=$S($D(TY(T3,X)):TY(T3,X),1:"") W $J(K,8)
 Q
SET S LRSET=$P(DD,U,3),%=$P($P(";"_LRSET,";"_X_":",2),";",1) I %]"" W "  ",% Q
 F I=1:1 S LRSUBS=$P(LRSET,";",I),Y=$F(LRSUBS,":"_X) G HUH:LRSUBS="" IF Y S X=$P(LRSUBS,":",1) W $E(LRSUBS,Y,255) Q
 Q
HUH K X Q
 W:X'["?" "  ??" W $C(7) K X F K=1:1 Q:$P(CODE,";",K)=""  W !,"YOU CAN ENTER ",$P($P(CODE,";",K),":")," WHICH STANDS FOR ",$P($P(CODE,";",K),":",2)
 Q
PAGE S T3=$S(TYPE="\":0,TYPE="[":1,TYPE="]":2,1:0) D INIT Q
STOP D EVAL S T3=0
DONE R !,"ARE YOU FINISHED WITH THIS PATIENT (Y/N) Y//",X:DTIME I '$T S FLAG=1 Q
 S:X="" X="Y" I "YyNn^"'[X W $C(7),"  ??" G DONE
 S:"Yy"[X DONE=1 S:U[X FLAG=1 D:FLAG=DONE INIT Q
 Q
EVAL D HD1
 F T3=0:1:2 F I=0:0 S I=$O(^TMP($J,T3,I)) Q:I=""  S Y=^(I) I $D(TY(T3,Y)) W !?2,^TMP("LA",$J,I,.1),": ",?12 S V=TY(T3,Y) X ^TMP("LA",$J,I,2) W $J(V,3)
 Q
STORE F T3=0:1:2 F I=0:0 S I=$O(^TMP($J,T3,I)) Q:I=""  S Y=^(I) I $D(TY(T3,Y)) S V=TY(T3,Y) X ^TMP("LA",$J,I,2) S @^TMP("LA",$J,I,1)=V
 Q
HD1 W @IOF,!!,"Patient name: ",PNM,?45,"SSN: ",SSN Q
HD2 W !,?10,"URINALYSIS  Screen ",$P("MAIN$CAST's$CRYSTAL's","$",T3+1)
 S LRDY=$Y W !,"'?'=DISPLAY, '!'=COMMENTS, '\'=MAIN, '['=CASTS, ']'=CRYSTALS, <RETURN>=EXIT" F I=1:1:T1 W !,"KEY",?7,T1(I),!,"TEST",?7,T2(I),!!
HD3 S TYPE="?" D HELP Q
HD4 Q:$O(^LR(LRDFN,"CH",LRDAT,1))<1  W !,?24,"> Urine Chem profile <",!
 S I=1 F C=1:0 S C=$O(^LR(LRDFN,"CH",LRDAT,C)) Q:C'>0  S V=^(C),X=$O(^LAB(60,"C","CH;"_C_";1",0)) I X>0 W $P(^LAB(60,X,0),U,1),": ",$P(V,U,1)_" "_$P(V,U,2),?(I*25) S I=I+1 I I>3 W ! S I=1
 Q
COM W !,"Comment: ",RMK,! I RMK="" R RMK:DTIME G COM2
 S Y=RMK D RW^LRDIED S RMK=$S(X="@":"",1:Y)
COM2 D HD1,HD4,HD2 Q
INIT K KEY,T1,T2 S KEY="",N1=T3*30,N2=N1+27,T1=1,(T1(T1),T2(T1))=""
 F I=0:0 S I=$O(^TMP($J,T3,I)) Q:I=""  S X=^(I),KEY(X)=I,KEY=KEY_X
 F I=N1+1:1:N2 S X=$S($D(^TMP("LA",$J,I,4)):^(4),1:""),Y=$S($D(^(.1)):^(.1),1:""),T1(T1)=T1(T1)_$J(X,8),T2(T1)=T2(T1)_$J(Y,8) Q:$O(^TMP($J,T3,I))=""  I '(I-N1#9) S T1=T1+1,(T1(T1),T2(T1))=""
 S T2=I,DONE=0,FLAG=0 D HD1,HD2 Q
