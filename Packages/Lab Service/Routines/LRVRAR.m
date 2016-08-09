LRVRAR ;DALOI/STAFF - AUTO RELEASE VERIFICATION ;05/27/16  15:44
 ;;5.2;LAB SERVICE;**458**;Sep 27, 1994;Build 10
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 ; Variables:
 ;           DUZ = set to IEN of LRLAB,AUTO RELEASE application proxy in file #200
 ;
 ;         LRDUZ = set to IEN of either:
 ;                     1. File #200 entry of LRLAB,AUTO VERIFY application proxy (LRDUZ("AV") if results were auto verified.
 ;                     2. File #200 entry of LRLAB,AUTO RELEASE application proxy (LRDUZ("AR") when results are auto released.
 ;
 ;         LRDUZ("AR") = set to IEN of LRLAB,AUTO RELEASE application proxy in file #200
 ;         LRDUZ("AV") = set to IEN of LRLAB,AUTO VERIFY application proxy in file #200
 ;
 ;         The variable LRDUZ is set in different places to one of the values in the LRDUZ array to represent the "user"
 ;         for the software to use within the context of the operation to record who released the results and who performed
 ;         the testing.
 ;
 ;
EN ; Entry Point
 ;  - call with LRLL=Load/Worklist IEN
 ;
 ;ZEXCEPT: LRLL,ZTREQ,ZTSTOP
 ;
 N DIQUIET,LA7624,LA76248,LA76249,LA7AAT,LAMSG,LRANYAA,LRAUTORELEASE,LRAUTOVERIFY,LRDELTACHKOK,LREND,LRERR,LRSQ
 ;
 S LRLL=+$G(LRLL)
 ;
 ; If no entries to process then quit
 I '$D(^LAH(LRLL,1,"AUTOREL")) S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
 ; See if already running and/or no one else is using this loasd list, i.e. user using EA (LRVR) to verify instrument data.
 L +^LAH("Z",LRLL):DILOCKTM+10
 E  S ZTREQ=$$HADD^XLFDT($H,0,0,5,0) D END Q
 ;
 D INIT^LRVRARU
 I LREND D  Q
 . D XQA^LA7UXQA(2,0,0,0,LAMSG,"")
 . D END
 ;
 S LRSQ=0
 F  S LRSQ=$O(^LAH(LRLL,1,"AUTOREL",LRSQ)) Q:LRSQ<1  D
 . I $$S^%ZTLOAD("Processing loadlist "_$P(LRLL(0),"^")_", entry #"_LRSQ) S ZTSTOP=1 Q  ; Task has been requested to stop
 . K LRERR
 . S LA7624=$P(^LAH(LRLL,1,"AUTOREL",LRSQ),U,2)
 . ; Interface message number in ^LAHM(62.49
 . S LA76249=+$P($G(^LAH(LRLL,1,LRSQ,0)),U,13)
 . ; File #62.48 configuration link
 . S LA76248=""
 . I LA76249 S LA76248=$$GET1^DIQ(62.49,LA76249_",",.5,"I")
 . D LOOK,NEXT
 D END
 Q
 ;
 ;
NEXT ; Clean up between entries
 ;
 ;ZEXCEPT: LRERR,LRLL,LRSQ,LRUID
 ;
 ; If no errors then remove record from LAH.
 I $G(LRERR)<1 D ZAPALL^LRVR3(LRLL,LRSQ)
 ;
 D CLEAN^LRVRARU
 Q
 ;
 ;
END ; Clean up and quit
 ;ZEXCEPT: LRLL,ZTQUEUED,ZTREQ
 ;
 ; Release locks
 L -^LAH("Z",LRLL)
 ;
 D SPALERT^LRVRARU,KVAR^VADPT,KILL^XUSCLEAN
 K ^TMP("LR",$J)
 I $D(ZTQUEUED),'$P($G(ZTREQ),"^") S ZTREQ="@"
 Q
 ;
 ;
LOOK ; Check for data
 ;
 ;ZEXCEPT: DFN,ERR,LRAA,LRAD,LRAN,LRDFN,LRDPF,LREND,LRERR,LRIDT,LRLL,LRLLOC,LRODT,LRORD,LRORU3,LRSN,LRSQ,PNM,X,ZTREQ
 ;
 N LRCDT,LRLDT,LRLOCKER,LRSS,LRUID
 ;
 K LRDFN,LRERR,ERR,LRDPF,PNM,X
 S (LREND,LRERR)=0
 ;
 S LRUID=$P($G(^LAH(LRLL,1,LRSQ,.3)),U)
 I LRUID="" D  Q
 . ; JMC/5/6/15 - need to write error message when UID not found with data in LAH
 . S LREND=1
 ;
 D UID^LRVRA
 ;
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0)
 S LRDFN=+X,LRDPF=$P(X,U,2),DFN=$P(^LR(LRDFN,0),U,3)
 S LRODT=+$P(X,U,4),LRSN=+$P(X,U,5),LRLLOC=$P(X,U,7)
 S LRSS=$P(^LRO(68,LRAA,0),U,2)
 ;
 S:'$L(LRLLOC) LRLLOC=0
 S LRORD=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.1)),"^")
 ;
 S X(3)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,3))
 S LRCDT=$P(X(3),U,1)
 S LRIDT=$P(X(3),U,5)
 S:'LRIDT LRIDT=9999999-X(3)
 S LRORU3=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3))
 ;
 D DEM^LRX
 I $G(LREND) S LRDFN=0 Q
 ;
 ; Lock records in file #63 and 68
 L +(^LR(LRDFN,LRSS,LRIDT),^LRO(68,LRAA,1,LRAD,1,LRAN)):DILOCKTM+10
 I '$T D  Q
 . S ZTREQ=$$HADD^XLFDT($H,0,0,5,0)
 . S LRERR=1
 ;
 D DATA
 ;
 L -(^LR(LRDFN,LRSS,LRIDT),^LRO(68,LRAA,1,LRAD,1,LRAN))
 ;
 ; If error encountered then remove from auto release queue/process
 I $G(LRERR)>0 D
 . K ^LAH(LRLL,1,"AUTOREL",LRSQ)
 . K ^LAH(LRLL,1,"AUTOREL-UID",LRUID,LRSQ)
 ;
 Q
 ;
 ;
DATA ;Process data and store in LR global
 ;
 ;ZEXCEPT: LA76248,LA76249,LA7AAT,LR642,LRAA,LRALERT,LRAUTOVERIFY,LRCDT,LRCNT,LRCOM,LRCUP,LRDATA,LRDFN,LRDFWKLD,LREII,LRERR
 ;ZEXCEPT: LRIDT,LRLDT,LRLL,LRMETH,LRNOW,LROKTORELEASE,LROUTINE,LRSAMP,LRSB,LRSPEC,LRSQ,LRSS,LRSTORE,LRTM60,LRTRAY
 ;ZEXCEPT: LRTS,LRTST,LRUID,LRUSI,LRVF,LRVTS,LRX,LRY,LRZ
 ;
 K LRCNT,LRDATA,LRERR,LREII,LRLDT,LRNOW,LRSAMP,LRSB,LRSPEC,LRTM60,LRTRAY,LRCUP,LRTS,LRVF,LRX,LRY,LRZ
 S (LR642,LRCNT,LRERR)=0
 ;
 ; Get type of HL7 application ACK
 S LA7AAT(1)=$P($G(^LAH(LRLL,1,"AUTOREL-UID",LRUID,LRSQ,LA76249)),U)
 ;
 ; Setup workload suffix and workload variables
 I LR642<1 S LR642=LRDFWKLD
 D WKLD^LRVRARU(LR642)
 D WKLDC^LRVRARU(LRLL,LRAA)
 ;
 S LRSPEC=$P(^LR(LRDFN,"CH",LRIDT,0),U,5)
 ;
 ; Check if verified results exist in ^LR then delete results from LAH and mark as error.
 S LRVF=+$P(^LR(LRDFN,"CH",LRIDT,0),U,3)
 I LRVF D
 . S LRX=1
 . F  S LRX=$O(^LR(LRDFN,"CH",LRIDT,LRX)) Q:LRX'>0  D
 . . S LRZ=^LR(LRDFN,"CH",LRIDT,LRX)
 . . I $P(LRZ,U)'="",$P(LRZ,U)'="pending",$D(^LAH(LRLL,1,LRSQ,LRX)) K ^LAH(LRLL,1,LRSQ,LRX) S:LRERR=0 LRERR=$$CREATE^LA7LOG(307,1)
 I LRERR D SENDACK^LRVRARU Q
 ;
 ; Check if results have datanames/tests on this profile and user is valid
 S LRDATA=1
 F  S LRDATA=$O(^LAH(LRLL,1,LRSQ,LRDATA)) Q:LRDATA<1  D  Q:LRERR
 . S LRDATA(LRDATA)=^LAH(LRLL,1,LRSQ,LRDATA)
 . I $P(LRDATA(LRDATA),"^",4)<1 S LRERR=$$CREATE^LA7LOG(111,1) Q
 . S LROKTORELEASE=$$OKTOREL
 . I 'LROKTORELEASE D  Q
 . . N LRDUZ
 . . I $P(LROKTORELEASE,U,2) S LRDUZ=$P(LROKTORELEASE,U,3),LRERR=$$CREATE^LA7LOG($P(LROKTORELEASE,U,2),1)
 . S LRDUZ("USER")=$P(LROKTORELEASE,U,2)
 . S LRAUTOVERIFY=LROKTORELEASE-1
 . S LREII=$P(LRDATA(LRDATA),U,11)
 . S LREII=LREII_";"_$S(LRAUTOVERIFY:"LRAV",1:"LRTV")
 . S $P(LRDATA(LRDATA),U,11)=LREII ; Store auto verify or tech verify with EII.
 . S LRTST=+$G(LRVTS(LRDATA))
 . I 'LRTST S LRERR=$$CREATE^LA7LOG(116,1) Q
 . I '$D(^TMP("LR",$J,"VTO",LRTST)) S LRERR=$$CREATE^LA7LOG(118,1) Q
 ;
 I LRERR D SENDACK^LRVRARU Q
 ;
 ; Calculate days back for delta checks
 S LRTM60=$$LRTM60^LRVR(LRCDT)
 ; Find previous specimen
 S LRLDT=LRIDT
 D FINDPS^LRGV2
 ;
 ; Store ^LR( data [results]
 K LRCOM
 S LRVF=0,LRALERT=LROUTINE,LRUSI="LRAR"
 ;
 ; Store any new methods with existing methods on file.
 S LRMETH=$P(^LAH(LRLL,1,LRSQ,0),U,7)_"(AR)"
 I $P($G(^LR(LRDFN,LRSS,LRIDT,0)),U,8)'="" D
 . N I,X
 . S X=$P(^LR(LRDFN,LRSS,LRIDT,0),U,8)
 . F I=1:1:$L(X,";") I $P(X,";",I)'="",LRMETH'[$P(X,";",I) S LRMETH=LRMETH_";"_$P(X,";",I)
 I LRMETH'="" S $P(^LR(LRDFN,LRSS,LRIDT,0),U,8)=LRMETH
 ;
 M LRSB=LRDATA
 D TEST^LRVR1
 S LRSB=1,LRNOW=$$NOW^XLFDT
 F  S LRSB=$O(LRSB(LRSB)) Q:LRSB<1  D STORE Q:LRERR
 ;
 I LRERR D SENDACK^LRVRARU Q
 ;
 ; Set releasing user to auto release proxy.
 S LRDUZ=LRDUZ("AR")
 ;
 ; Call to set data and comments
 I $O(LRSB(0)) D
 . D LRSBCOM^LRVR4,A3^LRVR3
 . S LRSTORE=LRSTORE+1
 . I $G(LA76248) S LRSTORE(LA76248)=$G(LRSTORE(LA76248))+1
 ;
 ; Send application ack back to sending application interface
 D SENDACK^LRVRARU
 Q
 ;
 ;
STORE ; Store the data in LR global
 ;
 ;ZEXCEPT: LRAUTOVERIFY,LRDEL,LRDELTACHKOK,LRDFN,LRDUZ,LRERR,LRIDT,LRLDT,LRNOW,LRSB,LRSS
 ;
 N I,LRNGS,LRQ,LRTS,LRX,LRY,X,X1,Y
 ;
 I '$G(^TMP("LR",$J,"TMP",LRSB,"P")) S LRERR=$$CREATE^LA7LOG(117,1) Q
 ;
 S LRX=$$TMPSB^LRVER1(LRSB),LRY=$P(LRSB(LRSB),U,3)
 F I=1:1:$L(LRX,"!") I $P(LRY,"!",I)="" S $P(LRY,"!",I)=$P(LRX,"!",I)
 S $P(LRSB(LRSB),U,3)=LRY
 S LRTS=$G(^TMP("LR",$J,"TMP",LRSB))
 D V25^LRVER5
 S LRX=LRNGS,LRY=$P(LRSB(LRSB),U,5)
 ;
 ; Do delta checking if enabled
 I LRDELTACHKOK D
 . S X=$P(LRSB(LRSB),"^"),Y=0,(LRQ,X1)=""
 . I LRLDT>0 S X1=$P($G(^LR(LRDFN,LRSS,LRLDT,LRSB)),U)
 . I LRDEL'="" S LRQ=1 D XDELTACK^LRVERA ;S:Y LRDELTA=Y
 ;
 ; Don't store file #60 units/ranges/etc at this time, use values from middleware
 ; (#.01) SITE/SPECIMEN [1P:61] ^ (#1) REFERENCE LOW [2F] ^ (#2) REFERENCE HIGH [3F] ^ (#3) CRITICAL LOW [4F] ^ (#4) CRITICAL HIGH [5F] ^  ^ (#6) UNITS [7F] ^ (#7) TYPE OF DELTA CHECK [8P:62.1] ^
 ; (#8) DELTA VALUE [9F] ^ (#9) DEFAULT VALUE [10F] ^ (#9.2) THERAPEUTIC LOW [11F] ^ (#9.3) THERAPEUTIC HIGH [12F] ^
 ;F I=1,4,5,8:1:12 I $P(LRY,"!",I)="" S $P(LRY,"!",I)=$P(LRX,U,I)
 ;S $P(LRSB(LRSB),U,5)=LRY
 ;
 S $P(LRSB(LRSB),U,6)=LRNOW
 ;
 ; Store performing lab based on LRDUZ(2) from load/list profile.
 S $P(LRSB(LRSB),U,9)=$S($G(LRDUZ(2)):LRDUZ(2),1:$G(DUZ(2)))
 ;
 S ^LR(LRDFN,"CH",LRIDT,LRSB)=LRSB(LRSB)
 ;
 Q
 ;
 ;
OKTOREL() ; Determine if it's OK to store these results for auto release
 ;
 ;ZEXCEPT: LRDATA,LRDUZ,LRLL,LRSQ
 ;
 ; Returns OK = "" (no "user")
 ;            = 0  (results not flagged for auto release)
 ;            = 0^error code (62.485)^invalid user duz
 ;            = 1^duz of user  (tech verify)
 ;            = 2  (auto verify user)
 ;
 N OK,LRX,LRY
 ;
 S OK=""
 ;
 I $P($G(^LAH(LRLL,1,LRSQ,LRDATA)),U)="" S OK=0
 ;
 ; Results not flagged for auto release.
 I '$D(^LAH(LRLL,1,"AUTOREL",LRSQ,LRDATA)) S OK=0
 ;
 ; Retrieve stored auto release setting when this result arrived.
 S LRX=$P(^LAH(LRLL,1,"AUTOREL",LRSQ,LRDATA),U,2)
 ;
 ; Retrieve user id/duz received with results.
 S LRY=$P(LRDATA(LRDATA),U,4)
 ;
 I OK="" D
 . ; If no user or auto release proxy then log error
 . I LRY<1 S OK="0^303" Q
 . I LRY=LRDUZ("AR") S OK="0^304"_U_LRY Q
 . ;
 . ; If auto release on for auto or tech verify
 . I LRX=1 D  Q
 . . I LRY=LRDUZ("AV") S OK=2 Q
 . . S OK=1_U_LRY Q
 . ;
 . ; If auto release on for auto verify only
 . I LRX=2 D  Q
 . . I LRY=LRDUZ("AV") S OK=2 Q
 . . S OK="0^305"_U_LRY
 . ;
 . ; If auto release on for tech verify only
 . I LRX=3 D  Q
 . . I LRY'=LRDUZ("AV"),LRY'=LRDUZ("AR") S OK=1_U_LRY Q
 . . S OK="0^306"_U_LRY
 ;
 ; Check if tech verify that user owns LRVERIFY security key.
 I $P(OK,U)=1 D
 . N LRKEY
 . ;
 . ; check if user is active
 . I '$$ACTIVE^XUSER($P(OK,U,2)) S OK="0^302^"_$P(OK,U,2) Q
 . ;
 . ; check that user has LRVERIFY key
 . D OWNSKEY^XUSRB(.LRKEY,"LRVERIFY",$P(OK,U,2))
 . I LRKEY(0)=1 Q
 . S OK="0^301^"_$P(OK,U,2)
 ;
 Q OK
