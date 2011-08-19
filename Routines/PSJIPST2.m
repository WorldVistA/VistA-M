PSJIPST2 ;BIR/LDT-CONVERSION UTILITY TO CHANGE PICK LIST FROM PRIMARY DRUG TO ORDERABLE ITEM ; 15 May 98 / 9:28 AM
 ;;5.0; INPATIENT MEDICATIONS ;**3**;16 DEC 97
 ;
DEQPL ;Convert Existing Pick Lists
 N S1,S2,S3,S4,CNT,ON,X
 S (CNT,S1)=0 F  S S1=$O(^PS(53.5,S1)) Q:'S1  D  S DA=S1,DIK="^PS(53.5,",DIK(1)=".01^AC1" D EN1^DIK
 .F  Q:$$LOCK^PSGPLUTL(S1,"PSGPL")  H 60
 .K ^PS(53.5,"AC",S1),^PS(53.5,"AU",S1)
 .S S2=0 F  S S2=$O(^PS(53.5,S1,1,S2)) Q:'S2  D
 ..S S3=0 F  S S3=$O(^PS(53.5,S1,1,S2,1,S3)) Q:'S3  D
 ...S ND=$G(^PS(53.5,S1,1,S2,1,S3,0)) Q:'ND!$P(ND,U,6)
 ...S S4=$O(^PS(53.5,S1,1,S2,1,S3,1,0))  Q:S4=""
 ...S X=$G(^PS(53.5,S1,1,S2,1,S3,1,S4,0)),X=+$G(^PS(55,S2,5,+ND,1,+X,0)),OIDA=$P($G(^PSDRUG(+X,2)),U)
 ...S $P(ND,U,3)="",$P(ND,U,6)=OIDA,^PS(53.5,S1,1,S2,1,S3,0)=ND I $P(ND,U,5) K DA,DIE S DR=".05////1",DIE="^PS(53.5,"_S1_",1,",DA(1)=S1,DA=S2 D ^DIE K DA,DIE
 .D UNLOCK^PSGPLUTL(S1,"PSGPL") S CNT=CNT+1
 ;
 ;Send mail msg. when PICK LIST CONVERSION  has completed.
 K XMY,PSG S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="UNIT DOSE PICK LIST CONVERSION",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="The conversion of the Pick Lists from Primary Drug to Orderable Item ",PSG(2,0)="has been completed.",PSG(3,0)=CNT_" Pick Lists have been converted."
 N DIFROM D ^XMD
 K PSG,XMY,XMSUB,XMDUZ,XMTEXT
 D NOW^%DTC S $P(^PS(59.7,1,20.5),U,3)=%
ACTPK ; activate Pick List options
 F PSJPKLST="PSJU PLDEL","PSJU PLAPS","PSJU PLPRG","PSJU PLDP","PSJU EUD","PSJU PL","PSJU RET","PSJU PLRP","PSJU PLATCS","PSJU PLUP" D
 .S DIE="^DIC(19,",DA=+$O(^DIC(19,"B",PSJPKLST,0))
 .S DR="2///@" D:DA>0 ^DIE
 K PSJPKLST,DIE,DA,DR
 Q
ENPVNV ; Entry point to begin conversion process to change PV FLAG and NV FLAG
 ; fields from "" to 0.
 ;
 K ZTSAVE,ZTSK S ZTIO="",ZTDTH=$H,ZTDESC="Conversion of Unit Dose Verification fields",ZTRTN="DEQPVNV^PSJIPST2" D ^%ZTLOAD
 ;W !!,"The conversion of Unit Dose verification data has",$S($D(ZTSK):"",1:" NOT")," been queued."
 D MES^XPDUTL(" ")
 S PSJMESSG="The conversion of Unit Dose verification data has"_$S($D(ZTSK):"",1:" NOT")_" been queued." D MES^XPDUTL(PSJMESSG)
 ;I $D(ZTSK) W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 I $D(ZTSK) S PSJMESSG="(to start NOW). YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED." D MES^XPDUTL(PSJMESSG)
 Q
DEQPVNV ; Update NV FLAG and PV FLAG fields so they contain 0 instead of ""
 ; for use by APV and ANV xrefs added on these fields. This only affects
 ; orders for the current admission.
 ;
 K ^XTMP("PSJPVNV") D NOW^%DTC S X1=X,X2=1 D C^%DTC S ^XTMP("PSJPVNV",0)=X
 D NOW^%DTC S PSGDT=+$E(%,1,12),X1=$P(%,"."),X2=-2 D C^%DTC S PSGODT=X_(PSGDT#1)
 S PSJWD="" F  S PSJWD=$O(^DPT("CN",PSJWD)) Q:PSJWD=""  S PSJWG=$$WGNM^PSGVBWU(PSJWD) F DFN=0:0 S DFN=$O(^DPT("CN",PSJWD,DFN)) Q:'DFN  D
 .; removed ref to ^DGPM
 .;S PSJPAD=9999999.9999999-$O(^DGPM("ATID1",DFN,0))
 .;F PSJST="C","O","OC","P","R" F PSGFD=$S(PSJST="O":PSJPAD,1:PSGODT):0 S PSGFD=$O(^PS(55,DFN,5,"AU",PSJST,PSGFD)) Q:'PSGFD  D
 .F PSJST="C","O","OC","P","R" F PSGFD=PSGODT:0 S PSGFD=$O(^PS(55,DFN,5,"AU",PSJST,PSGFD)) Q:'PSGFD  D
 ..F PSGORD=0:0 S PSGORD=$O(^PS(55,DFN,5,"AU",PSJST,PSGFD,PSGORD)) Q:'PSGORD  D
 ...S X=$G(^PS(55,DFN,5,PSGORD,4)) S:X]"" $P(X,U,9,10)=+$P(X,U,9)_U_+$P(X,U,10),^(4)=X
 ...S:'$P(X,U,9) ^PS(55,"APV",DFN,PSGORD)="" S:'$P(X,U,10) ^PS(55,"ANV",DFN,PSGORD)=""
 ;
MAILPVNV ;Send mail msg. when UNIT DOSE VERIFICATION DATA has completed.
 K XMY,PSG S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="Update of Unit Dose Verification Fields",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="The update of the PV FLAG and NV FLAG fields in the PHARMACY PATIENT",PSG(2,0)="file (#55) has completed."
 N DIFROM D ^XMD
 K PSG,XMY,XMSUB,XMDUZ,XMTEXT,^XTMP("PSJPVNV")
 D NOW^%DTC S $P(^PS(59.7,1,20.5),U)=%
 Q
