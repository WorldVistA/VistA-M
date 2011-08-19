SRBLOOD ;B'HAM  ISC/MM,SM - BLOOD PRODUCT VERIFICATION ;08/11/05
 ;;3.0; Surgery ;**74,85,101,148**;24 Jun 93
 ; 
 ; References to ^LRD(65 supported by DBIA #2331-A
 ; References to ^LR( supported by DBIA #894 and 252-B
 ; References to ^LAB(66 supported by DBIA #210
 ; Reference to BAR^LRBLB supported by DBIA #2331-B
 ; Reference to ^LRBLBU supported by DBIA #2333
 ; Reference to VBECA1B supported by DBIA #4629
 ;
 S X="VBECA1B" X ^%ZOSF("TEST") I $T D ^SRBL Q  ; check if VBECS installed
SCAN D BAR^LRBLB ; scan UNIT ID before VBECS
 ;obtain the LRDFN from the patient's DFN
 S SRDFN=$P($G(^DPT($P(^SRF(SRTN,0),"^"),"LR")),"^")
 I SRDFN="" G SRNO
 K DIR S DIR(0)="F^1:50",DIR("A")="Enter Blood Product Identifier",DIR("?")="Enter or scan the Blood Product Unit Id" D ^DIR G END:$D(DIRUT)
 W ! D ^LRBLBU S SRUNIT=$G(X) I SRUNIT="" G SRNO
 ;if patient is not on the "AP" 'DO NOT Give' (no display)
 I '$O(^LRD(65,"AP",SRDFN,0)) G SRNO
 I '$O(^LRD(65,"B",SRUNIT,0)),('$O(^LRD(65,"C",SRUNIT,0))) G SRNO
 S (SRIEN,SRICNT,SROCNT,SROK)=0 F  S SRIEN=$O(^LRD(65,"B",SRUNIT,SRIEN)) Q:'SRIEN  S SROCNT=SROCNT+1,SRO(SROCNT)=SRIEN
 S (SRIEN)=0 F  S SRIEN=$O(^LRD(65,"C",SRUNIT,SRIEN)) Q:'SRIEN  S SROCNT=SROCNT+1,SRO(SROCNT)=SRIEN
 S (SRLRD,SRICNT)=0 F SRZ=1:1:SROCNT D 
 .;S SRIEN=SRO(SRZ) I '$O(^LRD(65,SRIEN,2,0)) S SRICNT=SRICNT+1,SRB(SRICNT)=SRIEN_"^"_0 Q ;checks for "No date/time unit assigned"
 .S SRIEN=SRO(SRZ) I '$O(^LRD(65,SRIEN,2,0)) Q
 .S SRLRD=0 F  S SRLRD=$O(^LRD(65,SRIEN,2,SRLRD)) Q:'SRLRD  D
 ..Q:'$D(^LRD(65,"AP",SRLRD,SRIEN))
 ..S SRICNT=SRICNT+1,SRB(SRICNT)=SRIEN_"^"_SRLRD
 ..I SRLRD=SRDFN S SROK=1
 I '$D(SROK) G SRNO
 ;look through the list of patients assigned to the unit id for selected patient
 S (SRC2,SRFLAG)=0 F SRZ=1:1:SRICNT D
 .I SRC2=SROCNT Q
 .I SRZ=SRICNT,(SRFLAG=0) S SRD(SRC2+1)=SRB(SRZ) Q
 .I SRZ=SRICNT,(SRFLAG=1) Q
 .I $P(SRB(SRZ),"^",2)=SRDFN S SRFLAG=1,SRC2=SRC2+1,SRD(SRC2)=SRB(SRZ)
 .I $P(SRB(SRZ),"^")=$P(SRB(SRZ+1),"^") Q
 .I SRFLAG=1 S SRFLAG=0 Q
 .I SRFLAG=0 S SRC2=SRC2+1,SRD(SRC2)=SRB(SRZ)
 ;
 ;create the display
 I '$D(SRD) G SRNO
 ;if selected patient is assigned to each unit id, no display necessary 
 S SRI="",(SRDS,SRDSP,SRFLAG,SRNODT,SREXP)=0 F  S SRI=$O(SRD(SRI)) Q:SRI=""  D
 .I $P(SRD(SRI),"^",2)'=SRDFN S SRDSP=1
 .;I $D(^LRD(65,"AP",$P(SRD(SRI),"^",2),$P(SRD(SRI),"^")))
 .;E  S SRDS=1,SRD(SRI)=SRD(SRI)_"^"_"       **NO DATE/TIME UNIT ASSIGNED **",SRNODT=1
 .S DFN=$P(SRD(SRI),"^",2)
 .I DFN'=0 S DFN=$P(^LR(DFN,0),"^",3) D DEM^VADPT S $P(SRD(SRI),"^",6)=VADM(1)_" "_VA("PID")
 .I DFN=0 S $P(SRD(SRI),"^",6)="Not Assigned"
 .S SRIEN=$P(SRD(SRI),"^"),SRUNIT=$P(SRD(SRI),"^"),(Y,Z)=$P($G(^LRD(65,SRIEN,0)),"^",6) I Y'="" X ^DD("DD") S $P(SRD(SRI),"^",5)=Y I Z<DT S $P(SRD(SRI),"^",4)="Today's date exceeds the blood product expiration date.",SREXP=1
 I SRDSP=0,(SRDS=0) I SRNODT=0,(SREXP=0) G SRYES
 I SROCNT=1,$D(SROK) S Y=1 G CHECKS
 S SRI="",SRZ=0 F  S SRI=$O(SRD(SRI)) Q:SRI=""  D
 .S SRZ=SRZ+1,SRIEN=$P(SRD(SRI),"^"),SRUNIT=$P(^LRD(65,SRIEN,0),"^")
 .W !!," ",SRI_")"," Unit ID: ",SRUNIT,?45,$P(^LAB(66,$P(^LRD(65,SRIEN,0),"^",4),0),"^")
 .W !,?4,"Patient: ",$P(SRD(SRI),"^",6),?45,"Expiration Date: ",?40,$P(SRD(SRI),"^",5)
 .I $P(SRD(SRI),"^",3)'="" W !,$P(SRD(SRI),"^",3)
 W ! K DIR S DIR(0)="NO^1:"_SRZ,DIR("A")="Select the blood product matching the unit label" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y G END
CHECKS I $P(SRD(Y),"^",2)'=SRDFN G SRNO
 I $P(SRD(Y),"^",4)'="" S SRFLAG=1 W !!,"                       **WARNING**",!!,$P(SRD(Y),"^",4),!
 ;I $P(SRD(Y),"^",3)["**NO DATE" S SRFLAG=1 W !!," There is no 'DATE/TIME Unit Assigned' for this entry."
 I SRFLAG=1 G ASK
SRYES W !!!,?25,"No Discrepancies Found",!!! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue" D ^DIR G END
SRNO W !!,?30,"**WARNING**",!!
 W ?5,"There is no record that this unit has been assigned to this patient."
 W !!,?8,"      Please recheck the patient and blood product IDs.",!!
ASK K DIR S DIR(0)="Y",DIR("A")="Do you want to scan another product (Y/N)",DIR("B")="YES" D ^DIR
END K SRC2,SRDFN,SRFLAG,SRICNT,SROCNT,SRZ,SRDSP,SRBLOOD,SRB,SRO,SRD,SRDS,SROK,SRIEN,SRLRD,SRUNIT,SRNODT,SREXP,SRI
 I Y=1 G SCAN
 Q
AUDIT S L=0,DIC=19.081,FLDS="[XUOPTLOGP]",BY="[SR BLOOD PRODUCT VERIFICATION]" D EN1^DIP
 Q
PAGE I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR
 W @IOF
 Q
