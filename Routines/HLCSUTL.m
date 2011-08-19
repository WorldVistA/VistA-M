HLCSUTL ;ALB/MTC - CS Utility Routines ;06/03/2008 11:57
 ;;1.6;HEALTH LEVEL SEVEN;**2,19,58,64,65,142**;Oct 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
READ(HLDHANG,HLDBSIZE,HLTRM) ;  This function will perform a read on the device and
 ;  return the characters read and the termination character.
 ;
 ; INPUT : HLDHANG - TimeOut for read
 ;         HLDBSIZE- Block Size for read
 ;         HLTRM   - Passed by reference to return termination char
 ; OUTPUT:          <Data> - Ok
 ;                  -1^TIMEOUT : fails
 ;         
 N RESULT,X,Y
 ;
 K HLTOUT
 ;-- do read
 U IO R X#HLDBSIZE:HLDHANG I '$T S RESULT="-1^TIMEOUT" G READQ
 X ^%ZOSF("TRMRD") S HLTRM=Y
 S RESULT=X
 ;
READQ Q RESULT
 ;
NEXTLINE(LL0,LL1,LINE,ARR,QUE) ;  This function will return the next line from the
 ; Logical Link file #870 specified by LL0 and the position in the queue
 ; specified by QUE at the position LL1. This function will return the
 ; line in the array specifed by ARR. And the position in the WP
 ; field where the last part of the segment was found.
 ; Lastly a <CR> will be appended to the end of the segment
 ;
 ; INPUT :
 ;        LL0 - IFN of logical link
 ;        LL1 - Position in QUE to begin search for next line
 ;        LINE- Last line position, "" will return first line
 ;        ARR - Array to store next line. The output will be in the
 ;              following format ARR(1), ARR(2)
 ;        QUE - Will specify "IN" or "OUT" queue to pull data from
 ;
 ; OUTPUT:
 ;        ARR - As specified above
 ;        RESULT - Position last segment was found or "" if no line
 ;                 was found.
 ;
 ; 
 N RESULT,HLQUE,X,I
 S RESULT="",HLQUE=$S(QUE="IN":1,QUE="OUT":2,1:"")
 ;-- start looking for next line
 S X=+LINE,I=0 F  S X=$O(^HLCS(870,LL0,HLQUE,LL1,1,X)) Q:'X  D  I $G(^HLCS(870,LL0,HLQUE,LL1,1,X,0))="" S RESULT=X,@ARR@(I)=@ARR@(I)_$C(13) Q
 . I $D(^HLCS(870,LL0,HLQUE,LL1,1,X,0)),^(0)'="" S I=I+1,@ARR@(I)=$G(^HLCS(870,LL0,HLQUE,LL1,1,X,0))
 ;
 Q RESULT
 ;
FLD(NODE,FLD) ;This function will return the value for the field
 ;INPUT: NODE=HLNODE from the HLNEXT call, passed by reference
 ;       FLD=field position in segment
 ;       HL("FS") must be defined
 ;OUTPUT: value for the field in this segment
 Q:$G(HL("FS"))=""!($G(NODE)="")!('$G(FLD)) ""
 N I,L,L1,X,Y
 S NODE(0)=NODE,L=0,Y=1,X=""
 ;Y=begining piece of each node, L1=number of pieces in each node
 ;L=last piece in each node, quit when last piece is greater than FLD
 F I=0:1 Q:'$D(NODE(I))  S L1=$L(NODE(I),HL("FS")),L=L1+Y-1 D  Q:Y>FLD
 . ;if FLD is less than last piece, this node has field you want
 . S:FLD'>L X=X_$P(NODE(I),HL("FS"),(FLD-Y+1))
 . S Y=L
 K NODE(0)
 Q X
 ;
CHKSUM(HLTEXT) ; This function will return the checksum for the segment
 ; contained in the array ARR. If no checksum can be calculated an -1
 ; will be returned.
 ;
 ;  INPUT - HLTEXT the name of the array to be used in the calulation
 ;          of the checksum. The format is ARR(1,N),...ARR(M,N)
 ; OUTPUT - Decimal checksum %ZOSF("LPC")^Lenght of segment
 ;
 N RESULT,LEN,X,X1,X2,X3,Y,I
 S RESULT="",LEN=0,X1=0
 ;
 F  S X1=$O(@HLTEXT@(X1)) Q:'X1  S X=@HLTEXT@(X1),X2=$D(@HLTEXT@(X1)),LEN=LEN+$L(X) D
 . X ^%ZOSF("LPC") S RESULT=RESULT_$C(Y)
 . I X2=11 S X3=0 F  S X3=$O(@HLTEXT@(X1,X3)) Q:'X3  D
 .. S X=@HLTEXT@(X1,X3),LEN=LEN+$L(X) X ^%ZOSF("LPC") S RESULT=RESULT_$C(Y)
 ;
 S X=RESULT X ^%ZOSF("LPC") S RESULT=Y
 Q RESULT_"^"_LEN
 ;
CHKSUM2(HLTEXT) ; *** Add in <CR> *** This function will return the checksum for the segment
 ; contained in the array ARR. If no checksum can be calculated an -1
 ; will be returned.
 ;
 ;  INPUT - HLTEXT the name of the array to be used in the calulation
 ;          of the checksum. The format is ARR(1,N),...ARR(M,N)
 ; OUTPUT - Decimal checksum %ZOSF("LPC")^Lenght of segment
 ;
 N RESULT,LEN,X,X1,X2,X3,Y,I
 S RESULT="",LEN=0,X1=0
 ;
 F  S X1=$O(@HLTEXT@(X1)) Q:'X1  S X=@HLTEXT@(X1),X2=$D(@HLTEXT@(X1)),LEN=LEN+$L(X) D
 . X ^%ZOSF("LPC") S RESULT=RESULT_$C(Y)
 . I X2=1 S RESULT=RESULT_$C(13),LEN=LEN+1 Q
 . I X2=11 S X3=0 F  S X3=$O(@HLTEXT@(X1,X3)) Q:'X3  D
 .. S X=@HLTEXT@(X1,X3),LEN=LEN+$L(X) X ^%ZOSF("LPC") S RESULT=RESULT_$C(Y)
 ..I $O(@HLTEXT@(X1,X3))="" S RESULT=RESULT_$C(13),LEN=LEN+1
 ;
 S X=RESULT X ^%ZOSF("LPC") S RESULT=Y
 Q RESULT_"^"_LEN
 ;
APPEND(HLTEXT,LL0,LL1) ; This function will append the data contained in
 ; the HLTEXT array into the IN queue multiple (LL1) of the Logical
 ; Link (LL0) file 870.
 ;  INPUT : HLTEXT - Array containing text to append
 ;          LL0    - IEN of File 870
 ;          LL1    - IEN of IN queue multiple
 ;
 N HLI,X,X1,X2,X3
 S X=""
 S HLI=$P($G(^HLCS(870,LL0,1,LL1,1,0)),U,3)
 S:'HLI HLI=0
 F  S X=$O(@HLTEXT@(X)) Q:'X  S HLI=HLI+1,^HLCS(870,LL0,1,LL1,1,HLI,0)=@HLTEXT@(X),X2=$D(@HLTEXT@(X)) D
 . I X2=11 S ^HLCS(870,LL0,1,LL1,2,HLI,0)="" S X3=0 F  S X3=$O(@HLTEXT@(X,X3)) Q:'X3  D
 .. S HLI=HLI+1,^HLCS(870,LL0,1,LL1,1,HLI,0)=$G(@HLTEXT@(X,X3))
 . S HLI=HLI+1,^HLCS(870,LL0,1,LL1,1,HLI,0)="" Q
 ;
 ;-- update 0 node
 S ^HLCS(870,LL0,1,LL1,1,0)="^^"_HLI_"^"_HLI_"^"_DT_"^"
 Q
 ;
HLNEXT ;-- This routine is used to return the next segment from file 772
 ;   during processing of an inbound message. The following variables
 ;   are used for the processing.
 ;   HLMTIEN - Entry in 772 where message is
 ;   HLQUIT  - Curent ien of "IN" wp field
 ;   HLNODE  - Data is returned in HLNODE=Segment and HLNODE(n) if
 ;             segmemt is greater than 245 chars.
 ;
 K HLNODE
 N HLI,HLDONE,HLX
 S HLNODE="",HLDONE=0
 I HLQUIT="" S HLQUIT=0
 ;HLMTIEN is undef, no response to process
 I '$G(HLMTIEN) S HLQUIT=0 Q
 ;first time, check if new format
 I '$D(HLDONE1) D  Q:HLQUIT
 . S HLX=$O(^HLMA("B",HLMTIEN,0))
 . ;old format, set HLDONE1 so we won't come here again
 . I 'HLX S HLDONE1=0 Q
 . ;already got header, reset HLQUIT for text
 . I HLQUIT S (HLDONE1,HLQUIT)=0 Q
 . ;new format, get header in 773
 . S HLQUIT=$O(^HLMA(HLX,"MSH",HLQUIT))
 . ;there is no header
 . I 'HLQUIT S (HLDONE1,HLQUIT)=0 Q
 . S HLNODE=$G(^HLMA(HLX,"MSH",HLQUIT,0)),HLI=0
 . F  S HLQUIT=$O(^HLMA(HLX,"MSH",HLQUIT)) Q:'HLQUIT  D  Q:HLDONE
 .. I ^HLMA(HLX,"MSH",HLQUIT,0)="" S HLDONE=1 Q
 .. S HLI=HLI+1,HLNODE(HLI)=$G(^HLMA(HLX,"MSH",HLQUIT,0)) Q
 . S HLQUIT=1 Q
 S HLQUIT=$O(^HL(772,HLMTIEN,"IN",HLQUIT))
 I HLQUIT D  Q
 . ; patch HL*1.6*142 start
 . N HLQUIT2  ; use to save the last ien
 . S HLNODE=$G(^HL(772,HLMTIEN,"IN",HLQUIT,0)),HLI=0
 . ; F  S HLQUIT=$O(^HL(772,HLMTIEN,"IN",HLQUIT)) Q:'HLQUIT  D  Q:HLDONE
 . F  S HLQUIT2=HLQUIT,HLQUIT=$O(^HL(772,HLMTIEN,"IN",HLQUIT)) Q:'HLQUIT  D  Q:HLDONE
 .. I ^HL(772,HLMTIEN,"IN",HLQUIT,0)="" S HLDONE=1 Q
 .. S HLI=HLI+1,HLNODE(HLI)=$G(^HL(772,HLMTIEN,"IN",HLQUIT,0)) Q
 . ; for the occurrence when the last segment is not followed by <CR>
 . I HLQUIT="" S HLQUIT=HLQUIT2
 . ; patch HL*1.6*142 end
 ;no more nodes, kill flag and quit
 K HLDONE1 Q
 ;
MSGLINE(HLMID) ;return the number of lines in a message, TCP type only
 ;input: HLMID=message id
 Q:$G(HLMID)="" 0
 N HLCNT,HLIENS,HLIEN
 ;can't find message
 S HLIENS=$O(^HLMA("C",HLMID,0)) Q:'HLIENS 0
 S HLIEN=+$G(^HLMA(HLIENS,0)) Q:'HLIEN 0
 S HLCNT=$P($G(^HLMA(HLIENS,"MSH",0)),U,4)+$P($G(^HL(772,HLIEN,"IN",0)),U,4)
 Q HLCNT
 ;
MSGSIZE(HLIENS) ;return the number of characters in a message, TCP type only
 ;input: HLIENS= ien in file 773
 Q:'$G(HLIENS) 0
 N HLCNT,HLI,HLIEN,HLZ
 ;HLIEN=ien in file 772, message text.  Blank lines are CR, add 1
 Q:'$G(^HLMA(HLIENS,0)) 0 S HLIEN=+(^(0)) Q:'HLIEN 0
 S (HLCNT,HLI,HLZ)=0
 ;get header
 F  S HLI=$O(^HLMA(HLIENS,"MSH",HLI)) Q:'HLI  S HLZ=$L($G(^(HLI,0))),HLCNT=HLCNT+$S(HLZ:HLZ,1:1)
 ;if last line of header wasn't blank, add 1 for CR
 S:HLZ HLCNT=HLCNT+1
 ;get body
 S HLI=0 F  S HLI=$O(^HL(772,HLIEN,"IN",HLI)) Q:'HLI  S HLZ=$L($G(^(HLI,0))),HLCNT=HLCNT+$S(HLZ:HLZ,1:1)
 Q HLCNT
 ;
MSG(HLMID,HLREST) ;return the message text in the reference HLREST
 ;only for TCP type messages
 ;input: HLMID=message id,  HLREST=closed local or global reference
 ;to place message text
 ;output:  return 1 for success and 0 if message doesn't exist
 Q:$G(HLMID)=""!($G(HLREST)="") 0
 N HLCNT,HLI,HLIENS,HLIEN,HLZ
 ;can't find message
 S HLIENS=$O(^HLMA("C",HLMID,0)) Q:'HLIENS 0
 S HLIEN=+$G(^HLMA(HLIENS,0)) Q:'HLIEN 0
 ;RESULT must be close reference
 D  I '$D(HLREST) Q 0
 . Q:HLREST'["("
 . I $E(HLREST,$L(HLREST))=")",$F(HLREST,")")>($F(HLREST,"(")+1) Q
 . K HLREST
 S (HLCNT,HLI)=0,HLZ=""
 ;get header
 F  S HLI=$O(^HLMA(HLIENS,"MSH",HLI)) Q:'HLI  S HLCNT=HLCNT+1,(HLZ,@HLREST@(HLCNT))=$G(^(HLI,0))
 S:HLZ'="" HLCNT=HLCNT+1,@HLREST@(HLCNT)=""
 ;get body
 S HLI=0 F  S HLI=$O(^HL(772,HLIEN,"IN",HLI)) Q:'HLI  S HLCNT=HLCNT+1,@HLREST@(HLCNT)=$G(^(HLI,0))
 Q 1
