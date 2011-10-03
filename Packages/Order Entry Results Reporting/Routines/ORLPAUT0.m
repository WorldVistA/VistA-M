ORLPAUT0 ; slc/CLA -  Automatically load patients into lists ;2/12/92
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**247**;Dec 17, 1997
 Q
EN ;called by protocol ORU AUTOLIST - automatically update lists with AUTOLINK set.
 Q:'$D(DGPMT)!('$D(DFN))  S TYPE=DGPMT
 W !!,"Updating automated team lists..."
 K VAINDT S VA200=1 D INP^VADPT ;regenerate VAIN array to get NEW PERSON primary provider (and in some cases other protocols kill VAIN)
 D DELPT
 W "completed."
EXIT K DIK,EN,LINK,ORLIST,PROV,RB,TYPE,VA200
 Q
DELPT ;called by EN - remove patient from autolists
 S ORLIST=0
 F  S ORLIST=$O(^OR(100.21,"AB",DFN_";DPT(",ORLIST)) Q:ORLIST'>0  D
 . I $P(^OR(100.21,ORLIST,0),U,2)'="TA" Q
 . ; type TA is a total autolinked list removal and addition, LEAVE the others ALONE
 . S DA=$O(^OR(100.21,ORLIST,10,"B",DFN_";DPT(",0))
 . S DA(1)=ORLIST,DIK="^OR(100.21,"_DA(1)_",10," D ^DIK K DA,DIK
 ; Q:(TYPE=3)  ;quit if discharge not working for ASIH.  removed 11-94 mrh
UPDATE ; flow thru from DELPT - update autolists
 Q:'VAIN(1)  ; not a vaild movement
 I $G(VAIN(4)) S LINK=$P(VAIN(4),"^")_";DIC(42," D ADDPT ;ward
 S RB=$G(VAIN(5)) I $D(RB),RB'="" S EN=0 D
 .S EN=$O(^DG(405.4,"B",RB,EN)) Q:EN'>0
 .S LINK=EN_";DG(405.4," D ADDPT ;room-bed
 I $G(VAIN(3)) S LINK=$P(VAIN(3),"^")_";DIC(45.7," D ADDPT ;treating specialty
 I $G(VAIN(2)) S LINK=$P(VAIN(2),"^")_";VA(200," D ADDPT1("PB") ;primary provider
 I $G(VAIN(11)) S LINK=$P(VAIN(11),"^")_";VA(200," D ADDPT1("AB") ;attending dr
 Q
ADDPT ;called by UPDATE - add patient to autolists
 ; for WARD, ROOM-BED and TREATING SPECIALITY
 S ORLIST=0
 F  S ORLIST=$O(^OR(100.21,"AC",LINK,ORLIST)) Q:ORLIST'>0  D
 . I $P(^OR(100.21,ORLIST,0),U,2)'["A" Q
 . ;list types TA and MRAL are auto add the others are manual
 . I $D(^OR(100.21,ORLIST,10,"B",DFN_";DPT(")) Q  ;quit if patient already on list
 . I '$D(^OR(100.21,ORLIST,10,0)) S ^(0)="^100.2101AV^^"
 . K DIC,DA,DO,DD,DINUM  ;added DINUM in 247
 . S DLAYGO=100.21,DA(1)=ORLIST,DIC="^OR(100.21,"_DA(1)_",10,",DIC(0)="L",X=DFN_";DPT("
 . D FILE^DICN
 . K DA,DD,DIC,DLAYGO,DO,X,DINUM  ;added DINUM in 247
 Q
ADDPT1(LTYPE) ; called by UPDATE - add patient to autolists
 ; for primary attending or both (LTYPE)
 I LTYPE']"" Q
 I '+LINK Q
 S ORLIST=0
 F  S ORLIST=$O(^OR(100.21,"AC",LINK,ORLIST)) Q:ORLIST'>0  D
 . I $P(^OR(100.21,ORLIST,0),U,2)'["A" Q
 . I $D(^OR(100.21,ORLIST,10,"B",DFN_";DPT(")) Q  ;quit if patient already on list
 . S PROV=0 F  S PROV=$O(^OR(100.21,ORLIST,2,"B",LINK,PROV)) Q:PROV'>0  D
 .. I LTYPE[$P($G(^OR(100.21,ORLIST,2,PROV,0)),U,2) D FILE
 Q
FILE ;
 I '$D(^OR(100.21,ORLIST,10,0)) S ^(0)="^100.2101AV^^"
 K DIC,DA,DO,DD,DINUM  ;added DINUM in 247
 S DLAYGO=100.21,DA(1)=ORLIST,DIC="^OR(100.21,"_DA(1)_",10,",DIC(0)="L",X=DFN_";DPT("
 D FILE^DICN
 K DA,DD,DIC,DLAYGO,DO,X,DINUM  ;added DINUM in 247
 Q
