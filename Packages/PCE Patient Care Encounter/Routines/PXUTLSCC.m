PXUTLSCC ;ISL/DEE,ISA/KWP - Validates and corrects the Service Connected Conditions ;Dec 31, 2025@13:19:16
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**74,107,111,130,168,211,244**;Aug 12, 1996;Build 37
 ;
 ; Reference to $$EXAE^SDOE in ICR #2546
 ; Reference to $$GETOE^SDOE in ICR #2546
 ; Reference to CLOE^SDCO21 in ICR #1300
 ; Reference to CL^SDCO21 in ICR #1300
 ; Reference to $$REQ^SDM1A in ICR #1583
 ; Reference to $$CLINIC^SDAMU in ICR #1580
 ; Reference to $$INP^SDAM2 in ICR #1582
 ; Reference to $$EXOE^SDCOU2 in ICR #1015
 ; Reference to ^SCE("AVSIT" in ICR #2088
 ; Reference to ^SCE( in ICR #2065
 ; Reference to ^DPT( in ICR #1301
 ; Reference to ^SD(409.41 in ICR #2083
 ;
 Q
 ;
CLEANMSG(ERRMSG) ;Cleanup the error message by removing fields with no error.
 N CORR,CORRFLD,FIELD,IND,JND,TEMP,TEXT
 S (CORR,IND,JND)=0
 F  S IND=$O(ERRMSG("DIERR",1,"TEXT",IND)) Q:IND=""  D
 . S TEMP=ERRMSG("DIERR",1,"TEXT",IND)
 . I TEMP="" Q
 . I TEMP["Corrected to" S CORR=1,JND=JND+1,TEXT(JND)=TEMP
 . I TEMP["No error" Q
 . I CORR=0 S JND=JND+1,TEXT(JND)=TEMP,CORRFLD($P(TEMP,".",1))=""
 . I CORR=1 D
 .. S FIELD=$P(TEMP,".",1)
 .. I $D(CORRFLD(FIELD)) S JND=JND+1,TEXT(JND)=TEMP
 K ERRMSG("DIERR")
 M ERRMSG("DIERR",1,"TEXT")=TEXT
 Q
 ;
SCC(PXUPAT,PXUDT,PXUHLOC,PXUTLVST,PXUIN,PXUOUT,PXUERR) ;
 ;+Input Parameters:
 ;+  PXUPAT   IEN of patient
 ;+  PXUDT    date and time of the encounter
 ;+  PXUHLOC  Hospital Location of the encounter
 ;+  PXUTLVST (optional) pointer to the visit that is being used
 ;+  PXUIN    service connected^agent orange^ionizing radiation
 ;+             ^enviromental contaminants^military sexual trauma
 ;+             ^head and/or neck cancer
 ;+           where 1 ::= yes, 0 ::= no, null ::= n/a
 ;+
 ;+Output Parameters:
 ;+  PXUOUT  this is PXUIN corrected so that the invalid answers
 ;+          are changed to null
 ;+  PXUERR  this is a six piece value one for each condition as follows:
 ;+      1   ::= should be yes or no, but it is null
 ;+      0   ::= no error
 ;+     -1   ::= not valued value
 ;+     -2   ::= value must be null
 ;+     -3   ::= must be null because SC is yes
 ;
 N CODE,PXAA,VALUE,X
 S PXAA("PATIENT")=PXUPAT,PXAA("ENC D/T")=PXUDT,PXAA("HOS LOC")=PXUHLOC
 F X=1:1:8 D
 .S VALUE=$P(PXUIN,U,X)
 .S CODE=$$NODETOCODE^PXSPECAUTH(X)
 .S PXUOUT(CODE)=VALUE
 D VALSA^PXAIVSTV(.PXUERR,$G(PXUTLVST),.PXAA,.PXUOUT)
 Q
 ;
 ;
SCCOND(DFN,APPDT,HLOC,VISIT,PXUDATA) ;Set up array of the patients
 ;  Service Connected Conditions
 ;
 ;Input Parameters:
 ;  DFN      IEN of patient
 ;  APPDT    date and time of the encounter
 ;  HLOC     Hospital Location of the enocunter
 ;  VISIT    (optional) The visit that is being used
 ;
 ;Output Parameters:
 ;  PXUDATA  this is an array subscripted by "SC","AO","IR","EC","MST",
 ;           "HNC" that contains to piece each
 ;    first: 1 if the condition can be answered
 ;           0 if it should be null
 ;   second: the answer that Scheduling has if it has one
 ;           1 ::= yes,  0 ::= no
 ;
 N CLASSIF,XX,OUTENC,CL,END,X0,MNE
 S OUTENC=""
 I VISIT>0 D
 .S OUTENC=$O(^SCE("AVSIT",VISIT,0))
 .I OUTENC>0,$P(^SCE(OUTENC,0),U,6) S OUTENC=$P(^SCE(OUTENC,0),U,6)
 I 'VISIT D
 .; Call if they have an appointment for this hospital location
 .; and there is an Outpatient Encounter IEN;
 .; returns the answer that scheduling has if any
 .I $G(^DPT(DFN,"S",APPDT,0))]"" S XX=$G(^(0)) I +XX=HLOC D
 ..S OUTENC=$P(XX,U,20)
 .Q:OUTENC
 .;
 .; Find an Outpatient encounter matching DFN APPDT,HLOC if any.
 .S OUTENC=$$EXAE^SDOE(DFN,APPDT,APPDT) D VEROUT
 ;
 ;Do Outpatient Encounter checks
 I OUTENC D
 .I '$D(^SCE(OUTENC,0)) S OUTENC="" Q
 .S X0=^SCE(OUTENC,0),END=0 D ENCHK(OUTENC,X0)
 .I END S OUTENC=""
 I OUTENC>0 D CLOE^SDCO21(OUTENC,.CLASSIF)
 ;
 I '$G(OUTENC) D CL^SDCO21(DFN,APPDT,"",.CLASSIF)
 S XX=0
 F  S XX=$O(^SD(409.41,XX)) Q:XX'>0  D
 .S MNE=$P($G(^SD(409.41,XX,0)),U,7) I $D(MNE) D
 ..S PXUDATA(MNE)=$D(CLASSIF(XX))_U_$P($G(CLASSIF(XX)),U,2)
 Q
ENCHK(ENCOWNTR,X0) ;Do outpatient encounter checks
 N LOC,ORG,DFN
 S DFN=$P(X0,U,2),LOC=$P(X0,U,4),ORG=$P(X0,U,8)
 I $$REQ^SDM1A(+X0)'="CO" S END=1 Q  ;Check MAS Check out date parameter
 I ORG=1,'$$CLINIC^SDAMU(+LOC) S END=1 Q  ;Screen for valid clinic
 I "^1^2^"[("^"_ORG_"^"),$$INP^SDAM2(+DFN,+X0)="I" S END=1 Q  ;Inpat chk
 I $$EXOE^SDCOU2(ENCOWNTR) S END=1 Q  ;Chk exempt Outpt classification
 Q
VEROUT ;verify a clinic
 Q:'OUTENC
 S CL=$$GETOE^SDOE(OUTENC) I $P(CL,U,4)'=HLOC S OUTENC=""
 Q
 ;
