FBXI165A ;OI&T/LKG - POST-INIT CONVERSION FB*3.5*165 ;11/17/15  17:07
 ;;3.5;FEE BASIS;**165**;JAN 30, 1995;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 W !,"This FB*3.5*165 conversion routine should not be called directly." Q
 ;
 ; ICRs
 ;  #2053    FILE^DIE
 ;  #2054    CLEAN^DILF
 ;  #10141   BMES^XPDUTL, MES^XPDUTL
 ;
IN ;Entry point for removing payment lines with populated DATE PAID
 ; or CANCELLATION DATE from in process but not yet transmitted batches
 D BMES^XPDUTL("    Removing paid or payment cancelled payment lines from")
 D MES^XPDUTL("        not yet transmitted batches.")
 N FBCANDT,FBCHANGE,FBH,FBLCNT,FBPAID,FBSTATUS,FBTOTAL,FBTYPE
 N FBB2L,FBB3L,FBB5L,FBB9L,FBBCTR S (FBB2L,FBB3L,FBB5L,FBB9L)=0
 S FBH=0
 F  S FBH=$O(^FBAA(161.7,FBH)) Q:+FBH'=FBH  S FBSTATUS=$P($G(^FBAA(161.7,FBH,"ST")),U) I "^T^F^V^"'[("^"_FBSTATUS_"^") D
 . S FBTYPE=$P($G(^FBAA(161.7,FBH,0)),U,3) Q:"^B2^B3^B5^B9^"'[("^"_FBTYPE_"^")
 . S FBCHANGE=0
 . I FBTYPE="B3" D
 . . N FBCHK,FBI,FBJ,FBK,FBL S (FBI,FBJ,FBK,FBL)=0
 . . F  S FBI=$O(^FBAAC("AC",FBH,FBI)) Q:'FBI  F  S FBJ=$O(^FBAAC("AC",FBH,FBI,FBJ)) Q:'FBJ  F  S FBK=$O(^FBAAC("AC",FBH,FBI,FBJ,FBK)) Q:'FBK  F  S FBL=$O(^FBAAC("AC",FBH,FBI,FBJ,FBK,FBL)) Q:'FBL  D
 . . . S FBPAID=$P($P($G(^FBAAC(FBI,1,FBJ,1,FBK,1,FBL,0)),U,14),".")
 . . . S FBCANDT=$P($P($G(^FBAAC(FBI,1,FBJ,1,FBK,1,FBL,2)),U,4),"."),FBCHK=$P($G(^(2)),U,3)
 . . . Q:FBPAID=""&(FBCANDT="")
 . . . I FBCANDT="",FBPAID<3110107,FBCHK="" Q
 . . . Q:FBPAID>3130306  Q:FBCANDT>3130306
 . . . S FBCHANGE=1,FBB3L=FBB3L+1
 . . . N FBARR,FBIENS,FBDATE,FBERR S FBIENS=FBL_","_FBK_","_FBJ_","_FBI_","
 . . . S ^XTMP("FB*3.5*165","RMVPAY",162.03,FBH,FBIENS)="7^5:"_$P($G(^FBAAC(FBI,1,FBJ,1,FBK,1,FBL,0)),U,6)
 . . . S FBDATE=$S(FBCANDT>FBPAID:FBCANDT,1:FBPAID)
 . . . S FBARR(162.03,FBIENS,7)="@",FBARR(162.03,FBIENS,5)=FBDATE
 . . . D FILE^DIE("K","FBARR","FBERR")
 . . . D:$D(FBERR) MES^XPDUTL("    Error updating file 162.03 record with IENS "_FBIENS)
 . I FBTYPE="B9" D
 . . N FBI S FBI=0
 . . F  S FBI=$O(^FBAAI("AC",FBH,FBI)) Q:'FBI  D
 . . . S FBPAID=$P($P($G(^FBAAI(FBI,2)),U),"."),FBCANDT=$P($P($G(^(2)),U,5),".")
 . . . Q:FBPAID=""&(FBCANDT="")
 . . . Q:FBPAID>3130306  Q:FBCANDT>3130306
 . . . S FBCHANGE=1,FBB9L=FBB9L+1
 . . . N FBARR,FBIENS,FBDATE,FBERR S FBIENS=FBI_","
 . . . S ^XTMP("FB*3.5*165","RMVPAY",162.5,FBH,FBIENS)="20^19:"_$P($G(^FBAAI(FBI,0)),U,16)
 . . . S FBDATE=$S(FBCANDT>FBPAID:FBCANDT,1:FBPAID)
 . . . S FBARR(162.5,FBIENS,20)="@",FBARR(162.5,FBIENS,19)=FBDATE
 . . . D FILE^DIE("K","FBARR","FBERR")
 . . . D:$D(FBERR) MES^XPDUTL("    Error updating file 162.5 record with IENS "_FBIENS)
 . I FBTYPE="B2" D
 . . N FBI,FBJ S (FBI,FBJ)=0
 . . F  S FBI=$O(^FBAAC("AD",FBH,FBI)) Q:'FBI  F  S FBJ=$O(^FBAAC("AD",FBH,FBI,FBJ)) Q:'FBJ  D
 . . . S FBPAID=$P($P($G(^FBAAC(FBI,3,FBJ,0)),U,6),".")
 . . . S FBCANDT=$P($P($G(^FBAAC(FBI,3,FBJ,0)),U,8),".")
 . . . Q:FBPAID=""&(FBCANDT="")
 . . . Q:FBPAID>3130306  Q:FBCANDT>3130306
 . . . S FBCHANGE=1,FBB2L=FBB2L+1
 . . . N FBARR,FBIENS,FBERR S FBIENS=FBJ_","_FBI_","
 . . . S ^XTMP("FB*3.5*165","RMVPAY",162.04,FBH,FBIENS)="1"
 . . . S FBARR(162.04,FBIENS,1)="@"
 . . . D FILE^DIE("K","FBARR","FBERR")
 . . . D:$D(FBERR) MES^XPDUTL("    Error updating file 162.04 record with IENS "_FBIENS)
 . I FBTYPE="B5" D
 . . N FBI,FBJ S (FBI,FBJ)=0
 . . F  S FBI=$O(^FBAA(162.1,"AE",FBH,FBI)) Q:'FBI  F  S FBJ=$O(^FBAA(162.1,"AE",FBH,FBI,FBJ)) Q:'FBJ  D
 . . . S FBPAID=$P($P($G(^FBAA(162.1,FBI,"RX",FBJ,2)),U,8),".")
 . . . S FBCANDT=$P($P($G(^FBAA(162.1,FBI,"RX",FBJ,2)),U,11),".")
 . . . Q:FBPAID=""&(FBCANDT="")
 . . . Q:FBPAID>3130306  Q:FBCANDT>3130306
 . . . S FBCHANGE=1,FBB5L=FBB5L+1
 . . . N FBARR,FBIENS,FBERR S FBIENS=FBJ_","_FBI_","
 . . . S ^XTMP("FB*3.5*165","RMVPAY",162.11,FBH,FBIENS)="13"
 . . . S FBARR(162.11,FBIENS,13)="@"
 . . . D FILE^DIE("K","FBARR","FBERR")
 . . . D:$D(FBERR) MES^XPDUTL("    Error updating file 162.11 record with IENS "_FBIENS)
 . I FBCHANGE D
 . . S:FBSTATUS="" FBSTATUS="NULL" S FBBCTR(FBSTATUS)=$G(FBBCTR(FBSTATUS))+1
 . . D CNTTOT^FBAARB(FBH)
 . . N FBARR,FBIENS,FBERR S FBIENS=FBH_","
 . . S FBARR(161.7,FBIENS,8)=FBTOTAL,FBARR(161.7,FBIENS,10)=FBLCNT
 . . I FBTYPE="B9" S FBARR(161.7,FBIENS,9)=FBLCNT
 . . I FBTYPE="B5" D
 . . . N FBMCNT,FBM S FBMCNT=0,FBM=""
 . . . F  S FBM=$O(^FBAA(162.1,"AE",FBH,FBM)) Q:FBM=""  S FBMCNT=FBMCNT+1
 . . . S FBARR(161.7,FBIENS,9)=FBMCNT
 . . D FILE^DIE("K","FBARR","FBERR")
 . . D:$D(FBERR) MES^XPDUTL("    Error updating batch file 161.7 entry with IENS "_FBIENS)
 ;Output statistics
 D BMES^XPDUTL("*** Statistics For Removing Payments From Batches ***")
 N FBCNT S FBCNT=0
 S FBSTATUS=""
 F  S FBSTATUS=$O(FBBCTR(FBSTATUS)) Q:FBSTATUS=""  D
 . S FBH="Batches of Status '"_FBSTATUS_"' Updated: "_FBBCTR(FBSTATUS)
 . D MES^XPDUTL(FBH)
 . S FBCNT=FBCNT+FBBCTR(FBSTATUS)
 D BMES^XPDUTL("Total Number of Batches Updated: "_FBCNT)
 S FBH="B2 Batch Payment Lines Edited: "_FBB2L D BMES^XPDUTL(FBH)
 S FBH="B3 Batch Payment Lines Edited: "_FBB3L D MES^XPDUTL(FBH)
 S FBH="B5 Batch Payment Lines Edited: "_FBB5L D MES^XPDUTL(FBH)
 S FBH="B9 Batch Payment Lines Edited: "_FBB9L D MES^XPDUTL(FBH)
 D BMES^XPDUTL("Total Number of Payment Lines Edited: "_(FBB2L+FBB3L+FBB5L+FBB9L))
 D CLEAN^DILF
 Q
 ;
 ;FBXI165A
