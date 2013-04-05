LA7VHLU1 ;DALOI/JMC - HL7 segment builder utility ;04/30/10  19:10
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,61,64,74**;Sep 27, 1994;Build 229
 ;
 ;
SETID(LA76249,LA7ID,LA7X,LA7TYP) ; Setup identifier's in TMP global for later storing.
 ; Call with LA76249 = ien of message in #62.49
 ;             LA7ID = root of identifier
 ;              LA7X = value to add to identifier
 ;            LA7TYP = type - primary(1) or additional(0)
 N Y
 I $G(LA7X)="" Q
 S Y=$O(^TMP("LA7-ID",$J,LA76249,""),-1)+1 ; get next entry
 S ^TMP("LA7-ID",$J,LA76249,Y)=LA7ID_LA7X_"^"_+$G(LA7TYP)
 Q
 ;
 ;
UTS(LA7628,LA7UID,LA760) ; Update test status on manifest
 ; Call with LA7628 = ien of shipping manifest in #62.8
 ;           LA7UID = accession's UID
 ;            LA760 = file # 60 ien of ordered test
 ;
 ; Sets to status 4 (partial). Will deal with 5 (completed) at later time
 ; when lab package has capability of designating an accession as completed.
 ;
 N LA762801,LA7X
 ;
 S LA762801=0
 F  S LA762801=$O(^LAHM(62.8,LA7628,10,"UID",LA7UID,LA762801)) Q:'LA762801  D
 . S LA7X=$G(^LAHM(62.8,LA7628,10,LA762801,0))
 . I $P(LA7X,"^",2)'=LA760 Q  ; Not the test we're looking for.
 . I $P(LA7X,"^",8)>2,$P(LA7X,"^",8)<5 D STSUP^LA7SMU(LA7628,LA762801,4)
 Q
 ;
 ;
UPID(LA76249) ; Update identifier's associated with the message in #62.49
 ; Call with LA76249 = ien of message in #62.49
 ;
 N FDA,LA7ERR,LA7I,LA7TYP,LA7X
 ;
 S LA7I=0
 F  S LA7I=$O(^TMP("LA7-ID",$J,LA76249,LA7I)) Q:'LA7I  D
 . S LA7X=^TMP("LA7-ID",$J,LA76249,LA7I),LA7TYP=+$P(LA7X,"^",2)
 . I LA7TYP=1,$L($P(LA7X,"^"))<46 D
 . . S FDA(1,62.49,LA76249_",",5)=$P(LA7X,"^")
 . . D FILE^DIE("","FDA(1)","LA7ERR(1)"),CLEAN^DILF
 . I $D(^LAHM(62.49,LA76249,.2,"B",$P(LA7X,"^"))) Q
 . S FDA(2,62.49002,"+2,"_LA76249_",",.01)=$P(LA7X,"^")
 . D UPDATE^DIE("","FDA(2)","","LA7ERR(2)"),CLEAN^DILF
 ;
 ; Clean up
 D CLEAN^DILF
 K ^TMP("LA7-ID",$J,LA76249)
 Q
 ;
 ;
CHKDT(LA7X) ; Check validity of date/time
 ; Adjust invalid times to closest valid time - correct for lab problem
 ; that generated invalid FileMan date/times.
 ; If hours>24 then set to 24 with no minutes/seconds
 ; If minutes greater than 59 then set to 59
 ; If seconds greater than 59 then set to 59
 ;
 N I,LA7Y,X
 ;
 S LA7Y=$P(LA7X,".",2)
 ;
 ; If time present then check otherwise skip and return input.
 I LA7Y'="" D
 . F I=1:2:5 D
 . . S LA7Y(I)=$E(LA7Y,I,I+1)
 . . I $L(LA7Y(I))=1 S LA7Y(I)=LA7Y(I)_"0"
 . . I LA7Y(I)>$S(I=1:24,1:59) S LA7Y(I)=$S(I=1:24,1:59)
 . . I I=1,LA7Y(1)=24 S LA7Y=24
 . S X="."_LA7Y(1)_LA7Y(3)_LA7Y(5),X=+X
 . S $P(LA7X,".",2)=$P(X,".",2)
 ;
 Q LA7X
 ;
 ;
REFUNIT(LA7SB,LA761) ; Find reference ranges/units from file #60
 ; Call with LA7SB = dataname from "CH" subscript
 ;           LA761 = pointer to topography file #61
 ;
 ;   Returns  LA7Y = reference low^reference high^units^critcal low^critcal high^therapeutic low^therapeutic high
 ;
 ; Finds first entry in file #60 that is associated with this dataname.
 N LA760,LA7X,LA7Y
 ;
 S LA7Y=""
 S LA760=+$O(^LAB(60,"C","CH;"_LA7SB_";1",0))
 S LA7X=$G(^LAB(60,LA760,1,LA761,0))
 S $P(LA7Y,"^")=$P(LA7X,"^",2)
 S $P(LA7Y,"^",2)=$P(LA7X,"^",3)
 S $P(LA7Y,"^",3)=$P(LA7X,"^",7)
 S $P(LA7Y,"^",4)=$P(LA7X,"^",4)
 S $P(LA7Y,"^",5)=$P(LA7X,"^",5)
 S $P(LA7Y,"^",6)=$P(LA7X,"^",11)
 S $P(LA7Y,"^",7)=$P(LA7X,"^",12)
 ;
 Q LA7Y
 ;
 ;
OKTOSND(LRSS,LRSB,LA760) ; Check if test ok to send - is (O)utput or (B)oth
 ; Call with LRSS = file #63 subscript
 ;           LRSB = file #63 data name or field reference
 ;          LA760 = file #60 ien
 ;
 ; Returns   LA7Y = 0-do not send, 1-yes-ok (default)
 ;
 N LA760,LA7X,LA7Y
 S LA7Y=1
 ;
 ; If "CH" subscript check file #60 test's type that use this dataname
 ; and if find one that is type "O" or "B" then set to yes.
 I LRSS="CH" D
 . I $G(LA760) D  Q
 . . I "BO"'[$P(^LAB(60,LA760,0),"^",3) S LA7Y=0
 . S (LA760,LA7X)=0
 . F  S LA760=$O(^LAB(60,"C","CH;"_LRSB_";1",LA760)) Q:'LA760  D
 . . I "BO"[$P(^LAB(60,LA760,0),"^",3) S LA7X=1
 . S LA7Y=LA7X
 ;
 Q LA7Y
 ;
 ;
FAMG(LA76248,LA7TYP) ; Find alert mail group for this alert type
 ; Call with LA76248 = ien of entry in file #62.48
 ;            LA7TYP = type of alert
 ;                     (1-new results)
 ;                     (2-error on message)
 ;                     (3-orders received)
 ;
 ; Returns LA7MG = name of mail group
 ;
 N LA7MG,X,Y
 S (LA7MG,X)=""
 F  S X=$O(^LAHM(62.48,+$G(LA76248),20,"B",LA7TYP,X)) Q:'X  D
 . S Y=$G(^LAHM(62.48,LA76248,20,X,0))
 . I $P(Y,"^",2)'="" S LA7MG=$P(Y,"^",2) ; Send to mail group.
 ;
 ; Fail safe mail group when no mail group specified
 I LA7MG="" S LA7MG="LAB MESSAGING"
 ;
 Q LA7MG
 ;
 ;
GETISO(SUBFL,IENS) ; Retrieve isolate id for micro specimens from file #63
 ; Call with SUBFL = FileMan subfile #
 ;            IENS = FileMan iens of record
 ;
 ;    Returns LA7Y = isolate id as sub-id
 ;
 N LA7Y
 ;
 S LA7Y=$$GET1^DIQ(SUBFL,IENS,.1)
 I LA7Y="" D
 . N FDA,ID,LA74,LA7DIE
 . S ID=$S(SUBFL=63.3:3,SUBFL=63.34:6,SUBFL=63.37:9,SUBFL=63.39:12,SUBFL=63.43:17,1:"")
 . S ID=ID_"-"_$P(IENS,",")
 . S LA74=+$$KSP^XUPARAM("INST")
 . S LA7Y=$$MAKEISO^LRVRMI1(LA74,ID)
 . S FDA(63,SUBFL,IENS,.1)=LA7Y
 . D FILE^DIE("","FDA(63)","LA7DIE(2)")
 ;
 Q LA7Y
 ;
 ;
LAHSTAT(LRLL,ISQN,ERR,ERRMSG) ;
 ; Determine related file #62.49 message(s) status for results in LAH global.
 ; Call with LRLL = ien of loadlist in LAH global
 ;           ISQN = ien of entry in LAH(LRLL) global
 ;            ERR = 0 (do not return error messages)
 ;                = .5 (return status of last message processed)
 ;                = 1 (return error messages in array ERRMSG)
 ;
 ;         ERRMSG = array to return error messages (pass by reference)
 ;
 ;        Returns STATUS = 0 (no related file #62.49 messages found)
 ;                 = 1 (one or more related file #62.49 messages encountered no errors in processing)
 ;                 = 2 (one or more related file #62.49 messages encountered errors in processing)
 ;
 ;          ERRMSG = array listing related error messages (indexed by FM D/T of error)
 ;                   Example: ERRMSG(3061010.195711)="Msg #1070: No File #62.47 mapping found for OBX-3:0410.3\GRAM STAIN\99LAB"
 ;
 N I,K,LA7DT,LA7IEN,LA7X,STATUS,X
 S (LA7IEN,STATUS)=0
 F  S LA7IEN=$O(^LAH(LRLL,1,ISQN,.01,LA7IEN)) Q:'LA7IEN  D
 . I ERR=.5,LA7IEN'=$P(^LAH(LRLL,1,ISQN,0),"^",13) Q
 . S LA7X=$G(^LAHM(62.49,LA7IEN,0))
 . I $P(LA7X,"^",3)="X",STATUS=0 S STATUS=1 Q
 . I $P(LA7X,"^",3)'="E" Q
 . S STATUS=2 Q:'ERR
 . S LA7DT=$P(LA7X,"^",5),LA7DT(0)=LA7DT\1,LA7DT(1)=LA7DT#1
 . S K="LA7ERR^"_(LA7DT(0)-.1)
 . F  S K=$O(^XTMP(K)) Q:K=""!($P(K,"^")'="LA7ERR")  D
 . . I LA7DT(0)=$P(K,"^",2) S I=LA7DT(1)-.00000001
 . . E  S I=0
 . . F  S I=$O(^XTMP(K,I)) Q:'I  D
 . . . S X=^XTMP(K,I)
 . . . I $P(X,"^",2)=LA7IEN S ERRMSG($P(K,"^",2)_I)=$$DECODEUP^XMCU1($P(X,"^",4))
 ;
 Q STATUS
 ;
 ;
LAHSTATP(ERRMSG) ; Print/display error array from LAHSTAT function call.
 ; Call with ERRMSG = array of error messages (pass by reference)
 ;
 N A,LA7IEN,LAJ
 ;
 S LA7IEN=0,LAJ=1
 S A(LAJ)="Errors reported on message(s):",A(LAJ,"F")="!!"
 F  S LA7IEN=$O(ERRMSG(LA7IEN)) Q:'LA7IEN  S LAJ=LAJ+1,A(LAJ)=$$FMTE^XLFDT(LA7IEN,"1M")_" - "_ERRMSG(LA7IEN),A(LAJ,"F")="!?1"
 D EN^DDIOL(.A)
 Q
 ;
 ;
ABFLAGS ;; HL7 Table 0078 Abnormal flags
 ;;Below low normal;;
 ;;Above high normal;;
 ;;Below lower panic limits;;
 ;;Above upper panic limits;;
 ;;Below absolute low-off instrument scale;;
 ;;Above absolute high-off instrument scale;;
 ;;Normal;;
 ;;Abnormal;;
 ;;Very abnormal;;
 ;;Significant change up;;
 ;;Significant change down;;
 ;;Better;;
 ;;Worse;;
 ;;Susceptible;;
 ;;Resistant;;
 ;;Intermediate;;
 ;;Moderately susceptible;;
 ;;Very susceptible;;
