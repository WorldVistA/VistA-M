LR343 ;DALOI/JDB - LR*5.2*343 KIDS ROUTINE
 ;;5.2;LAB SERVICE;**343**;Sep 27, 1994;Build 1
 ;
 ; Send email if #69.9 fields set to Yes
 ; Set LR7O MOVEMENT EVENT protocols DISABLE and ACTION fields
 ; Pause X minutes so any running protocols can clear
 ; KIDS deletes LR7OEVNT routine
 ; KIDS deletes LR7O MOVEMENT EVENT protocols
 ; Delete data from #69.9 fields
 ; Delete #69.9 fields DD
 ; 
 ; 
EN ;
 ; Environment Check
 ; Does not prevent loading of the transport global.
 ;
 D CLEAN
 D CHECK
 I $G(XPDQUIT) D  Q  ;
 . W !,$$CJ^XLFSTR("Environment check failed",$G(IOM,80))
 ;
 W !,$$CJ^XLFSTR("Environment is okay",$G(IOM,80))
 D ALERT("Installation of patch "_$G(XPDNM,"Unknown patch")_" started on "_$$HTE^XLFDT($H))
 I '$G(XPDENV) D  Q
 . D ALERT("Transport global for patch "_$G(XPDNM,"Unknown patch")_" loaded on "_$$HTE^XLFDT($H))
 . D MSGADD("Sending transport global loaded alert to mail group G.LMI")
 Q
 ;
CHECK ;
 ; Perform environment check
 N POP
 ; Is Home device defined
 ; Need Home device so "task install" option is displayed
 S POP=0 S IOP="",%ZIS=0 D ^%ZIS
 I POP D  Q
 . S XPDQUIT=2
 . W !,$$CJ^XLFSTR("*** Home device is not defined ***",$G(IOM,80))
 ;
 ; Device Defined
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D  Q
 . W !,$$CJ^XLFSTR("*** Terminal Device is not defined ***",$G(IOM,80))
 . S XPDQUIT=2
 ;
 ; DUZ setup
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  Q
 . W !,$$CJ^XLFSTR("*** Please log in to set variables ***",$G(IOM,80))
 . S XPDQUIT=2
 ;
 ; Active User
 I $P($$ACTIVE^XUSER(DUZ),"^")'=1 D  Q
 . W !,$$CJ^XLFSTR("*** You are not a valid user on this system ***",$G(IOM,80))
 . S XPDQUIT=2
 ;
 ; KIDS default answer to "Disable Protocols...."
 S XPDDIQ("XPZ1")=0  ;;Dont allow disabling options
 S XPDDIQ("XPZ1","B")="NO"
 Q
 ;
PRE ;
 ; KIDS Pre Install
 ; Check that install was tasked
 ; Check if any File #69.9 fields are set to "YES" If so send
 ; notification email.
 ; Disable Lab Protocols (set DISABLED field and set ACTION to Q)
 ; Hang so current processes started by protocols can end
 N IEN,ERR,PREERR,RECIPS,BODY,VALS,STR
 S PREERR=0
 D MSGADD("Pre install started at "_$$HTE^XLFDT($H))
 ;
 ; Was install tasked? Quit if not
 I '$D(ZTQUEUED) I $G(IO("Q"))="" D  Q
 . S XPDQUIT=2
 . S XPDABORT=2
 . D MSGADD("***  THIS INSTALLATION MUST BE TASKED  ***")
 . D MSGADD("",0)
 . D MSGADD("Refer to the Patch Installation instructions",0)
 . D MSGADD("for details concerning re-running the install.",0)
 . D CLEAN
 ;
 ; check DD field values and send email if any are YES
 S VALS=$$GETVALS()
 I VALS>0 D  ;
 . S STR="File #69.9 LABORATORY SITE has one or more fields that were set to YES."
 . D BLDBODY(STR,.BODY)
 . S STR="    #150.3  CANCEL ON ADMIT set to "_$S($E(VALS,1,1):"YES",1:"NO")
 . D BLDBODY(STR,.BODY)
 . S STR="    #150.4  CANCEL ON DISCHARGE set to "_$S($E(VALS,2,2):"YES",1:"NO")
 . D BLDBODY(STR,.BODY)
 . S STR="    #150.5  CANCEL ON SPECIALTY set to "_$S($E(VALS,3,3):"YES",1:"NO")
 . D BLDBODY(STR,.BODY)
 . D BLDBODY(" ",.BODY)
 . S STR="One or more DC fields of File #69.9 are set to Yes. These fields should have been set to No according to guidelines issued with the release of OR*3*142 and OR*3*141."
 . S STR=STR_"  Facilities would be advised to use the functionality provided in file #100.6 (released with OR*3*142) to maintain the ability to auto discontinue laboratory orders upon a patient movement."
 . S STR=STR_"  Please check your configurations to ensure that this migration has occurred."
 . D BLDBODY(STR,.BODY)
 . S RECIPS(DUZ)=""
 . S RECIPS("G.LMI")=""
 . D EMAIL("LR*5.2*343 -- 69.9 DC Fields","BODY",.RECIPS)
 . K BODY
 . D MSGADD("***  File #69.9 field(s) set to YES  ***")
 ;
 D ALERT("LR*5.2*343 Installation has started")
 D MSGADD("Sent install started alert to mail group G.LMI")
 ;
 ; Disable Protocols and set action event to quit
 D MSGADD("Setting DISABLE and ACTION fields for Protocols")
 S IEN=$$FIND1^DIC(101,,"XO","LR7O MOVEMENT EVENT","B",,"ERR")
 I IEN D UPDTPROT(IEN)
 I 'IEN D MSGADD("***  Did not find LR7O MOVEMENT EVENT PROTOCOL  ***")
 S IEN=$$FIND1^DIC(101,,"XO","LR7O MOVEMENT EVENT TASK","B",,"ERR")
 I IEN D UPDTPROT(IEN)
 I 'IEN D MSGADD("***  Did not find LR7O MOVEMENT EVENT TASK PROTOCOL  ***")
 ;
 ; Now hang for X minutes to let all existing triggered
 ; events to clear so we don't cause any "cant return to source"
 ; errors when we overwrite the protocl's routine which would
 ; cause the other chained events not to be processed (the hang is
 ; why the install is tasked and not run in direct mode)
 H 300
 ;
 I 'PREERR D MSGADD("No actions required for pre install")
 D MSGADD("Pre install completed at "_$$HTE^XLFDT($H))
 Q
 ;
POST ;
 ; KIDS Post Install
 ; Delete data in File #69.9 fields
 ; Remove #69.9 fields from Data Dictionary
 ; Email installation progress message
 N DA,DIK,LRFDA,LRMSG,LRMSG2,POSTERR,RECIPS
 S POSTERR=0
 D MSGADD("Post install started at "_$$HTE^XLFDT($H))
 D MSGADD("File #69.9 field data update started")
 ; delete #69.9 field data
 S LRFDA(1,69.9,"1,",150.3)="@"
 S LRFDA(1,69.9,"1,",150.4)="@"
 S LRFDA(1,69.9,"1,",150.5)="@"
 K MSG
 D FILE^DIE("","LRFDA(1)","LRMSG")
 I $D(LRMSG) D  ;
 . K LRMSG2
 . D MSG^DIALOG("ASEM",.LRMSG2,$G(IOM,80),,"LRMSG")
 . S POSTERR=1
 . D MSGADD(.LRMSG2)
 D KILLDD(150.3)
 D KILLDD(150.4)
 D KILLDD(150.5)
 D MSGADD("File #69.9 field data deletion finished")
 D MSGADD("Post install completed"_$S(POSTERR:" with errors",1:"")_" at "_$$HTE^XLFDT($H))
 D MSGADD("Sending install completion alert to mail group G.LMI")
 ; Send alert
 D ALERT("Installation of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)_$S(POSTERR:" with errors",1:""))
 S RECIPS(DUZ)=""
 D EMAIL("INSTALL COMPLETED:"_$G(XPDNM),"^TMP(""LR343"","_$J_",""MSG"")",.RECIPS)
 D CLEAN
 Q
 ;
ALERT(MSG) ;
 N DA,DIK,XQA,XQAMSG
 S MSG=$G(MSG)
 S XQAMSG=MSG
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 Q
 ;
EMAIL(SUB,LRTXT,LRADDR) ;
 ; Sends an email message via MailMan using installer's DUZ
 ;    SUB <byval>   Subject for the message
 ;  LRTXT <byval>   Closed root local or global array
 ;              ie local array TEXT(1) passed as "TEXT"
 ; LRADDR <byref>   MailMan compatable array of message recipients
 N XMERR,XMZ,DIFROM
 D SENDMSG^XMXAPI($G(DUZ),$G(SUB),$G(LRTXT),.LRADDR)
 Q $G(XMZ,-1)
 ;
BLDBODY(STR,ARR) ;
 ; Adds a string to the end of the passed array
 ; Useful for building email message bodies
 ; STR <req>    The string to add to the array
 ; ARR <byref>  The array. Should be a simple, integer
 ;              based subscript array ie X(1), X(2), etc.
 N SUB
 S STR=$G(STR)
 S SUB=+$O(ARR("A"),-1)
 S ARR(SUB+1)=STR
 Q
 ;
GETVALS(NULL) ;
 ; Returns the values for #69.9 fields 150.3,150.4,150.5
 ; as a string  ie 000  or 010 etc (each field is only 1 or 0)
 N NODE,LRDATA,LRERR,VALUES
 S VALUES=""
 D GETS^DIQ(69.9,"1,","150.3;150.4;150.5","I","LRDATA","LRERR")
 I $D(LRDATA(69.9))>9 D  ;
 . S NODE="LRDATA(69.9)"
 .  F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,1)'=69.9  S VALUES=VALUES_+@NODE
 Q VALUES
 ;
UPDTPROT(IEN) ;
 ; Sets the PROTOCOL's (#101) DISABLE field (#2) to DISABLED
 ; and its ENTRY ACTION field (#20) to Q (QUIT)
 N LRFDA,LRMSG
 S IEN=$G(IEN)
 S LRFDA(1,101,IEN_",",2)="DISABLED BY LR*5.2*343"
 S LRFDA(1,101,IEN_",",20)="Q"
 D FILE^DIE("ET","LRFDA(1)","LRMSG")
 Q
 ;
MSGADD(TXT,LB) ;
 ; Utility to create a message global to save install
 ; messages and send later, usually via mailman.  Useful
 ; when an install is tasked.  It will print
 ; the messages out as they come in, as well as save them
 ; to the TMP global
 ; Input
 ; TXT <byref or byval>
 ;         If $D(TXT)=1 then TXT is saved
 ;         If $D(TXT)>9 then step through array and save each node 
 ;         as separate line.
 ;  LB <opt>   LineBreak  (True then uses MBES -- False uses MES)
 ;
 ; TXT <byref> is used by-ref when passsing in arrays created by
 ; the FileMan MSG^DIALOG output array
 ;
 N NODE,SUB,POS
 S TXT=$G(TXT)
 S LB=$G(LB)
 I LB="" S LB=1
 S LB=+LB
 S SUB=+$O(^TMP("LR343",$J,"MSG","A"),-1)
 I $D(TXT)>9 D  ;
 . S NODE="TXT"
 . F  S NODE=$Q(@NODE) Q:NODE=""  D  ;
 . . S ^TMP("LR343",$J,"MSG",SUB+1)=@NODE
 . . S SUB=SUB+1
 . . I $D(XPDENV) I LB D BMES^XPDUTL($$CJ^XLFSTR(@NODE,$G(IOM,80)))
 . . I $D(XPDENV) I 'LB D MES^XPDUTL($$CJ^XLFSTR(@NODE,$G(IOM,80)))
 . . I '$D(XPDENV) W !,$$CJ^XLFSTR(@NODE,$G(IOM,80))
 . ;
 ;
 I $D(TXT)=1 D  ;
 . S ^TMP("LR343",$J,"MSG",SUB+1)=TXT
 . I '$D(XPDENV) I LB D BMES^XPDUTL($$CJ^XLFSTR(TXT,$G(IOM,80)))
 . I '$D(XPDENV) I 'LB D MES^XPDUTL($$CJ^XLFSTR(TXT,$G(IOM,80)))
 . I $D(XPDENV) W !,$$CJ^XLFSTR(TXT,$G(IOM,80))
 Q
 ;
CLEAN ;
 K ^TMP("LR343",$J)
 D CLEAN^DILF
 Q
 ;
KILLDD(FIELD) ;
 ; Deletes the #69.9 field's DD
 N DIK,DA
 S DIK="^DD(69.9,"
 S DA=FIELD
 S DA(1)=69.9
 D ^DIK
 Q
