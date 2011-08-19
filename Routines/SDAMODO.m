SDAMODO ;ALB/SCK - PROVIDER DIAGNOSTICS REPORT; 4/21/93 ; 05 Oct 98  8:39 PM
 ;;5.3;Scheduling;**25,132,159**;Aug 13, 1993
START ;
 N SORT1,SORT2,SDBEG,SDEND,VAUTD,CLINIC,PATN,PROVDR,STOPC,PDIAG
 D HOME^%ZIS
SORTS ;
 I '$$RANGE G EXIT
 I '$$DIV G EXIT
 I '$$SORT1 G EXIT
 I '$$SORT2 G EXIT
PICKS ;
 I SORT1=1!(SORT2=1) G EXIT:'$$PROV
 I SORT1=2!(SORT2=2) G EXIT:'$$DIAG
 I SORT1=3!(SORT2=3) G EXIT:'$$PAT
 I SORT1=4!(SORT2=4) G EXIT:'$$CLINIC
 I SORT1=5!(SORT2=5) G EXIT:'$$STOP
FIN ;
 I '$$COMPL G SORTS
PRINT ;
 W !,"This report requires 132 columns for printout"
 S %ZIS="PMQ" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D QUE  G EXIT
 W ! D WAIT^DICD
 D ^SDAMODO2
EXIT ;
 D:'$D(ZTQUEUED) ^%ZISC
 K VAUTC,VAUTD,VAUTS,DIC,STR,CHECK,VAUTSTR,VAUTVB,X,Y,VAUTNI,SORT1,SORT2,SDEND,SDBEG
 Q
 ;
CLINIC() ;
 W !!,$$LINE("Clinic Selection")
 S DIC="^SC(",VAUTSTR="Clinic",VAUTVB="CLINIC",VAUTNI=2,DIC("S")="I $P(^(0),U,3)[""C"""
 D FIRST^VAUTOMA
 I Y<0 K CLINIC
 Q $D(CLINIC)>0
 ;
STOP() ;
 W !!,$$LINE("Stop Codes Selection")
 S DIC="^DIC(40.7,",VAUTSTR="Stop Code",VAUTVB="STOPC",VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 K STOPC
 Q $D(STOPC)>0
 ;
PAT() ;
 W !!,$$LINE("Select Patients")
 S DIC="^DPT(",VAUTSTR="Patient",VAUTVB="PATN",VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 K PATN
 Q $D(PATN)>0
 ;
PROV() ;   select provider
 W !!,$$LINE("Select Providers")
 S DIC="^VA(200,",VAUTSTR="Provider",VAUTVB="PROVDR",VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 K PROVDR
 Q $D(PROVDR)>0
 ;
DIAG() ;
 W !!,$$LINE("Select Diagnosis Code")
 S DIC="^ICD9(",VAUTSTR="Diagnosis",VAUTVB="PDIAG",VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 K PDIAG
 Q $D(PDIAG)>0
 ;
RANGE() ;   select date range for report
 W !!,$$LINE("Date Range Selection")
 Q $$RANGE^SDAMQ(.SDBEG,.SDEND)
 ;
SORT1() ;  first level sort
 W !!,$$LINE("First level sort will be by Division")
 W !,$$LINE("Select Second Sort Level")
 S SORT1=$$OPTIONS(0)
 Q (Y)
 ;
SORT2() ;  second level sort
 W !!,$$LINE("Sorting by Division and "_$P($T(SORT+SORT1^SDAMODO1),";;",2))
 W !,$$LINE("Select Third Sort Level")
 S SORT2=$$OPTIONS(SORT1)
 Q (Y)
 ;
DIV() ;
 W:$P($G(^DG(43,1,"GL")),U,2) !!,$$LINE("Division Selection")
 D ASK2^SDDIV I Y<0 K VAUTD
 Q $D(VAUTD)>0
 ;
COMPL() ;
 I '$$SHOW^SDAMODO1 S Y=0 G COMPLQ
 S DIR(0)="Y",DIR("A")="Continue",DIR("?")="Enter 'Y'es or 'N'o.",DIR("B")="YES" D ^DIR
COMPLQ Q (Y)
 ;
LINE(STR) ;  print display line
 N X
 S:STR]"" STR=" "_STR_" "
 S $P(X,"_",(IOM/2)-($L(STR)/2))=""
 Q X_STR_X
 ;
OPTIONS(CHECK) ;  display options for sorting reports
 S X="S^"
 S X=X_$S(CHECK=1:":[Selected];",1:"1:Provider;")
 S X=X_$S(CHECK=2:":[Selected];",1:"2:Diagnosis [DX];")
 S X=X_$S(CHECK=3:":[Selected];",1:"3:Patient;")
 S X=X_$S(CHECK=4:":[Selected];",1:"4:Clinic;")
 S X=X_$S(CHECK=5:":[Selected]",1:"5:Primary Stop Code")
 S DIR(0)=X,DIR("A")="Select Sort Option"
 D ^DIR K DIR
 Q (+Y)
 ;
QUE ;
 S ZTRTN="^SDAMODO2",ZTDESC="PROVIDER DX REPORT"
 F X="SORT1","SORT2","SDBEG","SDEND","VAUTD(","CLINIC(","PATN(","PROVDR(","STOPC(","PDIAG(","VAUTD","CLINIC","PATN","PROVDR","STOPC","PDIAG" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) !,"TASK #: ",ZTSK
 D HOME^%ZIS K IO("Q")
 Q
 ;
ERR ;
 W !!,"NOT AVAILABLE"
 Q
