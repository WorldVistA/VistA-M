LA68 ;DALOI/JMC - LA*5.2*68 PATCH ENVIRONMENT CHECK ROUTINE ;July 28, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**68**;Sep 27, 1994;Build 56
 ;
 ; Reference to PROTOCOL file (#101) supported by ICR #872
 ;
EN ; Does not prevent loading of the transport global.
 ; Environment check is done only during the install.
 ; 
 N XQA,XQAMSG
 ;
 I '$G(XPDENV) D  Q
 . S XQAMSG="Transport global for patch "_$G(XPDNM,"Unknown patch")_" loaded on "_$$HTE^XLFDT($H),XQA("G.LMI")=""
 . D SETUP^XQALERT
 . D BMES^XPDUTL($$CJ^XLFSTR("Sending transport global loaded alert to mail group G.LMI",80))
 ;
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" started on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 D CHECK
 D EXIT
 Q
 ;
 ;
CHECK ; Perform environment check
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Terminal Device is not defined",80))
 . S XPDQUIT=2
 ;
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Please log in to set local DUZ... variables",80))
 . S XPDQUIT=2
 ;
 I $P($$ACTIVE^XUSER(DUZ),"^")'=1 D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("You are not a valid user on this system",80))
 . S XPDQUIT=2
 ;
 Q
 ;
 ;
EXIT ;
 I $G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Install Environment Check FAILED ---",80))
 I '$G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Environment Check is Ok ---",80))
 Q
 ;
 ;
 ;
PRE ; KIDS Pre install for LA*5.2*68
 ;
 ; Save status of existing LA7HDR interface in #62.48 and #101
 S LA7HDR=$O(^LAHM(62.48,"B","LA7HDR",0))
 I LA7HDR S LA7HDR(0)=$G(^LAHM(62.48,LA7HDR,0))
 ;
 S LA7101=$O(^ORD(101,"B","LA7 LAB RESULTS TO HDR (SUB)",0))
 I LA7101 S LA7101(774)=$$GET1^DIQ(101,LA7101_",",774)
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("Sending install started alert to mail group G.LMI",80))
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install started ***",80))
 D BMES^XPDUTL($$CJ^XLFSTR("--- No action required---",80))
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install completed ***",80))
 ;
 Q
 ;
 ;
POST ; KIDS Post install for LA*5.2*68
 N DA,DIC,DIK,DLAYGO,LA7200,LA7DIE,LA7FAC,LA7FDA,LA7UPD,LA7X,LA7Y,X,Y,XQA,XQAMSG
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install started ***",80))
 ;
 ; Update flag.
 S LA7UPD=0
 ;
 ; Restore status of LA7HDR entry in #62.48 if pre-existing and active.
 I LA7HDR,$P($G(LA7HDR(0)),"^",3)=1 S $P(^LAHM(62.48,LA7HDR,0),"^",3)=1
 ;
 ; Restore status of Lab HDR subscriber protocol entry in #101 if pre-existing and active.
 I LA7101,$G(LA7101(774))'="",$E(LA7101(774),1)'=";" D
 . D BMES^XPDUTL($$CJ^XLFSTR("*** Restoring protocol LA7 LAB RESULTS TO HDR (SUB) Routing Logic field (#774) ***",80))
 . S LA7FDA(1,101,LA7101_",",774)=LA7101(774)
 . D FILE^DIE("","LA7FDA(1)","LA7DIE(1)")
 . D BMES^XPDUTL($$CJ^XLFSTR("*** Protocol restore completed ***",80))
 . S LA7UPD=1
 ;
 ; Removing facility station number in FACILITY NAME field in file #771.
 S LA7FAC=$$FIND1^DIC(771,"","OX","LA7LAB","B","")
 I LA7FAC>0 D
 . D BMES^XPDUTL($$CJ^XLFSTR("*** Clearing facility name for LA7LAB entry in file #771 ***",80))
 . S LA7FDA(2,771,LA7FAC_",",3)="@"
 . D FILE^DIE("","LA7FDA(2)","LA7DIE(2)")
 . D BMES^XPDUTL($$CJ^XLFSTR("*** Clearing facility name completed ***",80))
 . S LA7UPD=1
 ;
 I LA7UPD=0 D BMES^XPDUTL($$CJ^XLFSTR("--- No actions required for post install ---",80))
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install completed ***",80))
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("Sending install completion alert to mail group G.LMI",80))
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 K LA7101,LA7HDR
 Q
