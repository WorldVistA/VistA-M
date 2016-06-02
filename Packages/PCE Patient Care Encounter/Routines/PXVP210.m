PXVP210 ;BPOIFO/LMT - PX*1*210 KIDS Routine ;11/03/15  16:47
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**210**;Aug 12, 1996;Build 21
 ;
 ; Reference to ^PXRMINDX(9000010.11) supported by ICR #4290 and #4114
 ; Reference to INDEXD^PXRMDIEV supported by ICR #6059
 ; Reference to ^DD(9000010.11,.01,12) and ^DD(9000010.11,.01,12.1) supported by ICR #6256
 ;
 Q
 ;
PRE ; pre-install entry for patch PX*1*210
 N DIK,DA
 ;
 ; delete AC, AHR1 and AHR2 x-refs from V IMMUNIZATION file if they exist
 K DIK,DA S DIK="^DD(9000010.11,.01,1,",DA=4,DA(1)=.01,DA(2)=9000010.11 D ^DIK ; AC
 K DIK,DA S DIK="^DD(9000010.11,1201,1,",DA=2,DA(1)=1201,DA(2)=9000010.11 D ^DIK ; AHR1
 K DIK,DA S DIK="^DD(9000010.11,1403,1,",DA=2,DA(1)=1403,DA(2)=9000010.11 D ^DIK ; AHR2
 ; delete AC, AHR1 and AHR2 x-refs from V SKIN TEST file if they exist
 K DIK,DA S DIK="^DD(9000010.12,.01,1,",DA=4,DA(1)=.01,DA(2)=9000010.12 D ^DIK ; AC
 K DIK,DA S DIK="^DD(9000010.12,.06,1,",DA=2,DA(1)=.06,DA(2)=9000010.12 D ^DIK ; AHR2
 K DIK,DA S DIK="^DD(9000010.12,1201,1,",DA=2,DA(1)=1201,DA(2)=9000010.12 D ^DIK ; AHR1
 ; delete AU, AU1 and AU2 x-refs from IMMUNIZATION LOT file if they exist
 K DIK,DA S DIK="^DD(9999999.41,.01,1,",DA=2,DA(1)=.01,DA(2)=9999999.41 D ^DIK ; AU
 K DIK,DA S DIK="^DD(9999999.41,.02,1,",DA=1,DA(1)=.02,DA(2)=9999999.41 D ^DIK ; AU1
 K DIK,DA S DIK="^DD(9999999.41,.04,1,",DA=2,DA(1)=.04,DA(2)=9999999.41 D ^DIK ; AU2
 Q
 ;
POST ; KIDS Post install for PX*1*210
 D BMES("*** Post install started ***")
 ;
 D CVIMMXR ; Update ACR cross-reference on V IMMUNIZATION file
 D CIMMXR ; Create ACR cross-reference on IMMUNIZATION file
 D BLDVIMM ; Rebuild Clinical Reminder index on V Immunization file
 D DDSEC ; Update DD security on Immunization and Skin Test files
 D TSKDSG ; Task job to split Dosage into Dose and Units
 D MVDIAGS ; Move diagnosis data from old fields to new fields
 D DELSCRN ; Delete screen nodes from V Immunization .01 DD
 ;
 D BMES("*** Post install completed ***")
 Q
 ;
CVIMMXR ; Update ACR cross-reference on V IMMUNIZATION file
 N PXERR,PXXR,PXRES
 ;
 D BMES("*** Updating ACR cross-reference on V IMMUNIZATION file ***")
 ;
 S PXXR("FILE")=9000010.11
 S PXXR("NAME")="ACR"
 S PXXR("TYPE")="MU"
 S PXXR("USE")="A"
 S PXXR("EXECUTION")="R"
 S PXXR("ACTIVITY")="IR"
 S PXXR("SHORT DESCR")="Clinical Reminders index."
 S PXXR("DESCR",1)="This cross-reference builds four indexes, two for finding all patients"
 S PXXR("DESCR",2)="with a particular immunization and two for finding all the immunizations a"
 S PXXR("DESCR",3)="patient has. "
 S PXXR("DESCR",4)="The indexes are stored in the Clinical Reminders index global as:"
 S PXXR("DESCR",5)="^PXRMINDX(9000010.11,""IP"",IMMUNIZATION,DFN,DATE,DAS)"
 S PXXR("DESCR",6)="^PXRMINDX(9000010.11,""CVX"",""IP"",CVX CODE,DFN,DATE,DAS) "
 S PXXR("DESCR",7)="and"
 S PXXR("DESCR",8)="^PXRMINDX(9000010.11,""PI"",DFN,IMMUNIZATION,DATE,DAS) "
 S PXXR("DESCR",9)="^PXRMINDX(9000010.11,""CVX"",""PI"",DFN,CVX CODE,DATE,DAS) "
 S PXXR("DESCR",10)="respectively. "
 S PXXR("DESCR",11)="For all the details, see the Clinical Reminders Index Technical"
 S PXXR("DESCR",12)="Guide/Programmer's Manual."
 S PXXR("SET")="D SVFILE^PXPXRM(9000010.11,.X,.DA)"
 S PXXR("KILL")="D KVFILE^PXPXRM(9000010.11,.X,.DA)"
 S PXXR("WHOLE KILL")="K ^PXRMINDX(9000010.11)"
 S PXXR("VAL",1)=.01
 S PXXR("VAL",1,"SUBSCRIPT")=1
 S PXXR("VAL",1,"COLLATION")="F"
 S PXXR("VAL",2)=.02
 S PXXR("VAL",2,"SUBSCRIPT")=2
 S PXXR("VAL",2,"COLLATION")="F"
 S PXXR("VAL",3)=.03
 S PXXR("VAL",3,"SUBSCRIPT")=3
 S PXXR("VAL",3,"COLLATION")="F"
 S PXXR("VAL",4)=1201
 S PXXR("VAL",4,"COLLATION")="F"
 D CREIXN^DDMOD(.PXXR,"k",.PXRES,,"PXERR")
 I $G(PXRES) D
 . D MES("Cross-reference "_$P(PXRES,U,2)_" (#"_$P(PXRES,U,1)_") was updated successfully.")
 I $G(PXRES)="" D
 . D MES("*** ERROR: Failed to update cross-reference. ***")
 Q
 ;
CIMMXR ; Create ACR cross-reference on IMMUNIZATION file
 N PXERR,PXXR,PXRES
 ;
 D BMES("*** Creating ACR cross-reference on IMMUNIZATION file ***")
 ;
 S PXXR("FILE")=9999999.14
 S PXXR("NAME")="ACR"
 S PXXR("TYPE")="MU"
 S PXXR("USE")="A"
 S PXXR("EXECUTION")="R"
 S PXXR("ACTIVITY")=""
 S PXXR("SHORT DESCR")="Updates Clinical Reminder's index when CVX code changes."
 S PXXR("DESCR",1)="This cross-reference updates the Clinical Reminder's index on the V"
 S PXXR("DESCR",2)="Immunization file when a CVX code changes for an immunization. The indexes"
 S PXXR("DESCR",3)="updated are:"
 S PXXR("DESCR",4)="^PXRMINDX(9000010.11,""CVX"",""IP"",CVX CODE,DFN,DATE,DAS) and"
 S PXXR("DESCR",5)="^PXRMINDX(9000010.11,""CVX"",""PI"",DFN,CVX CODE,DATE,DAS)."
 S PXXR("SET")="Q"
 S PXXR("KILL")="D UPDCVX^PXPXRM(.DA,X1(1),X2(1))"
 S PXXR("VAL",1)=.03
 S PXXR("VAL",1,"COLLATION")="F"
 D CREIXN^DDMOD(.PXXR,"k",.PXRES,,"PXERR")
 I $G(PXRES) D
 . D MES("Cross-reference "_$P(PXRES,U,2)_" (#"_$P(PXRES,U,1)_") was created successfully.")
 I $G(PXRES)="" D
 . D MES("*** ERROR: Failed to create cross-reference. ***")
 Q
 ;
BLDVIMM ; Rebuild Clinical Reminder index on V Immunization file
 N PXDESC,PXFILELIST,PXQDT,PXRTN,PXTASK,PXVOTH
 N ZTCPU,ZTDESC,ZTDTH,ZTIO,ZTKIL,ZTPRI,ZTRTN,ZTSAVE,ZTSK,ZTSYNC,ZTUCI
 ;
 D BMES("*** Task job to rebuild the Clinical Reminders index for V IMMUNIZATION ***")
 ;
 I $D(^PXRMINDX(9000010.11,"CVX")) D  Q  ;ICR 4290
 . D MES("The index has already been rebuilt by previous installation.")
 . D MES("No need to rebuild it again.")
 ;
 S PXQDT=$G(XPDQUES("POS1"))
 I 'PXQDT S PXQDT=$$NOW^XLFDT
 ;
 S PXRTN="BLDVIMMT^PXVP210"
 S PXDESC="Clinical Reminders index rebuild for V IMMUNIZATION"
 S PXVOTH("ZTDTH")=PXQDT
 S PXTASK=$$NODEV^XUTMDEVQ(PXRTN,PXDESC,,.PXVOTH)
 ;
 I $G(PXTASK)>0 D MES("Task number "_PXTASK_" queued.")
 I $G(PXTASK)=-1 D  Q
 . D MES("*** ERROR: Task failed to queue ***")
 Q
 ;
BLDVIMMT ; Queued entry point to rebuild index
 S ZTREQ="@"
 K ^PXRMINDX(9000010.11,"DATE BUILT") ; ICR 4114
 D INDEXD^PXRMDIEV(9000010.11) ; ICR 6059
 D VIMM^PXPXRMI1
 Q
 ;
DDSEC ; Update security access codes on Immunization and Skin Test files
 N PXFILENUM,PXSEC
 ;
 D BMES("*** Updating security access codes on Immunization and Skin Test files ***")
 ;
 S PXSEC("AUDIT")="@"
 S PXSEC("DD")="@"
 S PXSEC("DEL")="@"
 S PXSEC("LAYGO")="@"
 S PXSEC("RD")=""
 S PXSEC("WR")="@"
 ;
 F PXFILENUM=9999999.14,9999999.28 D
 . D FILESEC^DDMOD(PXFILENUM,.PXSEC)
 Q
 ;
TSKDSG ; Task job to split Dosage into Dose and Units
 N PXRTN,PXDESC,PXVOTH,PXTASK
 ;
 D BMES("*** Task job to split V Immunization DOSAGE field (#1312) ***")
 I $G(^XTMP("PXVP210","DOSAGE")) D  Q
 . D MES("The Dosage has already been split by previous installation.")
 . D MES("No need to do it again.")
 ;
 S PXRTN="DOSAGE^PXVP210"
 S PXDESC="Split V Immunization DOSAGE field (1312)"
 S PXVOTH("ZTDTH")=$H
 S PXTASK=$$NODEV^XUTMDEVQ(PXRTN,PXDESC,,.PXVOTH)
 ;
 I $G(PXTASK)>0 D MES("Task number "_PXTASK_" queued.")
 I $G(PXTASK)=-1 D  Q
 . D MES("*** ERROR: Task failed to queue ***")
 Q
 ;
DOSAGE ; Loop through all V Immunization records and determine if Dosage needs to be split
 S ZTREQ="@"
 ;
 N PX13,PXIEN,PXVPDT
 ;
 S PXIEN=0
 F  S PXIEN=$O(^AUPNVIMM(PXIEN)) Q:'PXIEN  D
 . S PX13=$G(^AUPNVIMM(PXIEN,13))
 . I $P(PX13,U,12)'="",$P(PX13,U,13)="" D SPLITDSG(PXIEN)
 ;
 ; Set dosage flag in XTMP so that we know that the dosage split was completed
 S PXVPDT=$$FMADD^XLFDT(DT,365)
 S ^XTMP("PXVP210",0)=PXVPDT_"^"_DT
 S ^XTMP("PXVP210","DOSAGE")=1
 Q
 ;
SPLITDSG(PXIEN) ; Split Dosage field
 N PXFILE,PXIENS,PXDOSAGE,PXDOSE,PXUNITS,PXDELIM,PXFDAE,PXFDAI,PXVALID,PXCOM
 ;
 S PXFILE=9000010.11
 S PXIENS=PXIEN_","
 S PXDOSAGE=$P($G(^AUPNVIMM(PXIEN,13)),U,12)
 S PXDOSAGE=$$TRIM^XLFSTR(PXDOSAGE)
 S (PXDOSE,PXUNITS)=""
 ;
 S PXDELIM=" "
 I PXDOSAGE[";" S PXDELIM=";"
 ;
 S PXDOSE=$P(PXDOSAGE,PXDELIM,1)
 S PXUNITS=$P(PXDOSAGE,PXDELIM,2)
 ;
 K PXFDAE,PXFDAI
 S PXFDAE(PXFILE,PXIENS,1312)=PXDOSE
 S PXFDAE(PXFILE,PXIENS,1313)=PXUNITS
 D VALS^DIE("","PXFDAE","PXFDAI")
 S PXVALID=0
 I $G(PXFDAI(PXFILE,PXIENS,1312))'="^",$G(PXFDAI(PXFILE,PXIENS,1313))'="^" S PXVALID=1
 I PXVALID D FILE^DIE("K","PXFDAI")
 I 'PXVALID D
 . S PXCOM=$G(^AUPNVIMM(PXIEN,811))
 . S PXCOM=$S(PXCOM'="":PXCOM_"; ",1:"")_"Dosage: "_$TR(PXDOSAGE,";"," ")
 . K PXFDAI
 . S PXFDAI(PXFILE,PXIENS,1312)="@"
 . S PXFDAI(PXFILE,PXIENS,81101)=PXCOM
 . D FILE^DIE("KET","PXFDAI")
 Q
 ;
MVDIAGS ;
 ; move the data in the old DIAGNOSIS fields of the V SKIN TEST file
 ; (#9000010.12) to the new fields:
 ; from old fields .08, .09, .1, .11, .12, .13, .14, .15
 ;   to new fields 801, 802, 803, 804, 805, 806, 807, 808 respectively.
 ;
 I $$GET1^DID(9000010.12,.08,"","LABEL")'="DIAGNOSIS" Q  ; Quit if DIAGNOSIS field (#.08) does not exist
 N %,CNT,DA,DIK,DR,J,Q,X,Y,PXVD,PXVNOW,PXVV
 D NOW^%DTC S Y=% D DD^%DT S PXVNOW=Y
 K Q S Q(1)=" ",Q(2)="*** Moving V SKIN TEST file DIAGNOSIS data to new fields."
 S Q(3)="                       Process started "_PXVNOW_" ***"
 D BMES^XPDUTL(.Q)
 S (CNT,PXVV)=0
 F  S PXVV=$O(^AUPNVSK(PXVV)) Q:'PXVV  S PXVD=$P($G(^(PXVV,0)),"^",8,15) I PXVD'="",PXVD'="^^^^^^^" D
 . S:'$D(^AUPNVSK(PXVV,80)) ^AUPNVSK(PXVV,80)=PXVD,CNT=CNT+1
 . F J=8:1:15 S $P(^AUPNVSK(PXVV,0),"^",J)="" ; set diagnosis field values to null
 ;
MVDONE ; DIAGNOSIS data move completed
 D NOW^%DTC S Y=% D DD^%DT S PXVNOW=Y
 K Q S Q(1)=" ",Q(3)=" "_CNT_" entr"_$S(CNT'=1:"ies",1:"y")_" processed."
 S Q(2)="*** Process moving DIAGNOSIS data completed at "_PXVNOW_" ***"
 D BMES^XPDUTL(.Q)
 ;
RMVFLD ; remove DDs for old diagnosis fields .08 to .15
 N PXF,PXJ,PXN S PXJ=1
 S PXF="DIAGNOSIS",PXN=.08 D DELFLD
 F PXN=.09:.01:.15 S PXJ=PXJ+1,PXF="DIAGNOSIS "_PXJ D DELFLD
 Q
DELFLD ; delete field if it exists
 I $$GET1^DID(9000010.12,PXN,"","LABEL")=PXF D
 . D BMES^XPDUTL("***  Deleting field "_PXN_" ***")
 . K DIK,DA S DIK="^DD(9000010.12,",DA=PXN,DA(1)=9000010.12 D ^DIK
 Q
 ;
DELSCRN ; Delete screen nodes from V Immunization .01 DD
 D BMES("*** Deleting screen nodes from V Immunization .01 DD ***")
 K ^DD(9000010.11,.01,12) ;ICR 6256
 K ^DD(9000010.11,.01,12.1) ;ICR 6256
 Q
 ;
BMES(STR) ;
 ; Write string
 D BMES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
MES(STR) ;
 ; Write string
 D MES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
