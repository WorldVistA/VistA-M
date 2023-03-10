PSBOWA ;BIRMINGHAM/EFC-WARD ADMINISTRATION TIMES ;2/6/21  18:03
 ;;3.0;BAR CODE MED ADMIN;**9,32,56,70,80,83,106**;Mar 2004;Build 43
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; ^DPT/10035
 ; EN^PSJBCMA/2828
 ;
 ;*70 - add Clinic filter and clinic name into array
 ;      1480: Add clinic to header and breakdown by clinic in detail.
 ;*83 - add ability to print Scheduled Removals on Patient report
 ;    - count Removes in the Ward & Clinic reports.
 ;*106- add Hazardous Handle & Dispose flags
 ;
EN ;
 N PSBHDR,PSBGTOT,PSBTOT,PSBINDX,DFN,PSBX,PSBY,PSBSM,PSBADST,PSBZ
 N PSBSRCHL,PSBSORT,PSBCL                                      ;*70
 N RMDT,PSBIEN
 S PSBSORT=$P(PSBRPT(.1),U,1)                   ;init PSBSORT  ;*70
 S (Y,PSBEVDT)=$P(PSBRPT(.1),U,6) D D^DIQ
 S PSBHDR(2)="ADMINISTRATION DATE: "_Y
 ;check Clinic or Nurs Unit search list                        ;*70
 S PSBSRCHL=$$SRCHLIST^PSBOHDR()
 D:$G(PSBSRCHL)]""
 .S PSBHDR(3)=""
 .S:$P(PSBRPT(4),U,2)="C" PSBHDR(4)="Clinic Search List: "
 .S:$P(PSBRPT(4),U,2)="I" PSBHDR(4)="Ward Location: "
 ;
 S (Y,PSBEVDT2)=$S($P(PSBRPT(.1),U,8)']"":PSBEVDT,1:$P(PSBRPT(.1),U,8)) D D^DIQ
 S PSBHDR(2)=PSBHDR(2)_" to "_Y
 ;
 I PSBSORT="P" D PATIENT
 I PSBSORT="W" D WARD
 I PSBSORT="C" D CLINIC
 D QUIT
 Q
 ;
PATIENT ;* * *  Print By Patient  * * *
 F PSBIX=0:1 S PSBRPDT=$$FMADD^XLFDT(PSBEVDT,PSBIX) Q:PSBRPDT>PSBEVDT2!(PSBRPDT="-1")  D
 .; * * *  Print By Patient  * * *
 .D:PSBSORT="P"
 ..S DFN=PSBDFN
 ..K ^TMP("PSJ",$J)
 ..D EN^PSJBCMA(PSBDFN,PSBRPDT,"")
 ..D:PSBCLINORD                                     ;*70 filer clinics
 ... I $D(PSBRPT(2)) D FILTERCO^PSBO Q
 ... D INCLUDCO^PSBVDLU1
 ..I 'PSBCLINORD D REMOVECO^PSBVDLU1                ;*70
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
 .....S PSBTOT(PSBRPDT+Z,PSBOITX_"[sort2]",PSBONX)=PSBSM_U_"Dosage: "_PSBDOSE_"  Route: "_PSBMR_"  "_PSBIFR_U_PSBCLORD_U_U_PSBHAZHN_U_PSBHAZDS         ;add clinic name *70   ;sort Gives 2nd *83   ;*106 adds haz handle/dispose notice 5 & 6 piece
 ;
 ;process removes for MRR meds and add to print array if applies
 K ^TMP("PSB",$J,"RM")
 D GETREMOV^PSBO1(DFN)
 ;
 D:$D(^TMP("PSB",$J,"RM"))
 .F PSBIEN=0:0 S PSBIEN=$O(^TMP("PSB",$J,"RM",PSBIEN)) Q:'PSBIEN  D
 ..S RMDT=$P(^TMP("PSB",$J,"RM",PSBIEN),U,1)
 ..Q:($P(RMDT,".")<PSBEVDT)!($P(RMDT,".")>PSBEVDT2)
 ..S PSBCLORD=$P(^TMP("PSB",$J,"RM",PSBIEN),U,6)  ;CLOR
 ..Q:(PSBCLINORD)&(PSBCLORD="")
 ..Q:('PSBCLINORD)&(PSBCLORD]"")
 ..S PSBONX=$P(^TMP("PSB",$J,"RM",PSBIEN),U,2)    ;ONX
 ..S PSBOITX=$P(^TMP("PSB",$J,"RM",PSBIEN),U,3)   ;OITX
 ..S PSBOSTS=$P(^TMP("PSB",$J,"RM",PSBIEN),U,4)   ;OSTS
 ..S PSBOSP=$P(^TMP("PSB",$J,"RM",PSBIEN),U,5)    ;OSP
 ..S PSBDOSE=$P(^TMP("PSB",$J,"RM",PSBIEN),U,7)   ;DOSE
 ..S PSBMR=$P(^TMP("PSB",$J,"RM",PSBIEN),U,8)     ;MR
 ..S PSBSM=$P(^TMP("PSB",$J,"RM",PSBIEN),U,9)     ;SM
 ..S PSBSM=$S($G(PSBHSM)=1:"HSM",PSBSM=1:"SM",1:"")
 ..S PSBIFR=""                             ;infuse rt n/a for MRR meds
 ..S PSBHAZHN=$P(^TMP("PSB",$J,"RM",PSBIEN),U,10)     ;HAZHAN
 ..S PSBHAZDS=$P(^TMP("PSB",$J,"RM",PSBIEN),U,11)     ;HAZDIS
 ..S PSBTOT(RMDT,PSBOITX_"[sort1]",PSBONX)=PSBSM_U_"Dosage: "_PSBDOSE_"  Route: "_PSBMR_"  "_PSBIFR_U_PSBCLORD_U_"(RM)"_U_PSBHAZHN_U_PSBHAZDS   ;sort RMs 1st *83  '*106 adds haz handle/dispose notice
 ;
 ;print the patient report
 N PREVRPDT                                                       ;*83
 S PSBHDR(1)="WARD ADMINISTRATION TIMES"
 S Y=$P(PSBRPT(.1),U,6) D D^DIQ S PSBHDR(2)="ADMINISTRATION DATE: "_Y
 S Y=PSBEVDT2 D D^DIQ S PSBHDR(2)=PSBHDR(2)_" to "_Y
 S PREVRPDT=""
 W:'$D(PSBTOT) $$PTHDR()    ;insure a header when no records found
 S PSBX="" F  S PSBX=$O(PSBTOT(PSBX)) Q:PSBX=""  D
 .S PSBRPDT=$P(PSBX,".")
 .;write hdr for each date found
 .I PREVRPDT'=PSBRPDT W $$PTHDR() S PREVRPDT=PSBRPDT
 .W !
 .S PSBY="" F  S PSBY=$O(PSBTOT(PSBX,PSBY)) Q:PSBY=""  D
 ..S PSBZ="" F  S PSBZ=$O(PSBTOT(PSBX,PSBY,PSBZ)) Q:PSBZ=""  D
 ...W:$Y>(IOSL-6) $$PTFTR^PSBOHDR(),$$PTHDR()
 ...I PSBX="MESSAGE" W !,$P(PSBTOT(PSBX,PSBY,PSBZ),U,1),?20,PSBY Q
 ...W:PSBCLINORD !,$P(PSBTOT(PSBX,PSBY,PSBZ),U,3)
 ...W !,$$TIMEOUT^PSBUTL(PSBX)," ",$P(PSBTOT(PSBX,PSBY,PSBZ),U,4),?13  ;remove code piece 4 if exists *83
 ...W $P(PSBTOT(PSBX,PSBY,PSBZ),U,1),?20,$P(PSBY,"[sort"),?55,$P(PSBTOT(PSBX,PSBY,PSBZ),U,2)   ;*83
 ...;*106 adds haz handle/dispose notice
 ...I ($P(PSBTOT(PSBX,PSBY,PSBZ),U,5)=1)!($P(PSBTOT(PSBX,PSBY,PSBZ),U,6)=1) W !
 ...W:$P(PSBTOT(PSBX,PSBY,PSBZ),U,5)=1 ?20,"<<HAZ HANDLE>> "
 ...W:$P(PSBTOT(PSBX,PSBY,PSBZ),U,6)=1 ?20,"<<HAZ DISPOSE>>"
 W $$PTFTR^PSBOHDR()        ;write end of rpt footer
 Q
 ;
WARD ;* * * *  Print By Ward  * * *
 F PSBIX=0:1 S PSBRPDT=$$FMADD^XLFDT(PSBEVDT,PSBIX) Q:PSBRPDT>PSBEVDT2!(PSBRPDT="-1")  D
 .F X=0,.01:.01:.24 S PSBGTOT(X)=""
 .W $$WRDHDR()
 .S PSBINDX=""
 .F  S PSBINDX=$O(^TMP("PSBO",$J,"B",PSBINDX)) Q:PSBINDX=""  D
 ..F DFN=0:0 S DFN=$O(^TMP("PSBO",$J,"B",PSBINDX,DFN)) Q:'DFN  D
 ...W:$Y>(IOSL-10) $$WRDHDR()
 ...W !,$P(^DPT(DFN,0),U,1),!,"SSN: ",$P(^(0),U,9)
 ...W !,"Ward: ",$E($G(^DPT(DFN,.1)),1,25),!,"Room-Bed:  ",$E($G(^(.101)),1,21)
 ...W ?32
 ...F X=0,.01:.01:.24 S PSBTOT(X)=""
 ...K ^TMP("PSJ",$J)
 ...D EN^PSJBCMA(DFN,$P(PSBRPT(.1),U,6))
 ...D REMOVECO^PSBVDLU1        ;*70 always remove CO orders from ward
 ...F PSBX=0:0 S PSBX=$O(^TMP("PSJ",$J,PSBX)) Q:'PSBX  D
 ....Q:^TMP("PSJ",$J,PSBX,0)=-1  ; No Orders
 ....D CLEAN^PSBVT
 ....D PSJ^PSBVT(PSBX)
 ....Q:PSBSCHT'="C"  ; Not a Continuous
 ....Q:PSBOSTS'="A"&(PSBOSTS'="R")&(PSBOSTS'="O")  ; Active? - PSB*3*56 adds on call as an active status
 ....Q:PSBSM=1  ;Self med?
 ....S (PSBCADM,PSBYES,PSBODD)=0
 ....S PSBFREQ=$$GETFREQ^PSBVDLU1(DFN,PSBONX)
 ....S:$$PSBDCHK1^PSBVT1(PSBSCH) PSBYES=1
 ....F I=1:1 Q:$P(PSBSCH,"-",I)=""  I ($P(PSBSCH,"-",I)?2N)!($P(PSBSCH,"-",I)?4N) S PSBYES=1
 ....I PSBYES,PSBADST="",PSBSCHT'="O",PSBSCHT'="OC",PSBSCHT'="P" D  Q
 .....D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Admin times required",PSBSCH)
 ....I "PCS"'[PSBIVT,PSBONX'["U" Q
 ....I PSBIVT["S",PSBISYR'=1 Q  ;    allow intermittent syringe only
 ....I PSBIVT["C",PSBCHEMT'="P",PSBISYR'=1 Q
 ....I PSBIVT["C",PSBCHEMT="A" Q  ;     allow Chemo with intermittent syringe or Piggyback type only
 ....I PSBFREQ="D" S PSBFREQ=""
 ....I 'PSBYES,PSBFREQ<1 D  Q
 .....D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Invalid frequency received from order",PSBSCH)
 ....I +PSBFREQ>0 D
 .....I (PSBFREQ#1440'=0),(1440#PSBFREQ'=0) S PSBODD=1
 ....I PSBODD,PSBADST'="" D  Q
 .....D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Administration Times on ODD SCHEDULE",PSBSCH)
 ....K ^TMP("PSB",$J,"GETADMIN")
 ....I PSBADST="" S PSBADST=$$GETADMIN^PSBVDLU1(DFN,PSBONX,PSBOST,PSBFREQ,PSBRPDT) S:PSBADST'="" PSBCADM=1
 ....E  S ^TMP("PSB",$J,"GETADMIN",0)=PSBADST
 ....Q:PSBADST=""
 ....I PSBONX'["V" D  Q:'$$OKAY^PSBVDLU1(PSBOST,PSBRPDT,PSBSCH,PSBONX,PSBOIT,PSBFREQ)           ;*70
 ....I PSBONX["V",PSBSCH'=""  Q:'$$OKAY^PSBVDLU1(PSBOST,PSBRPDT,PSBSCH,PSBONX,PSBOIT,PSBFREQ)   ;*70
 ....F PSBXX=0:1 Q:'$D(^TMP("PSB",$J,"GETADMIN",PSBXX))  S PSBADST=$G(^TMP("PSB",$J,"GETADMIN",PSBXX)) D
 .....F Y=1:1:$L(PSBADST,"-") S Z=+("."_$E($P(PSBADST,"-",Y),1,2)) D
 ......Q:((PSBRPDT+Z)<$E(PSBOST,1,12))&($G(Z)'=0)    ;Start Date
 ......Q:(PSBRPDT+Z)'<$E(PSBOSP,1,12)                ;Stop Date
 ......;For invalid admin times
 ......D:($P(PSBADST,"-",Y)'?2N)&($P(PSBADST,"-",Y)'?4N)
 .......D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Invalid Admin times",PSBSCH)
 ......S PSBTOT(Z)=PSBTOT(Z)+1
 ......S PSBGTOT(Z)=PSBGTOT(Z)+1
 ......D:PSBMRRFL      ;mrr meds admins have a Remove, count it *83
 .......S PSBTOT(Z)=PSBTOT(Z)+1
 .......S PSBGTOT(Z)=PSBGTOT(Z)+1
 ...;print ward stats rpt from array
 ...S PSBX="" F  S PSBX=$O(PSBTOT(PSBX)) Q:$G(PSBX)=""  W $J(PSBTOT(PSBX),4)
 ...W !,$TR($J("",IOM)," ","-")
 .W !!,$TR($J("",IOM)," ","=")
 .W !?32 F X=0,.01:.01:.24 W $J($E(X_"00",2,3),4)
 .W !,"Hourly Totals:",?32
 .S PSBGTOT=0
 .S PSBX="" F  S PSBX=$O(PSBGTOT(PSBX)) Q:$G(PSBX)=""  D
 ..W $J(PSBGTOT(PSBX),4)
 ..S PSBGTOT=PSBGTOT+PSBGTOT(PSBX)
 .W !!,"Ward Total:",?32,$J(PSBGTOT,4)
 .W !!,$TR($J("",IOM)," ","-")
 Q
 ;
CLINIC ;* * *  Print By Clinic  * * *                              ;*70-1480
 F PSBIX=0:1 S PSBRPDT=$$FMADD^XLFDT(PSBEVDT,PSBIX) Q:PSBRPDT>PSBEVDT2!(PSBRPDT="-1")  D
 .F X=0,.01:.01:.24 S PSBGTOT(PSBRPDT,X)=""
 .S PSBINDX=""
 .F  S PSBINDX=$O(^TMP("PSBO",$J,"B",PSBINDX)) Q:PSBINDX=""  D
 ..F DFN=0:0 S DFN=$O(^TMP("PSBO",$J,"B",PSBINDX,DFN)) Q:'DFN  D
 ...K ^TMP("PSJ",$J)
 ...D EN^PSJBCMA(DFN,$P(PSBRPT(.1),U,6))
 ...;Filter in/out Clinic Orders               *70
 ...D:PSBCLINORD
 ....I $D(PSBRPT(2)) D FILTERCO^PSBO Q
 ....D INCLUDCO^PSBVDLU1
 ...F PSBX=0:0 S PSBX=$O(^TMP("PSJ",$J,PSBX)) Q:'PSBX  D
 ....S PSBCL=$P($G(^TMP("PSJ",$J,PSBX,0)),U,11)
 ....I PSBCL]"" F X=0,.01:.01:.24 S PSBTOT(PSBRPDT,DFN,PSBCL,X)=""
 ...F PSBX=0:0 S PSBX=$O(^TMP("PSJ",$J,PSBX)) Q:'PSBX  D
 ....S PSBCL=$P($G(^TMP("PSJ",$J,PSBX,0)),U,11)
 ....Q:^TMP("PSJ",$J,PSBX,0)=-1  ; No Orders
 ....D CLEAN^PSBVT
 ....D PSJ^PSBVT(PSBX)
 ....Q:PSBSCHT'="C"  ; Not a Continuous
 ....Q:PSBOSTS'="A"&(PSBOSTS'="R")&(PSBOSTS'="O")  ; Active? - PSB*3*56 adds on call as an active status
 ....Q:PSBSM=1  ;Self med?
 ....S (PSBCADM,PSBYES,PSBODD)=0
 ....S PSBFREQ=$$GETFREQ^PSBVDLU1(DFN,PSBONX)
 ....S:$$PSBDCHK1^PSBVT1(PSBSCH) PSBYES=1
 ....F I=1:1 Q:$P(PSBSCH,"-",I)=""  I ($P(PSBSCH,"-",I)?2N)!($P(PSBSCH,"-",I)?4N) S PSBYES=1
 ....I PSBYES,PSBADST="",PSBSCHT'="O",PSBSCHT'="OC",PSBSCHT'="P" D  Q
 .....D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Admin times required",PSBSCH)
 ....I "PCS"'[PSBIVT,PSBONX'["U" Q
 ....I PSBIVT["S",PSBISYR'=1 Q  ;    allow intermittent syringe only
 ....I PSBIVT["C",PSBCHEMT'="P",PSBISYR'=1 Q
 ....I PSBIVT["C",PSBCHEMT="A" Q  ;     allow Chemo with intermittent syringe or Piggyback type only
 ....I PSBFREQ="D" S PSBFREQ=""
 ....I 'PSBYES,PSBFREQ<1 D  Q
 .....D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Invalid frequency received from order",PSBSCH)
 ....I +PSBFREQ>0 D
 .....I (PSBFREQ#1440'=0),(1440#PSBFREQ'=0) S PSBODD=1
 ....I PSBODD,PSBADST'="" D  Q
 .....D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Administration Times on ODD SCHEDULE",PSBSCH)
 ....K ^TMP("PSB",$J,"GETADMIN")
 ....I PSBADST="" S PSBADST=$$GETADMIN^PSBVDLU1(DFN,PSBONX,PSBOST,PSBFREQ,PSBRPDT) S:PSBADST'="" PSBCADM=1
 ....E  S ^TMP("PSB",$J,"GETADMIN",0)=PSBADST
 ....Q:PSBADST=""
 ....I PSBONX'["V" D  Q:'$$OKAY^PSBVDLU1(PSBOST,PSBRPDT,PSBSCH,PSBONX,PSBOIT,PSBFREQ)
 ....I PSBONX["V",PSBSCH'=""  Q:'$$OKAY^PSBVDLU1(PSBOST,PSBRPDT,PSBSCH,PSBONX,PSBOIT,PSBFREQ)
 ....F PSBXX=0:1 Q:'$D(^TMP("PSB",$J,"GETADMIN",PSBXX))  S PSBADST=$G(^TMP("PSB",$J,"GETADMIN",PSBXX)) D
 .....F Y=1:1:$L(PSBADST,"-") S Z=+("."_$E($P(PSBADST,"-",Y),1,2)) D
 ......Q:((PSBRPDT)<$E(PSBOST,1,12))&($G(Z)'=0)  ;Start Date
 ......Q:(PSBRPDT)'<$E(PSBOSP,1,12)              ;Stop Date
 ......;For invalid admin times
 ......D:($P(PSBADST,"-",Y)'?2N)&($P(PSBADST,"-",Y)'?4N)
 .......D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Invalid Admin times",PSBSCH)
 ......S PSBTOT(PSBRPDT,DFN,PSBCL,Z)=PSBTOT(PSBRPDT,DFN,PSBCL,Z)+1
 ......S PSBGTOT(PSBRPDT,Z)=PSBGTOT(PSBRPDT,Z)+1
 ......D:PSBMRRFL       ;mrr meds admins have a Remove, count it *83
 .......S PSBTOT(PSBRPDT,DFN,PSBCL,Z)=PSBTOT(PSBRPDT,DFN,PSBCL,Z)+1
 .......S PSBGTOT(PSBRPDT,Z)=PSBGTOT(PSBRPDT,Z)+1
 .;
 .;print clinic stats rpt from array
 .S PSBRPDT="" F  S PSBRPDT=$O(PSBTOT(PSBRPDT)) Q:PSBRPDT=""  D
 ..W $$CLNHDR()
 ..S DFN="" F  S DFN=$O(PSBTOT(PSBRPDT,DFN)) Q:DFN=""  D
 ...W:$Y>(IOSL-10) $$CLNHDR()
 ...W !,$P(^DPT(DFN,0),U),!,$P(^(0),U,9)
 ...S PSBCL="" F  S PSBCL=$O(PSBTOT(PSBRPDT,DFN,PSBCL)) Q:PSBCL=""  D
 ....W:$Y>(IOSL-10) $$CLNHDR()
 ....W !,PSBCL,?32
 ....S PSBX=""  F  S PSBX=$O(PSBTOT(PSBRPDT,DFN,PSBCL,PSBX)) Q:PSBX=""  D
 .....W:$Y>(IOSL-10) $$CLNHDR()
 .....W $J(PSBTOT(PSBRPDT,DFN,PSBCL,PSBX),4)
 ...W !,$TR($J("",IOM)," ","-")
 ..W !!,$TR($J("",IOM)," ","=")
 ..W !?32 F X=0,.01:.01:.24 W $J($E(X_"00",2,3),4)
 ..W !,"Hourly Totals:",?32
 ..S PSBGTOT=0
 ..S PSBX="" F  S PSBX=$O(PSBGTOT(PSBRPDT,PSBX)) Q:$G(PSBX)=""  D
 ...W $J(PSBGTOT(PSBRPDT,PSBX),4)
 ...S PSBGTOT=PSBGTOT+PSBGTOT(PSBRPDT,PSBX)
 ..W !!,"Report Date Total:",?32,$J(PSBGTOT,4)
 ..W !!,$TR($J("",IOM)," ","-")
 Q
 ;
QUIT D CLEAN^PSBVT
 K I,^TMP("PSJ",$J),^TMP("PSB",$J)
 Q
 ;
 ;
WRDHDR() ;
 S PSBHDR(1)="WARD ADMINISTRATION TIMES"
 D WARD^PSBOHDR(PSBWRD,.PSBHDR,,,PSBSRCHL)
 S Y=PSBRPDT D D^DIQ
 W !,"Patient Name",?64,Y_" Administration Times"
 W !,"Room-Bed",?32
 F X=0,.01:.01:.24 W $J($E(X_"00",2,3),4)
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
CLNHDR() ;
 S PSBHDR(1)="CLINIC ADMINISTRATION TIMES"
 D CLINIC^PSBOHDR(.PSBRPT,.PSBHDR,,,PSBSRCHL)
 ;
 S Y=PSBRPDT D D^DIQ
 W !,"Patient Name",?64,Y_" Administration Times"
 W !,"SSN",!,"Location",?32                       ;*70
 F X=0,.01:.01:.24 W $J($E(X_"00",2,3),4)
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
PTHDR() ;
 S PSBHDR(1)="PATIENT ADMINISTRATION TIMES"
 D PT^PSBOHDR(PSBDFN,.PSBHDR,,,PSBSRCHL)
 W:PSBCLINORD !,"Location"
 W !,"Date/Time",?10,"Self Med",?20,"Medication",?55,"Dose/Route"
 W !,$TR($J("",IOM)," ","-")
 S Y=PSBRPDT D D^DIQ
 W !!,Y,!
 Q ""
