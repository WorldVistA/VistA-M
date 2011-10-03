DGPMBSP3 ;ALB/LM - BSR PRINT, CONT.; 13 JUNE 90 ; 1/13/05 3:48pm
 ;;5.3;Registration;**59,85,529,592,641**;Aug 13, 1993
 ;
A S NTOTAL="",(ORDER,CW,CB,CUM,BD,CT)=0
 ;  ^UTILITY("DGWOR",$J,ORDER)=19 PIECE PRINT/STATS LINE
 F O1=0:0 S ORDER=$O(^UTILITY("DGWOR",$J,ORDER)) Q:ORDER'>0  S DGWOR=^(ORDER),BDAY=$S($D(^UTILITY("DGWBD",$J,ORDER)):^(ORDER),1:0) D WR
 K BD,BDAY,C,CB,CW,I,I1,L,N,N1,ORDER,O1,TL,W,X,X1,Y,T,T1,T2,T3,TN,TX,TY,DGWOR,DGWON,DGWNN,DGWTOR
Q Q
 ;
 ;  $P(BDAY,"^",3) = Display on BSR
WR I $P(BDAY,"^",3) W ! F W=1:1:18 W ?+$P(TAB,"^",W),$J($P(DGWOR,"^",W),$P(JUS,"^",W))
 ;  $P(BDAY,"^",2) = Include Stats
 I $P(BDAY,"^",2) D CUM F N1=3:1:15,18 S $P(NTOTAL,"^",N1)=$P(NTOTAL,"^",N1)+$P(DGWOR,"^",N1)
 Q:$O(^UTILITY("DGWTOR",$J,ORDER,0))'>0
 S TL=0
 ;  ^UTILITY("DGWTOR",$J,ORDER,TOTAL LEVEL)=TOTAL NAME ^ PRINT IN CUM TOTALS (ORDER TOTAL)
 F TL1=0:0 S TL=$O(^UTILITY("DGWTOR",$J,ORDER,TL)) Q:TL'>0  S DGWTOR=^(TL) D TL
 Q
 ;
CUM S CW=CW+1 ; Count Ward
 S CB=CB+$P(BDAY,"^",4) ;  Cum Beds
 S BD=BD+BDAY ; Total Elapsed Fiscal Days
 S DGWON=$S($D(^UTILITY("DGWON",$J,ORDER)):^(ORDER),1:0) ; Last year 0 Node for ward (Old Node)
 S DGWNN=$S($D(^UTILITY("DGWNN",$J,ORDER)):^(ORDER),1:0) ;  RD's 0 Node for Ward (New Node)
 S C=0
 F I=17,29,23,5,6,8,3 F I1=DGWON,DGWNN S C=C+1,$P(CUM,"^",C)=$P(CUM,"^",C)+$P(I1,"^",I)
 ; CUM=old cum adm^new cum adm^old IWT^new IWT^old cum inter svc xfrs in^new cum inter svc xfers in^old cum disch^new cum disch^old cum inter xfers^new cum inter xfers^old inter svc xfers^new inter svc xfers^old cum bed^new cum bed
 Q
 ;
TL S TC(TL,ORDER)=CUM
 S TL(TL,ORDER)=NTOTAL
 S TB(TL,ORDER)=BD_"^"_CW_"^"_CB ;  TOTAL ELAPSED FISCAL DAYS ^ COUNT WARD ^ CUM BED
 I TL=1 S W=NTOTAL,T2=ORDER D TWR Q
 S NTOTAL="",T=0
 F T1=0:0 S T=$O(TL(TL-1,T)) Q:T'>0!(T>ORDER)  S T2=T,TN=TL(TL-1,T),TX=TB(TL-1,T),TY=TC(TL-1,T) D MTL
 S:$P(DGWTOR,"^",2) CUM(T2,TL)=$P(DGWTOR,"^")_"^"_TC(TL,T2),CT=CT+1 ; CT=CUM TOTAL
 S CUM="",(W,TL(TL,T2))=NTOTAL D TWR
 Q
 ;
TWR N DGDNTD
 S DGDNTD=$S($P(DGWTOR,"^")["DON'T DISPLAY":1,1:0)
 I DGDNTD,TL=1 W:UL["-" ! F L=1:1:131 W UL
 I 'DGDNTD D
 .W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 .W !
 .D PTOT ; print line on BSR
 ; code below updates cums
 S (CB,BD,CW,NTOTAL)=""
 I $S('$P(DGWTOR,"^",2):1,TL'=1:1,1:0) S CUM="" Q
 S CUM(ORDER,TL)=$P(DGWTOR,"^")_"^"_CUM
 S CUM=""
 S CT=CT+1 ;  CUM TOTAL
 Q
 ;
PTOT ; Calc Vacant, Overcapacity Beds for Totals
 S $P(W,"^",11)=$S(+$P(W,"^",13)>+$P(W,"^",6):($P(W,"^",13)-$P(W,"^",6)),1:0) ; Vacant Beds = Operating Beds - Patients Remaining
 S $P(W,"^",14)=$S(+$P(W,"^",6)>+$P(W,"^",13):($P(W,"^",6)-$P(W,"^",13)),1:0) ; Overcapacity = Patients Remaining - Operating Beds
 W $P(DGWTOR,"^") ;  Total (level name)
 F I=3:1:15 W ?+$P(TAB,"^",I),$J($P(W,"^",I),$P(JUS,"^",I))
 S X(16)=($P(W,"^",18)/FY("D")) ; Cum Pat Days/Days into fiscal year
 S X(17)=$S($P(TB(TL,T2),"^",3)'>0:0,1:((X(16)*100)/($P(TB(TL,T2),"^",3)/FY("D")))) ;  ADC/(Cum Bed Total/Days into fiscal year)
 S X(16)=$J(X(16),0,1) ; Cum ADC
 S X(17)=$J(X(17),0,1)_"%" ; Cum Occ Rate
 S X(18)=$P(W,"^",18) ; Cum Pat Days
 F I=16:1:18 W ?+$P(TAB,"^",I),$J(X(I),$P(JUS,"^",I))
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 I $Y>$S($D(IOSL):(IOSL-5),1:61) D HEAD^DGPMBSP,HEAD2^DGPMBSP
 Q
 ;
MTL F N1=3:1:15,18 S $P(NTOTAL,"^",N1)=$P(NTOTAL,"^",N1)+$P(TN,"^",N1)
 S T3=$O(TB(TL,T))
 I T'>T3 S T2=T3
 F N1=1:1:3 S $P(TB(TL,T2),"^",N1)=$P(TB(TL,T2),"^",N1)+$P(TX,"^",N1)
 I $P(DGWTOR,"^",2) F N1=1:1:15 S $P(TC(TL,T2),"^",N1)=$P(TC(TL,T2),"^",N1)+$P(TY,"^",N1)
 K TC(TL-1,T),TL(TL-1,T),TB(TL-1,T),N1,T3
 Q
