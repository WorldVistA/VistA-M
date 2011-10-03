PXDELENC ;BAY/RJV-CLEAN UP ENCOUNTERS POINTING TO VISITS THAT DO NOT EXIST. ;14-JUN-2005 
 ;;1.0;PCE;**153**;14-JUL-2004
EN ;Entry Point.
 N DIR,DA,ZTRTN,ZTDESC,PXOPT,ZTSK,ZTQUEUED,ZTIO,POP
 S DIR("?")="Please enter 1, 2, 3, or 4."
 S DIR("?",1)="Please note: Options 1 -3 work directly from the temporary"
 S DIR("?",2)="file created by date range under Option 1 - BUILD."
 S DIR("?",3)="While Option 4 works with the individual patient selected."
 S DIR("?",4)="Option 4 may show different results than the Build Report"
 S DIR("?",5)="displays all existing problem encounters by patient."
 S DIR("?",6)=""
 S DIR(0)="SO^1:BUILD;2:REPORT;3:FIX ALL BUILD ERRORS;4:FIX INDIVIDUAL"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="1 Build  2 Report  3 Fix All Build Errors  4 Fix Individual"
 D ^DIR
 S PXOPT=Y
 Q:PXOPT=""
 K DIR,DA Q:$D(DIRUT)
 I PXOPT=1 D ASKBLD
 I PXOPT=2 D PRINT
 I PXOPT=3 D FIXALL^PXDELFIX
 I PXOPT=4 D FIXIND^PXDELFIX
 Q
ASKBLD ;
 N PXPAT,PXSDATE,PXENC,PXVISIT,PXPRIM,PXSTART,PXEND,PXCOUNT,PXSEC,PXPRI
 N PXSDT,PXEDT,PXRANGE,PXREM,Y,%,DIRUT,PXPURGE,PXCREATE,X1,X2,PXATYP
 D NOW^%DTC S (PXCREATE,X1)=%,X2=120 D C^%DTC S PXPURGE=X
 S ^XTMP("PXDELENC",0)=PXPURGE_"^"_PXCREATE
 S Y=$G(^XTMP("PXDELENC","START BUILD")) D DD^%DT S PXSTART=Y
 S Y=$G(^XTMP("PXDELENC","END BUILD")) D DD^%DT S PXEND=Y
 I PXEND="RUNNING" D  Q
 .W !!,"Build started on ",PXSTART," still running!"
 .D WAIT
 S PXSDT=$P($G(^XTMP("PXDELENC","PXENC",0)),"^",1)
 S PXEDT=$P($G(^XTMP("PXDELENC","PXENC",0)),"^",2)
 S Y=PXSDT D DD^%DT S PXSDT=Y
 S Y=PXEDT D DD^%DT S PXEDT=Y
 S PXREM=$G(^XTMP("PXDELENC","PXENC","PXCOUNT"))
 I PXEND'="" D
 .W !!,"Last Build completed on ",PXEND
 .W !,"using a date range of ",PXSDT," thru ",PXEDT
 .I PXREM>0 W !!,"This build contains ",PXREM," items to be fixed.",!
 .I PXREM=0 W !!,"There are 0 remaining items to be fixed.",!
 S DIR("A")="Do you wish to continue with NEW Build? "
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR
 K DA,DIR Q:$D(DIRUT)
 I Y=0 Q
ASKBDT ;
 S %DT="AEPX",%DT("A")="Enter Begin date for build: "
 D ^%DT S PXSDT=Y
 I X="^" Q
 I Y=-1 W !!,"Invalid Date!",! G ASKBDT
 K %DT,Y
ASKEDT ;
 S %DT="AEPX",%DT("A")="Enter Ending date for build: "
 D ^%DT S PXEDT=Y
 I X="^" Q
 I Y=-1 W !!,"Invalid Date!",! G ASKEDT
 K %DT,Y
 K ^XTMP("PXDELENC","PXENC")
 S $P(^XTMP("PXDELENC","PXENC",0),"^",1)=PXSDT
 S $P(^XTMP("PXDELENC","PXENC",0),"^",2)=PXEDT
 D CLEAR^VALM1
 S ZTRTN="BUILD^PXDELENC"
 S ZTDESC="UTILITY TO LOOK FOR MISSING VISITS"
 S ZTSAVE("PX*")="",ZTSAVE("XM*")="",ZTIO=""
 D ^%ZTLOAD
 I $D(ZTSK) W !,"Request Queued!"
 D WAIT
 Q
BUILD ; Build missing visits enconters.
 S PXPAT="",PXENC="",PXATYP=""
 D NOW^%DTC S PXSTART=%
 S ^XTMP("PXDELENC","START BUILD")=PXSTART
 S ^XTMP("PXDELENC","END BUILD")="RUNNING"
 S ^XTMP("PXDELENC",0)=$$FMADD^XLFDT(PXSTART,60)_"^"_PXSTART
 S PXSDATE=PXSDT
 F  S PXSDATE=$O(^SCE("B",PXSDATE)) Q:PXSDATE=""!($P(PXSDATE,".")>PXEDT)  D 
 .F  S PXENC=$O(^SCE("B",PXSDATE,PXENC)) Q:PXENC=""  D
 ..S PXPAT=$P($G(^SCE(PXENC,0)),"^",2)
 ..I $G(PXPAT)="" Q
 ..S PXATYP=$P($G(^DPT(PXPAT,"S",PXSDATE,0)),"^",2)
 ..I PXATYP["C" Q
 ..S PXVISIT=$P($G(^SCE(PXENC,0)),"^",5)
 ..S PXPRIM=$P($G(^SCE(PXENC,0)),"^",6)
 ..S PXSEC="" I $P($G(^SCE(PXENC+1,0)),"^",6)=PXENC S PXSEC=PXENC+1
 ..I $G(PXVISIT)'="" Q
 ..I $G(PXVISIT)="",$G(PXPRIM)'="" Q
 ..I $G(PXVISIT)="",$D(^DPT(PXPAT,"S",PXSDATE,0)) D
 ...S ^XTMP("PXDELENC","PXENC",PXPAT,PXSDATE,PXENC)=$G(PXSEC)
 D NOW^%DTC S PXEND=%
 S ^XTMP("PXDELENC","PXENC","PXCOUNT")=$$COUNT()
 S ^XTMP("PXDELENC","END BUILD")=PXEND
 D PXMAIL
 Q
PRINT ; Print report of missing visits.
 N PXPAT,PXENC,PXSDATE,PXPATNM,PXNUMNM,%ZIS,PXSDTE,PXEND,PXPAGE
 N PXPRIM,PXPRIX,PXWARN
 S PXPAT=0,PXSDATE="",PXENC="",PXEND="",PXPAGE=0,PXWARN=0
 I $G(^XTMP("PXDELENC","END BUILD"))="RUNNING" D  Q
 .W !!,"Build is running, please wait until complete!"
 .D WAIT
 I $G(^XTMP("PXDELENC","PXENC","PXCOUNT"))=0 D  Q
 .W !!,"No missing visits found!"
 .D WAIT
 S %ZIS="Q" D ^%ZIS
 I POP Q
 I $G(IO("Q"))=1 D  Q
 .N ZTRTN,ZTDESC,ZTSAVE
 .S ZTRTN="PRINT1^PXDELENC",ZTDESC="MISSING VISIT REPORT"
 .S ZTSAVE("PX*")=""
 .D ^%ZTLOAD K IO("Q")
PRINT1 ;
 U IO
 D HDR
 F  S PXPAT=$O(^XTMP("PXDELENC","PXENC",PXPAT)) Q:PXPAT=""!(PXEND)  D
 .F  S PXSDATE=$O(^XTMP("PXDELENC","PXENC",PXPAT,PXSDATE)) Q:PXSDATE=""!(PXEND)  D
 ..F  S PXENC=$O(^XTMP("PXDELENC","PXENC",PXPAT,PXSDATE,PXENC)) Q:PXENC=""!(PXEND)  D
 ...S PXPRIX=""
 ...S PXSDTE=PXSDATE
 ...S Y=PXSDTE D DD^%DT S PXSDTE=Y
 ...S PXPATNM=$P($G(^DPT(PXPAT,0)),"^",1)
 ...S PXNUMNM=PXPAT_" - "_PXPATNM
 ...S PXSEC=$G(^XTMP("PXDELENC","PXENC",PXPAT,PXSDATE,PXENC))
 ...I '$D(^SCE(PXENC)),$G(PXSEC)'="" S PXPRIX="*",PXWARN=1
 ...W !,?2,$E(PXNUMNM,1,32),?35,PXSDTE,?55,PXENC,?65,$G(PXSEC)_PXPRIX
 ...D HDR:$Y+3>IOSL Q:PXEND
 I PXWARN D
 .W !!,?15,"* Secondary Encounter exists without Primary!"
 .W !,?15,"Please note: Secondary Encounters can only be corrected"
 .W !,?15,"by the FIX ALL option as the FIX INDIVIDUAL option requires"
 .W !,?15,"the Primary Encounter to exist."
 D:'PXEND WAIT
 W @IOF
 D ^%ZISC
 Q
HDR ;
 N PXSDT,PXEDT
 S PXSDT=$P($G(^XTMP("PXDELENC","PXENC",0)),"^",1)
 S PXEDT=$P($G(^XTMP("PXDELENC","PXENC",0)),"^",2)
 S Y=PXSDT D DD^%DT S PXSDT=Y
 S Y=PXEDT D DD^%DT S PXEDT=Y
 I PXPAGE>0,$E(IOST,1,2)="C-" S PXEND=$$EOP() Q:PXEND
 S PXPAGE=PXPAGE+1
 W:PXPAGE'=1 @IOF
 W !!,"Missing Visit Report for Date Range of ",$G(PXSDT)_" - "_$G(PXEDT),!!
 W !,?2,"Patient IEN - Name",?35,"Appt Date",?55,"Prim Enc",?65,"2nd Enc"
 W !,?2,"==================",?35,"=========",?55,"========",?65,"======="
 Q
EOP() ; End of page check
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 I $E(IOST,1,2)'="C-" Q 0  ;NOT TERMINAL
 S DIR(0)="E"
 D ^DIR
 Q 'Y
PXMAIL ;Send mail message when build complete.
 N XMAIL,XMSUB,XMDUZ,XMTEXT,PXTEXT,Y,XMY,XMMG,XMZ
 S Y=$G(PXSTART) D DD^%DT S PXSTART=Y
 S Y=$G(PXEND) D DD^%DT S PXEND=Y
 S Y=$G(PXSDT) D DD^%DT S PXSDT=Y
 S Y=$G(PXEDT) D DD^%DT S PXEDT=Y
 S ZTQUEUED=1
 S PXTEXT(1)="PCE DELETE ENCOUNTER W/O VISIT is ready to report & fix."
 S PXTEXT(2)="Build (PXDELENC) for range of "_$G(PXSDT)_"-"_$G(PXEDT)_" has completed"
 S PXTEXT(3)="Start time: "_$G(PXSTART)_" End time: "_$G(PXEND)
 S XMSUB="PCE Delete Encounters W/O Visit...Build Completed.."
 S XMTEXT="PXTEXT(",XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 S ^XTMP("PXDELENC","PXENC","PXMAIL")=$G(XMZ)_"^"_DUZ_"^"_$G(XMMG)
 K XMSUB,XMTEXT,XMY
 Q
WAIT ;
 Q:IO'=$G(IO("HOME"))
 N DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 W ! S DIR(0)="E" S DIR("A")="Enter RETURN to continue" D ^DIR W !
 Q
COUNT() ;
 N PXCOUNT,PXPAT,PXSDATE,PXENC
 S PXCOUNT=0,PXPAT="",PXSDATE="",PXENC=""
 F  S PXPAT=$O(^XTMP("PXDELENC","PXENC",PXPAT)) Q:PXPAT=""  D
 .F  S PXSDATE=$O(^XTMP("PXDELENC","PXENC",PXPAT,PXSDATE)) Q:PXSDATE=""  D
 ..F  S PXENC=$O(^XTMP("PXDELENC","PXENC",PXPAT,PXSDATE,PXENC)) Q:PXENC=""  D
 ...S PXCOUNT=PXCOUNT+1
 Q PXCOUNT
 ;
