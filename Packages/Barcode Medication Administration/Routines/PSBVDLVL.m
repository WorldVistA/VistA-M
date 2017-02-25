PSBVDLVL ;BIRMINGHAM/EFC-BCMA VIRTUAL DUE LIST FUNCTIONS ;03/06/16 3:06pm
 ;;3.0;BAR CODE MED ADMIN;**6,3,12,11,13,32,25,61,70,83**;Mar 2004;Build 89
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ;
 ; Reference/IA
 ; $$GET^XPAR/2263
 ; 
 ;*70 - Clinic Orders will use an Admin Early/Late calc of any day
 ;      before or After TODAY instead of minutes as in IM meds.
 ;*83 - Add ability to do Remove Early/Late tests on Sched Remove time
 ;     -add a 10 param, sched remove time
 ;     -add check for meds not removed for other orders (by OI)
 ;
EN(RESULTS,DFN,PSBXOR,PSBTYPE,PSBADMIN,PSBTAB,PSBUID,PSBASTS,PSBORSTS,PSBRMV,PSBRMT) ;
 ;
 ; RPC: PSB VALIDATE ORDER
 ;
 ; Description: Final check of order against an actual administration
 ;              date/time used immediately after scanned med has been
 ;              validated to be a good un-administered order.
 ;
 K PSBTST
 N PSBFLAG,FOUND,LSTACTN,PSBLSTGV,PSBLADT,PSBLAIEN,X,CLORD        ;*83
 I PSBRMV="I" D GETOHIST^PSBRPC2(.PSBTST,DFN,PSBXOR_PSBTYPE) S I=0 F  S I=$O(PSBTST(I)) Q:I=""  I $P(PSBTST(I),U,5)="I" S RESULTS(0)=1,RESULTS(1)="-2^" K PSBTST Q
 K PSBOKAY D CLEAN^PSBVT,PSJ1^PSBVT(DFN,PSBXOR_PSBTYPE) S PSB=0
 S CLORD=$S($G(PSBCLORD)]"":1,1:0)       ;if a Clinc ord, 1 else 0 *83
 S RESULTS(0)=1,RESULTS(1)="-1^***Unable to determine administration" ; Default Flag will be overwritten by anything
 D NOW^%DTC
 I ((PSBOSTS="A")!(PSBOSTS="R"))&(PSBOSP<%) S PSBOSTS="E"
 I PSBORSTS'=PSBOSTS,((PSBSCHT'="O")&(PSBOSTS'="E")) S PSB=PSB+1,RESULTS(0)=PSB,RESULTS(PSB)="-2^ORDER STATUS MISMATCH" Q
 ;
 ;patch/MRR removal does not follow The Rest of validation rules
 ;  special tests for RM added  *83
 I ((PSBTAB="UDTAB")!(PSBTAB="PBTAB")),((PSBRMV="RM")!(PSBRMV="N")) D  Q
 .D:PSBRMV="N"
 ..S PSB=PSB+1,RESULTS(0)=PSB
 ..S RESULTS(PSB)="0^Okay to Undo"
 .I PSBASTS="" Q  ;status is not given - don't check for mismatch
 .;check for admin status mismatch
 .I $D(^PSB(53.79,"AORD",DFN,PSBXOR_PSBTYPE,+PSBADMIN)) S X=$O(^PSB(53.79,"AORD",DFN,PSBXOR_PSBTYPE,+PSBADMIN,"")) I $P($G(^PSB(53.79,+X,0)),U,9)'=PSBASTS D  Q    ;Quit if -2 err, dont fall thru to RM logic
 ..S PSB=PSB+1,RESULTS(0)=PSB,RESULTS(PSB)="-2^Admin status mismatch"
 .;
 .;  RM logic quits after it runs and does not fall thru
 .;IM order Remove, Do variance check   *83
 .I PSBRMV="RM",'CLORD D  Q
 ..S PSBOKAY=$$VARIANCE(PSBRMV,PSBRMT)
 ..S PSB=PSB+1,RESULTS(0)=PSB,RESULTS(PSB)=PSBOKAY
 .;
 .;CO order Remove, No variance check   *83
 .I PSBRMV="RM",CLORD D  Q
 ..S RESULTS(0)=1,RESULTS(1)="0^Okay to Remove"
 ;
 ;    The Rest of the validation rules
 I PSBTYPE="V",PSBSCHT'="P",((PSBUID="")!(PSBUID["WS")) S RESULTS(0)=1,RESULTS(1)="0^Okay to administer" Q:PSBTAB="IVTAB"
 I PSBTYPE="V",PSBUID'="" D  Q:PSBTAB="IVTAB"  ; validate IV bags Piggybacks have additional tests
 .S PSB=0,PSBSUID=PSBUID D EN^PSBPOIV(DFN,PSBXOR_PSBTYPE)
 .S X="" F  S X=$O(^TMP("PSBAR",$J,X)) Q:X=""  D
 ..I PSBSUID'=X Q
 ..S PSBUIDS=^TMP("PSBAR",$J,X)
 ..I $P(PSBUIDS,U,2)="I"!($P(PSBUIDS,U,2)="S") S PSB=PSB+1,RESULTS(0)=PSB,RESULTS(PSB)="0^Okay to administer" Q  ; is infusing or stopped
 ..I $P(PSBUIDS,U,1)="I" S Y=$P(^TMP("PSBAR",$J,"I"),U,2) D DD^%DT S PSB=PSB+1,RESULTS(0)=PSB,RESULTS(PSB)=$P(^TMP("PSBAR",$J,"I"),U,3,99)_"  "_Y Q
 ..I $P(PSBUIDS,U,1)["W" S PSBWS=$P(PSBUIDS,U,1) F PSBWM=2:1 Q:$P(PSBWS,";",PSBWM)=""  D
 ...S Y=$P(^TMP("PSBAR",$J,"W",$P(PSBWS,";",PSBWM)),U,2) D DD^%DT S PSB=PSB+1,RESULTS(0)=PSB,RESULTS(PSB)=$P(^TMP("PSBAR",$J,"W",$P(PSBWS,";",PSBWM)),U,3,99)_" "_Y
 ..S PSB=PSB+1,RESULTS(0)=PSB,RESULTS(PSB)="0^Okay to administer"
 .K ^TMP("PSBAR",$J)
 ;
 ; no IV orders
 ;
 D NOW^%DTC
 I PSBOSTS="H" S PSB=PSB+1,RESULTS(0)=PSB,RESULTS(PSB)="0^Order is on Provider Hold" Q
 ;
 ;test for non-one time orders   admin prior to start date of order
 ;
 ;CO orders, check if start order date is > today
 I CLORD,PSBSCHT'="O"&($P(PSBOST,".")>DT) S PSB=PSB+1,RESULTS(0)=PSB,RESULTS(PSB)="-1^Order Not Active" Q         ;CO > today *83
 ;IM orders, check start order date/time > Now
 I 'CLORD,PSBSCHT'="O"&(%<($$FMADD^XLFDT(PSBOST,"","",$$GET^XPAR("ALL","PSB ADMIN BEFORE")*-1))) S PSB=PSB+1,RESULTS(0)=PSB,RESULTS(PSB)="-1^Order Not Active" Q         ;IM > now  *83
 ;All orders, check stop order date/time > Now
 I (%>PSBOSP) S PSB=PSB+1,RESULTS(0)=PSB,RESULTS(PSB)="-1^Order Not Active, expired" Q
 ;
 ;tests sched types of continuous or prns that are MRRs
 I (PSBSCHT="C")!((PSBSCHT="P")&(PSBMRRFL>0)) D
 .S PSBOKAY="0^Okay to administer"
 .I PSBASTS["*UNKNOWN*" S PSBOKAY="-1^This administration has *UNKNOWN* status" Q
 .I PSBOSTS'="A",PSBOSTS'="R",PSBOSTS'="O" S PSBOKAY="-1^Order Not Active" Q
 .I PSBNGF S PSBOKAY="-1^marked DO NOT GIVE" Q
 .;set special action flag
 .S PSBFLAG=0 I PSBRMV="M"!(PSBRMV="H")!(PSBRMV="R") S PSBFLAG=1
 .;
 .;*** Check for errors vs. last valid completed action this order.
 .;        completed = Given or Removed, end of a UD admin life cycle
 .I $D(^PSB(53.79,"AORDX",DFN,PSBXOR_PSBTYPE)) D  Q:X
 ..S X=0,LSTACTN="",PSBLAIEN=0
 ..S PSBLADT="",FOUND=0
 ..F  S PSBLADT=$O(^PSB(53.79,"AORDX",DFN,PSBXOR_PSBTYPE,PSBLADT),-1) Q:'PSBLADT  D  Q:FOUND
 ...S PSBLAIEN=$O(^PSB(53.79,"AORDX",DFN,PSBXOR_PSBTYPE,PSBLADT,""),-1)
 ...S LSTACTN=$P($G(^PSB(53.79,PSBLAIEN,0)),U,9)
 ...I (LSTACTN="G")!(LSTACTN="RM") S FOUND=1    ;found a previous G/RM
 ..Q:'FOUND     ;quit, no last valid completed type last action found
 ..;
 ..;MRR - Previous Admin NOT REMOVED tests
 ..I LSTACTN="G",PSBFLAG=0 D
 ...I $P($G(^PSB(53.79,PSBLAIEN,.5,1,0)),U,4)="PATCH" D NOTREMVD
 ...I 'X,$P($G(^PSB(53.79,PSBLAIEN,.5,1,0)),U,6)>0 D NOTREMVD
 ..;
 ..;if trying to Give an earlier dose after a later admin Given   *83
 ..S PSBLSTGV=$P(^PSB(53.79,PSBLAIEN,.1),U,3)
 ..I PSBADMIN<PSBLSTGV,PSBFLAG=0 D
 ...S X=1
 ...S PSBOKAY="-1^A later dose scheduled at ("_$$FMTE^XLFDT(PSBLSTGV,2)_") was given "_($$FMDIFF^XLFDT($$NOW^XLFDT,$P(^PSB(53.79,PSBLAIEN,0),U,6),2)\60)_" minutes ago."
 .;****
 .;
 .I $D(^PSB(53.79,"AORD",DFN,PSBXOR_PSBTYPE,+PSBADMIN)) D  Q:+PSBOKAY<0
 ..S X=$O(^PSB(53.79,"AORD",DFN,PSBXOR_PSBTYPE,+PSBADMIN,""))
 ..L +^PSB(53.79,+X):1
 ..I  L -^PSB(53.79,+X)
 ..E  S PSBOKAY="-1^The "_$$GET1^DIQ(53.79,+X_",",.13)_" administration is being edited by another" Q
 ..I $G(PSBASTS)]"" D  Q:+PSBOKAY<0
 ...I $P($G(^PSB(53.79,+X,0)),U,9)="" Q
 ...I $P($G(^PSB(53.79,+X,0)),U,9)'=PSBASTS S PSBOKAY="-2^Admin status mismatch" Q
 .;*70 perform early/late admin testing for IM & CO orders
 .;
 .;*83 call tag for non-removal actions - IM orders only
 .I 'CLORD,PSBRMV'="RM",'PSBFLAG S PSBOKAY=$$VARIANCE(PSBRMV,PSBADMIN)
 .;
 .D:CLORD          ;CO order new logic 
 ..N ADMINDT S ADMINDT=$P(PSBADMIN,".")
 ..S PSBOKAY="1^You are about to give a medication that "
 ..I ADMINDT>DT D  Q
 ...S PSBOKAY=PSBOKAY_"is scheduled for "_$$DOW^XLFDT(ADMINDT)_", "_$$FMTE^XLFDT(ADMINDT,5)_"."
 ..I ADMINDT<DT D  Q
 ...S PSBOKAY=PSBOKAY_"was scheduled for "_$$DOW^XLFDT(ADMINDT)_", "_$$FMTE^XLFDT(ADMINDT,5)_"."
 ..S PSBOKAY="0^Okay to administer"
 .;*70 end early/late logic
 ;
 ; Validate a PRN Order
 D:(PSBSCHT="P")
 .I PSBOSTS'="A",PSBOSTS'="R",PSBOSTS'="O" S PSBOKAY="-1^Order Not Active" Q
 .I PSBNGF S PSBOKAY="-1^marked DO NOT GIVE" Q
 .I (+($G(PSBOKAY))<0)&(PSBDOSEF="PATCH") Q  ;A Patch may have to be removed.
 .I (+($G(PSBOKAY))<0)&(PSBMRRFL>0) Q        ;MRR may need removal *83
 .S PSBOKAY="1^"
 .; Get Last Four Givens
 .S PSBDT=""
 .F  S PSBDT=$O(^PSB(53.79,"AOIP",DFN,+PSBOIT,PSBDT),-1) Q:PSBDT=""  D
 ..S PSBDA=""
 ..F  S PSBDA=$O(^PSB(53.79,"AOIP",DFN,+PSBOIT,PSBDT,PSBDA),-1) Q:'PSBDA  D
 ...S (PSBCNT1,PSBCNT2,PSBCNT3)=0
 ...S PSBLADT=$$GET1^DIQ(53.79,PSBDA_",",.06,"I")
 ...S PSBSTUS=$$GET1^DIQ(53.79,PSBDA_",",.09)
 ...S:PSBSTUS="" PSBSTUS="U"
 ...S PSBSCH=$$GET1^DIQ(53.79,PSBDA_",",.12)
 ...S PSBRSN=$$GET1^DIQ(53.79,PSBDA_",",.21)
 ...S PSBINJ=$$GET1^DIQ(53.79,PSBDA_",",.16)
 ...Q:$P(^PSB(53.79,PSBDA,0),U,9)="N"
 ...F PSBZ=.5,.6,.7 F PSBY=0:0 S PSBY=$O(^PSB(53.79,PSBDA,PSBZ,PSBY)) Q:'PSBY  D
 ....Q:'$D(^PSB(53.79,PSBDA,PSBZ,PSBY))
 ....S PSBDD=$S(PSBZ=.5:53.795,PSBZ=.6:53.796,1:53.797)
 ....S PSBUNIT=$$GET1^DIQ(PSBDD,PSBY_","_PSBDA_",",.03) S:PSBUNIT>0&(PSBUNIT<1) PSBUNIT="0"_+PSBUNIT ;Add leading 0 for decimal values less than 1, PSB*3*61
 ....S PSBUNFR=$$GET1^DIQ(PSBDD,PSBY_","_PSBDA_",",.04)
 ....I PSBZ=.5 S PSBCNT1=PSBCNT1+1
 ....I PSBZ=.6 S PSBCNT2=PSBCNT2+1
 ....I PSBZ=.7 S PSBCNT3=PSBCNT3+1
 ...;Units given or free text not to display for multiple dispense drugs or additives and solution
 ...I (PSBCNT1>1)!(PSBCNT2>0)!(PSBCNT3>0) S (PSBUNIT,PSBUNFR)=""
 ...S X=PSBLADT_U
 ...S X=X_PSBSTUS_U_PSBSCH_U_$G(PSBRSN)_U_$G(PSBINJ)_U_$G(PSBUNIT)_U_$G(PSBUNFR)
 ...S PSBOKAY($O(PSBOKAY(""),-1)+1)=3_U_X
 ...S:$D(PSBOKAY(4)) PSBDT=0
 .S X1=$$LASTG^PSBCSUTL(DFN,+PSBOIT) I X1>0 S PSBOKAY($O(PSBOKAY(""),-1)+1)=4_U_X1
 ;
 ; Validate a One-Time Order
 D:PSBSCHT="O"
 .S (PSBGVN,X,Y)=""
 .F  S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X),-1)  Q:'X  F  S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X,Y),-1) Q:'Y  I $P(^PSB(53.79,Y,.1),U)=PSBONX,"G"[$P(^PSB(53.79,Y,0),U,9) S PSBGVN=1,(X,Y)=0
 .I PSBGVN S PSBOKAY="-1^Dose Already on medication Log" Q
 .; One Time are automatically expired so we don't check STATUS here
 .I PSBNGF S PSBOKAY="-1^marked DO NOT GIVE" Q
 .S PSBOKAY="0^Okay to administer"
 ;
 ; Validate an On Call Order
 D:PSBSCHT="OC"
 .S PSBOKAY="0^Okay to administer"
 .S (PSBGVN,X,Y)=""
 .F  S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X),-1)  Q:'X  F  S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X,Y),-1) Q:'Y  I $P(^PSB(53.79,Y,.1),U)=PSBONX,"G"[$P(^PSB(53.79,Y,0),U,9) S PSBGVN=1,(X,Y)=0
 .I PSBGVN&('$$GET^XPAR("DIV","PSB ADMIN MULTIPLE ONCALL")) S PSBOKAY="-1^Dose Already on medication Log" Q
 .I PSBOSTS'="A",PSBOSTS'="R",PSBOSTS'="O" S PSBOKAY="-1^Order Not Active" Q
 .I PSBNGF S PSBOKAY="-1^marked DO NOT GIVE" Q
 .S X=0
 .I PSBGVN,$$GET^XPAR("DIV","PSB ADMIN MULTIPLE ONCALL") D  Q:X
 ..I PSBDOSEF="PATCH" D NOTREMVD Q                                ;*83
 ..I PSBMRRFL>0 D NOTREMVD Q                                      ;*83
 .S PSBOKAY="0^Okay to administer"
 ;
 D:+PSBOKAY'<0
 .N PSBDIFF,Y
 .D:(PSBSCHT="C")!(PSBSCHT="OC"&('$G(PSBGVN)))
 ..; On-call or cont and not on the log.
 ..S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,""),-1)
 ..;Check for the status of the medication and insert status into text
 ..I Y]"" S X=$O(^PSB(53.79,"AOIP",DFN,+PSBOIT,Y,""),-1),PSBSTUS=$P(^PSB(53.79,X,0),U,9)
 ..S:Y']"" PSBSTUS=""
 ..I PSBSTUS="N" D  Q:$G(PSBQUIT)
 ...S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,Y,X),-1)
 ...D:X']""
 ....S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,Y),-1) I Y']"" S PSBQUIT=1 Q
 ....S X=$O(^PSB(53.79,"AOIP",DFN,+PSBOIT,Y,""),-1),PSBSTUS=$P(^PSB(53.79,X,0),U,9)
 ..S PSBDIFF=$$FMDIFF^XLFDT($$NOW^XLFDT(),Y,2)
 ..Q:PSBDIFF>7200  ; Greater than 2 hours
 ..;remove "RM" sts previous action test for this warning          *83
 ..I (PSBSTUS="G")!(PSBSTUS="H")!(PSBSTUS="R") D
 ...S PSBSTUS=$$GET1^DIQ(53.79,X_",",.09)
 ...I PSBSTUS'="" D
 ....S Y="1^*** NOTICE, "_PSBOITX_" was "_PSBSTUS_" "_(PSBDIFF\60)_" minutes ago."
 ....I +PSBOKAY=1 S PSBOKAY(1)=Y
 ....E  S PSBOKAY=Y
 .;
 .;check for same OI medication MRR not removed, warning           *83
 .N LST
 .I PSBMRRFL,$$OIREMVD(DFN,PSBOIT,.LST) D
 ..;find last ien in psbokay, so won't overwrite with new OI msgs  *83
 ..N Q S Q=$O(PSBOKAY(""),-1)
 ..F X=0:0 S X=$O(LST(X)) Q:'X  D
 ...S PSBOKAY(Q+X)="1^Medication "_$P(LST(X),U,2)_" for scheduled administration "_$P(LST(X),U)_" has NOT been removed. "
 ;
 ;adds fall thru err msg text to Results
 S PSB=PSB+1,RESULTS(PSB)=PSBOKAY
 ;
 ;overwrite 0^okay text with 1^warning text IF array PSBOKAY populated
 I RESULTS(1)["0^Okay",$D(PSBOKAY)>9 S PSB=0
 F X=0:0 S X=$O(PSBOKAY(X)) Q:'X  D
 .S PSB=PSB+1,RESULTS(PSB)=PSBOKAY(X)
 ;
 S RESULTS(0)=$O(RESULTS(999),-1)      ;set to always agree to content
 Q
 ;
NOTREMVD ;Standard "Not Removed" MRR error msg & special pre-warning test *83
 S PSBOKAY=""
 I PSBRMV'="RM" S PSBOKAY=$$VARIANCE(PSBRMV,PSBADMIN)
 ;check special case of Early Admin - move Early error msg to Results
 ;array so PSBOKAY can be reused for later dual -1 errmsg: early admin
 ;
 I PSBOKAY["Admin",PSBOKAY["before" D
 .S PSB=PSB+1,RESULTS(PSB)=PSBOKAY,RESULTS(0)=PSB
 S X=1
 S PSBOKAY="-1^Cannot Give medication until previous administration has been removed."
 Q
 ;
VARIANCE(ACTION,DATETM) ;check for variance to exceed Early/Late window    *83
 N MSG
 S PSBWIN1=$$GET^XPAR("DIV","PSB ADMIN BEFORE")*-1    ;Minutes before
 S PSBWIN2=$$GET^XPAR("DIV","PSB ADMIN AFTER")        ;Minutes After
 D NOW^%DTC
 S PSBMIN=$S($P(DATETM,".",2):$$DIFF^PSBUTL(DATETM,%),1:0)
 ;
 D:ACTION'="RM"   ;Not a Removal
 .I PSBMIN<PSBWIN1 S MSG="1^Admin is "_(PSBMIN*-1)_" minutes before the scheduled administration time" Q
 .I PSBMIN>PSBWIN2 S MSG="1^Admin is "_(PSBMIN)_" minutes after the scheduled administration time" Q
 .S MSG="0^Okay to "_$S(ACTION="H":"Hold",ACTION="R":"Refuse",1:"administer")
 ;
 D:ACTION="RM"    ;Removal: use a new code #5 for RED txt (Early RM)
 .S MSG="0^Okay to Remove"
 .I PSBMIN<PSBWIN1 S MSG="5^Removal is "_(PSBMIN*-1)_" minutes before the scheduled removal time" Q
 .I PSBMIN>PSBWIN2 S MSG="1^Removal is "_(PSBMIN)_" minutes after the scheduled removal time" Q
 ;
 Q MSG
 ;
OIREMVD(DFN,OI,REM) ;Is another OI MRR not removed?
 ; Input:
 ;    DFN = patient ien
 ;     OI = Ordreable Item Ien
 ;Output:
 ;    Function - false/true
 ;    parm- REM(ien), IEN of file 53.79 array of meds needing Removal
 ;           formatted: Sched Admin date/time ^ Disp drug name ^Ordno
 ;    if One time sched, then set Sched Admin = actual given date/time
 ;
 ;check for previous MRR type 1 med not removed                  *83
 N CNT,PSBBK,DTE,IEN,QQ,MEDNM,ORDNO,SCHADM
 S PSBBK=$$GET^XPAR("DIV","PSB VDL PATCH DAYS")
 S PSBBK=$$FMADD^XLFDT(DT,-$S(PSBBK>0:PSBBK,1:30))
 S DTE="",CNT=0
 F  S DTE=$O(^PSB(53.79,"AOIP",DFN,OI,DTE),-1) Q:('DTE)!((DTE\1)<PSBBK)  D
 .S IEN=""
 .F  S IEN=$O(^PSB(53.79,"AOIP",DFN,OI,DTE,IEN),-1) Q:'IEN  D
 ..Q:$P($G(^PSB(53.79,IEN,0)),U,9)'="G"
 ..S CNT=CNT+1
 ..S SCHADM=$$GET1^DIQ(53.79,+IEN,"SCHEDULED ADMINISTRATION TIME")
 ..S:'SCHADM SCHADM=$E($$GET1^DIQ(53.79,+IEN,"ACTION DATE/TIME"),1,18)
 ..S QQ=$O(^PSB(53.79,IEN,.5,0))
 ..S:QQ MEDNM=$$GET1^DIQ(53.795,QQ_","_IEN,"DISPENSE DRUG")
 ..S ORDNO=$$GET1^DIQ(53.79,+IEN,"ORDER REFERENCE NUMBER")
 ..S REM(CNT)=SCHADM_U_MEDNM_U_ORDNO
 Q $D(REM)
