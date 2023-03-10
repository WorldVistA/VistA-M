IBCNIUK ;AITC/TAZ - Interfacility Ins Purge;29-OCT-2020
 ;;2.0;INTEGRATED BILLING;**687**; 21-MAR-94;Build 88
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Variables:
 ;CDAYS - Number of Days to retain Candidate Entries (#350.9,53.06)
 ;SDAYS - Number of Days to retain Sent entries. (#350.9,53.05)
 ;RDAYS - Number of Days to retain Received Entries (#350.9,53.07)
 ;
 Q
EN ;entry point
 N BDATE,CDAYS,DA,DATE,DIE,DIK,DR,EDATE,IEN,IENS,RDAYS,SDAYS,SDATE,SENT,STATUS,VIEN
 ;
 S SDAYS=$$GET1^DIQ(350.9,"1,",53.05)+1
 S CDAYS=$$GET1^DIQ(350.9,"1,",53.06)+1
 S RDAYS=$$GET1^DIQ(350.9,"1,",53.07)+1
 ;
 ;Process Candidate SENDER entries
 S DATE="",EDATE=$$FMADD^XLFDT(DT,-CDAYS)
 F  S DATE=$O(^IBCN(365.19,"DIR","S",DATE))  Q:'DATE  D
 . S IEN=""
 . F  S IEN=$O(^IBCN(365.19,"DIR","S",DATE,IEN)) Q:'IEN  D
 . . I $P(DATE,".")>EDATE Q
 . . ;file 365.19, field 1.01 SENDER STATUS
 . . S STATUS=$$GET1^DIQ(365.19,IEN,1.01)
 . . I STATUS="COMPLETE" Q
 . . I (STATUS="WAITING")!(STATUS["FAILED") D  Q
 . . . S DIK="^IBCN(365.19,",DA=IEN D ^DIK K DA,DIK
 . . S (SENT,VIEN)=0
 . . F  S VIEN=$O(^IBCN(365.19,IEN,1.1,VIEN)) Q:'VIEN  D
 . . . S DA=VIEN,DA(1)=IEN
 . . . S IENS=VIEN_","_IEN_","
 . . . ;Check SENT STATUS, purge "READY TO SEND" entries.
 . . . I $$GET1^DIQ(365.191,IENS,.02)="READY TO SEND" D
 . . . . S DIK="^IBCN(365.19,"_DA(1)_",1.1," D ^DIK K DA,DIK
 . . . I $$GET1^DIQ(365.191,IENS,.02)="SENT" S SENT=1
 . . ;If SENT, update STATUS to "COMPLETE"
 . . I SENT S DIE=365.19,DR="1.01///COMPLETE",DA=IEN D ^DIE K DA,DIE,DR
 ;
 ; Clean up the SENDER 'COMPLETE' entries
 S DATE="",EDATE=$$FMADD^XLFDT(DT,-SDAYS)
 F  S DATE=$O(^IBCN(365.19,"DIR","S",DATE))  Q:'DATE  D
 . S IEN=""
 . F  S IEN=$O(^IBCN(365.19,"DIR","S",DATE,IEN)) Q:'IEN  D
 . . S STATUS=$$GET1^DIQ(365.19,IEN,1.01)
 . . I STATUS'="COMPLETE" Q
 . . S VIEN=0
 . . F  S VIEN=$O(^IBCN(365.19,IEN,1.1,VIEN)) Q:'VIEN  D
 . . . S DA=VIEN,DA(1)=IEN
 . . . S IENS=VIEN_","_IEN_","
 . . . ;Use SENT STATUS DATE/TIME to compare against EDATE
 . . . S SDATE=$P($$GET1^DIQ(365.191,IENS,.03,"I"),".")
 . . . I SDATE>EDATE Q
 . . . S DA=IEN,DIK="^IBCN(365.19," D ^DIK K DA,DIK
 ;
 ;Process RECEIVER entries
 S DATE="",EDATE=$$FMADD^XLFDT(DT,-RDAYS)
 F  S DATE=$O(^IBCN(365.19,"DIR","R",DATE)) Q:'DATE   D
 . I DATE>EDATE Q    ;Compare against the date received (aka create date)
 . S IEN=0
 . F  S IEN=$O(^IBCN(365.19,"DIR","R",DATE,IEN)) Q:'IEN  D
 . . S DIK="^IBCN(365.19,",DA=IEN D ^DIK K DA,DIK
 Q
