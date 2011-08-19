DENTPCD1 ;ISC2/SAW,HAG-PRINT CDR WORKSHEETS ;9/24/99  09:04
 ;;1.2;DENTAL;**4,24,29**;JAN 26, 1989
 F I=1:1:18 S B(I)=B(I)/B,V=B(I) S:I=18 B(I)=V-F,V=B(I) S $P(B(I),"^",2)=V*R,X1=V*R,$P(B(I),"^",3)=V*E,X2=V*E,$P(B(I),"^",4)=$P(B(I),"^")-(X1+X2)
A S DATE="FOR THE MONTH OF "_DT2_" "_(1700+$E(DATE,1,3)),T="Medical",K=1100,(RT,ST,M,N,S,P,C)=0 D EN3
 W !,?5,T,!,?5,"01",?15,"1110.248",?27,"Medical",?55,$J($P(B(1),"^",4),7,4) S Z=1 D EN6
 W !,?5,"06",?15,"1111.248",?27,"Neurology",?55,$J($P(B(6),"^",4),7,4) S Z=6 D EN6
 W !,?5,"07",?15,"1113.248",?27,"Rehabilitation",?55,$J($P(B(7),"^",4),7,4) S Z=7 D EN6
 W !,?5,"10",?15,"1116.248",?27,"Spinal Cord Injury",?55,$J($P(B(10),"^",4),7,4) S Z=10 D EN6
 W !,?5,"11",?15,"1114.248",?27,"Epilepsy Center",?55,$J($P(B(11),"^",4),7,4) S Z=11 D EN6
 W !,?5,"12",?15,"1115.248",?27,"Blind Rehabilitation",?55,$J($P(B(12),"^",4),7,4) S Z=12 D EN6
 W !,?5,"13",?15,"1118.248",?27,"Dialysis Program",?55,$J($P(B(13),"^",4),7,4) S Z=13 D EN6
 W !,?5,"14",?15,"1117.248",?27,"Medical Int. Care Unit",?55,$J($P(B(14),"^",4),7,4) S Z=14 D EN6,EN5
 S T="Surgical",K=1200,(ST,M,N,S)=0
 W !,?5,T,!,?5,"02",?15,"1210.248",?27,"Surgical",?55,$J($P(B(2),"^",4),7,4) S Z=2 D EN6
 W !,?5,"15",?15,"1211.248",?27,"Surgical Int. Care Unit",?55,$J($P(B(15),"^",4),7,4) S Z=15 D EN6,EN5
 S T="Psychiatry",K=1300,(ST,M,N,S)=0
 W !,?5,T,!,?5,"03",?15,"1310.248",?27,"Psychiatry - Acute",?55,$J($P(B(3),"^",4),7,4) S Z=3 D EN6
 W !,?5,"04",?15,"1310.248",?27,"Psychiatry - Long Term",?55,$J($P(B(4),"^",4),7,4) S Z=4 D EN6
 W !,?5,"08",?15,"1313.248",?27,"Alcohol",?55,$J($P(B(8),"^",4),7,4) S Z=8 D EN6
 W !,?5,"09",?15,"1313.248",?27,"Drug",?55,$J($P(B(9),"^",4),7,4) S Z=9 D EN6,EN5
 S T="Nursing Home",K=1400,(ST,M,N,S)=0
 W !,?5,T,!,?15,"1410.248",?27,"Nursing Home Care Unit",?55,$J($P(B(16),"^",4),7,4) S Z=16 D EN6,EN5
 S T="Domiciliary",K=1500,(ST,M,N,S)=0 D EN3
 W !,?5,T,!,?15,"1510.248",?27,"Domicilliary",?55,$J($P(B(17),"^",4),7,4) S Z=17 D EN6,EN5
 S T="Intermediate Care",K=1600,(ST,M,N,S)=0
 W !,?5,T,!,?5,"05",?15,"1610.248",?27,"Intermediate Care Activity",?55,$J($P(B(5),"^",4),7,4) S Z=5 D EN6,EN5
 S T="Outpatient",K=2800,(ST,M,N,S)=0
 W !,?5,T,!,?15,"2710.248",?27,"Outpatient",?55,$J($P(B(18),"^",4),7,4) S Z=18 D EN6,EN5
 S T="*** CLINICAL---TOTAL ***"
 W !,?5,T,?55,$J(P,7,4),!,?5,I,! S T="Non-Clinical Activity" W !,?5,T,!,?15,"4710.248",?27,"Dental Fee Basis",?55,$J(F,7,4)
 S RT=RT+F+P W !,?5,I,!!,?5,"**** Reconciled --- Total ****",?55,$J(RT,7,4),! S I="",$P(I,"-",59)="" W ?5,I,!
 W !,?5,"Disregard the following trainee data if your station does",!,?5,"not have a Dental Resident Program",!
 S P=0 F I=1,6,7,10:1:14 S P=P+$P(B(I),"^")
 W !,?15,"1100.11",?27,"Medical Bed Proportion",?55,$J(P,7,4)
 S P=0 F I=2,15 S P=P+$P(B(I),"^")
 W !,?15,"1200.11",?27,"Surgical Bed Proportion",?55,$J(P,7,4)
 S P=0 F I=3,4,8,9 S P=P+$P(B(I),"^")
 W !,?15,"1300.11",?27,"Psychiatry Bed Proportion",?55,$J(P,7,4)
 W !,?15,"1400.11",?27,"Nursing Home Proportion",?55,$J($P(B(16),"^"),7,4)
 W !,?15,"1500.11",?27,"Domicilliary Bed Proportion",?55,$J($P(B(17),"^"),7,4)
 W !,?15,"1600.11",?27,"Intermediate Bed Proportion",?55,$J($P(B(5),"^"),7,4)
 W !,?15,"2800.11",?27,"Outpatient Bed Proportion",?55,$J($P(B(18),"^"),7,4) Q
EN3 S C=C+1 W @IOF,!,?57,"Page ",C,!,?5,"MONTHLY DENTAL SERVICE COST DISTRIBUTION (10-0141) REPORT",!,?(68-$L(DATE)\2),DATE,!!,?5,"BED",?15,"ACCOUNT",!,?5,"SECTION",?15,"NUMBER",?27,"NAME",?55,"CLINICAL",! Q
EN5 S P=P+ST,Q=T_" Sub-Total" W !!,?(50-$L(Q)),Q,?55,$J(ST,7,4),!
 W !,?16,K_".12",?27,"Instructional",?55,$J(M*P1,7,4) S RT=RT+(M*P1)
 W !,?16,K_".13",?27,"Administrative",?55,$J(M*P2,7,4) S RT=RT+(M*P2)
 W !,?16,K_".14",?27,"Continuing Education",?55,$J(M*P3,7,4) S RT=RT+(M*P3)
 W !,?16,K_".21",?27,"Research",?55,$J(N,7,4),! S RT=RT+N,I="",$P(I,"-",59)="" W ?5,I,! Q
 Q
EN6 S M=M+$P(B(Z),"^",3),N=N+$P(B(Z),"^",2),ST=ST+$P(B(Z),"^",4) Q
