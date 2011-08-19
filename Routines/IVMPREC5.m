IVMPREC5 ;ALB/KCL - PROCESS INCOMING (Z03 EVENT TYPE) HL7 MESSAGES ; 3/6/01 4:42pm
 ;;2.0;INCOME VERIFICATION MATCH;**2,17,34**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will process batch ORU SSN(event type Z03) HL7
 ; messages received from the IVM center.  Format of batch:
 ;       BHS
 ;       {MSH
 ;        PID
 ;        ZIV
 ;       }
 ;       BTS
 ;
EN ; entry point to process SSN messages 
 ;
 F IVMDA=1:0 S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)) Q:'IVMDA  S IVMSEG=$G(^(IVMDA,0)) I $E(IVMSEG,1,3)="MSH" D
 .K HLERR
 .S HLMID=$P(IVMSEG,HLFS,10) ; message control id from MSH
 .S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)),IVMSEG=$G(^(+IVMDA,0)) I $E(IVMSEG,1,3)'="PID" D  Q
 ..S HLERR="Missing PID segment" D ACK^IVMPREC
 .S DFN=$P($P(IVMSEG,HLFS,4),$E(HLECH),1)
 .I ('DFN!(DFN'=+DFN)!('$D(^DPT(+DFN,0)))) D  Q
 ..S HLERR="Invalid DFN" D ACK^IVMPREC
 .I $P(IVMSEG,HLFS,20)'=$P(^DPT(DFN,0),"^",9) D  Q
 ..S HLERR="Couldn't match IVM SSN with DHCP SSN" D ACK^IVMPREC
 .S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)),IVMSEG=$G(^(+IVMDA,0)) I $E(IVMSEG,1,3)'="ZIV" D  Q
 ..S HLERR="Missing ZIV segment" D ACK^IVMPREC
 .S IVMSEG=$P(IVMSEG,HLFS,2,999),IVMIY=$P(IVMSEG,HLFS,2)
 .S IVMIY=$$FMDATE^HLFNC(IVMIY) I $E(IVMIY,4,7)'="0000"!($E(IVMIY,1,3)<292) S HLERR="Invalid Income Year" D ACK^IVMPREC Q
 .;
 .I $P(IVMSEG,"^",4)=$P($G(^DPT(DFN,0)),"^",9) D  Q
 ..S HLERR="Client SSN already on file in DHCP" D ACK^IVMPREC Q
 .I $P(IVMSEG,"^",6)]"",$P(IVMSEG,"^",7)']"" D  Q
 ..S HLERR="Missing spouse IEN" D ACK^IVMPREC Q
 .I $P(IVMSEG,"^",6)]"",($P(IVMSEG,"^",6)=$P($$DEM^DGMTU1(+$P(IVMSEG,"^",7)),"^",9)) D  Q
 ..S HLERR="Spouse SSN already on file in DHCP" D ACK^IVMPREC Q
 .;
 .I $P(IVMSEG,"^",4)="",($P(IVMSEG,"^",6)=""!($P(IVMSEG,"^",7)="")) D  Q
 ..S HLERR="Missing client/spouse SSNs" D ACK^IVMPREC Q
 .;
 .D SSNCK I $D(HLERR) D ACK^IVMPREC Q
 .D STORE
 ;
 ; - send notification message if necessary
 I IVMCNTR D MAIL^IVMUFNC()
 Q
 ;
SSNCK ; check to make sure the SSN(s) are valid SSA SSNs
 ;
 N FLAG,L,X
 S FLAG=0 ; set to 1 if problem with SSN
 ;
 F X=$P(IVMSEG,"^",4),$P(IVMSEG,"^",6) Q:FLAG  D
 .S L=$E(X,1,3)
 .I L="000" S FLAG=1 Q  ;         begins with 000
 .I L>649,(L<700) S FLAG=1 Q  ;   650-699 invalid
 .I L>728 S FLAG=1 Q  ;           729-999 invalid
 I FLAG S HLERR="Invalid SSN sent"
 Q
 ;
STORE ; store the ZIV segment in the (#301.5) file for uploading
 ;
 ; check for patient case record
 S DA(1)=$O(^IVM(301.5,"B",+DFN,0)),X=$$IEN^IVMUFNC4("ZIV")
 I DA(1)']"" S HLERR="Patient missing from IVM PATIENT file" D ACK^IVMPREC Q
 I $G(^IVM(301.5,DA(1),"IN",0))']"" S ^(0)="^301.501PA^^"
 S DIC="^IVM(301.5,"_DA(1)_",""IN"",",DIC(0)="L",DLAYGO=301.501
 S DIC("DR")="10////^S X=IVMSEG"
 K DD,DO D FILE^DICN
 ;
 ;
STOREQ K DA,DIC,DIE,X,Y
 ;
 ;
 ; build mail message if SUPPRESS SSN UPLOAD NOTIFICATION is not set
 Q:$P($G(^IVM(301.9,1,0)),"^",3)
 ;
 ;
ZIVBULL ; build mail message for transmission to IVM mail group notifying them
 ; that patients with updated SSA/SSN's have been received from the
 ; IVM Center and may now be uploaded into DHCP.
 ;
 S XMSUB="IVM - SSN UPLOAD"
 S IVMTEXT(1)="Updated SSA/SSNs have been received from the Income Verification"
 S IVMTEXT(2)="Match Center.  Please select the 'SSN Upload' (SSN) option from the"
 S IVMTEXT(3)="'IVM Upload Menu' in order to view/update these SSA/SSNs.  If you"
 S IVMTEXT(4)="have any questions concerning these updated SSA/SSNs, please contact"
 S IVMTEXT(5)="the Income Verification Match Center."
 S IVMTEXT(6)=""
 S IVMTEXT(7)="The following patients have SSA/SSNs to be viewed/updated: "
 S IVMTEXT(8)=" "
 S IVMCNTR=IVMCNTR+1
 S IVMPTID=$$PT^IVMUFNC4(DFN)
 S IVMTEXT(IVMCNTR+8)=$J(IVMCNTR_")",5)_"  "_$P(IVMPTID,"^")_" ("_$P(IVMPTID,"^",3)_")"
 Q
