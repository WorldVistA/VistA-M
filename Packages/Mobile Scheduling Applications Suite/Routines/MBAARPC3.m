MBAARPC3 ;OIT-PD/PB - Scheduling RPCs ;02/10/2016
 ;;1.0;Scheduling Calendar View;**1**;Feb 13, 2015;Build 85
 ;
 ;Associated ICRs:
 ;  ICR#
 ;  6044 SC(
 ;
 ;This routine has multiple RPCs created to support the mobile Scheduling apps
 ;Line Tag ADMITS commented out due to the descoping the functionality in the first release
 ;ADMITS(RESULTS,DFN) ;Returns all admisssions for a patient MBAA RPC: MBAA PATIENT ADMISSIONS
 ;Input parameter: Patient DFN
 ;Returns:
 ;  if admissions are found returns an array in the format of:
 ;  RESULTS(0)=Discharge flag (0 = admitted, 1 = discharged)^Admission date^reason for admission^primary provider^attending physician^length of stay^ward^room-bed^treating specialty^date of discharge^type of discharge
 ; if no admissions are found for the patient in the last year
 ; Returns: 
 ;  RESULTS(INC)="0^No admissions"
 ;  Returns the following errors:
 ;  RESULTS(0)="0^DFN Missing"
 ;  RESULTS(0)="0^Not a patient at this facility"
 ;
 ;K MOVEDT,DTFLG
 ;I $G(DFN)'>0 S RESULTS(0)="0^DFN Missing" Q
 ;I '$D(^DPT($G(DFN),0)) S RESULTS(0)="0^Not a patient at this facility" Q
 ;I '$D(^DGPM("APTT1",DFN)) S RESULTS(0)="0^Patient has not been admitted at this facility" Q  ;ICR#: 565 DGPM("APTT1"
 ;D NOW^%DTC S MOVEDT=$$FMADD^XLFDT(%,-366,0,0,0),INC=1,DTFLG=0 ; removed customer wants all admissions
 ;S MOVEDT="",INC=1,DTFLG=0
 ;I $D(^DGPM("APTT1",DFN)) D CHKDT
 ;I DTFLG=1 S RESULTS(0)="0^Patient has not been admitted at this facility in the last year." Q
 ;F  S MOVEDT=$O(^DGPM("APTT1",DFN,MOVEDT)) Q:MOVEDT'>0  S REC=0 F  S REC=$O(^DGPM("APTT1",DFN,MOVEDT,REC)) Q:REC'>0  D
 ;.;K NODE,W1,WARD,RM1,RMBED,P1,PROVIDER,ATENDING,DGPP,DGAP,S1,TRSPCLTY,SHRTDIAG,DISFLAG,ADFLG,DISDATE,R1,TYPEDIS,STAYLEN,ADMITS
 ;.;S NODE=$G(^DGPM(REC,0)),ADFLG=0
 ;.;S ADFLG=0
 ;.;D GETS^DIQ(405,REC,".04;.06;.07;.08;.09;.1;.17;.19","IE","ADMITS")
 ;.;S W1=$P(NODE,"^",6) S:$G(W1)>0 WARD=$P(^DIC(42,W1,0),"^")  ;ICR#: 10039
 ;.;S WARD=$G(ADMITS(405,REC_",",.06,"E"))
 ;.;S RM1=$P(NODE,"^",7) S:$G(RM1)>0 RMBED=$P(^DG(405.4,RM1,0),"^")  ;ICR#: 1380 DG(405.4
 ;.;S RMBED=$G(ADMITS(405,REC_",",.07,"E"))
 ;.;S (DGPP,DGAP)="" D NOW^%DTC S NOWI=9999999.999999-% K %
 ;.;F I=NOWI:0 S I=$O(^DGPM("ATS",DFN,REC,I)) Q:'I  F J=0:0 S J=$O(^DGPM("ATS",DFN,REC,I,J)) Q:'J  F IFN=0:0 S IFN=$O(^DGPM("ATS",DFN,REC,I,J,IFN)) Q:'IFN  D TS1   ;ICR#: 419 DGPM(
 ;.;S S1=$P(NODE,"^",9) S:$G(S1)>0 TRSPCLTY=$P(^DIC(45.7,S1,0),"^")  ;ICR#: 362
 ;.;S TRSPCLTY=$G(ADMITS(405,REC_",",.09,"E"))
 ;.;S SHRTDIAG=$P(NODE,"^",10)
 ;.;S SHRTDIAG=$G(ADMITS(405,REC_",",.1,"E"))
 ;.;S DISFLAG=$P(NODE,"^",17)
 ;.;S DISFLAG=$G(ADMITS(405,REC_",",.17,"I"))
 ;.;I $G(DISFLAG)>0 S ADFLG=1,DISDATE=$P(^DGPM($G(DISFLAG),0),"^"),R1=$P(^DGPM($G(DISFLAG),0),"^",4),TYPEDIS=$P(^DG(405.1,R1,0),"^"),STAYLEN=$$FMDIFF^XLFDT(DISDATE,MOVEDT,1)  ;ICR#: 10103 XLFDT, 2965 DG(405.1
 ;.;I $G(DISFLAG)>0 W !,$G(DISFLAG) S ADFLG=1,DISDATE=$P(^DGPM($G(DISFLAG),0),"^"),R1=$P(^DGPM($G(DISFLAG),0),"^",4),TYPEDIS=$G(ADMITS(405,REC_",",.04,"E")),STAYLEN=$$FMDIFF^XLFDT(DISDATE,MOVEDT,1)  ;ICR#: 10103 XLFDT, 2965 DG(405.1
 ;.;S RESULTS(INC)=$G(ADFLG)_"^"_MOVEDT_"^"_$G(SHRTDIAG)_"^"_$G(PROVIDER)_"^"_$G(ATENDING)_"^"_$G(STAYLEN)_"^"_$G(WARD)_"^"_$G(RMBED)_"^"_$G(TRSPCLTY)_"^"_$G(DISDATE)_"^"_$G(TYPEDIS),INC=$G(INC)+1
 ;.;K NODE,W1,WARD,RM1,RMBED,P1,PROVIDER,ATENDING,DGPP,DGAP,S1,TRSPCLTY,SHRTDIAG,DISFLAG,ADFLG,DISDATE,R1,TYPEDIS,STAYLEN
 ;K MOVEDT,DFN,NODE,W1,I,IFN,INC,J,WARD,RM1,RMBED,P1,NOWI,REC,PROVIDER,ATENDING,DGPP,DGAP,S1,TRSPCLTY,SHRTDIAG,DISFLAG,ADFLG,DISDATE,R1,TYPEDIS,STAYLEN,DTFLG,ADMITS
 ;Q
 ;T13 Change to remove the linetag TS1 as it is not used in the first release of SCV
 ;TS1 ;
 ;N ADMITS1
 ;D GETS^DIQ(405,IFN,".08;.19","IE","ADMITS1")
 ;S PROVIDER=$G(ADMITS1(405,IFN_",",.08,"E")),ATENDING=$G(ADMITS1(405,IFN_",",.19,"E"))
 ;K PROVIDER,ATENDING
 ;Q
GETPROV(PROV1,CLINID) ; Get a list of providers by clinic  - RPC MBAA PROVIDERS BY CLINIC
 ; RPC MBAA PROVIDERS BY CLINIC
 ; INPUT PARAMETER: CLINIC ID - IEN for the clinic in the HOSPITAL LOCATION File (#44)
 ; OUTPUT: Array of providers in the format
 ; Success: ARRAY(I)=DFN^PROVIDER NAME
 ; Failure: ARRAY(0)="0^ERROR CODE"
 ;
 N ERR,CLINIC
 I $G(CLINID)="" S PROV1(1)="0^CLINIC ID IS NULL" Q
 S CLINIC=$$GET1^DIQ(44,CLINID,.01) I $G(CLINIC)="" S PROV1(1)="0^CLINIC DOESN'T EXIST" Q  ;ICR#: 6044 SC(
 D GETS^DIQ(44,$G(CLINID),"2600*","IE","PROV")
 S CNT=1,XX="" F  S XX=$O(PROV(44.1,XX)) Q:XX=""  D
 .K PIEN,PNAME
 .S PIEN=$G(PROV(44.1,XX,.01,"I")),PNAME=$G(PROV(44.1,XX,.01,"E"))
 .I $G(PIEN)>0  S PROV1(CNT)=$G(PIEN)_"^"_$G(PNAME),CNT=CNT+1
 .K PIEN,PNAME
 K CNT,CLINID,CLINIC,XX,PROV,PIEN,PNAME
 I $G(PROV1(1))="" S PROV1(1)="NO PROVIDERS ASSIGNED TO THE CLINIC"
 Q
