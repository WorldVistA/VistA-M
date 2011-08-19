PSSMSTR ;BIR/PWC-Send Master Drug File to External Interface ;04/05/04
 ;;1.0;PHARMACY DATA MANAGEMENT;**82**;09/30/97
 ;Reference to ^PS(59 supported by IA # 1976
 ;
 ;This routine will walk through the Drug file and send all drugs
 ;to each dispensing machine for each outpatient site file.
 ;It will only send to each site that has a dispensing machine running
 ;HL7 V.2.4 and has the Master File Update enabled.
 ;Task this job out
 ;
 S ZTRTN="BUILD^PSSMSTR",ZTDESC="MASTER DRUG FILE UPDATE",ZTIO=""
 S ZTDTH=$H D NOW^%DTC S PSSDTM=% D ^%ZTLOAD
 Q
 ;
BUILD N XX,DVER,DMFU,DNSNAM,DNSPORT
 F XX=0:0 S XX=$O(^PSDRUG(XX)) Q:'XX  D
 . F YY=0:0 S YY=$O(^PS(59,YY)) Q:'YY  D
 .. S DVER=$$GET1^DIQ(59,YY_",",105,"I") Q:DVER'="2.4"  ;HL7 2.4
 .. S DMFU=$$GET1^DIQ(59,YY_",",105.2) Q:DMFU'="YES"    ;enable MFU
 .. S DNSNAM=$$GET1^DIQ(59,YY_",",2006)    ;DNS name of dispense machine
 .. S DNSPORT=$$GET1^DIQ(59,YY_",",2007)   ;Port # of dispense machine
 .. I DNSNAM'="" D DRG^PSSDGUPD(XX,"NEW",DNSNAM,DNSPORT)
 K XX,YY,DVER,DMFU,DNSNAM,DNSPORT
 Q
