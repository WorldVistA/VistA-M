SRTPSS ;BIR/SJA - SELECT ASSESSMENT ;02/14/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 K:$D(DUZ("SAV")) SRNEW K SRTN W !! S SRSOUT=0
 N SRVA,SRTTYPE,SRTPDT S SRVA=""
 W ! S SRSOUT=0 K DIC S DIC("A")="Select Patient: ",DIC=2,DIC(0)="QEAM" D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S (SRDFN,DFN)=+Y D DEM^VADPT D HDR S SRANM=VADM(1)_"  "_VA("PID")
START ; start display
 D ^SRTPASS Q:$D(SRTPP)  I SRSOUT G END
 I $D(SRNEW) S CNT=CNT+1,SRCASE(CNT)="" W CNT,".   ----     CREATE NEW TRANSPLANT ASSESSMENT"
 I '$D(SRCASE(1)) W !!,"There are no Surgery Risk Assessments entered for "_VADM(1)_".",!! K DIR S DIR(0)="FOA",DIR("A")="  Press RETURN to continue.  " D ^DIR Q
OPT W !!!,"Select Assessment: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 I '$D(SRCASE(X)) W !!,"Enter the number of the desired assessment." W:$D(SRNEW) "  Select '"_CNT_"' to create a new",!,"transplant assessment." G OPT
 I $D(SRNEW),X=CNT D ^SRTPNEW D:$D(SRTPP)  K SRTPP,SRTN W @IOF G END
 .S SR("RA")=$G(^SRT(SRTPP,"RA")),SRVA=$P(SR("RA"),"^",5),SRNOVA=$S(SRVA="N":1,1:0),SRTTYPE=$P(SR("RA"),"^",2)
 .D @$S(SRTTYPE="K":"^SRTPKID1",SRTTYPE="LI":"^SRTPLIV1",SRTTYPE="LU":"^SRTPLUN1",1:"^SRTPHRT1")
 I '$D(SRTPP) S SRTPP=+SRCASE(X)
 Q
END S:'$D(SRSOUT) SRSOUT=1 W:SRSOUT @IOF D ^SRSKILL
 Q
HDR ; print heading
 W @IOF,!,?1,VADM(1)_"   "_VA("PID") S X=$P($G(VADM(6)),"^") W:X "         * DIED "_$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_" *" W !
 Q
SITE ; determine if transplant assessment is defined for the site
 I $$TRS Q
 W @IOF,!,"The SURGERY SITE PARAMETERS file indicates no transplant types defined for this",!,"site/division. Therefore, this option is not available for use.",!
 S XQUIT="" W !!,"Press RETURN to continue  " R X:DTIME W @IOF
 Q
TRS() ; extrinsic call to determine if site is can run the transplant assessment module
 N TRS S TRS=0 Q:'$G(SRSITE) TRS
 I $G(^SRO(133,SRSITE,8))["Y" S TRS=1
 Q TRS
PARAM ; enter/edit site parameters
 N SRDIV,SRN,SRNAME,SRNUM K SRL
 S (SRCNT,X)=0 F  S X=$O(^SRO(133,X)) Q:'X  I '$P($G(^SRO(133,X,0)),"^",21) S SRCNT=SRCNT+1,SRL(SRCNT)=X
 I SRCNT=1 S SRDIV=SRL(1),SRNUM=$$GET1^DIQ(4,SRSITE("DIV"),99),Q3(1)=" "_SRSITE("SITE")_"  ("_SRNUM_") " G PAR
 W @IOF K DIC,DINUM S DIC=133,DIC(0)="QEAMZ",DIC("A")="Edit Parameters for which Surgery Site: " D ^DIC K DIC I Y<0 W @IOF Q
 S SRDIV=+Y,SRN=+Y(0),SRNAME=Y(0,0),SRNUM=$$GET1^DIQ(4,SRN,99),Q3(1)=" "_SRNAME_"  ("_SRNUM_") "
PAR K DIE,DR,DA,Y S DA=SRDIV,DR="[SR TRANSPLANT]",DIE=133 D ^SRCUSS K DR,DIE,DA,ST W @IOF I $D(SRSITE) D SET
 Q
SET ; set site parameters
 S S(0)=^SRO(133,SRSITE,0),SRSITE("AML")=$P(S(0),"^",4),SRSITE("REQ")=$P(S(0),"^",2) K:SRSITE("REQ")="" SRSITE("REQ")
 S SRSITE("IV")=$P(S(0),"^",7) K:SRSITE("IV")="" SRSITE("IV")
 S SRSITE("DIV")=$P(S(0),"^"),SRSITE("SITE")=$$GET1^DIQ(4,SRSITE("DIV"),.01)
 S SRSITE("NRPT")=$P(S(0),"^",6) I SRSITE("NRPT")="" S SRSITE("NRPT")=1
 I '$D(SRSITE("OPTION")),$D(XQY) S SRSITE("OPTION")=XQY
 K S
 Q
