SD5370PT ;ALB/ABR - Initialize new parameters in Scheduling Param file ; 10/28/96
 ;;5.3;Scheduling;**70**;AUG 13, 1993
 ;
EN ;
 I $G(^SD(404.91,1,"PATCH70")) D BMES^XPDUTL(" ** Cannot re-run this post-install **") Q  ; do not allow re-run of post-install
 D FILEK
 D FILEC
 D HLAPP
 D SDPAR
 D HLM
 Q
FILEC ;clean up of file 409.73
 N DIK,DA
 D BMES^XPDUTL(">>Re-set of file 409.73 - TRANSMITTED OUTPATIENT ENCOUNTER begun")
 N SDN,SDTEN,XPDIDTOT,SDI
 D XREF
 S SDN=0,XPDIDTOT=$P(^SD(409.73,0),U,4),SDTEN=XPDIDTOT\10+1
 F SDI=1:1 S SDN=$O(^SD(409.73,SDN)) Q:'SDN  D  I '(SDI#SDTEN) D UPDATE^XPDID(SDI)
 . I $P($G(^SD(409.73,SDN,0)),U,5)=3 D  Q
 .. ; remove deleted encounters records
 .. S DIK="^SD(409.73,",DA=SDN D ^DIK
 .. Q
 . ; set to transmission not required, delete x-mit refs.
 . S $P(^SD(409.73,SDN,0),U,4)=0,^(1)="^^^^"
 . Q
 Q
 ;
XREF ;  x-ref cleanup
 D MES^XPDUTL(">>cleaning up cross references.")
 K ^SD(409.73,"AACBID"),^("AACLST"),^("AACMID"),^("AACNOACK"),^("AACXMIT")
 Q
 ;
FILEK ; clear out files 409.74,409.75
 N SDN,SDNODE
 D MES^XPDUTL(">> Cleaning out DELETED OUTPATIENT ENCOUNTER file (#409.74)")
 S SDNODE=$P(^SD(409.74,0),U,1,2)_"^0^0"
 K ^SD(409.74)
 S ^SD(409.74,0)=SDNODE ; reset 0-node
 D MES^XPDUTL(">> Cleaning out TRANSMITTED OUTPATIENT ENCOUNTER ERROR file (#409.75)")
 S SDNODE=$P(^SD(409.75,0),U,1,2)_"^0^0"
 K ^SD(409.75)
 S ^SD(409.75,0)=SDNODE ; reset 0-node
 Q
 ;
HLAPP ;  change AMBCARE-DHCP application name to AMBCARE-DH70
 N DIE,DIC,DA,DR,X,Y
 S DIC="^HL(771,",DIC(0)="X",X="AMBCARE-DHCP" D ^DIC
 I Y<0 D BMES^XPDUTL(">>  AMBCARE-DHCP application not found") Q
 S DIE=DIC,DA=+Y,DR=".01///AMBCARE-DH70" D ^DIE
 Q
 ;
SDPAR ;  This sets the SD70 INSTALL DATE to TODAY, and the 
 ;  SD70 LAST DATE to 9/30/96 
 ;  and AMBCARE MESSAGE LINES to 2000
 N SDINS
 S SDINS=$$HTFM^XLFDT($H)
 S ^SD(404.91,1,"PATCH70")=SDINS_U_2960930,$P(^("AMB"),U,8)=2000
 ;
 D BMES^XPDUTL("New Scheduling parameters initialized in file #404.91")
 D MES^XPDUTL("  SD70 INSTALL DATE set to: "_$$FMTE^XLFDT(SDINS))
 D MES^XPDUTL("  SD70 LAST DATE set to: Sept. 30, 1996")
 D MES^XPDUTL("  AMBCARE MESSAGE LINES set to:  2000")
 Q 
 ;
HLM ; change status to '3' (SUCCESSFULLY COMPLETED) to enable purge of messages
 D BMES^XPDUTL(">> Beginning HL7 message file update")
 N DA,DIC,DIE,DR,X,Y,SDAPP,HLI,XPDIDTOT,HLC,HLTEN
 S XPDIDTOT=$P($G(^HL(772,0)),U,4),HLTEN=XPDIDTOT\10+1
 S DIC="^HL(771,",DIC(0)="M",X="AMBCARE-DH" D ^DIC
 I Y<0 D BMES^XPDUTL(">> AMBCARE-DHCP application not found") Q
 S SDAPP=+Y,DIE="^HL(772,",DR="20////3"
 S HLI=0
 F HLC=1:1 S HLI=$O(^HL(772,HLI)) Q:'HLI  D  I '(HLC#HLTEN) D UPDATE^XPDID(HLC)
 . I $P($G(^HL(772,HLI,0)),U,3)'=SDAPP Q  ;only edit AMBCARE entries.
 . S DA=HLI D ^DIE
 D MES^XPDUTL(">> HL7 message file update complete")
 Q
