PSSPRE38 ;BIR/RTR-Pre init routine ;04/03/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**38**;9/30/97
 ;
 N PSSSYS
 S PSSSYS=+$O(^PS(59.7,0))
 I $P($G(^PS(59.7,PSSSYS,80)),"^",3)'=3 W !!,"Dosage conversion is not complete, cannot install!",! S XPDABORT=2 Q
TIME ;
 N PSSTIMEZ
 K ^XTMP("PSSTIMEX")
 S X1=DT,X2=+30 D C^%DTC S PSSTIMEZ=$G(X)
 S ^XTMP("PSSTIMEX",0)=PSSTIMEZ_"^"_DT
 D NOW^%DTC S ^XTMP("PSSTIMEX","START")=%
 Q
