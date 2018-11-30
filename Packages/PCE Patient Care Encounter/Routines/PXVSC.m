PXVSC ;SLC/PKR - APIs for Clinical Reminder indexes. ;08/11/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 Q
 ;=============================================
KVSC(X,DA) ;Delete indexes for the V Standard Codes file.
 ;X(1)=CODING SYSTEM, X(2)=CODE,X(3)=DFN, X(4)=VISIT IEN,
 ;X(5)=EVENT DATE AND TIME.
 N DATE,VISIT
 S VISIT=$G(^AUPNVSIT(X(4),0))
 I VISIT="" Q
 ;If it is availble, use the Event Date/Time for the date.
 S DATE=$G(X(5))
 I DATE="" S DATE=$P(VISIT,U,1)
 K ^PXRMINDX(9000010.71,"IP",X(1),X(2),X(3),DATE,DA)
 K ^PXRMINDX(9000010.71,"PI",X(3),X(1),X(2),DATE,DA)
 Q
 ;
 ;=============================================
SVSC(X,DA) ;Set indexes for the V Standard Codes file.
 ;X(1)=CODING SYSTEM, X(2)=CODE,X(3)=DFN, X(4)=VISIT IEN,
 ;X(5)=EVENT DATE AND TIME
 N DATE,VISIT
 S VISIT=$G(^AUPNVSIT(X(4),0))
 I VISIT="" Q
 ;If it is availble, use the Event Date/Time for the date.
 S DATE=$G(X(5))
 I DATE="" S DATE=$P(VISIT,U,1)
 S ^PXRMINDX(9000010.71,"IP",X(1),X(2),X(3),DATE,DA)=""
 S ^PXRMINDX(9000010.71,"PI",X(3),X(1),X(2),DATE,DA)=""
 Q
 ;
