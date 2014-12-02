LRVRMI1A ;DALOI/STAFF - LAB MICRO HL7 INTERFACE ;08/16/13  17:53
 ;;5.2;LAB SERVICE;**350,427**;Sep 27, 1994;Build 33
 ;
 Q
 ;
SRCHEN2 ;
 ; Continued from SRCHEN^LRVRMI1
 N IEN,IEN2,LRND,LRNDINFO
 ;
 ; virus
 I $D(^LAH(LWL,1,ISQN,"MI",16)) D
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,16)=^LAH(LWL,1,ISQN,"MI",16)
 ;
 I $D(^LAH(LWL,1,ISQN,"MI",17)) D
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,17)=^LAH(LWL,1,ISQN,"MI",17)
 . S IEN=0
 . F  S IEN=$O(^LAH(LWL,1,ISQN,"MI",17,IEN)) Q:'IEN  D
 . . S LRX=$G(^LAH(LWL,1,ISQN,"MI",17,IEN,0,.01,0))
 . . I $P(LRX,"^")'="" D BLDSTAT(34,$P(LRX,"^"))
 . D USERDT(16,$G(LRSTATUS(63.05,34)))
 ;
 ; virus remark
 I $D(^LAH(LWL,1,ISQN,"MI",18)) D
 . N STAT
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,18)=^LAH(LWL,1,ISQN,"MI",18)
 . S STAT=$P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,18,0),U,4)
 . D BLDSTAT(34,STAT),USERDT(16,$G(LRSTATUS(63.05,34)))
 ;
 ;
 ; Process similar multiples - nodes 15,19-31
 ;
 ; LRNDINFO(NODE)= Status Node ^ Status field
 S LRNDINFO(15)="8^19" ; mycology prep/smear
 S LRNDINFO(19)="1^11.5" ; preliminary bacteria comment
 S LRNDINFO(20)="16^34" ; preliminary virus comment
 S LRNDINFO(21)="5^15" ; preliminary parasite comment
 S LRNDINFO(22)="8^19" ; preliminary mycology comment
 S LRNDINFO(23)="11^23" ; preliminary TB comment
 S LRNDINFO(24)="5^15" ; parasite prep/smear
 S LRNDINFO(25)="1^11.5" ; bacteriology prep/smear
 S LRNDINFO(26)="1^11.5" ; bacteria tests
 S LRNDINFO(27)="5^15" ; parasitology tests
 S LRNDINFO(28)="8^19" ; mycology tests
 S LRNDINFO(29)="11^23" ; TB tests
 S LRNDINFO(30)="16^34" ; virology tests
 S LRNDINFO(31)="1^11.5" ; sterility tests
 ;
 F LRND=15,19:1:31 D
 . I $D(^LAH(LWL,1,ISQN,"MI",LRND)) D
 . . N LRIEN,LRSTAT,LRSTATND,LRSTATFLD
 . . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRND)=^LAH(LWL,1,ISQN,"MI",LRND)
 . . S LRSTAT=$P($G(^LAH(LWL,1,ISQN,"MI",LRND,0)),U,4)
 . . S LRSTATND=$P($G(LRNDINFO(LRND)),U,1)
 . . S LRSTATFLD=$P($G(LRNDINFO(LRND)),U,2)
 . . D BLDSTAT(LRSTATFLD,LRSTAT),USERDT(LRSTATND,$G(LRSTATUS(63.05,LRSTATFLD)))
 . . ;
 . . S LRIEN=0
 . . F  S LRIEN=$O(^LAH(LWL,1,ISQN,"MI",LRND,LRIEN)) Q:LRIEN<1  D
 . . . I $D(^LAH(LWL,1,ISQN,"MI",LRND,LRIEN,0,0)) D
 . . . . S LRSTAT=$P($G(^LAH(LWL,1,ISQN,"MI",LRND,LRIEN,0,0)),U,4)
 . . . . S LRSTATND=$P($G(LRNDINFO(LRND)),U,1)
 . . . . S LRSTATFLD=$P($G(LRNDINFO(LRND)),U,2)
 . . . . D BLDSTAT(LRSTATFLD,LRSTAT),USERDT(LRSTATND,$G(LRSTATUS(63.05,LRSTATFLD)))
 ;
 ;
 Q
 ;
 ;
BLDSTAT(FLD,VAL) ;
 ; Convenience method
 D BLDSTAT^LRVRMI4A(63.05,FLD,VAL,.LRSTATUS)
 Q
 ;
 ;
USERDT(LRNODE,LRSTAT) ; Set user and date/time in respective MI section
 ; Call with LRNODE = MI node to set
 ;           LRSTAT = status to set (optional)
 ;
 I '$D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRNODE)) S $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRNODE),U)=LRNOW
 ;
 ; Update status, don't change an existing "P" to a "F"
 I $G(LRSTAT)'="" D
 . I LRSTAT="F",$P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRNODE),"^",2)="P" Q
 . S $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRNODE),"^",2)=LRSTAT
 ;
 ; AFB (node=11) stores user in 5th piece instead of usual 3rd piece for other nodes.
 I LRNODE'=11 S $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRNODE),U,3)=$S($G(LRDUZ):LRDUZ,1:$G(DUZ))
 E  S $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRNODE),U,5)=$S($G(LRDUZ):LRDUZ,1:$G(DUZ))
 ;
 Q
