PSBVDLUD ;BIRMINGHAM/EFC-BCMA UNIT DOSE VIRTUAL DUE LIST FUNCTIONS ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**11,13,38,32**;Mar 2004;Build 32
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; EN^PSJBCMA/2828
 ; $$GET^XPAR/2263
 ;
EN(DFN,PSBDT) ;
 ;
 ;
 ; Description:
 ; Returns the current unit dose order set for today to display
 ; on the client VDL
 ;
 N PSBDATA,PSBTBOUT
 S PSBTBOUT=0
 ;
 ;This routine now re-uses the ^TMP("PSJ",$J global built in PSBVDLTB
 ;
 G:$G(^TMP("PSJ",$J,1,0))=-1 1
 F PSBX=0:0 S PSBX=$O(^TMP("PSJ",$J,PSBX)) Q:('PSBX)!(PSBTBOUT)  D
 .S:(PSBTAB'="UDTAB")&($G(^TMP("PSB",$J,"UDTAB",2))>0) PSBTBOUT=1
 .D CLEAN^PSBVT,PSJ^PSBVT(PSBX)
 .;
 .; << Standard checks for ALL orders >>
 .;
 .Q:PSBONX["V"  ;No IVs on UD tab
 .Q:PSBONX["P"  ;     No Pending Orders
 .Q:PSBOST>PSBWADM  ; Order Start Date/Time > admin window
 .Q:PSBOSP<PSBWBEG  ; For Non one-times Order Stop Date/Time < vdl window
 .Q:PSBOSTS["D"  ;     Is it DC'd
 .Q:PSBNGF  ;         Is it marked DO NOT GIVE!
 .Q:PSBIVPSH
 .;
 .; Non One-Times with stop date/time < now
 .;
 .D NOW^%DTC
 .Q:PSBOSP<%
 .;
 .; include Active, Renewed, ReInstated and On Call
 .; (Is it not one time)&(Is it not active or renewed or On Call)
 .I PSBSCHT'="O",PSBOSTS'="A",PSBOSTS'="H",PSBOSTS'="R",PSBOSTS'="RE",PSBOSTS'="O" Q
 .;
 .; Is One Time Given
 .;
 .I PSBSCHT="O" D  Q:PSBGVN
 ..S (PSBGVN,X,Y)=""
 ..F  S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X),-1) Q:'X  D
 ...F  S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X,Y),-1) Q:'Y  D
 ....I $P(^PSB(53.79,Y,.1),U)=PSBONX,$P(^PSB(53.79,Y,0),U,9)="G" S PSBGVN=1,(X,Y)=0
 .;
 .; How long does One Time remain on VDL ??
 .S PSBRMN=1
 .I PSBSCHT="O",PSBOSP'=PSBOST&(%>PSBOSP) S PSBRMN=0
 .Q:'PSBRMN
 .; Is On-Call Given, Can it be given more than once
 .;
 .I PSBSCHT="OC" D  Q:PSBGVN&('$$GET^XPAR("DIV","PSB ADMIN MULTIPLE ONCALL"))
 ..S (PSBGVN,X,Y)=""
 ..F  S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X),-1) Q:'X  D
 ...F  S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X,Y),-1) Q:'Y  D
 ....I $P(^PSB(53.79,Y,.1),U)=PSBONX,$P(^PSB(53.79,Y,0),U,9)="G" S PSBGVN=1,(X,Y)=0
 .;
 .S PSBREC=""
 .S $P(PSBREC,U,1)=DFN ; dfn
 .S $P(PSBREC,U,2)=PSBONX ; order
 .S $P(PSBREC,U,3)=PSBON ; order ien
 .S $P(PSBREC,U,4)=PSBOTYP ; iv/ud/pending
 .S $P(PSBREC,U,5)=PSBSCHT ; schedule type
 .S $P(PSBREC,U,6)=PSBSCH ; schedule
 .S $P(PSBREC,U,7)=$S(PSBHSM:"HSM",PSBSM:"SM",1:"") ; self med
 .S $P(PSBREC,U,8)=PSBOITX ; drugname
 .S $P(PSBREC,U,9)=PSBDOSE_" "_PSBIFR ; dosage
 .S $P(PSBREC,U,10)=PSBMR ; med route
 .; Last Given from the AOIP X-Ref - not given status not excepted
 .S (PSBCNT,PSBFLAG)=0,(YZ,PSBSTUS,PSBADMER)="" K PSBHSTA,PSBHSTAX
 .F XZ=1:1:20 S YZ=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,YZ),-1),(PSBCNT,PSBFLAG)=0 Q:YZ=""  D
 ..S:YZ>0 $P(PSBREC,U,11)=YZ
 ..S X="" F  S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,YZ,X),-1) Q:X=""  D
 ...K PSBLCK L +^PSB(53.79,X):1  I  L -^PSB(53.79,X) S PSBLCK=1
 ...S PSBSTUS=$P(^PSB(53.79,X,0),U,9)
 ...I $G(PSBSTUS)="" S:'$G(PSBLCK) PSBSTUS="X" I $G(PSBLCK) S PSBADMER=1 D
 ....K PSBPARM3,PSBPARM5,PSBPARM6,PSBPARM7
 ....S PSBPARM6=X,Y=$P(^PSB(53.79,X,.1),U,3) D DD^%DT S PSBPARM3=Y,Y=$P(^PSB(53.79,X,0),U,6) D DD^%DT S PSBPARM5=Y
 ....S PSBPARM7=$P(^PSB(53.79,X,0),U,7) S PSBPARM7="( # "_PSBPARM7_" ) "_$$GET1^DIQ(200,PSBPARM7_",",.01)
 ....K PSBXTMP S PSBXTMP=PSBONX
 ....D CLEAN^PSBVT,PSJ1^PSBVT(DFN,$$GET1^DIQ(53.79,PSBPARM6_",",.11))
 ....D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,PSBPARM3_" admin's ACTION STATUS is ""UNKNOWN"".",PSBSCH,PSBPARM5,PSBPARM6,PSBPARM7) ;  SEND AN E-MAIL
 ....D CLEAN^PSBVT,PSJ1^PSBVT(DFN,PSBXTMP)  ;Reset Variables
 ....S X=PSBPARM6 K PSBPARM3,PSBPARM5,PSBPARM6,PSBPARM7
 ...K PSBLCK S:(PSBSTUS']"") PSBSTUS="U"  I PSBSTUS'="N",($G(PSBSTUS)'="X") S PSBFLAG=1,PSBHSTA(YZ,$G(PSBSTUS))="ORIG"_U_X
 ...D:PSBSTUS="N"
 ....S $P(PSBREC,U,11)=""
 ....S Z="" F  S Z=$O(^PSB(53.79,X,.9,Z),-1) Q:'Z  Q:PSBFLAG=1  S PSBDATA=$G(^(Z,0)) D
 .....I (PSBDATA["Set to 'NOT GIVEN'")!(PSBDATA["Set to 'GIVEN'")!(PSBDATA["Set to 'REFUSED'")!(PSBDATA["Set to 'HELD'")!(PSBDATA["Set to 'MISSING DOSE'")!(PSBDATA["Set to 'REMOVED'") S PSBCNT=PSBCNT+1
 .....I (PSBDATA["STATUS 'HELD'")!(PSBDATA["STATUS 'GIVEN'")!(PSBDATA["STATUS 'REFUSED'")!(PSBDATA["STATUS 'MISSING DOSE'")!(PSBDATA["STATUS 'REMOVED'") S PSBCNT=PSBCNT+1
 .....I PSBCNT#2=0,PSBDATA["'REFUSED'" S PSBSTUS="R" D LAST^PSBVDLU1
 .....I PSBCNT#2=0,PSBDATA["'HELD'" S PSBSTUS="H" D LAST^PSBVDLU1
 .....I PSBCNT#2=0,PSBDATA["'MISSING DOSE'" S PSBSTUS="M" D LAST^PSBVDLU1
 .....I PSBCNT#2=0,PSBDATA["'REMOVED'" S PSBSTUS="RM" D LAST^PSBVDLU1
 .....I PSBFLAG=1,'$D(PSBHSTA($P(PSBREC,U,11),$G(PSBSTUS))) S PSBHSTA($P(PSBREC,U,11),$G(PSBSTUS))=Z_U_X
 .I $D(PSBHSTA) S $P(PSBREC,U,11)=$O(PSBHSTA(""),-1),PSBSTUS=$O(PSBHSTA($P(PSBREC,U,11),""),-1) M PSBHSTAX(PSBOIT)=PSBHSTA K PSBHSTA  ;last action date/time
 .S $P(PSBREC,U,12)=""  ;med log ien inserted below for actual date
 .S $P(PSBREC,U,13)=""  ;med log status inserted below for actual date
 .S $P(PSBREC,U,14)="" ; admin date inserted below
 .S $P(PSBREC,U,15)=PSBOIT ; OI Pointer
 .S $P(PSBREC,U,16)=PSBNJECT  ;med route injectable flag
 .; Variable dosage entered as ####-####?
 .I $P(PSBREC,U,9)?1.4N1"-"1.4N.E S $P(PSBREC,U,17)=1
 .E  S $P(PSBREC,U,17)=0
 .S:PSBDOSEF?1"CAP".E!(PSBDOSEF?1"TAB".E)!(PSBDOSEF="PATCH") $P(PSBREC,U,18)=PSBDOSEF ; dosage form
 .S $P(PSBREC,U,20)=$S((PSBSTUS="X")!(PSBSTUS="N"):"",1:PSBSTUS) ; last action status
 .S $P(PSBREC,U,21)=PSBOST
 .S $P(PSBREC,U,22)=PSBOSTS
 .S $P(PSBREC,U,26)=PSBOSP
 .S $P(PSBREC,U,27)=$$LASTG^PSBCSUTL(DFN,PSBOIT)
 .;
 .; Gather Dispense Drugs
 .D NOW^%DTC
 .S (PSBDDS,PSBSOLS,PSBADDS,PSBFLAG)="0"
 .F Y=0:0 S Y=$O(PSBDDA(Y)) Q:'Y  D
 ..I $P(PSBDDA(Y),U,5)=$P(%,".") S PSBFLAG=1 ;If drug was inactivated
 ..Q:$P(PSBDDA(Y),U,5)&($P(PSBDDA(Y),U,5)<%)  ; Inactive
 ..S:$P(PSBDDA(Y),U,4)="" $P(PSBDDA(Y),U,4)=1
 ..S PSBDDS=PSBDDS_U_$P(PSBDDA(Y),U,1,4)
 ..S $P(PSBDDS,U,1)=PSBDDS+1
 .;
 .; On-Call One Time PRN orders
 .S PSBQRR=0
 .I "^O^OC^P^"[(U_PSBSCHT_U) D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSBNOW\1,PSBDDS,PSBSOLS,PSBADDS,"UDTAB") Q
 .;
 .; Now we deal with only continuous
 .; process admintimes
 .; Display an order on the VDL based on the frequency received from IPM **PSB*2.0*3
 .S (PSBYES,PSBODD,PSBYTF)=0
 .I PSBSCH="" D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"No Schedule on this order")
 .S:$$PSBDCHK1^PSBVT1(PSBSCH) PSBYES=1
 .I PSBYES,PSBADST="" D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Admin times required",PSBSCH) Q
 .F I=1:1 Q:$P(PSBSCH,"-",I)=""  I $P(PSBSCH,"-",I)?2N!($P(PSBSCH,"-",I)?4N) S PSBYES=1,PSBYTF=1
 .I PSBSCHT="C",PSBYTF="1",PSBADST="" D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Admin times required",PSBSCH) Q
 .S PSBFREQ=$$GETFREQ^PSBVDLU1(DFN,PSBONX)
 .I PSBFREQ="O" S PSBFREQ=1440
 .I PSBFREQ="D" S PSBFREQ=""
 .I 'PSBYES,PSBFREQ<1 D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Invalid frequency received from order",PSBSCH) Q
 .I (PSBADST="")&(+PSBFREQ>0) D ODDSCH^PSBVDLU1("UDTAB") Q  ;calculate admin times based on frequency
 .; No admin times, MAYDAY MAYDAY!!
 .I +PSBFREQ>0 I (PSBFREQ#1440'=0),(1440#PSBFREQ'=0) S PSBODD=1
 .I PSBODD,PSBADST'="" D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Administration Times on ODD SCHEDULE",PSBSCH) Q
 .; process admin times against beginning and ending date
 .; build all orders for both days.
 .F PSBY=1:1 Q:$P(PSBADST,"-",PSBY)=""  D
 ..;For invalid admin times
 ..I ($P(PSBADST,"-",PSBY)'?2N)&($P(PSBADST,"-",PSBY)'?4N) D ERROR^PSBMLU(PSBONX,PSBOITX,DFN,"Invalid Admin times",PSBSCH)
 ..; apply this time to the beginning window date
 ..S PSB=+(PSBWBEG\1_"."_$P(PSBADST,"-",PSBY))
 ..D:(PSB'<PSBWBEG)&(PSB'>PSBWEND)  ; Make sure it is in the window
 ...D:(PSB'<PSBOST)&(PSB<PSBOSP)  ; Make sure this time is active
 ....D:$$OKAY^PSBVDLU1(PSBOST,PSB,PSBSCH,PSBONX,PSBOITX,PSBFREQ,PSBOSTS)  ; Okay on this date?
 .....D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSB,PSBDDS,PSBSOLS,PSBADDS,"UDTAB")
 ..;
 ..Q:(PSBWBEG\1)=(PSBWEND\1)  ; Window only has one day rare but possible
 ..;
 ..; apply this time to the ending window date
 ..S PSB=+(PSBWEND\1_"."_$P(PSBADST,"-",PSBY))
 ..D:(PSB'<PSBWBEG)&(PSB'>PSBWEND)  ; Make sure it is in the window
 ...D:(PSB'<PSBOST)&(PSB<PSBOSP)  ; Make sure this time is active
 ....D:$$OKAY^PSBVDLU1(PSBOST,PSB,PSBSCH,PSBONX,PSBOITX,PSBFREQ,PSBOSTS)  ; Okay on this date?
 .....D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSB,PSBDDS,PSBSOLS,PSBADDS,"UDTAB")
 .K PSBSTUS
1 K PSBREC D EN^PSBVDLPA
 ;add initials of verifying pharmacist/verifying nurse
 D:PSBTAB="UDTAB" VNURSE^PSBVDLU1("UDTAB")
 D CLEAN^PSBVT
 Q
 ;
