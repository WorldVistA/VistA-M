DG53985P ;ALB/HM - DG*5.3*985 POST INSTALL TO UPDATE HEALTH BENEFIT PLAN ;10/09/19 9:18pm
 ;;5.3;Registration;**985**;Aug 13, 1993;Build 15
 ;
 Q
 ;A post-install routine will be used to perform the following tasks:
 ; Update the LONG DESCRIPTION (#.04) field of the "Veteran - Full Medical Benefits Treatment & Rx Copay Exempt" record in the HEALTH BENEFIT PLAN (#25.11) file.
 ;
POST ; Entry point for post-install
 ;
 L +^DGHBP(25.11,0):10 I '$T D BMES^XPDUTL("     Health Benefit Plan (#25.11) File is locked by another user.  Please log YOUR IT Services ticket.") Q
 ;
 ; Update hte LONG DESCRIPTION (#.04) field of the "Veteran - Full Medical Benefits Treatment & Rx Copay Exempt" record in the HEALTH BENEFIT PLAN (#25.11) file.
 D BMES^XPDUTL("Updating the LONG DESCRIPTION (#.04) of the Veteran - Full Medical ")
 D BMES^XPDUTL("Benefits Treatment & Rx Copay Exempt plan.")
 D FIXPLN
 D BMES^XPDUTL("Finished updating the LONG DESCRIPTION (#.04) of the Veteran - Full Medical ")
 D BMES^XPDUTL("Benefits Treatment & Rx Copay Exempt plan.")
 ;
 L -^DGHBP(25.11,0)
 Q
 ;
FIXPLN ;Change Long description of Health Benefit Plan Veteran - Full Medical Benefits Treatment & Rx Copay Exempt
 ;
 N DGIEN,DGNAME,DGLD,DGFIELDS,DGPFMS1,DGERR
 S DGNAME="VETERAN - FULL MEDICAL BENEFITS TREATMENT & RX COPAY EXEMPT"
 S DGIEN=""
 S DGERR=""
 S DGIEN=$O(^DGHBP(25.11,"B",DGNAME,0))
 I 'DGIEN D BMES^XPDUTL("    "_DGIEN_" entry is not found to fix Long Description field.  ") Q
 S DGFIELDS("LD",1)="All enrolled Veterans have a comprehensive medical benefits package, which VA "
 S DGFIELDS("LD",2)="administers through an annual patient enrollment system. Veterans who meet "
 S DGFIELDS("LD",3)="Veteran status for VA healthcare benefits and are not subject to copayment"
 S DGFIELDS("LD",4)="for their inpatient, outpatient services nor medications."
 S DGFIELDS("LD",5)=""
 S DGFIELDS("LD",6)="Veterans are exempt from copayments for inpatient, outpatient services and "
 S DGFIELDS("LD",7)="medications related to their Service Connected (SC) related disability and "
 S DGFIELDS("LD",8)="special authority factor(s) - Agent Orange Exposure (AO), Southwest Asia "
 S DGFIELDS("LD",9)="Conditions (SWA), Ionizing Radiation (IR), Nose Throat Radium (NTR), Shipboard "
 S DGFIELDS("LD",10)="Hazard and Defense (SHAD), Combat Veteran (CV), Camp Lejeune (CL), Military "
 S DGFIELDS("LD",11)="Sexual Treatment (MST)."
 S DGFIELDS("LD",12)=""
 S DGFIELDS("LD",13)="Veterans assigned this VMBP meet one of the following conditions:"
 S DGFIELDS("LD",14)=""
 S DGFIELDS("LD",15)="o Determined to be 50% or greater SC"
 S DGFIELDS("LD",16)="o Determined to be 10% to 40% Compensable SC*"
 S DGFIELDS("LD",17)="o Received a Medal of Honor (MOH)"
 S DGFIELDS("LD",18)="o Received a Purple Heart (PH)**"
 S DGFIELDS("LD",19)="o Has been a Prisoner of War (POW)"
 S DGFIELDS("LD",20)="o Determined to be Catastrophically Disabled (CD)"
 S DGFIELDS("LD",21)="o Determined to be Unemployable due to SC conditions"
 S DGFIELDS("LD",22)="o In receipt of Aid & Attendance (A&A)"
 S DGFIELDS("LD",23)="o In receipt of Housebound (HB)"
 S DGFIELDS("LD",24)="o In receipt of a VA Pension"
 S DGFIELDS("LD",25)="o Discharge Due to Disability**"
 S DGFIELDS("LD",26)="o Military Disability Retirement**"
 S DGFIELDS("LD",27)="o Receive Medicaid**"
 S DGFIELDS("LD",28)="o Non-Service Connected (NSC)***"
 S DGFIELDS("LD",29)="o 0% SC non-compensable ****"
 S DGFIELDS("LD",30)=""
 S DGFIELDS("LD",31)="*They are exempt from copayment for medications related to their SC rated "
 S DGFIELDS("LD",32)="condition, but they must complete a Pharmacy Copay Exemption Test and "
 S DGFIELDS("LD",33)="the outcome is Rx Copay Exempt to be exempt from NSC medication copays."
 S DGFIELDS("LD",34)="**They must complete a Pharmacy Copay Exemption Test and the outcome "
 S DGFIELDS("LD",35)="is Rx Copay Exempt to be exempt from NSC medication copays."
 S DGFIELDS("LD",36)="***NSC Veterans who are subject to Means Testing; the outcome of the "
 S DGFIELDS("LD",37)="Means Test is MT Copay Exempt and Rx Exemption status is Exempt."
 S DGFIELDS("LD",38)="****SC Non-Compensable Veterans who are subject to Means Testing; the"
 S DGFIELDS("LD",39)="outcome of the Means Test is MT Copay Exempt and Rx Exemption status is "
 S DGFIELDS("LD",40)="Exempt."
 M DGLD=DGFIELDS("LD")
 D WP^DIE(25.11,DGIEN_",",.04,"","DGLD","DGPFMS1") ; LONG DESCRIPTION
 I $D(DGPFMS1) S DGERR=$G(DGPFMS1("DIERR",1,"TEXT",1))
 I DGERR'="" D
 . D BMES^XPDUTL("    *** An Error occurred during updating long description of ")
 . D MES^XPDUTL("    Veteran - Full Medical Benefits Treatment & Rx Copay Exempt")
 . D MES^XPDUTL("     *** "_DGERR_" ***")
 . D MES^XPDUTL("     Please log YOUR IT Services ticket.")
 I DGERR="" D
 . D BMES^XPDUTL("    LONG DESCRIPTION (#.04) field of plan Veteran - Full ")
 . D MES^XPDUTL("    Medical Benefits Treatment & Rx Copay Exempt updated.")
 Q
 ;
