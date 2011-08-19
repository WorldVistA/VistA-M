RAXSTAT ;HIRMFO/GJC-Examination Status List (Print) ;7/24/97  15:18
 ;;5.0;Radiology/Nuclear Medicine;**31**;Mar 16, 1998
EN1 ; Display Exam Status data by I-Type
 K RAVRAD
VEN1 K RADIC,RAQUIT,RAUTIL
 S RADIC="^RA(79.2,",RADIC(0)="QEAMZ"
 S RADIC("A")="Select Imaging Type: ",RAUTIL="RA XAM STAT"
 K ^TMP($J,RAUTIL),^TMP($J,"RA ASK"),^TMP($J,"RA REQ")
 D EN1^RASELCT(.RADIC,RAUTIL,"","")
 K RADIC,RAUTIL I RAQUIT K RAQUIT,I,POP Q
 K RAQUIT
DEV ; Device selection
 W ! S %ZIS="QM",%ZIS("A")="Select Device: "
 D ^%ZIS I POP K DTOUT,DUOUT,POP Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="START^RAXSTAT"
 . S ZTDESC="Rad/Nuc Med Display Examination Status List."
 . S ZTSAVE("^TMP($J,""RA XAM STAT"",")=""
 . I $D(RAVRAD)#2 S ZTRTN="STARTV^RAXSTAT",ZTDESC="Rad/Nuc Med Display VistaRad Category List.",ZTSAVE("RAVRAD")=""
 . D ^%ZTLOAD
 . I +$G(ZTSK("D"))>0 W !?5,"Request Queued, Task #: ",$G(ZTSK)
 . D HOME^%ZIS K %X,%XX,%Y,%YY,IO("Q"),X,Y,ZTSK
 . D EXIT
 . Q
 I $D(RAVRAD)#2 D STARTV Q  ; VistaRad Category only
 D START,EXIT
 Q
START ; Display output
 N I,J,K,RA1,RA72,RAFF,RAFLD,RAFLG,RAHD1,RAHD2,RAIEN,RAIT,RALINE,RANODE
 N RAORD,RAPCE,RAPG,RAR,RAREQ,RAREQL,RASK,RASKL,RAST,RAWORK,RAWORKL
 N RAXIT S (RAFLG,RAPG,RAXIT)=0
 S:$D(ZTQUEUED) ZTREQ="@" U IO S RAHD1="Examination Statuses"
 S RAHD2="Run Date: "_$$FMTE^XLFDT($$NOW^XLFDT(),"1P")
 S RASK="ASK ON STATUS TRACKING:",$P(RASKL,"-",($L(RASK)+1))=""
 S RAREQ="REQUIRED FOR CHANGE TO THIS STATUS:"
 S $P(RAREQL,"-",($L(RAREQ)+1))=""
 S RAWORK="WORKLOAD REPORTS THAT USE THIS STATUS IN ITS COMPLETION:"
 S $P(RAWORKL,"-",($L(RAWORK)+1))=""
 S $P(RALINE,"-",(IOM+1))="" S (RA1,RAIT)=""
 F  S RAIT=$O(^TMP($J,"RA XAM STAT",RAIT)) Q:RAIT']""  D  Q:RAXIT
 . S RA1=1,RAORD="" S:RAFLG RAXIT=$$EOS^RAUTL5() Q:RAXIT
 . D HDR ; Form feed for every I-Type encountered
 . F  S RAORD=$O(^RA(72,"AA",RAIT,RAORD)) Q:RAORD']""  D  Q:RAXIT
 .. S RAIEN=0
 .. F  S RAIEN=+$O(^RA(72,"AA",RAIT,RAORD,RAIEN)) Q:RAIEN'>0  D  Q:RAXIT
 ... D FORMAT
 ... Q
 .. Q
 . Q
 Q:RAXIT
 I 'RAFLG D HDR W !!,$$CJ^XLFSTR("*** No records to print! ***",IOM)
 Q
EXIT ; Kill variables
 W ! D ^%ZISC K ^TMP($J,"RA XAM STAT")
 K %XX,%YY,Y,POP,I,DISYS,RAVRAD
 S X=$$EOS^RAUTL5() K X
 Q
FORMAT ; Format the output
 S RAFF=0,RAFLG=1
 S RA72(0)=$G(^RA(72,RAIEN,0)),RA72(.1)=$G(^RA(72,RAIEN,.1))
 S RA72(.2)=$G(^RA(72,RAIEN,.2)),RA72(.3)=$G(^RA(72,RAIEN,.3))
 S RA72(.5)=$G(^RA(72,RAIEN,.5)),RA72(.6)=$G(^RA(72,RAIEN,.6))
 K ^TMP($J,"RA ASK"),^TMP($J,"RA REQ")
 D SET(.RA72) ; set TMP globals to display parameters 'Ask On Status
 ; Tracking' & 'Required For Change To This Status' in a column format
 ; (side by side)
 I RA1 W !?10,"Type Of Imaging: ",RAIT S RA1=0
 W !!,"Status: ***",$P(RA72(0),"^")_"***",?54,"Order: ",RAORD
 W !,"Default Next Status: ",$$GET1^DIQ(72,+$P(RA72(0),"^",2)_",",.01)
 W ?54,"User Key Needed: ",$$GET1^DIQ(72,RAIEN_",",4)
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 W !,"Generate Examined HL7 Message: ",$$GET1^DIQ(72,RAIEN_",",8)
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 W !,"Generate Exam Alert: ",$$GET1^DIQ(72,RAIEN_",",1)
 W ?54,"Allow Cancelling?: ",$$GET1^DIQ(72,RAIEN_",",6)
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 W !,"Appear On Status Tracking?: ",$$GET1^DIQ(72,RAIEN_",",5)
 W ?54,"Print Dosage Ticket: ",$$GET1^DIQ(72,RAIEN_",",.611)
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 W !,"VistaRad Category: ",$$GET1^DIQ(72,RAIEN_",",9),!
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 W !,RASK,?39,RAREQ,!,RASKL,?39,RAREQL,!
 S (RAST,RAR)=.001
 F  D  Q:'RAST&('RAR)  Q:RAXIT
 . I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D
 .. S RAFF=0 D HDR W !,RASK,?39,RAREQ,!,RASKL,?39,RAREQL,!
 .. Q
 . W:RAFF ! D ASK:RAST,REQ:RAR S RAFF=1
 . Q
 Q:RAXIT  W !?9,RAWORK,!?9,RAWORKL
 F K=.31,.32,.33,.34,.35,.36,.37,.38,.39,.311,.312,.313,.314,.315 D  Q:RAXIT
 . S RAFLD=$P($G(^DD(72,K,0)),"^") Q:RAFLD=""
 . S RANODE=$E(K,1,2),RAPCE=$E(K,3,999999)
 . I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D
 .. D HDR W !?9,RAWORK,!?9,RAWORKL
 .. Q
 . I $$UP^XLFSTR($P(RA72(RANODE),"^",RAPCE))="Y" D
 .. W !?14,$P(RAFLD," REPORT?")
 .. Q
 . Q
 W ! K ^TMP($J,"RA ASK"),^TMP($J,"RA REQ")
 Q
ASK ; Display 'Ask on Status Tracking' parameters (if any)
 S RAST=$O(^TMP($J,"RA ASK",RAST)) Q:RAST'>0
 W ?4,$G(^TMP($J,"RA ASK",RAST))
 Q
HDR ; Header
 D:'$D(IOF) HOME^%ZIS W:$Y @IOF
 S RAPG=RAPG+1 W !?(IOM-$L(RAHD1)\2),RAHD1
 W ?$S(IOM=132:120,1:68),"Page: ",RAPG
 W !,$$CJ^XLFSTR(RAHD2,IOM),!,RALINE
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
REQ ; Display 'Required For Change To This Status' parameters (if any)
 S RAR=$O(^TMP($J,"RA REQ",RAR)) Q:RAR'>0
 W ?44,$G(^TMP($J,"RA REQ",RAR))
 Q
SET(RA72) ; set TMP globals so we can display parameters 'Ask On Status
 ; Tracking' & 'Required For Change To This Status' in a column format
 ; (side by side)
 ; Input Variable: 'Y' ien of file 72
 F I=.21,.22,.23,.24,.25,.26,.27,.28,.211,.213,.214,.61,.63,.64,.65,.67,.68,.69 D
 . S RAFLD=$P($G(^DD(72,I,0)),"^") Q:RAFLD=""
 . S RANODE=$E(I,1,2),RAPCE=$E(I,3,999999)
 . I $$UP^XLFSTR($P(RA72(RANODE),"^",RAPCE))="Y" D
 .. S:RAFLD["ASK FOR " RAFLD=$P(RAFLD,"ASK FOR ",2)
 .. S:RAFLD["ASK " RAFLD=$P(RAFLD,"ASK ",2)
 .. S ^TMP($J,"RA ASK",I)=$P(RAFLD,"?")
 .. Q
 . Q
 F J=.11,.12,.13,.14,.15,.16,.111,.112,.116,.113,.114,.51,.53,.54,.55,.57,.58,.59 D
 . S RAFLD=$P($G(^DD(72,J,0)),"^") Q:RAFLD=""
 . S RANODE=$E(J,1,2),RAPCE=$E(J,3,999999)
 . I $$UP^XLFSTR($P(RA72(RANODE),"^",RAPCE))="Y" D
 .. S:RAFLD[" REQUIRED?" RAFLD=$P(RAFLD," REQUIRED?")
 .. S ^TMP($J,"RA REQ",J)=RAFLD
 .. Q
 . Q
 Q
STARTV ;Display VistaRad Category only
 N RA1,RA72,RAFLG,RAHD1,RAHD2,RAIEN,RAIT,RAORD,RAPG,RALINE
 N RAXIT S (RAFLG,RAPG,RAXIT)=0
 S:$D(ZTQUEUED) ZTREQ="@" U IO S RAHD1="VistaRad Categories"
 S RAHD2="Run Date: "_$$FMTE^XLFDT($$NOW^XLFDT(),"1P")
 S $P(RALINE,"-",(IOM+1))="" S (RA1,RAIT)=""
 F  S RAIT=$O(^TMP($J,"RA XAM STAT",RAIT)) Q:RAIT']""  D  Q:RAXIT
 . S RA1=1,RAORD="" 
 . D:'RAPG HDR ; Form feed 1st page
 . F  S RAORD=$O(^RA(72,"AA",RAIT,RAORD)) Q:RAORD']""  D  Q:RAXIT
 .. S RAIEN=0
 .. F  S RAIEN=+$O(^RA(72,"AA",RAIT,RAORD,RAIEN)) Q:RAIEN'>0  D  Q:RAXIT
 ... S RAFLG=1
 ... S RA72(0)=$G(^RA(72,RAIEN,0))
 ... I RA1 D HDR3 S RA1=0 Q:RAXIT
 ... I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 ... W !,$P(RA72(0),"^"),?30,RAORD,?35,$$GET1^DIQ(72,RAIEN_",",9)
 .. Q
 . Q
 D EXIT
 Q
VRADP I '$$IMAGE^RARIC1() W !!,"Current system is not running Vista Imaging -- nothing done.",! Q
 S RAVRAD=1 G VEN1
HDR3 I $Y>(IOSL-10) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 W !!?10,"Type Of Imaging: ",RAIT,!,"Status",?27,"Order",?35,"VistaRad Category",!
 Q
