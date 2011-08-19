XOBSCAV ;; kec/oak - VistaLink Access/Verify Security ; 12/09/2002  17:00
 ;;1.6;VistALink Security;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; ---------------------------------------------------------------------
 ;      Access/Verify Security: Security Message Request Handler
 ;             (main entry point; utilities; constants)   
 ; ---------------------------------------------------------------------
 ; 
 ; ==== main entry point ====
 ; 
EN(XOBDATA) ; -- handle parsed messages request
 ;
 IF XOBDATA("XOB SECAV","SECURITYTYPE")'=$$MSGTYP^XOBSCAV("request") DO  QUIT
 .;this routine should never see a message not of this type.
 .NEW XOBSPAR SET XOBSPAR(1)=$$MSGTYP^XOBSCAV("request"),XOBSPAR(2)=XOBDATA("SECURITYTYPE")
 .DO ERROR(.XOBR,$PIECE($TEXT(FCLIENT),";;",2),"Unexpected Message Format",183001,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183001,.XOBSPAR)))
 ;
 ;---- now process each security message type ----
 IF XOBDATA("XOB SECAV","SECURITYACTION")=$PIECE($TEXT(MSGSETUP),";;",2) DO SENDITXT^XOBSCAV1 QUIT
 IF XOBDATA("XOB SECAV","SECURITYACTION")=$PIECE($TEXT(MSGLGON),";;",2) DO LOGON^XOBSCAV1 QUIT
 IF XOBDATA("XOB SECAV","SECURITYACTION")=$PIECE($TEXT(MSGLGOUT),";;",2) DO LOGOUT^XOBSCAV1 QUIT
 IF XOBDATA("XOB SECAV","SECURITYACTION")=$PIECE($TEXT(MSGSELDV),";;",2) DO DIVSLCT^XOBSCAV1 QUIT
 IF XOBDATA("XOB SECAV","SECURITYACTION")=$PIECE($TEXT(MSGUPDVC),";;",2) DO SENDNVC^XOBSCAV2 QUIT
 IF XOBDATA("XOB SECAV","SECURITYACTION")=$PIECE($TEXT(MSGUSERD),";;",2) DO SENDDEM^XOBSCAV2 QUIT
 ;
 ; done processing all known message types
 NEW XOBSPAR SET XOBSPAR(1)=XOBDATA("XOB SECAV","SECURITYACTION")
 DO ERROR(.XOBR,$PIECE($TEXT(FCLIENT),";;",2),"Unexpected Message Format",183002,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183002,.XOBSPAR)))
 QUIT
 ;
 ; ==== utilities ====
 ; 
SENDSEC(XOBR,XOBMSGTP,XOBRSTYP,XOBMSG,XOBSTAT,XOBSCHEM) ; -- stream XML security reply back
 ;
 ; XOBR: internal VistaLink variable
 ; XOBMSGTP: type of message (e.g., gov.va.med.foundations.security.response)
 ; XOBRSTYP: type of response (e.g., AV.SetupAndIntroText)
 ; XOBMSG: message lines to send inside standard wrapper
 ; XOBSTAT: type of result (e.g., success)
 ; XOBSCHEM: noNamespaceSchemaLocation
 ; 
 NEW XOBFILL
 ; -- prepare socket for writing
 DO PRE^XOBVSKT
 ; -- write XML header tag and VistaLink tag
 DO WRITE^XOBVSKT($$ENVHDR^XOBVLIB(XOBMSGTP,XOBSCHEM))
 ; -- write SecurityInfo tag
 DO WRITE^XOBVSKT("<SecurityInfo version="""_$PIECE($TEXT(VRSNSEC),";;",2)_""" />")
 ; -- write Response opening tag
 DO WRITE^XOBVSKT("<Response type="""_XOBRSTYP_""" status="""_XOBSTAT_""">")
  ; -- write lines of message passed in
 NEW XOBI SET XOBI=0 FOR  SET XOBI=$ORDER(XOBMSG(XOBI))  QUIT:'+XOBI  DO WRITE^XOBVSKT(XOBMSG(XOBI))
 ; -- write closing Response tag, closing VistaLink tag
 DO WRITE^XOBVSKT("</Response>")
 DO WRITE^XOBVSKT($$ENVFTR^XOBVLIB())
 ; -- send eot and flush buffer
 DO POST^XOBVSKT
 ;
 KILL XOBDATA("XOB SECAV")
 QUIT
 ;
ERROR(XOBR,XOBFCODE,XOBFSTR,XOBCODE,XOBSTR) ; -- send security error back to client
 ;
 ; XOBR: internal VistaLink variable
 ; XOBFCODE: the fault code
 ; XOBFSTRING: the fault string
 ; XOBCODE: error code
 ; XOBSTR: error message
 ; 
 NEW XOBFILL
 ; -- prepare socket for writing
 DO PRE^XOBVSKT
 ; -- write XML header tag and VistaLink tag
 DO WRITE^XOBVSKT($$ENVHDR^XOBVLIB($PIECE($TEXT(ERRTYPE^XOBSCAV),";;",2),$PIECE($TEXT(SCHERROR^XOBSCAV),";;",2)))
 ; -- write SecurityInfo tag
 DO WRITE^XOBVSKT("<SecurityInfo version="""_$PIECE($TEXT(VRSNSEC),";;",2)_""" />")
 ; -- write fault message
 DO WRITE^XOBVSKT("<Fault>")
 DO WRITE^XOBVSKT("<FaultCode>"_XOBFCODE_"</FaultCode>")
 DO WRITE^XOBVSKT("<FaultString>"_XOBFSTR_"</FaultString>")
 DO WRITE^XOBVSKT("<Detail>")
 DO WRITE^XOBVSKT("<Error code="""_XOBCODE_""">")
 DO WRITE^XOBVSKT("<Message>"_XOBSTR_"</Message>")
 DO WRITE^XOBVSKT("</Error>")
 DO WRITE^XOBVSKT("</Detail>")
 DO WRITE^XOBVSKT("</Fault>")
 DO WRITE^XOBVSKT($$ENVFTR^XOBVLIB())
 ; -- send eot and flush buffer
 DO POST^XOBVSKT
 ; -- log the error/fault unless it's "too many invalid login attempts"
 IF XOBCODE'=183005 DO
 .SET:$DATA(XOBDATA("XOB SECAV","AVCODE")) XOBDATA("XOB SECAV","AVCODE")="<masked>"
 .SET:$DATA(XOBDATA("XOB SECAV","OLDVC")) XOBDATA("XOB SECAV","OLDVC")="<masked>"
 .SET:$DATA(XOBDATA("XOB SECAV","NEWVC")) XOBDATA("XOB SECAV","NEWVC")="<masked>"
 .SET:$DATA(XOBDATA("XOB SECAV","NEWVCCHECK")) XOBDATA("XOB SECAV","NEWVCCHECK")="<masked>"
 .DO ^%ZTER
 KILL XOBDATA("XOB SECAV")
 QUIT
 ;
POSTTXT(XOBRET,XOBMSG) ; -- adds the post-sign-in-text to a message being prepared
 NEW XOBI,XOBLINE,XOBCNT
 SET XOBCNT="",XOBLINE=1 FOR  SET XOBCNT=$ORDER(XOBMSG(XOBCNT)) QUIT:XOBCNT']""  SET XOBLINE=XOBCNT
 SET XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="<PostSignInText>"
 ; only return post sign in text if the signon says that the text line count is > 0
 ; (even if, past XOBRET(5), there are actually messages from the post-sign-in text)
 IF XOBRET(5)>0 DO
 .SET XOBI=5 FOR  SET XOBI=$ORDER(XOBRET(XOBI)) QUIT:XOBI']""  DO
 ..SET XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="<Line>"_$$CHARCHK^XOBVLIB(XOBRET(XOBI))_"</Line>"
 SET XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="</PostSignInText>"
 QUIT XOBLINE
 ;
ADDDIVS(XOBRET,XOBMSG) ; -- adds division list to a message being prepared
 NEW XOBI,XOBLINE,XOBCNT,XOBDEF
 SET XOBCNT="",XOBLINE=1 FOR  SET XOBCNT=$ORDER(XOBMSG(XOBCNT)) QUIT:XOBCNT']""  SET XOBLINE=XOBCNT
 ;
 SET XOBDEF=$ORDER(^VA(200,DUZ,2,"AX1",1,"")) ; default division if any. Use of ^VA(200,,2,"AX1"): DBIA #4058
 SET XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="<"_$PIECE($TEXT(PARTTAG),";;",2)_" needDivisionSelection=""true"">"
 SET XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="<Divisions>"
 SET XOBI=0 FOR  SET XOBI=$ORDER(XOBDIVS(XOBI)) QUIT:XOBI']""  DO
 .SET XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="<Division ien="""_$PIECE(XOBDIVS(XOBI),U)_""" divName="""_$$CHARCHK^XOBVLIB($PIECE(XOBDIVS(XOBI),U,2))_""" divNumber="""_$$CHARCHK^XOBVLIB($PIECE(XOBDIVS(XOBI),U,3))_""""
 .SET:($PIECE(XOBDIVS(XOBI),U)=XOBDEF) XOBMSG(XOBLINE)=XOBMSG(XOBLINE)_" default=""true"" "
 .SET XOBMSG(XOBLINE)=XOBMSG(XOBLINE)_" />"
 SET XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="</Divisions>"
 SET XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="   </"_$PIECE($TEXT(PARTTAG),";;",2)_">"
 ;
 QUIT XOBLINE
 ;
LOGGEDON() ; -- checks if the environment was previously properly set up, e.g.,
 ; logon succeeded in some previous call
 QUIT +$GET(DUZ)
 ;
CRCONTXT(XOBOPTNM) ; -- create the context if it doesn't already exist
 ; INPUT VALUE: XOBOPTNM encoded with Kernel encoding algorithm
 ; RETURN VALUE: +result will be 1 if successful, or 0 if unsuccessful
 ; if unsuccessful, result may (or may not) also contain the textual reason for failure
 ; 
 ; Accessing, Setting and Killing of XQY and XQY0: DBIA #4059
 ; 
 NEW XOBRSLT,XOBOPTN1
 ;
 SET XOBOPTN1=$$DECRYP^XUSRB1(XOBOPTNM)
 ; -- if context already set, quit 1
 IF $LENGTH($GET(XQY0)),XQY0=XOBOPTN1 QUIT 1
 ; -- if param is empty string, then kill off the context
 IF XOBOPTN1="" KILL XQY0,XQY QUIT 1
 ; -- otherwise try to create the context
 DO CRCONTXT^XWBSEC(.XOBRSLT,XOBOPTNM) ; use of CRCONTXT^XWBSEC: DBIA #4053
 ; -- return the result
 QUIT XOBRSLT
 ;
CHKCTXT(XOBRPCNM) ; -- does user have access to RPC?
 NEW XWBSEC
 DO CHKPRMIT^XWBSEC(XOBRPCNM) ; use of CHKPRMIT^XWBSEC: DBIA # 4053
 QUIT:'+$LENGTH($GET(XWBSEC)) 1
 QUIT XWBSEC
 ;
 ; ==== Constants ====
 ; 
MSGTYP(XOBRQRS) ; return request message type
 IF XOBRQRS="request" QUIT $PIECE($TEXT(REQTYPE),";;",2)
 IF XOBRQRS="response" QUIT $PIECE($TEXT(RESTYPE),";;",2)
 IF XOBRQRS="error" QUIT $PIECE($TEXT(ERRTYPE),";;",2)
 QUIT ""
SUCCESS() ; resulttype
 QUIT $PIECE($TEXT(RESTYPES+1),";;",2)
FAILURE() ;
 QUIT $PIECE($TEXT(RESTYPES+2),";;",2)
PARTIAL() ;
 QUIT $PIECE($TEXT(RESTYPES+3),";;",2)
 ;
RESTYPES ;Result types
 ;;success
 ;;failure
 ;;partialSuccess
 ;
 ;Message types
REQTYPE ;;gov.va.med.foundations.security.request
RESTYPE ;;gov.va.med.foundations.security.response
ERRTYPE ;;gov.va.med.foundations.security.fault
 ;
 ;Message response types
MSGSETUP ;;AV.SetupAndIntroText
MSGLGON ;;AV.Logon
MSGLGOUT ;;AV.Logout
MSGSELDV ;;AV.SelectDivision
MSGUPDVC ;;AV.UpdateVC
MSGUSERD ;;AV.GetUserDemographics
 ;
 ;Attribute values for response XML messages
VRSNSEC ;;1.0
 ;
 ;XML Tag names
PARTTAG ;;PartialSuccessData
MSGTAG ;;Message
 ;
 ;XML Schemas
SCHERROR ;;secFault.xsd
SCHLGON ;;secLogonResponse.xsd
SCHPARTS ;;secPartialSuccessResponse.xsd
SCHSETUP ;;secSetupIntroResponse.xsd
SCHSIMPL ;;secSimpleResponse.xsd
SCHUSERD ;;secUserDemographicsResponse.xsd
 ;
 ;Faultcodes
FSERVER ;;Server
FCLIENT ;;Client
FVERSION ;;VersionMismatch
FUNDERST ;;MustUnderstand
