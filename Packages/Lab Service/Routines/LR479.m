LR479 ;DALOI/FHS/TFF - LR*5.2*462 PATCH ENVIRONMENT CHECK ROUTINE; [2/21/17 9:13am]
 ;;5.2;LAB SERVICE;**479**;Sep 27, 1994;Build 8
ENV ; Does not prevent loading of the transport global.
 ; Environment check is done only during the install.
 ;
 N XQA,XQAMSG
 ;
CHKNM ; Make sure the patch name exist
 S XUMF=1
 I '$D(XPDNM) D  G EXIT
 . D BMES("No valid patch name exist")
 . S XPDQUIT=2
 ;
 D CHECK
 D EXIT
 Q
 ;
CHECK ; Perform environment check
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D
 . D BMES("Terminal Device is not defined")
 . S XPDQUIT=2
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D
 . D BMES("Please log in to set local DUZ... variables")
 . S XPDQUIT=2
 I $P($$ACTIVE^XUSER(DUZ),"^")'=1 D
 . D BMES("You are not a valid user on this system")
 . S XPDQUIT=2
 S XPDIQ("XPZ1","B")="NO" Q
EXIT ;
 N XQA
 I $G(XPDQUIT) D BMES("--- Install Environment Check FAILED ---") Q
 D BMES("--- Environment Check is Ok ---")
 S XQAMSG="Loading of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 D BMES("Sending install loaded alert to mail group G.LMI")
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 H 5
 Q
 ;
PRE ;Pre-install entry point
 Q:'$D(XPDNM)
 ;
 D BMES("*** Preinstall completed ***")
 Q
POST ;Post install
 ;Clean up file 69.73
 D SPELL,TITLE
 ;Set up CPRS AP ORDER MESSAGE LOG -
 ;CPRS AP ORDER MESSAGE IS STORE HERE FOR PROCESSING BY "TASKAP1^LR7OAPKM"
 I '$G(^XTMP("LRAP1",0)) D
 . S ^XTMP("LRAP1",0)=$$FMADD^XLFDT(DT+365)_U_DT_U_"CPRS AP ORDER MESSAGE LOG"
 . S ^XTMP("LRAP1",1,0)=10
 S $P(^XTMP("LRAP1",0),U,3)="CPRS AP ORDER MESSAGE LOG"
 D
 . D BMES("Sending install completion alert to mail group G.LMI")
 . S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" Installed on "_$$HTE^XLFDT($H)
 . S XQA("G.LMI")=""
 . D SETUP^XQALERT
 K LRDA,LRPRT,LRVR
CLEAN60 ; Remove obsolete fields from file 60
 D BMES("Removing Obsolete fields from LABORATORY TEST (#60) File")
 ;Clean-up LABORATORY TEST field
 N DIC,DIE,DA,DIK,X,Y
 ; Delete 60, AOE SCREEN field
 S DA(1)=60.01,DA=21661,DIK="^DD(60.01," D ^DIK
 ;
CLEAN69 ; Remove obsolete field from file 69
 ; Clean-up LAB ORDER ENTRY file
 ;
 D BMES("Remove Obsolete fields from LAB ORDER ENTRY (#69) File")
 N DA,DAX,DIK
 S DA=21661.1,DA(1)=69.02,DIK="^DD(69.02," D ^DIK ; Delete DIALOG subfile
 K DA,DIK F DAX=21661.74 D
 . S DA=DAX,DA(1)=69.01,DIK="^DD(69.01," D ^DIK ; Delete Surgery Case #
 ;
MESLMI ; Notify LIM patch is installed.
 N XQA,XQAMSG
 D BMES("Sending install completion alert to mail group G.LMI")
 ;
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_"completed on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 Q
BMES(STR) ;Write BMES^XPDUTL statements
 W !
 D BMES^XPDUTL($$CJ^XLFSTR(STR,IOM))
 Q
MAIL ;Send message to G.LMI local mail group of added 64 codes
 N DIFROM,XMSUB,XMDUZ,XMTEXT,XMY,LRIEN,LRN
 Q
 ;
SPELL ; Correct Spelling Errors
 D BMES("Correcting Spelling Errors")
 N SPEC,ND,WORD,SPELL,LN
 S SPEC("Erosioin")="Erosion"
 S SPEC("Technnique")="Technique"
 S SPEC("SLide")="Slide"
 S ND=$NA(^LAB(69.73)) F  S ND=$Q(@ND) Q:ND=""  Q:$QS(ND,1)'=69.73  D
 . S WORD="" F  S WORD=$O(SPEC(WORD)) Q:WORD=""  D
 . . I @ND[WORD S SPELL(ND)=ND_"="""_$$REPLACE^XLFSTR(@ND,.SPEC)_""""
 . . I ND[WORD S SPELL(ND)=$$REPLACE^XLFSTR(ND,.SPEC)_"="""_@ND_""""
 Q:'$D(SPELL)
 S ND=$NA(SPELL) F  S ND=$Q(@ND) Q:ND=""  D
 . K @$QS(ND,1) S LN=@ND S @LN
 Q
 ;
TITLE ; Correct Builder Block Title Names
 D BMES("Correcting Builder Block Title Names")
 N ND,LN,I
 S ND=$NA(^LAB(69.73)) F  S ND=$Q(@ND) Q:ND=""  Q:$QS(ND,1)'=69.73  D
 . I @ND="Orchiectomy" D
 . . S LN="^LAB(69.73," F I=2:1:5 S LN=LN_$QS(ND,I)_$S(I<5:",",1:")")
 . . Q:$G(@LN@(1,0))'="Submission Type"
 . . K @LN@("B")
 . . S @LN@(1,0)="Specimen Type"
 . . S @LN@("B","Specimen Type",1)=""
 . . S @LN@(2,0)="Submission Type"
 . . S @LN@("B","Submission Type",2)=""
 Q
