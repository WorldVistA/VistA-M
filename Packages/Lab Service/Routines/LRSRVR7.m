LRSRVR7 ;DALIO/JMC - LAB DATA SERVER CONT'D CPT EXTRACT ;Aug 17, 2006
 ;;5.2;LAB SERVICE;**346**;Sep 27, 1994;Build 10
 ; Produces NLT/CPT extract via LRLABSERVER option
 ;
 Q
 ;
 ;
SERVER ; Server entry Point
 N I,LRCNT,LREND,LRL,LRMSUBJ,LRST,LRSTN,LRTXT,LRX,LRY
 D BUILD
 S LRMSUBJ=LRST_" "_LRSTN_" NLT/CPT EXTRACT "_$$HTE^XLFDT($H,"1M")
 D MAILSEND^LRSRVR6(LRMSUBJ)
 D CLEAN
 Q
 ;
 ;
BUILD ; Build extract
 N LRCNT,LRCRLF,LRFN,LRNAME,LRQUIT,LRROOT,LRSCT,LRSTR,LRVAL,LRVUID,X,Y
 ;
 S LRVAL=$$SITE^VASITE,LRST=$P(LRVAL,"^",3),LRSTN=$P(LRVAL,"^",2)
 I LRST="" S LRST="???"
 K ^TMP($J,"LRDATA")
 S (LRCNT,LRCNT(1),LRCNT(2))=0,LRCRLF=$C(13,10),LRSTR=""
 D HDR,FILE
 ;
 ;
 ; Set the final info into the ^TMP message global
 S LRNODE=$O(^TMP($J,"LRDATA",""),-1)+1
 I LRSTR'="" S ^TMP($J,"LRDATA",LRNODE)=$$UUEN^LRSRVR4(LRSTR)
 S ^TMP($J,"LRDATA",LRNODE+1)=" "
 S ^TMP($J,"LRDATA",LRNODE+2)="end"
 ;
 S J=4
 S ^TMP($J,"LRDATA",J)="Number of records per file:"
 S ^TMP($J,"LRDATA",J+1)=$$LJ^XLFSTR("Total number of records",33,".")_": "_$J(LRCNT,5)
 S ^TMP($J,"LRDATA",J+2)=$$LJ^XLFSTR("CPT/LOINC records",33,".")_": "_$J(LRCNT(1),5)
 S ^TMP($J,"LRDATA",J+3)=$$LJ^XLFSTR("CPT/Default LOINC records",33,".")_": "_$J(LRCNT(2),5)
 ;
 Q
 ;
 ;
CLEAN ;
 K ^TMP($J,"LR61")
 K J,LA7PCNT,LR64CODE,LR64NM,LRFILENM,LRLEN,LRLN,LRLNC,LRNODE,LRSTSYN
 D CLEAN^LRSRVR
 D ^%ZISC
 Q
 ;
 ;
FILE ;
 ;
 N LR64,LR64018,LR81,LRCPT,LRCPTNM,LRI,LRXX,LRYY,LRZ
 S LRROOT="^LAM(""AD"")",(LR64,LR64018)=0
 F  S LRROOT=$Q(@LRROOT) Q:LRROOT=""  Q:$QS(LRROOT,1)'="AD"  D
 . I $QS(LRROOT,3)'="CPT" Q
 . I LR64'=$QS(LRROOT,2) D
 . . S LR64=$QS(LRROOT,2)
 . . S X=$G(^LAM(LR64,0))
 . . S LR64NM=$P(X,"^"),LR64CODE=$P(X,"^",2)
 . . D LOINC
 . . S LRCNT=LRCNT+1
 . S LR64018=$QS(LRROOT,4)
 . S LR81=+$P($G(^LAM(LR64,4,LR64018,0)),"^")
 . S X=$$CPT^ICPTCOD(LR81,DT,1)
 . S LRCPT=$S($P(X,"^")>0:$P(X,"^",2),1:"IEN "_LR81)
 . S LRCPTNM=$S($P(X,"^")>0:$P(X,"^",3),1:$P(X,"^",2))
 . ;  File "default" mapping
 . S LRSTR=LRSTR_LRST_"-"_LR64_"-"_LR64018_"|"_LR64CODE_"|"_LR64NM_"|"_LRCPT_"|"_LRCPTNM_"|"_LRLN
 . D SETDATA
 . ; File specific specimen/time aspect LOINC mappings
 . S LRXX=LRST_"-"_LR64_"-"_LR64018_"-"
 . S LRYY="|"_LR64CODE_"|"_LR64NM_"|"_LRCPT_"|"_LRCPTNM_"|"
 . S LRI=""
 . F  S LRI=$O(LRLN(LRI)) Q:LRI=""  D
 . . S LRSTR=LRSTR_LRXX_LRI_LRYY_LRLN(LRI)
 . . D SETDATA
 Q
 ;
 ;
SETDATA ; Set data into report structure
 S LRSTR=LRSTR_LRCRLF
 S LRNODE=$O(^TMP($J,"LRDATA",""),-1)
 D ENCODE^LRSRVR4(.LRSTR)
 Q
 ;
 ;
HDR ; Set the header information
 S LRFILENM=$TR(LRSTN," ","_")_"-"_LRSUB_"-"_$P($$FMTHL7^XLFDT($$NOW^XLFDT),"-")_".TXT"
 S ^TMP($J,"LRDATA",1)="Report generated.......: "_$$FMTE^XLFDT($$NOW^XLFDT)_" at "_LRSTN
 S ^TMP($J,"LRDATA",2)="Report requested.......: "_LRSUB
 F I=3,8,10,15 S ^TMP($J,"LRDATA",I)=" "
 S ^TMP($J,"LRDATA",9)="Attached file..........: "_LRFILENM
 S ^TMP($J,"LRDATA",11)="Legend:"
 S X="Station #-NLT IEN-CPT IEN-Spec-Time Aspect|NLT Code|NLT Name|CPT Code|CPT Name|Specimen|Time Aspect|LOINC Code|LOINC Short Name|"
 S ^TMP($J,"LRDATA",12)=X
 S X="                    1                     |    2   |   3    |    4   |    5   |    6   |     7     |     8     |        9      |"
 S ^TMP($J,"LRDATA",13)=X
 S ^TMP($J,"LRDATA",14)=$$REPEAT^XLFSTR("-",$L(X))
 S ^TMP($J,"LRDATA",16)=$$UUBEGFN^LRSRVR2A(LRFILENM)
 Q
 ;
 ;
LOINC ; Retreive any LOINC codes for the NLT code
 N LR61,LRJ,LRK,LRSPECN,LRTA,LRX
 K LRLN
 ; Default LOINC
 S LRX=$G(^LAM(LR64,9))
 S LRLN="||||"
 I $P(LRX,"^") D
 . S $P(LRLN,"|",3)=$$GET1^DIQ(95.3,$P(LRX,"^")_",",.01)
 . S $P(LRLN,"|",4)=$$GET1^DIQ(95.3,$P(LRX,"^")_",",81)
 . S LRCNT(2)=LRCNT(2)+1
 I $P(LRX,"^",2) S $P(LRLN,"|",2)=$P($G(^LAB(64.061,$P(LRX,"^",2),0)),"^")
 ;
 ; Specimen specific LOINC
 S LRJ=0
 F  S LRJ=$O(^LAM(LR64,5,LRJ)) Q:'LRJ  D
 . S LR61=+$P($G(^LAM(LR64,5,LRJ,0)),"^")
 . S LRSPECN=$P($G(^LAB(61,LR61,0)),"^")
 . S LRK=0
 . F  S LRK=$O(^LAM(LR64,5,LRJ,1,LRK)) Q:'LRK  D
 . . S LRTA=$P($G(^LAM(LR64,5,LRJ,1,LRK,0)),"^")
 . . S LRLNC=$P($G(^LAM(LR64,5,LRJ,1,LRK,1)),"^")
 . . S LRLN(LRJ_"-"_LRK)=LRSPECN_"|"_$P($G(^LAB(64.061,LRTA,0)),"^")_"|"_$$GET1^DIQ(95.3,LRLNC_",",.01)_"|"_$$GET1^DIQ(95.3,LRLNC_",",81)_"|"
 . . S LRCNT(1)=LRCNT(1)+1
 ;
 Q
