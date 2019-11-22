ORY397A ;ISP/JLC - POST FOR PATCH OR*3.0*397 ;Aug 01, 2019@15:46
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**397**;Dec 17, 1997;Build 22
 ;
 Q
EN ; Task off the rebuild of the 'D' cross-reference for file #100
 N ZTDTH,ZTIO,ZTSK,ZTRTN,ZTDESC
 D BMES^XPDUTL("Queueing Rebuild of the 'D' cross-reference for ORDERS file (#100)")
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,0,10)
 S ZTRTN="TASK^ORY397A",ZTDESC="Rebuild of the 'D' xref for file #100"
 S ZTIO=""
 D ^%ZTLOAD
 I +$G(ZTSK)=0 D
 . D BMES^XPDUTL("Unable to queue the file #100 xref Rebuild, file a help desk ticket for assistance.")
 E  D
 . D BMES^XPDUTL("DONE - Task #"_ZTSK)
 Q
TASK ;
 N ORIFN,I,J,STOP,A,OR0,OR3,ORDIALOG,ORIT,STOP,ZTSTOP
 D MSG1("S")
 S STOP=0
 S ORIFN=$G(^OR(100,"D",0)) I ORIFN="" S ORIFN=" "
 F I=1:1 D  Q:'ORIFN  I STOP Q
 . S ORIFN=$O(^OR(100,ORIFN),-1) Q:'ORIFN
 . S OR0=$G(^OR(100,ORIFN,0)) Q:'OR0
 . S ORDIALOG=+$P(OR0,"^",5),A=ORDIALOG_";ORD(101.41," K ^OR(100,"D",A,ORIFN)
 . S OR3=$G(^OR(100,ORIFN,3)) Q:'OR3
 . S ORIT=$P(OR3,"^",4)
 . I $G(ORIT),ORIT?.E1";ORD(101.41," S ^OR(100,"D",ORIT,ORIFN)=""
 . S ^OR(100,"D",0)=ORIFN
 . I '(I#100000) D  I STOP Q
 .. F J=1:1:510 H 1 I '(J#120) S STOP=$$REQ2STOP() I STOP Q
 I 'STOP K ^OR(100,"D",0) D MSG
 I STOP D MSG1("RS")
 Q
MSG ;
 N XMSUB,XMY,XMTEXT,XMDUZ,ORTEXT,SITE,I,A
 S ORTEXT(1)="Rebuild of 'D' cross-reference completed for "_$$SITE^VASITE()
 S ORTEXT(2)=" "
 S XMDUZ=DUZ
 S XMSUB="Rebuild of 'D' cross-reference completed"
 S XMY("CRUMLEY.JAMIE@FORUM.DOMAIN.EXT")="",XMY("THOMPSON.WILLIAM_ANTHONY@FORUM.DOMAIN.EXT")=""
 S XMTEXT="ORTEXT("
 D ^XMD
 Q
MSG1(ORTYP) ;
 N XMSUB,XMY,XMTEXT,XMDUZ,ORTEXT,SITE,I,A,ORTXT,ORSUB
 I ORTYP="S" S ORTXT="Rebuild of 'D' cross-reference STARTED for "_$$SITE^VASITE(),ORSUB="Rebuild of 'D' cross-reference started"
 I ORTYP="RS" S ORTXT="Rebuild of 'D' cross-reference STOP REQUESTED for "_$$SITE^VASITE(),ORSUB="Rebuild of D' cross-reference stop requested"
 S ORTEXT(1)=ORTXT
 S ORTEXT(2)=" "
 S XMDUZ=DUZ
 S XMSUB=ORSUB
 S XMY("CRUMLEY.JAMIE@FORUM.DOMAIN.EXT")="",XMY("THOMPSON.WILLIAM_ANTHONY@FORUM.DOMAIN.EXT")=""
 S XMTEXT="ORTEXT("
 D ^XMD
 Q
REQ2STOP() ;
 ; Check for task stop request
 ; Returns 1 if stop request made.
 N STATUS,X
 S STATUS=0
 I '$D(ZTQUEUED) Q 0
 S X=$$S^%ZTLOAD()
 I X D  ;
 . S STATUS=1
 . S X=$$S^%ZTLOAD("Received shutdown request")
 . S ZTSTOP=1
 ;
 Q STATUS
