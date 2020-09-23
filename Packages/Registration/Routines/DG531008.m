DG531008 ;WILM/BDB - DG*5.3*1008 PRE INSTALL VISTA P3 VHAP UPDATES 2 RSD;05/14/20 9:18pm
 ;;5.3;Registration;**1008**;Aug 13, 1993;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;        10104 : UP^XLFSTR
 ;
 Q
 ; This pre-install routine will be used to perform the following task:
 ; Update the NAME (#.01) field of the HEALTH BENEFIT PLAN (#25.11) file.
 ;
PRE ; Entry point for pre-install
 ;
 L +^DGHBP(25.11,0):10 I '$T D BMES^XPDUTL("Health Benefit Plan (#25.11) File is locked by another user.  Please log YOUR IT Services ticket.") Q
 ;
 ; Update NAME (#.01) field of the HEALTH BENEFIT PLAN (#25.11) file.
 D BMES^XPDUTL("Updating the NAME (#.01) field of the Health Benefit Plan (#25.11) File ")
 D UPDATE
 D BMES^XPDUTL("Update of the NAME field of the Health Benefit Plan (#25.11) File has completed. ")
 ;
 L -^DGHBP(25.11,0)
 Q
 ;
UPDATE ;Change Name field of certain Health Benefit Plan (#25.11) File entries
 ;
 N DGN,DGTEXT,DGOLD,DGNEW,DGIEN,DGFND,DGHBPN
 F DGN=1:1 S DGTEXT=$P($T(NAMES+DGN),";;",2) Q:DGTEXT=""  D
 .S DGOLD=$P(DGTEXT,";",1),DGNEW=$P(DGTEXT,";",2)
 .S DGOLD=$$UP^XLFSTR(DGOLD),DGNEW=$$UP^XLFSTR(DGNEW)
 .S DGIEN=0,DGFND=0 F  S DGIEN=$O(^DGHBP(25.11,DGIEN)) D:+DGIEN=0 DGERR Q:+DGIEN=0  D  Q:DGFND=1
 ..;S DGHBPN=$P(^DGHBP(25.11,DGIEN,0),U,1) Q:DGHBPN'=DGOLD
 ..S DGHBPN=$$GET1^DIQ(25.11,DGIEN,.01) Q:DGHBPN'=DGOLD  ;bdb 06162020 add fm api
 ..S DGFND=1
 ..S DR=".01///"_DGNEW,DIE="^DGHBP(25.11,",DA=DGIEN D ^DIE K DIE,DR,DA
 ..D BMES^XPDUTL("PLAN NAME:")
 ..D MES^XPDUTL(DGOLD)
 ..D MES^XPDUTL("RENAMED TO:")
 ..D MES^XPDUTL(DGNEW)
 Q
DGERR ;
 D BMES^XPDUTL("    *** The NAME field for the Health Benefit Plan(#25.11) file")
 D MES^XPDUTL("    for this Plan:"_DGNEW)
 D MES^XPDUTL("    did not need to be updated.")
 D MES^XPDUTL("    The patch was previously installed. ***")
 Q
NAMES ;format:  ;;oldname;newname
 ;;ACTIVE DUTY AND SHARING AGREEMENTS;ACTIVE DUTY AND TRICARE SHARING AGREEMENT
 ;;
