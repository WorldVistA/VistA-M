XTFCE ;SF-ISC.SEA/JLI - SELECTIVE FLOW CHARTS BY ENTRY POINT ;12/7/95  14:49
 ;;7.3;TOOLKIT;**8**;Apr 25, 1995
EN ;
 W !,"Select ROUTINE or LABEL^ROUTINE: " R X:DTIME G:'$T!(X="")!(X=U) EXIT S XTX=X,X=$S(X[U:$P(X,U,2),1:X) X ^%ZOSF("TEST") I '$T W $C(7),"  ??" G XTFCE
 K ^TMP($J) S XTROU=X I XTX[U S XTLINE=$P(XTX,U,1) I XTLINE]"" S XTLEV=1 D NODE G XTFCE
 ;
ROU ; Display Entry Points or identified lines of routine
 S XTLEV=0 D GETROU S XTM=0 F I=1:1 Q:'$D(^TMP($J,XTLEV,"T",I,0))  S J=^(0) Q:J=""  I $E(J,1)'=" " S XTM=XTM+1,^TMP($J,XTLEV,"X",XTM)=$P(J," ",1)
 ;
ROU1 G:'$D(^TMP($J,0)) XTFCE W !,"The following labels are present in routine ",XTROU," and can be",!,"selected for expansion.",! ;, or enter * for the entire routine.",!
 F J=1:1:15 Q:J>XTM  W !,$J(J,2),".  ",^TMP($J,XTLEV,"X",J) F K=J+15:15:60 Q:K>XTM  W ?(15*(K-1\15)),$J(K,2),".  ",^(K)
 W !!,"Select LABEL by number (1 to ",XTM,"): " R X:DTIME G:'$T!(X="")!(X[U) EXIT I X<1!(X>XTM) W $C(7),"  ??" G ROU1
 S XTLINE=^TMP($J,XTLEV,"X",+X),XTLEV=1 D NODE G ROU1
 ;
ALL ;
 Q
NODE ;
 K XTEXT,XTEXTB,^TMP($J,XTLEV)
 S XTLINE=$P(XTLINE,"("),XTROU(XTLEV)=XTROU,XTLINE(XTLEV)=XTLINE,X=XTROU D GETROU
 S XTIL=0 F I=1:1 Q:'$D(^TMP($J,XTLEV,"T",I,0))  S J=^(0) I $P($P(J," ",1),"(")=XTLINE S XTIL=I Q
 I XTIL=0 W $C(7),"  ??  line ",XTLINE," not found in routine ",XTROU S XTLEV=XTLEV-1 Q
 S XTIFLG=0,XTTFLG=0,XTCOND=0,XTENTR=0 F I=XTIL:1 Q:XTTFLG!'$D(^TMP($J,XTLEV,"T",I,0))  S X=^(0) D LINE^XTFC0
 D ^XTFCE1
 S XT="",XTLEV=XTLEV-1
 Q
GETROU ; Get routine into ^TMP($J,XTLEV,"T",n)
 S X=$P(X,"("),DIF="^TMP($J,XTLEV,""T"",",XCNP=0 X ^%ZOSF("LOAD") K DIF,XCNP
 Q
 ;
EXIT ;
 K XT,XTCOND,XTENTR,XTIFLG,XTIJ,XTIL,XTL,XTL1,XTL2,XTLEV,XTLINE,XTM,XTNAM,XTPCOND,XTREF,XTROU,XTSLINE,XTTFLG,XTX,XTX1,XTX2,XTX2B,XTZA,XTZX,XTZX1,I,J,JK,JL,K,N,X,Y,Z
 Q
