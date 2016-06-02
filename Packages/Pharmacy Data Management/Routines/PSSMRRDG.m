PSSMRRDG ;BIRMINGHAM/GN/DRP-Diagnostic Report only, does not update ;9/25/15 10:03am
 ;;1.0;PHARMACY DATA MANAGEMENT;**191**;9/30/97;Build 40
 Q
 ;
EN(P1) ;Check for MRR meds missing the 2.1 node which is new and would be
 ;there if an order was created and Finished after patch PSJ*3*315
 ; Input param: P1 = default is null and checks for 2.1 node
 ;                  = if pass in a value, then it will not check 2.1
 ;
 W ! K %ZIS,IOP,ZTSK S %ZIS("B")="",%ZIS="QM" D ^%ZIS I POP Q
 I $E($G(IOST),1,2)="C-" W $C(7),!?5,"It is recommended to Queue this report to a printer for Large sites, enter Q at Device prompt",!
 I '$D(IO("Q")) N TERM U IO S:$E(IOSL,1)'["9" TERM=$S($E($G(IOST),1,2)="C-":1,1:0) D MAIN,^%ZISC Q
 S ZTRTN="MAIN^PSSMRRDG",ZTDESC="Orders for MRRs With Removal Properties" D ^%ZTLOAD K IO("Q")
 Q
 ;
MAIN ; main control
 N DFN,MRR,MRRAR,ORD,STP,ORDTOT,DDOI,DDTXT,QQ,YY,STS,PSSID,PSSLOC,PSSQ,PSSPATCH,ORDSDT
 N CLNODE,LIN,MRRFL,OI,PAGNO,POP
 N $ESTACK,$ETRAP S $ETRAP="D ERRTRP^PSSMRRDG" ;
 S P1=$G(P1)   ;define P1 to null if not passed
 S PSSPATCH=$S($G(P2):1,1:'$$PATCH^XPDUTL("PSJ*5.0*315"))
 ;build array of OI's that are mrr and their flag value
 F QQ=0:0 S QQ=$O(^PSDRUG("ASP",QQ)) Q:QQ=""  D
 . F YY=0:0 S YY=$O(^PSDRUG("ASP",QQ,YY)) Q:'YY  D
 .. S OI=$P(^PSDRUG(YY,2),U)
 .. S MRRFL=$P($G(^PS(50.7,OI,4)),U,1)
 .. S:MRRFL MRRAR(OI)=MRRFL
 ..Q
 .Q
 ;
 ; Use Ord Stop Date XREF to look for current orders
 S ORDTOT=0,PSSQ=0,PAGNO=0,ORDSDT=DT
 F  S ORDSDT=$O(^PS(55,"AUD",ORDSDT)) Q:ORDSDT=""  D
 . S DFN=0
 . F  S DFN=$O(^PS(55,"AUD",ORDSDT,DFN)) Q:DFN=""  D
 .. S ORD=0
 .. F  S ORD=$O(^PS(55,"AUD",ORDSDT,DFN,ORD)) Q:ORD=""  D
 ... S STS=$P($G(^PS(55,DFN,5,ORD,0)),U,9)
 ... S CLNODE=$G(^PS(55,DFN,5,ORD,8),0)
 ... ;non Active type order, quit dont include
 ... I (STS="D")!(STS="E")!(STS="DE")!(STS="DR") Q
 ... S PSSID=$S('$D(^DPT(DFN,0)):"NONE",1:$E($P($G(^DPT(DFN,0)),U,1),1)_$E($P($G(^DPT(DFN,0)),U,9),6,9))
 ... D CHKORD        ;check and then set ^TMP for sort
 ...Q
 ..Q
 .Q
 D:$D(^TMP("PSSMRRDG")) PRINT
 D:ORDTOT=0 HDR
 I 'PSSQ W !!,"Total Orders found: ",ORDTOT,!
 W !!,"Press RETURN to continue....." R X:$G(DTIME) ;pause before returning to Detail screen
 K ^TMP("PSSMRRDG")
 Q
 ;
CHKORD ;check if Order qualifies and then print on report
 ; return mrrfl which is positive or true  (1,2,3)
 F QQ=0:0 S QQ=$O(^PS(55,DFN,5,ORD,1,QQ)) Q:'QQ  D
 . S DDOI=+$P($G(^PS(55,DFN,5,ORD,.2)),U)
 . S MRR=$G(MRRAR(DDOI))
 . Q:'MRR      ;don't report not a MRR med
 . ;   don't report if has a 2.1 node, unless P1 overrides
 . I $G(P1)="",$D(^PS(55,DFN,5,ORD,2.1)) Q
 . S PSSLOC=$S($$CLINIC(CLNODE):$P(^SC(+^PS(55,DFN,5,ORD,8),0),U,1),$G(^DPT(DFN,.1))]"":^DPT(DFN,.1),1:"UNKNOWN")
 . S DDTXT=$$GET1^DIQ(55.07,QQ_","_ORD_","_DFN,"DISPENSE DRUG")
 . S ^TMP("PSSMRRDG",PSSLOC,PSSID)=DDTXT_U_STS_U_MRR
 .Q
 Q
 ;
PRINT ;
 N STR S PSSLOC=""
  F  S PSSLOC=$O(^TMP("PSSMRRDG",PSSLOC)) Q:PSSLOC=""!PSSQ  D
 . D HDR S PSSID=""
 . F  S PSSID=$O(^TMP("PSSMRRDG",PSSLOC,PSSID)) Q:PSSID=""!PSSQ  D
 .. S STR=^TMP("PSSMRRDG",PSSLOC,PSSID),DDTXT=$P(STR,U),STS=$P(STR,U,2),MRR=$P(STR,U,3)
 .. D WRITELN S ORDTOT=ORDTOT+1
 .. I $Y>(IOSL-1) D PAUSE Q:PSSQ
 ..Q
 . D PAUSE Q:PSSQ
 .Q
 Q
 ;
HDR ;Write a heading on report
 S PAGNO=PAGNO+1
 W @IOF
 W !,$E($$FMTE^XLFDT($$NOW^XLFDT),1,18),?125,"Page ",PAGNO
 I 'PSSPATCH D H1,BODY Q
 D H2,BODY
 Q
 ;
H1 ; heading for Pre-PSJ315 install
 W !,?2,"The following ACTIVE Orders are for Medications Requiring Removal (MRR). Prior to Installation of PSJ*5*315 these orders"
 W !,?2,"should be reviewed for planning purposes, but no action taken. Once PSJ*5*315 is installed they will need to be d/c'd and"
 W !,?2,"re-entered after coordinating with your ADPAC."
 Q
H2 ; heading for Post-PSJ315 install
 W !,?2,"The following ACTIVE orders for medications that Require Removal (MRR) were finished prior to install of Patch PSJ*5*315."
 W !,?2,"These orders must be re-entered. They may not be copied, renewed or edited to create new orders."
 W !,?33,"Any changes to these orders should be coordinated with your ADPAC."
 Q
BODY ;
 W !!,?50," Sort by Patient within Ward  "_$G(PSSLOC,"NONE FOUND")
 W !!,"Patient",?10,"Patient",?30,"Orderable",?75,"Ordr",?80,"MRR"
 W !,"ID",?10,"Loc",?30,"Item Name",?75,"Sts",?80,"Val"
 S $P(LIN,"-",132)=""
 W !,LIN
 Q
 ;
WRITELN ;Write line on report
 W !,PSSID,?10,PSSLOC,?30,DDTXT,?76,STS,?81,MRR
 Q
 ;
PAUSE ;
 Q:'($G(TERM))
 N X
 W !!,"Press RETURN to continue, '^' to exit"
 R X:$G(DTIME) I (X="^")!('$T) S PSSQ=1 Q
 U IO
 Q
 ;
CLINIC(CL) ;Is this a Clinic order that would show on the VDL in CO mode also?
 Q:'($P(CL,"^",2)?7N!($P(CL,"^",2)?7N1".".N)) 0  ;no appt date, IM ord
 Q:'$D(^PS(53.46,"B",+CL)) 0                     ;no PTR to 44, IM ord
 N A S A=$O(^PS(53.46,"B",+CL,"")) Q:'A 0        ;no 53.46 ien, IM ord
 Q $P(^PS(53.46,A,0),"^",4)                      ;Send to BCMA? flag
 ;
TST(P2) ;
 S P2=$G(P2),P1=1
 D EN(P1)
 Q
 ;
ERRTRP ; Error trap processing
 N Z,PROBLEM
 S Z(1,1)=$$EC^%ZOSV ; mumps error location and description
 S Z="A SYSTEM ERROR HAS BEEN DETECTED AT THE FOLLOWING LOCATION"
 S PROBLEM=7
 D ^%ZTER ; record the error in the trap
 G UNWIND^%ZTER ; unwind stack levels
 Q
