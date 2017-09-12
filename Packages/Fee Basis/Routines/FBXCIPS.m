FBXCIPS ;WIRMFO/SAB-POST INIT ;1/7/98
 ;;3.5;FEE BASIS;**11**;JAN 30, 1995
 ;
 N FBC,FBDA,FBDT,FBI,FBY
 D BMES^XPDUTL("  Examining FEE BASIS ID CARD AUDIT File data...")
 ; init variables
 S FBC("PAT","CHK")=0 ; count of patients checked
 S FBC("PAT","FIX")=0 ; count of patients fixed
 S FBC("AUD","CHK")=0 ; count of audit entries checked
 S FBC("AUD","FIX")=0 ; count of audit entries fixed
 S FBC("TOT")=$P($G(^FBAA(161.83,0)),U,4) ; number of patients to check
 S XPDIDTOT=FBC("TOT") ; set total for status bar
 S FBC("UPD")=5  ; initial % required to update status bar
 ;
 ; loop thru patients
 S FBDA=0 F  S FBDA=$O(^FBAA(161.83,FBDA)) Q:'FBDA  D
 . S FBC("PAT","CHK")=FBC("PAT","CHK")+1
 . S FBC("%")=FBC("PAT","CHK")*100/FBC("TOT") ; calculate % complete
 . ; check if status bar should be updated
 . I FBC("%")>FBC("UPD") D
 . . D UPDATE^XPDID(FBC("PAT","CHK")) ; update status bar
 . . S FBC("UPD")=FBC("UPD")+5 ; increase update criteria by 5%
 . ;
 . ; check header of multiple and correct if necessary
 . I +$P($G(^FBAA(161.83,FBDA,1,0)),U,2)'=161.831 D
 . . S FBC("PAT","FIX")=FBC("PAT","FIX")+1
 . . S $P(^FBAA(161.83,FBDA,1,0),U,2)="161.831DA"
 . . ;W !,"FH ",FBDA ; uncomment for testing
 . ;
 . ; loop thru audit multiple and correct any invalid entries
 . S FBI=0 F  S FBI=$O(^FBAA(161.83,FBDA,1,FBI)) Q:'FBI  D
 . . S FBC("AUD","CHK")=FBC("AUD","CHK")+1
 . . S FBDT=9999999.9999-FBI ; calculate date/time from FBI
 . . S FBY=$G(^FBAA(161.83,FBDA,1,FBI,0))
 . . ; compare #.01 field with calculated date/time
 . . I +$P(FBY,U)'=+FBDT D
 . . . S FBC("AUD","FIX")=FBC("AUD","FIX")+1
 . . . K ^FBAA(161.83,"B",FBDT,FBI) ; delete bad "B" x-ref
 . . . S ^FBAA(161.83,FBDA,1,FBI,0)=FBDT_U_$P(FBY,U)_"^Unknown^.5"
 . . . S:$P(FBY,U)]"" ^FBAA(161.83,"C",$P(FBY,U),FBDA,FBI)=""
 . . . ;W !,"   ",FBDA,?10,FBI,?25,FBY ; uncomment for testing
 ;
 S FBX="    "_FBC("PAT","CHK")_" header node"_$S(FBC("PAT","CHK")=1:" was",1:"s were")_" examined. "
 S FBX=FBX_$S(FBC("PAT","FIX")=0:"No problems were",FBC("PAT","FIX")=1:"1 problem was",1:FBC("PAT","FIX")_" problems were")_" found"_$S(FBC("PAT","FIX")>0:" and corrected",1:"")_"."
 D MES^XPDUTL(FBX)
 ;
 S FBX="    "_FBC("AUD","CHK")_" audit entr"_$S(FBC("AUD","CHK")=1:"y was",1:"ies were")_" examined. "
 S FBX=FBX_$S(FBC("AUD","FIX")=0:"No problems were",FBC("AUD","FIX")=1:"1 problem was",1:FBC("AUD","FIX")_" problems were")_" found"_$S(FBC("AUD","FIX")>0:" and corrected",1:"")_"."
 D MES^XPDUTL(FBX)
 ;
 Q
 ;FBXCIPS
