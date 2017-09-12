DVBA35P ;ALB/PRH CAPRI CLEANUP POST-INS DVBA*2.7*35 ;03/02/01
 ;;2.7;AMIE;**35**;Apr 10, 1995
 ;
 ; This routine contains pre & post subroutines for patch DVBA*2.7*35
 ;
 ; The post installation routine contains a cleanup routine
 ; which will correct errors in the FORM 7131 file (#396).
 ; These occurred initially when both the Division and Date were
 ; stored in incorrect formats.
 ; Division was stored as a name and should be converted to division
 ; pointer number.
 ; Date was stored as a text date and should be converted to
 ; FileMan format.
 ;
 ; The fields in question (Both piece positions correspond) are;
 ; Division - Node 6 - i.e. ^DVB(396,DA,6)
 ; Date - Node 7 - i.e. ^DVB(396,DA,7)
 ;
 ; Div Field #  Date Field #    Position
 ;    4.6           4.7             9
 ;    5.6           5.7            11
 ;    6.6           6.7            13
 ;    7.6           7.7            15
 ;    9.6           9.7            17
 ;   11.6          11.7            19
 ;   13.6          13.7            21
 ;   15.6          15.7            23
 ;   17.6          17.7             7
 ;   18.6          18.7            26
 ;   20.6          20.7            28
 ;
 ; In addition the post-install will also update the AMIE site
 ; parameter (#396.1) file, field #.11 to extend the number
 ; of days to keep the 2507 REQUEST file (#396.3) to 365 days
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 ;
 Q
 ;
POST ;Main entry point for Post-init items
 ;
 D INIT
 D POST1 ;Correct (#396) file entries
 D POST2 ;Update (#396.1) file, field (#.11)
 D POST3 ;Email totals
 ;
 Q
 ;
INIT ;Post-install Initialization
 ;
 ;The XTMP global will hold four variables
 ;     Piece 1 = Date/Time run stared (FileMan format)
 ;     Piece 2 = Number of Division entries modified - DVBCTR1
 ;     Piece 3 = Number of date entries modified - DVBCTR2
 ;     Piece 4 = History file updated? (0=No 1=Yes)
 ;
 K ^XTMP("DVBA35P")
 S ^XTMP("DVBA35P",0)=$$NOW^XLFDT()_U_0_U_0_U_0
 ;
 Q
 ;
POST1 ;Correct (#396) file entries
 ;
 N DVBCTR1,DVBCTR2
 ;
 D BMES^XPDUTL("  >> starting Post-installation for DVBA*2.7*35")
 ;
 D LOOP
 ;
 I (DVBCTR1+DVBCTR2) D
 . D BMES^XPDUTL("    "_DVBCTR1_" Division entries corrected in FORM 7131 file")
 . D MES^XPDUTL("    "_DVBCTR2_" Date entries corrected in FORM 7131 file")
 ;
 S $P(^XTMP("DVBA35P",0),U,2,3)=DVBCTR1_U_DVBCTR2
 ;
 Q
 ;
POST2 ;Update (#396.1) file, field (#.11)
 ;
 ;Retain 2507 REQUEST (#396.3) file for 365 days
 ;
 N DA,DIE,DR,DVBARR,DVBERR
 ;
 ;First check how many days they retain at the moment
 K DVBARR,DVBERR
 D GETS^DIQ(396.1,1,.11,"I","DVBARR","DVBERR")
 Q:$D(DVBERR)
 I $G(DVBARR(396.1,"1,",.11,"I"))>364 D  Q  ;Already exceeds 364 days
 . S $P(^XTMP("DVBA35P",0),U,4)=0 ;No change
 ;
 S DA=1,DIE="^DVB(396.1,",DR=".11///365"
 D ^DIE
 S $P(^XTMP("DVBA35P",0),U,4)=1 ;Updated
 ;
 D BMES^XPDUTL("  2507 REQUEST FILE (#396.3) History retention updated to 365 days")
 D BMES^XPDUTL("  >> Post-installation completed")
 ;
 Q
 ;
POST3 ; send e-mail to user's
 ;
 ; if not in production account, do not send notification message (exit)
 X ^%ZOSF("UCI") I Y'=^%ZOSF("PROD") Q
 ;
 N DIFROM,DVBCTR1,DVBCTR2,DVBSITE,DVBSTIME,DVBETIME,DVBSTR,DVBTEXT,DVBUPD,XMY,XMDUN,XMDUZ,XMSUB,XMTEXT,XMZ
 S DVBSITE=$$SITE^VASITE
 S DVBSTR=^XTMP("DVBA35P",0)
 S DVBSTIME=$P(DVBSTR,U,1),DVBCTR1=$P(DVBSTR,U,2),DVBCTR2=$P(DVBSTR,U,3)
 S DVBUPD=$P(DVBSTR,U,4)
 S DVBETIME=$$NOW^XLFDT()      ;end date/time
 S XMDUZ=.5,XMY(XMDUZ)="",XMY(DUZ)="",XMTEXT="DVBTEXT("
 S XMY("G.PCMM TESTING@DOMAIN.EXT")=""  ;e-mail all sites totals to
 S XMSUB="Patch DVBA*2.7*35 Post Install Routine ("_$P(DVBSITE,U,3)_")"
 ;
 S DVBTEXT(1)=""
 S DVBTEXT(2)="          Facility Name:  "_$P(DVBSITE,"^",2)
 S DVBTEXT(3)="         Station Number:  "_$P(DVBSITE,"^",3)
 S DVBTEXT(4)=""
 S DVBTEXT(5)="  Date/Time job started:  "_$$FMTE^XLFDT(DVBSTIME)
 S DVBTEXT(6)="  Date/Time job stopped:  "_$$FMTE^XLFDT(DVBETIME)
 S DVBTEXT(7)=""
 S DVBTEXT(8)=$J(DVBCTR1,5)_" Division entries corrected in FORM 7131 file"
 S DVBTEXT(9)=$J(DVBCTR2,5)_" Date entries corrected in FORM 7131 file"
 S DVBTEXT(10)=""
 I DVBUPD S DVBTEXT(11)="  2507 REQUEST FILE (#396.3) History retention updated to 365 days"
 S DVBTEXT(12)=""
 S DVBTEXT(13)="  >> Post-installation completed"
 S DVBTEXT(14)=""
 ;
 D ^XMD
 ;
 K ^XTMP("DVBA35P")
 ;
 Q
 ;
LOOP ;Loop ^DVB(396 file to find incorrect entries and correct them
 ;
 N CNTR,DA,DAX,DIE,DR,DVB6F,DVB7F,DVBARR,DVBERR,DVBDIV,DVBDIVN,DVBDAT,FLD,X,Y
 ;
 S (DA,DVBCTR1,DVBCTR2)=0,DIE="^DVB(396,"
 ;
 ;DVB6F = Relevant Division Fields
 S DVB6F="4.6;5.6;6.6;7.6;9.6;11.6;13.6;15.6;17.6;18.6;20.6"
 ;
 ;DVB7F = Relevant Date Fields
 S DVB7F="4.7;5.7;6.7;7.7;9.7;11.7;13.7;15.7;17.7;18.7;20.7"
 ;
 F  S DA=$O(^DVB(396,DA)) Q:'DA!(DA'?1.N)  D
 . S DAX=DA_","
 . I $D(^DVB(396,DA,6)) D                   ;Division string exists
 . . K DVBARR,DVBERR
 . . D GETS^DIQ(396,DAX,DVB6F,"I","DVBARR","DVBERR")
 . . Q:$D(DVBERR)                           ;Error found
 . . F CNTR=1:1:$L(DVB6F,";") S FLD=$P(DVB6F,";",CNTR) D
 . . . S DVBDIV=$G(DVBARR(396,DAX,FLD,"I"))
 . . . Q:DVBDIV=""                          ;No entry made
 . . . Q:$E(DVBDIV,1)?1N                    ;Division correct format
 . . . S DVBDIVN=$O(^DG(40.8,"B",DVBDIV,""))
 . . . S DR=FLD_"///"_DVBDIVN
 . . . D ^DIE
 . . . S DVBCTR1=DVBCTR1+1
 . ;Now check the Date
 . I $D(^DVB(396,DA,7)) D  ;Date string exists
 . . K DVBARR,DVBERR
 . . D GETS^DIQ(396,DAX,DVB7F,"I","DVBARR","DVBERR")
 . . Q:$D(DVBERR)                           ;Error found
 . . F CNTR=1:1:$L(DVB7F,";") S FLD=$P(DVB7F,";",CNTR) D
 . . . S DVBDAT=$G(DVBARR(396,DAX,FLD,"I"))
 . . . Q:DVBDAT=""                          ;No entry made
 . . . Q:$E(DVBDAT,1)?1N                    ;Date correct format
 . . . S X=DVBDAT D ^%DT
 . . . Q:Y=-1
 . . . S DR=FLD_"///"_Y
 . . . D ^DIE
 . . . S DVBCTR2=DVBCTR2+1
 ;
 Q
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("*****")
 . S XPDABORT=2
 ;
 Q
 ;
PARMCHK(XPDABORT) ;checks for proper param file ien
 ;
 I '$D(^DVB(396.1,1)) D
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Parameter file (#396.1) does not have proper IEN (1).")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("*****")
 . S XPDABORT=2
 ;
 Q
