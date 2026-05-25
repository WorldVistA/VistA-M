SDES2SRCHCLNBYSC ;ALB/JAS,JDJ,LAB - SDES2 SEARCH CLIN BY STOP CODE ;JUN 18, 2025
 ;;5.3;Scheduling;**886,907,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 Q
 ;
 ;External References
 ;-------------------
 ; Reference to $$ACTIVPRV^PXAPI is supported by IA #2349
 ;
SEARCHCLIN(SDRETURN,SDCONTEXT,SDSEARCH) ;Search for clinics
 ; The SDCONTEXT array is controlled by the Acheron application and its fields are
 ; needed for the storage of the required auditing information.
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; The SDSEARCH array contains the following array elements:
 ;  SDSEARCH("STATION") (Opt) = Station Number: If present, the search would be limited to matching clinics at the given institution.
 ;    If absent, the search would take place across all divisions/institutions. Example values: 534, 534GB.
 ;    If "STARTING STOP CODE" is not populated, "STATION" will be REQUIRED.
 ;  SDSEARCH("STARTING STOP CODE") (Opt) = The beginning range of Stop Codes to be included in the search. If "ENDING STOP CODE" is
 ;    not populated, this will be the only Stop Code to be included in the search. If "STATION" is not populated, "STARTING STOP
 ;    "CODE" is REQUIRED.
 ;  SDSEARCH("ENDING STOP CODE") (Opt) = The ending range of Stop Codes to be included in the search.
 ;    If populated, the "STARTING STOP CODE" value is REQUIRED.
 ;
 ;  * Either "STATION" or "STARTING STOP CODE" must be populated.
 ;
 ; OUTPUT - SDRETURN
 ;   List of Clinics from the HOSPITAL LOCATION (#44) file that meet the search criteria.
 ;
 K ^TMP("SDES2SRCHCLNBYSC",$J)
 N CLINLIST
 S CLINLIST=$NA(^TMP("SDES2SRCHCLNBYSC",$J,"CLINLIST")) K @CLINLIST
 S SDRETURN=$NA(^TMP("SDES2SRCHCLNBYSC",$J,"JSON")) K @SDRETURN
 ;
 N SDERRORS
 S SDSEARCH("SDDATETIME")=DT
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.SDERRORS,.SDCONTEXT)
 I $D(SDERRORS) D  Q
 . S SDERRORS("ClinicAudit",1)="" M @CLINLIST=SDERRORS
 . D ENCODE^XLFJSON(.CLINLIST,.SDRETURN) K @CLINLIST,CLINLIST,SDSEARCH("SDDATETIME")
 ;
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 D VALSRCHFLDS(.SDERRORS,.SDSEARCH)
 I $D(SDERRORS) D  Q
 . S SDERRORS("ClinicAudit",1)="" M @CLINLIST=SDERRORS
 . D ENCODE^XLFJSON(.CLINLIST,.SDRETURN) K @CLINLIST,CLINLIST,SDSEARCH("SDDATETIME")
 ;
 D GETCLINICLIST(.CLINLIST,.SDSEARCH)
 D ENCODE^XLFJSON(.CLINLIST,.SDRETURN)
 K @CLINLIST,CLINLIST,SDSEARCH("SDDATETIME")
 Q
 ;
VALSRCHFLDS(SDERRORS,SDSEARCH) ; validate incoming search parameters
 ; Input - SDERRORS = passed in by reference, represents the errors that could be generated when validating the search string
 ; STATION = Station Number for Division
 ; STARTING STOP CODE = Stop Code to search against or beginning of a Stop Code range, if ENDING STOP CODE is defined
 ; ENDING STOP CODE = The last Stop Code in a range to search against
 N SDSTATION,STOPCDSTART,STOPCDEND
 ;
 S SDSTATION=$G(SDSEARCH("STATION"))
 I SDSTATION'="" D VALSTATIONNUM^SDES2VAL4(.SDERRORS,SDSTATION,DT)
 Q:$D(SDERRORS)
 ;
 S STOPCDSTART=$G(SDSEARCH("STARTING STOP CODE"))
 S STOPCDEND=$G(SDSEARCH("ENDING STOP CODE"))
 I $L(STOPCDSTART),'$D(^DIC(40.7,"C",STOPCDSTART)) D ERRLOG^SDESJSON(.SDERRORS,270) Q
 I $L(STOPCDEND),'$D(^DIC(40.7,"C",STOPCDEND)) D ERRLOG^SDESJSON(.SDERRORS,270) Q
 ;
 I STOPCDSTART=""&(STOPCDEND'="") D ERRLOG^SDESJSON(.SDERRORS,578) Q
 I SDSTATION=""&(STOPCDSTART="") D ERRLOG^SDESJSON(.SDERRORS,577) Q
 I STOPCDSTART'=""&(STOPCDEND'="")&(STOPCDSTART>STOPCDEND) D ERRLOG^SDESJSON(.SDERRORS,579) Q
 ;
 Q
 ;
GETCLINICLIST(CLINLIST,SDSEARCH) ; pull matching clinics using the first input parameter passed in by the RPC
 ; Input -
 ; SDSEARCH = Search array values, including Station Number and/or Stop Code (Stop Code range)
 ; CLINLIST = passed in by reference; represents the temp global that will be returned as output
 ; Output - CLINLIST = Temp global with list of clinic names and clinic IENs.
 N CLNIEN,SDCLINCNT,SDDATETIME,STOPCODESTART,STOPCODEEND,SDSTATION
 S STOPCODESTART=$G(SDSEARCH("STARTING STOP CODE"))
 S STOPCODEEND=$G(SDSEARCH("ENDING STOP CODE"))
 S SDSTATION=$G(SDSEARCH("STATION"))
 S SDDATETIME=$G(SDSEARCH("SDDATETIME"))
 ;
 I $L(STOPCODESTART),'$L(STOPCODEEND) S STOPCODEEND=STOPCODESTART
 ;
 S (CLNIEN,SDCLINCNT)=0
 F  S CLNIEN=$O(^SC(CLNIEN)) Q:'CLNIEN  I $D(^SC(CLNIEN,0)) D
 . I $L(SDSTATION) Q:$$WRONGDIVISION(CLNIEN,SDSTATION)
 . Q:$$INACTIVE^SDES2UTIL(CLNIEN,SDDATETIME)
 . I $L(STOPCODESTART) Q:$$WRONGSTOPCODE(CLNIEN,STOPCODESTART,STOPCODEEND)
 . S SDCLINCNT=SDCLINCNT+1
 . D BUILDRETURN(CLNIEN,SDCLINCNT,.CLINLIST,.SDDATETIME)
 I SDCLINCNT=0 S @CLINLIST@("ClinicAudit",1)="No Clinics returned for the criteria entered"
 Q
 ;
BUILDRETURN(SDCLINICIEN,SDCLINCNT,CLINLIST,SDDATETIME) ;Build return array with clinic data
 ; input - SDCLINICIEN = IEN of clinic in #44
 ; CLINLIST = passed by reference, represents the temp global of clinics and associated data that will be returned
 ; output - CLINLIST = clinic temp global and their associated data to be sent back to the client
 ;
 N SDFIELDS,SDDATA,SDPRVCNT,SDCLINPROVIDER,SDPROVIDERID,SDPROVIDERNAME,SDDEFAULTPROV,SDPROVIDERSECID
 N SDSICNT,SDSPECINIEN,SDSPECINSTRUCT
 S SDFIELDS=".01;3.5;8;10;16;20;21;60;61;62;99;99.1;1912;1918;2002;2502;2503;2508;2509;2510;2511"
 D GETS^DIQ(44,SDCLINICIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"ClinicIEN")=SDCLINICIEN
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"DivisionName")=$G(SDDATA(44,SDCLINICIEN_",",3.5,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"ClinicName")=$G(SDDATA(44,SDCLINICIEN_",",.01,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"PatientFriendlyName")=$G(SDDATA(44,SDCLINICIEN_",",60,"E"))
 ; initialize default provider fields to null to ensure they are always defined (in the event no default provider is found)
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"DefaultProviderActive")=""
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"DefaultProviderIEN")=""
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"DefaultProviderName")=""
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"DefaultProviderSecID")=""
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"StopCodeIEN")=$G(SDDATA(44,SDCLINICIEN_",",8,"I"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"StopCodeName")=$G(SDDATA(44,SDCLINICIEN_",",8,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"StopCodeAMIS")=$$GET1^DIQ(40.7,$G(SDDATA(44,SDCLINICIEN_",",8,"I")),1,"I")
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"CreditStopCodeIEN")=$G(SDDATA(44,SDCLINICIEN_",",2503,"I"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"CreditStopCodeName")=$G(SDDATA(44,SDCLINICIEN_",",2503,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"CreditStopCodeAMIS")=$$GET1^DIQ(40.7,$G(SDDATA(44,SDCLINICIEN_",",2503,"I")),1,"I")
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"NonCountClinic")=$G(SDDATA(44,SDCLINICIEN_",",2502,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"ECheckIn")=$G(SDDATA(44,SDCLINICIEN_",",20,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"PreCheckIn")=$G(SDDATA(44,SDCLINICIEN_",",21,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"PhysicalLocation")=$G(SDDATA(44,SDCLINICIEN_",",10,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"DirectScheduling")=$G(SDDATA(44,SDCLINICIEN_",",61,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"DisplayApptToPats")=$G(SDDATA(44,SDCLINICIEN_",",62,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"Telephone")=$$TELEPHONE^SDES2UTIL($G(SDDATA(44,SDCLINICIEN_",",99,"E")))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"TelephoneExt")=$$EXT^SDES2UTIL($G(SDDATA(44,SDCLINICIEN_",",99.1,"E")))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"ApptLength")=$G(SDDATA(44,SDCLINICIEN_",",1912,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"OverbooksPerDay")=$G(SDDATA(44,SDCLINICIEN_",",1918,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"MaxDaysForFuture")=$G(SDDATA(44,SDCLINICIEN_",",2002,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"NoShowLetter")=$G(SDDATA(44,SDCLINICIEN_",",2508,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"PreApptLetter")=$G(SDDATA(44,SDCLINICIEN_",",2509,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"ClinicCancelLetter")=$G(SDDATA(44,SDCLINICIEN_",",2510,"E"))
 S @CLINLIST@("ClinicAudit",SDCLINCNT,"ApptCancelLetter")=$G(SDDATA(44,SDCLINICIEN_",",2511,"E"))
 ;
 S SDSICNT=0
 S SDSPECINIEN=0 F  S SDSPECINIEN=$O(^SC(SDCLINICIEN,"SI",SDSPECINIEN)) Q:'SDSPECINIEN  D
 . S SDSPECINSTRUCT=$$GET1^DIQ(44.03,SDSPECINIEN_","_SDCLINICIEN_",",.01,"E")
 . S SDSICNT=SDSICNT+1
 . S @CLINLIST@("ClinicAudit",SDCLINCNT,"SpecialInstructions",SDSICNT,"InstructionText")=SDSPECINSTRUCT
 ; set empty object if no records are found
 I '$D(@CLINLIST@("ClinicAudit",SDCLINCNT,"SpecialInstructions")) S @CLINLIST@("ClinicAudit",SDCLINCNT,"SpecialInstructions",1)=""
 ;
 S SDPRVCNT=0
 S SDCLINPROVIDER=0 F  S SDCLINPROVIDER=$O(^SC(SDCLINICIEN,"PR",SDCLINPROVIDER)) Q:'SDCLINPROVIDER  D
 . S SDPROVIDERID=$$GET1^DIQ(44.1,SDCLINPROVIDER_","_SDCLINICIEN_",",.01,"I")
 . S SDPROVIDERNAME=$$GET1^DIQ(200,SDPROVIDERID,.01,"E")
 . S SDPROVIDERSECID=$$GET1^DIQ(200,SDPROVIDERID,205.1,"I")
 . S SDDEFAULTPROV=$$GET1^DIQ(44.1,SDCLINPROVIDER_","_SDCLINICIEN_",",.02,"I")
 . I SDDEFAULTPROV D  Q
 . . S @CLINLIST@("ClinicAudit",SDCLINCNT,"DefaultProviderIEN")=SDPROVIDERID
 . . S @CLINLIST@("ClinicAudit",SDCLINCNT,"DefaultProviderName")=$$GET1^DIQ(200,SDPROVIDERID,.01,"E")
 . . S @CLINLIST@("ClinicAudit",SDCLINCNT,"DefaultProviderSecID")=SDPROVIDERSECID
 . . S @CLINLIST@("ClinicAudit",SDCLINCNT,"DefaultProviderActive")=$$ACTIVPRV^PXAPI(SDPROVIDERID,$G(SDDATETIME))
 . S SDPRVCNT=SDPRVCNT+1
 . S @CLINLIST@("ClinicAudit",SDCLINCNT,"Providers",SDPRVCNT,"Name")=SDPROVIDERNAME
 . S @CLINLIST@("ClinicAudit",SDCLINCNT,"Providers",SDPRVCNT,"ID")=SDPROVIDERID
 . S @CLINLIST@("ClinicAudit",SDCLINCNT,"Providers",SDPRVCNT,"SecID")=SDPROVIDERSECID
 . S @CLINLIST@("ClinicAudit",SDCLINCNT,"Providers",SDPRVCNT,"Active")=$$ACTIVPRV^PXAPI(SDPROVIDERID,$G(SDDATETIME))
 ; set empty object if no records are found
 I '$D(@CLINLIST@("ClinicAudit",SDCLINCNT,"Providers")) S @CLINLIST@("ClinicAudit",SDCLINCNT,"Providers",1)=""
 Q
 ;
WRONGDIVISION(SDCLINICIEN,STATION) ;
 ; Screen out Clinics that don't match passed in Station Number
 N SDDIVISION,FACNUM
 S SDDIVISION=$$GET1^DIQ(44,SDCLINICIEN,3.5,"I")
 S FACNUM=$$GET1^DIQ(40.8,SDDIVISION,1,"I")
 I FACNUM'=STATION Q 1
 Q 0
 ;
WRONGSTOPCODE(SDCLINICIEN,STOPCODESTART,STOPCODEEND) ;
 ; Screen out Clinics that don't match the passed in Stop Codes
 N STOPCDIEN,STOPCODE
 S STOPCDIEN=$$GET1^DIQ(44,SDCLINICIEN,8,"I")
 S STOPCODE=$$GET1^DIQ(40.7,STOPCDIEN,1,"I")
 I STOPCODE<STOPCODESTART!(STOPCODE>STOPCODEEND) Q 1
 Q 0
 ;
