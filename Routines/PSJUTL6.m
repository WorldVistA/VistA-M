PSJUTL6  ;B'ham/LDT - Re-index "AUDS" x-ref on file 55 ; 18 Aug 98 / 2:48 PM
 ;;5.0; INPATIENT MEDICATIONS ;**13**;16 DEC 97
 ;
 Q
ENNV ; Begin
 K ZTSAVE,ZTSK S ZTRTN="ENQN^PSJUTL6",ZTDESC="Re-index of ""AUDS"" x-ref",ZTIO="",ZTDTH=$$CON(XPDQUES("POS ONE")) D ^%ZTLOAD
 I $D(ZTSK) D MES^XPDUTL("The Re-index of the ""AUDS"" is queued to run at "_XPDQUES("POS ONE"))
 I $D(ZTSK) D MES^XPDUTL("YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED.")
 Q
ENQN ; Loop thru Pharmacy Patient file.
 D NOW^%DTC N DFN S PSJSTART=$E(%,1,12)
 S DFN=0 F  S DFN=$O(^PS(55,DFN)) Q:'DFN  S DA(1)=DFN,DIK="^PS(55,"_DA(1)_",5,",DIK(1)="10^AUDS" D ENALL^DIK
 D SENDMSG
 Q
SENDMSG ;Send mail message when check is complete.
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="INPATIENT MEDS ORDER CHECK COMPLETED",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="  The Re-index of the ""AUDS"" x-ref completed as of "_Y_"."
 S X=$$FMDIFF^XLFDT(%,PSJSTART,3) S:$L(X," ")>1 DAYS=+$P(X," "),X=$P(X," ",2) S HOURS=+$P(X,":"),MINS=+$P(X,":",2)
 S PSG(2,0)=" ",PSG(3,0)="This process took "_$S($G(DAYS):DAYS_" day"_$E("s",DAYS'=1)_", ",1:"")_HOURS_" hour"_$E("s",HOURS'=1)_" and "_MINS_" minute"_$E("s",MINS'=1)_"."
 D ^XMD
 ;
DONE ;
 K DA,DIK,PSJSTART,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTSK S ZTREQ="@"
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
