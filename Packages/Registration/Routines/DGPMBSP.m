DGPMBSP ;ALB/LM - BSR PRINT; 12 JUNE 90
 ;;5.3;Registration;**12,134**;Aug 13, 1993
 ;
A D TAB
 D ^DGPMBSP1
 ;  D ^DGPMBSP2  ;  called in ^DGPMBSP1
 D HEAD,HEAD2
 D ^DGPMBSP3
 D HEAD
 D ^DGPMBSP4
 D ^DGPMBSP5
 D ^DGPMBSP6
 ;
 W !,"TOTAL ELAPSED FISCAL DAYS:  ",$J(FY("D"),3)
 W !,"TOTAL ELAPSED MONTH DAYS :  ",$J(FY("DIM"),3),!
 S X=$S($D(IOSL):IOSL,1:60),X=$Y-X
 F I=1:1:4 Q:I=2&(X<3)  W !
 W ?98 F I=1:1:33 W UL
 W !?84,"Prepared by:  ADMINISTRATIVE OFFICER OF THE DAY",!
 ;
 K ADC,AT,C,CT,CUM,D,D1,I,I1,J,J1,K,L,X,X1,X2
Q Q
 ;
HEAD I $D(FF) W @IOF
 S FF=2
 W !?94,"Date/Time Printed: ",DGNOW
 W !?RM-22\2,"BED STATUS REPORT"
 S X=$$NAME^VASITE(RD)
 I X']"" D
 .S X="VA MEDICAL CENTER"
 .S:$D(^DG(40.8,+$P(DGPM("GL"),"^",3),0)) X=X_", "_$P(^(0),"^")
 W !?RM-$L(X)\2,X
 S X=RD
 D DW^%DTC
 S X1=X,X="PERIOD ENDING MIDNIGHT "_X1_", "
 S Y=RD X ^DD("DD") S X=X_Y
 W !?RM-$L(X)\2,X,!
 K X,X1,Y
 Q
 ;
HEAD2 W !,?71,"Va-",?92,"Over",?116,"Cum",?127,"Cum"
 W !?10,"Bed",?21,"Prev",?39,"Pt's",?71,"cant",?78,"Beds",?85,"Oper",?92,"Cap.",?100,"Auth",?108,"Cum",?116,"Occ.",?123,"Patient"
 W !?2,"Ward",?10,"Section",?21,"Rem.",?27,"Gain",?33,"Loss",?39,"Rem.",?45,"Pass",?53,"AA",?59,"UA",?64,"ASIH",?71,"Beds",?79,"OOS",?85,"Beds",?92,"Beds",?100,"Beds",?108,"ADC",?116,"Rate",?126,"Days"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 K L
 Q
 ;
TAB S TAB="1^10^21^27^33^39^45^52^58^64^71^78^85^92^100^105^113^123"
 S JUS="0^0^4^4^4^4^4^3^3^4^4^4^4^4^4^6^7^7"
 Q
