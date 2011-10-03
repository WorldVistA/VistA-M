IVMRNQ ;ALB/CPM - IVM CASE INQUIRY ; 14-JUN-94
 ;;2.0; INCOME VERIFICATION MATCH ;**12,17**; 21-OCT-94
 ;
EN ; Main loop for the IVM Case Inquiry.
 S IVMSTOP=0 F  D PAT Q:IVMSTOP  W !!
 K IVMSTOP
 Q
 ;
 ;
PAT ; Run inquiry for a single patient.
 S DIC="^DPT(",DIC(0)="AEQMN" D ^DIC K DIC I Y<1 S IVMSTOP=1 G END
 S DFN=+Y,IVMDA=$O(^IVM(301.5,"B",DFN,0))
 I 'IVMDA W !!,"This patient has had no Means/Copay Tests transmitted to HEC.",! G PAT
 I '$O(^IVM(301.5,"B",DFN,IVMDA)) D  G DEV
 .S IVMYR=$P($G(^IVM(301.5,IVMDA,0)),"^",2)
 .W !!,"  >>>> Case Record is for Income Year ",1700+$E(IVMYR,1,3)," <<<<",!
 ;
YR ; Get income year to select record.
 N ENODE
 S DIR("A")="Select INCOME YEAR: ",DIR(0)="DA^2901231::E",DIR("?")="^D HLP^IVMRNQ"
 D ^DIR K DIR G:$D(DIRUT)!('Y) END
 S IVMYR=$E(Y,1,3)_"0000",IVMDA=$O(^IVM(301.5,"APT",DFN,IVMYR,0))
 I 'IVMDA W !!,"This patient did not have a Means/Copay Test referred to HEC for income year ",1700+$E(IVMYR,1,3),".",! G YR
 S ENODE=$G(^IVM(301.5,IVMDA,"E"))
 I (ENODE'=""),'(+$P(ENODE,"^")) W !!,"This patient did not have a Means/Copay Test referred to HEC for income year ",1700+$E(IVMYR,1,3),".",! G YR
 ;
DEV ; Select an output device.
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q") D HOME^%ZIS,END G END
 .S ZTRTN="DQ^IVMRNQ",ZTDESC="IVM - CASE INQUIRY"
 .S (ZTSAVE("IVMYR"),ZTSAVE("IVMDA"),ZTSAVE("DFN"))=""
 ;
 U IO
 ;
DQ ; Tasked entry point.
 S IVMPAG=0,IVMNAM=$$PT^IVMUFNC4(DFN),IVM0=$G(^IVM(301.5,IVMDA,0)),IVM1=$G(^(1))
 D NOW^%DTC S IVMDAT=$$FMTE^XLFDT(%),IVMQUIT=0
 S IVMMT=$$LST^DGMTU(DFN,$E(IVMYR,1,3)+1_1231)
 D HDR^IVMRNQ1
 ;
 ; - list transmission history
 I $Y>(IOSL-6) D PAUSE^IVMRUTL G:IVMQUIT END D HDR^IVMRNQ1
 D THDR^IVMRNQ1
 S IVMTR=0 F  S IVMTR=$O(^IVM(301.6,"B",IVMDA,IVMTR)) Q:'IVMTR  D  G:IVMQUIT END
 .S IVMTR0=$G(^IVM(301.6,IVMTR,0)),IVMTR1=$G(^(1))
 .I $Y>(IOSL-3) D PAUSE^IVMRUTL Q:IVMQUIT  D HDR^IVMRNQ1,THDR^IVMRNQ1
 .W !?2,$$FMTE^XLFDT($P(IVMTR0,"^",2))
 .W ?25,$$EXPAND^IVMUFNC(301.6,.03,$P(IVMTR0,"^",3))
 .W ?53,$S(IVMTR1:$E($P($$MTS^DGMTU("",+IVMTR1),"^"),1,13),1:"UNKNOWN")
 .W ?67,$S($P(IVMTR1,"^",2):"YES",1:"NO")
 .I $P(IVMTR0,"^",4)]"" D
 ..I $Y>(IOSL-3) D PAUSE^IVMRUTL Q:IVMQUIT  D HDR^IVMRNQ1,THDR^IVMRNQ1
 ..W !?4,"Error: ",$E($P(IVMTR0,"^",4),1,70)
 ;
 ; - list billing history
 I '$O(^IVM(301.61,"C",DFN,0)) G UPL
 I $Y>(IOSL-6) D PAUSE^IVMRUTL G:IVMQUIT END D HDR^IVMRNQ1
 D BHDR^IVMRNQ1
 S IVMTR=0 F  S IVMTR=$O(^IVM(301.61,"C",DFN,IVMTR)) Q:'IVMTR  D  G:IVMQUIT END
 .S IVMTR0=$G(^IVM(301.61,IVMTR,0))
 .I $Y>(IOSL-3) D PAUSE^IVMRUTL Q:IVMQUIT  D HDR^IVMRNQ1,BHDR^IVMRNQ1
 .W !?2,$$EXPAND^IVMUFNC(301.61,.04,$P(IVMTR0,"^",4))
 .W ?14,$$DAT1^IVMUFNC4($P(IVMTR0,"^",5))
 .W ?24,$$DAT1^IVMUFNC4($P(IVMTR0,"^",6))
 .W ?34,$J($P(IVMTR0,"^",8),8,2)
 .W ?44,$S($P(IVMTR0,"^",4)>1:"  N/A",1:$J($P(IVMTR0,"^",9),8,2))
 .W ?55,$S($P(IVMTR0,"^",11):"YES",1:"NO")
 .W ?63,$S($P(IVMTR0,"^",10):"YES",1:"NO")
 .W ?70,$S($P(IVMTR0,"^",13):$$DAT1^IVMUFNC4($P(IVMTR0,"^",13)),1:"Not Sent")
 ;
UPL ; - check for upload information
 D CKUPL^IVMRNQ1 I '$D(IVMTXT) G END1
 I $Y>(IOSL-6) D PAUSE^IVMRUTL G:IVMQUIT END D HDR^IVMRNQ1
 ;
 W !
 F IVMS=1,2,3 I $D(IVMTXT(IVMS)) W !,$P($T(UPTXT+IVMS^IVMRNQ1),";;",2)
 S IVMS=0 F  S IVMS=$O(IVMTXT(4,IVMS)) Q:'IVMS  S IVMX=IVMTXT(4,IVMS) D
 .I $P(IVMX,"^",5) W !,"Insurance data was uploaded on ",$$DAT1^IVMUFNC4($P(IVMX,"^",5),1),"."
 .I $P(IVMX,"^",8) W !,"Insurance data for this patient was rejected: ",$P($G(^IVM(301.91,$P(IVMX,"^",8),0)),"^",2)
 ;
END1 D PAUSE^IVMRUTL
 ;
END I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K %DT,DFN,IVMYR,IVMDA,IVMPAG,IVMNAM,IVM0,IVM1,IVMDAT,IVMMT,X,Y,ZTSK
 K IVMTR,IVMTR0,IVMTR1,IVMI,IVMX,DIRUT,DUOUT,DTOUT,IVMS,IVMTXT
 Q
 ;
HLP ; Help to select Income Year.
 N I
 W !!,"Please select one of the following Income Years:",!
 S I=0 F  S I=$O(^IVM(301.5,"APT",DFN,I)) Q:'I  I I>2900000 W !?4,$E(I,1,3)+1700
 Q
