PSSP159 ;BIRM/SJA-Pharmacy system site parameters ;09/24/10
 ;;1.0;PHARMACY DATA MANAGEMENT;**159**;9/30/97;Build 29
 ;
 Q
POST ; delete data of the DEFAULT MED ROUTE FOR CPRS field (#80.7)
 K DIE,DA,DR S DIE=59.7,DR="80.7///@",DA=1 D ^DIE K DA,DIE,DR
 ;
 ; delete DD for the DEFAULT MED ROUTE FOR CPRS field (#80.7)
 S DIK="^DD(59.7,",DA=80.7,DA(1)=59.7 D ^DIK K DA,DIK
 ;
 ; if no default med route, no possible med routes and the USE DOSAGE FORM MED ROUTE LIST field is set to NO
 ; change the field to "YES" and generate mailman message.
 S MCT=1,PSSIEN=0 F  S PSSIEN=$O(^PS(50.7,PSSIEN)) Q:'PSSIEN  I $D(^(PSSIEN,0)) S PSSNODE0=$G(^PS(50.7,PSSIEN,0)) D
 .I $P(PSSNODE0,"^",13)="N",'$P($G(^PS(50.7,PSSIEN,0)),"^",6)&('$O(^PS(50.7,PSSIEN,3,0))) D
 ..S $P(^PS(50.7,PSSIEN,0),"^",13)="Y",^TMP($J,"PSSP159",MCT)=$J(PSSIEN,10)_"     "_$E($P(PSSNODE0,"^"),1,20),MCT=MCT+1
MAIL ; create mail message
 D BMES^XPDUTL(" Generating Mail Message....")
 N XMDUZ,XMSUB,XMTEXT,XMY,DIFROM
 S XMDUZ="Patch PSS*1*159 Post Install"
 F PSSFDS=0:0 S PSSFDS=$O(@XPDGREF@("PSSARX",PSSFDS)) Q:'PSSFDS  S XMY(PSSFDS)=""
 S XMSUB="Pharmacy Orderable Item Updates",XMTEXT="PSSTMP("
 S PSSTMP(1)="Pharmacy Orderable Item Auto-change:",PSSTMP(2)=""
 S PSSTMP(3)="The USE DOSAGE FORM MED ROUTE LIST field of the following Orderable Items"
 S PSSTMP(4)="has been changed from NO to YES because these Orderable Items did not have the"
 S PSSTMP(5)="DEFAULT MED ROUTE and/or any POSSIBLE MED ROUTES populated. The medication"
 S PSSTMP(6)="routes associated with the Dosage Form for these Orderable Items will be "
 S PSSTMP(7)="displayed for selection in CPRS, as they were prior to this patch."
 S PSSTMP(8)=""
 S PSSTMP(9)="If you wish to make adjustments to the Medication Routes that display in CPRS "
 S PSSTMP(10)="for these Orderable Items, use the Edit Orderable Items [PSS EDIT ORDERABLE "
 S PSSTMP(11)="ITEMS] option."
 S PSSTMP(12)=""
 S PSSTMP(13)="",PSSTMP(14)="OI Number      OI NAME",PSSTMP(15)="==========     ===================="
 S CNT=15,X=0 F  S X=$O(^TMP($J,"PSSP159",X)) Q:'X  S CNT=CNT+1,PSSTMP(CNT)=$G(^(X))
 I '$O(^TMP($J,"PSSP159",0)) S CNT=16,PSSTMP(16)="               None Found"
 D ^XMD K PSSTMP,^TMP($J,"PSSP159")
 D BMES^XPDUTL(" Mail message sent.")
 Q
