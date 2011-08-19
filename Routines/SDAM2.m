SDAM2 ;ALB/MJK - Appt Mgt (cont); 8/18/05 12:10pm  ; Compiled April 16, 2007 09:43:32
 ;;5.3;Scheduling;**250,296,327,478,446**;Aug 13, 1993;Build 77
 ;
CI ; -- protocol SDAM APPT CHECK IN entry pt
 ; input:  VALMY := array entries
 ;
 N %,SDI,SDAT,VALMY,SDAMCIDT,SDCIACT
 D SEL^VALM2 S SDI=0,SDCIACT=""
 D NOW^%DTC S SDAMCIDT=$P(%,".")_"."_$E($P(%,".",2)_"0000",1,4)
 F  S SDI=$O(VALMY(SDI)) Q:'SDI  I $D(^TMP("SDAMIDX",$J,SDI)) K SDAT D
 .S SDAT=^TMP("SDAMIDX",$J,SDI)
 .W !,^TMP("SDAM",$J,+SDAT,0)
 .D:VALMCC SELECT^VALM10(+SDAT,1)
 .D ONE($P(SDAT,U,2),$P(SDAT,U,4),$P(SDAT,U,3),$P(SDAT,U,5),0,SDAMCIDT)
 .D:VALMCC SELECT^VALM10(+SDAT,0)
 S VALMBCK=$S(VALMCC:"",1:"R")
 Q
 ;
ONE(DFN,SDCL,SDT,SDDA,SDASK,SDAMCIDT) ; -- check in one appt
 ; input:  DFN := ifn of patient
 ;        SDCL := clinic# 
 ;         SDT := appt d/t
 ;        SDDA := ifn in ^SC multiple or null
 ;       SDASK := ask d/t of ci always [1|yes or 0|no]
 ;    SDAMCIDT := ci date/time [optional]
 ;
 I $D(XRTL) D T0^%ZOSV
 S:'SDDA SDDA=$$FIND(DFN,SDT,SDCL)
 I 'SDDA W !!,*7,"You cannot check in this appointment." D PAUSE^VALM1 G ONEQ
 N SDATA,SDCIHDL,X S SDATA=SDDA_U_DFN_U_SDT_U_SDCL,SDCIHDL=$$HANDLE^SDAMEVT(1)
 D BEFORE^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCIHDL)
 I '$D(^SD(409.63,"ACI",1,+SDATA("BEFORE","STATUS"))) W !!,*7,"You cannot check in this appointment." D PAUSE^VALM1 G ONEQ
 ; *** mt blocking removed
 ;S X="EASMTCHK" X ^%ZOSF("TEST") I $T,$G(EASACT)'="W",$$MT^EASMTCHK(DFN,"","C",SDT) D PAUSE^VALM1 G ONEQ
 I $P(SDT,".")>DT W !!,*7,"It is too soon to check in this appointment." D PAUSE^VALM1 G ONEQ
 S:'$D(^SC(SDCL,"S",0)) ^(0)="^44.001DA^^"
 S DR="",X=$G(^SC(SDCL,"S",SDT,1,SDDA,"C"))
 I +X S DR=309
 ; -- already co'ed
 I DR="",$P(X,U,3) D
 .S DR="309//"
 .I $P(^SC(SDCL,0),U,24)!(SDASK) S DR=DR_$$FTIME^VALM1($P(X,U,3)) Q
 .S DR=DR_"//^S X="_$P(X,U,3)
 ;
 I DR="",$P(^SC(SDCL,0),U,24)!(SDASK) S DR="309//"_$S(SDAMCIDT:$$FTIME^VALM1(SDAMCIDT),1:"NOW")
 I DR="" S DR="309///"_$S(SDAMCIDT:"/"_SDAMCIDT,1:"NOW")
 S DA(2)=SDCL,DA(1)=SDT,DA=SDDA,DIE="^SC("_DA(2)_",""S"","_DA(1)_",1," D ^DIE
 D AFTER^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCIHDL)
 I '$P(SDATA("AFTER","STATUS"),U,4),'$P(SDATA("BEFORE","STATUS"),U,4) W !?8,*7,"...appointment has not been checked in" D PAUSE^VALM1
 I SDATA("BEFORE","STATUS")'=SDATA("AFTER","STATUS") D
 .I $P(SDATA("AFTER","STATUS"),U,4),'$P(SDATA("BEFORE","STATUS"),U,4) W !?8,"...checked in ",$$FTIME^VALM1($P(SDATA("AFTER","STATUS"),U,4))
 .I $D(SDCIACT) D
 ..S Y=SDATA("AFTER","STATUS"),Y1=$P(Y,U,4),Y=$P(Y,U,3)
 ..I $P(SDATA("BEFORE","STATUS"),U,3)'=Y D UPD($$LOWER^VALM1(Y),"STAT",+SDAT,1),UPD("","TIME",+SDAT,1)
 ..I $P(SDATA("AFTER","STATUS"),U,3)["CHECKED IN" D UPD($S($P(Y1,".")=DT:$$TIME^SDAM1($P(Y1,".",2)),1:"     "),"TIME",+SDAT,1)
 .D EVT^SDAMEVT(.SDATA,4,0,SDCIHDL) ; 4 := ci evt , 0 := interactive mode
 I $D(XRT0) S XRTN="SDAM2" D T1^%ZOSV
ONEQ K DA,DIE,DR,DQ,DE,Y,Y1 Q
 ;
 ;
FIND(DFN,SDT,SDCL) ; -- return appt ifn for pat
 ;   input:        DFN := ifn of pat.
 ;                 SDT := appt d/t
 ;                SDCL := ifn of clinic
 ;  output: [returned] := ifn if pat has appt on date/time
 ;
 N Y
 S Y=0 F  S Y=$O(^SC(SDCL,"S",SDT,1,Y)) Q:'Y  I $D(^(Y,0)),DFN=+^(0),$D(^DPT(+DFN,"S",SDT,0)),$$VALID(DFN,SDCL,SDT,Y) S CNSTLNK=$P($G(^SC(SDCL,"S",SDT,1,Y,"CONS")),U) K:CNSTLNK="" CNSTLNK Q  ;SD/478
 Q Y
 ;
UPD(TEXT,FLD,LINE,SAVE) ; -- update data for screen
 D FLDTEXT^VALM10(LINE,FLD,TEXT)
 D:VALMCC CNTRL^VALM10(LINE,$P(VALMDDF(FLD),U,2),$P(VALMDDF(FLD),U,3),IOINHI,IOINORM,+$G(SAVE))
 Q
 ;
MAKE ; -- make appt action
 N ORACTION,ORVP,XQORQUIT,SDAMERR
 D FULL^VALM1
 W !!,VALMHDR(1)
 D ^SDM
 I '$D(SDAMERR) D BLD^SDAM
 I $D(SDAMERR) D PAUSE^VALM1
 D SDM^SDKILL S VALMBCK="R"
 Q
 ;
WI ; -- walk-in visit action
 S VALMBCK="R"
 D FULL^VALM1
 I SDAMTYP="P" I $$CL^SDAMWI(SDFN) D BLD^SDAM1
 I SDAMTYP="C" I $$PT^SDAMWI(SDCLN) D BLD^SDAM3
 ;evaluate wait list ;SD/327
EWLCHK ;check if patient has any open EWL entries (SD/372)
 ;CLN expected as clinic IEN
 I '$D(DFN) Q
 Q:'$D(SDT)
 K ^TMP($J,"SDAMA301"),^TMP($J,"APPT")
 N SD S SD=SDT
 I '$D(SC) S SC=+$G(CLN)
 ;
 K ^TMP($J,"SDAMA301"),^TMP($J,"APPT")
 W:$D(IOF) @IOF D APPT^SDWLEVAL(DFN,SD,SC)
 Q:'$D(^TMP($J,"APPT"))
 N SDEV D EN^SDWLEVAL(DFN,.SDEV) I SDEV,$L(SDEV(1))>0 D
 .K ^TMP("SDWLPL",$J),^TMP($J,"SDWLPL")
 .D INIT^SDWLPL(DFN,"M")
 .Q:'$D(^TMP($J,"SDWLPL"))
 .D LIST^SDWLPL("M",DFN)
 .F  Q:'$D(^TMP($J,"SDWLPL"))  N SDR D ANSW^SDWLEVAL(1,.SDR) I 'SDR D LIST^SDWLPL("M",DFN) D
 ..F  N SDR  D ANSW^SDWLEVAL(0,.SDR) Q:'$D(^TMP($J,"SDWLPL"))  I 'SDR W !,"MUST ENTER A REASON NOT TO DISPOSITION MATCHED EWL ENTRY",!
 I $D(^TMP($J,"APPT")) N SDEV D EN^SDWLEVAL(DFN,.SDEV) I SDEV,$L(SDEV(1))>0 D
 .Q:'$D(^TMP($J,"SDWLPL"))  D ASKREM^SDWLEVAL S SDCTN=1 ;display and process selected open EWL entries
 .Q
 Q
 ;
DATE ; -- change date range
 S VALMB=SDBEG D RANGE^VALM11
 I $S('VALMBEG:1,SDBEG'=VALMBEG:0,1:SDEND=VALMEND) W !!,"Date range was not changed." D PAUSE^VALM1 S VALMBCK="" G DATEQ
 S SDBEG=VALMBEG,SDEND=VALMEND
 I SDAMTYP="P" D BLD^SDAM1
 I SDAMTYP="C" D BLD^SDAM3
 S VALMBCK="R"
DATEQ K VALMB,VALMBEG,VALMEND Q
 ;
INP(DFN,VDATE) ; -- determine inpat status ; dom is not an inpat appt
 N SDINP,VAINDT,VADMVT
 S SDINP="",VAINDT=VDATE D ADM^VADPT2 G INPQ:'VADMVT
 I $P(^DG(43,1,0),U,21),$P($G(^DIC(42,+$P($G(^DGPM(VADMVT,0)),U,6),0)),U,3)="D" G INPQ
 S SDINP="I"
INPQ Q SDINP
 ;
VALID(DFN,SDCL,SDT,SDDA) ; -- return valid appt.
 ; **NOTE:  For speed consideration the ^SC and ^DPT nodes must be
 ;          check to see they exist prior to calling this entry point.
 ;   input:        DFN := ifn of pat.
 ;                 SDT := appt d/t
 ;                SDCL := ifn of clinic
 ;                SDDA := ifn of appt
 ;  output: [returned] := 1 for valid appt., 0 for not valid
 Q $S($P(^SC(SDCL,"S",SDT,1,SDDA,0),U,9)'="C":1,$P(^DPT(DFN,"S",SDT,0),U,2)["C":1,1:0)
