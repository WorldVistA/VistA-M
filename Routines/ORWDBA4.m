ORWDBA4 ; SLC/GU Billing Awareness - Phase II [11/26/04 15:44]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195,243**;Dec 17, 1997;Build 242
 ;
 ;Miscellaneous CIDC functions utility.
 ;
 ;External References used by this routine
 ;  $$GETS^DIQ            DBIA 2056
 ;  GETS^DIQ              DBIA 2056
 ;  $$ICDDX^ICDCODE       DBIA 3990
 ;  $$TFGBLGUI^ORWDBA1    DBIA none listed
 ;  $$SETDXD^ORWDBA2      DBIA none listed
 ;  $$NOW^XLFDT           DBIA 10103
 ;  $$GET^XPAR            DBIA 2263
 ;
GETTFCI(Y,ORIEN) ;Get Treatment Factors Clinical Indicators
 ;Input Variable:
 ;  ORIEN    Order Internal Entry Number (array variable)
 ;Ouput Variable:
 ;  Y        Y(AI)=Order_IEN^Treatment_Factors^ICD9^ICD9_Description
 ;           There can be up to 4 ICD9 codes and thier descriptions
 ;           ICD901^DESC01^ICD902^DESC02^ICD903^DESC03^ICD904^DESC04
 ;Local Variables:
 ;  AI       Array Index
 ;  CI       Clinical Index
 ;  TF       Treatment Factors
 ;  TFCI     Treatment Factors Clinical Indicators
 N AI,CI,CNT,DXS,TF,TFCI
 S U="^",(CNT,TF)=""
 F  S CNT=$O(ORIEN(CNT)) Q:CNT=""  D
 . S TF=$$GTF(ORIEN(CNT))
 . S DXS=$$GDCD(ORIEN(CNT))
 . I TF="NNNNNNNN"&(DXS="") Q
 . S TFCI(CNT)=ORIEN(CNT)_U_TF_$S(DXS="":"",1:U_DXS)
 M Y=TFCI
 Q
 ;
GTF(IEN) ;Get Treatment Factors
 ;Gets the Treatment Factors for the current order converted to the
 ;format used by the CPRS GUI display.
 ;
 ;Input Variable:
 ;  IEN     Internal Entry Number
 ;Local Variables:
 ;  ORTF    Order Record Treatment Factors
 ;  OREM    Order Record Error Message
 ;  OTF     Order Treatment Factors
 ;          (Converted to GUI values and returned)
 N ORTF,OREM,OTF
 S OTF=""
 D GETS^DIQ(100,IEN,"90;91;92;93;94;95;96;98","I","ORTF","OREM")
 S OTF=$G(ORTF(100,IEN_",",90,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",91,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",92,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",93,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",94,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",95,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",96,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",98,"I"))
 S OTF=$$TFGBLGUI^ORWDBA1(OTF)
 I OTF'="NNNNNNNN" Q OTF
 S OTF=""
 K ORTF,OREM
 D GETS^DIQ(100,IEN,"51;52;53;54;55;56;57;58","I","ORTF","OREM")
 S OTF=$G(ORTF(100,IEN_",",51,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",52,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",53,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",54,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",55,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",56,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",57,"I"))
 S OTF=OTF_U_$G(ORTF(100,IEN_",",58,"I"))
 S OTF=$$TFGBLGUI^ORWDBA1(OTF)
 Q OTF
 ;
GDCD(IEN) ;Get Diagnoses Codes / Description
 ;Builds and returns a text string delimited by the "^". The text string
 ;made from the ICD9 codes associated with the current order and thier
 ;descriptions pulled from the ICD DIAGNOSIS file #80. The string can
 ;contain up to four diagnoses codes and thier descriptions. The string
 ;with all four possiable diagnoses codes is formatted:
 ;ICD901^DESC01^ICD902^DESC02^ICD903^DESC03^ICD904^DESC04
 ;
 ;Input Variable:
 ;  IEN
 ;Local Variables:
 ;  DCD      Diagnosis Code Description (retrun variable)
 ;  DXDT     Diagnosis Date (either Order date or system date)
 ;  DXD      Diagnosis Description
 ;  DXIEN    Diagnosis Internal Entry Number
 ;  ICD9     ICD9 code (for GUI display)
 ;  IENS     Internale Entry Number Sequence
 ;           (Array index variable for data returned from lookup)
 ;  ORRF     Order Record Found (returned data from lookup)
 ;  OREM     Order Record Error Message
 N DCD,DXDT,DXD,DXIEN,ICD9,IENS,ORRF,OREM
 S DCD=""
 D GETS^DIQ(100,IEN,".8*;5.1*","I","ORRF","OREM")
 I $D(ORRF) D
 . S DXDT=""
 . I $D(ORRF(100.008)) S DXDT=$G(ORRF(100.008,"1,"_IEN_",",.01,"I"))
 . I DXDT="" S DXDT=$$NOW^XLFDT
 . I $D(ORRF(100.051)) D
 .. S IENS="" F  S IENS=$O(ORRF(100.051,IENS)) Q:IENS=""  D
 ... I ORRF(100.051,IENS,.01,"I")="" S DCD=DCD_U Q
 ... S DXIEN=ORRF(100.051,IENS,.01,"I")
 ... S ICD9=$$GET1^DIQ(80,DXIEN,.01,"")
 ... S DXD=$$SETDXD^ORWDBA2($P($$ICDDX^ICDCODE(ICD9,DT),U,4))
 ... S DCD=$S(DCD="":ICD9_U_DXD,1:DCD_U_ICD9_U_DXD)
 Q DCD
 ;
GETBAUSR(Y,ORCIEN) ;GUI RPC CALL
 ;Get Billing Awareness By User parameter value
 ;Gets and returns the value of the Enabled Billing Awareness By User 
 ;parameter assigned to a provider.
 ;Input Variable:
 ;  ORCIEN    Ordering Clinician's Internal Entry Number
 ;Output Variable:
 ;  Y         Parameter value, 1 if enabled, 0 if disabled
 S Y=$$GET^XPAR(ORCIEN_";VA(200,","OR BILLING AWARENESS BY USER",1,"Q")
 Q
