SD53793P ;MNT/BJR - Inactivate VCL/VCP Clinics ; Aug 03, 2021@07:22
 ;;5.3;Scheduling;**793**;Aug 13, 1993;Build 9
 ;
 Q
 ;References to DELETE^XPDPROT in ICR #5567
 ;References to OUT^XPDPROT in ICR #5567
 ;References to OUT^XPDMENU in ICR #1157
 ;References to BMES^XPDUTL in ICR #10141
 ;References to XREF^XQORM in ICR #10140
 ;References to GET1^DIQ in ICR #2056
 ;References to GOTLOCAL^XMXAPIG in ICR #3006
 ;References to ^XMD in ICR #10070
 ;References to ^DIE in ICR #10013
 ;References to file 40.8 in ICR #2295
 ;
 ;Post-init routine for EWL Decommission
 ;
 ;
EN ;Entry point for SD*5.3*793 Post Install routine
 K ^TMP("SD793P",$J)
 D INACLN
 D DISCLN
 D DISWL
 D WLDIS
 D SDWLCHK
 D VCLOPEN
 K ^TMP("SD793P",$J)
 Q
INACLN ;Inactivate VCL/VCP clinics
 N SDCLN,SDCLNS,SDWLCLN,DR,DA,DIE,DIK,SDTXT,SDCLIEN,SDDATE,SDI,SDX1,SDZZNM,SDFLG,SDAPPT,SDNUM,SDINST,SDDIV,SDT
 S SDCLN=0 F  S SDCLN=$O(^SC(SDCLN)) Q:'SDCLN  D
 .S SDFLG=0
 .S SDCLNS=SDCLN_",",SDX1=9999999
 .S SDDATE=$P($$NOW^XLFDT,".")
 .S SDWLCLN=$O(^SDWL(409.32,"B",SDCLN,""))
 .I $$GET1^DIQ(44,SDCLNS,.01)["VCL"!($$GET1^DIQ(44,SDCLNS,.01)["VCP") S SDFLG=1
 .Q:'SDFLG
 .Q:($$GET1^DIQ(44,SDCLNS,8)'="COMMUNITY CARE CONSULT")
 .S SDAPPT=DT F  S SDAPPT=$O(^SC(SDCLN,"S",SDAPPT)) Q:'SDAPPT  D
 ..S SDNUM=0 F  S SDNUM=$O(^SC(SDCLN,"S",SDAPPT,1,SDNUM)) Q:'SDNUM  I $P($G(^SC(SDCLN,"S",SDAPPT,1,SDNUM,0)),U,9)="" S SDFLG=0 D
 ...S ^TMP("SD793P",$J,"OPEN",SDCLN)=$$GET1^DIQ(44,SDCLNS,.01)
 .Q:'SDFLG
 .S SDINST=$$GET1^DIQ(44,SDCLNS,3) I SDINST="" S SDDIV=$$GET1^DIQ(44,SDCLNS,3.5,"I"),SDINST=$$GET1^DIQ(40.8,SDDIV,.07)
 .I SDWLCLN D INACTWL(SDWLCLN),DISP(SDCLN)
 .I $P($G(^SC(SDCLN,"I")),U)'="",$P($G(^SC(SDCLN,"I")),U,2)="" Q
 .S SDZZNM="ZZ"_$E($$GET1^DIQ(44,SDCLNS,.01),1,28)
 .S DR=".01///^S X=SDZZNM;2505///^S X=DT;2506///@",DIE="^SC(",DA=SDCLN D ^DIE
 .F SDI=SDDATE-.0001:0 S SDI=$O(^SC(SDCLN,"ST",SDI)) Q:'SDI!(SDI>SDX1)  S DA=SDI,DA(1)=SDCLN,DIK="^SC(SDCLN,""ST""," D ^DIK
 .F SDI=SDDATE-.0001:0 S SDI=$O(^SC(SDCLN,"T",SDI)) Q:'SDI!(SDI>SDX1)  S DA=SDI,DA(1)=SDCLN,DIK="^SC(SDCLN,""T""," D ^DIK
 .F SDI=SDDATE-.0001:0 S SDI=$O(^SC(SDCLN,"OST",SDI)) Q:'SDI!(SDI>SDX1)  S DA=SDI,DA(1)=SDCLN,DIK="^SC(SDCLN,""OST""," D ^DIK
 .F SDI=0:1:6 S SDT="T"_SDI I $D(^SC(SDCLN,SDT,9999999)) S ^SC(SDCLN,SDT,DT,0)=DT,^SC(SDCLN,SDT,DT,1)=^SC(SDCLN,SDT,9999999,1),^SC(SDCLN,SDT,9999999,1)=""
 .D SDEC^SDNACT(SDCLN,DT)
 .S SDTXT="VCL/VCP Clinic "_$$GET1^DIQ(44,SDCLNS,.01)_" has been inactivated." D BMES^XPDUTL(SDTXT)
 .S ^TMP("SD793P",$J,"CLIN",SDCLN)=$$GET1^DIQ(44,SDCLNS,.01)
 Q
INACTWL(SDWLCLN) ;Inactivate SDWL Clinic
 N SDWLCLS,SDTXT,DR,DA,DIE
 Q:$P(^SDWL(409.32,SDWLCLN,0),U,4)  ;Quit if already inactivated
 S SDWLCLS=SDWLCLN_","
 I $P(^SDWL(409.32,SDWLCLN,0),U,6)="" S DR=".02///^S X=SDINST",DIE="^SDWL(409.32,",DA=SDWLCLN D ^DIE ;File missing institution to avoid Fileman error
 I $P(^SDWL(409.32,SDWLCLN,0),U,6)="" S SDTXT="VCL/VCP Wait List Clinic "_$$GET1^DIQ(409.32,SDWLCLS,.01)_" is missing required Institution and cannot be inactivated." D BMES^XPDUTL(SDTXT) Q
 S DR="3///^S X=DT;4///^S X=.5",DIE="^SDWL(409.32,",DA=SDWLCLN D ^DIE
 S SDTXT="VCL/VCP Wait List Clinic "_$$GET1^DIQ(409.32,SDWLCLS,.01)_" has been inactivated." D BMES^XPDUTL(SDTXT)
 S ^TMP("SD793P",$J,"WLCLIN",SDCLN)=$$GET1^DIQ(409.32,SDWLCLS,.01)
 Q
DISP(SDCLN) ;Disposition VCL/VCP entries on Wait List
 N SDX,SDDSPDT,SDBY,SDDISP,SDCMT,SDSTAT,DA,DIE,DR,SDWLCLS
 S SDX=0 F  S SDX=$O(^SDWL(409.3,"SC",SDCLN,SDX)) Q:'SDX  D
 .S SDWLCLS=SDX_","
 .I $G(^SDWL(409.3,SDX,"DIS")),$$GET1^DIQ(409.3,SDWLCLS,23,"I")="C" Q  ;Quit if entry already dispositioned
 .S SDDSPDT=DT,SDBY=.5,SDDISP="NN",SDCMT="Removed by patch SD*5.3*793 VCL/VCP WL Decom.",SDSTAT="C"
 .S DIE="^SDWL(409.3,",DA=SDX,DR="23///^S X=SDSTAT;25///^S X=SDCMT" D ^DIE
 .S DIE="^SDWL(409.3,",DA=SDX,DR="19///^S X=SDDSPDT;20///^S X=SDBY;21///^S X=SDDISP" D ^DIE
 .S SDTXT="VCL/VCP Wait List entry number "_SDX_" has been dispositioned." D BMES^XPDUTL(SDTXT)
 .S ^TMP("SD793P",$J,"DIS",SDX)=$$GET1^DIQ(409.3,SDWLCLS,.01)
 Q
DISCLN ;Mailman Message of Inactivated Wait List Clinics
 N DIFROM ;when invoking ^XMD in post-init routine of the KIDS build, the calling routine must NEW the DIFROM variable
 N XMSUB,XMTEXT,XMY ;input vars for ^XMD call
 N SDWLN,SDTEXT,SDLN,SDPT,SDTM,SDPOS,SDPOSS,SDTMS,SDTEAM,SDSPEC,SDSPECS,SDSPECTY,SDPOSIT ;local vars
 ;construct mailman msg
 S XMSUB="SD*5.3*793 Post-Install - Inactive Clinics" ;msg subject
 I $$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY("G.SD EWL BACKGROUND UPDATE")="" ;send message to mail group
 I '$$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY($G(DUZ))="" ;msg addressee array
 S XMTEXT="SDTEXT(" ;array containing the text of msg
 S SDLN=1 ;msg line #
 S SDTEXT(SDLN)="SD*5.3*793 Post-Install - Clinics Inactivated."
 S SDLN=SDLN+1,SDTEXT(SDLN)="",SDLN=SDLN+1,SDTEXT(SDLN)="",SDLN=SDLN+1,SDTEXT(SDLN)=""
 S SDTEXT(SDLN)="The Following VCL/VCP Clinics were inactivated by Patch SD*5.3*793.",SDLN=SDLN+1
 S SDTEXT(SDLN)="CLINIC",SDLN=SDLN+1
 S SDTEXT(SDLN)="----------------------------------------------------------",SDLN=SDLN+1
 I '$D(^TMP("SD793P",$J,"CLIN")) S SDTEXT(SDLN)="No VCL/VCP Clinics were inactivated." D ^XMD Q
 S SDCLN="" F  S SDCLN=$O(^TMP("SD793P",$J,"CLIN",SDCLN)) Q:SDCLN=""  D
 .S SDLN=SDLN+1,SDTEXT(SDLN)=^TMP("SD793P",$J,"CLIN",SDCLN)
 S SDLN=SDLN+1,SDTEXT(SDLN)="",SDLN=SDLN+1,SDTEXT(SDLN)="",SDLN=SDLN+1,SDTEXT(SDLN)=""
 D ^XMD
 Q
DISWL ;Mailman Message of Inactivated Wait List Clinics
 N DIFROM ;when invoking ^XMD in post-init routine of the KIDS build, the calling routine must NEW the DIFROM variable
 N XMSUB,XMTEXT,XMY ;input vars for ^XMD call
 N SDWLN,SDTEXT,SDLN,SDPT,SDTM,SDPOS,SDPOSS,SDTMS,SDTEAM,SDSPEC,SDSPECS,SDSPECTY,SDPOSIT ;local vars
 ;construct mailman msg
 S XMSUB="SD*5.3*793 Post-Install - Inactive WL Clinics" ;msg subject
 I $$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY("G.SD EWL BACKGROUND UPDATE")="" ;send message to mail group
 I '$$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY($G(DUZ))="" ;msg addressee array
 S XMTEXT="SDTEXT(" ;array containing the text of msg
 S SDLN=1 ;msg line #
 S SDTEXT(SDLN)="SD*5.3*793 Post-Install - Inactive WL Clinics."
 S SDLN=SDLN+1,SDTEXT(SDLN)="",SDLN=SDLN+1,SDTEXT(SDLN)="",SDLN=SDLN+1,SDTEXT(SDLN)=""
 S SDTEXT(SDLN)="The Following VCL/VCP Wait List Clinics were inactivated by Patch SD*5.3*793.",SDLN=SDLN+1
 S SDLN=SDLN+1,SDTEXT(SDLN)="WAIT LIST CLINIC",SDLN=SDLN+1
 S SDLN=SDLN+1,SDTEXT(SDLN)="----------------------------------------------------------",SDLN=SDLN+1
 I '$D(^TMP("SD793P",$J,"WLCLIN")) S SDTEXT(SDLN)="No Wait List Clinics were inactivated." D ^XMD Q
 S SDTM=0 F  S SDTM=$O(^TMP("SD793P",$J,"WLCLIN",SDTM)) Q:'SDTM  D
 .S SDLN=SDLN+1,SDTEXT(SDLN)=^TMP("SD793P",$J,"WLCLIN",SDTM)
 S SDLN=SDLN+1,SDTEXT(SDLN)="",SDLN=SDLN+1
 D ^XMD
 Q
WLDIS ;Mailman Message of Dispositioned Wait List Entries
 N DIFROM ;when invoking ^XMD in post-init routine of the KIDS build, the calling routine must NEW the DIFROM variable
 N XMSUB,XMTEXT,XMY ;input vars for ^XMD call
 N SDWLN,SDTEXT,SDLN,SDPT,SDTM,SDPOS,SDPOSS,SDTMS,SDTEAM,SDSPEC,SDSPECS,SDSPECTY,SDPOSIT ;local vars
 ;construct mailman msg
 S XMSUB="SD*5.3*793 Post-Install - Dispositioned WL Entries" ;msg subject
 I $$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY("G.SD EWL BACKGROUND UPDATE")="" ;send message to mail group
 I '$$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY($G(DUZ))="" ;msg addressee array
 S XMTEXT="SDTEXT(" ;array containing the text of msg
 S SDLN=1 ;msg line #
 S SDTEXT(SDLN)="SD*5.3*793 Post-Install - Dispositioned WL Entries."
 S SDLN=SDLN+1,SDTEXT(SDLN)="",SDLN=SDLN+1,SDTEXT(SDLN)="",SDLN=SDLN+1,SDTEXT(SDLN)=""
 S SDTEXT(SDLN)="The Following VCL/VCP Wait List entries were dispositioned by Patch SD*5.3*793.",SDLN=SDLN+1
 S SDLN=SDLN+1,SDTEXT(SDLN)="WAIT LIST IEN - PATIENT",SDLN=SDLN+1
 S SDLN=SDLN+1,SDTEXT(SDLN)="----------------------------------------------------------",SDLN=SDLN+1
 I '$D(^TMP("SD793P",$J,"DIS")) S SDTEXT(SDLN)="No Wait List Entries were Dispositioned." D ^XMD Q
 S SDPOS=0 F  S SDPOS=$O(^TMP("SD793P",$J,"DIS",SDPOS)) Q:'SDPOS  D
 .S SDLN=SDLN+1,SDTEXT(SDLN)=SDPOS_" - "_^TMP("SD793P",$J,"DIS",SDPOS)
 S SDLN=SDLN+1,SDTEXT(SDLN)=""
 D ^XMD
 Q
SDWLCHK ;Run through remaining SD Wait List entries and Disposition any linked to inactive clinics
 N SDWL,SDWLCL,SDDSPDT,SDBY,SDDISP,SDCMT,SDSTAT,DIE,DA,DR,SDTXT
 S SDWL=0 F  S SDWL=$O(^SDWL(409.3,SDWL)) Q:'SDWL  I $$GET1^DIQ(409.3,SDWL,23,"I")="O"  D
 .S SDWLCL=$$GET1^DIQ(409.3,SDWL,8,"I") I SDWLCL S SDWLCLN=$$GET1^DIQ(409.32,SDWLCL,.01) I SDWLCLN["VCL"!(SDWLCLN["VCP") D
 ..I $$GET1^DIQ(409.32,SDWLCL,3,"I") D
 ...S SDDSPDT=DT,SDBY=.5,SDDISP="NN",SDCMT="Removed by patch SD*5.3*793 VCL/VCP WL Decom.",SDSTAT="C"
 ...S DIE="^SDWL(409.3,",DA=SDWL,DR="23///^S X=SDSTAT;25///^S X=SDCMT" D ^DIE
 ...S DIE="^SDWL(409.3,",DA=SDWL,DR="19///^S X=SDDSPDT;20///^S X=SDBY;21///^S X=SDDISP" D ^DIE
 ...S SDTXT="VCL/VCP Wait List entry number "_SDWL_" has been dispositioned." D BMES^XPDUTL(SDTXT)
 ...S ^TMP("SD793P",$J,"DIS",SDWL)=$$GET1^DIQ(409.3,SDWL,.01)
 Q
VCLOPEN ;Mailman Message of Clinics with pending future appointments
 N DIFROM ;when invoking ^XMD in post-init routine of the KIDS build, the calling routine must NEW the DIFROM variable
 N XMSUB,XMTEXT,XMY ;input vars for ^XMD call
 N SDWLN,SDTEXT,SDLN,SDPT,SDTM,SDPOS,SDPOSS,SDTMS,SDTEAM,SDSPEC,SDSPECS,SDSPECTY,SDPOSIT ;local vars
 ;construct mailman msg
 S XMSUB="SD*5.3*793 Post-Install - VCL/VCP Clinics w/ Future Appts" ;msg subject
 I $$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY("G.SD EWL BACKGROUND UPDATE")="" ;send message to mail group
 I '$$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY($G(DUZ))="" ;msg addressee array
 S XMTEXT="SDTEXT(" ;array containing the text of msg
 S SDLN=1 ;msg line #
 S SDTEXT(SDLN)="SD*5.3*793 Post-Install - VCL/VCP Clinics w/ Future Appts."
 S SDLN=SDLN+1,SDTEXT(SDLN)="",SDLN=SDLN+1,SDTEXT(SDLN)="",SDLN=SDLN+1,SDTEXT(SDLN)=""
 S SDTEXT(SDLN)="***The Following VCL/VCP Clinics were not inactivated by SD*5.3*793 due to future patient appointments being scheduled.***",SDLN=SDLN+1
 S SDTEXT(SDLN)="",SDLN=SDLN+1
 S SDTEXT(SDLN)="***If this is not a VCL/VCP clinic, no action is needed.***",SDLN=SDLN+1
 S SDTEXT(SDLN)="",SDLN=SDLN+1
 S SDTEXT(SDLN)="***If this is a VCL/VCP clinic, the appointments should be canceled and moved to a non VCL/VCP clinics.***",SDLN=SDLN+1
 S SDTEXT(SDLN)="",SDLN=SDLN+1
 S SDLN=SDLN+1,SDTEXT(SDLN)="VCL/VCP CLINIC",SDLN=SDLN+1
 S SDLN=SDLN+1,SDTEXT(SDLN)="----------------------------------------------------------",SDLN=SDLN+1
 I '$D(^TMP("SD793P",$J,"OPEN")) S SDTEXT(SDLN)="Any active VCL/VCP were inactivated" D ^XMD Q
 S SDPOS=0 F  S SDPOS=$O(^TMP("SD793P",$J,"OPEN",SDPOS)) Q:'SDPOS  D
 .S SDLN=SDLN+1,SDTEXT(SDLN)=^TMP("SD793P",$J,"OPEN",SDPOS)
 S SDLN=SDLN+1,SDTEXT(SDLN)=""
 D ^XMD
 Q
