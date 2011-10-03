PRS8VW ;WCIOFO/JAH - DECOMPOSITION, VIEW RESULTS ;01/11/08
 ;;4.0;PAID;**2,6,27,45,112,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is used to view the results of the decomposition.
 ;The variables VAL and VALOLD must be passed.  VAL is the current
 ;decomposition string.  VALOLD, which may be null, is the results
 ;of a previous decomposition run (what's in the 5 node of file 458
 ;prior to running decomposition).
 ;
 ;Called by Routines:  PRS8, PRS8DR
 S (NEW,VAL)=$G(VAL),(OLD,VALOLD)=$G(VALOLD)
 N DASH1,DASH2
 S $P(DASH1,"-",79)="-",$P(DASH2,"=",79)="="
 I +$E(NEW,2,4) S NEW=$E(VAL,33,999) ; 33rd position because CP field
 I +$E(OLD,2,4) S OLD=$E(VALOLD,33,999) ;is added(either "C","F"or" ")
 D E
 W @IOF
 I "C"'[$E(IOST) D
 .S X="Decomposition of Time" W ?(80-$L(X)/2),X,!
 .D NOW^%DTC S Y=% X ^DD("DD")
 .S X=$G(^VA(200,+$G(DUZ),0)),TR="User:  "_$S($P(X,"^",1)'="":$P(X,"^",1),1:"Unknown")
 .S TR=TR_"                                                                               "
 .S X="Run Date: "_Y,TR=$E(TR,1,(79-$L(X)))_X
 S X=$P(C0,"^",1)_" [SSN: "_$P(C0,"^",9)_"]" W !,X
 S X="Pay Period: "_(^PRST(458,+PY,0)) W ?(79-$L(X)),$P(X,"^",1)
 D CTID
 W !,DASH2
 W !,"Loc.",?10,"Data Element",?44,"Code",?52,"Old Value",?67,"New Value"
 W !,"----",?10,"------------",?44,"----",?52,"---------",?67,"---------"
 K I,L,X,USED
 D ^PRS8VW1
 D STUB
 I "C"'[$E(IOST) D
 .W !,DASH1
 .W !,TR
 D ONE^PRS8CV,^%ZISC Q
 ;
CERT ; entry point to show supervisor result of decomp before certifying
 N DASH1,DASH2
 S $P(DASH1,"-",79)="-",$P(DASH2,"=",79)="="
 S (NEW,VAL)=$G(VAL)
 I +$E(NEW,2,4) S NEW=$E(VAL,33,999) ;because CP field is added to STUB
 D E2
 W @IOF
 I "C"'[$E(IOST) D
 .S X="Decomposition of Time" W ?(80-$L(X)/2),X,!
 .D NOW^%DTC S Y=% X ^DD("DD")
 .S X=$G(^VA(200,+$G(DUZ),0)),TR="User:  "_$S($P(X,"^",1)'="":$P(X,"^",1),1:"Unknown")
 .S TR=TR_"                                                                               "
 .S X="Run Date: "_Y,TR=$E(TR,1,(79-$L(X)))_X
 S H="PAY PERIOD SUMMARY" W !,$J(H,40+($L(H)/2)),!
 S X=$P(C0,"^",1)_" [SSN: "_$E($P(C0,"^",9))_"XXXX"_$E($P(C0,"^",9),6,9)_"]" W !,X
 S X="Pay Period: "_(^PRST(458,+PY,0)) W ?(79-$L(X)),$P(X,"^",1)
 D CTID
 W !,DASH2
 W !
 K I,L,X,USED
 D ^PRS8VW2
 I "C"'[$E(IOST) D
 .W !,DASH1
 .W !,TR
 K H,R,Z Q
E2 ; --- create E array
 S E(1)="ANSKWDNOAURTCECUUNNANBSPSASBSCDADBDCTFOAOBOCYAOKOMRARBRCHAHBHCPTPAONYDHDVCEAEBTATCFAFCADNTRSSRSDNDCFCHCPCR"
 S E(2)="ALSLWPNPABRLCTCOUSNRNSSQSESFSGDEDFDGTGOEOFOGYEOSOURERFRGHLHMHNPHPBCLYHHOVSECEDTBTDFBFDAFNHRNSSSHNUCGCICQCS"
 S E(3)="NLDWMLCAPCCYFE" Q
STUB ; --- show stub record
 S X1=$G(HDR),X2=$E(VAL,1,32)
 I X1="" S X1=$E(VALOLD,1,32)
 I X1="" S X1=X2
 I $L(X1)<$L(X2) S X1=X2
 W !!,"STUB RECORD >>>>> ",$S(X1'="":X1,1:"Not Available At this Time...") Q
 ;
E ; --- create E array
 S E(1)="ANSKWDNOAURTCECUUNNANBSPSASBSCDADBDCTFOAOBOCYAOKOMRARBRCHAHBHCPTPAONYDHDVCEAEBTATCFAFCADNTRSSRSDNDCFCHCPCR"
 S E(2)="ALSLWPNPABRLCTCOUSNRNSSQSESFSGDEDFDGTGOEOFOGYEOSOURERFRGHLHMHNPHPBCLYHHOVSECEDTBTDFBFDAFNHRNSSSHNUCGCICQCS"
 S E(3)="NLDWINTLLULNLDDTTOLAMLCAPCCYRRFFFECD" Q
CTID ; compressed tour indicator display
 ; in - PY (pay period ien), DFN (employee ien)
 N FLX,FLXP
 S FLX=$P($G(^PRST(458,+PY,"E",DFN,0)),U,6) ; for current pay period
 S FLXP=$P($G(^PRST(458,+PY-1,"E",DFN,0)),U,6) ; for previous pay period
 I FLX]"",FLX'="0" D
 . W !,"This is a ",$$EXTERNAL^DILFD(458.01,5,"",FLX)," tour!"
 I FLX]"",FLXP]"",FLX'=FLXP D
 . W !,"Note: The Compressed Tour Indicator has been changed since"
 . W !,"      the previous pay period (from "
 . W $$EXTERNAL^DILFD(458.01,5,"",FLXP)
 . W " to ",$$EXTERNAL^DILFD(458.01,5,"",FLX),")."
 Q
