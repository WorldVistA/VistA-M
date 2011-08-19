LRLNC1 ;DALOI/CA-LOOKUP LOINC CODE ;1-OCT-1998
 ;;5.2;LAB SERVICE;**215,278**;Sep 27,1994
 ;Reference to ^DD supported by IA 10154
 ;=================================================================
 ; Ask VistA test to Lookup LOINC code in Lab Test file #60
 W @IOF
START ;entry point from option LR LOINC LOOKUP
 D TEST
 I $G(LREND) G EXIT
 D SPEC
 I $G(LREND) D EXIT G START
ENT S DIC="^LAB(95.3,",DIC(0)="AEQMZ"
 S DIC("B")=LRTEST_".."_$G(LRSPECL)
 S DIC("A")="LOINC Name..Specimen: "
 W !,$$CJ^XLFSTR(" Your initial lookup entry is ",IOM)
 W !,$$CJ^XLFSTR(DIC("B"),IOM)
 W !,$$CJ^XLFSTR("e.g. TEST NAME..SPECIMEN",IOM),!
 D ^DIC
 I $D(DIRUT) G START
 I Y=-1 W !!,"NO MATCHES FOUND" G START
 S LRCODE=+Y
 D DISPL
 G START
EXIT K DA,DIC,DIE,DINUM,DIR,DIRUT,DR,DTOUT,I,LRCODE,LRDATA,LREND,LRLNC,LRLNC0,LRLOINC,LRELEC,LRIEN,LRNLT,LRSPEC,LRSPECL,LRSPECN,LRTIME,LRTEST,LRUNITS,S,Y
 QUIT
TEST W !! K DIR,DIRUT
 S DIR(0)="PO^60:QNEMZ,",DIR("A")="VistA Lab Test to Lookup LOINC "
 S DIR("?")="Select Lab test you wish to lookup LOINC Code"
 D ^DIR K DIR
 I $D(DIRUT)!'Y K DIRUT S LREND=1 Q
 S LRIEN=+Y,LRTEST=$P(Y,U,2)
 Q
SPEC ; Ask Specimen- Lookup in Specimen multiple in Lab Test file #60
 K DA,DIC,DIE,DR
 S DA(1)=LRIEN
 S DIC="^LAB(60,"_LRIEN_",1,"
 S DIC(0)="AQEMZ"
 S DIC("A")="Specimen source: "
 S DIC("P")=$P(^DD(60.01,0),"^",2)
 D ^DIC
 I $D(DIRUT)!(Y=-1) K DIC,DA,DIRUT S LREND=1 Q
 S LRSPEC=$P(Y,U,2),LRSPECN=Y(0,0)
 ;Check to see if linked to file 64.061.  If not, then let enter link.
 I '$P($G(^LAB(61,LRSPEC,0)),U,9) D  Q
 .W !!,"There is not a LEDI HL7 code for "_LRSPECN,".",!
 S LRELEC=$P($G(^LAB(61,LRSPEC,0)),U,9)
 I 'LRELEC G SPEC
 S LRSPECL=$P(^LAB(64.061,LRELEC,0),U,2)
 Q
DISPL ;Show LOINC entry selected in file 95.3
 D DISPL^LRLNCC
 Q
