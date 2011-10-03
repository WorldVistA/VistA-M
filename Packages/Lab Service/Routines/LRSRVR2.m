LRSRVR2 ;DALIO/FHS - LAB DATA SERVER CONT'D RELMA EXTRACT ; Jan 9, 2006
 ;;5.2;LAB SERVICE;**303,346**;Sep 27, 1994;Build 10
 ; Produces LOINC RELMA extract - via LRLABSERVER or option
 ;
EN ; Called by option [LR LOINC EXTRACT RELMA FORMAT]
 ; Entry point for the option - user must capture output
 N DIR,DIRUT,LREND,LRCNT,LRSUB,LRVAL,LRST,LRSTN,LRTXT,X,Y
 S DIR(0)="Y",DIR("A")="Ready to Capture",DIR("B")="Yes"
 D ^DIR
 I $D(DIRUT) Q
 D WAIT^DICD
 S LRSUB="RELMA",LRTXT=1
 D BUILD
 W !
 S LRL=0
 F  S LRL=$O(^TMP($J,"LRDATA",LRL)) Q:LRL<1  W !,^(LRL)
 D CLEAN^LRSRVR2A
 Q
 ;
 ;
SERVER ; Server entry Point
 N I,LRCNT,LREND,LRL,LRMSUBJ,LRTXT,LRX,LRY
 S LRTXT=0
 D BUILD
 S LRMSUBJ=LRST_" "_LRSTN_" RELMA EXTRACT "_$$HTE^XLFDT($H,"1M")
 D MAILSEND^LRSRVR6(LRMSUBJ)
 D CLEAN^LRSRVR2A
 Q
 ;
 ;
BUILD ; Build extract
 N I,LR6206,LR64,LRCNT,LRCRLF,LRLEN,LRQUIT,LRROOT,LRSTNOTE,LRSS,LRSTR,LRSTUB,LRVAL
 S LRVAL=$$SITE^VASITE,LRST=$P(LRVAL,"^",3),LRSTN=$P(LRVAL,"^",2)
 I LRST="" S LRST="???"
 K ^TMP($J,"LRDATA"),^TMP($J,"LR60")
 S LRCNT=0,LRCRLF=$C(13,10),LRSTR=""
 F I=0,1,2,3 S LRCNT(I)=0
 D HDR^LRSRVR2A
 ;
 ; Step down the B X-ref - exclude synomyms
 S LRROOT="^LAB(60,""B"")"
 F  S LRROOT=$Q(@LRROOT) Q:LRROOT=""  Q:$QS(LRROOT,2)'="B"  D
 . Q:$G(@LRROOT)
 . D TEST
 ;
 ; Process microbiology antibiotics
 S LR6206=0,LRSS="MI"
 F  S LR6206=$O(^LAB(62.06,LR6206)) Q:'LR6206  D
 . S LR64=$$GET1^DIQ(62.06,LR6206_",",64,"I")
 . S LRX=$$MICRO^LRSRVR3(LR64)
 . S LRSTUB=$P(LRX,"|",5)_"||||"_$P(LRX,"|",3)_"|"_$P(LRX,"|",1)_"|||"_$P(LRX,"|",20)_"|"_$P(LRX,"|",19)_"|||||||||||"
 . I LR64 S LRSTUB=LRSTUB_$$GET1^DIQ(64,LR64_",",25)
 . S LRSTUB=LRSTUB_"|1.1|" ; Set extract version number
 . S LRSTR=LRSTR_LRST_"-"_LR64_"-"_"AB"_LR6206_"|"_LRSTUB
 . I 'LRTXT S LRSTR=LRSTR_LRCRLF
 . D SETDATA S LRCNT=LRCNT+1,LRCNT(3)=LRCNT(3)+1
 ;
 ; Set the final info into the ^TMP message global
 I 'LRTXT D
 . S LRNODE=$O(^TMP($J,"LRDATA",""),-1)
 . I LRSTR'="" S LRNODE=LRNODE+1,^TMP($J,"LRDATA",LRNODE)=$$UUEN^LRSRVR4(LRSTR)
 . S ^TMP($J,"LRDATA",LRNODE+1)=" "
 . S ^TMP($J,"LRDATA",LRNODE+2)="end"
 ;
 S ^TMP($J,"LRDATA",6)="Total number of records: "_$J(LRCNT,5)
 S ^TMP($J,"LRDATA",7)="Total number of tests..: "_$J(LRCNT(0),5)
 S ^TMP($J,"LRDATA",8)="Tests with LOINC code..: "_$J(LRCNT(1),5)
 S ^TMP($J,"LRDATA",9)="Tests with NLT code....: "_$J(LRCNT(2),5)
 S ^TMP($J,"LRDATA",10)="Antimicrobials.........: "_$J(LRCNT(3),5)
 ;
 Q
 ;
 ;
TEST ; Pull out test info
 N LA7TREE,LR60,LRBATTY,LRBATTYN,LRTSTTYP
 K LROUT,LRSPEC,ERR
 S LR60NM=$QS(LRROOT,3),LR60IEN=$QS(LRROOT,4)
 S LR60NM=$$TRIM^XLFSTR(LR60NM,"RL"," ")
 S LRTSTTYP=$P(^LAB(60,LR60IEN,0),"^",3)
 ;
 ; Bypass "neither" type tests.
 I LRTSTTYP="N" Q
 ; Bypass "workload" type tests.
 I $P(^LAB(60,LR60IEN,0),"^",4)="WK" Q
 ;
 S LRBATTY=LRST_"-"_LR60IEN,LRBATTYN=LR60NM
 S LRBATTY=$$TRIM^XLFSTR(LRBATTY,"RL"," ")
 ; Panel test
 ; Bypass "output panel" type tests - usually used for display only.
 I $O(^LAB(60,LR60IEN,2,0)) D  Q
 . I $P(^LAB(60,LR60IEN,0),"^",3)="O" Q
 . D UNWIND^LA7ADL1(LR60IEN,9,0)
 . S LR60=0
 . F  S LR60=$O(LA7TREE(LR60)) Q:'LR60  D
 . . I $D(^TMP($J,"LR60",LR60)) Q
 . . S LR60IEN=LR60,LR60NM=$P(^LAB(60,LR60IEN,0),"^")
 . . S LRTSTTYP=$P(^LAB(60,LR60IEN,0),"^",3)
 . . ; Bypass "neither" type tests.
 . . I LRTSTTYP="N" Q
 . . ; Bypass "workload" type tests.
 . . I $P(^LAB(60,LR60IEN,0),"^",4)="WK" Q
 . . S LRR64=+$P($G(^LAB(60,+LR60IEN,64)),U,2)
 . . D SPEC
 ;
 I $D(^TMP($J,"LR60",LR60IEN)) Q
 ; Not a panel test
 ; Get result NLT code
 S LRR64=+$P($G(^LAB(60,+LR60IEN,64)),U,2)
 D SPEC
 Q
 ;
 ;
SPEC ; Check each specimen for this test
 K LRSPEC,LROUT
 S (LRCDEF,LRSPEC,LRSPECN,LRLNC,LRLNCN,LRLNCX,LRLNC80,LRUNIT,Y)=""
 D SITENOTE^LRSRVR2A
 D SYNNOTE^LRSRVR2A
 S LRSPEC60=0
 F  S LRSPEC60=$O(^LAB(60,+LR60IEN,1,LRSPEC60)) Q:'LRSPEC60  D
 . Q:'($D(^LAB(60,+LR60IEN,1,LRSPEC60,0))#2)
 . S LRUNIT=$P(^LAB(60,+LR60IEN,1,LRSPEC60,0),U,7)
 . S X=$G(^LAB(61,LRSPEC60,0))
 . S LRSPECN=$P(X,"^"),LRSPECTA=$P(X,"^",10)
 . S LRSPEC(LRSPEC60_"-0")=LRSPEC60_U_LRSPECN_U_LRSPECTA_U_LRUNIT_U_LRR64
 . I LRR64,$P($$GET1^DIQ(64,LRR64_",",1,"E"),".",2)="0000" D SUFFIX^LRSRVR2A
 D SPECLOOP
 Q
 ;
 ;
SPECLOOP ; Check to see if specimen has been linked to LOINC
 ;
 N LR64,LR6421,LRINDX,LRLNTA,LRRNLT,LRTA,LRX,X
 S LRINDX=0
 F  S LRINDX=$O(LRSPEC(LRINDX)) Q:'LRINDX  D
 . S X=LRSPEC(LRINDX)
 . S LRSPEC=$P(X,U),LRSPECN=$P(X,U,2),LRLNTA=$P(X,U,3),LR64=$P(X,U,5),LRUNIT=$$TRIM^XLFSTR($P(X,U,4),"RL"," ")
 . S (LR6421,LRLNC,LRRNLT,LRTA)=""
 . I LR64 D
 . . S LRRNLT=$$GET1^DIQ(64,LR64_",",1,"E")
 . . S LR6421=$$GET1^DIQ(64,LR64_",",13,"I")
 . . S LRX=""
 . . I LRSPEC,LRLNTA S LRX=$P($G(^LAM(LR64,5,LRSPEC,1,LRLNTA,1)),"^")
 . . I LRX="",LRSPEC D
 . . . S X=$O(^LAM(LR64,5,LRSPEC,1,0))
 . . . I X S LRLNTA=X,LRX=$P($G(^LAM(LR64,5,LRSPEC,1,X,1)),"^")
 . . I LRX'="" S LRLNC=$$GET1^DIQ(95.3,LRX_",",.01,"E")
 . . I LRLNTA S LRTA=$$GET1^DIQ(64.061,LRLNTA_",",.01,"E")
 . D WRT
 Q
 ;
 ;
WRT ; Set ^TMP( with extracted data
 N LRJ,LREN,LRQUIT,LRSS,X,Y
 ;
 ; Set flag that this file #60 test has been processed - avoid duplicate
 ; processing as component of panel and individual test
 S ^TMP($J,"LR60",LR60IEN)=""
 ;
 S LRSTR=LRSTR_LRST_"-"_LR60IEN_"-"_LRINDX
 S LRSTR=LRSTR_"|"_LR60NM_"|"_LRSPECN_"|"_LRTA_"|"_LRUNIT_"|"_LRLNC_"|"_LRRNLT_"|"_LRBATTY_"|"_LRBATTYN_"|"
 ;
 ; Lab section specified for this NLT code.
 S LRSTR=LRSTR_$S($G(LR6421)>0:$$GET1^DIQ(64.21,LR6421_",",1),1:"")_"|"
 ;
 ; Subscript
 S LRSS=$$GET1^DIQ(60,LR60IEN_",",4,"I")
 S LRSTR=LRSTR_LRSS_"|"
 ; Test info - data type, help prompt
 I LRSS'="CH" S LRSTR=LRSTR_"||"
 I LRSS="CH" S X=$$TSTTYP^LRSRVR3($$GET1^DIQ(60,LR60IEN_",",13)) S LRSTR=LRSTR_$P(X,"|")_"|"_$P(X,"|",2)_"|"
 ;
 ; Test reference low|reference high|therapeutic low|therapeutic high|
 S X=$G(^LAB(60,LR60IEN,1,LRSPEC,0))
 S Y=$P(X,"^",2)_"|"_$P(X,"^",3)_"|"_$P(X,"^",11)_"|"_$P(X,"^",12)
 S LRSTR=LRSTR_$TR(Y,$C(34),"")
 ; Use for reference lab testing
 S X=$G(^LAB(60,LR60IEN,1,LRSPEC,.1))
 S LRSTR=LRSTR_"|"_$S($P(X,"^")=1:"YES",1:"NO")_"|"
 ; 
 ; Send site's test notes on first record for this test.
 I LRSTNOTE D
 . D SETDATA
 . S LRJ="LRSTNOTE"
 . F  S LRJ=$Q(@LRJ) Q:LRJ=""  D
 . . S X=@LRJ I X["|" S X=$TR(X,"|","~")
 . . S LRSTR=LRSTR_X D SETDATA
 . S LRSTNOTE=0
 S LRSTR=LRSTR_"|"
 ;
 ; Send site's test synonym's on first record for this test.
 I LRSTSYN D
 . D SETDATA
 . S LRJ="LRSTSYN"
 . F  S LRJ=$Q(@LRJ) Q:LRJ=""  S LRSTR=LRSTR_@LRJ_"^" D SETDATA
 . S LRSTSYN=0
 ;
 ; Send file #60 test type
 S LRSTR=LRSTR_"|"_LRTSTTYP_"|"
 ;
 ; Send default LOINC code
 I LR64 S LRSTR=LRSTR_$$GET1^DIQ(64,LR64_",",25)
 ;
 ; Set extract version number
 S LRSTR=LRSTR_"|1.1|"
 ;
 I 'LRTXT S LRSTR=LRSTR_LRCRLF
 D SETDATA
 ;
 S LRCNT=LRCNT+1,LRCNT(0)=LRCNT(0)+1
 I LRLNC'="" S LRCNT(1)=LRCNT(1)+1
 I LR64 S LRCNT(2)=LRCNT(2)+1
 Q
 ;
 ;
SETDATA ; Set data into report structure
 S LRNODE=$O(^TMP($J,"LRDATA",""),-1)
 I LRTXT S LRNODE=LRNODE+1,^TMP($J,"LRDATA",LRNODE)=LRSTR,LRSTR="" Q
 I 'LRTXT D ENCODE^LRSRVR4(.LRSTR)
 Q
