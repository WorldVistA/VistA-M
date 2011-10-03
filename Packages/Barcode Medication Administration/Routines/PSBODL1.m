PSBODL1 ;BIRMINGHAM/VRN-DUE LIST ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**5,9,32,28**;Mar 2004;Build 9
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified. 
 ;
EN ;
 S PSBFOHDR=0
 S PSBORD=0 F  S PSBORD=$O(^TMP("PSBO",$J,DFN,PSBORD)) Q:PSBORD=""  S PSBTYPE=$O(^TMP("PSBO",$J,DFN,PSBORD,"")) D
 .D CLEAN^PSBVT
 .D PSJ1^PSBVT(DFN,PSBORD)
 .I PSBSCHT="C" D  Q:PSBADMIN=""
 ..S PSBX=PSBADST,PSBFLAG=1
 ..I PSBX="",PSBONX["V",PSBIVT'="P" S PSBFLAG=0
 ..S (PSBYES,PSBODD)=0
 ..S:$$PSBDCHK1^PSBVT1(PSBSCH) PSBYES=1
 ..F I=1:1 Q:$P(PSBSCH,"-",I)=""  I $P(PSBSCH,"-",I)?2N!($P(PSBSCH,"-",I)?4N) S PSBYES=1
 ..I PSBYES,PSBADST="",PSBSCHT'="O",PSBSCHT'="OC",PSBSCHT'="P"  Q
 ..I PSBFREQ="O" S PSBFREQ=1440
 ..I 'PSBYES,PSBADST="",PSBFREQ<1 Q
 ..I +PSBFREQ>0 I (PSBFREQ#1440'=0),(1440#PSBFREQ'=0) S PSBODD=1
 ..I PSBODD,PSBADST'="" Q
 ..D:PSBX=""
 ...I PSBIVT="C",PSBCHEMT="A" S PSBX="0000",PSBFLAG=0
 ...I PSBIVT="C",PSBISYR=0 S PSBX="0000",PSBFLAG=0
 ...I PSBIVT="S",PSBISYR=0 S PSBX="0000",PSBFLAG=0
 ...I "HA"[PSBIVT S PSBX="0000",PSBFLAG=0
 ..I ("SC"[PSBIVT),(PSBISYR=1) S PSBX=""
 ..I (PSBIVT="C"),(PSBCHEMT="P") S PSBX=""
 ..I PSBOTYP="U",PSBX="0000" S PSBX=""
 ..I PSBIVT="P",$G(PSBX)=0 S PSBX=""
 ..I PSBX="" S PSBX=$$GETADMIN^PSBVDLU1(DFN,PSBONX,PSBOST,PSBFREQ,PSBEVDT)
 ..E  K ^TMP("PSB",$J,"GETADMIN") S ^TMP("PSB",$J,"GETADMIN",0)=PSBX
 ..S PSBADMIN=""
 ..F PSBXX=0:1 Q:'$D(^TMP("PSB",$J,"GETADMIN",PSBXX))  S PSBX=$G(^TMP("PSB",$J,"GETADMIN",PSBXX)) D
 ...F PSBY=1:1:$L(PSBX,"-")  D
 ....Q:($P(PSBX,"-",PSBY)'?2N)&($P(PSBX,"-",PSBY)'?4N)
 ....S PSBAT=+(PSBODATE_"."_$P(PSBX,"-",PSBY))
 ....I PSBFLAG Q:PSBAT<PSBOSTRT!(PSBAT>PSBOSTOP)  ; Report Window
 ....D VAL^PSBMLVAL(.PSBZ,DFN,PSBONX,PSBTYPE,PSBAT)
 ....S:$G(PSBFREQ)>29 PSBADMIN=PSBADMIN_$S(PSBADMIN]"":"-",1:"")_$P(PSBX,"-",PSBY)
 ....S:$G(PSBFREQ)<30 PSBADMIN="Due every "_$G(PSBFREQ)_" minutes."
 .I PSBSCHT'="C" S PSBADMIN=PSBADST
 .; Get LAST GIVEN date/time
 .S PSBLGDT="",X=""
 .F  S X=$O(^PSB(53.79,"AOIP",DFN,+PSBOIT,X),-1) Q:'X  D  Q:PSBLGDT
 ..S PSBIEN=""
 ..F  S PSBIEN=$O(^PSB(53.79,"AOIP",DFN,+PSBOIT,X,PSBIEN),-1) Q:PSBIEN=""  D  Q:PSBLGDT
 ...S:"MHNR"'[$P($G(^PSB(53.79,PSBIEN,0)),U,9) PSBLGDT=X
 .I $Y>(IOSL-12) I $Y<(IOSL-4) W !?(IOM-36\2),"(Medications Continued on Next Page)",$$FTR(),$$HDR()
 .I PSBSM S PSBSM=$S(PSBSMX:"H",1:"")_"SM"
 .E  S PSBSM=""
 .I 'PSBFOHDR S PSBFOHDR=1 W $$HDR()
 .W !,$J(PSBSM,3),?6,PSBTYPE,$E(PSBSCHT,1,4),?12 S PSBWFLAG=1
 .S X="",Y=0
 .W $$WRAP(14,34,PSBOITX)
 .S PSBADM="Give: "_PSBDOSE_"  "_PSBSCH
 .W $$WRAP(50,27,PSBADM)
 .W $$WRAP(78,6,PSBMR)
 .W ?85 I PSBLGDT W $E(PSBLGDT,4,5),"/",$E(PSBLGDT,6,7),"/",$E(PSBLGDT,2,3) W "@",$E($P(PSBLGDT,".",2)_"0000",1,4)
 .W ?100,$P($TR($$FMTE^XLFDT(PSBOST,2),"@"," ")," ")
 .W ?110,$P($TR($$FMTE^XLFDT(PSBOSP,2),"@"," ")," ")
 .W ?120,$S(PSBVPHI]"":PSBVPHI,1:"***"),"/",$S(PSBVNI]"":PSBVNI,1:"***")
 .W !,?100,"@"_$P(PSBOSTX,"  ",2),?110,"@"_$P(PSBOSPX,"  ",2)
 .W IOINHI  ; To Highlight the Dispense Drugs...
 .I $D(PSBDDA) S Y=0 F  S Y=$O(PSBDDA(Y)) Q:'Y  D
 ..Q:$P(PSBDDA(Y),U,5)&($P(PSBDDA(Y),U,5)<PSBNOW)
 ..W !?14,"*",$$WRAP(15,33,$P(PSBDDA(Y),U,3)_" ("_+$P(PSBDDA(Y),U,2)_")")
 .I $D(PSBADA) S Y=0 F  S Y=$O(PSBADA(Y)) Q:'Y  W !?14,"*",$$WRAP(15,33,$P(PSBADA(Y),U,3)_" ("_$P(PSBADA(Y),U,4)_")")
 .I $D(PSBSOLA) S Y=0 F  S Y=$O(PSBSOLA(Y)) Q:'Y  W !?14,"*",$$WRAP(15,33,$P(PSBSOLA(Y),U,3)_" ("_$P(PSBSOLA(Y),U,4)_")")
 .W IOINORM ; Highlight Off
 .S PSBADM=$S(PSBADMIN]"":"Admin Times: "_PSBADMIN,1:"")
 .W:PSBADM]"" $$WRAP(50,27,PSBADM)
 .S X=$S(PSBOTXT]"":PSBOTXT,1:"<None Entered>")
 .I $E(X,1)="!"  S $E(X,1)=""
 .W $$WRAP(14,34,"Spec Inst: "_X),!,$TR($J("",IOM)," ","-")
 I '$G(PSBWFLAG) W !!,?10,"** NO SPECIFIED MEDICATIONS TO PRINT **"
 W:PSBFOHDR $$BLANKS(),$$FTR()
 K ^TMP("PSB",$J,"GETADMIN")
 Q
 ;
WRAPPUP ;Do wrapping per PSBODL (Due List Report)
 ;
 W $$WRAP(14,34,PSBMED)
 S PSBADM="Give: "_PSBDOSE_"  "_PSBSCH
 W $$WRAP(50,27,PSBADM),?78,$$WRAP(78,6,PSBMR)
 W ?85 D:PSBLGDT
 .W $E(PSBLGDT,4,5),"/",$E(PSBLGDT,6,7),"/",$E(PSBLGDT,2,3),"@",$E($P(PSBLGDT,".",2)_"0000",1,4)
 W ?100,$P($TR($$FMTE^XLFDT(PSBOST,2),"@"," ")," "),?110,$P($TR($$FMTE^XLFDT(PSBOSP,2),"@"," ")," "),?120,$S(PSBVPHI]"":PSBVPHI,1:"***"),"/"
 W $S(PSBVNI]"":PSBVNI,1:"***"),!,?100,"@"_$P(PSBOSTX,"  ",2),?110,"@"_$P(PSBOSPX,"  ",2)
 W IOINHI
 I $D(PSBDDA) S Y=0 F  S Y=$O(PSBDDA(Y)) Q:'Y  D
 .Q:$P(PSBDDA(Y),U,5)&($P(PSBDDA(Y),U,5)<PSBNOW)
 .W !?14,"*",$$WRAP(15,33,$P(PSBDDA(Y),U,3)) ;_" ("_+$P(PSBDDA(Y),U,2)_")")
 I $D(PSBADA) S Y=0 F  S Y=$O(PSBADA(Y)) Q:'Y  W !?14,"*",$$WRAP(15,33,$P(PSBADA(Y),U,3)) ;_" ("_$P(PSBADA(Y),U,4)_")")
 I $D(PSBSOLA) S Y=0 F  S Y=$O(PSBSOLA(Y)) Q:'Y  W !?14,"*",$$WRAP(15,33,$P(PSBSOLA(Y),U,3)) ;_" ("_$P(PSBSOLA(Y),U,4)_")")
 W IOINORM ; Hlight Off
 S PSBADM=$S(PSBADMIN]"":"Admin Times: "_PSBADMIN,1:"")
 W:PSBADM]"" $$WRAP(50,27,PSBADM)
 S X=$S(PSBOTXT]"":PSBOTXT,1:"<None Entered>")
 I $E(X,1)="!"  S $E(X,1)=""
 W $$WRAP(14,34,"Spec Inst: "_X),!,$TR($J("",IOM)," ","-")
 Q
 ;
WRAP(X,Y,Z) ; Quick text wrap
 F  Q:'$L(Z)  D
 .W:$X>X !
 .W:$X<X ?X
 .I $L(Z)<Y W Z S Z="" Q
 .F PSB=Y:-1:0 Q:$E(Z,PSB)=" "
 .S:PSB<1 PSB=Y
 .W $E(Z,1,PSB)
 .S Z=$E(Z,PSB+1,255)
 Q ""
 ;
FTR() ; [Extrinsic] Page footer
 ;
 ; Sub Module Description:
 ; (No Description Available)
 ;
 I (IOSL<100) F  Q:$Y>(IOSL-10)  W !
 W !,$TR($J("",IOM)," ","=")
 S X="Ward: "_PSBHDR("WARD")_"  Room-Bed: "_PSBHDR("ROOM")
 W !,PSBHDR("NAME"),?(IOM-11\2),PSBHDR("SSN"),?(IOM-$L(X)),X
 Q ""
 ;
HDR() ; Page Header
 Q:'PSBFOHDR ""
 D PT^PSBOHDR(DFN,.PSBHDR)
 W !
 W !
 W !,?(IOM-28\2),"*****   FUTURE ORDERS   *****"
 W !
 W !,"Self",?85,"Last",?100,"Start",?110,"Stop",?120,"Verifying"
 W !,"Med",?6,"Sched",?14,"Medication",?50,"Dose",?78,"Route",?85,"Given",?100,"Date",?110,"Date",?120,"Rph/Rn"
 W !,?100,"@Time",?110,"@Time"
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
BLANKS() ; [Extrinsic] Print blanks at end of printout for changes
 Q:'$P(PSBRPT(.2),U,5) ""
 W !
 I $Y>(IOSL-26) W ?(IOM-42\2),"(Changes/Addendums to Orders on Next Page)" W $$FTR(),$$HDR() ; Not enough space - new page
 I IOSL<100 F  Q:$Y>(IOSL-26)  W !
 W ?(IOM-28\2),"Changes/Addendums to orders"
 F X=1:1:4 D
 .W !,$TR($J("",IOM)," ","-")
 .W !!?3,"CON ___ PRN ___",?20,"Drug: ",$TR($J("",22)," ","_"),?50,"Give: ",$TR($J("",42)," ","_"),?100,"Start: _________ Stop: _________"
 .W !?20,"Spec"
 .W !?3,"OT  ___ OC  ___",?20,"Inst: ",$TR($J("",72)," ","_"),?100,"Initials: ______ Date: _________"
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
