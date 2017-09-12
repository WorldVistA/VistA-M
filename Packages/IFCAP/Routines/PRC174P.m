PRC174P ;OI&T/KCL,DDA - PRC*5.1*174 INSTALL UTILITIES ;6/23/13  22:16
V ;;5.1;IFCAP;**174**;Oct 20, 2000;Build 23
 ;
 ;--------------------------------------------------
 ;Patch PRC*5.1*174: Environment, Pre-Install, and
 ;Post-Install entry points.
 ;--------------------------------------------------
 ;
ENV ;Main entry point for Environment check items
 ;Per KIDS documentation: During the environment check routine,
 ;use of direct WRITEs must be used for output messages.
 ;
 ;KIDS variable to indicate if install should abort
 ;if SET = 2, then abort entire installation
 S XPDABORT=""
 ;
 ;check programmer variables
 W !!,">>> Check programmer variables..."
 D PROGCHK(.XPDABORT)
 Q:XPDABORT=2
 W "Successful"
 ;
 ;success
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items
 Q
 ;
 ;
POST ;Main entry point for Post-init items
 ;
 ; Supported ICRs:
 ;  #10141 - Allows use of supported Kernel call BMES^XPDUTL
 ;  #5819 - Allows setting of ID nodes within a file DD.
 ;
 ;
 ;Item 1 - kill extraneous temp global node being set in patch PRC*5.1*167
 D BMES^XPDUTL(">>> Cleaning up extraneous temporary global node...")
 K ^TMP("KCLTST","AOESIG")
 D MES^XPDUTL("    Cleanup completed.")
 ;
 ;Item 2 - set ID node for Control Point Activity (#410) file. Change covered by ICR #5819
 D BMES^XPDUTL(">>> Setting ID node for Control Point Activity file #410...")
 S ^DD(410,0,"ID","Z3")="D:$P($G(^(1)),U,8)]"""" EN^DDIOL(""Accepted by eCMS"",,""?0""),EN^DDIOL("" "",,""!?2"")"
 D MES^XPDUTL("    Setting ID node completed.")
 ;
 ;Item 3 - data clean-up - store Station and Sub-station as appropriate for OUTBOUND events in file 414.06
 D BMES^XPDUTL(">>> Storing IFCAP/ECMS TRANSACTION #414.06 missing station/sub-station data...")
 ; Loop on the file-wide AED index to check every event in the file
 S PRCHEVDT=0
 F  S PRCHEVDT=$O(^PRCV(414.06,"AED",PRCHEVDT)) Q:+PRCHEVDT'>0  D
 . S PRCHIEN=0
 . F  S PRCHIEN=$O(^PRCV(414.06,"AED",PRCHEVDT,PRCHIEN)) Q:+PRCHIEN'>0  D
 .. S PRCHEIEN=0
 .. F  S PRCHEIEN=$O(^PRCV(414.06,"AED",PRCHEVDT,PRCHIEN,PRCHEIEN))  Q:+PRCHEIEN'>0  S PRCH410=$P(^PRCV(414.06,PRCHIEN,0),"^",3),PRCHTYPE=$P(^PRCV(414.06,PRCHIEN,1,PRCHEIEN,0),"^",2) D
 ... K PRC41406 S PRCHGO=0
 ... I (PRCHTYPE=1)!(PRCHTYPE=4) D GETSTN^PRCHJTA(PRCH410) D
 .... S:PRCVSTN'="" PRC41406(414.061,PRCHEIEN_","_PRCHIEN_",",1)=PRCVSTN,PRCHGO=1
 .... S:PRCVSUB'="" PRC41406(414.061,PRCHEIEN_","_PRCHIEN_",",2)=PRCVSUB,PRCHGO=1
 .... D:PRCHGO FILE^DIE("","PRC41406")
 ....Q
 ...Q
 ..Q
 .Q
 K PRCHEVDT,PRCHIEN,PRCHEIEN,PRCH410,PRCHTYPE,PRCVSTN,PRCVSUB,PRCH41406,PRCHGO
 D MES^XPDUTL("    Storing missing data completed.")
 ;
 ;Item 4 - data clean-up - store Station and Sub-station as appropriate for OUTBOUND events in file 414.06
 D BMES^XPDUTL(">>> Building new cross-references ""AUNQFCP"" and ""AUNQEC"" in IFCAP/ECMS TRANSACTION #414.06...")
 ; Build AUNQFCP
 S DIK="^PRCV(414.06,",DIK(1)=".01^AUNQFCP"
 D ENALL^DIK K DIK
 ; Build AUNQEC
 N DA S PRCHIEN=0
 F  S PRCHIEN=$O(^PRCV(414.06,PRCHIEN)) Q:+PRCHIEN'>0  S DA(1)=PRCHIEN,DIK(1)="6^AUNQEC",DIK="^PRCV(414.06,"_DA(1)_",1," D ENALL^DIK K DIK
 K PRCHIEN
 D MES^XPDUTL("    Cross-references ""AUNQFCP"" and ""AUNQEC"" have been built.")
 Q
 ;
PROGCHK(XPDABORT) ;Check for required programmer variables
 ;This procedure will determine if the installers programmer variables are set up.
 ;Per KIDS documentation: During the environment check routine, use of direct
 ;WRITEs must be used for output messages.
 ;
 ;  Input: 
 ;   XPDABORT - KIDS var to indicate if install should
 ;              abort, passed by reference
 ;
 ; Output:
 ;   XPDABORT - if = 2, then abort entire installation
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 . W !!,"    **********"
 . W !,"      ERROR: Environment check failed!"
 . W !,"      Your programming variables are not set up properly. Once"
 . W !,"      your programming variables are set up correctly, re-install"
 . W !,"      this patch PRC*5.1*174."
 . W !,"    **********"
 . ;tell KIDS to abort the entire installation of the distribution
 . S XPDABORT=2
 Q
