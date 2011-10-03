PSOPXRM1 ;BHAM ISC/MR - Returns Patient's Prescription info ;10/16/09  15:07
 ;;7.0;OUTPATIENT PHARMACY;**118,344**;DEC 1997;Build 2
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to ^PSDRUG( supported by DBIA 221
 ; 
NVA(DAS,DATA) ;Return data on non-VA meds.
 N EM,IND1,IND2,IND3,IND4,TEMP,TEMP1
 S IND1=$P(DAS,";",1),IND2=$P(DAS,";",2),IND3=$P(DAS,";",3),IND4=$P(DAS,";",4)
 S TEMP=^PS(55,IND1,IND2,IND3,IND4)
 S TEMP1=^PS(50.7,$P(TEMP,U,1),0)
 S DATA("ORDERABLE ITEM")=$P(TEMP1,U,1)
 S DATA("DOSAGE FORM")=^PS(50.606,$P(TEMP1,U,2),0)
 S DATA("DISPENSE DRUG")=$P(TEMP,U,2)
 S DATA("DOSAGE")=$P(TEMP,U,3)
 S DATA("MEDICATION ROUTE")=$P(TEMP,U,4)
 S DATA("SCHEDULE")=$P(TEMP,U,5)
 S TEMP1=$P(TEMP,U,6)
 S DATA("STATUS")=$S(TEMP1="":"ACTIVE",1:$$EXTERNAL^DILFD(55.05,5,"",TEMP1,.EM))
 S DATA("DISCONTINUED DATE")=$P(TEMP,U,7)
 S DATA("ORDER NUMBER")=$P(TEMP,U,8)
 S DATA("START DATE")=$P(TEMP,U,9)
 S DATA("DOCUMENTED DATE")=$P(TEMP,U,10)
 S DATA("DOCUMENTED BY")=$P(TEMP,U,11)
 S DATA("CLINIC")=$P(TEMP,U,12)
 Q
 ;
 ;====================================================
PSRX(DAS,RXAR) ; Returns Rx Information
 ; Input:  DAS  - String containing the ^PSRX location where the data
 ;                is located, separated by ";" (semi-colon).
 ;                Example: "329832;1;1;0" -> ^PSRX(329832,1,1,0)
 ;Output: .RXAR - Array/Global to be returned with the Rx Info (by Ref)
 ;                Return:  RXAR(Field Name)=Internal Value^External
 ;                                          Value (when applicable)
 ;
 N SB1,SB2,SB3,I,DA
 ;
 ; - Retrieving ^PSRX subscripts
 F I=1:1:3 S @("SB"_I)=$P(DAS,";",I)
 ;
 ; - Call appropriate sub-routine (Original, Refill or Partial)
 S DA=SB1 K RXAR D @($S(SB3="":"ORIG",SB2'="P":"REFL",1:"PRTL"))
 ;
 ; - Retrieve common fields
 N NODE0,RXCLIN
 S NODE0=$G(^PSRX(DA,0))
 S RXAR("STATUS")=+$G(^PSRX(DA,"STA"))
 S RXAR("ISSUE DATE")=+$P(NODE0,U,13)
 S RXAR("LAST DISPENSED DATE")=+$G(^PSRX(DA,3))
 S RXCLIN=+$P(NODE0,U,5)
 I RXCLIN S RXAR("CLINIC")=RXCLIN_U_$$GET1^DIQ(52,DA,5)
 S RXAR("PROVIDER")=$P(NODE0,U,4)_U_$$GET1^DIQ(52,DA,4)
 S RXAR("DISPENSE DRUG")=$P(NODE0,U,6)_U_$$GET1^DIQ(52,DA,6)
 S RXAR("DEA SPECIAL HDLG")=$P($G(^PSDRUG(+$P(NODE0,U,6),0)),U,3)
 ;
END Q
 ;
ORIG ; - Retrieve Original fields
 N RX0,RX2 S RX0=$G(^PSRX(DA,0)),RX2=$G(^PSRX(DA,2))
 S RXAR("DAYS SUPPLY")=$P(RX0,"^",8)
 S RXAR("PHARMACIST")=$S($P(RX2,"^",3):$P(RX2,"^",3)_U_$$GET1^DIQ(52,DA,23),1:"")
 S RXAR("RELEASED DATE/TIME")=$P(RX2,"^",13)
 S RXAR("QTY")=+$P(RX0,U,7)
 Q
 ;
REFL ; - Retrieve Refill fields
 N RF0 S RF0=$G(^PSRX(DA,1,SB3,0))
 S RXAR("DAYS SUPPLY")=$P(RF0,"^",10)
 S RXAR("PHARMACIST")=$S($P(RF0,"^",5):$P(RF0,"^",5)_U_$$GET1^DIQ(52.1,SB3_","_DA,4),1:"")
 S RXAR("RELEASED DATE/TIME")=$P(RF0,"^",18)
 S RXAR("QTY")=+$P(RF0,U,4)
 Q
 ;
PRTL ; - Retrieve Partial fields
 N PT0 S PT0=$G(^PSRX(DA,"P",SB3,0))
 S RXAR("DAYS SUPPLY")=$P(PT0,"^",10)
 S RXAR("PHARMACIST")=$S($P(PT0,"^",5):$P(PT0,"^",5)_U_$$GET1^DIQ(52.2,SB3_","_DA,.05),1:"")
 S RXAR("RELEASED DATE/TIME")=$P(PT0,"^",19)
 S RXAR("QTY")=+$P(PT0,U,4)
 Q
