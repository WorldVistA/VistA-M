SDES2CRTAPREQ2 ;ALB/TAW,JHC - CREATE APPOINTMENT REQUEST ; DEC 11, 2025
 ;;5.3;Scheduling;**915,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 Q
 ; RPC: SDES2 CREATE APPT REQ
 ;
 ; SDCONTEXT INPUT
 ;
 ;S SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ;S SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ;S SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;S SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ;S SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ;
 ; REQUEST INPUT FORMAT
 ;
 ;S REQUEST("DFN")=""                                       REQ (PATIENT IEN)
 ;S REQUEST("APPOINTMENT TYPE")=""                          REQ - APPOINTMENT TYPE - can be the Name or IEN
 ;S REQUEST("PATIENT INDICATED DATE")=""                    REQ (PID DATE IN ISO FORMAT)
 ;S REQUEST("PRIORITY")=""                                  REQ
 ;S REQUEST("REQUEST SUB TYPE")=""                          REQ
 ;S REQUEST("REQUESTED BY")=""                              REQ
 ;S REQUEST("CLINIC IEN")=""                                OPT/REQ  \
 ;S REQUEST("PRIMARY AMIS")=""                              OPT/REQ---> Either CLINIC IEN or PRIMARY AMIS/CREDIT PRIMARY AMIS must be defined
 ;S REQUEST("CREDIT AMIS")=""                               OPT/REQ  /
 ;S REQUEST("STATION NUMBER")=""                            OPT/REQ -- > Either STATION NUMBER or INSTITUTION NAME is REQUIRED
 ;S REQUEST("INSTITUTION NAME")=""                          OPT/REQ --/
 ;S REQUEST("CREATE DATE")=""                               OPT - Defaults to today if not sent
 ;S REQUEST("PROVIDER IEN")=""                              OPT  (Required if 'REQUESTED BY' is 'PROVIDER')
 ;S REQUEST("PRIORITY GROUP")=""                            OPT
 ;S REQUEST("SERVICE CONNECTED")=""                         OPT  (This is for PRIORITY; 1 OR 0, if passed)
 ;S REQUEST("SERVICE CONNECTED PERCENTAGE")=""              OPT
 ;S REQUEST("MODALITY")=""                                  OPT
 ;S REQUEST("PATIENT STATUS")=""                            OPT
 ;S REQUEST("VAOS GUID")=""                                 OPT
 ;S REQUEST("TIME SENSITIVE")=""                            OPT
 ;S REQUEST("REQUEST COMMENT")=""                           OPT
 ;S REQUEST("PATIENT COMMENT")=""                           OPT
 ;S REQUEST("PATIENT PREFERRED START DATE",1)=""            OPT
 ;S REQUEST("PATIENT PREFERRED END DATE",1)=""              OPT
 ;S REQUEST("PATIENT PREFERRED START DATE",2)=""            OPT
 ;S REQUEST("PATIENT PREFERRED END DATE",2)=""              OPT
 ;S REQUEST("PATIENT PREFERRED START DATE",3)=""            OPT
 ;S REQUEST("PATIENT PREFERRED END DATE",3)=""              OPT
 ;S REQUEST("MRTC","NEEDED")=""                             OPT (YES/NO)
 ;S REQUEST("MRTC","PARENT REQUEST")=""                     OPT
 ;S REQUEST("MRTC","DAYS BETWEEN APPTS")=""                 OPT
 ;S REQUEST("MRTC","HOW MANY NEEDED")=""                    OPT
 ;S REQUEST("DUPLICATE REASON")=""                          OPT - The reason a duplicate appointment request is being made
 ;
CREATEREQUEST(JSONRETURN,SDCONTEXT,REQUEST) ;
 N REQUESTIEN,ERRORS,RETURN,INSTITUTIONIEN,FILEDATA
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("Request",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 M FILEDATA=REQUEST
 D VALIDATE^SDES2CRTAPREQ(.REQUEST,.FILEDATA,.INSTITUTIONIEN,.ERRORS)
 ;
 I $D(ERRORS) S ERRORS("Request",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS) Q
 ;
 S REQUESTIEN=$$BUILDER^SDES2CRTAPREQ(.FILEDATA,INSTITUTIONIEN,$G(SDCONTEXT("ACHERON AUDIT ID")))
 ;
 ; Call SDES2 GET APPT REQ BY IEN
 S REQUEST("REQUEST IEN")=REQUESTIEN
 D GETREQBYREQIEN^SDES2GETAPPTREQ(.JSONRETURN,.SDCONTEXT,.REQUEST)
 Q
