PSSP153 ;BIRM/SJA-Pharmacy system site parameters ;03/24/10
 ;;1.0;PHARMACY DATA MANAGEMENT;**153**;9/30/97;Build 32
 ;
 Q
POST ; set the USE DOSAGE FORM MED ROUTE LIST field to YES for sites that have the 
 ; DEFAULT MED ROUTE FOR CPRS field (#80.7) of the PHARMACY SYSTEM file (#59.7) set to NO. 
 ; Otherwise, the USE DOSAGE FORM MED ROUTE LIST field is set to NO.
 N PSSVAL,PSSIEN
 S PSSVAL=$P($G(^PS(59.7,1,80)),"^",7)
 S PSSIEN=0 F  S PSSIEN=$O(^PS(50.7,PSSIEN)) Q:'PSSIEN  I $D(^(PSSIEN,0)) D
 .S $P(^PS(50.7,PSSIEN,0),"^",13)=$S($G(PSSVAL)=1:"N",1:"Y")
 Q
