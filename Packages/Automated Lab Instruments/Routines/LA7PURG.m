LA7PURG ;DALOI/JMC - Purge Lab Messaging Interface Messages ; Nov 4, 2004
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,64**;Sep 27, 1994
 ;
 ; This routine purges messages and checks file intregrity for Lab Messaging.
 Q
 ;
 ;
EN ; Entry point from taskman
 D IC^LA7CHKF
 D PURGE,PSM,PLPO
 S X=$$LACHK^LA7CHKF
 Q
 ;
 ;
PURGE ; purge messages previous to today
 N DA,DIK,I,LA7CFG,LA7DA,LA7DAT,LA7ROOT,LA7Q,X,Y
 ;
 ; Get each configuration's grace period for messages.
 ; Determine cut-off date for purging this configuration.
 S I=0
 F  S I=$O(^LAHM(62.48,I)) Q:'I  D
 . S X=$P($G(^LAHM(62.48,I,0)),"^",6)
 . I 'X S X=3 ; If missing, default to 3 days.
 . S LA7DAT(I)=$$HTFM^XLFDT($$HADD^XLFDT($H,-X),1)
 S LA7DAT=0
 ;
 F  S LA7DAT=$O(^LAHM(62.49,"AD",LA7DAT)) Q:'LA7DAT!(LA7DAT=DT)  D
 . ; Set flag if "problem" messages for this date are purgeable --> have been removed from XTMP.
 . S LA7DAT(0)=$G(^XTMP("LA7ERR^"_LA7DAT,0),0)
 . S LA7DA=0
 . F  S LA7DA=$O(^LAHM(62.49,"AD",LA7DAT,LA7DA)) Q:'LA7DA  D
 . . L +^LAHM(62.49,LA7DA):1
 . . I $T D
 . . . I LA7DAT'=$P($P($G(^LAHM(62.49,LA7DA,0)),"^",5),".") D  Q
 . . . . ; Date in cross-reference does not match field #4, remove x-ref.
 . . . . K ^LAHM(62.49,"AD",LA7DAT,LA7DA)
 . . . ; Don't purge if problem message and still in XTMP global.
 . . . I LA7DAT(0),$P(^LAHM(62.49,LA7DA,0),"^",3)'="X" Q
 . . . ; Get configuration for this message.
 . . . S LA7CFG=+$G(^LAHM(62.49,LA7DA,.5))
 . . . ; If message hasn't reached purge date --> skip.
 . . . I LA7CFG,LA7DAT'<$G(LA7DAT(LA7CFG)) Q
 . . . S DIK="^LAHM(62.49,",DA=LA7DA D ^DIK
 . . L -^LAHM(62.49,LA7DA)
 Q
 ;
 ;
PSM ; Purge shipping manifests file (#62.8)
 ;
 ; Check each manifest to determine if accessions on manifest have all
 ; been purged from file #68.
 ;
 ; If over 10000 entries purged from #62.85 then quit and pickup next
 ; session. Avoid performance and journaling issues.
 N DA,DIK,LA7628,LA7CNT
 S (LA7628,LA7CNT)=0,DIK="^LAHM(62.8,"
 F  S LA7628=$O(^LAHM(62.8,LA7628)) Q:'LA7628  D  Q:LA7CNT>10000
 . I '$$CHK628(LA7628) Q
 . D P6285
 . S DA=LA7628 D ^DIK
 Q
 ;
 ;
PLPO ; Purge Lab Pending Orders file (#69.6)
 ;
 ; Check each order to determine if order can be purged.
 ;
 ; If over 5000 entries purged then quit and pickup next session.
 ; Avoid performance and journaling issues.
 ;
 N DA,DIK,LA7696,LA7CNT,LA7COFF,LA7STAT
 ;
 S DIK="^LRO(69.6,",(LA7696,LA7CNT)=0
 ; Cutoff dates
 S LA7COFF(1)=$$FMADD^XLFDT(DT,-365),LA7COFF(2)=$$FMADD^XLFDT(DT,-730)
 ; Results sent status ien
 S LA7STAT=$$FIND1^DIC(64.061,"","OMX","Results/data Received","","I $P(^LAB(64.061,Y,0),U,7)=""U""")
 F  S LA7696=$O(^LRO(69.6,LA7696)) Q:'LA7696  D  Q:LA7CNT>5000
 . I '$$CHK696(LA7696,.LA7COFF,LA7STAT) Q
 . S LA7CNT=LA7CNT+1,DA=LA7696 D ^DIK
 Q
 ;
 ;
CHK628(LA7628) ; If all accessions have been purged then safe to purge manifest
 ; and associated events (#62.85)
 ;
 ; Call with LA7628 = ien of manifest in #62.8
 ;
 ; Returns OK = 1(yes)/ 0(no) to purge
 ;
 N LRUID,OK
 S OK=1,LRUID=""
 F  S LRUID=$O(^LAHM(62.8,LA7628,10,"UID",LRUID)) Q:LRUID=""  I $$CHECKUID^LRWU4(LRUID) S OK=0 Q
 Q OK
 ;
 ;
P6285 ; Purge related entries in shipping activity log (#62.85)
 ;
 N DA,DIK,LA7SM,LRUID
 S LA7SM=$P(^LAHM(62.8,LA7628,0),"^"),LRUID="",DIK="^LAHM(62.85,"
 ;
 ; Purge entries in 62.85 relating to accessions (UID) on manifest
 F  S LRUID=$O(^LAHM(62.8,LA7628,10,"UID",LRUID)) Q:LRUID=""  D
 . S DA=0
 . F  S DA=$O(^LAHM(62.85,"AM",LRUID,LA7SM,DA)) Q:'DA  D ^DIK S LA7CNT=LA7CNT+1
 ;
 ; Purge entries in 62.85 relating to manifest
 S DA=0
 F  S DA=$O(^LAHM(62.85,"B",LA7SM,DA)) Q:'DA  D ^DIK S LA7CNT=LA7CNT+1
 Q
 ;
 ;
CHK696(LA7696,LA7COFF,LA7SPST) ; Check if order safe to purge
 ;
 ; Call with LA7696 = ien of order in #69.6
 ;          LA7COFF = array of cutoff FileMan dates.
 ;          LA7SPST = ien of specimen status Results/data Received
 ;
 ; Returns OK = 1(yes)/ 0(no) to purge
 ;
 N LAX,OK
 S OK=0,LAX=$G(^LRO(69.6,LA7696,1))
 ;
 ; Check date order completed
 I $P(LAX,"^",7),$P(LAX,"^",7)<LA7COFF(1) S OK=1
 ;
 ; Check date order received/tranmsitted
 I 'OK D
 . I $P(LAX,"^",4),$P(LAX,"^",4)<LA7COFF(2) S OK=1 Q
 . I $P(LAX,"^",5),$P(LAX,"^",5)<LA7COFF(2) S OK=1 Q
 ;
 ; Check date order received and specimen status
 I 'OK,$P(LAX,"^",5),$P(LAX,"^",5)<LA7COFF(1) D
 . S X=$P($G(^LRO(69.6,LA7696,0)),"^",10) ; specimen status
 . I LA7SPST,X=LA7SPST S OK=1
 ;
 Q OK
