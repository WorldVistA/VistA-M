SD53P541 ;ALB/RLC - POST-INIT TO CORRECT PURPOSE OF VISIT FIELD; 7/27/07
 ;;5.3;SCHEDULING;**541**;21-MAR-94;Build 4
 ;
 ; LOOP THROUGH PATIENT FILE (2), APPOINTMENT MULTIPLE
 ; PURPOSE OF VISIT FIELD, FOR ALL APPOINTMENTS THAT
 ; CONTAIN AN INVALID VALUE IN THAT FIELD AND CHANGE
 ; THE VALUE IN EACH OCCURRANCE TO A VALUE OF 3.
 ;
 ; ONLY VALID VALUES ARE:
 ;
 ; 2.98,9        PURPOSE OF VISIT       0;7 SET (Required)
 ;
 ;                       '1' FOR C&P;
 ;                       '2' FOR 10-10;
 ;                       '3' FOR SCHEDULED VISIT;
 ;                       '4' FOR UNSCHED. VISIT;
 ;
 ;
 Q  ; must call at entry point
 ;
EN ;
 S (DFN,TOTAL)=0,SDPURP=""
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . S SDIEN=0
 . F  S SDIEN=$O(^DPT(DFN,"S",SDIEN)) Q:'SDIEN  D
 ..Q:'$D(^DPT(DFN,"S",SDIEN,0))
 ..S SDPURP=$P($G(^DPT(DFN,"S",SDIEN,0)),"^",7) D
 ...Q:SDPURP>0&(SDPURP<5)
 ...S $P(^DPT(DFN,"S",SDIEN,0),"^",7)=3
 ...S TOTAL=TOTAL+1
 D MSG
 K DFN,SDIEN,SDPURP,TOTAL,XMDUZ,XMSUB,XMY,XMTEXT,DVPARAM,CT,MSGTXT
 Q
 ;
MSG ;Send message containing total number of records updated
 S (DVPARAM,XMDUZ,XMSUB,XMTEXT,XMY)="",CT=0 K MSGTXT
 I 'TOTAL D NONE,MSG1 Q
 S CT=CT+1,MSGTXT(CT)="TOTAL NUMBER OF RECORDS UPDATED: "_TOTAL
MSG1 S XMTEXT="MSGTXT"
 S DVPARAM("FROM")="PATCH SD*5.3*541"
 S XMDUZ=DUZ,XMSUB="UPDATE PURPOSE OF VISIT FROM INVALID VALUE TO 3"
 S XMY(DUZ)=""
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.DVPARAM,"","")
 Q
 ;
NONE ;No records found with invalid value in Purpose of Visit field
 S CT=CT+1,MSGTXT(CT)="No appointment records were found that contain an invalid"
 S CT=CT+1,MSGTXT(CT)="value in the Purpose of Visit field in the Patient file."
 Q
 ;
