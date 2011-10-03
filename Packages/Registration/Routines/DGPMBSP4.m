DGPMBSP4 ;ALB/LM - BSR PRINT, CONT.; 13 JUNE 90 ; 1/13/05 3:48pm
 ;;5.3;Registration;**592,641**;Aug 13, 1993
 ;
A Q:'PL
 ;
 S X="T O T A L S   B Y   P R I M A R Y   W A R D   L O C A T I O N"
 ;
 W ! W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 W !?0,"|",?(RM-$L(X)\2),X,?130,"|"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 ;
HEAD2 W !?0,"|",?71,"Va-",?92,"Over",?116,"Cum",?127,"Cum|"
 W !?0,"|",?2,"Primary",?21,"Prev",?39,"Pt's",?71,"cant",?78,"Beds",?85,"Oper",?92,"Cap.",?100,"Auth",?108,"Cum",?116,"Occ.",?123,"Patient|"
 W !?0,"|",?2,"Location",?21,"Rem.",?27,"Gain",?33,"Loss",?39,"Rem.",?45,"Pass",?53,"AA",?59,"UA",?64,"ASIH",?71,"Beds",?79,"OOS",?85,"Beds",?92,"Beds",?100,"Beds",?108,"ADC",?116,"Rate",?126,"Days|"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 ;
 S I=0 F I1=0:0 S I=$O(^UTILITY("DGWPL",$J,I)) Q:I=""  S X=^(I),X1=$S($D(^UTILITY("DGWPLT",$J,I)):^(I),1:0) D WR
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 K I,I1,X1,L
HEAD2Q Q
 ;
WR W !?0,"|",I
 S $P(X,"^",11)=$S(+$P(X,"^",13)>+$P(X,"^",6):($P(X,"^",13)-$P(X,"^",6)),1:0) ; Vacant Beds = Operating Beds - Patients Remaining
 S $P(X,"^",14)=$S(+$P(X,"^",6)>+$P(X,"^",13):($P(X,"^",6)-$P(X,"^",13)),1:0) ; Overcapacity = Patients Remaining - Operating Beds
 F N=3:1:15 W ?+$P(TAB,"^",N),$J($P(X,"^",N),+$P(JUS,"^",N))
 S X(16)=($P(X,"^",18)/FY("D"))
 S X2=$P(X1,"^",3)/FY("D")
 S X(17)=$S(X2'>0:0,1:((X(16)*100)/X2))
 S X(16)=$J(X(16),0,1)
 S X(17)=$J(X(17),0,1)_"%"
 S X(18)=+$P(X,"^",18)
 S X2=$P(X1,"^",2)/$P(X1,"^")
 F N=16:1:18 W ?+$P(TAB,"^",N),$J(X(N),$P(JUS,"^",N))
 W ?30,"|"
WRQ Q
