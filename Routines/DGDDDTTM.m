DGDDDTTM ;ALB/MRL,BAJ,TDM - TRIGGER DT/TM CROSS REFERENCES [PATIENT] ; 5/28/10 1:17pm
 ;;5.3;Registration;**665,653,688,754**;Aug 13, 1993;Build 46
 ;
 ; This routine contains the code for new style cross-reference record
 ; triggers for the PATIENT File #2.
 ;
TEMP ; PATIENT File #2 Record Index: ADTTM1
 ; 
 ; This code updates the TEMPORARY ADDRESS CHANGE DT/TM field when any 
 ; of the following Temporary Address related data changes for a patient:
 ;    
 ;    TEMPORARY STREET [LINE 1]    (#.1211)
 ;    TEMPORARY STREET [LINE 2]    (#.1212)
 ;    TEMPORARY STREET [LINE 3]    (#.1213)
 ;    TEMPORARY CITY               (#.1214)
 ;    TEMPORARY STATE              (#.1215)
 ;    TEMPORARY ZIP CODE           (#.1216)
 ;    TEMPORARY ADDRESS START DATE (#.1217)
 ;    TEMPORARY ADDRESS END DATE   (#.1218)
 ;    TEMPORARY ADDRESS ACTIVE?    (#.12105)
 ;    TEMPORARY ZIP+4              (#.12112)
 ;    TEMPORARY ADDRESS COUNTY     (#.12111)
 ;    TEMPORARY ADDRESS PROVINCE   (#.1221)
 ;    TEMPORARY ADDRESS POSTAL CODE (#.1222)
 ;    TEMPORARY ADDRESS COUNTRY     (#.1223)
 ;
 Q:$G(DGRONUPD)=1  ;Suppress update for ROM (set in routine DGROHLR1)
 N DGIEN,DATA S DATA(.12113)=$$NOW^XLFDT(),DGIEN=DA
 I $$UPD^DGENDBS(2,.DGIEN,.DATA)
 Q
 ;
CONF ; PATIENT File #2 Record Index: ADTTM2
 ;
 ; This code updates the CONFIDENTIAL ADDR CHANGE DT/TM field when any
 ; of the following Confidential Address related data changes for a
 ; patient:
 ;
 ;    CONFIDENTIAL STREET [LINE 1]  (#.1411)
 ;    CONFIDENTIAL STREET [LINE 2]  (#.1412)
 ;    CONFIDENTIAL STREET [LINE 3]  (#.1413)
 ;    CONFIDENTIAL ADDRESS CITY     (#.1414)
 ;    CONFIDENTIAL ADDRESS STATE    (#.1415)
 ;    CONFIDENTIAL ADDRESS ZIP CODE (#.1416)
 ;    CONFIDENTIAL START DATE       (#.1417)
 ;    CONFIDENTIAL END DATE         (#.1418)
 ;    CONFIDENTIAL ADDRESS ACTIVE?  (#.14105)
 ;    CONFIDENTIAL ADDRESS COUNTY   (#.14111)
 ;    CONFIDENTIAL ADDR PROVINCE    (#.14114)
 ;    CONFIDENTIAL ADDR POSTAL CODE (#.14115)
 ;    CONFIDENTIAL ADDR COUNTRY     (#.14116)
 ;    CONFIDENTIAL PHONE NUMBER     (#.1315)
 ;
 Q:$G(DGRONUPD)=1  ;Suppress update for ROM (set in routine DGROHLR1)
 N DGIEN,DATA S DATA(.14112)=$$NOW^XLFDT(),DGIEN=DA
 I $$UPD^DGENDBS(2,.DGIEN,.DATA)
 Q
 ;
PNOK ; PATIENT File #2 Record Index: ADTTM3
 ;
 ; This code updates the PRIMARY NOK CHANGE DATE/TIME field when any
 ; of the following Primary Next of Kin related data changes for a
 ; patient:
 ;
 ;    K-NAME OF PRIMARY NOK        (#.211)
 ;    K-RELATIONSHIP TO PATIENT    (#.212)
 ;    K-STREET ADDRESS [LINE 1]    (#.213)
 ;    K-STREET ADDRESS [LINE 2]    (#.214)
 ;    K-STREET ADDRESS [LINE 3]    (#.215)
 ;    K-CITY                       (#.216)
 ;    K-STATE                      (#.217)
 ;    K-ZIP CODE                   (#.218)
 ;    K-ADDRESS SAME AS PATIENT'S? (#.2125)
 ;    K-ZIP+4                      (#.2207)
 ;    K-PHONE NUMBER               (#.219)
 ;    K-WORK PHONE NUMBER          (#.21011)
 ;
 N DGIEN,DATA S DATA(.21012)=$$NOW^XLFDT(),DGIEN=DA
 I $$UPD^DGENDBS(2,.DGIEN,.DATA)
 Q
 ;
SNOK ; PATIENT File #2 Record Index: ADTTM4
 ;
 ; This code updates the SECONDARY NOK CHANGE DATE/TIME field when any
 ; of the following Secondary Next of Kin related data changes for a
 ; patient:
 ;
 ;    K2-NAME OF SECONDARY NOK      (#.2191)
 ;    K2-RELATIONSHIP TO PATIENT    (#.2192)
 ;    K2-STREET ADDRESS [LINE 1]    (#.2193)
 ;    K2-STREET ADDRESS [LINE 2]    (#.2194)
 ;    K2-STREET ADDRESS [LINE 3]    (#.2195)
 ;    K2-CITY                       (#.2196)
 ;    K2-STATE                      (#.2197)
 ;    K2-ZIP CODE                   (#.2198)
 ;    K2-ADDRESS SAME AS PATIENT'S? (#.21925)
 ;    K2-ZIP+4                      (#.2203)
 ;    K2-PHONE NUMBER               (#.2199)
 ;    K2-WORK PHONE NUMBER          (#.211011)
 ;
 N DGIEN,DATA S DATA(.211012)=$$NOW^XLFDT(),DGIEN=DA
 I $$UPD^DGENDBS(2,.DGIEN,.DATA)
 Q
 ;
ECON ; PATIENT File #2 Record Index: ADTTM5
 ;
 ; This code updates the E-CONTACT CHANGE DATE/TIME field when any
 ; of the following Emergency Contact related data changes for a
 ; patient:
 ;
 ;    E-NAME (#.331)
 ;    E-RELATIONSHIP TO PATIENT    (#.332)
 ;    E-STREET ADDRESS [LINE 1]    (#.333)
 ;    E-STREET ADDRESS [LINE 2]    (#.334)
 ;    E-STREET ADDRESS [LINE 3]    (#.335)
 ;    E-CITY                       (#.336)
 ;    E-STATE                      (#.337)
 ;    E-ZIP CODE                   (#.338)
 ;    E-EMER. CONTACT SAME AS NOK? (#.3305)
 ;    E-ZIP+4                      (#.2201)
 ;    E-PHONE NUMBER               (#.339)
 ;    E-WORK PHONE NUMBER          (#.33011)
 ;
 N DGIEN,DATA S DATA(.33012)=$$NOW^XLFDT(),DGIEN=DA
 I $$UPD^DGENDBS(2,.DGIEN,.DATA)
 Q
 ;
ECON2 ; PATIENT File #2 Record Index: ADTTM6
 ;
 ; This code updates the E2-CONTACT CHANGE DATE/TIME field when any
 ; of the following Secondary Emergency Contact related data changes
 ; for a patient:
 ;
 ;    E2-NAME OF SECONDARY CONTACT (#.3311)
 ;    E2-RELATIONSHIP TO PATIENT   (#.3312)
 ;    E2-STREET ADDRESS [LINE 1]   (#.3313)
 ;    E2-STREET ADDRESS [LINE 2]   (#.3314)
 ;    E2-STREET ADDRESS [LINE 3]   (#.3315)
 ;    E2-CITY                      (#.3316)
 ;    E2-STATE                     (#.3317)
 ;    E2-ZIP CODE                  (#.3318)
 ;    E2-ZIP+4                     (#.2204)
 ;    E2-PHONE NUMBER              (#.3319)
 ;    E2-WORK PHONE NUMBER         (#.331011)
 ;
 N DGIEN,DATA S DATA(.33112)=$$NOW^XLFDT(),DGIEN=DA
 I $$UPD^DGENDBS(2,.DGIEN,.DATA)
 Q
 ;
DESIG ; PATIENT File #2 Record Index: ADTTM7
 ;
 ; This code updates the DESIGNEE CHANGE DATE/TIME field when any
 ; of the following Designee related data changes for a patient:
 ;
 ;    D-NAME OF DESIGNEE        (#.341)
 ;    D-RELATIONSHIP TO PATIENT (#.342)
 ;    D-STREET ADDRESS [LINE 1] (#.343)
 ;    D-STREET ADDRESS [LINE 2] (#.344)
 ;    D-STREET ADDRESS [LINE 3] (#.345)
 ;    D-CITY                    (#.346)
 ;    D-STATE                   (#.347)
 ;    D-ZIP CODE                (#.348)
 ;    D-DESIGNEE SAME AS NOK?   (#.3405)
 ;    D-ZIP+4                   (#.2202)
 ;    D-PHONE NUMBER            (#.349)
 ;    D-WORK PHONE NUMBER       (#.34011)
 ;
 N DGIEN,DATA S DATA(.3412)=$$NOW^XLFDT(),DGIEN=DA
 I $$UPD^DGENDBS(2,.DGIEN,.DATA)
 Q
