IBCNEHLM ;DAOU/ALA - HL7 Registration MFN Message ;02-JUN-2015
 ;;2.0;INTEGRATED BILLING;**184,251,300,416,438,497,506,549,601,621,631,659**;21-MAR-94;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
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
 ;    TIMOUT = Timeout Days Site Parameter
 ;    RETRY = Retry Flag Site Parameter
 ;
 N IBPERSIST
 S IBPERSIST="N" ; persistence flag - If "N", FSC will not use the statistics on the NTE segment
 D REG
 Q
 ;
EN1 ; TaskMan entry point
 N IBPERSIST
 S IBPERSIST="Y" ; persistence flag - If "Y", FSC will use NTE segment to update their copy of the site's stats
 D REG
 ; Purge the task record
 S ZTREQ="@"
 Q
 ;
REG ;  Registration message for when a site installs
 ;
 ;/vd-IB*2.0*659 - Quit if VAMC Site is MANILA (#358) & EIV is disabled for MANILA.
 I $P($$SITE^VASITE,U,3)=358,$$GET1^DIQ(350.9,"1,",51.33,"I")="N" Q
 ;
 N APP,CNTCEM,CNTCNM,CNTCPH,CODE,EDT,EVENT,FRSH,HL,HLCDOM,HLCINS,HLCS
 N HLCSTCP,HLECH,HLEID,HLFS,HLHDR,HLINST,HLIP,HLN,HLNHLQ,HLPROD,HLQ,HLREP
 N HLRESLT,HLSAN,HLTYPE,HLX,IBCNE,IBCNEDAT,IHLP,IHLS,IHLT,ID,INACT,IPA,IPP
 N MCT,MFE,MFN,MGRP,QFL,RESP,TAXID,ZMID,%I
 N IVER,RETRY,TIMOUT,VMFE         ; IB*2.0*506
 K ^TMP("HLS",$J) S MCT=0,QFL=0
 ;
 ;  Get data from IB Parameters File
 S TAXID=$TR($P($G(^IBE(350.9,1,1)),U,5),"-",""),CNTCPH="",CNTCEM="",CNTCNM=""
 S IBCNE=$G(^IBE(350.9,1,51))
 S FRSH=$P(IBCNE,U,1),TIMOUT=$P(IBCNE,U,5),RETRY=$P(IBCNE,U,26) ; IB*2.0*506
 S MGRP=$$MGRP^IBCNEUT5()
 S INACT=$E($$GET1^DIQ(350.9,"1,",51.08,"E"))
 S IHLP=$P(IBCNE,U,13),IHLT=$P(IBCNE,U,14)
 S IHLS=$P(IBCNE,U,19)
 ;
 ; IB*2.0*549 Updated version to 7, Removed retrieval of Contact Name, Phone, email
 ; IB*2.0*601 Updated version to 8
 ; IB*2.0*621 Updated version to 9, EICD
 ; IB*2.0*631 Updated version to 10
 ; IB*2.0*659 Updated version to 11
 S IVER="11"
 I IHLP="I" S (IHLT,IHLS)=""
 ;
 I IHLP="B",IHLT=""!(IHLS="") D  S QFL=1
 . S MCT=MCT+1,MSG(MCT)="The ""HL7 Response Processing Method"" selected is Batch but the HL7 Batch "
 . I IHLT="",IHLS="" S MSG(MCT)=MSG(MCT)_"Start and End Times are blank.  " Q
 . S MSG(MCT)=MSG(MCT)_$S(IHLT="":"Start",1:"End")_" Time is blank.  "
 ;
 I FRSH=""!(INACT="")!(IHLP="") D
 . S MCT=MCT+1,MSG(MCT)="The following eIV Site Parameters are not defined:  "
 . I FRSH="" S MCT=MCT+1,MSG(MCT)="""Days between electronic re-verification checks"" is blank.  "
 . I INACT="" S MCT=MCT+1,MSG(MCT)="""Look at a patient's inactive insurance?"" is blank.  "
 . I IHLP="" S MCT=MCT+1,MSG(MCT)="""HL7 Response Processing Method"" is blank.  "
 . Q
 ;
 I $O(MSG(""))'="" D MLMN
 I QFL=1 Q
 ;
HL ;  When a site installs, the enrollment should be an
 ;  "MUP" (update) record.
 N DSTAT,DSTAT2,VNTE,VZRR                   ; IB*2.0*549 added DSTAT2
 S MFE(1)="MUP"
 ;
 ;  Initialize the HL7
 D INIT^HLFNC2("IBCNE IIV REGISTER",.HL)
 S HLFS=HL("FS"),HLECH=HL("ECH"),HL("SAF")=$P($$SITE^VASITE,U,2,3),HLREP=$E(HL("ECH"),2)
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
 S ^TMP("HLS",$J,2)=VMFE_HLFS_"CE"
 ;
 ; Set the ZRR segment
 ;IB*549 Added line to send null values for removed fields so msg layout remains unchanged
 S (CNTCPH,CNTCEM,CNTCNM)=""
 S VZRR="ZRR"_HLFS_"1"_HLFS_TAXID_HLFS_HLFS_$$HLNAME^HLFNC(CNTCNM,$E(HLECH))_"^C"_HLFS
 S VZRR=VZRR_CNTCPH_$E(HLECH)_$E(HLECH)_$E(HLECH)_CNTCEM_HLFS_FRSH_HLFS_IHLP_HLFS_IHLT_$E(HLECH)_IHLS_HLFS_INACT_HLFS_IVER
 S ^TMP("HLS",$J,3)=VZRR
 ;
 ; Set the NTE segment
 S DSTAT=$$GETSTAT^IBCNEDST()
 S DSTAT2=$$GETSTAT2^IBCNEDST()                 ; IB*2.0*549 Added line
 S VNTE="NTE"_HLFS_"1"_HLFS_HLFS_IBPERSIST_HLREP_$TR(DSTAT,U,HLREP)
 S VNTE=VNTE_HLREP_RETRY_HLREP_TIMOUT           ; IB*2.0*506
 S VNTE=VNTE_HLREP_$TR(DSTAT2,U,HLREP)          ; IB*2.0*549 Added line
 S ^TMP("HLS",$J,4)=VNTE
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
