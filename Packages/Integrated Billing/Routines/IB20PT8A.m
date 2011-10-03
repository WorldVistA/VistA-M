IB20PT8A ;ALB/CPM - EXPORT ROUTINE 'DG3PR2' ; 24-FEB-94
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
DG3PR2 ;ALB/MIR - CONTINUATION OF THE THIRD PARTY REIMBURSEMENT ; NOV 21 90@8
 ;;5.3;Registration;**26**;Aug 13, 1993
 S DGINS=0 W !!,"INSURANCE TYPE",?24,"INSURANCE #",?45,"GROUP #",?63,"EXPIRES   HOLDER",!,"--------- ----",?24,"--------- -",?45,"----- -",?63,"-------   ------"
 D ALL^IBCNS1(DFN,"DGIBINS") F I=0:0 S I=$O(DGIBINS(I)) Q:'I  S J=DGIBINS(I,0) S X=$G(^DIC(36,+J,0)) W !,$S($P(X,"^",2)="N":"*",1:""),$E($P(X,"^",1),1,22),?24,$P(J,"^",2),?45,$P(J,"^",3) S DGINS=$S($P(X,"^",2)="N":1,1:0) D INS2
 I DGINS W !?22,"* - Insurer may not reimburse!"
 K DGINS,DGIBINS
 S Y=+DGAD X ^DD("DD") W !!,"Admitted: ",Y,?40,"Discharged: " S Y=+DGDC I Y X ^DD("DD") W Y
 I $P(DGAD,"^",18)=9 W !,"Transferred in From ",$S($D(^DIC(4,+$P(DGAD,"^",5),0)):$P(^(0),"^",1),1:"")
 S DGPTF=$P(DGAD,"^",16) I 'DGPTF!('$D(^DGPT(+DGPTF,0))) W !,"No PTF Record Exists" Q
 I '$D(^DGP(45.84,DGPTF)) W !,"PTF Record not closed",!
 K ^UTILITY("DG") F I=0:0 S I=$O(^DGPT(DGPTF,"M",I)) Q:'I  S J=^(I,0) S:$P(J,"^",2) ^UTILITY("DG",$J,"M",+$P(J,"^",10))=J
 F I=0:0 S I=$O(^DGPT(DGPTF,"S",I)) Q:'I  D HEAD:$Y>(IOSL-5) Q:'DGFL  S J=^DGPT(DGPTF,"S",I,0),^UTILITY("DG",$J,"S",+J)=J
 Q:'DGFL  I $O(^UTILITY("DG",$J,"M",0)) W !!,"DATE",?22,"LOS BEDSECTION",?39,"LOS",?45,"DIAGNOSES",!,"----",?22,"---------------",?39,"----  ---------"
 S DGPR=DGAD F I=0:0 S I=$O(^UTILITY("DG",$J,"M",I)) Q:'I  S J=^(I) D HEAD:$Y>(IOSL-5) Q:'DGFL  S Y=I X ^DD("DD") D LOL W !,Y,?22,$E($S($D(^DIC(42.4,+$P(J,"^",2),0)):$P(^(0),"^",1),1:""),1,16),?39,$J(DGLOL,4) D DIAG S DGPR=I
 Q:'DGFL  S DGPMIFN=DGCA D ^DGPMLOS W !?39,"----  ----------",!?26,"TOTAL LOS:",?39,$J(+$P(X,"^",5),4),?45,$S($D(^ICD9(+$S($D(^DGPT(DGPTF,70)):$P(^(70),"^",10),1:""),0)):"DXLS: "_$P(^(0),"^",1)_" ("_$P(^(0),"^",3)_")",1:"")
 Q:'$O(^UTILITY("DG",$J,"S",0))  D HEAD:$Y>(IOSL-10) Q:'DGFL  W !!,"SURGERY DATE",?22,"SPECIALTY",?45,"OP CODES",!,"------------",?22,"----------",?44,"--------"
 F I=0:0 S I=$O(^UTILITY("DG",$J,"S",I)) Q:'I  S J=^(I),Y=I X ^DD("DD") W !,Y,?22,$E($S($D(^DIC(45.3,+$P(J,"^",3),0)):$P(^(0),"^",2),1:""),1,16) D OP
 Q
DIAG S M=0 F K=5:1:15 I K'=10 S L=$P(J,"^",K) I L W:M ! W ?45,$S($D(^ICD9(+L,0)):$P(^(0),"^",1)_" ("_$P(^(0),"^",3)_")",1:"") S M=1
 Q
OP S M=0 F K=8:1:12 S L=$P(J,"^",K) I L W:M ! W ?45,$S($D(^ICD0(+L,0)):$P(^(0),"^",1)_" ("_$P(^(0),"^",4)_")",1:"") S M=1
 Q
LOL S X1=I,X2=DGPR D DTC S DGLOL=X
 F K=DGPR+.0000005:0 S K=$O(^DGPM("APCA",DFN,DGCA,K)) Q:'K!(K>I)  S C=$O(^(+K,0)) I $D(^DGPM(+C,0)),"^2^3^13^43^44^45^"[("^"_$P(^(0),"^",18)_"^") S X1=$O(^DGPM("APCA",DFN,DGCA,K)),X1=$S('X1:I,X1>I:I,1:X1),X2=K D DTC S DGLOL=DGLOL-X
 Q
HEAD N I,J,K,L,M,Y I $E(IOST,1)="C" S DIR(0)="E" D ^DIR S DGFL=Y I 'DGFL Q
 W @IOF,!,"THIRD PARTY REIMBURSEMENT",?49,"PRINTED:  ",DGNOW
 W !,"("_$P(^DPT(DFN,0),"^",1)_")",!
 Q
INS2 ;insurance data continued
 I $P(X,"^",2)="N" S DGINS=1
 S X=$P(J,"^",4) W:X]"" ?63,$E(X,4,5),"/",$E(X,6,7),"/",$E(X,2,3) S X=$P(J,"^",6) W ?73,$S(X="v":"VETERAN",X="s":"SPOUSE",X="o":"OTHER",1:"UNKNOWN")
 Q
DTC N I,J,K,L,M,Y D ^%DTC Q
