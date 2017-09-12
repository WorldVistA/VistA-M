FBXIP36 ;WOIFO/SS-PATCH INSTALL ROUTINE ;7/13/01
 ;;3.5;FEE BASIS;**36**;JAN 30, 1995
 ;File #161.2 conversion routine
 Q  ;stub
 ;/**
 ;post-install entry point
EN36 ;*/
 D KILTMP
 I $$PATCH^XPDUTL("FB*3.5*36") D BMES^XPDUTL("  Skipping Vendor file conversion since patch was previously installed.") Q
 N FBRCNT S FBRCNT=0 ;counters
 D TMPGL
 D BMES^XPDUTL("  Processing R-code: "_FBRCNT_" entries.")
 D RCODE
 D KILTMP
 Q
 ;/**
 ;kills ^TMP
KILTMP ;*/
 K ^TMP($J,"FBXIPQR")
 Q
 ;/**
 ;TMPGL
 ;Create ^TMP with all essential codes
TMPGL ;*/
 N FBIEN,FBN,FBR
 S FBR=159 ;R-code
 S FBIEN=0
 F  S FBIEN=$O(^FBAAV(FBIEN)) Q:'FBIEN  D
 . Q:$P($G(^FBAAV(FBIEN,2,0)),"^",4)<1
 . S FBN=0
 . F  S FBN=$O(^FBAAV(FBIEN,2,FBN)) Q:'FBN  D
 . . S:$G(^FBAAV(FBIEN,2,FBN,0))=FBR ^TMP($J,"FBXIPQR",FBR,FBIEN)=FBN,FBRCNT=FBRCNT+1
 Q
 ;
 ;
 ;/**
 ;RCODE
 ;For all vendors with R-code do the following:
 ;1) delete "R"-code
 ;2) if there is no "S" code for the vendor - add "S" code
 ;3) insert "RV"-code
RCODE ;*/
 N FBIEN,FBR,FBS,FBRV
 S FBR=159 ;R-code
 S FBS=162 ;S-code
 S FBRV=167 ;RV-code
 S FBIEN=0
 F  S FBIEN=$O(^TMP($J,"FBXIPQR",FBR,FBIEN)) Q:'FBIEN  D
 . D CHNGITEM(FBIEN,$G(^TMP($J,"FBXIPQR",FBR,FBIEN)),FBRV)
 . I '$O(^FBAAV(FBIEN,2,"B",FBS,0)) D INSITEM(FBIEN,FBS)
 Q
 ;
 ;/**
 ;CHNGITEM
 ;change FPDS code
CHNGITEM(FBIEN,FBN,FBCOD) ;*/
 N FBIENS,FBFDA
 S FBIENS=FBN_","_FBIEN_","
 S FBFDA(161.225,FBIENS,.01)=FBCOD
 D FILE^DIE("","FBFDA")
 Q
 ;
 ;/**
 ;INSITEM
 ;insert FPDS code
INSITEM(FBIEN,FBCOD) ;*/
 N FBSSI,FBIENS,FBFDA,FBER
 S FBIENS="+1,"_FBIEN_","
 S FBFDA(161.225,FBIENS,.01)=FBCOD
 D UPDATE^DIE("","FBFDA","FBSSI","FBER")
 I $D(FBER) D BMES^XPDUTL(FBER("DIERR",1,"TEXT",1))
 Q
 ;
 ;
