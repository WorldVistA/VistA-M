LREXEC ;SLC/RWF - EXECUTE CODE EXPANSION ; 6/2/86  7:54 AM ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 F LREX1=1:1 S LREX2=$P(LREXEC,U,LREX1) Q:LREX2=""  D LR2
 K LREX1,LREX2 Q
LR2 I +LREX2'=LREX2 S LREX2=$O(^LAB(62.07,"B",LREX2,0)) I LREX2="" W " Execute code ",LREX2," not found." Q
 I $D(^LAB(62.07,+LREX2,.1)) X ^(.1)
 Q
DELTA ;
 F LREX1=1:1 S LREX2=$P(LREXEC,U,LREX1) Q:LREX2=""  D LR4
 K LREX1,LREX2 Q
LR4 S LREX2=$O(^LAB(62.1,"B",LREX2,0)) I LREX2="" W " Delta code ",LREX2," not found." Q
 I $D(^LAB(62.1,LREX2,1)) X ^(1)
 Q
SETVAL ;Set value in X into LRSB for test in X1.
 Q:'$D(X)!('$D(X1))  Q:X1=""  S Q2=$O(^LAB(60,"B",X1,0)) Q:Q2'>0  S Q1=$S($D(^LAB(60,Q2,0)):$P($P(^(0),"^",5),";",2),1:"") Q:Q1'>0
 S LRSB(Q1)=X Q
SETUTL ;Set ^TMP("LR",$J,"VTO",test) so that a test in X will be verified.
 Q:'$D(X1)  Q:X1=""  S Q2=$O(^LAB(60,"B",X1,0)) Q:Q2'>0  S ^TMP("LR",$J,"VTO",Q2)=""
 Q
