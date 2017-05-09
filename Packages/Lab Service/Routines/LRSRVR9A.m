LRSRVR9A ;BPFO/DTG - LAB NTRT DATA SERVER CONT'D MISSING VUID EXTRACT ;02/10/2016
 ;;5.2;LAB SERVICE;**468**;FEB 10 2016;Build 64
 ;
 ; Based on LRSRVR2,LRSRVR2A
 ;
UUEN(STR) ; Uuencode string passed in.
 N J,K,LEN,LRI,LRX,S,TMP,X,Y
 S TMP="",LEN=$L(STR)
 F LRI=1:3:LEN D
 . S LRX=$E(STR,LRI,LRI+2)
 . I $L(LRX)<3 S LRX=LRX_$E("   ",1,3-$L(LRX))
 . S S=$A(LRX,1)*256+$A(LRX,2)*256+$A(LRX,3),Y=""
 . F K=0:1:23 S Y=(S\(2**K)#2)_Y
 . F K=1:6:24 D
 . . S J=$$DEC^XLFUTL($E(Y,K,K+5),2)
 . . S TMP=TMP_$C(J+32)
 S TMP=$C(LEN+32)_TMP
 Q TMP
 ;
TSTTYP(LRX) ; Determine test data type
 N LRSTUB,LRTYPE,LRY
 I LRX="" Q "|"
 S LRX=$P(LRX,"(",2)
 ;
 ; Data type
 S LRTYPE=$$GET1^DID($P(LRX,","),$P(LRX,",",2,99),"","TYPE")
 S $P(LRSTUB,"|",2)=LRTYPE
 ;
 ; Input transform
 S LRY=$$GET1^DID($P(LRX,","),$P(LRX,",",2,99),"",$S(LRTYPE="SET":"POINTER",1:"INPUT TRANSFORM"))
 I LRTYPE="NUMERIC",LRY["LRNUM" D
 . S LRX=$P(LRY,"""",2)
 . I LRX?.1"-".N1","1.N1","1N S LRY="Number from "_$P(LRX,",")_" to "_$P(LRX,",",2)_" with "_$P(LRX,",",3)_" decimal"
 S $P(LRSTUB,"|",1)=LRY
 ; Help prompt
 I LRTYPE="FREE TEXT" D
  . S LRY=$$GET1^DID($P(LRX,","),$P(LRX,",",2,99),"","HELP-PROMPT")
  . S $P(LRSTUB,"|",1)=LRY
 Q LRSTUB
 ;
ENCODE(LRSTR) ; Encode a string, keep remainder for next line
 ; Call with LRSTR by reference, Remainder returned in LRSTR
 ;
 S LRQUIT=0,LRLEN=$L(LRSTR)
 F  D  Q:LRQUIT
 . I $L(LRSTR)<45 S LRQUIT=1 Q
 . S LRX=$E(LRSTR,1,45)
 . S LRNODE=LRNODE+1,^TMP($J,"LRDATA",LRNODE)=$$UUEN(LRX)
 . S LRSTR=$E(LRSTR,46,LRLEN)
 Q
 ;
MAILSEND(LRMSUBJ) ; Send extract back to requestor.
 ;
 N LRINSTR,LRTASK,LRTO,XMERR,XMZ
 ;
 ;ZEXCEPT: XQSND
 ;
 S LRTO(XQSND)=""
 S LRINSTR("ADDR FLAGS")="R"
 S LRINSTR("FROM")="LAB_PACKAGE"
 S LRMSUBJ=$E(LRMSUBJ,1,65)
 D SENDMSG^XMXAPI(.5,LRMSUBJ,"^TMP($J,""LRDATA"")",.LRTO,.LRINSTR,.LRTASK)
 Q
 ;
CLEAN ;
 K ^TMP($J,"LR60")
 K ERR,LA7PCNT,LR60IEN,LR60NM,LR6421,LR64IEN
 K LRACTION,LRCC,LRCCNX,LOINCDTA,LRRNLT,LRCDEF,LREND
 K LRL,LRLNC,LRLNC80,LRLNCN,LRLNCX,LRNODE,LROUT,LROUT1,LRR64
 K LRSPEC,LRSPEC60,LRSPECN,LRSPECTA,LRST,LRSTN,LRSTR,LRSTSYN
 K LRTA,LRUNIT,LRX,LRY,X,Y,LRMISP
 K LSITE,LRNT,LRNTI,AR,LRBLD,LRSUBSCRIPT,LRTYPER,LRTXT
 K LRCDEF,LRCREATE,LREXPY,LRINACT,LRNODE,LRSPECCT,LA7TREE
 D CLEAN^LRSRVR
 D ^%ZISC
 Q
 ;
 ;
HDR ; Set the header information
 N XA S XA=""
 S ^TMP($J,"LRDATA",1)="Report Generated.......: "_$$FMTE^XLFDT($$NOW^XLFDT)_" at "_LRSTN
 S ^TMP($J,"LRDATA",2)="Report requested.......: "_LRSUB
 S ^TMP($J,"LRDATA",3)="LOINC version..........: "_$$GET1^DID(95.3,"","","PACKAGE REVISION DATA")
 S ^TMP($J,"LRDATA",4)="VistA File version.....: "_$G(^LAB(95.3,"VR"))
 S ^TMP($J,"LRDATA",5)="Extract version........: 1.1"
 F I=6,12,13 S ^TMP($J,"LRDATA",I)=" "
 S ^TMP($J,"LRDATA",14)="Legend:"
 S X="Station #-60 ien-Spec ien-Index|Test Name|Spec|Time Aspect|Units|Mapped LOINC|NLT #|Battery Code|Battery Description|Lab Section|Subscript|Comment|Data Type|Reference low|Reference high|Therapeutic low|Therapeutic high|"
 S ^TMP($J,"LRDATA",15)=X,XA=$L(X)
 ; S ^TMP($J,"LRDATA",17)=$$REPEAT^XLFSTR("-",$L(X))
 ;S X="           1                  |    2    |  3 |     4     |  5  |  6  |  7  |    8       |     9             |     10    |   11    |   12  |    13   |     14      |     15       |      16       |       17       |"
 ;S ^TMP($J,"LRDATA",16)=X
 S X="Use Ref Lab|Site Comment|Test Synonyms|Test Type |MLTF 66.3 IEN|MLTF LOINC|MLTF Name|MLTF Alt Name|Default LOINC|Submitted to NTRT|Specimen Create Date|Extract Ver|"
 ;S X="      18   |     19     |       20    |    21   |  22         |    23    |      24 |     25      |  26         |    27           |   28               |    29     |"
 I LRMISP=1 D
 . S X="Use Ref Lab|Site Comment|Test Synonyms|Test Type |MLTF 66.3 IEN|MLTF LOINC|MLTF Name|MLTF Alt Name|Default LOINC|Submitted to NTRT|Specimen Create Date| MISSING SPECIMENS|Extract Ver|"
 . ;S X="      18   |     19     |       20    |    21   |  22         |    23    |      24 |     25      |  26         |    27           |   28               |    29            |     30    |"
 S ^TMP($J,"LRDATA",16)=X,XA=XA+$L(X)
 ;S ^TMP($J,"LRDATA",18)=X
 ;S ^TMP($J,"LRDATA",18)=$$REPEAT^XLFSTR("-",$L(X))
 I XA<245 S ^TMP($J,"LRDATA",17)=$$REPEAT^XLFSTR("-",XA)
 I XA>245 S X=245,^TMP($J,"LRDATA",17)=$$REPEAT^XLFSTR("-",X)
 S ^TMP($J,"LRDATA",18)=" "
 I 'LRTXT D
 . S LRFILENM=$TR(LRSTN," ","_")_"-"_LRSUB_"-"_$P($$FMTHL7^XLFDT($$NOW^XLFDT),"-")_".TXT"
 . S ^TMP($J,"LRDATA",12)="Attached LMOF file.....: "_LRFILENM
 . S ^TMP($J,"LRDATA",19)=$$UUBEGFN(LRFILENM)
 K XA
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
 ;
 ; this is from LA7ADL1
UNWIND(LA760,LA7URG,LA7PARNT) ; Unwind profile - set tests into array LA7TREE with urgency.
 ;
 ; Call with  LA760 = file #60 ien
 ;           LA7URG = file #62.05 ien
 ;         LA7PARNT = file #60 ien -  ordered parent (panel)
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
 I '$O(^LAB(60,LA760,2,0)) S LA7TREE(LA760)=LA7URG_"^"_LA7PARNT,LA7PCNT=0 Q
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
 . I II D UNWIND(II,LA7URG,LA7PARNT)
 ;
 Q
