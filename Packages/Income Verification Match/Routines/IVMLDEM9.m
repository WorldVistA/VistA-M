IVMLDEM9 ;ALB/BRM/PHH - IVM ADDRESS UPDATES PENDING REVIEW RPT ; 09/23/08 13:35pm
 ;;2.0;INCOME VERIFICATION MATCH;**79,93,119,126,133**; 21-OCT-94;Build 2
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
EN2 ;entry point for IVM ADDR UPDT PENDING REVIEW menu option
 K ^TMP("IVMLDEM9",$J)
 K ^TMP($J,"IVMLDEM9")
 ;If mail group has no member or remote-member
 I '$$MEMBER() D  Q
 . I '$D(ZTQUEUED) W !!,"IVM ADDR UPDT REPORT does not have a member. Report not sent." K DIR S DIR(0)="E" D ^DIR K DIR
 I +$G(ZTSK) D PRINT,EXIT Q  ;started by Taskman job
 ;User runs the option
 I '$D(ZTQUEUED) D
 . W !!,"The report will be sent to mail group IVM ADDR UPDT REPORT"
 . D QUE
 . D EXIT
 . K DIR S DIR(0)="E" D ^DIR K DIR
 Q
 ;
LOOP(DTPARAM,FILDAT) ;main loop
 N DFN,IVMDT,IVMDA,IVMDA1,IVMDA2,RF171,TODAY,AUTODT,DTDIFF,NAME,UPLDT
 N X1,X2,Y,SSN,DFN
 D DT^DILF("X","T"_$G(DTPARAM),.AUTODT)
 S TODAY=$$DT^XLFDT S:'$G(FILDAT) FILDAT=0
 Q:'$G(AUTODT)  ;this should never occur, but just in case
 S RF171=$O(^IVM(301.92,"C","RF171","")),IVMDA2=""
 Q:'RF171
 F  S IVMDA2=$O(^IVM(301.5,IVMDA2)) Q:IVMDA2=""  D
 .S DFN=$P($G(^IVM(301.5,IVMDA2,0)),"^"),IVMDA1=""
 .Q:('DFN)!('$D(^DPT(+DFN)))!('$D(^IVM(301.5,IVMDA2,"IN")))
 .F  S IVMDA1=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1)) Q:IVMDA1=""  D
 ..Q:'$D(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",RF171))
 ..S IVMDA=""
 ..F  S IVMDA=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",RF171,IVMDA)) Q:'IVMDA  D
 ...S IVMDT=$P($G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMDA,0)),"^",3)
 ...Q:('IVMDT)!(IVMDT>AUTODT)
 ...; report addresses that will be auto-uploaded in DTDIFF days
 ...S X1=TODAY,X2=IVMDT D ^%DTC S DTDIFF=+$G(X)
 ...S NAME=$P($G(^DPT(DFN,0)),"^"),SSN=$P($G(^DPT(DFN,0)),"^",9)
 ...S X1=IVMDT,X2=14 D C^%DTC S UPLDT=$G(X)
 ...I '$D(^IVM(301.5,"ASEG","PID",IVMDA2)) Q
 ...S ^TMP("IVMLDEM9",$J,DTDIFF,SSN,IVMDA)=$G(NAME)_"^"_$P(IVMDT,".")_"^"_$P(UPLDT,".")_"^"_DFN_"^"_IVMDA2_"^"_IVMDA1
 Q
 ;
AUTOLOAD(DFN,IVMDA2,IVMDA1) ;auto-upload records that not been reviewed
 ; this tag is called from ^IVMLDEMC
 ;
 Q:('$G(DFN))!('$G(IVMDA2))!('$G(IVMDA1))
 N IVMI,IVMJ,IVMFIELD,IVMVALUE,IVMNODE,IVMFLAG,DUZ
 S DUZ=.5
 ;
 ; determine appropriate address change dt/tm to be used
 D ADDRDT^IVMLDEM6(DFN,IVMDA2,IVMDA1)
 ;
 N DGPRIOR D GETPRIOR^DGADDUTL(DFN,.DGPRIOR)
 ;
 ; loop through the record to be uploaded
 S IVMI=0 F  S IVMI=$O(^IVM(301.92,"AD",IVMI)) Q:IVMI']""  D
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,IVMJ)) Q:IVMJ']""  D
 ..;
 ..; check for data node in (#301.511) sub-file
 ..S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0))
 ..Q:('+IVMNODE)!($P(IVMNODE,"^",2)']"")
 ..;
 ..; check for residence phone number -> do not auto-upload
 ..Q:(+IVMNODE=$O(^IVM(301.92,"B","PHONE NUMBER [RESIDENCE]",0)))
 ..;
 ..; do not auto-upload if there is an active prescription
 ..I $$PHARM^IVMLDEM6(+DFN) D REJTADD Q
 ..;
 ..; set upload parameters
 ..S IVMFIELD=$P($G(^IVM(301.92,+IVMNODE,0)),"^",5)
 ..S IVMVALUE=$P(IVMNODE,"^",2)
 ..;
 ..; load addr field into the Patient (#2) file
 ..D UPLOAD^IVMLDEM6(DFN,IVMFIELD,IVMVALUE) S IVMFLAG=1
 ..;
 ..; remove entry from (#301.511) sub-file
 ..D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
 ..;
 ..; if no display or uploadable fields, delete PID segment
 ..I ('$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,0))&('$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,1)) D DELETE^IVMLDEM5(IVMDA2,IVMDA1," ")
 ;
 I +$G(IVMFLAG) D
 .N DGCURR
 .D GETUPDTS^DGADDUTL(DFN,.DGCURR)
 .D UPDADDLG^DGADDUTL(DFN,.DGPRIOR,.DGCURR)
 Q
REJTADD ;Reject the address
 ; update the ADDRESS CHANGE DT/TM field #.118 in PATIENT file #2
 D UPDDTTM^DGADDUTL(DFN,"PERM")
 ;
 ; trigger the record to transmit the existing address on file to HEC
 N DGENUPLD   ; Used in SETSTAT^IVMPLOG to prevent filing.
 N DA,X,IVMX
 S (DA,X)=DFN
 S IVMX=X,X="IVMPXFR" X ^%ZOSF("TEST") D:$T DPT^IVMPXFR S X=IVMX
 Q
PRINT ;report output
 N DAYS,SSN,DATA,EX,PAGE,IVMDA,DATA,IVMLN,XMY,XMSUB,XMDUZ,XMTEXT
 D LOOP("",0)
 D HDR
 D DISPLAY
 D EMAIL
 Q
DISPLAY ;Display the report
 S DAYS=""
 I '$D(^TMP("IVMLDEM9",$J)) Q
 F  S DAYS=$O(^TMP("IVMLDEM9",$J,DAYS),-1) Q:DAYS=""!($G(EX))  D
 .S SSN=""
 .F  S SSN=$O(^TMP("IVMLDEM9",$J,DAYS,SSN)) Q:SSN=""!($G(EX))  D
 ..S IVMDA=""
 ..F  S IVMDA=$O(^TMP("IVMLDEM9",$J,DAYS,SSN,IVMDA)) Q:(IVMDA="")!($G(EX))  D
 ...S DATA=$G(^TMP("IVMLDEM9",$J,DAYS,SSN,IVMDA))
 ... D LNPLUS
 ... S ^TMP($J,"IVMLDEM9",IVMLN)="       "_$$FMTE^XLFDT($P(DATA,"^",3))_"      "_$$FMTE^XLFDT($P(DATA,"^",2))_"      "_SSN_"     "_$P(DATA,"^")
 ... S ^TMP($J,"IVMLDEM9","TOTAL")=$G(^TMP($J,"IVMLDEM9","TOTAL"))+1
 D TOTAL
 D
 . D LNPLUS
 . S ^TMP($J,"IVMLDEM9",IVMLN)=""
 . D LNPLUS
 . S ^TMP($J,"IVMLDEM9",IVMLN)="                    <<END OF REPORT>>"
 I $E(IOST)="C" W ! K DIR S DIR(0)="E" D ^DIR K DIR
 Q
HDR ;print header
 N IVMDT,Y,DLINE
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,EX)=1 Q
 S Y=DT X ^DD("DD") S IVMDT=Y
 D
 . D LNPLUS
 . S ^TMP($J,"IVMLDEM9",IVMLN)=""
 . D LNPLUS
 . S ^TMP($J,"IVMLDEM9",IVMLN)=" IVM ADDRESS UPDATES PENDING REVIEW          "_IVMDT
 . D LNPLUS
 . S $P(^TMP($J,"IVMLDEM9",IVMLN),"=",78)=""
 . D LNPLUS
 . S ^TMP($J,"IVMLDEM9",IVMLN)=""
 . D LNPLUS
 . S ^TMP($J,"IVMLDEM9",IVMLN)="     Auto-Upload Date    Date Received        SSN        Patient Name"
 . D LNPLUS
 . S ^TMP($J,"IVMLDEM9",IVMLN)="     ----------------    -------------     ---------     ------------"
 Q
EXIT D ^%ZISC,HOME^%ZIS Q
 K ^TMP($J,"IVMLDEM9")
 K ^TMP("IVMLDEM9",$J)
 ;
ADRDTCK(DFN,IVMDA2,IVMDA1) ;is the incoming address older than #2 address?
 Q:'$G(DFN)!('$G(IVMDA2))!('$G(IVMDA1)) "0^MISSING INPUT PARAMETER"
 N OADDRDT,NADDRDT,ERR,IVMDA,IEN92,IENS
 S OADDRDT=$$GET1^DIQ(2,DFN_",",.118,"I","","ERR") Q:$D(ERR) "0^OLD ADDR ERROR"
 S IEN92=$O(^IVM(301.92,"C","RF171","")) Q:'IEN92 "0^BAD #301.92 ENTRY FOR RF171"
 I '$D(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IEN92)) Q "0^ADDR DT NOT PRESENT"
 S IVMDA=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IEN92,"")) Q:'IVMDA "0^MISSING ADDR DT IN 301.5"
 S IENS=IVMDA_","_IVMDA1_","_IVMDA2_","
 S NADDRDT=$$GET1^DIQ(301.511,IENS,.02,"I","","ERR") Q:$D(ERR) "0^NEW ADDR ERROR"
 Q:(OADDRDT="")&(NADDRDT="") 0
 Q:(NADDRDT="")!(OADDRDT'<NADDRDT) 1
 Q "0^INCOMING ADDRESS IS NEWER THAN PATIENT FILE ADDR"
MEMBER() ;Return 0 if mail group has no local or remote member
 N RESULT,IVMIEN,IVMRMT
 S RESULT=1
 S IVMIEN=$$FIND1^DIC(3.8,"","X","IVM ADDR UPDT REPORT")
 D LIST^DIC(3.812,","_IVMIEN_",",.01,"P","","","","","","","IVMRMT")
 I ($P($G(IVMRMT("DILIST",0)),U)'>0),('$$GOTLOCAL^XMXAPIG("IVM ADDR UPDT REPORT")) S RESULT=0
 Q RESULT
EMAIL ;Set up parameters to email the report
 ;If called within a task, protect variables
 I $D(ZTQUEUED) N %,DIFROM
 N RDT
 D NOW^%DTC S Y=% X ^DD("DD")
 S RDT=$P(Y,"@",1)_"@"_$P($P(Y,"@",2),":",1,2)
 S XMSUB="IVM Address Pending Review ("_RDT_")"
 S XMY("G.IVM ADDR UPDT REPORT")=""
 I $G(^TMP($J,"IVMLDEM9","TOTAL"))<1 D
 . D LNPLUS
 . S ^TMP($J,"IVMLDEM9",IVMLN)=""
 . D LNPLUS
 . S ^TMP($J,"IVMLDEM9",IVMLN)="*** NO RECORDS TO PRINT ***"
 S XMTEXT="^TMP($J,""IVMLDEM9"","
 D ^XMD
 Q
QUE ;Que the task if user invokes option
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZUSR,POP,X,ERR,IOP
 W !
 S ZTIO=""
 S ZTRTN="PRINT^IVMLDEM9"
 S ZTDESC="IVM AUTO ADDRESS UPLOAD RPT"
 D ^%ZTLOAD
 D ^%ZISC,HOME^%ZIS
 W !,$S($D(ZTSK):"REQUEST QUEUED AS TASK#"_ZTSK,1:"REQUEST CANCELLED!")
 Q
TOTAL ;Display record total on the report
 N IVMTOTAL
 S IVMTOTAL=$G(^TMP($J,"IVMLDEM9","TOTAL"))
 D
 . D LNPLUS
 . S ^TMP($J,"IVMLDEM9",IVMLN)=""
 . D LNPLUS
 . S ^TMP($J,"IVMLDEM9",IVMLN)="TOTAL RECORD(S): "_$G(IVMTOTAL)
 Q
LNPLUS ;Increase line number for the email text
 S IVMLN=$G(IVMLN)+1
 Q
