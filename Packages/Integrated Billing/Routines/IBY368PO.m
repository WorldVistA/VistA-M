IBY368PO ;YMG/BP - Post-Installation for IB patch 368 ;12-Mar-2007
 ;;2.0;INTEGRATED BILLING;**368**;12-MAR-2007;Build 21
 ;
EN ;
 N XPDIDTOT S XPDIDTOT=3
 D NTFY ; 1. notify FSC that patch has been installed in production
 D TEXT ; 2. add new text entries to file 361.3
 D AUTOFILE ; 3. clean up stale informational messages in file 361
 ;
EX ;
 Q
 ;
NTFY ; notify FSC that patch has been installed succesfully
 N HEADER,BODY,MAILTO,SITE,TS
 D BMES^XPDUTL(" STEP 1 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Sending notification to FSC ...")
 ; do not send notification if installed in test account
 I '$$PROD^XUPROD D MES^XPDUTL("N/A for test account installation."),UPDATE^XPDID(1) Q
 D DTNOLF^DICRW
 S SITE=$$SITE^VASITE()
 S HEADER="Patch IB*2.0*368 installed at VistA site "_$P(SITE,U,2)
 D NOW^%DTC S TS=$$HLDATE^HLFNC(%,"TS")
 S BODY(.1)="Patch installed successfully at "_$E(TS,5,6)_"/"_$E(TS,7,8)_"/"_$E(TS,1,4)_" "_$E(TS,9,10)_":"_$E(TS,11,12)_":"_$E(TS,13,19)
 S BODY(.2)="Station Number: "_$P(SITE,U,3)
 ; FSC destination address
 ; FSC address for integration testing
 S MAILTO="fsc.edi-team@domain.ext"
 D MAIL(HEADER,.BODY,MAILTO)
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(1)
 Q
TEXT ; Add new text entries in file 361.3 - IB MESSAGE SCREEN TEXT
 N DATA,TXT,DO,DA,DIC,X,Y
 D BMES^XPDUTL(" STEP 2 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding new entries into file 361.3 ....")
 S DATA("ACCEPT")=0
 S DATA("ACK/RECEIPT")=0
 S DATA("CLAIM ACKNOWLEDGED AND FORWARD")=0
 S DATA("FINAL/PAYMENT")=0
 S DATA("PAPER CLAIM MAILED VIA USPS")=0
 S DATA("ACCEPT *WARNING*")=1
 S TXT="" F  S TXT=$O(DATA(TXT)) Q:TXT=""  D
 .I $D(^IBE(361.3,"B",TXT)) Q      ; already on file
 .S DIC="^IBE(361.3,",DIC(0)="F",X=TXT
 .S DIC("DR")=".02////"_DATA(TXT)
 .D FILE^DICN
 .Q
TX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(2)
 Q
 ;
AUTOFILE ; Check if informational status messages with no Final Review Action qualify for auto-file with no review.
 ;
 N IBDA,IBCNT,IB,Z,STOP,IBAUTO,TXT,NOREVU,IBREV
 D BMES^XPDUTL(" STEP 3 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Now looking at all informational status messages on file to see if any of them")
 D MES^XPDUTL("can be auto-filed with no review needed.  Each ""."" represents 1000 messages.")
 D MES^XPDUTL("")
 S IBDA=0,IBCNT=0 F  S IBDA=$O(^IBM(361,"ASV","I",IBDA)) Q:'IBDA  D
 .S IBCNT=IBCNT+1 W:(IBCNT#1000=0)&'$D(ZTQUEUED) "."
 .S IB=$G(^IBM(361,IBDA,0))
 .I $P(IB,U,10)'="" Q  ; final review action exists so quit out
 .; if this message was previously auto-filed with no review, then
 .; update the final review information and quit out
 .I $P(IB,U,9)=2,$P(IB,U,14)=1 D  Q
 ..N DIE,DR,DA
 ..S DIE=361,DR=".1////F",DA=IBDA D ^DIE
 ..Q
 .;
 .; IBAUTO - flag indicating that the whole message can be auto-filed
 .;          with no review needed
 .; NOREVU - flag indicating that one of the message lines had 'No
 .;          Review Needed' text
 .; IBREV  - flag indicating that one of the message lines had 'Review
 .;          Always Needed' text (so the whole message needs review)
 .;
 .S (Z,STOP,IBAUTO)=0 F  S Z=$O(^IBM(361,IBDA,1,Z)) Q:'Z  D  Q:STOP
 ..S TXT=$G(^IBM(361,IBDA,1,Z,0)) Q:TXT=""  ; text line Z
 ..S NOREVU=$$CKREVU^IBCEM4(TXT,,,.IBREV)
 ..I IBREV S STOP=1,IBAUTO=0 Q  ; 'review always needed' text found
 ..I NOREVU S IBAUTO=1  ; 'no review needed' text found
 ..Q
 .I IBAUTO D
 ..N DIE,DR,DA
 ..S DIE=361,DR=".09////2;.14////1;.1////F",DA=IBDA D ^DIE
 ..Q
 .Q
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(3)
 D CLEAN^DILF
 Q
 ;
MAIL(MTITLE,MLINES,MRECIP) ; send message
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,XMMG
 S XMSUB=MTITLE,XMDUZ=.5,XMTEXT="MLINES(",XMY(""_MRECIP_"")=""
 D ^XMD
 Q
