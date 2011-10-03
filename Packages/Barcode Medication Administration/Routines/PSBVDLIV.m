PSBVDLIV ;BIRMINGHAM/EFC-BCMA IV VIRTUAL DUE LIST ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**6,38,32**;Mar 2004;Build 32
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; EN^PSJBCMA/2828
 ; EN^PSJBCMA1/2829 
 ;
EN(DFN,PSBDT) ; Default Order List Return for Today
 ;
 ; RPC: PSB GETORDERLIST
 ;
 ; Description:
 ; Returns the current IV order set for today to display on the
 ; client VDL
 ;
 N PSBDATA,PSBTBOUT,PSBDOADD
 S PSBTBOUT=0,PSBDOADD=0
 S:PSBTAB="IVTAB" PSBDOADD=1
 ;
 ; Passing PSBDT as 3rd parameter turns off the V.1.0 One-Time lookback
 K ^TMP("PSJ",$J),^TMP("PSB",$J,"ON IVTAB") S X1=PSBDT,X2=-3 D C^%DTC S PSBDT2=X D EN^PSJBCMA(DFN,PSBDT2,PSBDT)
 ;
 I $G(^TMP("PSJ",$J,1,0))=-1 Q  ; No orders
 ;
 F PSBX=0:0 S PSBX=$O(^TMP("PSJ",$J,PSBX)) Q:('PSBX)!(PSBTBOUT)  D
 .D CLEAN^PSBVT,PSJ^PSBVT(PSBX)
 .;
 .; << Standard checks for ALL orders >>
 .;
 .Q:PSBONX'["V"  ; IVs only
 .Q:PSBIVT["P"  ; No piggybacks
 .Q:PSBONX["P"  ;     No Pending Orders
 .Q:PSBOST>($$FMADD^XLFDT($$NOW^XLFDT,,,$$GET^XPAR("DIV","PSB ADMIN BEFORE")))
 .; Need to see if "last order" in chain is active/not pending.
 .S PSBFON1=PSBFON,PSBLOOP=0 I $G(PSBFON)]"" S PSBLACTV=$S($G(PSBFON)["P":0,1:1) S PSBFON2=$G(PSBFON) I 'PSBLACTV F  D  Q:($G(PSBFON)="")!($G(PSBFON1)=$G(PSBFON2))!(PSBLOOP)!(PSBLACTV)  ;
 ..I $G(PSBFON)["P" K ^TMP("PSJ1",$J) D EN^PSJBCMA1(DFN,PSBFON2,1) I ^TMP("PSJ1",$J,0)=-1 S PSBFON=""
 ..D:$G(PSBFON)["" CLEAN^PSBVT,PSJ1^PSBVT(DFN,PSBFON2)
 ..I PSBFON=PSBFON2 S PSBLOOP=1,PSBLACTV=0 Q
 ..S PSBLACTV=$S($G(PSBFON)["P":0,$G(PSBFON)']"":PSBLACTV,1:1),PSBFON2=$G(PSBFON)
 ..S:(PSBLACTV)&($G(PSBOST)>($$FMADD^XLFDT($$NOW^XLFDT,,,$$GET^XPAR("DIV","PSB ADMIN BEFORE")))) PSBLACTV=0
 .D CLEAN^PSBVT,PSJ^PSBVT(PSBX) ;Refresh data
 .K PSBCOMP,PSBCOMPX,PSBINFDT,PSBINFST D INFUSING^PSBVDLU2
 .D NOW^%DTC
 .I ((PSBOSTS="A")!(PSBOSTS="R"))&(PSBOSP<%) S PSBOSTS="E"
 .I (PSBOSTS["D")&(PSBCOMP=0) Q  ;     Is it DC'd and not infusing or stopped
 .I PSBOSTS="E",PSBCOMP=0 Q  ; Is expired and not infusing or stopped
 .I PSBOSTS="D",PSBCOMP=1,($G(PSBFON)]""),PSBLACTV Q  ; order is DC'ed   will be picked up by following order
 .I PSBOSTS="E",PSBCOMP=1,($G(PSBFON)]""),PSBLACTV Q  ; order is expired will be picked up by following order
 .I PSBOSTS="R",PSBFOR="R",PSBOSP<PSBWBEG Q  ; order is renewed bag picked up by following order
 .Q:$G(^TMP("PSB",$J,"ON IVTAB",PSBDFN,PSBONX))=1  ; The "previous order" is displayed on the VDL!
 .I (PSBOSTS["E")&(PSBCOMP=0) Q  ;     Is it expired and not infusing
 .I PSBIVT["S",PSBISYR=1 Q  ;     No intermittent syringes - done on PB tab
 .I PSBIVT["C",PSBISYR=1 Q  ;     No intermittent syringes - done on PB tab
 .I PSBIVT["C",PSBCHEMT="P" Q  ;  No Piggyback Chemos
 .I PSBNGF&(PSBCOMP=1) Q  ;         Is it marked DO NOT GIVE!
 .;
 .; Non One-Times with stop date/time < now
 .;
 .D NOW^%DTC
 .I PSBOSP<%,PSBOSTS'="R",PSBCOMP'=1 Q
 .;
 .; include Active, Renewed, ReInstated and On Call and Hold and Expired infusing
 .; (Is it not one time)&(Is it not active or renewed or On Call or Hold)
 .Q:PSBSCHT'="O"&((PSBOSTS'="A")&(PSBOSTS'="R")&(PSBOSTS'="RE")&(PSBOSTS'="O")&(PSBOSTS'="D")&(PSBOSTS'="H")&(PSBOSTS'="E"))
 .;
 .; Is One Time Given
 .;
 .I PSBSCHT="O" D  Q:PSBGVN
 ..S (PSBGVN,X,Y)=""
 ..F  S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X),-1) Q:'X  D
 ...F  S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X,Y),-1) Q:'Y  D
 ....I $P(^PSB(53.79,Y,.1),U)=PSBON,$P(^PSB(53.79,Y,0),U,9)="G" S PSBGVN=1,(X,Y)=0
 .;
 .; Is On-Call Given, Can it be given more than once
 .;
 .I PSBSCHT="OC" D  Q:PSBGVN&('$$GET^XPAR("DIV","PSB ADMIN MULTIPLE ONCALL"))
 ..S (PSBGVN,X,Y)=""
 ..F  S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X),-1) Q:'X  D
 ...F  S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X,Y),-1) Q:'Y  D
 ....I $P(^PSB(53.79,Y,.1),U)=PSBON,$P(^PSB(53.79,Y,0),U,9)="G" S PSBGVN=1,(X,Y)=0
 .;
OK .S PSBSTRT=PSBOST ; Order Start Date/Time
 .S PSBSTOP=PSBOSP ; Order Stop Date/Time
 .;
 .S PSBREC=""
 .S $P(PSBREC,U,1)=DFN ; dfn
 .S $P(PSBREC,U,2)=PSBONX ; Order
 .S $P(PSBREC,U,3)=+PSBON ; order ien
 .S $P(PSBREC,U,4)=PSBOTYP ; iv/ud/pending
 .S $P(PSBREC,U,5)=PSBSCHT ; schedule type
 .S $P(PSBREC,U,6)=PSBSCH ; schedule
 .S Y=""
 .S:PSBSM Y="SM"
 .S:PSBHSM Y="HSM"
 .S $P(PSBREC,U,7)=Y ; self med
 .S $P(PSBREC,U,8)=PSBOITX ; drugname
 .S $P(PSBREC,U,9)=PSBDOSE_" "_PSBIFR ; dosage
 .S $P(PSBREC,U,10)=PSBMR ; med route
 .; IV Information Column *new*  -  status date/time
 .; (only stopped or infusing)
 .;
 .D:PSBCOMP 
 ..S $P(PSBREC,U,11)=PSBINFDT K PSBINFDT
 ..S PSBSTUS=PSBINFST,$P(PSBREC,U,20)=PSBSTUS K PSBINFST
 .S $P(PSBREC,U,14)="" ; admin date inserted below
 .S $P(PSBREC,U,15)=PSBOIT ; OI Pointer
 .S $P(PSBREC,U,16)=PSBNJECT  ;Set injectable med route flag
 .; Variable dosage entered as ####-####?
 .I $P(PSBREC,U,9)?1.4N1"-"1.4N.E S $P(PSBREC,U,17)=1
 .E  S $P(PSBREC,U,17)=0
 .S $P(PSBREC,U,18)=PSBIVT  ;IV TYPE
 .S $P(PSBREC,U,21)=PSBOST
 .S $P(PSBREC,U,22)=PSBOSTS
 .S $P(PSBREC,U,26)=PSBSTOP
 .S $P(PSBREC,U,27)=$$LASTG^PSBCSUTL(DFN,PSBOIT)
 .;
 .; Gather Dispense Drugs
 .D NOW^%DTC
 .S (PSBDDS,PSBSOLS,PSBADDS)="0"
 .F Y=0:0 S Y=$O(PSBDDA(Y)) Q:'Y  D
 ..Q:$P(PSBDDA(Y),U,4)&($P(PSBDDA(Y),U,4)<%)  ; Inactive
 ..S:$P(PSBDDA(Y),U,3)="" $P(PSBDDA(Y),U,3)=1
 ..S PSBDDS=PSBDDS_U_$P(PSBDDA(Y),U,1,3)
 ..S $P(PSBDDS,U,1)=PSBDDS+1
 .; On-Call One Time PRN orders
 .S PSBQRR=0
 .I "^O^OC^P^"[(U_PSBSCHT_U) D  Q
 ..I 'PSBDOADD S PSBTBOUT=1,^TMP("PSB",$J,"IVTAB",0)=2,^TMP("PSB",$J,"IVTAB",1)=1,^TMP("PSB",$J,"IVTAB",2)=1 Q
 ..D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSBNOW\1,PSBDDS,PSBSOLS,PSBADDS,"IVTAB")
 ..S:$G(PSBFON)'="" ^TMP("PSB",$J,"ON IVTAB",PSBDFN,PSBFON)=1  ; Now do not have to place "following order" on VDL!
 .;
 .; IV's - don't worry about admin times if blank
 .I PSBONX["V",PSBIVT'="P",PSBADST="" D  Q
 ..I 'PSBDOADD S PSBTBOUT=1,^TMP("PSB",$J,"IVTAB",0)=2,^TMP("PSB",$J,"IVTAB",1)=1,^TMP("PSB",$J,"IVTAB",2)=1 Q
 ..D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSBNOW\1_".",PSBDDS,PSBSOLS,PSBADDS,"IVTAB")
 ..S:$G(PSBFON)'="" ^TMP("PSB",$J,"ON IVTAB",PSBDFN,PSBFON)=1  ; Now do not have to place "following order" on VDL!
 .;
 .; Now we deal with only continuous
 .; process admintimes
 .S PSBFREQ=$$GETFREQ^PSBVDLU1(DFN,PSBONX)
 .S PSBADMIN=PSBADST
 .; process admin times against beginning and ending date
 .; build all orders for both days.
 .F PSBY=1:1 Q:$P(PSBADMIN,"-",PSBY)=""  D
 ..; apply this time to the beginning window date
 ..S PSB=+(PSBWBEG\1_"."_$P(PSBADMIN,"-",PSBY))
 ..D:(PSB'<PSBWBEG)&(PSB'>PSBWEND)  ; Make sure it is in the window
 ...D:(PSB'<PSBSTRT)&(PSB<PSBSTOP)  ; Make sure this time is active
 ....D:$$OKAY^PSBVDLU1(PSBSTRT,$P(PSB,"."),PSBSCH,PSBON,PSBOITX,PSBFREQ)  ; Okay on this date?
 .....I 'PSBDOADD S PSBTBOUT=1,^TMP("PSB",$J,"IVTAB",0)=2,^TMP("PSB",$J,"IVTAB",1)=1,^TMP("PSB",$J,"IVTAB",2)=1 Q
 .....D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSB,PSBDDS,PSBSOLS,PSBADDS,"IVTAB")
 .....S:$G(PSBFON)'="" ^TMP("PSB",$J,"ON IVTAB",PSBDFN,PSBFON)=1  ; Now do not have to place "following order" on VDL!
 ..;
 ..Q:(PSBWBEG\1)=(PSBWEND\1)  ; Window only has one day rare but possible
 ..;
 ..; apply this time to the ending window date
 ..S PSB=+(PSBWEND\1_"."_$P(PSBADMIN,"-",PSBY))
 ..D:(PSB'<PSBWBEG)&(PSB'>PSBWEND)  ; Make sure it is in the window
 ...D:(PSB'<PSBSTRT)&(PSB<PSBSTOP)  ; Make sure this time is active
 ....D:$$OKAY^PSBVDLU1(PSBSTRT,$P(PSB,"."),PSBSCH,PSBON,PSBOITX,PSBFREQ)  ; Okay on this date?
 .....I 'PSBDOADD S PSBTBOUT=1,^TMP("PSB",$J,"IVTAB",0)=2,^TMP("PSB",$J,"IVTAB",1)=1,^TMP("PSB",$J,"IVTAB",2)=1 Q
 .....D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSB,PSBDDS,PSBSOLS,PSBADDS,"IVTAB")
 .....S:$G(PSBFON)'="" ^TMP("PSB",$J,"ON IVTAB",PSBDFN,PSBFON)=1  ; Now do not have to place "following order" on VDL!
 K ^TMP("PSB",$J,"ON IVTAB")
 ;
 ;add initials of verifying pharmacist/verifying nurse
 D:PSBDOADD VNURSE^PSBVDLU1("IVTAB")
 Q
 ;
