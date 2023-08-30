XUPSPRA ;ALB/CMC - Build PRA segment;Aug 6, 2010
 ;;8.0;KERNEL;**551,689**;Jul 10, 1995;Build 113
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN(XUPSIEN,XUPSSTR,HL) ;
 ;XUPSIEN - New Person Internal Entry Number
 ;XUPSSTR - sequence numbers which should be used, only field 6 for DEA# at this point used
 ;HL - hl7 array variables
 ;RETURN:  PRA segment returned or -1^error message
 ;
 N XUPSREC,NUM
 I XUPSIEN=""!(XUPSSTR="")!('$D(HL)) S XUPSREC="-1^Missing Parameters" G QUIT ;missing parameter
 S $P(XUPSREC,HL("FS"),1)="PRA" ;sequence 1 set to segment type
 ;DEA# FIELD 6
 ;S NUM=$P($G(^VA(200,XUPSIEN,"PS")),"^",2)
 S NUM=$$PRDEA^XUSER(XUPSIEN)
 I NUM="" S NUM=HL("Q")
 S $P(XUPSREC,HL("FS"),7)=NUM
QUIT Q XUPSREC
 ;
DEAXDT(DEA) ; 689 - Return Expiration Date for DEA 
 N DEAIEN,RET
 Q:'$L($G(DEA)) ""
 S DEAIEN=$$FIND1^DIC(8991.9,"","X",DEA)
 S RET=$$GET1^DIQ(8991.9,DEAIEN,.04,"I")
 Q RET
 ;
PRXDT(IEN) ; 689 - called from PRXDT^XUSER
 Q:'$D(IEN) ""
 N J,K,NP,RET S RET="",NP=0
 S J=0 F  S J=$O(^VA(200,IEN,"PS4",J)) Q:'J  D  Q:$L(RET)
 . S NP=1,K=$$GET1^DIQ(200.5321,J_","_IEN_",",.03,"I") D:K
 .. I $$GET1^DIQ(8991.9,K,.06,"I") S RET=$$GET1^DIQ(8991.9,K,.04,"I")
 Q RET
 ;
PRDEA(IEN) ; 689 - Called from PRDEA^XUSER
 Q:'$D(IEN) ""
 N J,K,NP,RET S RET="",NP=0
 S J=0 F  S J=$O(^VA(200,IEN,"PS4",J)) Q:'J  D  Q:$L(RET)
 . S NP=1,K=$$GET1^DIQ(200.5321,J_","_IEN_",",.03,"I") D:K
 .. I $$GET1^DIQ(8991.9,K,.06,"I") S RET=$$GET1^DIQ(8991.9,K,.01)
 Q RET
 ;
PRSCH(IEN,SCHTYP) ; 689 - Called from PRSCH^XUSER
 ; IEN      :  PROVIDER DUZ
 ; SCHTYP   :  NULL or 0 = First Active DEA Number
 ;                     1 = Inpatient DEA 
 ;                     2 = First Institutional DEA
 Q:'$D(IEN) ""
 N J,K,NP,RET,ALTRET,DEACT
 S RET="",NP=0,ALTRET=""
 ; First Active DEA
 I '$G(SCHTYP) S DEACT=$$DEA^XUSER(0,IEN) D  Q RET
 . N DEAIEN S DEAIEN=$$FIND1^DIC(8991.9,"","X",$P(DEACT,"-")) Q:'DEAIEN
 . S RET=$G(^XTV(8991.9,DEAIEN,2))
 S J=0 F  S J=$O(^VA(200,IEN,"PS4",J)) Q:'J  D  Q:$L(RET)
 . S NP=1,K=$$GET1^DIQ(200.5321,J_","_IEN_",",.03,"I") D:K
 .. ; If Individual DEA, find one marked for Inpatient
 .. I $G(SCHTYP)=1,$$GET1^DIQ(8991.9,K,.06,"I") S RET=$G(^XTV(8991.9,K,2)) Q
 .. ; Get schedules from first Institutional DEA if it exists
 .. I $G(SCHTYP)=2 I $$GET1^DIQ(8991.9,K,.07,"I")=1 S RET=$G(^VA(200,IEN,"PS3")) Q
 Q RET
 ;
DEASCH(DEA) ; 689 - Return DEA schedules for DEA
 ; DEA number
 N RET,DEAIEN
 S RET="",DEAIEN=""
 Q:'$L($G(DEA)) RET
 S DEAIEN=$$FIND1^DIC(8991.9,"","X",DEA,"B")
 Q:DEAIEN'>0 ""
 S RET=$G(^XTV(8991.9,DEAIEN,2))
 Q RET
