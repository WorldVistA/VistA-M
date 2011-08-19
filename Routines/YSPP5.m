YSPP5 ;ALB/ASF-PATIENT INQUIRY--OUT PATIENT ; 2/15/89  09:31 ;
 ;;5.01;MENTAL HEALTH;**37,40**;Dec 30, 1994
 ;
 S YSFHDR="Outpatient Data <<section 6 >>" D ENHD^YSFORM
ENCE ; Called indirectly from YSCEN31
 ;
 G FA:'$O(^DPT(DA,"DE",0)) W !!,"Currently enrolled in " S I=0 F  S I=$O(^DPT(DA,"DE",I)) Q:'I  I $D(^(I,0)),$P(^(0),U,2)'="I" W $S($D(^SC(+^(0),0)):$P(^(0),U)_", ",1:"") W:$X>60 !?22
 ;
FA ;
 W !!,"Future Appointments: ",?25,"Date",?37,"Time",?50,"Clinic",!?25 F I=25:1:78 W "="
 S %DT="",X="T" D ^%DT S YSFA=+Y
 F YSFA=YSFA:0 S YSFA=$O(^DPT(DA,"S",YSFA)) Q:'YSFA  S L=^(YSFA,0),C=+L I $P(L,U,2)'["C" D COV,COV1
 K %DT Q:$D(YSNOFORM)  D WAIT1^YSUTL:'YST,ENFT^YSFORM:YST Q
 ;
COV ;
 S YSCOV=$S($P(L,U,7)=7:" (COLLATERAL) ",1:"") Q
COV1 ;
 S YSFDT=$$FMTE^XLFDT(YSFA,"5ZP")
 W !,?25,$E(YSFDT,1,10),?37,$S(+$E(YSFDT,12,13)>9:$E(YSFDT,12,19),+$E(YSFDT,12,13)'>9:0_$E(YSFDT,12,19),1:""),?50,$P($G(^SC(C,0)),U)," ",YSCOV Q
