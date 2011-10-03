PSDUTL ;BIR/CML,JPW,LTL-Utility Routine for FileMan Functions ; 21 Dec 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
INACT ;check for inactive date on drug for 'D' x-ref (file 58.8)
 K PSDFLAG I '$D(^PSD(58.8,DA(2),1,DA(1),"I")) S PSDFLAG=1 Q
 S:$O(^PSD(58.8,DA(2),1,DA(1),"I"))>DT PSDFLAG=1
 Q
DELR ;deletes inactivation reason when inactivation date deleted
 I $D(^PSD(58.8,DA(1),1,DA,0)),'$P(^(0),"^",14) S $P(^(0),"^",15,16)="^"
 Q
IG ;reset sort keys for inventory groups
 F INVGRP=0:0 S INVGRP=$O(^PSI(58.2,INVGRP)) Q:'INVGRP  I $O(^PSI(58.2,INVGRP,3,"D",0)) W "." D IGSET
 K INVGRP
 Q
IGSET S CNT=0 F SK=0:0 S SK=$O(^PSI(58.2,INVGRP,3,"D",SK)) Q:'SK  S NAOU=$O(^PSI(58.2,INVGRP,3,"D",SK,0)),CNT=CNT+1,NAOULP(CNT)=NAOU
 F SK=0:0 S SK=$O(NAOULP(SK)) Q:'SK  S NSK=SK*100,DA(1)=INVGRP,DA=NAOULP(SK),DIE="^PSI(58.2,"_DA(1)_",3,",DR="2///"_NSK D ^DIE K DIE
 K D,D0,DA,D1,DIC,DIE,DQ,DR,X,CNT,NAOU,NAOULP,NSK,SK
 Q
NAOU ;checks for NAOU inpatient site
 S SITE=0
 I '$P($G(^PSD(58.8,PSDA,0)),"^",3) W !!,"You must define a CS inpatient site for this NAOU.",!,"Use the 'Create the Narcotic Area of Use' option to add this data.",!!,"Press <RET> to continue " R X:DTIME S SITE=1 W @IOF
 K X
 Q
STAT ;sets order status cross-reference in file 58.85 (field 6)
 N PSDNL,PSDD,PSDREQ S PSDNL=$P(^PSD(58.85,DA,0),"^",3),PSDD=$P(^(0),"^",4),PSDREQ=$P(^(0),"^",5)
 Q:'PSDNL!('PSDD)!('PSDREQ)
 S ^PSD(58.85,"AC",X,PSDNL,PSDD,PSDREQ,DA)=""
 Q
KSTAT ;kills order status cross-reference in file 58.85 (field 6)
 N PSDNL,PSDD,PSDREQ S PSDNL=$P(^PSD(58.85,DA,0),"^",3),PSDD=$P(^(0),"^",4),PSDREQ=$P(^(0),"^",5)
 Q:'PSDNL!('PSDD)!('PSDREQ)
 K ^PSD(58.85,"AC",X,PSDNL,PSDD,PSDREQ,DA)
 Q
REQ ;sets request # x-ref in file 58.85 (field 4)
 N PSDNL,PSDD S PSDNL=$P(^PSD(58.85,DA,0),"^",3),PSDD=$P(^(0),"^",4)
 Q:'PSDNL!('PSDD)
 S ^PSD(58.85,"AD",PSDNL,PSDD,X,DA)=""
 Q
KREQ ;kills request # x-ref in file 58.85 (field 4)
 N PSDNL,PSDD S PSDNL=$P(^PSD(58.85,DA,0),"^",3),PSDD=$P(^(0),"^",4)
 Q:'PSDNL!('PSDD)
 K ^PSD(58.85,"AD",PSDNL,PSDD,X,DA)
 Q
SAD ;sets 'AD' xref in file 58.81 (field 10)
 S PSDNL=+$P(^PSD(58.81,DA,0),"^",18) I 'PSDNL K PSDNL Q
 S ^PSD(58.81,"AD",X,PSDNL,DA)="" K PSDNL
 Q
KAD ;kills 'AD' x-ref in file 58.81 (field 10)
 S PSDNL=+$P(^PSD(58.81,DA,0),"^",18) I 'PSDNL K PSDNL Q
 K ^PSD(58.81,"AD",X,PSDNL,DA),PSDNL
 Q
SAF ;set 'AF' x-ref on field 3 in 58.81
 S PSDNL=$P(^PSD(58.81,DA,0),"^",3),PSDTYPE=$P(^(0),"^",2)
 I 'PSDNL!('PSDTYPE) K PSDNL,PSDTYPE Q
 S ^PSD(58.81,"AF",X,PSDNL,PSDTYPE,DA)="" K PSDNL,PSDTYPE
 Q
KAF ;kill 'AF' x-ref on field 3 in 58.81
 S PSDNL=$P(^PSD(58.81,DA,0),"^",3),PSDTYPE=$P(^(0),"^",2)
 I 'PSDNL!('PSDTYPE) K PSDNL,PSDTYPE Q
 K ^PSD(58.81,"AF",X,PSDNL,PSDTYPE,DA),PSDNL,PSDTYPE
 Q
SAFL ;set 'AF' (for loc) on field 3 in 58.81
 S PSDATT=$P(^PSD(58.81,DA,0),"^",4),PSDTYPE=$P(^(0),"^",2)
 I 'PSDATT!('PSDTYPE) K PSDATT,PSDTYPE Q
 S ^PSD(58.81,"AF",PSDATT,X,PSDTYPE,DA)="" K PSDATT,PSDTYPE
 Q
KAFL ;kill 'AF' (for loc) on field 3 in 58.81
 S PSDATT=$P(^PSD(58.81,DA,0),"^",4),PSDTYPE=$P(^(0),"^",2)
 I 'PSDATT!('PSDTYPE) K PSDATT,PSDTYPE Q
 K ^PSD(58.81,"AF",PSDATT,X,PSDTYPE,DA),PSDATT,PSDTYPE
 Q
SASITE ;set 'ASITE' x-ref on field 2 in 58.8
 Q:$P(^PSD(58.8,DA,0),"^",2)=""
 S PSDTYPE=$P(^PSD(58.8,DA,0),"^",2)
 S ^PSD(58.8,"ASITE",X,PSDTYPE,DA)="" K PSDTYPE
 Q
KASITE ;kill 'ASITE' x-ref on field 2 in 58.8
 Q:$P(^PSD(58.8,DA,0),"^",2)=""
 S PSDTYPE=$P(^PSD(58.8,DA,0),"^",2)
 K ^PSD(58.8,"ASITE",X,PSDTYPE,DA),PSDTYPE
 Q
SASITE1 ;set 'ASITE' x-ref on field 1
 S PSDDS=$P(^PSD(58.8,DA,0),"^",3) I 'PSDDS K PSDDS Q
 S ^PSD(58.8,"ASITE",PSDDS,X,DA)="" K PSDDS
 Q
KASITE1 ;k 'ASITE' on field 1 in 58.8
 S PSDDS=$P(^PSD(58.8,DA,0),"^",3) I 'PSDDS K PSDDS Q
 K ^PSD(58.8,"ASITE",PSDDS,X,DA),PSDDS
 Q
SAFT ;set 'AF' field 1 in 58.81
 S PSDNL=$P(^PSD(58.81,DA,0),"^",3),PSDATT=$P(^(0),"^",4)
 I 'PSDNL!('PSDATT) K PSDNL,PSDATT Q
 S ^PSD(58.81,"AF",PSDATT,PSDNL,X,DA)="" K PSDATT,PSDNL
 Q
KAFT ;kill 'AF' field 1 in 58.81
 S PSDNL=$P(^PSD(58.81,DA,0),"^",3),PSDATT=$P(^(0),"^",4)
 I 'PSDNL!('PSDATT) K PSDNL,PSDATT Q
 K ^PSD(58.81,"AF",PSDATT,PSDNL,X,DA),PSDATT,PSDNL
 Q
