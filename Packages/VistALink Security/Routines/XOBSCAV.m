XOBSCAV ;; kec/oak/TECHNATOMY/PB - VistaLink Access/Verify Security ; 12/09/2002  17:00
 ;;1.6;VistALink Security;**3,4**;May 08, 2009;Build 3
 ; ;Per VA Directive 6402, this routine should not be modified.
 Q
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
 I XOBDATA("XOB SECAV","SECURITYTYPE")'=$$MSGTYP^XOBSCAV("request") D  Q
 .;this routine should never see a message not of this type.
 .N XOBSPAR S XOBSPAR(1)=$$MSGTYP^XOBSCAV("request"),XOBSPAR(2)=XOBDATA("SECURITYTYPE")
 .D ERROR(.XOBR,$P($T(FCLIENT),";;",2),"Unexpected Message Format",183001,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183001,.XOBSPAR)))
 ;
 ;---- now process each security message type ----
 I XOBDATA("XOB SECAV","SECURITYACTION")=$P($T(MSGSETUP),";;",2) D SENDITXT^XOBSCAV1 Q
 I XOBDATA("XOB SECAV","SECURITYACTION")=$P($T(MSGLGON),";;",2) D LOGON^XOBSCAV1 Q
 ;added line below to process saml token for 2FA 
 I XOBDATA("XOB SECAV","SECURITYACTION")=$P($T(MSGLGON1),";;",2) D LOGON^XOBSCAV1 Q
 I XOBDATA("XOB SECAV","SECURITYACTION")=$P($T(MSGLGOUT),";;",2) D LOGOUT^XOBSCAV1 Q
 I XOBDATA("XOB SECAV","SECURITYACTION")=$P($T(MSGSELDV),";;",2) D DIVSLCT^XOBSCAV1 Q
 I XOBDATA("XOB SECAV","SECURITYACTION")=$P($T(MSGUPDVC),";;",2) D SENDNVC^XOBSCAV2 Q
 I XOBDATA("XOB SECAV","SECURITYACTION")=$P($T(MSGUSERD),";;",2) D SENDDEM^XOBSCAV2 Q
 ;
 ; done processing all known message types
 N XOBSPAR S XOBSPAR(1)=XOBDATA("XOB SECAV","SECURITYACTION")
 D ERROR(.XOBR,$P($T(FCLIENT),";;",2),"Unexpected Message Format",183002,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183002,.XOBSPAR)))
 Q
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
 N XOBFILL
 ; -- prepare socket for writing
 D PRE^XOBVSKT
 ; -- write XML header tag and VistaLink tag
 D WRITE^XOBVSKT($$ENVHDR^XOBVLIB(XOBMSGTP,XOBSCHEM))
 ; -- write SecurityInfo tag
 D WRITE^XOBVSKT("<SecurityInfo version="""_$P($T(VRSNSEC),";;",2)_""" />")
 ; -- write Response opening tag
 D WRITE^XOBVSKT("<Response type="""_XOBRSTYP_""" status="""_XOBSTAT_""">")
  ; -- write lines of message passed in
 N XOBI S XOBI=0 F  S XOBI=$O(XOBMSG(XOBI))  Q:'+XOBI  D WRITE^XOBVSKT(XOBMSG(XOBI))
 ; -- write closing Response tag, closing VistaLink tag
 D WRITE^XOBVSKT("</Response>")
 D WRITE^XOBVSKT($$ENVFTR^XOBVLIB())
 ; -- send eot and flush buffer
 D POST^XOBVSKT
 ;
 K XOBDATA("XOB SECAV")
 Q
 ;
ERROR(XOBR,XOBFCODE,XOBFSTR,XOBCODE,XOBSTR) ; -- send security error back to client
 ;
 ; XOBR: internal VistaLink variable
 ; XOBFCODE: the fault code
 ; XOBFSTRING: the fault string
 ; XOBCODE: error code
 ; XOBSTR: error message
 ; 
 N XOBFILL
 ; -- prepare socket for writing
 D PRE^XOBVSKT
 ; -- write XML header tag and VistaLink tag
 D WRITE^XOBVSKT($$ENVHDR^XOBVLIB($P($T(ERRTYPE^XOBSCAV),";;",2),$P($T(SCHERROR^XOBSCAV),";;",2)))
 ; -- write SecurityInfo tag
 D WRITE^XOBVSKT("<SecurityInfo version="""_$P($T(VRSNSEC),";;",2)_""" />")
 ; -- write fault message
 D WRITE^XOBVSKT("<Fault>")
 D WRITE^XOBVSKT("<FaultCode>"_XOBFCODE_"</FaultCode>")
 D WRITE^XOBVSKT("<FaultString>"_XOBFSTR_"</FaultString>")
 D WRITE^XOBVSKT("<Detail>")
 D WRITE^XOBVSKT("<Error code="""_XOBCODE_""">")
 D WRITE^XOBVSKT("<Message>"_XOBSTR_"</Message>")
 D WRITE^XOBVSKT("</Error>")
 D WRITE^XOBVSKT("</Detail>")
 D WRITE^XOBVSKT("</Fault>")
 D WRITE^XOBVSKT($$ENVFTR^XOBVLIB())
 ; -- send eot and flush buffer
 D POST^XOBVSKT
 ; -- log the error/fault unless it's "too many invalid login attempts"
 I XOBCODE'=183005 D
 .S:$D(XOBDATA("XOB SECAV","AVCODE")) XOBDATA("XOB SECAV","AVCODE")="<masked>"
 .S:$D(XOBDATA("XOB SECAV","OLDVC")) XOBDATA("XOB SECAV","OLDVC")="<masked>"
 .S:$D(XOBDATA("XOB SECAV","NEWVC")) XOBDATA("XOB SECAV","NEWVC")="<masked>"
 .S:$D(XOBDATA("XOB SECAV","NEWVCCHECK")) XOBDATA("XOB SECAV","NEWVCCHECK")="<masked>"
 .D APPERROR^%ZTER("VistALink Error ") ;XOBV*1.6*4
 K XOBDATA("XOB SECAV")
 Q
 ;
POSTTXT(XOBRET,XOBMSG) ; -- adds the post-sign-in-text to a message being prepared
 N XOBI,XOBLINE,XOBCNT
 S XOBCNT="",XOBLINE=1 F  S XOBCNT=$O(XOBMSG(XOBCNT)) Q:XOBCNT']""  S XOBLINE=XOBCNT
 S XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="<PostSignInText>"
 ; only return post sign in text if the signon says that the text line count is > 0
 ; (even if, past XOBRET(5), there are actually messages from the post-sign-in text)
 I XOBRET(5)>0 D
 .S XOBI=5 F  S XOBI=$O(XOBRET(XOBI)) Q:XOBI']""  D
 ..S XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="<Line>"_$$CHARCHK^XOBVLIB(XOBRET(XOBI))_"</Line>"
 S XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="</PostSignInText>"
 Q XOBLINE
 ;
ADDDIVS(XOBRET,XOBMSG) ; -- adds division list to a message being prepared
 N XOBI,XOBLINE,XOBCNT,XOBDEF
 S XOBCNT="",XOBLINE=1 F  S XOBCNT=$O(XOBMSG(XOBCNT)) Q:XOBCNT']""  S XOBLINE=XOBCNT
 ;
 S XOBDEF=$O(^VA(200,DUZ,2,"AX1",1,"")) ; default division if any. Use of ^VA(200,,2,"AX1"): DBIA #4058
 S XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="<"_$P($T(PARTTAG),";;",2)_" needDivisionSelection=""true"">"
 S XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="<Divisions>"
 S XOBI=0 F  S XOBI=$O(XOBDIVS(XOBI)) Q:XOBI']""  D
 .S XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="<Division ien="""_$P(XOBDIVS(XOBI),U)_""" divName="""_$$CHARCHK^XOBVLIB($P(XOBDIVS(XOBI),U,2))_""" divNumber="""_$$CHARCHK^XOBVLIB($P(XOBDIVS(XOBI),U,3))_""""
 .S:($P(XOBDIVS(XOBI),U)=XOBDEF) XOBMSG(XOBLINE)=XOBMSG(XOBLINE)_" default=""true"" "
 .S XOBMSG(XOBLINE)=XOBMSG(XOBLINE)_" />"
 S XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="</Divisions>"
 S XOBLINE=XOBLINE+1,XOBMSG(XOBLINE)="   </"_$P($T(PARTTAG),";;",2)_">"
 ;
 Q XOBLINE
 ;
LOGGEDON() ; -- checks if the environment was previously properly set up, e.g.,
 ; logon succeeded in some previous call
 Q +$G(DUZ)
 ;
CRCONTXT(XOBOPTNM) ; -- create the context if it doesn't already exist
 ; INPUT VALUE: XOBOPTNM encoded with Kernel encoding algorithm
 ; RETURN VALUE: +result will be 1 if successful, or 0 if unsuccessful
 ; if unsuccessful, result may (or may not) also contain the textual reason for failure
 ; 
 ; Accessing, Setting and Killing of XQY and XQY0: DBIA #4059
 ; 
 N XOBRSLT,XOBOPTN1
 ;
 S XOBOPTN1=$$DECRYP^XUSRB1(XOBOPTNM)
 ; -- if context already set, quit 1
 I $L($G(XQY0)),XQY0=XOBOPTN1 Q 1
 ; -- if param is empty string, then kill off the context
 I XOBOPTN1="" K XQY0,XQY Q 1
 ; -- otherwise try to create the context
 D CRCONTXT^XWBSEC(.XOBRSLT,XOBOPTNM) ; use of CRCONTXT^XWBSEC: DBIA #4053
 ; -- return the result
 Q XOBRSLT
 ;
CHKCTXT(XOBRPCNM) ; -- does user have access to RPC?
 N XWBSEC
 D CHKPRMIT^XWBSEC(XOBRPCNM) ; use of CHKPRMIT^XWBSEC: DBIA # 4053
 Q:'+$L($G(XWBSEC)) 1
 Q XWBSEC
 ;
 ; ==== Constants ====
 ; 
MSGTYP(XOBRQRS) ; return request message type
 I XOBRQRS="request" Q $P($T(REQTYPE),";;",2)
 I XOBRQRS="response" Q $P($T(RESTYPE),";;",2)
 I XOBRQRS="error" Q $P($T(ERRTYPE),";;",2)
 Q ""
SUCCESS() ; resulttype
 Q $P($T(RESTYPES+1),";;",2)
FAILURE() ;
 Q $P($T(RESTYPES+2),";;",2)
PARTIAL() ;
 Q $P($T(RESTYPES+3),";;",2)
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
MSGLGON1 ;;SAML.Logon
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
