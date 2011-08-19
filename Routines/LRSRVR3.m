LRSRVR3 ;DALOI/JMC -LAB DATA SERVER, CONT'D - LOINC SECTION ;Aug 17,2006
 ;;5.2;LAB SERVICE;**303,346**;Sep 27, 1994;Build 10
 ;
 ;
LOINCLD ; Build and send local delimited LOINC report
 N I,LR6206,LR64,LINR,LRA,LRB,LRCNT,LRCRLF,LRMSUBJ,LRNODE,LRSTR,LRTXT,LRXREF,X,Y
 ;
 K ^TMP($J,"LRSERVER","LOINC"),^TMP($J,"LRDATA")
 S ^TMP($J,"LRDATA",1)="Report Generated.......: "_$$FMTE^XLFDT($$NOW^XLFDT)_" at "_LRSTN
 S ^TMP($J,"LRDATA",2)="Report requested.......: "_LRSUB
 S ^TMP($J,"LRDATA",3)="LOINC version..........: "_$$GET1^DID(95.3,"","","PACKAGE REVISION DATA")
 S ^TMP($J,"LRDATA",4)="File version...........: "_$G(^LAB(95.3,"VR"))
 S LRFILENM=$TR(LRSTN," ","_")_"-"_LRSUB_"-"_$P($$FMTHL7^XLFDT($$NOW^XLFDT),"-")_".TXT"
 S ^TMP($J,"LRDATA",5)="Attached file..........: "_LRFILENM
 S ^TMP($J,"LRDATA",7)=" "
 S ^TMP($J,"LRDATA",8)="Legend:"
 S X="Station #-64 ien-61 ien-Time Aspect|NLT Code|NLT Name|Default LOINC Code|Default LOINC Name|Default Test|Time Aspect|Specimen|Data Location|Data Type|Input Transform|Units|Test Name|LOINC Code|LOINC Name"
 S ^TMP($J,"LRDATA",9)=X
 S Y="|Reference Low|Reference High|Therapeutic Low|Therapeutic High|Subscript|Lab Section|"
 S ^TMP($J,"LRDATA",10)=Y
 S ^TMP($J,"LRDATA",11)="                 1                 |    2   |   3    |          4       |        5         |      6     |     7     |   8    |     9       |   10    |       11      |  12 |    13   |    14    |    15    "
 S ^TMP($J,"LRDATA",12)="|     16      |      17      |      18       |     19         |    20   |     21    |"
 S ^TMP($J,"LRDATA",13)=$$REPEAT^XLFSTR("-",$L(X))
 S ^TMP($J,"LRDATA",14)=$$REPEAT^XLFSTR("-",$L(Y))
 S ^TMP($J,"LRDATA",15)=" "
 S ^TMP($J,"LRDATA",16)=$$UUBEGFN^LRSRVR2A(LRFILENM)
 S LINR=1,LRCNT=0,LRSTR="",LRTXT=0,LRCRLF=$C(13,10)
 ;
 F LRXREF="AI","AH" D
 . S LRA=""
 . F  S LRA=$O(^LAM(LRXREF,LRA)) Q:'LRA  D
 . . S LRB=""
 . . F  S LRB=$O(^LAM(LRXREF,LRA,LRB)) Q:LRB=""  S ^TMP($J,"LRSERVER","LOINC",LRB)=""
 ;
 S LR64=""
 F  S LR64=$O(^TMP($J,"LRSERVER","LOINC",LR64)) Q:LR64=""  D LOINCLA
 ;
 S LR6206=0,LRSS="MI"
 F  S LR6206=$O(^LAB(62.06,LR6206)) Q:'LR6206  D
 . S LR64=$$GET1^DIQ(62.06,LR6206_",",64,"I")
 . S LRREC=$$MICRO(LR64)
 . S LRINDX=LRST_"-"_LR64_"-"_"AB"_LR6206
 . S LRSTR=LRSTR_LRINDX_"|"_LRREC_LRCRLF
 . D SETDATA^LRSRVR2
 . S LRCNT=LRCNT+1
 ;
 S ^TMP($J,"LRDATA",6)="Total number of records: "_LRCNT
 I '$O(^TMP($J,"LRDATA",15)) S ^TMP($J,"LRDATA",12)="No LOINC codes mapped at "_LRSTN
 ;
 ; Set the final info into the ^TMP( message global
 S LRNODE=$O(^TMP($J,"LRDATA",""),-1)+1
 I LRSTR'="" S ^TMP($J,"LRDATA",LRNODE)=$$UUEN^LRSRVR4(LRSTR)
 S ^TMP($J,"LRDATA",LRNODE+1)=" "
 S ^TMP($J,"LRDATA",LRNODE+2)="end"
 ;
 S LRMSUBJ=LRST_" "_LRSTN_" LOCAL REPORT DELIMIT "_$$HTE^XLFDT($H,"1M")
 D MAILSEND^LRSRVR6(LRMSUBJ)
 D CLEAN^LRSRVR
 Q
 ;
 ;
LOINCLA ;
 N LR60,LR61,LRAA,LRAA1,LRERR,LRINDX,LOINCDTA,LOINCDTB,LRPNTA,LRPNTB,LRREC,LRSS,LRX
 D GETS^DIQ(64,LR64,".01;1;13;25;25.5","IE","LOINCDTB","LRERR")
 D GETS^DIQ(64,LR64,"20*","IE","LOINCDTA","LRERR")
 S LRPNTB=$O(LOINCDTB(64,"")) Q:LRPNTB=""
 ;
 ; NLT Code/Procedure
 S LRSTUB=$G(LOINCDTB(64,LRPNTB,1,"E"))
 S $P(LRSTUB,"|",2)=$G(LOINCDTB(64,LRPNTB,.01,"I"))
 ;
 ; Default LOINC code/name
 S $P(LRSTUB,"|",3)=$G(LOINCDTB(64,LRPNTB,25,"E"))
 S $P(LRSTUB,"|",4)=$G(^LAB(95.3,+$G(LOINCDTB(64,LRPNTB,25,"I")),81))
 ;
 ; Default LOINC code test (64,25.5)
 S $P(LRSTUB,"|",5)=$G(LOINCDTB(64,LRPNTB,25.5,"I"))
 ;
 ; Look for 64.01 & 64.02 here
 S LRAA1=""
 F  S LRAA1=$O(LOINCDTA(64.01,LRAA1)) Q:LRAA1=""  D
 . I '$D(LOINCDTA(64.01,LRAA1,.01,"I")) D  Q
 . . S $P(LRSTUB,"|",6)="Specimen sub-field error in file 64 - "_LRAA1
 . . S $P(LRSTUB,"|",7)=$G(LRERR("DIERR",1,"TEXT",1))
 . . S LRSTR=LRSTR_LRCRLF
 . . D SETDATA^LRSRVR2
 . . S LRCNT=LRCNT+1
 . S LRPNTA=LOINCDTA(64.01,LRAA1,.01,"I")
 . S $P(LRSTUB,"|",6)=$$GET1^DIQ(61,LRPNTA_",",.0961) ; Time Aspect
 . S $P(LRSTUB,"|",7)=LOINCDTA(64.01,LRAA1,.01,"E") ; Specimen
 . S LRAA=""
 . F  S LRAA=$O(LOINCDTA(64.02,LRAA)) Q:LRAA=""  I LRAA[LRAA1 D
 . . S $P(LRSTUB,"|",8)=$G(LOINCDTA(64.02,LRAA,2,"E")) ; Data location
 . . S LR60=+LOINCDTA(64.02,LRAA,3,"I")
 . . S LR61=+LOINCDTA(64.01,$P(LRAA,",",2,4),.01,"I")
 . . S $P(LRSTUB,"|",9,10)=$$TSTTYP(LOINCDTA(64.02,LRAA,2,"I"))
 . . S LRSS=$$GET1^DIQ(60,LR60_",",4,"I") ; Subscript
 . . S LRX=$$GET1^DIQ(60.01,LR61_","_LR60_",",6) ; Units
 . . S $P(LRSTUB,"|",11)=$$TRIM^XLFSTR(LRX,"LR"," ")
 . . S $P(LRSTUB,"|",12)=LOINCDTA(64.02,LRAA,3,"E") ; Test name
 . . S $P(LRSTUB,"|",13)=$G(LOINCDTA(64.02,LRAA,4,"E")) ; Loinc code
 . . S $P(LRSTUB,"|",14)=$G(^LAB(95.3,+$G(LOINCDTA(64.02,LRAA,4,"E")),81)) ; LOINC code (64.02,4)
 . . S X=$G(^LAB(60,LR60,1,LR61,0))
 . . S $P(LRSTUB,"|",15)=$P(X,"^",2) ; Test reference low
 . . S $P(LRSTUB,"|",16)=$P(X,"^",3) ; Test reference high
 . . S $P(LRSTUB,"|",17)=$P(X,"^",11) ; Test therapeutic low
 . . S $P(LRSTUB,"|",18)=$P(X,"^",12) ; Test therapeutic high
 . . S $P(LRSTUB,"|",19)=LRSS ; Lab subscript
 . . S $P(LRSTUB,"|",20)=$G(LOINCDTB(64,LRPNTB,13,"E")) ; Lab section
 . . S LRINDX=LRST_"-"_LR64_"-"_LR61_"-"_LOINCDTA(64.02,LRAA,.01,"I")
 . . S LRSTR=LRSTR_LRINDX_"|"_LRSTUB_LRCRLF
 . . D SETDATA^LRSRVR2
 . . S LRCNT=LRCNT+1
 Q
 ;
 ;
MICRO(LR64) ;
 N LOINCDTB,LR6421,LRPNTB,LRSTUB
 S LRSTUB=""
 D GETS^DIQ(64,LR64,".01;1;13;25;25.5","IE","LOINCDTB","LRERR")
 D GETS^DIQ(64,LR64,"20*","IE","LOINCDTA","LRERR")
 S LRPNTB=$O(LOINCDTB(64,"")) Q:LRPNTB="" LRSTUB
 ;
 ; NLT Code/Procedure
 S LRSTUB=$G(LOINCDTB(64,LRPNTB,1,"E"))
 S $P(LRSTUB,"|",2)=$G(LOINCDTB(64,LRPNTB,.01,"I"))
 ;
 ; Default LOINC code/name
 S $P(LRSTUB,"|",3)=$G(LOINCDTB(64,LRPNTB,25,"E"))
 S $P(LRSTUB,"|",4)=$G(^LAB(95.3,+$G(LOINCDTB(64,LRPNTB,25,"I")),81))
 ;
 ; Anti-microbial Suscept (62.06,.01)
 S $P(LRSTUB,"|",5)=$$GET1^DIQ(62.06,LR6206_",",.01)
 ;
 ; Lab subscript/section
 S $P(LRSTUB,"|",19)=LRSS
 I $G(LOINCDTB(64,LRPNTB,13,"I")) D  ; Lab section
 . S LR6421=LOINCDTB(64,LRPNTB,13,"I")
 . S $P(LRSTUB,"|",20)=$$GET1^DIQ(64.21,LR6421_",",1)
 ;
 Q LRSTUB
 ;
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
