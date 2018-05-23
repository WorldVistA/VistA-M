PSS1P210 ;PAW - Patch 210 Post Install Routine;4/25/2017
 ;;1.0;PHARMACY DATA MANAGEMENT;**210**;9/30/97;Build 9
 ;
 ;This post-installation routine will identify and report free text in the NAME field  
 ;(#.01) of the ADMINISTRATION SCHEDULE file (#51.1) when the TYPE OF SCHEDULE field (#5) 
 ;is set to D (Day of the Week).  
 Q
 ;
EN ; Begin post-installation routine 
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 N NAMSP,PATCH,JOBN,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,Y,ZTQUEUED,ZTREQ,ZTSAVE,CNT,SBJM
 S NAMSP="PSS1P210"
 S JOBN="PSS*1.0*210 Post-Installation"
 S PATCH="PSS*1.0*210"
 S Y=$$NOW^XLFDT S ZTDTH=$$FMTH^XLFDT(Y)
 D BMES^XPDUTL("=============================================================")
 D MES^XPDUTL("Queuing background job for "_JOBN_"...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("A MailMan message will be sent to the installer upon Post")
 D MES^XPDUTL("Install Completion.")
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
ENQN  ; Loop through file 51.1 and look for Day of the Week Schedule Types with Free Text 
 N CNT,PSSCREAT,PSSDASH,PSSEXPR,PSSTIME,PSSXTIME,PSSTIMCT,PSSIEN
 N PSSSTART,PSSX,PSSZX,PSSZ1,PSSZ2,PSSZ3,PSSZ4
 D NOW^%DTC S PSSSTART=$E(%,1,12),PSSCREAT=$E(%,1,7),PSSEXPR=$$FMADD^XLFDT(PSSCREAT,60,0,0,0)
 K ^TMP("PSS1P210R",$J)
 S CNT=8
 S PSSIEN=0
 F  S PSSIEN=$O(^PS(51.1,PSSIEN)) Q:PSSIEN=""  D
 . I $P($G(^PS(51.1,PSSIEN,0)),U,5)'="D" Q
 . S PSSX=$P(^PS(51.1,PSSIEN,0),U)
 . S PSSZX=PSSX S PSSX=$P(PSSX,"@")
 . S PSSZ2=1,PSSZ4="-" I PSSX'["-",PSSX?.E1P.E F PSSZ1=1:1:$L(PSSX) I $E(PSSX,PSSZ1)?1P S PSSZ4=$E(PSSX,PSSZ1) Q
 . F PSSZ1=1:1:$L(PSSX,PSSZ4) Q:'PSSZ2  S PSSZ2=0 I $L($P(PSSX,PSSZ4,PSSZ1))>1 F PSSZ3="MONDAYS","TUESDAYS","WEDNESDAYS","THURSDAYS","FRIDAYS","SATURDAYS","SUNDAYS" I $P(PSSZ3,$P(PSSX,PSSZ4,PSSZ1))="" S PSSZ2=1 Q
 . I PSSZ2=0 K PSSX
 . S PSSXTIME=$P(PSSZX,"@",2),PSSDASH=$L(PSSXTIME,"-")
 . F PSSTIMCT=1:1:PSSDASH S PSSTIME=$P(PSSXTIME,"-",PSSTIMCT)
 . I $L(PSSTIME)>4 K PSSX
 . I '$D(PSSX) S ^TMP("PSS1P210R",$J,CNT)=PSSZX,CNT=CNT+1
 D STOP
 Q
 ;
STOP K DA,DIE,DR,NUM,CPS,CPSX,DFN,ORSTA,ORSTOP,UDIV,UIEN,UIEN1,%
 D XMAIL1
 D XMAIL2
 Q
 ;
XMAIL1 ; Post-installation Notification for Installer
 K PSG,XMY S XMDUZ=.5,XMSUB="PATCH PSS*1.0*210 INSTALLATION COMPLETE",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="  -- INSTALLER --"
 S PSG(2,0)="  The post-install for PSS*1.0*210 completed "_Y_"."
 D ^XMD
 Q
 ;
XMAIL2 ; Post-installation Notification for Users 
 N PSSDUZ,PSSX
 S XMSUB="PSS*1.0*210 Pharmacy Expired Order Status Change"
 S XMDUZ=.5
 S XMSUB="PSS*1*210 Post-Install ADMINISTRATION SCHEDULE Report"
 I $D(^XUSEC("PSA ORDERS")) S PSSDUZ=0 F  S PSSDUZ=$O(^XUSEC("PSA ORDERS",PSSDUZ)) Q:'PSSDUZ  S XMY(PSSDUZ)=""
 I $D(^XUSEC("PSAMGR")) S PSSDUZ=0 F  S PSSDUZ=$O(^XUSEC("PSAMGR",PSSDUZ)) Q:'PSSDUZ  S XMY(PSSDUZ)=""
 I $D(^XUSEC("PSDMGR")) S PSSDUZ=0 F  S PSSDUZ=$O(^XUSEC("PSDMGR",PSSDUZ)) Q:'PSSDUZ  S XMY(PSSDUZ)=""
 S PSSDUZ=0 F  S PSSDUZ=$O(^XUSEC("PSNMGR",PSSDUZ)) Q:PSSDUZ'>0  S XMY(PSSDUZ)=""
 S ^TMP("PSS1P210R",$J,1)=" Patch PSS*1.0*210 post-installation routine has identified"
 S ^TMP("PSS1P210R",$J,2)=" "_(CNT-8)_" Day of the Week ADMINISTRATION SCHEDULES with free"
 S ^TMP("PSS1P210R",$J,3)=" text in the NAME field.  Please review."
 S ^TMP("PSS1P210R",$J,4)=" "
 S ^TMP("PSS1P210R",$J,5)="Schedule Name"
 S ^TMP("PSS1P210R",$J,6)="======== ===="
 S ^TMP("PSS1P210R",$J,7)=" "
 S XMY(DUZ)=""
 I CNT=8 S ^TMP("PSS1P210R",$J,8)="No discrepancy found, nothing to update..."
 S XMTEXT="^TMP(""PSS1P210R"",$J," N DIFROM D ^XMD
 K CNT,XMSUB,XMDUZ,XMY,XMTEXT,^TMP("PSS1P210R",$J)
 Q
 ;
