DGENUPA ;ALB/CJM - API FOR UPLOAD AUDIT ; 04-APR-94
 ;;5.3;REGISTRATION;**147**;08/13/93
 ;
STORE(AUDIT,ERROR) ;
 ;Description: Creates a new entry in the ENROLLMENT/ELIGIBILITY UPLOAD
 ;AUDIT file (#27.14).
 ;
 ;INPUT:
 ;  AUDIT: an array containing the record to be stored. (pass by reference)
 ;Output:
 ;  Function Value: the ien of the entry created, or 0 on failure
 ;  ERROR: on failure, will return an error message (optional) (pass by reference)
 ;
 N DATA,ADD
 S ADD=$$CHECK(.AUDIT,.ERROR)
 I 'ADD G STEXIT
 S DATA(.01)=AUDIT("MSGID")
 S DATA(.02)=AUDIT("DATETIME")
 S DATA(.03)=AUDIT("DFN")
 S DATA(1)="AUDIT(""CHANGES"")"
 S ADD=$$ADD^DGENDBS(27.14,,.DATA,.ERROR)
 ;
STEXIT ;
 Q +ADD
 ;
CREATE(DFN,WHEN,MSGID,AUDIT) ;
 ;Description: Creates an array containing the AUDIT object. There are
 ;no changes initially in the AUDIT object.
 ;
 ;Input:
 ;  DFN - ien of record in the PATIENT file
 ;  WHEN - date & time when the upload occurred (uses current date/time if not provided)
 K AUDIT
 S AUDIT("DFN")=$G(DFN)
 I '$G(WHEN) S WHEN=$$NOW^XLFDT
 S AUDIT("DATETIME")=$G(WHEN)
 S AUDIT("MSGID")=$G(MSGID)
 D ADDCHNG(.AUDIT,">>No Change <<")
 S AUDIT("CHANGES")=0
 Q
 ;
CHECK(AUDIT,ERROR) ;
 ;Description: checks the validity of the AUDIT object
 ;
 ;Input:
 ;  AUDIT - an array containing the AUDIT object (pass by reference)
 ;
 ;Output:
 ;  Function Value - 1 if valid, 0 otherwise
 ;  ERROR - if not valid, returns an error message (optional) (pass by reference)
 ;
 N OK
 S OK=1
 I '$G(AUDIT("DFN")) S OK=0,ERROR="NO PATIENT"
 I OK,'$D(^DPT(AUDIT("DFN"))) S OK=0,ERROR="PATIENT NOT FOUND"
 I OK,'$D(AUDIT("DATETIME")) S OK=0,ERROR="DATE/TIME OF UPLOAD NOT SPECIFIED"
 I OK,'$D(AUDIT("MSGID")) S OK=0,ERROR="MESSAGE ID NOT SPECIFIED"
 Q OK
 ;
ADDCHNG(AUDIT,LINE) ;
 ;Description: Adds one line to the record of changes from an upload.
 ;
 ;Input:
 ;  AUDIT - an array containing the AUDIT object. (pass by reference)
 ;  LINE - the line to be added
 ;
 ;Output:
 ;  AUDIT - the updated array containing the AUDIT object (pass by reference)
 ;
 S AUDIT("CHANGES")=1+$G(AUDIT("CHANGES"))
 S AUDIT("CHANGES",AUDIT("CHANGES"))=$G(LINE)
 Q
AUDITID(IEN) ;
 W "DT/TM UPLOADED: "_$P(^DGENA(27.14,IEN,0),"^",2)
 W "  MSG ID: "_$P(^DGENA(27.14,IEN,0),"^",2)
 Q
