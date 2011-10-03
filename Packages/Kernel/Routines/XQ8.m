XQ8 ;SEA/AMF,LUKE - Build menu trees ;06/06/2002  10:41
 ;;8.0;KERNEL;**81,89,116,157**;Jul 10, 1995
 ;
 Q  ;You can't start here.
TIME ;See if there are prohibited times for this option
 S %XQI=$P(^DIC(19,Y,0),U,9) I $L(%XQI)>2 S XQP(L)=%XQI_"MO-FR"
 I $D(^DIC(19,Y,3.91)) S %XQI=0 F  S %XQI=$O(^DIC(19,Y,3.91,%XQI)) Q:%XQI'>0  S XQP(L)=$S($D(XQP(L)):XQP(L)_";",1:"")_$P(^(%XQI,0),U,1)_$P(^(0),U,2)
 K %XQI I '$D(XQP(L)),$L($P(Y(0),U,9)) S XQP(L)=$P(Y(0),U,9)
 Q
UP S X=$$UP^XLFSTR(X) ;F Z=1:1 Q:X?.NUP  S W=$A(X,Z) I W<123,W>96 S X=$E(X,1,Z-1)_$C(W-32)_$E(X,Z+1,255)
 Q
CHK ;Called from XQ81+107
 S XQRE=$D(^XUTL("XQO",XQDIC,"^BUILD")) I XQRE,($P($H,",",2)-^("^BUILD")>1800)!(^("^BUILD")>$P($H,",",2)) K ^("^BUILD") S XQRE=0
 Q
PMO ;Called from XQ71+21
 D CHK W !,$S(XQRE:"I'M REBUILDING",1:"I NEED TO REBUILD")," MENUS .... QUICK ACCESS IS TEMPORARILY DISABLED" W:$D(XQMMJ) !!,"Please proceed to '",$E(XQMMJ,2,99),"'" K XQMMJ,XQMM I XQRE K XQRE Q
 Q
 ;
PM1 ;Enter here to build a single menu called by XQ83
 S XQPM1=""
 S:XQDIC'="PXU" XQXUF=""
 ;
PM2 ;Enter here to rebuild a single menu Called by RD3+10^XQ81
 ;$D(XQFG1) causes it rebuild in real time otherwise it is queued
 D:$D(XQCON) CHK S:'$D(XQRE) XQRE=0 Q:XQRE
 K ^TMP("XQO",$J,XQDIC) S ^XUTL("XQO",XQDIC,"^BUILD")=$P($H,",",2) G:$D(XQFG1) REBLD
 ;
 S ZTIO="",ZTRTN="REBLD^XQ8",ZTDTH=$H
 S ZTSAVE("XQDIC")="",ZTSAVE("XQPM2")=""
 S ZTDESC="Rebuild The Single Menu "_XQDIC D ^%ZTLOAD Q
 ;
REBLD K XQFG1 S U="^",UU="^^" ;Taskman entry
 S:'$D(XQDATE) XQDATE=$H
 I XQDIC'="PXU" S Y=+$P(XQDIC,"P",2) Q:Y'>0  Q:'$D(^DIC(19,Y,0))
 I '$D(XQXUF) K ^TMP("XQO",$J,"PXU") S XQSAV=XQDIC S XQDIC="PXU",Y=$O(^DIC(19,"B","XUCOMMAND",0)) S:Y>0 %="",(L,X(0))=0,(XQPX,XQD)=Y D:Y>0 TREE1,PMOK S XQDIC=XQSAV,XQXUF=1,^TMP("XQO",$J,"PXU",0)=XQDATE
 S Y=$P(XQDIC,"P",2) G:Y'>0!'$D(^DIC(19,+Y,0)) PMOKA I Y>0,$D(^DIC(19,Y,0)),$P(^(0),U,4)="M" D PMOK S %="",(L,X(0))=0,XQD=Y D TREE1
 S:$D(^DIC(19,$E(XQDIC,2,99),0)) ^(99.1)=XQDATE S ^TMP("XQO",$J,XQDIC,0)=XQDATE
 S Y=+$P(XQDIC,"P",2)
 I Y>0 S (XQD,%)=^DIC(19,Y,0),L=1,XQP(L)="" D TIME S ^TMP("XQO",$J,XQDIC,U,Y)=U_$P(%,U,1,2)_U_$S(($P(%,U,3)]""):1,1:"")_U_$P(%,U,4)_UU_$P(%,U,6,8)_U_XQP(L)_U_$P(%,U,10,99)
 I Y>0,'$D(^DIC(19,Y,"U")) S XQFL=0 S:$D(X)#2 XQSAVE=X,XQFL=1 S X=$E($P(^DIC(19,+Y,0),U,2),1,30) D UP S ^("U")=X S:XQFL X=XQSAVE
 I Y>0 S ^TMP("XQO",$J,XQDIC,^DIC(19,Y,"U")_U)=Y_"^0"
PMOKA K ^XUTL("XQO",XQDIC,"^BUILD") I '$D(XQFG),$D(ZTSK) K ^%ZTSK(ZTSK)
PMOK K %,XQA,XQD,XQE,XQF,XQFL,XQP,XQR,XQRE,XQSAVE
 ;
 I $D(XQPM1) D
 .;A single menu is being built
 .D MERGET^XQ81
 .D MERGEX^XQ81
 .K ^TMP($J),^TMP("XQO",$J)
 .Q
 K XQPM1
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
TREE ;
 S X(L)=$O(^DIC(19,XQD,10,X(L))) Q:X(L)'>0  S Y=^(X(L),0),%=$P(Y,U,2),Y=+Y G:$D(XQR(Y))!'$D(^DIC(19,Y,0)) TREE S XQR(Y)="" I $D(XQFG),'$D(XQNTREE) W:'(Y#5) "."
TREE1 S Y(0)=^DIC(19,Y,0),X=$S($D(^("U")):^("U"),1:"") I X="" S X=$E($P(Y(0),U,2),1,30) D UP S ^("U")=X
 S Y(1)=X S:'$L($P(Y(0),U,5)) $P(Y(0),U,5)=0
 G:$L($P(Y(0),U,3)) TREE S:$L($P(Y(0),U,6)) XQK(L)=$P(Y(0),U,6) S XQA(L)=Y S:$L($P(Y(0),U,10)) XQE(L)=$P(Y(0),U,10)
 S:$P(Y(0),U,16) XQF(L)=$P(^DIC(19,Y,3),U) I $D(XQF(L)) K:XQF(L)="" XQF(L)
 D TIME,PMOSET S L=L+1,X(L)=0,(XQD,XQD(L))=Y D TREE
 Q:L<2  K XQR(XQD(L)) S L=L-1 K XQA(L),XQK(L),XQP(L),XQE(L),XQF(L) S XQD=XQD(L) G TREE
 ;
PMOSET ;
 S K=0,X=$E(Y(1),1,27) I $L(X) S X=X_U D:$D(^TMP("XQO",$J,XQDIC,X))!$D(^(X_"1")) PMO3 S:L&'K ^TMP("XQO",$J,XQDIC,X)=Y_"^1"
 I $D(%),$L(%) S X=%,K=0 D UP Q:'$L(X)  S X=X_U D:$D(^TMP("XQO",$J,XQDIC,X))!$D(^(X_"1")) PMO3 S:L&'K ^TMP("XQO",$J,XQDIC,X)=Y_"^0"
 S (XQA,XQK,XQP,XQE,XQF)="" F D="XQA","XQK","XQP","XQE","XQF" F I=1:1:L I $D(@(D_"(I)")) S @D=@D_@(D_"(I)")_","
 I '$D(^TMP("XQO",$J,XQDIC,"^",Y)) S ^(Y)=U_$P(Y(0),U,1,2)_U_$S(($P(Y(0),U,3)]""):1,1:"")_U_$P(Y(0),U,4)_U_XQA_U_XQK_U_$P(Y(0),U,7,8)_U_XQP_U_XQE_U_$P(Y(0),U,11,15)_U_XQF_U_$P(Y(0),U,17,99) Q
 S %=$S('$D(^TMP("XQO",$J,XQDIC,"^",Y,0)):1,1:^(0)+1),^(0)=%,^(0,%)=XQA_U_XQK_U_XQP_U_XQE_U_XQF
 Q
PMO3 ;
 S D=X,K=$S($D(^TMP("XQO",$J,XQDIC,X)):(Y=+^(X)),1:0) F  S V=$O(^TMP("XQO",$J,XQDIC,D)) Q:K!($P(V,U,1)'=$P(X,U,1))  S D=V S:Y=+^(V) K=1
 I 'K S I=$P(D,U,2) S:'$L(I) I=0 I I=0 S ^(X_"1")=^TMP("XQO",$J,XQDIC,X) K ^(X) S I=1
 I 'K S X=X_(I+1)
 Q
 ;BUILD moved to XQ81
 Q
