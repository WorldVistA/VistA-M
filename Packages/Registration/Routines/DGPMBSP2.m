DGPMBSP2 ;ALB/LM - BSR PRINT, CONT.; 17 OCT 90 ; 1/13/05 3:48pm
 ;;5.3;Registration;**59,592,641**;Aug 13, 1993
 ;
A S BD=1 S BD("DY")=BD("OSD") ;(BD*BD("M")) ;  Total Elapsed Fiscal Days * Bed Days Multipler
 S ^UTILITY("DGWBD",$J,+ORDER)=BD("DY")_"^"_BD("S")_"^"_BD("D")_"^"_BD("CB") ;  Total Elapsed Fiscal Days * Bed Days Multipler_^_Include Stat's_^_Display on BSR_^_Cum Beds
 Q:'BD("S")  ; Include Stat's
 ;
CENSUS S X=$S($D(^DG(41.9,W,"C",RD,0)):^(0),1:"") ;  Census File 0 Node (Report Date) NEW NODE
 S ^UTILITY("DGWNN",$J,ORDER)=X ;  Census File 0 Node (Report Date) NEW NODE
 S ^UTILITY("DGWON",$J,ORDER)=$S($D(^DG(41.9,W,"C",FY("L"),0)):^(0),1:"") ;  Census File 0 Node (last fiscal year) OLD NODE
 S X(1)=$S($D(^DG(41.9,W,"C",RD,1)):^(1),1:"") ;  Census File 1 Node (Report Date)
 S X1=$S($D(^DG(41.9,W,"C",PD,0)):^(0),1:"") ;  Census File 0 Node (Previous Date)
 S:$E(PD,4,7)="0930" X1="^"_$P(X1,"^",2) ; Pats Remaining
 ;
PM S BD("PM")=$S($D(^DG(41.9,W,"C",FY("EOM"),0)):+$P(^(0),"^",3),1:0) ;  Cum Pat Days of Care
 S:$E(FY("EOM"),4,7)="0930" BD("PM")=0
 ;
N ;  BD("N") = BSR Display Stat's Node  ;  $P(1,2)=Name of Ward^Bed Section
 S $P(BD("N"),"^",3)=+$P(X1,"^",2) ;  Pats Remaining (Previous Date)
 S $P(BD("N"),"^",4)=$P(X,"^",28)-$P(X1,"^",28) ;  Gains Total Cum (new) - Gains Total Cum (previous)
 S $P(BD("N"),"^",5)=$P(X,"^",24)-$P(X1,"^",24) ; losses (new) - losses (previous)
 S $P(BD("N"),"^",6)=+$P(X,"^",2) ;  Pats Remaining
 S $P(BD("N"),"^",7)=+$P(X(1),"^",5) ;  AA<96
 S $P(BD("N"),"^",8)=+$P(X(1),"^",6) ;  AA
 S $P(BD("N"),"^",9)=+$P(X(1),"^",7) ;  UA
 S $P(BD("N"),"^",10)=+$P(X(1),"^",8) ;  ASIH
 ;
BEDS S BD("DOS")=+$P(X(1),"^",9) ;  Beds OOS
 S BD("AB")=+$P(X(1),"^",10) ;  Auth Beds
 S X(2)=(BD("AB")-BD("DOS")) ;  Auth Beds - Bed OOS
 S $P(BD("N"),"^",11)=$S(BD("AB")&($P(X,"^",2)'>X(2)):(BD("AB")-($P(X,"^",2)+BD("DOS"))),1:0) ;  AB=Auth Bed - Pat Remaining + Beds OOS = Vacant Beds
 S $P(BD("N"),"^",12)=+BD("DOS") ;  Beds OOS
 S $P(BD("N"),"^",13)=$P(X(1),"^",2) ; Operation Beds
 S $P(BD("N"),"^",14)=$S($P(X,"^",2)'>X(2):0,1:$P(X,"^",2)-X(2)) ; Pats Remaining greater than Auth Bed - Bed OOS = Over Cap Beds
 S $P(BD("N"),"^",15)=BD("AB") ; AB=Auth Bed
 ;
ADC S BD("P")=+$P(X,"^",3) ;  Cum Pat Days of Care (new)
 ;S X(2)=(BD("P")/FY("D")) ;  Cum Pat Days of Care/Days into Fiscal Year (Cum Ave Daily Census)
 S X(2)=$S(FY("D")-BD("OSD"):BD("P")/(FY("D")-BD("OSD")),1:0) ;  Pat Days/Total Elapsed Fiscal Days - days OOS (Cum ADC*)
 S X(3)=(BD("P")*100) ;  Cum Pat Days of Care * 100
 ;
 S BD("OR")=$S(BD("CB")>0:(X(3)/BD("CB")),1:0) ;  Cum Beds >0 then Pat Days of Care * 100 divided by Cum Beds (Cum Occ. Rate)
 S $P(BD("N"),"^",16)=$J(X(2),0,1) ;  Cum ADC
 S $P(BD("N"),"^",17)=$J(BD("OR"),0,1)_"%" ;  Cum Occ. Rate
 S $P(BD("N"),"^",18)=BD("P") ;  Cum Pat Days of Care (new) ADC
 ;
OOS ; OOS stats
 S X(2)=$S(FY("D")-BD("OSD"):BD("P")/(FY("D")-BD("OSD")),1:0) ;  Pat Days/Total Elapsed Fiscal Days - days OOS (Cum ADC*)
 S X(3)=(BD("P")*100) ;  Pat Days * 100
 ; *Occ Rate is *ADC multiplied by 100 divided by FYTD-OOS days
 S BD("OOR")=$S(BD("CB")>0:(X(3)/BD("CB")),1:0) ;  Cum Beds >0 then Pat Days of Care * 100 divided by Cum Beds (Cum Occ. Rate*)
 ;
NODE S ^UTILITY("DGWOR",$J,ORDER)=BD("N") ;  BSR Display Stat's Node
 S ADC=+BD("P")_"^"_(+BD("P")-(BD("PM"))) ; Cum Pat Days of Care new ADC _^_ Cum Pat Days of Care new ADC _^_ Cum Pt Day of Care FY
 F X=1:1:2 S $P(ADC(BD("DV"),BD("ADC")),"^",X)=$P(ADC(BD("DV"),BD("ADC")),"^",X)+$P(ADC,"^",X) ;  BD("DV") = Division  BD("ADC") = Service Type
 S X=^UTILITY("DGWPL",$J,BD("PL")) ;  BD("PL") = Primary Location
 F I=3:1:15,18 S $P(X,"^",I)=$P(X,"^",I)+$P(BD("N"),"^",I)
 ;
SET S ^UTILITY("DGWPL",$J,BD("PL"))=X ;  Ward totals
 S X=^UTILITY("DGWPLT",$J,BD("PL"))
 S $P(X,"^")=$P(X,"^")+1
 S $P(X,"^",2)=$P(X,"^",2)+BD("DY") ;  Total elasped fiscal days * bed day multipler
 S $P(X,"^",3)=$P(X,"^",3)+BD("CB") ; Cum beds
 S ^UTILITY("DGWPLT",$J,BD("PL"))=X ;  Total of wards _^_ Total elapsed fiscal days * bed days multipler _^_ Cum bed
Q Q
