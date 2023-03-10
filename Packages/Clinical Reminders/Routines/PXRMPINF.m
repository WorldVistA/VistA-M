PXRMPINF ;SLC/PKR - Routines relating to patient information. ;07/01/2020
 ;;2.0;CLINICAL REMINDERS;**12,17,24,45,42**;Feb 04, 2005;Build 245
 ;
 ;===============
DATACHG ;This entry point is called whenever patient data has changed.
 ;It is attached to the following event points:
 ;PXK VISIT DATA EVENT via PXRM PATIENT DATA CHANGE
 ;
 I '$D(^TMP("PXKCO",$J)) Q
 N EVENT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S EVENT=$$NEWEVENT("PXRM PXK EVENT",$NA(^TMP("PXKCO",$J)),.ZTSAVE)
 S ZTRTN="DATACHGR^PXRMPINF"
 S ZTDESC="Clinical Reminders PXK VISIT DATA EVENT handler"
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
 ;===============
DATACHGR ;Process data from PXK VISIT DATA EVENT
 N DATA,DFN,DGBL,NODE,PXRMDFN,VIEN,VISIT,VF,VFL,VGBL
 S ZTREQ="@"
 ;Look for PXK VISIT DATA EVENT data.
 S VISIT=$O(^XTMP(EVENT,0))
 S VIEN=$O(^XTMP(EVENT,VISIT,"VST",""))
 S NODE=$O(^XTMP(EVENT,VISIT,"VST",VIEN,""))
 S DATA=$G(^XTMP(EVENT,VISIT,"VST",VIEN,NODE,"AFTER"))
 I DATA="" S DATA=$G(^XTMP(EVENT,VISIT,"VST",VIEN,NODE,"BEFORE"))
 S DFN=$P(DATA,U,5)
 ;Build the list of V Files.
 S VF=""
 F  S VF=$O(^XTMP(EVENT,VISIT,VF)) Q:VF=""  D
 . S DGBL=$S(VF="CPT":"PXD(811.2,",VF="HF":"AUTTHF(",VF="IMM":"AUTTIMM(",VF="PED":"AUTTEDT(",VF="POV":"PXD(811.2,",VF="SK":"AUTTSK(",VF="XAM":"AUTTEXAM(",1:"")
 . S VGBL=$S(VF="CPT":"AUPNVCPT(",VF="HF":"AUPNVHF(",VF="IMM":"AUPNVIMM(",VF="PED":"AUPNVPED(",VF="POV":"AUPNVPOV(",VF="SK":"AUPNVSK(",VF="XAM":"AUPNVXAM(",1:"")
 . S VFL(VF)=DGBL_U_VGBL
 ;Call the routines that need to process the data.
 D UPDPAT^PXRMMST(EVENT,DFN,VISIT,.VFL)
 D SUICIDE^PXRMNTFY(EVENT,DFN,VISIT)
 D:'$$ISHIST^PXRMVSIT(VISIT) WH^PXRMNTFY(EVENT,DFN,VISIT)
 K ^XTMP(EVENT)
 Q
 ;
 ;===============
DEM(DFN,TODAY,DEMARR) ;Load the patient demographics into DEMARR
 ;The patient's age is calculated using whatever date is passed as
 ;TODAY. If there is a date of death and it is greater than TODAY
 ;then set the date of death to null. Direct read of patient file
 ;supported DBIA #10035. DATE OF BIRTH and SEX are required fields
 ;in the patient file.
 N TEMP
 K DEMARR
 I $L(DFN)'>0 S DEMARR("PATIENT")="" Q
 S TEMP=$G(^DPT(DFN,0))
 I TEMP="" S DEMARR("PATIENT")="" Q
 S DEMARR("PATIENT")=$P(TEMP,U,1)
 S DEMARR("SEX")=$P(TEMP,U,2)
 S DEMARR("DOB")=$P(TEMP,U,3)
 S DEMARR("SSN")=$P(TEMP,U,9)
 S DEMARR("DOD")=$P($G(^DPT(DFN,.35)),U,1)
 I DEMARR("DOD")>TODAY S DEMARR("DOD")=""
 S DEMARR("DFN")=DFN
 S DEMARR("SIG")=$P($G(^DPT(DFN,.24)),U,4)
 S DEMARR("AGE")=$$AGE^PXRMAGE(DEMARR("DOB"),DEMARR("DOD"),TODAY)
 ;DBIA #1096
 S TEMP=$O(^DGPM("ATID1",DFN,""))
 I TEMP'="" S TEMP=9999999.999999-TEMP
 S DEMARR("LAD")=TEMP
 ;Save the global demographic variables for reminder test.
 I $G(PXRMDEBG) D
 . K ^TMP("PXRMDEM",$J)
 . N SUB
 . S SUB=""
 . F  S SUB=$O(DEMARR(SUB)) Q:SUB=""  S ^TMP("PXRMDEM",$J,SUB)=DEMARR(SUB)
 Q
 ;
 ;===============
NEWEVENT(EVENT,DATALOC,ZTSAVE) ;Generate a new node in ^XTMP to store data for
 ;later processing
 N RETURN
 S RETURN=EVENT_$J_" "_$$NOW^XLFDT
 ;Make sure sub-script is unique.
 F  Q:'$D(^XTMP(RETURN))  I $D(^XTMP(RETURN)) H 1 S RETURN=EVENT_$J_" "_$$NOW^XLFDT
 K ^XTMP(RETURN)
 S ^XTMP(RETURN,0)=$$FMADD^XLFDT($$NOW^XLFDT,0,12)_U_DT
 M ^XTMP(RETURN)=@DATALOC
 S ZTSAVE("EVENT")=""
 S ZTSAVE("XTMP(")=""
 Q RETURN
 ;
 ;===============
PLIST ;This entry point is called whenever patient data has changed.
 ;It is attached to the following event points:
 ;GMPL EVENT via PXRM PATIENT PROBLEM DATA CHANGE
 ;
 I '$D(DFN)!('$D(GMPIFN)) Q
 N EVENT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTSAVE("DFN")=""
 S ZTSAVE("GMPIFN")=""
 S ZTRTN="PLISTR^PXRMPINF"
 S ZTDESC="Clinical Reminders GMPL EVENT handler"
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
 ;===============
PLISTR ;Process data from GMPL EVENT
 ;For diagnoses added to the problem list via the Encounter
 ;form, both DATACHG and PLIST line tags are executed
 ;in that order
 S ZTREQ="@"
 ;Call the routines that need to process the data.
 D WH^PXRMNTFY("",DFN,"",GMPIFN)
 Q
 ;
 ;===============
PTFCHG ;This entry point is called whenever patient data has changed.
 ;It is attached to the following event points:
 ;DG PTF ICD DIAGNOSIS NOTIFIER via PXRM PATIENT PTF DATA CHANGE
 I '$D(^TMP("DG PTF ICD NOTIFIER",$J)) Q
 N EVENT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S EVENT=$$NEWEVENT("PXRM PTF EVENT",$NA(^TMP("DG PTF ICD NOTIFIER",$J)),.ZTSAVE)
 S ZTRTN="PTFCHGR^PXRMPINF"
 S ZTDESC="Clinical Reminders DG PTF ICD DIAGNOSIS NOTIFIER handler"
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
 ;===============
PTFCHGR ;Process data from DG PTF ICD DIAGNOSIS NOTIFIER
 S ZTREQ="@"
 N DFN
 S DFN=$G(^XTMP(EVENT,"DFN"))
 D WH^PXRMNTFY(EVENT,DFN,"","")
 K ^XTMP(EVENT)
 Q
 ;
