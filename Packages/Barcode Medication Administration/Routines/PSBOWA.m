PSBOWA ;BIRMINGHAM/EFC-WARD ADMINISTRATION TIMES ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**9,32,56**;Mar 2004;Build 10
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; ^DPT/10035
 ; EN^PSJBCMA/2828
EN ;
 N PSBHDR,PSBGTOT,PSBTOT,PSBINDX,DFN,PSBX,PSBY,PSBSM,PSBADST,PSBZ
 S (Y,PSBEVDT)=$P(PSBRPT(.1),U,6) D D^DIQ
 S PSBHDR(2)="ADMINISTRATION DATE: "_Y
 S (Y,PSBEVDT2)=$S($P(PSBRPT(.1),U,8)']"":PSBEVDT,1:$P(PSBRPT(.1),U,8)) D D^DIQ
 S PSBHDR(2)=PSBHDR(2)_" to "_Y
 F PSBIX=0:1 S PSBRPDT=$$FMADD^XLFDT(PSBEVDT,PSBIX) Q:PSBRPDT>PSBEVDT2!(PSBRPDT="-1")  D
 .D:$P(PSBRPT(.1),U)="W"
 ..F X=0,.01:.01:.24 S PSBGTOT(X)=""
 ..W $$WRDHDR()
 ..S PSBINDX=""
 ..F  S PSBINDX=$O(^TMP("PSBO",$J,"B",PSBINDX)) Q:PSBINDX=""  D
 ...F DFN=0:0 S DFN=$O(^TMP("PSBO",$J,"B",PSBINDX,DFN)) Q:'DFN  D
 ....W:$Y>(IOSL-10) $$WRDHDR()
 ....W !,$P(^DPT(DFN,0),U,1),!,"SSN: ",$P(^(0),U,9)
 ....W !,"Ward: ",$E($G(^DPT(DFN,.1)),1,25),!,"Room-Bed:  ",$E($G(^(.101)),1,21)
 ....W ?32
 ....F X=0,.01:.01:.24 S PSBTOT(X)=""
 ....K ^TMP("PSJ",$J)
 ....D EN^PSJBCMA(DFN,$P(PSBRPT(.1),U,6))
 ....F PSBX=0:0 S PSBX=$O(^TMP("PSJ",$J,PSBX)) Q:'PSBX  D
 .....Q:^TMP("PSJ",$J,PSBX,0)=-1  ; No Orders
 .....D CLEAN^PSBVT
 .....D PSJ^PSBVT(PSBX)
 .....Q:PSBSCHT'="C"  ; Not a Continuous
 .....Q:PSBOSTS'="A"&(PSBOSTS'="R")&(PSBOSTS'="O")  ; Active? - PSB*3*56 adds on call as an active status
 .....Q:PSBSM=1  ;Self med?
 .....S (PSBCADM,PSBYES,PSBODD)=0
 .....S PSBFREQ=$$GETFREQ^PSBVDLU1(DFN,PSBONX)
 .....S:$$PSBDCHK1^PSBVT1(PSBSCH) PSBYES=1
 .....F I=1:1 Q:$P(PSBSCH,"-",I)=""  I ($P(PSBSCH,"-",I)?2N)!($P(PSBSCH,"-",I)?4N) S PSBYES=1
 .....I PSBYES,PSBADST="",PSBSCHT'="O",PSBSCHT'="OC",PSBSCHT'="P" D  Q
 ......D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Admin times required",PSBSCH)
 .....I "PCS"'[PSBIVT,PSBONX'["U" Q
 .....I PSBIVT["S",PSBISYR'=1 Q  ;    allow intermittent syringe only
 .....I PSBIVT["C",PSBCHEMT'="P",PSBISYR'=1 Q
 .....I PSBIVT["C",PSBCHEMT="A" Q  ;     allow Chemo with intermittent syringe or Piggyback type only
 .....I PSBFREQ="D" S PSBFREQ=""
 .....I 'PSBYES,PSBFREQ<1 D  Q
 ......D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Invalid frequency received from order",PSBSCH)
 .....I +PSBFREQ>0 D
 ......I (PSBFREQ#1440'=0),(1440#PSBFREQ'=0) S PSBODD=1
 .....I PSBODD,PSBADST'="" D  Q
 ......D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Administration Times on ODD SCHEDULE",PSBSCH)
 .....K ^TMP("PSB",$J,"GETADMIN")
 .....I PSBADST="" S PSBADST=$$GETADMIN^PSBVDLU1(DFN,PSBONX,PSBOST,PSBFREQ,PSBRPDT) S:PSBADST'="" PSBCADM=1
 .....E  S ^TMP("PSB",$J,"GETADMIN",0)=PSBADST
 .....Q:PSBADST=""
 .....I PSBONX'["V" D  Q:'$$OKAY^PSBVDLU1(PSBOST,$P(PSBRPT(.1),U,6),PSBSCH,PSBONX,PSBOIT,PSBFREQ)
 .....I PSBONX["V",PSBSCH'=""  Q:'$$OKAY^PSBVDLU1(PSBOST,$P(PSBRPT(.1),U,6),PSBSCH,PSBONX,PSBOIT,PSBFREQ)
 .....F PSBXX=0:1 Q:'$D(^TMP("PSB",$J,"GETADMIN",PSBXX))  S PSBADST=$G(^TMP("PSB",$J,"GETADMIN",PSBXX)) D
 ......F Y=1:1:$L(PSBADST,"-") S Z=+("."_$E($P(PSBADST,"-",Y),1,2)) D
 .......Q:(($P(PSBRPT(.1),U,6)+Z)<$E(PSBOST,1,12))&($G(Z)'=0)  ;Start Date
 .......Q:($P(PSBRPT(.1),U,6)+Z)'<$E(PSBOSP,1,12)  ;Stop Date
 .......;For invalid admin times
 .......D:($P(PSBADST,"-",Y)'?2N)&($P(PSBADST,"-",Y)'?4N)
 ........D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Invalid Admin times",PSBSCH)
 .......S PSBTOT(Z)=PSBTOT(Z)+1
 .......S PSBGTOT(Z)=PSBGTOT(Z)+1
 ....S PSBX="" F  S PSBX=$O(PSBTOT(PSBX)) Q:$G(PSBX)=""  W $J(PSBTOT(PSBX),4)
 ....W !,$TR($J("",IOM)," ","-")
 ..W !!,$TR($J("",IOM)," ","=")
 ..W !?32 F X=0,.01:.01:.24 W $J($E(X_"00",2,3),4)
 ..W !,"Hourly Totals:",?32
 ..S PSBGTOT=0
 ..S PSBX="" F  S PSBX=$O(PSBGTOT(PSBX)) Q:$G(PSBX)=""  D
 ...W $J(PSBGTOT(PSBX),4)
 ...S PSBGTOT=PSBGTOT+PSBGTOT(PSBX)
 ..W !!,"Ward Total:",?32,$J(PSBGTOT,4)
 ..W !!,$TR($J("",IOM)," ","-")
 ..K ^TMP("PSJ",$J)
 .D:$P(PSBRPT(.1),U)="P"
 ..S DFN=PSBDFN
 ..S PSBHDR(1)="WARD ADMINISTRATION TIMES"
 ..S Y=$P(PSBRPT(.1),U,6) D D^DIQ S PSBHDR(2)="ADMINISTRATION DATE: "_Y
 ..S Y=PSBEVDT2 D D^DIQ S PSBHDR(2)=PSBHDR(2)_" to "_Y
 ..W $$PTHDR()
 ..K ^TMP("PSJ",$J),PSBTOT
 ..D EN^PSJBCMA(PSBDFN,PSBRPDT,"")
 ..F PSBX=0:0 S PSBX=$O(^TMP("PSJ",$J,PSBX)) Q:'PSBX  D
 ...Q:^TMP("PSJ",$J,PSBX,0)=-1  ; No Orders
 ...D CLEAN^PSBVT
 ...D PSJ^PSBVT(PSBX)
 ...Q:PSBSCHT'="C"  ; Not a Continuous
 ...Q:PSBOSTS'="A"&(PSBOSTS'="R")&(PSBOSTS'="O")  ; Active? - PSB*3*56 adds on call as an active status
 ...S (PSBCADM,PSBYES,PSBODD)=0
 ...S PSBFREQ=$$GETFREQ^PSBVDLU1(DFN,PSBONX)
 ...S:$$PSBDCHK1^PSBVT1(PSBSCH) PSBYES=1
 ...F I=1:1 Q:$P(PSBSCH,"-",I)=""  I ($P(PSBSCH,"-",I)?2N)!($P(PSBSCH,"-",I)?4N) S PSBYES=1
 ...I PSBYES,PSBADST="",PSBSCHT'="O",PSBSCHT'="OC",PSBSCHT'="P" D  Q
 ....D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Admin times required",PSBSCH)
 ...I "PCS"'[PSBIVT,PSBONX'["U" Q
 ...I PSBIVT["S",PSBISYR'=1 Q  ;    allow intermittent syringe only
 ...I PSBIVT["C",PSBCHEMT'="P",PSBISYR'=1 Q
 ...I PSBIVT["C",PSBCHEMT="A" Q  ;     allow Chemo with intermittent syringe or Piggyback type only
 ...I PSBFREQ="D" S PSBFREQ=""
 ...I 'PSBYES,PSBFREQ<1 D  Q
 ....D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Invalid frequency received from order",PSBSCH)
 ...I +PSBFREQ>0 D
 ....I (PSBFREQ#1440'=0),(1440#PSBFREQ'=0) S PSBODD=1
 ...I PSBODD,PSBADST'="" D  Q
 ....D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Administration Times on ODD SCHEDULE",PSBSCH)
 ...K ^TMP("PSB",$J,"GETADMIN")
 ...I PSBADST="",+$G(PSBFREQ)>0,$G(PSBFREQ)<30 S PSBADST="MESSAGE",$P(PSBTOT(PSBADST,PSBOITX,PSBONX),2)="Due every "_PSBFREQ_" Mins" Q
 ...I PSBADST="",+$G(PSBFREQ)'<30 S PSBADST=$$GETADMIN^PSBVDLU1(DFN,PSBONX,PSBOST,PSBFREQ,PSBRPDT) S:PSBADST'="" PSBCADM=1
 ...E  S ^TMP("PSB",$J,"GETADMIN",0)=PSBADST
 ...Q:PSBADST=""
 ...I PSBONX'["V" D  Q:'$$OKAY^PSBVDLU1(PSBOST,PSBRPDT,PSBSCH,PSBONX,PSBOIT,PSBFREQ)
 ...I PSBONX["V",PSBSCH'=""  Q:'$$OKAY^PSBVDLU1(PSBOST,PSBRPDT,PSBSCH,PSBONX,PSBOIT,PSBFREQ)
 ...F PSBXX=0:1 Q:'$D(^TMP("PSB",$J,"GETADMIN",PSBXX))  S PSBADST=$G(^TMP("PSB",$J,"GETADMIN",PSBXX)) D
 ....F Y=1:1:$L(PSBADST,"-") S Z=+("."_$P(PSBADST,"-",Y)) D
 .....Q:(PSBRPDT+Z)<$E(PSBOST,1,12)  ; Start Date
 .....Q:(PSBRPDT+Z)'<$E(PSBOSP,1,12)  ; Stop Date
 .....;For Invalid admin times
 .....D:($P(PSBADST,"-",Y)'?2N)&($P(PSBADST,"-",Y)'?4N)
 ......D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Invalid Admin times",PSBSCH)
 .....S PSBSM=$S(PSBHSM=1:"HSM",PSBSM=1:"SM",1:"")
 .....;*** Local array to include order no
 .....S PSBTOT(Z,PSBOITX,PSBONX)=PSBSM_U_"Dosage: "_PSBDOSE_"  Route: "_PSBMR_"  "_PSBIFR
 ..S PSBX="" F  S PSBX=$O(PSBTOT(PSBX)) Q:PSBX=""  D
 ...W !
 ...S PSBY="" F  S PSBY=$O(PSBTOT(PSBX,PSBY)) Q:PSBY=""  D
 ....S PSBZ="" F  S PSBZ=$O(PSBTOT(PSBX,PSBY,PSBZ)) Q:PSBZ=""  D
 .....W:$Y>(IOSL-6) $$PTFTR^PSBOHDR(),$$PTHDR()
 .....I PSBX="MESSAGE" W !,$P(PSBTOT(PSBX,PSBY,PSBZ),U,1),?20,PSBY Q
 .....W !,$$TIMEOUT^PSBUTL(PSBX),?10
 .....W $P(PSBTOT(PSBX,PSBY,PSBZ),U,1),?20,PSBY,?55,$P(PSBTOT(PSBX,PSBY,PSBZ),U,2)
 ..W $$PTFTR^PSBOHDR()
 .K ^TMP("PSJ",$J),^TMP("PSB",$J)
 .Q
 ;
WRDHDR() ;
 S PSBHDR(1)="WARD ADMINISTRATION TIMES"
 D WARD^PSBOHDR(PSBWRD,.PSBHDR)
 S Y=PSBRPDT D D^DIQ
 W !,"Patient Name",?64,Y_" Administration Times"
 W !,"Room-Bed",?32
 F X=0,.01:.01:.24 W $J($E(X_"00",2,3),4)
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
PTHDR() ;
 S PSBHDR(1)="PATIENT ADMINISTRATION TIMES"
 D PT^PSBOHDR(PSBDFN,.PSBHDR)
 W !,"Date/Time",?10,"Self Med",?20,"Medication",?55,"Dose/Route"
 W !,$TR($J("",IOM)," ","-")
 S Y=PSBRPDT D D^DIQ
 W !!,Y,!
 Q ""
 ;
