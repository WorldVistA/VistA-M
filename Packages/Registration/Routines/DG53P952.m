DG53P952 ;SLC/SS - POST-INIT ;02/25/2019
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;DG*5.3*952 post - install entry point
 ;
 ;ICRs Used:
 ;DBIA #10141 XPDUTL
 ;DBIA #2053 Data Base Server API: Editing Utilities
EN ;
 D REIDX($$PATCH^XPDUTL("DG*5.3*952")),ADDELIG,POSADD,ADD38P6,POSTOTH
 Q
 ;
REIDX(REINST) ; rebuild AEXPMH index on field 2/.5501 and remove blank ^DPT(DFN,.55), if necessary
 N CNT,DFN,DIK
 D BMES^XPDUTL("Checking if we need to rebuild AEXPMH index in PATIENT file (#2)...")
 I 'REINST D MES^XPDUTL("This is the first installation of the patch - skipping.") Q
 D MES^XPDUTL("This is a re-installation of the patch - proceeding.")
 D BMES^XPDUTL("Cleaning up field 2/.5501...")
 ; remove unneeded ^DPT(DFN,.55) global nodes
 S (CNT,DFN)=0 F  S DFN=+$O(^DPT(DFN)) Q:'DFN  D
 .S CNT=CNT+1 I '$D(ZTQUEUED),'(CNT#100) W "."
 .; remove .55 node if it's blank and there's no entry in file 33 for this patient
 .I $G(^DPT(DFN,.55))="",+$O(^DGOTH(33,"B",DFN,""))'>0 K ^DPT(DFN,.55)
 .Q
 D MES^XPDUTL("Done.")
 ; rebuild AEXPMH index in file 2
 D BMES^XPDUTL("Rebuilding AEXPMH index in PATIENT file")
 S DIK="^DPT(",DIK(1)=".5501^AEXPMH"
 D ENALL2^DIK,ENALL^DIK
 D MES^XPDUTL("Done.")
 Q
 ;
ADDELIG ;Adds the EXPANDED MH CARE NON-ENROLLEE eligibility to the ELIGIBILITY CODE file (#8)
 N DA,DIK
 D BMES^XPDUTL("Checking for existence of the EXPANDED MH CARE NON-ENROLLEE eligibility in the ELIGIBILITY CODE file (#8)")
 S DA=$O(^DIC(8,"B","EXPANDED MH CARE NON-ENROLLEE",0)) I DA D  Q
 .D MES^XPDUTL("EXPANDED MH CARE NON-ENROLLEE eligibility already exists - skipping.")
 ;
 ;Add the new eligibility to the file #8
 N DGVALS,DGIEN
 D BMES^XPDUTL("Adding EXPANDED MH CARE NON-ENROLLEE eligibility entry to file #8")
 S DGVALS(.01)="EXPANDED MH CARE NON-ENROLLEE"
 S DGVALS(1)="RED"
 S DGVALS(2)="MHNV"
 S DGVALS(3)=11
 S DGVALS(4)="N"
 S DGVALS(5)="EXPANDED MH NON-ENROLLEE"
 S DGVALS(8)="EXPANDED MH CARE NON-ENROLLEE"
 S DGVALS(9)="VA STANDARD"
 S DGVALS(11)="VA"
 S DGIEN=$$INSREC(8,"",.DGVALS,,"E",,,1)
 I DGIEN<0 D
 . D BMES^XPDUTL("Error:")
 . D BMES^XPDUTL("  The EXPANDED MH CARE NON-ENROLLEE eligibility was not added to the file #8: ")
 . D MES^XPDUTL("  "_$P(DGIEN,U,2))
 ;
 I $O(^DIC(8,"B","EXPANDED MH CARE NON-ENROLLEE",0))>0 D  Q
 .D BMES^XPDUTL("The EXPANDED MH CARE NON-ENROLLEE eligibility has been added to the file #8 successfully.")
 Q
 ;
 ;
 ;/**
 ;Creates a new entry (or node for multiple with .01 field)
 ;
 ;DGFILE - file/subfile number
 ;DGIEN - ien of the parent file entry in which the new subfile entry will be inserted
 ;DGZFDA - array with values for the fields
 ; format for DGZFDA:
 ; DGZFDA(.01)=value for #.01 field
 ; DGZFDA(3)=value for #3 field
 ;DGRECNO -(optional) specify IEN if you want specific value
 ; Note: "" then the system will assign the entry number itself.
 ;DGFLGS - FLAGS parameter for UPDATE^DIE
 ;DGLCKGL - fully specified global reference to lock
 ;DGLCKTM - time out for LOCK, if LOCKTIME=0 then the function will not lock the file 
 ;DGNEWRE - optional, flag = if 1 then allow to create a new top level record 
 ;  
 ;output :
 ; positive number - record # created
 ; <=0 - failure^error message
 ;
 ;Example:
 ;S DGVALS(.01)="OTHD" W $$INSREC^DG53952(8.1,"",.DGVALS,,,,,1)
INSREC(DGFILE,DGIEN,DGZFDA,DGRECNO,DGFLGS,DGLCKGL,DGLCKTM,DGNEWRE) ;*/
 I ('$G(DGFILE)) Q "0^Invalid parameter"
 I +$G(DGNEWRE)=0 I $G(DGRECNO)>0,'$G(DGIEN) Q "0^Invalid parameter"
 N DGSSI,DGIENS,DGERR,DGFDA,DIERR
 N DGLOCK S DGLOCK=0
 I '$G(DGRECNO) N DGRECNO S DGRECNO=$G(DGRECNO)
 I DGIEN'="" S DGIENS="+1,"_DGIEN_"," I $L(DGRECNO)>0 S DGSSI(1)=+DGRECNO
 I DGIEN="" S DGIENS="+1," I $L(DGRECNO)>0 S DGSSI(1)=+DGRECNO
 M DGFDA(DGFILE,DGIENS)=DGZFDA
 I $L($G(DGLCKGL)) L +@DGLCKGL:(+$G(DGLCKTM)) S DGLOCK=$T I 'DGLOCK Q -2  ;lock failure
 D UPDATE^DIE($G(DGFLGS),"DGFDA","DGSSI","DGERR")
 I DGLOCK L -@DGLCKGL
 I $D(DGERR) Q "-1^"_$G(DGERR("DIERR",1,"TEXT",1),"Update Error")
 Q +$G(DGSSI(1))
 ;
ADD38P6 ;Add an entry to file #38.6 (INCONSISTENT DATA ELEMENTs) in DINUM positions 89 and 90
 ;for two new inconsistence checks on Primary Eligibility and Patient Type
 N DA,DGX,DIC,DINUM,DTOUT,DUOUT,X,Y
 K DO
 D BMES^XPDUTL("Checking for existence of the PAT TYPE/OTH ELIG INCONSISTENT consistency check..")
 S DGX=$D(^DGIN(38.6,"B","PAT TYPE/OTH ELIG INCONSISTENT")) D:DGX MES^XPDUTL("Consistency check for PAT TYPE/OTH ELIG INCONSISTENT already exists - skipping.")
 D:'DGX
 . D MES^XPDUTL("Adding inconsistency check PAT TYPE/OTH ELIG INCONSISTENT to")
 . D MES^XPDUTL("file #38.6 (INCONSISTENT DATA ELEMENTS) at DINUM position 89")
 . S DIC="^DGIN(38.6,",DIC(0)="FZ",X="PAT TYPE/OTH ELIG INCONSISTENT",DINUM=89
 . S DIC("DR")="2///PATIENT TYPE IS INCOMPATIBLE WITH PRIMARY ELIGIBILITY;3///0;4///1;5///0;6///0;"
 . S DIC("DR")=DIC("DR")_"50///Patient Type is incompatible with Primary Eligibility of Expanded MH Care Non-Enrollee"
 . D FILE^DICN
 . D MES^XPDUTL("...added.")
 Q
 ;
POSADD ;Add EXPANDED MH CARE NON-ENROLLEE eligibility to entries in file #21 (Period Of Service)
 ;                                                                            sub-file (#21.01)
 ;
 N DGPHEC    ;EXPANDED MH CARE NON-ENROLLEE - Eligibility Code actual name
 N DGPHIEN   ;EXPANDED MH CARE NON-ENROLLEE - IEN in file #8
 N DGPOSIEN  ;Period of Service IEN in file #21
 N DGFDA     ;FDA for DBS call
 N DGERR     ;Error array for DBS call
 ;
 D BMES^XPDUTL("**Updating entries in file #21, with EXPANDED MH CARE NON-ENROLLEE.")
 S DGPHEC="EXPANDED MH CARE NON-ENROLLEE",DGPHIEN=$$FIND1^DIC(8,"","MX",DGPHEC,"","","DGERR")
 I 'DGPHIEN!$D(DGERR) D  Q
 .D BMES^XPDUTL("*EXPANDED MH CARE NON-ENROLLEE not found in file #8.")
 .D BMES^XPDUTL("** Unable to update PERIOD OF SERVICE file (#21).")
 .Q
 ;
 S DGPOSIEN=$$FIND1^DIC(21,"","MX","OTHER NON-VETERANS","","","DGERR") I 'DGPOSIEN!$D(DGERR) Q
 I $$FIND1^DIC(21.01,","_DGPOSIEN_",","MX",DGPHIEN,"","","DGERR") D  Q
 .D BMES^XPDUTL("*EXPANDED MH CARE NON-ENROLLEE already exists in OTHER NON-VETERANS entry.")
 .Q
 S DGFDA(21.01,"+1,"_DGPOSIEN_",",.01)=DGPHEC
 D UPDATE^DIE("E","DGFDA","","DGERR")
 I $D(DGERR) D BMES^XPDUTL("** Unable to update PERIOD OF SERVICE file (#21).") Q
 D BMES^XPDUTL("*EXPANDED MH CARE NON-ENROLLEE successfully added to file #21.")
 Q
 ;
POSTOTH  ;  Run a background job to print possible OTH patients 4 days after install at 10:00 PM
 N RUNDT,XMDUZ,XMSUB,XMY,DIFROM
 D BMES^XPDUTL("**Attempting to run the POST Install for 'Potential OTH patients'")
 S ZTDESC="Potential OTH Patients Report "_$$FMTE^XLFDT(DT),ZTRTN="OTHRPT^DG53P952"
 S RUNDT=$$FMADD^XLFDT(DT,+4)_".2200"     ;Queue to today +4 at 2200
 S ZTDTH=$$FMTH^XLFDT(RUNDT)
 S (XMDUZ,XMSUB)="Potential OTH Pts since Executive order 13822",XMDUZ=".5",XMY(DUZ)="",XMY(XMDUZ)=""
 S XMY("G.DGEN ELIGIBILITY ALERT")="",XMY("G.DGEN ELIGIBILITY ALERT",0)="IN"
 S ZTSAVE("ZTREQ")="@",ZTIO=""
 D ^%ZTLOAD
 I $G(ZTSK) S X="**'Potential OTH Pts' Report - Queued to Task #"_$G(ZTSK) D BMES^XPDUTL(X)
 Q
OTHRPT ;
 N DIC,X,Y,SDPCF,IOP,ECXPCF,ECX,REP,DIFROM,POP,PMESS
 S XMSUB="Potential OTH Pts since Executive order 13822"
 S PMESS=$O(^%ZIS(1,"B","P-MESSAGE")) I $E(PMESS,1,9)'="P-MESSAGE" D POSTERR Q  ;Stop if p-message device doesn't exist
 S Y=$O(^%ZIS(1,"B",PMESS,""))
 I 'Y D POSTERR  Q                        ;Stop if p-message device doesn't exist
 S IOP="`"_+Y                             ;Set IOP to p-message device
 D ^%ZIS
 I POP G POSTERR                          ;Stop if there is a problem with p-message device
 D ENQUE^DGOTHRP6
 K XMY
 D ^%ZISC
 Q
 ;
POSTERR ;
 N MESS
 S MESS(1)="------------------------------------------------------------------------"
 S MESS(2)="***A queued Post Install report for 'Potential OTH Pts since Executive"
 S MESS(3)=" Order #13822', failed. Please run it manually - 'D EN^DGOTHRP6', Que"
 S MESS(4)="  the output for Today+4 (off normal hours), use device 'P-MESSAGE',"
 S MESS(5)="            send to the mail group 'G.DGEN ELIGIBILITY ALERT'"
 S MESS(6)="------------------------------------------------------------------------"
 D BMES^XPDUTL(.MESS)
 Q
