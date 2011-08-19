ORELR5 ; slc/dcm - Check 69 against 100 ;
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**42**;Dec 17, 1997
EN ;Check file 69 against 100 for inconsistencies
 N %,UPD,ZTSAVE
 W !!,"This routine will go through the LAB ORDER ENTRY file (69)"
 W !,"and check for inconsistencies between Lab files and CPRS files."
 W !,"This process could take several hours to complete."
 W !,"Are you sure you want to continue"
 S %=2 D YN^DICN
 I %=0 W !!,"Answer YES to continue" G EN
 Q:%'=1
UPD W !!,"You have the option of just checking the database, or updating the database."
 W !,"Do you want to update the database now"
 S %=2 D YN^DICN
 I %=0 W !!,"Select YES to update the database" G UPD
 Q:%=-1
 S UPD=$S(%=1:1,1:0)
 S ZTSAVE("UPD")=""
 D QUE^ORUTL1("DEQUE^ORELR5","Check from 69 to 100",.ZTSAVE)
 Q
DEQUE ;Queued entry point
 U IO
 W !,"Inconsistency report between LAB (69) and OE/RR (100) files..."
 W !,"Date/time Started: "_$$DATETIME^ORU($$NOW^XLFDT())
 W !,"Now looking for data..."
 N LRDFN,ORAFIX,STCNT,TOTCNT,DCNT,PTCNT,F100CNT,ENTCNT
 S (ORAFIX,STCNT,TOTCNT,DCNT,PTCNT,F100CNT,ENTCNT,LRDFN)=0
 F  S LRDFN=$O(^LRO(69,"D",LRDFN)) Q:LRDFN<1  D LOOP(LRDFN,UPD)
 W:IOSL-$Y<10 @IOF
 W !!,"Total Inconsistencies Found"
 W !,"Date/time Completed: "_$$DATETIME^ORU($$NOW^XLFDT())
 W !,"-------------------------------------------------"
 I DCNT W !,"Bad entry in ^LRO(69,""D""",?40,$J(DCNT,7)
 I F100CNT W !,"Broken pointer to 100",?40,$J(F100CNT,7)
 I ENTCNT W !,"Inconsistent entry dates",?40,$J(ENTCNT,7)
 I PTCNT W !,"Patient mismatch"_$S(UPD:" (not fixed)",1:""),?40,$J(PTCNT,7)
 I STCNT W !,"Status update on panel test",?40,$J(STCNT,7)
 W !,"================================================="
 W !,"Total: ",?40,$J(TOTCNT,7)
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
LOOP(LRDFN,ORAFIX) ;Loop on patient
 I '$D(^LR(LRDFN,0)) D WRT(,,,"No entry in ^LR("_LRDFN,ORAFIX) S DCNT=DCNT+1,TOTCNT=TOTCNT+1 K:ORAFIX ^LRO(69,"D",LRDFN) Q
 Q:$P(^LR(LRDFN,0),"^",2)'=2  ;Not in patient file.
 S DFN=$P(^LR(LRDFN,0),"^",3)
 Q:'$D(^LRO(69,"D",$G(LRDFN)))
 N LRODT,LRSN,LRTI,LRTST,LRENT,X,X0,X3,ORX1,ORX2,ORIFN,X8O
 S LRODT=0 F  S LRODT=$O(^LRO(69,"D",LRDFN,LRODT)) Q:'LRODT  S LRSN=0 F  S LRSN=$O(^LRO(69,"D",LRDFN,LRODT,LRSN)) Q:'LRSN  D
 . I '$D(^LRO(69,LRODT,1,LRSN,0)) D WRT(LRODT,LRSN,,"D X-ref invalid",ORAFIX) S DCNT=DCNT+1,TOTCNT=TOTCNT+1 K:ORAFIX ^LRO(69,"D",LRDFN,LRODT,LRSN) Q
 . S X=^LRO(69,LRODT,1,LRSN,0),LRENT=$P(X,"^",5)
 . S LRTI=0 F  S LRTI=$O(^LRO(69,LRODT,1,LRSN,2,LRTI)) Q:LRTI<1  S X0=^(LRTI,0) D
 .. S LRTST=+X0,ORIFN=$P(X0,"^",7)
 .. I ORIFN D
 ... I '$D(^OR(100,ORIFN)) D WRT(LRODT,LRSN,LRTI,"Broken pointer to 100:"_ORIFN,ORAFIX) S F100CNT=F100CNT+1,TOTCNT=TOTCNT+1 S:ORAFIX $P(^LRO(69,LRODT,1,LRSN,2,LRTI,0),"^",7)="P" Q  ;P=purged
 ... S X=^OR(100,ORIFN,0),X3=$G(^(3))
 ... I DFN'=+$P(X,"^",2) D WRT(LRODT,LRSN,LRTI,"Patient mismatch:"_ORIFN_"<"_$P(X3,"^",3)_">") S PTCNT=PTCNT+1,TOTCNT=TOTCNT+1 Q
 ... D STATUS(LRODT,LRSN,LRTI,X0,ORAFIX)
 ... I LRENT,$P(X,"^",7)>$S($P($P(X,"^",8),".",2):$P(X,"^",8),1:$P(X,"^",8)_".2359") D
 .... S ORX1=$$FMADD^XLFDT($P(X,"^",7),,,30),ORX2=$$FMADD^XLFDT($P(X,"^",7),,,-30)
 .... I LRENT<ORX2!(LRENT>ORX1) S ENTCNT=ENTCNT+1,TOTCNT=TOTCNT+1 I ORAFIX D
 ..... S $P(^OR(100,ORIFN,0),"^",7)=LRENT
 ..... I $P(X,"^",7)=+$G(^OR(100,ORIFN,8,1,0)) S X8O=$G(^(0)) D
 ...... N DI,DIC,DIE,DA,DR,D0,DQ,DISYS
 ...... I $P(X,"^",11) K ^OR(100,"ACT",$P(X,"^",2),9999999-+X8O,$P(X,"^",11),ORIFN,1)
 ...... K ^OR(100,"AC",$P(X,"^",2),9999999-+X8O,ORIFN,1),^OR(100,"AF",+X8O,ORIFN,1),^OR(100,"AS",$P(X,"^",2),9999999-(+X8O),ORIFN,1)
 ...... I $P(X8O,"^",16)=+X8O K ^OR(100,"AR",$P(X,"^",2),9999999-(+X8O),ORIFN,1) S ^OR(100,"AR",$P(X,"^",2),9999999-LRENT,ORIFN,1)="",$P(^OR(100,ORIFN,8,1,0),"^",16)=LRENT
 ...... S $P(^OR(100,ORIFN,8,1,0),"^")=LRENT,^OR(100,"AF",LRENT,ORIFN,1)=""
 ...... D S1^ORDD100(ORIFN,1,"",LRENT),SET^ORDD100(ORIFN,1),ACT1^ORDD100A(ORIFN,1)
 Q
WRT(LRODT,LRSN,LRTST,TEXT,FIXED) ;Write error message
 Q:$E(IOST,1,2)="P-"
 W "."
 ;W !,$G(LRODT)_";"_$G(LRSN)_";"_$G(LRTST)_"=>"_TEXT_$S($G(FIXED):" FIXED",1:"")
 Q
STATUS(I,J,K,Z,UPDATE) ;Check status of exploded panels
 Q:'$D(^LRO(69,I,1,J,2,K,0))  S:'$D(Z) Z=^(0)
 N F,X,X7,Z7,ORSTS,ORIFN
 K ^TMP("ORCHKLRO",$J)
 S F=1,Z7=$P(Z,"^",7)
 I $P(Z,"^",8) D
 . N TST,T,N
 . S T=0 F  S T=$O(^LAB(60,+Z,2,T)) Q:'T  S TST(+^(T,0))=""
 . S T=0 F  S T=$O(TST(T)) Q:'T  I $D(^LRO(69,I,1,J,2,"B",T)) S N=$O(^(T,0)) I $D(^LRO(69,I,1,J,2,N,0))  S X=^(0),X7=$P(X,"^",7) D
 .. I X7,Z7,X7'=Z7,'$D(^TMP("ORCHKLRO",$J,Z7)) D  Q
 ... N X1,X2
 ... S X1=$P($G(^OR(100,X7,3)),"^",3),X2=$P($G(^OR(100,Z7,3)),"^",3)
 ... Q:X1=""  Q:X2=""  Q:X1=X2  Q:X2=14  Q:X2=1  Q:X2=2  Q:X2=13
 ... I F S STCNT=STCNT+1,TOTCNT=TOTCNT+1
 ... S F=0
 ... I $G(UPDATE) D
 .... I $S(+$G(^DD(100,0,"VR")):+^("VR"),1:0)<3 S ORSTS=X1,ORIFN=Z7 D ST^ORX
 .... I $S(+$G(^DD(100,0,"VR")):+^("VR"),1:0)'<3 D STATUS^ORCSAVE2(Z7,X1)
 .... S ^TMP("ORCHKLRO",$J,Z7)=""
 K ^TMP("ORCHKLRO",$J)
 Q
