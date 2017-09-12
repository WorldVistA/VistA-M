SD53P297 ;ALB/JDS - Pre/Post-Install;15-Nov-2001 ; 8/8/05 2:01pm
 ;;5.3;Scheduling;**297**;Aug 13, 1993
 ;
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items.
 ;
 N I
 F I=0:0 S I=$O(^SD(403.46,I)) Q:'I   I $P($G(^(I,0)),U,3)]"" D
 .S DIE="^SD(403.46,",DR=".03///@",DA=I D ^DIE
 F SCI=0:0 S SCI=$O(^SD(403.46,SCI)) Q:'SCI  D
 .F J=0:0 S J=$O(^SD(403.46,SCI,2,J)) Q:'J  S DIK="^SD(403.46,"_SCI_",2,",DA=J,DA(1)=SCI D ^DIK
 Q
 ;
 ;
POST ;Main entry point for Post-init items.
 ;
 D MES^XPDUTL("Updating Client/Server entries")
 N ENTRY,E608,LASTD
 K DGLEFDA
 I '$D(^SCTM(404.46,"B","1.3.0.0")) D
 .K DO S DIC(0)="LM",DIC("DR")=".02////1;.03////"_DT,DIC="^SCTM(404.46,",X="1.3.0.0" D FILE^DICN
 I '$D(^SCTM(404.45,"B","SD*5.3*297")) D
 .S ENTRY=$O(^SCTM(404.46,"B","1.3.0.0",0))
 .S DIC("DR")=".02////"_(+ENTRY)_";.03////"_DT_";.04////1",DIC(0)="LM"
 .K DO S X="SD*5.3*297",DIC="^SCTM(404.45," D FILE^DICN
 ;move 608M errors to retransmit and disappear
 D MES^XPDUTL("Setting 608M PCMM errors for correction")
 S E608=$O(^SCPT(404.472,"B","608M",0))
 F I=0:0 S I=$O(^SCPT(404.471,"ASTAT","RJ",I)) Q:'I  D
 .I $D(^SCPT(404.571,I,"ERR","B",+E608)) S DA=I,DIE="^SCPT(404.471,",DR=".04////M" D ^DIE
 D MES^XPDUTL("Moving Team Position Clinic to multiple")
 ;move associated clinics to multiple
 F I=0:0 S I=$O(^SCTM(404.57,I)) Q:'I  S ZERO=$G(^(I,0)) I $D(^SCTM(404.51,+$P(ZERO,U,2),0)) I $P(ZERO,U,9) D
 .S X=$P(ZERO,U,9) I $D(^SCTM(404.57,I,5,+X)) Q
 .I '$D(^SCTM(404.57,I,5,0)) S ^(0)="^404.575PA^^"
 .S DIC="^SCTM(404.57,"_I_",5,",DIC(0)="LM",DA(1)=I D ^DICN
 ;If before May set up as alpha site
 ;Set up provider inactivation date 6 months away
 D MES^XPDUTL("Setting up 6 month  for provider inactivations")
 S X1=DT,X2=180 D C^%DTC S X1=$E(X,1,5)_28
 F  S LASTD=X1,X2=1 D C^%DTC S X1=X Q:($E(LASTD,1,5)'=$E(X,1,5))
 I '$P($G(^SCTM(404.44,1,1)),U,9) S DIE="^SCTM(404.44,",DA=1,DR="19////"_LASTD D ^DIE
 I DT<3051215 D
 .S DIE="^SCTM(404.44,",DA=1,DR="18////3051215" D ^DIE
 ;set default auto inactivate team on
 S DIE="^SCTM(404.44,",DA=1,DR="20///YES" D ^DIE
 ;Set default notification to No
 F I=0:0 S I=$O(^SCTM(404.57,I)) Q:'I  S ZERO=$G(^(I,2)) I $P(ZERO,U,9)="" S DR="2.09////N",DIE="^SCTM(404.57,",DA=I D ^DIE
 S XPDIDTOT=+$O(^SCPT(404.43,"ADFN",""),-1) D MES^XPDUTL("Queuing Routine to Flag Inactive PCMM assignments")
 S ZTRTN="INACTIVE^SCMCTSK1",ZTIO="",ZTDTH=$H,ZTDESC="PCMM Inactive patients"  D ^%ZTLOAD
 D MES^XPDUTL("Task "_$G(ZTSK))
MEN S X="SCMC PCMM PROVIDER RPTS MENU",DIC="^DIC(19,",DIC(0)="M" D ^DIC S SD=+Y
 I SD>0 D
 .S X="SCMC MU MASS TEAM UNASSIGNMENT",DIC="^DIC(19,"_SD_",10,",DIC(0)="M",DA(1)=SD D ^DIC Q:Y'>0
 .S DA(1)=SD,DIK="^DIC(19,"_SD_",10,",DA=+Y D ^DIK
 S X="SDOUTPUT",DIC="^DIC(19,",DIC(0)="M" D ^DIC Q:Y'>0  S SD=+Y
 I '$D(^DIC(19,+Y,10,0)) Q
 S X="SCMC PCMM MAIN MENU",DIC="^DIC(19,"_SD_",10,",DIC(0)="LM",DA(1)=SD D ^DIC
 S X="SC PCMM REPORTS MENU",DIC="^DIC(19,"_SD_",10,",DIC(0)="M",DA(1)=SD D ^DIC Q:'Y
 S DA(1)=SD,DIK="^DIC(19,"_SD_",10,",DA=+Y D ^DIK
 ;
 ;
 Q
