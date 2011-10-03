IBOVOP2 ;ALB/CPM-Opt/Reg Events Report Print Utilities ; 30-AUG-93
 ;;2.0;INTEGRATED BILLING;**52,132,153,156,167,176,234,247,339**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PRINT ; Retrieve data for printing.
 N IBCOMBAT
 S IBFLD1="" I '$D(^TMP("IBOVOP",$J)) W !!,"No Outpatient activity recorded for MT/LTC copay patients on ",$$DAT1^IBOUTL(IBDATE),"."
 F  S IBFLD1=$O(^TMP("IBOVOP",$J,IBFLD1)) Q:(IBFLD1="")!(IBQUIT)  W ! D:IBLINE>55 HDR W !,IBFLD1 D  D CHRGS Q:IBQUIT
 .S IBFLD2="" F  S IBFLD2=$O(^TMP("IBOVOP",$J,IBFLD1,IBFLD2)) Q:(IBFLD2="")!(IBQUIT)  D
 ..S IBFLD3="" F  S IBFLD3=$O(^TMP("IBOVOP",$J,IBFLD1,IBFLD2,IBFLD3)) Q:(IBFLD3="")!(IBQUIT)  D
 ...S IBSEQ="" F  S IBSEQ=$O(^TMP("IBOVOP",$J,IBFLD1,IBFLD2,IBFLD3,IBSEQ)) Q:(IBSEQ="")!(IBQUIT)  S IBDATA=$G(^(IBSEQ)) D
 ....S IBFLD4=$P(IBDATA,"^",1),IBFLD5=$P(IBDATA,"^",2),IBFLD6=$P(IBDATA,"^",3),DFN=$P(IBDATA,"^",4)
 ....S IBCOMBAT=$$CVEDT^IBACV(DFN,IBDATE) I +IBCOMBAT I $P(IBCOMBAT,"^",2)>0 W !,"Veteran has CV status until "_$$DAT1^IBOUTL($P(IBCOMBAT,"^",2))
 ....W !?5,IBFLD2
 ....W ?20,IBFLD3,?26,IBFLD4,?44,IBFLD5,?63,IBFLD6 D CLSF(+$P(IBDATA,"^",5)) D:IBFLD2="OBS ADMIS" CLSF^IBECEAU5(+$P(IBDATA,U,6)) W ! S IBLINE=IBLINE+1
 ....Q:$O(^TMP("IBOVOP",$J,IBFLD1))=""
 ....I IBLINE>55 D HDR W !,IBFLD1 I $D(^TMP("IBOVOP",$J,IBFLD1,IBFLD2,IBFLD3,IBSEQ+1)) W !?5,IBFLD2
 ....I $Y>(IOSL-5) D PAUSE^IBOUTL Q:IBQUIT  D HDR W !,IBFLD1,!?5,IBFLD2
 D:'IBQUIT PAUSE^IBOUTL
 Q
 ;
CHRGS ; Find OP charges for day, if any. Build string for print.
 Q:'$G(DFN)
 N IBSTDATA
 I $D(^IB("AFDT",DFN,-IBDATE))=10 D
 .S IBPRNT="" F  S IBPRNT=$O(^IB("AFDT",DFN,-IBDATE,IBPRNT)) Q:IBPRNT=""!(IBQUIT)  D
 ..S IBIEN="" F  S IBIEN=$O(^IB("AD",IBPRNT,IBIEN)) Q:IBIEN=""!(IBQUIT)  D
 ...S IBDATA=$G(^IB(IBIEN,0)) Q:IBDATA=""
 ...I $Y>(IOSL-5) D PAUSE^IBOUTL Q:IBQUIT  D HDR W !,IBFLD1
 ...S IBSTAT=$P($G(^IBE(350.21,+$P(IBDATA,"^",5),0)),"^",2)
 ...S IBACT=$S($P($G(^IBE(350.1,+$P(IBDATA,"^",3),0)),"^",8)'="":$P(^(0),"^",8),1:$P(^(0),"^",1))
 ...S IBAMT=$P(IBDATA,"^",7)
 ...S IBAMT=$S(IBAMT?1N.N1"."1N:IBAMT_"0 ",IBAMT?1N.N:IBAMT_".00 ",1:IBAMT)
 ...S IBAMT=$S(IBACT["CANCEL":"*($"_IBAMT_")",1:"* $"_IBAMT)
 ...S IBSTDATA=$G(^IBE(352.5,+$P(IBDATA,"^",20),0))
 ...I IBSTDATA'="" W !?26,"Stop Code: ",$P(IBSTDATA,"^",4),?58,"#",$P(IBSTDATA,"^"),?63,$$TYPE^IBEMTSCR(+$P(IBSTDATA,"^",3))
 ...W !?5,IBAMT,?13,IBACT,?63,IBSTAT S IBLINE=IBLINE+1
 Q
 ;
HDR ; Print header.
 S IBPAGE=IBPAGE+1,IBLINE=5,IBTITLE="Means Test/LTC Outpatient and Registration Activity for "_$$DAT1^IBOUTL(IBDATE)
 I $E(IOST,1,2)["C-"!(IBPAGE>1) W @IOF,*13
 W ?(80-$L(IBTITLE))\2,IBTITLE
 S IBTITLE="Printed: "_$$DAT1^IBOUTL(DT)
 W !?(80-$L(IBTITLE))\2,IBTITLE,?70,"Page: "_IBPAGE
 W !!,"Patient/Event",?20,"Time",?26,"Clinic/Stop",?44,"Appt.Type",?63,"(Status)",!
 Q
 ;
CLSF(IBOE) ; Display classification results.
 ;  Input:    IBOE  --  Pointer to Outpatient Encounter in file #409.68
 I '$G(IBOE) G CLSFQ
 N I,IBCLS,IBCLSD,IBF S IBF=0,IBCLSD=$$ENCL^IBAMTS2(IBOE)
 I IBCLSD]"" F I=1,2,3,4,5,6,7,8 S IBCLS=$P(IBCLSD,"^",I) I IBCLS]"" W:'IBF !?6 W:IBF "  " W "Care related to ",$S(I=1:"AO",I=2:"IR",I=3:"SC",I=4:"SWA",I=5:"MST",I=6:"HNC",I=7:"CV",I=8:"SHAD",1:"??"),"? ",$S(IBCLS:"YES",1:"NO") S IBF=1
CLSFQ Q
