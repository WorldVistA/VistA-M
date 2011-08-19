QACI4 ; OAKOIFO/TKW - DATA MIGRATION - VISTALINK RPC CODE ;9/28/04  11:54
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
EN(PATSBY,PATSLIST) ;
 ; Read list of migrated ROCs in PATSLIST, put into ^XTMP. Then
 ;   return the next list of ROCs to be migrated into global ^TMP.
 ;   NOTE: This routine is always called after QACI3, so there is
 ;   no need to check the 'ready to migrate' flag.
 ; PATSBY = the name of the output global
 ; PATSLIST = If defined, contains a list of ROC numbers
 ;     for ROCs that have been successfully migrated to PATS.
 ;
 ; Process incoming list. Move list of migrated ROCs into
 ; ^XTMP("QACMIGR","ROC","D"), remove them from the list of ROCs
 ; to be migrated ^XTMP("QACMIGR","ROC","U").
 D LISTIN
 ; Now return the next set of ROCs to be migrated.
 S PATSBY=$NA(^TMP("ROC",$J))
 D LISTOUT
 Q
 ;
LISTIN ;
 N I,ROCNO,CNT S I="",CNT=0
 F  S I=$O(PATSLIST(I)) Q:I=""  S ROCNO=PATSLIST(I) I ROCNO]"" D
 . K ^XTMP("QACMIGR","ROC","U",ROCNO_" ")
 . S ^XTMP("QACMIGR","ROC","D",ROCNO)=""
 . S CNT=CNT+1
 . Q
 I CNT>0 D
 . S ^XTMP("QACMIGR","ROC","D")=$G(^XTMP("QACMIGR","ROC","D"))+CNT
 . I $O(^XTMP("QACMIGR","ROC","U",0))="" K ^XTMP("QACMIGR","ROC","U") Q
 . S ^XTMP("QACMIGR","ROC","U")=$G(^XTMP("QACMIGR","ROC","U"))-CNT
 . Q
 Q
 ;
LISTOUT ;
 K ^TMP("ROC",$J)
 ; The output array will be empty if there is no data to migrate
 Q:$O(^XTMP("QACMIGR","ROC","U",0))=""
 ; The 0 node should contain VISN name and Station Numbers
 ;  if not, return the output array empty.
 N X S X=$G(^XTMP("QACMIGR","ROC","U",0))
 Q:X=""
 S ^TMP("ROC",$J,1)=X
 N ROCNO,I,CNT S CNT=1,ROCNO=0
 F  S ROCNO=$O(^XTMP("QACMIGR","ROC","U",ROCNO)) Q:ROCNO=""!(CNT>1500)  D
 . S I=$O(^XTMP("QACMIGR","ROC","U",ROCNO,"A"),-1)
 . I (I+CNT)>1500 S CNT=9999 Q
 . F I=0:0 S I=$O(^XTMP("QACMIGR","ROC","U",ROCNO,I)) Q:'I  S X=^(I) D
 .. S CNT=CNT+1
 .. S ^TMP("ROC",$J,CNT)=X Q
 . Q
 Q
 ;
