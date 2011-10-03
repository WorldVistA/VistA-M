SRO1L ;BIR/ADM - Update 1-Liner Cases ; [ 07/7/03  9:05 AM ]
 ;;3.0; Surgery ;**86,88,107,121,125**;24 Jun 93
ST I '$D(SRSITE) D ^SROVAR
EN2 S SRSOUT=0 K SRTN D SROPS G:'$D(SRTN) END
 D ^SRO1L1 S SROERR=SRTN D ^SROERR0
 W @IOF G EN2
END D ^SRSKILL K SRTN W @IOF
 Q
SROPS ; select patient and case
 N SRSEL S (CNT,SRDT)=0 D ^SROPSEL G:SRSOUT END D HDR
 I SRSEL=2 K SRCASE D LIST I '$D(SRCASE(1)) W !!,"Case #"_SROP_" is not a valid 1-liner case.",!!,"Press RETURN to continue  " R X:DTIME G ST
 I SRSEL=2 S SRTN=+SRCASE(1) Q
 ;
ADT S (SRDT,CNT,SRBACK)=0 F  S SRDT=$O(^SRF("ADT",DFN,SRDT)) Q:'SRDT!SRSOUT!$D(SRTN)!SRBACK  S SROP=0 F  S SROP=$O(^SRF("ADT",DFN,SRDT,SROP)) Q:'SROP!$D(SRTN)!SRSOUT!SRBACK  D LIST
 G:SRBACK ADT Q:$D(SRTN)
 I '$D(SRCASE(1)) W !!,"There are no cases entered for "_VADM(1)_".",!!,"Press RETURN to continue  " R X:DTIME G END
OPT S SRSOUT=0 W !!,"Select Case: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 I '$D(SRCASE(X)) W !!,"Enter the number of the operation you want to edit." G OPT
 S SRTN=+SRCASE(X)
 Q
LIST ; list cases
 N SRA S SRA=$G(^SRF(SROP,"RA")) I $P(SRA,"^",2)="N",$P(SRA,"^",6)="Y" Q
 I $P($G(^SRF(SROP,0)),"^",9)<2961001 Q
 I '$P($G(^SRF(SROP,.2)),"^",12) Q
 I $P($G(^SRF(SROP,30)),"^")!$P($G(^SRF(SROP,31)),"^",8) Q
 I $P($G(^SRF(SROP,"NON")),"^")="Y" Q
 I $P($G(^SRF(SROP,37)),"^") Q
 I $Y+5>IOSL S SRBACK=0 D SEL Q:$D(SRTN)!(SRSOUT)  D HDR Q:SRBACK
 S CNT=CNT+1,SRSDATE=$P(^SRF(SROP,0),"^",9) W !,CNT_". "
CASE W $E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3)
 S SROPER=$P(^SRF(SROP,"OP"),"^") I $O(^SRF(SROP,13,0)) S SROTHER=0 F I=0:0 S SROTHER=$O(^SRF(SROP,13,SROTHER)) Q:'SROTHER  D OTHER
 D ^SROP1 K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W ?14,SROPS(1) I $D(SROPS(2)) W !,?14,SROPS(2) I $D(SROPS(3)) W !,?14,SROPS(3) W:$D(SROPS(4)) !,?14,SROPS(4)
 W ! S SRCASE(CNT)=SROP_"^"_SRDT
 Q
SEL ; select case
 W ! K DIR S DIR("A")="Select case or enter RETURN to continue listing cases: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I X="" Q
 I '$D(SRCASE(X)) W ! S DIR("A",1)="Please enter the number corresponding to the case you want to edit.",DIR("A",2)="If the case desired does not appear, enter RETURN to continue listing",DIR("A",3)="additional cases."
 I '$D(SRCASE(X)) S DIR("A",4)="",DIR("A")="Press RETURN to continue  " D ^DIR K DIR S:$D(DTOUT)!$D(DUOUT) SRSOUT=1 S SRBACK=1 Q
 S SRTN=+SRCASE(X)
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SROP,13,SROTHER,0),"^"))>235 S SRLONG=0,SROTHER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SROP,13,SROTHER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
LOOP ; break procedure
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
HDR ; print heading
 W @IOF,!,?1,VADM(1)_"   "_VA("PID") S X=$P($G(VADM(6)),"^") W:X "        * DIED "_$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_" *" W !
 Q
