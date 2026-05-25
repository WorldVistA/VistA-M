SR220UTL ;HDSO/NMG - YEARLY CPT EXCLUSION UPDATES; Jun 18, 2025@11:23
 ;;3.0;Surgery;**220**;24 Jun 93;Build 2
 ;
ENV ;
 S SRBACKUP="SR"_$E($T(+1),3,5)_" PRE INSTALL BACKUP"
 I $D(^XTMP(SRBACKUP)) D
 . ;Field test sites will already have a backup, so they can continue the install.
 . N DIR,DTOUT,DUOUT
 . S DIR(0)="YN",DIR("B")="NO"
 . S DIR("A",1)="Backup of the CPT EXCLUSIONS (#137) file has already occurred."
 . S DIR("A",2)="If this site was a field test site for patch SR*3.0*220,"
 . S DIR("A",3)="patch installation may proceed."
 . S DIR("A")="Was this site a field test site"
 . D ^DIR
 . I $D(DUOUT)!($D(DTOUT))!('Y) D
 . . S XPDABORT=1
 . . D BMES^XPDUTL($$CJ^XLFSTR("Submit a ServiceNow ticket for assistance.",80))
 . . K ^XTMP(SRBACKUP,1)
 Q
 ;
PRE ;
 N SRBACKUP
 S SRBACKUP="SR"_$E($T(+1),3,5)_" PRE INSTALL BACKUP"
 ;Do not back up again if field test site already backed the file up.
 I $D(^XTMP(SRBACKUP,1)) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Backup of CPT EXCLUSIONS (#137) file not needed",80))
 . D BMES^XPDUTL($$CJ^XLFSTR("if backup was already performed and this is a field test site.",80))
 S ^XTMP(SRBACKUP,0)=$$FMADD^XLFDT(DT,120)_"^"_$G(DT)_"^Backup of file 137 before update"
 D BMES^XPDUTL($$CJ^XLFSTR("Backing up the CPT EXCLUSIONS file (#137) to ^XTMP("""_SRBACKUP_""")",80))
 M ^XTMP(SRBACKUP,137)=^SRO(137) S ^XTMP(SRBACKUP,1)=DT
 D BMES^XPDUTL($$CJ^XLFSTR("Backup complete.",80))
 Q
 ;
POST ; -- post-install process
 N SRI,SRJ,SRLIST,SRX,SRY,DIK,DA,X
 S DIK="^SRO(137,"
 F SRJ=1:1 S SRLIST=$P($T(DELETES+SRJ)," ;;",2) Q:SRLIST=""  D
 . F SRI=1:1 S SRX=$P(SRLIST,",",SRI) Q:SRX=""  I $D(^ICPT("B",SRX)) D
 . . S SRY=$O(^ICPT("B",SRX,0)) Q:SRY=""
 . . ;No need to attempt a delete if not in the file.
 . . I $D(^SRO(137,SRY)) S DA=SRY D ^DIK
 F SRJ=1:1 S SRLIST=$P($T(ADDS+SRJ)," ;;",2) Q:SRLIST=""  D
 . F SRI=1:1 S SRX=$P(SRLIST,",",SRI) Q:SRX=""  I $D(^ICPT("B",SRX)) D
 . . S SRY=$O(^ICPT("B",SRX,0)) Q:SRY=""
 . . ;Do not add if code is already in the file.
 . . I '$D(^SRO(137,SRY)) D
 . . . K DA,DIC,DD,DO,DINUM S (DINUM,X)=SRY
 . . . S DIC="^SRO(137,",DIC(0)="L" D FILE^DICN
 D BMES^XPDUTL($$CJ^XLFSTR("  Update of CPT EXCLUSIONS (#137) file completed.",80))
 Q
 ;
BACK ; -- rollback
 N SRBACKUP,SRTXT
 S SRBACKUP="SR"_$E($T(+1),3,5)_" PRE INSTALL BACKUP"
 I '$D(^XTMP(SRBACKUP)) D  Q
 . W !,"Backup file has not been set yet or was set and was deleted after six months."
 I '$D(^SRO(137,0))#2 D  Q
 . W !,"File #137 hasn't been set up yet, so no data to delete."
 S SRTXT="File #137 doesn't have any data, so nothing to delete."
 I '$O(^SRO(137,0)) D DISP Q
 W !,"Restoring file 137 from the backup..."
 K ^SRO(137)
 S ^SRO(137,0)="CPT EXCLUSIONS^137P^^0"
 M ^SRO(137)=^XTMP(SRBACKUP,137)
 ;Kill the backup in case the patch needs to be installed again.
 K ^XTMP(SRBACKUP)
 W !!,"Rollback completed."
 Q
 ;
DISP ;display one-line text either interactively or within KIDS installation
 I '$D(XPDNM)#2 U 0 W !!?5,SRTXT
 E  D BMES^XPDUTL($$CJ^XLFSTR(SRTXT,80))
 Q
 ;
DELETES ;
 ;;C7503,C7531,C7532,C7534,C7535,C7555,C9742,C9773,C9774,C9775
 ;;C9778,S2053,S2054,S2060,S2061,S2065,S2102,S2103,S2118,S2152
 ;;S2206,S2209,S2235,S2350,S2351
 Q
 ;
ADDS ;
 ;;0868T,0869T,0870T,0871T,0872T,0873T,0874T,0875T,0876T,0877T
 ;;0878T,0879T,0880T,0881T,0882T,0883T,0884T,0885T,0886T,0887T
 ;;0888T,0889T,0890T,0891T,0892T,0893T,0894T,0895T,0896T,0897T
 ;;0898T,0899T,0900T,0901T,0902T,0903T,0904T,0905T,0906T,0907T
 ;;0911T,0912T,0913T,0914T,0915T,0916T,0917T,0918T,0919T,0920T
 ;;0921T,0922T,0923T,0924T,0925T,0926T,0927T,0928T,0929T,0930T
 ;;0931T,0932T,0933T,0934T,0935T,0936T,0937T,0938T,0939T,0940T
 ;;0941T,0942T,0943T,0944T,0945T,0946T,0947T,15011,15012,15013
 ;;15014,15015,15016,15017,15018,25448,3292F,3293F,3294F,32960
 ;;32994,32997,3300F,33016,33017,33018,33019,3301F,3315F,38225
 ;;38226,38227,38228,49186,51721,53865,53866,55881,55882,60660
 ;;60661,61715,64466,64467,64468,64469,64473,64474,66683,76014
 ;;76015,76016,76017,76018,76019,81195,81515,81558,82233,82234
 ;;83884,84393,84394,86581,87513,87564,87594,87626,90624,90684
 ;;90695,92137,93896,93897,93898,96041,98000,98001,98002,98003
 ;;98004,98005,98006,98007,98008,98009,98010,98011,98012,98013
 ;;98014,98015,98016,C8000,C9033,C9081,C9082,C9083,C9169,C9170
 ;;C9171,C9172,C9750
 Q
 ;
