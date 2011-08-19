RORHL7 ;HCIOFO/SG - HL7 UTILITIES ; 11/2/05 10:30am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** ADDS THE SEGMENT TO THE HL7 MESSAGE BUFFER
 ;
 ; .SOURCE       Reference to a local variable where the
 ;               source data is stored
 ;
 ; [SRCTYPE]     Type and format of the source data
 ;                 "C"  Complete segment (see the ADDSEGC^RORHL7A
 ;                      for source data format description)
 ;                 "F"  List of field values (see the ADDSEGF^RORHL7A 
 ;                      for source data format description).
 ;                      This is the default parameter value.
 ;
ADDSEG(SOURCE,SRCTYPE) ;
 I $G(SRCTYPE)?."F"  D ADDSEGF^RORHL7A(.SOURCE)  Q
 I SRCTYPE="C"       D ADDSEGC^RORHL7A(.SOURCE)  Q
 D ERROR^RORERR(-88,,,,"SRCTYPE",$G(SRCTYPE))
 Q
 ;
 ;***** CREATES A NEW MESSAGE IN THE BATCH
 ;
 ; The function adds a new message header to the batch. If the batch
 ; does not exist yet, it is created.
 ;
 ; [.RORMSH]     Reference to a variable in what a MSH segment of
 ;               the message is returned.
 ;
 ; Return Values:
 ;        <0  Error Code
 ;        >0  Index of a subnode of the ^TMP("HLS",$J) that
 ;            contains the new MSH segment.
 ;
 ; MSH segment is returned as a value of the RORMSH parameter. In case
 ; of a long segment, continuations are returned as subnodes.
 ;
 ; Several nodes (HL7*) in ROREXT are set and the ^TMP("HLS",$J) node
 ; is deleted by this entry point before it creates a new batch.
 ;
CREATE(RORMSH) ;
 N NDX,RC,TMP  K RORMSH
 Q:$G(ROREXT("HL7PROT"))="" $$ERROR^RORERR(-25)
 ;--- Create a message stub for the new batch message
 ;    (if it has not been created before)
 I '$G(ROREXT("HL7MTIEN"))  D  Q:$G(RC)<0 RC
 . N RORMID,RORIEN,RORDT
 . ;--- Set up HL7 environment variables
 . S RC=$$INIT($NA(^TMP("HLS",$J)))  Q:RC<0
 . ;--- Create a stub
 . S RORDT=$S($G(ROREXT("HDTIEN"))>0:$G(ROREXT("HL7DT")),1:"")
 . D CREATE^HLTF(.RORMID,.RORIEN,.RORDT)
 . ;--- Save parameters of the new batch message
 . S (ROREXT("HL7CNT"),ROREXT("HL7SIZE"))=0
 . S ROREXT("HL7DT")=RORDT
 . S ROREXT("HL7MID")=RORMID
 . S ROREXT("HL7MTIEN")=RORIEN
 . ;--- Initialize temporary storage
 . K ^TMP("HLS",$J)
 ;--- Initialize the HL7 environment variables
 S RC=$$INIT()  Q:RC<0 RC
 S NDX=$G(ROREXT("HL7PTR"))+1
 ;--- Reset the Set ID's for all supported segments
 F TMP="OBR","OBX","PID","PV1","ZRD","ZSP"  D
 . S ROREXT("HL7SID",TMP)=1
 ;--- Create and store a MSH segment for individual message
 S ROREXT("HL7CNT")=ROREXT("HL7CNT")+1
 S TMP=ROREXT("HL7MID")_"-"_ROREXT("HL7CNT")
 D MSH^HLFNC2(.RORHL,TMP,.RORMSH)
 S:$P(RORMSH,RORHL("FS"),17)="US" $P(RORMSH,RORHL("FS"),17)="USA"
 M ^TMP("HLS",$J,NDX)=RORMSH
 S ROREXT("HL7SIZE")=ROREXT("HL7SIZE")+$L(RORMSH)+$L($G(RORMSH(1)))+1
 S ROREXT("HL7PTR")=NDX
 Q NDX
 ;
 ;***** REPLACES ENCODING CHARACTERS WITH ESCAPE CODES
 ;
 ; STR           Source string
 ;
 ; The HLFS and HLECH variables must be initialized before
 ; calling this function (either by the INIT^HLFNC2 or manually).
 ;
 ; The function returns the source string with encoding
 ; characters replaced with corresponding escape codes.
 ;
ESCAPE(STR) ;
 Q:STR="" STR
 N BUF,ESC,CH,I1,I2,SCLST
 S SCLST=HLECH_HLFS
 ;--- Find all occurrences of encoding characters and
 ;    save their positions to a local array
 F I1=1:1:5  S CH=$E(SCLST,I1),I2=1  Q:CH=""  D
 . F  S I2=$F(STR,CH,I2)  Q:'I2  S BUF(I2-1)=I1
 Q:$D(BUF)<10 STR
 ;--- Replace encoding characters with escape codes
 S (BUF,I2)="",ESC=$E(HLECH,3)  S:ESC="" ESC="\"
 F  S I1=I2,I2=$O(BUF(I2))  Q:I2=""  D
 . S BUF=BUF_$E(STR,I1+1,I2-1)_ESC_$E("SRETF",BUF(I2))_ESC
 Q BUF_$E(STR,I1+1,$L(STR))
 ;
 ;***** CHECKS THE DATE/TIME AND CONVERTS IT TO HL7 FORMAT
 ;
 ; DATE          Date/time in FileMan format
 ;
FM2HL(DATE) ;
 Q:'$G(DATE) """"""
 S DATE=$$FMTHL7^XLFDT(DATE)
 Q $S(DATE>0:DATE,1:"")
 ;
 ;***** INITIALIZES THE HL7 SEPARATORS
 ;
 ; [.CS]         Reference to a local variable where the
 ;               component separator will be returned to.
 ;
 ; [.SCS]        Reference to a local variable where the
 ;               sub-component separator will be returned to.
 ;
 ; [.RPS]        Reference to a local variable where the
 ;               repetition separator will be returned to.
 ;
ECH(CS,SCS,RPS) ;
 S HLECH=$G(RORHL("ECH"),"^~\&")
 S CS=$E(HLECH,1),SCS=$E(HLECH,4),RPS=$E(HLECH,2)
 Q
 ;
 ;***** INITIALIZES THE HL7 ENVIRONMENT VARIABLES
 ;
 ; [ROR8FILE]    Closed root of the buffer that will be used for
 ;               construction of the HL7 message.
 ;
 ; Return Values:
 ;        <0  Error Code
 ;         0  Ok
 ;
INIT(ROR8FILE) ;
 N TMP  K RORHL
 D INIT^HLFNC2(ROREXT("HL7PROT"),.RORHL)
 Q:$G(RORHL) $$ERROR^RORERR(-23,,RORHL)
 S TMP=$G(RORHL("ECH"))
 Q:$L(TMP)<4 $$ERROR^RORERR(-75)
 ;--- Initialize the nodes required for the API's
 S:$G(ROR8FILE)'="" ROREXT("HL7BUF")=ROR8FILE
 D:$G(ROREXT("HL7BUF"))'=""
 . S ROREXT("HL7PTR")=+$O(@ROREXT("HL7BUF")@(""),-1)
 Q 0
 ;
 ;***** CHECKS IF MAXIMUM BATCH SIZE IS REACHED
 ;
 ; [RESERVE]     Number of bytes reserved in the batch (0 by default)
 ;
 ; Return Values:
 ;         0  Messages can be added to the batch
 ;         1  Maximum size of the batch has been reached
 ;
ISMAXSZ(RESERVE) ;
 Q:$G(ROREXT("MAXHL7SIZE"))'>0 0
 Q:($G(ROREXT("HL7SIZE"))+$G(RESERVE))<ROREXT("MAXHL7SIZE") 0
 S $P(ROREXT("HL7SIZE"),U,2)=1
 Q 1
 ;
 ;***** RETURNS NUMBER OF MESSAGES IN THE CURRENT BATCH
MSGCNT() ;
 Q $G(ROREXT("HL7CNT"))
 ;
 ;***** RETURNS THE POINTER TO LAST SEGMENT IN THE MESSAGE BUFFER
PTR() Q +$G(ROREXT("HL7PTR"))
 ;
 ;***** DELETES THE SEGMENTS FROM THE HL7 MESSAGE BUFFER
 ;
 ; SEGPTR        An index of the HL7 segment in the message buffer
 ;
 ; [KEEP]        Keep the segment referenced by the SEGPTR and start
 ;               the rollback from the next segment.
 ;
ROLLBACK(SEGPTR,KEEP) ;
 N BUF,I,I1,MSH,NODE,SEGNAME
 S NODE=ROREXT("HL7BUF"),HLFS=$G(RORHL("FS"),"|")
 S I=$S($G(KEEP):$O(@NODE@(SEGPTR)),1:+SEGPTR)
 S MSH=$S(I>0:$P($G(@NODE@(I)),HLFS)="MSH",1:0)
 ;---
 F  Q:I'>0  D  S I=$O(@NODE@(I))
 . S BUF=$G(@NODE@(I))
 . ;--- Decrement the batch size indicator
 . S ROREXT("HL7SIZE")=$G(ROREXT("HL7SIZE"))-$L(BUF)-1
 . S I1=""
 . F  S I1=$O(@NODE@(I,I1))  Q:I1=""  D
 . . S ROREXT("HL7SIZE")=ROREXT("HL7SIZE")-$L(@NODE@(I,I1))
 . ;--- Decrement the 'Set ID' counter if necessary
 . S SEGNAME=$P(BUF,HLFS),I1=+$G(ROREXT("HL7SID",SEGNAME))
 . I I1>0  S:$P(BUF,HLFS,2)>0 ROREXT("HL7SID",SEGNAME)=I1-1
 . ;--- Delete the segment
 . K @NODE@(I)
 ;--- Validate current size of the batch
 S:$G(ROREXT("HL7SIZE"))<0 ROREXT("HL7SIZE")=0
 ;--- Decrease number of messages in the batch if necessary
 I MSH  S:$G(ROREXT("HL7CNT"))>0 ROREXT("HL7CNT")=ROREXT("HL7CNT")-1
 Q
 ;
 ;***** SENDS THE BATCH MESSAGE
 ;
 ; .MID          Reference to a local variable where the batch
 ;               message ID (returned by the GENERATE^HLMA) is
 ;               returned to.
 ;
 ; Return Values:
 ;        <0  Error Code
 ;         0  Ok
 ;        >0  There was nothing to send
 ;
 ; Several nodes (HL7*) in the ROREXT and the ^TMP("HLS",$J) node
 ; are deleted by this entry point.
 ;
SEND(MID) ;
 N RC,RORBUF,RORHLP  S MID=""
 Q:$G(ROREXT("HL7PROT"))="" $$ERROR^RORERR(-25)
 ;--- Quit if there is nothing to send
 Q:'$G(ROREXT("HL7MTIEN"))!($D(^TMP("HLS",$J))<10) 1
 ;--- Set up the HL7 environment variables
 D INIT^HLFNC2(ROREXT("HL7PROT"),.RORHL)
 Q:$G(RORHL) $$ERROR^RORERR(-23,,RORHL)
 ;--- Send the message
 S RORHLP("NAMESPACE")="ROR"
 D GENERATE^HLMA(ROREXT("HL7PROT"),"GB",1,.RORBUF,ROREXT("HL7MTIEN"),.RORHLP)
 S RC=$S($P(RORBUF,U,2):$$ERROR^RORERR(-24,,RORBUF),1:0)
 S MID=$P(RORBUF,U)
 ;--- Cleanup if there is no error or not in debug mode
 D:'$G(RORPARM("DEBUG"))!(RC'<0)
 . F TMP="HL7CNT","HL7MTIEN","HL7SIZE"  K ROREXT(TMP)
 . K ^TMP("HLS",$J)
 Q RC
