IBY602PO ;EDE/DM - Post-Installation for IB*2.8*602 ; 23-MAR-2018
 ;;2.0;INTEGRATED BILLING;**602**;09-AUG-2018;Build 22
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
POST ; POST ROUTINE(S)
 N IBXPD,XPDIDTOT
 S XPDIDTOT=1
 ;
 ; Task FIXTQ  
 D TSKFIXTQ(1)
 ;
 ; Done...
 D MES^XPDUTL("")
 D MES^XPDUTL("POST-Install Completed.")
 Q
 ;
TSKFIXTQ(IBXPD) ; task the FIXTQ routine
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Tasking Examine/Clean IIV Response & IIV Transmission Queue ... ")
 N MSG,ZTDESC,ZTRTN,ZTQUEUED
 S ZTQUEUED=1
 S ZTDESC="IBCN EXAMINE #365 & #365.1 FILES"
 S ZTRTN="FIXTQ^IBY602PO"
 S MSG=$$TASK("T@2000",ZTDESC,ZTRTN)
 D MES^XPDUTL(MSG)
 Q
 ;
TASK(X,ZTDESC,ZTRTN) ;bypass for queued task
 N Y,IDT,XDT,TSK,MSG,ZTIO,ZTSK,%DT
 S %DT="FR"
 D ^%DT
 S IDT=Y D DD^%DT S XDT=Y
 ;
 ;Check if task already scheduled for date/time
 S TSK=$$GETTASK(IDT)
 I TSK D  Q MSG
 . S Y=$P(TSK,U,2) D DD^%DT
 . S MSG=" Task (#"_+TSK_") already scheduled to run on "_Y
 ;
 ;Schedule the task
 S TSK=$$SCHED(IDT)
 ;
 ;Check for scheduling problem
 I '$G(TSK) S MSG=" Task Could Not Be Scheduled" Q MSG
 ;
 ;Send successful schedule message
 S MSG=" Examine/Clean IIV Transmission Queue Scheduled for "_XDT
 Q MSG
 ;
GETTASK(IDT) ;
 N TASK,TASKNO,TDT,XUSUCI,Y,ZTSK0
 ;
 ;Retrieve UCI
 X ^%ZOSF("UCI") S XUSUCI=Y
 ; 
 S (TASK,TDT)=0,TASKNO=""
 F  S TASK=$O(^%ZTSK(TASK)) Q:'TASK  D  Q:TASKNO
 .I $G(^%ZTSK(TASK,.03))[ZTDESC D
 ..S ZTSK0=$G(^%ZTSK(TASK,0))
 ..;
 ..;Exclude tasks scheduled by TaskMan
 ..Q:ZTSK0["ZTSK^XQ1"
 ..;
 ..;Exclude tasks in other ucis
 ..Q:(($P(ZTSK0,U,11)_","_$P(ZTSK0,U,12))'=XUSUCI)
 ..;
 ..;Check for correct date and time
 ..S TDT=$$HTFM^XLFDT($P(ZTSK0,"^",6))
 ..;I TDT=IDT S TASKNO=TASK
 Q TASKNO_U_TDT
 ;
SCHED(ZTDTH) ;
 N XUSUCI,ZTIO,ZTSK
 ;Retrieve UCI
 X ^%ZOSF("UCI") S XUSUCI=Y
 S ZTIO=""
 D ^%ZTLOAD
 Q ZTSK
 ;
FIXTQ(IBXPD) ; clean/report abnormal IIV TRANSMISSION QUEUE (#365.1) records
 N DA,DIK,HLIEN,DNP,TQIEN,ENDDT,WKDT,WKZZ
 N STATLIST,STAGE,TCNT,ACNT,MCNT,DONE
 N BAD,TQS,TQD,TQQ,MSG,IBXMY
 ;
 S STATLIST=","_$$FIND1^DIC(365.14,,"B","Response Received")
 S STATLIST=STATLIST_","_$$FIND1^DIC(365.14,,"B","Communication Failure")
 S STATLIST=STATLIST_","_$$FIND1^DIC(365.14,,"B","Cancelled")_","
 S (TQIEN,TCNT,STAGE,ACNT,MCNT,DONE)=0
 S MSG=""
 S ENDDT=$$FMADD^XLFDT(DT,-182) ; about 6 months
 ; STAGE=0, delete abnormal < T-182
 ; STAGE=1, report abnormal from T-182 through T-32
 ;
 D FIXRESP
 ;
 F  S TQIEN=$O(^IBCN(365.1,TQIEN)) Q:'TQIEN!DONE!$G(ZTSTOP)  D
 . S TCNT=TCNT+1
 . I $D(ZTQUEUED),TCNT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . S TQD=$$GET1^DIQ(365.1,TQIEN_",",.06,"I") ; DATE/TIME CREATED
 . S WKDT=+$P(TQD,".",1)
 . I WKDT>ENDDT,STAGE S DONE=1 Q
 . I WKDT>ENDDT S STAGE=1,ENDDT=$$FMADD^XLFDT(DT,-32)
 . I WKDT>ENDDT S DONE=1 Q 
 . ; check for abnormal 
 . S BAD=0
 . S TQS=$$GET1^DIQ(365.1,TQIEN_",",.04,"I") ; TRANSMISSION STATUS
 . S TQQ=$$GET1^DIQ(365.1,TQIEN_",",.11,"I") ; QUERY FLAG 
 . ; If the QUERY FLAG IS "I" and not an EICD Transaction entry will purge/report.
 . S:TQQ="I"&'$D(^IBCN(365.18,"B",TQIEN)) BAD=1
 . ; If the QUERY FLAG is null OR the DATE/TIME CREATED is null or 
 . ; TRANSMISSION STATUS not in STATLIST entry will purge/report
 . S:(TQQ="")!('TQD)!('$F(STATLIST,","_TQS_",")) BAD=1
 . Q:'BAD
 . I STAGE=0 D
 .. ; loop through the HL7 messages multiple and kill any response
 .. ; records that are found for this transmission queue entry.
 .. ; Preserve the TQ and any response that has DO NOT PURGE set to 1 (YES) 
 .. S DNP=0,HLIEN=0,DIK="^IBCN(365,"
 .. F  S HLIEN=$O(^IBCN(365.1,TQIEN,2,HLIEN)) Q:'HLIEN  D
 ... S DA=$P($G(^IBCN(365.1,TQIEN,2,HLIEN,0)),U,3) Q:'DA
 ... I +$$GET1^DIQ(365,DA_",",.11,"I") S DNP=1 Q 
 ... D ^DIK
 ... Q
 .. ; now we can kill the TQ entry itself 
 .. ; as long as there was no DO NOT PURGE responses
 .. I 'DNP S DA=TQIEN,DIK="^IBCN(365.1," D ^DIK
 .. Q
 . Q:'STAGE  ; not reporting abnormal yet
 . S ACNT=ACNT+1 ; abnormal count 
 . Q:MCNT>9  ; msg count, only want 10
 . S MCNT=MCNT+1
 . ;example of a detail line on the email 
 . ;FEB 22, 2017@10:44:08 T#:xxxxxxxxxx *xxxxxxxxxxxxxxxxxxxxx *NO QFLAG 
 . I 'TQD S $E(MSG(MCNT+2),1)="*NO DATE"
 . I TQD S $E(MSG(MCNT+2),1)=$$GET1^DIQ(365.1,TQIEN_",",.06,"E") ;DATE/TIME CREATED
 . S $E(MSG(MCNT+2),23)="T#:"_TQIEN
 . I '$F(STATLIST,","_TQS_",") S $E(MSG(MCNT+2),40)=" *"_$$GET1^DIQ(365.1,TQIEN_",",.04,"E")
 . S WKZZ=""
 . I TQQ="" S WKZZ=" *NO QUERY FLAG"
 . I TQQ="I" S WKZZ=" *QUERY FLAG: 'I'"
 . S $E(MSG(MCNT+2),60)=WKZZ
 ; send mailman msg
 S WKDT=$$SITE^VASITE()
 S MSG(1)="Patch IB*2.0*602 Post Install Issue Summary for station "_$P(WKDT,U,3)_":"_$P(WKDT,U,2)
 S MSG(2)="-------------------------------------------------------------------------------"
 I 'ACNT S MSG(3)=" NO ISSUES FOUND"
 I ACNT D
 . S MSG(MCNT+3)=""
 . S MSG(MCNT+4)="TOTAL ISSUES DETECTED: "_ACNT
 S IBXMY("vhaeinsurancerr@domain.ext")=""
 D MSG^IBCNEUT5(,"Patch IB*2.0*602 Post Install Issue Summary ("_$P(WKDT,U,3)_")","MSG(",,.IBXMY)
 ; Tell TaskManager to delete the task's record
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
FIXRESP ;Populate Response entries with null date/time created.
 N DIE,DR,DTM,RDTM,RIEN,RPDTM
 S RIEN=0,RPDTM=$$FMADD^XLFDT(DT,-182)
 F  S RIEN=$O(^IBCN(365,RIEN)) Q:'RIEN  D
 . S TCNT=TCNT+1
 . I $D(ZTQUEUED),TCNT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . ;
 . S DTM=$$GET1^DIQ(365,RIEN_",",.08,"I") I DTM Q
 . S RDTM=$$GET1^DIQ(365,RIEN_",",.07,"I")
 . I RDTM>RPDTM D
 .. S ACNT=ACNT+1
 .. I MCNT<6 D
 ... S MCNT=MCNT+1
 ... S $E(MSG(MCNT+2),1)="*NO DATE/TIME CR"
 ... S $E(MSG(MCNT+2),23)="R#:"_$$GET1^DIQ(365,RIEN_",",.01)  ;MESSAGE CONTROL ID
 ... S $E(MSG(MCNT+2),40)=" *"_$$GET1^DIQ(365,RIEN_",",.06)  ;TRANSMISSION STATUS
 ... S $E(MSG(MCNT+2),60)=" *"_$$GET1^DIQ(365,RIEN_",",.1) ;RESPONSE TYPE
 . S DTM=$S(RDTM:RDTM,1:"NOW")
 . S DIE=365,DA=RIEN,DR=".08///"_DTM
 . D ^DIE
 Q
 ;
