PXAIVSTV ;ISL/JVS,PKR ISA/KWP - VALIDATE THE VISIT DATA ;04/02/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**9,15,19,74,111,116,130,124,168,211**;Aug 12, 1996;Build 244
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
 ;required.
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
 I $G(PXAA("CHECKOUT D/T"))'="" D
 .;Is it a valid FileMan date?
 . I $$VFMDATE^PXDATE(PXAA("CHECKOUT D/T"),"ESTXR")=-1 D  Q
 .. S PXAERR(9)="CHECKOUT D/T"
 .. S PXAERR(11)=PXAA("CHECKOUT D/T")
 .. S PXAERR(12)="The checkout date and time is not a valid FileMan date and time."
 .. D ERRSET
 . I $G(STOP)=1 Q
 .;The checkout D/T should not be before the visit D/T.
 . I PXAA("CHECKOUT D/T")<PXAA("ENC D/T") D
 .. S PXAERR(9)="CHECKOUT D/T"
 .. S PXAERR(11)=PXAA("CHECKOUT D/T")
 .. S PXAERR(12)="The checkout D/T is before the encounter D/T."
 .. D ERRSET
 I $G(STOP)=1 Q
 ;
 ;Is the pointer to the eligibility file valid?
 I $G(PXAA("ELIGIBILITY"))'="",'$D(^DIC(8,PXAA("ELIGIBILITY"),0)) D  Q
 . S PXAERR(9)="ELIGIBILITY"
 . S PXAERR(11)=PXAA("ELIGIBILITY")
 . S PXAERR(12)=PXAA("ELIGIBILITY")_" is not a valid pointer to the Eligibility file #8."
 . D ERRSET
 ;
 ;Is the pointer to the Location valid?
 I $G(PXAA("INSTITUTION"))'="",'$D(^AUTTLOC(PXAA("INSTITUTION"),0)) D  Q
 . S PXAERR(9)="INSTITUTION"
 . S PXAERR(11)=PXAA("INSTITUTION")
 . S PXAERR(12)=PXAA("INSTITUTION")_" is not a valid pointer to the Location file #9999999.06."
 . D ERRSET
 ;
 ;Is the Outside Location valid?
 I $G(PXAA("OUTSIDE LOCATION"))'="",(($L(PXAA("OUTSIDE LOCATION"))<2)!($L(PXAA("OUTSIDE LOCATION"))>50)) D  Q
 . S PXAERR(9)="OUTSIDE LOCATION"
 . S PXAERR(11)=PXAA("OUTSIDE LOCATION")
 . S PXAERR(12)="The length of the Outside Location is either less than 2 or greater than 50."
 . D ERRSET
 ;
 ;Is the Comment valid?
 I $G(PXAA("COMMENT"))'="",(($L(PXAA("COMMENT"))<1)!($L(PXAA("COMMENT"))>245)) D  Q
 . S PXAERR(9)="COMMENT"
 . S PXAERR(11)=PXAA("COMMENT")
 . S PXAERR(12)="The length of the Comment is either less than 2 or greater than 245."
 . D ERRSET
 ;
 ;If an Encounter Type is being input validate it.
 I $G(PXAA("ENCOUNTER TYPE"))'="" D
 . N EXTERNAL,MSG
 . S EXTERNAL=$$EXTERNAL^DILFD(9000010,15003,"",PXAA("ENCOUNTER TYPE"),"MSG")
 . I (EXTERNAL=""),$D(MSG) D
 .. S PXAERR(12)=MSG("DIERR",1,"TEXT",1)
 .. S PXAERR(13)=MSG("DIERR",1,"TEXT",2)
 .. D ERRSET
 Q
 ;
VALSCC ;--VALIDATE SERVICE CONNECTIVENESS
 N ERR,ERR1,ERRMSG
 D SCC^PXUTLSCC($G(PXAA("PATIENT")),$G(PXAA("ENC D/T")),$G(PXAA("HOS LOC")),$G(PXAVISIT),$G(AFTER800),.AFTER8A,.ERR)
 ;PX*1*111 - Add HNC
 I $P(ERR,"^",1)=0,$P(ERR,"^",2)=0,$P(ERR,"^",3)=0,$P(ERR,"^",4)=0,$P(ERR,"^",5)=0,$P(ERR,"^",6)=0,$P(ERR,"^",7)=0,$P(ERR,"^",8)=0 Q
 ;
 S ERRMSG(-1)="Not a valid value"
 S ERRMSG(-2)="Value must be NULL"
 S ERRMSG(-3)="Must be NULL because Service Connected is yes"
 S ERRMSG(0)="No error"
 S ERRMSG(1)="Should be a YES or NO!, not NULL"
 ;
 S PXADI("DIALOG")=8390001.003
 S PXAERRW=1
 ;
 S PXAERR("1W")=$S($P(AFTER800,"^",1)']"":"NULL",1:$P(AFTER800,"^",1))
 S PXAERR("2W")=$S($P(AFTER800,"^",2)']"":"NULL",1:$P(AFTER800,"^",2))
 S PXAERR("3W")=$S($P(AFTER800,"^",3)']"":"NULL",1:$P(AFTER800,"^",3))
 S PXAERR("4W")=$S($P(AFTER800,"^",4)']"":"NULL",1:$P(AFTER800,"^",4))
 S PXAERR("5W")=$S($P(AFTER800,"^",5)']"":"NULL",1:$P(AFTER800,"^",5))
 ;PX*1*111 - Add HNC
 S PXAERR("16W")=$S($P(AFTER800,"^",6)']"":"NULL",1:$P(AFTER800,"^",6))
 S PXAERR("19W")=$S($P(AFTER800,"^",7)']"":"NULL",1:$P(AFTER800,"^",7))
 S PXAERR("22W")=$S($P(AFTER800,"^",8)']"":"NULL",1:$P(AFTER800,"^",8))
 ;
 S ERR1=$P(ERR,"^",1),PXAERR("6W")=ERRMSG(ERR1)
 S ERR1=$P(ERR,"^",2),PXAERR("7W")=ERRMSG(ERR1)
 S ERR1=$P(ERR,"^",3),PXAERR("8W")=ERRMSG(ERR1)
 S ERR1=$P(ERR,"^",4),PXAERR("9W")=ERRMSG(ERR1)
 S ERR1=$P(ERR,"^",5),PXAERR("10W")=ERRMSG(ERR1)
 ;PX*1*111 - Add HNC
 S PXAERR("11W")=$S($P(AFTER8A,"^",1)']"":"NULL",1:$P(AFTER8A,"^",1))
 S PXAERR("12W")=$S($P(AFTER8A,"^",2)']"":"NULL",1:$P(AFTER8A,"^",2))
 S PXAERR("13W")=$S($P(AFTER8A,"^",3)']"":"NULL",1:$P(AFTER8A,"^",3))
 S PXAERR("14W")=$S($P(AFTER8A,"^",4)']"":"NULL",1:$P(AFTER8A,"^",4))
 S PXAERR("15W")=$S($P(AFTER8A,"^",5)']"":"NULL",1:$P(AFTER8A,"^",5))
 ;
 S ERR1=$P(ERR,"^",6),PXAERR("17W")=ERRMSG(ERR1)
 S ERR1=$P(ERR,"^",7),PXAERR("20W")=ERRMSG(ERR1)
 S ERR1=$P(ERR,"^",8),PXAERR("23W")=ERRMSG(ERR1)
 ;PX*1*111 - Add HNC
 S PXAERR("18W")=$S($P(AFTER8A,"^",6)']"":"NULL",1:$P(AFTER8A,"^",6))
 S PXAERR("21W")=$S($P(AFTER8A,"^",7)']"":"NULL",1:$P(AFTER8A,"^",7))
 S PXAERR("24W")=$S($P(AFTER8A,"^",8)']"":"NULL",1:$P(AFTER8A,"^",8))
 D ERR^PXAI("SCC",1)
 Q
 ;
VPKG(EPKG,PKG) ;Is the Package parameter valid?
 N PIEN
 S PIEN=$$VPKG^PXAIVAL($G(PKG),.PXAERR)
 I (EPKG'=""),(PIEN>0),(EPKG'=PIEN) D  Q EPKG
 . S PXAERR(7)="PACKAGE"
 . S PXAERR(9)=PKG
 . S PXAERR(12)="PACKAGE cannot be edited."
 . S PXAERRW=1
 . S PXADI("DIALOG")=8390001.002
 I EPKG'="" Q EPKG
 I PIEN=0 D  Q 0
 . S PXAERR(7)="PACKAGE"
 . D ERRSET
 Q PIEN
 ;
VPTR(VISITIEN) ;Is the Visit pointer valid?
 I '$D(^AUPNVSIT(VISITIEN,0)) D
 . S PXAERR(7)="DATA SOURCE"
 . S PXAERR(9)="DATA2PCE parameter: VISIT"
 . S PXAERR(11)=VISITIEN
 . S PXAERR(12)="The Visit pointer that was input is not valid."
 . D ERRSET
 Q
 ;
VSOURCE(ESRC,SOURCE) ;Is the Data Source valid?
 N SRC
 S SRC=$$VSOURCE^PXAIVAL($G(SOURCE),.PXAERR)
 I (ESRC'=""),(SRC>0),(ESRC'=SRC) D  Q ESRC
 . S PXAERR(7)="DATA SOURCE"
 . S PXAERR(9)=SRC
 . S PXAERR(12)="DATA SOURCE cannot be edited."
 . S PXAERRW=1
 . S PXADI("DIALOG")=8390001.002
 I ESRC'="" Q ESRC
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
 ;
