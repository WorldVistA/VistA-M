GECSUSEL ;WISC/RFJ-utility selection ;01 Nov 93
 ;;2.0;GCS;**2,41**;MAR 14, 1995;Build 7
 Q
 ;
 ;
CODESHET(BATCH) ;  select an existing code sheet
 ;  batch = only select code sheets for batch
 N %,%Y,DIC,GECSBADA,GECSSUPR,X,Y
 I $L(BATCH) S GECSBADA=+$O(^GECS(2101.1,"B",BATCH,0)) I 'GECSBADA W !,"BATCH ",BATCH," CANNOT BE FOUND IN FILE 2101.1." Q 0
 W !!,$S($D(^XUSEC("GECS SUPER EDITOR",+$G(DUZ))):"-- You can select all code sheets created for this batch type --",1:"-- You may only select code sheets which you have created --")
 I $D(^XUSEC("GECS SUPER EDITOR",DUZ)) S GECSSUPR=1
 S DIC("S")="I $P(^(0),U,4)=""""!($P(^(0),U,4)="_DUZ_")!($G(GECSSUPR))"
 I $G(GECSBADA) S DIC("S")=DIC("S")_",$P(^(0),U,3)="_GECSBADA
 S DIC="^GECS(2100,",DIC(0)="QEAM",DIC("A")="Select CODE SHEET ID Number: " D ^DIC
 I Y'>0 Q 0
 Q +Y
 ;
 ;
BATTYPE(DEFAULT,DONTASK) ;  select batch type parameters
 ;  default set to batch default in lookup, if set to '- GECO' it
 ;          will ask to select a batch name containing '- GECO'
 ;  dontask set to lookup on batch without asking
 ;  return gecs("batch")=batch name
 ;         gecs("batda")=batch da number
 ;         gecs("sysid")=system identidier (ams, etc)
 N %,%Y,DIC,X,Y
 ;
 K GECS("BATCH"),GECS("BATDA"),GECS("SYSID")
 S DIC="^GECS(2101.1,"
 ;
 ;  default is set (not null), lookup batch type, do not ask
 I $G(DONTASK),$L(DEFAULT),DEFAULT'="- GECO" D  Q
 .   S DIC(0)="MNZ",X=DEFAULT D ^DIC I Y'>0 Q
 .   D BATCHECK
 .   I '$G(GECS("BATDA")) K GECS("BATDA"),GECS("BATCH"),GECS("SYSID") Q
 .   W !,"Batch Type: ",GECS("BATCH")
 ;
 ;  ask batch type
 I DEFAULT="- GECO" S DIC("S")="I $P(^(0),U)[""- GECO""",DEFAULT=""
 I $L(DEFAULT) S DIC("B")=DEFAULT
 S DIC(0)="AEQMZ" D ^DIC I Y'>0 Q
 D BATCHECK
 I '$G(GECS("BATDA")) K GECS("BATDA"),GECS("BATCH"),GECS("SYSID") Q
 W !,"Batch Type: ",GECS("BATCH")
 D GEC2P41 ;GEC*2*41 - WARNING FOR BATCHES TO BE DISABLED IN THE FUTURE
 Q
 ;
 ;
BATNOFMS ;  select batch except for fms
 N DONTASK
 K GECS("BATCH"),GECS("BATDA"),GECS("SYSID")
 I $L($G(GECSSYS)) S DONTASK=1
 F  W ! D BATTYPE($G(GECSSYS),$G(DONTASK)) Q:'$G(GECS("BATDA"))  D  Q:$G(GECS("BATDA"))
 .   I GECS("SYSID")="FMS" W !,"*** FMS DOCUMENTS CANNOT BE SELECTED ***" K GECS("BATDA")
 I '$G(GECS("BATDA")) K GECS("BATCH"),GECS("BATDA"),GECS("SYSID")
 Q
 ;
 ;
BATCHECK ;  check selected batch and set up variables
 ;  y=selected batch;  y(0)=data for selected batch
 I $P(Y(0),"^",4)="" W !,"SYSTEM ID FOR BATCH TYPE ",$P(Y,"^",2)," HAS NOT BEEN ENTERED." Q
 S GECS("BATDA")=+Y,GECS("BATCH")=$P(Y,"^",2),GECS("SYSID")=$P(Y(0),"^",4)
 Q
 ;
 ;
TRANTYPE(DEFAULT,DONTASK) ;  ask transaction type-segment
 ;  default set to segment default in lookup
 ;  dontask set to lookup on segment without asking
 ;  gecs("batda")=batch da (from file 2101.1)
 ;  gecs("sysid")=system id (AMS)
 ;  return gecs("tt")=segment name
 ;         gecs("ttda")=segment da number
 ;         gecs("edit")=edit template name
 ;         gecsflag=1 to exit application
 N %,%Y,DIC,X,Y
 ;
 K GECS("TT"),GECS("TTDA"),GECS("EDIT"),GECSFLAG
 S DIC="^GECS(2101.2,",DIC("S")="I $P(^(0),U,4)="_GECS("BATDA")
 ;
 ;  segment defined, look it up and quit
 I $G(DONTASK),$L(DEFAULT) D  Q
 .   S DIC(0)="MNZ",X=DEFAULT D ^DIC I Y'>0 S GECSFLAG=1 Q
 .   D TTCHECK
 .   I '$G(GECS("SEGDA")) S GECSFLAG=1
 ;
 ;  ask for segment entry
 I $L($G(SEGMENT)),$G(GECS("SYSID"))="AMS" S DIC("B")=DEFAULT
 S DIC(0)="AEQMZ" D ^DIC I Y'>0 S GECSFLAG=1 Q
 D TTCHECK
 Q
 ;
 ;
TTCHECK ;  check selected transaction type and set up variables
 ;  y=selected entry;  y(0)=data for selected entry
 I $P(Y(0),"^",3)=""!($P(Y(0),"^",5)'="Y") W !,"THIS TRANSACTION TYPE ",$P(Y,"^",2),"  IS NOT YET ",$S($P(Y(0),"^",5)'="Y":"ACTIVATED",1:"AVAILABLE") Q
 I $P(Y(0),"^",4)="" W !,"THE BATCH TYPE FOR THIS TRANSACTION TYPE ",$P(Y,"^",2)," HAS NOT BEEN ENTERED." Q
 I $P(Y(0),"^",2)="" W !,"THE INPUT TEMPLATE FOR THIS TRANSACTION TYPE ",$P(Y,"^",2)," IS MISSING." Q
 S GECS("TTDA")=+Y,GECS("TT")=$P(Y,"^",2),GECS("EDIT")=$P(Y(0),"^",3)
 Q
 ;
 ;
BATCHSEL(GECSDICS) ;  select batch number from file 2101.3
 ;  gecsdics=screen
 N %,%Y,DIC,X,Y
 S DIC="^GECS(2101.3,",DIC(0)="QEAM",DIC("A")="Select BATCH NUMBER: "
 I GECSDICS'="" S DIC("S")=GECSDICS
 W ! D ^DIC I Y'>0 Q 0
 Q +Y
 ;
 ;
GEC2P41 ;;GEC*2*41  check for batch scheduled to be disabled - SSNR, PDL
 N I,GECB,GECBL,GECMSG,%,%I,XMSUB,XMTEXT,XMY
 ; INITIALIZE LIST OF BATCHES TO CHECK IN GECBL
 S I=1,GECBL="^" F  S GECB=$T(GEC2P41B+I) Q:GECB["GEC2P41B_END"  S GECBL($P(GECB,";",3))="",I=I+1
 D:$D(GECBL(GECS("BATCH")))
  . D NOW^%DTC
  . W !!,"**************"
  . W !,"NOTE: This batch type is scheduled to be disabled in May 2026."
  . W !,"Please enter a ServiceNOW ticket for 'VistA - Generic Code Sheet'"
  . W !,"if there are questions/concerns."
  . W !,"**************"
  . ;RECORD IN XTMP
  . S ^XTMP("GEC2P41",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^GEC*2*41 - batch type usage"
  . S ^XTMP("GEC2P41",%)=GECS("BATCH")_"^"_DUZ
  . ;SEND MSG
  . S XMY(.5)="",XMY(DUZ)="",XMY("FiscalMgmt@domain.ext")=""
  . S XMSUB="GEC*2*41 Usage Notification",XMTEXT="GECMSG"
  . S GECMSG(1)="GEC*2*41 Site "_$G(DUZ(2))_" had unexpected usage of GEC Batch Type "_GECS("BATCH")
  . D SENDMSG^XMXAPI(DUZ,XMSUB,XMTEXT,.XMY)
 Q
GEC2P41B ;;$Text list of batch types to be discontinued (future patch) for SSNR
 ;;A1BO CENSUS ROLL-UP
 ;;CONSULTING/ATTENDING
 ;;DDCSS - MENTAL HEALTH
 ;;HOSPITAL BASED HOME CARE- GECO
 ;;VOLUNTARY
 ;;GEC2P41B_END
 Q
