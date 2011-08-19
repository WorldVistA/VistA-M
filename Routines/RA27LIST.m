RA27LIST ;HIRMFO/SWM  -  List data after RA27PST ;12/21/01  11:10
VERSION ;;5.0;Radiology/Nuclear Medicine;**27**;Mar 16, 1998
 ; Use this AFTER RA27PST has finished to
 ; list report-to-exam pointer problems, from ^XTMP("RA-RA27PST) :
 ;  Orphan report's impression, report text
 ;  Exam's report's impression, report text
 ;
 ; A74= ien file 74 from 1st paired record
 ; B74= ien file 74 from 2nd paired record
 ; RA7003 = exam global node name
EN I '$O(^XTMP("RA-RA27PST",.99)) W !!,"There's no data warning in ^XTMP(""RA-RA27PST"", -- nothing done --" Q
 W !,"The post-install cleanup from patch RA*5.0*27 was tasked off ",!,"on " S Y=$P(^XTMP("RA-RA27PST",0),"^",2) D DD^%DT W Y S RAY=Y
 W "  This routine reads the cleanup's results,",!,"which are stored in ^XTMP(""RA-RA27PST"".  The results contain the report",!,"IDs for reports that couldn't have their duplicate Clinical History purged."
 W !!,"This routine outputs a listing of orphaned reports and the exams that",!,"they refer to.  This listing may be used by the Radiology and IRM staff",!,"to determine if an orphan report is valid or not."
 W !!,"The listing may be sent directly to the screen, or to a device.",!
DEV K %ZIS,IOP W ! S %ZIS="QM",%ZIS("A")="Select a device: "
 D ^%ZIS I POP G QOUT
 I '$D(IO("Q")) D START G QOUT
 S ZTRTN="START^RA27LIST",ZTSAVE("RAY")=""
 S ZTDESC="Checking results from ^XTMP(""RA-RA27PST"""
 D ^%ZTLOAD
 I +$G(ZTSK("D"))>0 W !?2,"Request Queued, Task #: ",$G(ZTSK)
 D HOME^%ZIS K IO("Q")
QOUT S:$D(ZTQUEUED) ZTREQ="@"
 W ! D ^%ZISC
 Q
START U IO
 W !,"Patch RA*5*27's post-install routine that was run on  ",RAY,!,"has found reports that are NOT linked to any exams."
 W !!,"The following listing shows the orphan report (not linked to any exam),",!,"the clinical history of the exam that the orphan refers to, and the exam's",!,"currently linked report, if any.",!
 S I=.99
1 S I=$O(^XTMP("RA-RA27PST",I)) Q:'I
 K X1,X2
 G:I#1'=0 1 ;first node of pair must be integer
 G:^XTMP("RA-RA27PST",I)["locked" 1 S X1=^(I)
 S A74=$P(X1,"ien=",2),A74=$P(A74," but")
 S I2=$O(^XTMP("RA-RA27PST",I)) G:(I2'=(I+.1)) 1 S X2=^(I2),I=I2
 S B74=$P(X2,"piece=",2)
 S RA7003=$P(X2,"'s"),RA7003=$E(RA7003,2,$L(RA7003))
 S HIST=$P(RA7003,",0)"),HIST=HIST_",""H"","
 W !!,"============================================================================"
 W !,"_____Orphan report_____ ",$P($G(^RARPT(A74,0)),"^"),": ",?60,"^RARPT(",A74
 D GETDEM(A74)
 W !?2,"RptStatus=",$P(^RARPT(A74,0),"^",5) W:$D(^(2005)) ", has Images"
 I $D(^(1)) W !?2,"Share rpt with case#: " S J="" F  S J=$O(^RARPT(A74,1,"B",J)) Q:J=""  W $P(J,"-",2) W:$O(^RARPT(A74,1,"B",J)) ", "
 W !,"Orphan's report impression:"
 S J=0 F  S J=$O(^RARPT(A74,"I",J)) Q:'J  W !?2,^(J,0)
 W !,"Orphan's report text:"
 S J=0 F  S J=$O(^RARPT(A74,"R",J)) Q:'J  W !?2,^(J,0)
 W !,"_____Exam's report_____ ",$S(+B74:$P(^RARPT(B74,0),"^"),1:"**Exam is not linked to a report**"),": " W:+B74 ?60,"^RARPT(",B74
 D:+B74 GETDEM(B74)
 I +B74 D
 . W !?2,"RptStatus=",$P(^RARPT(B74,0),"^",5) W:$D(^(2005)) ", has Images"
 . I $D(^(1)) W !?2,"Share rpt with case#: " S J="" F  S J=$O(^RARPT(B74,1,"B",J)) Q:J=""  W $P(J,"-",2) W:$O(^RARPT(B74,1,"B",J)) ", "
 W !,"Clinical History from exam:"
 S J=0 F  S J=$O(@(HIST_J_")")) Q:'J  W !?2,@(HIST_J_",0)")
 I +B74 D
 . W !,"Exam's report impression:"
 . S J=0 F  S J=$O(^RARPT(B74,"I",J)) Q:'J  W !?2,^(J,0)
 . W !,"Exam's report text:"
 . S J=0 F  S J=$O(^RARPT(B74,"R",J)) Q:'J  W !?2,^(J,0)
 G 1
GETDEM(X) ;
 Q:'$D(^RARPT(X,0))
 S RADFN=+$P($G(^RARPT(X,0)),"^",2),RADT=$P($G(^(0)),"^",3),RAPNAM="UNKNOWN",RAPSSN="UNKNOWN"
 S:RADFN RAPNAM=$$GET1^DIQ(70,RADFN,.01),RAPSSN=$$GET1^DIQ(70,RADFN,.09)
 W !,"Patient: ",RAPNAM,"  SSN: ",RAPSSN
 W "  Exm D/T: ",$E(RADT,4,5),"/",$E(RADT,6,7),"/",$E(RADT,2,3),"@",$E(RADT,9,10),":",$E(RADT,11,12)
 Q
