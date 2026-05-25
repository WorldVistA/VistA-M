RCDPESCR ;AITC/CJE - NEW ERA STATUS CHANGE REPORT ;05-NOV-02
 ;;4.5;Accounts Receivable;**439**;Mar 20, 1995;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
SET ; Set Logic for MUMPS cross reference to create Match Status Audit data
 N IENS,EFTIEN,FDA,NOW
 S EFTIEN=""
 I X(1)=1!(X(1)=-1) S EFTIEN=$$GETEFT(DA)
 S NOW=$$NOW^XLFDT()
 S IENS="+1,"_DA_","
 S FDA(344.43,IENS,.01)=NOW
 S FDA(344.43,IENS,.02)=DUZ
 S FDA(344.43,IENS,.03)=X1(1)
 S FDA(344.43,IENS,.04)=X(1)
 S FDA(344.43,IENS,.05)=EFTIEN
 ;
 D UPDATE^DIE("","FDA")
 Q
 ;
GETEFT(ERAIEN) ; Given an internal entry number of an ERA return the matched EFT
 ; Input - ERAIEN : Internal entry number of an Electronic Remttance advice (file #344.4)
 ; Returns - Internal entry number of an Electronic funs transfer (file #344.31)
 Q $O(^RCY(344.31,"AERA",ERAIEN,""))
