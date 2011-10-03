FBAAMP ;AISC/CMR-MULTIPLE PAYMENT ENTRY ;9/29/2003
 ;;3.5;FEE BASIS;**4,21,38,55,61,67,116**;JAN 30, 1995;Build 30
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S FBMP=1 ;multiple payment flag
 G ^FBAACO
1 ;return from FBAACO
 D MMPPT^FBAACP G:$G(FBAAOUT) Q1
 D MPDT I 'FBMPDT G Q1
 K FBAAOUT W ! D CPTM^FBAALU(FBMPDT,DFN) I 'FBGOT G Q1
 ; prompt revenue code
 S FBAARC=$$ASKREVC^FBUTL5() I FBAARC="^" S FBAAOUT=1 G Q1
 ; prompt units paid
 S FBUNITS=$$ASKUNITS^FBUTL5() I FBUNITS="^" S FBAAOUT=1 G Q1
 S FY=$E(DT,1,3)+1700+$S($E(DT,4,5)>9:1,1:0)
 D ASKZIP^FBAAFS($G(FBV)) I $G(FBAAOUT)!($G(FBZIP)']"") G Q1
 I $$ANES^FBAAFS($$CPT^FBAAUTL4(FBAACP)) D ASKTIME^FBAAFS I $G(FBAAOUT)!('$G(FBTIME)) G Q1
 D HCFA^FBAAMP1 G Q1:$G(FBAAOUT)
AMTCL S DIR(0)="162.03,1",DIR("A")="Amount Claimed:  $",DIR("?")="Enter the amount being claimed by the vendor" D ^DIR K DIR G Q:$D(DIRUT) S FBJ=+Y
 W ! S DIR("A")="Is $"_FBJ_" correct for Amount Claimed",DIR("B")="Yes",DIR(0)="Y" D ^DIR K DIR G Q:$D(DIRUT),AMTCL:'Y
RDAP D FEE G Q:$G(FBAAOUT) S FBK=FBAMTPD
 W ! S DIR("A")="Is $"_FBK_" correct for Amount Paid",DIR("B")="Yes",DIR(0)="Y" D ^DIR K DIR G Q:$D(DIRUT),RDAP:'Y
 S FBAAAS=0 K FBADJ I FBJ-FBK D SUSP^FBAAMP1 I $G(FBAAOUT) G Q:$D(DUOUT),Q1
 S FBJ=+FBJ,FBK=+FBK,FBAAAS=+FBAAAS
 ; prompt for remittance remarks
 I $$RR^FBUTL4(.FBRRMK,2)=0 S FBAAOUT=1 G Q1
MULT W:FBINTOT>0 !,"Invoice: "_FBAAIN_" Totals: $ "_FBINTOT
 W !! S %DT("A")="Date of Service: ",%DT="AEPX" D ^%DT G Q1:X=""!(X="^")
 D DATCK^FBAAUTL G MULT:'$D(X)!(Y<0)
 S FBDT=Y
 I '$$CHKCPT() W !,$C(7),"Invalid Date of Service." G MULT
 I $$CHKICD9^FBCSV1(+$G(FBHCFA(28)),$G(FBDT))="" G MULT
 I '$G(FBAAMM1),'$$CHKFS() W !,$C(7),"Invalid Date of Service." G MULT
 S DIR(0)="Y",DIR("A")="Is "_($$DATX^FBAAUTL(FBDT))_" correct",DIR("B")="Yes" D ^DIR K DIR G MULT:$D(DIRUT)!('Y)
 S FBAADT=FBDT
 S FBMODL=$$MODL^FBAAUTL4("FBMODA","I")
 I $D(^FBAAC("AE",DFN,FBV,FBAADT,FBAACP_$S($G(FBMODL)]"":"-"_FBMODL,1:""))) S DIR(0)="Y",DIR("A")="Code already exists for that date!  Want to add another service for the SAME DATE",DIR("B")="No" D ^DIR K DIR G MULT:$D(DIRUT)!('Y)
 I FBFPPSC]"" S FBFPPSL=$$FPPSL^FBUTL5() I FBFPPSL=-1 G Q1
 W !! D GETSVDT^FBAACO5(DFN,FBV,FBASSOC,0,FBAADT) G Q:$G(FBAAOUT)
 D SETO^FBAACO3,SVCPR^FBAACO1 G Q:$G(FBAAOUT)
FILE S TP="",DR="1///^S X=FBJ;Q;2///^S X=FBK;47///^S X=FBUNITS"
 I FBCSID]"" S DR=DR_";49///^S X=FBCSID"
 I FBFPPSC]"" S DR=DR_";50///^S X=FBFPPSC;51///^S X=FBFPPSL"
 I FBAARC]"" S DR=DR_";48////^S X=FBAARC"
 ;S DR=DR_$S(FBJ-FBK:";3///^S X=FBAAAS;3.5////^S X=DT;4////^S X=FBAASC;D DESC^FBAAMP1",1:"")
 S DR(1,162.03,1)="6////^S X=DUZ;7////^S X=FBAABE;8////^S X=BO;13///^S X=FBAAID;14///^S X=FBAAIN;15///^S X=FBPT;16////^S X=FBPOV;17///^S X=FBTT;18///^S X=FBAAPTC;23////^S X=2;26////^S X=FBPSA"
 S DR(1,162.03,2)="34///^S X=$G(FBAAMM1);28////^S X=FBHCFA(28);30////^S X=FBHCFA(30);31////^S X=FBHCFA(31);32////^S X=FBHCFA(32);33///^S X=FBAAVID;44///^S X=FBFSAMT;45////^S X=FBFSUSD"
 S DIE="^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,"
 S DA=FBAACPI,DA(1)=FBSDI,DA(2)=FBV,DA(3)=DFN
 D LOCK^FBUCUTL(DIE,FBAACPI,1)
 D ^DIE
 D FILEADJ^FBAAFA(FBAACPI_","_FBSDI_","_FBV_","_DFN_",",.FBADJ)
 D FILERR^FBAAFR(FBAACPI_","_FBSDI_","_FBV_","_DFN_",",.FBRRMK)
 L -^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI)
 S FBINTOT=FBINTOT+FBK
 W " ....OK, DONE...."
 ; HIPAA 5010 - count line items that have 0.00 amount paid
 ;I FBK>0 S Z1=$P(^FBAA(161.7,FBAABE,0),"^",11)+1,$P(^(0),"^",11)=Z1
 S Z1=$P(^FBAA(161.7,FBAABE,0),"^",11)+1,$P(^(0),"^",11)=Z1
 W:Z1>(FBAAMPI-20) !,*7,"Warning, you can only enter ",(FBAAMPI-Z1)," more line items!" I Z1>(FBAAMPI-1) D  S FBMAX=1 G Q1
 .W !!,*7,"You have reached the maximum number of payments for a Batch!",!,"You must select another Batch for entering Payments!"
 G MULT
Q1 K FBADJ,FBAADT,FBX,FBAACP,DIC,DIE,X,Y,DIRUT,DUOUT,DTOUT,FBOUT,FBSI,FBMPDT G ^FBAACO:$D(FBMAX),1^FBAACO
 ;
Q ;kill variables and exit
 D Q^FBAACO
 Q
 ;
MPDT ;
 S FBMPDT=""
 S DIR(0)="D^::EX"
 S DIR("A")="Enter date to use for CPT/ICD checks and fee schedule calc"
 S DIR("B")="TODAY"
 S DIR("?",1)="Enter a date. This date will be used when checking for"
 S DIR("?",2)="an active CPT/Modifier/ICD code. Also, the fee schedule"
 S DIR("?",3)="amount will be computed based on this date."
 S DIR("?")="Enter '^' to exit."
 W !
 D ^DIR K DIR S:'$D(DIRUT) FBMPDT=Y
 Q
 ;
FEE N FBX,FB1725
 ; set FB1725 flag = true if payment for a 38 U.S.C. 1725 claim
 S FB1725=$S($G(FB583):+$P($G(^FB583(+FB583,0)),U,28),1:0)
 S FBFY=FY-1
 S (FBFSAMT,FBFSUSD,FBAMFS)=""
 S FBX=$$GET^FBAAFS($$CPT^FBAAUTL4(FBAACP),$$MODL^FBAAUTL4("FBMODA","E"),FBMPDT,$G(FBZIP),$$FAC^FBAAFS($G(FBHCFA(30))),$G(FBTIME))
 ;
 I '$G(FBAAMM1) D
 . S FBFSAMT=$P(FBX,U),FBFSUSD=$P(FBX,U,2)
 E  D
 . W !,?2,"Payment is for a contracted service so fee schedule does not apply."
 ;
 I $P($G(FBX),U)]"" D
 . W !?2,$S($G(FBAAMM1):"However, f",1:"F")
 . W "ee schedule amount is $",$P(FBX,U)," from the "
 . W:$P(FBX,U,3)]"" $P(FBX,U,3)," " ; year if returned
 . W:$P(FBX,U,2)]"" $$EXTERNAL^DILFD(162.03,45,"",$P(FBX,U,2))
 E  W !?2,"Unable to determine a FEE schedule amount."
 ;
 I FB1725 D
 . W !!?2,"**Payment is for emergency treatment under 38 U.S.C. 1725."
 . I FBFSAMT D
 . . S FBFSAMT=$J(FBFSAMT*.7,0,2)
 . . W !?2,"  Therefore, fee schedule amount reduced to $",FBFSAMT," (70%)."
 ;
 I $G(FBUNITS)>1 D
 . W !!?2,"Units Paid = ",FBUNITS
 . Q:FBFSAMT'>0
 . N FBFSUNIT
 . ; determine if fee schedule can be multipled by units
 . S FBFSUNIT=$S(FBFSUSD="R":1,FBFSUSD="F"&(FBMPDT>3040930):1,1:0)
 . I FBFSUNIT D
 . . S FBFSAMT=$J(FBFSAMT*FBUNITS,0,2)
 . . W !?2,"  Therefore, fee schedule amount increased to $",FBFSAMT
 . E  D
 . . W !?2,"  Fee schedule not complied on per unit basis so amount not adjusted by units."
 ;
 I '$G(FBAAMM1) D
 . ; set default amount paid to lesser of amt claimed (J) or fee sched.
 . S FBAMFS=$S(FBFSAMT>$G(FBJ):$G(FBJ),1:FBFSAMT)
 ;
 W !
 ;
AMTPD S DIR(0)="162.5,9",DIR("A")="Amount Paid: $",DIR("B")=$G(FBAMFS),DIR("?")="^D HELP1^FBAAMP" K:$G(FBAMFS)="" DIR("B") D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1 Q
 I +Y>FBJ W !!,*7,"Amount paid cannot be greater than the amount claimed." G AMTPD
 I FBAMFS]"" I +Y>FBAMFS&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) W !!,*7,"You must be a holder of the 'FBAASUPERVISOR' key in order to",!,"exceed the Fee Schedule.",! G AMTPD
 S FBAMTPD=+Y K FBAMFS Q
HELP1 W !!,"Enter a dollar amount that does not exceed the amount claimed.",!
 I FBAMFS>0 W "Only the holder of the 'FBAASUPERVISOR' key may exceed the",!,"Fee Schedule.",!
 Q
 ;
CHKCPT() ; check if CPT/Modifer active on date of service
 N FBCPTX,FBI,FBMOD,FBMODX,FBRET
 S FBRET=1
 S FBCPTX=$$CPT^ICPTCOD(FBAACP,FBDT,1)
 I '$P(FBCPTX,U,7) S FBRET=0 W !,"  CPT Code ",$P(FBCPTX,U,2)," inactive on date of service."
 I $O(FBMODA(0)) D
 . S FBI=0 F  S FBI=$O(FBMODA(FBI)) Q:'FBI  D
 . . S FBMODX=$$MOD^ICPTMOD(FBMODA(FBI),"I",FBDT,1)
 . . I '$P(FBMODX,U,7) S FBRET=0 W !,"  CPT Modifier ",$P(FBMODX,U,2)," inactive on date of service."
 Q FBRET
 ;
CHKFS() ; check if fee schedule amount is different on date of service
 N FBX,FBRET,FB1725
 S FBRET=1 ; return value - true if date of service allowed
 ; set FB1725 flag = true if payment for a 38 U.S.C. 1725 claim
 S FB1725=$S($G(FB583):+$P($G(^FB583(+FB583,0)),U,28),1:0)
 S FBX=$$GET^FBAAFS($$CPT^FBAAUTL4(FBAACP),$$MODL^FBAAUTL4("FBMODA","E"),FBDT,$G(FBZIP),$$FAC^FBAAFS($G(FBHCFA(30))),$G(FBTIME))
 ; set FB1725 flag = true if payment for a 38 U.S.C. 1725 claim
 S FB1725=$S($G(FB583):+$P($G(^FB583(+FB583,0)),U,28),1:0)
 ; adjust amount if mill bill
 I FB1725 S $P(FBX,U)=$J($P(FBX,U)*.7,0,2)
 ; adjust amount if units > 1
 I $G(FBUNITS) D
 . N FBFSUNIT
 . ; determine if fee schedule can be multipled by units
 . S FBFSUNIT=$S($P(FBX,U,2)="R":1,$P(FBX,U,2)="F"&(FBDT>3040930):1,1:0)
 . I FBFSUNIT S $P(FBX,U)=$J($P(FBX,U)*FBUNITS,0,2)
 ; issue warning if lesser of claim and fee schedule amount different
 I +$S($P(FBX,U)>$G(FBJ):$G(FBJ),1:$P(FBX,U))'=+$S(FBFSAMT>$G(FBJ):$G(FBJ),1:FBFSAMT) D
 . W !,"  Warning: The fee schedule amount (",$P(FBX,U),") for this date of service "
 . W !,"  differs from the initial fee schedule amount (",FBFSAMT,")."
 . I $P(FBX,U)>0,FBK>$P(FBX,U) D
 . . W !,"  Amount paid (",FBK,") exceeds the fee schedule amount."
 . . I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) D
 . . . W !,"  You must be a holder of the 'FBAASUPERVISOR' key in order"
 . . . W !,"  to exceed the Fee Schedule."
 . . . S FBRET=0
 . W:FBRET !,"  You may want to separately process this date of service."
 Q FBRET
 ;
ANCIL ;ENTRY POINT FOR mutiple ancillary payment option
 S FBCHCO=1 D ^FBAAMP
 K FBCHCO Q
