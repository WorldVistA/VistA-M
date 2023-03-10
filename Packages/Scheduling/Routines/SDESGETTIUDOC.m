SDESGETTIUDOC  ;ALB/RRM - VISTA SCHEDULING GET TIU DOCUMENT BY CONTEXT RPC; Oct 07, 2022@15:02
 ;;5.3;Scheduling;**827**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$CONTEXT^TIUSRVLO            is supported by IA #2865
 ; Reference to GETS^DIQ                      is supported by IA #2056
 ; Reference to $$FIND1^DIC                   is supported by IA #2051
 ; Reference to ENCODE^XLFJSON                is supported by IA #6682
 ; Reference to Direct Global Read access to  is supported by IA #2937
 ;              TIU DOCUMENT File #8925
 ; Reference to Direct Global Read access to  is supported by IA #5897
 ;              TIU DOCUMENT File #8925.1
 ; Reference to ^VA(200                       is supported by IA #10060
 ;
 Q  ;No Direct Call
 ;
 ; The parameter list for this RPC must be kept in sync.
 ; If you need to add or remove a parameter, ensure that the Remote Procedure File #8994 definition is also updated.
TIUDOCBYCONTEXT(JSONRETURN,CLASS,CONTEXT,DFN,BEGINDATE,ENDDATE,PERSON,OCCLIM,SEQUENCE,SHOWADD,INCUND,SHOW,TIUIEN,EAS) ; ep: SDES GET TIU DOC BY CONTEXT RPC
 ; Input:
 ;   CLASS     [Required]  - Pointer to TIU DOCUMENT DEFINITION #8925.1
 ;                           (e.g. 3 for PROGRESS NOTES, 244 for DISCHARGE SUMMARIES)
 ;   CONTEXT   [Required]  - 1=All Signed (by PT),
 ;                           2="Unsigned (by PT&(AUTHOR!TRANSCRIBER))
 ;                           3="Uncosigned (by PT&EXPECTED COSIGNER
 ;                           4="Signed notes (by PT&selected author)
 ;                           5="Signed notes (by PT&date range)
 ;   DFN       [Required]  - Pointer to Patient File#2
 ;   BEGINDATE [Optional]  - The beginning date/time in ISO 8601 Time Format to start for the search.
 ;   ENDDATE   [Optional]  - The ending date/time in ISO 8601 Time Format to start for the search.
 ;   PERSON    [Optional]  - Pointer to file 200 (The program will use the default DUZ if not passed)
 ;   OCCLIM    [Optional]  - The number of documents/records to the return array
 ;   SEQUENCE  [Optional]  - "A"=ascending (Regular date/time)
 ;                           "D"=descending (Reverse date/time) (dflt)
 ;   SHOWADD   [Optional]  - Boolean: Include addenda in the return array, when their parent documents are identified by the search
 ;   INCUND    [Optional]  - Boolean: Include Undictated and Untranscribed documents along with Unsigned documents, when the CONTEXT is 2.
 ;   SHOW      [Optional]  - Boolean: Return "0^SHOW MORE" in return
 ;                           array when additional notes available for
 ;                           context of 1 or 5 when occurrence limit
 ;                           prevents all notes from displaying
 ;   TIUIEN    [Optional]  - Starting TIU IEN for additional return
 ;                           when "SHOW MORE" was received in previous
 ;                           return array (LATE date/time will be set
 ;                           to Reference date of this TIU document)
 ;   EAS       [Optional]  - The Enterprise Appointment Scheduling (EAS) Tracking Number associated to an appointment.
 ;
 ; Output:
 ;  Successful Return:
 ;    JSONRETURN = Returns the TIU DOCUMENT data in JSON formatted string.
 ;    Otherwise, JSON Errors will be returned for any invalid/missing parameters.
 ;
 N TMPTIU,RETURN,ERRORS
 D INITVAR
 D VALIDATECLASS(.ERRORS,CLASS)
 D VALIDATECONTEXT(.ERRORS,CONTEXT)
 D VALIDATEDFN(.ERRORS,DFN)
 D VALBEGENDDATE(.ERRORS,BEGINDATE,ENDDATE)
 D VALIDATEPERSON(.ERRORS,PERSON)
 D VALIDATEOCCLIM(.ERRORS,OCCLIM)
 D VALIDATESEQ(.ERRORS,SEQUENCE)
 D VALIDATESHOWADD(.ERRORS,SHOWADD)
 D VALIDATEINCUND(.ERRORS,INCUND)
 D VALIDATESHOW(.ERRORS,SHOW)
 D VALIDATETIUIEN(.ERRORS,TIUIEN)
 D VALIDATEEAS^SDESINPUTVALUTL(.ERRORS,EAS)
 I $D(ERRORS) M RETURN=ERRORS  D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.RETURN) Q
 D CONTEXT^TIUSRVLO(.TMPTIU,CLASS,CONTEXT,DFN,BEGINDATE,ENDDATE,PERSON,OCCLIM,SEQUENCE,SHOWADD,INCUND,SHOW,TIUIEN)
 D BUILDDATA(.TMPTIU,.RETURN,DFN)
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.RETURN)
 Q
 ;
BUILDDATA(TMPTIU,RETURN,DFN) ;
 N RECNT,CLINICIEN,TIUDATA,ERR,EPBEGDATETIME,EPENDDATETIME
 K RETURN
 S RECNT=0 F  S RECNT=$O(@TMPTIU@(RECNT)) Q:RECNT=""  D
 . S TIUIEN=$P(@TMPTIU@(RECNT),"^")
 . S RETURN("TIUDocument",RECNT,"DocumentIEN")=TIUIEN
 . S RETURN("TIUDocument",RECNT,"DocumentPrintName")=$P(@TMPTIU@(RECNT),"^",2)
 . S RETURN("TIUDocument",RECNT,"NoteDateTime")=$$FMTISO^SDAMUTDT($P(@TMPTIU@(RECNT),"^",3))
 . S RETURN("TIUDocument",RECNT,"PatientName")=$$GET1^DIQ(2,DFN,.01,"E")
 . S RETURN("TIUDocument",RECNT,"PatientDFN")=$G(DFN)
 . S RETURN("TIUDocument",RECNT,"Last4SSN")=$$LAST4SSN^SDESINPUTVALUTL($G(DFN))
 . S RETURN("TIUDocument",RECNT,"Author")=$P($P(@TMPTIU@(RECNT),"^",5),";",3)
 . S RETURN("TIUDocument",RECNT,"AuthorDUZ")=$P($P(@TMPTIU@(RECNT),"^",5),";")
 . S RETURN("TIUDocument",RECNT,"SignatureBlockName")=$P($P(@TMPTIU@(RECNT),"^",5),";",2)
 . S RETURN("TIUDocument",RECNT,"HospitalLocation")=$P(@TMPTIU@(RECNT),"^",6)
 . S RETURN("TIUDocument",RECNT,"Status")=$P(@TMPTIU@(RECNT),"^",7)
 . S RETURN("TIUDocument",RECNT,"RequestingPackageVariablePointer")=$P(@TMPTIU@(RECNT),"^",10)
 . S RETURN("TIUDocument",RECNT,"ImageCount")=$P(@TMPTIU@(RECNT),"^",11)
 . S RETURN("TIUDocument",RECNT,"Subject")=$P(@TMPTIU@(RECNT),"^",12)
 . S RETURN("TIUDocument",RECNT,"HasChildren")=$P(@TMPTIU@(RECNT),"^",13)
 . S RETURN("TIUDocument",RECNT,"IENOfParentDocument")=$P(@TMPTIU@(RECNT),"^",14)
 . ;
 . S CLINICIEN=$$FIND1^DIC(44,"","X",$P(@TMPTIU@(RECNT),"^",6),"B")
 . S RETURN("TIUDocument",RECNT,"HospitalLocationIEN")=CLINICIEN
 . S EPBEGDATETIME=$$CVTTOFM^SDAMUTDT($TR($P($P(@TMPTIU@(RECNT),"^",8),":",2)," ",""))
 . S EPENDDATETIME=$$CVTTOFM^SDAMUTDT($TR($P($P(@TMPTIU@(RECNT),"^",9),":",2)," ",""))
 . S RETURN("TIUDocument",RECNT,"EpisodeBeginDateTime")=$S(EPBEGDATETIME<1:"",1:$$FMTISO^SDAMUTDT(EPBEGDATETIME,$G(CLINICIEN)))
 . S RETURN("TIUDocument",RECNT,"EpisodeEndDateTime")=$S(EPENDDATETIME<1:"",1:$$FMTISO^SDAMUTDT(EPENDDATETIME,$G(CLINICIEN)))
 . S RETURN("TIUDocument",RECNT,"TypeOfLocation")=$P($P(@TMPTIU@(RECNT),"^",8),":",1)
 . ;
 . K TIUDATA,ERR
 . D GETS^DIQ(8925,TIUIEN_",","1205;1206;1207;1211","IE","TIUDATA","ERR")
 . S RETURN("TIUDocument",RECNT,"VisitLocationName")=$G(TIUDATA(8925,TIUIEN_",",1211,"E"))
 . S RETURN("TIUDocument",RECNT,"VisitLocationIEN")=$G(TIUDATA(8925,TIUIEN_",",1211,"I"))
 ;If no record found, set the object equals to null
 I $O(RETURN("TIUDocument",""))="" S RETURN("TIUDocument",1)=""
 Q
 ;
VALIDATECLASS(ERRORS,CLASS) ;
 N ERR,SDTIUCLASSIEN
 I $G(CLASS)="" D ERRLOG^SDESJSON(.ERRORS,329) Q
 S SDTIUCLASSIEN=$$FIND1^DIC(8925.1,"","","`"_$G(CLASS),"","","ERR")
 I +SDTIUCLASSIEN<1 D ERRLOG^SDESJSON(.ERRORS,328)
 Q
 ;
VALIDATECONTEXT(ERRORS,CONTEXT) ;
 I $G(CONTEXT)="" D ERRLOG^SDESJSON(.ERRORS,330) Q
 I $G(CONTEXT)'="",(+CONTEXT<1!(+CONTEXT>5)) D ERRLOG^SDESJSON(.ERRORS,331) Q
 Q
 ;
VALIDATEDFN(ERRORS,DFN) ;
 D VALIDATEDFN^SDESINPUTVALUTL(.ERRORS,DFN)
 Q
 ;
VALBEGENDDATE(ERRORS,BEGINDATE,ENDDATE) ;
 I BEGINDATE'="" D
 . S BEGINDATE=$$ISOTFM^SDAMUTDT(BEGINDATE)
 . I BEGINDATE=-1 S BEGINDATE=""
 ;
 I ENDDATE'="" D
 . S ENDDATE=$$ISOTFM^SDAMUTDT(ENDDATE)
 . I ENDDATE=-1 S ENDDATE=""
 ;
 I $G(BEGINDATE)'=-1,$G(ENDDATE)'=-1,BEGINDATE>ENDDATE D ERRLOG^SDESJSON(.ERRORS,29)
 Q
 ;
VALIDATEPERSON(ERRORS,PERSON) ;
 I PERSON'="",'$D(^VA(200,DUZ,0)) S PERSON=""
 Q
 ;
VALIDATEOCCLIM(ERRORS,OCCLIM) ;
 I +$G(OCCLIM)'>0 S OCCLIM=""
 Q
 ;
VALIDATESEQ(ERRORS,SEQUENCE) ;
 I $G(SEQUENCE)'="",(SEQUENCE'="A"!(SEQUENCE'="D")) S SEQUENCE=""
 Q
 ;
VALIDATESHOWADD(ERRORS,SHOWADD) ;
 I ($G(SHOWADD)'="")&(SHOWADD'?1N!(SHOWADD>1)) S SHOWADD=""
 Q
 ;
VALIDATEINCUND(ERRORS,INCUND) ;
 I ($G(INCUND)'="")&(INCUND'?1N!(INCUND>1)) S INCUND=""
 Q
 ;
VALIDATESHOW(ERRORS,SHOW) ;
 I ($G(SHOW)'="")&(SHOW'?1N!(SHOW>1)) S SHOW=""
 Q
 ;
VALIDATETIUIEN(ERRORS,TIUEN) ;
 I $G(TIUIEN)'="",'$D(^TIU(8925,+TIUIEN,0)) S TIUIEN=""
 Q
 ;
INITVAR ;Initialize input parameter variables
 S CLASS=$G(CLASS)
 S CONTEXT=$G(CONTEXT)
 S DFN=$G(DFN)
 S BEGINDATE=$G(BEGINDATE)
 S ENDDATE=$G(ENDDATE)
 S DUZ=$G(DUZ)
 S PERSON=$G(PERSON)
 S OCCLIM=$G(OCCLIM)
 S SEQUENCE=$G(SEQUENCE)
 S SHOWADD=$G(SHOWADD)
 S INCUND=$G(INCUND)
 S SHOW=$G(SHOW)
 S TIUIEN=$G(TIUIEN)
 S EAS=$G(EAS)
 Q
 ;
