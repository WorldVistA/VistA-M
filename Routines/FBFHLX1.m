FBFHLX1 ;WOIFO/SAB-TRANSMIT HL7 MESSAGES TO FPPS (CON'T) ;9/9/2003
 ;;3.5;FEE BASIS;**61**;JULY 18, 2003
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
CHKACK ; check for acknowledgements
 ; input  - none
 ; output
 ;   FBCNT("ACKT") - count of previously transmitted invoices w/o ack
 ;   FBCNT("ACKA") - count of these that were accepted
 ;   FBCNT("ACKR") - count of these that were rejected
 ;   FBCNT("ACKW") - count of these that are still waiting for ack
 ;   ^TMP($J,"FBNA",invoice number)="" - list waiting for ack
 ;   update file 163.5
 N FBAAIN,FBMSGID,FBQDA,FBQY,FBSTATUS,FBX
 ;
 ; initialize
 K ^TMP($J,"FBNA")
 F FBX="ACKA","ACKR","ACKW" S FBCNT(FBX)=0
 ;
 ; loop thru transmitted (not yet acknowledged entries)
 S FBQDA=0  F  S FBQDA=$O(^FBHL(163.5,"AC",1,FBQDA)) Q:'FBQDA  D
 . S FBQY=$G(^FBHL(163.5,FBQDA,0))
 . S FBAAIN=$P(FBQY,U)
 . Q:FBAAIN=""  ; invalid invoice number
 . S FBMSGID=$P(FBQY,U,4)
 . Q:FBMSGID=""
 . ;
 . S FBSTATUS=$$MSGSTAT^HLUTIL(FBMSGID)
 . ;
 . I $P(FBSTATUS,U)=3 D  Q
 . . N FBFDA
 . . S FBFDA(163.5,FBQDA_",",2)="2" ; set status = acknowledged
 . . S FBFDA(163.5,FBQDA_",",8)="A" ; set ACK FLAG = ACCEPTED
 . . S FBFDA(163.5,FBQDA_",",9)=$P(FBSTATUS,U,2) ; set ACK DATE/TIME
 . . I $D(FBFDA) D FILE^DIE("","FBFDA")
 . . S FBCNT("ACKA")=FBCNT("ACKA")+1
 . ;
 . I $P(FBSTATUS,U)=4 D  Q
 . . N FBFDA,FBTXT
 . . S FBFDA(163.5,FBQDA_",",2)="2" ; set status = acknowledged
 . . S FBFDA(163.5,FBQDA_",",8)="R" ; set ACK FLAG = rejected
 . . S FBFDA(163.5,FBQDA_",",9)=$P(FBSTATUS,U,2) ; set ACK DATE/TIME
 . . S FBFDA(163.5,FBQDA_",",10)="N" ; rej status = not reported
 . . I $D(FBFDA) D FILE^DIE("","FBFDA")
 . . S FBTXT(1)=$P(FBSTATUS,U,3)
 . . I FBTXT(1)]"" D WP^DIE(163.5,FBQDA_",",11,"","FBTXT") ; error msg
 . . S FBCNT("ACKR")=FBCNT("ACKR")+1
 . ;
 . ; don't report not acknowledged unless it is last entry for invoice
 . Q:$$LAST^FBFHLU($P(FBQY,U))'=FBQDA
 . ;
 . ; last entry for invoice was not acknowledged yet
 . S ^TMP($J,"FBNA",FBAAIN)=""
 . S FBCNT("ACKW")=FBCNT("ACKW")+1
 ;
 S FBCNT("ACKT")=FBCNT("ACKA")+FBCNT("ACKR")+FBCNT("ACKW")
 ;
 Q
 ;
SUMMSG ; Summary Message (build and send)
 ; input
 ;   ^TMP($J,"FBE",invoice number,seq number)=error text
 ;   ^TMP($J,"FBW",invoice number,seq number)=warning text
 ;   ^TMP($J,"FBNA",invoice number)="" for invoices not acknowledged
 ;   ^TMP($J,"FBX",seq number)=message text so far
 ;   FBXL = last line used in ^TMP($J,"FBX",seq number)
 ;   FBXMIT("START") = start process, FileMan date/time
 ;   FBXMIT("ACK") = start check for acks, FileMan date/time
 ;   FBXMIT("SEND") = start transmit, FileMan date/time
 ;   FBXMIT("END") = end process, FileMan date/time
 ;   FBCNT("PENDT")= count of pending invoices that were transmitted
 ;   FBCNT("PENDE")= count of pending invoices that had exception
 ;   FBCNT("ACKT") = count of previously transmitted invoices w/o ack
 ;   FBCNT("ACKA") = count of these that were accepted
 ;   FBCNT("ACKR") = count of these that were rejected
 ;   FBCNT("ACKW") = count of these that are still waiting for ack
 ; output
 ;   ^TMP($J,"FBX",
 ;   mail message
 ;
 N XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 ;
 ; add header text
 S ^TMP($J,"FBX",1)=$$FMTE^XLFDT(FBXMIT("START"))_"  Process Started."
 S ^TMP($J,"FBX",2)=$$FMTE^XLFDT(FBXMIT("ACK"))_"  Check transmitted messages for acknowledgement..."
 S ^TMP($J,"FBX",3)="                       "_FBCNT("ACKT")_" previously transmitted messages w/o ack."
 S ^TMP($J,"FBX",4)="                       "_FBCNT("ACKA")_" of these were accepted."
 S ^TMP($J,"FBX",5)="                       "_FBCNT("ACKR")_" of these were rejected."
 S ^TMP($J,"FBX",6)="                       "_FBCNT("ACKW")_" of these still waiting for ack."
 S ^TMP($J,"FBX",7)=$$FMTE^XLFDT(FBXMIT("SEND"))_"  Transmit pending invoices..."
 S ^TMP($J,"FBX",8)="                       "_FBCNT("PENDT")_" transmitted."
 S ^TMP($J,"FBX",9)="                       "_FBCNT("PENDE")_" not transmitted due to exception."
 S ^TMP($J,"FBX",10)=$$FMTE^XLFDT(FBXMIT("END"))_"  Process Complete."
 I $D(ZTSTOP) S ^TMP($J,"FBX",11)="  Process (task) stopped due to user request."
 ;
 ; List Exceptions
 I FBCNT("PENDE")>0 D
 . N FBAAIN,FBL,FBX
 . D PTXT(.FBXL," ")
 . D PTXT(.FBXL,"List of Exceptions during Transmit of Pending Invoices")
 . S FBAAIN="" F  S FBAAIN=$O(^TMP($J,"FBE",FBAAIN)) Q:FBAAIN=""  D
 . . D PTXT(.FBXL,"Invoice: "_FBAAIN)
 . . S FBL=0 F  S FBL=$O(^TMP($J,"FBE",FBAAIN,FBL)) Q:'FBL  D
 . . . S FBX=$G(^TMP($J,"FBE",FBAAIN,FBL))
 . . . I FBX]"" D PTXT(.FBXL,"  "_FBX)
 ;
 ; List Invoices Waiting for Ack
 I FBCNT("ACKW")>0 D
 . N FBAAIN
 . D PTXT(.FBXL," ")
 . D PTXT(.FBXL,"List of Invoices Waiting for Acknowledgement")
 . S FBAAIN="" F  S FBAAIN=$O(^TMP($J,"FBW",FBAAIN)) Q:FBAAIN=""  D
 . . D PTXT(.FBXL,"Invoice: "_FBAAIN)
 ;
 ; Report Rejected Acks
 I $D(^FBHL(163.5,"ARS","N")) D
 . N FBAAIN,FBFDA,FBI,FBQDA,FBTXT,FBWP,FBX
 . D PTXT(.FBXL," ")
 . D PTXT(.FBXL,"List of Rejected Invoices that have not been reported.")
 . S FBQDA=0 F  S FBQDA=$O(^FBHL(163.5,"ARS","N",FBQDA)) Q:'FBQDA  D
 . . S FBQY=$G(^FBHL(163.5,FBQDA,0))
 . . S FBAAIN=$P(FBQY,U)
 . . D PTXT(.FBXL,"Invoice: "_FBAAIN)
 . . ;
 . . K FBWP
 . . S FBX=$$GET1^DIQ(163.5,FBQDA_",",11,"","FBWP")
 . . S FBI=0 F  S FBI=$O(FBWP(FBI)) Q:'FBI  D
 . . . S FBTXT=FBWP(FBI)
 . . . D PTXT(.FBXL,"  "_FBTXT)
 . . ;
 . . K FBFDA
 . . S FBFDA(163,FBQDA_",",10)="R" ; set reject status = reported
 . . I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 D PTXT(.FBXL," ")
 D PTXT(.FBXL,"END OF SUMMARY MESSAGE")
 ;
 ; send message
 S XMSUB="FEE BASIS FPPS Transmit "_$$FMTE^XLFDT(FBXMIT("START"),"DF")
 S XMDUZ="FEE BASIS"
 S XMY("G.FEE")=""
 S XMTEXT="^TMP($J,""FBX"","
 D ^XMD
 Q
 ;
PTXT(FBXL,FBTXT) ; Post line of text in global array for summary message
 ; input
 ;   FBXL  - last line number used, passed by reference
 ;   FBTXT - line of text
 ; output
 ;   FBXL -  increments value by 1
 ;   ^TMP($J,"FBX",input line+1)=text
 ;
 S FBXL=FBXL+1
 S ^TMP($J,"FBX",FBXL)=FBTXT
 ;
 Q
 ;
 ;FBFHLX1
