DG311PIR ;ALB/JJG-Total Dependents Calculation Utility ; 07 AUG 2000
 ;;5.3;Registration;**311**;Aug 13, 1993
 ;
 ; This routine will be run as a post-installation routine for patch
 ; DG*5.3*311. The main purpose for this routine is to recalculate 
 ; the TOTAL DEPENDENTS field (408.31,.18) of the ANNUAL MEANS TEST file
 ; (#408.31). This field may have been set incorrectly as a result of
 ; a recent modification to routine DGMTU11 that was released as part of
 ; patch DG*5.3*291.
 ;
POST ;entry point for post-install, setting up checkpoints
 N %
 I $D(XPDNM) S %=$$NEWCP^XPDUTL("DGMTDT","MAIN^DG311PIR",0)
 Q
MAIN ;Main Driver
 N DGRECNT,DGLY,DGMTPAR
 S U="^",DGRECNT=0
 D BMES^XPDUTL(" Starting post-install process...")
 S DGLY=2990000 ;Last Year, required by PAR^DGMTSCU
 D PAR^DGMTSCU
 D LOOP
 D MAIN^DG311PTR ; Clean up any invalid '0' pointers to Patient Relation
 D BMES^XPDUTL(" Post-install process has completed.")
 D BMES^XPDUTL(" "_DGRECNT_" total records have been identified and corrected.")
 Q
LOOP ; Locate and correct incorrect TOTAL DEPENDENTS field
 N DGMTDT,DGIEN31,DGNOD31,DGIEN2,DGSTA,DGTOTD,DGMTYPT,DGDEPC,DGPAY,DGDEC
 N DGHARD
 S DGMTDT=3000705  ;Patch DG*5.3*291 release date
 I $D(XPDNM) S DGMTDT=+$$PARCP^XPDUTL("DGMTDT")
 S:(DGMTDT<3000705) DGMTDT=3000705
 F  S DGMTDT=$O(^DGMT(408.31,"B",DGMTDT)) Q:'DGMTDT  D
 .S DGIEN31=0
 .F  S DGIEN31=$O(^DGMT(408.31,"B",DGMTDT,DGIEN31)) Q:'DGIEN31  D
 . .S DGNOD31=$G(^DGMT(408.31,DGIEN31,0))
 . .S DGIEN2=$P(DGNOD31,"^",2) Q:'DGIEN2
 . .S DGSTA=$P(DGNOD31,"^",3) ;Means Test Status
 . .S DGMTYPT=$P(DGNOD31,"^",19) ;Type of Test: 1=Means Test 2=Copay Test
 . .S DGTOTD=$P(DGNOD31,"^",18)  ;Total Dependents
 . .S DGPAY=$P(DGNOD31,"^",11)   ;Agreed To Pay Deductible
 . .S DGDEC=$P(DGNOD31,"^",14)   ;Declines To Give Income Info.
 . .S DGHARD=$P(DGNOD31,"^",20)  ;Hardship?
 . .D GETREL^DGMTU11(DGIEN2,"VSC",DGMTDT,DGIEN31) ; Recalculate Total Dependents minus spouse
 . .S DGDEPC=DGDEP
 . .S:$G(DGREL("S")) DGDEPC=DGDEPC+1  ; Include the spouse as DGMTU11 only returns children
 . .I (DGTOTD!DGDEPC)&(DGTOTD'=DGDEPC) D UPDATE
 . .I $D(XPDNM) S %=$$UPCP^XPDUTL("DGMTDT",DGMTDT)  ; Update Checkpoint
 Q
UPDATE ;Update .18 field of ANNUAL MEANS TEST file
 N DATA,DGENDA,ERROR,DFN,DGMTI,DGVIRI,DGVINI,DGMTACT,DGMTI,DGMTINF,DGREL,DGPRIEN,DGUPSW
 S DFN=DGIEN2,DGMTI=DGIEN31,(DGVIRI,DGREL,DGUPSW)=""
 F  S:(DGREL'=1) DGVIRI=$O(^DGMT(408.22,"B",DFN,DGVIRI),-1) Q:DGREL=1!('DGVIRI)  D
 .S DGVINI=$P($G(^DGMT(408.22,DGVIRI,0)),U,2)
 .Q:'DGVINI
 .S DGPRIEN=$P($G(^DGMT(408.21,DGVINI,0)),U,2) ; Pointer to PATIENT RELATION file (#408.12)
 .Q:'DGPRIEN
 .S DGREL=$P($G(^DGPR(408.12,DGPRIEN,0)),U,2) ;Pointer to RELATIONSHIP file (#408.11)
 .I DGREL=1 S DATA(.13)=DGDEP,DGENDA=DGVIRI,ERROR="" D
 .. I $$UPD^DGENDBS(408.22,.DGENDA,.DATA,.ERROR) Q
 Q:DGREL'=1  ; Quit if relationship is not 'SELF'
 D:(DGSTA=4)!(DGMTYPT=2&(DGSTA=7)) SET^DGMTSCU2 ;only make call if current status is 'Cat A'.  Or, if copay test, only make call for status of 'Exempt'.
 K DATA
 S DATA(.18)=DGDEPC ; Newly derived Total # of dependents
 ; In the following 2 lines, only want to update Status and associated
 ; fields if current status is 'Cat A', and 'Hardship' flag is not 'YES'.
 ; For copay test, only update status and associated fields if current
 ; status is 'Exempt' and 'Hardship' flag is not 'YES'.
 I (DGSTA=4),'DGHARD S DGUPSW=1
 I DGMTYPT=2&(DGSTA=7),'DGHARD S DGUPSW=1
 I DGUPSW D
 .S DATA(.03)=DGMTS ; Newly derived Status
 .S DATA(.12)=DGTHA ; Newly derived Threshold A field
 .S DATA(2.03)=DGMTS ; Newly derived Test Determined Status
 I (DGSTA'=4)&(DGSTA'=7) S DGMTS=DGSTA ; need DGMTS for build of ^XTMP
 S DGENDA=DGIEN31,ERROR=""
 S DGMTACT="EDT",DGMTI=DGENDA,DGMTINF=1  ; Needed for call to DGMTEVT
 D PRIOR^DGMTEVT
 I $$UPD^DGENDBS(408.31,.DGENDA,.DATA,.ERROR) D
 .D AFTER^DGMTEVT
 .D EN^DGMTEVT  ; Call to Means Test Event Driver
 .S DGRECNT=DGRECNT+1
 .D BUILDLN
 .D ATRXREF
 Q
 ;
BUILDLN ; Build storage array with data
 ;
 ;Output:  
 ; ^XTMP("DG311PIR",pt name,pt ssn,income year,old status,new status)=""
 ;
 N DGNAME,DGSSN,DGINY
 ;
 ; - pt name and ssn from Patient (#2) file
 S DGNAME=$P($G(^DPT(DFN,0)),"^"),DGSSN=$P($G(^(.36)),"^",3)
 S:DGNAME="" DGNAME=DFN
 S:DGSSN="" DGSSN="MISSING"
 S Y=DGMTDT
 D DD^%DT
 S DGINY=$P(Y," ",3)
 ;
 S ^XTMP("DG311PIR",DGNAME,DGSSN,DGINY,DGSTA,DGMTS)=""
 Q
 ;
ATRXREF ; Add entry into the 'ATR' cross reference of the IVM PATIENT (#301.5)
 ; file so that demographic and income information will be transmitted 
 ; to the IVM Center.
 ;
 N IVIEN,IVNOD,IVIY,IVLAST,IVSF,IVTS
 S IVIEN="",IVLAST=0,IVLIEN=""
 F  S IVIEN=$O(^IVM(301.5,"B",DGIEN2,IVIEN)) Q:'IVIEN  D
 . S IVNOD=^IVM(301.5,IVIEN,0)
 . S IVIY=$P(IVNOD,U,2)
 . S:(IVIY>IVLAST) IVLAST=IVIY,IVLIEN=IVIEN
 I (IVLIEN'="") D
 . S ^IVM(301.5,"ATR",0,IVLIEN)=""
 . S IVTS=$P(IVNOD,U,3)  ; Transmission Status Flag
 . S IVSF=$P(IVNOD,U,4)  ; Stop Flag
 . I IVTS!IVSF D
 .. K DATA
 .. S DATA(.03)=0,DATA(.04)=0,ERROR=""
 .. I $$UPD^DGENDBS(301.5,.IVLIEN,.DATA,.ERROR) Q
 Q
