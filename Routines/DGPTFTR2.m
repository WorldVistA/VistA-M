DGPTFTR2 ;ALB/JDS - ALB/BOK  PTF TRANSMISSION ; 01 DEC 87 @0800
 ;;5.3;Registration;**729**;Aug 13, 1993;Build 59
501 ;
 K DGCMVT I T2'=9999999 S DGCMVT=$O(^DGPT(J,"M","AM",+$P(T2,".")_".2359")),DGCMVT=$S('DGCMVT:1,$O(^(DGCMVT,0)):$O(^(0)),1:1)
 F I=0:0 S I=$O(^DGPT(J,"M",I)) G PROC:I'>0 I $D(^(I,0)) S DGM=^(0),DGTD=$P(DGM,U,10) S:$D(DGCMVT) DGTD=$S(I=DGCMVT:$P(T2,".")_".2359",1:DGTD) I $P(DGM,U,17)'="n",DGTD,DGTD'<T1,DGTD'>T2 D MOV
MOV S DGM=$P(DGM,U,1,9)_U_$P(DGM,U,11,15),L=1
 F Z=5:1:14 S:'$P(DGM,U,Z) DGM=$P(DGM,U,1,Z-1)_U_$P(DGM,U,Z+1,99) S:'$P(DGM,U,Z) Z=Z-1 S L=L+1 Q:L=10
 S Y=$S(T1:"C",1:"N")_"501"_DGHEAD,X=$P(DGTD,".")_"       ",Y=Y_$E(X,4,5)_$E(X,6,7)_$E(X,2,3)
 N DGSARRX,DGSARRY
 S DGARRX=$$TSDATA^DGACT(42.4,$P(DGM,U,2),.DGARRY)
 S $P(DGM,U,2)=$G(DGARRY(7))
 S L=2,X=DGM,Z=2 D ENTER0 S Y=Y_"  "
 S L=3 F Z=3,4 D ENTER0
 S L=1,X=DG57,Z=4 D ENTER S:I=1 DG502=Y
 F Z=5:1:9 S F=$S($D(^ICD9(+$P(DGM,U,Z),0)):$P(^(0),U,1),1:"   ."),F=$P(F,".",1)_$E($P(F,".",2)_"    ",1,3),F=F_$E("      ",1,7-$L(F)),Y=Y_F
 ; bed occupant
 I T1 S Y=Y_$S(I=1:$E($P(DG70,U,14)_" "),$P(+DGTD,".")=$P(T2,"."):5,1:1)
 I 'T1 S Y=Y_$S(I=1:$E($P(DG70,U,14)_" "),1:" ")
 D SAVE
 Q
 ;
PROC K DGCMVT,^UTILITY($J,"PROC") S I=0
601 S I=$O(^DGPT(J,"P",I)) G 701:I'>0 S (X,DGPROC)=^(I,0) G 601:'DGPROC
 G 601:DGPROC<T1!(DGPROC>T2) S DGPROCD=+^DGPT(J,"P",I,0)\1,^UTILITY($J,"PROC",DGPROCD)=$S($D(^UTILITY($J,"PROC",DGPROCD)):^(DGPROCD),1:0)+1
 I ^UTILITY($J,"PROC",DGPROCD)>1 W !,"More than one procedure record on same date" S DGERR=1 Q
 S Y=$S('T1:"N",1:"C")_"60"_^(DGPROCD)_DGHEAD_$E(DGPROCD,4,7)_$E(DGPROCD,2,3)
 N DGARRY,DGARRX ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(X,U,2),.DGARRY)
 S $P(X,U,2)=$G(DGARRY(7))
 S L=2,Z=2 D ENTER0 S L=1,Z=3 D ENTER S L=3,Z=4 D ENTER0
 S L=1 F K=5:1:9 S:'$P(DGPROC,U,K) DGPROC=$P(DGPROC,U,1,K-1)_U_$P(DGPROC,U,K+1,99),K=K-1 S L=L+1 Q:L=5
 F K=5:1:9 S Y=Y_$S($D(^ICD0(+$P(DGPROC,U,K),0)):$J($P($P(^(0),U,1),".",1),2)_$E($P($P(^(0),U,1),".",2)_"   ",1,3),1:"     ")_"  "
 S Y=Y_"      " D SAVE G 601
 Q
 ;
701 S Y=$S(T1:"C",1:"N")_"701"_DGHEAD,DGDDX=+DG70\1_"       ",Y=Y_$E(DGDDX,4,5)_$E(DGDDX,6,7)_$E(DGDDX,2,3)
 S X=DG70
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(X,U,2),.DGARRY)
 S $P(X,U,2)=$G(DGARRY(7))
 S (L,Z)=2 D ENTER0 S Y=Y_"  " K DGDDX
 S X=DG70 I "467"[($P(X,U,3)\1) S Y=Y_$P(X,U,3)_"         " G J
 S L=1 F Z=3:1:5 D ENTER
 S Y=Y_$S($D(^DIC(45.6,+$P(X,U,6),0)):$P(^(0),U,2),1:" "),L=3,Z=12 D ENTER S Y=Y_$E($P(X,U,13)_"   ",1,3)
J S L=3,Z=8 D ENTER0
 S Y=Y_$S($D(^DIC(10,+$P(DG10,U,6),0)):$J($P(^(0),U,2),1),1:" ")_$J($P(DG70,U,9),1)
 S DGXLS=$S($D(^ICD9(+$P(DG70,U,10),0)):$P(^(0),U,1),1:""),Y=Y_$S(DGXLS[".":$J($P(DGXLS,".",1),3)_$E($P(DGXLS,".",2)_"   ",1,3),1:$J(DGXLS,6))_" "
 S L=$P(DG70,U,16,24) S DG702="" F K=1:1:9 I $D(^ICD9(+$P(L,U,K),0)) S DG702=DG702_$P(^(0),U,1)_U
 I DG702']"" S Y=Y_"X"
 D Y
 I T1 F K=34:1:47,60 S Y=$E(Y,1,K-1)_" "_$E(Y,K+1,80)
 I T1 D CEN^DGPTFTR1 S:'DGERR ^UTILITY($J,DGCNT,0)=Y,DGCNT=DGCNT+1 Q
 I 'T1 D SAVE
702 ;
 Q:DG702']""
 S Y="N702"_$E(Y,5,33)
 F K=1:1:5 S F=$P(DG702,U,K),F=$P(F,".",1)_$E($P(F,".",2)_"   ",1,3),F=F_$E("      ",1,7-$L(F)),Y=Y_F
 D Y
 I 'DGERR S ^UTILITY($J,DGCNT,0)=Y,DGCNT=DGCNT+1
 S DG702=$P(DG702,U,6,9)
 ;
703 Q:DG702']""
 S Y="N703"_$E(Y,5,33)
 F K=1:1:4 S F=$P(DG702,U,K),F=$P(F,".",1)_$E($P(F,".",2)_"   ",1,3),F=F_$E("      ",1,7-$L(F)),Y=Y_F
 D Y
 I 'DGERR S ^UTILITY($J,DGCNT,0)=Y,DGCNT=DGCNT+1
 Q
 ;
ENTER S Y=Y_$J($P(X,U,Z),L)
 Q
 ;
ENTER0 S Y=Y_$S($P(X,U,Z)]"":$E("00000",$L($P(X,U,Z))+1,L)_$P(X,U,Z),1:$J($P(X,U,Z),L))
 Q
 ;
SAVE D START^DGPTFTR1 S:'DGERR ^UTILITY($J,DGCNT,0)=Y,DGCNT=DGCNT+1
Q Q
 ;
Y F K=$L(Y):1:79 S Y=Y_" "
