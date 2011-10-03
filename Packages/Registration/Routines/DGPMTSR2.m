DGPMTSR2 ;ALB/LM - TREATING SPECIALTY REPORT SET ; 3/1/93
 ;;5.3;Registration;;Aug 13, 1993
 ;
A ; This will set ^TMP("TSR")  = TREATING SPECIALTY TOTALS
 ;               ^TMP("TSRS") = SERVICE TOTALS
 ;               ^TMP("TSRD") = DIVISION TOTALS
 ;               ^TMP("TSRG") = GRAND TOTAL
 Q
 ;
START ;  Pats Remaining (Previous Date)
 S $P(^TMP("TSR",$J,D,S,ORDER,TS),"^",2)=+$P(CN1,"^",2)
 S $P(^TMP("TSRS",$J,D,S),"^",2)=$P(^TMP("TSRS",$J,D,S),"^",2)+$P(CN1,"^",2)
 S $P(^TMP("TSRD",$J,D),"^",2)=$P(^TMP("TSRD",$J,D),"^",2)+$P(CN1,"^",2)
 S $P(^TMP("TSRG",$J),"^",2)=$P(^TMP("TSRG",$J),"^",2)+$P(CN1,"^",2)
 ;
GAINS ;  Gains Total Cum (new) - Gains Total Cum (previous)
 S $P(^TMP("TSR",$J,D,S,ORDER,TS),"^",3)=$P(CN,"^",28)-$P(CN1,"^",28)
 S $P(^TMP("TSRS",$J,D,S),"^",3)=$P(^TMP("TSRS",$J,D,S),"^",3)+$P(CN,"^",28)-$P(CN1,"^",28)
 S $P(^TMP("TSRD",$J,D),"^",3)=$P(^TMP("TSRD",$J,D),"^",3)+$P(CN,"^",28)-$P(CN1,"^",28)
 S $P(^TMP("TSRG",$J),"^",3)=$P(^TMP("TSRG",$J),"^",3)+$P(CN,"^",28)-$P(CN1,"^",28)
 ;
LOSSES ; losses (new) - losses (previous)
 S $P(^TMP("TSR",$J,D,S,ORDER,TS),"^",4)=$P(CN,"^",24)-$P(CN1,"^",24)
 S $P(^TMP("TSRS",$J,D,S),"^",4)=$P(^TMP("TSRS",$J,D,S),"^",4)+$P(CN,"^",24)-$P(CN1,"^",24)
 S $P(^TMP("TSRD",$J,D),"^",4)=$P(^TMP("TSRD",$J,D),"^",4)+$P(CN,"^",24)-$P(CN1,"^",24)
 S $P(^TMP("TSRG",$J),"^",4)=$P(^TMP("TSRG",$J),"^",4)+$P(CN,"^",24)-$P(CN1,"^",24)
 ;
CURRENT ;  Patients Remaining
 S $P(^TMP("TSR",$J,D,S,ORDER,TS),"^",5)=+$P(CN,"^",2)
 S $P(^TMP("TSRS",$J,D,S),"^",5)=$P(^TMP("TSRS",$J,D,S),"^",5)+$P(CN,"^",2)
 S $P(^TMP("TSRD",$J,D),"^",5)=$P(^TMP("TSRD",$J,D),"^",5)+$P(CN,"^",2)
 S $P(^TMP("TSRG",$J),"^",5)=$P(^TMP("TSRG",$J),"^",5)+$P(CN,"^",2)
 ;
PASS S $P(^TMP("TSR",$J,D,S,ORDER,TS),"^",6)=+$P(CN(1),"^",5)
 S $P(^TMP("TSRS",$J,D,S),"^",6)=$P(^TMP("TSRS",$J,D,S),"^",6)+$P(CN(1),"^",5)
 S $P(^TMP("TSRD",$J,D),"^",6)=$P(^TMP("TSRD",$J,D),"^",6)+$P(CN(1),"^",5)
 S $P(^TMP("TSRG",$J),"^",6)=$P(^TMP("TSRG",$J),"^",6)+$P(CN(1),"^",5)
 ;
AA S $P(^TMP("TSR",$J,D,S,ORDER,TS),"^",7)=+$P(CN(1),"^",6)
 S $P(^TMP("TSRS",$J,D,S),"^",7)=$P(^TMP("TSRS",$J,D,S),"^",7)+$P(CN(1),"^",6)
 S $P(^TMP("TSRD",$J,D),"^",7)=$P(^TMP("TSRD",$J,D),"^",7)+$P(CN(1),"^",6)
 S $P(^TMP("TSRG",$J),"^",7)=$P(^TMP("TSRG",$J),"^",7)+$P(CN(1),"^",6)
 ;
UA S $P(^TMP("TSR",$J,D,S,ORDER,TS),"^",8)=+$P(CN(1),"^",7)
 S $P(^TMP("TSRS",$J,D,S),"^",8)=$P(^TMP("TSRS",$J,D,S),"^",8)+$P(CN(1),"^",7)
 S $P(^TMP("TSRD",$J,D),"^",8)=$P(^TMP("TSRD",$J,D),"^",8)+$P(CN(1),"^",7)
 S $P(^TMP("TSRG",$J),"^",8)=$P(^TMP("TSRG",$J),"^",8)+$P(CN(1),"^",7)
 ;
ASIH S $P(^TMP("TSR",$J,D,S,ORDER,TS),"^",9)=+$P(CN(1),"^",8)
 S $P(^TMP("TSRS",$J,D,S),"^",9)=$P(^TMP("TSRS",$J,D,S),"^",9)+$P(CN(1),"^",8)
 S $P(^TMP("TSRD",$J,D),"^",9)=$P(^TMP("TSRD",$J,D),"^",9)+$P(CN(1),"^",8)
 S $P(^TMP("TSRG",$J),"^",9)=$P(^TMP("TSRG",$J),"^",9)+$P(CN(1),"^",8)
 ;
ADC S $P(^TMP("TSR",$J,D,S,ORDER,TS),"^",10)=ADC("P")
 S $P(^TMP("TSRS",$J,D,S),"^",10)=ADC("S")
 S $P(^TMP("TSRD",$J,D),"^",10)=ADC("D")
 S $P(^TMP("TSRG",$J),"^",10)=ADC("G")
 ;
CUM S $P(^TMP("TSR",$J,D,S,ORDER,TS),"^",12)=BD("P")
 S $P(^TMP("TSRS",$J,D,S),"^",12)=BD("S")
 S $P(^TMP("TSRD",$J,D),"^",12)=BD("D")
 S $P(^TMP("TSRG",$J),"^",12)=BD("G")
 ;
 ; formats ADC number into comma output
COMMA S X=$P(^TMP("TSR",$J,D,S,ORDER,TS),"^",12) D COMMA^%DTC S $P(^TMP("TSR",$J,D,S,ORDER,TS),"^",11)=$P(X,".")
 S X=$P(^TMP("TSRS",$J,D,S),"^",12) D COMMA^%DTC S $P(^TMP("TSRS",$J,D,S),"^",11)=$P(X,".")
 S X=$P(^TMP("TSRD",$J,D),"^",12) D COMMA^%DTC S $P(^TMP("TSRD",$J,D),"^",11)=$P(X,".")
 S X=$P(^TMP("TSRG",$J),"^",12) D COMMA^%DTC S $P(^TMP("TSRG",$J),"^",11)=$P(X,".")
 ;
END Q
