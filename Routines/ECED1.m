ECED1 ;BIR/MAM,JPW-Event Capture Data Entry (cont'd) ;6 Mar 96
 ;;2.0; EVENT CAPTURE ;**4,5,8,10,18,23,41,47,50,72**;8 May 96
CAT ;cat & set unit info
 W !!,"Location: "_ECLN,!,"DSS Unit: "_ECDN,!
 D CATS^ECHECK1
 S NODE=$G(^ECD(ECD,0)),ECS=+$P(NODE,"^",2),ECM=+$P(NODE,"^",3),ECDDT=$P(NODE,"^",12),ECDDT=$S(ECDDT="T":"NOW",ECDDT="N":"NOW",1:"")
 S ECSN=$S($P($G(^DIC(49,ECS,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN"),ECMN=$S($P($G(^ECC(723,ECM,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECPCE="U~"_$S($P(NODE,"^",14)]"":$P(NODE,"^",14),1:"N")
PAT ;get pat
 S (ECJLP,ECOUT)=0
 K EC,^TMP("ECLKUP",$J) S CNT=0 K DIC S DIC=2,DIC(0)="QEAMZ",DIC("A")="Select Patient: " D ^DIC K DIC Q:Y<0  S ECDFN=+Y,ECPAT=$P(Y,"^",2),ECOUT=0
 N ECUP S DFN=ECDFN D 2^VADPT I +VADM(6) D  I $G(ECUP)="^" G PAT
 . ; NOIS MWV-0603-21781: line below changed by VMP.
 . W !!,"WARNING "_"[PATIENT DIED ON "_$P(VADM(6),U,2)_"] ",!!
 . R "Press Return to Continue or ^ to Deselect: ",ECUP:DTIME
ASKD ;get proc date
 D DATE Q:ECOUT
 ;
 ;- Determine inpatient/outpatient status
 S ECPTSTAT=$$INOUTPT^ECUTL0(+$G(ECDFN),+$G(ECDT))
 I ECPTSTAT="" D INOUTERR^ECUTL0 Q
 ;
 ;- Display inpatient/outpatient status message
 D DSPSTAT^ECUTL0(ECPTSTAT) S ECIOFLG=1
 ;
PR S X=$E(ECDT,1,7)-.0001 F I=0:0 S X=$O(^ECH("ADT",ECL,ECDFN,ECD,X)) Q:X>ECDT1!('X)  S ECFN=0 F I=0:0 S ECFN=$O(^ECH("ADT",ECL,ECDFN,ECD,X,ECFN)) Q:'ECFN  S CNT=CNT+1,EC(CNT)=ECFN D SET
 S CNT=0 I '$O(EC(0))&ECOUT=99 S ECOUT=0 Q
PROS ; display procedures
 I ECOUT K ECPAT D HDR W ! G PAT
 I '$D(EC(1)) S ECJLP=1 D DATE Q:ECOUT  D NEW^ECED2 S CNT=0 K EC G PR
 ;
 ;- Prevents inpat/outpat status from scrolling off screen before heading
 ;  clears screen and prints at top
 I $D(EC(1)),(+$G(ECIOFLG)) D MSG1^ECMUTL1 K ECIOFLG
 D HDR K ECHOICE F I=0:0 S CNT=$O(EC(CNT)) Q:'CNT!($D(ECHOICE))  S CNT1=CNT D LIST
 I ECOUT K ECPAT D HDR W ! G PAT
 I $D(ECHOICE),ECHOICE S EC=ECHOICE D EDIT^ECED3 S CNT=0 K EC G PR
 I $D(ECHOICE),ECHOICE="N" S ECJLP=1 D DATE Q:ECOUT  D NEW^ECED2 S CNT=0 K EC G PR
SELP W !!!,"Select a number to edit/delete, or enter N to create a New Procedure:  " R X:DTIME I '$T!("^"[X) K ECPAT D HDR G PAT
 I "Nn"[X S ECJLP=1 D DATE Q:ECOUT  D NEW^ECED2 S CNT=0 K EC G PR
 I '$D(EC(X)) W !!,"Enter N to create a new procedure, or the number corresponding to the",!,"procedure that you want to edit or delete.  Enter ^ quit.",!!,"Press <RET> to continue  " R X:DTIME S CNT=CNT1-5 G PROS
 S EC=X D EDIT^ECED3 S CNT=0 K EC G PR
 ;
LIST ; list procedures
 I $Y+8>IOSL D SEL Q:$D(ECHOICE)!(X="")
 S ECDTM=$$FMTE^XLFDT($P(EC(CNT),"^",10),2)
 W !!,CNT_".",?5,"Category : "_$E($P(EC(CNT),"^",2),1,23),?41,"Pr. Date: ",ECDTM,?67,$P(EC(CNT),"^",4),!,?5,"Procedure: "_$E($P(EC(CNT),"^",3),1,50)_" ("_$P(EC(CNT),"^",6)_")",?67,$E($P(EC(CNT),"^",5),1,13)
 I $O(EC(CNT,"MOD",""))'="" D
 . N MOD S MOD="" F  S MOD=$O(EC(CNT,"MOD",MOD)) Q:MOD=""  D
 . . W !?6,"Modifier: ","    - ",MOD," ",$E(EC(CNT,"MOD",MOD),1,55)
 I $P(EC(CNT),"^",9)]"" W !?5,"Procedure Reason: "_$P(EC(CNT),"^",9)
 Q
HDR ; heading
 W @IOF,!,"Location: "_ECLN,?40,"Service: "_ECSN,!,"Section: "_ECMN,?40,"DSS Unit: "_ECDN I $D(ECPAT) W !,"Patient: "_ECPAT,?40,"Procedure Date: "_ECDATE
 Q
SEL ; select procedure
 W !!!,"Select a number to edit, enter N for a New Procedure, or press <RET> to ",!,"continue listing procedures:  " R X:DTIME I '$T!(X="^") S (ECOUT,ECHOICE)=1 Q
 I X="" S CNT=CNT-1 D HDR Q
 I "Na"[X S ECHOICE="N" Q
 I $D(EC(X)) S ECHOICE=X Q
 W !!,"To create a new procedure, type N.  If you would like to edit or delete",!,"one of the procedures listed, enter the corresponding number.  Press <RET>",!,"to continue the list, or ^ to quit."
 W !!,"Press <RET> to continue  " R X:DTIME S X="",CNT=CNT-6 D HDR
 Q
SET ; set EC array
 N ECPXD
 I '$D(^ECH(EC(CNT),0)) W !!,"Event Capture patient data missing.",!! S ECOUT=1 Q
 S ECCH=$G(^ECH(EC(CNT),0)),(ECPSYN,ECPTCD)="",ECDTM=$P(ECCH,"^",3)
 S ECTEMP=+$P(ECCH,"^",8),ECCN=$S($P($G(^EC(726,ECTEMP,0)),"^")]"":$P(^(0),"^"),1:"None")
 S ECTEMP=$P(ECCH,"^",9),ECTEST="^"_$P(ECTEMP,";",2),ECTEMP=+ECTEMP
 I $P(ECCH,"^",4)'="",$P(ECCH,"^",7)'="",$P(ECCH,"^",8)'="",$P(ECCH,"^",9)'="" D
 . S ECPSY=+$O(^ECJ("AP",$P(ECCH,"^",4),$P(ECCH,"^",7),$P(ECCH,"^",8),$P(ECCH,"^",9),""))
 . I ECPSY'="" S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),"^",2)
 S ECCPT=$S(ECTEST["EC":$P($G(^EC(725,ECTEMP,0)),"^",5),1:ECTEMP)
 S (ECPTCD,ECPXD)="" I ECCPT'="" D
 . S ECPXD=$$CPT^ICPTCOD(ECCPT,ECDTM) I +ECPXD>0 S ECPTCD=$P(ECPXD,U,2)
 I $D(^ECH(EC(CNT),"MOD")) D  K MOD,ARR,ECMODF
 . K ARR,ECMOD S ECMODF=$$MOD^ECUTL(EC(CNT),"E",.ARR) I 'ECMODF Q
 . S MOD="" F  S MOD=$O(ARR(MOD)) Q:MOD=""  S ECMOD(MOD)=$P(ARR(MOD),U,3)
 I ECTEST["EC" D  G SET1
 . S ECPN=$S($P($G(^EC(725,ECTEMP,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 I ECTEST["ICPT" D  G SET1
 . S ECPN=$S($P(ECPXD,U,3)]"":$P(ECPXD,U,3),1:"UNKNOWN")
 S ECPN="UNKNOWN"
SET1 S ECPN=ECPTCD_" "_ECPN_$S(ECPSYN="":"",1:"  ["_ECPSYN_"]")
 S ECTEMP=+$P(ECCH,"^",12)
 S ECON=$S($P($G(^ECC(723,ECTEMP,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECV=$P(ECCH,"^",10),EC4=$P(ECCH,"^",19),ECID=$P(ECCH,"^",20)
 S EC4N=$S($P($G(^SC(+EC4,0)),"^")]"":$P(^(0),"^"),1:"")
 S ECDAT=$$GETPPRV^ECPRVMUT(EC(CNT),.ECUN) I ECDAT S ECUN="^No primary provider"
 S ECUN=$P(ECUN,"^",2)
 ;
 ;- Check for and display procedure reason
 I +$P(ECCH,"^",23) S ECPRS=+$P(ECCH,"^",23),ECPRSL=$P($G(^ECL(ECPRS,0)),"^"),ECPRSN=$P($G(^ECR(ECPRSL,0)),"^")
 S EC(CNT)=EC(CNT)_"^"_ECCN_"^"_ECPN_"^"_$S(ECUN[",":$P(ECUN,",")_", "_$E($P(ECUN,",",2)),1:ECUN)_"^"_$E(ECON,1,15)_"^"_ECV_"^"_EC4_"^"_ECID_$S($G(ECPRSN)]"":"^"_ECPRSN,1:"")
 S $P(EC(CNT),"^",10)=ECDTM
 I $O(ECMOD(""))'="" D
 . M EC(CNT,"MOD")=ECMOD
 K ECPRS,ECPRSN,ECPRSL,ECMOD
 Q
DATE ;ask date
 I ECJLP,$D(ECDT),$P(ECDT,".",2)]"" Q
 I ECJLP,$D(ECDT),$P(ECDT,".",2)']"" W !!,"You must enter both DATE and TIME to create a new procedure record.",!!
 ;
 ;- Prevent future dates from being entered
 K %DT S %DT="EAXR",%DT("A")="Enter Date and Time of Procedure: ",%DT(0)="-NOW" S:ECDDT]"" %DT("B")=ECDDT D ^%DT K %DT I Y<0 S ECOUT=1 Q
 S ECDT=+Y,ECDT1=$E(Y,1,7)+.9999,ECDATE=$$FMTE^XLFDT(ECDT)
 Q
