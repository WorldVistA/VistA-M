XMFAX ;ISC-SF/GMB-Fax ;04/08/2002  14:46
 ;;8.0;MailMan;;Jun 28, 2002
FAX(XMZ) ; Fax a message
 N XMABORT,XMCNT,XMFIEN,XMQUIET
 S XMQUIET=1 ; "quiet flag"
 S XMABORT=0
 D CRE8FAX(XMZ,XMQUIET,.XMCNT,.XMABORT) Q:XMABORT
 D SENDFAX(XMQUIET,XMFIEN,XMCNT)
 Q
CRE8FAX(XMZ,XMQUIET,XMCNT,XMABORT) ;
 N XMFID
 D RECORD(XMQUIET,.XMFID,.XMFIEN,.XMABORT) Q:XMABORT
 L +^AKF("FAX",XMFIEN)
 D RECIPS(XMZ,XMFID,XMFIEN,.XMCNT)
 D BODY(XMZ,XMFIEN)
 L -^AKF("FAX",XMFIEN)
 Q
RECORD(AKQ,AKFAX,AKIEN,XMABORT) ; Add record to fax file
 ; AKFAX    Fax ID
 ; AKIEN    Record number in ^AKF("FAX",
 D NE^AKFAX0 I '$D(AKFAX) S XMABORT=1 Q  ; Add record to fax file
 S $P(^AKF("FAX",AKIEN,0),U,4)=1  ; This is a MailMan-generated fax
 Q
RECIPS(XMZ,XMFID,XMFIEN,XMCNT) ; Add recipients to fax record and update recipient record in mail msg.
 N I,XMREC,XMIENS,XMFDA
 S I="",XMCNT=0
 F  S I=$O(^XMB(3.9,XMZ,1,"AFAX",I)) Q:I=""  D
 . S XMREC=$G(^AKF("FAXR",I,0)) Q:XMREC=""
 . S XMCNT=XMCNT+1
 . S XMIENS="+1,"_XMFIEN_","
 . S XMFDA(589500.01,XMIENS,.01)=I ; Pointer to recipient
 . S XMFDA(589500.01,XMIENS,1)=$$EZBLD^DIALOG(39303.7) ;Awaiting Transmission Path
 . S XMFDA(589500.01,XMIENS,2)=$P(XMREC,U,2) ; Recipient fax phone
 . S XMFDA(589500.01,XMIENS,3)=$P(XMREC,U,3) ; Recipient physical location
 . S XMFDA(589500.01,XMIENS,4)=$P(XMREC,U,4) ; Recipient voice phone
 . D UPDATE^DIE("","XMFDA") ; Add recipient to fax record
 . S XMIENS=$O(^XMB(3.9,XMZ,1,"AFAX",I,""))_","_XMZ_","
 . S XMFDA(3.91,XMIENS,4)=$$NOW^XLFDT()    ; Current date/time
 . S XMFDA(3.91,XMIENS,5)="@"  ; get rid of status
 . S XMFDA(3.91,XMIENS,13)="@" ; get rid of xref
 . S XMFDA(3.91,XMIENS,14)=XMFID ; fax id
 . D FILE^DIE("","XMFDA") ; Update mail msg recipient
 Q
BODY(XMZ,XMFIEN) ; Copy the msg text to the fax text
 N XMTEXT,XMREC,I,XMDATE,XMFROM
 S XMREC=^XMB(3.9,XMZ,0)
 S I=1,XMTEXT(I)=$$EZBLD^DIALOG(34536,$P(XMREC,U,1))_"  "_$$EZBLD^DIALOG(34537,XMZ) ; Subj: |1|  [#|1|]
 S XMDATE=$$MMDT^XMXUTIL1($P(XMREC,U,3))
 I $L(XMTEXT(I))+$L(XMDATE)+1>79 S I=I+1,XMTEXT(I)=XMDATE
 E  S XMTEXT(I)=XMTEXT(I)_" "_XMDATE
 S I=I+1,XMTEXT(I)=$$EZBLD^DIALOG(39330,^XMB("NETNAME")) ;Site: |1|
 S I=I+1,XMTEXT(I)=$$EZBLD^DIALOG(34538,$$NAME^XMXUTIL($P(XMREC,U,2),1)) ; From: |1|
 I DUZ'=$P(XMREC,U,2) S I=I+1,XMTEXT(I)=$$EZBLD^DIALOG(39331,$$NAME^XMXUTIL(DUZ,1)) ;Sender: |1|
 S I=I+1,XMTEXT(I)="-------------------------------------------------------------------------------"
 S I=I+1,XMTEXT(I)=""
 D WP^DIE(589500,XMFIEN_",",7,"","XMTEXT")
 D WP^DIE(589500,XMFIEN_",",7,"A","^XMB(3.9,"_XMZ_",2)")
 Q 
SENDFAX(AKQ,AKIEN,AKML) ;
 W !,$$EZBLD^DIALOG(39332) ;Sending to fax
 D QUE^AKFAX0
 Q
FAXHDR(XMFID,XMFTO) ; Print the fax header
 W !,$$EZBLD^DIALOG(39333,XMFTO) ;MailMan FAX for |1|
 N XMPARM S XMPARM(1)=XMFID,XMPARM(2)=$$FMTE^XLFDT($$NOW^XLFDT,5)
 W !,$$EZBLD^DIALOG(39334,.XMPARM),! ;FAXmail ID: |1|, Faxed: |2|
 Q
