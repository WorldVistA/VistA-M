IBCNEHLD ;DAOU/ALA - IIV Deactivate MFN Message ;02-AUG-2002
 ;;2.0;INTEGRATED BILLING;**184,271,300**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will process deactivate registration MFN message
 ;
 ;*** WARNING-This program should only be executed by the integration team ***
 ;
 Q
 ;
 ;  Variables
 ;    HL* = HL7 package specific variables
 ;    MGRP = Mailgroup to email messages to
 ;    APP = Application
 ;    EVENT = HL7 Event
 ;    CODE = Values sent in the MFN message
 ;
DEAC ;  Deactivation message for when a site consolidates with another site
 NEW MGRP,APP,EVENT,CODE,MFN,HL,HLFS,HLECH,MCT,HLPROD,HLX
 NEW HLEID,HLCS,HLINST,HLN,HLPARAM,HLDOM,HLHDR,HLSAN
 NEW HLTYPE,HLQ,HLRESLT,ID,DA,DISYS,MFE,RESP,ZMID
 K ^TMP("HLS",$J)
 ;
 S MGRP=$$MGRP^IBCNEUT5()
 ;
HL ;  When a site deactivates, the enrollment should be an
 ;  "MDC" (delete) record
 S MFE(1)="MDC"
 ;
 ;  Initialize the HL7
 D INIT^HLFNC2("IBCNE IIV REGISTER",.HL)
 S HLFS=HL("FS"),HLECH=HL("ECH"),HL("SAF")=$P($$SITE^VASITE,U,2,3)
 ; S HLEID=$$HLP^IBCNEHLU("IBCNE IIV REGISTER")
 ;
 ;   Set the MFI segment
 S ID="Facility Table",APP="",EVENT="UPD",RESP="AL"
 S ^TMP("HLS",$J,1)=$$MFI^VAFHLMFI(ID,APP,EVENT,,,RESP)
 ;
 ;  Set the MFE segment
 S EVENT=MFE(1),MFN="",EDT=$$DT^XLFDT()
 S CODE=""
 S ^TMP("HLS",$J,2)=$$MFE^VAFHLMFE(EVENT,MFN,EDT,CODE)_HLFS_"CE"
 ;
 D GENERATE^HLMA("IBCNE IIV REGISTER","GM",1,.HLRESLT,"")
 I $P(HLRESLT,U,2)]"" S HLRESLT="Error - "_$P(HLRESLT,U,2,99) D  Q
 . S MSG(1)="IIV Deactivation Message not created."
 . S MSG(2)=HLRESLT
 . S MSG(3)="Please log a NOIS for this problem."
 . D MLMN
 K ^TMP("HLS",$J),%H,%I,X,EDT
 Q
 ;
MLMN ;  MailMan Message
 S XMSUB="IIV Deactivation Failure"
 D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
 K XMSUB,XMY,MSG,XMZ,XMDUZ
 Q
