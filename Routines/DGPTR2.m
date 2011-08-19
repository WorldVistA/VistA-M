DGPTR2 ;ALB/JDS/MJK/MTC/ADL - ALB/BOK  PTF TRANSMISSION ; 6/6/05 11:48am
 ;;5.3;Registration;**183,338,423,510,636,729**;Aug 13, 1993;Build 59
 ;;ADL;Update for CSV Project;;Mar 27,2003
501 ; -- setup 501 transactions
 ; DG*636
 N DGPTMVDT
 K DGCMVT I T2'=9999999 S DGCMVT=$O(^DGPT(J,"M","AM",+$P(T2,".")_".2359")),DGCMVT=$S('DGCMVT:1,$O(^(DGCMVT,0)):$O(^(0)),1:1)
 F I=0:0 S I=$O(^DGPT(J,"M",I)) G 535:I'>0 I $D(^(I,0)) D
 . S DGM=^(0),DGSC=$P(DGM,U,18),DGAO=$P(DGM,U,26),DGIR=$P(DGM,U,27),DGEC=$P(DGM,U,28),DGMST=$P(DGM,U,29),DGHNC=$P(DGM,U,30),DGTD=$P(DGM,U,10),DGPTMVDT=$P(DGM,U,10)
 . S:$D(DGCMVT) DGTD=$S(I=DGCMVT:$P(T2,".")_".2359",1:DGTD)
 . I $P(DGM,U,17)'="n",DGTD,DGTD'<T1,DGTD'>T2 D MOV
MOV S DGCDR=$P(DGM,U,16),DGM=$P(DGM,U,1,9)_U_$P(DGM,U,11,15),L=1 F Z=5:1:14 S:'$P(DGM,U,Z) DGM=$P(DGM,U,1,Z-1)_U_$P(DGM,U,Z+1,99) S:'$P(DGM,U,Z) Z=Z-1 S L=L+1 Q:L=10
 S Y=$S(T1:"C",1:"N")_"501"_DGHEAD,X=$P(DGTD,".")_"       ",Y=Y_$E(X,4,5)_$E(X,6,7)_$E(X,2,3)_$E($P(DGTD,".",2)_"0000",1,4)
 S Z=DGCDR D CDR
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(DGM,U,2),.DGARRY)
 S $P(DGM,U,2)=$G(DGARRY(7))
 S L=2,X=DGM,Z=2 D ENTER0
 ; convert pass, leave days >999 to 999
 S L=3 F Z=3,4 S:$P(X,U,Z)>999 $P(X,U,Z)=999 D ENTER0
 S L=1,X=DG57,Z=4 D ENTER S:I=1 DG502=Y
 F Z=5:1:9 S DGPTTMP=$$ICDDX^ICDCODE($P(DGM,U,Z),$G(DGPTMVDT)) D
 . S F=$S(+DGPTTMP>0&($P(DGPTTMP,U,10)):$P(DGPTTMP,U,2),1:"   ."),F=$P(F,".",1)_$E($P(F,".",2)_"    ",1,3),F=F_$E("      ",1,7-$L(F)),Y=Y_F
 S Y=Y_"         "
 S X=""
 I 'T1 S Z=$S(I=1:+$O(^DGPT(J,535,"ADC",0)),1:+$O(^DGPT(J,535,"AM",DGTD-.0000001))) I $D(^DGPT(J,535,+$O(^(Z,0)),0)) S X=^(0)
 I T1 S Z=+$O(^DGPT(J,535,"AM",DGTD-.0000001)) S:'Z Z=+$O(^DGPT(J,535,"ADC",0)) I $D(^DGPT(J,535,+$O(^(Z,0)),0)) S X=^(0)
 S Z=$P(X,U,16) D CDR
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(X,U,2),.DGARRY)
 S $P(X,U,2)=$G(DGARRY(7))
 S L=2,Z=2 D ENTER0
 ; bed occupant
 I T1 S Y=Y_$S(I=1:$E($P(DG70,U,14)_" "),$P(+DGTD,".")=$P(T2,"."):5,1:1)
 I 'T1 S Y=Y_$S(I=1:$E($P(DG70,U,14)_" "),1:" ")
 ;-- additional ptf questions
 S DGAUX=$S($D(^DGPT(J,"M",I,300)):^(300),1:"")
 D ADDQUES
 ;-- sc related care
 S Y=Y_$E(DGSC_" ")
 ;-- ao related care
 S Y=Y_$E(DGAO_" ")
 ;-- ir related care
 S Y=Y_$E(DGIR_" ")
 ;-- ec related care
 S Y=Y_$E(DGEC_" ")
 ;-- mst related care
 S Y=Y_$E(DGMST_" ")
 ;-- Head/Neck CA related care
 S Y=Y_$E(DGHNC_" ")
 K DGAUX,DGDRUG,DGSC,DGAO,DGIR,DGEC,DGMST,DGHNC
 D FILL^DGPTR2,SAVE
 Q
535 ; -- do 535's
 D 535^DGPTR3
 ;
PROC ; -- setup 601 transactions
 K ^UTILITY($J,"PROC") S I=0
601 S I=$O(^DGPT(J,"P",I)) G 701:I'>0 S (X,DGPROC)=^(I,0) G 601:'DGPROC
 G 601:DGPROC<T1!(DGPROC>T2) S DGPROCD=+^DGPT(J,"P",I,0),^UTILITY($J,"PROC",DGPROCD)=$S($D(^UTILITY($J,"PROC",DGPROCD)):^(DGPROCD),1:0)+1
 I ^UTILITY($J,"PROC",DGPROCD)>1 W !,"More than one procedure record on same date/time" S DGERR=1 Q
 S Y=$S('T1:"N",1:"C")_"60"_^(DGPROCD)_DGHEAD_$E(DGPROCD,4,7)_$E(DGPROCD,2,3)_$E($P(+X,".",2)_"0000",1,4)
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(X,U,2),.DGARRY)
 S $P(X,U,2)=$G(DGARRY(7))
 S L=2,Z=2 D ENTER0
 S L=1,Z=3 S $P(X,U,Z)="" D ENTER ;null dialysis type. DG729
 S L=3,Z=4 D ENTER0
 S L=1 F K=5:1:9 S:'$P(DGPROC,U,K) DGPROC=$P(DGPROC,U,1,K-1)_U_$P(DGPROC,U,K+1,99),K=K-1 S L=L+1 Q:L=5
 F K=5:1:9 S DGPTTMP=$$ICDOP^ICDCODE(+$P(DGPROC,U,K),$$GETDATE^ICDGTDRG(J)) D
 . S Y=Y_$S(+DGPTTMP>0&($P(DGPTTMP,U,10)):$J($P($P(DGPTTMP,U,2),".",1),2)_$E($P($P(DGPTTMP,U,2),".",2)_"   ",1,3),1:"     ")_"  "
 D FILL,SAVE G 601
 Q
 ;
701 ; -- setup 701 transaction
 D 701^DGPTR4 Q
 ;
ENTER S Y=Y_$J($P(X,U,Z),L)
 Q
 ;
ENTER0 S Y=Y_$S($P(X,U,Z)]"":$E("00000",$L($P(X,U,Z))+1,L)_$P(X,U,Z),1:$J($P(X,U,Z),L))
 Q
 ;
SAVE D START^DGPTR1 S:'DGERR ^XMB(3.9,DGXMZ,2,DGCNT,0)=Y,DGCNT=DGCNT+1
 I DGERR'>0 S DGACNT=DGACNT+1,^TMP("AEDIT",$J,$E(Y,1,4),DGACNT)=Y
Q Q
 ;
FILL F K=$L(Y):1:124 S Y=Y_" "
 Q
 ;
CDR S Y=Y_$E($P(Z,".")_"0000",1,4)_$E($P(Z,".",2)_"00",1,2)
 Q
ADDQUES ;-- additional PTF questions load records for trans 501/701
 N DGADDQ
 F DGADDQ=2,3,4 D  ;null results if discharge>inactive date. DG/729
 . I +$P($G(^DIC(45.88,DGADDQ,0)),U,3) S $P(DGAUX,U,DGADDQ)=$S((+$G(^DGPT(J,70))<$P(^DIC(45.88,DGADDQ,0),U,3)):$P(DGAUX,U,DGADDQ),1:"")
 S DGDRUG=$S($D(^DIC(45.61,+$P(DGAUX,U,4),0)):$P(^(0),U,2),1:"    ")
 S Y=Y_$E($P(DGAUX,U,3)_" ")_$E($P(DGAUX,U,2)_" ")_$J($P(DGDRUG,U),4)
 S Y=Y_$E($P(DGAUX,U,5)_" ")
 S DGT=0,X=$P(DGAUX,U,6) I X]"" S DGT=1,Z=1,L=2 D ENTER0
 I 'DGT S Y=Y_"  "
 S DGT=0,X=$P(DGAUX,U,7) I X]"" S DGT=1,Z=1,L=2 D ENTER0
 I 'DGT S Y=Y_"  "
 Q
