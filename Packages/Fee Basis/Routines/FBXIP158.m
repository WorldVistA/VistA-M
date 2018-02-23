FBXIP158 ;WCIOFO/SLT-PATCH INSTALL ROUTINE ;5/27/2006
 ;;3.5;FEE BASIS;**158**;JAN 30, 1995;Build 94
 Q
 ;
EN ; post-install entry point
 D MES^XPDUTL("Post-install start...")
 D ITC,ROPT,UPDSITE,ADJRSN
 D CSGR^FBX2P158
 D MES^XPDUTL("Post-install complete.")
 Q
 ;
ITC ;Recompile Input Templates
 N FBC,DMAX,FBMAX,FBN
 S FBMAX=$$ROUSIZE^DILF
 D MES^XPDUTL("  Recompiling affected input templates ...")
 F FBC=1:1 S FBN=$P($T(TMPL+FBC),";;",2) Q:FBN=""  D COMP(FBN,FBMAX)
 D MES^XPDUTL("  done.")
 Q
 ;
COMP(TNAME,DMAX) ; Compile the Input Template
 N FBIEN,FBRTN,X,Y
 ;find the ien of the input template
 S FBIEN=$O(^DIE("B",TNAME,0)) Q:'FBIEN
 ;quit if input template not compiled
 S FBRTN=$P($G(^DIE(FBIEN,"ROUOLD")),U) Q:FBRTN=""
 D MES^XPDUTL("    Compiling "_TNAME_" , compiled routine is "_FBRTN_" ...")
 S X=FBRTN,Y=FBIEN
 D EN^DIEZ
 D MES^XPDUTL("    done.")
 D MES^XPDUTL("")
 Q
 ;
ROPT ; remove option from parent option
 N POIEN,COIEN,DA,DIK
 D MES^XPDUTL("  Removing Option FB FPPS TRANSMIT from FB FPPS UPDATE MENU...")
 Q:'$D(^DIC(19,"B","FB FPPS UPDATE MENU"))
 S (POIEN,COIEN,DA)=0
 S POIEN=$O(^DIC(19,"B","FB FPPS UPDATE MENU",""))
 I POIEN S COIEN=$O(^DIC(19,"B","FB FPPS TRANSMIT",""))
 I COIEN D
 . S DA=$O(^DIC(19,POIEN,10,"B",COIEN,"")) Q:'DA
 . S DA(1)=POIEN,DIK="^DIC(19,"_DA(1)_",10,"
 . D ^DIK
 D MES^XPDUTL("  done.")
 Q
 ;
UPDSITE ; update FEE BASIS SITE PARAMETERS file, MAX #* fields
 N SIEN
 D MES^XPDUTL("  Updating FEE BASIS SITE PARAMETERS file, MAX #* fields...")
 I '$D(^FBAA(161.4,0)) D MES^XPDUTL("   Site Parameters file undefined. Unable to continue.") Q
 S SIEN=$P(^FBAA(161.4,0),U,3)
 I 'SIEN D MES^XPDUTL("   A single entry is required in Site Parameters. Unable to continue.") Q
 I $D(^FBAA(161.4,SIEN)) D
 . S $P(^FBAA(161.4,SIEN,"FBNUM"),U,3)=50  ;MAX # PAYMENT LINE ITEMS (#17)
 . S $P(^FBAA(161.4,SIEN,"FBNUM"),U,4)=30  ;MAX # CH PAYMENT LINES (#17.1)
 . S $P(^FBAA(161.4,SIEN,"FBNUM"),U,5)=30  ;MAX # CNH PAYMENT LINES (#17.2)
 D MES^XPDUTL("  done.")
 Q
 ;
ADJRSN ; changed "B1 " to "B1" in the adjustment reason file #161.91
 N DIC,DIE,DA,DR,X,Y,NUM,FBC
 S X="B1 "
 S DIC="^FB(161.91," D ^DIC S NUM=+Y
 Q:NUM=-1
 ; update entry
 S DA=NUM
 S FBC="B1"
 S DR=".01////^S X=FBC"
 S DIE="^FB(161.91,"
 D ^DIE
 Q
 ;
 ;
TMPL ;;
 ;;FBCH EDIT PAYMENT
 ;;FBCH ENTER PAYMENT
 ;;FBNH EDIT PAYMENT
 ;;
