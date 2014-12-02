PSJ299PO ;BIR/LE-Post Install routine for patch PSJ*5*299 ;05/1/13
 ;;5.0;INPATIENT MEDICATIONS ;**299**;9/30/97;Build 11
 ;
QUE ;
 N NAMSP,PATCH,JOBN,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,Y,ZTQUEUED,ZTREQ,ZTSAVE,CNT,SBJM,RESTART,SMSG
 S NAMSP="PSJ299PO"
 S JOBN="PSJ*5*299 Post Install"
 S PATCH="PSJ*5*299"
 S Y=$$NOW^XLFDT S ZTDTH=$$FMTH^XLFDT(Y)
 ;
 I '$G(RESTART) D
 .D BMES^XPDUTL("=============================================================")
 .D MES^XPDUTL("Queuing background job for "_JOBN_"...")
 .D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 .D MES^XPDUTL("A MailMan message will be sent to the installer upon Post")
 .D MES^XPDUTL("Install Completion.  This may take 2-3 hours.")
 .D MES^XPDUTL("==============================================================")
 E  D
 .W !,"============================================================="
 .W !,"Queuing background job for "_JOBN_"..."
 .W !,"A MailMan message will be sent to the installer upon Post"
 .W !,"Install Completion.  This may take 2-3 hours."
 .W !,"=============================================================="
 ;
 S ZTRTN="EN^"_NAMSP,ZTIO=""
 S (SBJM,ZTDESC)="Background job for "_JOBN
 S ZTSAVE("JOBN")="",ZTSAVE("ZTDTH")="",ZTSAVE("DUZ")="",ZTSAVE("SBJM")=""
 D ^%ZTLOAD
 D:$D(ZTSK)
 . S SMSG="*** Task #"_ZTSK_" Queued! ***"
 . I '$G(RESTART) D MES^XPDUTL(SMSG)
 . E  W !,SMSG
 . I '$G(RESTART) D BMES^XPDUTL("")
 . S ZTSAVE("ZTSK")=""
 I '$G(RESTART) D BMES^XPDUTL("")
 K XPDQUES
 Q
 ;
EN ;Do Mail Message
 N DFN,DA,STARTH,STOPH,SUBJ
 S STARTH=$$HTE^XLFDT(ZTDTH)
 K DIK S DIK="^PS(53.1,",DIK(1)="113^CIMO" D ENALL2^DIK,ENALL^DIK
 S DFN=0 F  S DFN=$O(^PS(55,DFN)) Q:'DFN  S DA(1)=DFN D
 .K DIK S DIK="^PS(55,"_DA(1)_",5,",DIK(1)="130^CIMOU" D ENALL2^DIK,ENALL^DIK
 .K DIK S DIK="^PS(55,"_DA(1)_",5,",DIK(1)="130^CIMOCLU" D ENALL2^DIK,ENALL^DIK
 .K DIK S DIK="^PS(55,"_DA(1)_","_"""IV"""_",",DIK(1)="136^CIMOI" D ENALL2^DIK,ENALL^DIK
 .K DIK S DIK="^PS(55,"_DA(1)_","_"""IV"""_",",DIK(1)="136^CIMOCLI" D ENALL2^DIK,ENALL^DIK
 K DIK
 ;
 ;Send message
 S CNT=1
 S Y=$$NOW^XLFDT S STOPH=$$FMTH^XLFDT(Y),STOPH=$$HTE^XLFDT(STOPH)
 S SUBJ="PSJ*5*299 POST INSTALL Complete"
 S MSG(CNT)="The IMO Clinic cross references have been re-indexed:",CNT=CNT+1
 S MSG(CNT)=" ",CNT=CNT+1
 S MSG(CNT)="     File 53.1 - CIMO",CNT=CNT+1
 S MSG(CNT)="      File 55  - CIMOU and CIMOCLU for Unit Dose Sub-file.",CNT=CNT+1
 S MSG(CNT)="      File 55  - CIMOI AND CIMOCLI for IV Sub-file.",CNT=CNT+1
 S MSG(CNT)=" ",CNT=CNT+1
 S MSG(CNT)="The background job "_ZTSK_" began "_STARTH_" and ",CNT=CNT+1
 S MSG(CNT)="ended "_STOPH_".",CNT=CNT+1
 D MAIL(.MSG,SUBJ)
 Q
 ;
MAIL(MSG,SBJ) ; Send out some mail!
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,I
 S XMDUZ="INPT PHARMACY",XMSUB=SBJM,XMTEXT="MSG("
 S XMY(DUZ)=""
 D ^XMD
 Q ""
 ;
RESTART ;restart post install if error occurs
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 S RESTART=1
 D QUE
 Q
