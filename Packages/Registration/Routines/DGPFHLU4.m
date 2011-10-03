DGPFHLU4 ;ALB/RPM - PRF HL7 ACK PROCESSING ; 3/04/03
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
BLDACK(DGACK,DGROOT,DGHL,DGSEGERR,DGSTOERR) ;Build ACK Message/Segments
 ;
 ;  Input:
 ;      DGACK - (required) Acknowledment code
 ;     DGROOT - (required) Segment array name
 ;       DGHL - (required) HL7 environment array
 ;   DGSEGERR - (optional) defined only if errors during parsing
 ;   DGSTOERR - (optional) defined only if errors during filing
 ;
 ;  Output:
 ;   Function Value - 1 on success, 0 on failure
 ;   ^TMP("HLA",$J) - Array of ACK segments
 ;
 N DGCNT   ;segment counter
 N DGMSA   ;formatted MSA segment
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 I $G(DGACK)]"",$G(DGROOT)]"" D
 . S DGCNT=0
 . ;
 . ;build MSA segment
 . S DGMSA=$$MSA^DGPFHLU3(DGACK,DGHL("MID"),.DGSTOERR,"1,2",.DGHL)
 . Q:(DGMSA="")
 . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGMSA
 . ;
 . ;build ERR segments
 . Q:($D(DGSEGERR)&('$$BLDERR(DGROOT,.DGSEGERR,.DGHL,.DGCNT)))
 . ;
 . ;success
 . S DGRSLT=1
 Q DGRSLT
 ;
PARSACK(DGWRK,DGHL,DGACK,DGMSG) ;Parse ACK Message/Segments
 ;
 ;  Input:
 ;    DGWRK - Closed root work global reference
 ;     DGHL - HL7 environment array
 ;
 ;  Output:
 ;    DGACK - array of ACK results
 ;    DGMSG - undefined on success, array of MailMan text on failure
 ;
 N DGFS
 N DGCS
 N DGRS
 N DGSS
 N DGCURLIN
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
 . D @(DGSEG("TYPE")_"(.DGSEG,DGCS,DGRS,DGSS,.DGACK,.DGMSG)")
 Q
 ;
MSH(DGSEG,DGCS,DGRS,DGSS,DGACK,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGACK - array of ACK results
 ;            "SNDFAC" - sending facility
 ;            "RCVFAC" - receiving facility
 ;            "MSGDTM" - message creation date/time in FileMan format
 ;    DGERR - undefined on success, error array on failure
 ;
 S DGACK("SNDFAC")=$P($G(DGSEG(4)),DGCS,1)
 S DGACK("RCVFAC")=$P($G(DGSEG(6)),DGCS,1)
 S DGACK("MSGDTM")=$$HL7TFM^XLFDT($G(DGSEG(7)))
 Q
 ;
MSA(DGSEG,DGCS,DGRS,DGSS,DGACK,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGACK - array of ACK results
 ;            "ACKCODE" - Acknowledgment code
 ;            "MSGID" - Message Control ID of the message being ACK'ed
 ;    DGERR - undefined on success, error array on failure
 ;
 N DGCNT
 ;
 S DGACK("ACKCODE")=$G(DGSEG(1))
 S DGACK("MSGID")=$G(DGSEG(2))
 I DGACK("ACKCODE")'="AA",$G(DGSEG(6))]"" D
 . S DGCNT=$O(DGERR(""),-1),DGCNT=DGCNT+1
 . S DGERR(DGCNT)=$P(DGSEG(6),DGCS,1)
 Q
 ;
ERR(DGSEG,DGCS,DGRS,DGSS,DGACK,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGACK - array of ACK results
 ;    DGERR - undefined on success, error array on failure
 ;
 N DGCNT
 N DGCOD
 ;
 I $G(DGSEG(1))]"" D
 . S DGCOD=$P($P(DGSEG(1),DGCS,4),DGSS,1)
 . I DGCOD]"" D
 . . S DGCNT=$O(DGERR(""),-1),DGCNT=DGCNT+1
 . . S DGERR(DGCNT)=DGCOD
 Q
 ;
BLDERR(DGROOT,DGSEGERR,DGHL,DGCNT) ;build all ERR segments
 ;This function builds a formatted ERR segment for each entry in the
 ;segment error array (DGSEGERR).
 ;
 ;  Input:
 ;     DGROOT - (required) Closed root array or global name for segment
 ;              storage
 ;   DGSEGERR - (required) Array of segment errors
 ;              Format: DGSEGERR(segment name,sequence,field)=error code
 ;       DGHL - (required) VistA HL7 environment array
 ;      DGCNT - (optional) Previous segment # in DGROOT
 ;
 ;  Output:
 ;   Function Value - 1 on success, 0 on failure
 ;
 N DGCOD   ;error code
 N DGERR   ;formatted ERR segment
 N DGPOS   ;field positions containing error
 N DGSEG   ;segment name containing error
 N DGSEQ   ;sequence of segment containing error
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 I $G(DGROOT)]"",$D(DGSEGERR) D
 . S DGCNT=$G(DGCNT,0)
 . S DGSEG=""
 . F  S DGSEG=$O(DGSEGERR(DGSEG)) Q:(DGSEG="")  D  Q:(DGERR="")
 . . S DGSEQ=0
 . . F  S DGSEQ=$O(DGSEGERR(DGSEG,DGSEQ)) Q:'DGSEQ  D  Q:(DGERR="")
 . . . S DGPOS=0
 . . . F  S DGPOS=$O(DGSEGERR(DGSEG,DGSEQ,DGPOS)) Q:'DGPOS  D  Q:(DGERR="")
 . . . . S DGCOD=DGSEGERR(DGSEG,DGSEQ,DGPOS)
 . . . . S DGERR=$$ERR^DGPFHLU3(DGSEG,DGSEQ,DGPOS,DGCOD,"1",.DGHL)
 . . . . Q:(DGERR="")
 . . . . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGERR
 . Q:(DGERR="")
 . S DGRSLT=1
 Q DGRSLT
