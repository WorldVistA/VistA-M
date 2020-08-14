DGY994PO ; ALB/CNF/CMF - UTILITY TO CREATE CERNER LOGICAL LINK ; 10-03-2019
 ;;5.3;Registration;**1005**;Aug 13, 1993;Build 57
 ;
ENV ; Entry point for environment check
    S XPDABORT=""
    D PROGCHK(.XPDABORT) I XPDABORT=2 Q
    D CRNRCHK(.XPDABORT) I XPDABORT=2 Q
    I XPDABORT="" K XPDABORT
    Q
 ;
PRE ; Entry point for pre install
 Q
PROGCHK(XPDABORT) ;checks for necessary programmer variables
    I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
    . D BMES^XPDUTL("******")
    . D MES^XPDUTL("Your programming variables are not set up properly.")
    . D MES^XPDUTL("Installation aborted.")
    . D MES^XPDUTL("******")
    . S XPDABORT=2
    Q
    ;
CRNRCHK(XPDABORT) ;checks CERNER entry in Institution file.  Post init will fail if missing.
    I $$FIND1^DIC(4,"","MX","CERNER")=0 DO
    . D BMES^XPDUTL("******")
    . D MES^XPDUTL("There is no CERNER entry in the Institution file (#4).")
    . D MES^XPDUTL("This entry is necessary for the Logical Link file (#870) update in this patch.")
    . D MES^XPDUTL("Contact Customer Service for instructions to install this entry then try again.")
    . D MES^XPDUTL("Installation aborted.")
    . D MES^XPDUTL("******")
    . S XPDABORT=2
    Q
    ;
POST ; Entry point post install
 ;set up logical link
 N DGX,DGABRT,DGPORT,DGLNK,DGOLD,DGNEW,DGPCE,DGNAME
 ;
 S DGABRT=0  ;Abort Flag:  1=Abort Setup, 0=Continue Setup
 F DGX="BUG","CHK","PORT","870","FIN" D @DGX  Q:DGABRT
 D:DGABRT ABRT
 ;
 Q
 ;
BUG ; Before this patch, a category II flag could be inactivated without
    ; inactivating patient flag assignments for the inactive category II flag.
    ; That bug is fixed and this code cleans up the patient flag assignments.
    ;
 D BMES^XPDUTL("Inactivate all active patient record flag assignment records in the")
 D MES^XPDUTL("PRF ASSIGNMENT (#26.13) file when records are associated with an")
 D MES^XPDUTL("inactive category II patient flag.")
 ;
 ; Loop through the 0 records in DGPF(26.11
 ; Because of previous bug, index "ASTAT" is not correct.
 ; Inactive entries may appear as active in "ASTAT" index.
 ;
 N FLG,FLGNM,MSG,X
 S FLG=0
 F  S FLG=$O(^DGPF(26.11,FLG)) Q:'FLG  D
 . S X=$G(^DGPF(26.11,FLG,0)) I '$L(X) Q      ;record doesn't exist
 . I $P(X,"^",2) Q                            ;record is active
 . ;
 . S FLGNM=$P(X,"^",1)
 . S MSG="Second inactivation, see patch DG*5.3*994"
 . D DEACT^DGPFXCRN(FLG,FLGNM,MSG)            ;inactivate a second time for audit purposes
 . S DA=FLG,DIK="^DGPF(26.11," D IX^DIK       ;correct index for this entry
 . ;
 . ; Patient flag assignments are not inactivated as part of set logic because patient flag
 . ; status isn't changing.  Flag status was set to inactive and code is re-setting to inactive.
 . ; Call DGPFDD to inactivate patient flag assignments.
 . D INACT^DGPFDD(FLG,0,26.11,DUZ)
 ;
 D MES^XPDUTL("Patient Record Flag entries cleaned up.")
 Q
 ;
CHK ; Check for existing logical link
 N X,Y,Z,J
 S DGLNK="VACRNR"
 S X=$$FIND1^DIC(870,"","MX",DGLNK) I X>0 D
 . D BMES^XPDUTL("A Logical Link for "_DGLNK_" already exists and will be overwritten.")
 ;
 S DGPCE=".01,.02,.08,4.5,2,3,21,200.021,200.05,200.08,400.02,400.03,400.04,400.07"
 F J=1:1:14 S $P(DGOLD,",",J)=$$GET1^DIQ(870,X,$P(DGPCE,",",J))
 ;    
 Q
 ;
PORT ; KIDS has prompted user for port number, set port variable DGPORT
 S Y=$G(XPDQUES("POSPORT"))
 I (Y="")!(Y="^") S DGABRT=1 Q
 ;
 I Y'?1N.N S DGABRT=1 Q
 S DGPORT=$G(Y)
 Q
 ;
870 ; Create HL7 Logical Link
 N ERR,FDA,X,J
 ;
 ; Set up the logical link
 K FDA
 S FDA(1,870,"?+1,",.01)=DGLNK                               ;Node
 S:$P($G(DGOLD),",",2)'="CERNER" FDA(1,870,"?+1,",.02)="CERNER"   ;Institution
 S FDA(1,870,"?+1,",.08)="hc-vdif-ent.domain.ext"                ;DNS Domain
 S FDA(1,870,"?+1,",4.5)=1                                   ;Autostart
 S FDA(1,870,"?+1,",2)="TCP"                                 ;LLP Type
 S FDA(1,870,"?+1,",3)="NC"                                  ;Device Type
 S FDA(1,870,"?+1,",21)=10                                   ;Queue Size
 S FDA(1,870,"?+1,",200.021)="R"                             ;Exceed Re-transmit Action
 S FDA(1,870,"?+1,",200.05)=20                               ;ACK timeout
 S FDA(1,870,"?+1,",200.08)=2.3                              ;Protocol ID Version
 S FDA(1,870,"?+1,",400.02)=DGPORT                           ;TCP/IP Port
 S FDA(1,870,"?+1,",400.03)="C"                              ;TCP/IP Service Type
 S FDA(1,870,"?+1,",400.04)="N"                              ;Persistent
 S FDA(1,870,"?+1,",400.07)="Y"                              ;Say HELO
 ;
 D UPDATE^DIE("E","FDA(1)","","ERR")
 I $D(ERR) D  Q
 . D BMES^XPDUTL("Unable to file a logical Link for "_DGLNK_".")
 . S DGABRT=1
 ;
 ; If there were previous values for the logical link, document what was changed.
 I '$L($G(DGOLD)) Q    ;Quit if DGOLD does not have a value
 ;
 S DGNAME="Node,Institution,DNS Domain,Autostart,LLP Type,Device Type,Queue Size,"
 S DGNAME=DGNAME_"Exceed Re-transmit Action,ACK timeout,Protocol ID Version,"
 S DGNAME=DGNAME_"TCP/IP Port,TCP/IP Service Type,Persistent,Say HELO"
 S DGNEW="VACRNR,CERNER,vaauscluhshhl7rtr201.aac.domain.ext,1,TCP,NC,10,R,20,2.3,"
 S DGNEW=DGNEW_DGPORT_",C,N,Y"
 ;
 S X="Summary of changes to logical link "_DGLNK D BMES^XPDUTL(X)
 F J=1:1:14 I '($P(DGOLD,",",J)=$P(DGNEW,",",J)) D
 . S X="  Value changed for field:  "_$P(DGNAME,",",J) D MES^XPDUTL(X)
 . S X="     OLD:  "_$P(DGOLD,",",J) D MES^XPDUTL(X)
 . S X="     NEW:  "_$P(DGNEW,",",J) D MES^XPDUTL(X)
 Q
 ;
FIN ;
 D BMES^XPDUTL("Logical Link Setup Complete")
 Q
 ;
ABRT ;
 D BMES^XPDUTL("Logical Link Setup Aborted")
 Q
 ;
