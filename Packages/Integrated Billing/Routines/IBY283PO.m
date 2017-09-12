IBY283PO ;ALB/ESG - Post Install for IB patch 283 ;24-AUG-2004
 ;;2.0;INTEGRATED BILLING;**283**;21-MAR-94
 ; IA#2916 for call to CREIXN^DDMOD
 ;
EN ;
 N XPDIDTOT S XPDIDTOT=4
 D TEXT         ; new text entries in file 361.3
 D ACSA         ; new index file for 361
 D AUTOFILE     ; examine informational messages for auto-file
 D PARAM        ; site parameter purge value
EX ;
 Q
 ;
TEXT ; Add new text entries in file 361.3 - IB MESSAGE SCREEN TEXT
 NEW DATA,TXT,DO,DA,DIC,X,Y
 D BMES^XPDUTL(" STEP 1 of 4")
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding new entries into file 361.3 ....")
 S DATA("CLAIM RECEIVED")=""
 S DATA("ACK/ACCEPTANCE HAS BEEN ACCEPT")=""
 S DATA("COMPLETED: PAYMENT MADE")=""
 S DATA("FINALIZED-PAYMENT: PAYMENT REF")=""
 S TXT=""
 F  S TXT=$O(DATA(TXT)) Q:TXT=""  D
 . I $D(^IBE(361.3,"B",TXT)) Q      ; already on file
 . S DIC="^IBE(361.3,",DIC(0)="F",X=TXT
 . S DIC("DR")=".02////0"
 . D FILE^DICN
 . Q
TX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(1)
 Q
 ;
ACSA ; Build the new "ACSA" index for file 361
 NEW IBMXR,IBMRES,IBMOUT
 S IBMXR("FILE")=361
 S IBMXR("NAME")="ACSA"
 S IBMXR("TYPE")="R"
 S IBMXR("USE")="S"
 S IBMXR("EXECUTION")="R"
 S IBMXR("ACTIVITY")="IR"
 S IBMXR("SHORT DESCR")="Index by Message Severity and Review Status"
 S IBMXR("DESCR",1)="This index is used in the CSA screen (Claims Status Awaiting"
 S IBMXR("DESCR",2)="Resolution).  Most often the CSA screen is built with unreviewed"
 S IBMXR("DESCR",3)="rejection messages.  This index file can immediately locate them."
 S IBMXR("VAL",1)=.03
 S IBMXR("VAL",1,"SUBSCRIPT")=1
 S IBMXR("VAL",1,"COLLATION")="F"
 S IBMXR("VAL",2)=.09
 S IBMXR("VAL",2,"SUBSCRIPT")=2
 S IBMXR("VAL",2,"COLLATION")="F"
 ;
 D BMES^XPDUTL(" STEP 2 of 4")
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("A new index will now be created for file 361.")
 D MES^XPDUTL("This may take some time depending on how many entries are in file 361.")
 D CREIXN^DDMOD(.IBMXR,"SW",.IBMRES,"IBMOUT")
 I +$G(IBMRES) D MES^XPDUTL("Index successfully created!") G ACSAX
 ;
 ; Index not created
 D MES^XPDUTL("A PROBLEM WAS ENCOUNTERED.  INDEX FILE NOT CREATED!!!")
 D MES^XPDUTL("SENDING MAILMAN MESSAGE...")
 D MES^XPDUTL("PLACING THE CSA SCREEN OUT-OF-ORDER.")
 NEW XMDUZ,XMSUBJ,XMBODY,MSG,XMTO,DA,DIE,DR
 S XMDUZ=DUZ,XMSUBJ="IB*2*283 Error:  ACSA index not built",XMBODY="MSG"
 S MSG(1)="The new ""ACSA"" index for file 361 was not created at"
 S MSG(2)=" "
 S MSG(3)="     "_$$SITE^VASITE
 S MSG(4)=" "
 S MSG(5)="The CSA screen has been placed out of order."
 ;
 ; recipients of message
 S XMTO(DUZ)=""
 S XMTO("eric.gustafson@daou.com")=""
 S XMTO("G.PATCHES")=""
 S XMTO("G.IB EDI")=""
 S XMTO("G.IB EDI SUPERVISOR")=""
 ;
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO)
 ;
 ; place CSA screen out of order
 S DA=$O(^DIC(19,"B","IBCE CLAIMS STATUS AWAITING",""))
 I DA S DIE=19,DR="2///IB Patch 283 Installation Failure" D ^DIE
ACSAX ;
 D UPDATE^XPDID(2)
 Q
 ;
AUTOFILE ; Loop through the informational status messages with
 ; no Final Review Action and check to see if they qualify for
 ; auto-file with no review.
 ;
 NEW IBDA,IBCNT,IB,Z,STOP,IBAUTO,TXT,NOREVU,IBREV
 D BMES^XPDUTL(" STEP 3 of 4")
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Now looking at all informational status messages on file to see if any of them")
 D MES^XPDUTL("can be auto-filed with no review needed.  Each ""."" represents 1000 messages.")
 D MES^XPDUTL("")
 S IBDA=0,IBCNT=0
 F  S IBDA=$O(^IBM(361,"ASV","I",IBDA)) Q:'IBDA  D
 . S IBCNT=IBCNT+1 W:(IBCNT#1000=0)&'$D(ZTQUEUED) "."
 . S IB=$G(^IBM(361,IBDA,0))
 . ;
 . I $P(IB,U,10)'="" Q     ; final review action exists so quit out
 . ;
 . ; if this message was previously auto-filed with no review, then
 . ; update the final review information and quit out
 . I $P(IB,U,9)=2,$P(IB,U,14)=1 D  Q
 .. N DIE,DR,DA
 .. S DIE=361,DR=".1////F",DA=IBDA D ^DIE
 .. Q
 . ;
 . ; IBAUTO - flag indicating that the whole message can be auto-filed
 . ;          with no review needed
 . ; NOREVU - flag indicating that one of the message lines had 'No
 . ;          Review Needed' text
 . ; IBREV  - flag indicating that one of the message lines had 'Review
 . ;          Always Needed' text (so the whole message needs review)
 . ;
 . S Z=0,STOP=0,IBAUTO=0
 . F  S Z=$O(^IBM(361,IBDA,1,Z)) Q:'Z  D  Q:STOP
 .. S TXT=$G(^IBM(361,IBDA,1,Z,0)) Q:TXT=""   ; text line Z
 .. S NOREVU=$$CKREVU^IBCEM4(TXT,,,.IBREV)    ; call function
 .. I IBREV S STOP=1,IBAUTO=0 Q       ; 'review always needed' text found
 .. I NOREVU S IBAUTO=1    ; 'no review needed' text found
 .. Q
 . ;
 . I IBAUTO D
 .. N DIE,DR,DA
 .. S DIE=361,DR=".09////2;.14////1;.1////F",DA=IBDA D ^DIE
 .. Q
 . Q
 ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(3)
 Q
 ;
PARAM ; Ensure there is a value in IB site parameter field 350.9,8.02
 ; "Days to wait to purge messages"
 ; If not defined, set it to be 90 days.
 ;
 N A
 S A=$G(^IBE(350.9,1,8))
 D BMES^XPDUTL(" STEP 4 of 4")
 D MES^XPDUTL("-------------")
 ;
 I $P(A,U,2) D  G PARAMX      ; quit out if field is defined
 . D MES^XPDUTL("IB site parameter value ""Days to wait to purge status messages"" is set to "_$P(A,U,2)_".")
 . D MES^XPDUTL(" No changes made.")
 . Q
 ;
 D MES^XPDUTL("IB site parameter value ""Days to wait to purge status messages"" is not defined.")
 D MES^XPDUTL("Setting this parameter value to 90 ....")
 S $P(^IBE(350.9,1,8),U,2)=90    ; set to 90 days if undefined
 D MES^XPDUTL(" Done.")
PARAMX ;
 D UPDATE^XPDID(4)
 Q
 ;
