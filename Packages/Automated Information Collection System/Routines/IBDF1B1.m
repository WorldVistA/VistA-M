IBDF1B1 ;ALB/CJM - ENCOUNTER FORM PRINT (IBDF1B continued - print encounter forms for selected appts); 3/1/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3**;APR 24, 1997
 ;
 N IBDEVICE,IBQUIT
 ;
 K DA,D0,X,Y,I
 ;
 ;set the error trap so workspace in ^TMP is erased in case of abnormal termination of the print job
 S X="ERRORTRP^IBDF1B",@^%ZOSF("TRAP")
 ;
 S IBQUIT=0
 D DEVICE^IBDFUA(0,.IBDEVICE)
 D:$D(^TMP("IBDF",$J,"D")) ENDV^IBDF1B1B D:$D(^TMP("IBDF",$J,"C")) ENCL^IBDF1B1A
 K ^TMP("EARL",$J),^TMP("MULT",$J)
 D ENPT
 D KPRNTVAR^IBDFUA
 K ^TMP("IBDF",$J),^TMP("IB",$J),^TMP("EARL",$J),^TMP("MULT",$J),DA,D0,X,Y,I,IBI
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
ENPT ;print encounter forms for each appt
 ;input ^TMP(  - contains appointment data:
 ;if IBSRT=1 format is ^TMP("IBDF",$J,"P",division name,clinic name,clinic ien,patient name,dfn,appt)=""
 ;if IBSRT=2 format is^TMP("IBDF",$J,"P",division name,terminal digits,dfn,appt)=clinic ien
 ;if IBSRT=3 format is ^TMP("IBDF",$J,"P",division name,clinic name,clinic ien,terminal digits,dfn,appt)=""
 N DFN,CLNCNAME,IBCLINIC,PNAME,TDIGIT,IBAPPT,IBDIV
 ;IBCLINIC=ien of clinic
 ;IBSTRTDV is the division to start from in the case of a reprint
 ;IBREPRNT is the clinic or terminal digits (1st 4) to start from in case of a reprint
 ;
 S IBDIV="" F  S IBDIV=$O(^TMP("IBDF",$J,"P",IBDIV)) Q:IBQUIT!(IBDIV="")  D:(IBDIV=" ")!(IBSTRTDV']IBDIV)
 .I IBSRT=2,IBDIV]" " W !,"DIVISION: ",IBDIV,@IOF
 .D:IBSRT=1 SORT1
 .D:IBSRT=2 SORT2
 .D:IBSRT=3 SORT3
 D:'IBQUIT TRLR
 Q
 ;
SORT1 ;case of sort by div/clinic/patient
 S CLNCNAME=""
 ;check if report was restarted, start is after this clinic
 I IBREPRNT]"" I ((IBDIV=" ")!(IBDIV=IBSTRTDV)) S CLNCNAME=$E(IBREPRNT,1,$L(IBREPRNT)-1)
 F  S CLNCNAME=$O(^TMP("IBDF",$J,"P",IBDIV,CLNCNAME)) Q:CLNCNAME=""!IBQUIT  S IBCLINIC="" F  S IBCLINIC=$O(^TMP("IBDF",$J,"P",IBDIV,CLNCNAME,IBCLINIC)) Q:'IBCLINIC!IBQUIT  D
 .D HDRPG($P($G(^SC(IBCLINIC,0)),"^"),IBDIV)
 .S PNAME="" F  S PNAME=$O(^TMP("IBDF",$J,"P",IBDIV,CLNCNAME,IBCLINIC,PNAME)) Q:PNAME=""!IBQUIT  S DFN="" F  S DFN=$O(^TMP("IBDF",$J,"P",IBDIV,CLNCNAME,IBCLINIC,PNAME,DFN)) Q:'DFN!IBQUIT  D
 ..S IBAPPT="" F  S IBAPPT=$O(^TMP("IBDF",$J,"P",IBDIV,CLNCNAME,IBCLINIC,PNAME,DFN,IBAPPT)) Q:'(+IBAPPT)!IBQUIT  D APPT($G(IBDIV),$G(CLNCNAME),$G(IBCLINIC),$G(PNAME),$G(DFN),$G(IBAPPT))
 Q
SORT2 ;case of sort by div/terminal digit
 S TDIGIT=""
 ;check if report was restarted, start is after this terminal digit
 I IBREPRNT]"" I ((IBDIV=" ")!(IBDIV=IBSTRTDV)) S TDIGIT=IBREPRNT
 F  S TDIGIT=$O(^TMP("IBDF",$J,"P",IBDIV,TDIGIT)) Q:TDIGIT=""!IBQUIT  D
 .S DFN="" F  S DFN=$O(^TMP("IBDF",$J,"P",IBDIV,TDIGIT,DFN)) Q:'DFN!IBQUIT  D
 ..S IBAPPT="" F  S IBAPPT=$O(^TMP("IBDF",$J,"P",IBDIV,TDIGIT,DFN,IBAPPT)) Q:'+IBAPPT!IBQUIT  D
 ...S IBCLINIC=$G(^TMP("IBDF",$J,"P",IBDIV,TDIGIT,DFN,IBAPPT)) Q:'IBCLINIC!IBQUIT  D APPT($G(IBDIV),$G(CLNCNAME),$G(IBCLINIC),$G(PNAME),$G(DFN),$G(IBAPPT),$G(TDIGIT))
 Q
SORT3 ;case of sort by div/clinic/terminal digits
 S CLNCNAME=""
 ;check if report was restarted, start is after this CLINIC
 I IBREPRNT]"" I ((IBDIV=" ")!(IBDIV=IBSTRTDV)) S CLNCNAME=$E(IBREPRNT,1,$L(IBREPRNT)-1)
 F  S CLNCNAME=$O(^TMP("IBDF",$J,"P",IBDIV,CLNCNAME)) Q:CLNCNAME=""!IBQUIT  S IBCLINIC="" F  S IBCLINIC=$O(^TMP("IBDF",$J,"P",IBDIV,CLNCNAME,IBCLINIC)) Q:'IBCLINIC!IBQUIT  D
 .D HDRPG($P($G(^SC(IBCLINIC,0)),"^"),IBDIV)
 .S TDIGIT="" F  S TDIGIT=$O(^TMP("IBDF",$J,"P",IBDIV,CLNCNAME,IBCLINIC,TDIGIT)) Q:TDIGIT=""!IBQUIT  S DFN="" F  S DFN=$O(^TMP("IBDF",$J,"P",IBDIV,CLNCNAME,IBCLINIC,TDIGIT,DFN)) Q:'DFN!IBQUIT  D
 ..S IBAPPT="" F  S IBAPPT=$O(^TMP("IBDF",$J,"P",IBDIV,CLNCNAME,IBCLINIC,TDIGIT,DFN,IBAPPT)) Q:'(+IBAPPT)!IBQUIT  D APPT($G(IBDIV),$G(CLNCNAME),$G(IBCLINIC),$G(PNAME),$G(DFN),$G(IBAPPT),$G(TDIGIT))
 Q
 ;
APPT(IBDIV,CLNCNAME,IBCLINIC,PNAME,DFN,IBAPPT,TDIGIT) ;print everything for single appt
 ;input - DFN,IBAPPT,IBCLINIC
 I $$S^%ZTLOAD S (ZTSTOP,IBQUIT)=1 W !,"TASK STOPPED AT USER'S REQUEST" Q
 D PRNTFRMS^IBDF1B2
 D PRNTOTHR^IBDF1B5(IBCLINIC,IBAPPT,DFN)
 I $D(^DPT(DFN,"S",IBAPPT,0)) S $P(^DPT(DFN,"S",IBAPPT,0),"^",21)=1 S:IBADDONS $P(^DPT(DFN,"S",IBAPPT,0),"^",22)=1
 Q
 ;
HDRPG(CLINIC,IBDIV) ;print a header page for clinic
 N LN
 S LN="BEGINNING TO PRINT ENCOUNTER FORMS FOR "_CLINIC_$S(IBDIV'=" ":" IN "_IBDIV,1:"")_" on "_$E(IBDT,4,5)_"/"_$E(IBDT,6,7)_"/"_$E(IBDT,2,3)
 I $Y W @IOF
 W !!!!!,?((IOM-$L(LN))\2),LN
 W @IOF
 W !!
 Q
TRLR ;prints a trailer page
 N LN
 S LN="PRINTING OF ENCOUNTER FORMS IS COMPLETE"_" for "_$E(IBDT,4,5)_"/"_$E(IBDT,6,7)_"/"_$E(IBDT,2,3)
 W !!!!!,?((IOM-$L(LN))\2),LN
 W @IOF
 Q
EARLIEST(DFN,APPT) ;determines if APPT is the earliest appt on the list for DFN
 D GETLIST^IBDF1B1A(DFN,IBDT,DIVISION)
 I APPT=$O(^TMP("IBDF",$J,"APPT LIST",DFN,""))
 Q $T
