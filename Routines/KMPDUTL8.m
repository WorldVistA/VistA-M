KMPDUTL8 ;OAK/RAK - CM Tools Utility ;2/17/04  10:52
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**2**;Mar 22, 2002
 ;
ADD(KMPDNAME,KMPDARRY,KMPDIEN) ;-- add new entry to file #8972.1
 ;-----------------------------------------------------------------------
 ; KMPDNAME... Field #.01 (free text).
 ; KMPDARRY(). Array containing data to file in format (passed by value):
 ;               KMPDARRY(FieldNumber)=InternalEntryValue.
 ;               Example: KMPDARRY(.02)=2990719.1001
 ;                        KMPDARRY(.03)=12345
 ;                        KMPDARRY(.04)="1290"
 ;                        KMPDARRY(...)="..."
 ;                        KMPDARRY(10,1,0)="This contains word"
 ;                        KMPDARRY(10,2,0)="processing text for the"
 ;                        KMPDARRY(10,3,0)="COMMENTS field."
 ; KMPDIEN... New ien for entry (if not successful KMPDIEN will be null).
 ;-----------------------------------------------------------------------
 ;
 Q:$G(KMPDNAME)=""
 ; convert disallowed characters.
 S KMPDNAME=$$CONVERT^KMPDUTL7(KMPDNAME)
 Q:KMPDNAME=""
 ;
 N FDA,I,MESSAGE,ZIEN
 ; name.
 S FDA($J,8972.1,"+1,",.01)=KMPDNAME
 ; additional fields.
 F I=.02:.01:.09 I $G(@KMPDARRY@(I))'="" D 
 .S FDA($J,8972.1,"+1,",I)=@KMPDARRY@(I)
 ; 'comments' word-processing field.
 S:$O(@KMPDARRY@(10,0)) FDA($J,8972.1,"+1,",10)=KMPDARRY_"(10)"
 ;
 ; update file 8971.1.
 D UPDATE^DIE("","FDA($J)","ZIEN","MESSAGE")
 S KMPDIEN=$G(ZIEN(1)) Q:'KMPDIEN
 ; if error message.
 I $D(MESSAGE) D MSG^DIALOG("W","",60,10,"MESSAGE")
 ;
 Q
 ;
EDIT(KMPDIEN,KMPDARRY) ;-- edit entry in file #8972.1
 ;-----------------------------------------------------------------------
 ; KMPDIEN... Ien for file #8972.1 (CM CODE EVALUATOR)
 ; KMPDARRY(). Array containing data to file in format (passed by value):
 ;               KMPDARRY(FieldNumber)=InternalEntryValue.
 ;               Example: KMPDARRY(.02)=2990719.1001
 ;                        KMPDARRY(.03)=12345
 ;                        KMPDARRY(.04)="1290"
 ;                        KMPDARRY(...)="..."
 ;                        KMPDARRY(10,1,0)="This contains word"
 ;                        KMPDARRY(10,2,0)="processing text for the"
 ;                        KMPDARRY(10,3,0)="COMMENTS field."
 ;-----------------------------------------------------------------------
 ;
 Q:'$G(KMPDIEN)
 Q:'$D(^KMPD(8972.1,+KMPDIEN,0))#5
 Q:$G(KMPDARRY)=""
 ;
 N DATA,FDA,I,MESSAGE,ZIEN
 ;
 ; data already stored for this entry
 S DATA(0)=$G(^KMPD(8972.1,+KMPDIEN,0))
 ;
 ; date/time last edited
 S FDA($J,8972.1,KMPDIEN_",",2.01)=$$NOW^XLFDT
 ;
 ; last edited by
 S:$G(DUZ) FDA($J,8972.1,KMPDIEN_",",2.02)=DUZ
 ;
 ; add data elements to current data
 F I=.04:.01:.09 D 
 .S FDA($J,8972.1,KMPDIEN_",",I)=@KMPDARRY@(I)+$P(DATA(0),U,(I*100))
 .; make sure not negative number
 .S FDA($J,8972.1,KMPDIEN_",",I)=$$NUMBER^KMPDUTL7(FDA($J,8972.1,KMPDIEN_",",I))
 .; if number has grown to 15 characters or more then make this code
 .; evaluator inactive
 .S:$L(FDA($J,8972.1,KMPDIEN_",",I))>14 FDA($J,8971.1,KMPDIEN_",",.11)=0
 ;
 ; increment count
 S FDA($J,8972.1,KMPDIEN_",",.1)=$P(DATA(0),U,10)+1
 ;
 ; 'comments' word-processing field.
 S:$O(@KMPDARRY@(10,0)) FDA($J,8972.1,KMPDIEN_",",10)=KMPDARRY_"(10)"
 ;
 ; update file 8971.1.
 D UPDATE^DIE("","FDA($J)","ZIEN","MESSAGE")
 ;
 S KMPDIEN=$G(ZIEN(1)) Q:'KMPDIEN
 ;
 ; if error message.
 I $D(MESSAGE) D MSG^DIALOG("W","",60,10,"MESSAGE")
 ;
 Q
 ;
ID(KMPDIEN) ;-- display fields during lookup
 ;-----------------------------------------------------------------------
 ; KMPDIEN.... Ien for file #8972.1.
 ;-----------------------------------------------------------------------
 ;
 Q:'$D(^KMPD(8972.1,+$G(KMPDIEN),0))
 ;
 N DATA,TXT
 S DATA=$G(^KMPD(8972.1,+KMPDIEN,0))
 S TXT(1)=$$FMTE^DILIBF($P(DATA,U,2),6)
 S TXT(1)=TXT(1)_"   "_$$GET1^DIQ(8972.1,KMPDIEN,.03)
 S TXT(1,"F")="?35"
 S TXT(2)="cpu tm="_$P(DATA,U,4)_"  dio ref="_$P(DATA,U,5)_"  "
 S TXT(2)=TXT(2)_"bio ref="_$P(DATA,U,6)_"  page flts="_$P(DATA,U,7)_"  "
 S TXT(2)=TXT(2)_"m com="_$P(DATA,U,8)_"  global ref="_$P(DATA,U,9)
 S TXT(2,"F")="!?5",TXT(3)="",TXT(3,"F")="!"
 D EN^DDIOL(.TXT)
 ;
 Q
 ;
ELEDATA(KMPDIEN) ;-- extrinsic function - if element data
 ;-----------------------------------------------------------------------
 ; KMPDIEN... Ien for file #8972.1 (CM CODE EVALUATOR)
 ;
 ; Return: 0 - element data is NOT present
 ;         1 - element data is present
 ;-----------------------------------------------------------------------
 ;
 Q:'$G(KMPDIEN) 0
 Q:'$D(^KMPD(8972.1,+KMPDIEN,0))#5 0
 ;
 N DATA,I,RETURN
 S DATA(0)=$G(^KMPD(8972.1,+KMPDIEN,0))
 S RETURN=1
 F I=4,5,6,8,9 I $P(DATA(0),U,I)']"" S RETURN=0 Q
 Q RETURN
