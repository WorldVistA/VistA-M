PSJ5P340 ;PAW - Patch 340 Post Install Routine;4/25/2017
 ;;5.0;INPATIENT MEDICATIONS;**340**;DEC 1997;Build 16
 ;
 ;Reference to ^PS(55 is supported by DBIA# 2191.
 ;
 ;This post-installation routine will identify ACTIVE UD and IV orders with a
 ;STOP DATE prior to today.  It will then change the order status to EXPIRED.
 Q
 ;
EN ; Begin post-installation routine 
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 N NAMSP,PATCH,JOBN,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,Y,ZTQUEUED,ZTREQ,ZTSAVE,CNT,SBJM
 S NAMSP="PSJ5P340"
 S JOBN="PSJ*5.0*340 Post-Installation"
 S PATCH="PSJ*5.0*340"
 S Y=$$NOW^XLFDT S ZTDTH=$$FMTH^XLFDT(Y)
 D BMES^XPDUTL("=============================================================")
 D MES^XPDUTL("Queuing background job for "_JOBN_"...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("A MailMan message will be sent to the installer upon Post")
 D MES^XPDUTL("Install Completion.  This may take an hour or more, depending")
 D MES^XPDUTL("upon site size.")
 D MES^XPDUTL("==============================================================")
 ;
 S ZTRTN="ENQN^"_NAMSP,ZTIO=""
 S (SBJM,ZTDESC)="Background job for "_JOBN
 S ZTSAVE("JOBN")="",ZTSAVE("ZTDTH")="",ZTSAVE("DUZ")="",ZTSAVE("SBJM")=""
 D ^%ZTLOAD
 D:$D(ZTSK)
 . D MES^XPDUTL("*** Task #"_ZTSK_" Queued! ***")
 . D BMES^XPDUTL("")
 . S ZTSAVE("ZTSK")=""
 D BMES^XPDUTL("")
 K XPDQUES
 Q
 ;
ENQN N DFN,CNT,ORSTA,ORSTOP,PSGPO,PSIVACT,PSJCOR,PSJCREAT,PSJEXPR,PSJPO,PSJSTART,STATUS,UIEN,UIEN1,UDIV,UDIV1
 D NOW^%DTC S PSJSTART=$E(%,1,12),PSJCREAT=$E(%,1,7),PSJEXPR=$$FMADD^XLFDT(PSJCREAT,60,0,0,0)
 K ^XTMP("PSJ5P340",$J),^TMP("PSJ5P340R",$J)
 S (CNT,DFN)=0
 F  S DFN=$O(^PS(55,DFN)) Q:DFN=""  D UD,IV
 I CNT'=0 D UPDATE
 D STOP
 Q
 ;
UD ; Process Unit Dose Orders
 S UIEN=""
 F  S UIEN=$O(^PS(55,DFN,5,UIEN)) Q:UIEN=""  D
 . S ORSTA=$S($P($G(^PS(55,DFN,5,UIEN,0)),U,9)="A":1,1:0)
 . S ORSTOP=($P($G(^PS(55,DFN,5,UIEN,2)),U,4))
 . I ORSTA=1,ORSTOP'>DT S ^XTMP("PSJ5P340",$J,DFN,"UD",UIEN)="",CNT=CNT+1
 Q
 ;
IV ; Process IV Orders
 S UIEN=""
 F  S UIEN=$O(^PS(55,DFN,"IV",UIEN)) Q:UIEN=""  D
 . S ORSTA=$S($P($G(^PS(55,DFN,"IV",UIEN,0)),U,17)="A":1,1:0)
 . S ORSTOP=($P($G(^PS(55,DFN,"IV",UIEN,0)),U,3))
 . I ORSTA=1,ORSTOP'>DT S ^XTMP("PSJ5P340",$J,DFN,"IV",UIEN)="",CNT=CNT+1
 Q
 ; 
UPDATE ; Loop to Update Status on Unit Dose and IV Orders 
 S DFN="" F  S DFN=$O(^XTMP("PSJ5P340",$J,DFN)) Q:DFN=""  D
 . S UDIV="" F  S UDIV=$O(^XTMP("PSJ5P340",$J,DFN,UDIV)) Q:UDIV=""  D
 .. S UIEN="" F  S UIEN=$O(^XTMP("PSJ5P340",$J,DFN,UDIV,UIEN)) Q:UIEN=""  D
 ... D UPDATE1
 Q
 ;
UPDATE1 ; Update Status on Unit Dose and IV Orders
 S UDIV1=$S(UDIV="UD":5,1:"IV")
 I $G(^PS(55,DFN,UDIV1,UIEN,0))="" Q  ;This record is very corrupt and should not be updated.
 S PSJCOR=0
 I '$D(^PS(55,DFN,UDIV1,UIEN,2)) S PSJCOR=1  ;Set incomplete record indicator.
 I PSJCOR,UDIV="UD" D CORRUPT Q  ;Update manually, due to corrupt data. 
 S STATUS="E",(PSGPO,PSIVACT)=1,DA=UIEN,DA(1)=DFN,DIE=$S(UDIV="IV":"^PS(55,"_DA(1)_",""IV"",",1:"^PS(55,"_DA(1)_",5,"),DR=$S(UDIV="IV":"100////E",1:"28////E") D ^DIE
 S UIEN1=$S(UDIV="IV":UIEN_"V",1:UIEN_"U")
 D EN1^PSJHL2(DFN,"SC",UIEN1)
 Q
 ;
CORRUPT ; Corrupt Unit Dose Data Found
 N PSJORD
 S $P(^PS(55,DFN,UDIV1,UIEN,0),"^",9)="E"
 K DIK,DA S DA(1)=DFN,DA=UIEN,DIK="^PS(55,"_DFN_",5,",DIK(1)="28^AL28^AOERRS" D EN2^DIK K DIK
 S ^XTMP("PSJ5P340",$J,DFN,UDIV,UIEN)=""
 S PSJORD=$P($G(^PS(55,DFN,UDIV1,UIEN,0)),"^",21)
 I PSJORD'="" S ^XTMP("PSJ5P340C",DFN,UDIV,UIEN)=PSJORD  ;Log corrupt data if link found to Order file
 Q
 ;
STOP K DA,DIE,DR,NUM,CPS,CPSX,DFN,ORSTA,ORSTOP,UDIV,UIEN,UIEN1,%
 D XMAIL1
 D XMAIL2
 S:$D(^XTMP("PSJ5P340")) ^XTMP("PSJ5P340",0)=PSJEXPR_"^"_PSJCREAT
 S:$D(^XTMP("PSJ5P340C")) ^XTMP("PSJ5P340C",0)=PSJEXPR_"^"_PSJCREAT
 Q
 ;
XMAIL1 ; Post-installation Notification for Installer
 K PSG,XMY S XMDUZ=.5,XMSUB="PATCH PSJ*5.0*340 INSTALLATION COMPLETE",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="  -- INSTALLER --"
 S PSG(2,0)="  The post-install for PSJ*5.0*340 completed "_Y_"."
 D ^XMD
 Q
 ;
XMAIL2 ; Post-installation Notification for Users 
 N DRG,PSJX,PSJORD
 S XMSUB="PSJ*5.0*340 Pharmacy Expired Order Status Change"
 S XMDUZ=.5
 S ^TMP("PSJ5P340R",$J,1)=" Patch PSJ*5.0*340 post-installation routine has updated"
 S ^TMP("PSJ5P340R",$J,2)=" the status of "_CNT_" stopped / expired pharmacy patient"
 S ^TMP("PSJ5P340R",$J,3)=" orders from ACTIVE to EXPIRED."
 S ^TMP("PSJ5P340R",$J,4)=" "
 S ^TMP("PSJ5P340R",$J,5)=" Information identifying orders that have had status"
 S ^TMP("PSJ5P340R",$J,6)=" updates from ACTIVE to EXPIRED will remain in"
 S ^TMP("PSJ5P340R",$J,7)=" ^XTMP(""PSJ5P340"",$J,DFN,IV/UD,UIEN) for 60 days."
 S ^TMP("PSJ5P340R",$J,8)=""
 S ^TMP("PSJ5P340R",$J,9)=" The following Pharmacy Patient file (#55) entries contain"
 S ^TMP("PSJ5P340R",$J,10)=" corrupt data and should be manually checked in FileMan."
 S ^TMP("PSJ5P340R",$J,11)=" You can use the Order File# to manually change the Order"
 S ^TMP("PSJ5P340R",$J,12)=" file (#100) STATUS field to EXPIRED via FileMan."
 S ^TMP("PSJ5P340R",$J,13)=""
 S ^TMP("PSJ5P340R",$J,14)=" DFN          Type   Order IEN   Order file#"
 S ^TMP("PSJ5P340R",$J,15)=" ----------   ----   ---------   -----------"
 S CNT=15
 S DFN="" F  S DFN=$O(^XTMP("PSJ5P340C",DFN)) Q:DFN=""  D
 . S UDIV="" F  S UDIV=$O(^XTMP("PSJ5P340C",DFN,UDIV)) Q:UDIV=""  D
 .. S UIEN="" F  S UIEN=$O(^XTMP("PSJ5P340C",DFN,UDIV,UIEN)) Q:UIEN=""  D
 ... S CNT=CNT+1
 ... S PSJORD=^XTMP("PSJ5P340C",DFN,UDIV,UIEN)
 ... S ^TMP("PSJ5P340R",$J,CNT)=" "_$J(DFN,10)_"   "_$J(UDIV,4)_"   "_$J(UIEN,9)_"   "_$J(PSJORD,11)
 S PSJX="" F  S PSJX=$O(^XUSEC("PSJI MGR",PSJX)) Q:'PSJX  S XMY(PSJX)=""
 S PSJX="" F  S PSJX=$O(^XUSEC("PSJU MGR",PSJX)) Q:'PSJX  S XMY(PSJX)=""
 S PSJX="" F  S PSJX=$O(^XUSEC("PSJU RPH",PSJX)) Q:'PSJX  S XMY(PSJX)=""
 S PSJX="" F  S PSJX=$O(^XUSEC("PSJ RPHARM",PSJX)) Q:'PSJX  S XMY(PSJX)=""
 S DRG=0 F  S DRG=$O(^XUSEC("PSNMGR",DRG)) Q:DRG'>0  S XMY(DRG)=""
 S XMY(DUZ)=""
 S XMTEXT="^TMP(""PSJ5P340R"",$J," N DIFROM D ^XMD
 K CNT,XMSUB,XMDUZ,XMY,XMTEXT,^TMP("PSJ5P340R",$J)
 Q
 ;
