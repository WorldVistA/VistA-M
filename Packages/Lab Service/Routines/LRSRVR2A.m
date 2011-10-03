LRSRVR2A ;DALIO/FHS - LAB DATA SERVER CONT'D RELMA EXTRACT ; Aug 17, 2006
 ;;5.2;LAB SERVICE;**346**;Sep 27, 1994;Build 10
 ; Called by LRSRVR2
 ;
 ;
CLEAN ;
 K ^TMP($J,"LR60")
 K ERR,LA7PCNT,LR60IEN,LR60NM,LR6421,LR64IEN
 K LRACTION,LRCC,LRCCNX,LOINCDTA,LRRNLT,LRCDEF,LREND
 K LRL,LRLNC,LRLNC80,LRLNCN,LRLNCX,LRNODE,LROUT,LROUT1,LRR64
 K LRSPEC,LRSPEC60,LRSPECN,LRSPECTA,LRST,LRSTN,LRSTR,LRSTSYN
 K LRTA,LRUNIT,LRX,LRY,X,Y
 D CLEAN^LRSRVR
 D ^%ZISC
 Q
 ;
 ;
HDR ; Set the header information
 S ^TMP($J,"LRDATA",1)="Report Generated.......: "_$$FMTE^XLFDT($$NOW^XLFDT)_" at "_LRSTN
 S ^TMP($J,"LRDATA",2)="Report requested.......: "_LRSUB
 S ^TMP($J,"LRDATA",3)="LOINC version..........: "_$$GET1^DID(95.3,"","","PACKAGE REVISION DATA")
 S ^TMP($J,"LRDATA",4)="VistA File version.....: "_$G(^LAB(95.3,"VR"))
 S ^TMP($J,"LRDATA",5)="Extract version........: 1.1"
 F I=6,12,13 S ^TMP($J,"LRDATA",I)=" "
 S ^TMP($J,"LRDATA",14)="Legend:"
 S X="Station #-60 ien-Spec ien-Index|Test Name|Spec|Time Aspect|Units|LOINC|NLT #|Battery Code|Battery Description|Lab Section|Subscript|Comment|Data Type|Reference low|Reference high|Therapeutic low|Therapeutic high|"
 S ^TMP($J,"LRDATA",15)=X
 ;S X="           1                   |    2    |  3 |     4     |  5  |  6  |  7  |    8       |     9             |     10    |   11    |   12  |    13   |     14      |     15       |      16       |       17       |"
 ;S ^TMP($J,"LRDATA",16)=X
 S X="Use Ref Lab|Site Comment|Test Synonyms|Test Type|Default LOINC|Extract Ver|"
 S ^TMP($J,"LRDATA",16)=X
 ;S X="      18   |     19     |       20    |    21   |      22     |    23     |"
 ;S ^TMP($J,"LRDATA",18)=X
 S ^TMP($J,"LRDATA",17)=$$REPEAT^XLFSTR("-",$L(X))
 S ^TMP($J,"LRDATA",18)=" "
 I 'LRTXT D
 . S LRFILENM=$TR(LRSTN," ","_")_"-"_LRSUB_"-"_$P($$FMTHL7^XLFDT($$NOW^XLFDT),"-")_".TXT"
 . S ^TMP($J,"LRDATA",12)="Attached LMOF file.....: "_LRFILENM
 . S ^TMP($J,"LRDATA",19)=$$UUBEGFN(LRFILENM)
 Q
 ;
 ;
SITENOTE ; Build site's test notes for first record
 ;
 N LRI,LRSTNDT
 K LRSTNOTE
 S (LRSTNOTE,LRI)=0
 F  S LRI=$O(^LAB(60,LR60IEN,11,LRI)) Q:'LRI  D
 . S LRSTNDT=$P($G(^LAB(60,LR60IEN,11,LRI,0)),"^")
 . M LRSTNOTE(LRI)=^LAB(60,LR60IEN,11,LRI,1)
 . S LRSTNOTE(LRI,1,0)=$S(LRI>1:"^",1:"")_$$FMTE^XLFDT(LRSTNDT,"1M")_": "_$G(LRSTNOTE(LRI,1,0))
 . K LRSTNOTE(LRI,0)
 I $D(LRSTNOTE) S LRSTNOTE=1
 Q
 ;
 ;
SYNNOTE ; Build site's test synonym's for first record
 ;
 K LRSTSYN
 S LRSTSYN=0
 M LRSTSYN=^LAB(60,LR60IEN,5)
 K LRSTSYN(0),LRSTSYN("B")
 I $D(LRSTSYN) S LRSTSYN=1
 Q
 ;
 ;
SUFFIX ; If Result NLT does not have a suffix, i.e. it has .0000 then check for suffixed NLT codes which can also be used
 N LR64,LRRNLT,LRROOT,LRX,LRY
 S LRRNLT=$$GET1^DIQ(64,LRR64_",",1,"E")
 S LRROOT="^LAM(""E"","_LRRNLT_")"
 F  S LRROOT=$Q(@LRROOT) Q:LRROOT=""  Q:$P($QS(LRROOT,2),".")'=$P(LRRNLT,".")  D
 . S LR64=$QS(LRROOT,3)
 . I $G(^LAM(LR64,5,LRSPEC60,0)) S LRSPEC(LRSPEC60_"-"_LR64)=LRSPEC60_U_LRSPECN_U_LRSPECTA_U_LRUNIT_U_LR64
 Q
 ;
 ;
UUBEGFN(LRFILENM) ; Construct uuencode "begin" coding
 ; Call with LRFILENM = name of uuencoded file attachment
 ; 
 ; Returns LRX = string with "begin..."_file name
 ;
 N LRX
 S LRX="begin 644 "_LRFILENM
 Q LRX
