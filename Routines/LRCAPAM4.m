LRCAPAM4 ;SLC/RS/DALISC/FHS - LMIP PHASE 4 BUILD MAILMAN MESSAGES FOR LAB LMIP WORKLOAD TRANS ;8/23/91 1039;
 ;;5.2;LAB SERVICE;**42,105,119,201**;Sep 27, 1994
EN ;
 ;Message size <30K
 ;Message each institution
 ;Separate message for each month
 ;Format: $Institution #^Fx Name
 ;$$Division #^Fx name  $$$Reporting month
 ;*Workload code^in pat^out pat^other pat^qc^in stats^tot stats^manual input^reffered test
 ;\Workload code name
 ;-|treating specialty^count|........
EN1 ;
 K ^TMP($J) W @IOF,!!
 S LINE="PHASE 4 OF LMIP DATA COLLECTION" W !?(IOM-$L(LINE))\2,LINE,!
 S LINE="You should have already reviewed this LMIP data" W !?(IOM-$L(LINE))\2,LINE,!
 S LINE="in Phase 3. This option will create 1 or more mail message(s)" W !?(IOM-$L(LINE))\2,LINE,!
 S LINE="and will send it to you <ONLY>." W !?(IOM-$L(LINE))\2,LINE,!
 S LINE="    YOU MUST USE THE MAILMAN FUNCTION AND FORWARD THE MESSAGE(S)" W !?(IOM-$L(LINE))\2,LINE,!
 S LINE="TO AUSTIN DPC TO COMPLETE THE NATIONAL REPORTING PROCESS." W !?(IOM-$L(LINE))\2,LINE,!
GO ;
 K DIR S DIR("A")="Wish to continue ",DIR(0)="Y",DIR("B")="NO" D ^DIR G:$D(DIRUT) CLEAN I Y='1 W !!?10,"TO CONTINUE YOU MUST ENTER 'YES' - PROCESS ABORTED",! S LREND=1 G EXIT
ASK1 ;
 W !?10,"Device to print processing errors if any are detected.",!
 K %ZIS,DIR,ZTSK S %ZIS="Q" D ^%ZIS G:POP CLEAN
 I $D(IO("Q")) S ZTRTN="DQ^LRCAPAM4",ZTIO=ION,ZTDESC="Building LAB LMIP Mail Message",ZTDTH=$H D ^%ZTLOAD W !,$S($G(ZTSK):"Queued to "_ION,1:"Error Not Queued"),! G CLEAN
 W:$E(IOST)="P" !?5,"This will only take a moment - Please standby ",!
DQ U IO S:$D(DEQUEUED) ZTREQ="@"
 K ^TMP($J)
 W !!?5,"Processing data and building Mailman messages ",!
 W !?15,$TR($$FMTE^XLFDT($$NOW^XLFDT,"1M"),"@"," "),!
 S LRCPM=30000,LRLLN=+$G(^LAH("LABWL",0)) I LRLLN
 E  W !!,"No data in global !!",$C(7) G EXIT
 S LRHD1=$G(^LAH("LABWL",1,0)) D  D:$G(LREND) PRINT G:$G(LREND) EXIT
 .  I '$S('$P(LRHD1,"$",2):1,'$P(LRHD1,"$$",2):1,'$P(LRHD1,"$$$",2):1,1:0) S LREND=1 W !!?10,"^LAB(""LABWL"" is corrupt ",!!,$C(7)
 S LRHD1="",(LRCHC,LRDLN,LRSEQ)=0,LRMSN=1
 S (LREND,LRSLN)=0 F  S LRSLN=$O(^LAH("LABWL",LRSLN)) Q:'LRSLN!($G(LREND))  S LRTXT=^(LRSLN) D LOOP1
 I '$G(LREND),(LRDLN>2) D NEWMSG
EXIT ;
 S LRTXT=$S($G(LREND):"Process Error",1:"Phase 4 Finished") W !?20,LRTXT,!! W:$E(IOST)="P" @IOF W !!,"DONE",!!
 I IO'=IO(0) U IO(0) W !?20,LRTXT,! U IO
CLEAN Q:$G(LRDEBUG)  K ^TMP($J),DIR,%ZIS D ^%ZISC
 K LINE,LRCHC,LRCPM,LRDLN,LRDV1,LRDV2,LRDVDT,LREND,LRHD1,LRLLN,LRMSM,LRSLN,LRSUB
 K LRSEQ,LRCHK,LRX,ZTSK,LRDV1X,LRDV2X
 K LRTXT,LRX,LRXM,LRX4,LRMSN,XMZ,NODE,X,Y,XMTEXT,XMY,XMSUB,XMDUZ D ^%ZISC
 Q
LOOP1 ;
 I LRSLN=1 S LRDV1=$P($P(LRTXT,"$",2),U),LRDV2=$P($P(LRTXT,"$$",2),U),LRDVDT=$P(LRTXT,"$$$",2),LRHD1=LRTXT,^TMP($J,1,0)=LRHD1,LRDLN=1,LRSEQ=1 Q
 I $E(LRTXT)="$" D:LRDV1'=$P($P(LRTXT,"$",2),U)!(LRDV2'=$P($P(LRTXT,"$$",2),U))!(LRDVDT'=$P(LRTXT,"$$$",2)) NEWMSG S LRSEQ=1 Q
 S LREND=$S('LRDV1:1,'LRDV2:1,'LRDVDT:1,1:0) I LREND W !!?5,"Header Block Corrupted (^LAH(LABWL,"_LRSLN_")",! D PRINT Q
 S LRX=$E(LRTXT),LRCHK=$S(LRX="$":1,LRX="*":2,LRX="\":3,LRX="-":4,1:0)
 I 'LRCHK W !!?5,"Starting charater not correct at position "_LRSLN_" ABORTED",!! S LREND=1 D PRINT Q
 I LRSEQ=0,LRCHK='1 W !!?5," Sequence not correct ^LAB(LABWL,"_LRSLN_")",! S LREND=1 D PRINT Q
CHK D  D:$G(LREND) PRINT Q:$G(LREND)
 . I LRSEQ=0,LRCHK=1 S LRSEQ=1 Q
 . I LRSEQ=1,LRCHK=2 S LRSEQ=2 Q
 . I LRSEQ=2,LRCHK=3 S LRSEQ=3 Q
 . I LRSEQ=3,LRCHK=4 S LRSEQ=4 Q
 . I LRSEQ=3,LRCHK=2 S LRSEQ=2 Q
 . I LRSEQ=4,LRCHK=4 Q
 . I LRSEQ=4,"12"[LRCHK S LRSEQ=LRCHK Q
 . W !!,"Data is not in proper sequence [Error = ^LAB(LABWL,"_LRSLN_")"
 . S LREND=1
 I $E(LRTXT)="*",((LRCHC+$L(LRTXT))>LRCPM) S:$D(^TMP($J,1,0)) LRHD1=^(0) D NEWMSG S LRSEQ=2
 S LRDLN=LRDLN+1,^TMP($J,LRDLN,0)=LRTXT,LRCHC=LRCHC+$L(LRTXT)+1
 W:'(LRDLN#5) "."
 Q
NEWMSG ;
 I LRMSN D MAIL W:'$G(LREND) !,"LMIP Message #",LRMSN," filed !!",!
 K ^TMP($J)
 S LRMSN=LRMSN+1,(LRDLN,LRSEQ)=1,LRCHC=0
 I $E(LRTXT)="$" S LRHD1=LRTXT,LRDV1=$P($P(LRHD1,"$",2),U),LRDV2=$P($P(LRHD1,"$$",2),U),LRDVDT=$P(LRHD1,"$$$",2)
 S ^TMP($J,1,0)=LRHD1
 Q
MAIL ;
 S (LRSUB,XMSUB)="LMIP WKL Msg #"_LRMSN_" D/I "_$P($P(LRHD1,"$$",2),U)_"/"_$P($P(LRHD1,"$",2),U)_" "_$$FMTE^XLFDT($P(LRHD1,"$$$",2),"1D")
 S XMDUZ=DUZ,XMTEXT="^TMP("_$J_",",XMY(+$G(DUZ))=""
 D ^XMD I '$G(XMZ) W !!?4,"Error in the call to Mailman",! S LREND=1 Q
 W !,LRSUB,!,"Mailman message number ",XMZ
 S LRDV1X=$O(^DIC(4,"D",LRDV1,0)),LRDV2X=$O(^DIC(4,"D",LRDV2,0))
 I $S('LRDV2X:1,'LRDV1X:1,1:0) D ERR Q
 S NODE=$O(^LRO(67.9,LRDV1X,1,LRDV2X,1,"B",+LRDVDT,0)) D:'NODE ERR Q:'NODE  S LRXM=$G(^LRO(67.9,LRDV1X,1,LRDV2X,1,NODE,0)) D:'LRXM ERR I NODE,LRXM D
 . S LRX4=$P(LRXM,U,4) S:'$L(LRX4) $P(LRXM,U,4)=XMZ S:$L(LRX4) $P(LRXM,U,4)=$E(XMZ_":"_LRX4,1,50)
 . S ^LRO(67.9,LRDV1X,1,LRDV2X,1,NODE,0)=LRXM
 Q
ERR ;
 W !!?10,"UNABLE TO STORE MESSAGE NUMBER IN ^LRO(67.9 FILE",!! Q
PRINT ;
 N X,I
 W !!?5,"Error at subscript < "_LRSLN_" >",!,"Listing of surrounding data",!!
 S I=0 S:$G(LRSLN)>5 I=(LRSLN-5) F X=1:1:10 S I=$O(^LAH("LABWL",I)) Q:I<1  W !,"^LAH(LABWL,",I,") =",!,?6,^(I),!
  W ! Q
