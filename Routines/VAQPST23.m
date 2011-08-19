VAQPST23 ;ALB/JRP - POST INIT (FILE CONVERSION);29-JUL-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
RESULTS(CORARR,DEBUG) ;CONVERT RESULTS OF REQUEST & UNSOLICITED PDXs
 ;INPUT  : CORARR - Where correlation of 1.0 request with it's
 ;                  entry in 394.61 is stored (full global reference)
 ;         DEBUG - Turns on debug mode (info written to screen)
 ;           1 - Debug on
 ;           0 - Debug off (default)
 ;OUTPUT : X - Number of requests successfully converted
 ;        -1^Error_Text - Error (nothing converted)
 ;NOTES  : CORARR will be in the format
 ;           CORARR(X,Y)=Z
 ;             X = 1.0 request number
 ;             Y = 1.5 request number
 ;             Z = 1.5 IFN
 ;
 ;CHECK INPUT
 S CORARR=$G(CORARR)
 Q:(CORARR="") "-1^Did not pass reference to correlation array"
 S DEBUG=+$G(DEBUG)
 ;DECLARE VARIABLES
 N AMBGPTR,NTFNPTR,REJPTR,CNTPTR,RSLTPTR,NTRGPTR,UNSPTR
 N COUNT,ERRCNT,PTR10,STATUS,NODE0,NODE1,TMP,TRAN10,TRAN15
 N LINE,PREPAR,BLOCK,XMER,TYPE,PTR15
 ;DETERMIN CONSTANTS
 S PREPAR="^TMP(""VAQ-CNVRT"","_$J_")"
 K @PREPAR
 S AMBGPTR=+$O(^VAT(394.3,"B",11,""))
 Q:('AMBGPTR) "-1^PDX STATUS file (#394.3) did not contain status # 11 (ambiguous)"
 S NTFNPTR=+$O(^VAT(394.3,"B",12,""))
 Q:('NTFNPTR) "-1^PDX STATUS file (#394.3) did not contain status # 12 (not found)"
 S REJPTR=+$O(^VAT(394.3,"B",13,""))
 Q:('REJPTR) "-1^PDX STATUS file (#394.3) did not contain status # 13 (rejected)"
 S CNTPTR=+$O(^VAT(394.3,"B",14,""))
 Q:('CNTPTR) "-1^PDX STATUS file (#394.3) did not contain status # 14 (contact facility)"
 S RSLTPTR=+$O(^VAT(394.3,"B",15,""))
 Q:('RSLTPTR) "-1^PDX STATUS file (#394.3) did not contain status # 15 (results)"
 S UNSPTR=+$O(^VAT(394.3,"B",16,""))
 Q:('UNSPTR) "-1^PDX STATUS file (#394.3) did not contain status # 16 (Unsolicited PDX)"
 S NTRGPTR=+$O(^VAT(394.3,"B",18,""))
 Q:('NTRGPTR) "-1^PDX STATUS file (#394.3) did not contain status # 18 (not registered)"
 W:(DEBUG) !!!!
 W:(DEBUG) !,"*********************"
 W:(DEBUG) !,"*                   *"
 W:(DEBUG) !,"*   PDX Result &    *"
 W:(DEBUG) !,"*  Unsolicited PDX  *"
 W:(DEBUG) !,"*    Conversion     *"
 W:(DEBUG) !,"*                   *"
 W:(DEBUG) !,"*********************"
 W:(DEBUG) !!,"Pointer Information"
 W:(DEBUG) !,"-------------------"
 W:(DEBUG) !,"Ambiguous Pointer: ",AMBGPTR
 W:(DEBUG) !,"Not Found Pointer: ",NTFNPTR
 W:(DEBUG) !,"Rejected Pointer: ",REJPTR
 W:(DEBUG) !,"Contact Facility Pointer: ",CNTPTR
 W:(DEBUG) !,"Results Pointer: ",RSLTPTR
 W:(DEBUG) !,"Not Registered Pointer: ",NTRGPTR
 W:(DEBUG) !,"Unsolicited PDX Pointer: ",UNSPTR
 ;FILE RESULTS
 W:(DEBUG) !!,"Converting results",!,"  Time: ",$$NOW^VAQUTL99,!
 S COUNT=0
 S ERRCNT=0
 S PTR10=0
 F  S PTR10=+$O(^VAT(394,"AD",AMBGPTR,PTR10)) Q:('PTR10)  D FILE K ^VAT(394,"AD",AMBGPTR,PTR10)
 S PTR10=0
 F  S PTR10=+$O(^VAT(394,"AD",NTFNPTR,PTR10)) Q:('PTR10)  D FILE K ^VAT(394,"AD",NTFNPTR,PTR10)
 S PTR10=0
 F  S PTR10=+$O(^VAT(394,"AD",REJPTR,PTR10)) Q:('PTR10)  D FILE K ^VAT(394,"AD",REJPTR,PTR10)
 S PTR10=0
 F  S PTR10=+$O(^VAT(394,"AD",CNTPTR,PTR10)) Q:('PTR10)  D FILE K ^VAT(394,"AD",CNTPTR,PTR10)
 S PTR10=0
 F  S PTR10=+$O(^VAT(394,"AD",RSLTPTR,PTR10)) Q:('PTR10)  D FILE K ^VAT(394,"AD",RSLTPTR,PTR10)
 S PTR10=0
 F  S PTR10=+$O(^VAT(394,"AD",NTRGPTR,PTR10)) Q:('PTR10)  D FILE K ^VAT(394,"AD",NTRGPTR,PTR10)
 ;FILE UNSOLICITED PDXS
 W:(DEBUG) !!,"Converting Unsolicited PDXs",!,"  Time: ",$$NOW^VAQUTL99,!
 S PTR10=0
 F  S PTR10=+$O(^VAT(394,"AD",UNSPTR,PTR10)) Q:('PTR10)  D FILE K ^VAT(394,"AD",UNSPTR,PTR10)
 K @PREPAR
 Q (COUNT-ERRCNT)
 ;
FILE ;FILE REQUESTS
 ;INCREMENT COUNT
 S COUNT=COUNT+1
 I (DEBUG) W:(('(COUNT#5))&(COUNT#100)) "." W:('(COUNT#100)) "#"
 ;GET INFO FROM 1.0 TRANSACTION
 I ('$D(^VAT(394,PTR10))) S ERRCNT=ERRCNT+1 Q
 S NODE0=$G(^VAT(394,PTR10,0))
 S NODE1=$G(^VAT(394,PTR10,1))
 S TRAN10=+$P(NODE0,"^",2)
 I ('TRAN10) S ERRCNT=ERRCNT+1 Q
 S STATUS=+$P(NODE0,"^",12)
 I ((STATUS'=AMBGPTR)&(STATUS'=NTFNPTR)&(STATUS'=REJPTR)&(STATUS'=CNTPTR)&(STATUS'=RSLTPTR)&(STATUS'=NTRGPTR)&(STATUS'=UNSPTR)) S ERRCNT=ERRCNT+1 Q
 ;CONVERT PARENT TRANSACTION NUMBER
 S TMP=+$P(NODE0,"^",3)
 S PARENT=+$O(@CORARR@(TMP,""))
 I (('PARENT)&(STATUS'=UNSPTR)) S ERRCNT=ERRCNT+1 Q
 S:(STATUS'=UNSPTR) $P(NODE0,"^",3)=PARENT
 ;GO TO CONTINUATION ROUTINE
 D CNVRT1^VAQPST25
 Q
