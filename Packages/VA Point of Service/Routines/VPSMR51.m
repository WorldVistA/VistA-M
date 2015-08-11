VPSMR51 ;WOIFO/BT - Get the last MRAR data for a patient (Transaction Level) ;01/29/15 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 29, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; 
TRANS(VPSMRAR,DFN,LASTMRAR) ; -- retrieve conducted with level fields and store them in VPSMRAR
 ; INPUT
 ;   DFN      : Patient IEN
 ;   LASTMRAR : The last MRAR Transaction IEN for the patient
 ; OUTPUT
 ;   VPSMRAR: local array contains all field names/values for the last mrar
 ;
 N FIL S FIL=853.51
 N TRANS D GETS^DIQ(FIL,LASTMRAR_","_DFN_",","*","IE","TRANS")
 N ATTR,INVAL,EXVAL
 N SUBS S SUBS=""
 N FLD S FLD=""
 ;
 F  S FLD=$O(TRANS(FIL,LASTMRAR_","_DFN_",",FLD)) Q:'FLD  D
 . K ATTR D FIELD^DID(FIL,FLD,"","LABEL;TYPE","ATTR")
 . S INVAL=TRANS(FIL,LASTMRAR_","_DFN_",",FLD,"I")
 . S EXVAL=TRANS(FIL,LASTMRAR_","_DFN_",",FLD,"E")
 . I ATTR("TYPE")="WORD-PROCESSING" S EXVAL=$$WP^VPSMRAR9(.TRANS,FIL,SUBS,FLD),INVAL=""
 . D ADD^VPSMRAR9(.VPSMRAR,ATTR("LABEL"),SUBS,INVAL,EXVAL)
 ;
 QUIT
 ;
CNDWTH(VPSMRAR,DFN,LASTMRAR) ; -- retrieve conducted with level fields and store them in VPSMRAR
 ; INPUT
 ;   DFN      : Patient IEN
 ;   LASTMRAR : The last MRAR Transaction IEN for the patient
 ; OUTPUT
 ;   VPSMRAR: local array contains all field names/values for the last mrar
 ;
 N FIL S FIL=853.5121
 N REC,INVAL,EXVAL
 N CNDWTH S CNDWTH=0
 N ATTR D FIELD^DID(FIL,".01","","LABEL;TYPE","ATTR")
 N FLD S FLD=".01"
 ;
 F  S CNDWTH=$O(^VPS(853.5,DFN,"MRAR",LASTMRAR,"MRARWITH",CNDWTH)) Q:'CNDWTH  D
 . K REC D GETS^DIQ(FIL,CNDWTH_","_LASTMRAR_","_DFN_",","*","IE","REC")
 . S INVAL=REC(FIL,CNDWTH_","_LASTMRAR_","_DFN_",",FLD,"I")
 . S EXVAL=REC(FIL,CNDWTH_","_LASTMRAR_","_DFN_",",FLD,"E")
 . D ADD^VPSMRAR9(.VPSMRAR,ATTR("LABEL"),","_INVAL,INVAL,EXVAL)
 ;
 QUIT
