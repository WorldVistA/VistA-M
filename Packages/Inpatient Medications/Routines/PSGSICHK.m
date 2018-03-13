PSGSICHK ;BIR/CML3-CHECKS SPECIAL INSTRUCTIONS ;17 Aug 98 / 8:33 AM
 ;;5.0;INPATIENT MEDICATIONS ;**3,9,26,29,44,49,59,110,139,146,160,175,201,185,181,256,347**;16 DEC 97;Build 6
 ;
 ; Reference to ^PS(50.605 is supported by DBIA 696.
 ; Reference to EN^PSOORDRG is supported by DBIA 2190.
 ; Reference to ^PSI(58.1 is supported by DBIA 2284.
 ; Reference to ^PSDRUG( is supported by DBIA 2192.
 ; Reference to ^PSD(58.8 is supported by DBIA 2283.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(51 is supported by DBIA 2176.
 ; Reference to ^ORRDI1 is supported by DBIA 4659.
 ; Reference to ^XTMP("ORRDI" is supported by DBIA 4660.
 ; Reference to ^PSSDSAPI is supported by DBIA 5425.
 ;
START ;
 I $S(X'?.ANP:1,X["^":1,1:$L(X)>180) K X Q
 S Y="" F Y(1)=1:1:$L(X," ") S Y(2)=$P(X," ",Y(1)) I Y(2)]"" D CHK Q:'$D(X)
 I $D(X),Y]"",X'=$E(Y,1,$L(Y)-1) D EN^DDIOL("EXPANDS TO: ") W Y F Y(1)=1:1 S Y(2)=$P(Y," ",Y(1)) Q:Y(2)=""  D:$L(Y(2))+$X>78 EN^DDIOL(Y(2)_" ")
 Q
 ;
CHK ;
 I $L(Y(2))<31,$D(^PS(51,+$O(^PS(51,"B",Y(2),0)),0)),$P(^(0),"^",2)]"",$P(^(0),"^",4) S Y(2)=$P(^(0),"^",2)
 I $L(Y)+$L(Y(2))>180 K X Q
 S Y=Y_Y(2)_" " Q
 ;
ENSET(X) ; expands the SPECIAL INSTRUCTIONS field contained in X into Y
 N X1,X2,Y S Y=""
 ;BHW;PSJ*5*185;Modified Logic below to NOT strip spaces and allow existing logic to flow.
 ;             ;Removed code I X2]"" Before Set of Y and created argumentless DO structure.
 F X1=1:1:$L(X," ") S X2=$P(X," ",X1) D
 . I X2']"" S Y=Y_" " Q  ;if multiple spaces in text and were $P'ing through text, X2 will="" so just add space and continue
 . S Y=Y_$S($L(X2)>30:X2,'$D(^PS(51,+$O(^PS(51,"B",X2,0)),0)):X2,$P(^(0),"^",2)]""&$P(^(0),"^",4):$P(^(0),"^",2),1:X2)_" "
 . Q
 ;BHW;Modified stripping of spaces at end of string
 F X1=$L(Y):-1:0 Q:$E(Y,X1,X1)'=" "  S Y=$E(Y,1,X1-1)
 Q Y
 ;
END ; used by DRUG (55.06,101 & 53.1,101) x-refs to warn user if patient is receiving or about to receive the drug just ordered
 Q:$D(PSJHLSKP)
 ;
 ;***This module is no longer used after PSJ*5*181***
 Q
 ;
 N Z,ZZ,STATUSNP I $G(PSJPWD)&($P($G(PSJSYSU),";")=3)&($G(PSGDRG)) I ($D(^PSI(58.1,"D",PSGDRG,PSJPWD)))!($D(^PSD(58.8,"D",PSGDRG,PSJPWD))) D EN^DDIOL("                         *** A WARD STOCK ITEM ***")
 D NOW^%DTC
 N PSJDCHK F Z=%:0 S Z=$O(^PS(55,+PSGP,5,"AUS",Z)) Q:'Z!$D(DUOUT)  F ZZ=0:0 S ZZ=$O(^PS(55,+PSGP,5,"AUS",Z,ZZ)) Q:'ZZ!$D(DUOUT)  I +$G(^PS(55,+PSGP,5,ZZ,.2))=PSGX D PDWCHK(+PSGP,ZZ_"U") S PSJDCHK=1
 F STATUSNP="N","P" F Z=0:0 S Z=$O(^PS(53.1,"AS",STATUSNP,+PSGP,Z)) Q:'Z!$D(DUOUT)  I +$G(^PS(53.1,+Z,.2))=PSGX D PDWCHK(+PSGP,Z_"P") S PSJDCHK=1
 I $D(PSJDCHK) N DIR D
 .S DIR(0)="Y",DIR("A")="Do you wish to continue entering this order",DIR("?",1)="Enter ""N"" if you wish to exit without creating a new order,"
 .S DIR("?")="or ""Y"" to continue with the order entry process." D ^DIR S:'Y Y=-1,X="^"
 K Z,ZZ
 Q
 ;
ENDDC(PSGP,PSJDD) ; Perform Duplicate Drug, Duplicate Class
 ;Using FDB OC
 NEW PSPDRG,PSJDSPNM,X
 K ^TMP($J,"PSJPRE")
 S PSJDSPNM=""
 ;If it is an active or pending order then check for multiple dispense drugs.
 I $G(PSJMULDD)>1!($G(PSGORD)]"") S PSJDSPNM=$$DRGNM()
 S PSPDRG(1)=PSJDD_U_$S(PSJDSPNM]"":PSJDSPNM,1:$$DN^PSJMISC(+PSJDD))
 I $$SUP^PSSDSAPI(+PSJDD) D DISPLAY^PSJOC Q
 D OC^PSJOC(.PSPDRG,"I;"_$G(PSGORD))
 Q 
DRGNM() ;
 ;Return the OI name + Dosage form if more than one DD in the order
 NEW PSJCNT,PSJDSPNM,X
 ;If it's speed finish then get the drug name from 53.1 (^PS(53.45 is not set to the current order yet)
 I $G(PSJSPEED),($G(PSGORD)["P") S PSJDSPNM=$$OINM^PSJOCDS(PSGORD) Q PSJDSPNM
 S PSJCNT=0,PSJDSPNM=""
 F X=0:0 S X=$O(^PS(53.45,+$G(PSJSYSP),2,X)) Q:'X  S PSJCNT=PSJCNT+1
 I PSJCNT>1,+$G(PSGPDRG) S PSJDSPNM=$$OIDF^PSJLMUT1(+PSGPDRG)
 Q PSJDSPNM
 ;
CONT ; Ask user if they wish to continue in spite of an order check.
 Q:'$D(PSJPDRG)  N DIR S DIR(0)="Y",DIR("A")="Do you wish to continue entering this order",DIR("?",1)="Enter ""N"" if you wish to exit without creating a new order,"
 S DIR("?")="or ""Y"" to continue with the order entry process.",DIR("B")="NO" D ^DIR I 'Y S PSGORQF=1,X="^",COMQUIT=1 Q
 I 'INTERVEN!($P(PSJSYSU,";")'=3) Q
 NEW PSJY
 W:PSJIREQ !!,"This is a CRITICAL interaction, you must enter an intervention log to continue"
 S DIR(0)="Y",DIR("A")="Do you wish to log an intervention",DIR("?",1)="Enter ""N"" if you do not wish to log an intervention,",DIR("?")="or ""Y"" to log an intervention." D ^DIR S PSJY=Y D:Y ^PSJRXI
 I 'PSJY,PSJIREQ S PSGORQF=1,COMQUIT=1
 Q
 ;
ENDL ; used by PSGTRAIN DRUG LOOK-UP option
 D ENCV^PSGSETU Q:$D(XQUIT)
 F  S DIC="^PSDRUG(",DIC(0)="AEIMOQZ",DIC("A")="Select DRUG: " W ! D ^DIC K DIC Q:+Y'>0  D SF
 D ENKV^PSGSETU K N5,ND,Q,Y Q
 ;
SF ;
 S Y=+Y,ND=$G(^PSDRUG(Y,0)),PSGID=+$G(^("I")) I PSGID W !!,"THIS DRUG IS INACTIVE AS OF ",$E($$ENDTC^PSGMI(PSGID),1,8)
 W !!,$S($P(ND,"^",9):"NON-",1:""),"FORMULARY ITEM" W:$P(ND,"^",10)]"" !,$P(ND,"^",10)
 S ND=$P($G(^PSDRUG(Y,2)),"^",3)["U" W !,$P("NOT^","^",ND+1)," A UNIT DOSE DRUG" W ! S ND=$G(^(8)),N5=$G(^(8.5)) W !?2,"DAY (nD) or DOSE (nL) LIMIT: " I ND W $P(ND,"^")
 W !?10,"UNIT DOSE MED ROUTE: " I $P(ND,"^",2) W $S($D(^PS(51.2,$P(ND,"^",2),0)):$P(^(0),"^"),1:$P(ND,"^",2))
 ; NAKED REF below refers to ^PS(51.2, on line above.
 W !?6,"UNIT DOSE SCHEDULE TYPE: " I $P(ND,"^",3)]"" W $P($P(";"_$P(^(0),"^",3),";"_$P(ND,"^",3)_":",2),";")
 W !?11,"UNIT DOSE SCHEDULE: " I $P(ND,"^",4)]"" W $P(ND,"^",4)
 W !,"CORRESPONDING OUTPATIENT DRUG: " I $P(ND,"^",5) W $S('$D(^PSDRUG(+$P(ND,"^",5),0)):$P(ND,"^",5),$P(^(0),"^")]"":$P(^(0),"^"),1:$P(ND,"^",5))
 W !?17,"ATC MNEMONIC: " I $P(N5,"^",2)]"" W $P(N5,"^",2)
 W !?17,"ATC CANISTER: " F Q=0:0 S Q=$O(^PSDRUG(Y,212,Q)) Q:'Q  S ND=$G(^(Q,0)) I ND,$P(ND,"^",2) W ?31,$S('$D(^PS(57.5,+ND,0)):+ND_";PS(57.5,",$P(^(0),"^")]"":$P(^(0),"^"),1:+ND_";PS(57.5,"),?56,$P(ND,"^",2),!
 Q
 ;
OCHK ; Add drugs in current order to ^TMP("ORDERS" and call order checker.
 ; Set PSJOCHK=1 so OP order check doesn't Kill array.
 ;
 K ^TMP($J,"ORDERS")
 N PSJOCHK S PSJOCHK=1
PDWCHK(DFN,ON) ; Print Dup Drug order.
 N ND,ND0,ND2,X
 W:'$D(PSJDCHK) $C(7),$C(7),!!,"WARNING! THIS PATIENT HAS THE FOLLOWING ORDER(S) FOR THIS MEDICATION:",!!
 S ND=$$DRUGNAME^PSJLMUTL(DFN,ON)
 S F=$S(ON["P":"^PS(53.1,",1:"^PS(55,"_DFN_",5,"),ND0=$G(@(F_+ON_",0)")),ND2=$G(^(2)),X=$P(ND,U,2),X=$S(X=.2:$P($G(^(.2)),U,2),1:$G(^(.3)))
 W ?10,$P(ND,U),!,?13,"Give: ",X," ",$$ENMRN^PSGMI(+$P(ND0,U,3))," ",$P(ND2,U),!!
 Q
