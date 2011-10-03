IBOEMP2 ;ALB/ARH - EMPLOYER REPORT (PRINT) ; 6/19/93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ;Array:  patient:  DFN)=pt name ^ SSN ^ event date ^ appt type ^ prim elig
 ;        employed: DFN,x)=name ^ occupation ^ employment status ^ SSN
 ;        employer: "E",EMPLOYER NAME)=count of employees per employer name
 ;                  "E",EMPLOYER NAME,y)=employer address
 ;                  "E",EMPLOYER NAME,y,PATIENT NAME,DFN,x)=""
 ;
 ;        w/x = "P" if employed is patient, "S" for spouse otherwise
 ;          y = number of employers with same name but not the same address, ie. 1:1:...
 ;
 ;
 D HDR
 ;
P1 ;print report
 Q:'$D(^TMP("IBEMP",$J))  S IBW=IOM
 S IBADDN="" F  S IBADDN=$O(^TMP("IBEMP",$J,"E",IBADDN)) Q:IBADDN=""!(IBQ)  S IBCNT=^TMP("IBEMP",$J,"E",IBADDN),IBX="" D  Q:IBQ
 . F  S IBX=$O(^TMP("IBEMP",$J,"E",IBADDN,IBX)) Q:IBX=""!(IBQ)  D:(IBLN+9)>IOSL HDR Q:IBQ  D  W !!,IBDSH,! S IBLN=IBLN+2
 .. ;
 .. ;print employer name and address
 .. S IBADD=^TMP("IBEMP",$J,"E",IBADDN,IBX) W !,$E($P(IBADD,"^",1),1,29),?32,$P(IBADD,"^",8),?55 S IBLNG=55,IBLN=IBLN+2
 .. F IBI=2:1:7 S IBP=$P(IBADD,"^",IBI) I IBP'="" S IBP=IBP_$S(IBI<6:",",IBI=6:" ",1:"") D
 ... F  S IBE=$P(IBP," ",1)_" ",IBP=$P(IBP," ",2,999) D  W ?IBLNG,IBE S IBLNG=IBLNG+IBT Q:IBP=""
 .... S IBT=$L(IBE) I (IBT+IBLNG)>IOM S IBLNG=55,IBLN=IBLN+1 W !
 .. ;
 .. ;print patient data
 .. S IBPTNM="" F  S IBPTNM=$O(^TMP("IBEMP",$J,"E",IBADDN,IBX,IBPTNM)) Q:IBPTNM=""  D  Q:IBQ
 ... S IBDFN="" F  S IBDFN=$O(^TMP("IBEMP",$J,"E",IBADDN,IBX,IBPTNM,IBDFN)) Q:IBDFN=""  I $D(^TMP("IBEMP",$J,IBDFN)) D:(IBLN+3)>IOSL HDR Q:IBQ  D
 .... S IBPAT=^TMP("IBEMP",$J,IBDFN),IBLN=IBLN+2 S Y=$P(IBPAT,"^",3) X ^DD("DD")
 .... W !!,?3,"Patient: ",?12,$P(IBPAT,"^",1),?55,$P(IBPAT,"^",2),?70,$P(IBPAT,"^",5),?77,Y,?92,$E($P(IBPAT,"^",4),1,11),?107,"Home: ",$P($G(^DPT(IBDFN,.13)),"^",1)
 .... ;
 .... ;print employed's data
 .... S IBZ="" F  S IBZ=$O(^TMP("IBEMP",$J,"E",IBADDN,IBX,IBPTNM,IBDFN,IBZ)) Q:IBZ=""  D:(IBLN'<IOSL) HDR Q:IBQ  D
 ..... S IBEMPED=^TMP("IBEMP",$J,IBDFN,IBZ),IBLN=IBLN+1
 ..... W !,?3,"Employed: ",?13,$S(IBZ="P":"Patient: ",1:"Spouse:  "),?22,$P(IBEMPED,"^",1),?55,$P(IBEMPED,"^",4),?70,$E($P(IBEMPED,"^",2),1,19),?92,$E($P(IBEMPED,"^",3),1,11)
 ..... I IBZ="P" W ?107,"Work: ",$P($G(^DPT(IBDFN,.13)),"^",2) ; we only have patients work number
 I 'IBQ D PAUSE
 K IBT,IBE,IBP,IBI,IBY,IBX,IBZ,IBQ,IBW,IBCNT,IBADD,IBADDN,IBLNG,IBDFN,IBPAT,IBPTNM,IBEMPED,X,Y
 Q
 ;
HDR ;print the report header, allow user stops, for terminals only form feed on first page
 S IBQ=$$STOP Q:IBQ  D:IBPGN>0 PAUSE Q:IBQ  I IBPGN>0!($E(IOST,1,2)["C-") W @IOF
 S IBPGN=IBPGN+1,IBLN=5 W IBHDR,IBBEGE," - ",IBENDE I IOM<85 W !
 W ?(IOM-30),IBCDT,?(IOM-8),"PAGE ",IBPGN W:IBHDR'="" !,IBHDR1 W !,IBDSH,!
 Q
 ;
PAUSE ;pause at end of screen if being displayed on a terminal
 Q:$E(IOST,1,2)'["C-"
 S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DIRUT)) S IBQ=1
 Q
 ;
STOP() ;determine if user requested task to be stopped
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !!,"TASK STOPPED BY USER",!!
 Q +$G(ZTSTOP)
