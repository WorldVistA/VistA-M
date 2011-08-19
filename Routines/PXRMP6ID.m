PXRMP6ID ; SLC/AGP - Inits for PXRM*2.0*6 ;11/25/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;
 Q
 ;====================================================
BDICONV ;
 N BDI,BDI2,DA,DIE,DR,ITEM,NAME,NLINES,RGBDI,RGBDI2,TEXT
 K ^TMP("PXRMXMZ",$J)
 S TEXT(1)="Converting Dialog Elements from BDI to BDI2."
 S TEXT(2)="See Mailman message for more details."
 D MES^XPDUTL(.TEXT)
 S NLINES=1,TEXT="Dialog Elements names that were converted."
 S ^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 S DIE="^PXRMD(801.41,"
 S BDI=$O(^YTT(601,"B","BDI","")) Q:BDI'>0
 S BDI2=$O(^YTT(601,"B","BDI2","")) Q:BDI2'>0
 S BDI=BDI_";YTT(601,",BDI2=BDI2_";YTT(601,"
 S RGBDI=$O(^PXRMD(801.41,"B","PXRM BDI RESULT GROUP","")) Q:RGBDI'>0
 S RGBDI2=$O(^PXRMD(801.41,"B","PXRM BDI II RESULT GROUP","")) Q:RGBDI2'>0
 S DA=0 F  S DA=$O(^PXRMD(801.41,DA)) Q:DA'>0  D
 .S ITEM=$P($G(^PXRMD(801.41,DA,1)),U,5) Q:ITEM'>0
 .I BDI=ITEM D
 ..S NAME=$P($G(^PXRMD(801.41,DA,0)),U)
 ..S DR="15////^S X=BDI2"
 ..I $P($G(^PXRMD(801.41,DA,0)),U,15)=RGBDI D
 ...S DR=DR_";55////^S X=RGBDI2" D ^DIE
 ..D ^DIE
 ..S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=NAME
 I NLINES=1 D
 .S NLINES=NLINES+1
 .S ^TMP("PXRMXMZ",$J,NLINES,0)="No dialog elements were converted."
 D SEND^PXRMMSG("Dialog elements converted from BDI to BDI2")
 K ^TMP("PXRMXMZ",$J)
 Q
CHECKRG ;
 ;list non-National Result Groups that need to be mapped to a MH finding
 N DIEN,NLINES,NODE,TEXT
 K ^TMP("PXRMXMZ",$J)
 S NLINES=0
 S DIEN=0 F  S DIEN=$O(^PXRMD(801.41,DIEN)) Q:DIEN'>0  D
 .S NODE=$G(^PXRMD(801.41,DIEN,0))
 .I $P(NODE,U,4)'="S" Q
 .I $P($G(^PXRMD(801.41,DIEN,100)),U)="N" Q
 .S TEXT="Result Group: "_$P(NODE,U)_" needs to be mapped to an MH test and scale."
 .S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 .S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=""
 S TEXT="Dialog Results Groups that need to be mapped to a MH Test."
 I NLINES>0 D SEND^PXRMMSG(TEXT)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
DCLEAN ;
 N CNT,DA,DIEN,DIK,EARRAY,EIEN,RIEN,TEXT
 S RIEN=$O(^PXD(811.9,"B","PXRM RESULT GROUP UPDATE REMINDER",""))
 Q:RIEN'>0
 S DIEN=$P($G(^PXD(811.9,RIEN,51)),U) Q:DIEN'>0
 S TEXT="Removing transport reminder and dialog for Result Groups."
 D MES^XPDUTL(.TEXT)
 S CNT=0 F  S CNT=$O(^PXRMD(801.41,DIEN,10,CNT)) Q:CNT'>0  D
 .S EIEN=$P($G(^PXRMD(801.41,DIEN,10,CNT,0)),U,2)
 .I $P($P($G(^PXRMD(801.41,EIEN,0)),U)," ")'="PXRM" Q
 .S EARRAY(EIEN)=""
 S DIK="^PXRMD(801.41,"
 S DA="" F  S DA=$O(EARRAY(DA)) Q:DA'>0  D ^DIK
 S DA=DIEN D ^DIK
 S DIK="^PXD(811.9,",DA=RIEN D ^DIK
 Q
 ;
REINDEX ;
 S DIK="^PXRMD(801.41,",DIK(1)=4 D ENALL^DIK
 Q 
STORERG ;
 ;store result groups for an element in XTMP
 N CNT,DIEN,RGIEN,PXRMXTMP,TYPE
 ;S PXRMXTMP="PXRM"_$$NOW^XLFDT
 S PXRMXTMP="PXRM PATCH 6"
 K ^XTMP(PXRMXTMP)
 S ^XTMP(PXRMXTMP,0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"PXRM PATCH 6 DIALOG CONVERSION"
 S DIEN=0,CNT=0 F  S DIEN=$O(^PXRMD(801.41,DIEN)) Q:DIEN'>0  D
 .S TYPE=$P($G(^PXRMD(801.41,DIEN,0)),U,4)
 .I TYPE'="E",TYPE'="G" Q
 .I $P($G(^PXRMD(801.41,DIEN,0)),U,15)="" Q
 .S CNT=CNT+1
 .S ^XTMP(PXRMXTMP,"PXRM DCONV",CNT)=DIEN_U_+$P($G(^PXRMD(801.41,DIEN,0)),U,15)
 .S $P(^PXRMD(801.41,DIEN,0),U,15)=""
 Q
 ;
TESTMTCH(DIEN,RIEN,NLINES) ;
 ;validate if finding item and Result Group finding item match
 N DNAME,DTEST,RNAME,RTEST,RESULT,TEXT
 S DTEST=+$P($G(^PXRMD(801.41,DIEN,1)),U,5)
 S RTEST=+$P($G(^PXRMD(801.41,RIEN,50)),U)
 S RESULT=$S(DTEST=0:0,RTEST=0:0,DTEST'=RTEST:0,1:1)
 I RESULT=1 Q RESULT
 S DNAME=$P($G(^PXRMD(801.41,DIEN,0)),U)
 ;Release with Exchange no reason to print error, entry already updated
 I DNAME="VA-MH DOMG" Q 0
 S RNAME=$P($G(^PXRMD(801.41,RIEN,0)),U)
 S TEXT="Result Group: "_RNAME_" could not be moved for the following"
 S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 S TEXT="element "_DNAME_"."
 S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 S TEXT="Manual Correction is needed."
 S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=""
 ;D BMES^XPDUTL(.TEXT)
 Q RESULT
 ;
WRITERG ;
 ;write RG from XTMP back to file 801.41
 N CNT,DA,DIE,DR,FDA,NLINES,PXRMXTMP,RGIEN,TEXT
 S NLINES=0
 K ^TMP("PXRMXMZ",$J)
 S TEXT(1)="Moving Result Group to new multiple location."
 S TEXT(2)="See MailMan message for any error."
 D BMES^XPDUTL(.TEXT)
 S PXRMXTMP="PXRM PATCH 6"
 I $D(^XTMP(PXRMXTMP,"PXRM DCONV"))=0 Q
 S CNT=0 F  S CNT=$O(^XTMP(PXRMXTMP,"PXRM DCONV",CNT)) Q:CNT'>0  D
 .S DA=$P($G(^XTMP(PXRMXTMP,"PXRM DCONV",CNT)),U)
 .S RGIEN=$P($G(^XTMP(PXRMXTMP,"PXRM DCONV",CNT)),U,2)
 .I $$TESTMTCH(DA,RGIEN,.NLINES)=0 Q
 .S DA(1)=DA
 .S FDA(801.41121,"+1,"_DA(1)_",",.01)=RGIEN
 .D UPDATE^DIE("","FDA","","MSG")
 .I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 1
 S TEXT="Result Groups that could not be moved."
 I NLINES>0 D SEND^PXRMMSG(TEXT)
 K ^XTMP(PXRMXTMP)
 K ^TMP("PXRMXMZ",$J)
 Q
