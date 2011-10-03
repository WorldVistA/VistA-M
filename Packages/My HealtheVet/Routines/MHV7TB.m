MHV7TB ;WAS/GPM - HL7 BOLUS TRANSMITTER ;  [12/31/07 6:15pm]
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
BOLUS(MSGROOT,XMT,HL) ; Build and Transmit large messages in Bolus mode
 ;   Walks message in MSGROOT and transmits multiple response messages
 ; based on the desired message size in XMT("MAX SIZE").
 ;   Always creates at least one message with at least one record.
 ; Messages may exceed the maximum size by the size of the last record
 ; added to the message.
 ;
 ; Algorithm:
 ; Copy original message to temporary storage
 ; Extract header segments common to all mesages (MSA,QPD,QRD,QAK,etc)
 ; Determine QAK segment postion if exists
 ; For each message in the bolus response
 ;     merge in the common header segments
 ;     add segments by walking the original message
 ;     if reach end of orginal message or exceed maximum size
 ;         if QAK exists update with hit counts
 ;         transmit message
 ;
 ;  Integration Agreements:
 ;         2164 : GENERATE^HLMA
 ;
 ;  Input:
 ;     MSGROOT - Global root of message array
 ;         XMT - Transmission parameters
 ;            XMT("PROTOCOL") - Protocol for deferred transmissions
 ;            XMT("BUILDER") - Name/tag of message builder routine
 ;            XMT("MAX SIZE") - Maximum message size
 ;            XMT("BREAK SEGMENT") - Segment that marks new record
 ;          HL - HL7 package array variable
 ;
 ;  Output: HL7 Messages Transmitted
 ;
 N ORGROOT,ORGCNT,MSGHEAD,HEADSIZE,HEADCNT,QAKPOS,QAKSEG,MSGSIZE,MSGCNT,MAXSIZE,HIT,HITTOT,HITREM,CNT,SEG,SEGTYPE,BREAKPT,FS,END,XMIT,HLRSLT,HLP
 ;
 D LOG^MHVUL2("TRANSMIT "_$P(XMT("BUILDER"),"^")_" BOLUS","BEGIN","S","DEBUG")
 ;
 S ORGROOT="^TMP(""MHV7 BOLUS ROOT"",$J)"
 M @ORGROOT=@MSGROOT
 K @MSGROOT
 S BREAKPT=XMT("BREAK SEGMENT")
 S MAXSIZE=XMT("MAX SIZE")
 S QAKPOS=0,QAKSEG=""
 S HEADCNT=0,HEADSIZE=0,ORGCNT=0
 S FS=HL("FS")                 ;field separator
 ;
 ; Pull out header segments (MSA,QAK,QPD,QRD,etc)
 ;-----------------------------------------
 F  D  Q:SEG=""!(SEGTYPE=BREAKPT)
 . S ORGCNT=ORGCNT+1
 . S SEG=$G(@ORGROOT@(ORGCNT))
 . Q:SEG=""
 . S SEGTYPE=$E(SEG,1,3)
 . Q:SEGTYPE=BREAKPT
 . S MSGHEAD(ORGCNT)=SEG
 . S HEADSIZE=HEADSIZE+$L(SEG)
 . S HEADCNT=HEADCNT+1
 . I SEGTYPE="QAK" D
 . . S QAKPOS=ORGCNT
 . . S QAKSEG=SEG
 . . S HITTOT=$P(QAKSEG,FS,5)
 . . S HITREM=HITTOT
 . . Q
 . Q
 ;
 ; Create and send message bolus messages
 ;-----------------------------------------
 S END=0
 F MSGCNT=1:1 D  Q:END
 . ; Merge in header segments
 . M @MSGROOT=MSGHEAD
 . S MSGSIZE=HEADSIZE
 . S CNT=HEADCNT
 . S HIT=0,XMIT=0
 . ; Merge segments into message
 . F  D  Q:XMIT!END
 . . K SEG S SEG=""
 . . I '$D(@ORGROOT@(ORGCNT)) S END=1 Q
 . . M SEG=@ORGROOT@(ORGCNT)
 . . S SEGTYPE=$E(SEG,1,3)
 . . S MSGSIZE=MSGSIZE+$$SIZE(SEG)
 . . I SEGTYPE=BREAKPT,MSGSIZE>MAXSIZE,HIT>0 S XMIT=1 Q
 . . I SEGTYPE=BREAKPT S HIT=HIT+1
 . . S CNT=CNT+1
 . . M @MSGROOT@(CNT)=SEG
 . . S ORGCNT=ORGCNT+1
 . . Q
 . ; Update QAK
 . I QAKPOS D                        ;Update QAK
 . . S $P(QAKSEG,FS,6)=HIT           ;Hits this payload
 . . S HITREM=HITREM-HIT
 . . S $P(QAKSEG,FS,7)=HITREM        ;Hits remaining
 . . S @MSGROOT@(QAKPOS)=QAKSEG
 . . Q
 . D LOG^MHVUL2("BOLUS MESSAGE:"_MSGCNT,HIT_" HITS","S","DEBUG")
 . D LOG^MHVUL2("MESSAGE "_MSGCNT,MSGROOT,"I","DEBUG")
 . ; Transmit message
 . D GENERATE^HLMA(XMT("PROTOCOL"),"GM",1,.HLRSLT,"",.HLP)
 . K @MSGROOT
 . D LOG^MHVUL2("TRANSMIT MESSAGE:"_MSGCNT,.HLRSLT,"M","DEBUG")
 . Q
 ;
 K @ORGROOT
 D LOG^MHVUL2("TRANSMIT "_$P(XMT("BUILDER"),"^")_" BOLUS","END","S","DEBUG")
 Q
 ;
SIZE(SEG) ; Calculate the size of a segment
 N LEN,I
 S LEN=$L(SEG)
 S I="" F  S I=$O(SEG(I)) Q:I=""  S LEN=LEN+$L(SEG(I))
 Q LEN
 ;
