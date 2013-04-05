SROERR ;B'HAM ISC/MAM,ADM - ORDER ENTRY ROUTINE ;01/22/99  9:47 AM
 ;;3.0; Surgery ;**14,67,73,41,80,86,107,147,144**;24 Jun 93
 ;
 ; Reference to ^ORD(100.99 supported by DBIA #874
 ; Reference to FILE^ORX supported by DBIA #866
 ; Reference to ST^ORX supported by DBIA #866
 ; Reference to NEW^VPRSR supported by DBIA #4750
 ; Reference to DEL^VPRSR supported by DBIA #4750
 ;
CREATE ; create order in ORDER file (100)
 I $P($G(^SRO(133,SRSITE,0)),"^",22)="Y" D
 .N SROP,SROPER,SRTYPE,DYNOTE
 .S SROP=SRTN,SROPER="" D ^SROP1 S SRTYPE=1
 .I SROPER["REQUESTED" Q
 .I $P($G(^SRF(SRTN,"OP")),"^",2)']"" D
 ..W !!,"  This Surgery case does not have a Planned Principal CPT Code entered. The ",!,"  information sent to SPD for creation of a case cart may not contain ",!,"  enough information for processing."
 .I SROPER["SCHEDULED" S SRTYPE=1
 .I SROPER["NOT COMPLETE",$P($G(^SRF(SRTN,.2)),"^",10) S SRTYPE=1
 .D ST^SRSCOR(SRTN)
 D SERR^SROPFSS(SRTN,"SROERR")
 N SREVENT S SREVENT="S12",SROERR=SRTN D STATUS^SROERR0,MSG^SRHLZIU(SRTN,SRSTATUS,SREVENT)
 I $L($T(NEW^VPRSR)) D NEW^VPRSR(SROERR,$G(DFN),SRSTATUS) Q  ;CPRS-R
 I +$$VERSION^XPDUTL("ORDER ENTRY/RESULTS REPORTING")>2.5 K SROERR Q
 I '$D(^ORD(100.99)) Q
 I '$D(ORPCL) K DIC S DIC="^DIC(19,",X="SR SURGERY REQUEST",DIC(0)="" D ^DIC I Y'=-1 S ORPCL=+Y_";DIC(19,"
REQ S ORNP=SRSDOC,ORPK=SRTN,ORSTRT=SRSDATE S:'$D(ORVP) ORVP=DFN_";DPT(" D:'$D(ORL) LOC
 S:'$D(SROERR) SROERR=SRTN D STATUS^SROERR0 S ORTX=SRSOP_"|>> Case #"_SRTN_" "_SRSTATUS
 I DT<$E(ORSTRT,1,7) S X1=ORSTRT,X2=DT D ^%DTC S ORPURG=X+30
 D FILE^ORX K DIE,DA,DR S DA=SRTN,DIE=130,DR="100////"_ORIFN D ^DIE K DA,DR,DIE,ORIFN,SROERR
 Q
LOC S SRL=$P($G(^DPT(DFN,.1)),"^") I SRL'="" K DIC S DIC="^DIC(42,",X=SRL D ^DIC K DIC S SRL=$S(Y'=-1:+Y,1:"") S:SRL SRL=$P($G(^DIC(42,SRL,44)),"^")
 S ORL=$S(SRL:SRL_";SC(",1:"")
 Q
EN ; entry for OE/RR, process order actions
 S:'$D(ORGY) ORGY="" Q:'$D(ORACTION)!(ORGY=9)  I ORGY=10 S SROERR=ORPK D ^SROERR0 Q
 I ORACTION=7 D PURGE Q
8 I ORACTION=8 D DETAIL S:'$O(ORSLST(ORNXT)) OREND=1 Q
 I "2345"[ORACTION W !!,"Not allowed on Surgical Requests !" Q
 I ORACTION,ORSTS'=5 W !!,"Cannot update/delete case not in 'REQUESTED' status !" Q
 I '$D(^XUSEC("SROREQ",DUZ)) W !!,"You must hold the 'SROREQ' key to perform this function !" G PRESS
 D:'$D(SRSITE) ^SROVAR S DFN=+ORVP D DEM^VADPT I ORACTION=0 S ORPCL=XQORNOD D ADD Q
 I ORACTION=1 D DISPLAY,EDIT Q
 I ORACTION=6 D DISPLAY D DEL^SRSUPRQ G END
 Q
EDIT ; edit requested case
 W !!,"1. Delete",!,"2. Update Request Information",!,"3. Change the Request Date",!!,"Select Number: " R Z:DTIME S:'$T Z="" G:"^"[Z END S:Z["?" Z=4
 I Z<1!(Z>3)!(+Z\1'=Z) W !!,"If you want to delete this request, enter '1'.  Enter '2' if you only want",!,"to update the general information about this case, or '3' to change the date",!,"for which this case is requested." G EDIT
 I Z=1 D DEL^SRSUPRQ G END
 I Z=2 D UPDATE^SRSUPRQ G END
 I Z=3 D CHANGE^SRSDT
END K SRTN D ^SRSKILL
 Q
DISPLAY S SRDFN=+ORVP,SRNM=VADM(1),SRTN=ORPK,SRSDATE=$P(^SRF(SRTN,0),"^",9)
 W @IOF,!,SRNM," (",VA("PID"),")" I $P($G(^DPT(DFN,.35)),"^")'="" S Y=$P(^(.35),"^") D D^DIQ W "   ** DIED: "_Y_" **" G END
 S SRSDT=$E(SRSDATE,4,5)_"/"_$E(SRSDATE,6,7)_"/"_$E(SRSDATE,2,3) S SROPER=$P(^SRF(SRTN,"OP"),"^")_" (#"_SRTN_")"
 K SROPS,MM,MMM S:$L(SROPER)<71 SROPS(1)=SROPER I $L(SROPER)>70 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !!,SRSDT,?11,SROPS(1) I $D(SROPS(2)) W !,?11,SROPS(2) I $D(SROPS(3)) W !,?11,SROPS(3)
 Q
LOOP ; break case information if longer than 70 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<70  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
PRESS W !!,"Press RETURN to continue  " R X:DTIME G:'$T END
 Q
DETAIL I $E(IOST)="C" W !!,"Press RETURN to review case information, or '^' to quit.  " R X:DTIME I '$T!(X["^") S OREND=1 Q
 S SRTN=ORPK I $P($G(^SRF(SRTN,"NON")),"^")="Y" D ^SROERR2 G END
 D ^SROERR1,END
 Q
ADD ; add new requests to ORDER file (100)
 W @IOF,!,VADM(1)," (",VA("PID"),")" I $P($G(^DPT(+ORVP,.35)),"^")'="" S Y=$P(^(.35),"^") D D^DIQ W "   ** DIED: "_Y_" **"
 W !!,"Add New Surgery Requests",!!!,"1. Make Operation Requests",!,"2. Make a Request from the Waiting List",!,"3. Make a Request for Concurrent Cases"
 W !!,"Select Number: " R Z:DTIME S:'$T Z="" G:"^"[Z END S:Z["?" Z=4
 I Z<1!(Z>3)!(+Z\1'=Z) W !!,"If you want to make a new operation request, enter '1'.  Enter '2' if you want",!,"to make a request from the surgery waiting list, or '3' to make a request for",!,"concurrent cases." D PRESS G ADD
 I Z=1 D ^SRSMREQ G END
 I Z=2 D ^SRSWREQ G END
 I Z=3 D ^SRSCONR G END
 Q
PURGE ; purge order from ORDER file
 N SREVENT,SRSTATUS S SREVENT="S17",SRSTATUS="(DELETED)" D MSG^SRHLZIU(ORPK,SRSTATUS,SREVENT)
 I $L($T(DEL^VPRSR)) D DEL^VPRSR(ORPK,$G(DFN)) Q  ;CPRS-R
 I +$$VERSION^XPDUTL("ORDER ENTRY/RESULTS REPORTING")>2.5 Q
 I "589"'[ORSTS S:$D(^SRF(ORPK,0)) $P(^(0),"^",14)="" S ORSTS="K" D ST^ORX
 Q
DEL ; delete from ORDER file (100) and call CoreFLS API
 I $P($G(^SRO(133,SRSITE,0)),"^",22)="Y" D
 .N SRDYNOTE,SRTYPE
 .S SRDYNOTE=$P($G(^SRF(SRTN,31)),"^",10) Q:'SRDYNOTE
 .I SRDYNOTE S SRTYPE=4 D ST^SRSCOR(SRTN)
 N SREVENT,SRSTATUS S SREVENT="S17",SRSTATUS="(DELETED)" D MSG^SRHLZIU(SRTN,SRSTATUS,SREVENT)
 I $L($T(DEL^VPRSR)) D DEL^VPRSR(SRTN,$G(DFN)) Q  ;CPRS-R
 I +$$VERSION^XPDUTL("ORDER ENTRY/RESULTS REPORTING")>2.5 Q
 S:'$D(ORIFN) ORIFN=$P(^SRF(SRTN,0),"^",14) I $D(ORIFN) S ORSTS="K" D ST^ORX K ORIFN
 Q
