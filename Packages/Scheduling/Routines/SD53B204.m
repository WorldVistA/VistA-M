SD53B204 ;bp/cmf - Patch SD*5.3*204 post-init routine ; 12/06/99 
 ;;5.3;Scheduling;**204**;AUG 13, 1993
 ;
POST ;update c/s files
 ;
 ;initialize new pcmm parameter file fields
 ; add default value to RPC Time Limit field
 ; add default value to HL7 Transmit Limit field
 D BMESS("Updating PCMM files.")
 D MESS("Updating PCMM Parameter file.")
 N SCFDA,SC1ERR,SCX
 K SCFDA(1)
 S SCFDA(1,404.44,"1,",14)=30
 S SCFDA(1,404.44,"1,",15)=999999
 D FILE^DIE("","SCFDA(1)","SC1ERR")
 I $D(SC1ERR) D WMESS("PCMM Parameter file not updated properly.")
 ;
DSER ;disable old server entries (build active client list)
 D MESS("Disabling obsolete entries in Server Patch file.")
 N SC2LIST,SC2ERR,SCY,SC3LIST
 S SCX=$$ACTSER^SCMCUT("","SC2LIST")
 I 'SCX D MESS("No active Server Patch entries.") G P205
 S SCX=""
 F  S SCX=$O(SC2LIST(SCX)) Q:SCX']""  D
 . ;build active client list
 . S SCY=$$CLNLST^SCMCUT(SCX,"SC3LIST",1)
 . S SCY=0
 . F  S SCY=$O(^SCTM(404.45,"ACT",SCX,0)) Q:'SCY  D
 . . K SCFDA(2)
 . . S SCFDA(2,404.45,SCY_",",.04)=0
 . . D FILE^DIE("","SCFDA(2)","SC2ERR")
 . . Q
 . Q
 I $D(SC2ERR) D WMESS("Obsolete Server Patch entries not disabled.")
 ;
DCLI ;disable old client entries
 D MESS("Disabling obsolete entries in Client Patch file.")
 I '$D(SC3LIST) D MESS("No active Client Patch entries.") G P205
 N SC3ERR
 S SCX=""
 F  S SCX=$O(SC3LIST(SCX)) Q:SCX']""  D
 . K SCFDA(3)
 . S SCY=$O(^SCTM(404.46,"B",SCX,0))
 . S SCFDA(3,404.46,SCY_",",.02)=0
 . D FILE^DIE("","SCFDA(3)","SC3ERR")
 . Q
 I $D(SC3ERR) D WMESS("Obsolete Client Patch entries not disabled.")
 ;
P205 ;patch 205 record keeping
 D MESS("Updating SD*5.3*205 related entries.")
 S SCX=$$UPCLNLST^SCMCUT("SD*5.3*205^NullClient^1^0^0")
 I +SCX<1 D WMESS("SD*5.3*205 related entries not updated.")
 ;
P204 ;patch 204 record keeping
 D MESS("Updating SD*5.3*204 related entries.")
 S SCX=$$UPCLNLST^SCMCUT("SD*5.3*204^1.2.2.0^1^1^1")
 I +SCX<1 D WMESS("SD*5.3*204 related entries not updated.")
 ;
Q D MESS("")
 D MESS("PCMM files update finished.")
 Q
 ;
BMESS(SCX) ;
 D BMES^XPDUTL("******")
 D MESS(SCX)
 D MESS("")
 Q
 ;
WMESS(SCX) ;
 D MESS(" WARNING:")
 D MESS(" ."_SCX)
 Q
 ;
MESS(SCX) ;
 D MES^XPDUTL("."_SCX)
 Q
 ;
