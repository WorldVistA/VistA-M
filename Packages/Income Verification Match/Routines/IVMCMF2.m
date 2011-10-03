IVMCMF2 ;ALB/SEK,CKN,TDM - CHECK INCOME DEPENDENT DATA ; 4/14/06 1:34pm
 ;;2.0;INCOME VERIFICATION MATCH;**71,107,105,115**;21-OCT-94;Build 28
 ;
 ; This routine is a called from IVMCMF.
 ;
ZMT(STRING) ; check ZMT segment
 ;
 ; Input:  STRING as ZMT segment
 ;
 N X,Y
 ;
 ; Means Test Status Checks
 I IVMTYPE=1,$P(STRING,HLFS,3)'="G" D MT^IVMCMF3(STRING,ARRAY("ZIC"))
 ;
 ; Copay Test Status Checks
 I IVMTYPE=2 D CO^IVMCMF3(STRING)
 ;
 ; Hardship consistency checks
 N HARDSHIP K HARDSHIP
 S HARDSHIP("Y/N")=$P(STRING,HLFS,13)
 S HARDSHIP("SITE")=$P(STRING,HLFS,23)
 S HARDSHIP("EFFDATE")=$P(STRING,HLFS,24)
 ;
 I (IVMTYPE'=4),(HARDSHIP("Y/N"))!(+HARDSHIP("SITE"))!(HARDSHIP("EFFDATE")) D
 .I HARDSHIP("Y/N")="" S CNT=CNT+1,IVMERR(CNT)="Missing Hardship Indicator"
 .I HARDSHIP("SITE")="" S CNT=CNT+1,IVMERR(CNT)="Missing Site Granting Hardship"
 .;starting in year 2000, all hardships should have an effective date
 .I $E($P(STRING,HLFS,2),1,4)'<2000,(HARDSHIP("EFFDATE")="") S CNT=CNT+1,IVMERR(CNT)="Missing Hardship Effective Date"
 .I $L(HARDSHIP("EFFDATE")) S X=$$FMDATE^HLFNC(HARDSHIP("EFFDATE")),%DT=X D ^%DT I Y<0 S CNT=CNT+1,IVMERR(CNT)="Invalid Hardship Effective Date"
 .I HARDSHIP("EFFDATE"),(HARDSHIP("EFFDATE")<($P(STRING,HLFS,2))-1) S CNT=CNT+1,IVMERR(CNT)="Hardship Effective Date earlier than Means Test Date"
 ;
 ; Source of Test
 S X=$P(STRING,HLFS,18)
 I "^1^2^3^4^"'[(U_X_U) S CNT=CNT+1,IVMERR(CNT)="Source of Test must be identified"
 I X=4,$P(STRING,HLFS,22)="" S CNT=CNT+1,IVMERR(CNT)="Site Conducting Test must be identified"
 ;
ZMTQ Q
 ;
ZDP(STRING) ; Check validity of ZDP segment
 ;
 ; Input:  STRING as ZDP segment
 ;
 N RELAT,IVMZDP5,PSSNRSN,SSNVSTAT
 S IVMZDP5=$P(STRING,HLFS,5)
 I +IVMZDP5'>0 D  G ZDPQ
 .S RELAT=$P(STRING,HLFS,6),RELAT=$S($D(^DG(408.11,RELAT,0)):$P(^DG(408.11,RELAT,0),HLFS),1:"OTHER")
 .S CNT=CNT+1,IVMERR(CNT)="Dependent ("_RELAT_") transmitted without SSN"
 I $D(IVMAR2(IVMZDP5)) S CNT=CNT+1,IVMERR(CNT)="Two dependents transmitted with same SSN"
 S IVMAR2(IVMZDP5)=""
 S PSSNRSN=$P(STRING,HLFS,10) I PSSNRSN]"",(PSSNRSN'="R"),(PSSNRSN'="S"),(PSSNRSN'="N") S CNT=CNT+1,IVMERR(CNT)="Invalid Pseudo SSN Reason transmitted for Spouse/Dependent."
 S SSNVSTAT=$P(STRING,HLFS,12) I SSNVSTAT]"",(SSNVSTAT'=2),(SSNVSTAT'=4) S CNT=CNT+1,IVMERR(CNT)="Invalid SSN Verification Status transmitted for Spouse/Dependent."
ZDPQ Q
