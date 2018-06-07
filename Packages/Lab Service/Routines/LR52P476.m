LR52P476 ;AITC/CR - Post Installation for Patch 476 ; 11/28/17 12:36pm
 ;;5.2;LAB SERVICE;**476**;Sep 27, 1994;Build 11
 ; Stuff codes #1, #20.5 and #26.5 in the Execute Code file, #62.07, field #1,
 ; for the three records that follow below:
 ;
 Q
ERR ; keep a history of any error that happened during the installation
 D BMES^XPDUTL("Post initialization of LR*5.2*476 did not complete.")
 I $D(LRERR) D BMES^XPDUTL(.LRERR)
 ;alert the user if any error occurred
 I $D(LRERR) D
 .N LRTEXT,XMDUZ,XMY,XMDUZ,XMSUB,XMTEXT
 .S XMSUB="ERROR ENCOUNTERED WHILE INSTALLING LR*5.2*476"
 .S XMDUZ=.5
 .S XMY(DUZ)="",XMY(XMDUZ)=""
 .S LRTEXT(1)="During the post-installation operations of patch"
 .S LRTEXT(2)="LR*5.2*476, an error occurred. Please look at the"
 .S LRTEXT(3)="installation log of the patch for details."
 .S XMTEXT="LRTEXT("
 .D ^XMD
 Q
 ;
POST ; edit field #1 for the Bacteriology record (#7)
 I $G(DUZ)="" D BMES^XPDUTL("Your DUZ is not identified in VistA, quiting...") Q
 ;
 D BMES^XPDUTL("Starting Post-Initialization for LR*5.2*476 ...")
 N DA,DIE,DR,LRFDA,LRCODE1,LRCODE2,LRCODE3,LRNECODE,LRERR,LRMICROEC,LRNEC
 ;
 S LRCODE1="BACTERIOLOGY",LRCODE2="TB BACTERIOLOGY",LRCODE3="MYCOLOGY"
 S LRIEN1=$$FIND1^DIC(62.07,,"MX",LRCODE1) ;IEN for the execute code record
 S LRIEN2=$$FIND1^DIC(62.07,,"MX",LRCODE2)
 S LRIEN3=$$FIND1^DIC(62.07,,"MX",LRCODE3)
 F DA=LRIEN1,LRIEN2,LRIEN3 L +^LAB(62.07,DA):5 I '$T D BMES^XPDUTL("Cannot lock file - try later.") G ERR
 ;
 S LRMICROEC=$$GET1^DIQ(62.07,LRIEN1_",",1) ; current execute code before changes
 D BMES^XPDUTL("Execute Code for Bacteriology before changes:")
 D BMES^XPDUTL(LRMICROEC)
 S LRNECODE="S DR=""11.55////""_DUZ_"";.055;.05;.99;11.6;11.5;1;S LRSPEC=$P(LRBG0,U,5),Y=$S(LRSPEC=71:11.57,LRSPEC=68:11.58,1:0);11.57;S Y=0;11.58"",LREND=0 D ^DIE S:$D(Y) LREND=1 Q:$D(Y)  D ^LRMIBUG Q:LREND  S DR=""13;11"" D ^DIE Q"
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
 ; edit field #1 for the TB Bacteriology record (#8)
 S LRMICROEC=$$GET1^DIQ(62.07,LRIEN2_",",1)
 D BMES^XPDUTL("Execute Code for TB Bacteriology before changes:")
 D BMES^XPDUTL(LRMICROEC)
 S LRNECODE="S DR=""25.5////""_DUZ_"";.05;.99;23;24;25;26;26.5;27;22"",DR(2,63.39)="".01;1:99"" D ^DIE Q"
 S DIE="^LAB(62.07,",DR="1///@",DA=LRIEN2 D ^DIE
 ;
 S DA=LRIEN2
 D UPDATE
 D BMES^XPDUTL("Execute Code for TB Bacteriology after changes:")
 S LRNEC=$$GET1^DIQ(62.07,LRIEN2_",",1)
 D BMES^XPDUTL(LRNEC)
 D BMES^XPDUTL("============================================================")
 ; edit field #1 for the Mycology record (#9)
 S LRMICROEC=$$GET1^DIQ(62.07,LRIEN3_",",1)
 D BMES^XPDUTL("Execute Code for Mycology before changes:")
 D BMES^XPDUTL(LRMICROEC)
 S LRNECODE="S DR=""19.5////""_DUZ_"";.05;.99;19;19.2;20;20.5;21;18"",DR(2,63.37)="".01:99"" D ^DIE Q"
 S DIE="^LAB(62.07,",DR="1///@",DA=LRIEN3 D ^DIE
 ;
 S DA=LRIEN3
 D UPDATE
 D BMES^XPDUTL("Execute Code for Mycology after changes:")
 S LRNEC=$$GET1^DIQ(62.07,LRIEN3_",",1)
 D BMES^XPDUTL(LRNEC)
 D BMES^XPDUTL("Post-initialization of LR*5.2*476 completed!")
 F DA=LRIEN1,LRIEN2,LRIEN3 L -^LAB(62.07,DA)
 Q
 ;
UPDATE ; common code for update of field #1, Execute Code File
 S LRFDA(62.07,DA_",",1)=LRNECODE
 D FILE^DIE("E","LRFDA","LRERR")
 I $D(LRERR) D BMES^XPDUTL("Unable to edit the Execute Code field of Record #: "_DA) D ERR
 Q
