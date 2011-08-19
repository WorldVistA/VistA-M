FHADR81 ; HISC/NCA - Print Dietetic Costs ;11/25/94  14:11
 ;;5.5;DIETETICS;;Jan 28, 2005
EN2 ; Print Dietetic Cost
 K N,PER,T1,TO,TP S (TO,TP,TQ,TQ1,TQ2,TQ3,TQ4)="",TOT=0
 F I=1:1:5 S T1(I)=""
 F I=1:1:4 S PER(I)=""
 F QR=1:1:4 S QTR=QR,PRE=FHYR_"0"_QTR_"00" D Q2^FHADRPT,CALC
 D PRT K N,PER,T1,TO,TP Q
CALC ; Calculate the Avg Cost Per Meal and store it in T1(1)
 Q:'SDT!('EDT)
 S (BEG,CLOS,ISS,USG)=0
 S SDT=$E(SDT,1,5)_"00",EDT=$E(EDT,1,5)_"00"
 S X1=$P($G(^FH(117.2,SDT,0)),"^",2,7) F J=1:1:6 S BEG=BEG+$P(X1,"^",J)
 S X1=$P($G(^FH(117.2,EDT,0)),"^",14,19) F J=1:1:6 S CLOS=CLOS+$P(X1,"^",J)
 S SDT=$E(SDT,1,5)-1_"00"
 F LL=SDT:0 S LL=$O(^FH(117.2,LL)) Q:LL<1!(LL>EDT)  S X1=^(LL,0) D
 .S J1=7
 .F J=1:1:6 D
 ..S J1=J1+1
 ..S ISS=ISS+$P(X1,"^",J1)
 ..Q
 .Q
 S USG=(BEG+ISS)-CLOS
 S TQ=TQ+1
 S TOT=$P($G(^FH(117.3,PRE,1)),"^",5)
 S USG=$S(TOT:USG/TOT,1:"") S:USG TQ1=TQ1+1 S $P(T1(1),"^",QTR)=$P(T1(1),"^",QTR)+USG
 S $P(T1(1),"^",5)=$P(T1(1),"^",5)+USG
 ; Calculate the Cost Per Diem
 S ST=$P($G(^FH(117.3,PRE,"COST",0)),"^",3) Q:ST<1
 S ST1=$G(^FH(117.3,PRE,"COST",ST,0)) Q:ST1=""
 F I=1:1:10 S N(I)=""
 S K=0 F I=1:1:6,8,9 S K=K+1,N(I)=$P(ST1,"^",K)
 S TOT=$S(TOT:TOT/3,1:"")
 F M=1:1:6,8,9 S N(M)=$S(TOT:N(M)/TOT,1:"")
 S N(7)=N(2)-N(3)-N(4)-N(5)-N(6),N(10)=N(1)-N(2)-N(8)-N(9)
 F M=1:1:10 S N(M)=$J(N(M),0,2)
 S:N(1) TQ2=TQ2+1
 S:N(2) TQ3=TQ3+1
 ; Store data of each 4 Quarters in T1(2)-T1(5) and Total in TO.
 S K=0 F I=3:1:10 S K=K+1,$P(T1(QTR+1),"^",K)=$S(N(I):N(I),1:"")
 S $P(T1(QTR+1),"^",9)=$S(N(2):N(2),1:""),$P(T1(QTR+1),"^",10)=$S(N(1):N(1),1:"")
 F L=1:1:10 S $P(TO,"^",L)=$P(TO,"^",L)+$P(T1(QTR+1),"^",L)
 ; Calculate and store Percent Cost and after T1 Cost Strg.
 F I=6:1:10 S $P(PER(QTR),"^",I)=$S(+$P(T1(QTR+1),"^",10)'<1:$P(T1(QTR+1),"^",I)/$P(T1(QTR+1),"^",10)*100,1:"")
 Q
PRT ; Print Avg Cost Per Meal, Cost Per Diem, and the YTD
 S $P(T1(1),"^",5)=$S(TQ1:$P(T1(1),"^",5)/TQ1,1:"")
 D:$Y'<(LIN-9) HDR^FHADRPT D HD,HDR
 W ?35 F L=1:1:4 W " ",$S($P(T1(1),"^",L):$J($P(T1(1),"^",L),8,2),1:$J("",8))_$J("",11)
 W $S($P(T1(1),"^",5):$J($P(T1(1),"^",5),8,2),1:$J("",8))
 D HDR1
 F L=6:1:10 S $P(TP,"^",L)=$S(+$P(TO,"^",10)'<1:$P(TO,"^",L)/$P(TO,"^",10)*100,1:"")
 S K=1
 S I=2 F TIT="Tech (1019)","Dietitians (1018)","Wageboard (1008)","Clerical (1002)","Other" S TQ4=TQ2 D LOOP
 S X="Total Personal Cost" S K1=9 D LAST
 S I=0,K=6 F TIT="Subsistence (2610)","Operating Supp (2660)","All Other" S TQ4=TQ3 D LOOP
 S X="Total" S K1=10 D LAST
 Q
LAST ; Print the Last Line
 S TQ4=""
 W !,X,?29 F I=1:1:4 D
 .S X=$S($P(T1(I+1),"^",K1):$P(T1(I+1),"^",K1),1:"")
 .S:X TQ4=TQ4+1
 .W $S(X:$J(X,9,2),1:$J("",9))_" "
 .W $S($P(PER(I),"^",K1):$J($P(PER(I),"^",K1),8,2),1:$J("",8))_"  "
 .Q
 W ?110 S X=$S($P(TO,"^",K1):$P(TO,"^",K1),1:""),X=$J($S(TQ4:X/TQ4,1:""),0,2)
 W $S(X:$J(X,9,2),1:$J("",9))_" "
 W $S($P(TP,"^",K1):$J($P(TP,"^",K1),8,2),1:$J("",8))
 Q
LOOP ; Print title for each row along with the cost of the quarters.
 W ! W:I ?I W TIT,?29
 F J=1:1:4 D
 .S X=$S($P(T1(J+1),"^",K):$P(T1(J+1),"^",K),1:"")
 .W $S(X:$J(X,9,2),1:$J("",9))_" "
 .W $S($P(PER(J),"^",K):$J($P(PER(J),"^",K),8,2),1:$J("",8))_"  "
 .Q
 W ?110 S X=$S($P(TO,"^",K):$P(TO,"^",K),1:""),X=$J($S(TQ4:X/TQ4,1:""),0,2)
 W $S(X:$J(X,9,2),1:$J("",9))_" "
 W $S($P(TP,"^",K):$J($P(TP,"^",K),8,2),1:$J("",8))
 S K=K+1
 Q
HD W !!!!,"S E C T I O N  V   D I E T E T I C   C O S T" Q
HDR ; Print Cost Per Meal Hdg
 W !!!!,"COST PER MEAL"
 W ?37,"1st Qtr",?57,"2nd Qtr",?77,"3rd Qtr",?97,"4th Qtr",?120,"YTD"
 W !!,"Average Cost Per Meal"
 Q
HDR1 ; Print Cost Per Diem Hdg
 D:$Y'<(LIN-15) HDR^FHADRPT,HD
 W !!!!,"COST PER DIEM"
 W ?37,"1st Qtr",?57,"2nd Qtr",?77,"3rd Qtr",?97,"4th Qtr",?120,"YTD"
 W !,?34,"Cost",?41,"% Cost",?54,"Cost",?61,"% Cost",?74,"Cost",?81,"% Cost",?94,"Cost",?101,"% Cost",?112,"Avg Tot",?122,"% Cost"
 W !,"Personal Services" Q
