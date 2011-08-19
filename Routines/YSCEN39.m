YSCEN39 ;ALB/ASF-PASS REPORT ;4/3/90  10:29 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
ENPASS ; Called from MENU option YSCENPASS
 ;
 R !!,"(L)ast Transfer/Pass or (O)n Pass list? On Pass// ",X:DTIME S YSTOUT='$T,YSUOUT=X["^" I YSTOUT!YSUOUT G END1
 S X=X_"O",X=$TR($E(X),"lo","LO") I "OL"'[X W !,"Enter 'O' for patients currently on pass, 'L' for list of all pts last transfer type",$C(7) G ENPASS
 S YSFLG=1 S:"L"[X YSFLG=0
 D AX^YSCEN3 G:Y<1!POP END1 I $D(IO("Q")) K IO("Q") S ZTRTN="PASQ^YSCEN39",ZTDESC="YS IP PASS" F ZZ="T6","W1","W2","YSFLG" S ZTSAVE(ZZ)=""
 I  D ^%ZTLOAD W !,$S($D(ZTSK):"QUEUED",1:"Not queued"),$C(7) G END1
PASQ ;
 K YSOPT1 S (Q3,P,P1)=0,YSOPT2="ENPASS1^YSCEN39" D:T6'="A" L2^YSCEN2 D:T6="A" L1^YSCEN2
END1 ;
 K B,D1,YSC,YSFLG,A,YSOPT1,YSOPT2,X,Y,YST,YST1,P,P1,YSPRG,DA,YSDFN,YSPRG3,YSO,T6 G END^YSCEN2
ENPASS1 ;
 Q:Q3  D H1 S N3="",YSC=0 F  S N3=$O(^UTILITY($J,N3)) Q:N3=""  D PASS1 Q:Q3
 W !!?30,YSC," Patients ",$S(YSFLG:"on Pass",1:"listed") D WAIT^YSCEN1 Q
PASS1 ;
 S YSDFN=0 F  S YSDFN=$O(^UTILITY($J,N3,YSDFN)) Q:'YSDFN!Q3  S DFN=YSDFN,VAIP("D")="L" D IN5^VADPT,DEM^VADPT S D1=VAIP(1) I (D1]"")&($P(VAIP(2),U)=2) S YST1=$P(VAIP(3),U),YST=$P(VAIP(4),U) D L2A^YSCEN34
 Q
H1 ;
 S YSTLE=$S(YSFLG=0:"LAST TRANSFER/",1:"ON ")_"PASS LIST" W:$Y>1 @IOF W "WARD: ",W2,?$X+(IOM-$X-25-($L(YSTLE))/2),YSTLE D TIME^YSCEN2
 I $D(YSOPT9L) W !?3,YSOPT9L,$P(^VA(200,YSWHO,0),U)
 S G2=^YSG("SUB",T6,0)
 W !,"TEAM: ",$P(G2,U),?20," Beds: ",$P(^YSG("SUB",T6,1),U,3),?35," Patients: ",YSTM S X=$P(G2,U,9) W !,"Team Leader: " D D3 W ?20,"  Physician: " S X=$P(G2,U,2) D D3 W ?50,"  Psychologist: " S X=$P(G2,U,3) D D3
H12 ;
 W !,"NAME",?22,"DATE",?35,"TYPE",?64,"TO",?68,$S(YSFLG=0:"EXPECT/FROM",1:"RETURNING"),!
 S C1="",$P(C1,"-",79)="" W C1,! Q
D3 ;
 Q:X'?1N.N  S X=$P(^VA(200,X,0),U),X(2)=$E($P(X,",",2),1,2) S X(2)=$S(X(2)?1P.E:$E(X(2),2),1:$E(X(2))) W $P(X,","),",",X(2) Q
 ;
NM ; Called from MENU option YSCENNAM
 ;
 W @IOF,!?IOM-$L("PATIENT NAME SEARCH")\2,"PATIENT NAME SEARCH"
L ;
 R !!,"Enter first letters of patient's LAST name: ",S:DTIME S YSTOUT='$T,YSUOUT=S["^" G:YSTOUT!YSUOUT END
 S YSR1="S",YSR2="",YSR3="?1A.ANP",YSR4="Enter the alphabetic characters of the patients last name only!  Do not use more letters than you are sure are correct."
 D ^YSCEN14 G L:S="?",END:S=-1
 F ZZ=1:1:$L(S) I $E(S,ZZ)?1L S D=$E(S,ZZ),D=$A(D)-32,S=$E(S,0,ZZ-1)_$C(D)_$E(S,ZZ+1,30)
L1 ;
 K ^UTILITY($J) W !?50 S YSFS=0,L=$L(S),V3=0
 S YSDFN=0 F  S YSDFN=$O(^YSG("INP","CP",YSDFN)) Q:'YSDFN  S DA=$O(^(YSDFN,0)),YSNM=$P(^DPT(YSDFN,0),U) I $E(YSNM,1,L)=S S ^UTILITY($J,YSNM,YSDFN)=DA
 D L2,L4:V3 I $D(V3) W !!,"SEARCH COMPLETE",! W:'V3 "**** NO INPATIENTS FOUND WITH LAST NAMES BEGINNING: ",S
END ;
 K A,B3,D,DA,I,I0,L,S,S1,T,V3,W1,W2,X,X1,X2,YS,YSFS,YSLFT,YSNM,YSDFN,YSNOFORM,YSCENN Q
 Q
L2 ;
 S (YSNM,I)="",$P(I,"=",79)="" W !?40,"Ward",?57,"Team",!,I F  S YSNM=$O(^UTILITY($J,YSNM)) Q:YSNM=""  D
 .S V3=V3+1,YSDFN=$O(^(YSNM,0)),DA=^(YSDFN),W1=$P(^YSG("INP",DA,7),U),YS(V3)=YSDFN_U_W1_U_DA
 .W !,$J(V3,3)," ",YSNM,?40,$P(^DIC(42,W1,0),U),?55," ",$P(^YSG("SUB",$P(^YSG("INP",DA,0),U,4),0),U)
 Q
L4 ;
 R !!,"Enter above number for patient profile or return to continue: ",B3:DTIME S YSTOUT='$T,YSUOUT=B3["^" Q:YSTOUT
 S YSR1="B3",YSR2="",YSR3=V3,YSR4="Enter 1 to "_V3_" or just hit return to to continue" D:B3]"" ^YSCEN14 K YSR1,YSR2,YSR3 G L4:B3="?" Q:B3'?1N.N
 S YSDFN=+YS(B3),DA=$P(YS(B3),U,3),^DISV(DUZ,"^DPT(")=YSDFN,^DISV(DUZ,"^YSG(""INP"",")=DA
 K ^UTILITY($J),DA,V3,B3,YSNM,S,I,YSNOFORM S YST=0,DA=YSDFN,YSA8="1,2,3,4,5,6,7,8,9,10",YSCENN=1 D ENPT^YSUTL,ENP^YSPPJ Q
