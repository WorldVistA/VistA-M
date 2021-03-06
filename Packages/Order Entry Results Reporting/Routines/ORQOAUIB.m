ORQOAUIB ;EPIP/RTW - LIST ANTI-MICROBIAL ORDER, ANTIMICROBIAL QUICK ORDER & NON-QUICK ORDER ; 12/28/17 2:20pm
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**441**;Dec 17, 1997;Build 52
 ;QUICK ORDER AUDIT MONTHLY REPORT AND QUICK ORDER AUDIT PRINT
 ;ICR#   Type  Description
 ;-----  ----  -------------------------------------
 ;10086  Sup   ^%ZIS
 ;10089  Sup   ^%ZISC
 ;10063  Sup   ^%ZTLOAD
 ;1456   Sup   ^DIC
 ;10103  Sup   $$FMDIFF^XLFDT
 ;10103  Sup   $$FMTE^XLFDT
 N ORSDATE,OREDATE,ORI,ORJ,ORCDSS,ORDIV,ORMISLOC,ORI1,OR2,Y,X2,ORWHO,%DT,%IS,DIC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP($J)
 I '$O(^OR(100.953,0)) W !,"No Groups Created in the QUICK ORDER DIVISION GROUPS File" Q
START W ! W !,"Past date ranges can be entered covering 31 days at a time.",!
 S %DT="AE",%DT("A")="Enter Starting Date: " D ^%DT Q:+Y'>0  S ORSDATE=+Y
 S %DT="AE",%DT("A")="Enter Ending Date: " D ^%DT Q:+Y'>0  S OREDATE=+Y
 I OREDATE<ORSDATE W !,"** ERROR ** - Ending Date needs to follow Starting Date",! G START
 S ORDIV="" I $O(^OR(100.953,0))>0 S DIC(0)="AEQM",DIC="^OR(100.953,",DIC("A")="Select MEDICAL CENTER DIVISION GROUP: " D ^DIC Q:+Y'>0 
 S ORDIV=+Y
 I $$FMDIFF^XLFDT(OREDATE,ORSDATE,1)>31 W !,"** ERROR ** - Only 31 days at a time is permitted",! G START
 K DIR S DIR("A")="Do you want a delimited report to a printer or home device",DIR(0)="Y",DIR("B")="NO" D ^DIR S ORDELIMT=Y
 K DIR S DIR("A")="Do you want to print orders with MISSING LOCATIONS",DIR(0)="Y",DIR("B")="NO" D ^DIR S ORMISLOC=Y
 I 'ORDELIMT S %IS="MQ" D ^%ZIS
 I ORDELIMT S %IS="MQ",%ZIS("A")=("DELIMITED REPORT DEVICE: ") D ^%ZIS
 I $D(IO("Q")) S ZTRTN="DQ^ORQOAUIB",ZTSAVE("ORSDATE")="",ZTSAVE("ORDELIMT")="",ZTSAVE("OREDATE")="",ZTIO=ION,ZTSAVE("IO*")="",ZTSAVE("ORDIV")="" D ^%ZTLOAD W !,"Task Queued: ",ZTSK Q
 U IO
DQ ; QUEUED ENTRY POINT
 S ORI=ORSDATE F  S ORI=$O(^OR(100,"AF",ORI)) Q:+ORI'>0!(+ORI>OREDATE)  S ORJ=0 F  S ORJ=$O(^OR(100,"AF",ORI,ORJ)) Q:+ORJ'>0  D
 . Q:'$$DIVMATCH(ORJ)  ; QUIT IF NOT FOR ONE OF REQUESTED DIVISIONS
 . Q:'$$ANTIMIC(ORJ)  ; QUIT IF NOT ANTI-MICROBIAL ORDER
 . S ORQUICK=$$ORQOAM(ORJ) ; DETERMINE WHETHER QUICK ORDER OR NON-QUICK ORDER
 . I ORQUICK S ^TMP($J,"QUICK",ORJ)=ORQUICK
 . E  S ^TMP($J,"NON-QUICK",ORJ)=""
 D PRINT("QUICK") ; PRINT ANTIMICROBIAL QUICK ORDERS
 D PRINT("NON-QUICK") ; PRINT NON-QUICK ORDERS
 K ^TMP($J),ORDRUGFN,ORPHDN,ORAM
 D ^%ZISC ; CLOSE OUTPUT DEVICE
 Q
DIVMATCH(ORRD) ; DETERMINE IF ORDER IS FOR REQUESTED DIVISION
 N ORLLOC,ORRQDIV
 I ORDIV="" Q 1 ; NO DIVISIONS REQUESTED
 S ORLLOC=$P(^OR(100,ORRD,0),U,10) I +ORLLOC>0,ORLLOC["SC" S ORRQDIV=$P(^SC(+ORLLOC,0),U,15)
 I ORMISLOC,+ORLLOC=0 Q 1  ;RTW ADD MISSING LOCATION TO MONTHLY
 I $G(ORRQDIV)>0,$D(^OR(100.953,ORDIV,1,"B",ORRQDIV)) Q 1
 E  Q 0
ANTIMIC(ORRD) ; DETERMINE IF ORDER HAS ANY ANTIMICROBIAL ITEMS
 N ORI,ORJ
 S (ORI,ORAM)=0 F  S ORI=$O(^OR(100,ORRD,.1,"B",ORI)) Q:+ORI'>0  D
 . S ORPHDN=$P($P(^ORD(101.43,ORI,0),"^",2),";",1)
 . Q:$P($P(^ORD(101.43,ORI,0),"^",2),";",2)'["PS"
 . S ORDRUGFN=0,ORDRUGFN=$O(^PS(50.7,"A50",ORPHDN,ORDRUGFN))
 . Q:'$G(ORDRUGFN)
 . S:$P(^PSDRUG(ORDRUGFN,0),"^",2)["AM" ORAM=1
 Q ORAM
ORQOAM(ORKK0) ; DETERMINE IF ORDER IS QUICK ORDER OR NOT
 ;LOOK FOR AUDIT IFN IN COMMENTS, STORE IFN OF ORDER IN AUDIT FILE
 N ORK,ORKK,ORQUICK
 S ORQUICK=0 ; INITIALIZE TO NON-QUICK ORDER
 I ORKK0]"",ORKK0["** Pharmacy Confirmation #: " S ORQUICK=1_"^"_ORKK0 ;IDENTIFIED AS QUICK ORDER
 I $D(^OR(100,ORJ,8,0)) S ORK=0 F  S ORK=$O(^OR(100,ORJ,8,ORK)) Q:+ORK'>0  I $D(^OR(100,ORJ,8,ORK,.1,0)) S ORKK=0 F  S ORKK=$O(^OR(100,ORJ,8,ORK,.1,ORKK)) Q:ORKK'>0  D
 .S ORKK0=^OR(100,ORJ,8,ORK,.1,ORKK,0) I ORKK0["** Pharmacy Confirmation" S ORQUICK=1_"^"_ORKK0 ; IDENTIFIED AS QUICK ORDER
 Q ORQUICK
PRINT(ORZ) ; PRINT RESULTS
 ; ORWHO = 'WHO ENTERED' field
 ; ORCNUM = Pharmacy Confirmation No (Record # in file 100.95)
 ; OR2EDAT = 'WHEN ENTERED' field
 ; OR2PAT  = Patient Name and last 4 of SSN
 ; OR2PRB  = 'CURRENT AGENT/PROVIDER' field
 ; OR2LOC  = 'PATIENT LOCATION' field
 N ORX0,X8,ORI,ORK,OR2DOTS,OR2PROV,ORCNUM,OR2EDAT,OR2HFS,OR2PAT,DFN,OR2SSN,OR2LOC,OR2OITEM
 S OR2HFS=$$HFS() ; DETERMINE WHETHER PRINTER OR HFS DEVICE
 I OR2HFS,ORZ="QUICK" W "Type"_U_"Order #"_U_"Patient"_U_"Who Entered"_U_"Confirm #"_U_"When Entered"_U_"Provider"_U_"Location"_U_"Orderable Item"
 I ORDELIMT,ORZ="QUICK" W "Type"_U_"Order #"_U_"Patient"_U_"Who Entered"_U_"Confirm #"_U_"When Entered"_U_"Provider"_U_"Location"_U_"Orderable Item"
 I 'ORDELIMT,'OR2HFS,ORZ="QUICK" W !!,"Anti-Microbial Orders",?65 D ^%D W:ORDIV]"" !,"Division Group: ",$P(^OR(100.953,ORDIV,0),"^",1) W !,ORZ," Orders" S $P(OR2DOTS,"-",81)="" D
 .W !!,"Order #",?12,"Patient" W:ORZ="QUICK" ?30,"Confirm #" W ?42,"Who Entered",?68,"When Entered",!?12,"Location",?42,"Provider",!?42,"Orderable Item",!,OR2DOTS
 .W !
 I OR2HFS,ORZ="NON-QUICK" W !,"Type"_U_"Order #"_U_"Patient"_U_"Who Entered"_U_"Confirm #"_U_"When Entered"_U_"Provider"_U_"Location"_U_"Orderable Item"
 I ORDELIMT,ORZ="NON-QUICK" W !,"Type"_U_"Order #"_U_"Patient"_U_"Who Entered"_U_"Confirm #"_U_"When Entered"_U_"Provider"_U_"Location"_U_"Orderable Item"
 I 'ORDELIMT,'OR2HFS,ORZ="NON-QUICK" W !!,"Anti-Microbial Orders",?65 D ^%D W:ORDIV]"" !,"Division Group: ",$P(^OR(100.953,ORDIV,0),"^",1) W !,ORZ," Orders" S $P(OR2DOTS,"-",81)="" D
 .W !!,"Order #",?12,"Patient" W:ORZ="NON-QUICK" ?30,"Confirm #" W ?42,"Who Entered",?68,"When Entered",!?12,"Location",?42,"Provider",!?42,"Orderable Item",!,OR2DOTS
 .W !
 S ORI=0 F  S ORI=$O(^TMP($J,ORZ,ORI)) Q:+ORI'>0  D
 .S ORX0=$G(^OR(100,ORI,0))
 .S ORWHO=$P(ORX0,"^",6),ORWHO=$E($P(^VA(200,ORWHO,0),U,1),1,20)
 .S ORCNUM=^TMP($J,ORZ,ORI) I ORCNUM]"" S ORCNUM=$P($P(ORCNUM,"Confirmation #: ",2)," ",1)
 .S OR2EDAT=$P(ORX0,U,7) I OR2EDAT<ORSDATE!(OR2EDAT>OREDATE) Q  ; ORDER NOT ENTERED WITHIN DATE RANGE
 .S OR2PAT=$P(ORX0,U,2),DFN=+OR2PAT
 .I +DFN>0 S OR2PAT=$P(^DPT(DFN,0),U,1),OR2SSN=$E($P(^DPT(DFN,0),U,9),6,9),OR2PAT=$P(OR2PAT,",",1),OR2PAT=OR2PAT_" ("_OR2SSN_")"
 .E  S OR2PAT="No Patient"
 .S OR2EDAT=$$FMTE^XLFDT(OR2EDAT,"2D")
 .S OR2PROV=$P(ORX0,U,4) S:+OR2PROV>0 OR2PROV=$P(^VA(200,OR2PROV,0),U,1)
 .S OR2LOC=$P(ORX0,U,10) I +OR2LOC>0 S X2=$P(OR2LOC,";",2) S OR2LOC=$P(@("^"_X2_+OR2LOC_",0)"),U,1)
 .D ITEM
 .I ORMISLOC,$P(OR2LOC,";",1)=0 S OR2LOC="MISSING LOCATION"  ;RTW
 .I ORDELIMT!OR2HFS W !,ORZ_U_ORI_U_OR2PAT_U_ORWHO_U_ORCNUM_U_OR2EDAT_U_OR2PROV_U_OR2LOC_U_OR2OITEM
 .E  W !,ORI,?12,OR2PAT,?32,ORCNUM,?42,ORWHO,?71,OR2EDAT,!?12,OR2LOC,?42,OR2PROV,!?42,OR2OITEM,!!
 Q
HFS() ; RETURN '1' IF OUTPUTTING TO A FILE, '0' FOR DEVICE
 I $P(^%ZIS(1,IOS,"TYPE"),U,1)="HFS" Q 1
 Q 0
ITEM   ;Define the antimicrobial drug name.
 I $G(ORDRUGFN) D
 . S OR2OITEM="",ORQQ=0
 . I $D(^OR(100,ORI,.1)) S ORI1=0 F  S ORI1=$O(^OR(100,ORI,.1,"B",ORI1)) Q:ORI1'>0  Q:ORQQ  D
 . . S ORPHDN=$P($P(^ORD(101.43,ORI1,0),"^",2),";",1)
 . . S ORDRUGFN=0,ORDRUGFN=$O(^PS(50.7,"A50",ORPHDN,ORDRUGFN))
 . . Q:'$G(ORDRUGFN)
 . . S:$P(^PSDRUG(ORDRUGFN,0),"^",2)["AM" OR2OITEM=$P(^PSDRUG(ORDRUGFN,0),U,1),ORQQ=1
 K ORQQ Q
QOAP ;This is the Quick Order Audit Print Option Entry point, The report is designed to show whether the entry in file 100.95 was a poke or an order
 N L,BY,FLDS
 S DIC="100.95",L=0,BY="[OR QUICK ORDER AUDIT REPORT]",FLDS="[OR QUICK ORDER AUDIT REPORT]" D EN1^DIP
 Q
