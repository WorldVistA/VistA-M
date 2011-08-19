SPNPSR26 ;SAN/WDE/Next Annual Rehab Eval filter 5-19-99
 ;;2.0;Spinal Cord Dysfunction;**11**;01/02/1997
 ;
EN1(D0,BDATE,EDATE) ; *** Search entry point
 ; Next annual rehab eval due up-front filter
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING DATE") = Date ^ Date_(Ext)
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING DATE") = Date ^ Date_(Ext)
 ;      BDATE = Beginning date
 ;      EDATE = Ending date
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N DATE,MEETSRCH
 S MEETSRCH=0
 S DATE("BEG")=BDATE
 S DATE("END")=EDATE
 S SPNY=0 F  S SPNY=$O(^SPNL(154,D0,"REHAB",SPNY)) Q:(SPNY="")!('+SPNY)  D  Q:MEETSRCH=1
 . S DATE("EVAL")=$P($G(^SPNL(154,D0,"REHAB",SPNY,0)),U,3)
 . S MEETSRCH=$S(DATE("EVAL")<DATE("BEG"):0,DATE("EVAL")>DATE("END"):0,1:1) Q:MEETSRCH=1
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING DATE") = Date ^ Date_(Ext)
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING DATE") = Date ^ Date_(Ext)
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0) = $$EN1^SPNPSR26(D0,BDATE,EDATE)
 ;
 K ^TMP($J,"SPNPRT",ACTION,SEQUENCE)
 S (BDATE,EDATE)=""
 D EN1^SPNPSR00(ACTION,SEQUENCE,.BDATE,.EDATE)
 I $G(BDATE)'="" I $G(EDATE)'="" S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR26(D0,"_BDATE_","_EDATE_")"
 Q
