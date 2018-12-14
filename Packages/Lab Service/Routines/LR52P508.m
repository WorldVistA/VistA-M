LR52P508 ;AITC/CR - Cleanup of Execute Code File (#62.07) ; 6/18/18 12:37pm
 ;;5.2;LAB SERVICE;**508**;Sep 27, 1994;Build 8
 ; clean up field #19.2 and specimen #68 in the Execute Code file, #62.07,
 ; in field #1 of file #62.07, the reference to field #19.2 will be deleted for Mycology,
 ; the expression LRSPEC=68 will be replaced with LRSPEC=360 in Bacteriology
 ; the DESCRIPTION field (#6) of file #62.07 will be updated with preliminary comments
 ; for Bacteriology, TB Bacteriology, and Mycology
 Q
 ;
ERR ; keep a history of any error that happened during the installation
 D BMES^XPDUTL("Post-installation of LR*5.2*508 did not complete.")
 I $D(LRERR) D MES^XPDUTL(.LRERR)
 ;alert the user if any error occurred
 I $D(LRERR) D
 .N DIFROM,LRTEXT,XMDUZ,XMY,XMDUZ,XMSUB,XMTEXT
 .S XMSUB="ERROR ENCOUNTERED WHILE INSTALLING LR*5.2*508"
 .S XMDUZ=.5
 .S XMY(DUZ)="",XMY(XMDUZ)=""
 .S LRTEXT(1)="During the post-installation operations of patch"
 .S LRTEXT(2)="LR*5.2*508, an error occurred. Please look at the"
 .S LRTEXT(3)="installation log of the patch for details."
 .S XMTEXT="LRTEXT("
 .D ^XMD
 Q
 ;
 ;
POST ; save the DESCRPTION field in EXECUTE CODE file (#62.07) before changes
 ; lrdsc displays exec code descriptions for bacteriology, tb bacteriology, and mycology
 ; lrien values are national standard IENs for the 3 exec codes above
 I $G(DUZ)="" D BMES^XPDUTL("Your DUZ is not identified in VistA, quitting ...") Q
 D BMES^XPDUTL("Starting Post-Installation for LR*5.2*508")
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Collecting existing DESCRIPTION field information in file #62.07")
 D MES^XPDUTL(" for BACTERIOLOGY (IEN=7), TB BACTERIOLOGY (IEN=8), and MYCOLOGY (IEN=9)")
 N LRFILE,LRFLD,LRIEN,LRROOT
 S LRDSC=""
 S LRFILE=62.07,LRFLD=6,LRROOT=""
 F LRIEN=7,8,9 D
 . S LRDSC=$$GET1^DIQ(LRFILE,LRIEN_",",LRFLD,"","WP") ; get current desc
 . D BMES^XPDUTL("DESCRIPTION field before changes for "_$S(LRIEN=7:"BACTERIOLOGY:",LRIEN=8:"TB BACTERIOLOGY:",LRIEN=9:"MYCOLOGY:",1:""))
 . D MES^XPDUTL(.WP) K WP ;clear array WP to avoid corruption
 D BMES^XPDUTL("====================================================")
 ;
 ; clean up existing desc field and stuff national description with updated prelim comment
 ; check that file is available before updating description field
 F LRIEN=7,8,9 L +^LAB(62.07,LRIEN):5 I '$T D BMES^XPDUTL("Cannot lock file - try later.") G ERR
 D BMES^XPDUTL("Deleting existing data in the DESCRIPTION field of File #62.07 ...")
 F LRIEN=7,8,9 D WP^DIE(LRFILE,LRIEN_",",LRFLD,"K",LRROOT) ;
 D BMES^XPDUTL("DESCRIPTION field is now empty.")
 ;
 D BMES^XPDUTL("Updating DESCRIPTION field of File #62.07 with national definitions ...")
 ; add national descritpion with preliminary comment to bacteriology
 ; bacteriology, ien=7, comment field is #6 in file #62.07
 K LRTXT,WP
 S LRTXT(1)="Stuff BACT PERSON with current user; COLLECTION SAMPLE;"
 S LRTXT(2)="SITE/SPECIMEN; COMMENT ON SPECIMEN; BACT RPT STATUS; PRELIMINARY BACT COMMENT;"
 S LRTXT(3)="if specimen is urine use URINE SCREEN; if specimen is sputum use SPUTUM SCREEN."
 S LRTXT(4)="Enter the ORGANISM and antibiotics (edit templates may be utilized); BACT RPT REMARK; BACT RPT DATE APPROVED."
 S LRCOMM=6
 S LRIEN=7 D WP^DIE(LRFILE,LRIEN_",",LRCOMM,"A","LRTXT")
 S LRDSC=$$GET1^DIQ(LRFILE,LRIEN_",",LRFLD,"","WP")
 D BMES^XPDUTL("DESCRIPTION Field after changes for BACTERIOLOGY:")
 D MES^XPDUTL("")
 D MES^XPDUTL(.WP) ; output refreshed description of exec code
 ; ========================================= 
 ;
 ; add national description with preliminary comment for tb bacteriology
 K LRTXT,WP
 S LRTXT(1)="Stuff TB ENTERING PERSON with current user; SITE/SPECIMEN;"
 S LRTXT(2)="COMMENT ON SPECIMEN; TB RPT STATUS; ACID FAST STAIN; QUANTITY; multiple"
 S LRTXT(3)="MYCOBACTERIUM including QUANTITY, COMMENTS and DRUGS; PRELIMINARY TB COMMENT;"
 S LRTXT(4)="TB RPT REMARK; TB RPT DATE APPROVED."
 S LRIEN=8 D WP^DIE(LRFILE,LRIEN_",",LRCOMM,"A","LRTXT")
 S LRDSC=$$GET1^DIQ(LRFILE,LRIEN_",",LRFLD,"","WP")
 D BMES^XPDUTL("DESCRIPTION Field after changes for TB BACTERIOLOGY:")
 D MES^XPDUTL("")
 D MES^XPDUTL(.WP) ; output refreshed description of exec code
 ; ========================================== 
 ;
 ; add national description with preliminary comment to mycology
 K LRTXT,WP
 S LRTXT(1)="Stuff MYC PERSON with current user; SITE/SPECIMEN; COMMENT ON"
 S LRTXT(2)="SPECIMEN; MYCOLOGY RPT STATUS; multiple FUNGUS/YEAST including QUANTITY and"
 S LRTXT(3)="COMMENTS; PRELIMINARY MYCOLOGY COMMENT; MYCOLOGY RPT REMARK; MYCOLOGY RPT DATE APPROVED."
 S LRIEN=9 D WP^DIE(LRFILE,LRIEN_",",LRCOMM,"A","LRTXT")
 S LRDSC=$$GET1^DIQ(LRFILE,LRIEN_",",LRFLD,"","WP")
 D BMES^XPDUTL("DESCRIPTION Field after changes for MYCOLOGY:")
 D MES^XPDUTL("")
 D MES^XPDUTL(.WP) ; output refreshed description of exec code
 D BMES^XPDUTL("Completed updating Description field in File #62.07 - LR*5.2*508")
 K LRTXT,LRDSC,WP
 D POST1
 Q
 ;
POST1 ; edit field #1 for the Bacteriology record (#7)
 ;
 D BMES^XPDUTL("Continuing Post-Installation for LR*5.2*508 ...")
 N DA,DIE,DR,LRFDA,LRCODE1,LRCODE2,LRCODE3,LRNECODE,LRERR,LRMICROEC,LRNEC
 ;
 S LRCODE1="BACTERIOLOGY",LRCODE3="MYCOLOGY"
 S LRIEN1=$$FIND1^DIC(62.07,,"MX",LRCODE1) ;IEN for the execute code record
 S LRIEN3=$$FIND1^DIC(62.07,,"MX",LRCODE3)
 F DA=LRIEN1,LRIEN3 L +^LAB(62.07,DA):5 I '$T D BMES^XPDUTL("Cannot lock file - try later.") G ERR
 ;
 S LRMICROEC=$$GET1^DIQ(62.07,LRIEN1_",",1) ; current execute code before changes
 D BMES^XPDUTL("Execute Code for Bacteriology before changes:")
 D BMES^XPDUTL(LRMICROEC)
 S LRNECODE="S DR=""11.55////""_DUZ_"";.055;.05;.99;11.6;11.5;1;S LRSPEC=$P(LRBG0,U,5),Y=$S(LRSPEC=71:11.57,LRSPEC=360:11.58,1:0);11.57;S Y=0;11.58"",LREND=0 D ^DIE S:$D(Y) LREND=1 Q:$D(Y)  D ^LRMIBUG Q:LREND  S DR=""13;11"" D ^DIE Q"
 ; prepare field for new data
 S DIE="^LAB(62.07,",DR="1///@",DA=LRIEN1 D ^DIE
 ;
 S DA=LRIEN1
 D UPDATE
 D BMES^XPDUTL("Execute Code for Bacteriology after changes:")
 S LRNEC=$$GET1^DIQ(62.07,LRIEN1_",",1) ; updated execute code 
 D BMES^XPDUTL(LRNEC)
 D BMES^XPDUTL("============================================================")
 ;
 ; edit field #1 for the Mycology record (#9)
 S LRMICROEC=$$GET1^DIQ(62.07,LRIEN3_",",1)
 D BMES^XPDUTL("Execute Code for Mycology before changes:")
 D BMES^XPDUTL(LRMICROEC)
 S LRNECODE="S DR=""19.5////""_DUZ_"";.05;.99;19;20;20.5;21;18"",DR(2,63.37)="".01:99"" D ^DIE Q"
 S DIE="^LAB(62.07,",DR="1///@",DA=LRIEN3 D ^DIE
 ;
 S DA=LRIEN3
 D UPDATE
 D BMES^XPDUTL("Execute Code for Mycology after changes:")
 S LRNEC=$$GET1^DIQ(62.07,LRIEN3_",",1)
 D BMES^XPDUTL(LRNEC)
 D BMES^XPDUTL("Post-Installation of LR*5.2*508 completed!")
 F DA=LRIEN1,LRIEN3 L -^LAB(62.07,DA)
 Q
 ;
UPDATE ; common code for update of field #1, Execute Code File
 S LRFDA(62.07,DA_",",1)=LRNECODE
 D FILE^DIE("E","LRFDA","LRERR")
 I $D(LRERR) D BMES^XPDUTL("Unable to edit the Execute Code field of Record #: "_DA) D ERR
 Q
