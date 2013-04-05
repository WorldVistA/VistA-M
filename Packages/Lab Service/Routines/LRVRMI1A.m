LRVRMI1A ;DALOI/STAFF - LAB MICRO HL7 INTERFACE ;05/12/09  18:26
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 Q
 ;
SRCHEN2 ;
 ; Continued from SRCHEN^LRVRMI1
 N IEN,IEN2
 ; mycology prep/smear
 I $D(^LAH(LWL,1,ISQN,"MI",15)) D
 . D USERDT(8)
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,15)=^LAH(LWL,1,ISQN,"MI",15)
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
 ; preliminary bacteria comment
 I $D(^LAH(LWL,1,ISQN,"MI",19)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,19)=^LAH(LWL,1,ISQN,"MI",19)
 ;
 ; preliminary virus comment
 I $D(^LAH(LWL,1,ISQN,"MI",20)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,20)=^LAH(LWL,1,ISQN,"MI",20)
 ;
 ; preliminary parasite comment
 I $D(^LAH(LWL,1,ISQN,"MI",21)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,21)=^LAH(LWL,1,ISQN,"MI",21)
 ;
 ; preliminary mycology comment
 I $D(^LAH(LWL,1,ISQN,"MI",22)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,22)=^LAH(LWL,1,ISQN,"MI",22)
 ;
 ; preliminary TB comment
 I $D(^LAH(LWL,1,ISQN,"MI",23)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,23)=^LAH(LWL,1,ISQN,"MI",23)
 ;
 ; parasite prep/smear
 I $D(^LAH(LWL,1,ISQN,"MI",24)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,24)=^LAH(LWL,1,ISQN,"MI",24)
 ;
 ; bacteriology prep/smear
 I $D(^LAH(LWL,1,ISQN,"MI",25)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,25)=^LAH(LWL,1,ISQN,"MI",25)
 ;
 ; bacteria tests
 I $D(^LAH(LWL,1,ISQN,"MI",26)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,26)=^LAH(LWL,1,ISQN,"MI",26)
 ;
 ; parasitology tests
 I $D(^LAH(LWL,1,ISQN,"MI",27)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,27)=^LAH(LWL,1,ISQN,"MI",27)
 ;
 ; mycology tests
 I $D(^LAH(LWL,1,ISQN,"MI",28)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,28)=^LAH(LWL,1,ISQN,"MI",28)
 ;
 ; TB tests
 I $D(^LAH(LWL,1,ISQN,"MI",29)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,29)=^LAH(LWL,1,ISQN,"MI",29)
 ;
 ; virology tests
 I $D(^LAH(LWL,1,ISQN,"MI",30)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,30)=^LAH(LWL,1,ISQN,"MI",30)
 ;
 ; sterility tests
 I $D(^LAH(LWL,1,ISQN,"MI",31)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,31)=^LAH(LWL,1,ISQN,"MI",31)
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
