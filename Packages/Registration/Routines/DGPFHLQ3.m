DGPFHLQ3 ;ALB/RPM - PRF HL7 QRY PROCESSING ; 12/13/04
 ;;5.3;Registration;**425,650**;Aug 13, 1993;Build 3
 ;
PARSQRY(DGWRK,DGHL,DGQRY,DGPFERR) ;Parse QRY~R02 Message/Segments
 ;
 ;  Input:
 ;    DGWRK - Closed root global reference
 ;     DGHL - VistA HL7 environment array
 ;
 ;  Output:
 ;    DGQRY - Patient lookup components array
 ;   DGPFERR - Undefined on success, ERR segment data array on failure
 ;             Format:  DGPFERR(seg_id,sequence,fld_pos)=error_code
 ;
 N DGRSLT    ;result from CHK^DIE
 N DGFS      ;field separator
 N DGCS      ;component separator
 N DGRS      ;repetition separator
 N DGSS      ;sub-component separator
 N DGCURLIN  ;current segment line
 N DGSEG     ;segment field data array
 N DGERR     ;error processing array
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
 . S DGCURLIN=$$NXTSEG^DGPFHLUT(DGWRK,DGCURLIN,DGFS,.DGSEG)
 . Q:'DGCURLIN
 . D @(DGSEG("TYPE")_"(.DGSEG,DGCS,DGRS,DGSS,.DGQRY,.DGPFERR)")
 Q
 ;
MSH(DGSEG,DGCS,DGRS,DGSS,DGQRY,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGQRY - array of ORF results
 ;            "SNDFAC" - sending facility
 ;            "RCVFAC" - receiving facility
 ;            "MSGDTM" - message creation date/time in FileMan format
 ;    DGERR - undefined on success, error array on failure
 ;
 D MSH^DGPFHLU4(.DGSEG,DGCS,DGRS,DGSS,.DGQRY,.DGERR)
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
 ;    DGQRY("QID") - Query ID
 ;           DGERR - undefined on success, error array on failure
 ;                      format: DGERR(seg_id,sequence,fld_pos)=error code
 ;
 S DGQRY("QID")=$G(DGSEG(4))
 S DGQRY("ICN")=+$P($G(DGSEG(8)),DGCS,1)
 Q
 ;
QRF(DGSEG,DGCS,DGRS,DGSS,DGQRY,DGERR) ;
 ; This procedure is a placeholder to allow parsing loop to continue.
 ;
 ;  Input:
 ;    DGSEG - PID segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;           DGERR - undefined on success, error array on failure
 ;                   format: DGERR(seg_id,sequence,fld_pos)=error code
 ;
 Q
