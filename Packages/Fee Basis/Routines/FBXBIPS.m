FBXBIPS ;WIRMFO/SAB-POST INIT ;10/24/97
 ;;3.5;FEE BASIS;**10**;JAN 30, 1995
 ;
 I $$PATCH^XPDUTL("FB*3.5*10") D BMES^XPDUTL("  Skipping Vendor check since patch was previously installed.") Q
 ;
 N DA,FBC,FBDA,FBDA1,FBIEN1,FBT,FEEO,XPDIDTOT
 D BMES^XPDUTL("  Marking Vendors with socio-economic data...")
 K ^TMP($J)
 S FBC("TOT")=+$P($G(^FBAAV(0)),U,4) ; total number of vendors
 S FBC("VEN")=0 ; count of vendors examined
 S FBC("MRA")=0 ; count of vendors added to 161.25
 S XPDIDTOT=FBC("TOT") ; set total for status bar
 S FBC("UPD")=5  ; initial % required to update status bar
 S FBDA=0 F  S FBDA=$O(^FBAAV(FBDA)) Q:'FBDA  D
 . ;
 . S FBC("VEN")=FBC("VEN")+1 ; increment counter
 . S FBC("%")=FBC("VEN")*100/FBC("TOT") ; calculate % complete
 . ; check if status bar should be updated
 . I FBC("%")>FBC("UPD") D
 . . D UPDATE^XPDID(FBC("VEN")) ; update status bar
 . . S FBC("UPD")=FBC("UPD")+5 ; increase update criteria by 5%
 . ;
 . Q:$P($G(^FBAAV(FBDA,1)),U,10)=""  ; business type (fpds) null
 . Q:$P($G(^FBAAV(FBDA,"ADEL")),U)="Y"  ; austin deleted
 . S FBDA1=$O(^FBAA(161.25,"AF",FBDA,0))
 . I FBDA1]"",FBDA1'=FBDA Q  ; linked to another vendor
 . ;
 . ; vendor should be reported to Central FEE
 . I $D(^FBAA(161.25,FBDA)) D  Q  ; vendor already in 161.25
 . . I $P($G(^FBAA(161.25,FBDA,0)),U,5)="" Q  ; not sent - will incl fpds
 . . S ^TMP($J,FBDA)="" ; can't update since awaiting austin action
 . ; add to queue
 . S (DA,FBIEN1)=FBDA,FBT="F",FEEO="" D SETGL^FBAAVD
 . S FBC("MRA")=FBC("MRA")+1
 D MES^XPDUTL("  "_FBC("MRA")_" Vendors were marked.")
 ;
 I $D(^TMP($J)) D
 . N FBDT,FBID,FBVEN,FBX,FBY
 . D BMES^XPDUTL("  The following vendors could not be marked for transmission")
 . D MES^XPDUTL("  because they are currently awaiting Austin action.")
 . D BMES^XPDUTL("   Vendor Name                               ID           Sent to Austin")
 . D MES^XPDUTL("   ----------------------------------------  -----------  --------------")
 . S FBDA=0 F  S FBDA=$O(^TMP($J,FBDA)) Q:'FBDA  D
 . . S FBY(0)=$G(^FBAAV(FBDA,0))
 . . S FBVEN=$E($P(FBY(0),U),1,40)
 . . S FBID=$P(FBY(0),U,2)
 . . S FBDT=$P($G(^FBAAV(FBDA,"ADEL")),U,2)
 . . I FBDT]"" S FBDT=$$FMTE^XLFDT(FBDT)
 . . S FBX="   "_$$LJ^XLFSTR(FBVEN,42)_$$LJ^XLFSTR(FBID,13)_FBDT
 . . D MES^XPDUTL(FBX)
 . D BMES^XPDUTL("  The Update FMS Vendor File in Austin [FBAA FMS UPDATE] option can be")
 . D MES^XPDUTL("  used to send the socio-economic data for the listed vendors to")
 . D MES^XPDUTL("  Austin after their current pending action has been resolved.")
 ;
 K ^TMP($J)
 Q
 ;FBXBIPS
