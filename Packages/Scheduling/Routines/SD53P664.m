SD53P664 ;ALB/TXH - UPDATE FILE 409.45;07/03/17
 ;;5.3;Scheduling;**664**;AUG 13, 1993;Build 5
 ;
 ; This patch updates the OUTPATIENT CLASSIFICATION STOP CODE EXCEPTION 
 ; file (#409.45).
 ; There are 16 active stop codes will need to remain on the file and 
 ; all the other stop codes will be inactivated effective 10/15/2017.
 ;
 Q
 ;
POST ; Post installation processes
 ;
 D BMES^XPDUTL("SD*5.3*664 Post-Install starts...")
 D MES^XPDUTL("")
 D LOADSC         ; Load stop codes
 D UPDCODES       ; Update 409.45 to "gold" standard
 D ADD            ; Add code if not exist in 409.45
 D BMES^XPDUTL("SD*5.3*664 Post-Install is complete.")
 D MES^XPDUTL("")
 Q
 ;
LOADSC ; Load stop codes
 ;
 K ^XTMP("SDSTOP")
 N SDX,SDXX
 ; Set auto-delete date from XTMP global
 S ^XTMP("SDSTOP",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^Patch SD*5.3*664 Gold Stop Codes"
 F SDX=1:1 S SDXX=$P($T(CODE+SDX),";;",2) Q:SDXX="QUIT"  D
 . S ^XTMP("SDSTOP",$J,SDXX)=""
 Q
 ;
UPDCODES ; Compare existing entries in 409.45 with "gold" entries
 ;
 N SDSC,SDIEN,SDDA,SDDT,SDIX,SDMSG,SDSCIEN,SDSTA
 S SDSC=0 F  S SDSC=$O(^SD(409.45,"B",SDSC)) Q:SDSC'>0  D
 . S SDIEN=0 F  S SDIEN=$O(^SD(409.45,"B",SDSC,SDIEN)) Q:SDIEN'>0  D
 . . ; if entry is not in Gold list
 . . I '$D(^XTMP("SDSTOP",$J,SDSC)) D  Q  ; entry in 409.45 isn't in Gold list
 . . . S SDMSG="     Stop code "_SDSC
 . . . S DA=$O(^SD(409.45,"B",SDSC,0))
 . . . I 'DA D MES^XPDUTL(SDMSG_" could not be found in exemption file... nothing updated.") Q
 . . . ; Get Stop Code IEN from 40.7
 . . . S SDSCIEN=$O(^DIC(40.7,"C",SDSC,0))
 . . . ; Determine if Clinic Stop Code is Exempt from Outpatient Classifications
 . . . I SDSCIEN,$$EX^SDCOU2(SDSCIEN) D  Q
 . . . . ; Check if status already = 0, then skip
 . . . . S SDDT=9999999 S SDDT=+$O(^SD(409.45,DA,"E","B",SDDT),-1) Q:'SDDT  D
 . . . . . S SDIX=999 S SDIX=+$O(^SD(409.45,DA,"E","B",SDDT,SDIX),-1) Q:'SDIX  D
 . . . . . . S SDSTA=$P($G(^SD(409.45,DA,"E",SDIX,0)),U,2)
 . . . . . . Q:SDSTA=0
 . . . . ; add new EFFECTIVE DATE and ACTIVE = 0 no matter what current status is
 . . . . I SDSTA=1 D INACT(DA,0)
 . . . . D MES^XPDUTL(SDMSG_" no longer exempt from classification questions.")
 . . . I 'SDSCIEN D MES^XPDUTL(SDMSG_" already exempt.")
 . . ; if entry exists in Gold list
 . . I $D(^XTMP("SDSTOP",$J,SDSC)) D  Q    ; entry in Gold list
 . . . S DA=$O(^SD(409.45,"B",SDSC,0))
 . . . ; Check ACTIVE status from last entry
 . . . S SDDT=9999999 S SDDT=+$O(^SD(409.45,DA,"E","B",SDDT),-1) Q:'SDDT  D
 . . . . S SDIX=999 S SDIX=+$O(^SD(409.45,DA,"E","B",SDDT,SDIX),-1) Q:'SDIX  D
 . . . . . S SDSTA=$P($G(^SD(409.45,DA,"E",SDIX,0)),U,2)
 . . . . . ; if active, quit
 . . . . . Q:SDSTA=1
 . . . . . ; if inactive, change to active with new EFFECTIVE DATE
 . . . . . I SDSTA'=1 D INACT(DA,1) Q
 Q
 ;
ADD ; Add new entry if not exist in 409.45
 ;
    N DA,DIC,DLAYGO,MSG,SDYQERR,SDYQSTOP,STOPIEN,X,Y
    S SDYQERR=0
    ; Read each code from Gold list, if not exist in 409.45, add it.
    S SDYQSTOP=0 F  S SDYQSTOP=$O(^XTMP("SDSTOP",$J,SDYQSTOP)) Q:SDYQSTOP'>0  D
 . I '$D(^SD(409.45,"B",SDYQSTOP)) D
 . . S MSG="     Stop code "_SDYQSTOP
    . . S DA=$O(^SD(409.45,"B",SDYQSTOP,0))
    . . I 'DA D  Q:SDYQERR
    . . . K DD,DO
    . . . S X=SDYQSTOP,DIC="^SD(409.45,",DIC(0)="L",DLAYGO=409.45
    . . . D FILE^DICN S DA=+Y
    . . . I Y<0 S SDYQERR=1 D MES^XPDUTL(MSG_" could not be added...try again later.")
    . . . I Y>0 D MES^XPDUTL(MSG_" added to file as of 10/15/17")
    . . I $O(^SD(409.45,DA,"E","B",2960901,0)) D MES^XPDUTL(MSG_"...already in file.") Q
    . . D INACT(DA,1)
 Q
 ;
INACT(DA,ONOFF) ; Create entry for active/inactive
 ; Input: DA as IEN of 409.45
 ;        ONOFF as 1 for active; 0 for inactive
 ;
 N DIC,DLAYGO,X,Y
 S DIC="^SD(409.45,"_DA_",""E"","
 S DIC("P")=$P(^DD(409.45,75,0),"^",2)
 S DA(1)=DA
 S DIC(0)="L"
 S X="3171015"
 S DIC("DR")=".02///^S X=ONOFF"
 K DD,D0
 D FILE^DICN
 Q
 ;
CODE ; Stop codes that need to remain on the file.
 ;;104
 ;;105
 ;;106
 ;;107
 ;;108
 ;;109
 ;;115
 ;;128
 ;;144
 ;;145
 ;;149
 ;;150
 ;;151
 ;;153
 ;;421
 ;;703
 ;;QUIT
