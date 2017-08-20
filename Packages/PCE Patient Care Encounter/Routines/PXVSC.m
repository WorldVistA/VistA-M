PXVSC ;SLC/PKR - APIs for Clinical Reminder indexes. ;02/04/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 84
 ;Temporary routine - this code should go to PXPXRM.
 ;
 Q
 ;=============================================
KVSC(X,DA) ;Delete indexes for the V Standard Codes file.
 ;X(1)=CODING SYSTEM, X(2)=CODE,X(3)=DFN, X(4)=VISIT.
 N DATE
 ;If it is availble, use the Event Date/Time for the date.
 S DATE=$P($G(^AUPNVSC(DA,12)),U,1)
 I DATE="" S DATE=$P($G(^AUPNVSIT(X(4),0)),U,1)
 I DATE="" Q
 K ^PXRMINDX(9000010.71,"IP",X(1),X(2),X(3),DATE,DA)
 K ^PXRMINDX(9000010.71,"PI",X(3),X(2),X(1),DATE,DA)
 Q
 ;
 ;=============================================
SVSC(X,DA) ;Set indexes for the V Standard Codes file.
 ;X(1)=CODING SYSTEM, X(2)=CODE,X(3)=DFN, X(4)=VISIT.
 N DATE
 ;If it is availble, use the Event Date/Time for the date.
 S DATE=$P($G(^AUPNVSC(DA,12)),U,1)
 I DATE="" S DATE=$P($G(^AUPNVSIT(X(4),0)),U,1)
 I DATE="" Q
 S ^PXRMINDX(9000010.71,"IP",X(1),X(2),X(3),DATE,DA)=""
 S ^PXRMINDX(9000010.71,"PI",X(3),X(2),X(1),DATE,DA)=""
 Q
 ;
 ;=============================================
VSCDATA(DA,DATA) ;Return data for a specified V Standard Codes entry.
 N TEMP
 S TEMP=^AUPNVSC(DA,0)
 S DATA("VISIT")=$P(TEMP,U,3)
 S DATA("PROVIDER NARRATIVE")=$P(TEMP,U,4)
 S DATA("COMMENTS")=$G(^AUPNVSC(DA,811))
 S TEMP=$G(^AUPNVSC(DA,220))
 I TEMP="" Q
 S DATA("MAGNITUDE")=$P(TEMP,U,1)
 S TEMP=$P(TEMP,U,2)
 I TEMP'="" S DATA("UCUM CODE")=$$GET1^DIQ(757.5,TEMP,.01)
 Q
 ;
