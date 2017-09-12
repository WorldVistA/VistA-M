PX10118P ;BPFO/ESW;POST INIT FOR PATCH 118;10-MAR-2001 ; 5/15/02 11:27am
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**118**;Mar, 10 2002
 ;
 ; This is a clean up routine following PX*1.0*117
 ;
POST ;Main entry point of post init routine
 N X
 ;Delete incomplete V CPT records
 S X(1)=" "
 S X(2)="Post install is ready for queuing."
 S X(3)=" "
 S X(4)="The queued task will perform the following:"
 S X(5)="1. V CPT records without the CPT (#.01) field defined will be deleted."
 S X(6)=" "
 S X(7)="2. Overwritten V CPT records will be updated as follows:"
 S X(8)="   -PROVIDER NARRATIVE (#.04) field will be populated based on the CPT"
 S X(9)="    value of the V CPT record replacing the existing incorrect pointer"
 S X(10)="    to the PROVIDER NARRATIVE (#9999999.27) file."
 S X(11)="   -AUDIT TRIAL (#80102) field will be updated to its previous value."
 S X(12)="   -ENCOUNTER PROVIDER (#1204) field will be removed if no match exists"
 S X(13)="    with pointers from V PROVIDER (#9000010.06) file to the evaluated VISIT."
 S X(14)="   -If the CPT code is the same found in TYPE OF VISIT (#357.69) field"
 S X(15)="    then the QUANTITY (#.16) field will be set to one."
 S X(16)="3. Partially created V CPT records with  CPT, PATIENT NAME and VISIT will be"
 S X(17)="   populated with PROVIDER NARRATIVE (#.04) and QUANTITY (#.16) only."
 S X(18)="4. V CPT records with not a valid CPT code, if any, will be identified"
 S X(19)="in ^XTMP(""NOT A CPT CODE"") and marked in the COMMENTS field with"
 S X(20)="'PX*1.0*118/NOCPT' value for individual investigation."
 S X(21)=" "
 S X(22)="All updated V CPT records will be populated with 'PX*1.0*118' value"
 S X(23)="in the COMMENTS (#81101) field for reference purposes."
 S X(24)=" "
 D MES^XPDUTL(.X) K X
EN1 ;Queue clean up routine
 ; Queue time is post install question POS1 (use NOW if not defined)
 ; If queued using entry point QUEUE, queue time will be prompted for
 N ZTSK,ZTRTN,ZTIO,ZTDESC,ZTDTH
 S X(1)=" "
 S X(2)="Routine to clean up V CPT (#9000010.18) file will be queued as requested."
 S X(3)=" "
 D MES^XPDUTL(.X) K X
 I $D(^XTMP("PX10118P",2)) D  Q
 .S X(1)=" "
 .S X(2)="*****"
 .S X(3)="Post init appears to be running.  If it is not, delete the"
 .S X(4)="node ^XTMP(""PX10118P"",2) and use line tag QUEUE^PX10118P"
 .S X(5)="to [re]start the process."
 .S X(6)="*****"
 .S X(7)=" "
 .D MES^XPDUTL(.X) K X
 I $D(^XTMP("PX10118P",3)) D  Q
 .S X(1)=" "
 .S X(2)="*****"
 .S X(3)="Post init appears to have run to completion on "_$$FMTE^XLFDT(^XTMP("PX10118P",3))_"."
 .S X(4)="If it did not, delete the node ^XTMP(""PX10118P"",3) and use"
 .S X(5)="line tag QUEUE^PX10118P to [re]start the process."
 .S X(6)="*****"
 .S X(7)=" "
 .D MES^XPDUTL(.X) K X
 S ZTRTN="SET^PX10118P",ZTIO=""
 S ZTDTH=$H S X=+$G(XPDQUES("POS1")) S:(X) ZTDTH=$$FMTH^XLFDT(X) K:$G(PX10118P) ZTDTH
 S ZTDESC="Clean up of V CPT file(#9000010.18)"
 D ^%ZTLOAD
 I $G(ZTSK) D MES^XPDUTL("Task #"_ZTSK_" queued to start "_$$HTE^XLFDT($G(ZTSK("D")))) I 1
 E  D MES^XPDUTL("***** UNABLE TO QUEUE CLEAN UP V CPT *****")
 Q
 ;
SET ; This is the post-init to clean V CPT file
 N CIENCNT,DATIM,CIEN,QFLG,Y,XMDUZ,XMTEXT,XMY,LASTCIEN,CIENTOT,CIENDEL,NOCPT
 S DATIM=$$DT^XLFDT()
 S ^XTMP("PX10118P",0)=$$FMADD^XLFDT(DATIM,30)_"^"_DATIM
 S ^XTMP("PX10118P",2)=1
 S QFLG=0
 S Y=$G(^XTMP("PX10118P",1))
 S (CIEN,LASTCIEN)=+Y
 I CIEN=0 S CIEN="A" S (NOCPT,CIENCNT,CIENTOT,CIENDEL)=0
 E  S CIENCNT=+$P(Y,U,2),CIENTOT=+$P(Y,U,3),CIENDEL=+$P(Y,U,4),NOCPT=$P(Y,U,5)
 F  S CIEN=$O(^AUPNVCPT(CIEN),-1) Q:'CIEN  D  Q:QFLG
 .S CIENTOT=CIENTOT+1
 .S LASTCIEN=CIEN
 .N VER,VCD,CPV S VCD="VA LOCAL CODE SELECTED"
 .S CPV=$P($G(^AUPNVCPT(CIEN,0)),U)
 .;verify if a correct pointer to CPT file 
 .I CPV'="" S VER=$$CPT^ICPTCOD(CPV) I $P(VER,U,2)'=VCD&(VER<1) D  Q
 ..I '$D(^XTMP("NOT A CPT CODE")) S ^XTMP("NOT A CPT CODE",0)=$$FMADD^XLFDT(DATIM,30)_"^"_DATIM
 ..M ^XTMP("NOT A CPT CODE",$J,CIEN)=^AUPNVCPT(CIEN)
 ..S $P(^AUPNVCPT(CIEN,811),U)="PX*1.0*118/NOCPT "_$P($G(^AUPNVCPT(CIEN,811)),U)
 ..S NOCPT=NOCPT+1
 .I $L($P($G(^AUPNVCPT(CIEN,801)),U,2),"-A")>2!'$P($G(^AUPNVCPT(CIEN,0)),U,4)!'$P($G(^(0)),U) D
 ..I '$D(^XTMP("CLEAN V CPT")) S ^XTMP("CLEAN V CPT",0)=$$FMADD^XLFDT(DATIM,30)_"^"_DATIM
 ..M ^XTMP("CLEAN V CPT",$J,CIEN)=^AUPNVCPT(CIEN)
 ..S CIENCNT=CIENCNT+1
 ..;delete icorrectly created record
 ..I '$P($G(^AUPNVCPT(CIEN,0)),U) S CIENDEL=CIENDEL+1 D  Q
 ...N DIK,DA S DIK="^AUPNVCPT(",DA=CIEN D ^DIK
 ..;verify/update AUDIT TRIAL
 ..N GG,FR,PP,FRS S GG=$P($G(^AUPNVCPT(CIEN,801)),U,2) I $L(GG,"-A")>2 D
 ...F PP=1:1 S:$P(GG,";",PP)["-A" FRS(PP)="" I $O(FRS(""),-1)>1 S GG=$P(GG,";",1,PP-1)_";" Q
 ...S $P(^AUPNVCPT(CIEN,801),U,2)=GG
 ..;verify PROVIDER NARRATIVE
 ..N PN,PNVI,ENC S PN=$P(^AUPNVCPT(CIEN,0),U,4)
 ..S PNVI=$$PRVNARR($P(^AUPNVCPT(CIEN,0),U)) ;prov narr
 ..I PNVI'=PN S $P(^AUPNVCPT(CIEN,0),U,4)=PNVI
 ..;verify QUANTITY
 ..;I $P(^AUPNVCPT(CIEN,0),U,16)="" S $P(^(0),U,16)=1 ;QUANTITY
 ..I $P(^AUPNVCPT(CIEN,0),U,16)'=1,$D(^IBE(357.69,+$P(^AUPNVCPT(CIEN,0),U))) S $P(^AUPNVCPT(CIEN,0),U,16)=1 ;DBIA #: 1906
 ..;verify ENCOUNTER PROVIDER (for CPT)
 ..I $P($G(^AUPNVCPT(CIEN,12)),U,4) S ENC=$P(^(12),U,4) D
 ...N PRV,VST,FKL S VST=+$P(^AUPNVCPT(CIEN,0),U,3),PRV="",FKL="" D
 ....F  S PRV=$O(^AUPNVPRV("AD",VST,PRV)) Q:PRV=""  D  Q:FKL
 .....I $P(^AUPNVPRV(PRV,0),U)=ENC S FKL=1
 ....I 'FKL S $P(^AUPNVCPT(CIEN,12),U,4)=""
 ..;set up COMMENTS
 ..S $P(^AUPNVCPT(CIEN,811),U)="PX*1.0*118 "_$P($G(^AUPNVCPT(CIEN,811)),U)
 .I '(CIENCNT#100) S QFLG=$$S^%ZTLOAD("CIEN: "_CIEN)
 S ^XTMP("PX10118P",1)=LASTCIEN_U_CIENCNT_U_CIENTOT_U_CIENDEL_U_NOCPT
 K ^XTMP("PX10118P",2)
 S DATIM=$$NOW^XLFDT()
 N ZTREQ,ZTSTOP
 I QFLG D  I 1
 .S ZTSTOP=1
 .S Y=$$S^%ZTLOAD("STOPPED PROCESSING AT CIEN "_LASTCIEN)
 E  D
 .S ^XTMP("PX10118P",3)=DATIM
 .S ZTREQ="@"
 S XMSUB="PX*1.0*118 post init has run to completion."
 S:(QFLG) XMSUB="PX*1.0*118 post init was asked to stop."
 K ^TMP($J,"PX10118P")
 S ^TMP($J,"PX10118P",1,0)="Routine to clean up V CPT file"
 I QFLG D  D FIN Q
 .S ^TMP($J,"PX10118P",2,0)="was asked to stop on "_$$FMTE^XLFDT(DATIM)_"."
 .S ^TMP($J,"PX10118P",3,0)=" "
 .S ^TMP($J,"PX10118P",4,0)="Use the entry point QUEUE^PX10118P to resume clean up."
 S ^TMP($J,"PX10118P",2,0)="ran to completion on "_$$FMTE^XLFDT(DATIM)_"."
 S ^TMP($J,"PX10118P",3,0)="Post init routine PX10118P can be deleted."
 S ^TMP($J,"PX10118P",4,0)="Number of all scanned V CPT records: "_$P(^XTMP("PX10118P",1),U,3)
 S ^TMP($J,"PX10118P",5,0)="Number of cleaned/updated records: "_$P(^XTMP("PX10118P",1),U,2)
 S ^TMP($J,"PX10118P",6,0)="including deleted records: "_$P(^XTMP("PX10118P",1),U,4)
 S ^TMP($J,"PX10118P",7,0)=" "
 I $D(^XTMP("NOT A CPT CODE")) D
 .S ^TMP($J,"PX10118P",8,0)=$P(^XTMP("PX10118P",1),U,5)_" records with not valid CPT code were identified."
 .S ^TMP($J,"PX10118P",9,0)="They have to be investigated and addressed individually."
FIN S XMDUZ="Patch PX*1.0*118"
 S XMTEXT="^TMP($J,""PX10118P"","
 S XMY(DUZ)=""
 D ^XMD
 K ^TMP($J,"PX10118P")
 S ZTREQ="@"
 Q
 ;
QUEUE ;Line tag for field to use to requeue clean up
 N X,PX10118P
 S PX10118P=1
 D EN1
 Q
PRVNARR(CPT) ;calculate provider narrative
 N PNV S PNV=$$EXTTEXT^PXUTL1(CPT,1,81,2) ;text
 Q +$$PROVNARR^PXAPI($G(PNV),9000010.18) ;prov narr
