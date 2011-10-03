DGPFHLU3 ;ALB/RPM - PRF HL7 BUILD MSA/ERR SEGMENTS ; 3/03/03
 ;;5.3;Registration;**425,650**;Aug 13, 1993;Build 3
 ;
 Q
 ;
MSA(DGACK,DGID,DGERR,DGFLD,DGHL) ;MSA Segment API
 ;This function wraps the data retrieval and segment creation APIs and
 ;returns a formatted MSA segment.
 ;
 ;  Input:
 ;     DGACK - (required) MSA segment Acknowledgment code
 ;      DGID - (required) Message Control ID
 ;     DGERR - (optional) Error condition
 ;     DGFLD - (optional) List of comma-separated fields (sequence #'s)
 ;             to include.  Defaults to all required fields (1,2).
 ;      DGHL - (required) HL7 environment array
 ;
 ;  Output:
 ;   Function Value - MSA segment on success, "" on failure
 ;
 N DGMSA
 N DGVAL
 ;
 S DGMSA=""
 I $G(DGACK)]"",+$G(DGID) D
 . S DGERR=$G(DGERR)
 . S DGFLD=$$CKSTR^DGPFHLUT("1,2",DGFLD)  ;validate field string
 . I DGERR]"" S DGFLD=DGFLD_",6"
 . S DGFLD=","_DGFLD_","
 . I $$MSAVAL(DGFLD,DGACK,DGID,"","","",DGERR,.DGVAL) D
 . . S DGMSA=$$BLDSEG^DGPFHLUT("MSA",.DGVAL,.DGHL)
 Q DGMSA
 ;
MSAVAL(DGFLD,DGACK,DGID,DGTEXT,DGESN,DGDAT,DGERR,DGVAL) ;build MSA value array
 ;
 ;  Input:
 ;     DGFLD - (required) fields string
 ;     DGACK - (required) MSA segment Acknowledgment code
 ;      DGID - (required) Message Control ID
 ;    DGTEXT - (optional) Text message
 ;     DGESN - (optional) Expected sequence number
 ;     DGDAT - (optional) Delayed acknowledgment type
 ;     DGERR - (optional) Error condition
 ;
 ;  Output:
 ;   Function Value - 1 on sucess, 0 on failure
 ;            DGVAL - MSA field array [SUB1:field, SUB2:repetition,
 ;                                    SUB3:component, SUB4:sub-component]
 ;
 N DGRSLT    ;function value
 N DGACKS    ;array of valid ACK codes
 N DGCOD     ;ACK code string
 ;
 S DGRSLT=0
 I $G(DGFLD)]"",$G(DGACK)]"",+$G(DGID) D
 . F DGCOD="AA","AE","AR","CA","CE","CR" S DGACKS(DGCOD)=""
 . ;
 . ; seq 1 Acknowledgment Code
 . I DGFLD[",1," D
 . . S DGVAL(1)=$S($D(DGACKS(DGACK)):DGACK,1:"")
 . Q:(DGVAL(1)="")  ;required field
 . ;
 . ; seq 2 Message Control ID
 . I DGFLD[",2," D
 . . S DGVAL(2)=DGID
 . Q:(DGVAL(2)="")  ;required field
 . ;
 . ; seq 3 Text Message
 . I DGFLD[",3," D
 . . S DGVAL(3)=$G(DGTEXT)
 . ;
 . ; seq 4 Expected Sequence Number
 . I DGFLD[",4," D
 . . S DGVAL(4)=$G(DGESN)
 . ;
 . ; seq 5 Delayed Acknowledgment Type
 . I DGFLD[",5," D
 . . S DGDAT=$G(DGDAT)
 . . S DGVAL(5)=$S(DGDAT="D":DGDAT,DGDAT="F":DGDAT,1:"")
 . ;
 . ; seq 6 Error Condition
 . I DGFLD[",6," D
 . . S DGVAL(6,1,1)=DGERR
 . . S DGVAL(6,1,2)=$$EZBLD^DIALOG(DGERR)
 . . S DGVAL(6,1,3)="L"
 . S DGRSLT=1
 I 'DGRSLT K DGVAL
 Q DGRSLT
 ;
ERR(DGSEG,DGSEQ,DGPOS,DGCOD,DGFLD,DGHL) ;ERR segment API
 ;
 ;  Input:
 ;    DGSEG - (required) Segment ID
 ;    DGSEQ - (required) Sequence
 ;    DGPOS - (required) Field position
 ;    DGCOD - (required) Error code
 ;    DGFLD - (optional) List of comma-separated fields (sequence #'s)
 ;             to include.  Defaults to all required fields (1).
 ;     DGHL - (required) HL7 Environment array
 ;
 ;  Output:
 ;   Function value - ERR segment on success, "" on failure
 ;
 N DGERR
 N DGVAL
 ;
 S DGERR=""
 I $G(DGSEG)]"",+$G(DGSEQ),+$G(DGPOS),$G(DGCOD)]"",$G(DGHL("ECH"))]"" D
 . S DGFLD=$$CKSTR^DGPFHLUT("1",DGFLD)  ;validate field string
 . S DGFLD=","_DGFLD_","
 . I $$ERRVAL(DGFLD,DGSEG,DGSEQ,DGPOS,DGCOD,.DGVAL) D
 . . S DGERR=$$BLDSEG^DGPFHLUT("ERR",.DGVAL,.DGHL)
 Q DGERR
 ;
ERRVAL(DGFLD,DGSEG,DGSEQ,DGPOS,DGCOD,DGVAL) ;build ERR value array
 ;
 ;  Input:
 ;    DGFLD - (required) Field string
 ;    DGSEG - (required) Segment ID
 ;    DGSEQ - (required) Sequence
 ;    DGPOS - (required) Field position
 ;    DGCOD - (required) Error code
 ;    
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;            DGVAL - ERR field array [SUB1:field, SUB2:repetition,
 ;                                    SUB3:component, SUB4:sub-component]
 N DGRSLT
 ;
 S DGRSLT=0
 I $G(DGFLD)]"",$G(DGSEG)]"",+$G(DGSEQ),+$G(DGPOS),$G(DGCOD)]"" D
 . I DGFLD[",1," D
 . . S DGVAL(1,1,1)=DGSEG
 . . S DGVAL(1,1,2)=DGSEQ
 . . S DGVAL(1,1,3)=DGPOS
 . . S DGVAL(1,1,4,1)=DGCOD
 . . S DGVAL(1,1,4,2)=$$EZBLD^DIALOG(DGCOD)
 . . S DGVAL(1,1,4,3)="L"
 . S DGRSLT=1
 Q DGRSLT
 ;
BLDVA086(DGTBL) ;build error code/text array for table VA086
 ;
 ;  Input:
 ;    none
 ;
 ;  Output:
 ;    DGTBL - error code array subscripted by code containing error text
 ;
 N DGI
 N DGLINE
 N DGCOD
 N DGTXT
 N DGDESC
 ;
 F DGI=1:1 S DGLINE=$T(ERRTBL+DGI) Q:DGLINE=""  D
 . S DGCOD=$P(DGLINE,";",3)
 . S DGTXT=$P(DGLINE,";",4)
 . S DGDESC=$P(DGLINE,";",5)
 . S DGTBL(DGCOD)=DGTXT
 . S DGTBL(DGCOD,"DESC")=DGDESC
 Q
 ;
ERRTBL ;VA086 Error Code Table;error code;error text
 ;;FE;Filer Error;An error occurred at the remote site when attempting to add, update or retrieve assignment data.
 ;;IF;Invalid Patient Record Flag;The transmitted Patient Record Flag is not defined at the remote site.
 ;;IID;Invalid Observation ID;The transmitted observation ID is not "N"arrative, "S"tatus or "C"omment.
 ;;IOR;Invalid Originating Site;The originating site of the transmission is not defined at the remote site.
 ;;IOW;Invalid Owner Site;The transmitted owning site is not defined at the remote site.
 ;;NM;No Match;No patient was found that correlates to the transmitted ICN, DOB and SSN.
 ;;UU;Unauthorized Update;The originating site of the transmission is not defined as the owning site of the assignment or an invalid action was transmitted (i.e. Reactivate an already active assignment).
