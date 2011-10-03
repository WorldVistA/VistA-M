MAG7UM ;WOIFO/MLH - Imaging - HL7 - utilities - make a message from a parse tree; 05/18/2007 11:23
 ;;3.0;IMAGING;**11,54**;03-July-2009;;Build 1424
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
MAKE(XTREE,XMSG) ; make a parse tree into an array of message lines
 ;
 ; INPUT:     XTREE     The name of the parse tree ($NA format)
 ;   Parse tree structure:
 ;   @XTREE@(NSEG,0)                    segment name
 ;   @XTREE@(NSEG,NFLD,NREP,NCMP,NSCM)  element data
 ;   @XTREE@("B",SEGID,NSEG)            null
 ;   
 ;            XMSG      The name of a single-dimensional array to be populated
 ;                      with message lines ($NA format).  This array is
 ;                      cleared on invocation.
 ;                      
 ;  OUTPUT:   XMSG      The array after being populated with message lines
 ; 
 N UFS,UCS,URS,UEC,USS ;---------------- HL7 delimiters (universal)
 N X,I ; --------------------------------- scratch var
 N ERR ; ------------------------------- error flag
 N ENC ; ------------------------------- encoding characters string
 N NSEG ; ------------------------------ segment number in the parse tree
 N NMSEG ; ----------------------------- segment number in the message
 N IMSG ; ------------------------------ message array index
 N SEG ; ------------------------------- segment data
 N NFLD ; ------------------------------ field number in the segment
 N FLD ; ------------------------------- field data
 ;
 K @XMSG ; refresh target array
 ; process MSH segment
 Q:$D(@XTREE)<10 -1 ; parse tree sent?
 S NSEG=$O(@XTREE@("")),NMSEG=1
 Q:$G(@XTREE@(NSEG,0))'="MSH" -2 ; an HL7 message?
 Q:$D(@XTREE@(NSEG,9,1,1,1))#10=0 -3 ; message type provided? 
 ; get delimiters or define defaults
 S UFS=$G(@XTREE@(NSEG,1,1,1,1)) I $L(UFS)-1 S UFS="|"
 S ENC=$G(@XTREE@(NSEG,2,1,1,1)) I $L(ENC)-4 S ENC="^~\&"
 S UCS=$E(ENC),URS=$E(ENC,2),UEC=$E(ENC,3),USS=$E(ENC,4)
 I $D(@XTREE@(NSEG,3,1,1,1))#10=0 S @XTREE@(1,3,1,1,1)="VistA Imaging"
 S @XTREE@(NSEG,7,1,1,1)=$$NOW^XLFDT()+17000000*1000000
 I $D(@XTREE@(NSEG,10,1,1,1))#10=0 D
 . S X=""
 . F I=1:1:16 S X=X_$E("0123456789ABCDEF",$R(16)+1)
 . S @XTREE@(NSEG,10,1,1,1)=X
 . Q
 I $D(@XTREE@(NSEG,11,1,1,1))#10=0 S @XTREE@(NSEG,11,1,1,1)="D"
 I $D(@XTREE@(NSEG,12,1,1,1))#10=0 S @XTREE@(NSEG,12,1,1,1)="2.3.1"
 S SEG="MSH"_UFS_ENC
 S NFLD=2
 F  S NFLD=$O(@XTREE@(NSEG,NFLD)) Q:NFLD=""  D PROCFLD(XTREE,NSEG,NFLD,.SEG)
 S @XMSG@(NMSEG)=SEG
 F  S NSEG=$O(@XTREE@(NSEG)) Q:'NSEG  D
 . K SEG
 . S NMSEG=NMSEG+1
 . S NFLD=0
 . F  S NFLD=$O(@XTREE@(NSEG,NFLD)) Q:NFLD=""  D PROCFLD(XTREE,NSEG,NFLD,.SEG)
 . S @XMSG@(NMSEG)=$G(@XTREE@(NSEG,0))_$S($G(SEG)]"":UFS_SEG,1:"")
 . Q
 Q 0
 ;
PROCFLD(XTREE,XNSEG,XNFLD,XSEG) ; process a field
 ;
 ; input:  XTREE   name of MUMPS array for parse tree ($NA format)
 ;         XNSEG   segment number for parse tree
 ;         XNFLD   field number for parse tree
 ;         .XSEG   segment before addition of field
 ;         
 ; output: .XSEG   segment after addition of field
 ;
 N NREP ; ---- repetition (occurrence) number
 N REP ; ----- repetition data
 N NCMP ; ---- component number
 N CMP ; ----- component data
 N NSCM ; ---- subcomponent number
 N SCM ; ----- subcomponent data
 N FLD ; ----- field data
 ;
 S NREP=""
 F  S NREP=$O(@XTREE@(XNSEG,XNFLD,NREP)) Q:NREP=""  D
 . K REP
 . S NCMP=""
 . F  S NCMP=$O(@XTREE@(XNSEG,XNFLD,NREP,NCMP)) Q:NCMP=""  D
 . . K CMP
 . . S NSCM=""
 . . F  S NSCM=$O(@XTREE@(XNSEG,XNFLD,NREP,NCMP,NSCM)) Q:NSCM=""  D
 . . . S SCM=@XTREE@(XNSEG,XNFLD,NREP,NCMP,NSCM)
 . . . S $P(CMP,USS,NSCM)=$$ESC(.SCM)
 . . . Q
 . . S $P(REP,UCS,NCMP)=CMP
 . . Q
 . S $P(FLD,URS,NREP)=REP
 . Q
 S $P(XSEG,UFS,NFLD)=$G(FLD)
 Q
 ;
ESC(XDTA) ;apply escape sequence to data
 ; Insert an intermediate token, then expand the intermediate token to
 ; the real escape sequence.  (We have to do 2 steps because the escape
 ; sequence uses the escape character.)
 F  Q:XDTA'[UFS  S XDTA=$P(XDTA,UFS)_$C(1)_$P(XDTA,UFS,2,999)
 F  Q:XDTA'[UCS  S XDTA=$P(XDTA,UCS)_$C(2)_$P(XDTA,UCS,2,999)
 F  Q:XDTA'[URS  S XDTA=$P(XDTA,URS)_$C(3)_$P(XDTA,URS,2,999)
 F  Q:XDTA'[UEC  S XDTA=$P(XDTA,UEC)_$C(4)_$P(XDTA,UEC,2,999)
 F  Q:XDTA'[USS  S XDTA=$P(XDTA,USS)_$C(5)_$P(XDTA,USS,2,999)
 F  Q:XDTA'[$C(1)  S XDTA=$P(XDTA,$C(1))_UEC_"F"_UEC_$P(XDTA,$C(1),2,999)
 F  Q:XDTA'[$C(2)  S XDTA=$P(XDTA,$C(2))_UEC_"S"_UEC_$P(XDTA,$C(2),2,999)
 F  Q:XDTA'[$C(3)  S XDTA=$P(XDTA,$C(3))_UEC_"R"_UEC_$P(XDTA,$C(3),2,999)
 F  Q:XDTA'[$C(4)  S XDTA=$P(XDTA,$C(4))_UEC_"E"_UEC_$P(XDTA,$C(4),2,999)
 F  Q:XDTA'[$C(5)  S XDTA=$P(XDTA,$C(5))_UEC_"T"_UEC_$P(XDTA,$C(5),2,999)
 Q XDTA
 ;
