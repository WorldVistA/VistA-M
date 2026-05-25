PSODEAUJ ;ALB/MFR - DEA NIGHTLY UPDATE JOB ; 11 Jul 2025  7:08 PM
 ;;7.0;OUTPATIENT PHARMACY;**770**;DEC 1997;Build 145
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 Q
AUTO ; DEA Nightly Update Scheduled Background Job Edit
 N DIC,Y S DIC(0)="XZM",DIC="^DIC(19.2,",X="PSO DEA/DOJ NIGHTLY DATA UPD" D ^DIC
 I +Y>0 S DA=Y D EDIT^XUTMOPT("PSO DEA/DOJ NIGHTLY DATA UPD") Q
 D RESCH^XUTMOPT("PSO DEA/DOJ NIGHTLY DATA UPD",$$FMADD^XLFDT(DT,1)+.0001,"","24H","L")
 D EDIT^XUTMOPT("PSO DEA/DOJ NIGHTLY DATA UPD")
 Q
 ;
DEAUPD ; Update DEA #'s that are about to expire in the DEA NUMBERS file (#8991.9)
 N DEANUM,DEAIEN,DATA,OLDDEA,MSGTXT,COUNT,MSGLINE
 ;
 I '$$PROD^XUPROD() Q   ; Will run in Prod accounts only
 ;
 S (DEAIEN,MSGLINE,COUNT)=0
 F  S DEAIEN=$O(^XTV(8991.9,DEAIEN)) Q:'DEAIEN  D  I COUNT>500 Q
 . S DEAEXP=$$GET1^DIQ(8991.9,DEAIEN,.04,"I")
 . I DEAEXP>$$FMADD^XLFDT(DT,30) Q           ; Exp. Date more than 30 days in the future
 . S DEANUM=$$GET1^DIQ(8991.9,DEAIEN,.01)
 . D GETS^DIQ(8991.9,DEAIEN,"**","","DATA")
 . M OLDDEA=DATA(8991.9,DEAIEN_",")
 . D DEADOJ^PSODEAUT(.NEWDEA,DEANUM) I '$G(NEWDEA(0)) Q
 . S $P(NEWDEA(1),"^",12)=$$HL7TFM^XLFDT($P(NEWDEA(1),"^",12))
 . I $P(NEWDEA(1),"^",12)'>DEAEXP Q      ; New Exp. Date not later than Exp. Date on file
 . ; Preserving USE FOR INPATIENT ORDERS? (#.06) and SCHEDULE permissions (#2.1-#2.6) fields (except MbM)
 . I $$GET1^DIQ(59.7,1,102,"I")'="MBM" D
 . . S $P(NEWDEA(1),"^",21)=$G(OLDDEA(.06))
 . . S $P(NEWDEA(1),"^",15)=$G(OLDDEA(2.1))
 . . S $P(NEWDEA(1),"^",16)=$G(OLDDEA(2.2))
 . . S $P(NEWDEA(1),"^",17)=$G(OLDDEA(2.3))
 . . S $P(NEWDEA(1),"^",18)=$G(OLDDEA(2.4))
 . . S $P(NEWDEA(1),"^",19)=$G(OLDDEA(2.5))
 . . S $P(NEWDEA(1),"^",20)=$G(OLDDEA(2.6))
 . D FILEFM^PSODEAUT(.RET,$G(NEWDEA(1)))
 . D ADD2MSG(DEANUM,.OLDDEA,$G(NEWDEA(1)))
 . S COUNT=COUNT+1
 I 'COUNT Q
 D ADDTXT(""),ADDTXT(COUNT_" DEA #'s have been updated.")
 D SENDMSG
 ;
 Q
 ;
ADD2MSG(DEANUM,OLDDEA,NEWDEA) ; Builds the Mailman Message to be sent to PSDRPH key holders
 ;Input: DEANUM - DEA Number
 ;       OLDDEA - DEA data before the Update
 ;       NEWDEA - DEA data after the Update
 I '$D(MSGTXT) D
 . S MSGTXT(1)="The list below shows DEA Numbers that have been updated with data from DEA/DOJ"
 . S MSGTXT(2)="Database because they were 30 days or less from expiring."
 ;
 D ADDTXT("")
 D ADDTXT("DEA #: "_DEANUM)
 D ADDTXT("----------------")
 S TXT="BEFORE:",$E(TXT,41)="AFTER"
 D ADDTXT($$DATALINE("Exp. Date: ",$G(OLDDEA(.04)),$$FMTE^XLFDT($P(NEWDEA,"^",12))))
 D ADDTXT($$DATALINE("Name: ",$G(OLDDEA(1.1)),$P(NEWDEA,"^",1)))
 D ADDTXT($$DATALINE("Company: ",$G(OLDDEA(1.2)),$P(NEWDEA,"^",2)))
 D ADDTXT($$DATALINE("Address 1: ",$G(OLDDEA(1.3)),$P(NEWDEA,"^",3)))
 D ADDTXT($$DATALINE("Address 2: ",$G(OLDDEA(1.4)),$P(NEWDEA,"^",4)))
 D ADDTXT($$DATALINE("City: ",$G(OLDDEA(1.5)),$P(NEWDEA,"^",5)))
 D ADDTXT($$DATALINE("State: ",$G(OLDDEA(1.6)),$P(NEWDEA,"^",6)))
 D ADDTXT($$DATALINE("Zip Code: ",$G(OLDDEA(1.7)),$P(NEWDEA,"^",8)))
 D ADDTXT($$DATALINE("Activity Code: ",$G(OLDDEA(.02)),$P(NEWDEA,"^",9)))
 D ADDTXT($$DATALINE("Type: ",$G(OLDDEA(.07)),$P(NEWDEA,"^",10)))
 D ADDTXT($$DATALINE("Detox #: ",$G(OLDDEA(.03)),$P(NEWDEA,"^",14)))
 I $$GET1^DIQ(59.7,1,102,"I")="MBM" D
 . D ADDTXT($$DATALINE("Schedule II-Narcotic: ",$G(OLDDEA(2.1)),$P(NEWDEA,"^",15)))
 . D ADDTXT($$DATALINE("Schedule II-Non Narcotic: ",$G(OLDDEA(2.2)),$P(NEWDEA,"^",16)))
 . D ADDTXT($$DATALINE("Schedule III-Narcotic: ",$G(OLDDEA(2.3)),$P(NEWDEA,"^",17)))
 . D ADDTXT($$DATALINE("Schedule III-Non Narcotic: ",$G(OLDDEA(2.4)),$P(NEWDEA,"^",18)))
 . D ADDTXT($$DATALINE("Schedule IV: ",$G(OLDDEA(2.5)),$P(NEWDEA,"^",19)))
 . D ADDTXT($$DATALINE("Schedule V: ",$G(OLDDEA(2.6)),$P(NEWDEA,"^",20)))
 Q
 ;
ADDTXT(TXT) ; Setting Plain Text
 S MSGLINE=$O(MSGTXT(99999),-1)+1,MSGTXT(MSGLINE)=TXT
 Q
 ; 
DATALINE(LABEL,BEFORE,AFTER) ;
 N DATALINE
 S DATALINE=$$TRUNC(LABEL_BEFORE,40),$E(DATALINE,41)=$$TRUNC(LABEL_AFTER,40)
 Q DATALINE
 ;
TRUNC(TXT,LEN) ; Truncates Text
 ;Input: TXT - Text to be Truncated
 ;       LEN - Maximum Lenght
 ;
 I $L($G(TXT))'>$G(LEN) Q $G(TXT)
 Q $E(TXT,1,LEN-3)_"..."
 ;
SENDMSG ; Sends Mailman message
 S PSOSUB="DEA Numbers Data Update from DEA/DOJ"
 S PSOFROM="DEA Update Nightly Job"
 S PSOTEXT="MSGTXT"
 D MAILMSG(PSOSUB,PSOFROM,PSOTEXT)
 Q
 ;
MAILMSG(MSGSUBJ,MSGFROM,MSGTEXT) ; Build and send a MailMan message
 N PSOREC,PSOMY,PSOMIN,PSOMZ
 S PSOMIN("FROM")=MSGFROM
 S PSOREC=""
 F  S PSOREC=$O(^XUSEC("PSDRPH",PSOREC)) Q:PSOREC=""  S PSOMY(PSOREC)=""
 S PSOMY(DUZ)=""
 D SENDMSG^XMXAPI(DUZ,MSGSUBJ,MSGTEXT,.PSOMY,.PSOMIN,.PSOMZ,"")
 Q
