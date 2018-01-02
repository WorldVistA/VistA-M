PSS208P ; ALB/MHA - Price per dispense unit - post install fix ;05/24/2017
 ;;1.0;PHARMACY DATA MANAGEMENT;**208**;9/30/97;Build 14
 ;
 Q
 ;
EN ;
 D BMES^XPDUTL("Starting post-install for PSS*1*208 ... ")
 D DRG
 D MES^XPDUTL("Finished with post-install for PSS*1*208.")
 Q
 ;
DRG ; loop through DRUG file for price update
 N NS,DRG,NDC,PPDU,PPOU,CT S DRG=0,NS="PSS208" K ^TMP(NS,$J)
 S ^TMP(NS,$J,1)="The Price Per Dispense Unit (PPDU) field (#16) and the Price Per Order Unit"
 S ^TMP(NS,$J,2)="(PPOU) field (#13) in the Drug file (#50) have been updated in the following"
 S ^TMP(NS,$J,3)="entries:"
 S ^TMP(NS,$J,4)=""
 S ^TMP(NS,$J,5)="Generic Name"
 S $E(^TMP(NS,$J,5),44)="NDC            Old PPDU   New PPDU"
 S $E(^TMP(NS,$J,6),44)="                   PPOU       PPOU"
 S ^TMP(NS,$J,7)="============"
 S $E(^TMP(NS,$J,7),44)="===            ========   ========"
 S ^TMP(NS,$J,8)="",CT=8
 F  S DRG=$O(^PSDRUG(DRG)) Q:'DRG  D
 . S NDC=$P($G(^PSDRUG(DRG,2)),"^",4),PPDU=$J($P($G(^PSDRUG(DRG,660)),"^",6),0,4),PPOU=$J($P($G(^PSDRUG(DRG,660)),"^",3),0,2) D:$G(NDC)
 . . N I,SYN,SNDC,SPPDU,SINT,SOU,SPPOU,SDUOU,QT S (I,QT)=0
 . . F  S I=$O(^PSDRUG(DRG,1,I)) Q:'I!(QT)  D
 . . . S SYN=^PSDRUG(DRG,1,I,0),SNDC=$P(SYN,"^",2),SPPDU=$J($P(SYN,"^",8),0,4),SINT=$P(SYN,"^",3) Q:SINT'["D"!('SPPDU)  ;SYN Price per dispense unit
 . . . S:$E(SNDC)=0 $P(SNDC,"-")=+$P(SNDC,"-")
 . . . S:$E(NDC)=0 $P(NDC,"-")=+$P(NDC,"-")
 . . . I $G(SNDC),SNDC=NDC,SPPDU>221,SPPDU'=PPDU D FIXPR S QT=1
 D GMAIL
 Q
 ;
FIXPR ;
 S SOU=$P(SYN,"^",5) ; Order unit
 S SPPOU=$P(SYN,"^",6) ;Price per order unit
 S SDUOU=$P(SYN,"^",7) ;Dispense Units per Order Unit
 N DIE,DA,DR
 S DIE="^PSDRUG(",DA=DRG,DR="12////"_SOU_";13////"_SPPOU_";15////"_SDUOU_";16////"_SPPDU D ^DIE
 S CT=CT+1,^TMP(NS,$J,CT)=$E($P(^PSDRUG(DRG,0),"^"),1,35)_"("_DRG_")"
 S $E(^TMP(NS,$J,CT),44)=NDC,$E(^TMP(NS,$J,CT),59)=$J(PPDU,8,2),$E(^TMP(NS,$J,CT),70)=$J(SPPDU,8,2)
 S CT=CT+1
 S $E(^TMP(NS,$J,CT),59)=$J(PPOU,8,2),$E(^TMP(NS,$J,CT),70)=$J(SPPOU,8,2)
 Q
 ;
GMAIL ; send post-install message
 S XMSUB="PSS*1*208 Post-Install Drug Price Update Report"
 S XMDUZ="PHARMACY DATA MANAGEMENT PACKAGE",XMY(DUZ)=""
 I $D(^XUSEC("PSNMGR")) S PSSDUZ=0 F  S PSSDUZ=$O(^XUSEC("PSNMGR",PSSDUZ)) Q:'PSSDUZ  S XMY(PSSDUZ)=""
 I $D(^XUSEC("PSA ORDERS")) S PSSDUZ=0 F  S PSSDUZ=$O(^XUSEC("PSA ORDERS",PSSDUZ)) Q:'PSSDUZ  S XMY(PSSDUZ)=""
 I $D(^XUSEC("PSAMGR")) S PSSDUZ=0 F  S PSSDUZ=$O(^XUSEC("PSDMGR",PSSDUZ)) Q:'PSSDUZ  S XMY(PSSDUZ)=""
 I CT=8 S ^TMP(NS,$J,7)="No discrepancy found, nothing to update..."
 S XMTEXT="^TMP(""PSS208"",$J," N DIFROM D ^XMD
 K XMSUB,XMDUZ,XMY,XMTEXT,PSSDUZ,^TMP(NS,$J)
 Q
 ;
