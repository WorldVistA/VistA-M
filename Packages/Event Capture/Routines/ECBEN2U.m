ECBEN2U ;BIR/MAM,JPW-Categories and Procedures Selection ;12 Feb 96
 ;;2.0; EVENT CAPTURE ;**4,5,7,10,17,18,23,42,47,54,72,95,76**;8 May 96;Build 6
END Q
HDR ;screen header
 W @IOF,!,"Location: ",ECLN
 W !,"DSS Unit: ",$E(ECDN,1,30) I $G(ECCN)]"" W ?48,"Category: ",$E(ECCN,1,20)
 W !,"Ordering Section: ",ECON
 W !,"Procedure Date: ",ECDATE,!
 D DSP1416^ECPRVMUT(.ECPRVARY)
 W !
 Q
MSG W !!,"No procedures entered.  No Action Taken.",!!,"Press <RET> to continue " R X:DTIME S ECOUT=1
 Q
MSG1 ;
 W !!,"Please enter the number that corresponds to the "_$S(OK:"procedure",1:"category")_" from which",!,"you would like to select a procedure.  If you would like to continue",!,"with the list, press <RET>.  Enter ^ to quit."
 S CNT=CNT-5
 Q
HDRP ;hdr batch by proc
 W @IOF,!,"Location: ",ECLN
 I $G(ECCN)]"" W !,"Category: ",ECCN
 W !,"Procedure Date: ",ECDATE
 D DSP1442^ECPRVMUT(.ECPRVARY)
 W !
 Q
PCEQST ;entry pt for PCE questions
 S (ECDX,ECDXN,ECVST,ECSC,ECAO,ECIR,ECZEC,ECMST,ECHNC,ECCV,ECSHAD)=""
INP ;- Set inpatient/outpatient status
 S ECINP=$G(ECPTSTAT)
 D CLINIC I ECOUT Q
 ;ask dx
 D DIAG^ECUTL2 I ECOUT Q
 I $P(ECPCE,"~",2)="O"&(ECINP'="O") Q
 D VISIT
 Q
CLINIC ;display default clinic
 Q:$P(ECPCE,"~",2)="N"  I $P(ECPCE,"~",2)="O"&(ECINP'="O") Q
 K DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT S DIR(0)="721,26",DIR("A")="Associated Clinic",DIR("?")="An active clinic is required. Enter an active clinic or an ^ to exit"
 I EC4,EC4N'["NO ASSOCIATED CLINIC" S DIR("B")=EC4N
 D ^DIR K DIR
 I Y S EC4=+Y,ECID=$P($G(^SC(+EC4,0)),"^",7)
 I $D(DTOUT)!$D(DUOUT) S ECOUT=1 Q
 I +EC4,'$G(ECOUT) D CLIN I 'ECPCL W !!,"You must enter an active clinic now.",! G CLINIC
 I $D(DTOUT)!$D(DUOUT)!('Y)!(Y<0) W:$P(ECPCE,"~",2)'="N" !!,"Please note that this record cannot be sent to PCE without an active clinic.",!!
 Q
VISIT ;ask visit info
 Q:ECINP="I"
 ;
 ;- Ask classification questions applicable to patient and file in #721
 I $$ASKCLASS^ECUTL1(+$G(ECPT(CNT)),.ECCLFLDS,.ECOUT,ECPCE,ECINP),($O(ECCLFLDS(""))]"") D SETCLASS^ECUTL1(.ECCLFLDS)
 I +$G(ECOUT) Q
 K ECCLFLDS
 Q
PCEE ;checks edited data and sets PCE node for filing
 S ECVST=+$P(EC(0),"^",21) I 'ECVST G PCE
DEL ;delete visit and refresh data to PCE
 K DA,DIE,DR S DA=ECFN,DIE=721,DR="25///@;28///@" D ^DIE K DA,DIE,DR
 ;
 ;* Prepare all EC records with same Visit file entry to resend to PCE
 N ECVAR1,EC2PCE S ECVAR1=$$FNDVST^ECUTL(ECVST,ECFN,.EC2PCE) K ECVAR1
 ;
 ;- Set VALQUIET to stop Amb Care validator from broadcasting to screen
 N ECPKG,ECSOU
 S ECPKG=$O(^DIC(9.4,"B","EVENT CAPTURE",0)),ECSOU="EVENT CAPTURE DATA"
 S VALQUIET=1,ECVV=$$DELVFILE^PXAPI("ALL",ECVST,ECPKG,ECSOU) K ECVST,VALQUIET
 ;- Resend to PCE task
 D PCETASK^ECPCEU(.EC2PCE) K EC2PCE
PCE ;set data for PCE filing
 Q:$P(ECPCE,"~",2)="N"  I $P(ECPCE,"~",2)="O"&(ECINP'="O") Q
 S ECREAS=""
 ;
 ;- Kill Reason node
 D KILLR
 I EC4 D CLIN^ECPCEU
 I 'EC4 S ECREAS="Clinic missing;"
 I 'ECDX S ECREAS="Diagnosis not entered;"
 I EC4,'ECPCL S ECREAS=ECREAS_"Clinic inactive;"
 I 'ECCPT S ECREAS=ECREAS_"CPT code missing;"
 I ECREAS]"" S ^ECH(ECFN,"R")=ECREAS K ECPCL,ECREAS Q
 I '$D(^ECH(ECFN,0)) Q
 I '$D(^ECH(ECFN,"P")) Q
 S PN=^ECH(ECFN,0),PNP=^ECH(ECFN,"P")
 S PNMOD="" I $D(^ECH(ECFN,"MOD")) D
 . N MOD,MODS S MODS=0 F  S MODS=$O(^ECH(ECFN,"MOD",MODS)) Q:'MODS  D
 . . S MOD=$P($G(^ECH(ECFN,"MOD",MODS,0)),U)
 . . S MOD=$$MOD^ICPTMOD(MOD,"I",$P(PN,U,3)) I +MOD<0 Q
 . . S PNMOD=$S(PNMOD'="":PNMOD_";",1:"")_$P(MOD,U,2)
SET ;set data pieces
 S ECP3=+$P(PN,"^",3) I ECP3'["." K ECP3 D DELNOD Q
 S ECP2=+$P(PN,"^",2) I 'ECP2 K ECP2 D DELNOD Q
 S ECP19=+$P(PN,"^",19) I 'ECP19 K ECP19 D DELNOD Q
 S ECP4=+$P(PN,"^",4) I 'ECP4 K ECP4 D DELNOD Q
 S ECP20=+$P(PN,"^",20) I 'ECP20 K ECP20 D DELNOD Q
 S ECP10=+$P(PN,"^",10) I 'ECP10 K ECP10 D DELNOD Q
 S ECPP1=+$P(PNP,"^") I 'ECPP1 K ECPP1 D DELNOD Q
 S ECPP2=+$P(PNP,"^",2) I 'ECPP2 K ECPP2 D DELNOD Q
 S ECPP3=$P(PNP,"^",3),ECPP3=$S(ECPP3="Y":1,ECPP3="N":0,1:"")
 S ECPP4=$P(PNP,"^",4),ECPP4=$S(ECPP4="Y":1,ECPP4="N":0,1:"")
 S ECPP5=$P(PNP,"^",5),ECPP5=$S(ECPP5="Y":1,ECPP5="N":0,1:"")
 S ECPP6=$P(PNP,"^",6),ECPP6=$S(ECPP6="Y":1,ECPP6="N":0,1:"")
 S ECPP9=$P(PNP,"^",9),ECPP9=$S(ECPP9="Y":1,ECPP9="N":0,1:"")
 S ECPP10=$P(PNP,"^",10),ECPP10=$S(ECPP10="Y":1,ECPP10="N":0,1:"")
 S ECPP11=$P(PNP,"^",11),ECPP11=$S(ECPP11="Y":1,ECPP11="N":0,1:"")
 S ECPP12=$P(PNP,"^",12),ECPP12=$S(ECPP12="Y":1,ECPP12="N":0,1:"")
 S ECPP1A="" I $P(PN,"^",9)["EC" S ECPP1A=$G(^EC(725,+$P(PN,"^",9),0)),ECPP1A=$P(ECPP1A,"^",2)_"  "_$P(ECPP1A,"^")
 S ECELIG=$S($G(ECELIG):ECELIG,1:"")
NODE ;sets "PCE" node
 ;d/t~dfn~hosp loc~inst~dss id~*prov(not filled)~*prov2*~prov3~vol~cpt~dx~ao~rad~env~sc~ecs nat # & name~eligibility~mst~hnc~cv~proj112/shad
 S PNODE=ECP3_"~"_ECP2_"~"_ECP19_"~"_ECP4_"~"_ECP20_"~~~~"_ECP10_"~"_ECPP1_"~"_ECPP2_"~"_ECPP3_"~"_ECPP4_"~"_ECPP5_"~"_ECPP6_"~"_ECPP1A_"~"_ECELIG_"~"_ECPP9_"~"_ECPP10_"~"_ECPP11_"~"_ECPP12
 S ^ECH(ECFN,"PCE")=PNODE
 ;set "PCE1" node
 ;CPT modifier1;CPT modifier 2;CPT modifier 3;...CPT modifier n
 I PNMOD'="" S ^ECH(ECFN,"PCE1")=PNMOD
 ;Replace set of SEND TO PCE w/direct task call - patch 95
 ;S DA=ECFN,DIE=721,DR="31////"_ECDT D ^DIE K DA,DIE,DR
 S EC2PCE(ECDT,ECFN)=""
 D PCETASK^ECPCEU(.EC2PCE) K EC2PCE  ;send to PCE task
 K ECP2,ECP3,ECP4,ECP10,ECP19,ECP20,ECPP1,ECPP1A,ECPP2,ECPP3,ECPP4,ECPP5,ECPP6,ECPP9,ECPP10,ECPP11,ECPP12,ECREAS,ECPCL,PN,PNP,PNODE,ECELIG,PNMOD
 Q
CLIN ;check for active associated clinic
 S MSG1=1,MSG2=0
 D CLIN^ECPCEU
 I 'ECPCL D
 .W !!,"The clinic ",$S(MSG1:"associated with",1:"you selected for")," this procedure ",$S(MSG2:"has not been entered",1:"is inactive"),"."
 .W !,"Workload data cannot be sent to PCE for this procedure with ",!,$S(MSG2:"a missing",1:"an inactive")," clinic."
 S (MSG1,MSG2)=0
 Q
 ;
 ;
KILLR ;- Kill 'R' (Reason) node
 ;
 K ^ECH(ECFN,"R")
 Q
 ;
 ;
DELNOD ;- Delete 'PCE' and 'Send' nodes
 ;
 N DA,DIE,DR
 ;
 ;- Lock node
 L +^ECH(ECFN):5 Q:'$T
 S DA=ECFN
 S DIE="^ECH("
 S DR="30////@;31////@;37////@"
 ;
 ;- Delete contents
 D ^DIE
 ;
 ;- Unlock node
 L -^ECH(ECFN)
 Q
