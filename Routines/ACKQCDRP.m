ACKQCDRP ;AUG/JLTP BIR/PTD HCIOFO/AG -Print CDR Report ; [ 03/28/96   10:45 AM ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ; This routine prints the CDR report either for a Site, or for an 
 ;  individual Division, for a specific Month.
 ;
 K ACKDIV ; initialise Division array
 ;
 ; get CDR Generate flag (by site or division)
 S ACKCDRP=$$GET1^DIQ(509850.8,"1,",.1,"I") ; either 'S' or 'D'
 I ACKCDRP'="S",ACKCDRP'="D" G EXIT
 ;
OPTN ;Introduce option.
 I ACKCDRP="S" D
 . S ACKTXT(1)="This option prints the A&SP Service Cost Distribution report for your site,"
 . S ACKTXT(2)="for a given month."
 I ACKCDRP="D" D
 . S ACKTXT(1)="This option prints the A&SP Service Cost Distribution report for a Division"
 . S ACKTXT(2)="or multiple Divisions, for a given month."
 W @IOF,!,ACKTXT(1),!,ACKTXT(2),!
 ;
 ; prompt for Division(s)
 I ACKCDRP="D" S ACKDIV=$$DIV^ACKQUTL2(3,.ACKDIV,"AI") G:+ACKDIV=0 EXIT
 ;
 ; prompt for month
 D GETDT G:$D(DIRUT) EXIT
 S MON=$E(ACKM,1,5),ACKEM=MON_"99",ACKDA=+$$SITE^VASITE()_MON
 S ACKBFY=$$BFY^ACKQUTL(ACKM)
 ;
 ; determine whether the cdr has been generated
 S ACKEXIT=0
 I ACKCDRP="D" D CHKDIV G:ACKEXIT EXIT
 I ACKCDRP="S" D CHKSITE G:ACKEXIT EXIT
 ;
DEV ; select output device
 W !!,"The right margin for this report is 80."
 W !,"You can queue it to run at a later time.",!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS
 I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." G EXIT
 ; if requested, add report to queue
 I $D(IO("Q")) D  G EXIT
 . K IO("Q")
 . S ZTRTN="DQ^ACKQCDRP",ZTDESC="QUASAR - Print A&SP Cost Distribution Report"
 . S ZTSAVE("ACK*")="" D ^%ZTLOAD D HOME^%ZIS K ZTSK
 ;
DQ ;Entry point when queued.
 U IO
 D NOW^%DTC
 S ACKCDT=$$NUMDT^ACKQUTL(%)_" at "_$$FTIME^ACKQUTL(%),ACKPG=0
 K ^TMP("ACKQCDRP",$J)
 ;
 ; print the report
 I ACKCDRP="S" D COMPS,PRINT  ; print for the site
 I ACKCDRP="D" D         ; print for each division
 . S ACKDIV="" F  S ACKDIV=$O(ACKDIV(ACKDIV)) Q:ACKDIV=""  D COMPD,PRINT
 ;
EXIT ;  ALWAYS EXIT HERE
 K %I,ACKBFY,ACKCDT,ACKDA,ACKEM,ACKM,ACKPG,AS,CDR,CPT,DIR,DIRUT,DTOUT
 K DUOUT,I,ICD,LN,T,X,XAS,Y,ZIP,^TMP("ACKQCDRP",$J)
 K ACKTXT,ACKCDRP,ACKCDR,ACKCDRNM,ACKPCNT,ACKTOT,ACKTMP,ACKIEN,ACKTGT,ACKMSG
 K ACKMORE,ACKCDRX,ACKEXIT,ACKDIV
 W:$E(IOST)="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
COMPS ; compile data for the site
 ; walk down the CDR data for the site in the Workload file.
 K ACKTGT,ACKMSG
 S ACKFROM="" S ACKTOT=0,ACKMORE=0
 F  D  Q:'ACKMORE
 . S ACKMORE=0
 . D LIST^DIC(509850.74,","_ACKDA_",",".01;.02","I",1,.ACKFROM,"","","","","ACKTGT","ACKMSG")
 . I $P(ACKTGT("DILIST",0),U,1)=1 D   ; one found
 . . S ACKMORE=$P(ACKTGT("DILIST",0),U,3)   ; there are more
 . . S ACKCDR=ACKTGT("DILIST","ID",1,.01)   ; cdr number
 . . S ACKPCNT=ACKTGT("DILIST","ID",1,.02)  ; percentage
 . . S ACKIEN=$$FIND1^DIC(509850,"","O",ACKCDR,"B","","")
 . . S ACKCDRNM=$$GET1^DIQ(509850,ACKIEN_",",1,"E")  ; cdr description
 . . S ^TMP("ACKQCDRP",$J,1,+ACKCDR)=ACKCDR_U_ACKCDRNM_U_ACKPCNT
 Q
 ;
COMPD ; compile data for a division
 ; walk down the CDR data for the division in the Workload file.
 K ACKTGT,ACKMSG,^TMP("ACKQCDRP",$J,1)
 S ACKFROM="" S ACKTOT=0,ACKMORE=0
 F  D  Q:'ACKMORE  Q:$D(DIRUT)
 . S ACKMORE=0
 . D LIST^DIC(509850.754,","_ACKDIV_","_ACKDA_",",".01;54.02","I",1,.ACKFROM,"","","","","ACKTGT","ACKMSG")
 . I $P(ACKTGT("DILIST",0),U,1)=1 D   ; one found
 . . S ACKMORE=$P(ACKTGT("DILIST",0),U,3)     ; there are more
 . . S ACKCDR=ACKTGT("DILIST","ID",1,.01)     ; cdr number
 . . S ACKPCNT=ACKTGT("DILIST","ID",1,54.02)  ; percentage
 . . S ACKIEN=$$FIND1^DIC(509850,"","O",ACKCDR,"B","","")
 . . S ACKCDRNM=$$GET1^DIQ(509850,ACKIEN_",",1,"E")  ; cdr description
 . . S ^TMP("ACKQCDRP",$J,1,+ACKCDR)=ACKCDR_U_ACKCDRNM_U_ACKPCNT
 Q
 ;
PRINT ;  Print/display results for the Site/Division.
 I ACKPG>0,$E(IOST)="C" D PAUSE^ACKQUTL Q:$D(DIRUT)
 D DHD
 I '$D(^TMP("ACKQCDRP",$J,1)) D LINE W !!,"No data found for report specifications." D:$E(IOST)="C" PAUSE^ACKQUTL Q
 D HD4
CDR ;  CDR information for site/Division
 S ACKCDR="" F  S ACKCDR=$O(^TMP("ACKQCDRP",$J,1,ACKCDR)) Q:ACKCDR=""  D  Q:$D(DIRUT)
 . I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D DHD,HD4
 . S ACKTMP=^TMP("ACKQCDRP",$J,1,ACKCDR)
 . S ACKCDRX=$P(ACKTMP,U,1),ACKCDRNM=$P(ACKTMP,U,2),ACKPCNT=$P(ACKTMP,U,3)
 . W !?5,ACKCDRX,?15,ACKCDRNM,?65,$J(ACKPCNT,6,2)
 . S ACKTOT=ACKTOT+ACKPCNT
 ;
 ;  print total
 Q:$D(DIRUT)
 W !!?5,"Total:",?65,$J(ACKTOT,6,2)
 Q
 ;
DHD ;
 N X
 W:($E(IOST)="C")!(ACKPG>0) @IOF
 S ACKPG=ACKPG+1
 W "Printed: ",ACKCDT,?(IOM-8),"Page: ",ACKPG,!
 W ! D CNTR^ACKQUTL("Audiology & Speech Pathology")
 W ! D CNTR^ACKQUTL("Cost Distribution Report")
 I ACKCDRP="S" W ! D CNTR^ACKQUTL("for")
 I ACKCDRP="D" W ! D CNTR^ACKQUTL("for Division : "_$$GET1^DIQ(40.8,ACKDIV_",",.01,"E"))
 W ! D CNTR^ACKQUTL($$XDAT^ACKQUTL(ACKM))
 W !
 Q
HD4 ;  Header for CDR statistics.
 N X
 W !?5,"CDR ACCOUNT",?63,"% WORKLOAD"
 D LINE
 Q
LINE S X="",$P(X,"-",IOM)="-" W !,X
 Q
CHKDIV ;  Check the CDR has been generated for one Division for the month
 N ACKERR S ACKERR=0
 S ACKDIV="" F  S ACKDIV=$O(ACKDIV(ACKDIV)) Q:ACKDIV=""  D
 . I '$$DIVCDR(ACKDA,ACKDIV) D
 . . S ACKERR=ACKERR+1,ACKERR(ACKERR)=ACKDIV
 . . K ACKDIV(ACKDIV)
 ;
 ; none left to be printed
 I $O(ACKDIV(""))="" D  S ACKEXIT=1 D:$E(IOST)="C" PAUSE^ACKQUTL Q
 . W !!,"The CDR has not been generated for "_$$XDAT^ACKQUTL(ACKM)
 . W " for any of the selected",!,"Divisions",!!
 ;
 ; at least one error 
 I ACKERR D
 . W !!,"The CDR has not been generated for "_$$XDAT^ACKQUTL(ACKM)
 . W " for the following Division"_$S(ACKERR>1:"s",1:"")
 . F I=1:1:ACKERR W !?5,$$GET1^DIQ(40.8,ACKERR(I)_",",.01,"E")
 ;
 ; now list the Divisions that will be printed
 W !!,"The CDR for "_$$XDAT^ACKQUTL(ACKM)_" will now print for the following Division"
 W $S($O(ACKDIV(""))=$O(ACKDIV(""),-1):"",1:"s")
 S ACKDIV="" F  S ACKDIV=$O(ACKDIV(ACKDIV)) Q:ACKDIV=""  D
 . W !?5,$$GET1^DIQ(40.8,ACKDIV_",",.01,"E")
 ;
 ;  End
 Q
CHKSITE ;  Check the CDR has been generated for the selected month
 I '$$SITECDR(ACKDA) D
 . W !!,"The CDR has not been generated for "_$$XDAT^ACKQUTL(ACKM)_".",!
 . S ACKEXIT=1
 Q
GETDT ;  Select month for report.
 N DIR,X,Y
GDT1 K DIR
 S DIR(0)="D^::APE",DIR("A")="Select Month & Year"
 S DIR("B")=$$XDAT^ACKQUTL($$LM(DT)),DIR("?")="^D HELP^%DTC"
 S DIR("??")="^D DATHLP^ACKQCDRP"
 D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G GDT1
 Q:$D(DIRUT)
 S ACKM=$E(Y,1,5)_"00"
 I ACKM>DT W !,"Can't run Cost Distribution Report for future months!",! G GDT1
 Q
DATHLP ;  Extended help - select month for CDR report.
 W !?5,"Enter a date, in the past, for which you wish to"
 W !?5,"print the Cost Distribution Report."
 Q
LM(X) ;Find month previous to X.
 N M,D,Y S M=$E(X,4,5),D=$E(X,6,7),Y=$E(X,1,3),M=M-1
 S:M<1 M=12,Y=Y-1 S:M<10 M="0"_M
 Q Y_M_"00"
DIVCDR(ACKDA,ACKDIV) ; check if CDR generated for ACKDA (month) and ACKDIV
 N ACKTGT,ACKMSG,ACKFRM
 D LIST^DIC(509850.754,","_ACKDIV_","_ACKDA_",","","",1,.ACKFRM,"","","","","ACKTGT","ACKMSG")
 Q $P(ACKTGT("DILIST",0),U,1)=1
SITECDR(ACKDA) ; check is CDR generated for ACKDA (month) for the site
 N ACKTGT,ACKMSG,ACKFRM
 D LIST^DIC(509850.74,","_ACKDA_",","","",1,.ACKFRM,"","","","","ACKTGT","ACKMSG")
 Q $P(ACKTGT("DILIST",0),U,1)=1
