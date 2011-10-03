SCRPW50 ;RENO/KEITH - ACRP Data Validation Reports ; 15 Jul 98  4:31 PM
 ;;5.3;Scheduling;**144,466**;AUG 13, 1993;Build 2
RQUE(SDROU,SDES,SD132) ;Queue data validation reports
 ;Required input: SDROU=routine entry point to que
 ;Required input: SDES=report name
 ;Optional input: SD132='1' to flag for 132 column output
 N SD,SDDIV,ZTSAVE D TITL(SDES)
 G:'$$DIVA^SCRPW17(.SDDIV) EXIT S SDMD=$O(SDDIV("")),SDMD=$O(SDDIV(SDMD)) S:$P(SDDIV,U,2)="ALL DIVISIONS" SDMD=1
DATE N %DT S %DT="AEPX",%DT(0)="-NOW",%DT("A")="Produce report for Fiscal Year workload through (date): " W ! D ^%DT G:Y<1 EXIT
 I Y<2961001 W !!,$C(7),"This date cannot be prior to OCT 1, 1996!" K Y G DATE
 S SD("MOD")=$E(Y,1,5)_"00",SD("EDT")=Y_.99,SD("FYD")=$E(Y,1,3)_1001 S:SD("FYD")>SD("EDT") SD("FYD")=SD("FYD")-10000 X ^DD("DD") S SD("PEDT")=Y
 F X="SD(","SDDIV","SDDIV(","SDMD" S ZTSAVE(X)=""
 I $D(SDSTA) S ZTSAVE("SDSTA")="" ;encounter status
 I $G(SD132) W !!,"This report requires 132 column output."
 W ! D EN^XUTMDEVQ(SDROU,SDES,.ZTSAVE)
EXIT D END K SDMD,SD132,SDROU,SDES,SD,SDDIV,X,Y,%DT,SDX Q
 ;
XY(X,SDI,SDZ) ;Maintain $X, $Y
 ;Required input: X=screen handling variable
 ;Optional input: SDI=1 if indirection is needed
 ;Optional input: SDZ=0 if $X & $Y are to be zeroed
 N DX,DY S DX=$X,DY=$Y S:$G(SDZ)=0 (DX,DY)=0
 I $G(SDI),$L(X) W @X X ^%ZOSF("XY") Q ""
 W X X ^%ZOSF("XY") Q ""
 ;
TITL(SDES) ;Display report title
 ;Required input: SDES=report descriptive title
 N X,SDX
 D ENS^%ZISS S X=0 X ^%ZOSF("RM")
 I $E(IOST)'="C" W $$XY(IOF,1,0),?(IOM-$L(SDES)\2),SDES,! Q
 S:$L(SDES)#1 SDES=SDES_" " S IOTM=3,IOBM=IOSL,SDX="",$P(SDX," ",(80-$L(SDES)\2+1))="",SDX=SDX_SDES_SDX W $$XY(IOF,1,0),$$XY(IORVON),SDX,$$XY(IORVOFF),$$XY(IOSTBM,1),!
 Q
 ;
SUBT(SDX) ;Display subtitle
 ;Required input: SDX=subtitle text
 W !!?(80-$L(SDX)\2),$$XY(IORVON),SDX,$$XY(IORVOFF) Q
 ;
END ;Clean up
 N X S X=IOM X ^%ZOSF("RM") D DISP0^SCRPW23,KILL^%ZISS K ^TMP("SCRPW",$J) Q
 ;
PROV(SDOE,SDARY) ;Create array of provider types for an encounter
 ;Required input: SDOE=outpatient encounter ifn
 ;Required input: SDARY=array to return list (pass by reference)
 ;Output:         SDARY(providerifn)=VA code of person class
 K SDARY N SDAR1,SDPR,SDPRA,SDI D GETPRV^SDOE(SDOE,"SDPR")
 S SDI=0 F  S SDI=$O(SDPR(SDI)) Q:'SDI  S SDPR=$P(SDPR(SDI),U) I SDPR D
 .K SDAR1 D ROLE^VAFHLRO3(SDPR,"SDAR1","")
 .I $L($G(SDAR1(1))) S SDARY(SDPR)=SDAR1(1)
 .Q
 Q
