FBXIP39 ;WOIFO/SS-PATCH INSTALL ROUTINE ;7/13/01
 ;;3.5;FEE BASIS;**39**;JAN 30, 1995
 ;File #161.2 conversion routine
 Q  ;stub
 ;/**
 ;post-install entry point
EN39 ;*/
 D KILTMP
 I $$PATCH^XPDUTL("FB*3.5*39") D BMES^XPDUTL("  Skipping Vendor file conversion since patch was previously installed.") Q
 N FBQCNT,FBRVCNT,FBCNT S (FBQCNT,FBRVCNT,FBCNT)=0 ;counters
 D TMPGL
 D BMES^XPDUTL("  Processing Q-code: "_FBQCNT_" entries.")
 D QCODE
 D BMES^XPDUTL("  Processing RV-code: "_FBRVCNT_" entries.")
 D RVCODE
 D BMES^XPDUTL("  Marked to be sent to Austin for update: "_FBCNT_" entries.")
 D NMARKED
 D KILTMP
 Q
 ;/**
 ;kills ^TMP
KILTMP ;*/
 K ^TMP($J,"FBXIPQR")
 K ^TMP($J,"FBXIP39")
 Q
 ;/**
 ;TMPGL
 ;Create ^TMP with all essential codes
TMPGL ;*/
 N FBIEN,FBN,FBQ,FBRV,FBFPDS
 S FBQ=158 ;Q-code
 S FBRV=167 ;RV-code
 S FBIEN=0
 F  S FBIEN=$O(^FBAAV(FBIEN)) Q:'FBIEN  D
 . Q:$P($G(^FBAAV(FBIEN,2,0)),"^",4)<1
 . S FBN=0
 . F  S FBN=$O(^FBAAV(FBIEN,2,FBN)) Q:'FBN  D
 . . S FBFPDS=$G(^FBAAV(FBIEN,2,FBN,0))
 . . I FBFPDS=FBRV S ^TMP($J,"FBXIPQR",FBFPDS,FBIEN)=FBN,FBRVCNT=FBRVCNT+1 Q
 . . I FBFPDS=FBQ S ^TMP($J,"FBXIPQR",FBFPDS,FBIEN)=FBN,FBQCNT=FBQCNT+1 Q
 Q
 ;
 ;
 ;/**
 ;QCODE
 ;For all vendors with Q-code do the following:
 ;1) add to correction file to inform Austin about changes
 ;2) delete "Q"- code
 ;3) if there is no "S" code for the vendor - add "S" code
 ;   but only if it is SMALL BUSINESS type
QCODE ;*/
 N FBIEN,FBQ,FBS
 S FBQ=158 ;Q-code
 S FBS=162 ;S-code
 S FBIEN=0
 F  S FBIEN=$O(^TMP($J,"FBXIPQR",FBQ,FBIEN)) Q:'FBIEN  D
 . D ADDCORR(FBIEN) ;add to correction file
 . D CHNGITEM(FBIEN,$G(^TMP($J,"FBXIPQR",FBQ,FBIEN)),"@")
 . ;if business type (fpds) null or not Small Business
 . I $P($G(^FBAAV(FBIEN,1)),"^",10)'=1 Q
 . I $O(^FBAAV(FBIEN,2,"B",FBS,0))'="" Q
 . D INSITEM(FBIEN,FBS)
 Q
 ;
 ;/**
 ;RVCODE
 ;For all vendors with RV-code do the following:
 ;1) add to correction file to inform Austin
RVCODE ;*/
 N FBIEN,FBRV
 S FBRV=167 ;RV-code
 S FBIEN=0
 F  S FBIEN=$O(^TMP($J,"FBXIPQR",FBRV,FBIEN)) Q:'FBIEN  D
 . D ADDCORR(FBIEN) ;add to correction file
 Q
 ;
 ;/**
 ;ADDCORR
 ;Add vendors with changes to correction file (#161.25)
 ;
ADDCORR(FBIEN) ;*/
 ;if business type (fpds) null
 I $P($G(^FBAAV(FBIEN,1)),"^",10)="" Q
 ;
 ;if Austin deleted
 I $P($G(^FBAAV(FBIEN,"ADEL")),"^")="Y" Q
 ;
 ;if linked to another vendor
 N FBDA1 S FBDA1=$O(^FBAA(161.25,"AF",FBIEN,0))
 I FBDA1]"",FBDA1'=FBIEN Q  ;linked to another vendor
 ;
 ;if vendor already in 161.25
 I $D(^FBAA(161.25,FBIEN)) D  Q
 . ;
 . ;not place the  entry - previous change was not transmitted yet, 
 . ;will be transmitted with new fpds
 . I $P($G(^FBAA(161.25,FBIEN,0)),"^",5)="" S FBCNT=$$FBCNTINC() Q
 . ;
 . ;save it for a list of non-processed
 . ;vendors. Previous change was transmitted to 
 . ;Austin but there is no reply for the change from Austin yet, 
 . ;so at the moment we cannot perform new transmission to Austin
 . S ^TMP($J,"FBXIP39",FBIEN)=""
 . Q
 ;if it is already marked
 Q:$D(FBCNT(FBIEN))
 ;otherwise file it
 N FEEO,FBT,FBIEN1,DA S (DA,FBIEN1)=FBIEN,FBT="F",FEEO="" D SETGL^FBAAVD
 S FBCNT=$$FBCNTINC()
 Q
 ;
 ;/**
 ;Counter for marked vendors
 ;
FBCNTINC() ;*/
 Q:$D(FBCNT(FBIEN)) FBCNT
 S FBCNT(FBIEN)=""
 Q FBCNT+1
 ;
 ;/**
 ;CHNGITEM
 ;change or delete FPDS code
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
 ;/**
 ;print all vendors that were not marked to sent to Austin
 ;
NMARKED ;*/
 Q:'$D(^TMP($J,"FBXIP39"))
 N FBDT,FBID,FBVEN,FBX,FB,FBY,FBDA
 D BMES^XPDUTL("  The following vendors could not be marked for transmission")
 D MES^XPDUTL("  because they are currently awaiting Austin action.")
 D BMES^XPDUTL("   Vendor Name                               ID           Sent to Austin")
 D MES^XPDUTL("   ----------------------------------------  -----------  --------------")
 S FBDA=0 F  S FBDA=$O(^TMP($J,"FBXIP39",FBDA)) Q:'FBDA  D
 . S FBY(0)=$G(^FBAAV(FBDA,0))
 . S FBVEN=$E($P(FBY(0),"^"),1,40)
 . S FBID=$P(FBY(0),"^",2)
 . S FBDT=$P($G(^FBAAV(FBDA,"ADEL")),"^",2)
 . I FBDT]"" S FBDT=$$FMTE^XLFDT(FBDT)
 . S FBX="   "_$$LJ^XLFSTR(FBVEN,42)_$$LJ^XLFSTR(FBID,13)_FBDT
 . D MES^XPDUTL(FBX)
 D BMES^XPDUTL("  The Update FMS Vendor File in Austin [FBAA FMS UPDATE] option can be")
 D MES^XPDUTL("  used to send the socio-economic data for the listed vendors to")
 D MES^XPDUTL("  Austin after their current pending action has been resolved.")
 Q
 ;
