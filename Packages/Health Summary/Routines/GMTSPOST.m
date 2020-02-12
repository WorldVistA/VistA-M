GMTSPOST ;SLC/JER - Post-init for Health Summary ;10/4/19 9:39am
 ;;2.7;Health Summary;**129**;Oct 20, 1995;Build 8
MAIN ; Controls branching and execution
 N GMI,INCLUDE,GMTSEG,GMTSI,GMTSIFN,GMTJ,GMTSNM
 W !!,"Starting post-init action now...."
 D SPOOL,PARAM
 ;GMTS*2.7*129 remove call to SOWK^GMTSPOS1
 D INPHAR,DIET,OERR,VITALS,LAB,RAD,MHPE,PRGNOTE,SURG,DCS,CP,PL^GMTSPOS1,PCE,MED^GMTSPOS1,PSO^GMTSPOS1,OUTPHAR
 D EN^GMTSPOS2
 K ^GMT(142,12,1,"C") ;Get rid of "C" xref in case there are duplicate entries
 W !!,"'C' cross-reference on the GMTS AD HOC OPTION type in file 142 deleted."
 W !,"It will be rebuilt"
 S INCLUDE=0 D ENPOST^GMTSLOAD
 D ^GMTSONIT
 W !!,"Post-init successfully completed."
 D FINITO
 K GMTSIST
 Q
SPOOL ; Convert spool name to pointer value
 N DIC,DIE,DA,X
 S X=$P($G(^GMT(142.99,1,0)),U,4)
 Q:+X!(X']"")  ;Quit is Spool Device is null or a numeric value
 S DIC=3.5,DIC(0)="X"
 D ^DIC
 W !!,"Converting "_X_" to a pointer value for Spool Device in Site Parameter file."
 I +Y'>0 D  Q
 . W !,"** Can't converted "_X_" to a pointer value. **"
 . W !,"Enter a Valid Spool Device using 'Edit Health Summary Site Parameters' option."
 S $P(^GMT(142.99,1,0),U,4)=+Y
 W !,X," converted successfully."
 Q
PARAM ; Convert YES/NO codes from 1/0 to Y/N
 N GMNUM,X
 F GMNUM=2,3,5 D
 . S X=$P($G(^GMT(142.99,1,0)),U,GMNUM)
 . Q:X']""!(X="Y")!(X="N")  ;Quit there is not entry or it is "Y" or "N"
 . I X=0 S $P(^GMT(142.99,1,0),U,GMNUM)=""
 . I X=1 S $P(^GMT(142.99,1,0),U,GMNUM)="Y"
 Q
INPHAR ; Checks conditions auto-disable of Inpatient Pharmacy components
 N GMMSG,X
 S X="PSJEEU0"
 X ^%ZOSF("TEST")
 Q:$T
 F X="PHARMACY INTRAVENOUS","PHARMACY UNIT DOSE" S GMMSG="Inpatient Medications not yet available" D DISABLE
 Q
OUTPHAR ; Checks conditions auto-disable of Outpatient Pharmacy components
 N GMMSG,X
 S X="PSOHCSUM"
 X ^%ZOSF("TEST")
 Q:$T
 F X="PHARMACY OUTPATIENT" S GMMSG="Outpatient Pharmacy not yet available" D DISABLE
 Q
DIET ; Checks conditions auto-disable of Dietetics
 N GMMSG,X
 S X="FHWHEA"
 X ^%ZOSF("TEST")
 Q:$T
 F X="DIETETICS" S GMMSG="Dietetics not yet available" D DISABLE
 Q
OERR ; Checks conditions auto-disable of OERR Orders
 N GMMSG,X
 S X="ORF4"
 X ^%ZOSF("TEST")
 Q:$T
 F X="ORDERS CURRENT" S GMMSG="OE/RR Orders not yet available" D DISABLE
 Q
VITALS ; Checks conditions auto-disable of Vitals
 N GMMSG,X
 S X="GMRVUT0"
 X ^%ZOSF("TEST")
 Q:$T
 F X="VITAL SIGNS","VITAL SIGNS SELECTED" S GMMSG="Vital Signs not yet available" D DISABLE
 Q
PRGNOTE ; Checks conditions auto-disable of Progress Note components
 N GMMSG,X
 I ($D(^YSP(606))<10),($D(^GMR(121))<10) F X="PROGRESS NOTES","PROGRESS NOTES BRIEF" S GMMSG="Progress Notes not yet available" D DISABLE
 I $D(^GMR(121))<10 F X="ADVANCE DIRECTIVE","CLINICAL WARNINGS","CRISIS NOTES" S GMMSG=X_" not yet available" D DISABLE
 Q
SURG ; Checks conditions for auto-disable of Surgery component
 N X,GMMSG
 I $D(^SRF)<10 F X="SURGERY REPORTS","SURGERY REPORTS BRIEF" S GMMSG="Surgery Package not yet installed" D DISABLE
 Q
DCS ; Checks conditions for auto-disable of Discharge Summary components
 N X,GMMSG
 I $D(^GMR(128))<10 D
 . S GMMSG="Discharge Summary Package not yet installed or available"
 . F X="DISCHARGE SUMMARY","DISCHARGE SUMMARY BRIEF"  D DISABLE
 Q
CP ; Checks conditions for auto-disable of Compensation and Pension component
 N X,GMMSG
 ; Checks conditions for auto-disable of Comp & Pen component
 I +$$VERSION^XPDUTL("DVBA")<2.7 D
 . S GMMSG="Requires AMIE version 2.7"
 . S X="COMPENSATION AND PENSION EXAMS" D DISABLE^GMTSPOST
 Q
LAB ; Checks condition for auto-disable of Lab components
 N GMMSG,X
 I $$VERSION^XPDUTL("LR")<5.1 D
 . S GMMSG="Requires Lab version 5.1 or later"
 . F X="LAB BLOOD AVAILABILITY","LAB BLOOD TRANSFUSIONS","LAB CHEMISTRY & HEMATOLOGY","LAB CUMULATIVE SELECTED","LAB CUMULATIVE SELECTED 1" D DISABLE^GMTSPOST
 . F X="LAB CUMULATIVE SELECTED 2","LAB CUMULATIVE SELECTED 3","LAB CUMULATIVE SELECTED 4","LAB CYTOPATHOLOGY","LAB ELECTRON MICROSCOPY","LAB MICROBIOLOGY" D DISABLE^GMTSPOST
 . F X="LAB MICROBIOLOGY BRIEF","LAB ORDERS","LAB ORDERS BRIEF","LAB SURGICAL PATHOLOGY","LAB TESTS SELECTED" D DISABLE^GMTSPOST
 Q
RAD ; Checks condition for auto-disable of Radiology
 N GMMSG,X
 I $$VERSION^XPDUTL("RA")<3 D
 . S GMMSG="Requires Radiology version 3 or later"
 . F X="RADIOLOGY IMPRESSION","RADIOLOGY IMPRESSION SELECTED","RADIOLOGY PROFILE","RADIOLOGY STATUS" D DISABLE^GMTSPOST
 Q
MHPE ; Checks condition for auto-disable of Mental Health
 N GMMSG,X
 I $$VERSION^XPDUTL("YS")<5 D
 . S GMMSG="Requires Mental Health version 5 or later"
 . F X="MENTAL HEALTH PHYSICAL EXAM" D DISABLE^GMTSPOST
 Q
PCE ; Checks for existence of PCE package...Disables components if absents
 N GMMSG,X
 I $$VERSION^XPDUTL("PX")'>0 D  ;Disable PCE components if PCE not installed nor available 
 . S GMMSG="Patient Care Encounter Package not yet installed"
 . F X="PCE LOCATION OF HOME","PCE CLINICAL REMINDERS","PCE HEALTH FACTORS SELECTED","PCE HEALTH FACTORS ALL","PCE OUTPATIENT ENCOUNTERS","PCE MEASUREMENTS NON-TABULAR","PCE IMMUNIZATIONS","PCE SKIN TESTS" D DISABLE^GMTSPOST
 . F X="PCE MEASUREMENTS SELECTED","PCE EDUCATION","PCE EDUCATION LATEST","PCE OUTPATIENT DIAGNOSIS","PCE EXAMS LATEST","PCE TREATMENTS PROVIDED" D DISABLE^GMTSPOST
 . F X="PCE CLINICAL MAINTENANCE" D DISABLE^GMTSPOST
 Q
DISABLE ; Disable components if auto-disable conditions are met
 N DA,DIC,DIE,DR,Y
 S DIC="^GMT(142.1,",DIC(0)="X" D ^DIC
 I +Y>0 D
 . W !,X," Health Summary Component disabled"
 . S DA=+Y,DR="5///"_"P"_";8///"_GMMSG,DIE=DIC D ^DIE
 Q
FINITO ; Finish initialization, inform user
 N GMTSIFT,GMTSITD,X
 S GMTSIFT=$$NOW^GMTSPREI,GMTSITD=$$DIFF(GMTSIFT,+$G(GMTSIST))
 W !!,"HEALTH SUMMARY VERSION 2.7 INITIALIZATION COMPLETE!"
 Q:'$L($T(FMDIFF^XLFDT))
 S X=$G(GMTSIST) D REGDTM^GMTSU
 W !!?9,"Initialization began at: ",X
 S X=GMTSIFT D REGDTM^GMTSU
 W !!?5,"Initialization completed at: ",X
 W !!?7,"TOTAL Initialization Time: ",GMTSITD
 Q
DIFF(END,BEGIN) ; Converts time difference to external format
 N DIFF,HR,MIN,SEC,Y
 S DIFF=$$FMDIFF^XLFDT(END,BEGIN,2),HR=DIFF\3600
 S MIN=DIFF\60,SEC=DIFF#60
 S HR=$E("00",0,2-$L(HR))_HR,MIN=$E("00",0,2-$L(MIN))_MIN,SEC=$E("00",0,2-$L(SEC))_SEC
 S Y=HR_":"_MIN_":"_SEC
 Q Y
