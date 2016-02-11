ORWPT1 ; SLC/KCM/ALB/ART - Patient Lookup Functions (cont) ;09/11/2014
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,109,280,340,306,387**;Dec 17, 1997;Build 19
 ;
SAVDFLT ; continued from ORWPT, save new default patient list
 N DAY,HOLDX S OK=1
 I $P(X,U)="P" D
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT LIST SOURCE",1,"P")
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT PROVIDER",1,"`"_$P(X,U,2))
 I $P(X,U)="T" D
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT LIST SOURCE",1,"T")
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT TEAM",1,"`"_$P(X,U,2))
 I $P(X,U)="S" D
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT LIST SOURCE",1,"S")
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT SPECIALTY",1,"`"_$P(X,U,2))
 I $P(X,U)="C" D
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT LIST SOURCE",1,"C")
 . F DAY="MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY","SUNDAY" D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT CLINIC "_DAY,1,"`"_$P(X,U,2))
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT CLINIC START DATE",1,$P($P(X,U,3),";"))
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT CLINIC STOP DATE",1,$P($P(X,U,3),";",2))
 ; SLC/PKS - 6/25/2001
 ; Added section to save clinic defaults for current day only:
 I $P(X,U)="CT" D
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT LIST SOURCE",1,"C")
 . S HOLDX=X
 . D NOW^%DTC D DW^%DTC S DAY=X S X=HOLDX
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT CLINIC "_DAY,1,"`"_$P(X,U,2))
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT CLINIC START DATE",1,$P($P(X,U,3),";"))
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT CLINIC STOP DATE",1,$P($P(X,U,3),";",2))
 I $P(X,U)="W" D
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT LIST SOURCE",1,"W")
 . D EN^XPAR(DUZ_";VA(200,","ORLP DEFAULT WARD",1,"`"_$P(X,U,2))
 I $P(X,U)="A" D DEL^XPAR(DUZ_";VA(200,","ORLP DEFAULT LIST SOURCE",1)
 Q
 ;
PRCARE(VAL,PATIENT) ; return Primary Care info for CPRS Header
 ;Input - PATIENT = Patient DFN
 ;Output - VAL = Primary Care Team^PCP^Attending^AP^MH Treatment Coordinator/MH Team^Inpatient Provider
 ; for PCMM Web VAL = Primary Care Team/PCP/AP^^Attending^^MH Treatment Coordinator/MH Team^Inpatient Provider
 ;
 ; Source of PACT/PCP data for CPRS is 404.41/.06 - 387
 ; Other callers will get original data format
 ; ICR #6042 - SCMC PCMM/R GET PRIMARY CARE SUMMARY 
 ;
 N PCT,PCP,ATT,ASS,MHTC,INPROV,MHSTR
 S (PCT,PCP,ATT,ASS,MHTC,INPROV,MHSTR)=""
 ;
 ;RPC Broker sets XQCY0 to the caller's context
 IF $GET(XQCY0)["CPRSChart" DO  ;check calling source
 . S PCT=$$CPRSHEAD^SCMCWSUT(PATIENT) ;387
 ELSE  DO
 . S PCT=$P($$OUTPTTM^SDUTL3(PATIENT,DT),U,2)
 . S PCP=$P($$OUTPTPR^SDUTL3(PATIENT,DT),U,2)
 . S ASS=$P($$OUTPTAP^SDUTL3(PATIENT,DT),U,2)
 ;
 S ATT=$G(^DPT(PATIENT,.1041)) I ATT S ATT=$P($G(^VA(200,ATT,0)),U)
 S MHSTR=$$START^SCMCMHTC(PATIENT) ;387
 S MHTC=$S($P(MHSTR,U,2)'="":$P(MHSTR,U,2)_" / "_$P(MHSTR,U,5),1:"") ;387 - mhtc/mh team
 S INPROV=$G(^DPT(PATIENT,.104)) I INPROV S INPROV=$P($G(^VA(200,INPROV,0)),U)
 S VAL=PCT_U_PCP_U_ATT_U_ASS_U_MHTC_U_INPROV
 Q
 ;
PCDETAIL(LST,PATIENT)   ; return Primary Care Detail information
 ;Input - PATIENT = Patient DFN
 ;Output - LST = Array of Patient Team Assignment Details
 ;
 ; Source of data for CPRS is now a web service call to PCMM Web - 387
 ; Other callers will get original data format
 ; ICR #6027 - SCMC PCMM/R GET PRIMARY CARE DETAILS
 ;
 ;new for PCMM Web requirements
 ;RPC Broker sets XQCY0 to the caller's context
 IF $GET(XQCY0)["CPRSChart" DO  QUIT
 . DO PCDETAIL^SCMCWS1(.LST,PATIENT)
 ;
 ;original code
 N ILST,X S ILST=0
 S X=$$OUTPTTM^SDUTL3(PATIENT,DT)
 I +X>0 D
 . S ILST=ILST+1,LST(ILST)="        Primary Care Team:  "_$P(X,U,2)
 . S ILST=ILST+1,LST(ILST)="                    Phone:  "_$P($G(^SCTM(404.51,+X,0)),U,2)
 E  S ILST=ILST+1,LST(ILST)="No Primary Care Team Assigned."
 S ILST=ILST+1,LST(ILST)=" "
 S X=$$OUTPTPR^SDUTL3(PATIENT,DT)
 I +X>0 D
 . S ILST=ILST+1,LST(ILST)="    Primary Care Provider:  "_$P(X,U,2)
 . S ILST=ILST+1,LST(ILST)="             Analog Pager:  "_$P($G(^VA(200,+X,.13)),U,7)
 . S ILST=ILST+1,LST(ILST)="            Digital Pager:  "_$P($G(^VA(200,+X,.13)),U,8)
 . S ILST=ILST+1,LST(ILST)="             Office Phone:  "_$P($G(^VA(200,+X,.13)),U,2)
 E  S ILST=ILST+1,LST(ILST)="No Primary Care Provider Assigned."
 S ILST=ILST+1,LST(ILST)=" "
 S X=$$OUTPTAP^SDUTL3(PATIENT,DT)
 I +X>0 D
 . S ILST=ILST+1,LST(ILST)="       Associate Provider:  "_$P(X,U,2)
 . S ILST=ILST+1,LST(ILST)="             Analog Pager:  "_$P($G(^VA(200,+X,.13)),U,7)
 . S ILST=ILST+1,LST(ILST)="            Digital Pager:  "_$P($G(^VA(200,+X,.13)),U,8)
 . S ILST=ILST+1,LST(ILST)="             Office Phone:  "_$P($G(^VA(200,+X,.13)),U,2)
 E  S ILST=ILST+1,LST(ILST)="No Associate Provider Assigned."
 S ILST=ILST+1,LST(ILST)=" "
 I $$INPT(PATIENT) D
 . S X=$G(^DPT(PATIENT,.1041))
 . I +X D
 . . S ILST=ILST+1,LST(ILST)="      Attending Physician:  "_$P($G(^VA(200,+X,0)),U)
 . . S ILST=ILST+1,LST(ILST)="             Analog Pager:  "_$P($G(^VA(200,+X,.13)),U,7)
 . . S ILST=ILST+1,LST(ILST)="            Digital Pager:  "_$P($G(^VA(200,+X,.13)),U,8)
 . . S ILST=ILST+1,LST(ILST)="             Office Phone:  "_$P($G(^VA(200,+X,.13)),U,2)
 . E  S ILST=ILST+1,LST(ILST)="No Attending Physician Assigned."
 . S ILST=ILST+1,LST(ILST)=" "
 . S X=$G(^DPT(PATIENT,.104))
 . I +X D
 . . S ILST=ILST+1,LST(ILST)="       Inpatient Provider:  "_$P($G(^VA(200,+X,0)),U)
 . . S ILST=ILST+1,LST(ILST)="             Analog Pager:  "_$P($G(^VA(200,+X,.13)),U,7)
 . . S ILST=ILST+1,LST(ILST)="            Digital Pager:  "_$P($G(^VA(200,+X,.13)),U,8)
 . . S ILST=ILST+1,LST(ILST)="             Office Phone:  "_$P($G(^VA(200,+X,.13)),U,2)
 . E  S ILST=ILST+1,LST(ILST)="No Inpatient Provider Assigned."
 . S ILST=ILST+1,LST(ILST)=" "
 S X=0
 S X=$$START^SCMCMHTC(PATIENT) ;Retrieve Mental Health Provider
 I +X>0 D
 . S ILST=ILST+1,LST(ILST)="        MH Treatment Team:  "_$P(X,U,5)
 . S ILST=ILST+1,LST(ILST)=" MH Treatment Coordinator:  "_$P(X,U,2)
 . S ILST=ILST+1,LST(ILST)="             Analog Pager:  "_$P($G(^VA(200,+X,.13)),U,7)
 . S ILST=ILST+1,LST(ILST)="            Digital Pager:  "_$P($G(^VA(200,+X,.13)),U,8)
 . S ILST=ILST+1,LST(ILST)="             Office Phone:  "_$P($G(^VA(200,+X,.13)),U,2)
 ;E  S ILST=ILST+1,LST(ILST)="No MH Treatment Coordinator Assigned."
 Q
 ;
INPT(ORDFN) ;check if the patient is an inpatient
 N RET S RET=0
 I $D(^DPT(ORDFN,.1)) S RET=1
 Q RET
 ;
