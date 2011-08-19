PSBOXA ;BIRMINGHAM/EFC-MEDICATION LOG ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**13**;Mar 2004
 ;
 ; Reference/IA
 ;
 ; File 4/10090
 ;
 ;
 ; Entry Point -   Report OPTION used by PSB MANAGER key holders to locate
 ;                "UNKNOWN" Action Status entries in the BCMA Medication Log File.
 ;
EN ;  UNKNOWN Action Status Report - creation!
 ;
 S PSBDTST=+$P(PSBRPT(.1),U,6)
 S PSBDTSP=+$P(PSBRPT(.1),U,8)
 D NOW^%DTC S Y=% D DD^%DT S PSBDTTM=Y
 S PSBLIST=""
 S (PSBPGNUM,PSBLNTOT,PSBTOT,PSBX1)=""
 F  S PSBX1=$O(^PSB(53.79,"AADT",PSBX1)) Q:PSBX1=""  D
 .S PSBX2=$$FMADD^XLFDT(PSBDTST,,,,-.1) F  S PSBX2=$O(^PSB(53.79,"AADT",PSBX1,PSBX2)) Q:(PSBX2>$$FMADD^XLFDT(PSBDTSP,,23.9999))!(+PSBX2=0)  D
 ..S PSBX3="" F  S PSBX3=$O(^PSB(53.79,"AADT",PSBX1,PSBX2,PSBX3)) Q:+PSBX3=0  D
 ...Q:('$D(^PSB(53.79,PSBX3,0)))!$D(PSBLIST(PSBX3))
 ...I $P(^PSB(53.79,PSBX3,0),U,9)="" I $$GET1^DIQ(4,$P(PSBRPT(0),U,4)_",",.01)=$$GET1^DIQ(4,$P(^PSB(53.79,PSBX3,0),U,3)_",",.01) D
 ....L +^PSB(53.79,PSBX3):1 I  L -^PSB(53.79,PSBX3) S PSBTOT=PSBTOT+1,PSBLIST(PSBX3)=""
 I +PSBTOT=0 K PSBLIST
 S Y=PSBDTST D DD^%DT S Y1=Y S Y=PSBDTSP D DD^%DT S Y2=Y
 D BLDRPT
 D WRTRPT
 Q
 ;
BLDRPT ;
 ;
 K PSBOUTP
 S (PSBPGNUM,PSBX1)=""
 I '$D(PSBLIST) D  Q
 .S PSBPGNUM=1
 .S PSBOUTP(0,14)="W !!,""<<<< NO """"UNKNOWN ACTION STATUS"""" ENTRIES FOUND FOR THIS DATE RANGE >>>>"",!!"
 S PSBPGNUM=1,PSBTOT1=0
 F  S PSBX1=$O(PSBLIST(PSBX1))  Q:+PSBX1=0  D
 .S PSBTOT1=PSBTOT1+1
 .D CLEAN^PSBVT,PSJ1^PSBVT($$GET1^DIQ(53.79,PSBX1_",",.01,"I"),$$GET1^DIQ(53.79,PSBX1_",",.11))
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W """_PSBTOT1_".)"",!,?5,""Action Status...: "_$S($$GET1^DIQ(53.79,PSBX1_",",.09)']"":"*UNKNOWN*",1:$$GET1^DIQ(53.79,PSBX1_",",.09))_""""
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !,?5,""Patient.........: ("_$$GET1^DIQ(2,PSBDFN_",",.09)_") "_$$GET1^DIQ(2,PSBDFN_",",.01)_""""
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !,?5,""Ward/Bed........: "_$$GET1^DIQ(2,PSBDFN_",",.1)_$S($$GET1^DIQ(2,PSBDFN_",",.101)']"":"",1:"/"_$$GET1^DIQ(2,PSBDFN_",",.101))_""""
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !,?5,""Order Number....: "_PSBONX_""""
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !,?5,""Orderable Item..: "_PSBOITX_""""
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !,?5,""Schedule........: "_PSBSCH_""""
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !,?5,""Scheduled Adm Tm: "_$S($$GET1^DIQ(53.79,PSBX1_",",.13)']"":"AS NEEDED",1:$$GET1^DIQ(53.79,PSBX1_",",.13))_""""
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !,?5,""Created Dt/Tm...: "_$$GET1^DIQ(53.79,PSBX1_",",.06)_""""
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !,?5,""Created By......: ("_$$GET1^DIQ(53.79,PSBX1_",",.07,"I")_") "_$$GET1^DIQ(53.79,PSBX1_",",.07)_""""
 .S PSBOUTP($$PGTOT(3),PSBLNTOT)="W !,$TR($J("""",IOM),"" "",""-""),!!"
 Q
 ;
WRTRPT ;  Actually "WRITE" the report to output device
 ;
 I $O(PSBOUTP(""),-1)<1 D  Q
 .D HDR
 .X PSBOUTP($O(PSBOUTP(""),-1),14)
 .D FTR
 S PSBPGNUM=1
 D HDR
 S PSBX1="" F  S PSBX1=$O(PSBOUTP(PSBX1)) Q:PSBX1=""  D
 .I PSBPGNUM'=PSBX1 D FTR S PSBPGNUM=PSBX1 D HDR
 .S PSBX2="" F  S PSBX2=$O(PSBOUTP(PSBX1,PSBX2)) Q:PSBX2=""  D
 ..X PSBOUTP(PSBX1,PSBX2)
 D FTR
 Q
 ;
HDR ;  Create Report Header
 ;
 ;
 ;   BAR CODE MEDICATION ADMINISTRATION (BCMA) UNKNOWN ACTION STATUS REPORT
 ;   Date/Time: NOW
 ;   Date Range:   Y1  to  Y2   (inculsive)
 ;   
 ;   
 ;   This is a report of entries, created within the given date range, in the
 ;   BCMA Medication Log File with UNKNOWN Action Status data.
 ;   These entries may be corrected via the BCMA GUI "Edit Med Log".   
 ;   
 ;----------------------------------------------------------------
 ;
 W:$Y>1 @IOF
 W:$X>1 !
 S PSBPG="Page: "_PSBPGNUM_" of "_$S($O(PSBOUTP(""),-1)=0:1,1:$O(PSBOUTP(""),-1))
 S PSBPGRM=IOM-($L(PSBPG)+5)
 I $P(PSBRPT(0),U,4)="" S $P(PSBRPT(0),U,4)=DUZ(2)
 S PSBDIVN="Division: "_$$GET1^DIQ(4,$P(PSBRPT(0),U,4)_",",.01)
 W !!,"BCMA UNKNOWN ACTION STATUS REPORT" W ?PSBPGRM,PSBPG
 W !,"Date/Time: "_PSBDTTM,!,"Report Date Range:  Start Date: "_Y1_"   Stop Date: "_Y2
 W !,PSBDIVN,?(IOM-($L("Total *UNKNOWN* entries found: "_+PSBTOT)+5)),"Total *UNKNOWN* entries found: "_+PSBTOT
 W !!,?5,"This is a report of entries, created within the given date range,"
 W !,?5,"in the BCMA Medication Log File with UNKNOWN Action Status data."
 W !,?5,"These entries can be corrected using the BCMA GUI ""Edit Med Log""."
 W !!,$TR($J("",IOM)," ","="),!!
 ;
 Q
 ;
FTR ;  Create Report Footer
 ;
 I (IOSL<100) F  Q:$Y>(IOSL-7)  W !
 W !,$TR($J("",IOM)," ","="),!
 W !,PSBDTTM,!,"BCMA UNKNOWN ACTION STATUS REPORT - footer -"
 W ?PSBPGRM,PSBPG,!
 Q
 ;
PGTOT(X) ;Keep track of lines and PAGE Number...
 ;
 S:'$D(X) PSBLNTOT=PSBLNTOT+1
 S:$D(X) PSBLNTOT=PSBLNTOT+X
 I PSBPGNUM=1,(PSBLNTOT=1) S PSBLNTOT=14 S PSBMORE=PSBLNTOT+12 Q PSBPGNUM
 I PSBLNTOT=PSBMORE D
 .S PSBMORE=PSBLNTOT+12
 .I PSBMORE>(IOSL-7) S PSBPGNUM=PSBPGNUM+1,PSBLNTOT=14 S PSBMORE=PSBLNTOT+12
 Q PSBPGNUM
