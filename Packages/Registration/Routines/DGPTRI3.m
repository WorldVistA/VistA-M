DGPTRI3 ;ALB/JDS/MJK - ALB/BOK  PTF TRANSMISSION ;3/12/11 7:21am
 ;;5.3;Registration;**850**;Aug 13, 1993;Build 171
 ;
 ; CSI^ICDEX      ICR 5747
 ;
535 ; -- setup 535 transactions
 F I=0:0 S I=$O(^DGPT(J,535,I)) Q:'I  I $D(^(I,0)) S DGM=^(0),DGTD=+$P(DGM,U,10) I $P(DGM,U,17)'="n",'$P(DGM,U,7),'$D(^DGPT(J,"M","AM",DGTD)),DGTD'<T1,DGTD'>T2 D PHY
 Q
 ;
PHY ; -- set up physical mvt
 S Y=$S(T1:"C",1:"N")_"535"_DGHEAD,X=$P(DGTD,".")_"       ",Y=Y_$E(X,4,5)_$E(X,6,7)_$E(X,2,3)_$E($P(DGTD,".",2)_"0000",1,4)
 ; physical cdr
 S Z=$P(DGM,U,16) D CDR^DGPTRI2
 ; physical specialty
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(DGM,U,2),.DGARRY)
 S $P(DGM,U,2)=$G(DGARRY(7))
 S L=2,X=DGM,Z=2 D ENTER0
 ; find corresponding PTF mvt
 S X="",Z=+$O(^DGPT(J,"M","AM",DGTD-.0000001)),Z=$S(Z:+$O(^(Z,0)),1:1) I $D(^DGPT(J,"M",Z,0)) S X=^(0) ; use d/c mvt if 'Z
 ; specialty cdr
 S Z=$P(X,U,16) D CDR^DGPTRI2
 ; specialty
 ;replace specialty pointer (ien) with ptf code (alpha-numeric)
 N DGARRX,DGARRY ;DG729
 S DGARRX=$$TSDATA^DGACT(42.4,$P(X,U,2),.DGARRY)
 S $P(X,U,2)=$G(DGARRY(7))
 S L=2,Z=2 D ENTER0
 ; 
 ; convert pass, leave days >999 to 999
 S X=DGM,L=3 F Z=3,4 S:$P(X,U,Z)>999 $P(X,U,Z)=999 D ENTER0
 D FILL^DGPTRI2,SAVE
 K DGM,X,Z,L Q
 ;
ENTER S Y=Y_$J($P(X,U,Z),L)
 Q
 ;
ENTER0 S Y=Y_$S($P(X,U,Z)]"":$E("00000",$L($P(X,U,Z))+1,L)_$P(X,U,Z),1:$J($P(X,U,Z),L))
 Q
 ;
SAVE D START^DGPTRI1 S:'DGERR ^XMB(3.9,DGXMZ,2,DGCNT,0)=Y,DGCNT=DGCNT+1
 I DGERR'>0 S DGACNT=DGACNT+1,^TMP("AEDIT",$J,$E(Y,1,4),DGACNT)=Y
Q Q
 ;
VERCHK(REC) ; -- check version for all diagnosis and procedure codes
 N I,J,X,Y,DGPTF,FLD,VER,%,ICD,DGICD,M,CODSYSD,CODSYSP,ERR1,ERR2,ERR3,ERR4,ERR5,ERR6
 N EFFDATE,IMPDATE,DGPTDAT
 Q:+$G(REC)<1
 ;
 D EFFDATE^DGPTIC10(REC,"701")
 S CODSYSD=+$$CS^ICDEX(80,"I",EFFDATE)
 S CODSYSP=+$$CS^ICDEX(80.1,"I",EFFDATE)
 ;
 S %=$S($D(^DGPT(REC,70)):^(70),1:"") I %'="" D
 . S %=U_$P(%,U,10)_U_$P(%,U,16,24)_U_$G(^DGPT(REC,71))
 .F ICD=1:1:15 S DGICD=$P(%,U,ICD) I DGICD'="" D  Q:$G(ERR1)=1
 .. S X=$$CSI^ICDEX(80,DGICD)
 .. I +X'=CODSYSD S ERR1=CODSYSD ;W !,%,!,ICD,!,X
 .. Q
 . Q
 ;
 S M=0 F I=0:0 S I=$O(^DGPT(REC,"M",I)) Q:'I  D
 . S %=$G(^DGPT(REC,"M",I,0)) S %=U_$P(%,U,5,9)_U_$P(%,U,11,15)
 . F ICD=1:1:15 S DGICD=$P(%,U,ICD) I DGICD'="" D  Q:$G(ERR2)=1
 .. S X=$$CSI^ICDEX(80,DGICD)
 .. I +X'=CODSYSD S ERR2=CODSYSD
 .. Q
 . Q
 ;
 S I=0 F I=0:0 S I=$O(^DGPT(REC,"P",I)) Q:'I  D
 . S %=$G(^DGPT(REC,"P",I,0)) S %=U_$P(%,U,5,9)
 . F ICD=1:1:6 S DGICD=$P(%,U,ICD) I DGICD'="" D  Q:$G(ERR3)=1
 .. S X=$$CSI^ICDEX(80.1,DGICD)
 .. I +X'=CODSYSP S ERR3=CODSYSP ;W !,%,!,ICD,!,X,!,CODSYSP
 .. Q
 . Q
 ;
 S I=0 F I=0:0 S I=$O(^DGPT(REC,"S",I)) Q:'I  D
 . S %=$G(^DGPT(REC,"S",I,0)) S %=U_$P(%,U,8,12)
 . F ICD=1:1:6 S DGICD=$P(%,U,ICD) I DGICD'="" D  Q:$G(ERR4)=1
 .. S X=$$CSI^ICDEX(80.1,DGICD)
 .. I +X'=CODSYSP S ERR4=CODSYSP
 .. Q
 . Q
 ;
 S %=$S($D(^DGPT(REC,"401P")):^("401P"),1:"") I %'="" D
 . S %=U_$P(%,U,1,5)
 .F ICD=1:1:6 S DGICD=$P(%,U,ICD) I DGICD'="" D  Q:$G(ERR5)=1
 .. S X=$$CSI^ICDEX(80,DGICD)
 .. I +X'=CODSYSD S ERR5=CODSYSD ;W !,%,!,ICD,!,X
 .. Q
 . Q
 ;
 D CPTDATA
 ;
 I $G(ERR4) S DGERR=$G(DGERR)+1 W !,"401         ",$S(ERR4=2:"ICD-9",1:"ICD-10")," Code Expected, ",$S(ERR4=2:"ICD-10",1:"ICD-9")," Code found."
 I $G(ERR2) S DGERR=$G(DGERR)+1 W !,"501         ",$S(ERR2=1:"ICD-9",1:"ICD-10")," Code Expected, ",$S(ERR2=1:"ICD-10",1:"ICD-9")," Code found."
 I $G(ERR3) S DGERR=$G(DGERR)+1 W !,"601         ",$S(ERR3=2:"ICD-9",1:"ICD-10")," Code Expected, ",$S(ERR3=2:"ICD-10",1:"ICD-9")," Code found."
 I $G(ERR5) S DGERR=$G(DGERR)+1 W !,"601         ",$S(ERR5=1:"ICD-9",1:"ICD-10")," Code Expected, ",$S(ERR5=1:"ICD-10",1:"ICD-9")," Code found."
 I $G(ERR1) S DGERR=$G(DGERR)+1 W !,"701         ",$S(ERR1=1:"ICD-9",1:"ICD-10")," Code Expected, ",$S(ERR1=1:"ICD-10",1:"ICD-9")," Code found."
 I $G(ERR6) S DGERR=$G(DGERR)+1 W !,"801         ",$S(ERR6=1:"ICD-9",1:"ICD-10")," Code Expected, ",$S(ERR6=1:"ICD-10",1:"ICD-9")," Code found."
 ;
 Q
 ;
CPTDATA ; -- get 801 movement Diagnosis Data in DG801(i,j,"DATA")
 ; 801 movement uses CPT Record date instead of 701 type dates
 N H,I,I2,N,IEN,K,K1,L,DGCPTDT,DGCPTSYS
 S (H,I,N)=0
 F I2=1:1 S H=$O(^DGPT(PTF,"C","B",H)) Q:H'>0  D
 . F  S I=$O(^DGPT(PTF,"C","B",H,I)) Q:I'>0  D
 .. S DG801(I2)=^DGPT(PTF,"C",I,0),DGCPTDT=$P(DG801(I2),U,1),DGCPTSYS=+$$CS^ICDEX(80,"I",DGCPTDT)
 .. S (K,K1)=0,F=1 ;D
 .. F  S K=$O(^DGCPT(46,"C",PTF,K)) Q:K'>0  I +DG801(I2)=+$G(^DGCPT(46,K,1)),'$G(^DGCPT(46,K,9)) D
 ... S K1=K1+1
 ... S DG801(I2,K1,"DATA")=$P(^DGCPT(46,K,0),U,4,7)_U_$P(^DGCPT(46,K,0),U,15,18)
 ... F L=1:1:8 S DGICD=$P(DG801(I2,K1,"DATA"),U,L) I DGICD D  Q:$G(ERR6)
 .... S X=$$CSI^ICDEX(80,DGICD)
 .... I +X'=DGCPTSYS S ERR6=DGCPTSYS
 .... Q
 ... S F=0
 ... Q
 ..I F K DG801(I2) S I2=I2-1
 .. Q
 . Q
 K F,I,K,K1,N
 Q
