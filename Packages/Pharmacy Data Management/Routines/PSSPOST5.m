PSSPOST5 ;BIR/EJW-Post install routine ;
 ;;1.0;PHARMACY DATA MANAGEMENT;**55**;9/30/97
 ;External reference to PSNMGR supported by DBIA 2106
 ;External reference to ^XUSEC supported by DBIA 10076
 ; POST-INSTALL ROUTINE FOR PATCH PSS*1*55 - TO POPULATE THE "DTXT" CROSS-REFERENCES IN THE DRUG AND PHARMACY ORDERABLE ITEMS FILE
 S ZTDTH=""
 I $D(ZTQUEUED) S ZTDTH=$H
 I ZTDTH="" D
 .W !,"The background job to populate the 'DTXT' (drug text) cross-reference in the"
 .W !,"PHARMACY ORDERABLE ITEM file (#50.7) and the DRUG file (#50) must be queued."
 .W !,"If no start date/time is entered when prompted, the background job will be"
 .W !,"queued to run NOW."
 .W !
 .D BMES^XPDUTL("Queuing background job to populate the 'DTXT' (drug text) cross-reference...")
 S ZTRTN="RES^PSSPOST5",ZTIO="",ZTDESC="Background job to populate 'DTXT' cross-reference" D ^%ZTLOAD K ZTDTH,ZTRTN,ZTIO,ZTDESC
 W:$D(ZTSK)&('$D(ZTQUEUED)) !!,"Task Queued !",!
 Q
RES ;
 I '$G(DT) S DT=$$DT^XLFDT
 D NOW^%DTC S ^XTMP("PSSTIMEX","START")=%
 D BMES^XPDUTL("Populating 'DTXT' cross-references...")
OI ;Updating "DTXT" cross-reference for Orderable Items
 D BMES^XPDUTL("Populating 'DTXT' x-ref for Pharmacy Orderable Items...")
 N PSSOI,PSSTXP,PSSSQ,PSSOICT,PSSDCT
 S (PSSOICT,PSSDCT)=0
 S PSSOI=0 F  S PSSOI=$O(^PS(50.7,PSSOI)) Q:'PSSOI  I $D(^PS(50.7,PSSOI,1,"B")) D
 .S PSSTXP="" F  S PSSTXP=$O(^PS(50.7,PSSOI,1,"B",PSSTXP)) Q:'PSSTXP  I $D(^PS(51.7,PSSTXP)) S PSSSQ="" F  S PSSSQ=$O(^PS(50.7,PSSOI,1,"B",PSSTXP,PSSSQ)) Q:PSSSQ=""  D
 ..I '$D(^PS(50.7,"DTXT",PSSTXP,PSSOI)) S ^PS(50.7,"DTXT",PSSTXP,PSSOI,PSSSQ)="" S PSSOICT=PSSOICT+1
DRUG ;Updating "DTXT" cross-reference for Drug file
 D BMES^XPDUTL("Populating 'DTXT' x-ref for Drug file...")
 N PSSDRG
 S PSSDRG=0 F  S PSSDRG=$O(^PSDRUG(PSSDRG)) Q:'PSSDRG  S PSSTXP="" F  S PSSTXP=$O(^PSDRUG(PSSDRG,9,"B",PSSTXP)) Q:'PSSTXP  I $D(^PS(51.7,PSSTXP)) S PSSSQ="" F  S PSSSQ=$O(^PSDRUG(PSSDRG,9,"B",PSSTXP,PSSSQ)) Q:PSSSQ=""  D
 .W " ",PSSDRG,"-",PSSTXP I '$D(^PSDRUG("DTXT",PSSTXP,PSSDRG)) S ^PSDRUG("DTXT",PSSTXP,PSSDRG,PSSSQ)="" S PSSDCT=PSSDCT+1
MAIL ;
 D NOW^%DTC S PSSTIMEB=%
 S Y=$G(^XTMP("PSSTIMEX","START")) D DD^%DT S PSSTIMEA=Y
 S Y=$G(PSSTIMEB) D DD^%DT S PSSTIMEB=Y
 S XMDUZ="PHARMACY DATA MANAGEMENT PACKAGE",XMY(DUZ)="",XMSUB="Drug Text Cross Reference Creation"
 F PSOCXPDA=0:0 S PSOCXPDA=$O(^XUSEC("PSNMGR",PSOCXPDA)) Q:'PSOCXPDA  S XMY(PSOCXPDA)=""
 K PSSTEXT S PSSTEXT(1)="Patch PSS*1*55 Drug Text Cross Reference creation is complete.",PSSTEXT(2)="It started on "_$G(PSSTIMEA)_".",PSSTEXT(3)="It ended on "_$G(PSSTIMEB)_"."
 S PSSTEXT(4)=" "
 S PSSTEXT(5)=PSSOICT_" entries were added to the 'DTXT' cross-reference for the PHARMACY ORDERABLE"
 S PSSTEXT(6)="ITEM file (#50.7)."
 S PSSTEXT(7)=" "
 S PSSTEXT(8)=PSSDCT_" entries were added to the 'DTXT' cross-reference for the DRUG file (#50)."
 S PSSTEXT(9)=" "
 S PSSTEXT(10)="This message is being sent to the installer of the patch and holders of the"
 S PSSTEXT(11)="PSNMGR key. The new Drug Text File Report [PSS DRUG TEXT FILE REPORT] option"
 S PSSTEXT(12)="should be run for all drug text entries in the DRUG TEXT file (#51.7)"
 S PSSTEXT(13)="to verify that the correct drug text is associated with the correct entries"
 S PSSTEXT(14)="in the PHARMACY ORDERABLE ITEM file (#50.7) and the DRUG file (#50)."
 S PSSTEXT(15)="A listing of the original drug text file entries distributed with"
 S PSSTEXT(16)="Patch PSS*1*29 is provided in the Pharmacy Data Management user manual."
 S XMTEXT="PSSTEXT(" N DIFROM D ^XMD
 K PSSTIMEA,PSSTIMEB,XMDUZ,XMSUB,PSSTEXT,XMTEXT
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
