PSBPXLP ;BIR/RMS - BCMA2PCE FOR IMMUNIZATIONS, TASKED ; 6/23/09 4:16pm
 ;;3.0;BAR CODE MED ADMIN;**47**;Mar 2004;Build 7
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; File 50.7/2180
 ; File 9999999.14/1990
 ; ^AUPNVIMM("AA"/2313
 ;
 ;Class III to Class I Conversion Project
 ;Contributions of George Holcomb (West Palm Beach) and
 ;Geri Wittenberg (Hines, now at North Chicago) are acknowleged.
 ;--------------------------------------------------------------
 ;
TASK I $D(ZTQUEUED) G TASK2
 N %DT,DTOUT,X,X1,X2,Y,PSBDTB,PSBUDT
 S X1=DT,X2=-1 D C^%DTC S PSBDTB=X\1
 W !,"Immunizations Documentation by BCMA",!
 S %DT="AEP",%DT("A")="Select START DATE: "
 S %DT("B")=$$FMTE^XLFDT(X),%DT(0)=-PSBDTB
 D ^%DT
 Q:Y'>0
 S PSBUDT=$$FMADD^XLFDT(Y,1)\1
 D TASK2
 Q
 ;
TASK2 N PAT,REC,STARTDT,X,X1,X2
 N PSB507,PSBDFN,PSBIMM,PSBDX,PSBDT,PSBDATE,PSBWHO
 S X1=$G(PSBUDT,DT),X2=-1 D C^%DTC S STARTDT=X-.000001
 S PAT=0 F  S PAT=$O(^PSB(53.79,"AADT",PAT)) Q:'PAT  D
 .S PSBDATE=STARTDT F  S PSBDATE=$O(^PSB(53.79,"AADT",PAT,PSBDATE)) Q:'PSBDATE!(PSBDATE'<DT)  D
 ..S REC=0 F  S REC=$O(^PSB(53.79,"AADT",PAT,PSBDATE,REC)) Q:'REC  D
 ...Q:$P($G(^PSB(53.79,REC,0)),"^",9)'="G"
 ...S PSB507=$P(^PSB(53.79,REC,0),"^",8) Q:'+PSB507
 ...S PSBIMM=+$G(^PS(50.7,PSB507,"IMM")) Q:'+PSBIMM
 ...S PSBDFN=$P(^PSB(53.79,REC,0),"^")
 ...S PSBDT=$P(^PSB(53.79,REC,0),"^",6)\1
 ...S PSBWHO=$P(^PSB(53.79,REC,0),"^",7)
 ...W:$E(IOST)="C" !,$E($$GET1^DIQ(2,PSBDFN,.01),1,20),?25,$E($$GET1^DIQ(9999999.14,PSBIMM,.01),1,12)," (",$$FMTE^XLFDT(PSBDT,2),")",?50,$$GET1^DIQ(200,PSBWHO,.01) ; FOR TROUBLESHOOTING ASSISTANCE
 ...I $D(^AUPNVIMM("AA",PSBDFN,PSBIMM,9999999-PSBDT)) D  Q  ;->
 ....I $E(IOST)="C" W !,"Result: Immunization already on file."
 ...D BCMA2PCE^PSBPXFL(PSBDFN,PSBIMM,"",PSBDT,PSBWHO)
 Q
