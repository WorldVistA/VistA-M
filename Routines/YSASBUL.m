YSASBUL ;692/DCL-SEND BULLETIN VIA E-MAIL ON ASI TO SIGN ;1/23/97  11:37
 ;;5.01;MENTAL HEALTH;**24**;Dec 30, 1994
 Q
 ;
BUL(YSASIEN,YSAST,YSASI) ;Send e-mail from transcriber to interviewer that ASI is ready for signature
 Q:$G(YSASIEN)'>0
 Q:$G(YSAST)'>0
 Q:$G(YSASI)'>0
 N XMSUB,XMTEXT,XMY,XMDUZ,YSASL,YSASTE,YSASPE,YSASDUZE
 S YSASDUZE=$P(^VA(200,DUZ,0),"^")
 S XMY(DUZ)=""
 S XMY(YSAST)=""
 S XMY(YSASI)=""
 N DUZ
 S (DUZ,XMDUZ)=.5,XMSUB="ASI FOR "_$$F(.02)_" IS READY FOR REVIEW AND SIGNATURE"
 S XMTEXT="^TMP($J,""YSASBUL"","
 K ^TMP($J,"YSASBUL")
 ;names in external format
 S YSASPE=$$F(.02),YSASTE=$$F(.14)
 S ^TMP($J,"YSASBUL",$$L)="To: "_$$F(.09)
 S ^TMP($J,"YSASBUL",$$L)=" "
 S ^TMP($J,"YSASBUL",$$L)=$$F(.04)_" ASI, on "_$$F(.05)_", for "_$E($P(YSASPE,",",2))_". "_$P(YSASPE,",")_" has been completed, by "_$E($P(YSASTE,",",2))_". "_$P(YSASTE,",")_","
 S ^TMP($J,"YSASBUL",$$L)="and is ready for your review and electronic signature."
 S ^TMP($J,"YSASBUL",$$L)=" "
 S ^TMP($J,"YSASBUL",$$L)=" "
 S ^TMP($J,"YSASBUL",$$L)=" "
 S ^TMP($J,"YSASBUL",$$L)="cc: "_YSASTE
 S:YSASTE'=YSASDUZE ^TMP($J,"YSASBUL",$$L)="cc: "_YSASDUZE
 D ^XMD
 K ^TMP($J,"YSASBUL")
 Q
 ;
L() ;Line counter
 S YSASL=$G(YSASL)+1
 Q YSASL
 ;
F(YSASF) ;Return value of field
 N DIERR
 Q $$GET1^DIQ(604,YSASIEN_",",YSASF)
