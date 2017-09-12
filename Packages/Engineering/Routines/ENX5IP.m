ENX5IP ;WCIOFO/SAB-INSTALL ROUTINE;5/8/1998
 ;;7.0;ENGINEERING;**53**;AUG 17, 1993
 ; This routine can be deleted after patch EN*7*53 has been installed
 Q
 ;
PRE ;Pre-Install Steps
 ; delete PRIMARY TECH ASSIGNED field so "AD" x-ref can be removed.
 S DIK="^DD(6920,",DA=16,DA(1)=6920 D ^DIK
 Q
 ;
PST ;Post-Install Steps
 ; create KIDS checkpoints with call backs
 N ENX
 F ENX="AINC","WO" D
 . S Y=$$NEWCP^XPDUTL(ENX,ENX_"^ENX5IP")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_ENX_" Checkpoint.")
 Q
 ;
AINC ; post-install checkpoint
 ; check AINC x-ref entries and remove from x-ref as necessary 
 N ENC,ENDA,ENRDA,ENSHOP
 D BMES^XPDUTL("  Examining the incomplete work order (AINC) x-ref")
 D MES^XPDUTL("  and removing inappropriate entries as necessary...")
 S (ENC("INC"),ENC("BAD"))=0
 ; loop thru shop in x-ref
 S ENSHOP=0 F  S ENSHOP=$O(^ENG(6920,"AINC",ENSHOP)) Q:'ENSHOP  D
 . ; loop thru 'reverse' iens under shop
 . S ENRDA=0 F  S ENRDA=$O(^ENG(6920,"AINC",ENSHOP,ENRDA)) Q:'ENRDA  D
 . . S ENC("INC")=ENC("INC")+1
 . . S ENBAD=0 ; init flag, true if x-ref should be deleted
 . . S ENDA=9999999999-ENRDA ; determine work order ien
 . . I $P($G(^ENG(6920,ENDA,5)),U,2) S ENBAD=1 ; work order complete
 . . I ENSHOP'=$P($G(^ENG(6920,ENDA,2)),U) S ENBAD=1 ; wrong shop
 . . I ENBAD S ENC("BAD")=ENC("BAD")+1 K ^ENG(6920,"AINC",ENSHOP,ENRDA)
 D MES^XPDUTL("    "_$FN(ENC("INC"),",")_" entries were processed.")
 D MES^XPDUTL("  "_$S(ENC("BAD")=0:"None",1:$FN(ENC("BAD"),","))_" of the entries had to be removed from the AINC x-ref.")
 Q
 ;
WO ; post-install checkpoint
 ; check work orders and add to AINC x-ref as necessary
 N ENC,ENDA,ENRDA,ENSHOP
 D BMES^XPDUTL("  Checking all work orders and adding incomplete work")
 D MES^XPDUTL("  orders to the AINC x-ref as necessary...")
 S XPDIDTOT=+$P($G(^ENG(6920,0)),U,4) ; set total for status bar
 S (ENC("ADD"),ENC("INC"),ENC("WO"))=0
 S ENDA=0 F  S ENDA=$O(^ENG(6920,ENDA)) Q:'ENDA  D
 . I '$D(^ENG(6920,ENDA,0)) K ^ENG(6920,ENDA) Q  ; invalid data
 . S ENC("WO")=ENC("WO")+1
 . I '(ENC("WO")#1000) D UPDATE^XPDID(ENC("WO")) ; update status bar
 . Q:$P($G(^ENG(6920,ENDA,5)),U,2)]""  ; completed work order
 . S ENC("INC")=ENC("INC")+1
 . S ENSHOP=$P($G(^ENG(6920,ENDA,2)),U)
 . Q:ENSHOP=""  ; missing shop
 . S ENRDA=9999999999-ENDA
 . I '$D(^ENG(6920,"AINC",ENSHOP,ENRDA)) S ENC("ADD")=ENC("ADD")+1
 . S ^ENG(6920,"AINC",ENSHOP,ENRDA)=""
 ;
 ; update count of w.o. in file header (if necessary)
 I XPDIDTOT'=ENC("WO") S $P(^ENG(6920,0),U,4)=ENC("WO")
 D MES^XPDUTL("    "_$FN(ENC("WO"),",")_" work orders were processed.")
 D MES^XPDUTL("    "_$FN(ENC("INC"),",")_" incomplete work orders were found.")
 D MES^XPDUTL("  "_$S(ENC("ADD")=0:"None",1:$FN(ENC("ADD"),","))_" of the work orders had to be added to the AINC x-ref.")
 Q
 ;
 ;ENX5IP
