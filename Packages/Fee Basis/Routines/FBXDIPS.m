FBXDIPS ;WIRMFO/SAB-POST INSTALL ;12/9/1998
 ;;3.5;FEE BASIS;**13**;JAN 30, 1995
 ;
 ; only perform during 1st install
 I $$PATCH^XPDUTL("FB*3.5*13") D BMES^XPDUTL("  Skipping post install since patch was previously installed.") Q
 ;
 N DA,DIK,FBC,FBAC,FBDA,FBFDA,FBPROG,FBY
 ;
 D BMES^XPDUTL("  Checking Purpose of Visit codes")
 S FBPROG=$O(^FBAA(161.8,"B","CHAMPVA",0))
 F FBAC=12,13 D
 . S FBDA=0 F  S FBDA=$O(^FBAA(161.82,"C",FBAC,FBDA)) Q:'FBDA  D
 . . S FBY=$G(^FBAA(161.82,FBDA,0)) Q:FBY=""
 . . Q:$P(FBY,U,2)=FBPROG  ; already points to CHAPMVA
 . . S FBFDA(161.82,FBDA_",",2)=$S(FBPROG:FBPROG,1:"@")
 . . D MES^XPDUTL("    updating fee program for POV with ien "_FBDA)
 I $D(FBFDA) D FILE^DIE("","FBFDA") D MSG^DIALOG()
 ;
 D BMES^XPDUTL("  Building new cross-reference for existing authorizations...")
 ; init variables
 S FBC("TOT")=$P($G(^FBAAA(0)),U,4) ; total number of patients to index
 S FBC("PAT")=0 ; count of re-indexed patients
 S XPDIDTOT=FBC("TOT") ; set total for status bar
 S FBC("UPD")=5  ; initial % required to update status bar
 ;
 ; loop thru patients
 S FBDA=0 F  S FBDA=$O(^FBAAA(FBDA)) Q:'FBDA  D
 . S FBC("PAT")=FBC("PAT")+1
 . S FBC("%")=FBC("PAT")*100/FBC("TOT") ; calculate % complete
 . ; check if status bar should be updated
 . I FBC("%")>FBC("UPD") D
 . . D UPDATE^XPDID(FBC("PAT")) ; update status bar
 . . S FBC("UPD")=FBC("UPD")+5 ; increase update criteria by 5%
 . ; build B index for patient authorizations
 . K DA S DIK="^FBAAA("_FBDA_",1,",DIK(1)=".01^B",DA(1)=FBDA D ENALL^DIK
 ;
 D MES^XPDUTL("    done.")
 ;
 Q
 ;FBXDIPS
