FHASN4 ; HISC/NCA - Nutrition Status Matrix (cont.) ;8/3/94  11:11
 ;;5.5;DIETETICS;;Jan 28, 2005
Q0 ; Process Screening
 K S,^TMP($J),CTN,CTR S CT=0,ANS=""
 F W1=0:0 S W1=$O(^FH(119.6,W1)) Q:W1'>0  D F0
 G P0
F0 I WRDS,W1'=WRDS Q
 F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",W1,FHDFN)) Q:FHDFN<1  S ADM=$G(^FHPT("AW",W1,FHDFN)) Q:ADM<1  S (NEW,OLD)=0 D Q1
 Q
Q1 ; Process screening inpatients for status comparison
 S ADTE=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",1) Q:ADTE=""
 S DSCH=$P($G(^DGPM(ADM,0)),"^",17) S:DSCH>0 DSCH=$P($G(^DGPM(+DSCH,0)),"^",1)
 I FHX1=2 S SDT=ADTE,EDT=DT
 S X1=EDT\1,X2=ADTE\1 D ^%DTC Q:'%Y
 I FHX1=1 Q:X<NOM  I X'>NOM,SDT<(ADTE\1) Q
 I FHX1=2 Q:X'=NOM
 I DSCH,DSCH>SDT,DSCH<EDT Q
 ; Tabulate status for new
 S X4=EDT+1,X4=X4+.0001,X4=9999999-X4
 S X4=$O(^FHPT(FHDFN,"S",X4)) G:'X4 Q2 S X5=^(X4,0)
 I $P(X5,"^",1)<$S(SDT:SDT,1:9999999) G Q2:$P(X5,"^",1)<ADTE,CNT
 S NEW=$S($P(X5,"^",2)<5:$P(X5,"^",2),1:5)
 G Q3
CNT ; Count unchanged status
 S (OLD,NEW)=$S($P(X5,"^",2)<5:$P(X5,"^",2),1:5)
 G Q5
Q2 ; Unclassified New
 S NEW=5
Q3 ; Tabulate status for old
 S L1=SDT\1,L1=L1-.0001
 S L1=$O(^FHPT(FHDFN,"S","B",L1)) G:L1=""!(L1\1>EDT) Q4
 S L1=9999999-L1,X6=$G(^FHPT(FHDFN,"S",L1,0)) G:X6="" Q4
 S X1=SDT\1-.0001,X1=X1\1,X2=3 D C^%DTC S THR=X
 I $P(X6,"^",1)>$S(THR:THR+.3,1:9999999) G:SDT\1=ADTE\1 Q4 S L1=$O(^FHPT(FHDFN,"S",L1)) G:L1="" Q4 S X6=$G(^(L1,0)) G:$P(X6,"^",1)<ADTE Q4
 S OLD=$S($P(X6,"^",2)<5:$P(X6,"^",2),1:5)
 G Q5
Q4 ; Unclassified Old
 S OLD=5
Q5 ; Set Classification for Old and New
 I OLD=NEW S:'$D(CTR(W1)) CTR(W1)="" S $P(CTR(W1),"^",OLD)=$P(CTR(W1),"^",OLD)+1,$P(CTR(W1),"^",6)=$P(CTR(W1),"^",6)+1
 S:'$D(S(W1,OLD)) S(W1,OLD)="" S $P(S(W1,OLD),"^",NEW)=$P(S(W1,OLD),"^",NEW)+1
 S:'$D(CTN(W1)) CTN(W1)="" S $P(CTN(W1),"^",OLD)=$P(CTN(W1),"^",OLD)+1
 I OLD=NEW Q:OLD'=5
 S CT=CT+1
 S:'$D(^TMP($J,"VEC1",W1,OLD,NEW,CT)) ^TMP($J,"VEC1",W1,OLD,NEW,CT)=""
 D PATNAME^FHOMUTL I DFN="" Q
 S Y=$P($G(^DPT(DFN,0)),"^",1) S:Y="" Y="Unknown" D PID^FHDPA
 S ^TMP($J,"VEC1",W1,OLD,NEW,CT)=$E(Y,1,30)_"^"_BID
 S $P(^TMP($J,"VEC1",W1,OLD,NEW,CT),"^",NEW+2)=$P(^TMP($J,"VEC1",W1,OLD,NEW,CT),"^",NEW+2)+1
 Q
P0 ; Print Summary
 D NOW^%DTC S (NOW,DTP)=% D DTP^FH S HD=DTP S PG=0,LN="",$P(LN,"-",80)=""
 I FHX1=1 S DTP=SDT D DTP^FH S DTE=DTP_" to " S DTP=EDT D DTP^FH S DTE=DTE_DTP
 I FHX1=2 S DTE="Admission "_NOM_" Days to "_HD
 F W1=0:0 S W1=$O(S(W1)) Q:W1=""  F ST=0:0 S ST=$O(S(W1,ST)) Q:ST=""  D P1
 F W1=0:0 S W1=$O(CTN(W1)) Q:W1=""  S NAM=$P($G(^FH(119.6,+W1,0)),"^",1) S:NAM'="" ^TMP($J,"CNT",NAM_"~"_W1,0)=$P(CTN(W1),"^",1)_"^"_$P(CTN(W1),"^",2)_"^"_$P(CTN(W1),"^",3)_"^"_$P(CTN(W1),"^",4)_"^"_$P(CTN(W1),"^",5)_"^"_$G(CTR(W1))
 S (NAM,STS)="",N=1
 F W1=0:0 S NAM=$O(^TMP($J,"VEC2",NAM)) Q:NAM=""!(ANS="^")  D HDR^FHASN3:N=1,HD^FHASN3:N'=1 S (TOT,SUM)=0,TOT1="",N=N+1 F ST=0:0 S ST=$O(^TMP($J,"VEC2",NAM,ST)) D:ST<1 LAST Q:ST<1!(ANS="^")  S STS=ST,D1=^(STS,0) D P2
 K ^TMP($J),CTN,CTR,N,SUM,TOT,TOT1,X
 W ! Q
P1 S NAM=$P($G(^FH(119.6,+W1,0)),"^",1)
 Q:NAM=""  S ^TMP($J,"VEC2",NAM_"~"_W1,ST,0)=$G(S(W1,ST))
 F LL=1:1:5 I $D(^TMP($J,"VEC1",W1,ST,LL)) F CT=0:0 S CT=$O(^TMP($J,"VEC1",W1,ST,LL,CT)) Q:CT<1  S ^TMP($J,"VEC2",NAM_"~"_W1,ST,"NS",LL,CT)=$G(^TMP($J,"VEC1",W1,ST,LL,CT))
 Q
P2 D:$Y'<(IOSL-3) HD^FHASN3 Q:ANS="^"
 W !,$S(STS=1:"I",STS=2:"II",STS=3:"III",STS=4:"IV",1:"UNC")
 S TOT=$G(^TMP($J,"CNT",NAM,0)) W ?24,$J($P(TOT,"^",STS),7) S SUM=SUM+$P(TOT,"^",STS)
 W ?37 F K=1:1:5 S X=$P(D1,"^",K) W $J(X,7) S $P(TOT1,"^",K)=$P(TOT1,"^",K)+X
 S X=$P(TOT,"^",5+STS) W $J(X,7)
 F LL=0:0 S LL=$O(^TMP($J,"VEC2",NAM,STS,"NS",LL)) Q:LL<1  F CT=0:0 S CT=$O(^TMP($J,"VEC2",NAM,STS,"NS",LL,CT)) Q:CT<1  S Y=^(CT) W !?1,$P(Y,"^",2),?10,$E($P(Y,"^",1),1,26),?37 D
 .F L=1:1:5 S AST=$P(Y,"^",L+2) S:AST AST="*" W $J(AST,7)
 .Q
 Q
LAST ; Last Total Line
 W !,LN,!,"Total",?24,$J(SUM,7),?37 F L=1:1:5 W $J($P(TOT1,"^",L),7)
 W $J($S($P(TOT,"^",11)'="":$P(TOT,"^",11),1:""),7)
 Q
