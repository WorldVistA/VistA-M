VAFHADT3 ;ALB/RJS - GOES THROUGH APCA & ATS CROSS-REFERENCE - 5/16/95
 ;;5.3;Registration;**91**;Jun 06, 1996
BLDHIST(DFN,ADMSSN,ARRAY) ;
 ;
 ;This Routine builds a history of an ADMISSION (ADMSSN)
 ;for a Patient with a certain (DFN)
 ;
 ;The APCA cross-reference catches all Admit Discharge Transfer
 ;(ADT) events
 ; 
 ;The ATS cross-reference catches all Specialty Transfers
 ;
 ;The History is returned in the array specified in the array
 ;variable, which can be global or local, e.g. "ZIMBA" OR "^TMP($J)"
 ;if ARRAY is "" or not-defined it is returned in local variable
 ;VAFHADT3
 ;
 ;
 Q:$G(DFN)=""!($G(ADMSSN)="")
 N VADATE,IEN,SPEC,TT,ACTDATE
 I $G(ARRAY)="" S ARRAY="VAFHADT3"
 ;
 ;--$O Through "apca" cross reference of patient movement file
 ;  looking for admission, discharge, and transfer events
 ;
 S VADATE=""
 F  S VADATE=$O(^DGPM("APCA",DFN,ADMSSN,VADATE)) Q:VADATE=""  D
 . S IEN=""
 . F  S IEN=$O(^DGPM("APCA",DFN,ADMSSN,VADATE,IEN)) Q:IEN=""  D
 . . S TT=$P($G(^DGPM(IEN,0)),"^",2),ACTDATE=$P($G(^DGPM(IEN,0)),"^",1)
 . . I TT'=""&("123"[TT) D
 . . . S @ARRAY@(ACTDATE,IEN)=$S(TT=1:"ADMISSION",TT=2:"TRANSFER",TT=3:"DISCHARGE")
 . . . I $$ASSOCTD(DFN,ADMSSN,$$CONVERT(ACTDATE)) S @ARRAY@(ACTDATE,IEN)=@ARRAY@(ACTDATE,IEN)_",SPECIALTY"
 ;
 ;--$O Through "ats" cross reference of patient movement file
 ;  looking for specialty transfer events
 ;
 S VADATE=""
 F  S VADATE=$O(^DGPM("ATS",DFN,ADMSSN,VADATE)) Q:VADATE=""  D
 . S SPEC=""
 . F  S SPEC=$O(^DGPM("ATS",DFN,ADMSSN,VADATE,SPEC)) Q:SPEC=""  D
 . . S IEN=""
 . . F  S IEN=$O(^DGPM("ATS",DFN,ADMSSN,VADATE,SPEC,IEN)) Q:IEN=""  D
 . . . S ACTDATE=$P($G(^DGPM(IEN,0)),"^",1),TT=$P($G(^DGPM(IEN,0)),"^",2)
 . . . I TT'=""&("6"[TT) D
 . . . . I '$D(@ARRAY@(ACTDATE)) S @ARRAY@(ACTDATE,IEN)="SPECIALTY"
 ;
 ;--$O through array created, looking to flag the last movement as
 ;  "LASTONE"
 ;
 Q:'$D(@ARRAY)
 S VADATE="",VADATE=$O(@ARRAY@(VADATE),-1)
 S IEN="",IEN=$O(@ARRAY@(VADATE,IEN),-1)
 S @ARRAY@(VADATE,IEN)=@ARRAY@(VADATE,IEN)_",LASTONE"
 Q
 ;
CONVERT(VADATE) ;
 Q:$G(VADATE)="" -1
 S VADATE=9999999.9999999-VADATE
 Q VADATE
ASSOCTD(DFN,ADMSSN,VADATE,IEN) ;
 N RESULT
 Q:$D(^DGPM("ATS",DFN,ADMSSN,VADATE)) 1
 Q 0
