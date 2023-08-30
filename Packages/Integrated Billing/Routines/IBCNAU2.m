IBCNAU2 ;ALB/KML/AWC - USER EDIT REPORT (COMPILE) ;6-APRIL-2015
 ;;2.0;INTEGRATED BILLING;**528,664,668,737**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Queued Entry Point for Report.
 ;  Required variable input:  ALLUSERS, ALLINS, PLANS, ALLPLANS, EXCEL
 ;  ^TMP("IBINC",$J) 
 ;  ^TMP("IBUSER",$J) 
 ;  DATE("START") and DATE("END") required array elements if all dates not selected
 ;
 ;IB*737/CKB - references to 'eIV Payer' should be changed to 'Payer' in order
 ; to include 'IIU Payers'
 Q
 ;
 ;EN(ALLINS,ALLPLANS,PLANS,DATE) ;
 ;/vd-IB*2*664 - Changed the above line to the line below.
EN(ALLINS,ALLPLANS,PLANS,ALLPYRS,REPTYP,DATE) ;
 N LN
 S LN=0
 ; - compile report data
 K ^TMP("IBPR",$J),^TMP("IBPR2",$J)
 K ^TMP("IBPRINS",$J) ; IB*737/DTG to track which DIA(36,"B",INSIENS have been picked up
 ;
 ; - user wanted all companies, PLANS, and users
 ;I PLANS D PLANS(ALLUSERS,.LN,.DATE)
 ;E  D NOPLANS(ALLUSERS,.LN,.DATE)
 ;/vd-IB*2*664 - Replaced the above 3 lines with the following:
 ;Beginning of IB*2*664 code
 ; - dependent upon Report selection prepare the respective insurance companies,
 ;   plans, eIV payers, and users
 I REPTYP'=2 D      ; report for ins cos/plans or both was selected
 .I PLANS D PLANS(ALLUSERS,.LN,.DATE)
 .E  D NOPLANS(ALLUSERS,.LN,.DATE)
 I REPTYP'=1 D PAYERS(ALLPLANS,ALLUSERS,.LN,.DATE)   ; report for eIV payers or both was selected
 ;End of IB*2*664 code
 ;
PRINT ; - print report
 ;D EN^IBCNAU3(ALLPLANS,PLANS)
 ;/vd-IB*2*664 - Replaced the line above with the line below
 D EN^IBCNAU3(ALLPLANS,PLANS,ALLPYRS,REPTYP)
 ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
 ;
PLANS(ALLUSERS,LN,DATE) ;
 ; report will include edits to files 36 and 355.3
 N INSNAME,INSIEN,PLIEN,Z
 S INSNAME="" F  S INSNAME=$O(^TMP("IBINC",$J,INSNAME)) Q:INSNAME=""  D
 . S INSIEN=0 F  S INSIEN=$O(^TMP("IBINC",$J,INSNAME,INSIEN)) Q:'INSIEN  D
 . . S PLIEN=0 F  S PLIEN=$O(^TMP("IBINC",$J,INSNAME,INSIEN,PLIEN)) Q:'PLIEN  D
 . . . I ALLUSERS D ALLUSERS(INSNAME,INSIEN,PLIEN,PLANS,.LN,.DATE,.Z) Q
 . . . I 'ALLUSERS D SELUSERS(INSNAME,INSIEN,PLIEN,.LN,.DATE,.Z)
 Q
 ;
NOPLANS(ALLUSERS,LN,DATE) ;  only report edits made to INSURANCE COMPANY file (36)
 N INSNAME,INSIEN,PLIEN
 S PLIEN=0
 ;
 S INSNAME="" F  S INSNAME=$O(^TMP("IBINC",$J,INSNAME)) Q:INSNAME=""  D
 . S INSIEN=0 F  S INSIEN=$O(^TMP("IBINC",$J,INSNAME,INSIEN)) Q:'INSIEN  D
 . . I ALLUSERS D ALLUSERS(INSNAME,INSIEN,0,0,.LN,.DATE,.Z)
 . . I 'ALLUSERS D SELUSERS(INSNAME,INSIEN,PLIEN,.LN,.DATE,.Z)
 Q
 ;
ALLUSERS(INSNAME,INSIEN,PLIEN,PLANS,LN,DATE,Z) ; procedure to gather edits for All Users within a date range
 ; INSNAME = name of insurance company (36, .01)
 ; INSIEN = ien of INSURANCE COMPANY (36) entry
 ; PLIEN = ien of GROUP iNSURANCE PLAN (355.3) entry
 ;         OR equal to 0 if group plans or not to be reported
 ; DATE = date range for edits (DATE("START") and DATE("END"))
 ; Z = input and output array
 K Z
 N DIAIEN,SUB,DIA0,FIELD ;LN
 S SUB=$S(PLIEN:1,1:0)
 S DIAIEN=0
 S Z("PLAN")=$S(PLIEN:$P($G(^IBA(355.3,PLIEN,2)),U),1:"NO PLANS SELECTED")
 S Z("INSNAME")=INSNAME
 ; INSURANCE COMPANY AUDITS
 F  S DIAIEN=$O(^DIA(36,"B",INSIEN,DIAIEN)) Q:'DIAIEN  D
 . S DIA0=^DIA(36,DIAIEN,0),DATE=$P($P(DIA0,U,2),".")
 . Q:DATE<DATE("START")  Q:DATE>DATE("END")   ; audit record outside date range
 . S FIELD=$S($P(DIA0,U,3)=".01":"INSURANCE COMPANY",1:$P(^DD(36,$P(DIA0,U,3),0),U))
 . S Z("DATE")=$E($P(DIA0,U,2),1,12),Z("FIELD")=FIELD,Z("USER")=$P(DIA0,U,4)
 . S Z("OLDVAL")=$G(^DIA(36,DIAIEN,2)),Z("NEWVAL")=$G(^DIA(36,DIAIEN,3))
 . S Z("PLAN")=$S(PLIEN:$P($G(^IBA(355.3,PLIEN,2)),U),1:"NO PLANS SELECTED")
 . S Z("INSNAME")=INSNAME
 . S Z("ISINS")=36  ;IB*737/DTG flag for file 36
 . I $G(^TMP("IBPRINS",$J,INSIEN,DIAIEN))=1 Q  ; IB*737/DTG do not re-print if already printed
 . D ADDLN(SUB,.LN,.Z)
 . S ^TMP("IBPRINS",$J,INSIEN,DIAIEN)=1  ; IB*737/DTG track for not re-print if already printed
 ;
 ; if GROUP PLAN edits are to be reported then proceed with gathering edits from file 355.3, 355.32, 355.4
 ; GROUP INSURANCE PLAN AUDITS
 I PLANS D
 . S DIAIEN=0,Z("ISINS")=""  ;IB*737/DTG make sure DIAIEN is zero, clear item for file 36 chk
 . F  S DIAIEN=$O(^DIA(355.3,"B",PLIEN,DIAIEN)) Q:'DIAIEN  D
 . . S DIA0=^DIA(355.3,DIAIEN,0),DATE=$P($P(DIA0,U,2),".")
 . . Q:DATE<DATE("START")  Q:DATE>DATE("END")   ; audit record outside date range
 . . S FIELD=$P(^DD(355.3,$P(DIA0,U,3),0),U)
 . . S Z("DATE")=$E($P(DIA0,U,2),1,12),Z("FIELD")=FIELD,Z("USER")=$P(DIA0,U,4)
 . . S Z("OLDVAL")=$G(^DIA(355.3,DIAIEN,2)),Z("NEWVAL")=$G(^DIA(355.3,DIAIEN,3))
 . . D ADDLN(SUB,.LN,.Z)
 Q
 ;
SELUSERS(INSNAME,INSIEN,PLIEN,LN,DATE,Z) ; procedure to gather edits for selected Users for a date range
 K Z
 N DIAIEN,SUB,DIA0,FIELD,USER
 S SUB=$S(PLIEN:1,1:0)
 S DIAIEN=0
 S Z("PLAN")=$S(PLIEN:$P($G(^IBA(355.3,PLIEN,2)),U),1:"NO PLANS SELECTED")
 S Z("INSNAME")=INSNAME
 ; INSURANCE COMPANY AUDITS
 F  S DIAIEN=$O(^DIA(36,"B",INSIEN,DIAIEN)) Q:'DIAIEN  D
 . S DIA0=^DIA(36,DIAIEN,0),DATE=$P($P(DIA0,U,2),"."),USER=$P(DIA0,U,4)
 . Q:'$D(^TMP("IBUSER",$J,USER))  ; not a selected user
 . Q:DATE<DATE("START")  Q:DATE>DATE("END")   ; audit record outside date range
 . S FIELD=$S($P(DIA0,U,3)=".01":"INSURANCE COMPANY",1:$P(^DD(36,$P(DIA0,U,3),0),U))
 . ;IB*737/CKB - display date & time when a specific User(s) is selected
 . S Z("DATE")=$E($P(DIA0,U,2),1,12),Z("FIELD")=FIELD,Z("USER")=USER
 . S Z("OLDVAL")=$G(^DIA(36,DIAIEN,2)),Z("NEWVAL")=$G(^DIA(36,DIAIEN,3))
 . S Z("PLAN")=$S(PLIEN:$P($G(^IBA(355.3,PLIEN,2)),U),1:"NO PLANS SELECTED")
 . S Z("INSNAME")=INSNAME
 . S Z("ISINS")=36  ;IB*737/DTG flag for file 36
 . I $G(^TMP("IBPRINS",$J,INSIEN,DIAIEN))=1 Q  ; IB*737/DTG do not re-print if alredy printed
 . D ADDLN(SUB,.LN,.Z)
 . S ^TMP("IBPRINS",$J,INSIEN,DIAIEN)=1  ; IB*737/DTG track for not re-print if alredy printed
 ;
 Q:'PLANS  ; audits from the GROUP INSURANCE PLAN are not to be reported
 ; if GROUP PLAN edits are to be reported then proceed with gathering edits from file 355.3, 355.32, 355.4
 ;
 ; GROUP INSURANCE PLAN AUDITS
 S DIAIEN=0,Z("ISINS")=""  ;IB*737/DTG make sure DIAIEN is zero, clear itm for file 36
 F  S DIAIEN=$O(^DIA(355.3,"B",PLIEN,DIAIEN)) Q:'DIAIEN  D
 . S DIA0=^DIA(355.3,DIAIEN,0),DATE=$P($P(DIA0,U,2),"."),USER=$P(DIA0,U,4)
 . Q:'$D(^TMP("IBUSER",$J,USER))  ; not a selected user
 . Q:DATE<DATE("START")  Q:DATE>DATE("END")   ; audit record outside date range
 . S FIELD=$P(^DD(355.3,$P(DIA0,U,3),0),U)
 . ;IB*737/CKB - display date & time when a specific User(s) is selected
 . S Z("DATE")=$E($P(DIA0,U,2),1,12),Z("FIELD")=FIELD,Z("USER")=USER
 . S Z("OLDVAL")=$G(^DIA(355.3,DIAIEN,2)),Z("NEWVAL")=$G(^DIA(355.3,DIAIEN,3))
 . D ADDLN(SUB,.LN,.Z)
 Q
 ;
 ;/vd-IB*2*664 - Beginning of new code for eIV Payer selection(s).
 ;IB*737/CKB
PAYERS(ALLPLANS,ALLUSERS,LN,DATE) ; PROCESS PAYERS
 N BDATE,DIA0,DIAIEN,EDATE,FIELD,PAYERLN,PYRAPP,PYRIEN,PYRNAME,SUB
 ;
 S SUB=0
 S Z("ISINS")=""  ;IB*737/DTG clear itm for file 36
 S BDATE=DATE("START")-.000001,EDATE=DATE("END")+.999999
 F  S BDATE=$O(^DIA(365.12,"C",BDATE)) Q:BDATE=""  D
 . I BDATE>EDATE Q
 . S DIAIEN=0,PAYERLN=1
 . F  S DIAIEN=$O(^DIA(365.12,"C",BDATE,DIAIEN)) Q:DIAIEN=""  D
 . . N Z
 . . S DIA0=^DIA(365.12,DIAIEN,0)
 . . S PYRIEN=+$P(DIA0,U,1),PYRAPP=$P($P(DIA0,U,1),",",2)   ; Get the internal Payer # and the Application
 . . ;IB*737/CKB - only "eIV" and "IIU" Application Modifications.
 . . I ($$GET1^DIQ(365.121,PYRAPP_","_PYRIEN_",",.01)'="EIV")&($$GET1^DIQ(365.121,PYRAPP_","_PYRIEN_",",.01)'="IIU") Q
 . . S PYRNAME=$$GET1^DIQ(365.12,PYRIEN,.01)
 . . I 'ALLPYRS,'$D(^TMP("IBPYR",$J,PYRNAME,PYRIEN)) Q   ; Is this a selected payer?
 . . ;IB*668/TAZ - Changed Payer Application from IIV to EIV
 . . ;IB*737/CKB - allow for eIV and IIU Payers
 . . I ('+$$PYRAPP^IBCNEUT5("EIV",PYRIEN))&('+$$PYRAPP^IBCNEUT5("IIU",PYRIEN)) Q
 . . S FIELD=$S($P(DIA0,U,3)="1,.03":"LOCALLY ENABLED","1,5.01":"RECEIVE IIU DATA",1:"")
 . . I FIELD="" Q   ; Not the Locally Enabled or the Receive IIU Data field.
 . . S Z("DATE")=$P(DIA0,U,2),Z("FIELD")=FIELD,Z("USER")=$P(DIA0,U,4)
 . . S Z("OLDVAL")=$G(^DIA(365.12,DIAIEN,2)),Z("NEWVAL")=$G(^DIA(365.12,DIAIEN,3)),Z("PYRNAME")=PYRNAME
 . . I 'ALLUSERS,'$D(^TMP("IBUSER",$J,Z("USER"))) Q
 . . D ADDLN(SUB,.LN,.Z,PAYERLN)
 Q
 ;/IB*2*664 - End of new code.
 ;
 ;ADDLN(SUB,LN,Z) ;/vd-IB*2*664 - Replaced this line with the following line:
ADDLN(SUB,LN,Z,PAYERLN) ;
 ; SUB = 0 if no group plans to be reported
 ;     = 1 if group plans to be reported
 ; LN = passed by reference.  Line subscript at ^TMP("IBPR",$J,PLANS,LN)
 ; PAYERLN=0 if not generating a payer's line
 ;        =1 if a payer's line is being generated
 S LN=LN+1
 ; /vd-IB*2*664 - Replaced the following line with couple of lines below it.
 ;S ^TMP("IBPR",$J,SUB,LN)=Z("INSNAME")_U_Z("PLAN")_U_Z("USER")_U_Z("DATE")_U_Z("OLDVAL")_U_Z("NEWVAL")_U_Z("FIELD")
 ;I '+$G(PAYERLN) S ^TMP("IBPR",$J,SUB,LN)=Z("INSNAME")_U_Z("PLAN")_U_Z("USER")_U_Z("DATE")_U_Z("OLDVAL")_U_Z("NEWVAL")_U_Z("FIELD") Q
 I '+$G(PAYERLN) D  Q
 . S ^TMP("IBPR",$J,SUB,LN)=Z("INSNAME")_U_Z("PLAN")_U_Z("USER")_U_Z("DATE")
 . S ^TMP("IBPR",$J,SUB,LN)=^TMP("IBPR",$J,SUB,LN)_U_Z("OLDVAL")_U_Z("NEWVAL")_U_Z("FIELD")
 . S ^TMP("IBPR",$J,SUB,LN)=^TMP("IBPR",$J,SUB,LN)_U_$G(Z("ISINS"))  ; IB*737/DTG identify file 36 entry
 ;S ^TMP("IBPR2",$J,SUB,LN)=Z("PYRNAME")_U_Z("USER")_U_Z("DATE")_U_Z("OLDVAL")_U_Z("NEWVAL")_U_Z("FIELD")
 S ^TMP("IBPR2",$J,SUB,LN)=Z("PYRNAME")_U_Z("USER")_U_Z("DATE")_U_Z("OLDVAL")_U_Z("NEWVAL")_U_Z("FIELD")
 S ^TMP("IBPR2",$J,SUB,LN)=^TMP("IBPR2",$J,SUB,LN)_U_$G(Z("ISINS"))  ; IB*737/DTG identify file 36 entry
 Q
