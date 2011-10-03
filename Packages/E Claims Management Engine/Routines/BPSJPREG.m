BPSJPREG ;BHAM ISC/LJF - HL7 Registration MFN Message ;6/12/08  15:38
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,2,5,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will process the outgoing registration MFN message
 ;
 ;  Variable
 ; HL      = HL7 parameters
 ; HL7DTG  = Date time in HL7 format
 ; HLECH   = HL7 Encoding Characters
 ; HLEID   = HL7 Link id
 ; HLFS    = HL7 Field separator
 ; HLLNK   = HL7 E-Pharm Link
 ; HLRESET = HL7 generate results
 ; IPP     = IP Port
 ; IPA     = IP Address
 ; MCT     = Message Count
 ; MGRP    = E-Mail message group
 ; MSG     = Message
 ;
 ; Don't allow direct execution
 ;
 W !!!,"DIRECT ENTRY NOT ALLOWED",!!!
 Q
 ;
REG(PHARMIX,BPSJVAL) ;  Registration message for when a site installs
 ;
 N HL,HL7DTG,HLECH,HLEID,HLFS,HLLNK,HLPRO,BPSHLRS,IPA,IPP,NPKEY,NCPDP
 N MGRP,MCT,MSG,TAXID,ZRPSEG,BPSJVAL2,BPSJPRES,BPSZ
 ;
 S (MCT,TAXID)=0,BPSJVAL=$G(BPSJVAL)
 ;
 I '$G(PHARMIX) Q
 K ^TMP("HLS",$J)
 ;
 ; only send Active or recently made inactive pharmacies, no reason to send
 ; inactive ones over and over
 S BPSZ=$G(^BPS(9002313.56,PHARMIX,0))
 I 'BPSJVAL,'$P(BPSZ,"^",10),'$P(BPSZ,"^",4) Q
 ;
 ; NPI Processing
 ; Get DropDeadDate and Date/Time Last Change
 N BPSJAPI,BPSJNPI,BPSJNDT,BPSJOP,BPSJOPS,BPSJDDD,NPKEY
 S BPSJDDD=$$NPIREQ^BPSNPI(DT)
 N NOW,%,%H,%I,X D NOW^%DTC S BPSJNDT=%
 ; Get OP site for pharmacy and NPIAPI
 S BPSJOP=0,BPSJAPI=""
 F  S BPSJOP=$O(^BPS(9002313.56,PHARMIX,"OPSITE",BPSJOP)) Q:'BPSJOP  D  I BPSJAPI'="" Q
 . S BPSJOPS=$G(^BPS(9002313.56,PHARMIX,"OPSITE",BPSJOP,0))
 . S BPSJAPI=$$NPI^BPSNPI("Pharmacy_ID",BPSJOPS)
 . I $P(BPSJAPI,U,1)=-1 S BPSJAPI="" Q
 . I $P(BPSJAPI,U)>0 S BPSJAPI=$P(BPSJAPI,U)
 ; Check for existing NPI
 S BPSJNPI=$P($G(^BPS(9002313.56,PHARMIX,"NPI")),U)
 I 'BPSJAPI,BPSJNPI,BPSJVAL<2 D
 . N DA,DIC,DIE,DINUM,DIR,DIRUT,DIROUT,DLAYGO,DR,DTOUT,DUOUT,X,Y
 . S DA=PHARMIX,DIE=$$ROOT^DILFD(9002313.56)
 . S DR="41.01///@;41.02///@" D ^DIE
 I BPSJAPI,BPSJVAL<2 D
 . S ^XTMP("BPSJ",0)=(BPSJNDT+7)_U_BPSJNDT_U_"BPS NPI HL7 DATA"
 . S ^XTMP("BPSJ","NPI",BPSJAPI)=PHARMIX_U_BPSJNDT
 ;
 ;  Get Link data from HL7 table
 S HLPRO="BPSJ REGISTER",(IPA,IPP)=""
 S HLLNK=$$FIND1^DIC(870,"",,"EPHARM OUT","B")
 I HLLNK S IPA=$$GET1^DIQ(870,HLLNK_",",400.01),IPP=$$GET1^DIQ(870,HLLNK_",",400.02)
 ;
 ;  Error if any missing data
 I IPA=""!(IPP="") S MCT=MCT+1,MSG(MCT)="IP Address or Port is not defined.  "
 ;
 ;  Initialize the HL7
 D INIT^HLFNC2(HLPRO,.HL)
 S HLFS=$G(HL("FS")) I HLFS="" S HLFS="|"
 S HLECH=$E($G(HL("ECH"),1)) I HLECH="" S HLECH="^"
 S HL("EPPORT")=IPP,HLEID=$$HLP^BPSJUTL(HLPRO)
 ;
 ;Get fileman date/time, ensuring seconds are included: 3031029.135636
 S HL7DTG=$E($$HTFM^XLFDT($H)_"000000",1,14)
 ;Set HL7 Date/Time format: 20031029135636-0400
 S HL7DTG=$$FMTHL7^XLFDT(HL7DTG)
 ;
 ;  Set the ZRP Segment
 D EN^BPSJZRP(.HL,PHARMIX,.ZRPSEG,BPSJAPI,.NCPDP)
 M ^TMP("HLS",$J,3)=ZRPSEG K ZRPSEG
 ;
 ;  Set the MFE segment
 N BPSMFE S BPSMFE="MUP"
 S NPKEY=$$NPKEY^BPSNPI(NCPDP,BPSJNPI,BPSJAPI)
 I NPKEY D
 . I '$$BPSACTV^BPSUTIL(PHARMIX) S BPSMFE="MDC"
 . S ^TMP("HLS",$J,2)="MFE"_HLFS_BPSMFE_HLFS_HLFS_HL7DTG
 . S ^TMP("HLS",$J,2)=^TMP("HLS",$J,2)_HLFS_NPKEY_HLFS_"ST"
 ;
 ;   Set the MFI segment
 S ^TMP("HLS",$J,1)="MFI"_HLFS_"Pharmacy Table"_HLFS_HLFS_"UPD"_HLFS
 S ^TMP("HLS",$J,1)=^TMP("HLS",$J,1)_HL7DTG_HLFS_HL7DTG_HLFS_"NE"
 ;
 S BPSJPRES=$$VAL2^BPSJVAL(BPSJVAL,BPSJDDD)  ; 0 = ok
 I BPSJVAL=3 G FINI   ; Just checking to see if data valid.
 ;
 ;-Check if msg valid.
 I 'BPSJPRES D  G FINI
 . N BPSHLRS
 . D GENERATE^HLMA(HLEID,"GM",1,.BPSHLRS,"")
 . I $P($G(BPSHLRS),U,2)]"" D  Q
 .. I BPSJVAL D  Q   ; Interactive: show no success
 ... W !!,"ECME Pharmacy Registration HL7 Message not created: "_BPSHLRS
 ... W !," PHARMIX: "_PHARMIX_""
 .. S MCT=MCT+1,MSG(MCT)="ECME Pharmacy Registration HL7 Message not created. (PHARMIX: "_PHARMIX_")"
 .. S MCT=MCT+1,MSG(MCT)=BPSHLRS
 .. D MSG^BPSJUTL(.MSG,"ECME Pharmacy Registration")
 . ; update last status sent
 . S $P(^BPS(9002313.56,PHARMIX,0),"^",4)=$P(^BPS(9002313.56,PHARMIX,0),"^",10)
 . I BPSJVAL D    ;Interactive: show success
 .. W !!,"ECME Pharmacy Registration HL7 Message was created successfully."
 ;
 ;
FINI ; Clean up
 K ^TMP("HLS",$J)
 Q
