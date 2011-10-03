FHADR9A ; HISC/NCA,RTK - Dietetic Survey (cont.) ;1/10/94  16:10
 ;;5.5;DIETETICS;;Jan 28, 2005
EN2 ; Print the Dietetic Survey
 D:$Y'<(LIN-16) HDR^FHADRPT
 K T1,T2,TOT S TQ=0
 F I=1:1:10 S (T1(I),T2(I),TOT(I))=""
 F QR=1:1:4 S QTR=QR,PRE=FHYR_"0"_QTR_"00" D Q2^FHADRPT,Q11
 G PRT
Q11 Q:'SDT!('EDT)
 F N=1:1:10 D DECODE
 Q
DECODE ; Decode each string rating
 S (L1,S1,S2,S3)=""
 S TLE=$S(N=1:"Q1AP",N=2:"Q2FP",N=3:"Q3HF",N=4:"Q4CF",N=5:"Q5CR",N=6:"Q6PD",N=7:"Q7TI",N=8:"Q8ET",N=9:"Q9NI",1:"Q10V")
 S L1=$P($G(^FH(117.3,PRE,TLE,0)),"^",3) Q:L1<1
 S SURV=$P($G(^FH(117.3,PRE,TLE,L1,0)),"^",2,7)
 F LP=1:1:6 D
 .S (CTR,VAL)=0,X=$P(SURV,"^",LP)
 .F J=1:1 Q:$P(X," ",J)=""  D
 ..S X1=$P(X," ",J),CHR=$E(X1,1),NUM=+$P(X1,CHR,2)
 ..;S RTG=$S(CHR="V":5,CHR="G":4,CHR="A":3,CHR="F":2,1:1)
 ..S RTG=$S(CHR="E":5,CHR="V":4,CHR="G":3,CHR="F":2,1:1)
 ..S S3=S3+NUM,VAL=VAL+(NUM*RTG),CTR=CTR+NUM Q
 .S S1=S1_VAL_","
 .S S2=S2_CTR_"," Q
 S $P(T1(N),"^",QTR)=S1,$P(T2(N),"^",QTR)=S2,$P(TOT(N),"^",QTR)=S3 Q
PRT ; Print the Dietetic Survey
 D HDR,HD1
 F N=1:1:10 D LP
 K CHR,CTR,FIN,I,J,L,L1,L2,LP,N,N1,NUM,QNAM,QR,RTG,S1,S2,S3,SUM,SURV,T1,T2,TOT,TIT,TLE,TQ,VAL,X,X1,X2 Q
LP ; Loop to Print each row
 I $Y'<(LIN-6) D HDR^FHADRPT,HDR,HD1
 S QNAM=$S(N=1:"Appetizing",N=2:"Foods Preferred",N=3:"Hot Enough",N=4:"Cold Enough",N=5:"Courteous",N=6:"Preferences Discussed",N=7:"Timeliness",N=8:"Enough Time to Eat",N=9:"Nutritional Info",1:"Overall")
 W !,QNAM,!
 S (FTQR,FNRT,SUM)=0
 F RR=1:1:4 S (TQR(RR),NRT(RR))=0
 F N1=1:1:6 D
 .S TIT=$S(N1=1:"GM&S",N1=2:"NHCU",N1=3:"PSYCH",N1=4:"DOM",N1=5:"SCI",1:"OTHER")
 .W !,TIT,?23
 .S (FIN,RTG,TQ)=0
 .F QR=1:1:4 D
 ..S X1=$P($G(T1(N)),"^",QR) S:$E(X1,$L(X1))="," X1=$E(X1,1,$L(X1)-1)
 ..S X2=$P($G(T2(N)),"^",QR) S:$E(X2,$L(X2))="," X2=$E(X2,1,$L(X2)-1)
 ..S NUM=$P(X1,",",N1),CTR=$P(X2,",",N1)
 ..S X=$S(CTR:NUM/CTR,1:"")
 ..W $J($S(CTR:CTR,1:""),5),$S(X:$J(X,5,2),1:$J("",5))_$J("",12)
 ..S FIN=FIN+CTR,RTG=RTG+X,TQR(QR)=TQR(QR)+X
 ..I CTR S TQ=TQ+1,NRT(QR)=NRT(QR)+1
 ..Q
 .W ?111,$J($S(FIN:FIN,1:""),5),$S(TQ:$J(RTG/TQ,5,2),1:$J("",5))
 .S SUM=SUM+FIN
 .Q
 F RR=1:1:4 S FTQR=FTQR+TQR(RR),FNRT=FNRT+NRT(RR)
 W !,"Total",?23 F L2=1:1:4 S X=$P($G(TOT(N)),"^",L2) W $J($S(X:X,1:""),5)_$S(NRT(L2):$J(TQR(L2)/NRT(L2),5,2),1:$J("",5))_$J("",12)
 W ?111,$J($S(SUM:SUM,1:""),5),$S(FNRT:$J(FTQR/FNRT,5,2),1:$J("",5)),!
 Q
HDR ; Section Heading
 W !!!!,"S E C T I O N  VI   P A T I E N T   S A T I S F A C T I O N" Q
HD1 ; Print Heading for Overall Service
 W !!!,"DIETETIC SURVEY",?25,"1st Qtr",?47,"2nd Qtr",?69,"3rd Qtr",?91,"4th Qtr",?113,"YTD Rtng"
 W !?25,"Num Rtng",?47,"Num Rtng",?69,"Num Rtng",?91,"Num Rtng",?113,"ToT  Avg",! Q
