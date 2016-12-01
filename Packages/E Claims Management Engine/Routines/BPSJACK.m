BPSJACK ;BHAM ISC/LJF - HL7 Acknowledgement Messages ;3/13/08  16:08
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5,7,20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine examines an Acknowledgement Message. If the message is
 ; the E-PHARM Application Acknowledgement Message, and it is "AA",
 ; it kicks off the Pharmacy Registration Messages.
 ; If the message flags an error, then error notification is processed.
 ;
EN(HL) N ACK,AREG,BPSJSEG,ERR,HCT,SEG
 N MFI,MFIIX,MSGCTLID,MSGID,MSGIX,MSH
 ;
 I '$D(HL) Q
 ;
 S (AREG,HCT,MFIIX,MSGCTLID,MSGID,MSGIX)=0,(ACK,MFI,MSH)=""
 S ERR("MSA")=""
 ;  Loop through the message and find each segment for processing
 F  S HCT=$O(^TMP($J,"BPSJHLI",HCT)) Q:HCT=""  D
 . K BPSJSEG D SPAR^BPSJUTL(.HL,.BPSJSEG,HCT) S SEG=$G(BPSJSEG(1))
 . ;
 . I SEG="MSH" D  Q
 . . S MSGCTLID=$G(BPSJSEG(10))    ; get the message control id
 . ;
 . I SEG="MSA" D  Q  ; MSA seg looks like this -> MSA|AA|509133482
 . . S ACK=$G(BPSJSEG(2)),MSGID=$G(BPSJSEG(3)) K ERR("MSA")
 . ;
 . I SEG="MFI",ACK="AA",$P($G(BPSJSEG(2)),$E($G(HL("ECH"))))="Facility Table" S AREG=1
 . ;
 . ;GET NPI
 . I SEG="MFI",ACK="AA",$P($G(BPSJSEG(2)),$E($G(HL("ECH"))))="Pharmacy Table" D
 . . I '$G(MSGID) Q
 . . N BPSJNPI,BPSJPIX,BPSJNDT,BPSJ,HLMAID,HLID
 . . ; back track AA/ACK to message sent out to find NPI sent out
 . . S HLMAID=$O(^HLMA("C",MSGID,"")) I '$G(HLMAID) Q
 . . S HLID=$P(^HLMA(HLMAID,0),U) I '$G(HLID) Q
 . . S BPSJNPI=$P($G(^HL(772,HLID,"IN",22,0)),"|") I '$G(BPSJNPI) Q
 . . S BPSJ=$G(^XTMP("BPSJ","NPI",BPSJNPI)) I 'BPSJ Q
 . . S BPSJPIX=$P(BPSJ,U),BPSJNDT=$P(BPSJ,U,2)
 . . N DA,DIC,DIE,DINUM,DIR,DIRUT,DIROUT,DLAYGO,DR,DTOUT,DUOUT,X,Y
 . . S DA=BPSJPIX,DIE=$$ROOT^DILFD(9002313.56)
 . . S DR="41.01////"_BPSJNPI_";41.02////"_BPSJNDT D ^DIE
 . . K ^XTMP("BPSJ","NPI",BPSJNPI)
 . ;
 . I SEG="MFA",ACK="AE" S ERR("MFA",U_$G(BPSJSEG(5)))="" Q
 ;
 ; Pharmacy Registrations
 I AREG S AREG=0 D
 . S $P(^BPS(9002313.99,1,0),"^",7)=$$NOW^XLFDT
 . F  S AREG=$O(^BPS(9002313.56,AREG)) Q:'AREG  D REG^BPSJPREG(AREG)
 ;
 I $D(ERR) D ERRORM D MSG^BPSJUTL(.ERR,"BPSJACK")
 Q
 ;
ERRORM ; Error message setup
 N ERRT
 ;
 S ERR(1)="Error(s) indicated for HL7 Application Acknowledge Message ID: "_$G(MSGCTLID)
 I $D(ERR("MSA")) S ERR(2)="Error:NO MSA - No MSA segment found."
 I $D(ERR("MFA")) S ERRT="" F  S ERRT=$O(ERR("MFA",ERRT)) Q:ERRT=""  D
 . I ERRT["NC100" S ERR(100)="Error:NC100 - Invalid OP Interface version." Q
 . I ERRT["NC300" S ERR(300)="Error:NC300 - OP pharmacy not registered.  Failed to update Pharmacy information." Q
 . I ERRT["NC301" S ERR(301)="Error:NC301 - Unable to update Pharmacy information due to outpatient pharmacy registration has invalid OP interface version." Q
 . S ERR(399)="Error:"_ERRT_" - Unknown error."
 K ERR("MFA"),ERR("MSA")
 ;
 Q
 ;
APPACK(HL,APPACK,PSIEN) ; Application Acknowledgement for Payer Sheets
 N MGRP,MSG,MCT,BPSGENR
 N TLN,FS,FS2,FS3,CS
 ;
 K ^TMP("HLA",$J)
 ;
 ;-Set up HL7
 D INIT^HLFNC2("BPSJ REGISTER",.HL)
 ;
 D DGAPPACK  ; Dollar G the APPACK variable (bullet proofing)
 ;
 S FS=$G(HL("FS")) I FS="" S FS="|"      ; field separator
 S CS=$E($G(HL("ECH"))) I CS="" S CS="^"  ; component separator
 ;
 S MCT=0,FS2=FS_FS,FS3=FS_FS_FS
 ;
 ;-MSA SEG
 I APPACK("MFA",4,1)="S" S ^TMP("HLA",$J,1)="MSA"_FS_"AA"_FS_APPACK("MSA",2)
 E  S ^TMP("HLA",$J,1)="MSA"_FS_"AE"_FS_APPACK("MSA",2)
 ;
 ;-MFI SEG
 S TLN="MFI"_FS_APPACK("MFI",1,1)_CS_APPACK("MFI",1,2)_FS2
 S ^TMP("HLA",$J,2)=TLN_APPACK("MFI",3)_FS3_APPACK("MFI",6)
 ;
 ;-MFA SEG(S)
 I APPACK("MFA",4,1)="S" D  S ^TMP("HLA",$J,3)=TLN
 . S TLN="MFA"_FS_APPACK("MFA",1)_FS_APPACK("MFA",2)_FS2
 . S TLN=TLN_APPACK("MFA",4,1)_CS_APPACK("MFA",4,2)_FS
 . S TLN=TLN_APPACK("MFA",5)_FS_APPACK("MFA",6)
 E  D MFASEGS
 ;
 D GENACK^HLMA1($G(HL("EID")),$G(HL("HLMTIENS")),$G(HL("EIDS")),"GM",1,.BPSGENR)
 ;
 K ^TMP("HLA",$J)
 Q
 ;
MFASEGS ; Set up the MFA segs for Reject message
 N MFAP1,MFAP2,MFACNTR,FIELD,RECORD,ZPRERR
 ;
 S MFAP1="MFA"_FS_APPACK("MFA",1)_FS_APPACK("MFA",2)
 S MFAP1=MFAP1_FS2_APPACK("MFA",4,1)_CS
 S MFAP2=FS_APPACK("MFA",5)_FS_APPACK("MFA",6)
 S MFACNTR=2
 ;
 I $D(^TMP($J,"BPSJ-ERROR","MFI")) S FIELD="" D
 . F  S FIELD=$O(^TMP($J,"BPSJ-ERROR","MFI",FIELD)) Q:'FIELD  D
 .. S MFACNTR=MFACNTR+1
 .. S ^TMP("HLA",$J,MFACNTR)=MFAP1_"V60"_FIELD_MFAP2
 ;
 I $D(^TMP($J,"BPSJ-ERROR","MFE")) S FIELD="" D
 . F  S FIELD=$O(^TMP($J,"BPSJ-ERROR","MFE",FIELD)) Q:'FIELD  D
 .. S MFACNTR=MFACNTR+1
 .. S ^TMP("HLA",$J,MFACNTR)=MFAP1_"V61"_FIELD_MFAP2
 ;
 I $D(^TMP($J,"BPSJ-ERROR","ZPS")) S FIELD="" D
 . F  S FIELD=$O(^TMP($J,"BPSJ-ERROR","ZPS",FIELD)) Q:'FIELD  D
 .. S MFACNTR=MFACNTR+1
 .. S ^TMP("HLA",$J,MFACNTR)=MFAP1_"V62"_FIELD_MFAP2
 ;
 I $D(^TMP($J,"BPSJ-ERROR","ZPR")) S RECORD="" D
 . F  S RECORD=$O(^TMP($J,"BPSJ-ERROR","ZPR",RECORD)),FIELD="" Q:'RECORD  D
 .. F  S FIELD=$O(^TMP($J,"BPSJ-ERROR","ZPR",RECORD,FIELD)) Q:'FIELD  D
 ... S ZPRERR=$G(^TMP($J,"BPSJ-ERROR","ZPR",RECORD,FIELD))
 ... S MFACNTR=MFACNTR+1,^TMP("HLA",$J,MFACNTR)=MFAP1_ZPRERR_MFAP2
 ;
 Q
DGAPPACK ; $G the APPACK var
 S APPACK("MFA",1)=$G(APPACK("MFA",1))
 S APPACK("MFA",2)=$G(APPACK("MFA",2))
 S APPACK("MFA",3)=$G(APPACK("MFA",3))
 S APPACK("MFA",4,1)=$G(APPACK("MFA",4,1))
 S APPACK("MFA",4,2)=$G(APPACK("MFA",4,2))
 S APPACK("MFA",5)=$G(APPACK("MFA",5))
 S APPACK("MFA",6)=$G(APPACK("MFA",6))
 S APPACK("MFI",1,1)=$G(APPACK("MFI",1,1))
 S APPACK("MFI",1,2)=$G(APPACK("MFI",1,2))
 S APPACK("MFI",3)=$G(APPACK("MFI",3))
 S APPACK("MFI",6)=$G(APPACK("MFI",6))
 S APPACK("MSA",1)=$G(APPACK("MSA",1))
 S APPACK("MSA",2)=$G(APPACK("MSA",2))
 Q
