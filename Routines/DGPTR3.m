DGPTR3 ;ALB/JDS/MJK - ALB/BOK  PTF TRANSMISSION ; 01 DEC 87 @0800
 ;;5.3;Registration;**183,729**;Aug 13, 1993;Build 59
 ;
535 ; -- setup 535 transactions
 F I=0:0 S I=$O(^DGPT(J,535,I)) Q:'I  I $D(^(I,0)) S DGM=^(0),DGTD=+$P(DGM,U,10) I $P(DGM,U,17)'="n",'$P(DGM,U,7),'$D(^DGPT(J,"M","AM",DGTD)),DGTD'<T1,DGTD'>T2 D PHY
 Q
 ;
PHY ; -- set up physcial mvt
 S Y=$S(T1:"C",1:"N")_"535"_DGHEAD,X=$P(DGTD,".")_"       ",Y=Y_$E(X,4,5)_$E(X,6,7)_$E(X,2,3)_$E($P(DGTD,".",2)_"0000",1,4)
 ; physical cdr
 S Z=$P(DGM,U,16) D CDR^DGPTR2
 ; physical specialty
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(DGM,U,2),.DGARRY)
 S $P(DGM,U,2)=$G(DGARRY(7))
 S L=2,X=DGM,Z=2 D ENTER0
 ; find corresponding PTF mvt
 S X="",Z=+$O(^DGPT(J,"M","AM",DGTD-.0000001)),Z=$S(Z:+$O(^(Z,0)),1:1) I $D(^DGPT(J,"M",Z,0)) S X=^(0) ; use d/c mvt if 'Z
 ; specialty cdr
 S Z=$P(X,U,16) D CDR^DGPTR2
 ; specialty
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(X,U,2),.DGARRY)
 S $P(X,U,2)=$G(DGARRY(7))
 S L=2,Z=2 D ENTER0
 ; 
 ; convert pass, leave days >999 to 999
 S X=DGM,L=3 F Z=3,4 S:$P(X,U,Z)>999 $P(X,U,Z)=999 D ENTER0
 D FILL^DGPTR2,SAVE
 K DGM,X,Z,L Q
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
