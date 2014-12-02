XUPCSRVR ;OAK/BT- SERVER TO UPDATE THE PERSON CLASS(#8932.1) FILE ;12/05/13
 ;;8.0;KERNEL;**634**;Jul 10, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;Auto update Person Class file. The updated message is sent out from the Person Class master file on Forum
S1 ;get data from email; this starting point for SERVER OPTION. [XUPCSRVR] UPDATE PERSON CLASS SERVER
 K ^TMP("PSC DATA",$J)
 K ^TMP("XUBA",$J)
 N XUI,XUDATA,XUIEN,XUY,XUSBJ
 S XUY=0
 S XUSBJ=$G(^XMB(3.9,XQMSG,0)) I $E(XUSBJ,1,24)'="UPDATE PERSON CLASS ENTR" Q
 S XUI=.99 F  S XUI=$O(^XMB(3.9,XQMSG,2,XUI)) Q:XUI'>0  D
 . S XUDATA=$G(^XMB(3.9,XQMSG,2,XUI,0))
 . S XUIEN=$P(XUDATA,"$$")
 . S XUDATA=$P(XUDATA,"$$",2)
 . S ^TMP("PSC DATA",$J,XUI)=XUDATA
 . I $P(XUDATA,":")="DAT" S XUDATA=$P(XUDATA,":",2) I $P(XUDATA,"^")=XUIEN D ADD(XUDATA) Q  ; update entry
 . I $P(XUDATA,":")="DEF" S XUY=XUY+1,^TMP("XUBA",$J,XUIEN,XUY,0)=$P(XUDATA,":",2,99) Q
 . I $P(XUDATA,":")="END" D DEFI(XUIEN) S XUY=0 Q  ; update definition
 . Q
 D SEND("SUMMARY UPDATE OF THE PERSON CLASS FILE") ;send the updated information to the mail group PERSON CLASS UPDATE
 K XQMSGP
 Q
 ;
 ;-----------------------------------
ADD(XUDATA) ; add or update a single entry
 N FDA,FDAIEN,XUD
 S XUD=$G(XUDATA)
 S FDAIEN(1)=$P(XUD,"^")
 S FDA(8932.1,"+1,",.01)=$P(XUD,"^",2)
 S FDA(8932.1,"+1,",1)=$P(XUD,"^",3)
 S FDA(8932.1,"+1,",2)=$P(XUD,"^",4)
 S FDA(8932.1,"+1,",3)=$P(XUD,"^",5)
 S FDA(8932.1,"+1,",5)=$P(XUD,"^",6)
 S FDA(8932.1,"+1,",5)=$P(XUD,"^",7)
 S FDA(8932.1,"+1,",6)=$P(XUD,"^",8)
 S FDA(8932.1,"+1,",8)=$P(XUD,"^",10)
 S FDA(8932.1,"+1,",90002)=$P(XUD,"^",12)
 ;----------------
 F  L +^USC(8932.1,FDAIEN(1),0):$S($D(DILOCKTM):DILOCKTM,1:3) Q:$T  H $S($D(DILOCKTM):DILOCKTM,1:3)
 D DEL(+XUDATA) ;clean the entry before update 
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 L -^USC(8932.1,FDAIEN(1),0)
 Q
 ;------------------------------------
DEL(XUIEN)  ;delete entry
 N DIR,DA,DIK
 S DA=$G(XUIEN)
 S DIK="^USC(8932.1," D ^DIK
 Q
 ;
 ;^USC(8932.1,D0,0)= (#.01) PROVIDER TYPE [1F] ^ (#1) CLASSIFICATION [2F] ^ 
 ;                ==>(#2) AREA OF SPECIALIZATION [3F] ^ (#3) STATUS [4S] ^ (#4) 
 ;                ==>DATE INACTIVATED [5D] ^ (#5) VA CODE [6F] ^ (#6) X12 CODE 
 ;                ==>[7F] ^ (#7) reserved [8F] ^ (#8) SPECIALTY CODE [9F] ^ 
 ;^USC(8932.1,D0,11,0)=^8932.111^^  (#11) DEFINITION
 ;^USC(8932.1,D0,11,D1,0)= (#.01) DEFINITION [1W] ^ 
 ;^USC(8932.1,D0,90002)=  ^ (#90002) INDIVIDUAL/NON [2S] ^
 ;------------------------------------
 ;
DEFI(XUIEN) ; 
 N XUI
 S XUI=XUIEN_","
 D WP^DIE(8932.1,XUI,11,"K","^TMP(""XUBA"",$J,XUIEN)")
 K ^TMP("XUBA",$J)
 Q
 ;------------------------------------
SEND(XUKIND) ; Send to sites
 N ODUZ S MSG=$NA(^TMP("PSC DATA",$J))
 I DUZ<.5 S ODUZ=DUZ,DUZ=.5 ;** Change user to POSTMASTER **
 S MSGSBJ=$G(XUKIND)_"   "_$$FMTE^XLFDT(DT,1)
 I '$D(WHO) S WHO("G.PERSON CLASS UPDATE")=""
 D SENDMSG^XMXAPI(DUZ,MSGSBJ,.MSG,.WHO)
 K ^TMP("PSC DATA",$J),MSGSBJ,MSG
 Q
 ;
CRMG ;CREATE MAIL GROUP
 ;N XMY S XMY(DUZ)=""
 N XMDESC S XMDESC(1)="This mail group is to receive updated Person Class messages from the Master Person Class file from Forum account."
 N XUIEN S XUIEN=$$MG^XMBGRP("PERSON CLASS UPDATE",0,.5,1,,.XMDESC,1)
 Q
 ;
DEF ; Update definitions
 N XUI D DEF1(609)
 N XUI D DEF1(610)
 N XUI D DEF1(745)
 Q
 ;
DEF1(XUI) ; Update definition for single entry XUI
 N XUI1,XUDATA,XUY
 K ^TMP($J,"XUBA")
 F XUY=1:1:100 S XUDATA=$T(@XUI+XUY) Q:XUDATA=" ;;END"  D 
 . S ^TMP($J,"XUBA",XUI,XUY,0)=$P(XUDATA,";;",2)
 S XUI1=XUI_","
 D WP^DIE(8932.1,XUI1,11,"K","^TMP($J,""XUBA"",XUI)")
 K ^TMP($J,"XUBA")
 Q
 ;
GETDEF ; get definitions
 N XUI,XUY
 F XUI=609,610,745 D
 . S XUY=$G(^USC(8932.1,XUI,11,0)),XUY=$P(XUY,"^",3)
 . I XUY>0 D GETDES(XUI,XUY)
 Q
 ;
GETDES(XUI,XUY) ; get single entry definition
 N XUA,XUB
 W !,XUI," ;"
 F XUA=1:1:XUY W !," ;;",$G(^USC(8932.1,XUI,11,XUA,0))
 W !," ;;END"
 Q
 ;
POST ;
 D DEF ; Update for 30/1/2013
 D CRMG ;CREATE MAIL GROUP
 Q
 ;
609 ;
 ;;A health care professional who is specifically educated and trained to 
 ;;manage comprehensive orthotic patient care, including musculoskeletal and 
 ;;neuromuscular anomalies resulting from injuries or disease processes 
 ;;involving the lower extremity, upper extremity or spinal segment/s and 
 ;;positional deformation of the cranium. Orthotists assess specific patient 
 ;;needs, formulate an appropriate treatment plan, implement the treatment 
 ;;plan and provide follow-up care.   Source: American Board for 
 ;;Certification in Orthotics, Prosthetics, and Pedorthics, Inc. [7/1/2010: 
 ;;modified, 7/1/2013: modified]
 ;; 
 ;;Additional Resources: American Board for Certification in Orthotics, 
 ;;Prosthetics and Pedorthics, Inc., www.abcop.org and Board of 
 ;;Certification/Accreditation, International, www.bocusa.org.
 ;;END
610 ;
 ;;A health care professional who is specifically educated and trained to 
 ;;manage comprehensive prosthetic patient care for individuals who have 
 ;;sustained complete or partial limb loss or absence. Prosthetists assess 
 ;;specific patient needs, formulate an appropriate treatment plan, 
 ;;implement the treatment plan and provide follow-up care.   Source: 
 ;;American Board for Certification in Orthotics, Prosthetics, and 
 ;;Pedorthics, Inc. [7/1/2010: modified, 7/1/2013: modified]
 ;; 
 ;;Additional Resources: American Board for Certification in Orthotics, 
 ;;Prosthetics and Pedorthics, Inc., www.abcop.org and Board of 
 ;;Certification/Accreditation, International, www.bocusa.org.
 ;;END
745 ;
 ;;Oral and maxillofacial surgeons are trained to recognize and treat a wide 
 ;;spectrum of diseases, injuries and defects in the head, neck, face, jaws 
 ;;and the hard and soft tissues of the oral and maxillofacial region. They 
 ;;are also trained to administer anesthesia, and provide care in an office 
 ;;setting. They are trained to treat problems such as the extraction of 
 ;;wisdom teeth, misaligned jaws, tumors and cysts of the jaw and mouth, and 
 ;;to perform dental implant surgery.   Source: American College of 
 ;;Surgeons, 2013. [7/1/2013: definition added, source added, additional 
 ;;resources added]
 ;; 
 ;;Additional Resources: American Board of Oral and Maxillofacial Surgery 
 ;;and American Association of Oral and Maxillofacial Surgeons
 ;; 
 ;;While this is generally considered a specialty of dentistry, physicians 
 ;;can also be board certified as oral and maxillofacial surgeons through 
 ;;the American Board of Oral and Maxillofacial Surgery.
 ;;END
