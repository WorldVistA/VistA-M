LA7ADL1 ;DALOI/JMC - Automatic Download of Test Orders (Cont'd) ; 1/30/95 09:00
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**17,23,57**;Sep 27, 1994
 ;
BUILD ; Build test listing for all instruments designated for auto download.
 ;
 N LA7I,LA7INST,LA7WL
 ;
 K ^TMP("LA7-INST",$J)
 K LA7AUTO
 ;
 ; Flag used to notify download routines of automatic download (no worklist).
 S LA7ADL=1
 ;
 S LA7INST=0
 F  S LA7INST=$O(^LAB(62.4,"AE",LA7INST)) Q:'LA7INST  D BLDINST(LA7INST,0)
 Q
 ;
 ;
BLDINST(LA7INST,LA7WL) ; Build list of instrument tests
 ; Call with LA7INST = ien of entry in file #62.4
 ;             LA7WL = ien of entry in file #62.8 (optional)
 ;                     will default to list associated with #62.4 entry.
 ;
 K ^TMP("LA7-INST",$J,LA7INST)
 ;
 S LA7AUTO(LA7INST)=$G(^LAB(62.4,LA7INST,0))
 ; Quit - no zero node in 62.4.
 I LA7AUTO(LA7INST)="" K LA7AUTO(LA7INST) Q
 ;
 S LA7AUTO(LA7INST,9)=$G(^LAB(62.4,LA7INST,9))
 ; Quit - no/invalid download routine specified.
 I $$CHKRTN Q
 ;
 ; Worklist pointer
 I 'LA7WL S LA7WL=$P(LA7AUTO(LA7INST),"^",4)
 ;
 ; Store "include uncollected accessions" flag, defaults to 0 (NO)
 S ^TMP("LA7-INST",$J,LA7INST)=+$P($G(^LRO(68.2,LA7WL,0)),"^",10)
 ;
 S LA7I=0
 F  S LA7I=$O(^LAB(62.4,LA7INST,3,LA7I)) Q:'LA7I  D BLDTST
 ;
 ; No download tests found for this instrument.
 I '$O(^TMP("LA7-INST",$J,LA7INST,0)) D
 . K LA7AUTO(LA7INST)
 . K ^TMP("LA7-INST",$J,LA7INST)
 Q
 ;
 ;
BLDTST ; Build list of test that can be downloaded.
 ;
 N X,Y
 ; Don't download this test.
 I $P($G(^LAB(62.4,LA7INST,3,LA7I,2)),"^",4)=0 Q
 ;
 ; X = Zeroth node of test multiple
 ; Y = Screening criteria - accession area, specimen type, urgency
 S X=$G(^LAB(62.4,LA7INST,3,LA7I,0))
 S Y=$G(^LAB(62.4,LA7INST,3,LA7I,2))
 ;
 ; Build pattern mask based on file #60, #62.41, #68, #61, #62.05 iens
 S ^TMP("LA7-INST",$J,LA7INST,+X,LA7I,+$P(Y,"^",12),+$P(Y,"^",13),+$P(Y,"^",14))=""
 ;
 ; Build test info
 S ^TMP("LA7",$J,LA7INST,LA7I)=X
 S $P(^TMP("LA7",$J,LA7INST,LA7I),"^",7)=$P($G(^LAB(60,+X,.2)),"^")
 ;
 Q
 ;
 ;
CHKRTN() ; Check if download routine defined and valid
 ;
 N LA7ERR,X,XQA,XQAMSG
 ;
 S LA7ERR=0,XQAMSG=""
 ;
 ; Check if download routine specified
 I $P(LA7AUTO(LA7INST,9),"^",4)="" D
 . S LA7ERR=1
 . S XQAMSG="No download routine (field #94)"
 ;
 ; Check if download routine valid
 I $L($P(LA7AUTO(LA7INST,9),"^",4)) D
 . S X=$P(LA7AUTO(LA7INST,9),"^",4) X ^%ZOSF("TEST") Q:$T
 . S LA7ERR=1
 . S XQAMSG="Invalid download routine (field #94)"
 ;
 ; Check if routine label valid
 I 'LA7ERR,$L($P(LA7AUTO(LA7INST,9),"^",3)) D
 . I $L($T(@$P(LA7AUTO(LA7INST,9),"^",3,4))) Q
 . S LA7ERR=1
 . S XQAMSG="Invalid download routine label (field #93)"
 ;
 ; If problem send alert and kill array entry
 I LA7ERR D
 . S XQAMSG=XQAMSG_" specified for AUTO INSTRUMENT: "_$P(LA7AUTO(LA7INST),"^")
 . D ERROR^LA7UID
 . K LA7AUTO(LA7INST)
 ;
 Q LA7ERR
 ;
 ;
UNWIND(LA760,LA7URG,LA7TYP) ; Unwind profile - set tests into array LA7TREE with urgency.
 ;
 ; Call with  LA760 = file #60 ien
 ;           LA7URG = file #62.05 ien
 ;           LA7TYP =  0 ordered test
 ;                     1 expanded from panel
 ;
 ; Recursive panel, caught in a loop.
 I $G(LA7PCNT)>50 Q
 ;
 ; If no urgency, set to routine (9), default value.
 I 'LA7URG S LA7URG=9
 ;
 ; Test does not exist in file 60.
 I '$D(^LAB(60,LA760,0)) Q
 ;
 ; Bypass "workload" type tests.
 I $P(^LAB(60,LA760,0),"^",4)="WK" Q
 ;
 ; Test already listed, check if urgency different.
 I $D(LA7TREE(LA760)) D  Q
 . S LA7PCNT=0
 . ; Convert expanded panel test urgency to regular urgency
 . I LA7URG>50 S LA7URG=LA7URG-50
 . ; Found test with higher urgency, save new urgency.
 . I LA7URG<LA7TREE(LA760) S $P(LA7TREE(LA760),"^")=LA7URG
 ;
 ; Not a panel, list test with urgency.
 I '$O(^LAB(60,LA760,2,0)) S LA7TREE(LA760)=LA7URG_"^"_LA7TYP,LA7PCNT=0 Q
 ;
 N I
 ;
 ; Increment panel and test loop counter.
 S LA7PCNT=$G(LA7PCNT)+1,I=0
 ;
 ; Expand test on panel.
 F  S I=$O(^LAB(60,LA760,2,I)) Q:'I  D
 . N II
 . ; IEN of test on panel.
 . S II=+$G(^LAB(60,LA760,2,I,0))
 . ; Recursive panel, panel calls itself.
 . I II,II=LA760 Q
 . I II D UNWIND(II,LA7URG,1)
 ;
 Q
 ;
 ;
SETSTOP(FLAG,USER) ; Set "STOP" node in ^LA("ADL") global..
 ; Required parameters
 ; FLAG - Values passed can be:
 ;        0 = Auto download background task running.
 ;        1 = Start/Restart background task.
 ;        2 = Shutdown auto download background task, don't restart.
 ;        3 = Shutdown, don't start auto download task and don't collect accessions for downloading.
 ; USER - DUZ of user.
 ;
 ; Value passed out of range.
 I FLAG<0!(FLAG>3) Q
 ;
 I $G(USER)'>0 S USER="UNKNOWN"
 ;
 ; Set flag to value passed, user and current time.
 S ^LA("ADL","STOP")=FLAG_"^"_$$HTFM^XLFDT($H)_"^"_USER
 ;
 Q
 ;
 ;
SHOWST() ; Show status
 ;
 N X,Y
 ;
 S X=$G(^LA("ADL","STOP"),-1)
 S Y=$P("Not Running^Running^Start/Restart Auto Download Job^Shutdown Auto Download Job^Shutdown Auto Download Job and Stop Collecting Accessions","^",$P(X,"^")+2)
 ;
 I +X'<0 D
 . S $P(Y,"^",2)=$$FMTE^XLFDT($P(X,"^",2))
 . I $P(X,"^",3) S $P(Y,"^",3)=$$GET1^DIQ(200,$P(X,"^",3)_",",.01)
 . I $P(X,"^",3)="UNKNOWN"!($P(Y,"^",3)="") S $P(Y,"^",3)="UNKNOWN"
 ;
 Q Y
