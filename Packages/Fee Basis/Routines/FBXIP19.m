FBXIP19 ;WCIOFO/SAB-PATCH INSTALL ROUTINE ;10/25/2000
 ;;3.5;FEE BASIS;**19**;JAN 30, 1995
 ; This routine invokes IA #3228
 Q
 ;
PR ; pre-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="DXREF" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP19")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
PS ; post-install entry point
 ;
 ; only perform during 1st install
 I $$PATCH^XPDUTL("FB*3.5*19") D BMES^XPDUTL("  Skipping post install since patch was previously installed.") Q
 ;
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="MERGED" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP19")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
DXREF ; Delete cross-references (Pre Install)
 ;
 ; Delete trigger x-ref because new logic has fewer nodes in DD
 D DELIX^DDMOD(162.11,.01,2) ; trigger x-ref
 ;
 ; This section deletes existing traditional style cross reference logic
 ; whose functionality is being replaced by new style cross references
 ; included in this patch.
 D DELIX^DDMOD(162.11,7,1) ; AG x-ref
 D DELIX^DDMOD(162.11,13,2) ; AJ x-ref
 D DELIX^DDMOD(162.11,13,3) ; AK x-ref
 D DELIX^DDMOD(162.11,15,1) ; AA x-ref
 D DELIX^DDMOD(162.2,14,1) ; AI x-ref
 D DELIX^DDMOD(162.3,3,1) ; AD x-ref
 D DELIX^DDMOD(162.5,1,1) ; AI1 x-ref
 D DELIX^DDMOD(162.5,10,1) ; AI x-ref
 D DELIX^DDMOD(162.5,5,1) ; AA x-ref
 D DELIX^DDMOD(162.5,20,2) ; AE x-ref
 Q
 ;
MERGED ; Check previously merged patients and fix FEE as needed (post install)
 N FBAUTCHG,FBDA,FBFR,FBTO,FBX
 K ^TMP($J)
 ; loop through MERGE IMAGES file (IA #3228)
 S FBDA=0 F  S FBDA=$O(^XDRM(FBDA)) Q:'FBDA  D
 . S FBX=$G(^XDRM(FBDA,0))
 . Q:$P($P(FBX,U),";",2)'="DPT("  ; from is not PATIENT file
 . Q:$P($P(FBX,U,2),";",2)'="DPT("  ; to is not PATIENT file
 . S FBFR=$P($P(FBX,U),";") ; From IEN of patient
 . S FBTO=$P($P(FBX,U,2),";") ; To IEN of patient
 . ;
 . D LOADBI^FBXIP19A(1) ; load FEE before images for FBFR into ^TMP
 . D LOADBI^FBXIP19A(2) ; load FEE before images for FBTO into ^TMP
 . ;
 . ; process FEE BASIS PATIENT file authorization multiple (161.01)
 . D FB16101^FBXIP19A
 . ;I $D(FBAUTCHG) W ! ZW FBAUTCHG
 . ;
 . ; process FEE BASIS PAYMENT file service provided multiple (162.03)
 . D FB16203^FBXIP19A
 . ;
 . ; process FEE BASIS PAYMENT file travel payment multiple (162.04)
 . D FB16204^FBXIP19A
 . ;
 . ; process changed pointers
 . D PCHG
 . ;
 ; report any problems via mail message
 I $D(^TMP($J,"PROB")) D
 . N DIFROM,FBFILE,FBFR,FBIENS,FBL,FBTO,FBTXT,XMDUZ,XMSUB,XMTEXT,XMY
 . ; build message text
 . S ^TMP($J,"MSG",1)="The patch FB*3.5*19 post install was not able to automatically"
 . S ^TMP($J,"MSG",2)="process some of the previously merged fee data."
 . S ^TMP($J,"MSG",3)="This mail message has been sent to a developer for review."
 . S FBL=3 ; last line used for message text
 . ;loop thru problems and load appropriate text into message
 . S FBFR=0 F  S FBFR=$O(^TMP($J,"PROB",FBFR)) Q:'FBFR  D
 . . S FBTO=$P($G(^TMP($J,"PROB",FBFR)),U)
 . . S FBL=FBL+1 S ^TMP($J,"MSG",FBL)=" "
 . . S FBL=FBL+1 S ^TMP($J,"MSG",FBL)="ISSUES FOR PATIENT MERGED FROM "_FBFR_" INTO "_FBTO
 . . S FBFILE=""
 . . F  S FBFILE=$O(^TMP($J,"PROB",FBFR,FBFILE)) Q:FBFILE=""  D
 . . . S FBIENS=""
 . . . F  S FBIENS=$O(^TMP($J,"PROB",FBFR,FBFILE,FBIENS)) Q:FBIENS=""  D
 . . . . S FBTXT=$G(^TMP($J,"PROB",FBFR,FBFILE,FBIENS))
 . . . . S FBL=FBL+1,^TMP($J,"MSG",FBL)="  FILE: "_FBFILE_"  IENS: "_FBIENS
 . . . . S FBL=FBL+1,^TMP($J,"MSG",FBL)="    "_FBTXT
 . S XMSUB="POST INSTALL FB*3.5*19"
 . S XMDUZ=.5
 . S XMTEXT="^TMP($J,""MSG"","
 . S XMY("BAUMANN,SCOTT@DOMAIN.EXT")="",XMY(DUZ)=""
 . D ^XMD
 ;
 ; cleanup
 K ^TMP($J)
 Q
 ;
PCHG ; Process Pointers Changed multiple in MERGE IMAGES file
 ; before this patch, nine x-refs depended on the patient but were
 ; not updated if the patient pointer was changed.
 ; check/update those x-refs for patients merged prior to this patch
 ; also update 'free-text' authorization pointers when necessary
 ; input
 ;   FBDA - entry in MERGE IMAGES file
 ;   FBAUTCHG(old ien,new ien) - array of changed authorization iens
 ; output
 ;   update cross-reference values in various FEE files
 ;   update 'free-text' authorization pointers in various FEE files
 ;
 N FBDA1,FBFILE,FBFLD,FBIENS,FBOVAL,FBPC
 ;
 ; loop thru "B" x-ref of POINTERS CHANGED multiple in MERGE IMAGES
 S FBPC="161 "
 F  S FBPC=$O(^XDRM(FBDA,3,"B",FBPC)) Q:FBPC=""!(FBPC]"164 ")  D
 . S FBDA1=0 F  S FBDA1=$O(^XDRM(FBDA,3,"B",FBPC,FBDA1)) Q:'FBDA1  D
 . . S FBFILE=$P($P(FBPC,U),";")
 . . S FBIENS=$P($P(FBPC,U),";",2)
 . . S FBFLD=$P($P(FBPC,U),";",3)
 . . S FBOVAL=$P($G(^XDRM(FBDA,3,FBDA1,1)),U)
 . . Q:FBOVAL=""
 . . ;W !,"POINTER CHANGED for FILE: "_FBFILE_"  FIELD: "_FBFLD_"  OLD VAL "_FBOVAL_"  IENS: "_FBIENS
 . . ;Q  ; *** temp quit for testing
 . . I FBFILE=161.26,FBFLD=.01 D F16126
 . . I FBFILE=162.11,FBFLD=4 D F16211
 . . I FBFILE=162.2,FBFLD=3 D F1622
 . . I FBFILE=162.3,FBFLD=1 D F1623
 . . I FBFILE=162.5,FBFLD=3 D F1625
 . . I FBFILE=162.7,FBFLD=2 D F1627
 Q
 ;
F16126 ; file 161.26 field .01 check/fix 'free-text' pointer
 N DA,DIE,DR,FBFTPC,FBFTPN,FBY
 D DA^DILF(FBIENS,.DA)
 Q:'DA
 S FBY=$G(^FBAA(161.26,DA,0))
 ;
 ; update 'free-text' authorization pointer if it changed
 S FBFTPC=$P(FBY,U,3) ; current
 S FBFTPN=$S(FBFTPC:$O(FBAUTCHG(FBFTPC,0)),1:"") ; new (if different)
 I FBFTPN,FBFTPN'=FBFTPC D
 . S DIE="^FBAA(161.26,"
 . S DR="2////^S X=FBFTPN"
 . D ^DIE
 Q
 ;
F16211 ; file 162.11 field 4 check/fix x-refs & 'free-text' pointer
 N DA,DIE,DIK,DR,FBFTPC,FBFTPN,FBRXY,FBY
 D DA^DILF(FBIENS,.DA)
 Q:'DA(1)
 Q:'DA
 S FBY=$G(^FBAA(162.1,DA(1),0))
 S FBRXY=$G(^FBAA(162.1,DA(1),"RX",DA,0))
 ;
 ; delete "AG" x-ref for old value
 I $P(FBY,U,4)]"",$P(FBY,U,8)]"",$P(FBRXY,U,8)]"" K ^FBAA(162.1,"AG",$P(FBY,U,4),$P(FBY,U,8),FBOVAL,$P(FBRXY,U,8),DA(1),DA)
 ; delete "AJ" x-ref for old value
 I $P(FBRXY,U,17)]"" K ^FBAA(162.1,"AJ",$P(FBRXY,U,17),FBOVAL,DA(1),DA)
 ; delete "AK" x-ref for old value
 I $P(FBY,U,4)]"",$P(FBRXY,U,3)]"" K ^FBAA(162.1,"AK",$P(FBY,U,4),9999999-$P(FBRXY,U,3),FBOVAL,DA(1),DA)
 ; delete "AA" x-ref for old value
 I $P(FBRXY,U,19)]"" K ^FBAA(162.1,"AA",$P(FBRXY,U,19),FBOVAL,DA(1),DA)
 ; re-index "AG","AJ","AK","AA" x-refs for entry
 S DIK="^FBAA(162.1,"_DA(1)_",""RX"","
 S DIK(1)="4^AA^AG^AJ^AK"
 D EN1^DIK
 ;
 ; update 'free-text' authorization pointer if it changed
 S FBFTPC=$P($G(^FBAA(162.1,DA(1),"RX",DA,2)),U,7) ; current
 S FBFTPN=$S(FBFTPC:$O(FBAUTCHG(FBFTPC,0)),1:"") ; new (if different)
 I FBFTPN,FBFTPN'=FBFTPC D
 . S DIE="^FBAA(162.1,"_DA(1)_",""RX"","
 . S DR="27////^S X=FBFTPN"
 . D ^DIE
 Q
 ;
F1622 ; file 162.2 field 3 check/fix x-ref
 N DA,DIK,FBY
 D DA^DILF(FBIENS,.DA)
 Q:'DA
 S FBY=$G(^FBAA(162.2,DA,0))
 ;
 ; delete "AI" x-ref for old value
 I $P(FBY,U,2)]"",$P(FBY,U,13)]"",$P(FBY,U,16)]"" K ^FBAA(162.2,"AI",$P(FBY,U,2),$P(FBY,U,13),FBOVAL,$P(FBY,U,16),DA)
 ; re-index "AI" x-ref for entry
 S DIK="^FBAA(162.2,"
 S DIK(1)="3^AI"
 D EN1^DIK
 Q
 ;
F1623 ; file 162.3 field 1 check/fix x-ref and 'free-text' pointer
 N DA,DIE,DIK,DR,FBFTPC,FBFTPN,FBY
 D DA^DILF(FBIENS,.DA)
 Q:'DA
 S FBY=$G(^FBAACNH(DA,0))
 ;
 ; delete "AD" x-ref for old value
 I $P(FBY,U,4)]"" K ^FBAACNH("AD",FBOVAL,DA)
 ; re-index "AD" x-ref for entry
 S DIK="^FBAACNH("
 S DIK(1)="1^AD"
 D EN1^DIK
 ;
 ; update 'free-text' authorization pointer if it changed
 S FBFTPC=$P(FBY,U,10) ; current
 S FBFTPN=$S(FBFTPC:$O(FBAUTCHG(FBFTPC,0)),1:"") ; new (if different)
 I FBFTPN,FBFTPN'=FBFTPC D
 . S DIE="^FBAACNH("
 . S DR="9////^S X=FBFTPN"
 . D ^DIE
 Q
 ;
F1625 ; file 162.5 field 3 check/fix x-refs
 N DA,DIK,FBY
 D DA^DILF(FBIENS,.DA)
 Q:'DA
 S FBY=$G(^FBAAI(DA,0))
 ;
 ; delete "AI" x-ref for old value
 I $P(FBY,U,3)]"",$P(FBY,U,2)]"",$P(FBY,U,11)]"" K ^FBAAI("AI",$P(FBY,U,3),$P(FBY,U,2),FBOVAL,$P(FBY,U,11),DA)
 ; delete "AA" x-ref for old value
 I $P(FBY,U,3)]"",$P(FBY,U,6)]"" K ^FBAAI("AA",$P(FBY,U,3),FBOVAL,$E($P($P(FBY,U,6),"."),1,5),DA)
 ; delete "AE" x-ref for old value
 I $P(FBY,U,17)]"" K ^FBAAI("AE",$P(FBY,U,17),FBOVAL,DA)
 ; re-index "AI","AA","AE" x-refs for entry
 S DIK="^FBAAI("
 S DIK(1)="3^AI^AA^AE"
 D EN1^DIK K DIK
 Q
 ;
F1627 ; file 162.7 field 2 check/fix 'free-text' pointer
 N DA,DIE,DR,FBFTPC,FBFTPN,FBY
 D DA^DILF(FBIENS,.DA)
 Q:'DA
 S FBY=$G(^FB583(DA,0))
 ;
 ; update 'free-text' authorization pointer if it changed
 S FBFTPC=$P(FBY,U,27) ; current
 S FBFTPN=$S(FBFTPC:$O(FBAUTCHG(FBFTPC,0)),1:"") ; new (if different)
 I FBFTPN,FBFTPN'=FBFTPC D
 . S DIE="^FB583("
 . S DR="30////^S X=FBFTPN"
 . D ^DIE
 Q
 ;
 ;FBXIP19
