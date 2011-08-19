FHWOR31 ; HISC/NCA - HL7 Early/Late Tray (Cont.) ;10/10/00  14:56
 ;;5.5;DIETETICS;;Jan 28, 2005
CUR(FHDFN,ADM,FHDTE,FHV1,FHV2) ; This fuction pass the variable FHORD and FHLD back.
 N A1,FHN,KK,X
 S A1=0,(FHV1,FHV2)="" F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1!(KK>FHDTE)  S A1=KK
 Q:'A1  S FHN=$P(^FHPT(FHDFN,"A",ADM,"AC",A1,0),"^",2),X=^FHPT(FHDFN,"A",ADM,"DI",FHN,0),FHV1=$P(X,"^",2,6),FHV2=$P(X,"^",7) Q
PROC ; Process Add E/L Trays
 D NOW^%DTC S NOW=%
 I FHV2'="" S TXT="Patient is on a WITHHOLD ORDER at that time!" D ERR^FHWOR Q
 I "^^^^"[FHV1 S TXT="Patient has NO DIET ORDER at that time!" D ERR^FHWOR Q
 I SDT=EDT,SDT<NOW S TXT="Can Not Order a Meal for a Date/Time before now!" D ERR^FHWOR Q
 S FILL="E"_";"_ADM_";;"_SDT_";"_EDT_";"_WKD_";"_MEAL_";"_TIM_";"_BAG
 D ^FHORE1A
 I 'FHDAY S TXT="Day of Week Not Within Start and Stop Date." D ERR^FHWOR G EXIT^FHWOR3
 D SEND^FHWOR Q
WKD ; Get week days
 S X=EDT D H^%DTC S:%Y=0 %Y=7 Q:%Y<0
 S WKD=WKD_$E("MTWRFSX",%Y)
 Q
SET ; Set Date/Time in HL7 format
 S:SDT SDT=$$FMTHL7^XLFDT(SDT)
 S:EDT EDT=$$FMTHL7^XLFDT(EDT)
 S:NOW NOW=$$FMTHL7^XLFDT(NOW)
 Q
