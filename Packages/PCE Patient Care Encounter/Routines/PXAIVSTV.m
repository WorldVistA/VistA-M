PXAIVSTV ;ISL/JVS,PKR ISA/KWP - VALIDATE THE VISIT DATA ;Nov 06, 2025@14:14:33
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**9,15,19,74,111,116,130,124,168,211,244**;Aug 12, 1996;Build 37
 ;
 Q
ERRSET ;Set the rest of the error data.
 S STOP=1
 S PXAERRF=1
 S PXADI("DIALOG")=8390001.001
 Q
 ;
VAL ;--Validate the input.
 ;If a valid Visit pointer has been input no further validation is
 ;required, when this is called the Visit pointer has already been
 ;validated.
 I $G(PXAVISIT) Q
 ;
 ;If it is a deletion then no further validation is required.
 I $G(PXAA("DELETE"))=1 Q
 ;
 ;Missing the date and time of visit.
 I $G(PXAA("ENC D/T"))="" D  Q
 . S PXAERR(9)="ENC D/T"
 . S PXAERR(11)=$G(PXAA("ENC D/T"))
 . S PXAERR(12)="The visit date and time is missing."
 . D ERRSET
 ;
 ;Is it a valid FileMan date?
 I $$VFMDATE^PXDATE(PXAA("ENC D/T"),"ST")=-1 D  Q
 . S PXAERR(9)="ENC D/T"
 . S PXAERR(11)=PXAA("ENC D/T")
 . S PXAERR(12)="The visit date and time is not a valid FileMan date and time."
 . D ERRSET
 ;
 ;Missing Time and not a historical visit.
 I $P(PXAA("ENC D/T"),".",2)="",$G(PXAA("SERVICE CATEGORY"))'="E" D  Q
 . S PXAERR(9)="ENC D/T"
 . S PXAERR(11)=PXAA("ENC D/T")
 . S PXAERR(12)="The visit time is missing and the visit is not historical."
 . D ERRSET
 ;
 ;Missing the patient, a pointer to PATIENT/IHS FILE # 9000001
 I $G(PXAA("PATIENT"))']"" D  Q
 . S PXAERR(9)="PATIENT"
 . S PXAERR(11)=$G(PXAA("PATIENT"))
 . S PXAERR(12)="Missing a pointer to the PATIENT/IHS file #9000001"
 . D ERRSET
 ;
 ;Not a valid pointer to the PATIENT/IHS file #9000001
 I '$D(^AUPNPAT(PXAA("PATIENT"),0)) D  Q
 . S PXAERR(9)="PATIENT"
 . S PXAERR(11)=PXAA("PATIENT")
 . S PXAERR(12)=PXAA("PATIENT")_" is not a valid pointer to the PATIENT/IHS file # 9000001."
 . D ERRSET
 ;
 ;Visit date before the patient's date of birth.
 I PXAA("ENC D/T")<$P(^DPT(PXAA("PATIENT"),0),U,3) D  Q
 . S PXAERR(9)="ENC D/T"
 . S PXAERR(11)=PXAA("ENC D/T")
 . S PXAERR(12)="The visit date is before the patient's date of birth"
 . D ERRSET
 ;
 ;Service category is required.
 I '$D(PXAA("SERVICE CATEGORY")) D  Q
 . S PXAERR(9)="SERVICE CATEGORY"
 . S PXAERR(11)=$G(PXAA("SERVICE CATEGORY"))
 . S PXAERR(12)="Service Category is a required field"
 . D ERRSET
 ;
 ;Is the Service Category valid?
 N EXTERNAL,MSG
 S EXTERNAL=$$EXTERNAL^DILFD(9000010,.07,"",PXAA("SERVICE CATEGORY"),"MSG")
 I (EXTERNAL=""),$D(MSG) D  Q
 . S PXAERR(9)="SERVICE CATEGORY"
 . S PXAERR(11)=PXAA("SERVICE CATEGORY")
 . S PXAERR(12)="This is not a valid Service Category."
 . D ERRSET
 ;
 ;Hospital Location is required unless Service Category is "E".
 I PXAA("SERVICE CATEGORY")'="E",$G(PXAA("HOS LOC"))="" D  Q
 . S PXAERR(9)="HOSPITAL LOCATION"
 . S PXAERR(12)="The Hospital Location is missing and the Service Category is not ""E"""
 . D ERRSET
 ;
 ;Is the pointer to Hospital Location file valid?
 I $G(PXAA("HOS LOC"))'="",'$D(^SC(PXAA("HOS LOC"),0)) D  Q
 . S PXAERR(9)="HOSPITAL LOCATION"
 . S PXAERR(11)=PXAA("HOS LOC")
 . S PXAERR(12)=PXAA("HOS LOC")_" is not a valid pointer to the Hospital Location file #44."
 . D ERRSET
 ;
 ;If a valid Hospital Location is passed use it to automatically
 ;set DSS ID.
 I $G(PXAA("HOS LOC"))'="" S PXAA("DSS ID")=$P(^SC(PXAA("HOS LOC"),0),U,7)
 ;
 ;Is the pointer to Clinic Stop file valid?
 I $G(PXAA("DSS ID"))'="",'$D(^DIC(40.7,PXAA("DSS ID"),0)) D  Q
 . S PXAERR(9)="DSS ID"
 . S PXAERR(11)=PXAA("DSS ID")
 . S PXAERR(12)=PXAA("DSS ID")_" is not a valid pointer to the Clinic Stop Location file #40.7."
 . D ERRSET
 ;
 ;Is the pointer to the parent Visit valid?
 I $G(PXAA("PARENT"))'="",'$D(^AUPNVSIT(PXAA("PARENT"),0)) D  Q
 . S PXAERR(9)="PARENT"
 . S PXAERR(11)=PXAA("PARENT")
 . S PXAERR(12)=PXAA("PARENT")_" is not a valid pointer to the Visit file #9000010."
 . D ERRSET
 ;
 ;Is the Checkout D/T valid?
 ;* I $G(PXAA("CHECKOUT D/T"))'="" D
 ;* .;Is it a valid FileMan date?
 ;* . I $$VFMDATE^PXDATE(PXAA("CHECKOUT D/T"),"ESTXR")=-1 D  Q
 ;* .. S PXAERR(9)="CHECKOUT D/T"
 ;* .. S PXAERR(11)=PXAA("CHECKOUT D/T")
 ;* .. S PXAERR(12)="The checkout date and time is not a valid FileMan date and time."
 ;* .. D ERRSET
 ;* . I $G(STOP)=1 Q
 ;* .;The checkout D/T should not be before the visit D/T.
 ;* . I PXAA("CHECKOUT D/T")<PXAA("ENC D/T") D
 ;* .. S PXAERR(9)="CHECKOUT D/T"
 ;* .. S PXAERR(11)=PXAA("CHECKOUT D/T")
 ;* .. S PXAERR(12)="The checkout D/T is before the encounter D/T."
 ;* .. D ERRSET
 ;* I $G(STOP)=1 Q
 ;
 ;Is the pointer to the eligibility file valid?
 ;* I $G(PXAA("ELIGIBILITY"))'="",'$D(^DIC(8,PXAA("ELIGIBILITY"),0)) D  Q
 ;* . S PXAERR(9)="ELIGIBILITY"
 ;* . S PXAERR(11)=PXAA("ELIGIBILITY")
 ;* . S PXAERR(12)=PXAA("ELIGIBILITY")_" is not a valid pointer to the Eligibility file #8."
 ;* . D ERRSET
 ;
 ;Is the pointer to the Location valid?
 ;* I $G(PXAA("INSTITUTION"))'="",'$D(^AUTTLOC(PXAA("INSTITUTION"),0)) D  Q
 ;* . S PXAERR(9)="INSTITUTION"
 ;* . S PXAERR(11)=PXAA("INSTITUTION")
 ;* . S PXAERR(12)=PXAA("INSTITUTION")_" is not a valid pointer to the Location file #9999999.06."
 ;* . D ERRSET
 ;
 ;Is the Outside Location valid?
 ;* I $G(PXAA("OUTSIDE LOCATION"))'="",(($L(PXAA("OUTSIDE LOCATION"))<2)!($L(PXAA("OUTSIDE LOCATION"))>50)) D  Q
 ;* . S PXAERR(9)="OUTSIDE LOCATION"
 ;* . S PXAERR(11)=PXAA("OUTSIDE LOCATION")
 ;* . S PXAERR(12)="The length of the Outside Location is either less than 2 or greater than 50."
 ;* . D ERRSET
 ;
 ;Is the Comment valid?
 ;* I $G(PXAA("COMMENT"))'="",(($L(PXAA("COMMENT"))<1)!($L(PXAA("COMMENT"))>245)) D  Q
 ;* . S PXAERR(9)="COMMENT"
 ;* . S PXAERR(11)=PXAA("COMMENT")
 ;* . S PXAERR(12)="The length of the Comment is either less than 2 or greater than 245."
 ;* . D ERRSET
 ;
 ;If an Encounter Type is being input validate it.
 ;* I $G(PXAA("ENCOUNTER TYPE"))'="" D
 ;* . N EXTERNAL,MSG
 ;* . S EXTERNAL=$$EXTERNAL^DILFD(9000010,15003,"",PXAA("ENCOUNTER TYPE"),"MSG")
 ;* . I (EXTERNAL=""),$D(MSG) D
 ;* .. S PXAERR(9)="ENCOUNTER TYPE"
 ;* .. S PXAERR(12)=MSG("DIERR",1,"TEXT",1)
 ;* .. S PXAERR(13)=MSG("DIERR",1,"TEXT",2)
 ;* .. D ERRSET
 Q
 ;
VALSA(PXAERR,PXAVISIT,PXAA,PXSAS) ;
 N CODE,INVALID,INVCODE,NOTNEED,PXARRAY,ELIG,SC,SUB,TEXT,WARNNUM,VALUE
 S SC=$G(PXSAS("SC"))
 D GETPATSA^PXSPECAUTH($G(PXAA("PATIENT")),$G(PXAA("ENC D/T")),$G(PXAA("HOS LOC")),$G(PXAVISIT),.PXARRAY)
 I SC="" S SC=$P($G(PXARRAY("SC")),U,2)
 S CODE="" F  S CODE=$O(PXARRAY(CODE)) Q:CODE=""  D
 .S ELIG=+$P($G(PXARRAY(CODE)),U),DVALUE=$P($G(PXARRAY(CODE)),U,2)
 .;SA Value not passed in, pt is eligible, a value has been stored in the outpatient classification file.
 .I $G(PXSAS(CODE))="",ELIG=1,DVALUE'="" S PXSAS(CODE)=DVALUE
 .S VALUE=$G(PXSAS(CODE))
 .;SKIPCODE set to 1 for codes that have a relationship to SC values
 .S SKIPCODE=$S(CODE="AO":1,CODE="IR":1,CODE="EC":1,1:0)
 .;Only "", -1, 0, 1 are valid values
 .I VALUE'="",+VALUE<-1!(+VALUE>1) S INVALID(CODE)="",PXSAS(CODE)="" Q
 .;if SC true no reason to continue validate codes, that have a relationship to SC.
 .I SKIPCODE,SC=1 Q
 .;if not eligible, then no value should be passed in
 .I 'ELIG D  Q
 ..I VALUE=0!(VALUE=1) S NOTNEED(CODE)="",PXSAS(CODE)=""
 .;If eligible only 1 or 0 should be passed in
 .I VALUE=-1!(VALUE="") D
 ..S INVCODE(CODE)="",PXSAS(CODE)=""
 ;
 S WARNNUM=0
 S CODE="" F  S CODE=$O(INVALID(CODE)) Q:CODE=""  D
 .S TEXT="Invalid value entered for "_CODE_"."
 .S WARNNUM=WARNNUM+1,SUB=WARNNUM_"W",PXAERR(SUB)=TEXT
 S CODE="" F  S CODE=$O(INVCODE(CODE)) Q:CODE=""  D
 .S TEXT="The veteran is eligible for "_CODE_", but no values were input with the Visit or with V POV."
 .S WARNNUM=WARNNUM+1,SUB=WARNNUM_"W",PXAERR(SUB)=TEXT
 S CODE="" F  S CODE=$O(NOTNEED(CODE)) Q:CODE=""  D
 .S TEXT="The veteran is not eligible for "_CODE_" but a value was input with code."
 .S WARNNUM=WARNNUM+1,SUB=WARNNUM_"W",PXAERR(SUB)=TEXT
 ;
 I WARNNUM=0 Q
 S PXADI("DIALOG")=8390001.003
 S PXAERRW("SCC")=1
 D ERR^PXAI("SCC",1)
 Q
 ;
VALSCC ;--VALIDATE SERVICE CONNECTIVENESS
 N CODE,ERR,ERR1,ERRMSG,PXSAS,VALUE,X
 F X=1:1:8 D
 .S VALUE=$P(AFTER800,U,X)
 .S CODE=$$NODETOCODE^PXSPECAUTH(X)
 .S PXSAS(CODE)=VALUE
 D VALSA(.PXAERR,$G(PXAVISIT),.PXAA,.PXSAS)
 Q
 ;
VPKG(EPKG,PKG) ;Is the Package parameter valid?
 I EPKG'="" Q EPKG
 I $G(PKG)="" D  Q 0
 . S PXAERR(7)="ENCOUNTER"
 . S PXAERR(9)="DATA2PCE parameter: PKG"
 . S PXAERR(12)="PKG is required and it is NULL."
 . D ERRSET
 N PIEN
 S PIEN=$$VPKG^PXAIVAL($G(PKG),.PXAERR)
 I PIEN=0 D  Q 0
 . S PXAERR(7)="PACKAGE"
 . D ERRSET
 Q PIEN
 ;
VPTR(VISITIEN) ;Is the Visit pointer valid?
 I '$D(^AUPNVSIT(VISITIEN,0)) D
 . S PXAERR(7)="VISIT POINTER"
 . S PXAERR(9)="DATA2PCE parameter: VISIT"
 . S PXAERR(11)=VISITIEN
 . S PXAERR(12)="The Visit pointer that was input is not valid."
 . D ERRSET
 Q
 ;
VSOURCE(PXAPKG,ESRC,SOURCE) ;Is the Data Source valid?
 ;Scheduling creates encounters using Visit Tracking, it does not call
 ;DATA2PCE and it does not set Source.
 I $P(^DIC(9.4,PXAPKG,0),U,1)="SCHEDULING" Q ""
 I ESRC'="" Q ESRC
 I $G(SOURCE)="" D  Q 0
 . S PXAERR(7)="ENCOUNTER"
 . S PXAERR(9)="DATA2PCE parameter: SOURCE"
 . S PXAERR(12)="SOURCE is required and it is NULL."
 . D ERRSET
 N SRC
 S SRC=$$VSOURCE^PXAIVAL($G(SOURCE),.PXAERR)
 I SRC=0 D  Q 0
 . S PXAERR(7)="DATA SOURCE"
 . D ERRSET
 Q SRC
 ;
VUSER(USER) ;If the user is passed, validate it.
 I $G(USER)="" Q
 I '$D(^VA(200,USER,0)) D  Q
 . S PXAERR(7)="ENCOUNTER"
 . S PXAERR(9)="DATA2PCE parameter USER"
 . S PXAERR(11)="The value is: "_USER
 . S PXAERR(12)=USER_" is not a valid pointer to the New Person file #200."
 . D ERRSET
 Q
