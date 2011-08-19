EC2P24PT ;ALB/JAM - PATCH EC*2.0*24 Post-Init Rtn ; 04/19/00
 ;;2.0; EVENT CAPTURE ;**24**;04 Apr 2000
 ;
POST ; entry point
 ;* search file #725 for invalid CPT IENs then file 721.
 S ECJ=$J K ^TMP(ECJ,"EC2P24")
 D F725SRH
 D BKGPRC
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("   completed...")
 D MES^XPDUTL(" ")
 Q
 ;
F725SRH ; Locate invalid CPT codes in file 725 and correct them
 N IEN,CPT,ECX,DA,DIE,CPTIEN,DR
 S IEN=0
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Correcting CPT IEN in EC NATIONAL PROCEDURE file(#725)...")
 D MES^XPDUTL(" ")
 F  S IEN=$O(^EC(725,IEN)) Q:'IEN  D
 . S ECX=$G(^EC(725,IEN,0)),CPT=$P(ECX,U,5) I CPT="" Q
 . I $D(^ICPT(CPT)) Q
 . I $D(^ICPT("B",CPT)) D  Q
 . . S CPTIEN=$O(^ICPT("B",CPT,0))
 . . I CPTIEN="" S ^TMP(ECJ,"EC2P24","F725",IEN)=CPT_U_ECX Q
 . . K DIE,DR S DA=IEN,DR="4////"_CPTIEN,DIE="^EC(725," D ^DIE K DR
 . . D MES^XPDUTL(" ")
 . . D BMES^XPDUTL("   Entry #"_IEN_" for "_$P(ECX,U)_" ["_$P(ECX,U,2)_"]")
 . . D BMES^XPDUTL("   ...updated to use CPT IEN "_CPTIEN_".")
 . S ^TMP(ECJ,"EC2P24","F725",IEN)=CPT_U_ECX Q
 Q
 ;
F721SRH ; Locate invalid CPT code in file 721 and corrects it
 N ECD,ECSD,ECED,ECPT,EC,ECDA,FLG,ERR,CPTIEN,X,Y
 S %DT="X",X="12/22/99" D ^%DT S ECSD=Y,ECD=ECSD-.1
 D NOW^%DTC S ECED=%
 F  S ECD=$O(^ECH("AC",ECD)) Q:'ECD  Q:ECD>ECED  S ECDA=0 D
 . F  S ECDA=$O(^ECH("AC",ECD,ECDA)) Q:'ECDA  D
 . . S EC=$G(^ECH(ECDA,"P")),ECPT=$P(EC,U),ERR=0 I ECPT="" Q
 . . I $D(^ICPT(ECPT)) Q
 . . S EC(0)=$G(^ECH(ECDA,0)) I EC(0)="" Q
 . . D
 . . . S CPTIEN=$O(^ICPT("B",ECPT,0)) I CPTIEN="" S ERR=1 Q
 . . . I '$D(^ICPT(CPTIEN)) S ERR=1 Q
 . . . S $P(^ECH(ECDA,"P"),U)=CPTIEN
 . . . S FLG=$$FIX721(ECDA,.EC)
 . . S ^TMP(ECJ,"EC2P24","F721",ECDA)=ECPT_U_ERR_U_EC(0)
 K DIE,DA,DR
 Q
 ;
MSGTXT ; Message intro
 ;; Please forward this message to your local DSS Site Manager or
 ;; Event Capture ADPAC.
 ;;
 ;; A review of the EVENT CAPTURE PATIENT file (#721) was done on
 ;; CPT codes for the period 12/22/99-present. This message provides 
 ;; the result of encounters found with invalid CPT code during that
 ;; period.  If the encounter had a CPT code that was stored in its
 ;; external format it was corrected with the corresponding internal 
 ;; entry number and shows on the list below with a status of 'C'.
 ;; If the entry status is shown as 'NC', the user should use the 
 ;; 'Enter/Edit Patient Procedures' [ECPAT] option to correct these 
 ;; entries to have the proper CPT code.
 ;;    
 ;;QUIT
 ;
BKGPRC ;* print entrie with invalid CPT codes
 D BMES^XPDUTL("You will receive a MailMan message regarding invalid CPT entries in file #721 and #725")
 D BMES^XPDUTL("  ")
 S ZTRTN="PROCESS^EC2P24PT",ZTDESC="File #721 Review from EC*2*24"
 S ZTIO="",ZTDTH=$H,ZTREQ="@",ZTSAVE("ZTREQ")="",ZTSAVE("ECJ")="" D ^%ZTLOAD
 Q
 ;
PROCESS ;* background job entry point
 N IEN,COUNT,TXTVAR,BL,ECDT,ECY,I,STA,ECPT
 D F721SRH
 S COUNT=0,$P(BL," ",40)=" "
 F I=1:1 S TXTVAR=$P($T(MSGTXT+I),";;",2) Q:TXTVAR="QUIT"  D LINE(TXTVAR)
 D LINE(" ")
 D LINE(" ")
 D LINE("721 IEN        PATIENT IEN    DATE/TIME               OLD/NEW CPT CODE    STA")
 D LINE("-------        -----------    ---------               ----------------    ---")
 S IEN=0
 F  S IEN=$O(^TMP(ECJ,"EC2P24","F721",IEN)) Q:'IEN  D
 . S ECX=^TMP(ECJ,"EC2P24","F721",IEN),STA=$P(ECX,U,2)
 . S STA=$S(STA:"NC",1:"C")
 . S ECPT=$P(ECX,U)_"/"_$S(STA:"",1:$P($G(^ECH(IEN,"P")),U))
 . S Y=$P(ECX,U,5) X ^DD("DD") S ECDT=Y
 . S ECY=$E(IEN_BL,1,15)_$E($P(ECX,U,4)_BL,1,15)_$E(ECDT_BL,1,24)
 . S ECY=ECY_$E(ECPT_BL,1,20)_STA
 . D LINE(ECY)
 I $D(^TMP(ECJ,"EC2P24","F721")) D
 . D LINE(" ")
 . D LINE("C  - Corrected")
 . D LINE("NC - Not Corrected")
 I $D(^TMP(ECJ,"EC2P24","F725")) D
 . D LINE(" ")
 . D LINE(" ")
 . D LINE(" ")
 . D LINE("CPT entries found in EC NATIONAL PROCEDURE FILE #725")
 . D LINE("that could not be located in the CPT file #81")
 . D LINE(" ")
 . D LINE("725 IEN        EC NATIONAL CODE                       CPT CODE")
 . D LINE("-------        ----------------                       --------")
 . S IEN=0 F  S IEN=$O(^TMP(ECJ,"EC2P24","F725",IEN)) Q:'IEN  D
 . . S ECX=^TMP(ECJ,"EC2P24","F725",IEN)
 . . S ECY=$E(IEN_BL,1,15)_$E($P(ECX,U,2)_BL,1,36)_"   "_$P(ECX,U)
 . . D LINE(ECY)
 I '$D(^TMP(ECJ,"EC2P24","F721")) D
 .D LINE(" ")
 .D LINE(" No entries found in EVENT CAPTURE PATIENT file #721 that")
 .D LINE(" needs correction.")
 .D LINE(" ")
 K ^TMP(ECJ,"EC2P24","F721"),^TMP(ECJ,"EC2P24","F725")
 D MAIL
 K ^TMP(ECJ,"EC2P24"),ECJ
 Q
 ;
LINE(TEXT) ; Add line to message global
 S COUNT=COUNT+1,^TMP(ECJ,"EC2P24",COUNT)=TEXT
 Q
 ;
MAIL ; Send message
 N XMDUZ,XMY,XMTEXT,XMSUB
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Event Capture Patient CPT Code Review"
 S XMTEXT="^TMP(ECJ,""EC2P24"","
 D ^XMD
 Q
FIX721(ECFN,EC) ;Fix bad CPT code entry in file #721
 ; Input: ECFN  -  Event Capture file #721 IEN
 ;        EC    -  Zero (0) and "P" nodes in file #721
 ;
 ; Output:      -  Returns 1 if fixed and 0 if failed
 ;
 N EC4,ECDX,ECP,ECCPT,ECINP,ECPCE,ECD,NODE,ECDT
 S EC4=$P(EC(0),"^",19),ECDX=$P(EC,"^",2),ECP=$P(EC(0),"^",9)
 S ECCPT=$S(ECP["EC":$P($G(^EC(725,+ECP,0)),"^",5),1:+ECP)
 S ECINP=$P(EC(0),"^",22),ECD=$P(EC(0),"^",7),NODE=$G(^ECD(ECD,0))
 S ECPCE="U~"_$S($P(NODE,"^",14)]"":$P(NODE,"^",14),1:"N")
 D NOW^%DTC S ECDT=%
 D PCEE^ECBEN2U
 Q 1
