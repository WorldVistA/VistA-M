PSANDC ;BIR/LTL-NDC Duplicates Report ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine checks the ITEM FILE for multiple NDC's.
 ;
 ;References to $$DESCR^PRCPUX1 are covered by IA #259
 ;References to $$VENNAME^PRCPUX1 are covered by IA #259
 ;References to ^PRC( are covered by IA #214
 F I=0:1:4 W !,$P($T(NAR+I),";;",2,99)
NAR ;Expanation
 ;;     This report lists each National Drug Code (NDC) that has been
 ;;     entered for more than one item.  In order for the DRUG file to
 ;;     correctly link to the ITEM MASTER file, it is recommended that the NDC
 ;;     be removed from all but the one correct entry.
 D DT^DICRW
DEV ;asks device and queueing info
 K I,IO("Q") N %ZIS,DTOUT,DUOUT,IOP,POP,PSAOUT S %ZIS="Q" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" S PSAOUT=1 G END
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSANDC",ZTDESC="Duplicate NDC Report" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G END
START ;compiles and prints data for report
 N %DT,DIR,DIRUT,PSAPG,PSANDC,PSALN,PSANDCD,PSARPDT,X,Y S (PSANDC,PSANDCD)="",(PSAPG,PSAOUT)=0,Y=DT D DD^%DT S PSARPDT=Y D HEADER
LOOP F  S PSANDC=$O(^PRC(441,"F",PSANDC)) G:PSANDC=""!(PSAOUT) END D:$Y+10>IOSL HEADER D  G:PSAOUT END
 .S PSANDC(1)=0
 .F  S PSANDCD=$O(^PRC(441,"F",PSANDC,PSANDCD)) Q:'PSANDCD!(PSAOUT)  I $O(^PRC(441,"F",PSANDC,PSANDCD)),'$G(^PRC(441,+PSANDCD,3)),'$G(^PRC(441,+$O(^PRC(441,"F",PSANDC,PSANDCD)),3)) D  D:$Y+10>IOSL HEADER Q:PSAOUT
 ..S PSANDC(1)=PSANDC(1)+1
 ..W:PSANDC(1)=1 !,PSALN,!,?30,"NDC:  "_PSANDC,!!,"ITEM #",?10,"DESCRIPTION",?50,"VENDOR",!!,PSANDCD,?10,$E($$DESCR^PRCPUX1(0,PSANDCD),1,37),?50,$E($$VENNAME^PRCPUX1($O(^PRC(441,"F",PSANDC,PSANDCD,0))_"PRC(440"),1,30)
 ..W !!,$O(^PRC(441,"F",PSANDC,PSANDCD)),?10,$E($$DESCR^PRCPUX1(0,$O(^PRC(441,"F",PSANDC,PSANDCD))),1,37),?50,$E($$VENNAME^PRCPUX1($O(^PRC(441,"F",PSANDC,$O(^PRC(441,"F",PSANDC,PSANDCD)),0))_"PRC(440"),1,30)
END I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'$G(PSAOUT) W !! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !?2,"DUPLICATE NDC REPORT",?35,PSARPDT,?70,"PAGE: "_PSAPG,!,!!
 Q
