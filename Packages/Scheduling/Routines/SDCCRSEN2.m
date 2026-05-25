SDCCRSEN2 ;CCRA/LB,PB - Appointment retrieval API;
 ;;5.3;Scheduling;**912,936**;;Build 65
 ;SAC EXEMPTION 202505291453-05 : CCRA use of vendor specific code
 ;Patch 912 change to add a new comment to the consult
 ;Patch 936 fixes an issue with address formatting
 Q
 ;Check the status of the consult. if it is scheduled or canceled return 1, otherwise return 0
CHKAPPT(CONSID,TYPE) ;
 I CONSID="" Q 0
 S ST=0
 I TYPE="SCHEDULE" D
 .S TSTATUS=$O(^ORD(100.01,"B","SCHEDULED",0))
 .S:$P(^GMR(123,CONSID,0),"^",12)=TSTATUS ST=1
 ;When checking cancel, check status, if status = scheduled, then check to see if there is an appointment
 ;for the appointment date/time (SDECSTART). if status = scheduled and there is an appointment for the
 ;patient on the SDECSTART time, then it is considered the original and return 1. otherwise return 0
 I TYPE="CANCEL" D
 .S TSTATUS=$O(^ORD(100.01,"B","CANCELLED",0))
 .S:$P(^GMR(123,CONSID,0),"^",12)=TSTATUS ST=1
 .I ST=0 D
 ..S:'$D(^DPT(DFN,"S",STARTFM1)) ST=1
 I TYPE="NOSHOW" D
 .S TSTATUS=$O(^ORD(100.01,"B","SCHEDULED",0))
 .;S:$P(^GMR(123,CONSID,0),"^",12)=TSTATUS ST=1
 .I ST=0 D
 ..S:'$D(^DPT(DFN,"S",STARTFM1)) ST=1
 Q ST
ADDCOMMENT(SDECSTART,PROV,PROV1,PROVIDERADDRESS,PROVIDERPHONE) ;
 S I=1
 S COMMENT(I)="Patient has an appointment on "_SDECSTART_" with "_$G(PROV)_".",I=I+1
 S:$G(PROVIDERADDRESS)'="" COMMENT(I)="at "_$G(PROVIDERADDRESS),I=I+1
 S:$G(PROVIDERPHONE)'="" COMMENT(I)="PHONE NUMBER: "_$G(PROVIDERPHONE),I=I+1
 D NOW^%DTC
 D CMT^GMRCGUIB(CONID,.COMMENT,DUZ,%,DUZ)
 K ZIP,TSTATUS,STREET2,STATE,ST,PHONE,OFFICE,COMMENT,CITY,%,I
 Q
ADDCANCOMMENT(SDECSTART,PROV,PROV1,PROVIDERADDRESS,PROVIDERPHONE) ;
 D NOW^%DTC
 S I=1
 S CANCELEDBY=$P(USERMAIL,"@")
 S COMMENT(I)="Patient's appointment on "_SDECSTART_" with "_$G(PROV),I=I+1
 S:$G(PROVIDERADDRESS)'="" COMMENT(I)="at "_$G(PROVIDERADDRESS),I=I+1
 S:$G(PROVIDERPHONE)'="" COMMENT(I)="PHONE NUMBER: "_$G(PROVIDERPHONE),I=I+1
 S COMMENT(I)="was canceled by "_$P($G(CANCELEDBY),".",1)_" "_$P($G(CANCELEDBY),".",2)_" on "_SDECSTART_".",I=I+1
 D NOW^%DTC
 D CMT^GMRCGUIB(CONID,.COMMENT,DUZ,%,DUZ)
 K ZIP,TSTATUS,STREET2,STATE,ST,PHONE,OFFICE,COMMENT,CITY,CANCELEDBY,%,I
 Q
NOSHOWCOMMENT(SDECSTART,PROV,PROV1,PROVIDERADDRESS,PROVIDERPHONE) ;
 S I=1
 S CANCELEDBY=$P(USERMAIL,"@")
 S COMMENT(I)="Patient failed to make an appointment on "_SDECSTART_" with "_$G(PROV),I=I+1
 S:$G(PROVIDERADDRESS)'="" COMMENT(I)="at "_$G(PROVIDERADDRESS),I=I+1
 S:$G(PROVIDERPHONE)'="" COMMENT(I)="PHONE NUMBER: "_$G(PROVIDERPHONE),I=I+1
 D NOW^%DTC
 D CMT^GMRCGUIB(CONID,.COMMENT,DUZ,%,DUZ)
 K ZIP,TSTATUS,STREET2,STATE,ST,PHONE,OFFICE,COMMENT,CITY,%,I
 Q
