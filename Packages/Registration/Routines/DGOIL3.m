DGOIL3 ;ALB/AAS - CALC LOS BY TRANSFER (CONT), GET ASIH MOVEMENTS ; 23-OCT-90
 ;;5.3;Registration;;Aug 13, 1993
 ;
SAVE ;variables needing saving
 S DGPMIFN(1)=DGPMIFN,DGPMIFN1(1)=DGPMIFN1,A(1)=A,A1(1)=A1,D(1)=D,I(1)=I,B("SAVE")=B
 K DGS
 ;
SET ;set up new variables needed
 S I=1,DGT=DGT+1,X(DGT)="0^0^0^0^0^0^0"
 S DGPMIFN=$S('Z:"",'$D(^DGPM(+Z,0)):"",1:$P(^(0),"^",15)) G RESTORE:'DGPMIFN G RESTORE:'$D(^DGPM(DGPMIFN,0)) S B=^DGPM(DGPMIFN,0) S A=$S($L(+B)>7:+B,1:+B_"."),A=$E(A_"000000",1,14)_$P(B,"^",22)
 D MAX^DGOIL2 ;set d equal to discharge
 ;
CALC ;find ASIH movements
 D ADM^DGOIL2
 ;
RESTORE ;set variables back to original
 S A=D+.0000002 ;start with movement after discharge date
 S DGPMIFN=DGPMIFN(1),DGPMIFN1=DGPMIFN1(1),A1=A1(1),D=D(1),I=I(1),B=B("SAVE")
 ;
END K DGPMIFN(1),DGPMIFN1(1),A(1),A1(1),D(1),I(1),B("SAVE"),DGDONE
 Q
