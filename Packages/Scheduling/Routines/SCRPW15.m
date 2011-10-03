SCRPW15 ;RENO/KEITH - Encounter Activity Report (Cont.) ;06/19/99
 ;;5.3;Scheduling;**139,144,166,180,295**;AUG 13, 1993
 ;06/19/99 ACS - Added CPT modifiers to the report
 ;06/19/99 ACS - Added CPT modifier API calls
 ;
 N LINEFLAG
 S SDIV="" F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:SDIV=""!SDOUT  D DCAL
 S SDLINE="",$P(SDLINE,"-",81)="" D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),(SDPAGE,SDFFS)=1
 S SDIV="" F  S SDIV=$O(SDDIV(SDIV)) Q:'SDIV  S SDIV(SDDIV(SDIV))=SDIV
 I 'SDDIV,$P(SDDIV,U,2)'="ALL DIVISIONS" S SDIV($P(SDDIV,U,2))=$$PRIM^VASITE()
 I $P(SDDIV,U,2)="ALL DIVISIONS" S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,SDI)) Q:'SDI  S SDX=$P($G(^DG(40.8,SDI,0)),U) S:$L(SDX) SDIV(SDX)=SDI
 D:$E(IOST)="C" DISP0^SCRPW23 I '$O(^TMP("SCRPW",$J,0)) S SDIV=0 D DHDR^SCRPW40(2,.SDT) D HDR() Q:SDOUT  S SDX="No activity found within selected report parameters!" W !!?(80-$L(SDX)\2),SDX G EXIT
 S SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""!SDOUT  S SDIV=SDIV(SDIVN) D DPRT(.SDIV)
 S SDI=0,SDI=$O(^TMP("SCRPW",$J,SDI)),SDMD=$O(^TMP("SCRPW",$J,SDI))
 G:SDOUT EXIT I SDMD S SDIV=0 D DPRT(.SDIV)
 ;
 I $E(IOST)="C",'$G(SDOUT) N DIR S DIR(0)="E" D ^DIR
EXIT K SD,SDDIV G EXIT^SCRPW14
 ;
DCAL ;Calculate numbers for a division
 D STOP^SCRPW14 Q:SDOUT
 S SDS=0 F  S SDS=$O(^TMP("SCRPW",$J,SDIV,1,SDS)) Q:'SDS  D S1 S ^TMP("SCRPW",$J,SDIV,1,SDS,"VIS")=SDVS(SDIV),^TMP("SCRPW",$J,SDIV,1,SDS,"UNIQ")=SDUN(SDIV),^TMP("SCRPW",$J,SDIV,2,$$ORD(),SDS)=""
 S (SDRPVS(SDIV),SDRPUN(SDIV),DFN)=0 F  S DFN=$O(^TMP("SCRPW",$J,SDIV,"RPT","PT",DFN)) Q:'DFN  S SDRPUN(SDIV)=SDRPUN(SDIV)+1,SDDT=0 F  S SDDT=$O(^TMP("SCRPW",$J,SDIV,"RPT","PT",DFN,SDDT)) Q:'SDDT  S SDRPVS(SDIV)=SDRPVS(SDIV)+1
 Q
 ;
DPRT(SDIV) ;Print report for a division
 S:SD("FMT")="D" SDDET=1 D T3 S SDPAGE=1 I '$D(^TMP("SCRPW",$J,SDIV)) S SDX="No activity found for this division!" D HDR() Q:SDOUT  W !!?(80-$L(SDX)\2),SDX Q
 D HDR() Q:SDOUT
 S SDSV="" F  S SDSV=$O(^TMP("SCRPW",$J,SDIV,2,SDSV),$S(SD("ORD")="A":1,1:-1)) Q:SDSV=""!SDOUT  S SDS=0 F  S SDS=$O(^TMP("SCRPW",$J,SDIV,2,SDSV,SDS)) Q:'SDS!SDOUT  D PRT
 Q:SDOUT  I SD("FMT")="S" D RTOT Q
 Q:SDOUT  D:SD("FMT")="D" NONE Q
 ;
S1 S (SDVS(SDIV),SDUN(SDIV),SDPT)=0 F  S SDPT=$O(^TMP("SCRPW",$J,SDIV,1,SDS,"PT",SDPT)) Q:'SDPT  S SDUN(SDIV)=SDUN(SDIV)+1,SDDT=0 F  S SDDT=$O(^TMP("SCRPW",$J,SDIV,1,SDS,"PT",SDPT,SDDT)) Q:'SDDT  S SDVS(SDIV)=SDVS(SDIV)+1
 Q:SD("FMT")="S"
 S SDD=0 F  S SDD=$O(^TMP("SCRPW",$J,SDIV,1,SDS,"DX",SDD)) Q:'SDD  S SDTOT=$G(^TMP("SCRPW",$J,SDIV,1,SDS,"DX",SDD,"PRI"))+$G(^TMP("SCRPW",$J,SDIV,1,SDS,"DX",SDD,"SEC")),^TMP("SCRPW",$J,SDIV,1,SDS,"DXTOT",SDTOT,SDD)=""
 S SDP=0 F  S SDP=$O(^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",SDP)) Q:'SDP  S SDTOT=^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",SDP),^TMP("SCRPW",$J,SDIV,1,SDS,"PROCTOT",SDTOT,SDP)=""
 Q
 ;
ORD() ;Produce sort value
 Q:SD("ORD")="V" SDVS(SDIV)  Q:SD("ORD")="U" SDUN(SDIV)  Q:SD("ORD")="E" ^TMP("SCRPW",$J,SDIV,1,SDS,"ENC")  Q $$SNAME()
 ;
HDR(SDPG) ;Print page header
 D STOP^SCRPW14 Q:SDOUT
 I $E(IOST)="C",'SDFFS N DIR S DIR(0)="E" D ^DIR S SDOUT=Y'=1 Q:SDOUT
 S:$G(SDPG) SDPAGE=+SDPG W:'SDFFS $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0) W SDLINE,!?22,"<*>  ENCOUNTER ACTIVITY REPORT  <*>"
 N SDI S SDI=0 F  S SDI=$O(SDTIT(SDI)) Q:'SDI  W !?(80-$L(SDTIT(SDI))\2),SDTIT(SDI)
 I SDPAGE=1 W !,SDLINE D PVIEW(15,1)
 W !,SDLINE,!,"Date printed: ",SDPNOW,?(74-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE,! S SDPAGE=SDPAGE+1,SDFFS=0
 Q:'$D(^TMP("SCRPW",$J,SDIV))
 Q:$G(SDPG)["N"  I SD("FMT")="D",SDPAGE>2 W !,$S(SD("CAT")="C":"Clinic: ",SD("CAT")="P":"Provider: ",1:"Stop Code: "),$$SNAME(),"  (cont.)",! Q
 W !,$S(SD("CAT")="C":"Clinic",SD("CAT")="P":"Provider",1:"Stop Code"),?40,"Encounters",?59,"Visits",?73,"Uniques",!,"------------------------------------",?40,"----------",?55,"----------",?70,"----------"
 Q
 ;
RTOT ;Print report total
 D:$Y>(IOSL-5) HDR() Q:SDOUT  W !!,"====================================",?40,"==========",?55,"==========",?70,"==========",!!,"REPORT TOTAL:",?40,$J(SDRPEN(SDIV),10),?55,$J(SDRPVS(SDIV),10),?70,$J(SDRPUN(SDIV),10) Q
 ;
T3 K SDTIT D DHDR^SCRPW40(1,.SDTIT) Q
 ;
PVIEW(SDCOL,SDSKIP) ;Print report parameters
 ;Required input: SDCOL=column to position output
 ;Required input: SDSKIP=1 to skip division data on output
 D:'$G(SDSKIP) PDIV W !?SDCOL,"    Activity date range: " S Y=SD("BDT") X ^DD("DD") W Y," to " S Y=$P(SD("EDT"),".") X ^DD("DD") W Y
 W !?(SDCOL+8),"Report category: ",$S(SD("CAT")="C":"CLINIC",SD("CAT")="P":"PROVIDER",1:"STOP CODE")," perspective",!?(SDCOL+10),"Output format: ",$S(SD("FMT")="S":"SUMMARY",1:"DETAIL")
 I SD("FMT")="S" W !?(SDCOL+8),"Collation order: ",$S(SD("ORD")="A":"ALPHABETIC",SD("ORD")="E":"by ENCOUNTER TOTAL",SD("ORD")="V":"by VISIT TOTAL",1:"by UNIQUE TOTAL")
 W !?(SDCOL+7),"Encounter status: " S X=$O(SD("STAT",0)) W $P(^SD(409.63,X,0),U) F  S X=$O(SD("STAT",X)) Q:'X  W !?(SDCOL+25),$P(^SD(409.63,X,0),U)
 Q
 ;
PDIV I 'SDDIV W !?SDCOL,"Medical Center Division: ",$P(SDDIV,U,2) Q
 N SDI S SDI=0 F  S SDI=$O(SDDIV(SDI)) Q:'SDI  W !?SDCOL,"Medical Center Division: ",SDDIV(SDI)
 Q
 ;
SNAME() ;Produce item name
 Q:SD("CAT")="C" $P($G(^SC(SDS,0),"UNKNOWN"),U)  Q:SD("CAT")="P" $P($G(^VA(200,SDS,0),"UNKNOWN"),U)
 N X S X=$G(^DIC(40.7,SDS,0),"UNKNOWN^UNKNOWN"),X=$P(X,U,2)_" - "_$P(X,U) Q X
 ;
PRT ;Print data
 I SD("FMT")="D",'$G(SDDET) D HDR(1) Q:SDOUT
 D:$Y>(IOSL-4) HDR() Q:SDOUT  K SDDET W !,$$SNAME(),?40,$J(^TMP("SCRPW",$J,SDIV,1,SDS,"ENC"),10),?55,$J(^TMP("SCRPW",$J,SDIV,1,SDS,"VIS"),10),?70,$J(^TMP("SCRPW",$J,SDIV,1,SDS,"UNIQ"),10) I SD("FMT")="D" D DX Q:SDOUT  D PROC
 Q
 ;
DX ;Print diagnosis information
 D DXHD I '$D(^TMP("SCRPW",$J,SDIV,1,SDS,"DX")) W !!,"(No diagnosis information identified)" Q
 S (SDT,SDTOT,SDTOT1,SDTOT2)="" F  S SDT=$O(^TMP("SCRPW",$J,SDIV,1,SDS,"DXTOT",SDT),-1) Q:SDT=""!SDOUT  S SDD=0 F  S SDD=$O(^TMP("SCRPW",$J,SDIV,1,SDS,"DXTOT",SDT,SDD)) Q:'SDD!SDOUT  D DX1
 Q:SDOUT
 W !,"====================================",?40,"==========",?55,"==========",?70,"==========",!,"TOTAL:",?40,$J(SDTOT1,10),?55,$J(SDTOT2,10),?70,$J(SDTOT,10) Q
 ;
DX1 ; 
 ;D:$Y>(IOSL-6) HDR(),DXHD Q:SDOUT  S SDD0=^ICD9(SDD,0),SDT1=+$G(^TMP("SCRPW",$J,SDIV,1,SDS,"DX",SDD,"PRI")),SDT2=+$G(^TMP("SCRPW",$J,SDIV,1,SDS,"DX",SDD,"SEC")),SDTOT1=SDTOT1+SDT1,SDTOT2=SDTOT2+SDT2,SDTOT=SDTOT+SDT1+SDT2
 ;W !,$P(SDD0,U),?7,$P(SDD0,U,3),?40,$J(SDT1,10),?55,$J(SDT2,10),?70,$J((SDT1+SDT2),10) Q
 ;
 D:$Y>(IOSL-6) HDR(),DXHD Q:SDOUT  S SDD0=$$ICDDX^ICDCODE(SDD),SDT1=+$G(^TMP("SCRPW",$J,SDIV,1,SDS,"DX",SDD,"PRI")),SDT2=+$G(^TMP("SCRPW",$J,SDIV,1,SDS,"DX",SDD,"SEC")),SDTOT1=SDTOT1+SDT1,SDTOT2=SDTOT2+SDT2,SDTOT=SDTOT+SDT1+SDT2
 W !,$P(SDD0,U,2),?7,$P(SDD0,U,4),?40,$J(SDT1,10),?55,$J(SDT2,10),?70,$J((SDT1+SDT2),10) Q
 ;
DXHD ;Diagnosis sub-header
 Q:SDOUT  W !!,"Diagnosis",?43,"Primary",?56,"Secondary",?75,"Total",!,"------------------------------------",?40,"----------",?55,"----------",?70,"----------" Q
 ;
PROC ;Print procedure information
 D:$Y>(IOSL-8) HDR() Q:SDOUT  D PROCHD I '$D(^TMP("SCRPW",$J,SDIV,1,SDS,"PROC")) W !!?12,"(No procedure information identified)" Q
 S (SDT,SDTOT)="" F  S SDT=$O(^TMP("SCRPW",$J,SDIV,1,SDS,"PROCTOT",SDT),-1) Q:SDT=""!SDOUT  S SDP=0 F  S SDP=$O(^TMP("SCRPW",$J,SDIV,1,SDS,"PROCTOT",SDT,SDP)) Q:'SDP!SDOUT  D PROC1
 Q:SDOUT
 W !?12,"===================================",?55,"==========",!?12,"PROCEDURE TOTAL:",?55,$J(SDTOT,10) Q
 ;
PROC1 ;D:$Y>(IOSL-6) HDR(),PROCHD Q:SDOUT  S SDP0=^ICPT(SDP,0),SDTOT=SDTOT+SDT W !?12,$P(SDP0,U),?18,$P(SDP0,U,2),?55,$J(SDT,10) Q
 N CPTCODE,CPTTEXT,SDMOD,SDMODQTY
 D:$Y>(IOSL-6) HDR(),PROCHD Q:SDOUT
 S SDP0=$$CPT^ICPTCOD(SDP,,1)
 Q:SDP0'>0
 S CPTCODE=$P(SDP0,U,2)
 S CPTTEXT=$P(SDP0,U,3)
 S SDTOT=SDTOT+SDT
 ;print procedure, desc, quantity
 I LINEFLAG W !
 W !?12,CPTCODE,?18,CPTTEXT,?55,$J(SDT,10)
 S LINEFLAG=1
 ;build array to hold ranked modifiers
 K ^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",2)
 S SDMOD=""
 S SDPROC=SDP
 F  S SDMOD=$O(^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",SDPROC,SDMOD)) Q:SDMOD=""  D
 . S SDMODQTY=$G(^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",SDPROC,SDMOD))
 . S ^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",2,SDMODQTY,SDMOD)=""
 . Q
 ; loop through ranked modifiers
 S SDMODQTY=""
 F  S SDMODQTY=$O(^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",2,SDMODQTY),-1) Q:SDMODQTY=""  D
 . S SDMOD=""
 . F  S SDMOD=$O(^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",2,SDMODQTY,SDMOD),-1) Q:SDMOD=""  D
 .. D:$Y>(IOSL-6) HDR(),PROCHD Q:SDOUT
 .. N MODINFO,MODCODE,MODTEXT,SDMQTY2
 .. S MODINFO=$$MOD^ICPTMOD(SDMOD,"I",,1)
 .. I +MODINFO'>0 Q
 .. S MODCODE=$P(MODINFO,"^",2)
 .. ; format for printing
 .. S MODCODE=$S($L(MODCODE)=1:"  "_MODCODE,1:" "_MODCODE)
 .. S MODTEXT=$E($P(MODINFO,"^",3),1,32)
 .. ;print modifier, desc, and quantity
 .. S SDMQTY2="-"_SDMODQTY
 .. W !,?13,"-",MODCODE,?18,MODTEXT,?55,$J(SDMQTY2,10)
 .. Q
 . S LINEFLAG=1
 . Q
 K ^TMP("SCRPW",$J,SDIV,1,SDS,"PROC",2)
 Q
 ;
PROCHD S LINEFLAG=0 Q:SDOUT  W !!?12,"Procedures/Modifiers",?60,"Total",!?12,"--------------------------------------",?55,"----------" Q
 ;
NONE ;List items with no activity
 S SDS=0 F  S SDS=$O(SD("LIST",SDS)) Q:'SDS!SDOUT  I '$D(^TMP("SCRPW",$J,SDIV,1,SDS)) S SDN=1 D HDR("1N") Q
 I $G(SDN) S SDS=0 F  S SDS=$O(SD("LIST",SDS)) Q:'SDS!SDOUT  I '$D(^TMP("SCRPW",$J,SDIV,1,SDS)) D:$Y>(IOSL-4) HDR("N") Q:SDOUT  D NO1
 Q
 ;
NO1 W !!,"No activity found for ",$S(SD("CAT")="C":"clinic",SD("CAT")="P":"provider",1:"stop code"),": ",$$SNAME() Q
