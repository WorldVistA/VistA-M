FBXEIPS ;WCIOFO/SAB-POST INSTALL ROUTINE ;7/17/1998
 ;;3.5;FEE BASIS;**14**;JAN 30, 1995
 Q
 ;
EN N FBDA,FBC
 D BMES^XPDUTL("  Examining the FEE BASIS PATIENT file...")
 ; init variables
 S FBC("TOT")=$P($G(^FBAAA(0)),U,4) ; total # of patients to evaluate
 S FBC("PAT")=0 ; count of evaluated patients
 S FBC("HEC")=0 ; count of patients to report to HEC
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
 . ; evaluate authorizations
 . I $$XMIT(FBDA) S FBC("HEC")=FBC("HEC")+1 D EVENT^IVMPLOG(FBDA)
 ;
 D MES^XPDUTL("    "_FBC("PAT")_" FEE BASIS PATIENTs were evaluated.")
 D MES^XPDUTL("    Of these, "_FBC("HEC")_" will be included in the next daily transmission to HEC.")
 ;
 Q
 ;
XMIT(FBDA) ; Should FEE veterans be reported to HEC
 N FBDA1,FBRET,FBY0
 S FBRET=0 ; assume no authorizations will meet criteria
 ; reverse loop thru authorizations - stop when any one meets criteria
 S FBDA1=" " F  S FBDA1=$O(^FBAAA(FBDA,1,FBDA1),-1) Q:'FBDA1  D  Q:FBRET
 . Q:$P($G(^FBAAA(FBDA,1,FBDA1,"ADEL")),U)="Y"  ; ignore Austin Deleted
 . S FBY0=$G(^FBAAA(FBDA,1,FBDA1,0))
 . Q:$P(FBY0,U,2)<2961001  ; To Date before cutoff date
 . Q:$P(FBY0,U,3)=""  ; FEE Program required
 . ; passed all checks
 . S FBRET=1
 ;
 Q FBRET
 ;
 ;FBXEIPS
