BPS10P8 ;ALB/SS - BPS*1*8 POST INSTALL ROUTINE ;6/9/08  11:02
 ;;1.0;E CLAIMS MGMT ENGINE;**8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
POST ; post install for BPS*1*8
 ;
 N BPRECIEN,BPFLDEF,BPX,BPSCNT,BPSOK,BPNCPDFL,GETCODE,FORMATCD,SETCODE,MC,ERRMSG,FKI,FKV
 D MES^XPDUTL("  Starting post-install of BPS*1*8")
 D MES^XPDUTL(" ")
 S BPSCNT=0
 F BPX=1:1 S BPFLDEF=$P($T(FIELDS+BPX),";;",2,99) Q:BPFLDEF=""  D
 . S BPNCPDFL=$P(BPFLDEF,";",1)   ; ncpdp field#
 . S BPRECIEN=+$O(^BPSF(9002313.91,"B",BPNCPDFL,0))   ; ien to file# 9002313.91
 . I BPRECIEN=0 D MES^XPDUTL("    error: can't find entry for the NCPDP field # "_BPNCPDFL_" in the file #9002313.91") Q
 . ;
 . D MES^XPDUTL("  updating data for the NCPDP field# "_BPNCPDFL_"...")
 . S BPSOK=0
 . ;
 . S GETCODE=$P(BPFLDEF,";",2)
 . I GETCODE="" S GETCODE=";GET code for this COB field is executed in COB^BPSOSHF"
 . K MC,ERRMSG S MC(1,0)=GETCODE
 . D WP^DIE(9002313.91,BPRECIEN_",",10,"","MC","ERRMSG")
 . I $D(ERRMSG) D  Q
 .. D MES^XPDUTL("FileMan reported a problem with the GET CODE for field# "_BPNCPDFL_":")
 .. S (FKI,FKV)="ERRMSG"
 .. F  S FKI=$Q(@FKI) Q:FKI'[FKV  D MES^XPDUTL("   "_FKI_" = "_$G(@FKI))
 .. D MES^XPDUTL("  ")
 .. Q
 . S BPSOK=BPSOK+1
 . ;
 . S FORMATCD=$P(BPFLDEF,";",3)    ; FORMAT code
 . I FORMATCD]"" D
 .. K MC,ERRMSG S MC(1,0)=FORMATCD
 .. D WP^DIE(9002313.91,BPRECIEN_",",40,"","MC","ERRMSG")
 .. I $D(ERRMSG) D  Q
 ... D MES^XPDUTL("FileMan reported a problem with the FORMAT CODE for field# "_BPNCPDFL_":")
 ... S (FKI,FKV)="ERRMSG"
 ... F  S FKI=$Q(@FKI) Q:FKI'[FKV  D MES^XPDUTL("   "_FKI_" = "_$G(@FKI))
 ... D MES^XPDUTL("  ")
 ... Q
 . S BPSOK=BPSOK+1
 . ;
 . S SETCODE=$P(BPFLDEF,";",4)    ; SET code
 . I SETCODE]"" D
 .. K MC,ERRMSG S MC(1,0)=SETCODE
 .. D WP^DIE(9002313.91,BPRECIEN_",",30,"","MC","ERRMSG")
 .. I $D(ERRMSG) D  Q
 ... D MES^XPDUTL("FileMan reported a problem with the SET CODE for field# "_BPNCPDFL_":")
 ... S (FKI,FKV)="ERRMSG"
 ... F  S FKI=$Q(@FKI) Q:FKI'[FKV  D MES^XPDUTL("   "_FKI_" = "_$G(@FKI))
 ... D MES^XPDUTL("  ")
 ... Q
 . S BPSOK=BPSOK+1
 . ;
 . I BPSOK=3 S BPSCNT=BPSCNT+1
 . Q
 ;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("  "_BPSCNT_" entries have been updated successfully.")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 ;
 Q
 ;
 ;
FIELDS ; NCPDP field;GET code;FORMAT code;SET code
 ;;337;;S BPS("X")=$$NFF^BPSECFM($G(BPS("X")),1);D SET337^BPSFLD01
 ;;338;;S BPS("X")=$$ANFF^BPSECFM($G(BPS("X")),2);D SET338^BPSFLD01
 ;;339;;S BPS("X")=$$ANFF^BPSECFM($G(BPS("X")),2);D SET339^BPSFLD01
 ;;340;;S BPS("X")=$$ANFF^BPSECFM($G(BPS("X")),10);D SET340^BPSFLD01
 ;;341;;S BPS("X")=$$NFF^BPSECFM($G(BPS("X")),1);D SET341^BPSFLD01
 ;;342;;S BPS("X")=$$ANFF^BPSECFM($G(BPS("X")),2);D SET342^BPSFLD01
 ;;431;;S BPS("X")=$$DFF^BPSECFM($G(BPS("X")),8);D SET431^BPSFLD01
 ;;443;;S BPS("X")=$$DTF1^BPSECFM($G(BPS("X")));D SET443^BPSFLD01
 ;;471;;S BPS("X")=$$NFF^BPSECFM($G(BPS("X")),2);D SET471^BPSFLD01
 ;;472;;S BPS("X")=$$ANFF^BPSECFM($G(BPS("X")),3);D SET472^BPSFLD01
 ;;412;S BPS("X")=0;;
 ;;477;S BPS("X")=0;S BPS("X")=$$DFF^BPSECFM($G(BPS("X")),8);
 ;;481;S BPS("X")=0;;
 ;;483;S BPS("X")=+BPS("Insurer","Percent Sales Tax Rate Sub");;
 ;
 ;
