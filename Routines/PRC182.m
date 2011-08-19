PRC182 ;WISC/REW/Displays list of temporary transaction with no FORM TYPE
 ;;5.0;IFCAP;**182**;4/21/95
 ;
 ;
LIST ;
 S (COUNT,LOOP)=0
 S MSG="Now searching for temporary transactions with missing 'Form Type'."
 D MES^XPDUTL(MSG)
 F  S LOOP=$O(^PRCS(410,LOOP)) Q:LOOP=""  D
 . S TRAN=$G(^PRCS(410,LOOP,0))
 . I $P(TRAN,"^",3)]"",$P(TRAN,"^",4)="" D
 . . S COUNT=COUNT+1
 . . I (COUNT=1) D
 . . . S MSG="The following transaction(s) require a valid 'Form Type':"
 . . . D BMES^XPDUTL(MSG)
 . . . D MES^XPDUTL(" ")
 . . S MSG="Station "_$J($P(TRAN,"^",5),5)_", FCP "
 . . S MSG=MSG_$J($P($P($G(^PRCS(410,LOOP,3)),"^",1)," ",1),7)
 . . S MSG=MSG_", Transaction '"_$P(TRAN,"^",3)_"'"
 . . D MES^XPDUTL(MSG)
 D BMES^XPDUTL("Search complete.")
 S MSG="Total of "_COUNT
 S MSG=MSG_" temporary transactions are missing 'Form Type' entries."
 D MES^XPDUTL(MSG)
 Q
