DGQEHLUT ;ALB/RPM - VIC REPLACEMENT HL7 UTILITIES ; 10/6/03
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;This routine contains generic utilities used when building
 ;or processing received VIC REPLACEMENT HL7 messages.
 ;
 Q  ;no supported direct entry
 ;
INIT(DGPROT,DGHL) ;Kernel HL7 INIT wrapper
 ;
 ;  Supported Reference:
 ;    DBIA #2161: INIT^HLFNC2
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
 N DGSUBVAL  ;suc-component value
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
