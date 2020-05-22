IBY652P ;AITC/TAZ-Post Install Routine for Patch 652;10 Jun 19
 ;;2.0;INTEGRATED BILLING;**652**;21-MAR-94;Build 23
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 N IBXPD,XPDIDTOT
 S XPDIDTOT=1
 ;
 ;
 ; Task PROC  
 D PROC(1)
 ;
 ; Done...
 D MES^XPDUTL("")
 D MES^XPDUTL("POST-Install Completed.")
 Q
 ;
PROC(IBXPD) ;Process the MBI File
 ;Read File into the ^TMP($J) global
 N CNT,CCNT,FILENAME,INSTCMP,IOC,GREF,PROD,RCNT,SCNT,SITE,SITESYS,SUB,TCNT
 ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Processing MBI Crosswalk ... ")
 ;
 K ^TMP($J)
 ;
 S SITESYS=$$SITE^VASITE
 ;
 I (DT>3200131) G PROCQ                ;Past the compliance date, no longer processing files.
 ;
 I $P(SITESYS,U,3)=358 G PROCQ           ;If site is Manila, DO NOT process
 ;
 S PROD=$$PROD^XUPROD(1)
 S INSTCMP=$$GET1^DIQ(9.7,$O(^XPD(9.7,"B","IB*2.0*652",""),-1)_",",.02,"I")=3
 F SITE=405,515,518,585,662 S IOC(SITE)=""
 ;
 I 'PROD,'$D(IOC($P(SITESYS,U,3))) G PROCQ      ;Test account and not an IOC site
 ; Only IOC TEST sites and all PROD sites get here
 I INSTCMP,'$D(IOC($P(SITESYS,U,3))) G PROCQ    ;Already installed once and not an IOC site
 ;
 S GREF=$NA(^TMP($J,"IN",1,0))
 S SUB=3
 ;Note:  PATH is set up in IBY652E and killed in PROCQ
 S FILENAME="va"_$P(SITESYS,U,3)_".txt"
 I '$$FTG^%ZISH(PATH,FILENAME,GREF,SUB) G PROCQ
 ;
 ;Process MBI Data
 S CNT=1,(CCNT,RCNT,SCNT,TCNT)=0
 S RCNT=RCNT+1,^TMP($J,"OUT",RCNT,0)="Site:"_$P(SITESYS,U,3)_U_$P(SITESYS,U,2,3)_"^Results of IB*2.0*652 installed on "_$$FMTE^XLFDT(DT)
 F  S CNT=$O(^TMP($J,"IN",CNT)) Q:'CNT  S DATA=^(CNT,0) D
 . I '$L(DATA) Q  ; blank line at end of file.
 . S TCNT=TCNT+1 I '(TCNT#100) U 0 W "."
 . N DFN,DOB,ERROR,ICN,ICNT,IEN,INSIEN,MBI,MCNT,SKIP,SSN
 . S ICN=$P(DATA,U,1),SSN=$$NOPUNCT^IBCEF($P(DATA,U,2),1),DOB=$$HL7TFM^XLFDT($P(DATA,U,3)),MBI=$P(DATA,U,6)
 . S (IEN,MCNT,SKIP)=0
 . I MBI']"" D ERROR(DATA,"Patient Not Found") Q
 . ;Match on ICN
 . I '$D(^DPT("AICN",ICN)) D ERROR(DATA,"Patient Not Found") Q
 . S DFN="" F ICNT=0:1 S DFN=$O(^DPT("AICN",ICN,DFN)) I DFN="" Q
 . I ICNT'=1 D ERROR(DATA,"Patient Not Found") Q
 . S DFN=$O(^DPT("AICN",ICN,""))
 . L +^DPT(DFN,.312,0):DILOCKTM E  D ERROR(DATA,"Record Locked") Q
 . ; Match on SSN
 . I $$NOPUNCT^IBCEF($$GET1^DIQ(2,DFN_",",.09),1)'=SSN D ERROR(DATA,"Patient Not Found",1) Q
 . ; Match on DOB
 . I $$GET1^DIQ(2,DFN_",",.03,"I")'=DOB D ERROR(DATA,"Patient Not Found",1) Q
 . ; Check for Medicare policies
 . S INSIEN=0
 . F  S INSIEN=$O(^DPT(DFN,.312,INSIEN)) Q:'INSIEN  D
 .. N FDA,IENS,INSNM,PATID,SUBID
 .. S IENS=INSIEN_","_DFN_","
 .. S INSNM=$TR($$GET1^DIQ(2.312,IENS,.01)," ")
 .. I ",MEDICARE(WNR),MEDICAREPARTD(WNR),"'[(","_INSNM_",") Q
 .. S MCNT=MCNT+1
 .. S SUBID=$$GET1^DIQ(2.312,IENS,7.02)
 .. S PATID=$$GET1^DIQ(2.312,IENS,5.01)
 .. I SUBID=MBI S SKIP=1 Q  ;No need to update
 .. S SKIP=0
 .. ;Set Subscriber ID and Patient ID to MBI,Rollback fields to SUBID AND PATID
 .. S FDA(2.312,IENS,5.01)=MBI
 .. S FDA(2.312,IENS,7.02)=MBI
 .. S FDA(2.312,IENS,7.03)=SUBID
 .. S FDA(2.312,IENS,7.04)=PATID
 .. S FDA(2.312,IENS,1.05)=DT
 .. S FDA(2.312,IENS,1.06)=.5
 .. D FILE^DIE(,"FDA","ERROR") I $D(ERROR) D ERROR(DATA,$G(ERROR)) Q
 . I SKIP S SCNT=SCNT+1
 . I 'MCNT D ERROR(DATA,"No Medicare Found")
 . I 'SKIP,MCNT S CCNT=CCNT+1
 . L -^DPT(DFN,.312,0)
 ;
 ;Write Result file to HMS Directory
 S GREF=$NA(^TMP($J,"OUT",1,0))
 S FILENAME="va"_$P(SITESYS,U,3)_"-results.txt"
 I '$$GTF^%ZISH(GREF,SUB,PATH,FILENAME) G PROCQ
 ;
 N MSG,SUB,XMY
 S MSG(1)="On "_$$FMTE^XLFDT(DT)_" the MBI Crosswalk was run at site "_$P(SITESYS,U,3)_" - "_$P(SITESYS,U,2)
 S MSG(2)=""
 S MSG(3)="Total Records: "_TCNT
 S MSG(4)=""
 S MSG(5)="Successful Patient Update Records: "_CCNT
 S MSG(6)=""
 S MSG(7)="Patient Error Records: "_(RCNT-1)  ;subtract 1 to account for the header record.
 S MSG(8)=""
 S MSG(9)="Patient Skipped (MBI correct on file) Records: "_SCNT
 S MSG(10)=""
 S MSG(11)="File "_FILENAME_" was created in the "_PATH_" directory by user "_$$GET1^DIQ(200,DUZ_",",.01)_"."
 ;
 S SUB="MBI CROSSWALK ("_$P(SITESYS,U,3)_" - "_$P(SITESYS,U,2)_")"
 ;
 S XMY("VHAeInsuranceRapidResponse@domain.ext")=""
 ;
 D MSG^IBCNEUT5(,SUB,"MSG(",1,.XMY)
 ;
PROCQ ;End of routine.
 K PATH,XPDQUIT
 Q
 ;
ERROR(DATA,ERROR,UNLOCK) ;Set the Error in the results file
 S RCNT=RCNT+1
 S ^TMP($J,"OUT",RCNT,0)=DATA_U_ERROR
 I $G(UNLOCK) L -^DPT(DFN,.312,0)
 Q
