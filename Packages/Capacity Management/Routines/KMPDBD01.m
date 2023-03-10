KMPDBD01 ;OAK/RAK/JML - CM Tools Background Driver ;6/1/2020
 ;;4.0;CAPACITY MANAGEMENT;**1**;Jan 15, 2013;Build 27
 ;
EN ;-entry point for background driver
 ;
 S:'$G(DT) DT=$$DT^XLFDT
 ;
 N DAILY,STR
 ;
 ; update cpu data in file #8973 (CP PARAMETERS)
 D CPUSET^KMPDUTL6(1)
 ;
 ; hl7
 ;compile and store daily stats in file 8973.1 (CM HL7 DATA)
 ; NOTE: HL7 data sent via VSM nightly job
 ;S STR=$$NOW^XLFDT,DAILY=$$FMADD^XLFDT(DT,-1)
 ;D DAILY^KMPDHU02(DAILY,DAILY)
 ; store start, stop and delta times for daily background job
 ;D STRSTP^KMPDUTL2(3,1,1,STR)
 ;
 ; timing
 ; send raw numbers to CPE database
 D ^KMPDRDAT
 ; compile and store timing stats in file 8973.2 (CP TIMING)
 S STR=$$NOW^XLFDT
 D DAILY^KMPDTU02
 ; store start, stop and delta times for daily background job
 D STRSTP^KMPDUTL2(4,1,1,STR)
 ;
 ; transmit 'yesterdays' daily stats to national database
 S STR=$$NOW^XLFDT,DAILY=$$FMADD^XLFDT(DT,-1)
 D DAILY^KMPDTU01(DAILY)
 ; store start, stop and delta times for daily background job
 D STRSTP^KMPDUTL2(4,2,1,STR)
 ;
 ;
 ; if sunday
 D:'$$DOW^XLFDT(DT,1) SUNDAY
 ;
 Q
 ;
SUNDAY ;-- weekly
 ;
 N STR
 ;
 S:'$G(DT) DT=$$DT^XLFDT
 ;
 ; hl7 - compress & transmit hl7 data to cm national
 ; database, and purge file #8973.1 (CM HL7 DATA) of old data
 S STR=$$NOW^XLFDT
 D WEEKLY^KMPDHU01(DT,1)
 ; store start, stop and delta times for weekly background job
 D STRSTP^KMPDUTL2(3,2,1,STR)
 ;
 ; purge entries from file 8973.2 (CP TIMING)
 S STR=$$NOW^XLFDT
 D PURGE1^KMPDUTL3
 D STRSTP^KMPDUTL2(4,2,2,STR)
 ;
 Q
