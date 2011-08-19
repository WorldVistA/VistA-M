PSJ0099 ;BIR/JLC - EVALUATE IV ORDER PROBLEMS ;12/03/2002
 ;;5.0; INPATIENT MEDICATIONS ;**99**;16 DE7 97
 ;
 ;Reference to ^PS(55 supported by DBIA 2191
 ;
ENNV ; Begin check of existing orders
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 K ZTSAVE,ZTSK S ZTRTN="START^PSJ0099",ZTDESC="Inpatient Orders Check (INPATIENT MEDS)",ZTIO="" D ^%ZTLOAD
 W !!,"The check of existing Pharmacy orders is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
START ;run through entries in XTMP("PSOPOST7"
 S JOB=0 I $D(^XTMP("PSOPOST7")) S $P(^("PSOPOST7",0),"^",1)="3030531"
 F  S JOB=$O(^XTMP("PSOPOST7",JOB)) Q:JOB=""  D
 . S DFN=""
 . F  S DFN=$O(^XTMP("PSOPOST7",JOB,"IV",DFN)) Q:DFN=""  D
 .. S PSJORD=""
 .. F  S PSJORD=$O(^XTMP("PSOPOST7",JOB,"IV",DFN,PSJORD)) Q:PSJORD=""  D
 ... W !! S S1="^PS(55,"_DFN_",""IV"","_PSJORD_")",CHK=$P(S1,")")
 ... F  S S1=$Q(@S1) Q:S1=""  Q:$P(S1,",",1,4)'=CHK  W S1," = ",@S1,!
 ... S A=$G(^PS(55,DFN,"IV",PSJORD,0)) I A="" S ^XTMP("PSJ0099",$J,DFN,PSJORD)="NOT ON FILE" Q
 ... S PSSTART=$P(A,"^",2),PSSTOP=$P(A,"^",3),PSSTATUS=$P(A,"^",17)
 ... I PSSTATUS'["S X=" S ^XTMP("PSJ0099",$J,DFN,PSJORD)="STATUS" D  Q
 .... I '$D(^PS(55,DFN,"IV",PSJORD,2)) K ^XTMP("PSJ0099",$J,DFN,PSJORD) Q
 ... S ^XTMP("PSJ0099",$J,DFN,PSJORD)="OTHER" D NOSTOP
 D NOW^%DTC S PSJSTART=$E(%,1,12),CREAT=$E(%,1,7),EXPR=$$FMADD^XLFDT(CREAT,90,0,0,0)
 I $D(^XTMP("PSJ0099",$J)) S ^($J,0)=EXPR_"^"_CREAT
SENDMSG ;Send mail message when check is complete.
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="INPATIENT MEDS ORDER CHECK COMPLETED",XMTEXT="PSG(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSG(1,0)="The check of existing Pharmacy orders for use with Inpatient",PSG(2,0)="Medications 5.0 completed as of "_Y_"."
 I $D(^XTMP("PSOPOST7")) D
 . S PSG(3,0)="There were Pharmacy orders - listed in ^XTMP(""PSOPOST7"",,""IV""",PSG(4,0)="that had changes made."
 . S PSG(5,0)="Please spot check some of the affected orders to be sure",PSG(6,0)="they are now correct."
 . I $D(^XTMP("PSJ0099")) S PSG(7,0)="Some orders could not be changed. These are listed in XTMP(""PSJ0099"".",PSG(8,0)="Please check these patients to be sure their profile is correct."
 D ^XMD
 Q
NOSTOP S D2=0,OLD=""
 F  S D2=$O(^PS(55,DFN,"IV",PSJORD,"A",D2)) Q:'D2  D
 . S D3=0
 . F  S D3=$O(^PS(55,DFN,"IV",PSJORD,"A",D2,1,D3)) Q:'D3  D
 .. S ACTDATA=^PS(55,DFN,"IV",PSJORD,"A",D2,1,D3,0)
 .. Q:$P(ACTDATA,"^")'="STATUS"  S A=$P(ACTDATA,"^",2)
 .. I A'="DISCONTINUED",A'="EXPIRED",A'="PURGE",A'="ON CALL",A'="NON VERIFIED" Q
 .. S OLD=A
 I OLD="",PSSTOP=1 S OLD="PURGE"
 S STATUS=$S(OLD="DISCONTINUED":"D",OLD="EXPIRED":"E",OLD="PURGE":"P",OLD="ON CALL":"OC",OLD="NON VERIFIED":"N",1:"")
 K DR S DIE="^PS(55,"_DFN_",""IV"",",DA=PSJORD,DA(1)=DFN,DR="100////"_STATUS D ^DIE
 I STATUS="" S $P(^PS(55,DFN,"IV",PSJORD,0),"^",17)=""
 K ^XTMP("PSJ0099",$J,DFN,PSJORD) Q
