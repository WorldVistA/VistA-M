QACI1A ; OAKOIFO/TKW - DATA MIGRATION - AUTO-CLOSE ROCS (CONTINUED) ;10/26/06  11:23
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
 ;
DEFDATE(DATEIN) ; Return default date for auto-closing ROCs
 N MM,YY
 I '$G(DATEIN) S DATEIN=$$DT^XLFDT()
 S MM=$E(DATEIN,4,5),YY=$E(DATEIN,1,3)
 S MM=$S(MM>9:"07",MM>6:"04",MM>3:"01",1:"10")
 I MM=10 S YY=YY-1
 Q YY_MM_"01"
 ;
 ;
ENRPT2 ; Print report of auto-closed ROCs
 I $O(^XTMP("QACMIGR","AUTO","C",""))="" W !!,"No ROCs have been Auto-Closed!",!! Q
 W !!,"Ready to print report of auto-closed ROCs",!
 N PATSHDR,PATSTYPE
 S PATSTYPE="AUTO"
 S PATSHDR="AUTO-CLOSED ROCS",PATSHDR(1)="ROC Number     Date Closed    NULL Fields changed"
 N ZTSAVE S ZTSAVE("PATSTYPE")="",ZTSAVE("PATSHDR")=""
 D EN^XUTMDEVQ("DQRPT2^QACI1A","Report of "_ZTSAVE("PATSHDR"),.ZTSAVE)
 Q
 ;
DQRPT ; Report errors found while processing ROCs
 N PAGENO,LNCNT,LASTROC,ROCNO,ERRMSG,INFO,HDDATE,X,%,%H,%I
 S PAGENO=1,LNCNT=0
 D NOW^%DTC S HDDATE=$$FMTE^XLFDT(%)
 U IO D HDR
 S (LASTROC,ROCNO)=""
 F  S ROCNO=$O(^XTMP("QACMIGR",PATSTYPE,"E",ROCNO)) Q:ROCNO=""  D
 . I LASTROC'=ROCNO D
 .. D:LNCNT>53 HDR
 .. W !,ROCNO
 .. S LASTROC=ROCNO,LNCNT=LNCNT+1
 .. Q
 . F I=0:0 S I=$O(^XTMP("QACMIGR",PATSTYPE,"E",ROCNO,I)) Q:'I  S X=^(I) D
 .. S ERRMSG=$P(X,"^") S:I=1 INFO=$P(X,"^",2)
 .. D:LNCNT>54 HDR
 .. I I=1 W ?15,"Info Taker: ",INFO,! S LNCNT=LNCNT+1
 .. W ?15,ERRMSG,!
 .. S LNCNT=LNCNT+1 Q
 . Q
 D ^%ZISC Q
 ;
DQRPT2 ; Report list of auto-closed ROCs
 N PAGENO,LNCNT,ROCNO,ERRMSG,HDDATE,%,%H,%I,PATSS,X
 S PATSS="D" I PATSTYPE="AUTO" S PATSS="C"
 S PAGENO=1,LNCNT=0
 D NOW^%DTC S HDDATE=$$FMTE^XLFDT(%)
 U IO D HDR
 S ROCNO=""
 F  S ROCNO=$O(^XTMP("QACMIGR",PATSTYPE,PATSS,ROCNO)) Q:ROCNO=""  S X=^(ROCNO) D
 . D:LNCNT>54 HDR
 . W !,ROCNO
 . I PATSTYPE="AUTO" D
 .. W ?15,$P(X,"^")
 .. I $P(X,"^",2) W "   Edited By"
 .. I $P(X,"^",3) W "   Info Taken By"
 .. I $P(X,"^",4) W "   Issue Text"
 .. I $P(X,"^",5) W "   Resolution Text"
 .. I $P(X,"^",6) W "   Division"
 .. Q
 . S LNCNT=LNCNT+1
 . Q
 D ^%ZISC Q
 ;
HDR W #,!,PATSHDR,?43,HDDATE,?68,"Page "_PAGENO,!
 I $D(PATSHDR(1)) W PATSHDR(1),!
 N X S X="",$P(X,"-",78)=""
 W X,!
 S LNCNT=0,PAGENO=PAGENO+1 Q
 ;
 ;
