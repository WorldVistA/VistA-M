MAG7UP ;WOIFO/MLH - Imaging - HL7 - utilities - break out message into a parse tree ; 06/03/2005  12:05
 ;;3.0;IMAGING;**11,51**;26-August-2005
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
PARSE(XMSG,XTREE) ; break the HL7 message lines into a parse tree
 ;
 ; INPUT:  The single-dimensional array of message lines
 ;
 ; OUTPUT:  The parse tree, in the structure
 ;   @XTREE@(NSEG,0)                    segment name
 ;   @XTREE@(NSEG,NFLD,NREP,NCMP,NSCM)  element data
 ;   @XTREE@("B",SEGID,NSEG)          null
 ;
 N I,J,K,L,M,X,Z ; --------------------- scratch vars
 N IMSG ; ------------------------------ message array index
 N ISUBSEG ; --------------------------- index of continuation data for long segs
 N ISUCC ; ----------------------------- successor element index
 N FERR ; ------------------------------ error flag
 N SEG ; ------------------------------- segment data
 N SEGTAG ; ---------------------------- segment ID ("0th" piece)
 N UFS,UCS,URS,UEC,USS ;---------------- HL7 delimiters (universal)
 N ENC ;-------------------------------- HL7 encoding characters
 N UFSESC,UCSESC,URSESC,UECESC,USSESC ;- HL7 escape sequences for delimiters (universal)
 N PATTERN ; --------------------------- pattern match for spanned record
 N NSEG ; ------------------------------ segment number in the parse tree
 N NSEGINPT ; -------------------------- segment number of input HL7 data
 N NFLD ; ------------------------------ field number in the segment
 N FLD ; ------------------------------- field data
 ;
 S FERR=0 ; assume no error
 S IMSG=""
 ;
 ; process MSH segment
 ; If there's a message problem, return it in an NTE segment.
 ;
 S IMSG=$O(@XMSG@(IMSG)) ; array sent?
 I IMSG="" D  Q FERR ; no
 . S FERR=-1
 . ; have to use default field separator
 . S @XMSG@(0)="NTE|1||"_FERR_";no input array found"
 . Q
 S SEG=$G(@XMSG@(IMSG)) Q:$E(SEG,1,3)'="MSH" -2 ; an HL7 message?
 I $E(SEG,1,3)'="MSH" D  Q FERR ; no
 . S FERR=-2
 . S ISUCC=$O(@XMSG@(IMSG)) S:'ISUCC ISUCC=IMSG+1
 . ; have to use default field separator
 . S @XMSG@(IMSG+ISUCC/2)="NTE|1||"_FERR_";invalid HL7 message (1st 3 chars must be MSH)"
 . Q
 ;
 ; set up delimiters and escape sequences
 S UFS=$E(SEG,4),@XTREE@(1,1,1,1,1)=UFS
 S ENC=$P(SEG,UFS,2),@XTREE@(1,2,1,1,1)=ENC
 S UCS=$E(ENC),URS=$E(ENC,2),UEC=$E(ENC,3),USS=$E(ENC,4)
 S UFSESC=UEC_"F"_UEC,UCSESC=UEC_"S"_UEC,URSESC=UEC_"S"_UEC,UECESC=UEC_"E"_UEC,USSESC=UEC_"T"_UEC
 S PATTERN="1A2AN1"""_UFS_""""
 S @XTREE@(1,0)="MSH",@XTREE@("B","MSH",1)=""
 F NFLD=3:1:$L(SEG,UFS) S FLD=$P(SEG,UFS,NFLD) D
 . I FLD]"" D PROCFLD(XTREE,1,NFLD,FLD)
 . Q
 ; process the remaining segments
 S SEG="" ; SEG will be a concatenated series of spanned records
 S NSEG=2 ; next segment in the parse tree will be #2
 F NSEGINPT=2:1 S IMSG=$O(@XMSG@(IMSG)) Q:IMSG=""  D  Q:FERR
 . S SEG=$G(@XMSG@(IMSG)) Q:SEG=""
 . S ISUBSEG="" ; prepare to handle very long HL7 segments (up to 32K)
 . F  S ISUBSEG=$O(@XMSG@(IMSG,ISUBSEG)) Q:ISUBSEG=""  D
 . . S SEG=SEG_$G(@XMSG@(IMSG,ISUBSEG))
 . . Q
 . S SEGTAG=$P(SEG,UFS) I SEGTAG'?1U2.3UN S FERR=-3 Q
 . S @XTREE@(NSEG,0)=SEGTAG,@XTREE@("B",SEGTAG,NSEG)=""
 . F NFLD=2:1:$L(SEG,UFS) D
 . . S FLD=$P(SEG,UFS,NFLD)
 . . I FLD]"" D PROCFLD(XTREE,NSEG,NFLD-1,FLD)
 . . Q
 . S SEG="" ; reinitialize SEG for the next possible concatenation
 . S NSEG=NSEG+1 ; increment counter for next segment in the parse tree
 . Q
 Q FERR
 ;
PROCFLD(XTREE,XNSEG,XNFLD,XFLD) ; process a field
 ;
 ; input:  XTREE   name of MUMPS array for parse tree ($NA format)
 ;         XNSEG   segment number for parse tree
 ;         XNFLD   field number for parse tree
 ;         XFLD    field data
 ;
 N SG ; ------ segment name
 N NREP ; ---- repetition (occurrence) number
 N REP ; ----- repetition data
 N NCMP ; ---- component number
 N CMP ; ----- component data
 N NSCM ; ---- subcomponent number
 N SCM ; ----- subcomponent data
 ;
 S SG=@XTREE@(XNSEG,0)
 ; Per DICOM meeting 2004-02-24, reaffirmed that data may need to be
 ; retrieved above the subcomponent level, and that those data will
 ; need to be de-escaped because the receiving application won't have
 ; access to the delimiters from the original message.
 S @XTREE@(XNSEG,XNFLD)=$$DEESC(XFLD)
 ;
 ; Break out to the lowest delimiter level too.  This is not strictly an
 ; HL7 parse because it does not take actual HL7 (or realm constraining)
 ; data types into account.
 ;
 F NREP=1:1:$L(XFLD,URS) S REP=$P(XFLD,URS,NREP) I REP]"" D
 . F NCMP=1:1:$L(REP,UCS) S CMP=$P(REP,UCS,NCMP) I CMP]"" D
 . . ; Per DICOM meeting 2004-02-24, reaffirmed that data may need to be
 . . ; retrieved above the subcomponent level, and that those data will
 . . ; need to be de-escaped because the receiving application won't have
 . . ; access to the delimiters from the original message.
 . . S @XTREE@(XNSEG,XNFLD,NREP,NCMP)=$$DEESC(CMP)
 . . F NSCM=1:1:$L(CMP,USS) S SCM=$P(CMP,USS,NSCM) I SCM]"" D
 . . . S @XTREE@(XNSEG,XNFLD,NREP,NCMP,NSCM)=$$DEESC(SCM)
 . . . Q
 . . Q
 . Q
 Q
 ;
DEESC(XSCM) ; replace escape sequences with delimiter characters
 ;
 ; input:  XSCM   element data before replacement
 ;
 ; expects:  UFSESC, UCSESC, URSESC, UECESC, USSESC
 ;                delimiter escape sequences
 ;
 ; function return:  element data after replacement
 ;
 N HIT ; need another pass after each hit
 F  D  Q:'$D(HIT)
 . K HIT
 . I XSCM[UFSESC S XSCM=$P(XSCM,UFSESC)_UFS_$P(XSCM,UFSESC,2,99999),HIT=1
 . I XSCM[UCSESC S XSCM=$P(XSCM,UCSESC)_UCS_$P(XSCM,UCSESC,2,99999),HIT=1
 . I XSCM[URSESC S XSCM=$P(XSCM,URSESC)_URS_$P(XSCM,URSESC,2,99999),HIT=1
 . I XSCM[UECESC S XSCM=$P(XSCM,UECESC)_UEC_$P(XSCM,UECESC,2,99999),HIT=1
 . I XSCM[USSESC S XSCM=$P(XSCM,USSESC)_USS_$P(XSCM,USSESC,2,99999),HIT=1
 . Q
 Q $E(XSCM,1,510)
 ;
