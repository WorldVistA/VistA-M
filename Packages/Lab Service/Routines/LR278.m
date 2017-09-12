LR278 ;DALOI/FHS - LR*5.2*278 PATCH ENVIRONMENT CHECK ROUTINE;16 -SEP-2001
 ;;5.2;LAB SERVICE;**278**;Sep 27,1994
EN ; Does not prevent loading of the transport global.
 ;Environment check is done only during the install.
 Q:'$D(XPDENV)
 N VER,RN,LN2
 D BMES^XPDUTL($$CJ^XLFSTR("*** Environment check started ***",80))
 D CHECK
EXIT I $G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("Install Environment Check FAILED",IOM))
 I '$G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("Environment Check is Ok ---",IOM))
 Q
CHECK I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D BMES^XPDUTL($$CJ^XLFSTR("Terminal Device is not defined",IOM)) S XPDQUIT=2
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D BMES^XPDUTL($$CJ^XLFSTR("Please Log in to set local DUZ... variables",80)) S XPDQUIT=2
 I '$$ACTIVE^XUSER($G(DUZ)) D BMES^XPDUTL($$CJ^XLFSTR("You are not a valid user on this system",80)) S XPDQUIT=2
 S VER=$$VERSION^XPDUTL("LR")
 I VER'>5.1 D BMES^XPDUTL($$CJ^XLFSTR("You must have LAB V5.2 Installed",IOM)) S XPDQUIT=2
 S VER=$$VERSION^XPDUTL("NLT")
 I VER'=5.254 D BMES^XPDUTL($$CJ^XLFSTR("You must have NLT V5.254 Installed",IOM)) S XPDQUIT=2
 Q
PRE ;Pre-install entry point
 Q:'$D(XPDNM)
 N DA,DIC,DIK,LROK,X,Y
 D BMES^XPDUTL($$CJ^XLFSTR("Removing the data dictionary for WKLD METHOD #.14 ",IOM))
 D BMES^XPDUTL($$CJ^XLFSTR("From LOAD/WORK LIST file (68.2) ",IOM))
 S DIK="^DD(68.2,",DA(1)=68.2,DA=.14 D ^DIK K DIK,DA
 K ^LAM("AL")
 D BMES^XPDUTL($$CJ^XLFSTR("Done - Install will replace the field ",IOM))
 S DIK="^DD(62.06,",DA=64,DA(1)=62.06 D ^DIK K DIK,DA
 S DA(1)=$$LKOPT^XPDMENU("LR7O 60-64")
 I DA(1)>0 D  K DA
 . D BMES^XPDUTL($$CJ^XLFSTR("Removing routine from [LR7O 60-64] Menu",IOM))
 . N DIK
 . S DA=25,DA(2)=19
 . S DIK="^DIC(19,"_DA(1)_"," D ^DIK
 S LROK=$$DELETE^XPDMENU("LRLOINC","LR LOINC MAP ANTIMICROBIAL")
 D
 . N DA,DIK
 . S DA=$$LKOPT^XPDMENU("LR LOINC MAP ANTIMICROBIAL")
 . Q:DA<1  S DIK="^DIC(19," D ^DIK
 Q
POST ;Do reindexing 64.02 field #3
 D BMES^XPDUTL($$CJ^XLFSTR("Reindexing 64.02 field #3",IOM))
 S:$D(^LAM(0))#2 $P(^(0),U,3)=99999
 W !
 N LRIEN,LRSPEC,LRASPECT,DIK,DA,LRDA,X,Y
 S LRIEN=0
 F  S LRIEN=$O(^LAM(LRIEN)) Q:LRIEN<1  D
 . S LRSPEC=0 F  S LRSPEC=$O(^LAM(LRIEN,5,LRSPEC)) Q:LRSPEC<1  D
 . . S LRDA=0 F  S LRDA=$O(^LAM(LRIEN,5,LRSPEC,1,LRDA)) Q:LRDA<1  D SET
 D
 . S LRIEN=0 F  S LRIEN=+$O(^LAB(60,LRIEN)) Q:LRIEN<1  I $D(^(LRIEN,0))#2 D
 . . N DIK,DA
 . . S DA=LRIEN,DIK="^LAB(60,",DIK(1)=".01^B"
 . . D EN1^DIK
 Q
SET ;Set X-Ref on 64.02,3 [^LAM("AL",LAB TEST,WKLD CODE,SPECIMEN,TIME ASPECT)]
 K DIK,DA
 S DA=LRDA,DA(1)=LRSPEC,DA(2)=LRIEN
 S DIK="^LAM("_DA(2)_",5,"_DA(1)_",1,"
 S DIK(1)="3^AL"
 D ENALL^DIK
 W "# "
 Q
