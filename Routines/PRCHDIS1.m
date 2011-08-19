PRCHDIS1 ;ID/RSD-X-REF OF DISCOUNT FIELD IN FILE 443.6 ;5/24/94  10:00 AM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
DIS Q:X="Q"  K ^TMP($J,"PRCHD"),PRCHD("LI") S PRCHD=0,PRCHD("AC")=0
 F  S PRCHD=$O(^PRC(443.6,D0,3,PRCHD)) Q:'PRCHD  S K=$P(^(PRCHD,0),U,1) Q:K="Q"  S:K[":" K=$P(K,":",1)_":1:"_$P(K,":",2) S PRCHD("DS")="F J="_K_" S ^TMP($J,""PRCHD"",J)=""""" X PRCHD("DS")
 G 1:$L(X)>1&(X[",")&(X'[":"),2:X?.N1":".N,3:X?.N K X,PRCHD,^TMP($J,"PRCHD") Q
1 S:$E(X,$L(X))="," X=$E(X,1,$L(X)-1) F I=1:1 Q:'$D(X)  S PRCHD=$P(X,",",I) Q:PRCHD=""  D DIS1,DIS2:$D(X)
 Q
2 S:$E(X,$L(X))=":" X=X_$P(^PRC(442,D0,2,0),U,4) ; <<<<REW to handle "5:" as if it were "5:last"  patch 65 for NOIS BRX-1294-10197
 X "F I="_$P(X,":",1)_":1:"_$P(X,":",2)_" Q:'$D(X)  S PRCHD=I D DIS1,DIS2:$D(X)"
 Q
3 S PRCHD=X D DIS1,DIS2:$D(X) Q
DIS1 I PRCHD>$P(^PRC(443.6,D0,2,0),U,4)!(PRCHD<1) W " ??",$C(7),!," **ITEM ",PRCHD," IS NOT A VALID LINE ITEM**" K X,PRCHD,^TMP($J,"PRCHD") Q
 I $D(^TMP($J,"PRCHD",PRCHD)) W " ??",$C(7),!," **ITEM ",PRCHD," IS IN ANOTHER DISCOUNT**" K X,PRCHD,^TMP($J,"PRCHD") Q
 S PRCHD("AC")=PRCHD("AC")+1,^TMP($J,"PRCHD",PRCHD)="" Q
DIS2 G DIS21:'$D(PRCHD("LI")),ER:'$D(^TMP($J,"PRCHD","LI",PRCHD)) Q
DIS21 S PRCHD("CN")=0 F J=0:0 S PRCHD("CN")=$O(PRCH("AM",PRCHD("CN"))) G:PRCHD("CN")<0 ER1 D DIS221 Q:$D(PRCHD("LI"))
 Q
DIS221 S PRCHD("CN3")=$P(PRCH("AM",PRCHD("CN")),U,3),PRCHD("CN3")=$E(PRCHD("CN3"),1,$L(PRCHD("CN3"))-1) X "F K="_PRCHD("CN3")_" I K=PRCHD D DIS22 Q" Q:$D(PRCHD("LI"))
 Q
DIS22 X "F L="_PRCHD("CN3")_" S ^TMP($J,""PRCHD"",""LI"",L)=""""" S PRCHD("LI")="" Q
ER W $C(7),!," ** ITEM ",PRCHD," IS NOT ASSOCIATED WITH ",$S(PRCHD("CN")=".OM":"PURCHASE ORDER",1:"CONTRACT "_PRCHD("CN"))," **" K X,PRCHD,^TMP($J,"PRCHD") Q
ER1 W !,"** ERROR WITH LINE ITEM ",I,"**",$C(7) K X,PRCHD,^TMP($J,"PRCHD") Q
TERM S PRCHD=$O(^PRC(443.6,DA(1),2,"AC",X,0)) K:PRCHD<0 X I $D(^PRC(443.6,DA(1),2,PRCHD,2)) S PRCHD=$P(^(2),U,5),PRCHD("*")=$S(PRCHD]"":PRCHD,1:"") Q
