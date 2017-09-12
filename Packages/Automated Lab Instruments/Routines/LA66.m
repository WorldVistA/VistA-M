LA66 ;DALOI/JMC - LA*5.2*66 PATCH ENVIRONMENT CHECK ROUTINE ;May 7, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**66**;Sep 27, 1994;Build 30
 ;
 ; Pre, Post, and Environment checks for LA*5.2*66
 ;
ENV ;
 ; Environment checks
 S XPDNOQUE=1 ; no queuing
 N LAERR,LAADL
 K ^TMP($$RTNNM(),$J)
 I '$G(XPDENV) D  ;
 . N MSG
 . S MSG="Transport global for patch "_$G(XPDNM,"Unknown patch")_" loaded on "_$$HTE^XLFDT($H)
 . D ALERT(MSG)
 . D BMES("Sending transport global loaded alert to mail group G.LMI")
 ;
 I $G(XPDENV) D  ;
 . N MSG
 . S MSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" started on "_$$HTE^XLFDT($H)
 . D ALERT(MSG)
 . D BMES("Sending install started alert to mail group G.LMI")
 ;
 S LAERR=0
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D  ;
 . D BMES("Terminal Device is not defined.")
 . S LAERR=2
 ;
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  ;
 . D BMES("Please login to set local DUZ variables.")
 . S LAERR=2
 ;
 I 'LAERR,$P($$ACTIVE^XUSER(DUZ),"^")'=1 D  ;
 . D BMES("You are not a valid user on this system.")
 . S LAERR=2
 ;
 ; If installing, run system config
 I 'LAERR,$G(XPDENV) D  ;
 . S LAADL=$G(^LA("ADL","STOP"))
 . D ENV2
 . I $P(LAADL,"^")=0 D  ;
 . . D BMES("N O T E:  If you abort this installation")
 . . D MES("restart the Lab Universal Interface background job.")
 ;
 I LAERR!$D(XPDABORT)!$D(XPDQUIT) D  ;
 . S LAERR=1
 . S XPDABORT=2 S XPDQUIT=2
 . W !,$C(7) W ! D BMES("* * * Environment check FAILED * * *")
 ;
 I 'LAERR W ! D BMES("--- Environment is okay ---")
 ;
 I $G(XPDENV) S XPDDIQ("XPZ1","B")="NO"
 Q
 ;
 ;
PRE ;
 ; Pre install
 D BMES("*** Pre install started ***")
 D BMES("--- No action required for pre-install ---")
 D BMES("*** Pre install completed ***")
 Q
 ;
 ;
POST ;
 ; Post install
 N LAERR,LAFDA,LA7DIE,LA7FAC,LA7I,LA7X,LA7Y,LAMSG,LAPOST,DIERR
 S (LAERR,LAPOST)=0
 D BMES("*** Post install started ***")
 ;
 ; Set facility station number into FACILITY NAME field in file #771.
 S LA7FAC=$P($$SITE^VASITE(DT),"^",3)
 I 'LA7FAC D  ;
 . S LAERR=1
 . D BMES("ERROR: Could not determine Facility Number.")
 . D BMES("Edit file #771, FACILITY NAME field for LA7UI*")
 I LA7FAC'="" D
 . D BMES("*** Updating facility name for LA7UI* entries in file #771 ***")
 . ; Okayed by Thomas Grohowski
 . F LA7I=1:1:10 D  ;
 . . I LA7I S LA7X="LA7UI"_LA7I
 . . K DIERR
 . . S LA7Y=$$FIND1^DIC(771,"","OX",LA7X,"B")
 . . I LA7Y<1 D  Q
 . . . S LAERR=1
 . . . D BMES("ERROR: "_LA7X_" not found in file #771")
 . . K LAFDA,DIERR,LAMSG
 . . S LAFDA(1,771,LA7Y_",",3)=LA7FAC
 . . D FILE^DIE("","LAFDA(1)","LAMSG")
 . . ; notify if could not update
 . . S LAERR=$$FMERR("LAMSG","ERROR: unable to update "_LA7X_" in file #771")
 . ; delete facility ID for LA7LAB
 . K LAFDA,LAMSG,DIERR
 . S LA7Y=$$FIND1^DIC(771,"","OX","LA7LAB","B")
 . I 'LA7Y D
 . . S LAERR=1
 . . D BMES("*** Missing 'LA7LAB' entry in HL7 APPLICATION PARAMETER (#771) file ***")
 . I LA7Y D
 . . K DIERR,LAFDA,LAMSG
 . . S LAFDA(1,771,LA7Y_",",3)="@"
 . . D FILE^DIE("","LAFDA(1)","LAMSG")
 . . S LAERR=$$FMERR("LAMSG","ERROR: Failed to update LA7LAB entry in file #771.")
 . S LAPOST=1
 . D BMES("*** Updating facility name completed"_$S(LAERR:" but with errors",1:"")_" ***")
 ;
 ;
 I $D(^TMP("LA66",$J,"62.48")) D
 . D BMES("*** Restoring existing LA7UI* entries to ACTIVE in file #62.48 ***")
 . S LA7I=0,LAPOST=1
 . F  S LA7I=$O(^TMP("LA66",$J,"62.48",LA7I)) Q:'LA7I  D
 . . K DIERR,LAFDA,LAMSG
 . . S LA7Y=$P(^LAHM(62.48,LA7I,0),"^")
 . . D BMES("*** Updating entry "_LA7Y_" to ACTIVE in file #62.48 ***")
 . . S LAFDA(2,62.48,LA7I_",",2)=^TMP("LA66",$J,"62.48",LA7I)
 . . D FILE^DIE("","LAFDA(2)","LAMSG")
 . . S LAERR=$$FMERR("LAMSG","ERROR: Failed to update "_LA7Y_" entry in file #62.48.")
 . D BMES("*** Updating existing LA7UI* entries to ACTIVE completed ***")
 ;
 I 'LAERR,'LAPOST D BMES("--- No actions required for post install ---")
 ;
 D RESTORE
 D BMES("*** Post install completed"_$S(LAERR:" but with errors",1:"")_" ***")
 ;
 N MSG
 S MSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 D ALERT(MSG)
 D BMES("Sending install completion alert to mail group G.LMI")
 ;
 K ^TMP($$RTNNM(),$J),^TMP("LA66",$J)
 Q
 ;
 ;
BMES(STR,POS) ;
 ; Display messages using BMES^XPDUTL or MES^XPDUTL
 ; Accepts single string or string array
 ; Input
 ;  STR The string to display (byRef or byValue)
 ;  POS <opt> value for $$CJ^XLFSTR (80=default)
 ;
 N I,X
 S POS=$G(POS,80)
 ; If an array, step through it and pass each node to MES since $$CJ^XLFSTR can't handle arrays
 I $D(STR)>9 D
 . S I=0
 . F  S I=$O(STR(I)) Q:'I  S X=STR(I) D MES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(X,POS),"R"," "))
 ;
 I $D(STR)<2 D MES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,POS),"R"," "))
 Q
 ;
 ;
MES(STR,CJ,LM) ;
 ; Displays a string using MES^XPDUTL
 ;  Inputs
 ;  STR: String to display
 ;   CJ: Center text?  1=yes 0=1 <dflt=1>
 ;   LM: Left Margin (padding)
 N X
 S STR=$G(STR)
 S CJ=$G(CJ,1)
 S LM=$G(LM)
 I LM<0 S LM=0
 I CJ S STR=$$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," ")
 I 'CJ I LM S X="" S $P(X," ",LM)=" " S STR=X_STR
 D MES^XPDUTL(STR)
 Q
 ;
 ;
FMERR(LAREF,MSG) ;
 ; Checks if a FileMan error occurred and displays help message
 ; and error text message.
 ; Input
 ;   LAREF Name of array that has the FM DIERR subscripts
 ;         ie FILE^DIE  msg_root variable
 ;     MSG <opt> Additional help text
 ; Output
 ;  1 if an error occurred, 0 if no error
 ;  Also writes the messages to the device
 N LAERRMSG,OK,FMERR
 S LAREF=$G(LAREF)
 S MSG=$G(MSG)
 S FMERR=0
 D MSG^DIALOG("AE",.LAERRMSG,,,LAREF)
 I $D(LAERRMSG) D  ;
 . I MSG'="" D BMES(MSG)
 . D BMES(.LAERRMSG)
 . S FMERR=1
 Q FMERR
 ;
 ;
ENV2 ;
 ; Secondary Environment checks
 N X,I
 ; check and shutdown Auto Download job.
 S X=$G(^LA("ADL","STOP"))
 I $P(X,"^")=0 D  ;
 . D SETSTOP^LA7ADL1(2,DUZ)
 . D BMES("Shutting down Lab Universal Interface Auto Download Job")
 . S ^TMP($$RTNNM(),$J,"ADL")=1
 . F I=1:1:10 W "." H 1
 ;
 ;
 ; If previously installed then save current ACTIVE LA7UI* entries.
 K ^TMP("LA66",$J,"62.48")
 S I=0
 F  S I=$O(^LAHM(62.48,I)) Q:'I  I $E($P(^LAHM(62.48,I,0),"^"),1,5)="LA7UI",$P(^LAHM(62.48,I,0),"^",3)=1 S ^TMP("LA66",$J,"62.48",I)=1
 Q
 ;
 ;
RESTORE ;
 ; Restore system after install
 N LAADL,X
 ; Restart auto download process status if stopped by install
 S LAADL=$G(^TMP($$RTNNM(),$J,"ADL"))
 I LAADL=1 D  ;
 . D ZTSK^LA7ADL
 . D SETSTOP^LA7ADL1(1,DUZ)
 . D BMES("Restarting Lab Universal Interface Auto Download Job")
 . K ^TMP($$RTNNM(),$J,"ADL")
 . H 3
 ;
 ; If ADL not started, notify user to restart
 S X=$G(^LA("ADL","STOP"))
 S X=$P(X,"^")
 I X'=0 D BMES("Be sure to restart the Lab Universal Interface Auto Download Job")
 K ^TMP($$RTNNM(),$J)
 Q
 ;
 ;
ALERT(MSG,RECIPS) ;
 N DA,DIK,XQA,XQAMSG
 S XQAMSG=$G(MSG)
 S XQA("G.LMI")=""
 I $D(RECIPS) M XQA=RECIPS
 D SETUP^XQALERT
 Q
 ;
 ;
RTNNM() ;
 Q $T(+0)
