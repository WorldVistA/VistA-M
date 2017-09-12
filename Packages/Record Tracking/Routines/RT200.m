RT200 ;PKE/TROY; clean up 2 old DIC(3,16 references for va200
 ;;2.0;Record Tracking;**29**;10/22/91
 ;
 ; fix 194.5,46 REQUESTING USER for executable code to dic(3
 ; fix 194.5,7  AGE for person multiple in 194.51
 ;
CHKPTS ;Create check points for post-init
 ;Input  : All variables set by KIDS
 ;Output : None
 ;
 ;Declare variables
 N TMP
 ;Create check points
 ;
 ;Change REQUESTING USER entry #46 in file 194.5
 S TMP=$$NEWCP^XPDUTL("RT46","EN46^RT200")
 ;
 ;Change AGE entry #7 in file 194.5
 S TMP=$$NEWCP^XPDUTL("RT7","EN7^RT200")
 Q
 ;
 ;
EN46 ;checkpoint entry
 N OFIELD,NFIELD,DR,DA,DIC,DIE,X,Y
 ;
 S DIC="^DIC(194.5,",DIC(0)="X",X="REQUESTING USER"
 D ^DIC
 I Y'>0 DO  QUIT
 .D BMES^XPDUTL(">>> REQUESTING USER entry NOT found in File #194.5")
 .D BMES^XPDUTL(">>> Please check entry names and/or cross-references")
 .;
 ;
 S DA=+Y
 ;
 S OFIELD="S RTV(RTJ)=$S($D(^DIC(3,+$P(RTQ,""^"",3),0)):$P(^(0),""^""),1:"_"""UNKNOWN"""_")"
 S NFIELD="S RTV(RTJ)=$S($D(^VA(200,+$P(RTQ,""^"",3),0)):$P(^(0),""^""),1:"_"""UNKNOWN"""_")"
 ;
 ;if entry has dic(3 change it to va(200
 I $G(^DIC(194.5,DA,"E"))=OFIELD DO
 . S DIE="^DIC(194.5,"
 . S DR="100///^S X=NFIELD"
 . D ^DIE
 . I $G(^DIC(194.5,DA,"E"))=NFIELD DO
 . . D BMES^XPDUTL(">>> MUMPS CODE TO SET VARIABLE field in REQUESTING USER entry in file #194.5")
 . . D BMES^XPDUTL(">>> was updated to use ^VA(200.")
 ;
 I $G(^DIC(194.5,DA,"E"))'=NFIELD DO
 . D BMES^XPDUTL(">>> MUMPS CODE TO SET VARIABLE field for REQUESTING USER' entry in file 194.5")
 . D BMES^XPDUTL(">>> not found OR doesn't match patch distribution.  Please check this entry.")
 ;
 QUIT
 ;
 ;
EN7 ;checkpoint entry
 N RTDA,DINUM,DLAGO,DR,DA,DIC,DIE,X,Y
 ;
 S DIC="^DIC(194.5,",DIC(0)="X",X="AGE"
 D ^DIC
 I Y'>0 DO  QUIT
 .D BMES^XPDUTL(">>> AGE entry NOT found in File #194.5")
 .D BMES^XPDUTL(">>> Please check entry names and/or cross-references")
 ;
 S (RTDA,DA)=+Y
 ;
 ; if new person entry missing, addit
 I '$D(^DIC(194.5,DA,50,200,0)) DO
 . K DD,DO
 . S DIC="^DIC(194.5,"_DA_",50,"
 . S DIC("P")=$P($G(^DD(194.5,50,0)),U,2)
 . S DIC(0)="L"
 . S DA(1)=DA
 . S DINUM=200
 . S DA="200"
 . S X="200"
 . S DLAGO=194.51
 . S DIC("DR")="2///5"
 . D FILE^DICN
 .;
 . I Y'>0 DO  QUIT
 . . D BMES^XPDUTL(">>> Failed to add NEW PERSON entry in PARENT FILE multiple for the")
 . . D BMES^XPDUTL(">>> AGE entry in file #194.5")
 .;
 . I $P(Y,"^",3) DO
 . . D BMES^XPDUTL(">>> Added NEW PERSON entry to PARENT FILE multiple in AGE entry in file #194.5")
 ;
 S DA=RTDA
 ;if PERSON entry get rid of it
 I $D(^DIC(194.5,DA,50,16,0)) DO
 . S DA(1)=DA,DIK="^DIC(194.5,"_DA_",50,"
 . S DA=16
 . D ^DIK
 . K DIK
 .;
 . I '$D(^DIC(194.5,DA,50,16,0)) DO
 . . D BMES^XPDUTL(">>> Removed PERSON entry from PARENT FILE multiple of AGE entry in file #194.5")
 Q
