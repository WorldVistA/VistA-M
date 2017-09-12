PSSXRF1  ;BIR/TTH-Re-Index "AOC" x-ref on DRUG file (#50) ;05 MAY 99
 ;;1.0; PHARMACY DATA MANAGEMENT;**25**;9/30/97
 ;
 Q
ENNV ; Begin
 K ZTSAVE,ZTSK S ZTRTN="ENQN^PSSXRF1",ZTDESC="PDM patch #25 re-index of ""AOC"" cross-reference",ZTIO="",ZTDTH=$$CON(XPDQUES("POS ONE")) D ^%ZTLOAD
 I $D(ZTSK) D MES^XPDUTL("The re-index of the ""AOC"" cross-reference is queued to run at "_XPDQUES("POS ONE"))
 I $D(ZTSK) D MES^XPDUTL("You will receive a mailman message when task #"_ZTSK_" has completed.")
 Q
ENQN ; Loop thru VA Drug file (#50).
 D NOW^%DTC N DFN S PSSSTART=$E(%,1,12)
 S DIK="^PSDRUG(",DIK(1)="2^AOCC" D ENALL^DIK K DIK
 D SENDMSG
 Q
SENDMSG ;Send mail message when check is complete.
 K PSS,XMY S XMDUZ="Pharmacy Data Management",XMSUB="PSS*1*25 Installation Completed",XMTEXT="PSS(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSS(1,0)=" The re-index of the ""AOC"" cross-reference completed on "_Y_"."
 D ^XMD
 ;
DONE ;
 K DA,DIK,PSSSTART,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTSK S ZTREQ="@"
 Q
 ;
GETDT ; check date/time for job to run
 N %DT,Y S %DT="NRS"
 D ^%DT I Y=-1 K X
 E  S X=Y
 Q
CON(X) ;
 N %DT S %DT="NRS" D ^%DT
 Q Y
