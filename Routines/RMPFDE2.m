RMPFDE2 ;DDC/PJU - R3 DISPLAY ELIG REQUESTS ;7/8/04
 ;;3.0;REMOTE ORDER/ENTRY SYSTEM;**1**;11/1/02
 ;SETUP OPTION RMPFDE2 IN THE OPTION FILE TO ACCESS THIS ROUTINE.
LIST(RMLIST)       ;FUNCTION RETURNING LIST OF ELIG AWAITING APPROVAL IN RMLIST
 ;TAKE FROM ^RMPF(791814,"C",2,DA)
 ;RMPFVFLG = 1 to see CONT/Actions,, 0 to list w/o interaction
 ;ND=node,TT=line num, CT=counter,NM=DFN name,EL=sugg elig, RD=request date
 ;RQ=REQUESTER DUZ, RN=REQUESTER NAME, RMPFX is selected node for action
 N CT,DFN,EL,EXIT,I,IEN,NM,RD,RN,RMMSG,RMPFX,RQ,S0,S1,S2,SSN,TT,Y
REPT K RMLIST,RMPFS1 S RMPFVFLG=1,EXIT=0
 D GETLIST
 D SORT
 G:'$G(TT) END ;no entries left
 G END:EXIT=1 ;chose quit
 G REPT
END K RMLIST,RMPFS1,RMPFVFLG,VADM,VAERR Q
 ;
GETLIST ;
 S (CT,IEN,TT)=0,RMPFS1(0)=""
L1 S IEN=$O(^RMPF(791814,"C",2,IEN))
 Q:'IEN
 I '$D(^RMPF(791814,IEN)) D  G L1 ;BAD ENTRY IN XREF
 .K ^RMPF(791814,"C",2,IEN)
 S S0=$G(^RMPF(791814,IEN,0))
 S S1=$G(^RMPF(791814,IEN,1))
 S S2=$G(^RMPF(791814,IEN,2))
 S DFN=$P(S0,U,1)
 D DEM^VADPT
 G:$G(VAERR) L1 ;error
 S NM=VADM(1)
 S SSN=$P(VADM(2),U,1)
 S EL=$P(S1,U,1) ;suggested eligibility
 S RMMSG=$P(S1,U,2) ;msg #
 S RD=$P(S0,U,2) ;REQUEST date
 S RQ=$P(S0,U,3) ;requestor DUZ
 S CT=CT+1
 S RMPFS1(RD,CT)=NM_U_SSN_U_EL_U_DFN_U_RQ_U_RMMSG_U_IEN ;keep in chron order, use TT to sort
 K VADM G L1
SORT ;create a sorted list by entry date with a ctr subscript (may be mult on date)
 S (RD,CT)=0 F  D  Q:'RD
 .S RD=$O(RMPFS1(RD)) Q:'RD  S CT=0 D
 ..F  S CT=$O(RMPFS1(RD,CT)) Q:'CT  D
 ...S TT=TT+1 S RMLIST(TT)=RD_U_RMPFS1(RD,CT)
 ..;RMLIST(TT)=req dt^pat name^pat SSN^sug el^dfn^req DUZ^MSG#^IEN
 ;
PRT D HEAD1 ;now print list
 I 'TT W !!,"NO REQUESTS TO REPORT" Q
 S CT=0
 F  S CT=$O(RMLIST(CT)) Q:'CT  D  Q:$G(EXIT)=1
 .W !,CT,?4,$$FMTE^XLFDT($P(RMLIST(CT),U,1)),?24,$P(RMLIST(CT),U,2)
 .S SSN=$P(RMLIST(CT),U,3)
 .W ?43,$E(SSN,1,3),"-",$E(SSN,4,5),"-",$E(SSN,6,9),?56,$P(RMLIST(CT),U,4)
 .I $G(RMPFVFLG)=1,CT#15=0 D CONT Q:$G(EXIT)=1  ;repeat command line if list long
 ;
LISTOT Q:$G(EXIT)=1
 W !!,"Total Orders:  ",TT
 D:$G(RMPFVFLG)=1 CONT
 D KILL^XM
 Q
HEAD1 W @IOF,!?17,"ROES REQUESTS FOR ELIGIBILITY DETERMINATION"
 W:$G(RMPFVFLG)'=1 !,?68,$$FMTE^XLFDT(DT)
 W ! F I=1:1:80 W "-"
 W !?1,"#",?7,"Request Date",?26,"Patient Name"
 W ?47,"SSN",?58,"Proposed Eligibility"
 W !,"--",?4,"------------------",?24,"-----------------"
 W ?43,"-----------",?56,"------------------------"
 Q
CONT ;EOL actions
 Q:$G(RMPFVFLG)=0  ;printing
 F I=1:1 Q:$Y>19  W !
CONT1 W !!,"Type the NUMBER of the request, <P>rint "
 W:CT<15 "or " W:CT>14 ","
 W "<Q>uit('^') the option"
 I CT>14 W " or <RETURN> to continue: "
 E  W ": "
 D READ
 I $D(RMPFOUT) S EXIT=1 G CONTE
 I $D(RMPFQUT) D  G CONT1
 .W !!,"Enter the number to the left of the request to select it for processing"
 .W !?9,"a <P> to print the list, <Q> or '^' to quit the list, or"
 .W !?11,"<RETURN> to continue in list."
 I Y="" D HEAD1 G CONTE
 I "Pp"[$E(Y,1) D QUE G CONTE
 I "Qq"[$E(Y,1) S EXIT=1 G CONTE
 I $D(RMLIST(Y)) S RMPFX=RMLIST(Y) D
 .D DISPLINE^RMPFDE3 ;display inf
CONTE Q
QUE W ! S %ZIS="NPQ" D ^%ZIS G QUEE:POP
 I IO=IO(0),'$D(IO("S")) S RMPFVFLG=1 G QUEE
 I $D(IO("S")) S %ZIS="",IOP=ION D ^%ZIS D  G QUEE ;SLAVE PRINT
 .S RMPFVFLG=0
 .D PRT
 .D ^%ZISC
 .D HOME^%ZIS
 .S RMPFVFLG=1
 S RMPFVFLG=0 ;NON-SLAVE PRINT
 S ZTDTH=$H,ZTRTN="PRT^RMPFDE2",ZTSAVE("TT")=""
 S ZTSAVE("RM*")=""
 S ZTIO=ION D ^%ZTLOAD
 D HOME^%ZIS S RMPFVFLG=1
 W:$D(ZTSK) !!,"*** Request Queued ***" H 2
 ;
QUEE K POP,ZTRTN,ZTSAVE,ZTIO,ZTSK
 Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
PRINT D HEAD1,LIST,LISTOT Q
