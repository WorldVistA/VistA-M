IBCNEHLM ;DAOU/ALA - HL7 Registration MFN Message ;10-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,251,300,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will process the outgoing registration MFN message
 ;
 ;  Variables
 ;    MCT = Lines of MailMan message counter
 ;    QFL = Quit flag
 ;    HL* = HL7 package specific variables
 ;    TAXID = Tax ID
 ;    CNTCPH = Contact Phone
 ;    CNTCEM = Contact Email
 ;    FRSH = Freshness Days
 ;    MGRP = Mailgroup to email messages to
 ;    INACT = Inactive Insurance Flag
 ;    CNTC = Contact IEN
 ;    APP = Application
 ;    EVENT = HL7 Event
 ;    CODE = Values sent in the MFN message
 ;    IPP = IP Port
 ;    IPA = IP Address
 ;    RESP = Response Code
 ;    IHLP = Interface HL7 Processing Type
 ;    IHLT = Interface HL7 Batch Start Time
 ;    IHLS = Interface HL7 Batch Stop Time
 ;    IVER = Interface Version
 ;
REG ;  Registration message for when a site installs
 NEW TAXID,CNTCPH,CNTCEM,CNTCNM,IBCNE,FRSH,MGRP,INACT,IHLP,MFE,HLSAN
 NEW IHLT,CNTC,APP,EVENT,CODE,EDT,MFN,HL,HLFS,HLECH,MCT,HLPROD,HLX,ID
 NEW HLEID,IPP,IPA,IBCNEDAT,HLCS,HLINST,HLN,RESP,HLHDR
 NEW HLTYPE,HLQ,HLRESLT,IHLS,HLCDOM,HLCINS,HLCSTCP,HLIP,%I,ZMID
 NEW VMFE,IVER
 K ^TMP("HLS",$J) S MCT=0,QFL=0
 ;
 ;  Get data from IB Parameters File
 S TAXID=$TR($P($G(^IBE(350.9,1,1)),U,5),"-",""),CNTCPH="",CNTCEM="",CNTCNM=""
 S IBCNE=$G(^IBE(350.9,1,51))
 S FRSH=$P(IBCNE,U,1)
 S MGRP=$$MGRP^IBCNEUT5()
 S INACT=$E($$GET1^DIQ(350.9,"1,",51.08,"E"))
 S IHLP=$P(IBCNE,U,13),IHLT=$P(IBCNE,U,14),CNTC=$P(IBCNE,U,16)
 S IHLS=$P(IBCNE,U,19)
 S IVER="4"
 ;
 I IHLP="I" S (IHLT,IHLS)=""
 ;
 ;  Get contact specific information
 I CNTC'="" D
 . S CNTCNM=$P($G(^VA(200,CNTC,0)),U,1)
 . S CNTCPH=$P($G(^VA(200,CNTC,.13)),U,2)
 . S CNTCEM=$P($G(^VA(200,CNTC,.15)),U,1)
 ;
 ;  Email if any missing data
 I CNTC="" S MCT=MCT+1,MSG(MCT)="The Contact Person is not defined in the eIV Site Parameters.  ",QFL=1
 I CNTC'="",CNTCPH="" S MCT=MCT+1,MSG(MCT)="The office phone number of the eIV Contact Person is not defined  (File 200, Field .132).  ",QFL=1
 I CNTC'="",CNTCEM="" S MCT=MCT+1,MSG(MCT)="The email address of the eIV Contact Person is not defined  (File 200, Field .151).  ",QFL=1
 ;
 I IHLP="B",IHLT=""!(IHLS="") D  S QFL=1
 . S MCT=MCT+1,MSG(MCT)="The ""HL7 Response Processing Method"" selected is Batch but the HL7 Batch "
 . I IHLT="",IHLS="" S MSG(MCT)=MSG(MCT)_"Start and End Times are blank.  " Q
 . S MSG(MCT)=MSG(MCT)_$S(IHLT="":"Start",1:"End")_" Time is blank.  "
 ;
 I FRSH=""!(INACT="")!(IHLP="") D
 . S MCT=MCT+1,MSG(MCT)="The following eIV Site Parameters are not defined:  "
 . I FRSH="" S MCT=MCT+1,MSG(MCT)="""Days between electronic reverification checks"" is blank.  "
 . I INACT="" S MCT=MCT+1,MSG(MCT)="""Look at a patient's inactive insurance?"" is blank.  "
 . I IHLP="" S MCT=MCT+1,MSG(MCT)="""HL7 Response Processing Method"" is blank.  "
 . Q
 ;
 I $O(MSG(""))'="" D MLMN
 I QFL=1 Q
 ;
HL ;  When a site installs, the enrollment should be an
 ;  "MUP" (update) record.
 N VZRR
 S MFE(1)="MUP"
 ;
 ;  Initialize the HL7
 D INIT^HLFNC2("IBCNE IIV REGISTER",.HL)
 S HLFS=HL("FS"),HLECH=HL("ECH"),HL("SAF")=$P($$SITE^VASITE,U,2,3)
 ; S HLEID=$$HLP^IBCNEHLU("IBCNE IIV REGISTER")
 ;
 ;   Set the MFI segment
 S ID="Facility Table",APP="",EVENT="UPD",RESP="NE"
 S ^TMP("HLS",$J,1)=$$MFI^VAFHLMFI(ID,APP,EVENT,,,RESP)
 ;
 ;  Set the MFE segment
 S EVENT=MFE(1),MFN="",EDT=$$DT^XLFDT()
 S CODE=$P($$SITE^VASITE,U,3)_$E(HLECH)
 S VMFE=$$MFE^VAFHLMFE(EVENT,MFN,EDT,CODE)
 S $P(VMFE,U,11)=$S($P(VMFE,U,11)="YES":"Y",1:"N")
 S ^TMP("HLS",$J,2)=VMFE_HLFS_"CE"
 ;
 ;  Set the ZRR segment
 S VZRR="ZRR"_HLFS_"1"_HLFS_TAXID_HLFS_HLFS_$$HLNAME^HLFNC(CNTCNM,$E(HLECH))_"^C"_HLFS
 S VZRR=VZRR_CNTCPH_$E(HLECH)_$E(HLECH)_$E(HLECH)_CNTCEM_HLFS_FRSH_HLFS_IHLP_HLFS_IHLT_$E(HLECH)_IHLS_HLFS_INACT_HLFS_IVER
 S ^TMP("HLS",$J,3)=VZRR
 ;
 D GENERATE^HLMA("IBCNE IIV REGISTER","GM",1,.HLRESLT,"")
 I $P(HLRESLT,U,2)]"" S HLRESLT="Error - "_$P(HLRESLT,U,2,99) D  Q
 . S MSG(1)="HL7 eIV Registration Message not created."
 . S MSG(2)=HLRESLT
 . D MLMN
 K ^TMP("HLS",$J)
 Q
 ;
MLMN ;  MailMan Message
 D TXT^IBCNEUT7("MSG")
 S XMSUB="eIV Registration Failure"
 D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
 K XMSUB,XMY,MSG,XMZ,XMDUZ
 Q
