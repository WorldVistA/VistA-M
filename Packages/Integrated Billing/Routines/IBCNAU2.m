IBCNAU2 ;ALB/KML/AWC - eIV USER EDIT REPORT (COMPILE) ;6-APRIL-2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Queued Entry Point for Report.
 ;  Required variable input:  ALLUSERS, ALLINS, PLANS, ALLPLANS, EXCEL
 ;  ^TMP("IBINC",$J) 
 ;  ^TMP("IBUSER",$J) 
 ;  DATE("START") and DATE("END") required array elements if all dates not selected
 ;
 Q
 ;
EN(ALLINS,ALLPLANS,PLANS,DATE) ;
 N LN
 S LN=0
 ; - compile report data
 K ^TMP("IBPR",$J)
 ;
 ; - user wanted all companies,PLANS, and users
 I PLANS D PLANS(ALLUSERS,.LN,.DATE)
 E  D NOPLANS(ALLUSERS,.LN,.DATE)
 ;
PRINT ; - print report
 D EN^IBCNAU3(ALLPLANS,PLANS)
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
 . . . I 'ALLUSERS D SELUSERS(INSNAME,INSIEN,PLIEN,.DATE,.Z)
 Q
 ;
NOPLANS(ALLUSERS,LN,DATE) ;  only report edits made to INSURANCE COMPANY file (36)
 N INSNAME,INSIEN,PLIEN
 S PLIEN=0
 ;
 S INSNAME="" F  S INSNAME=$O(^TMP("IBINC",$J,INSNAME)) Q:INSNAME=""  D
 . S INSIEN=0 F  S INSIEN=$O(^TMP("IBINC",$J,INSNAME,INSIEN)) Q:'INSIEN  D
 . . I ALLUSERS D ALLUSERS(INSNAME,INSIEN,0,0,.LN,.DATE,.Z)
 . . I 'ALLUSERS D SELUSERS(INSNAME,INSIEN,PLIEN,.DATE,.Z)
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
 . D ADDLN(SUB,.LN,.Z)
 ;
 ; if GROUP PLAN edits are to be reported then proceed with gathering edits from file 355.3, 355.32, 355.4
 ; GROUP INSURANCE PLAN AUDITS
 I PLANS D
 . F  S DIAIEN=$O(^DIA(355.3,"B",PLIEN,DIAIEN)) Q:'DIAIEN  D
 . . S DIA0=^DIA(355.3,DIAIEN,0),DATE=$P($P(DIA0,U,2),".")
 . . Q:DATE<DATE("START")  Q:DATE>DATE("END")   ; audit record outside date range
 . . S FIELD=$P(^DD(355.3,$P(DIA0,U,3),0),U)
 . . S Z("DATE")=$E($P(DIA0,U,2),1,12),Z("FIELD")=FIELD,Z("USER")=$P(DIA0,U,4)
 . . S Z("OLDVAL")=$G(^DIA(355.3,DIAIEN,2)),Z("NEWVAL")=$G(^DIA(355.3,DIAIEN,3))
 . . D ADDLN(SUB,.LN,.Z)
 Q
 ;
SELUSERS(INSNAME,INSIEN,PLIEN,DATE,Z) ; procedure to gather edits for selected Users for a date range
 K Z
 N DIAIEN,LN,SUB,DIA0,FIELD,USER
 S SUB=$S(PLIEN:1,1:0)
 S (LN,DIAIEN)=0
 S Z("PLAN")=$S(PLIEN:$P($G(^IBA(355.3,PLIEN,2)),U),1:"NO PLANS SELECTED")
 S Z("INSNAME")=INSNAME
 ; INSURANCE COMPANY AUDITS
 F  S DIAIEN=$O(^DIA(36,"B",INSIEN,DIAIEN)) Q:'DIAIEN  D
 . S DIA0=^DIA(36,DIAIEN,0),DATE=$P($P(DIA0,U,2),"."),USER=$P(DIA0,U,4)
 . Q:'$D(^TMP("IBUSER",$J,USER))  ; not a selected user
 . Q:DATE<DATE("START")  Q:DATE>DATE("END")   ; audit record outside date range
 . S FIELD=$S($P(DIA0,U,3)=".01":"INSURANCE COMPANY",1:$P(^DD(36,$P(DIA0,U,3),0),U))
 . S Z("DATE")=DATE,Z("FIELD")=FIELD,Z("USER")=USER
 . S Z("OLDVAL")=$G(^DIA(36,DIAIEN,2)),Z("NEWVAL")=$G(^DIA(36,DIAIEN,3))
 . S Z("PLAN")=$S(PLIEN:$P($G(^IBA(355.3,PLIEN,2)),U),1:"NO PLANS SELECTED")
 . S Z("INSNAME")=INSNAME
 . D ADDLN(SUB,.LN,.Z)
 Q:'PLANS  ; audits from the GROUP INSURANCE PLAN are not to be reported
 ; if GROUP PLAN edits are to be reported then proceed with gathering edits from file 355.3, 355.32, 355.4
 ;
 ; GROUP INSURANCE PLAN AUDITS
 F  S DIAIEN=$O(^DIA(355.3,"B",PLIEN,DIAIEN)) Q:'DIAIEN  D
 . S DIA0=^DIA(355.3,DIAIEN,0),DATE=$P($P(DIA0,U,2),"."),USER=$P(DIA0,U,4)
 . Q:'$D(^TMP("IBUSER",$J,USER))  ; not a selected user
 . Q:DATE<DATE("START")  Q:DATE>DATE("END")   ; audit record outside date range
 . S FIELD=$P(^DD(355.3,$P(DIA0,U,3),0),U)
 . S Z("DATE")=DATE,Z("FIELD")=FIELD,Z("USER")=USER
 . S Z("OLDVAL")=$G(^DIA(355.3,DIAIEN,2)),Z("NEWVAL")=$G(^DIA(355.3,DIAIEN,3))
 . D ADDLN(SUB,.LN,.Z)
 Q
 ;
ADDLN(SUB,LN,Z) ;
 ; SUB = 0 if no group plans to be reported
 ;     = 1 if group plans to be reported
 ; LN = passed by reference.  Line subscript at ^TMP("IBPR",$J,PLANS,LN)
 S LN=LN+1
 S ^TMP("IBPR",$J,SUB,LN)=Z("INSNAME")_U_Z("PLAN")_U_Z("USER")_U_Z("DATE")_U_Z("OLDVAL")_U_Z("NEWVAL")_U_Z("FIELD")
 Q
