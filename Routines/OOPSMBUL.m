OOPSMBUL ;HIRMFO/REL-Bulletin ;3/30/98
 ;;2.0;ASISTS;**2,4,15**;Jun 03, 2002;Build 9
 Q
MFAC ;
 N NIEN,NGRP,TEST
 S NIEN=$$GET1^DIQ(2260,IEN,13,"I")
 S NGRP=GRP_" - "_$$GET1^DIQ(4,NIEN,99,"E")
 S TEST=$$FIND1^DIC(3.8,"","AMX",NGRP)
 I TEST S GRP=NGRP
 D GRP
 Q
CASE(IEN) ;
 N CN,SUP,SUP2,Y,GRP
 S XMB="OOPS CASE",X0=$G(^OOPS(2260,IEN,0)) K XMY
 S CN=$P(X0,U,1),SUP=$P(X0,U,8),XMY(SUP)=""
 S SUP2=$P(X0,U,9) I SUP2>0 S XMY(SUP2)=""
 S XMB(3)=CN
 ; V2 - 05/09/02 LLH - add whether inj or illness
 S XMB(6)=$$GET1^DIQ(2260,IEN,52)
 ; Patch 8 - added display of supervisors name to bulletin
 S XMB(4)=$$GET1^DIQ(200,SUP,.01,"E")
 I SUP2>0 S XMB(5)=$$GET1^DIQ(200,SUP2,.01,"E")
 S Y=$P(X0,U,5) D DD^%DT S XMB(2)=Y
 S Y=$P(X0,U,3)
 S GRP="OOPS INJURY"
 D MFAC
 S GRP="OOPS UNION"
 D MFAC
 I $P(X0,U,4)>10 S GRP="OOPS EH" D MFAC
 ; next 2 lines restrict access to delivered message - 060303 LLH
 S XMBODY="",XMINSTR("FLAGS")="IX"
 D TASKBULL^XMXAPI(DUZ,"OOPS CASE",.XMB,XMBODY,.XMY,.XMINSTR)
 Q
SAFETY(IEN) ; Safety Officer Bulletin
 N GRP
 S XMB="OOPS SAFETY",X0=$G(^OOPS(2260,IEN,0)) K XMY
 S XMB(1)=$P(X0,U,2)
 S XMB(3)=$P(X0,U,1)
 S Y=$P(X0,U,5) D DD^%DT S XMB(2)=Y
 S GRP="OOPS SAFETY"
 D MFAC
 D ^XMB K XMB,XMY,XMM,XMDT
 Q
CIO(IEN) ; OOPS INCIDENT OUTCOME REQUIRED BULLETIN
 ;this bulletin is sent to the safety officer when the response to the 
 ;INITIAL RETURN TO WORK STATUS (field #352) is "Days Away Work" or 
 ;"Job Transfer/Transfer"
 ;Input:  IEN of the ASISTS case
 N GRP,XMB,X0
 S XMB="OOPS INCIDENT OUTCOME REQUIRED",X0=$G(^OOPS(2260,IEN,0)) K XMY
 S XMB(1)=$P(X0,U,1)
 S GRP="OOPS SAFETY"
 D MFAC
 D ^XMB K XMB,XMY,XMM,XMDT
 Q
CLSCASE(IEN) ; Bulletin to Safety & WC whenever a case is closed
 ;  01/02/04 Patch 4, llh
 ;  Input
 ;    IEN - Internal record number
 ;
 N GRP
 K XMB,XMY,X0
 S XMB="OOPS CASE CLOSE NOTIFICATION"
 S X0=$P($G(^OOPS(2260,IEN,0),"CASE UNDEFINED"),U)
 S XMB(1)=X0                             ; case number
 S XMB(2)=$$GET1^DIQ(200,DUZ,.01,"E")    ; name of user closing case
 S XMB(3)=$$FMTE^XLFDT($$DT^XLFDT())     ; today's date
 S GRP="OOPS WCP" D MFAC
 D ^XMB
 S GRP="OOPS SAFETY" D MFAC
 D ^XMB K XMB,XMY,XMM,XMDT,X0
 Q
WCPBOR(IEN) ; Employee does not understand bill of rights, sent msg to wcp
 ; Input
 ;   IEN - Internal record number
 ;
 N GRP,X0
 S X0=$G(^OOPS(2260,IEN,0)) K XMY
 S XMB(1)=$P(X0,U,2)
 S XMB="OOPS WCPBOR"
 S GRP="OOPS WCP"
 D MFAC
 D ^XMB K XMB,XMY,XMM,XMDT
 Q
CONSENT(IEN,UNIREP) ; Employee consented to union notification, 
 ;                 send msg to union
 ; Input
 ;    IEN - Internal record number
 ; UNIREP - IEN from file 200 of the Union Rep - used to send bulletin
 ;
 N GRP,X0,XA
 S X0=$G(^OOPS(2260,IEN,0))
 S XA=$G(^OOPS(2260,IEN,"2162A")) K XMY
 S XMY(UNIREP)=""
 S XMB(1)=$P(X0,U),Y=$P(X0,U,5) D DD^%DT S XMB(2)=Y
 S XMB(3)=$$GET1^DIQ(2260,IEN,52)
 S XMB(4)=$$GET1^DIQ(2260,IEN,2)
 S XMB(5)=$$GET1^DIQ(2260,IEN,7)
 S XMB(6)=$$GET1^DIQ(2260,IEN,13,"I")
 S XMB(7)=$E($$GET1^DIQ(2260,IEN,18),1,28)
 S XMB(8)=$$GET1^DIQ(2260,IEN,14)
 S XMB(9)=$P(XA,U,12)_"/"_$P(XA,U,13)
 S XMB(10)=$E($$GET1^DIQ(2260,IEN,53),1,23)
 S XMB(11)=$E($$GET1^DIQ(2260,IEN,53.1),1,28)
 S XMB(12)=$E($$GET1^DIQ(2260,IEN,3),1,23)
 S XMDUZ=.5
 S XMB="OOPS CONSENT"
 D ^XMB K XMB,XMY,XMM,XMDT,XMDUZ
 Q
WCP(IEN,ACT) ; Bulletin to Super when WC edits or WX signs CA1/CA2
 ; Input
 ;   IEN - Internal record number
 ;   ACT -
 ;    "E" = Edited by the WC personnel
 ;    "S" = Signed by the WC personnel
 ;
 N SUP,SUP2,Y
 S XMB=$S(ACT="E":"OOPS WC EDITED",ACT="S":"OOPS WC SIGNED",1:"")
 I $G(XMB)="" Q
 S X0=$G(^OOPS(2260,IEN,0)) K XMY
 S SUP=$P(X0,U,8),XMY(SUP)=""
 S SUP2=$P(X0,U,9) I $G(SUP2) S XMY(SUP2)=""
 S XMB(1)=$P(X0,U,2)
 S XMB(2)=$P(X0,U,1)
 S Y=$P(X0,U,5) D DD^%DT S XMB(3)=Y
 S XMDUZ=.5
 D ^XMB K XMB,XMY,XMM,XMDT,X0,XMDUZ
 Q
SUPS(IEN) ; Bulletin to WC when Supervisor signs CA1/CA2
 ; Patch 8
 N SUP,SUP2,FORM,GRP,Y
 S XMB="OOPS WORKERS COMP",X0=$G(^OOPS(2260,IEN,0)) K XMY
 S SUP=$P(X0,U,8),XMY(SUP)=""
 S SUP2=$P(X0,U,9) I $G(SUP2) S XMY(SUP2)=""
 S XMB(1)=$P(X0,U,2)
 S XMB(2)=$P(X0,U,1)
 S Y=$P(X0,U,5) D DD^%DT S XMB(3)=Y
 S FORM=$P(X0,U,7)
 S FORM=$S(FORM=1:"CA1ES",FORM=2:"CA2ES",1:"")
 I FORM="" Q
 S Y=$P(^OOPS(2260,IEN,FORM),U,6) D DD^%DT S XMB(4)=Y
 S GRP="OOPS WCP"
 D MFAC
 D ^XMB K XMB,XMY,XMM,XMDT,X0
 Q
UNION(IEN) ; Union  Bulletin
 N GRP,Y
 S XMB="OOPS SUPERVISOR",X0=$G(^OOPS(2260,IEN,0)) K XMY
 S XMB(3)=$P(X0,U,1)
 S Y=$P(X0,U,5) D DD^%DT S XMB(2)=Y
 S GRP="OOPS UNION"
 D MFAC
 D ^XMB K XMB,XMY,XMM,XMDT
 Q
EMP(IEN) ; Employee notification to supervisor
 N GRP,SUP,SUP2
 S XMB="OOPS EMPLOYEE",X0=$G(^OOPS(2260,IEN,0)) K XMY
 S XMB(3)=$P(X0,U,1)
 S Y=$P(X0,U,5) D DD^%DT S XMB(2)=Y
 S SUP=$P(X0,U,8),XMY(SUP)=""
 S SUP2=$P(X0,U,9) I SUP2>0 S XMY(SUP2)=""
 S GRP="OOPS INJURY"
 D MFAC
 D ^XMB K XMY,XMM,XMDT
 S GRP="OOPS UNION"
 D MFAC
 S XMDUZ=.5
 D ^XMB K XMB,XMY,XMM,XMDT,XMDUZ
 Q
BOR(IEN) ; Employee Bill of Rights
 N EMP
 S XMB="OOPS BILL OF RIGHTS" K XMY
 S EMP=$O(^VA(200,"SSN",SSN,0)),XMY(EMP)=""
 D ^XMB K XMB,XMY,XMM,XMDT
 Q
GRP ; Get Mail group Members for GRP
 I GRP="" Q
 S XMY("I:G."_GRP)=""
 Q
