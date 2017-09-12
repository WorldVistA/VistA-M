LR153 ;DALISC/JMC/FHS - LR*5.2*153 PATCH ENVIRONMENT CHECK ROUTINE ; 12/3/1997
 ;;5.2;LAB SERVICE;**153**;Sep 27, 1994
EN ; Does not prevent loading of the transport global.
 ; Environment check is done only during the install.
 Q:'$G(XPDENV)
 D CHECK
 D EXIT
 Q
 ;
CHECK ; Perform environment check
 N VER
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Terminal Device is not defined",80))
 . S XPDQUIT=2
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Please log in to set local DUZ... variables",80))
 . S XPDQUIT=2
 I '$D(^VA(200,$G(DUZ),0))#2 D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("You are not a valid user on this system",80))
 . S XPDQUIT=2
 S VER=$$VERSION^XPDUTL("LA7")
 I VER'>5.1 D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("You must have LAB MESSAGING V5.2 Installed",80))
 . S XPDQUIT=2
 S XPDIQ("XPZ1","B")="NO"
 Q
 ;
EXIT ;
 I $G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Install Environment Check FAILED ---",80))
 I '$G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Environment Check is Ok ---",80))
 Q
 ;
PRE ; KIDS Pre install for LR*5.2*153
 S:$D(^LAM(0))#2 $P(^(0),U,3)=99999
 S X=$P($G(^LAB(64.061,0)),U,1,2) I $L(X) D
 . K ^LAB(64.061) S ^LAB(64.061,0)=X
 I $D(^DD(64.061,6,0))#2 D
 . N DIK,DA
 . S DIK="^DD(64.061,",DA(1)=64.061,DA=6
 . D ^DIK
 I $$GET1^DID(64.6,695000,"","LABEL")'="DOMAIN NAME" D
 . D BMES^XPDUTL($$CJ^XLFSTR("*** Disregard KIDS install failure message ***",80))
 . D BMES^XPDUTL($$CJ^XLFSTR("*** concerning file INTERIM REPORTS (#64.6)***",80))
 . D BMES^XPDUTL($$CJ^XLFSTR("*** DD for this file is only installed if site ***",80))
 . D BMES^XPDUTL($$CJ^XLFSTR("*** has local field #695000, DOMAIN NAME ***",80))
 Q
 ;
POST ; KIDS Post install for LR*5.2*153
 ; Add menu option
 ; Check HL7 codes mapping in Urgency (62.05) file.
 ; Set HL7 urgency to "(R)outine" if not defined.
 N LRX
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install started ***",80))
 ;
 ; Add menu option
 W !
 D BMES^XPDUTL($$CJ^XLFSTR("*** Adding new Menus ***",80))
 S LRX=$$ADD^XPDMENU("LR IN","LRLEDI")
 D BMES^XPDUTL($$CJ^XLFSTR("Referral Patient Multi-purpose Accession [LRLEDI] option",80))
 D BMES^XPDUTL($$CJ^XLFSTR("was"_$S(LRX:"",1:" NOT")_" added to the Accessioning Menu [LR IN] ",80))
 W !
 S LRX=$$ADD^XPDMENU("LR WKLD","LR TAT URGENCY")
 D BMES^XPDUTL($$CJ^XLFSTR("Turnaround times By Urgency",80))
 D BMES^XPDUTL($$CJ^XLFSTR("was"_$S(LRX:"",1:" NOT")_" added to Lab statistics menu [LR WKLD ",80))
 W !
 S LRX=$$ADD^XPDMENU("LR SUPER/WKLD MENU","LR TAT URGENCY")
 D BMES^XPDUTL($$CJ^XLFSTR("Turnaround times By Urgency",80))
 D BMES^XPDUTL($$CJ^XLFSTR("was"_$S(LRX:"",1:" NOT")_" added to Supervisor workload menu ",80))
 D BMES^XPDUTL($$CJ^XLFSTR("[LR SUPER/WKLD MENU]",80))
 W !
 S LRX=$$ADD^XPDMENU("LR WKLD","LR ORDERED TESTS BY PHY")
 D BMES^XPDUTL($$CJ^XLFSTR("ORDERED TEST COST BY PROVIDER",80))
 D BMES^XPDUTL($$CJ^XLFSTR("was"_$S(LRX:"",1:" NOT")_" added to Lab statistics menu [LR WKLD ",80))
 W !
 W !!
 ; Check HL7 mapping
 D BMES^XPDUTL($$CJ^XLFSTR("Checking mapping of HL7 Table of Priority to DHCP Urgency file # 62.05",80))
 D BMES^XPDUTL($$CJ^XLFSTR("Setting those entries missing a mapping to (R)outine",80))
 N LRFLAG,LRI,X
 S (LRFLAG,LRI)=0
 F  S LRI=$O(^LAB(62.05,LRI)) Q:'LRI!(LRI>49)  D
 . S X=$G(^LAB(62.05,LRI,0))
 . I $P(X,"^",4)="" D
 . . S $P(^LAB(62.05,LRI,0),"^",4)="R",LRFLAG=1
 . . D BMES^XPDUTL("Setting HL7 CODE (#3) for URGENCY entry "_$P(X,"^",1)_" to (R)outine")
 I 'LRFLAG D BMES^XPDUTL($$CJ^XLFSTR("No entries found missing a mapping to HL Table of Priority",80))
 ;
 ; Re-index field 64.1 in file #60
 D BMES^XPDUTL($$CJ^XLFSTR("Re-Indexing RESULT NLT CODE field 64.1 of file 60",80))
 N DIK
 S DIK="^LAB(60,",DIK(1)="64.1" W ! D ENALL^DIK W !
 ;
537 ;Set ID field in ^DD(537010,0,"ID")
 S ^DD(537010,0,"ID",2)="D EN^DDIOL($P(^(0),U,3),"""",""?15"")"
 D C61
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install completed ***",80))
 Q
C61 ; Convert File #61 to File #64.061
 N LAI,LAHL7,LA64,DA,DIK
 S LAI=0 F  S LAI=$O(^LAB(61,LAI)) Q:+LAI'>0  I $D(^LAB(61,LAI,0)) S LAHL7=$P(^LAB(61,LAI,0),U,8) I LAHL7'="" S LA64=$O(^LAB(64.061,"D",$$SP(LAHL7),0)) D:LA64'=""
 . S $P(^LAB(61,LAI,0),U,9)=LA64 S DIK="^LAB(61,",DA=LAI,DIK(1)=".09^HL7" D EN1^DIK K DIK,DA
C6205 ;Convert File #62.05 to File #64.061
 S LAI=0 F  S LAI=$O(^LAB(62.05,LAI)) Q:+LAI'>0  I $D(^LAB(62.05,LAI,0)) S LAHL7=$P(^LAB(62.05,LAI,0),U,4) I LAHL7'="" S LA64=$O(^LAB(64.061,"D",LAHL7,0)) D:LA64'=""
 . S $P(^LAB(62.05,LAI,0),U,5)=LA64 S DIK="^LAB(62.05,",DA=LAI,DIK(1)="4^AC" D EN1^DIK K DIK,DA
 Q
SP(X) ;Convert Abbrv from HL7 V2.3 > V2.3 0070 table
 I X="ABLD" Q "BLDA"
 I X="CBLD" Q "BLDCO"
 I X="PER" Q "PRT"
 I X="TISL" Q "TLNG"
 I X="BRTH" Q "EXHLD"
 I X="TISC" Q "CUR"
 I X="TISPL" Q "PLC"
 I X="TISB" Q "MAR"
 Q X
