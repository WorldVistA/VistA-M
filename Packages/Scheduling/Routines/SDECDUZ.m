SDECDUZ ;ALB/TAW - Return DUZ data ;Jan 7, 2022
 ;;5.3;Scheduling;**803,804,805**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; ICR
 ; Reference to ^DIC(4, in #2251
 ; Reference to ^XTV(8989.3,1,XUS in #1518
 Q
DUZSTATIONID(RETURN) ;
 N STATIONID,DATA
 ;#804 change from DUZ(2) to station ID for the default institution
 S STATIONID=$$DEFAULTSTATION()
 I STATIONID'="" S DATA("Station_ID")=STATIONID
 E  S DATA("Error",1)="Default Institution not defined"
 D ENCODE^SDESJSON(.DATA,.RETURN)
 Q
DEFAULTSTATION() ;
 N INST,STATION
 S STATION=""
 S INST=$$GET1^DIQ(8989.3,1,217,"I")  ;default inst
 I INST'="" S STATION=$$GET1^DIQ(4,INST,99,"I")  ;station num
 Q STATION
