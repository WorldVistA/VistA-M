LA27 ;DCIOFO/JMC - LA*5.2*27 PATCH ENVIRONMENT CHECK ROUTINE ; 12/3/1997
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27**;Sep 27, 1994
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
 I '$$PATCH^XPDUTL("LA*5.2*25") D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("You must install patch LA*5.2*25",80))
 . S XPDQUIT=2
 I '$G(LA23),'$$PATCH^XPDUTL("LA*5.2*23") D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("You must install patch LA*5.2*23",80))
 . S XPDQUIT=2
 S XPDIQ("XPZ1","B")="NO"
 Q
 ;
EXIT ;
 I $G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Install Environment Check FAILED ---",80))
 I '$G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Environment Check is Ok ---",80))
 Q
 ;
PRE ; KIDS Pre install for LA*5.2*27
 N LA7FIELD,LA7NOAC
 S LA7NOAC=1 ; Flag for actions
 D BMES^XPDUTL($$CJ^XLFSTR("--- Starting Pre Install ---",80))
 F LA7FIELD=.05,.06,.07 I $$VFIELD^DILFD(62.8,LA7FIELD) D
 . N DIK
 . S LA7NOAC=0
 . D BMES^XPDUTL($$CJ^XLFSTR("Deleting Field #"_LA7FIELD_" in file #62.8, LAB SHIPPING MANIFEST",80))
 . S DIK="^DD(62.8,",DA=LA7FIELD D ^DIK
 I $$VFIELD^DILFD(62.85,.06) D
 . N DIK
 . S LA7NOAC=0
 . D BMES^XPDUTL($$CJ^XLFSTR("Deleting Field #.06 in file #62.85, LAB SHIPPING EVENT",80))
 . S DIK="^DD(62.85,",DA=.06 D ^DIK
 I $$VFIELD^DILFD(62.9,.07) D  ; Clear out old data since field attribute changed
 . N LA7X
 . D FIELD^DID(62.9,.07,"","TYPE","LA7X")
 . I $G(LA7X("TYPE"))'="SET" Q
 . S LA7NOAC=0
 . D BMES^XPDUTL($$CJ^XLFSTR("Clearing data for field # .07 in file #62.9, LAB SHIPPING CONFIGURATION",80))
 . D BMES^XPDUTL($$CJ^XLFSTR("Have Lab ADPAC re-enter data via Shipping Configuration Edit Menu option",80))
 . S X=0
 . F  S X=$O(^LAHM(62.9,X)) Q:'X  S $P(^LAHM(62.9,X,0),"^",7)=""
 I $$VFIELD^DILFD(62.9,10) D
 . N DIU
 . S LA7NOAC=0
 . D BMES^XPDUTL($$CJ^XLFSTR("Deleting Data Dictionary for file #62.9, LAB SHIPPING CONFIGURATION",80))
 . D BMES^XPDUTL($$CJ^XLFSTR("File will be installed as part of KIDS installation",80))
 . S DIU="^LAHM(62.9,",DIU(0)="" D EN^DIU2
 I LA7NOAC D BMES^XPDUTL($$CJ^XLFSTR("--- No action necessary ---",80))
 D BMES^XPDUTL($$CJ^XLFSTR("--- End Pre Install ---",80))
 Q
 ;
POST ; KIDS Post install for LA*5.2*27
 N LA7,LA76248,LA76249,LA7CNT,LA7DESC,LA7DT,LA7TM,LA7X,LA7Y,LA7XMY
 D BMES^XPDUTL($$CJ^XLFSTR("--- Starting Post Install ---",80))
 ; Convert Lab Messaging error Log if necessary
 D BMES^XPDUTL($$CJ^XLFSTR("--- Checking if Lab Messaging Error Log needs converting ---",80))
 S LA7DT="LA7"
 F  S LA7DT=$O(^XTMP(LA7DT)) Q:LA7DT=""!($E(LA7DT,1,3)'="LA7")  D
 . I $E(LA7DT,1,6)="LA7ERR" Q  ; Already converted.
 . I $E(LA7DT,1,5)="LA7IC" Q  ; Don't touch IC nodes.
 . D BMES^XPDUTL("Converting Lab Messaging Error Log for "_$$FMTE^XLFDT($E(LA7DT,4,10)))
 . S LA7TM=0
 . F  S LA7TM=$O(^XTMP(LA7DT,LA7TM)) Q:LA7TM=""  D
 . . S LA7=$G(^XTMP(LA7DT,LA7TM))
 . . I $P($G(^XTMP(LA7DT,0)),"^",3)'="Lab Messaging Error Log" D
 . . . S LA76249=+LA7
 . . . S LA76248=+$G(^LAHM(62.49,LA76249,.5))
 . . . S LA7=LA76248_"^"_LA7
 . . S ^XTMP("LA7ERR^"_$E(LA7DT,4,10),LA7TM)=LA7 ; Set converted entry.
 . . K ^XTMP(LA7DT,LA7TM) ; Kill off old entry.
 . S ^XTMP("LA7ERR^"_$E(LA7DT,4,10),0)=^XTMP(LA7DT,0) ; Set converted entry.
 . S $P(^XTMP("LA7ERR^"_$E(LA7DT,4,10),0),"^",3)="Lab Messaging Error Log"
 . K ^XTMP(LA7DT,0) ; Kill off old entry.
 D BMES^XPDUTL($$CJ^XLFSTR("--- Finished Lab Messaging Error Log Conversion ---",80))
 ;
 ; Convert file #.05,EVENT CODE in file #62.85 LAB SHIPPING EVENT if neceessary
 D BMES^XPDUTL($$CJ^XLFSTR("--- Checking if LAB SHIPPING EVENT file needs converting ---",80))
 S XPDIDTOT=$P($G(^LAHM(62.85,0)),"^",4)
 S LA7X=0,LA7CNT="0^0"
 F  S LA7X=$O(^LAHM(62.85,LA7X)) Q:'LA7X  D
 . S $P(LA7CNT,"^")=$P(LA7CNT,"^")+1
 . I '($P(LA7CNT,"^")#(XPDIDTOT\.1)) D UPDATE^XPDID($P(LA7CNT,"^"))
 . S LA7X(0)=$G(^LAHM(62.85,LA7X,0))
 . I $P(LA7X(0),"^",6)="" Q  ; Doesn't need conversion
 . S LA7="SM"_$S($P(LA7X(0),"^",5)<10:"0"_$P(LA7X(0),"^",5),1:$P(LA7X(0),"^",5))
 . S LA7Y=$$EVNC^LA7SMU(LA7)
 . I LA7Y S $P(^LAHM(62.85,LA7X,0),"^",5,6)=+LA7Y_"^",$P(LA7CNT,"^",2)=$P(LA7CNT,"^",2)+1
 D BMES^XPDUTL($$CJ^XLFSTR("--- Finished LAB SHIPPING EVENT Conversion ---",80))
 ;
 ; Add menu option
 S LA7X=$$ADD^XPDMENU("LRMENU","LA7S MAIN MENU","LSM")
 D BMES^XPDUTL($$CJ^XLFSTR("Lab Shipping Menu [LA7S MAIN MENU] Option ",80))
 D BMES^XPDUTL($$CJ^XLFSTR("was"_$S(LA7X:"",1:" NOT")_" added to the Laboratory DHCP Menu [LRMENU]",80))
 ;
 S LA7X=$$ADD^XPDMENU("LRLIAISON","LA7S MGR MENU","SMGR")
 D BMES^XPDUTL($$CJ^XLFSTR("Lab Shipping Management Menu [LA7S MGR MENU] Option ",80))
 D BMES^XPDUTL($$CJ^XLFSTR("was"_$S(LA7X:"",1:" NOT")_" added to the Lab liaison menu [LRLIAISON]",80))
 ;
 ; Setup mail group LAB MESSAGING
 D BMES^XPDUTL($$CJ^XLFSTR("--- Setting up mail group LAB MESSAGING ---",80))
 S LA7DESC(1)="This mail group is used by the LAB MESSAGING package to notify appropiate Lab"
 S LA7DESC(2)="and IRM staff of conditions affecting LAB MESSAGING that may need corrective"
 S LA7DESC(3)="action."
 S LA7XMY(+$G(DUZ))=""
 S LA7X=$$MG^XMBGRP("LAB MESSAGING",0,0,1,.LA7XMY,.LA7DESC,1)
 D BMES^XPDUTL($$CJ^XLFSTR("Mail group LAB MESSAGING setup "_$S(LA7X:"",1:"UN")_"SUCCESSFUL",80))
 ; Scheduled task reminder
 D BMES^XPDUTL($$CJ^XLFSTR("*** NOTE: Remember to schedule option LA7TASK NIGHTY ***",80))
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("--- End Post Install ---",80))
 Q
