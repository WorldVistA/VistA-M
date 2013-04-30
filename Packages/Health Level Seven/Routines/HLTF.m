HLTF ;AISC/SAW,JRP-Create/Process Message Text File Entries ;08/05/2011  14:37
 ;;1.6;HEALTH LEVEL SEVEN;**1,19,43,55,109,120,122,142,157**;Oct 13, 1995;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
FILE ;Create Entries in files 772 and 773 for Version 1.5 Interface Only
 D CREATE(,.HLDA,.HLDT,.HLDT1)
 Q
CREATE(HLMID,MTIEN,HLDT,HLDT1) ;Create entries in Message Text (#772)
 ;
 ;Input  : HLMID = Variable in which value of message ID will be
 ;                 returned (pass by reference)
 ;         MTIEN = Variable in which IEN of Message Text file entry
 ;                 will be returned (pass by reference)
 ;         HLDT = Variable in which current date/time in FM internal
 ;                format will be returned (pass by reference)
 ;         HLDT1 = Variable in which current date/time in HL7 format
 ;                 will be returned (pass by reference)
 ;
 ;Output : See above
 ;
 ;Notes  : If HLDT has a value [upon entry], the created entries will
 ;         be given that value for their date/time (value of .01)
 ;       : Current date/time used if HLDT is not passed or invalid
 ;
 ;Make entry in Message Administration file
 N Y
 S HLDT=$G(HLDT)
 D MT(.HLDT)
 S Y=$$CHNGMID(MTIEN,.HLMID),HLDT1=$$HLDATE^HLFNC(HLDT)
 Q
TCP(HLMID,MTIEN,HLDT) ;create new message in 772 & 773 entries
 ;used for incoming messages and outgoing responses
 ;Input  : HLMID = Variable in which value of message ID will be
 ;                 returned (pass by reference)
 ;         MTIEN = Variable in which IEN of file 773 entry
 ;                 will be returned (pass by reference)
 ;         HLDT = Variable in which current date/time in FM internal
 ;                format will be returned (pass by reference)
 ;
 S HLDT=$G(HLDT),HLMID=$G(HLMID)
 D MT(.HLDT)
 S MTIEN=$$MA(MTIEN,.HLMID)
 Q
 ;
MT(HLX) ;Create entry in Message Text file (#772)
 ;
 ;Input  : HLX = Date/time entry in file should be given (value of .01)
 ;               Defaults to current date/time
 ;
 ;Output : HLDT = Date/time of created entry (value of .01)
 ;       : HLDT1 = HLDT in HL7 format
 ;
 ;Notes  : HLX must be in FileMan format (default value used if not)
 ;       : HLDT will be in FileMan format
 ;       : MTIEN is ien in file 772
 ;
 ;Check for input
 S HLX=$G(HLX)
 ;Declare variables
 N DIC,DD,DO,HLCNT,HLJ,X,Y
 F HLCNT=0:1 D  Q:Y>0  H HLCNT
 . I (HLX'?7N.1".".6N) S HLX=$$NOW^XLFDT
 . S DIC="^HL(772,",DIC(0)="L",(HLDT,X)=HLX
 . S Y=$$STUB772(X) ; This call substituted for D FILE^DICN by HL*1.6*109
 . ;Entry not created - try again
 . I Y<0 S HLX="" Q
 . S MTIEN=+Y
 ;***If we didn't get a record in 772, need to do something
 I Y<0 Q
 S HLDT1=$$HLDATE^HLFNC(HLDT)
 Q
 ;add to Message Admin file #773
MA(X,HLMID) ;X=ien in file 772, HLMID=msg. id (passed by ref.)
 ;return ien in file 773
 ;
 ; patch HL*1.6*122: MPI-client/server start
 F  L +^HL(772,+$G(X)):10 Q:$T  H 1
 ; patch HL*1.6*142: MPI-client/server start
 N COUNT,FLAG
 S FLAG=0
 F COUNT=1:1:15 D  Q:FLAG  H COUNT
 . Q:'($D(^HL(772,X,0))#2)
 . Q:($G(^HL(772,X,0))']"")
 . S FLAG=1
 ; patch HL*1.6*142: MPI-client/server end
 Q:'$G(^HL(772,X,0)) 0
 L -^HL(772,+$G(X))
 ; patch HL*1.6*122: MPI-client/server end
 ;
 N DA,DD,DO,DIC,DIE,DR,HLDA,HLCNT,HLJ,Y
 S DIC="^HLMA(",DIC(0)="L"
 F HLCNT=0:1 D  Q:Y>0  H HLCNT
 . S Y=$$STUB773(X) ; This call substituted for D FILE^DICN by HL*1.6*109
 ;***If we didn't get a record in 773, need to do something
 I Y<0 Q 0
 S HLDA=+Y,HLMID=$$MAID(HLDA,$G(HLMID))
 Q HLDA
 ;
MAID(Y,HLMID) ;Determine message ID (if needed) & store message ID
 ;Y=ien in 773, HLMID=id,  Output message id
 N HLJ
 ;need to have id contain institution number to make unique
 S:$G(HLMID)="" HLMID=+$P($$PARAM^HLCS2,U,6)_Y
 S HLJ(773,Y_",",2)=HLMID
 D FILE^HLDIE("","HLJ","","MAID","HLTF") ;HL*1.6*109
 Q HLMID
 ;
CHNGMID(PTRMT,NEWID) ;Change message ID for entry in Message Text file
 ;Input  : PTRMT - Pointer to entry in Message Text file (#772)
 ;         NEWID - New message ID
 ;Output : 0 = Success
 ;         -1^ErrorText = Error/Bad input
 ;
 ;Check input
 S PTRMT=+$G(PTRMT)
 S NEWID=$G(NEWID)
 Q:('$D(^HL(772,PTRMT,0))) "-1^Did not pass valid pointer to Message Text file (#772)"
 N HLJ
 I $G(NEWID)="" S NEWID=+$P($$PARAM^HLCS2,U,6)_PTRMT
 S HLJ(772,PTRMT_",",6)=NEWID
 D FILE^HLDIE("","HLJ","","CHNGMID","HLTF") ; HL*1.6*109
 Q 0
 ;
OUT(HLDA,HLMID,HLMTN) ;File Data in Message Text File for Outgoing Message
 ;Version 1.5 Interface Only
 ;
 ; patch HL*1.6*122: HLTF routine splitted, moves sub-routines,
 ; OUT, IN, and ACK to HLTF2 routine.
 ;
 D OUT^HLTF2($G(HLDA),$G(HLMID),$G(HLMTN))
 Q
 ;
IN(HLMTN,HLMID,HLTIME) ;File Data in Message Text File for Incoming Message
 ;Version 1.5 Interface Only
 ;
 ; patch HL*1.6*122: HLTF routine splitted, moves sub-routines,
 ; OUT, IN, and ACK to HLTF2 routine.
 ;
 D IN^HLTF2($G(HLMTN),$G(HLMID),$G(HLTIME))
 Q
 ;
ACK(HLMSA,HLIO,HLDA) ;Process 'ACK' Message Type - Version 1.5 Interface Only
 ;
 ; patch HL*1.6*122: HLTF routine splitted, moves sub-routines,
 ; OUT, IN, and ACK to HLTF2 routine.
 ;
 D ACK^HLTF2($G(HLMSA),$G(HLIO),$G(HLDA))
 Q
 ;
STUB772(FLD01,OS) ;
 ;This function creates a new stub record in file 772. The Stub record may consist of only the 0 node with a value of "^". If a value is passed in for the .01 field it will be included in the 0 node and its "B" x-ref set.
 ;Inputs:
 ;  OS (optional), the value of ^%ZOSF("OS")
 ;  FLD01 (optional), the value for the .01 field
 ;Output - the function returns the ien of the newly created record
 ;
 N IEN
 I '$L($G(OS)) N OS S OS=$G(^%ZOSF("OS"))
 ; patch HL*1.6*157 start, supports Linux/xinetd
 N HLOSYS
 S HLOSYS=$$OS^%ZOSV
 ; I OS'["DSM",OS'["OpenM" D
 I OS'["DSM",(OS'["OpenM")!((OS["OpenM")&(HLOSYS'["VMS")&(HLOSYS'["UNIX")) D
 .F  L +^HLCS(869.3,1,772):10 S IEN=+$G(^HLCS(869.3,1,772))+1,^HLCS(869.3,1,772)=IEN S:$D(^HL(772,IEN)) IEN=0,^HLCS(869.3,1,772)=($O(^HL(772,":"),-1)\1) L -^HLCS(869.3,1,772) Q:IEN
 E  D
 .F  S IEN=$I(^HLCS(869.3,1,772),1) S:$D(^HL(772,IEN)) IEN=0,^HLCS(869.3,1,772)=($O(^HL(772,":"),-1)\1) Q:IEN
 ;
 ; patch HL*1.6*122: MPI-client/server start
 F  L +^HL(772,IEN):10 Q:$T  H 1
 S ^HL(772,IEN,0)=$G(FLD01)_"^"
 I $L($G(FLD01)) S ^HL(772,"B",FLD01,IEN)=""
 L -^HL(772,IEN)
 ; patch HL*1.6*122: MPI-client/server end
 ;
 Q IEN
 ;
STUB773(FLD01,OS) ;
 ;This function creates a new stub record in file 772. The Stub record may consist of only the 0 node with a value of "^". If a value is passed in for the .01 field it will be included in the 0 node and its "B" x-ref set.
 ;Inputs:
 ;  OS (optional), the value of ^%ZOSF("OS")
 ;  FLD01 (optional), the value for the .01 field
 ;Output - the function returns the ien of the newly created record
 ;
 N IEN
 I '$L($G(OS)) N OS S OS=$G(^%ZOSF("OS"))
 ; patch HL*1.6*157 start, supports Linux/xinetd
 N HLOSYS
 S HLOSYS=$$OS^%ZOSV
 ; I OS'["DSM",OS'["OpenM" D
 I OS'["DSM",(OS'["OpenM")!((OS["OpenM")&(HLOSYS'["VMS")&(HLOSYS'["UNIX")) D
 .F  L +^HLCS(869.3,1,773):10 S IEN=+$G(^HLCS(869.3,1,773))+1,^HLCS(869.3,1,773)=IEN S:$D(^HLMA(IEN)) IEN=0,^HLCS(869.3,1,773)=($O(^HLMA(":"),-1)\1) L -^HLCS(869.3,1,773) Q:IEN
 E  D
 .F  S IEN=$I(^HLCS(869.3,1,773),1) S:$D(^HLMA(IEN)) IEN=0,^HLCS(869.3,1,773)=($O(^HLMA(":"),-1)\1) Q:IEN
 ;
 ; patch HL*1.6*122: MPI-client/server start
 F  L +^HLMA(IEN):10 Q:$T  H 1
 S ^HLMA(IEN,0)=$G(FLD01)_"^"
 I $L($G(FLD01)) S ^HLMA("B",FLD01,IEN)=""
 L -^HLMA(IEN)
 ; patch HL*1.6*122: MPI-client/server end
 ;
 Q IEN
