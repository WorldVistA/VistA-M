HLUTIL4 ;OIFO-O/RJH-Don't Purge & Reprocessing for HLLP & MAILMAN  ;09/02/2008  16:54
 ;;1.6;HEALTH LEVEL SEVEN;**142**;Oct 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ; Don't purge and reprocessing functions for HLLP and MailMan
 ; messages only
 Q
 ;
NOPURG() ; for HLLP and MailMan messages only
 ; set the DON'T PURGE field to 1 in order to prevent the message
 ; from purging.
 ; at least one of the variables, HLMTIEN and HLMTIENS, must be defined
 ; HLMTIEN- parent message IEN of file #772
 ; HLMTIENS- child message IEN of file #772
 ; return value :  1 for successfully set the field
 ;                -1 for failure
 ;
 N FLAG
 S FLAG=$$SETPFLAG(1)
 Q FLAG
 ;
PURG() ; for HLLP and MailMan messages only
 ; clear the DON'T PURGE field to allow the message to be purged.
 ; at least one of the variables, HLMTIEN and HLMTIENS, must be defined
 ; HLMTIEN- parent message IEN of file #772
 ; HLMTIENS- child message IEN of file #772
 ; return value :  0 for successfully clear the field
 ;                -1 for failure
 ;
 N FLAG
 S FLAG=$$SETPFLAG(0)
 Q FLAG
 ;
SETPFLAG(STATUS) ; for HLLP and MailMan messages only
 ; to set or to clear the DONT PURGE field
 ; at least one of the variables, HLMTIEN and HLMTIENS, must be defined
 ; HLMTIEN- parent message IEN of file #772
 ; HLMTIENS- child message IEN of file #772
 ; input: 1 to set the DONT PURGE field
 ;        0 to clear the DONT PURGE field.
 ; return value: 1 means successfully set the DONT PURGE field
 ;               0 means successfully clear the DONT PURGE field
 ;              -1 means fail to set or to clear the field
 ;
 N FLAG
 S FLAG=""
 I (STATUS'=1),(STATUS'=0) Q -1
 I '$G(HLMTIEN),'$G(HLMTIENS) Q -1
 ;
 ; both HLMTIEN and HLMTIENS are defined
 I $G(HLMTIEN),$G(HLMTIENS) D
 . I '$D(^HL(772,HLMTIEN)) S FLAG=-1 Q
 . I '$D(^HL(772,HLMTIENS)) S FLAG=-1 Q
 . I (HLMTIEN'=$P(^HL(772,HLMTIENS,0),"^",8)) S FLAG=-1 Q
 . L +^HL(772,HLMTIEN):300
 . E  S FLAG=-1 Q
 . L +^HL(772,HLMTIENS):300
 . E  L -^HL(772,HLMTIEN) S FLAG=-1 Q
 . D SETVALUE
 . L -^HL(772,HLMTIENS)
 . L -^HL(772,HLMTIEN)
 . S FLAG=STATUS
 I (FLAG=-1)!(FLAG=STATUS) Q FLAG
 ;
 ; only HLMTIEN(parent message IEN) is defined
 I $G(HLMTIEN) D
 . I '$D(^HL(772,HLMTIEN)) S FLAG=-1 Q
 . I (HLMTIEN'=$P(^HL(772,HLMTIEN,0),"^",8)) S FLAG=-1 Q
 . L +^HL(772,HLMTIEN):300
 . E  S FLAG=-1 Q
 . D SETVALUE
 . L -^HL(772,HLMTIEN)
 . S FLAG=STATUS
 I (FLAG=-1)!(FLAG=STATUS) Q FLAG
 ;
 ; only HLMTIENS(child message IEN) is defined
 I $G(HLMTIENS) D
 . I '$D(^HL(772,HLMTIENS)) S FLAG=-1 Q
 . S HLMTIEN=$P(^HL(772,HLMTIENS,0),"^",8)
 . I 'HLMTIEN S FLAG=-1 Q
 . I '$D(^HL(772,HLMTIEN)) S FLAG=-1 Q
 . I (HLMTIEN'=$P(^HL(772,HLMTIEN,0),"^",8)) S FLAG=-1 Q
 . L +^HL(772,HLMTIEN):300
 . E  S FLAG=-1 Q
 . L +^HL(772,HLMTIENS):300
 . E  L -^HL(772,HLMTIEN) S FLAG=-1 Q
 . D SETVALUE
 . L -^HL(772,HLMTIENS)
 . L -^HL(772,HLMTIEN)
 . S FLAG=STATUS
 Q FLAG
 ;
SETVALUE ; set or clear the DONT PURGE field
 S ^HL(772,HLMTIEN,2)=STATUS
 I $G(HLMTIENS) S ^HL(772,HLMTIENS,2)=STATUS
 Q
 ;
PROC(IEN,RTN) ; reprocessing HLLP or MailMan message
 ; IEN- either the parent message IEN or the child message IEN
 ;  of file #772
 ; RTN- the routine, to be Xecuted for processing the message
 ;
 ; return value:
 ; "0^reprocessing is successful" for success.
 ; "-1^<error text>" for failure.
 ;
 N HLMTIEN,HLMTIENS,HLNEXT,HLNODE,HLQUIT,HLERR,HLRESLT
 N HL,HDR,HLMSA,X,X1
 N HLI,HLTMP,MSAFLAG
 ;
 Q:'$G(IEN) "-1^not a valid IEN"
 I $G(RTN)']"" Q "-1^reprocessing routine is misssing"
 ;
 S HLTMP=$G(^HL(772,IEN,0))
 I HLTMP']"" Q "-1^not a valid entry"
 I $P(HLTMP,"^",4)'="I" Q "-1^not an incoming message"
 ;
 ; get parent message ien
 S HLMTIEN=$P(HLTMP,"^",8)
 ;
 ; if IEN is child, define HLMTIENS as child IEN
 I HLMTIEN,(HLMTIEN'=IEN) S HLMTIENS=IEN
 ;
 ; if IEN is parent, find child ien, HLMTIENS
 I '$G(HLMTIENS) D
 . S HLMTIEN=IEN
 . S HLMTIENS=+$O(^HL(772,"AI",IEN,IEN))
 ;
 S HLMSA=""
 S MSAFLAG=0
 S X=0
 F HLI=1:1:6 S X=$O(^HL(772,HLMTIEN,"IN",X)) Q:(X'>0)!(MSAFLAG)  D
 . S X1=$G(^HL(772,HLMTIEN,"IN",X,0))
 . Q:"FHS,BHS,MSH,MSA"'[$E(X1,1,3)
 . ; If header segment, define HDR for header
 . I '$D(HDR),"FHS,BHS,MSH"[$E(X1,1,3) D  Q
 .. S HDR=X1
 . ; variable HLMSA is used to save the MSA segment data of MSH msg,
 . ; HLMSA is not for saving the MSA segment data of BHS msg
 . ; the MSA segment data of BHS msg will be set in CHK^HLTPCK1
 . I $E(X1,1,3)="MSA",$G(HLMSA)="",$E($G(HDR),1,3)="MSH" D
 .. S HLMSA=X1
 .. S MSAFLAG=1
 ;
 Q:'$D(HDR) "-1^missing message header segment"
 ;
 ;Validate message header
 D CHK^HLTPCK1(HDR,.HL,$S(HLMSA]"":$P(HLMSA,$E(HDR,4),2,4),1:""))
 ;
 I $G(HL)]"" Q "-1^"_HL
 ;
 S HLQUIT=0,HLNODE="",HLNEXT="D HLNEXT^HLCSUTL"
 ;
 I RTN["D " X RTN
 I RTN'["D " D
 . I RTN["^" X "D "_RTN
 . I RTN'["^" X "D ^"_RTN
 ;
 S HLRESLT=0
 S:($D(HLERR)) HLRESLT="9^"_$G(^HL(771.7,9,0))
 ;
 ; update the status of child message
 I $G(HLMTIENS) D
 . D STATUS^HLTF0(HLMTIENS,$S(HLRESLT:4,1:3),$S(HLRESLT:+HLRESLT,1:""),$S($D(HLERR):HLERR,HLRESLT:$P(HLRESLT,"^",2),1:""),,1)
 ;
 ; update the status of parent message
 D STATUS^HLTF0(HLMTIEN,$S(HLRESLT:4,1:3),$S(HLRESLT:+HLRESLT,1:""),$S(HLRESLT:$P(HLRESLT,"^",2),1:""),,1)
 ;
 Q "0^reprocessing is successful"
 ;
