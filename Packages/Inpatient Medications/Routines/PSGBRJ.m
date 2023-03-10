PSGBRJ ;BIR/CML3-UD JANITOR (BACKGROUND TASKMAN JOB) ; 6/4/10 9:57am
 ;;5.0;INPATIENT MEDICATIONS;**12,50,244,317,432**;16 DEC 97;Build 18
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PS(59.7 is supported by DBIA# 2181.
 ;
LK ; kill off old labels
 D NOW^%DTC S (PSGBRJDT,PSGDT)=%,^PS(53.42,PSGBRJDT,0)=PSGBRJDT,PSJACIVF=1
 F PSGL1=1,2 D
 .F PSGL2=0:0 S PSGL2=$O(^PS(53.41,PSGL1,1,PSGL2)) Q:'PSGL2  D
 ..F PSGL3=0:0 S PSGL3=$O(^PS(53.41,PSGL1,1,PSGL2,1,PSGL3)) Q:'PSGL3  D
 ...S PSGKD=$$LABELDT(PSGL3,PSGDT)
 ...F PSGL4=1,2,3 F PSGL5=0:0 S PSGL5=$O(^PS(53.41,PSGL1,1,PSGL2,1,PSGL3,1,PSGL4,1,PSGL5)) Q:'PSGL5  D
 ....S X=$P($G(^PS(53.41,PSGL1,1,PSGL2,1,PSGL3,1,PSGL4,1,PSGL5,0)),"^",3)
 ....I X<PSGKD K DA S DIK="^PS(53.41,"_PSGL1_",1,"_PSGL2_",1,"_PSGL3_",1,"_PSGL4_",1,",DA(4)=PSGL1,DA(3)=PSGL2,DA(2)=PSGL3,DA(1)=PSGL4,DA=PSGL5 D ^DIK
 ;
AK ; kill off all orders in 53.1 that have gone active (into 55)
 N PSJNO,PSJNOACT,ON100 S PSJNOACT=1
 S DIK="^PS(53.1," F PSGP=0:0 S PSGP=$O(^PS(53.1,"AS","A",PSGP)) Q:'PSGP  F PSJNO=0:0 S PSJNO=$O(^PS(53.1,"AS","A",PSGP,PSJNO)) Q:'PSJNO  S DA=PSJNO D 
 . S ON100=+$P($G(^PS(53.1,DA,0)),U,21) I '$D(^XTMP("ORLK-"_$G(ON100))) D ^DIK ;*PSJ*5*244 - Check for lock
 ;
DE ; kill off de orders in 53.1 that no longer tie to order in 55
 S X="ORX" X ^%ZOSF("TEST") S PSGOERRF=$T
 NEW PSJDA,ON K ^TMP($J)
 F PSGP=0:0 S PSGP=$O(^PS(53.1,"AS","DE",PSGP)) Q:'PSGP  F PSJDA=0:0 S PSJDA=$O(^PS(53.1,"AS","DE",PSGP,PSJDA)) Q:'PSJDA  S ON=$P($G(^PS(53.1,PSJDA,0)),U,26) D
 . I ON["A"!(ON["O")!(ON["U") S:'$D(^PS(55,PSGP,5,+ON,0)) ^TMP($J,PSJDA)=PSGP Q
 . I ON["V" S:'$D(^PS(55,PSGP,"IV",+ON,0)) ^TMP($J,PSJDA)=PSGP Q
 . I '$D(^PS(53.1,+ON,0)) S ^TMP($J,PSJDA)=PSGP Q
 F PSJDA=0:0 S PSJDA=$O(^TMP($J,PSJDA)) Q:'PSJDA  D:$D(^PS(53.1,PSJDA,0)) PDE(PSJDA,^TMP($J,PSJDA))
 K ^TMP($J)
 ;
DK ; kill off dc'd orders in 53.1 around longer than life of labels
 N PSJNOACT S PSJNOACT=1
 S X="ORX" X ^%ZOSF("TEST") S PSGOERRF=$T
 F PSGP=0:0 S PSGP=$O(^PS(53.1,"AS","D",PSGP)) Q:'PSGP  D
 .S PSGKD=$$LABELDT(PSGP,PSGDT) F DA=0:0 S DA=$O(^PS(53.1,"AS","D",PSGP,DA)) Q:'DA  D
 ..S S=$P($G(^PS(53.1,DA,0)),"^",9),ST=$P($G(^(2)),"^",3) I $S(S="U":1,S="P":1,1:ST<PSGKD) D ORPRG:PSGOERRF S DIK="^PS(53.1," D ^DIK
 ;
PLP ; purge pick lists that are filed away and older than auto purge days
 I $D(^PS(59.7,1,63.5)),^(63.5) S X2=-^(63.5),X1=DT D C^%DTC S PSJX=X F Q=0:0 S Q=$O(^PS(53.5,"AO",Q)) Q:'Q  F QQ=0:0 S QQ=$O(^PS(53.5,"AO",Q,QQ)) Q:'QQ!(QQ>PSJX)  S Y=$O(^(QQ,0)) I Y D
 .K DA,DIK,^PS(53.5,"AU",Y) S DIK="^PS(53.5,",DA=Y D ^DIK
 F PSJX=0:0 S PSJX=$O(^PS(53.55,PSJX)) Q:'PSJX  I '$D(^PS(53.5,PSJX)) K DA,DIK S DA=PSJX,DIK="^PS(53.55," D ^DIK
 ;
GLK ; kill off entries in ^PS(53.42) 20 days or more old
 S X1=DT,X2=-20 D C^%DTC F D=0:0 S D=$O(^PS(53.42,D)) Q:'D!(D'<X)  K ^(D)
 ;
UPARAM ; kill off entries in ^PS(53.45) INPATIENT USER PARAMETERS file if there is no corresponding entry in the NEW PERSON file or they have a TERMINATION DATE before today.
 S DA=0 F  S DA=$O(^PS(53.45,DA)) Q:'DA  D
 .I '$D(^VA(200,DA)) S DIK="^PS(53.45," D ^DIK K DIK Q
 .S PSGX=$P(^VA(200,DA,0),"^",11),PSGX=$S(PSGX="":9999999,1:PSGX) I PSGX<DT S DIK="^PS(53.45," D ^DIK K DIK
 ;
NVK ; *PSJ*5*244 - kill discontinued orders from non-verified X-refs
 N DFN,ON,PSGREF,X
 S PSGREF(1)="ANV",PSGREF(2)="APV",PSGREF(3)="ANIV",PSGREF(4)="APIV"
 F X=1:1:4 D
 . F DFN=0:0 S DFN=$O(^PS(55,PSGREF(X),DFN)) Q:'DFN  D
 .. F ON=0:0 S ON=$O(^PS(55,PSGREF(X),DFN,ON)) Q:'ON  D
 ... I $P($G(^PS(55,DFN,5,ON,0)),U,9)["D" K ^PS(55,PSGREF(X),DFN,ON)
 ;
PADE ; *317 - kill messages older than 90 days
 N D,PDT,PDI S X1=DT,X2=-90 D C^%DTC S D=0,PDT=X,DIK="^PS(58.72,"
 F  S D=$O(^PS(58.72,"B",D)) Q:'D!(D>PDT)  D
 .S PDI=0 F  S PDI=$O(^PS(58.72,"B",D,PDI)) Q:'PDI  S DA=PDI D ^DIK
 Q
 ;
DONE ;
 S:$D(ZTQUEUED) ZTREQ="@"
 D NOW^%DTC S $P(^PS(53.42,PSGBRJDT,0),"^",2)=%
 D ENKV^PSGSETU K CA,D,DA,DFN,DIK,DND,GOTO,PSGL1,PSGL2,PSGL3,PSGL4,PSGL4,PSGKD,PSGOERRF,PSGX,PSJACIVF,PSJX,PSGBRJDT,S,ST,X1,X2 Q
 ;
ORPRG ;
 ;*** COMMENT OUT FOR NOW.  NEED TO GET BACK WITH MELANIE TO SEE
 ;*** WHAT TO BE DONE WHEN WE PURGE INPATIENT MEDS ORDERS.  7/19/96.
 ; removed old call to ORX routine!
 Q
LABELDT(PSGP,X1) ; Find patient's ward and get days to keep new labels.
 S X=$G(^DPT(PSGP,.1)),X2=0 I X]"" S X=+$O(^DIC(42,"B",X,0)),X=+$O(^PS(59.6,"B",X,0)),X2=-$P($G(^PS(59.6,X,0)),U,11)
 D C^%DTC
 Q X
 ;
PDE(PSJDA1,PSGP) ;Remove all related pending orders with the "DE" status.
 N DA,DIK,PDE,PSJNUM,PDEFLG,PSJ55,PSJNOACT S (PDEFLG,PSJ55)=0,PSJNOACT=1
 F  S PSJNUM=$P($G(^PS(53.1,PSJDA1,0)),U,25) Q:'+PSJNUM  D  Q:PSJ55
 . I PSJNUM["A"!(PSJNUM["O")!(PSJNUM["U") S PSJ55=1 I $D(^PS(55,PSGP,5,+PSJNUM,0)) S PDEFLG=1 Q
 . I PSJNUM["V" S PSJ55=1 I $D(^PS(55,PSGP,"IV",+PSJNUM,0)) S PDEFLG=1 Q
 . S PDE(PSJDA1)="",PSJDA1=+PSJNUM
 S:'PSJ55 PDE(PSJDA1)=""
 I 'PDEFLG,$O(PDE(0)) F PSJDA1=0:0 S PSJDA1=$O(PDE(PSJDA1)) Q:'PSJDA1  I $D(^PS(53.1,PSJDA1,0)) S DA=PSJDA1 D ORPRG:PSGOERRF S DIK="^PS(53.1,",DA=+PSJDA1 D ^DIK K DA,DIK
 Q
 ;
