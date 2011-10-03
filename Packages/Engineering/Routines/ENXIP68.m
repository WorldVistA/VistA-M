ENXIP68 ;WCIOFO/SAB-PATCH INSTALL ROUTINE ;2/8/2001
 ;;7.0;ENGINEERING;**68**;Aug 17, 1993
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N ENX,Y
 F ENX="OBC" D
 . S Y=$$NEWCP^XPDUTL(ENX,ENX_"^ENXIP68")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_ENX_" Checkpoint.")
 Q
 ;
OBC ; Move ORIGINAL BAR CODE ID data (post-install)
 N ENC,ENDA,ENOBC,XPDIDTOT,DA,DIK
 ;
 ; If field 28.1 not ORIGINAL BAR CODE ID then already done
 I $$GET1^DID(6914,28.1,"","LABEL")'="ORIGINAL BAR CODE ID" D  Q
 . D BMES^XPDUTL("  ORIGINAL BAR CODE ID data already processed. Skipping step.")
 ;
 I '$D(^ENG(6914,"OEE")) D
 .D BMES^XPDUTL("  No ORIGINAL BAR CODE ID data to move. Skipping step.")
 E  D
 . ; must be some data to move
 . ; loop through file 6914 - move data from 28.1 into new multiple
 . D BMES^XPDUTL("  Moving ORIGINAL BAR CODE ID data in file 6914...")
 . ; init variables
 . S ENC("TOT")=$P($G(^ENG(6914,0)),U,4) ; total # of items to process
 . I ENC("TOT")=0 S ENC("TOT")=1 ; avoid divide by zero error
 . S ENC("EQU")=0 ; count of evaluated items
 . S ENC("OBC")=0 ; count of ORIGINAL BAR CODE IDs moved
 . S XPDIDTOT=ENC("TOT") ; set total for status bar
 . S ENC("UPD")=5  ; initial % required to update status bar
 . ; loop thru equipment
 . S ENDA=0 F  S ENDA=$O(^ENG(6914,ENDA)) Q:'ENDA  D
 . . S ENC("EQU")=ENC("EQU")+1
 . . S ENC("%")=ENC("EQU")*100/ENC("TOT") ; calculate % complete
 . . ; check if status bar should be updated
 . . I ENC("%")>ENC("UPD") D
 . . . D UPDATE^XPDID(ENC("EQU")) ; update status bar
 . . . S ENC("UPD")=ENC("UPD")+5 ; increase update criteria by 5%
 . . ; get single valued ORIGINAL BAR CODE ID
 . . S ENOBC=$P($G(^ENG(6914,ENDA,3)),U,14)
 . . Q:ENOBC=""  ; nothing to move
 . . Q:$O(^ENG(6914,ENDA,12,0))  ; unexpected - value in multiple
 . . ; put original bar code id in multiple field
 . . S ^ENG(6914,ENDA,12,0)="^6914.05^1^1"
 . . S ^ENG(6914,ENDA,12,1,0)=ENOBC
 . . S ^ENG(6914,ENDA,12,"B",ENOBC,1)=""
 . . ; delete modifier from old location
 . . S $P(^ENG(6914,ENDA,3),U,14)=""
 . . K ^ENG(6914,"OEE",ENOBC,ENDA)
 . . ; set whole file x-ref for new multiple
 . . S ^ENG(6914,"OEE",ENOBC,ENDA,1)=""
 . . ; increment counter
 . . S ENC("OBC")=ENC("OBC")+1
 . ;
 . ; report results
 . D MES^XPDUTL("    "_ENC("OBC")_" ORIGINAL BAR CODE IDs were moved.")
 ;
 ; delete field 28.1 from data dictionary
 S DIK="^DD(6914,",DA=28.1,DA(1)=6914 D ^DIK
 ;
 Q
 ;
 ;ENXIP68
