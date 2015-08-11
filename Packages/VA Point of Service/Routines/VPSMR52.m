VPSMR52 ;WOIFO/BT - Get the last MRAR data for a patient (Allergy Level) ;01/29/15 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 29, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; 
ALLERGY(VPSMRAR,DFN,LASTMRAR) ; -- retrieve Allergy level fields and store them in VPSMRAR
 ; INPUT
 ;   DFN      : Patient IEN
 ;   LASTMRAR : The last MRAR Transaction IEN for the patient
 ; OUTPUT
 ;   VPSMRAR: local array contains all field names/values for the last mrar
 ;
 N REC,INVAL,EXVAL,ALRNO,FLD,SUBS
 N FIL S FIL=853.52
 N ALRIEN S ALRIEN=0
 ;
 F  S ALRIEN=$O(^VPS(853.5,DFN,"MRAR",LASTMRAR,"ALLERGY",ALRIEN)) Q:'ALRIEN  D
 . S SUBS=ALRIEN_","_LASTMRAR_","_DFN_","
 . K REC D GETS^DIQ(FIL,SUBS,"*","IE","REC")
 . S ALRNO=REC(FIL,SUBS,.01,"I")
 . S FLD=""
 . F  S FLD=$O(REC(FIL,SUBS,FLD)) Q:'FLD  D
 . . K ATTR D FIELD^DID(FIL,FLD,"","LABEL;TYPE","ATTR")
 . . S INVAL=REC(FIL,SUBS,FLD,"I")
 . . S EXVAL=REC(FIL,SUBS,FLD,"E")
 . . I FIL=853.52,FLD=.02 S EXVAL=$$GET1^DIQ(120.8,INVAL_",",.02,"E")
 . . I ATTR("TYPE")="WORD-PROCESSING" S EXVAL=$$WP^VPSMRAR9(.REC,FIL,SUBS,FLD),INVAL=""
 . . D ADD^VPSMRAR9(.VPSMRAR,ATTR("LABEL"),","_ALRNO,INVAL,EXVAL)
 . ;
 . D ALLIND(.VPSMRAR,VPSDFN,LASTMRAR,ALRIEN,ALRNO)
 . D ALREACT(.VPSMRAR,VPSDFN,LASTMRAR,ALRIEN,ALRNO)
 ;
 QUIT
 ;
ALLIND(VPSMRAR,DFN,LASTMRAR,ALRIEN,ALRNO) ; -- retrieve Allergy Indicator level fields and store them in VPSMRAR
 ; INPUT
 ;   DFN      : Patient IEN
 ;   LASTMRAR : The last MRAR Transaction IEN for the patient
 ;   ALRIEN   : Allergy IEN
 ;   ALRNO    : Allergy Entry #
 ; OUTPUT
 ;   VPSMRAR  : local array contains all field names/values for the last mrar
 ;
 N REC,INVAL,EXVAL,ATTR,SUBS
 N FIL S FIL("ACHG")=853.525,FIL("ACNFR")=853.526,FIL("ADISCR")=853.527
 N FLD S FLD=".01"
 ;
 F IND="ACHG","ACNFR","ADISCR" D
 . K ATTR D FIELD^DID(FIL(IND),FLD,"","LABEL;TYPE","ATTR")
 . N INDIEN S INDIEN=0
 . F  S INDIEN=$O(^VPS(853.5,DFN,"MRAR",LASTMRAR,"ALLERGY",ALRIEN,IND,INDIEN)) Q:'INDIEN  D
 . . S SUBS=INDIEN_","_ALRIEN_","_LASTMRAR_","_DFN_","
 . . K REC D GETS^DIQ(FIL(IND),SUBS,"*","IE","REC")
 . . S INVAL=REC(FIL(IND),SUBS,FLD,"I")
 . . S EXVAL=REC(FIL(IND),SUBS,FLD,"E")
 . . D ADD^VPSMRAR9(.VPSMRAR,ATTR("LABEL"),","_ALRNO_","_INVAL,INVAL,EXVAL)
 ;
 QUIT
 ;
ALREACT(VPSMRAR,VPSDFN,LASTMRAR,ALRIEN,ALRNO) ; -- retrieve Allergy Reaction level fields and store them in VPSMRAR
 ; INPUT
 ;   DFN      : Patient IEN
 ;   LASTMRAR : The last MRAR Transaction IEN for the patient
 ;   ALRIEN   : Allergy IEN
 ; OUTPUT
 ;   VPSMRAR  : local array contains all field names/values for the last mrar
 ;
 N REC,INVAL,EXVAL,ATTR,FLD,SUBS,REACTNO
 N FIL S FIL=853.57
 N REACTIEN S REACTIEN=0
 ;
 F  S REACTIEN=$O(^VPS(853.5,DFN,"MRAR",LASTMRAR,"ALLERGY",ALRIEN,"REACTIONS",REACTIEN)) Q:'REACTIEN  D
 . S SUBS=REACTIEN_","_ALRIEN_","_LASTMRAR_","_DFN_","
 . K REC D GETS^DIQ(FIL,SUBS,"*","IE","REC")
 . S REACTNO=REC(FIL,SUBS,".01","I")
 . S FLD=0
 . F  S FLD=$O(REC(FIL,SUBS,FLD)) Q:'FLD  D
 . . K ATTR D FIELD^DID(FIL,FLD,"","LABEL;TYPE","ATTR")
 . . S INVAL=REC(FIL,SUBS,FLD,"I")
 . . S EXVAL=REC(FIL,SUBS,FLD,"E")
 . . I ATTR("TYPE")="WORD-PROCESSING" S EXVAL=$$WP^VPSMRAR9(.REC,FIL,SUBS,FLD),INVAL=""
 . . D ADD^VPSMRAR9(.VPSMRAR,ATTR("LABEL"),","_ALRNO_","_REACTNO,INVAL,EXVAL)
 ;
 QUIT
 ;
ADDALLER(VPSMRAR,DFN,LASTMRAR) ; -- retrieve Additional Allergy level fields and store them in VPSMRAR
 ; INPUT
 ;   DFN      : Patient IEN
 ;   LASTMRAR : The last MRAR Transaction IEN for the patient
 ; OUTPUT
 ;   VPSMRAR: local array contains all field names/values for the last mrar
 ;
 N REC,INVAL,EXVAL,ALRNO,FLD,SUBS
 N FIL S FIL=853.53
 N ALRIEN S ALRIEN=0
 ;
 F  S ALRIEN=$O(^VPS(853.5,DFN,"MRAR",LASTMRAR,"ALLERGYADD",ALRIEN)) Q:'ALRIEN  D
 . S SUBS=ALRIEN_","_LASTMRAR_","_DFN_","
 . K REC D GETS^DIQ(FIL,SUBS,"*","IE","REC")
 . S ALRNO=REC(FIL,SUBS,.01,"I")
 . S FLD=""
 . F  S FLD=$O(REC(FIL,SUBS,FLD)) Q:'FLD  D
 . . K ATTR D FIELD^DID(FIL,FLD,"","LABEL;TYPE","ATTR")
 . . S INVAL=REC(FIL,SUBS,FLD,"I")
 . . S EXVAL=REC(FIL,SUBS,FLD,"E")
 . . I ATTR("TYPE")="WORD-PROCESSING" S EXVAL=$$WP^VPSMRAR9(.REC,FIL,SUBS,FLD),INVAL=""
 . . D ADD^VPSMRAR9(.VPSMRAR,ATTR("LABEL"),","_ALRNO,INVAL,EXVAL)
 ;
 QUIT
