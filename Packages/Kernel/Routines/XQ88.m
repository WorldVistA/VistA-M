XQ88 ;SF/GFT,RWF,AMF,JLI,LUKE - Build menu trees ;04/18/2002  11:08
 ;;8.0;KERNEL;**156**;Jul 10, 1995
 ;Taken from XQ8 and XQ81 to make a stripped down menu rebuild
 ;
TIME ;See if there are prohibited times for this option
 S %XQI=$P(^DIC(19,Y,0),U,9) I $L(%XQI)>2 S XQP(L)=%XQI_"MO-FR"
 I $D(^DIC(19,Y,3.91)) S %XQI=0 F  S %XQI=$O(^DIC(19,Y,3.91,%XQI)) Q:%XQI'>0  S XQP(L)=$S($D(XQP(L)):XQP(L)_";",1:"")_$P(^(%XQI,0),U,1)_$P(^(0),U,2)
 K %XQI I '$D(XQP(L)),$L($P(Y(0),U,9)) S XQP(L)=$P(Y(0),U,9)
 Q
 ;
UP S X=$$UP^XLFSTR(X) ;F Z=1:1 Q:X?.NUP  S W=$A(X,Z) I W<123,W>96 S X=$E(X,1,Z-1)_$C(W-32)_$E(X,Z+1,255)
 Q
 ;
PM2 ;Enter here to rebuild a single menu Called by RD3+10
 K ^TMP("XQO",$J,XQDIC) S ^XUTL("XQO",XQDIC,"^BUILD")=$P($H,",",2)
 ;
 I XQDIC'="PXU" S Y=+$P(XQDIC,"P",2) Q:Y'>0  Q:'$D(^DIC(19,Y,0))
 I '$D(XQXUF) K ^TMP("XQO",$J,"PXU") S XQSAV=XQDIC S XQDIC="PXU",Y=$O(^DIC(19,"B","XUCOMMAND",0)) S:Y>0 %="",(L,X(0))=0,XQD=Y D:Y>0 TREE1,PMOK S XQDIC=XQSAV,XQXUF=1,^TMP("XQO",$J,"PXU",0)=XQDT
 I XQDIC=9!(XQDIC="P9")
 ;
 S Y=$P(XQDIC,"P",2) G:Y'>0!'$D(^DIC(19,+Y,0)) PMOKA I Y>0,$D(^DIC(19,Y,0)),$P(^(0),U,4)="M" D PMOK S %="",(L,X(0))=0,XQD=Y D TREE1
 S:$D(^DIC(19,$E(XQDIC,2,99),0)) ^(99.1)=XQDT S ^TMP("XQO",$J,XQDIC,0)=XQDT
 S Y=+$P(XQDIC,"P",2)
 I Y>0 S (XQD,%)=^DIC(19,Y,0),L=1,XQP(L)="" D TIME S ^TMP("XQO",$J,XQDIC,U,Y)=U_$P(%,U,1,2)_U_$S(($P(%,U,3)]""):1,1:"")_U_$P(%,U,4)_UU_$P(%,U,6,8)_U_XQP(L)_U_$P(%,U,10,99)
 I Y>0,'$D(^DIC(19,Y,"U")) S XQFL=0 S:$D(X)#2 XQSAVE=X,XQFL=1 S X=$E($P(^DIC(19,+Y,0),U,2),1,30) D UP S ^("U")=X S:XQFL X=XQSAVE
 I Y>0 S ^TMP("XQO",$J,XQDIC,^DIC(19,Y,"U")_U)=Y_"^0"
PMOKA K ^XUTL("XQO",XQDIC,"^BUILD") K ZTSK
PMOK K %,XQA,XQD,XQE,XQF,XQFL,XQP,XQR,XQSAVE
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
TREE ;
 S X(L)=$O(^DIC(19,XQD,10,X(L))) Q:X(L)'>0  S Y=^(X(L),0),%=$P(Y,U,2),Y=+Y G:$D(XQR(Y))!'$D(^DIC(19,Y,0)) TREE S XQR(Y)=""
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
 ;
 ;
SEC S XQL="P"_XQBLD Q:$D(^TMP("XQO",$J,XQL))  D RD3 Q
 S XQL="P" F XQN=0:0 S XQL=$O(^TMP("XQO",$J,XQL)) Q:$E(XQL)'="P"  I $D(^TMP("XQO",$J,XQL,"^",XQBLD)) Q
 D:$E(XQL)'="P" RD3
 Q
 ;
RD3 ;Called by SEC and SEC+2
 S XQDIC="P"_XQBLD
 D PM2
 Q
 ;
SET G:'$D(^VA(200,XQI,201)) SET1 S XQK=+^(201) Q:'$L(XQK)
 S XQR="" S:$D(^VA(200,XQI,1.1)) XQR=$P(^(1.1),".",1) S XQP=1_U_XQR
 I $D(^TMP($J,XQK)) S XQP=^TMP($J,XQK) S XQP=XQP+1_U_$S(XQR>$P(XQP,U,2):XQR,1:$P(XQP,U,2))
 I $D(^DIC(19,XQK,0)),$P(^(0),U,4)="M" S ^TMP($J,XQK)=XQP
SET1 F XQN=0:0 S XQN=$O(^VA(200,XQI,203,XQN)) Q:XQN'>0  S XQL=+^(XQN,0) I $D(^DIC(19,XQL,0)) S ^TMP($J,"SEC",XQL)=""
 Q
 ;
 ;
EN ;Entry point
 S U="^",UU="^^"
 N XQDIC,XQDT,XQI,XQH,XQSAV,XQSEC
 S:'$D(XQDT) XQDT=$H
 K ZTREQ
 S ^TMP("XQO",$J,"P0")="",XQSEC=1
 S XQI="" F XQK=0:0 S XQI=$O(^TMP("XQO",$J,XQI)) Q:XQI'=+XQI!(XQI="")  I $D(^TMP("XQO",$J,XQI,0))#2 S $P(^(0),U,2)=""
 S XQI="U" F XQK=0:0 S XQI=$O(^TMP("XQO",$J,XQI)) Q:"U"'[$E(XQI)!(XQI="")  I $D(^TMP("XQO",$J,XQI,0))#2 S $P(^(0),U,2)=""
 S XQI="P" F XQK=0:0 S XQI=$O(^TMP("XQO",$J,XQI)) Q:"P"'[$E(XQI)!(XQI="")  I $D(^TMP("XQO",$J,XQI,0))#2,$L(^(0)) Q
 S XQI="P" F XQK=0:0 S XQI=$O(^TMP("XQO",$J,XQI)) Q:"P"'[$E(XQI)!(XQI="")  I "P"[$E(XQI),XQI'="P0" K ^TMP("XQO",$J,XQI)
 ;
 ;Find the various trees and put them into ^TMP($J), and count them
 S:'$D(XQH) XQH=$H K ^TMP($J) S XQI=.5 F XQK=0:0 S XQI=$O(^VA(200,XQI)) Q:XQI'=+XQI  I $D(^VA(200,XQI,0)),$L($P(^VA(200,XQI,0),U,3)) D SET
 ;
 S (XQNT,%)=0 F  S %=$O(^TMP($J,%)) Q:%=""  S XQNT=XQNT+1
 S %=0 F  S %=$O(^TMP($J,"SEC",%)) Q:%=""  S XQNT=XQNT+1
 ;
 S X="" F XQBLD=0:0 S XQBLD=$O(^TMP($J,XQBLD)) Q:XQBLD'>0!(X=U)  I $D(^DIC(19,XQBLD,0)) S XQJ=^DIC(19,XQBLD,0) D RD3
 S XQSEC=0
 S X="" F XQBLD=0:0 S XQBLD=$O(^TMP($J,"SEC",XQBLD)) Q:XQBLD'>0  D SEC
 K ^TMP("XQO",$J,"P0") S XQK="P" F XQBLD=0:0 S XQK=$O(^TMP("XQO",$J,XQK)) Q:XQK'["P"  S ^(XQK,0)=XQH
 ;
BLDEND ;We are all done, let's clean up and quit.
 ;
 K %,%H,%TG,D,DIC,DIR,I,J,K,L,V,X,Y,Z,UU
 K XQBLD,XQDT,XQH,XQI,XQJ,XQK,XQL,XQN,XQNT,XQP,XQR,XQSAV,XQSEC,XQXUF
 ;
 D MERGE
 ;
 K ^TMP($J),^TMP("XQO",$J)
 K D,I,W,X,XQK,XQREALT,XQXUF,Y,Z
 Q
 ;
MERGE ;Merge ^TMP("XQO",$J) into ^DIC(19,"AXQ")
 N X S X="P"
 F  S X=$O(^TMP("XQO",$J,X)) Q:X=""  D
 .L +^DIC(19,"AXQ",X):5
 .K ^DIC(19,"AXQ",X)
 .M ^DIC(19,"AXQ",X)=^TMP("XQO",$J,X)
 .L -^DIC(19,"AXQ",X)
 .K ^TMP("XQO",$J,X)
 .Q
 Q
 ;
ERR ;Come here on error
 N XQERROR
 S XQERROR=$$EC^%ZOSV
 D ^%ZTER
 D EXIT^XPDID()
 G UNWIND^%ZTER
 Q
