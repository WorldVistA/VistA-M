PSSRXACT ;BIR/SAB- returns active Rx flag ; 09/04/03 10:30 am
 ;;1.0;PHARMACY DATA MANAGEMENT;**75**;9/30/97
 ;External reference to EN^PSOORDER supported by DBIA 1878
 ;
EN(DFN) ;
 N FLAG,EXPD,RX,STAT S EXPD=DT-1
 F  S EXPD=$O(^PS(55,DFN,"P","A",EXPD)) Q:'EXPD!($G(FLAG))  F RX=0:0 S RX=$O(^PS(55,DFN,"P","A",EXPD,RX)) Q:'RX!($G(FLAG))  D
 .D EN^PSOORDER(DFN,RX)
 .I $G(^TMP("PSOR",$J,RX,0))']"" Q
 .S STAT=$P($P(^TMP("PSOR",$J,RX,0),"^",4),";")
 .S FLAG=$S(STAT="A":1,STAT="N":1,STAT="H":1,STAT="S":1,1:0)
 .K ^TMP("PSOR",$J)
 Q +$G(FLAG)
