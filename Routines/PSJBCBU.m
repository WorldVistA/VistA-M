PSJBCBU ;BIR/LDT-RETURN INFORMATION FOR AN ORDER IN HL7 FORMAT FOR BCMA CONTINGENCY PLAN;16 Mar 99 / 10:59 AM
 ;;5.0; INPATIENT MEDICATIONS ;**102**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^%DTC is supported by DBIA 10000.
 ; Usage of this routine by BCMA BACKUP Software is supported by DBIA 3876.
 ;
EN(DFN,ON,PSJNAME)         ; return detail data for Inpatient Meds.
 ;Input
 ;               DFN - Patient's IEN
 ;               ON - Order number for patient including "U" for Unit Dose, "V" for IV, and "P" for pending orders
 ;               PSJNAME - Array name to return information in
 N PSJBCBU S PSJBCBU=1
 I $G(ON)["U",$D(^PS(55,+$G(DFN),5,+ON,0)) D EN1^PSJHL2(DFN,"XX",ON)
 I $G(ON)["V",$D(^PS(55,+$G(DFN),"IV",+ON,0)) D EN1^PSJHL2(DFN,"XX",ON)
 I $G(ON)["P",$D(^PS(53.1,+ON,0)),$P($G(^PS(53.1,+ON,0)),"^",15)=DFN D EN1^PSJHL2(DFN,"XX",ON)
 I '$D(PSJNAME) S PSJNAME(0)=-1
 K ^TMP("PSJHLS",$J,"PS")
 Q
 ;
EN2(DFN,BDT)         ; return condensed list of inpat meds
 K ^TMP("PSJBU",$J)
 NEW FON,ON,WBDT,Y,%
 D:+$G(DFN) ORDER
 I '$D(^TMP("PSJBU",$J,1,0)) S ^(0)=-1
 K PSJINX
 Q
ORDER ;Loop thru the orders.
 I '+$G(BDT) D NOW^%DTC S BDT=%
 I BDT'["." S BDT=BDT_".0001"
 S PSJINX=0
 ;* U/D orders
 S WBDT=BDT
 F  S WBDT=$O(^PS(55,DFN,5,"AUS",WBDT)) Q:'WBDT  D
 . F ON=0:0 S ON=$O(^PS(55,DFN,5,"AUS",WBDT,ON)) Q:'ON  S FON=ON_"U" D TMP
 ;* IV orders
 S WBDT=BDT
 F  S WBDT=$O(^PS(55,DFN,"IV","AIS",WBDT)) Q:'WBDT  D
 . F ON=0:0 S ON=$O(^PS(55,DFN,"IV","AIS",WBDT,ON)) Q:'ON  S FON=ON_"V" D TMP
 ;* Pending orders
 F PST="P","N" F ON=0:0 S ON=$O(^PS(53.1,"AS",PST,DFN,ON)) Q:'ON  D
 . S FON=ON_"P" D TMP
 Q
 ;
TMP ;* Setup ^TMP that have common fields between IV and U/D
 S PSJINX=PSJINX+1
 S ^TMP("PSJBU",$J,PSJINX,0)=DFN_U_+ON_U_FON
 Q
