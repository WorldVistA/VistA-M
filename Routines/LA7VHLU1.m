LA7VHLU1 ;DALOI/JMC - HL7 segment builder utility ; 11-25-1998
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,61,64**;Sep 27, 1994
 ;
 ;
SETID(LA76249,LA7ID,LA7X) ; Setup identifier's in TMP global for later storing.
 ; Call with LA76249 = ien of message in #62.49
 ;             LA7ID = root of identifier
 ;              LA7X = value to add to identifier
 N Y
 S Y=$O(^TMP("LA7-ID",$J,LA76249,""),-1) ; get last entry
 S Y=Y+1
 S ^TMP("LA7-ID",$J,LA76249,Y)=LA7ID_LA7X
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
 N FDA,LA7CNT,LA7ERR,LA7I,LA7X
 ;
 S (LA7CNT,LA7I)=0
 F  S LA7I=$O(^TMP("LA7-ID",$J,LA76249,LA7I)) Q:'LA7I  D
 . S LA7CNT=LA7CNT+1
 . S LA7X=^TMP("LA7-ID",$J,LA76249,LA7I)
 . I LA7CNT=1 S FDA(1,62.49,LA76249_",",5)=LA7X
 . ; Add code to store additional identifiers in new multiple field in #62.49
 I $D(FDA(1)) D FILE^DIE("","FDA(1)","LA7ERR(1)")
 ;
 ; Clean up
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
 I $L(LA7Y) D
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
