PXRMGECU ;SLC/AGP,JVS - CLINICAL REMINDERS ;7/14/05  10:45
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 Q
FINISHED(DFN,ANS) ;Delete 801.5 entries if finished
 ;ANS=Answer to YES/NO button should be 1 or will quit
 Q:DFN=""
 Q:ANS=0
 S PATDA="" F  S PATDA=$O(^PXRMD(801.5,"B",DFN,PATDA)) Q:PATDA=""  D
 .S DA=PATDA,DIK="^PXRMD(801.5," D ^DIK
 K DA,DIK,PATDA
 Q
 ;
CON(IEN,DFN) ;CHECK TO see if 2 DIA ARE DONE to display consult
 N OK
 ;
 S OK=0
 S GEC1DA=$O(^PXRMD(801.41,"AC","GEC1",0))
 S GEC2DA=$O(^PXRMD(801.41,"AC","GEC2",0))
 S GEC3DA=$O(^PXRMD(801.41,"AC","GEC3",0))
 S GECFDA=$O(^PXRMD(801.41,"AC","GECF",0))
 Q:IEN'=GEC1DA!(IEN'=GEC2DA)!(IEN'=GEC3DA) OK
 ;
 S CNT=0
 I $D(^PXRMD(801.5,"AD",DFN,"GEC1")) S CNT=CNT+1
 I $D(^PXRMD(801.5,"AD",DFN,"GEC2")) S CNT=CNT+1
 I $D(^PXRMD(801.5,"AD",DFN,"GEC3")) S CNT=CNT+1
 ;
 I CNT>1 S OK=1
 Q OK
 ;
DEL(NOTEIEN) ;Delete HF and 801.5 Called from DELETE^TIUEDI1
 N DFN,TIUNODE,FILEIEN,GEC,ENCDT,GECNODE,GECT,GECDA,HFDA
 N HFARY
 Q:'$D(^PXRMD(801.5,"ACOPY",NOTEIEN))
 S DFN=$O(^PXRMD(801.5,"ACOPY",NOTEIEN,0))
 S ENCDT=$O(^PXRMD(801.5,"ACOPY",NOTEIEN,DFN,0))
 I $D(^PXRMD(801.5,"ANOTE",NOTEIEN)) D
 .S GEC="" F  S GEC=$O(^PXRMD(801.5,"ANOTE",NOTEIEN,GEC)) Q:GEC=""  D
 ..S FILEIEN=0 F  S FILEIEN=$O(^PXRMD(801.5,"ANOTE",NOTEIEN,GEC,FILEIEN)) Q:FILEIEN=""  D
 ...S GECNODE=$G(^PXRMD(801.5,FILEIEN,0))
 ...S GECT=$P(GECNODE,"^",3),GECDA=$O(^PX(839.7,"B",GECT,0))
 ...S HFDA=0 F  S HFDA=$O(^AUPNVHF("AED",ENCDT,DFN,GECDA,HFDA)) Q:HFDA=""  D
 ....S HFARY(HFDA)=""
 ...S DA=FILEIEN S DIK="^PXRMD(801.5," D ^DIK
 E  I $D(^PXRMD(801.5,"ACOPY",NOTEIEN)) D
 .S GECT="" F  S GECT=$O(^PXRMD(801.5,"ACOPY",NOTEIEN,DFN,ENCDT,GECT)) Q:GECT=""  D
 ..S GECDA=$O(^PX(839.7,"B",GECT,0))
 ..S HFDA=0 F  S HFDA=$O(^AUPNVHF("AED",ENCDT,DFN,GECDA,HFDA)) Q:HFDA=""  D
 ...S HFARY(HFDA)=""
 I $D(HFARY) D
 .;
 .N ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC,ZTSK,GECIEN,GET
 .;
 .S ZTIO="ORW/PXAPI RESOURCE"
 .S ZTRTN="REMOVE^PXRMGECK"
 .S ZTDTH=$H
 .S ZTSAVE("GECT")=""
 .S ZTSAVE("HFARY(")=""
 .S ZTDESC="PXRM remove Health Factors for GEC"
 .D ^%ZTLOAD
 ;Clean up ACOPY nodes
 D ACOPYDEL^PXRMGECK
 Q
 ;
API(RESULT,IEN,DFN,VISIT,WHERE,NOTEIEN) ;
 I '$D(NOTEIEN) S NOTEIEN=1
 N GEC,DFNDT
 S GEC=$$CHECKGEC(IEN)
 I $G(GEC)="" S RESULT=0_U_"" Q
 S RESULT=1_U_$$GECDT(DFN,GEC,VISIT,NOTEIEN)_";"_GEC_U_$$EVAL(DFN,GEC,WHERE)
 ;
 Q
 ;
CHECKGEC(IEN) ;
 N RIEN,DIEN
 I IEN["R" D
 . S RIEN=$E(IEN,2,$L(IEN)) S DIEN=$G(^PXD(811.9,RIEN,51))
 . I $G(DIEN)'="" S GEC=$P($G(^PXRMD(801.41,DIEN,0)),U,16)
 E  S GEC=$P($G(^PXRMD(801.41,IEN,0)),U,16)
 Q $G(GEC)
 ;
GECDT(DFN,GEC,VISIT,NOTEIEN) ;Get Date/Time from file
 N STOP
 S STOP=0
 I $D(^PXRMD(801.5,"B",DFN)) D CURADD
 I '$D(^PXRMD(801.5,"B",DFN)) D NEWADD
 S DFNDT=$O(^PXRMD(801.5,"AC",DFN,0))
 Q DFNDT
 ;
NEWADD ;-Set Data into File 801.5 and 801.55 (history)
 Q:STOP=1
 D
 .Q:$D(^PXRMD(801.5,"AD",DFN,GEC))
 .S GEX(1,801.5,"+1,",.01)=DFN
 .S GEX(1,801.5,"+1,",.02)=$$NOW^XLFDT
 .S GEX(1,801.5,"+1,",.03)=GEC
 .S GEX(1,801.5,"+1,",.04)=+$G(NOTEIEN)
 .S GEX(1,801.5,"+1,",.05)=DUZ
 .S GEX(1,801.5,"+1,",.06)=DT
 .S ^PXRMD(801.5,"ACOPY",+$G(NOTEIEN),DFN,$G(GEX(1,801.5,"+1,",.02)),GEC,DT)=""
 .D UPDATE^DIE("","GEX(1)")
 ;--HISTORY FILE
 S GEX(2,801.55,"+1,",.01)=DFN
 S GEX(2,801.55,"+1,",.02)=$$NOW^XLFDT
 S GEX(2,801.55,"+1,",.03)=GEC
 S GEX(2,801.55,"+1,",.04)=+$G(NOTEIEN)
 S GEX(2,801.55,"+1,",.05)=DUZ
 S GEX(2,801.55,"+1,",.06)=DT
 D UPDATE^DIE("","GEX(2)")
 K GEX
 S STOP=1
 Q
CURADD ;-Set Data into File 801.5 and 801.55 (history)
 Q:STOP=1
 D
 .Q:$D(^PXRMD(801.5,"AD",DFN,GEC))
 .S GEX(1,801.5,"+1,",.01)=DFN
 .S GEX(1,801.5,"+1,",.02)=$O(^PXRMD(801.5,"AC",DFN,0))
 .S GEX(1,801.5,"+1,",.03)=GEC
 .S GEX(1,801.5,"+1,",.04)=+$G(NOTEIEN)
 .S GEX(1,801.5,"+1,",.05)=DUZ
 .S GEX(1,801.5,"+1,",.06)=DT
 .S ^PXRMD(801.5,"ACOPY",+$G(NOTEIEN),DFN,$G(GEX(1,801.5,"+1,",.02)),GEC,DT)=""
 .D UPDATE^DIE("","GEX(1)")
 ;--HISTORY FILE
 S GEX(2,801.55,"+1,",.01)=DFN
 S GEX(2,801.55,"+1,",.02)=$O(^PXRMD(801.5,"AC",DFN,0))
 S GEX(2,801.55,"+1,",.03)=GEC
 S GEX(2,801.55,"+1,",.04)=+$G(NOTEIEN)
 S GEX(2,801.55,"+1,",.05)=DUZ
 S GEX(2,801.55,"+1,",.06)=DT
 D UPDATE^DIE("","GEX(2)")
 K GEX
 S STOP=1
 Q
 ;
STATUS(DFN) ;Evaluate The status of the Referral
 ;
 N STOP,ZTSK
 S STOP=0
 I $D(^PXRMD(801.5,"ATASK",DFN)) S ZTSK=$O(^PXRMD(801.5,"ATASK",DFN,0)) D
 .D STAT^%ZTLOAD
 .I ZTSK(0)=1 D
 ..I 12[ZTSK(1) D
 ...S MESSAGE="Data is Changing!! Please Check Status Again^GEC Referral NO Status Available^0"
 ...S STOP=1
 Q:STOP=1 MESSAGE
 ;
 ;Returned
 ;sentence ~ sentence ~ sentence ^ OK or YES/NO BOX
 ;
 N MISSING,MESSAGE,HFDA,STOP,BOX
 S BOX=1
 D ACOPYDEL^PXRMGECK
 ;
 ;GET IEN FOR DATA SOURCES FOR GEC
 I $D(^PX(839.7,"B","GEC1")) S GEC1=$O(^PX(839.7,"B","GEC1",""))
 I $D(^PX(839.7,"B","GEC2")) S GEC2=$O(^PX(839.7,"B","GEC2",""))
 I $D(^PX(839.7,"B","GEC3")) S GEC3=$O(^PX(839.7,"B","GEC3",""))
 I $D(^PX(839.7,"B","GECF")) S GECF=$O(^PX(839.7,"B","GECF",""))
 ;
 S STOP=0
 S MESSAGE=" No GEC Referral in progress.^GEC Referral Status"
 S HFDA="" F  S HFDA=$O(^AUPNVHF("C",DFN,HFDA)) Q:HFDA=""  Q:STOP=1  D
 .I $D(^AUPNVHF(HFDA,12)) D
 ..I $P($G(^AUPNVHF(HFDA,12)),"^",1)>0 D
 ...S SOURCE=$P($G(^AUPNVHF(HFDA,812)),"^",3)
 ...Q:SOURCE=""
 ...I (SOURCE=$G(GEC1))!(SOURCE=$G(GEC2))!(SOURCE=$G(GEC3))!(SOURCE=$G(GECF)) D
 ....S STOP=1
 ;
 S (MISSING)=""
 I '$D(^PXRMD(801.5,"B",DFN))&(STOP=0) D
 .S MESSAGE=" No GEC Referral on record.^Current GEC Referral Status"
 Q:'$D(^PXRMD(801.5,"B",DFN)) MESSAGE
 S MESSAGE=""
 ;
 ;
 ; A. look for missing dialog
 S:'$D(^PXRMD(801.5,"AD",DFN,"GEC1")) MISSING=MISSING_1_"^"
 S:'$D(^PXRMD(801.5,"AD",DFN,"GEC2")) MISSING=MISSING_2_"^"
 S:'$D(^PXRMD(801.5,"AD",DFN,"GEC3")) MISSING=MISSING_3_"^"
 S:'$D(^PXRMD(801.5,"AD",DFN,"GECF")) MISSING=MISSING_4
 ;    a. if none missing then set message
 ;I MISSING="" D
 ;    b. if missing then create message
 I MISSING'=""!(MISSING="") D
 .S MESSAGE="The following Dialogs are Complete:~"
 .S:MISSING'[1 MESSAGE=MESSAGE_$P($T(T+7),";",3) D
 ..I +$$TIUSTAT^PXRMGECK(DFN,"GEC1") D
 ...S MESSAGE=MESSAGE_"~"_"       Note is "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC1"),":",2)_"    "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC1"),":",4)_"~"
 .S:MISSING'[2 MESSAGE=MESSAGE_$P($T(T+8),";",3) D
 ..I +$$TIUSTAT^PXRMGECK(DFN,"GEC2") D
 ...S MESSAGE=MESSAGE_"~"_"       Note is "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC2"),":",2)_"    "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC2"),":",4)_"~"
 .S:MISSING'[3 MESSAGE=MESSAGE_$P($T(T+9),";",3) D
 ..I +$$TIUSTAT^PXRMGECK(DFN,"GEC3") D
 ...S MESSAGE=MESSAGE_"~"_"       Note is "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC3"),":",2)_"    "_$P($$TIUSTAT^PXRMGECK(DFN,"GEC3"),":",4)_"~"
 .S:MISSING'[4 MESSAGE=MESSAGE_$P($T(T+10),";",3) D
 ..I +$$TIUSTAT^PXRMGECK(DFN,"GECF") D
 ...S MESSAGE=MESSAGE_"~"_"       Note is "_$P($$TIUSTAT^PXRMGECK(DFN,"GECF"),":",2)_"    "_$P($$TIUSTAT^PXRMGECK(DFN,"GECF"),":",4)_"~"
 .I $E(MESSAGE,$L(MESSAGE))'="~" S MESSAGE=MESSAGE_"~"
 .I MISSING'="" S MESSAGE=MESSAGE_$P($T(T+11),";",3)
 .S:MISSING[1 MESSAGE=MESSAGE_$P($T(T+7),";",3)
 .S:MISSING[2 MESSAGE=MESSAGE_$P($T(T+8),";",3)
 .S:MISSING[3 MESSAGE=MESSAGE_$P($T(T+9),";",3)
 .S:MISSING[4 MESSAGE=MESSAGE_$P($T(T+10),";",3)
 ;
 I MISSING="" S MESSAGE=MESSAGE_"~"_$P($T(T+5),";",3)
 S MESSAGE=MESSAGE_$P($T(T+6),";",3)
 S MESSAGE=MESSAGE_"^Current GEC Referral Status"_"^"_BOX
 ;
 Q MESSAGE
 ;
EVAL(DFN,GEC,WHERE) ;Evaluate for missing dialogs
 ;DFN=PATIENT DFN
 ;GEC=Identify for Dialog
 ;WHERE=What part of the dialog this call is comming from
 ; 0=Object at the start
 ; 1=Finished button
 ;
 ;Returned
 ;Box Header ^  Message ^ Box display Flag
 ;
 ;Clean up ACOPY node
 D ACOPYDEL^PXRMGECK
 ;
 N MISSING,MESSAGE,DIANAME,FORTH,BOX
 ;
 ;Getting the Names fo the dialogs
 I GEC="GEC1" S DIANAME=$P($T(T+1),";",3)
 I GEC="GEC2" S DIANAME=$P($T(T+2),";",3)
 I GEC="GEC3" S DIANAME=$P($T(T+3),";",3)
 I GEC="GECF" S DIANAME=$P($T(T+4),";",3)
 ;
 ;Check to see if 4th is done;add 1 or 0 to end of message
 ;if 1 the GUI should bring up a modal box asking if finished
 S FORTH=0
 S:$D(^PXRMD(801.5,"AD",DFN,"GECF"))!(GEC["GECF") FORTH=1
 I 'WHERE S FORTH=0
 ;
 ;
 S (MISSING,MESSAGE)=""
 Q:'$D(^PXRMD(801.5,"B",DFN)) MESSAGE
 I WHERE Q:FORTH=0 MESSAGE
 ;
 ;
 ; A. look for missing dialog
 S:'$D(^PXRMD(801.5,"AD",DFN,"GEC1"))&(GEC'["GEC1") MISSING=MISSING_1_"^"
 S:'$D(^PXRMD(801.5,"AD",DFN,"GEC2"))&(GEC'["GEC2") MISSING=MISSING_2_"^"
 S:'$D(^PXRMD(801.5,"AD",DFN,"GEC3"))&(GEC'["GEC3") MISSING=MISSING_3_"^"
 S:'$D(^PXRMD(801.5,"AD",DFN,"GECF"))&(GEC'["GECF") MISSING=MISSING_4
 ;    a. if none missing then set message
 I MISSING="" D
 .I WHERE S MESSAGE=$P($T(T+5),";",3)_$P($T(T+6),";",3)
 .I 'WHERE S MESSAGE=$P($T(T+5),";",3)
 ;    b. if missing then create message
 I MISSING'="" D
 .S MESSAGE="The Following Dialogs are Missing:~"
 .S:MISSING[1 MESSAGE=MESSAGE_$P($T(T+7),";",3)
 .S:MISSING[2 MESSAGE=MESSAGE_$P($T(T+8),";",3)
 .S:MISSING[3 MESSAGE=MESSAGE_$P($T(T+9),";",3)
 .S:MISSING[4 MESSAGE=MESSAGE_$P($T(T+10),";",3)
 .Q:'WHERE
 .S MESSAGE=MESSAGE_$P($T(T+6),";",3)_$P($T(T+12),";",3)_$P($T(T+13),";",3)
 ;
 S BOX="GEC Referral Completion Status"
 S MESSAGE=BOX_"^"_MESSAGE_"^"_FORTH
 Q MESSAGE
 ;
T ;TEXT
 ;; Social Services,
 ;; Nursing Assessment,
 ;; Care Recommendations,
 ;; Care Coordination
 ;; All Dialogs are Finished.
 ;; ~~Is this Referral Complete?
 ;; ~    Social Services
 ;; ~    Nursing Assessment
 ;; ~    Care Recommendations
 ;; ~    Care Coordination
 ;; ~The Following Dialogs are Missing:~
 ;; ~~(If you select Yes, the current REFERRAL ~will be completed and the information ~from the missing dialogs cannot be added.
 ;; ~~If you select No, the current REFERRAL ~remains open.)
 Q
