YSCLHLPD ;DSS/PO-CLOZAPINE DATA TRANSMISSION-Messaging-Segment-PID ;19 May 2020 14:13:48
 ;;5.01;MENTAL HEALTH;**149**;Dec 30, 1994;Build 72
 Q
 ;
 ; Reference to ^HLOAPI supported by DBIA #4716
 ;
PID(YSEG,YSCLARR) ; create PID segment
 ;  input:  YSCLARR   data array to build in HL7 segments from
 ; output:  YSEG      segment data to be submitted to HLO
 ;
 N IDA  ; ID number array
 N RPI  ; repetition index
 ;
 S IDA(1)=YSCLARR("PATIENT_CLOZ REG NUM")  ;PN
 S IDA(2)=YSCLARR("PATIENT_SSN")   ;SS
 S IDA(3)=YSCLARR("PATIENT_ICN")  ;NI      ; this field could be as 29 char long  our sample are max of 23 char 
 S IDA(4)=YSCLARR("PATIENT_DFN")  ;PI
 ;
 ; build segment elements
 D SET^HLOAPI(.YSEG,"PID",0)
 F RPI=1:1:4 D
 . D SET^HLOAPI(.YSEG,IDA(RPI),3,1,1,RPI)
 . D SET^HLOAPI(.YSEG,$P("PN^SS^NI^PI",U,RPI),3,5,1,RPI)
 ;
 D SET^HLOAPI(.YSEG,YSCLARR("PATIENT_LAST NAME"),5,1,1,1)
 D SET^HLOAPI(.YSEG,YSCLARR("PATIENT_FIRST NAME"),5,2,1,1)
 D SET^HLOAPI(.YSEG,"L",5,7,1,1) ; name occ #1
 D SET^HLOAPI(.YSEG,YSCLARR("PATIENT_DOB"),7)
 D SET^HLOAPI(.YSEG,YSCLARR("PATIENT_SEX"),8)
 ;
 D SET^HLOAPI(.YSEG,YSCLARR("PATIENT_RACE CODE"),10,1,1,1)
 D SET^HLOAPI(.YSEG,YSCLARR("PATIENT_RACE"),10,2,1,1)
 ;
 D SET^HLOAPI(.YSEG,"HL70005",10,3)
 D SET^HLOAPI(.YSEG,YSCLARR("PATIENT_ZIP"),11,5)
 ;
 D SET^HLOAPI(.YSEG,YSCLARR("PATIENT_ETHNICITY CODE"),22,1,1,1)
 D SET^HLOAPI(.YSEG,YSCLARR("PATIENT_ETHNICITY"),22,2,1,1)
 D SET^HLOAPI(.YSEG,"HL70189",22,3,1,1)
 Q
 ;
TEST ; Entry point for development / testing
 ; Select a patient from CLOZAPINE PATIENT LIST who's been authorized
 ; in the PHARMACY PATIENT File
 N DIC,X,Y ; vars used by ^DIC
 N DFN,Q,VADM,VAPA ; work vars
 N YSCLR,YSCLP ; registration number & DFN for DIC("S") screen
 N SEGA ; return segment array
 S DIC=603.01,DIC(0)="AEQZ"
 S DIC("S")="S YSCLR=$P(^(0),U),YSCLP=$P(^(0),U,2) I $L(YSCLR),YSCLP,$D(^PS(55,""ASAND1"",YSCLR,YSCLP))"
 D ^DIC Q:'$D(Y(0))  S DFN=$P(Y(0),"^",2)
 D GET^YSCLHLGT(.YSCLARR,DFN)
 D PID(.SEGA,.YSCLARR)
 ;
 W ! S X="",Q=$C(34) F  S X=$O(YSCLARR(X)) Q:X=""  S Y=YSCLARR(X) W !,$NA(YSCLARR(X))_"="_$S(Y=+Y:Y,1:Q_Y_Q)
 ;
