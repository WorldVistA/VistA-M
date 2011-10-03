DGPMTSR1 ;ALB/LM - TREATING SPECIALTY REPORT VARIABLES ; 3/1/93
 ;;5.3;Registration;;Aug 13, 1993
 ;
A ; This will set up variables used in ^TMP
 Q
 ;
START S TS=$O(^DG(40.8,"ATS",D,ORDER,0)) ; Treating Specialty
 S S=$P(^DIC(45.7,TS,0),"^",2) ;  Pointer to Specialty File
 S S=$P(^DIC(42.4,S,0),"^",3) ;  Service Set of Codes
 S SV=$S(S="M":"MEDICINE",S="S":"SURGERY",S="P":"PSYCHIATRY",S="NH":"NHCU",S="NE":"NEUROLOGY",S="I":"INTERMEDIATE MED",S="R":"REHAB MEDICINE",S="SCI":"SPINAL CORD INJURY",S="D":"DOMICILIARY",S="B":"BLIND REHAB",S="RE":"RESPITE CARE",1:"")
 ;
TOTALS I '$D(^TMP("TSRG",$J)) S ^TMP("TSRG",$J)="GRAND TOTAL",BD("G")=0
 I '$D(^TMP("TSRD",$J,D)) S ^TMP("TSRD",$J,D)=$P(^DG(40.8,D,0),"^")_" TOTALS" S BD("D")=0 ; Division Name
 I '$D(^TMP("TSRS",$J,D,S)) S ^TMP("TSRS",$J,D,S)=SV_" TOTALS" S BD("S")=0 ; Service Name
 S ^TMP("TSR",$J,D,S,ORDER,TS)=$P(^DIC(45.7,TS,0),"^") ; Treating Specialty Name
 ;
NODES S CN=$S($D(^DG(40.8,D,"TS",TS,"C",RD,0)):^(0),1:"") ;  TS Census 0 Node
 S CN(1)=$S($D(^DG(40.8,D,"TS",TS,"C",RD,1)):^(1),1:"") ;  TS Census 1 Node
 S CN1=$S($D(^DG(40.8,D,"TS",TS,"C",PD,0)):^(0),1:"") ;  TS Census 0 Node (Previous Date)
 ;
 S:$E(PD,4,7)="0930" CN1="^"_$P(CN1,"^",2) ;  NO cumulative totals if beginning of FY
 I RD=TSRI S CN1="^"_$S($D(^DG(40.8,D,"TS",TS,0)):$P(^DG(40.8,D,"TS",TS,0),"^",3),1:0) ; Utilize whats in beginning TSR Patients on TSR Initialization Date
 ;
 S X2=$S(+$E(RD,4,5)<10:+$E(RD,1,3)-1,1:$E(RD,1,3))_"0930" ; Place holder for FY
 S X1=RD D ^%DTC S FY("D")=+X ;  Total Elapsed Fiscal Days
 ;
DAYS ;  Cum Pat Days of Care (new)
 S BD("P")=$P(CN,"^",3)
 S BD("S")=($P(^TMP("TSRS",$J,D,S),"^",12))+($P(CN,"^",3))
 S BD("D")=($P(^TMP("TSRD",$J,D),"^",12))+($P(CN,"^",3))
 S BD("G")=($P(^TMP("TSRG",$J),"^",12))+($P(CN,"^",3))
 ;
ADC ;  Cum Ave Daily Census
 S ADC("P")=$J((BD("P")/FY("D")),0,1)
 S ADC("S")=$J((BD("S")/FY("D")),0,1)
 S ADC("D")=$J((BD("D")/FY("D")),0,1)
 S ADC("G")=$J((BD("G")/FY("D")),0,1)
END Q
