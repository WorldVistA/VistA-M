PSULRHL2 ;HCIOFO/BH - File real time HL7 messages ; 3/30/11 10:14am
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**3,17,18**;MARCH, 2005;Build 7
 ;
FILE Q  ;  quit for HLO - ALA
 ;
 ; * THIS CODE IS NEVER TO BE INVOKED AT A SITE!!! ***
 ; * IT SHOULD ONLY BE INSTALLED ON THE CMOP-NAT SERVER ***
 ;
 Q
 ;
 ;***** parses then files the incoming HL7 message into the message
 ;      global
 ;
 ;***** The following are present upon entry to this label
 ;
 ; HLNEXT   M Code you can use to execute a $O through the segments of 
 ;          a message
 ; 
 ; HLNODE   The current segment in the message (initally set to null)
 ;
 ; HLQUIT   If not greater than zero, indicates there are no more 
 ;          segments to $O through
 ;
 ;*****
 ;
 N FAC,HLCS,HLCSS,HLECH,HLFILE,HLFS,I,I2,ID,IEN,J2
 K HLFILE,X2
 ;
 F I2=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S HLFILE(I2)=HLNODE,J2=0
 . F  S J2=$O(HLNODE(J2))  Q:'J2  S HLFILE(I2,J2)=HLNODE(J2)
 ;
 S HLFILE="HLFILE"
 ;
 I $D(@(HLFILE))<10 Q
 ;
 ;
 I '$$PARAMS() Q
 ;
 S IEN=$$DEMO() I 'IEN Q
 ;
 D WRITE(IEN)
 ;
 K X2,HLFILE
 Q
 ;
 ;
WRITE(IEN) ;--- Find the OBR/OBX segments
 ;
 N I,IEN1,IEN2,J,J1,PREV,QUIT,STR,STR1
 S I=0
 F  S I=$O(@HLFILE@(I)) Q:I=""  D
 . S STR=@HLFILE@(I)
 . S J=""
 . F  S J=$O(@HLFILE@(I,J))  Q:J=""  S STR=STR_@HLFILE@(I,J)
 . I $E(STR,1,3)="OBR" D
 . . S IEN1=$$OBR(STR,IEN)
 . . I 'IEN1 Q
 . . S QUIT=0
 . . F  Q:QUIT  S PREV=I,I=$O(@HLFILE@(I)) Q:I=""  D
 . . . S STR1=@HLFILE@(I)
 . . . S J1=""
 . . . F  S J1=$O(@HLFILE@(I,J1))  Q:J1=""  S STR1=STR1_@HLFILE@(I,J1)
 . . . I $E(STR1,1,3)'="OBX" S QUIT=1 Q 
 . . . D OBX(STR1,IEN,IEN1)
 . . S I=PREV
 Q
 ;
 ;
ERROR(CODE,FAC,MESSAGE) ; Files any errors found within the processing
 ;
 ;  Input:        
 ;
 ;  CODE     Error Code
 ;  FAC      Facility number
 ;  MESSAGE  Optional parameter to help illustrate the error
 ;
 ;
 N ARR,FDA,STR
 I CODE=1 S STR=DT_": No patient DFN in the HL7 message ID: "_MESSAGE_" - Facility: "_FAC
 ;
 I CODE=2 S STR=DT_": Fileman Update did not work for message ID: "_MESSAGE_" -  Facility: "_FAC
 ;
 I CODE=3 S STR=DT_": Could not update the OBR segment in message ID "_MESSAGE
 ;
 I CODE=4 S STR=DT_": Could not update the OBX segment in message ID "_MESSAGE
 ;
 S FDA(99999,"+1,",.01)=FAC
 S FDA(99999,"+1,",2)=STR
 D UPDATE^DIE("","FDA",)
 Q
 ;
 ;
OBX(STR1,IEN,IEN1) ; Extracts required OBX fields and files into 
 ;                 the global
 ;
 N FDA2,IENS,INDEX,LABS,LOCAL,LOINCC,LOINCNME,MSG2,NLTCODE,NLTNAME,OUT2,RANGE,RESULT,UNITS,VALUE
 ;
 S LABS=$P(STR1,HLFS,4)
 F INDEX=3,6,9 D
 . S VALUE=$P(LABS,HLCS,INDEX)
 . I VALUE="99LRT" D
 . . S LOCAL=$P(LABS,HLCS,INDEX-1)
 . I VALUE="99NLT" D
 . . S NLTCODE=$P(LABS,HLCS,INDEX-2)
 . . S NLTNAME=$P(LABS,HLCS,INDEX-1)
 . I VALUE="99LN" D
 . . S LOINCC=$P(LABS,HLCS,INDEX-2)
 . . S LOINCNME=$P(LABS,HLCS,INDEX-1)
 ;
 S RESULT=$P(STR1,HLFS,6)
 I $G(RESULTS)="" Q
 S UNITS=$P(STR1,HLFS,7)
 S RANGE=$P(STR1,HLFS,8)
 ;
 S IENS="+1,"_IEN1_","_IEN_","
 S FDA2(99999.11,IENS,.01)=RESULT
 S FDA2(99999.11,IENS,.02)=$G(NLTCODE)
 S FDA2(99999.11,IENS,.03)=$G(NLTNAME)
 S FDA2(99999.11,IENS,.04)=$G(LOINCC)
 S FDA2(99999.11,IENS,.05)=$G(LOINCNME)
 S FDA2(99999.11,IENS,.06)=$G(LOCAL)
 S FDA2(99999.11,IENS,2.01)=UNITS
 S FDA2(99999.11,IENS,2.02)=RANGE
 D UPDATE^DIE("","FDA2","OUT2","MSG2")
 ;
 ;I $D(MSG2) S ^TMP("PSUTEST",$J)=MSG2 D ERROR(4,FAC,ID_" IENs: "_IENS)
 I $D(MSG2) D ERROR(4,FAC,ID_" IENs: "_IENS)
 ;
 Q
 ;
 ;
 ;
OBR(STR,IEN) ; Extracts required OBR fields and files into the global
 N DD,FDA1,MM,MSG1,OUT1,SPEC,SPECDATE,YY
 S SPECDATE=+$P(STR,HLFS,8)
 S MM=$E(SPECDATE,5,6),DD=$E(SPECDATE,7,8),YY=$E(SPECDATE,3,4)
 S YY=$S($E(YY,1,1)=0:"3",1:"2")_YY,SPECDATE=YY_MM_DD
 S SPEC=$P(STR,HLFS,16)
 ;
 S FDA1(99999.01,"+1,"_IEN_",",.01)=SPEC
 S FDA1(99999.01,"+1,"_IEN_",",.02)=SPECDATE
 D UPDATE^DIE("","FDA1","OUT1","MSG1")
 ;
 I $D(MSG1) D ERROR(3,FAC,ID_" IENs: "_IEN) Q 0
 ;
 Q OUT1(1)
 ;
 ;
PARAMS() ; Get HL7 Parameters and facility # from the MSH segment
 N CNT,J2,QUIT,REC
 S (QUIT,CNT)=0
 F  S CNT=$O(@HLFILE@(CNT)) Q:'CNT!(QUIT)  D
 . S REC=@HLFILE@(CNT)
 . S J2=""
 . F  S J2=$O(@HLFILE@(CNT,J2))  Q:J2=""  S REC=REC_@HLFILE@(CNT,J2)
 . I $E(REC,1,3)="MSH" D  Q
 . . S HLFS=$E(REC,4,4)
 . . S HLECH=$P(REC,HLFS,2)
 . . S HLCS=$E(HLECH,1,1)
 . . S HLCSS=$E(HLECH,2,2)
 . . S FAC=$P(REC,HLFS,4),FAC=$P(FAC,HLCS,1)
 . . S ID=$P(REC,HLFS,10)
 . . S QUIT=1
 I $G(FAC)="" Q 0
 Q 1
 ;
DEMO() ; Get the demographic data and file a zero node entry in the 
 ; message global
 ;
 N CNT,DFN,END,FDA,I,ICN,IDSTR,J3,MSG,OUT,QPID,QORC,QUIT,REC,SUB,SSN,STA5A
 S (ICN,SSN,DFN,STA5A)=""
 S (QPID,QORC,QUIT,CNT)=0
 F  S CNT=$O(@HLFILE@(CNT)) Q:'CNT!(QUIT)  D
 . S REC=@HLFILE@(CNT)
 . S J3=""
 . F  S J3=$O(@HLFILE@(CNT,J3))  Q:J3=""  S REC=REC_@HLFILE@(CNT,J3)
 . I $E(REC,1,3)="PID" D  Q
 . . S IDSTR=$P(REC,HLFS,4),END=0
 . . ;
 . . F I=1:1  Q:END  D
 . . . S SUB=$P(IDSTR,HLCSS,I)
 . . . I SUB="" S END=1 Q
 . . . I $P(SUB,HLCS,5)="NI" D
 . . . . I $P(SUB,HLCS,8)'="" Q
 . . . . S ICN=$P(SUB,HLCS,1),ICN=$P(ICN,"V",1)
 . . . . ; 
 . . . . ;PSU*4*17 Don't overwrite SSN with ""
 . . . I $P(SUB,HLCS,5)="SS" D
 . . . . S SSN=$S($G(SSN):SSN,1:$P(SUB,HLCS,1))
 . . . . ;
 . . . I $P(SUB,HLCS,5)="PI" D
 . . . . S DFN=$P(SUB,HLCS,1)
 . . S QPID=1
 . ;*18 Get Station#
 . I $E(REC,1,3)="ORC" D
 . . S STA5A=$P(REC,HLFS,11),STA5A=$P(STA5A,HLCS,14),QORC=1
 . I QPID,QORC S QUIT=1
 ;
 I DFN="" D ERROR(1,FAC,ID) Q 0
 ;
 K FDA,OUT,MSG
 ;
 S FDA(99999,"+1,",.02)=DFN
 S FDA(99999,"+1,",.04)=ICN
 S FDA(99999,"+1,",.05)=SSN
 S FDA(99999,"+1,",.06)=STA5A
 S FDA(99999,"+1,",.01)=FAC
 D UPDATE^DIE("","FDA","OUT","MSG")
 ;
 I $D(MSG) D ERROR(2,FAC,ID) Q 0
 ;
 Q OUT(1)
 ;
 ;
 Q
 ;
 ;
