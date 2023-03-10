DG531048P ;ALB/JAM - DG*5.3*1048 PRE-INSTALL ROUTINE FOR PATCH DG*5.3*1048;04 March 2021 9:00 AM
 ;;5.3;Registration;**1048**;Aug 13, 1993;Build 7
 ;
 QUIT
 ;--------------------------------------------------------------------------
 ;Patch DG*5.3*1048: Pre-Install routine.  Tag INCLUDE only used for Screen Logic
 ;--------------------------------------------------------------------------
 ;
 ; ICRs:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;
PRE ; Pre-install for patch DG*5.3*1048
 ;Add OTHER FEDERAL AGENCY eligibility to entries in file #21 (Period Of Service)
 ; sub-file (#21.01)
 ;
 N DGPHEC    ;OTHER FEDERAL AGENCY - Eligibility Code actual name
 N DGPHIEN   ;OTHER FEDERAL AGENCY - IEN in file #8
 N DGPOSIEN  ;Period of Service IEN in file #21
 N DGFDA     ;FDA for DBS call
 N DGERR     ;Error array for DBS call
 ;
 D BMES^XPDUTL("**Updating the OTHER NON-VETERANS entry in the PERIOD OF SERVICE FILE (#21).")
 S DGPHEC="OTHER FEDERAL AGENCY",DGPHIEN=$$FIND1^DIC(8,"","X",DGPHEC,"","","DGERR")
 I 'DGPHIEN!$D(DGERR) D  Q
 .D BMES^XPDUTL(" >> OTHER FEDERAL AGENCY not found in ELIGIBILITY CODE file (#8).")
 .D MES^XPDUTL(" >> Unable to update PERIOD OF SERVICE file (#21).")
 ;
 S DGPOSIEN=$$FIND1^DIC(21,"","X","OTHER NON-VETERANS","","","DGERR") I 'DGPOSIEN!$D(DGERR) Q
 I $$FIND1^DIC(21.01,","_DGPOSIEN_",","X",DGPHIEN,"","","DGERR") D  Q
 .D BMES^XPDUTL(" >> OTHER FEDERAL AGENCY already exists in OTHER NON-VETERANS entry.")
 .D MES^XPDUTL(" >> No update required.")
 S DGFDA(21.01,"+1,"_DGPOSIEN_",",.01)=DGPHEC
 D UPDATE^DIE("E","DGFDA","","DGERR")
 I $D(DGERR) D BMES^XPDUTL(" >> Unable to update PERIOD OF SERVICE file (#21).") Q
 D BMES^XPDUTL(" >> Successfully added OTHER FEDERAL AGENCY as ELIGIBILITY for OTHER NON-VETERANS. ")
 Q
 ;
INCLUDE(DGY) ; This tag is called by the Screen Logic of the build to determine which entries should be included in the build
 ;             for the OTHER FEDERAL AGENCY file (#35).
 ; Input:  DGY - the entry number of the entry in file #35
 ; Output: TRUE if the entry should be included in the build
 ;
 I $P($G(^DIC(35,+DGY,0)),U,1)="DEPT HEALTH AND HUMAN SERVICES" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="DEPARTMENT OF INTERIOR" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="DEPARTMENT OF JUSTICE" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="DEPARTMENT OF AGRICULTURE" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="DEPARTMENT OF TRANSPORTATION" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="NAT ARCHIVES AND RECORDS ADMIN" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="SMALL BUSINESS ADMINISTRATION" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="ENVIRONMENTAL PROTECTION AGCY" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="GENERAL SERVICES ADMIN" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="OFFICE OF PERSONNEL MANAGEMENT" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="US FEDERAL JUDICIARY" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="VA - STATE VETERANS HOME" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="HHS - FOOD AND DRUG ADMIN" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="HHS - OFC OF THE INSP GENERAL" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="HHS - CHILDREN AND FAMILIES" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="US DC SOUTHERN DISTRICT OF NY" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="DOJ - DRUG ENFORCEMENT ADMIN" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="DC FEDERAL CIRCUIT COURT" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="DOA - FOREST SERVICE" Q 1
 I $P($G(^DIC(35,+DGY,0)),U,1)="OTHER" Q 1
 Q 0
