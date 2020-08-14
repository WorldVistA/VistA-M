DGPFHLUT ;ALB/RPM - PRF HL7 UTILITIES ; 2/12/2020
 ;;5.3;Registration;**425,650,951,1005**;Aug 13, 1993;Build 57
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;This routine contains generic utilities used when building
 ;or processing received patient record flag HL7 messages.
 ;
 Q  ;no supported direct entry
 ;
INIT(DGPROT,DGHL) ;Kernel HL7 INIT wrapper
 ;
 ;  Supported DBIA #2161:  The supported DBIA is used to access the
 ;                         VistA HL7 API to initialize the HL7 environ-
 ;                         ment variables.
 ;
 ;  Input:
 ;    DGPROT - Event protocol name
 ;
 ;  Output:
 ;    Function value - HLEID on success;0 on failure
 ;    DGHL - HL array from INIT^HLFNC2 Kernel call
 ;
 N DGHLEID
 S DGHLEID=0
 S DGHLEID=$$HLEID(DGPROT)
 I DGHLEID D
 . D INIT^HLFNC2(DGHLEID,.DGHL)
 . I $O(DGHL(""))="" S DGHLEID=0
 Q DGHLEID
 ;
HLEID(DGPROT) ;return IEN of HL7 protocol
 ;
 ;  Input:  
 ;    DGPROT - Protocol name
 ;
 ;  Output:  
 ;   Function value - IEN of protocol on success, 0 on failure
 ;
 I $G(DGPROT)="" Q 0
 Q +$O(^ORD(101,"B",DGPROT,0))
 ;
GETLINK(DGINST) ;retrieve a single link for a given institution
 ;
 ;  Supported DBIA #2271:  The supported DBIA is used to access the
 ;                         VistA HL7 API to retrieve logical links
 ;                         given a pointer to the INSTITUTION (#4) file.
 ;
 ;  Input:
 ;    DGINST - IEN of site in INSTITUTION (#4) file
 ;
 ;  Output:
 ;    Function Value - HL Logical link on success, 0 on failure
 ;
 N DGLINKS
 N DGLNK
 N DGRSLT
 ;
 S DGRSLT=0
 I $G(DGINST)>0 D
 . D LINK^HLUTIL3(DGINST,.DGLINKS)
 . S DGLNK=$O(DGLINKS(0))
 . S DGRSLT=$S(DGLNK>0:DGLINKS(DGLNK),1:0)
 Q DGRSLT
 ;
BLDTEXT(DGWP,DGHL,DGARR) ;Build HL7 word proc text array
 ;
 ;  Supported DBIA #10104:  The supported DBIA is used to access KERNEL
 ;                          string functions.
 ;
 ;  Input:
 ;     DGWP - Word processing closed root
 ;     DGHL - HL7 environment array
 ;
 ;  Output:
 ;   Function Value - count of segment array elements on success,
 ;                    0 on failure
 ;            DGARR - array of segment text data
 ;
 N DGLIN   ;word processing line iterator
 N DGCNT   ;text segment counter
 N DGTXT   ;word processing text
 N DGBLK   ;blank line counter
 N DGREP   ;HL7 repetition character
 ;
 S DGLIN=0
 S DGCNT=0
 S DGBLK=0
 S DGREP=$E(DGHL("ECH"),2)
 ;
 F  S DGLIN=$O(@DGWP@(DGLIN)) Q:'DGLIN  D
 . S DGTXT=$G(@DGWP@(DGLIN,0))
 . S DGTXT=$$STRIPTS^DGPFHLUT(DGTXT)      ;strip trailing spaces
 . I DGTXT?1.PC!(DGTXT="") S DGBLK=DGBLK+1 Q
 . S DGCNT=DGCNT+1
 . I DGBLK D
 . . S DGARR(DGCNT)=$$REPEAT^XLFSTR(DGREP,DGBLK)_DGTXT
 . . S DGBLK=0
 . E  S DGARR(DGCNT)=DGTXT
 Q DGCNT
 ;
NXTSEG(DGROOT,DGCURR,DGFS,DGFLD) ;retrieves next sequential segment
 ; This function retrieves the next segment in the work global, returns
 ; an array of field values and the segment's work global index.  If
 ; the next segment does not exist, then the function returns a zero.
 ;
 ;  Input:
 ;    DGROOT - close root name of work global
 ;    DGCURR - index of current segment
 ;      DGFS - HL7 field separator character
 ;
 ;  Output:
 ;   Function Value  - index of the next segment on success, 0 on failure
 ;             DGFLD - array of segment field values
 ;
 N NXTSEG
 ;
 S DGCURR=DGCURR+1
 S NXTSEG=$G(@DGROOT@(DGCURR,0))
 I NXTSEG]"" D
 . D GETFLDS(NXTSEG,DGFS,.DGFLD)
 E  D
 . S DGCURR=0
 Q DGCURR
 ;
GETFLDS(DGSEG,DGFS,DGFLD) ;retrieve HL7 segment fields into an array
 ;This procedure parses a single HL7 segment and builds an array
 ;subscripted by the field number that contains the data for that field.
 ;An additional subscript node, "TYPE" is created containing the segment
 ;type.
 ;
 ;  Input:
 ;     DGSEG - HL7 segment to parse
 ;      DGFS - HL7 field separator
 ;
 ;  Output:
 ;    DGFLD - array of segment field values subscripted by field #
 ;            Example: DGFLD(2)="DOE,JOHN"
 ;
 N DGI
 ;
 S DGFLD("TYPE")=$P(DGSEG,DGFS)
 F DGI=2:1:$L(DGSEG,DGFS) D
 . S DGFLD($S(DGFLD("TYPE")="MSH":DGI,1:DGI-1))=$P(DGSEG,DGFS,DGI)
 Q
 ;
STRIPTS(DGSTR) ;Strip trailing spaces from a line of text
 ;
 ;  Input:
 ;    DGSTR - Text string
 ;
 ;  Output:
 ;   Function Value - Input text string with trailing spaces removed
 ;
 N SPACE
 S SPACE=$C(32)
 F  Q:$E(DGSTR,$L(DGSTR))'=SPACE  S DGSTR=$E(DGSTR,1,$L(DGSTR)-1)
 Q DGSTR
 ;
BLDSEG(DGTYP,DGVAL,DGHL) ;generic segment builder
 ;
 ;  Input:
 ;    DGTYP - segment type
 ;    DGVAL - field data array [SUB1:field, SUB2:repetition,
 ;                              SUB3:component, SUB4:sub-component] 
 ;     DGHL - HL7 environment array
 ;
 ;  Output:
 ;   Function Value - Formatted HL7 segment on success, "" on failure
 ;
 N DGCMP     ;component subscript
 N DGCMPVAL  ;component value
 N DGFLD     ;field subscript
 N DGFLDVAL  ;field value
 N DGREP     ;repetition subscript
 N DGREPVAL  ;repetition value
 N DGSUB     ;sub-component subscript
 N DGSUBVAL  ;sub-component value
 N DGFS      ;field separator
 N DGCS      ;component separator
 N DGRS      ;repetition separator
 N DGSS      ;sub-component separator
 N DGSEG
 N DGSEP
 ;
 Q:($G(DGTYP)']"") ""
 ;
 S DGSEG=DGTYP
 S DGFS=DGHL("FS")
 S DGCS=$E(DGHL("ECH"))
 S DGRS=$E(DGHL("ECH"),2)
 S DGSS=$E(DGHL("ECH"),4)
 ;
 F DGFLD=1:1:$O(DGVAL(""),-1) D
 . S DGFLDVAL=$G(DGVAL(DGFLD)),DGSEP=DGFS
 . D ADD(DGFLDVAL,DGSEP,.DGSEG)
 . F DGREP=1:1:$O(DGVAL(DGFLD,""),-1)  D
 . . S DGREPVAL=$G(DGVAL(DGFLD,DGREP))
 . . S DGSEP=$S(DGREP=1:"",1:DGRS)
 . . D ADD(DGREPVAL,DGSEP,.DGSEG)
 . . F DGCMP=1:1:$O(DGVAL(DGFLD,DGREP,""),-1) D
 . . . S DGCMPVAL=$G(DGVAL(DGFLD,DGREP,DGCMP))
 . . . S DGSEP=$S(DGCMP=1:"",1:DGCS)
 . . . D ADD(DGCMPVAL,DGSEP,.DGSEG)
 . . . F DGSUB=1:1:$O(DGVAL(DGFLD,DGREP,DGCMP,""),-1) D
 . . . . S DGSUBVAL=$G(DGVAL(DGFLD,DGREP,DGCMP,DGSUB))
 . . . . S DGSEP=$S(DGSUB=1:"",1:DGSS)
 . . . . D ADD(DGSUBVAL,DGSEP,.DGSEG)
 Q DGSEG
 ;
ADD(DGVAL,DGSEP,DGSEG) ;append a value onto segment
 ;
 ;  Input:
 ;    DGVAL - value to append
 ;    DGSEP - HL7 separator
 ;
 ;  Output:
 ;    DGSEG - segment passed by reference
 ;
 S DGSEP=$G(DGSEP)
 S DGVAL=$G(DGVAL)
 S DGSEG=DGSEG_DGSEP_DGVAL
 Q
 ;
CKSTR(DGFLDS,DGSTR) ;validate comma-delimited HL7 field string
 ;
 ;  Input:
 ;    DGFLDS - (required) comma delimited string of required fields
 ;    DGSTR - (optional) comma delimited string of fields to include
 ;            in an HL7 segment.
 ;
 ;  Output:
 ;   Function Value - validated string of fields
 ;
 N DGI     ;generic index
 N DGREQ   ;required field
 ;
 Q:($G(DGFLDS)']"") ""
 S DGSTR=$G(DGSTR)
 F DGI=1:1 S DGREQ=$P(DGFLDS,",",DGI) Q:DGREQ=""  D
 . I ","_DGSTR_","'[(","_DGREQ_",") S DGSTR=DGSTR_$S($L(DGSTR)>0:",",1:"")_DGREQ
 Q DGSTR
 ;
CONVMID(DGID) ;convert #772 msgid to #773 msgid
 ;This function takes the HL7 message ID from the DIRECT^HLMA API result,
 ;which is based on the HL7 MESSAGE TEXT (#772) file IEN and converts it
 ;into a message ID based on the HL7 MESSAGE ADMINISTRATION (#773) file.
 ;
 ;  Integration Agreements:
 ;    #4564 - allows access to the "C" index of HL7 MESSAGE TEXT (#772)
 ;    #4669 - allows access to the "B" index and MESSAGE ID (#2) field
 ;            of HL7 MESSAGE ADMINISTRATION (#773) file.
 ;  Input:
 ;    DGID - HL7 message id returned from DIRECT^HLMA
 ;
 ;  Output:
 ;    Function value - returns HL7 message control ID from HL MESSAGE
 ;                     ADMINISTRATION (#773) file on success;
 ;                     0 on failure
 ;
 N DG772  ;HL7 MESSAGE TEXT (#772) file IEN
 N DG773  ;HL7 MESSAGE ADMINISTRATION (#773) file IEN
 N DGERR  ;FM error array
 N DGMCID  ;message ID
 ;
 S DG772=+$O(^HL(772,"C",+$G(DGID),0))
 S DG773=+$O(^HLMA("B",DG772,0))
 S DGMCID=+$$GET1^DIQ(773,DG773_",",2,"I","","DGERR")
 Q $S(DGMCID&('$D(DGERR)):DGMCID,1:0)
 ;
ENCHL7(STR) ; Encode HL7 escape sequences in a string
 ;
 ; Input:
 ; STR = string possibly containing HL7 encoding chars
 ;
 ; HLFS and HLECH are assumed to be already initialized by HL7 (call to INIT^HLFNC2)
 ;
 ; Returns string with encoded escape seqs as follows:
 ;  field separator (HLFS) --> \F\
 ;  component separator (HLECH-1) --> \S\
 ;  repetition separator (HLECH-2) --> \R\
 ;  escape character (HLECH-3) --> \E\
 ;  subcomponent separator (HLECH-4) --> \T\
 ;
 N CHR,CHRSTR,CNT,ESC,FLG,NEW,RPLC,Z1,Z2
 ;
 S ESC=$E(HLECH,3) ; escape character
 S CHRSTR=HLFS_HLECH,FLG=0 F Z1=1:1:5 S CHR=$E(CHRSTR,Z1),CNT=$L(STR,CHR) I CNT>1 D
 .S NEW=$P(STR,CHR)
 .S RPLC=$C(26)_$TR(CHR,CHRSTR,"FSRET")_$C(26)
 .F Z2=2:1:CNT S NEW=NEW_RPLC_$P(STR,CHR,Z2)
 .S STR=NEW
 .S FLG=1 ; flag to indicate that at least one escape sequence was encoded
 .Q
 S:FLG STR=$TR(STR,$C(26),ESC)
 Q STR
 ;
DECHL7(STR) ; Decode HL7 escape sequences in a string
 ;
 ; Input:
 ; STR = string possibly containing HL7 escape sequences for encoding chars
 ;
 ; HLFS and HLECH are assumed to be already initialized by HL7 (call to INIT^HLFNC2)
 ;
 ; Returns string with decoded escape seqs as follows:
 ;  \F\ --> field separator (HLFS)
 ;  \S\ --> component separator (HLECH-1)
 ;  \R\ --> repetition separator (HLECH-2)
 ;  \E\ --> escape character (HLECH-3)
 ;  \T\ --> subcomponent separator (HLECH-4)
 ;
 ; Note: if any of HL7 encoding characters is "^", it gets replaced with a single space
 ;       in order to prevent filing problems.
 ;
 N ECHARS,ECODE,ESC,LEN,PAT,PCE,REPL
 ;
 ; Replace ^ with a single space to prevent filing problems
 S ECHARS=$TR(HLECH,"^"," ")
 S ESC=$E(ECHARS,3) ; escape character
 ; Check for escape sequences, quit if none found
 I STR'[ESC Q STR
 ; Array of rep. chars
 S REPL("F")=$S(HLFS="^":" ",1:HLFS) ;Field delimiter
 S REPL("S")=$E(ECHARS)              ;Comp. delimiter
 S REPL("R")=$E(ECHARS,2)            ;Rep. delimiter
 ; Temp. replace w/ASC 26, until after other ESC are stripped
 S REPL("E")=$C(26)                  ;Esc. char
 S REPL("T")=$E(ECHARS,4)            ;Subcomp. delimiter
 ; Translate escape seqs left to right
 S LEN=$L(STR,ESC) F PCE=1:1:(LEN-1)\2 D
 .; Ignore empty or unrecognized escape sequences
 .S ECODE=$P(STR,ESC,2) I ECODE="" S ECODE="XXXX"
 .I $D(REPL(ECODE))'>0 S STR=$P(STR,ESC)_$C(26)_$P(STR,ESC,2)_$C(26)_$P(STR,ESC,3,LEN) Q
 .; Else, replace escape sequence with encoding character
 .S STR=$P(STR,ESC)_$G(REPL(ECODE))_$P(STR,ESC,3,LEN)
 ;Replace the decoded ESC chars that were actually sent
 S STR=$TR(STR,$C(26),ESC)
 Q STR
