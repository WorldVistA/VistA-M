DGROHLQ3 ;DJH/AMA - ROM HL7 QRY/ORF PROCESSING ; 27 Apr 2004  4:50 PM
 ;;5.3;Registration;**533,572**;Aug 13, 1993
 ;
PARSQRY(DGWRK,DGHL,DGQRY,DGROERR) ;Parse QRY~R02 Message/Segments
 ;Called from RCVQRY^DGROHLR
 ;  Input:
 ;    DGWRK - Closed root global reference, ^TMP("DGROHL7",$J)
 ;     DGHL - VistA HL7 environment array
 ;
 ;  Output:
 ;    DGQRY - Patient lookup components array
 ;   DGROERR - Undefined on success, ERR segment data array on failure
 ;             Format:  DGROERR(seg_id,sequence,fld_pos)=error_code
 ;
 N DGFS      ;field separator
 N DGCS      ;component separator
 N DGRS      ;repetition separator
 N DGSS      ;sub-component separator
 N DGCURLIN  ;current segment line
 N DGSEG     ;segment field data array
 N DGROERR   ;error processing array
 ;
 S DGFS=DGHL("FS")
 S DGCS=$E(DGHL("ECH"),1)
 S DGRS=$E(DGHL("ECH"),2)
 S DGSS=$E(DGHL("ECH"),4)
 S DGCURLIN=0
 ;
 ;loop through the message segments and retrieve the field data
 F  D  Q:'DGCURLIN
 . N DGSEG
 . S DGCURLIN=$$NXTSEG^DGROHLUT(DGWRK,DGCURLIN,DGFS,.DGSEG)
 . Q:'DGCURLIN
 . D @(DGSEG("TYPE")_"(.DGSEG,DGCS,DGRS,DGSS,.DGQRY,.DGROERR)")
 Q
 ;
PARSORF(DGWRK,DGHL,DGORF,DGMSG,DGDATA) ;Parse ORF~R04 Message/Segments
 ;Called RCVORF^DGROHLR
 ;  Input:
 ;    DGWRK - Closed root work global reference, ^TMP("DGROHL7",$J)
 ;     DGHL - HL7 environment array
 ;
 ;  Output:
 ;     DGORF - array of ORF results
 ;             "ACKCODE" - acknowledgment code ("AA","AE","AR")
 ;             "DFN"     - DFN
 ;             "ICN"     - patient's Integrated Control Number
 ;             "MSGDTM"  - message creation date/time in FileMan format
 ;             "MSGID"   - Message ID for HL7
 ;             "RCVFAC"  - receiving facility
 ;             "SNDFAC"  - sending facility
 ;    DGDATA - array of patient data to upload, ^TMP("DGROFDA",$J)
 ;     DGMSG - undefined on success, array of MailMan text on failure
 ;
 N DGFS,DGCS,DGRS,DGSS,DGCURLIN
 ;
 S DGFS=DGHL("FS")
 S DGCS=$E(DGHL("ECH"),1)
 S DGRS=$E(DGHL("ECH"),2)
 S DGSS=$E(DGHL("ECH"),4)
 S DGCURLIN=0
 ;
 ;loop through the message segments and retrieve the field data
 F  D  Q:'DGCURLIN
 . N DGSEG
 . S DGCURLIN=$$NXTSEG^DGROHLUT(DGWRK,DGCURLIN,DGFS,.DGSEG)
 . Q:'DGCURLIN
 . I DGSEG("TYPE")'="FDA" D @(DGSEG("TYPE")_"(.DGSEG,DGCS,DGRS,DGSS,.DGORF,.DGMSG)") I 1
 . E  D FDA^DGROHLU(DGWRK,.DGCURLIN,DGFS,DGCS,DGRS,.DGDATA)
 Q
 ;
MSH(DGSEG,DGCS,DGRS,DGSS,DGORF,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGORF - array of ORF results
 ;            "SNDFAC" - sending facility
 ;            "RCVFAC" - receiving facility
 ;            "MSGDTM" - message creation date/time in FileMan format
 ;    DGERR - undefined on success, error array on failure
 ;
 D MSH^DGROHLU4(.DGSEG,DGCS,DGRS,DGSS,.DGORF,.DGERR)
 Q
 ;
MSA(DGSEG,DGCS,DGRS,DGSS,DGORF,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGORF - array of ORF results
 ;            "ACKCODE" - Acknowledgment code
 ;            "MSGID" - Message Control ID of the message being ACK'ed
 ;    DGERR - undefined on success, error array on failure
 ;
 D MSA^DGROHLU4(.DGSEG,DGCS,DGRS,DGSS,.DGORF,.DGERR)
 Q
 ;
ERR(DGSEG,DGCS,DGRS,DGSS,DGORF,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGORF - array of ORF results
 ;    DGERR - undefined on success, error array on failure
 ;
 D ERR^DGROHLU4(.DGSEG,DGCS,DGRS,DGSS,.DGORF,.DGERR)
 Q
 ;
QRD(DGSEG,DGCS,DGRS,DGSS,DGQRY,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGQRY("ICN") - Patient's Integrated Control Number
 ;    DGQRY("DFN") - Query ID
 ;   DGQRY("USER") - Query Site user's info   ;DG*5.3*572
 ;           DGERR - undefined on success, error array on failure
 ;                      format: DGERR(seg_id,sequence,fld_pos)=error code
 ;
 S DGQRY("DFN")=$P($G(DGSEG(4)),"~")
 S DGQRY("USER")=$P($G(DGSEG(4)),"~",2,99)
 S DGQRY("ICN")=+$P($G(DGSEG(8)),DGCS,1)
 S DGQRY("PATCH")=$G(DGSEG(5))
 I DGQRY("ICN")="" D
 . S DGERR("QRD",1,8)="NM"
 Q
 ;
QRF(DGSEG,DGCS,DGRS,DGSS,DGQRY,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - PID segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGQRY("SSN") - Patient's Social Security Number
 ;    DGQRY("DOB") - Patient's Date of Birth
 ;           DGERR - undefined on success, error array on failure
 ;                   format: DGERR(seg_id,sequence,fld_pos)=error code
 ;
 S DGQRY("SSN")=$G(DGSEG(4))
 I DGQRY("SSN")="" S DGERR("QRF",1,4)="NM"  ;no match
 ;
 S DGQRY("DOB")=+$$HL7TFM^XLFDT($G(DGSEG(5)))
 I DGQRY("DOB")'>0 S DGERR("QRF",1,5)="NM"  ;no match
 Q
