FHADR3A ; HISC/NCA - Facility Workload ;6/18/93  11:30
 ;;5.5;DIETETICS;;Jan 28, 2005
EN2 ; Calculate Inpats Days of Care and Outpats treated in
 ; Hosp & Sat Clinics
 K AMS,T1,T2,TD S AMS="" F K=1:1:8 S T1(K)=""
 F K=1:1:4 S TD(K)=0
 F QR=1:1:4 S QTR=QR,PRE=FHYR_"0"_QTR_"00" D Q2^FHADRPT D
 .Q:'SDT!('EDT)
 .K N S S=0 F K=1:1:24 S N(K)=0
 .S STR1=""
 .S D1=SDT\1 F L1=0:0 D  Q:X>EDT
 ..S Y0=$G(^FH(117,D1,0)),Y1=$G(^(1))
 ..S:Y0'="" S=S+1
 ..S K=1 F L=1,2,4,5,7,8 S K=K+1,N(L)=$P(Y0,"^",K)
 ..S K=10 F L=1:3:16 S K=K+1,N(K)=$P(Y1,"^",L)+$P(Y1,"^",L+1)+$P(Y1,"^",L+2)
 ..S N(3)=N(1)-N(2)*3,N(6)=N(4)-N(5)*3,N(9)=N(7)-N(8)*3
 ..S N(10)=N(3)+N(6)+N(9)+N(11)+N(12)+N(13)+N(14)+N(15)+N(16)
 ..S N(22)=N(1)-N(2),N(23)=N(4)-N(5),N(24)=N(7)-N(8)
 ..S N(17)=N(17)+N(10),N(18)=N(18)+N(22)
 ..S N(19)=N(19)+N(23),N(20)=N(20)+N(24)
 ..S X1=D1,X2=1 D C^%DTC
 ..S D1=X
 ..Q
 .S N(21)=N(18)+N(19)+N(20)
 .S $P(T1(QTR),"^",1)=$P(T1(QTR),"^",1)+N(17)
 .S $P(T1(QTR),"^",2)=$P(T1(QTR),"^",2)+N(20)
 .S $P(T1(QTR),"^",3)=$P(T1(QTR),"^",3)+N(19)
 .S $P(T1(QTR),"^",4)=$P(T1(QTR),"^",4)+N(18)
 .S $P(T1(QTR),"^",5)=$P(T1(QTR),"^",5)+N(21)
 .S TD(QTR)=TD(QTR)+S
 .S $P(^FH(117.3,PRE,1),"^",5)=N(17)
 .S STR=$G(^FH(117.3,PRE,1))
 .S $P(T1(5),"^",QTR)=$P(T1(5),"^",QTR)+$P(STR,"^",1)
 .S $P(T1(5),"^",5)=$P(T1(5),"^",5)+$P(STR,"^",1)
 .S $P(T1(6),"^",QTR)=$P(T1(6),"^",QTR)+$P(STR,"^",1)
 .S NUM=$P(STR,"^",3) Q:NUM<1
 .S CTR=$P($G(^FH(117.3,PRE,"CLIN",0)),"^",4) Q:CTR=""  Q:CTR'=NUM
 .F NUM=0:0 S NUM=$O(^FH(117.3,PRE,"CLIN",NUM)) Q:NUM<1  S STR1=$G(^(NUM,0)) D
 ..S SAT=$P(STR1,"^",1)
 ..I SAT'="" S:'$D(T2(SAT)) T2(SAT)=""
 ..S $P(T2(SAT),"^",QTR)=$P(T2(SAT),"^",QTR)+$P(STR1,"^",2)
 ..S $P(T2(SAT),"^",5)=$P(T2(SAT),"^",5)+$P(STR1,"^",2)
 ..S $P(T1(5),"^",5)=$P(T1(5),"^",5)+$P(STR1,"^",2)
 ..S $P(T1(6),"^",QTR)=$P(T1(6),"^",QTR)+$P(STR1,"^",2)
 ..Q
 .Q
 D HDR1 S (FIN,FTO,YD)=0
 W !,?15,"Hospital ",?61
 F I=1:1:4 S X=$P(T1(I),"^",2),X2=0 D COMMA^%DTC W X S FIN=FIN+$P(T1(I),"^",2)
 S X=FIN,X2=0 D COMMA^%DTC W ?112,X S FTO=FTO+FIN,FIN=0
 W !,?15,"Nursing Home ",?61
 F I=1:1:4 S X=$P(T1(I),"^",3),X2=0 D COMMA^%DTC W X S FIN=FIN+$P(T1(I),"^",3)
 S X=FIN,X2=0 D COMMA^%DTC W ?112,X S FTO=FTO+FIN,FIN=0
 W !,?15,"Domicillary ",?61
 F I=1:1:4 S X=$P(T1(I),"^",4),X2=0 D COMMA^%DTC W X S FIN=FIN+$P(T1(I),"^",4)
 S X=FIN,X2=0 D COMMA^%DTC W ?112,X S FTO=FTO+FIN,FIN=0
 W !,?15,"Total Inpatient Days ",?61
 F I=1:1:4 S X=$P(T1(I),"^",5),X2=0 D COMMA^%DTC W X
 S X=FTO,X2=0 D COMMA^%DTC W ?112,X
 W !!!,?13,"OUTPATIENTS TREATED",!?15,"Hospital Clinic ",?61
 F I=1:1:4 S X=$P(T1(5),"^",I),X2=0 D COMMA^%DTC W X S FIN=FIN+$P(T1(5),"^",I)
 S X=FIN,X2=0 D COMMA^%DTC W ?112,X S FIN=0
 S (CT,Z)=0 F K=0:0 S Z=$O(T2(Z)) Q:Z=""  S CT=CT+1 D
 .W !,?15,"Satellite Location ",CT," ",Z,?61
 .F J=1:1:4 S X=$P(T2(Z),"^",J),X2=0 D COMMA^%DTC W X
 .S X=$P(T2(Z),"^",5),X2=0 D COMMA^%DTC W ?112,X
 .Q
 W !,?15,"Total Outpatients Treated ",?61
 F I=1:1:4 S X=$P(T1(6),"^",I),X2=0 D COMMA^%DTC W X S FIN=FIN+$P(T1(6),"^",I)
 S X=FIN,X2=0 D COMMA^%DTC W ?112,X S FIN=0
 D:$Y'<LIN HDR^FHADRPT D HDR2
 W !!!!?13,"SERVED MEALS SUMMARY",!!?65,"1st Qtr     2nd Qtr     3rd Qtr     4th Qtr         Yearly"
 W !!?15,"Total Served Meals",?61
 F I=1:1:4 S X=$P(T1(I),"^",1),X2=0 D COMMA^%DTC W X S FIN=FIN+$P(T1(I),"^",1)
 S X=FIN,X2=0 D COMMA^%DTC W ?112,X
 W !,?15,"Average Daily Meals",?61 S FIN=0
 F I=1:1:4 S X=$S(+TD(I)'<1:$P(T1(I),"^",1)/TD(I),1:""),$P(AMS,"^",I)=X,X2=0,FIN=FIN+$P(T1(I),"^",1),YD=YD+TD(I) D COMMA^%DTC W X
 S X=$S(YD'<1:FIN/YD,1:""),X2=0 D COMMA^%DTC W ?112,X
 K N,T1,T2,TD Q
HDR1 ; Print heading for Facility Workload
 D:$Y'<(LIN-20) HDR^FHADRPT
 W !!!?13,"S E C T I O N  II   F A C I L I T Y   W O R K L O A D   S T A T I S T I C S"
 W !!!!,?13,"INPATIENT DAYS OF CARE" W ?65,"1st Qtr     2nd Qtr     3rd Qtr     4th Qtr      YTD Total" Q
HDR2 ; Print Heading for Workload Statistics
 D:$Y'<(LIN-14) HDR^FHADRPT
 W !!!!!!?13,"S E C T I O N  III   D I E T E T I C   W O R K L O A D   S T A T I S T I C S"
 Q
