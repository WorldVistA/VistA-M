DGPTFTR0 ;ALB/JDS/ADL - PTF TRANSMISSION ; 10/1/03 6:52pm
 ;;5.3;Registration;**247,510,524**;Aug 13, 1993
 ;;ADL;Update for CSV Project;;Mar 26, 2003
 S DGSSN=$P(DG10,U,9),DGHEAD=$S($E(DGSSN,10)="P":"P",1:" ")_$E(DGSSN,1,9)_" ",DGADM=$P(DG0,U,2)\1,DGHEAD=DGHEAD_$E(DGADM,4,5)_$E(DGADM,6,7)_$E(DGADM,2,3)
 S Y=DGHEAD,L=3,X=DG0,Z=3 D ENTER S Y=Y_$E($P(X,U,5)_"   ",1,3)
 S DGHEAD=Y,Y="    "_Y D HEAD^DGPTFTR1
101 S Y=$S(T1:"C",1:"N")_"101"_DGHEAD,DGNAM=$P(DG10,U,1) D DGNAM S Y=Y_$E($P(DGNAM,",",1)_"           ",1,12)_$J($E($P(DGNAM,",",2),1),1)_$J($E($P($P(DGNAM,",",2)," ",2),1),1)
 S Y=Y_$S($D(^DIC(45.1,+$P(DG101,U,1),0)):$J($P(^(0),U,1),2),1:"  ")
 S L=3,X=DG101,Z=5 D ENTER S Y=Y_$E($P(X,U,6)_"   ",1,3)
 S Y=Y_$S("A0"[$P(DG0,U,5):" ",1:$J($P(DG101,U,3),1))
 ;POW Location
 S Y=Y_$S($P(DG52,U,5)="N":1,$P(DG52,U,5)'="Y":3,$P(DG52,U,6)>0&($P(DG52,U,6)<7):3+$P(DG52,U,6),$P(DG52,U,6)>6&($P(DG52,U,6)<9):$C($P(DG52,U,6)+58),1:" ")
 S Y=Y_$S($D(^DIC(11,+$P(DG10,U,5),0)):$E(^(0),1),1:" ")_$J($P(DG10,U,2),1)
 S DGDOB=$P(DG10,U,3)\1,Y=Y_$E(DGDOB,4,5)_$E(DGDOB,6,7)_(1700+$E(DGDOB,1,3))
 S C=$S($D(^DIC(45.82,+$P(DG101,U,4),0)):$P(^(0),U,1),1:" "),(G,E)=" " S:C=6 DGAO=$P(DG321,U,2),G=$S($P(DG321,U,1)'="Y":1,DGAO="N":2,DGAO="Y":3,1:4)
 S:C="Z"!(C>1&(C<8)) DGNT=$P(DG321,U,12),E=$S($P(DG321,U,3)'="Y":1,DGNT="N":2,DGNT="T":3,DGNT="B":4,1:" ")
 S Y=Y_C_G_E K C,G,E
 ; state code
 S X=$S($D(^DIC(5,+$P(DG11,U,5),0)):^(0),1:""),L=2,Z=3 D ENTER0
 ; county code
 S X=$S($D(^DIC(5,+$P(DG11,U,5),1,+$P(DG11,U,7),0)):^(0),1:""),L=3,Z=3 D ENTER0
 ; zip code
 S X=DG11,Z=6,L=5 D ENTER
 ; means test
 S Y=Y_$E($P(DG0,U,10),1,2)
 F K=$L(Y):1:79 S Y=Y_" "
 D SAVE
P401 G 401:'$D(^DGPT(J,"401P"))!(T1) S DG41=^("401P"),Y=$S(T1:"C",1:"N")_"401"_DGHEAD_"P"_"           "
 S DG41=$S($D(^DGPT(J,"401P")):^("401P"),1:"")
 S L=1 F K=1:1:5 S:'$P(DG41,U,K) DG41=$P(DG41,U,1,K-1)_U_$P(DG41,U,K+1,99),K=K-1 S L=L+1 Q:L=5
 F I=1:1:5 S DGPTTMP=$$ICDOP^ICDCODE(+$P(DG41,U,I),$$GETDATE^ICDGTDRG(PTF)) S Y=Y_$S(+DGPTTMP>0&($P(DGPTTMP,U,10)):$J($P($P(DGPTTMP,U,2),".",1),2)_$E($P($P(DGPTTMP,U,2),".",2)_"   ",1,3),1:"     ")_"  "
 I $E(Y,40)'=" " S Y=Y_"      " D SAVE
401 G 501:'$D(^DGPT(J,"S")) K ^UTILITY($J,"S") S I=0
SUR S I=$O(^DGPT(J,"S",I)) G 501:I'>0 S DGSUR=^(I,0) G SUR:'DGSUR
 G SUR:DGSUR<T1!(DGSUR>T2) S DGSUD=+^(0)\1,^UTILITY($J,"S",DGSUD)=$S($D(^UTILITY($J,"S",DGSUD)):^(DGSUD),1:0)+1,F=$S(DGSUD<2871000:0,1:1)
 I ^UTILITY($J,"S",DGSUD)>$S(F:3,1:2) D  I Y'=1 S DGERR=1 Q
 .W !!,"**There are more than ",$S(F:"three",1:"two")," surgeries on the same date**"
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="OK to continue?" D ^DIR K DIR
 S Y=$S(T1:"C",1:"N")_"40"_^(DGSUD)_DGHEAD_$E(DGSUD,4,5)_$E(DGSUD,6,7)_$E(DGSUD,2,3)_$S($D(^DIC(45.3,+$P(DGSUR,U,3),0)):$P(^(0),U,1),1:"  ")
 S L=1,X=DGSUR F Z=4:1:7 D ENTER
 S L=1 F K=8:1:12 S:'$P(DGSUR,U,K) DGSUR=$P(DGSUR,U,1,K-1)_U_$P(DGSUR,U,K+1,99),K=K-1 S L=L+1 Q:L=5
 F K=8:1:12 S DGPTTMP=$$ICDOP^ICDCODE(+$P(DGSUR,U,I),$$GETDATE^ICDGTDRG(PTF)) S Y=Y_$S(+DGPTTMP>0&($P(DGPTTMP,U,10)):$J($P($P(DGPTTMP,U,2),".",1),2)_$E($P($P(DGPTTMP,U,2),".",2)_"   ",1,3),1:"     ")_"  "
 S Y=Y_"      " D SAVE G SUR
501 G 501^DGPTFTR2
 Q
ENTER S Y=Y_$J($P(X,U,Z),L)
 Q
ENTER0 S Y=Y_$S($P(X,U,Z)]"":$E("00000",$L($P(X,U,Z))+1,L)_$P(X,U,Z),1:$J($P(X,U,Z),L))
 Q
SAVE D START^DGPTFTR1 S:'DGERR ^UTILITY($J,DGCNT,0)=Y,DGCNT=DGCNT+1
Q Q
DGNAM S X=DGNAM I X?.E.P F I=1:1:$L(X) S Z=$E(X,I) Q:Z=","  S:Z?.P&(Z]"") X=$E(X,1,I-1)_$E(X,I+1,$L(X)),I=I-1 Q:X'?.E.P
 I X?.E.L D UP^DGHELP
 S DGNAM=X
