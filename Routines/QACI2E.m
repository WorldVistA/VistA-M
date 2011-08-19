QACI2E ; OAKOIFO/TKW - DATA MIGRATION - BUILD LEGACY DATA TO BE MIGRATED (CONT.) ;7/27/05  14:15
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
 ;
UPDCNT(PATSCNT) ; Update counts of data migrated on XTMP global
 F TYPE="ROC","HL","USER","PT","CC","EMPINV","FSOS" D
 . S ^XTMP("QACMIGR",TYPE,"U")=PATSCNT(TYPE)
 . Q
 Q
 ;
UPDERRCT ; Update counts of errors generated.
 N CNT,I,TYPE
 F TYPE="HL","USER","PT","CC","EMPINV","FSOS" D
 . S CNT=0
 . F I=0:0 S I=$O(^XTMP("QACMIGR",TYPE,"E",I)) Q:'I  S CNT=CNT+1
 . S ^XTMP("QACMIGR",TYPE,"E")=CNT Q
 S CNT=0,I=""
 F  S I=$O(^XTMP("QACMIGR","ROC","E",I)) Q:I=""  S CNT=CNT+1
 S ^XTMP("QACMIGR","ROC","E")=CNT
 Q
 ;
ERRPT(QACI0) ; Print all errors found during data migration
 N PATSFROM
 S PATSFROM=$S(QACI0:"Data Cleanup",1:"Move to Staging Area")
ENERRPT ; Entry point to print all error reports found during any step of data migration.
 N PATSTYPE,PATSHDR,PATSERR
 S PATSERR=0
 F PATSTYPE="HL","USER","PT","CC","EMPINV","FSOS" D  Q:PATSERR
 . I $O(^XTMP("QACMIGR",PATSTYPE,"E",0))]"" S PATSERR=1
 . Q
 I 'PATSERR W !!,"No Reference Table Errors were found",!
 E  D
 . I $G(REPRINT),'$$ASK("Ref Table") Q
 . W !!,"Printing report of Reference Table Errors",!
 . S PATSHDR=PATSFROM_" - Ref Table Data Errors"
 . N ZTSAVE S ZTSAVE("PATSHDR")=""
 . D EN^XUTMDEVQ("DQRPT^QACI2E","Report - "_PATSHDR,.ZTSAVE)
 . Q
 I $O(^XTMP("QACMIGR","ROC","E",0))="" D  Q
 . W !!,"No Report of Contact (ROC) Errors were found",!
 . Q
 I $G(REPRINT),'$$ASK("ROC") Q
 W !!,"Printing report of Report of Contact (ROC) Errors",!
 S PATSTYPE="ROC"
 S PATSHDR=PATSFROM_" - ROC Errors",PATSHDR(1)=" ROC Number    Error"
 K ZTSAVE S ZTSAVE("PATSTYPE")="",ZTSAVE("PATSHDR")=""
 D EN^XUTMDEVQ("DQRPT^QACI1A","Report - "_PATSHDR,.ZTSAVE)
 Q
 ;
ENRPT2 ; Print list of ROCs with data changed during migration
 I $O(^XTMP("QACMIGR","ROC","C",""))="" D  Q
 . I $G(^XTMP("QACMIGR","ROC","U"))!($G(^("D"))) W !!,"No ROC data was changed when data was moved to staging area!",!! Q
 . W !!,"ROC changes occur when data is moved to the staging area!"
 . Q
 W !!,"Ready to print the list of ROCs with data changed",!
 N PATSHDR
 S PATSHDR="ROCs With Data Changed for Migration",PATSHDR(1)=" ROC Number     Data Changed"
 N ZTSAVE S ZTSAVE("PATSHDR")=""
 D EN^XUTMDEVQ("DQRPT3^QACI2E","Report of ROC Data Changed for Migration",.ZTSAVE)
 Q
 ;
DQRPT ; Report errors found in reference table data
 N PAGENO,LNCNT,LASTIEN,IEN,TYPE,ERRMSG,HDDATE,%,%H,%I
 S PAGENO=1,LNCNT=0
 D NOW^%DTC S HDDATE=$$FMTE^XLFDT(%)
 U IO D HDR^QACI1A
 S (LASTIEN,IEN)=""
 F TYPE="HL","USER","PT","CC","EMPINV","FSOS" D
 . Q:$O(^XTMP("QACMIGR",TYPE,"E",0))']""
 . W !,$S(TYPE="HL":"Hospital Location",TYPE="USER":"User",TYPE="PT":"Patient",TYPE="CC":"Congressional Contact",TYPE="EMPINV":"Employee Involved",TYPE="FSOS":"Service/Discipline (Facility Service or Section)","":"*Unknown*")
 . F IEN=0:0 S IEN=$O(^XTMP("QACMIGR",TYPE,"E",IEN)) Q:'IEN  D
 .. I LASTIEN'=IEN D
 ... D:LNCNT>56 HDR^QACI1A
 ... W !,"IEN: "_IEN
 ... S LASTIEN=IEN,LNCNT=LNCNT+1
 ... Q
 .. F I=0:0 S I=$O(^XTMP("QACMIGR",TYPE,"E",IEN,I)) Q:'I  S ERRMSG=^(I) D
 ... D:LNCNT>58 HDR^QACI1A
 ... W ?20,ERRMSG,!
 ... S LNCNT=LNCNT+1 Q
 .. Q
 . Q
 D ^%ZISC Q
 ;
DQRPT3 ; Print report of ROC data changed for migration
 N PAGENO,LNCNT,ROCNO,PATSCHG,HDDATE,%,%H,%I,I
 S PAGENO=1,LNCNT=0
 D NOW^%DTC S HDDATE=$$FMTE^XLFDT(%)
 U IO D HDR^QACI1A
 S ROCNO=""
 F  S ROCNO=$O(^XTMP("QACMIGR","ROC","C",ROCNO)) Q:ROCNO=""  S PATSCHG=^(ROCNO) D
 . D:LNCNT>56 HDR^QACI1A
 . W !," "_ROCNO S I=16
 . I $P(PATSCHG,"^")=1 W ?I,"Info Taken By" S I=I+16
 . I $P(PATSCHG,"^",2)=1 W ?I,"Edited By" S I=I+16
 . I $P(PATSCHG,"^",3)=1 W ?I,"Division" S I=I+16
 . I $P(PATSCHG,"^",4)=1 W ?I,"Issue Text" S I=I+16
 . I $P(PATSCHG,"^",5)=1 W ?I,"Issue Text Overflow"
 . W ! S LNCNT=LNCNT+1
 . Q
 D ^%ZISC
 Q
 ;
ENREPRNT ; Reprint data error reports - menu entry point
 N PATSFROM,CNT,REPRINT
 S CNT=0,REPRINT=1
 F PATSTYPE="ROC","HL","USER","PT","CC","EMPINV","FSOS" D  Q:CNT
 . I $O(^XTMP("QACMIGR",PATSTYPE,"U",0))]"" S CNT=1 Q
 . I $O(^XTMP("QACMIGR",PATSTYPE,"D",0))]"" S CNT=1
 . Q
 S PATSFROM=$S(CNT=1:"Data Cleanup",1:"Move to Staging Area")
 D ENERRPT
 Q
 ;
ASK(TYPE) ; Ask whether users want to reprint error reports
 N DIR,X,Y
 S DIR("A")="Reprint the "_TYPE_" error report"
 S DIR(0)="YO",DIR("B")="YES"
 D ^DIR
 Q Y
 ;
 ;
