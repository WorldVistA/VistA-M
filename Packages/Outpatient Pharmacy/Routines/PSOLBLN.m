PSOLBLN ;BIR/RTR - NEW PRINTS LABEL ;11/18/92
 ;;7.0;OUTPATIENT PHARMACY;**16,36,71,107,110,117,135,233,251,387**;DEC 1997;Build 13
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^VA(200 supported by DBIA 224
 ;External reference to ^SC( supported by DBIA 254
 K PSOSTLK,ZTKDRUG I $L($T(PSOSTALK^PSOTALK1)) D PSOSTALK^PSOTALK1 S PSOSTLK=1 ; PRINT SCRIPTALK LABEL IF APPLICABLE
 I $G(IOS),$G(PSOBARS) I $G(PSOBAR0)=""!($G(PSOBAR1)="") S PSOIOS=IOS D DEVBAR^PSOBMST
 I $G(DFN) D ADD^VADPT
 I '$G(COPIES) S COPIES=""
 S ADDR(33)=$G(VAPA(4))_", "_$P($G(VAPA(5)),"^",2)_"  "_$S($G(VAPA(11))]"":$P($G(VAPA(11)),"^",2),1:$G(VAPA(6))),ADDR(22)=""
 S:$G(VAPA(2))]"" ADDR(22)=$G(VAPA(2))_" "_$G(VAPA(3)),ADDR(22)=$E(ADDR(22),1,46) S:ADDR(22)="" ADDR(22)=ADDR(33),ADDR(33)=""
 S ADDR(4)=$S(ADDR(33)="":ADDR(22),1:ADDR(33)) I $G(VAPA(2))="",$G(VAPA(3))="" S ADDR(2)=ADDR(4),ADDR(3)="",ADDR(4)="" G ST
 I $G(VAPA(2))'="",$G(VAPA(3))="" S ADDR(2)=VAPA(2),ADDR(3)=ADDR(4),ADDR(4)="" G ST
 I $G(VAPA(2))="",$G(VAPA(3))'="" S ADDR(2)=VAPA(3),ADDR(3)=ADDR(4),ADDR(4)="" G ST
 S ADDR(2)=$G(VAPA(2)),ADDR(3)=$G(VAPA(3))
ST I $P($G(^PSRX(RX,3)),"^",3) S PSOPROV=+$P(^(0),"^",4) S PSOPROV=$S($G(RXP):+$P($G(RXP),"^",17),$G(RXF):+$P($G(^PSRX(RX,1,RXF,0)),"^",17),1:PSOPROV) S:'$G(PSOPROV) PSOPROV=+$P(^PSRX(RX,0),"^",4) D
 .I +$P($G(^VA(200,PSOPROV,"PS")),"^",7) S:'$P($G(PHYS),"/",2) PHYS=$G(PHYS)_"/"_+$P($G(^PSRX(RX,3)),"^",3)
 ;
 S:$G(PSOBLALL) PSOBLRX=RX
 S:$D(RXRP(RX)) REPRINT=1 S:$D(RXPR(RX)) RXP=RXPR(RX)
 I $G(PSOSUREP)!($G(PSOEXREP)) S REPRINT=1 S:'$G(RXRP(RX)) RXRP(RX)=1
 S RXY=^PSRX(RX,0),RXSTA=$P(^PSRX(RX,"STA"),"^")
 S RXN=$P(RXY,"^"),ISD=$P(RXY,"^",13),RXF=0,DFN=+$P(RXY,"^",2),SIG=$P($G(^PSRX(RX,"SIG")),"^"),ISD=$E(ISD,4,5)_"/"_$E(ISD,6,7)_"/"_($E(ISD,1,3)+1700),ZY=0,$P(LINE,"_",28)="_"
 S PSOLBLPS=+$P(RXY,"^",3),PSOLBLDR=+$P(RXY,"^",6)
 S NURSE=$S($P($G(^DPT(DFN,"NHC")),"^")="Y":1,$P($G(^PS(55,DFN,40)),"^"):1,1:0) S FDT=$P(^PSRX(RX,2),"^",2),PS=$S($D(^PS(59,PSOSITE,0)):^(0),1:""),PS1=$S($D(^(1)):^(1),1:""),PSOSITE7=$P(^("IB"),"^")
 S PS2=$P(PS,"^")_"^"_$P(PS,"^",6)
 S (EXPDT,EXDT)=$P(^PSRX(RX,2),"^",6),EXDT=$S('EXDT:"",1:$E(EXDT,4,5)_"/"_$E(EXDT,6,7)_"/"_($E(EXDT,1,3)+1700))
 S COPIES=$S($P($G(RXRP(RX)),"^",2):$P($G(RXRP(RX)),"^",2),$P(RXY,"^",18)]"":$P(RXY,"^",18),1:1)
 S STATE=$S($D(^DIC(5,+$P(PS,"^",8),0)):$P(^(0),"^",2),1:"UKN")
 S DRUG=$$ZZ^PSOSUTL(RX),DEA=$P($G(^PSDRUG(+$P(RXY,"^",6),0)),"^",3),WARN=$P($G(^(0)),"^",8)
  I $G(^PSRX(RX,"P",+$G(RXP),0))]"" S RXPI=RXP D
 .S RXP=^PSRX(RX,"P",RXP,0)
 .S RXY=$P(RXP,"^")_"^"_$P(RXY,"^",2,6)_"^"_$P(RXP,"^",4)_"^"_$P(RXP,"^",10)_"^"_$P(RXY,"^",9)_"^"_$P($G(^PSRX(RX,"SIG")),"^",2)_"^"_$P(RXP,"^",2)_"^"_$P(RXY,"^",12,14)_"^"_$P(^PSRX(RX,"STA"),"^")_"^"_$P(RXP,"^",7)_"^"_$P(RXY,"^",17,99)
 .S FDT=$P(RXP,"^")
 S MW=$P(RXY,"^",11) I $G(RXFL(RX))'=0 D:$G(RXFL(RX))  I '$G(RXFL(RX)) F I=0:0 S I=$O(^PSRX(RX,1,I)) Q:'I  S RXF=RXF+1 S:'$G(RXP) MW=$P(^PSRX(RX,1,I,0),"^",2) I +^PSRX(RX,1,I,0)'<FDT S FDT=+^(0)
 .I $G(RXFL(RX)),'$D(^PSRX(RX,1,RXFL(RX),0)) K RXFL(RX) Q
 .;PSO*7*266
 .S RXF=RXFL(RX) S:'$G(RXP) MW=$P($G(^PSRX(RX,1,RXF,0)),"^",2) F I=0:0 S I=$O(^PSRX(RX,1,I)) Q:'I  I +^PSRX(RX,1,I,0)'<FDT S FDT=+^(0)
 I MW="W" S PSMP=$G(^PSRX(RX,"MP")) I PSMP]"" D
 .N PSJ S PSJ=0 F PSI=1:1:$L(PSMP) S PSMP(PSI)="",PSJ=PSJ+1 F PSJ=PSJ:1 S PSMP(PSI)=PSMP(PSI)_$P(PSMP," ",PSJ)_" " Q:($L(PSMP(PSI))+$L($P(PSMP," ",PSJ+1))>30)
 .K PSMP(PSI)
 S X=$S($D(^PS(55,DFN,0)):^(0),1:""),PSCAP=$P(X,"^",2),PS55=$P($G(X),"^",3),PS55X=$P($G(X),"^",5)
 I (($G(PS55X)]"")&(PS55>1)&(PS55X<DT)) S PS55=0
 S:MW="M" MW=$S((PS55=1!(PS55=4)):"R",1:MW)
 S MW=$S(MW="M":"REGULAR",MW="R":"CERTIFIED",1:"WINDOW")
 I ($G(PSMP(1))']""&($G(PS55)=2)) S PSMP(1)=$G(SSNPN)
 S DATE=$E(FDT,1,7),REF=$P(RXY,"^",9)-RXF S:'$G(RXP) $P(^PSRX(RX,3),"^")=FDT S:REF<1 REF=0 D ^PSOLBL2 S II=RX D ^PSORFL,RFLDT^PSORFL
 S PATST=$G(^PS(53,+$P(RXY,"^",3),0)) S PRTFL=1 I REF=0 S:('$P(PATST,"^",5))!(DEA["W")!(DEA[1)!(DEA[2) PRTFL=0
 S VRPH=$P(^PSRX(RX,2),"^",10),PSCLN=+$P(RXY,"^",5),PSCLN=$S($D(^SC(PSCLN,0)):$P(^(0),"^",2),1:"UNKNOWN")
 S PATST=$P(PATST,"^",2),X1=DT,X2=$P(RXY,"^",8)-10 D C^%DTC:REF I $D(^PSRX(RX,2)),$P(^(2),"^",6),REF,X'<$P(^(2),"^",6) S REF=0,VRPH=$P(^(2),"^",10)
 ;
 S COPIES=COPIES-1,$P(ULN,"_",34)="",PSOTRAIL=1 I $G(SIDE) D REP^PSOLBL2 G REP
 S (Y,X1)=EXPDT X ^DD("DD") S EXPDT=Y,Y=$P(^PSRX(RX,0),"^",13) X ^DD("DD") S ISD=Y,X2=DT D ^%DTC S DIFF=X
 S Y=DATE X ^DD("DD") S DATE=Y D NOW^%DTC S Y=% X ^DD("DD") S NOW=Y
 S TECH="("_$S($P($G(^PSRX(+$G(RX),"OR1")),"^",5):$P($G(^PSRX(+$G(RX),"OR1")),"^",5),1:$P(RXY,"^",16))_"/"_$S($G(VRPH)&($P(PSOPAR,"^",32)):VRPH,1:" ")_")"
 S PSZIP=$P(PS,"^",5) S PSOHZIP=$S(PSZIP["-":PSZIP,1:$E(PSZIP,1,5)_$S($E(PSZIP,6,9)]"":"-"_$E(PSZIP,6,9),1:""))
L1 W ?3,"VAMC ",$P(PS,"^",7),", ",STATE,"  ",$G(PSOHZIP),?54,"VAMC ",$P(PS,"^",7),", ",STATE,"  ",$G(PSOHZIP),?102 W $S($D(REPRINT)&($G(PSOBLALL)):"(GROUP REPRINT)",$D(REPRINT):"(REPRINT)",1:"") W:$G(RXP) "(PARTIAL)"
 W !?3,$P(PS2,"^",2),"  ",$P(PS,"^",3),"-",$P(PS,"^",4),"   ",TECH,?54,$P(PS2,"^",2),"  ",$P(PS,"^",3),"-",$P(PS,"^",4),"   ",TECH,?102,$P(PS2,"^",2)," ",TECH," ",NOW
 W !,"Rx# ",RXN,"  ",DATE,"  Fill ",RXF+1," of ",1+$P(RXY,"^",9),?54,"Rx# ",RXN,"  ",DATE,"  Fill ",RXF+1," of ",1+$P(RXY,"^",9),?102,"Rx# ",RXN,"  ",DATE,"  Fill ",RXF+1," of ",1+$P(RXY,"^",9)
 W !,PNM,"  ",$G(SSNPN),?54,PNM,"  ",$G(SSNPN),?102,PNM,"  ",$G(SSNPN)
 F DR=1:1 Q:$G(SGY(DR))=""  D:DR=4!(DR=7)!(DR=10)!(DR=13)  W !,$G(SGY(DR)),?54,$G(SGY(DR)),?102,$S($G(OSGY(DR))]"":OSGY(DR),1:$G(SGY(DR)))
 .F GG=1:1:27 W !
 I DR>4 S KK=$S(DR=5!(DR=8)!(DR=11):2,(DR=6)!(DR=9)!(DR=12):1,1:0) I KK F HH=1:1:KK W !
 I DR=2 W !!
 I DR=3 W !
 W !,$G(PHYS),?54,$G(PHYS),?102,$G(PHYS)
 S PSMF=$S($G(NURSE):"Mfg______Exp______",1:""),PSDU=$P($G(^PSDRUG($P($G(^PSRX(RX,0)),"^",6),660)),"^",8),PSDU=$S(PSDU="":"      "_PSMF,1:PSDU_" "_PSMF)
 W !,"Qty: "_$G(QTY),"  ",$G(PSDU),?54,"Qty: "_$G(QTY),"  ",$G(PSDU),?102,"Qty: "_$G(QTY),"  ",$G(PSDU)
 S ZTKDRUG="XXXXXX   SCRIPTALK RX   XXXXXX"
 I '$G(PSOSTLK) K PSDU,PSMF W !,DRUG,?54,DRUG,?102,DRUG
 I $G(PSOSTLK) K PSDU,PSMF W !,$S($G(PSOSTALK):ZTKDRUG,1:DRUG),?54,DRUG,?102,DRUG
 I $P(RXY,"^",9)-RXF'>0 D ^PSOLBLN1 G L13
 G:DIFF<30 L11
 W !?54,$P(RXY,"^",9)-RXF," Refills remain prior to ",EXPDT,?102,"Mfg "_$G(MFG)_" Lot# "_$G(LOT) G L12
L11 W !?54,"Last fill prior to ",$G(EXPDT),?102,"Mfg "_$G(MFG)_" Lot# "_$G(LOT)
L12 W !,$P(PS,"^",2),?54,$S($L($G(COPAYVAR)):$G(COPAYVAR)_"     ",1:""),"Days Supply: ",$G(DAYS),?102,"Tech__________RPh_________",!,$P(PS,"^",7),", ",STATE,"  ",$G(PSOHZIP)
 ;send a CR for OPTIFIL (P-MT661BC)
 I $G(PSOBARS),$P(PSOPAR,"^",19)'=1 S X="S",X2=PSOINST_"-"_RX S X1=$X W ?54,@PSOBAR1,X2,@PSOBAR0,$C(13) S $X=0 W:IOST["P-MT661BC" !
 E  W !!!
 W !,"FORWARDING SERVICE REQUESTED" W:"C"[$E(MW) !,?21,"CERTIFIED MAIL" W !?54,$G(VAPA(1))
 W !,$S($G(PS55)=2:"***DO NOT MAIL***",1:"***CRITICAL MEDICAL SHIPMENT***"),?54,$G(ADDR(2)),?102,"Routing: "_$S("W"[$E(MW):MW,1:MW_" MAIL")
 W !?54,$G(ADDR(3)),?102,"Days supply: ",$G(DAYS)," Cap: ",$S(PSCAP:"**NON-SFTY**",1:"SAFETY")
 W !?54,$G(ADDR(4)),?102,"Isd: ",ISD," Exp: ",EXPDT
 W !,PNM,?54,"*Indicate address change on back of this form",?102,"Last Fill: ",$G(PSOLASTF)
 W !,$S($D(PSMP(1)):PSMP(1),1:$G(VAPA(1))),?54,"[ ] Permanent",?102,"Pat. Stat ",PATST," Clinic: ",PSCLN
 W !,$S($D(PSMP(2)):PSMP(2),$D(PSMP(1)):"",1:$G(ADDR(2))),?54,"[ ] Temporary until ",$S($P($G(VAPA(10)),"^",2)]"":$P($G(VAPA(10)),"^",2),1:"__/__/__"),?102,$S($G(WARN)'="":"DRUG WARNING "_$G(WARN),1:"")
 W !,$S($D(PSMP(3)):PSMP(3),$D(PSMP(1)):"",1:$G(ADDR(3))),!,$S($D(PSMP(4)):PSMP(4),$D(PSMP(1)):"",1:$G(ADDR(4))),?54,"Signature",ULN
 I $G(PSOBARS) S X="S",X2=PSOINST_"-"_RX S X1=$X W ?102,@PSOBAR1,X2,@PSOBAR0,$C(13) S $X=0
L13 I $G(WARN)'="",'$G(PSOBLALL) I '$G(PSDFNFLG),'$G(PSOLAPPL) D WARN^PSOLBL2
 W @IOF
REP I COPIES>0 S SIDE=1 G ST
 D NOW^%DTC S NOW=% K %,%H,%I I $G(RXF)="" S RXF=0 F I=0:0 S I=$O(^PSRX(RX,1,I)) Q:'I  S RXF=I
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(RX,"L",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(RX,"L",0)="^52.032DA^"_IR_"^"_IR
 S ^PSRX(RX,"L",IR,0)=NOW_"^"_$S($G(RXP):99-RXPI,1:RXF)_"^"_$S($G(PCOMX)]"":$G(PCOMX),$G(PCOMH(RX))]"":PCOMH(RX),1:"From RX number "_$P(^PSRX(RX,0),"^"))_$S($G(RXP):" (Partial)",1:"")_$S($D(REPRINT):" (Reprint)",1:"")_"^"_PDUZ
 N PSOBADR,PSOTEMP
 S PSOBADR=$$CHKRX^PSOBAI(RX)
 I $G(PSOBADR) S PSOTEMP=$P(PSOBADR,"^",2),PSOBADR=$P(PSOBADR,"^")
 I $G(PSOBADR),'$G(PSOTEMP) D
 .S IR=IR+1,^PSRX(RX,"L",0)="^52.032DA^"_IR_"^"_IR
 .S ^PSRX(RX,"L",IR,0)=NOW_"^"_$S($G(RXP):99-RXPI,1:RXF)_"^"_"ROUTING="_$G(MW)_" (BAD ADDRESS)"_"^"_PDUZ
 S ^PSRX(RX,"TYPE")=0 K RXF,IR,FDA,NOW,I,PCOMH(RX)
 I $G(WARN)'="" I $G(PSDFNFLG)!($G(PSOLAPPL)) D ALLWARN^PSOLBLN1
 I $G(WARN)="" I $G(PSDFNFLG)!($G(PSOLAPPL)) D ALL^PSOLBLS
 I $G(PSOBLALL) D:$G(WARN)="" ALL^PSOLBLS D:$G(WARN)'="" ALLWARN^PSOLBLN1
 I '$D(PSSPND),$P(PSOPAR,"^",18) I $G(PSDFNFLG)!($G(PSOLAPPL))!($G(PSOBLALL)) D CHCK2^PSOTRLBL
 D:$G(PSOBLALL) TRAIL^PSOLBL2
END ;
 I $D(RXFLX(RX)) S RXFL(RX)=$G(RXFLX(RX)) K RXFLX
 D KILL^PSOLBL2 Q
