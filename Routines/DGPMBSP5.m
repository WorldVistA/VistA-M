DGPMBSP5 ;ALB/LM - BSR PRINT, CONT.; 13 JUNE 90
 ;;5.3;Registration;;Aug 13, 1993
 ;
A Q:'AT
 ;
 S X="A V E R A G E    D A I L Y   C E N S U S   (ADC)"
 ;
 W ! W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 W !?0,"|",?(RM-$L(X)\2),X,?130,"|"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 W !?0,"|",?57,"|",?67,"Cumulative FYTD",?93,"||",?103,"Cumulative MONTH",?130,"|"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 W !?0,"|","DIVISION",?57,"|",?61,"Hospital|",?77,"NHCU|",?89,"Dom.||",?98,"Hospital|",?114,"NHCU|",?126,"Dom.|"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 S D=0
 F D1=0:0 S D=$O(ADC(D)) Q:D'>0  I $D(^DG(40.8,+D,0)) S X=^(0),X1=$S($D(^DG(40.8,+D,"CEN",RD,0)):^(0),1:0) D WADC
 K I,X,X1,X2,L
Q Q
 ;
WADC W !?0,"|",$E($P(X,"^"),1,30),?49,"Planned |",$J(+$P(X1,"^",4),11,1),"|",$J(+$P(X1,"^",2),11,1),"|",$J(+$P(X1,"^",10),11,1),"||",$J(+$P(X1,"^",3),11,1),"|",$J(+$P(X1,"^",11),11,1),"|",$J(+$P(X1,"^",12),11,1),"|"
 S X2=""
 F I=1:1:3 S X=$S($D(ADC(D,I)):ADC(D,I),1:0),$P(X2,"^",I)=+$P(X,"^"),$P(X2,"^",(I+3))=+$P(X,"^",2)
 W !?0,"|",?50,"ACTUAL |"
 F I=1:1:3 S X=$P(X2,"^",I)/FY("D") W $J(X,11,1),"|"
 W "|" F I=4:1:6 S X=$P(X2,"^",I)/FY("DIM") W $J(X,11,1),"|"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 Q
