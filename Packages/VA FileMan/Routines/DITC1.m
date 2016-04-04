DITC1 ;SFISC/XAK-COMPARE FILE ENTRIES PRINT ;7/1/93  4:31 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
PRNT S %ZIS("B")="",%ZIS=$S($D(DIMERGE):"M",1:"QM") D ^%ZIS G:POP END^DITC I $D(IO("Q")) G QUE
COMP W:$D(DDSP) !,"COMPARING THE TWO ENTRIES" F I=1:1:2 I $L(DTO(I)) S J=-1 F K=0:0 S @("J=$O("_DTO(I)_"J))") Q:J=""  W:$D(DDSP) "." D EACH
 D DISP
 Q
EACH ;
 I @("$D("_DTO(I)_"J))'<10") D MUL Q
 S X=^(J) F N=1:1 D:$L($P(X,U,N)) SETU Q:'$L($P(X,U,N,999))
 Q
SETU ;
 I '$D(^UTILITY($J,"DIT",J,N,0)) S @("Y=$O(^DD("_DFF_",""GL"",J,"_N_",-1))") Q:Y=""  S %=^DD(DFF,Y,0),^UTILITY($J,"DIT",J,N,0)=Y_U_$P(%,U,1)_U I Y=.01,$P(%,U,5,999)["DINUM" S ^UTILITY($J,"DITDINUM",J,N,0)=""
 S O=+^UTILITY($J,"DIT",J,N,0) S:$P(^DD(DFF,O,0),U,2)["O" ^UTILITY($J,"DITI",J,N,I)=$P(X,U,N)
 S C=^DD(DFF,O,0),O=$P(C,U,1),C=$P(C,U,2),D0=DIT(I),Y=$P(X,U,N) D Y^DIQ S ^UTILITY($J,"DIT",J,N,I)=Y
 Q
MUL ;
 I '$D(^UTILITY($J,"DIT",U,J,0)) S @("Y=$O(^DD("_DFF_",""GL"",J,0,-1))") Q:Y=""  S ^UTILITY($J,"DIT",U,J,0)=Y_U_$P(^DD(DFF,Y,0),U,1)_U
 S N=0 F L=0:1 S @("N=$O("_DTO(I)_"J,N))") Q:'N
 S $P(^UTILITY($J,"DIT",U,J,0),U,I+3)=L
 Q
DISP ;
 U IO
 I $D(DIMERGE) S J=-1 F  S J=$O(^UTILITY($J,"DIT",J)) Q:U[J  S N=-1 F  S N=$O(^UTILITY($J,"DIT",J,N)) Q:N=""  D D11^DITC2
 S DC=0,DDSH="",$P(DDSH,"-",IOM-1)="-",$P(DDSPC," ",30)=" ",DV=(IOM-1)\3
 S DHD(0)="COMPARISON OF "_DFL(1)_" FILE ENTRIES"
 S R=$S(DSUB(DSUB)[",":1,1:0),%H=$H D YX^%DTC S DHD(9)=$P(Y,":",1,2)
 F I=1:1:2 I $L(DTO(I)) F J=1:2 S K=$P(DTO(I),",",1,J+R) Q:($E(K,$L(K))=",")  D D0
 S DIFF=$S(IOST?1"C".E:1,1:0) D ^DITC2 K DUOUT
 I $D(DTOUT)!('$D(DIMERGE)) G EX
 I IOST'?1"C".E W !!!!,?3,"**** NOW PROCEEDING WITH THE MERGE ****" W @IOF S DIACT="P" D ACT^DITC3 G EX
 I X=U D ASK^DITC3 G EX
 W ! D @($P("ASK",U,'$O(^UTILITY($J,"DIT",U,0)))_"^DITC3")
EX X $G(^%ZIS("C")) G END^DITC
 Q
D0 ;
 I '$D(^DD(DFF(J+1\2),.001,0)) S K=K_",0)" Q:'$D(@K)  S Y=^(0),Y=$P(Y,U,1) Q:'$L(Y)  S C=^DD(DFF(J+1\2),.01,0) G D01
 S Y=$P($P(DTO(I),DIC,2),",",1),C=^DD(DFF(J+1\2),.001,0)
D01 S O=$P(C,U,1),C=$P(C,U,2) D Y^DIQ S $P(DHD(J\2+1),U,I)=Y
 Q
QUE ;
 K Y,K,L,M,N,I,X,X1,C,DDSP,DMSG
 S DJ=0,DHD="COMPARE OF "_DFL(1)_" FILE" D ^DIP4 G END^DITC
 Q
DQ ;
 D NOW^%DTC S DT=X K %,%I G COMP
