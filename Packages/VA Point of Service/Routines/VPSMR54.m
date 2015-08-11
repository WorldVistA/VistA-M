VPSMR54 ;WOIFO/BT - Get the last MRAR data for a patient (Medication Level) ;01/29/15 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 29, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; 
MEDS(VPSMRAR,DFN,LASTMRAR) ; -- retrieve Medication level fields and store them in VPSMRAR
 ; INPUT
 ;   DFN      : Patient IEN
 ;   LASTMRAR : The last MRAR Transaction IEN for the patient
 ; OUTPUT
 ;   VPSMRAR: local array contains all field names/values for the last mrar
 ;
 N REC,INVAL,EXVAL,MEDNO,FLD,SUBS
 N FIL S FIL=853.54
 N MEDIEN S MEDIEN=0
 ;
 F  S MEDIEN=$O(^VPS(853.5,DFN,"MRAR",LASTMRAR,"MEDS",MEDIEN)) Q:'MEDIEN  D
 . S SUBS=MEDIEN_","_LASTMRAR_","_DFN_","
 . K REC D GETS^DIQ(FIL,SUBS,"*","IE","REC")
 . S MEDNO=REC(FIL,SUBS,.01,"I")
 . S FLD=""
 . F  S FLD=$O(REC(FIL,SUBS,FLD)) Q:'FLD  D
 . . K ATTR D FIELD^DID(FIL,FLD,"","LABEL;TYPE","ATTR")
 . . S INVAL=REC(FIL,SUBS,FLD,"I")
 . . S EXVAL=REC(FIL,SUBS,FLD,"E")
 . . I ATTR("TYPE")="WORD-PROCESSING" S EXVAL=$$WP^VPSMRAR9(.REC,FIL,SUBS,FLD),INVAL=""
 . . D ADD^VPSMRAR9(.VPSMRAR,ATTR("LABEL"),","_MEDNO,INVAL,EXVAL)
 . ;
 . D MEDIND(.VPSMRAR,DFN,LASTMRAR,MEDIEN,MEDNO)
 ;
 QUIT
 ;
MEDIND(VPSMRAR,DFN,LASTMRAR,MEDIEN,MEDNO) ; -- retrieve Medication Indicator level fields and store them in VPSMRAR
 ; INPUT
 ;   DFN      : Patient IEN
 ;   LASTMRAR : The last MRAR Transaction IEN for the patient
 ;   MEDIEN   : Medication IEN
 ;   MEDNO    : Medication Entry #
 ; OUTPUT
 ;   VPSMRAR  : local array contains all field names/values for the last mrar
 ;
 N REC,INVAL,EXVAL,ATTR,SUBS
 N FIL S FIL("MCHG")=853.5454,FIL("MCNFR")=853.5455,FIL("MDISCR")=853.5452
 N FLD S FLD=".01"
 ;
 F IND="MCHG","MCNFR","MDISCR" D
 . K ATTR D FIELD^DID(FIL(IND),FLD,"","LABEL;TYPE","ATTR")
 . N INDIEN S INDIEN=0
 . F  S INDIEN=$O(^VPS(853.5,DFN,"MRAR",LASTMRAR,"MEDS",MEDIEN,IND,INDIEN)) Q:'INDIEN  D
 . . S SUBS=INDIEN_","_MEDIEN_","_LASTMRAR_","_DFN_","
 . . K REC D GETS^DIQ(FIL(IND),SUBS,"*","IE","REC")
 . . S INVAL=REC(FIL(IND),SUBS,FLD,"I")
 . . S EXVAL=REC(FIL(IND),SUBS,FLD,"E")
 . . D ADD^VPSMRAR9(.VPSMRAR,ATTR("LABEL"),","_MEDNO_","_INVAL,INVAL,EXVAL)
 ;
 QUIT
 ;
ADDMEDS(VPSMRAR,DFN,LASTMRAR) ; -- retrieve Additional Medication level fields and store them in VPSMRAR
 ; INPUT
 ;   DFN      : Patient IEN
 ;   LASTMRAR : The last MRAR Transaction IEN for the patient
 ; OUTPUT
 ;   VPSMRAR: local array contains all field names/values for the last mrar
 ;
 N REC,INVAL,EXVAL,MEDNO,FLD,SUBS
 N FIL S FIL=853.55
 N MEDIEN S MEDIEN=0
 ;
 F  S MEDIEN=$O(^VPS(853.5,DFN,"MRAR",LASTMRAR,"MEDSADD",MEDIEN)) Q:'MEDIEN  D
 . S SUBS=MEDIEN_","_LASTMRAR_","_DFN_","
 . K REC D GETS^DIQ(FIL,SUBS,"*","IE","REC")
 . S MEDNO=REC(FIL,SUBS,.01,"I")
 . S FLD=""
 . F  S FLD=$O(REC(FIL,SUBS,FLD)) Q:'FLD  D
 . . K ATTR D FIELD^DID(FIL,FLD,"","LABEL;TYPE","ATTR")
 . . S INVAL=REC(FIL,SUBS,FLD,"I")
 . . S EXVAL=REC(FIL,SUBS,FLD,"E")
 . . I ATTR("TYPE")="WORD-PROCESSING" S EXVAL=$$WP^VPSMRAR9(.REC,FIL,SUBS,FLD),INVAL=""
 . . D ADD^VPSMRAR9(.VPSMRAR,ATTR("LABEL"),","_MEDNO,INVAL,EXVAL)
 ;
 QUIT
