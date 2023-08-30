SDECDTHCLNUP2 ;ALB/JAS - RECALL REMINDER & SDEC APPT REQUEST REPORT/CLEAN-UP FOR DECEASED PATIENTS ; Mar 20, 2023
 ;;5.3;SCHEDULING;**843**;AUG 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
RPT ;
 ;
 N HTYP S HTYP="RPT"
 D MAIN(HTYP),DEVCLOSE
 Q
 ;
CLNUP ;
 ;
 N HTYP S HTYP="CLN"
 D MAIN(HTYP),DEVCLOSE
 Q
 ; 
MAIN(HTYP) ;
 ;
 N CLNEDT,DA,DOD,DODLU,DTOUT,DUOUT,ECNT,ENTERDT,FSTDT,I,LSTDT,PCNT,PFLG,POP
 N RCNT,RDA,SCNT,SDA,SDDFN,SVSTAT,UPEDT
 S (DA,ECNT,PCNT,POP,RCNT,SCNT)=0,FSTDT=9999999.999999,LSTDT=0000000.000000
 S (CLNEDT,UPEDT)=3201231  ; The latest date to include for record Cleanup
 S ENTERDT=3211231  ; The Date of Death Entered By check date
 ;
 D HEADER(HTYP),DEVOPEN(POP)
 Q:POP
 ;
 ; Loop through AEXP1 x-ref to only search deceased patient records
 ;
 F  S DA=$O(^DPT("AEXP1",DA)) Q:'DA  I $D(^DPT("AEXP1",DA)) D
 . S SDDFN=0 F  S SDDFN=$O(^DPT("AEXP1",DA,SDDFN)) Q:'SDDFN  I $D(^DPT(SDDFN,0)) D
 . . ;
 . . S DOD=$$GET1^DIQ(2,SDDFN,.351,"I") Q:'DOD  ; double-check for a populated Date of Death
 . . Q:DOD>CLNEDT  ; check DOD against default cut-off
 . . S DODLU=$$GET1^DIQ(2,SDDFN,.354,"I") Q:'DODLU  ; check for populated Date of Death Last Updated
 . . I 'DODLU&(DOD>3141231) Q  ; if no Date of Death Last Updated, quit if DOD is later than 2015
 . . I DODLU&(DODLU>ENTERDT) Q  ; check Date of Death Last Updated against default cut-off
 . . ;
 . . ; Search RECALL REMINDERS file
 . . ;
 . . S PFLG=0
 . . I $D(^SD(403.5,"B",SDDFN)) D
 . . . S RDA=0
 . . . F  S RDA=$O(^SD(403.5,"B",SDDFN,RDA)) Q:RDA=""  I $D(^SD(403.5,RDA,0)) D
 . . . . I 'PFLG S PFLG=1,PCNT=PCNT+1 I HTYP="RPT" D PDET(SDDFN,DOD)
 . . . . I HTYP="RPT" W !,"     RECALL REMINDER Record IEN: "_RDA
 . . . . I HTYP="CLN" S SVSTAT=$$REMOVEREC(RDA,SDDFN) I 'SVSTAT S ECNT=ECNT+1 Q
 . . . . I DOD<FSTDT S FSTDT=DOD
 . . . . I DOD>LSTDT S LSTDT=DOD
 . . . . S RCNT=RCNT+1
 . . ;
 . . ; Search SDEC APPT REQUEST file
 . . ;
 . . I $D(^SDEC(409.85,"B",SDDFN)) D
 . . . N SVSTAT S SDA=0
 . . . F  S SDA=$O(^SDEC(409.85,"B",SDDFN,SDA)) Q:SDA=""  I $D(^SDEC(409.85,SDA,0)) D
 . . . . Q:$$GET1^DIQ(409.85,SDA,23)="CLOSED"  ; Make sure CURRENT STATUS of record isn't already Closed
 . . . . I 'PFLG S PFLG=1,PCNT=PCNT+1 I HTYP="RPT" D PDET(SDDFN,DOD)
 . . . . I HTYP="RPT" W !,"     SDEC APPT REQUEST Record IEN: "_SDA
 . . . . I HTYP="CLN" S SVSTAT=$$UPDATEREQ(SDA) I 'SVSTAT S ECNT=ECNT+1 Q
 . . . . I DOD<FSTDT S FSTDT=DOD
 . . . . I DOD>LSTDT S LSTDT=DOD
 . . . . S SCNT=SCNT+1
 ;
 I HTYP="RPT" D RSUMM(ENTERDT,FSTDT,LSTDT,PCNT,RCNT,SCNT,UPEDT) Q
 D CSUMM(ECNT,ENTERDT,FSTDT,LSTDT,PCNT,RCNT,SCNT,UPEDT)
 Q
 ;
REMOVEREC(RDA,RDFN) ; Delete RECALL REMINDER record and update corresponding 
 ;                    DELETE REASON field in RECALL REMINDER REMOVED file.
 N LSTIEN,RET,RRRIEN
 S LSTIEN=$O(^SD(403.56,"A"),-1)
 ;
 ; Call API that prepares and deletes RECALL REMINDER record
 ;
 D RECDSET^SDEC52A(.RET,RDA)
 I '$P(RET,"^",3) Q 0
 ;
 ; Locate the new IEN created in the RECALL REMINDER REMOVED file
 ;
 S RRRIEN=$O(^SD(403.56,"B",RDFN,""),-1)
 I 'RRRIEN!(RRRIEN'>LSTIEN) Q 0
 ;
 ; Update DELETE REASON field #203, Value=3 (DECEASED)
 ;
 N FDA,FDAERR
 S FDA(403.56,RRRIEN_",",203)=3
 D FILE^DIE(,"FDA","FDAERR")
 Q 1
 ;
UPDATEREQ(REQIEN) ; Update CURRENT STATUS field in SDEC APPT REQUEST file
 ;      CURRENT STATUS - Field #23, Value="C" (CLOSED)
 ;
 N FDA,FDAERR
 S FDA(409.85,REQIEN_",",23)="C"
 D FILE^DIE(,"FDA","FDAERR")
 I $D(FDAERR) Q 0
 Q 1
 ;
HEADER(HTYP) ; Header for report data
 ;
 W !!!,?15,$S(HTYP="RPT":"Report",1:"Clean-up")_" for Scheduling records for deceased patients.",!!
 Q
 ;
PDET(PDDFN,DOD) ; Detail line for Patient
 ;
 W !!!,"PATIENT NAME: "_$$GET1^DIQ(2,PDDFN,.01,"E")
 W !,"PATIENT IEN: ",PDDFN,?45,"DATE OF DEATH: "_$P($$FMTE^XLFDT(DOD),"@")
 W ! F I=1:1:79 W "-"
 Q
 ;
RSUMM(ENTERDT,FSTDT,LSTDT,PCNT,RCNT,SCNT,UPEDT) ; Report Summary 
 ;
 W !! F I=1:1:79 W "="
 W !!,"Date of Death on or before: "_$P($$FMTE^XLFDT(UPEDT),"@")
 W !,"Date of Death Last Updated on or before: "_$P($$FMTE^XLFDT(ENTERDT),"@")
 W !!,"Deceased patients with active records: ",PCNT
 I FSTDT<9999999.999999 D
 . W !,"Earliest Date of Death found: "_$P($$FMTE^XLFDT(FSTDT),"@")
 I LSTDT>0000000.000000 D
 . W !,"Latest Date of Death found: "_$P($$FMTE^XLFDT(LSTDT),"@")
 W !!,"Total associated RECALL REMINDER records: ",RCNT
 W !,"Total associated SDEC APPT REQUEST records: ",SCNT
 Q
 ;
CSUMM(ECNT,ENTERDT,FSTDT,LSTDT,PCNT,RCNT,SCNT,UPEDT) ; Clean-up Summary
 ;
 W !! F I=1:1:79 W "="
 W !!,"Date of Death on or before: "_$P($$FMTE^XLFDT(UPEDT),"@")
 W !,"Date of Death Last Updated on or before: "_$P($$FMTE^XLFDT(ENTERDT),"@")
 W !!,"Deceased patients with records cleaned up: ",PCNT
 I FSTDT<9999999.999999 D
 . W !,"Earliest Date of Death found: "_$P($$FMTE^XLFDT(FSTDT),"@")
 I LSTDT>0000000.000000 D
 . W !,"Latest Date of Death found: "_$P($$FMTE^XLFDT(LSTDT),"@")
 W !!,"Total associated RECALL REMINDER records that were removed: ",RCNT
 W !,"Total associated SDEC APPT REQUEST records that were closed: ",SCNT
 W !,"Total unsuccessful updates: ",ECNT
 Q
 ;  
DEVOPEN(POP) ;Prompt for device
 D ^%ZIS Q:POP
 U IO
 Q
 ;
DEVCLOSE ;Close device
 ;
 D ^%ZISC
 Q
