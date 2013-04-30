RORP013 ;BP/ACS CCR POST-INIT PATCH 13 ;08/31/09
 ;;1.5;CLINICAL CASE REGISTRIES;**13**;Feb 17, 2006;Build 27
 ;
 ; This routine uses the following IAs:
 ;
 ; #2053    UPDATE^DIE (supported)
 ; #10075   OPTION file r/w
 ;
 N RORPARM S RORPARM("DEVELOPER")=1
 ;
 ;******************************************************************************
 ;Add new LOINC code 57006-9 to the VA HEPC lab search criterion in the
 ;ROR LAB SEARCH file #798.9.  Do not add the 'dash' or the number following it
 ;******************************************************************************
 N I,HEPCIEN,RORDATA,RORLOINC K RORMSG
 S HEPCIEN=$O(^ROR(798.9,"B","VA HEPC",0)) ;HEPC Registry top level IEN
 ;--- add LOINC code to the VA HEPC search criteria
 S RORLOINC=57006
 ;add if it isn't already in the global
 I '$D(^ROR(798.9,HEPCIEN,1,"B",RORLOINC)) D
 . S RORDATA(1,798.92,"+2,"_HEPCIEN_",",.01)=$G(RORLOINC)
 . S RORDATA(1,798.92,"+2,"_HEPCIEN_",",1)=6
 . D UPDATE^DIE("","RORDATA(1)",,"RORMSG")
 . K RORDATA,RORMSG
 ;
 ;******************************************************************************
 ;Add new Non-VA Meds data area to file ROR DATA AREA
 ;******************************************************************************
 ;remove old entry if it exists
 N DIK S DIK="^ROR(799.33,",DA=$O(^ROR(799.33,"B","Non-VA Meds",0)) I $G(DA)>0 D ^DIK
 N RORFDA,RORERR,RORIEN
 S RORFDA(799.33,"+1,",.01)="Non-VA Meds"
 S RORIEN(1)=19 ;set IEN to 19
 D UPDATE^DIE(,"RORFDA","RORIEN","RORERR")
 K RORFDA,RORERR,RORIEN
 ;
 ;******************************************************************************
 ;Update the NON-VA MEDS backpull entry in the ROR HISTORICAL DATA 
 ;EXTRACT file with END DATE and ACTIVATION DATE = current date.
 ;******************************************************************************
 N RORIEN S RORIEN=$O(^RORDATA(799.6,"B","NON-VA MEDS",0))
 I $G(RORIEN) D
 . N DIE,DA,DR
 . S DIE="^RORDATA(799.6,",DA=RORIEN,DR=".04///"_DT_";.07///"_DT D ^DIE
 ;
 ;******************************************************************************
 ;Add new entries to the ROR XML ITEM file (#799.31)
 ;******************************************************************************
 N RORXML,RORTAG,RORFDA,RORERR
 ;--- add codes
 F I="REFILLS","ALL_FILLS","RECENT_FILLS" D 
 . S RORXML=I
 . ;don't add if it's already in the global
 . Q:$D(^ROR(799.31,"B",RORXML))
 . S RORFDA(799.31,"+1,",.01)=RORXML
 . D UPDATE^DIE(,"RORFDA",,"RORERR")
 K RORFDA,RORERR
 ;
 ;******************************************************************************
 ;Update report parameter panels in ROR REPORT PARAMETERS file (#799.34) for
 ;reports impacted by the Clinic, Division, or Patient panels
 ;******************************************************************************
 N RORIEN,RORPANEL,DIE,DA,DR
 F RORIEN=3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20 D
 . S RORTAG="RP"_RORIEN
 . S RORPANEL=$P($T(@RORTAG),";;",2)
 . Q:'RORPANEL
 . S DIE="^ROR(799.34,",DA=RORIEN,DR="1///"_RORPANEL D ^DIE
 ;
 ;******************************************************************************
 ;Add RPC 'ROR GET M VERSION' to OPTION 'ROR GUI' in file 19.
 ;******************************************************************************
 N VALUE,IEN S VALUE="ROR GUI" S IEN=$$FIND1^DIC(19,,"X",.VALUE)
 I $G(IEN) D
 . N DIC,X,Y
 . K DA S DA(1)=IEN
 . S DIC="^DIC(19,"_DA(1)_",""RPC"","
 . S DIC(0)="XL",X="ROR GET M VERSION"
 . D ^DIC
 ;
 Q
 ;******************************************************************************
 ;updated report panels in 799.34
 ;******************************************************************************
RP3 ;;10,14,22,62,35,30,34,50,140,180,70,100;;General Utilization & Demographics
RP4 ;;10,14,22,60,66,50,34,140,180,70,100;;Clinic Follow Up
RP5 ;;10,14,22,170,110,46,34,140,180,70,100;;Inpatient Utilization
RP6 ;;10,14,22,110,120,52,34,50,140,180,70,100;;Lab Utilization
RP7 ;;10,14,22,110,120,34,50,140,180,70,100;;Radiology Utilization
RP9 ;;10,14,22,170,26,110,46,54,44,90,34,50,140,180,70,100;;Pharmacy Prescription Utilization
RP10 ;;10,14,22,47,34,50,140,180,70,100;;Registry Lab Tests by Range
RP11 ;;10,14,170,26,45,54,34,50,140,180,70,100;;Patient Medication History
RP12 ;;14,22,64,66,10,54,44,11,53,12,34,50,140,180,70,100;;Combined Meds and Labs
RP13 ;;10,14,22,62,160,34,50,140,70,100;;Diagnoses
RP14 ;;10,14,22,170,26,62,84,56,34,50,140,180,70,100;;Registry Medications
RP15 ;;10,14,22,150,65,66,62,160,59,12,34,50,140,180,70,100;;Procedures
RP16 ;;10,14,22,170,110,46,34,140,180,70,100;;Outpatient Utilization
RP17 ;;10,14,22,24,28,84,56,34,50,140,180,70,100;;VERA Reimbursement
RP18 ;;14,22,62,201,47,12,34,50,140,180,70,100;;BMI
RP19 ;;14,22,201,47,12,34,50,140,180,70,100;;MELD
RP20 ;;14,22,62,201,47,12,34,50,140,180,70,100;;Renal Function by Range
