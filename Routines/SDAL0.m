SDAL0 ;ALB/GRR,TMP,MJK - APPOINTMENT LIST (CONTINUED FROM SDAL) ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**28,37,106,149,171,177,193,305,373,266**;Aug 13, 1993
LOOP I 'VAUTC,$G(^SC(SC,"ST",SDD,1))["CANCELLED"  D  Q
 .S SDPAGE=1 D HED^SDAL
 .S SDPCT="Clinic cancelled for this date!"
 .W !!?(IOM-$L(SDPCT)\2),SDPCT
 I $$CHECK(),$$NCHECK(),$$ACTIVE() D
 .;I VAUTC,SDCOPY>1 S VAUTC(SD)=SC
 .S SDPAGE=1 D HED^SDAL Q:SDEND  S SDPCT=0
 .;S SDT=SDD F  S SDT=$O(^SC(SC,"S",SDT)) Q:'SDT!(SDT\1-SDD)!SDEND  D MORE
 .;loop through sorted appointment data for the clinic
 .N SDT,SDDFN,SDDATA,SDDATAC S SDT="" F  S SDT=$O(^TMP($J,"SDAMA301","S",SC,SDT)) Q:'SDT  D
 ..S SDDFN="" F  S SDDFN=$O(^TMP($J,"SDAMA301","S",SC,SDT,SDDFN)) Q:'SDDFN!SDEND  D
 ...;store appt data and comments for later reference
 ...S SDDATA=$G(^TMP($J,"SDAMA301","S",SC,SDT,SDDFN)),SDDATAC=$G(^(SDDFN,"C"))
 ...D MORE
 .W ! D CCLK Q:SDEND
 .I 'SDPCT S SDPCT="No activity found for this clinic date!" W !!?(IOM-$L(SDPCT)\2),SDPCT
 S SDPAGE=1 Q
 ;
PTL N SDAPPT
 ;S DFN=+^SC(SC,"S",SDT,1,K,0),SDOI=$P(^(0),"^",4)
 S DFN=+$P(SDDATA,"^",4),SDOI=$G(SDDATAC)
 ;S (SDAPPT,X)=$G(^DPT(DFN,"S",SDT,0))
 ;Q:$S('X:1,$P(X,"^",2)="NT":0,$P(X,"^",2)["C"!($P(X,"^",2)["N"):1,1:0)
 S SDAPPT=""
 D ^VAUQWK,GETA
 I ($Y+7>IOSL) D HED^SDAL Q:SDEND
 I '$D(SDFS) S SDFS=1,X=PT D TM^SDROUT0 W !,$J(X,8)
 N SDCLY D CL^SDCO21(DFN,SDT,"",.SDCLY)
 N SDY S SDY=$Y
 W ! D:SDBC BARC^SDAL(85,$P(VAQK(2),"^"))
 ;check for Combat Vet
 N SDCV
 S SDCV=$$CVEDT^DGCV(DFN,$G(SDD))
 S SDCV=$P(SDCV,U,3)
 ;W !?3,$S($G(SDCV)=1:"(CV)",1:""),?9,$S($D(^SC(SC,"S",SDT,1,K,"OB")):"*",1:""),?10,$S(VAQK(1)]"":VAQK(1),1:"UNKNOWN PATIENT"),?41,$S(VAQK(2)]"":$E(VAQK(2),1,9),1:"")
 W !?3,$S($G(SDCV)=1:"(CV)",1:""),?9,$S($P(SDDATA,"^",7)="Y":"*",1:""),?10,$S(VAQK(1)]"":VAQK(1),1:"UNKNOWN PATIENT"),?41,$S(VAQK(2)]"":$E(VAQK(2),1,9),1:"")
 S INC=0 F SDZ=3,4,5 S X=SDZ(SDZ) D:X]"" TM^SDROUT0 S INC=SDZ#3*8+3 W ?48+INC,$J(X,8) W:INC<16 "  "
 I VAQK(12)]"" W !,?41,VAQK(12) W:VAQK(13)]"" !,?41,VAQK(13)
 W:SDOI]"" !,?15,SDOI W:SDEM]"" !,?15,SDEM,$S($D(SDCP):$P(^SC(SDCP,0),"^"),1:$P(^SC(SC,0),"^")),!,?15,SDEM1
 W !,?10,"Phone #: ",$P($G(^DPT(DFN,.13)),"^",1) ;Phone Number [Residence]
 S SDX="" F I=7:1:9 I VAQK(I) S SDX=1 Q
 ;Primary Care information
 I +$G(SDPCMM) D TDATA^SDPPTEM(DFN,"",SDD,"P",15)
 ;I SDPCMM D TDATA^SDPPTEM(DFN,"",SDD,"P",15)
 ;I SDX W !,?15,"** Requires Special Survey Disposition **"
 ;; GAF SCORE CHECK
 N SDGAF,SDGAFST
 ;I $$MHCLIN^SDUTL2(SC),'($$COLLAT^SDUTL2(+VAQK(6))!$P(SDAPPT,U,11)) D
 ;use Appt Type here since COLLATERAL VISIT field not supported by encapsulation API
 I $$MHCLIN^SDUTL2(SC),'($$COLLAT^SDUTL2(+VAQK(6))!$P($P(SDDATA,"^",10),";",2)["COLLATERAL OF VET") D
 . S SDGAF=$$NEWGAF^SDUTL2(DFN),SDGAFST=$P(SDGAF,"^")
 . W:SDGAFST !,?15,"** New GAF Score Required **"
 ;;
 I $O(SDCLY(0))  D
 .N PCL
 .S PCL=0
 .W !,?15,"** Required for facility workload credit => "
 .F  S PCL=$O(SDCLY(PCL)) Q:'PCL  D
 ..  W " ",SDCLAR(PCL)," "
 ..  I (SDCLAR(PCL)="SC")&($G(^DPT(DFN,0))]"") D
 ...  K SDELAR
 ...  S VAROOT="SDELAR"
 ...  D ELIG^VADPT
 ...  Q:'$P($G(SDELAR(3)),"^")
 ...  W $P(SDELAR(3),"^",2),"% "
 ...  K SDELAR,VAROOT
 .W "**"
 I $P(VAQK(11),"^",2)]"" W !,?15,"Means Test: ** ",$P(VAQK(11),"^",2)," **" W "   Last Test: ",$$FDATE^SDUL1($P($$LST^DGMTU(DFN),U,2))
 S SDCOPS=$$LST^DGMTU(DFN,DT,2) I +SDCOPS W !,?15,"Co-Pay Status: ","**"_$P(SDCOPS,U,3)_"**"," Last Test: ",$$FDATE^SDUL1($P(SDCOPS,U,2)) K SDCOPS
 I $D(^DIC(8,+VAQK(6),0)),$P(^(0),U,9)=13 W !,?15,"** COLLATERAL **" G Q
 ;I $P($G(^SC(SC,"S",SDT,1,K,0)),"^",10)]"" D  I V W !,?15,"** COLLATERAL **" G Q
 I +$P(SDDATA,"^",8)]"" D  I V W !,?15,"** COLLATERAL **" G Q
 .;S V=$P(^(0),"^",10),V=$S($D(^DIC(8,+V,0)):$P(^(0),"^",9)=13,1:0)
 .S V=+$P(SDDATA,"^",8),V=$S($D(^DIC(8,+V,0)):$P(^(0),"^",9)=13,1:0)
 ;I $P(SDAPPT,U,11) W !,?15,"** COLLATERAL VISIT **"
 ;use Appt Type here since COLLATERAL VISIT field not supported by encapsulation API
 I $P($P(SDDATA,"^",10),";",2)["COLLATERAL OF VET" W !,?15,"** COLLATERAL VISIT **"
 ;S:($P($G(^SC(SC,"S",SDT,1,K,0)),"^",10)=0) V=0
 I +$P($G(SDDATA),"^",8)=0 S V=0
Q I SDBC,(SDY+5)>$Y F I=1:1 Q:(SDY+5)'>$Y  W !
 I SDBC W !?9,$E(SDASH,9,255)
 S SDPCT=SDPCT+1 K V,SDX,SDMT,VAQK Q
 ;
GETA ;K SDCP S (SDZ(3),SDZ(4),SDZ(5))="" I $D(^DPT(DFN,"S",SDT,0)) F SDZ=3,4,5 S SDZ(SDZ)=$P(^(0),"^",SDZ)
 K SDCP S SDZ(3)=$P($G(SDDATA),"^",21),SDZ(4)=$P($G(SDDATA),"^",20),SDZ(5)=$P($G(SDDATA),"^",19)
 S SDEM="",SDEC=+VAQK(6) Q:'SDEC
 S SDXX=$S('$D(^DIC(8,SDEC,0)):1,$P(^(0),"^",5)'="Y":1,$P(^(0),"^",4)=4:0,$P(^(0),"^",4)=5:0,1:1) Q:SDXX
 I $D(^SC(SC,"SL")),$P(^("SL"),U,5)]"",$D(^SC($P(^("SL"),U,5),0)) S SDCP=$P(^SC(SC,"SL"),U,5)
 S SDCP=$S($D(SDCP):SDCP,1:SC) I $D(^DPT(DFN,"DE","B",SDCP)),VAQK(12)']"" S SDEA=$O(^DPT(DFN,"DE","B",SDCP,0)) I $D(^DPT(DFN,"DE",+SDEA,0)),$P(^(0),"^",2)']"",$O(^(1,0))'="" D CKCED
 Q
 ;
MORE ;K SDFS I $D(^SC(SC,"S",SDT,1)) S PT=SDT S K=0 F  S K=$O(^SC(SC,"S",SDT,1,K)) Q:'K!SDEND  I $P(^(K,0),"^",9)'["C" D PTL
 K SDFS S PT=SDT D PTL
 Q
 ;
CCLK S SDCC=0 F  S SDCC=$O(^SC(SC,"C",SDD,1,SDCC)) Q:'SDCC!SDEND  S SDPT0=$G(^DPT(+^(SDCC,0),0)) I $L(SDPT0) D
 .I ($Y+4>IOSL) D HED^SDAL Q:SDEND  W !
 .W !,"CHART REQUEST: ",$P(SDPT0,"^",1),?34,$P(SDPT0,"^",9)
 Q
 ;
CKCED S A=0 F  S A=$O(^DPT(DFN,"DE",SDEA,1,A)) Q:'A  I $P(^DPT(DFN,"DE",SDEA,1,A,0),"^",3)']"" D ENR Q
 Q
 ;
ENR S SDEDT=$P(^(0),"^",1)\1,SDDIF=DT-SDEDT,SDREV=$P(^(0),"^",5),SDDIF1=$S(SDREV:DT-SDREV,1:"") ;NAKED REFERENCE - ^DPT(DFN,"DE",SDEA,1,A,0)
 I $P(^DPT(DFN,"DE",SDEA,1,A,0),"^",2)="O",$S(SDDIF1']""&(SDDIF>10000):1,SDDIF1>10000:1,1:0) S SDEM="PATIENT HAS BEEN ENROLLED IN ",SDEM1="FOR MORE THAN 1 YEAR, PLEASE RE-EVALUATE"
 Q
 ;
CHECK() I $D(^SC(SC,0)),$P(^(0),"^",3)="C",$S(VAUTD:1,$D(VAUTD(+$P(^(0),"^",15))):1,'$P(^(0),"^",15)&$D(VAUTD(+$O(^DG(40.8,0)))):1,1:0)
 I $T,$D(^SC(SC,"ST",SDD,1)),^(1)'["**CANCELLED",$S('$D(^SC(SC,"I")):1,+^("I")'>0:1,+^("I")>SDD:1,+^("I")'>SDD&(+$P(^("I"),"^",2)>SDD!(+$P(^("I"),"^",2)=0)):0,1:1) Q 1
 Q 0
 ;
NCOUNT ;COUNT, NON-COUNT, or BOTH FOR CLINIC SELECTION
 W !,"Count, Non Count, or Both: C//" R SDCONC:DTIME
 I '$T!(SDCONC="") S SDCONC="C" Q
 Q:SDCONC=U
 I $L(SDCONC)=1,$E(SDCONC)="?" W !,"Type C, N or B" G NCOUNT
 I $E(SDCONC,1,2)="??" D  G NCOUNT
 . W !!,"Choosing ""C"" will limit the selection to COUNT clinics."
 . W !,"         ""N"" will limit the selection to NON COUNT clinics."
 . W !,"         ""B"" will give BOTH count and non count clinics.",!
 S SDCONC=$E(SDCONC),SDCONC=$TR(SDCONC,"bcn","BCN")
 I "BCN"'[SDCONC W !,"C, N or B" G NCOUNT
 Q
 ;
NCHECK() ;EXTEND $T LOGIC COUNT, NO COUNT,or BOTH  
 N NOC S NOC=$P($G(^SC(SC,0)),U,17)
 I SDCONC="B" Q 1
 I SDCONC="C"&(NOC="N") Q 1
 I SDCONC="N"&(NOC="Y") Q 1
 Q 0
 ;
NCLINIC ;SCREEN CLINICS
 N NOCC
 I SDCONC="B" S NOCC="&1"
 I SDCONC="N" S NOCC="&($P(^(0),U,17)=""Y"")"
 I SDCONC="C" S NOCC="&($P(^(0),U,17)=""N"")"
 S DIC="^SC(",DIC("S")="I $P(^(0),U,3)=""C""&'$G(^(""OOS""))"_NOCC_"&$S(VAUTD:1,$D(VAUTD(+$P(^(0),U,15))):1,'+$P(^(0),U,15)&$D(VAUTD(+$O(^DG(40.8,0)))):1,1:0)",VAUTSTR="clinic",VAUTVB="VAUTC" G FIRST^VAUTOMA
 ;
ACTIVE() ;Determine if clinic has activity to print
 ;Output: '1' if activity or selected clinic, '0' otherwise
 Q:'VAUTC 1  ;selected clinics
 Q:$O(^SC(SC,"C",SDD,1,0)) 1  ;chart request list
 ;N SDX S SDX=0 F SDT=SDD:0 S SDT=$O(^SC(SC,"S",SDT)) Q:'SDT!(SDT\1-SDD)!SDX  D
 ;.F K=0:0 S K=$O(^SC(SC,"S",SDT,1,K)) Q:'K!SDX  I $P(^(K,0),"^",9)'["C" S SDX=1
 ;.Q  ;patient appointment activity
 ;if clinic has no appts, return 0
 S SDX=1 I '$D(^TMP($J,"SDAMA301",SC)) S SDX=0
 Q SDX
