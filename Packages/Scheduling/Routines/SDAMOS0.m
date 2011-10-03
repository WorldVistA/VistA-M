SDAMOS0 ;ALB/SCK - AM MGT REPORTS STATISTICS BUILD GLOBAL ;5/25/93
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
STOPC ;  build global of action counts from division/stopcode in TMP
 N I,SDFIN
 S SDT=SDBEG F  S SDT=$O(^SCE("B",SDT)) Q:'SDT!(SDT>SDEND)  D
 . S SDOE=0 F  S SDOE=$O(^SCE("B",SDT,SDOE)) Q:'SDOE  D
 .. I '$D(^SCE(SDOE,0)) Q
 .. S SDOEO=$G(^SCE(SDOE,0))
 .. I '$$OKDIV(+$P($G(SDOEO),U,11))!('$$STCHK(+$P($G(SDOEO),U,3))) Q
 .. S SDDIV=$P($G(^DG(40.8,+$P($G(SDOEO),U,11),0)),U)
 .. S SDCODE=$P($G(^DIC(40.7,+$P(SDOEO,U,3),0)),U)
 .. I $P($G(SDOEO),U,12)>0 S ^TMP("SDAMS",$J,SDDIV,SDCODE,+$P(SDOEO,U,12))=$G(^TMP("SDAMS",$J,SDDIV,SDCODE,+$P(SDOEO,U,12)))+1
 K SDT,SDOE,SDOEO,SDDIV,SDCODE
 Q
 ;
OKDIV(SDDV) ; check for division in list of valid divisions (vautd)
 N Y S Y=0
 I VAUTD S Y=1 G OKDIVQ
 I $D(VAUTD(SDDV)) S Y=1
OKDIVQ Q (+Y)
 ;
STCHK(SDSTC) ;  check for stopcode in list of valid stopcodes (vautc)
 N Y S Y=0
 I VAUTC S Y=1 G STCHKQ
 I $D(VAUTC(SDSTC)) S Y=1
STCHKQ Q (+Y)
 ;
DISP() ; -- display selection choices
 N C,D
 D HOME^%ZIS W @IOF,*13
 W $$LINE^SDAMO("Report Specifications")
 W !!,"   Encounter Dates: ",$$FDATE^VALM1(SDBEG)," to ",$$FDATE^VALM1(SDEND)
 W !,"     Report Format: ",$S(FMT=1:"Appointment Clinics",1:"Stop Codes")
 W !!?15,"Divisions",?55,$S(FMT=1:"Clinics",1:"Stop Codes")
 W !?15,"---------",?55,"----------"
 S (D,C)=0
 I VAUTD!VAUTC S D=$S(VAUTD:"All",1:$O(VAUTD(0))),C=$S(VAUTC:"All",1:$O(VAUTC(0))) W !?15,$S(D:VAUTD(D),1:D),?55,$S(C:VAUTC(C),1:C)
 S D=+D,C=+C
 F I=1:1 S:D'="" D=$O(VAUTD(D)) S:C'="" C=$O(VAUTC(C)) Q:'D&('C)  W ! W:D ?15,VAUTD(D) W:C ?55,VAUTC(C) I I>9 S I=0 D PAUSE^VALM1 I 'Y G DISPQ
 W !,$$LINE^SDAMO("")
 S Y=1
DISPQ Q Y
