YSPDXR ;SLC/DKG,SLC/RWF-ICD9 DIAGNOSIS REPORT ; 4/24/89  11:28 ; 4/22/09 10:50am
 ;;5.01;MENTAL HEALTH;**37,96**;Dec 30, 1994;Build 46
 ;Reference to %ZIS APIs supported by DBIA #10089
 ;Reference to %ZTLOAD APIs supported by DBIA #10063
 ;Reference to ^ICD9( supported by DBIA #5388
 ;Reference to XLFDT APIs supported by DBIA #10103
 ;Reference to ICDCODE APIs supported by DBIA #3990
 ;Reference to ^VA(200, supported by DBIA #10060
 ;Reference to ^DIC(3.1, supported by DBIA #1234
 ;  Called by routine YSDXR
 I $D(^MR(YSDFN,"PHDX",1)) D:$Y+YSSL+1>IOSL CK Q:YSLFT  W !!,"ICD9 DIAGNOSES:"
PRT ; Called by routine YSPDR1
 S T=$O(^MR(YSDFN,"PHDX","B",T)) G END:'T S Y1=$O(^MR(YSDFN,"PHDX","B",T,0)) G END:'Y1
 S D2=^MR(YSDFN,"PHDX",Y1,0),T1=0 G PRT:D2<1 S Y2=^ICD9(+D2,0)
 I $D(A1),A1?1"Y".E G PRT:$P(D2,U,2)="I"
 I $Y+YSSL+2>IOSL D CK Q:YSLFT
 W !!,$P(Y2,U),?8
 N YSDXZZ S YSXDZZ=$$ICDD^ICDCODE($P(Y2,U),"YSDXZZ") S Y2=YSXDZZ(1) ;asf 4/22/09
 F I=3:1:8 IF $L($P(Y2," ",I))>70 Q
 W $P(Y2," ",1,I-1) W:$L($P(Y2," ",I,99)) !?9,$P(Y2," ",I,99)
 S C=$P(^MR(YSDFN,"PHDX",Y1,0),U,2),C=$S(C="A":"A C T I V E",C="I":"** INACTIVE",1:"") W "  ",C
PT1 ;
 I $Y+YSSL+2>IOSL D CK Q:YSLFT
 S T1=$O(^MR(YSDFN,"PHDX",Y1,1,T1)) G PRT:'T1 S S2=^(T1,0)
 W !?8 S X=+S2,Z=$P(S2,U,2) D DAT,SET
 S X=$P(S2,U,3) IF X>0,$D(^VA(200,X,0)) W "  ",$P(^VA(200,X,0),U) S X=$P(^(0),U,9) IF X>0,$D(^DIC(3.1,X,0)) W ", ",^(0)
 S X=$P(S2,U,4) IF $L(X) F I=4:1:10 IF $L($P(X," ",I))>50 Q
 IF $L(X) W !?20,"COMMENT: ",$P(X," ",1,I) W:$L($P(X," ",I+1,99)) !?21,$P(X," ",I+1,99)
 G PT1
END ;
 Q:$D(YSNOFORM)  D ENFT^YSFORM:YST D:'YSPP WAIT^YSUTL:'YST Q:YSPP  D ^%ZISC,KILL^%ZTLOAD Q
 ;
DAT ;
 W "  ",$$FMTE^XLFDT(X,"5ZD") Q
SET ;
 S Y=";"_$P(^DD(90.05,1,0),U,3) F I=1:1:10 IF $P(Y,";",I)[(Z_":") Q
 W:I<10 "  ",$P($P(Y,";",I),":",2),":" Q
CK ;
 I $D(YSNOFORM) D:'YST WAIT^YSUTL Q:YSLFT  W:YST @IOF Q
 S:YSSL YSCON=1 D WAIT^YSUTL:'YST,ENFT^YSFORM:YST Q:YSLFT  D:YST ENHD^YSFORM Q
