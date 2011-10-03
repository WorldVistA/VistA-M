PXRMGECL ;SLC/AGP,JVS - Restore Func & Utilities ;7/14/05  10:43
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 Q
 ;
CNT(DOC,DFN) ;Count number of referals per Provider and patient
 N DATE
 S CNT=0
 S DATE=0 F  S DATE=$O(^TMP("PXRMGEC",$J,"DFNCNT",DOC,DFN,DATE)) Q:DATE=""  D
 .S CNT=CNT+1
 Q CNT
POST ;Post Routine to gather old date from health factors
 ;
 D BMES^XPDUTL("Adding data to new file 801.55")
 D BMES^XPDUTL("Please Wait.....Thank you")
 N TIME,DFN,GEC,DA,GECX,GECNA,HF0,HF12,CNT
 S CNT=0
 S TIME=0 F  S TIME=$O(^AUPNVHF("AED",TIME)) Q:TIME=""  D
 .Q:TIME'>3000000
 .S DFN=0 F  S DFN=$O(^AUPNVHF("AED",TIME,DFN)) Q:DFN=""  D
 ..S GEC=0 F  S GEC=$O(^AUPNVHF("AED",TIME,DFN,GEC)) Q:GEC=""  D
 ...S GECNA=$P($G(^PX(839.7,GEC,0)),"^",1) Q:GECNA'["GEC"
 ...S DA=0 F  S DA=$O(^AUPNVHF("AED",TIME,DFN,GEC,DA)) Q:DA=""  D
 ....S HF0=$G(^AUPNVHF(DA,0))
 ....S HF12=$G(^AUPNVHF(DA,12))
 ....S HF801=$G(^AUPNVHF(DA,801))
 ....S GECX(1,801.55,"+1,",.01)=DFN
 ....S GECX(1,801.55,"+1,",.02)=$P(HF12,"^",1)
 ....S GECX(1,801.55,"+1,",.03)=GECNA
 ....S GECX(1,801.55,"+1,",.05)=+$P($P(HF801,"^",2)," ",2)
 ....S GECX(1,801.55,"+1,",.06)=$P($P(HF12,"^",1),".",1)
 ....I '$D(^PXRMD(801.55,"AE",DFN,$P(HF12,"^",1),GECNA,+$P($P(HF801,"^",2)," ",2))) D
 .....D UPDATE^DIE("","GECX(1)")
 .....S CNT=CNT+1
 .....K GECX,HF0,HF12
 S DIK="^PXRMXT(810.3,",DIK(1)="6^AHLID"
 D IXALL^DIK
 Q
 ;
REOPEN(NUM) ;Move a referral from the Historial 801.55 to 801.5
 Q:NUM=""
 N I,GEX
 S I=0 F  S I=$O(^TMP("PXRMGEC_CK2",$J,NUM,I)) Q:I=""  D
 .S DA=0 F  S DA=$O(^TMP("PXRMGEC_CK2",$J,NUM,I,DA)) Q:DA=""  D
 ..S GEX(1,801.5,"+1,",.01)=$P(^TMP("PXRMGEC_CK2",$J,NUM,I,DA),"^",1)
 ..S GEX(1,801.5,"+1,",.02)=$P(^TMP("PXRMGEC_CK2",$J,NUM,I,DA),"^",2)
 ..S GEX(1,801.5,"+1,",.03)=$P(^TMP("PXRMGEC_CK2",$J,NUM,I,DA),"^",3)
 ..S GEX(1,801.5,"+1,",.04)=$P(^TMP("PXRMGEC_CK2",$J,NUM,I,DA),"^",4)
 ..S GEX(1,801.5,"+1,",.05)=$P(^TMP("PXRMGEC_CK2",$J,NUM,I,DA),"^",5)
 ..S GEX(1,801.5,"+1,",.06)=$P(^TMP("PXRMGEC_CK2",$J,NUM,I,DA),"^",6)
 ..D UPDATE^DIE("","GEX(1)")
 Q
 ;
