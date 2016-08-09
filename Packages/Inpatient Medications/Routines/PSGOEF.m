PSGOEF ;BIR/CML3 - FINISH ORDERS ENTERED THROUGH OE/RR ;14 May 98  2:17 PM
 ;;5.0;INPATIENT MEDICATIONS;**7,30,29,35,39,47,50,56,80,116,110,111,133,153,134,222,113,181,260,199,281**;16 DEC 97;Build 113
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^PSDRUG( is supported by DBIA 2192
 ; Reference to DOSE^PSSORPH is supported by DBIA 3234.
 ; Reference to ^TMP("PSODAOC",$J is supported by DBIA 6071.
 ; Reference to FULL^VALM1 is supported by DBIA 10116.
 ;
START ;
 I '$D(^PS(53.1,+PSGORD)) W $C(7),!?3,"Cannot find this pending order (#",+PSGORD,")." Q
 D NOW^%DTC S PSGDT=+$E(%,1,12) K PSGFDX,PSGEFN,PSGOEEF,PSGOES,PSGONF,PSGRDTX S PSGOES=1,(PSGOEF,PSGOEEF)=0,PSGOEEG=3
 I $D(PSJTUD) S PSGDO=$P($G(^PS(53.1,+PSGORD,.3)),U),(PSGPDRG,PSGPD)=PSJCOI,(PSGPDRGN,PSGPDN)=$$OINAME^PSJLMUTL(PSGPD)
 I $P($G(^PS(53.1,+PSGORD,0)),U,24)'="R" S X=PSGSCH D EN^PSGORS0 D
 . S:($D(X)&($P($G(^PS(53.1,+PSGORD,2)),"^",5)="")&($P($G(^PS(53.1,+PSGORD,0)),"^",24)="N")) PSGAT=PSGS0Y
 . NEW PSJDOX,PSJDOSE,PSJPIECE,PSJUNIT,PSJX,X
 . S X=$G(^PS(53.1,+PSGORD,1,1,0)) Q:'+X
 . D DOSE^PSSORPH(.PSJDOX,+X,"U")
 . I $S('$D(PSJDOX):1,1:+PSJDOX(1)=-1) Q
 . S PSJPIECE=$S($P(PSJDOX(1),U)="":3,1:1)
 . S X=^PS(53.1,+PSGORD,.2)
 . S:PSJPIECE=3 PSJDOSE=$P(X,U,2)
 . S:PSJPIECE=1 PSJDOSE=$P(X,U,5),PSJUNIT=$P(X,U,6)
 . F X=0:0 S X=$O(PSJDOX(X)) Q:+$G(PSJX)!'X  D
 .. I PSJPIECE=3,($P(PSJDOX(X),U,3)'=PSJDOSE) Q
 .. I PSJPIECE=1,($P(PSJDOX(X),U,1)_$P(PSJDOX(X),U,2)'=(PSJDOSE_PSJUNIT)) Q
 .. S:+$P(PSJDOX(X),U,12) $P(^PS(53.45,PSJSYSP,2,1,0),U,2)=+$P(PSJDOX(X),U,12),PSJX=1
 I PSGEB'=PSGOPR F X=7,11 S Y=$T(@(3_X)),@("PSGEFN("_X_")="_$P(Y,";",7)),PSGOEEF(+$P(Y,";",3))="",PSGOEEF=PSGOEEF+1
 D GTST^PSGOE6(+PSGORD)
 I $P($G(^PS(53.1,+PSGORD,0)),U,24)'="R" S PSGSD="" D:PSGS0Y]""
 .N PSJX S PSJX=$P($G(^PS(53.1,+PSGORD,0)),U,25) I PSJX="" Q
 .I PSJX["U" S PSGSD=$P($G(^PS(55,DFN,5,+PSJX,2)),U,2) Q
 .I PSJX["V" S PSGSD=$P($G(^PS(55,DFN,"IV",+PSJX,0)),U,2) Q
 .I PSJX["P" S PSGSD=$P($G(^PS(53.1,+PSJX,2)),U,2)
 S:PSGSD="" PSGSD=PSGLI
 S PSGNEDFD=$$GTNEDFD^PSGOE7("U",+PSGPD)
 S:$P($G(PSGNEDFD),U,3)="" $P(PSGNEDFD,U,3)=PSGST  ; N PSGOEA S PSGOEA="R"
 S (PSGNESD,PSGSD)=$$ENSD^PSGNE3(PSGSCH,PSGS0Y,PSGLI,PSGSD)
 ;if this is a renewal order, ignore any 'requested start date' received.  Use the system calculated start date.
 I $P($G(^PS(53.1,+PSGORD,0)),U,24)'="R" D
 . D REQDT^PSJLIVMD(PSGORD)
 E  D
 . S X=$$DSTART^PSJDCU(DFN,$P(^PS(53.1,+PSGORD,0),U,25)) I X]"" S (PSGNESD,PSGSD)=X K PSGRSD
 D   ; Extend the Default Stop Date if needed for the first renewed order.
 .N PSGOEAO,PSGWALLO
 .I $P($G(^PS(53.1,+PSGORD,0)),U,24)="R" S PSGOEAO=PSGOEA,PSGOEA="R",PSGWALLO=$P(^PS(55,DFN,5.1),U)
 .D ENFD^PSGNE3(PSGLI) S PSGFD=$S($G(PSGRDTX(+PSGORD,"PSGFD")):PSGRDTX(+PSGORD,"PSGFD"),1:PSGNEFD)
 .I $P($G(^PS(53.1,+PSGORD,0)),U,24)="R" S PSGOEA=PSGOEAO,$P(^PS(55,DFN,5.1),U)=PSGWALLO
 N DUR,PSGRNSD S PSGRNSD=+$$LASTREN^PSJLMPRI(DFN,PSGORD) I PSGRNSD S DUR=$$GETDUR^PSJLIVMD(DFN,PSGORD,"P",1) I DUR]"" D
 . N DURMIN S DURMIN=$$DURMIN^PSJLIVMD(DUR) I DURMIN S PSGFD=$$FMADD^XLFDT(PSGRNSD,,,DURMIN)
 S PSGOFD="",PSGSDN=$$ENDD^PSGMI(PSGSD)_U_$$ENDTC^PSGMI(PSGSD),PSGFDN=$$ENDD^PSGMI(PSGFD)_U_$$ENDTC^PSGMI(PSGFD)
 S PSGLIN=$$ENDD^PSGMI(PSGLI)_U_$$ENDTC^PSGMI(PSGLI)
 I '$O(^PS(53.45,PSJSYSP,2,0)) N DRG,DRGCNT S DRGCNT=0 D
 .F X=0:0 S X=$O(^PSDRUG("ASP",+PSGPD,X)) Q:'X!(DRGCNT>1)  S:$P($G(^PSDRUG(+X,2)),U,3)["U" DRGCNT=DRGCNT+1,DRG=+X
 .I DRGCNT=1 K ^PS(53.45,PSJSYSP,2) S ^PS(53.45,PSJSYSP,2,1,0)=DRG_U_1,^PS(53.45,PSJSYSP,2,0)="^53.4502^1^1",PS(53.45,PSJSYSP,2,"B",+DRG,1)=""
 Q
FINISH ;
 ; force display of second screen if CPRS order checks exist
 N NSFF,PSGOEF39,PSGEDTOI S NSFF=1 K PSJNSS,PSGEDTOI,PSGOEER,ZZND
 I $G(PSGORD),$D(PSGRDTX(+PSGORD)) D  K PSGRDTX
 . ;PSJOCDSC stores the default start & stop date ^ cal start & stop date (use in dosing calculation for duration)
 . ;for some reasons PSGSD & PSGFD are reset to the cal dates if order has duration defined
 . S PSJOCDSC("CX","PSGSD",+PSGORD)=$G(PSGSD)_U_$G(PSGRDTX(+PSGORD,"PSGRSD"))
 . S PSJOCDSC("CX","PSGFD",+PSGORD)=$G(PSGFD)_U_$G(PSGRDTX(+PSGORD,"PSGRFD"))
 . S:$G(PSGRDTX(+PSGORD,"PSGRSD")) PSGSD=PSGRDTX(+PSGORD,"PSGRSD")
 . S:$G(PSGRDTX(+PSGORD,"PSGRFD")) PSGFD=$S($G(PSGRDTX(+PSGORD,"PSGRFD")):PSGRDTX(+PSGORD,"PSGRFD"),1:$G(PSGNEFD))
 N PSJCOM S PSJCOM=+$P($G(^PS(53.1,+PSGORD,.2)),"^",8)
 ; 
 ; PSJ*5*222
 ; PSJCT1 is a counter variable.  Every piece of a complex order calls PSGOEF.
 ; The only time this code is to look for overlapping admin times is when the
 ; first part of a complex order is being finished.  This variable will keep track
 ; of how many "parts" of the complex order have been checked.
 ; 
 ; Also, since the user can select multiple complex orders to finish, like selecting
 ; orders 1-2 or 1-3 from the profile, PSJCT1A will keep track of whether the parent
 ; order number is the same as the first parent order number selected for finishing.
 ; Since the PSJCT1 counter variable will still be set if multiple complex orders
 ; are selected, PSJCT1 will be re-set to 1 if the parent complex order number (PSJCT1A) is
 ; not equal to the original parent order number (PSJCOM).
 ; 
 S PSJCT1=$G(PSJCT1)+1
 I PSJCT1=1 S PSJCT1A=PSJCOM
 I $G(PSJCT1A)'=PSJCOM S PSJCT1=1,PSJCT1A=PSJCOM
 ; End of flag setting for PSJ*5*222
 ;PRE UAT group requested to not show the second screen since FDB OC has more text and provider override reason appears after 2nd screen 
 ;I $O(^PS(53.1,+PSGORD,12,0))!$O(^PS(53.1,+PSGORD,10,0)) D
 ;.Q:$G(PSJLMX)=1  ; there's no second screen to display
 ;.S VALMBG=16 D RE^VALM4,PAUSE^VALM1
 D FULL^VALM1
 I '$D(IOINORM)!('$D(IOINHI)) S X="IORVOFF;IORVON;IOINHI;IOINORM" D ENDR^%ZISS
 I $G(PSJCOM)'="",$G(PSJCT1)=1 D
 . D OVERLAP^PSGOEF2 I $G(PSJOVRLP)=1 D
 . . N X,X1,DIR
 . . W !!,"**WARNING**"
 . . W !,"The highlighted admin times for these portions of this complex order overlap.",!!
 . . S (X,X1)="" F  S X=$O(^TMP("PSJATOVR",$J,X)) Q:X=""  D
 . . . S X1=$G(^TMP("PSJATOVR",$J,X))
 . . . W $S($P(X1,"^",4)=1:IORVON,1:""),"Part "_X,IORVOFF," has a schedule of "_$P(X1,"^",2)_" and admin time(s) of "
 . . . W $S($P(X1,"^",4)=1:IORVON,1:""),$P(X1,"^",3),IORVOFF
 . . . W !
 . . . W $S($G(PSJOVR("CONJ",X))="A":"AND",$G(PSJOVR("CONJ",X))="T":"THEN",1:""),!
 . . W !,"Please ensure the schedules and administration times are appropriate.",!
 . . S DIR(0)="EA",DIR("A")="Press Return to continue..." D ^DIR W !
 K ^TMP("PSJATOVR",$J)
 I $G(PSJPROT)=3,'$D(PSJTUD),'$$ENIVUD^PSGOEF1(PSGORD) Q
 I $G(PSGOSCH)]"" D  S:$G(PSGS0XT)'="" $P(^PS(53.1,+PSGORD,2),"^",6)=PSGS0XT
 .N PSGOES,PSGS0Y,PSGSCH S X=PSGOSCH K:$G(PSJTUD) NSFF D ENOS^PSGS0
 .I '($G(PSGORD)["P"&($P($G(^PS(53.1,+PSGORD,0)),"^",24)="R")) I $G(X)]""&$G(PSGS0Y) S:$G(PSGAT)="" PSGAT=PSGS0Y
 .I $G(PSJNSS) S PSGOSCH="" K PSJNSS
 .I $G(PSGORD)["P",$G(PSGAT),$G(PSGS0Y),($G(PSGOSCH)]"") I PSGAT'=PSGS0Y D
 ..S PSGNSTAT=1 W $C(7),!!,"PLEASE NOTE:  This order's admin times (",PSGAT,")"
 ..W !?13," do not match the ward times (",PSGS0Y,")"
 ..W !?13," for this administration schedule (",PSGOSCH,")",!
 ..S DIR(0)="EA",DIR("A")="Press Return to continue..." D ^DIR K DIR  W !
 I $G(PSGS0XT)="" S $P(^PS(53.1,+PSGORD,2),"^",6)=$S($P($G(ZZND),"^",3)'="":$P(ZZND,"^",3),1:"")
 S CHK=0 S:$P($G(^PS(53.1,+PSGORD,0)),U,24)'="R" PSGSI=$$ENPC^PSJUTL("U",+PSJSYSP,180,PSGSI)
 I '$G(PSJTUD),$G(PSJNSS),($G(PSGOSCH)]"") D NSSCONT^PSGS0(PSGOSCH,PSGS0XT) K PSJNSS S PSGOSCH=""
 S PSGOEFF=PSGOSCH=""+('$O(^PS(53.45,PSJSYSP,2,0))*10)
 I PSGOEFF S X=$S(PSGOEFF#2:" a SCHEDULE",1:"")_$S(PSGOEFF=11:" and",1:"")_$S(PSGOEFF>9:" at least one DISPENSE DRUG",1:"")
 I 'PSGOEFF I (($G(PSGS0XT)="D")&($G(PSGAT)="")) S X=" Admin Times",PSGOEFF=1,PSGOEF39=1
 I PSGOEFF,X]"" S X=X_" before it can be finished."
 I PSGOEFF S CHK=1 W $C(7),!!,"PLEASE NOTE: This order must have" F Q=1:1:$L(X," ") S Y=$P(X," ",Q) W:$L(Y)+$X>78 ! W Y," "
 I $G(PSGOEF39) S PSGOEE=0,PSGOEFF=0 D  I 'PSGOEE D REFRESH^VALM G DONE
 .S F1=53.1,MSG=0,Y=$T(39),@("PSGFN(39)="_$P(Y,";",7)),PSGOEEF(+$P(Y,";",3))=1,(PSGOEEF,PSGOEE)=1 W ! D @$P($T(39),";",3) S CHK=0
 I PSGOEFF=1 S F1=53.1,MSG=0,Y=$T(38),@("PSGFN(38)="_$P(Y,";",7)),PSGOEEF(+$P(Y,";",3))=1,(PSGOEE,PSGOEEF)=1 W ! D @$P($T(38),";",3) S CHK=0 G:'PSGOEE DONE
 I PSGOEFF=11 S F1=53.1,MSG=0,Y=$T(32),@("PSGFN(32)="_$P(Y,";",7)),PSGOEEF(+$P(Y,";",3))=1,(PSGOEE,PSGOEEF)=1 W ! D @$P($T(32),";",3) D  G:'PSGOEE DONE
 .S F1=53.1,MSG=0,Y=$T(38),@("PSGFN(38)="_$P(Y,";",7)),PSGOEEF(+$P(Y,";",3))=1,(PSGOEE,PSGOEEF)=1 W ! D @$P($T(38),";",3) S CHK=0
 I PSGOEFF>9 S CHK=7 D ENDRG^PSGOEF1(+PSGPD,0) I CHK D ABORTACC Q
 I 'PSGOEFF D OC531^PSGOESF ; check every dispense drug from CPRS
 S VALMBG=1
 I 'PSGOEFF&($D(PSGORQF)) D RE^VALM4 Q
 I $G(MSG) K DIR S DIR(0)="E" W !! D ^DIR
 I PSGOEFF D:PSGST="" GTST^PSGOE6(+PSGORD)
 S PSJLMFIN=1
 K PSJACEPT I $O(^PS(53.1,+PSGORD,12,0)) S PSJLMP2=1
 S PSGOEENO=0,PSGSTAT=$S($P(PSJSYSP0,U,9):"ACTIVE",1:"NON-VERIFIED")
 NEW PSJDOSE,PSJDOX,PSJDSFLG
 D DOSECHK^PSJDOSE
 S:+$G(PSJDSFLG) VALMSG="Dosage Ordered & Dispense Drug are not compatible"
 I PSGODO=PSGDO S PSGOEEF(109)=""
 I PSGODO'=PSGDO S PSGOEENO=1,VALMSG="This change will cause a new order to be created  "
 D EN^VALM("PSJU LM ACCEPT")
 I $G(PSJNSS) D  S PSGOEEF(26)="" K PSJACEPT,PSJNSS
 .K DIR S DIR(0)="FOA",DIR("A")="Invalid Schedule" D ^DIR K DIR
 I $G(PSGS0XT)="D",'$G(PSGS0Y),'$G(PSGAT),((",P,R,")'[(","_$G(PSGST)_",")) D  S PSGOEEF(39)="" K PSJACEPT
 .K DIR S DIR(0)="FOA",DIR("A")="   WARNING - Admin times are required for DAY OF WEEK schedules  " D ^DIR K DIR
 ;***PSJ*5*113
 I $G(PSGAT)="",(PSGST="C"!(PSGST="R")) D
 .I $G(PSGS0XT) Q:$$ODD^PSGS0(PSGS0XT)
 .Q:$$PRNOK^PSGS0($G(PSGSCH))
 .Q:($P($G(ZZND),"^",5)'="C")
 .K PSJACEPT
 .K DIR S DIR(0)="FOA",DIR("A")="  WARNING - Admin times are required for CONTINUOUS orders " D ^DIR K DIR
 ;***
 I '$G(PSJACEPT) D ABORTACC Q
 I $G(PSJRNF),$G(^PS(53.1,+PSGORD,4)) D
 . W $C(7),!!,"ACCEPTING THIS ORDER WILL CHANGE THE STATUS TO ACTIVE."
 . S DIR(0)="Y",DIR("A")="Do you wish to make this order Active",DIR("?",1)="Enter ""N"" if you wish to exit without Activating this order,"
 . S DIR("?")="or ""Y"" to continue with the Activation process." D ^DIR S:'Y Y=-1 K DIR
 I $G(PSJRNF),$G(Y)=-1 S PSJACEPT=0 D ABORTACC Q
 I $G(PSJRNF),$G(Y)=1 S PSGOEAV=1
 I $G(PSGEDTOI) D OC^PSJOE1
 I $S($G(PSGORQF):0,$G(PSGEDTOI):0,$G(PSGOEER)["109^PSGOE8":1,$G(PSGOEER)["3^PSGOE8":1,$G(PSGOEER)["26^PSGOE8":1,$G(PSGOEER)["10^PSGOE81":1,$G(PSGOEER)["25^PSGOE81":1,1:0) D
 . NEW PSJDD S PSJDD=+$$DD53P45^PSJMISC()
 . D:$G(PSJDD) IN^PSJOCDS($G(PSGORD),"UD",PSJDD)
 I $G(PSGORQF) S PSGOEENO=0,PSJACEPT=0
 I PSGOEENO S PSJNOO=$$ENNOO^PSJUTL5("E"),PSJACEPT=$S(PSJNOO<0:0,1:1)
ACCEPT ;
 N PSGUDFIN S PSGUDFIN=1
 S VALMBCK=$S($G(PSJACEPT):"Q",1:"R")
 I '$G(PSJACEPT) D ABORTACC Q
 K PSGOES,PSGRSD,PSGRSDN D:PSGOEENO NEW3^PSGOEE D:'PSGOEENO UPD^PSGOEF1 I $D(PSGOEF)!PSGOEENO S PSGCANFL=-1
 ;saves drug allergy signs/symptoms PSJ*5*260
 I $D(^TMP("PSODAOC",$J,"ALLERGY")) D
 .N DA,OCCDT,ORN,ORL,Z,RET,PSJDAOC
 .S PSJDAOC="IP "_$S($G(PSGORD)["P":"Pending/Non-Verified",$G(PSGORD)["U":"Unit Dose",$G(PSGORD)["V":"IV",1:"")_" Allergy",OCCDT=$$NOW^XLFDT
 .I PSGORD["P" S ORN=$P(^PS(53.1,+PSGORD,0),U,21)
 .I PSGORD["U" S ORN=$P(^PS(55,DFN,5,+PSGORD,0),U,21)
 .I PSGORD["V" S ORN=$P(^PS(55,DFN,"IV",+PSGORD,0),U,21)
 .Q:'$G(ORN)
 . S PSJAGYSV=1 ;use in ^PSJOE to store allergy (also clean up this var)
 .;D SETOC^PSJNEWOC(PSGORD) ;set order checks in 100.05
 .;K ^TMP("PSODAOC",$J),^TMP("PSJDAOC",$J)
 D DONE1^PSGOEE
 D DONE
 Q
BYPASS ;
 S PSGCANFL=1
 ;
DONE ;
 K CHK,DA,DIE,DR,DRG,MSG,Q1,Q2,PSGNSTAT,PSGEDTOI,PSGOEER,ZZND
 K PSJOVR
 Q
ABORTACC ; Abort Accept process.
 K PSJCT1,PSJOVR,PSJOVRLP,PSJCT1A K ^TMP("PSODAOC",$J)
 D ABORT^PSGOEE K PSGOEEF D GETUD^PSJLMGUD(PSGP,PSGORD),^PSGOEF,ENSFE^PSGOEE0(PSGP,PSGORD),INIT^PSJLMUDE(PSGP,PSGORD) S VALMBCK="R",PSGSD=PSGNESD,PSGFD=PSGNEFD Q
 ;
 ;
31 ;;101^PSGOE8;PSGOPD;PSGPD;101;1
32 ;;109^PSGOE8;PSGODO;PSGDO;109;PSGODO]""
33 ;;10^PSGOE81;PSGOSD;PSGSD;10;0
34 ;;3^PSGOE8;PSGOMR;PSGMR;3;1
35 ;;25^PSGOE81;PSGOFD;PSGFD;25;0
36 ;;7^PSGOE8;PSGOST;PSGST;7;0
37 ;;5^PSGOE82;PSGOSM;PSGSM;5;0
38 ;;26^PSGOE8;PSGOSCH;PSGSCH;26;1      
39 ;;39^PSGOE81;PSGOAT;PSGAT;39;0
310 ;;1^PSGOE82;PSGOPR;PSGPR;1;1
311 ;;8^PSGOE81;PSGOSI;PSGSI;8;0
312 ;;2^PSGOE82;;;2;0
313 ;;40^PSGOE82;;;40;0
 ;
AH ;
 W !!?2,"Answer 'YES' to accept this order as a NON-VERIFIED UNIT DOSE order.  Answer",!,"'NO' to edit this order now.  Enter '^' to BYPASS this order, leaving it as",!,"a PENDING INPATIENT order."
 Q
