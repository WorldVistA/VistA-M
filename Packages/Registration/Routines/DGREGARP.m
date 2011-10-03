DGREGARP ;ALB/DW,ERC-Address audit reports ; 8/1/08 1:21pm
 ;;5.3;Registration;**522,560,688**;Aug 13, 1993;Build 29
EN(TYPE) ;Entry point
 N DGRNG,XMY,XMSUB,XMDUZ,XMTEXT,DGSRT,DGTOTAL
 K ^TMP($J,"DG ADD CHNG")
 K ^TMP($J,"DG BEFORE")
 I ($G(TYPE)'="ALL")&($G(TYPE)'="RX") Q
 ;If mail group has no member or remote-member
 I '$$MEMBER() D  Q
 . I '$D(ZTQUEUED) W !!,"DG DAILY ADDRESS CHANGE does not have a member. Report not sent." D EOP^DGREGAED
 ;Entry from TaskMan
 I $D(ZTQUEUED) D  Q
 . D PRINT
 ;User runs the option
 I '$D(ZTQUEUED) D
 . W !!,"The report will be sent to mail group DG DAILY ADDRESS CHANGE."
 . D QUE
 . W !! D EOP^DGREGAED
 Q
MEMBER() ;Return 0 if mail group has no local or remote member
 N RESULT,DGIEN,DGRMT
 S RESULT=1
 S DGIEN=$$FIND1^DIC(3.8,"","X","DG DAILY ADDRESS CHANGE")
 D LIST^DIC(3.812,","_DGIEN_",",.01,"P","","","","","","","DGRMT")
 I ($P($G(DGRMT("DILIST",0)),U)'>0),('$$GOTLOCAL^XMXAPIG("DG DAILY ADDRESS CHANGE")) S RESULT=0
 Q RESULT
QUE ;Que the task if user invokes option
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZUSR,POP,X,ERR,IOP
 W !
 S ZTIO=""
 S ZTSAVE("TYPE")=""
 S ZTRTN="PRINT^DGREGARP"
 S ZTDESC="DG "_$G(TYPE)_" ADDRESS CHANGE REPORT"
 D ^%ZTLOAD
 D ^%ZISC,HOME^%ZIS
 W !,$S($D(ZTSK):"REQUEST QUEUED AS TASK#"_ZTSK,1:"REQUEST CANCELLED!")
 Q
PRESORT ;Sort for the report
 N DGRNG
 D RANGE(.DGRNG)
 I DGRNG=-1 Q
 D SORT(.DGRNG,TYPE)
 Q
PRINT ;Create the email message.
 N DGLINE,DFN,SSN,IEN
 S (DGLINE,DFN,SSN,IEN)=0
 D CHKPAR
 D HEADER
 D PRESORT
 D REPORT
 D TOTAL
 D EMAIL(TYPE)
 Q
 ;
REPORT ;Create the address change report body
 N DGNAME,DGSSN,DGDFN
 N DGR,DGUSER,DGDATE,DGSRC,DG12
 N DGA,DGFOR,DGN,DGO
 N DGPRSCRP
 S (DGNAME,DGSSN,DGDFN)=""
 F  S DGNAME=$O(^TMP($J,"DG BEFORE",DGNAME)) Q:DGNAME=""  D
 . S DGSSN=""
 . F  S DGSSN=$O(^TMP($J,"DG BEFORE",DGNAME,DGSSN)) Q:DGSSN=""  D
 .. S DGDFN=""
 .. F  S DGDFN=$O(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN)) Q:DGDFN=""  D
 ... D GEN(DGNAME,DGSSN,DGDFN)
 ... D OLD(DGNAME,DGSSN,DGDFN)
 ... D NEW(DGNAME,DGSSN,DGDFN)
 ... D PRSCPT(DGDFN)
 Q
GEN(DGNAME,DGSSN,DGDFN) ;General information for each patient
 K DGR
 D GETS^DIQ(2,DGDFN_",",".122;.118;.119;.12","E","DGR")
 S DGUSER=$G(DGR(2,DGDFN_",",.122,"E"))
 S DGDATE=$G(DGR(2,DGDFN_",",.118,"E"))
 S DGSRC=$G(DGR(2,DGDFN_",",.119,"E"))
 S DG12=$G(DGR(2,DGDFN_",",.12,"E"))
 D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)=""
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="   PATIENT: "_DGNAME_"   SSN: "_$E(DGSSN,6,10)
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="      USER: "_DGUSER_"   DATE: "_DGDATE
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="    SOURCE: "_DGSRC_"   "_DG12
 Q
OLD(DGNAME,DGSSN,DGDFN) ;Get address as of 24 hours ago, assuming audits are on for all
 S DGO("ADD1")=$G(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,.111))
 S DGO("ADD2")=$G(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,.112))
 S DGO("ADD3")=$G(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,.113))
 S DGO("CITY")=$G(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,.114))
 S DGO("ST")=$G(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,.115))
 S DGO("ZIP")=$G(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,.1112))
 S DGO("CNTY")=$G(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,.117))
 S DGO("PROV")=$G(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,.1171))
 S DGO("PCODE")=$G(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,.1172))
 S DGO("CNTRY")=$G(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,.1173))
 S DGFOR=$$FOR^DGADDUTL(DGO("CNTRY"))
 I $G(DGO("CNTRY"))]"" D CNTRY^DGADDUT2(.DGO)
 S DGO("TAG")="BEFORE"
 D DISP(.DGO)
 S DGFOR=0
 Q
DISP(DGA) ;
 D LNPLUS
 S ^TMP($J,"DG ADD CHNG",DGLINE)="     "_DGA("TAG")_": "_DGA("ADD1")
 I $G(DGA("ADD2"))'="" D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="            "_DGA("ADD2")
 I $G(DGA("ADD3"))'="" D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="            "_DGA("ADD3")
 I 'DGFOR D
 . I (DGA("CITY")'="")!(DGA("ST")'="") D
 . . D LNPLUS
 . . S ^TMP($J,"DG ADD CHNG",DGLINE)="            "_DGA("CITY")_","_DGA("ST")_" "_DGA("ZIP")
 I (DGA("CNTY")'="") D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="            "_"COUNTY CODE: "_DGA("CNTY")
 I DGFOR D
 . I (DGA("CITY")'="")!(DGA("PROV")'="") D
 .. D LNPLUS
 .. S ^TMP($J,"DG ADD CHNG",DGLINE)="            "_$S(DGA("PCODE")]"":DGA("PCODE")_" ",1:"")_DGA("CITY")_","_DGA("PROV")
 I DGA("CNTRY")]"" D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="            "_DGA("CNTRY")
 I $G(DGA("HPHN"))'="" D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="  "_"PHONE(H): "_DGA("HPHN")
 I $G(DGA("OPHN"))'="" D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="  "_"PHONE(O): "_DGA("OPHN")
 Q
NEW(DGNAME,DGSSN,DGDFN) ;Get current address
 K DGCURR
 D GETS^DIQ(2,DGDFN_",",".111;.112;.113;.114;.115;.116;.117:1173;.119;.12;.1112;.131;.132","E","DGCURR")
 S DGN("ADD1")=$G(DGCURR(2,DGDFN_",",.111,"E"))
 S DGN("ADD2")=$G(DGCURR(2,DGDFN_",",.112,"E"))
 S DGN("ADD3")=$G(DGCURR(2,DGDFN_",",.113,"E"))
 S DGN("CITY")=$G(DGCURR(2,DGDFN_",",.114,"E"))
 S DGN("ST")=$G(DGCURR(2,DGDFN_",",.115,"E"))
 S DGN("ZIP")=$G(DGCURR(2,DGDFN_",",.1112,"E"))
 S DGN("CNTY")=$G(DGCURR(2,DGDFN_",",.117,"E"))
 S DGN("OPHN")=$G(DGCURR(2,DGDFN_",",.132,"E"))
 S DGN("HPHN")=$G(DGCURR(2,DGDFN_",",.131,"E"))
 S DGN("PROV")=$G(DGCURR(2,DGDFN_",",.1171,"E"))
 S DGN("PCODE")=$G(DGCURR(2,DGDFN_",",.1172,"E"))
 S DGN("CNTRY")=$G(DGCURR(2,DGDFN_",",.1173,"E"))
 S DGFOR=$$FOR^DGADDUTL(DGN("CNTRY"))
 I $G(DGN("CNTRY"))]"" D CNTRY^DGADDUT2(.DGN)
 S DGN("TAG")="AFTER"
 D DISP(.DGN)
 Q
PRSCPT(DGDFN) ;Display if the patient has active prescription
 S DGPRSCRP=$$EN^PSSRXACT(DGDFN)
 I $G(DGPRSCRP)=1 D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="Patient has active pharmacy prescription(s)"
 Q
EXIT S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J,"DG ADD CHNG")
 K ^TMP($J,"DG BEFORE")
 Q
CHKPAR ;Check if audit is on for the fields
 N DGR,DGN,DGFLD
 F DGN=.111,.112,.113,.114,.115,.116,.117,.1171,.1172,.1173,.1112 D
 . K DGR
 . D FIELD^DID(2,DGN,"","LABEL;AUDIT","DGR")
 . I $D(DGR("DIERR")) Q
 . I ($G(DGR("AUDIT"))'["YES")&($G(DGR("AUDIT"))'["EDITED OR DELETED") D
 .. D LNPLUS^DGREGARP
 .. S ^TMP($J,"DG ADD CHNG",DGLINE)="Audit is off for the "_$G(DGR("LABEL"))_" field"
 Q
RANGE(RESULT) ;Get the range of the reports
 K RESULT
 N DGBEGIN,DGEND,DGNOW,DGAGO
 N X,X1,X2
 D NOW^%DTC
 S DGNOW=%
 S X1=%,X2="-1" D C^%DTC
 S DGAGO=X
 S DGNOW=$O(^DIA(2,"C",DGNOW),-1)
 S DGAGO=$O(^DIA(2,"C",DGAGO))
 I ($G(DGNOW)="")!($G(DGAGO)="") S RESULT=-1 Q
 S (DGBEGIN,DGEND)=""
 S DGBEGIN=$O(^DIA(2,"C",DGNOW,DGBEGIN),-1)
 S DGEND=$O(^DIA(2,"C",DGAGO,DGEND))
 I $G(DGBEGIN)=""!$G(DGEND)="" S RESULT=-1 Q
 S DGBEGIN=DGBEGIN+1
 S RESULT=DGBEGIN_U_DGEND
 Q
SORT(RANGE,TYPE) ;Build the temp global to display
 N DGBEGIN,DGEND,DGIEN,DGDFN,DGFLD
 S DGIEN=$P($G(RANGE),U)
 S DGEND=$P($G(RANGE),U,2)
 F  S DGIEN=$O(^DIA(2,DGIEN),-1) Q:DGIEN<DGEND  D:$$SCRN(TYPE,DGIEN)
 . D BUILD(TYPE,DGIEN)
 Q
SCRN(TYPE,DGIEN) ;Screen Audit file to find address changes.
 N DGFLD
 S DGFLD=$P($G(^DIA(2,DGIEN,0)),U,3)
 I (DGFLD=.114)!(DGFLD=.116)!(DGFLD=.117)!(DGFLD=.1112)!(DGFLD=.115) Q 1
 I (DGFLD=.111)!(DGFLD=.112)!(DGFLD=.113)!(DGFLD=.1171)!(DGFLD=.1172)!(DGFLD=.1173) Q 1
 Q 0
BUILD(TYPE,DGIEN) ;Build temp global
 N DGDFN,DGFLD,DGNAME,DGSSN,DGCURR,DGN
 S DGDFN=$P($G(^DIA(2,DGIEN,0)),U)
 I $G(TYPE)="RX" Q:'$$EN^PSSRXACT(DGDFN)
 D GETS^DIQ(2,DGDFN_",",".01;.09","E","DGCURR")
 S DGNAME=$G(DGCURR(2,DGDFN_",",.01,"E"))
 S DGSSN=$G(DGCURR(2,DGDFN_",",.09,"E"))
 I ($G(DGNAME)="")!($G(DGSSN)="")!($G(DGDFN)="") Q
 S DGFLD=$P($G(^DIA(2,DGIEN,0)),U,3)
 I '$D(^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN)) D
 . ;Get current address
 . K DGCURR,DGN
 . D GETS^DIQ(2,DGDFN_",",".111;.112;.113;.114;.115;.116;.117:.1173;.1112","E","DGCURR")
 . F DGN=.111,.112,.113,.114,.115,.116,.117,.1171,.1172,.1173,.1112 D
 .. S ^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,DGN)=$G(DGCURR(2,DGDFN_",",DGN,"E"))
 . S DGTOTAL=$G(DGTOTAL)+1
 S ^TMP($J,"DG BEFORE",DGNAME,DGSSN,DGDFN,DGFLD)=$P($G(^DIA(2,DGIEN,2)),U)
 Q
LNPLUS ;Increase line number for the email text
 S DGLINE=$G(DGLINE)+1
 Q
HEADER ;Report header
 N RDT,Y
 I $G(TYPE)="ALL" D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)=""
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="                       ALL ADDRESS CHANGE REPORT"
 I $G(TYPE)="RX" D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)=""
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="   ALL ADDRESS CHANGE FOR PATIENTS WITH ACTIVE PRESCRIPTIONS REPORT"
 D NOW^%DTC S Y=% X ^DD("DD")
 S RDT=$P(Y,"@",1)_"@"_$P($P(Y,"@",2),":",1,2)
 D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="            The BEFORE address shown may not be accurate."
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="     It is only valid as of 24 hours prior to running the report."
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="          Changes within the last 24 hours will not be shown."
 . D LNPLUS^DGREGARP
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="               Date/Time Report Run: "_RDT
 . D LNPLUS^DGREGARP
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="-----------------------------------------------------------------------------"
 Q
TOTAL ;Get the total of the patients
 N DGCNT
 ;S DGCNT=$G(^TMP($J,"DG BEFORE","TOTAL"))
 S DGCNT=$G(DGTOTAL)
 I $G(DGCNT)>0 D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)=""
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="TOTAL RECORD(S): "_DGCNT
 Q
EMAIL(TYPE) ;Email the report to mailgroup.
 ;If called within a task, protect variables
 I $D(ZTQUEUED) N %,DIFROM
 N RDT
 D NOW^%DTC S Y=% X ^DD("DD")
 S RDT=$P(Y,"@",1)_"@"_$P($P(Y,"@",2),":",1,2)
 S XMSUB="DG "_$G(TYPE)_" ADDRESS CHANGE ("_RDT_")"
 S XMY("G.DG DAILY ADDRESS CHANGE")=""
 I $G(DGTOTAL)'>0 D
 . D LNPLUS
 . S ^TMP($J,"DG ADD CHNG",DGLINE)="*** NO RECORDS TO PRINT ***"
 S XMTEXT="^TMP($J,""DG ADD CHNG"","
 D ^XMD
 Q
