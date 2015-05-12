FBAAMP ;AISC/CMR-MULTIPLE PAYMENT ENTRY ; 11/21/12 4:12pm
 ;;3.5;FEE BASIS;**4,21,38,55,61,67,116,108,143,123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 S FBMP=1 ;multiple payment flag
 G ^FBAACO
1 ;return from FBAACO
 D MMPPT^FBAACO G:$G(FBAAOUT) Q1
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
RDAP D FEE G Q:$G(FBAAOUT) S FBK=FBAMTPD W ! S DIR("A")="Is $"_FBK_" correct for Amount Paid",DIR("B")="Yes",DIR(0)="Y" D ^DIR K DIR G Q:$D(DIRUT),RDAP:'Y
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
 S DR(1,162.03,1)="6////^S X=DUZ;7////^S X=FBAABE;8////^S X=BO;13///^S X=FBAAID;14///^S X=FBAAIN;15///^S X=FBPT;16////^S X=FBPOV;17///^S X=FBTT;18///^S X=FBAAPTC;23////^S X=FBTYPE;26////^S X=FBPSA"
 S DR(1,162.03,2)="34///^S X=$G(FBAAMM1);54////^S X=$G(FBCNTRP);28////^S X=FBHCFA(28);30////^S X=FBHCFA(30);31////^S X=FBHCFA(31);32////^S X=FBHCFA(32);33///^S X=FBAAVID;44///^S X=FBFSAMT;45////^S X=FBFSUSD"
 S DR(1,162.03,3)=".05////^S X=$G(FBIA);.055///^S X=$G(FBDODINV)"         ; FB*3.5*123
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
 S Z1=$P(^FBAA(161.7,FBAABE,0),"^",11)+1,$P(^(0),"^",11)=Z1
 W:Z1>(FBAAMPI-20) !,*7,"Warning, you can only enter ",(FBAAMPI-Z1)," more line items!" I Z1>(FBAAMPI-1) D  S FBMAX=1 G Q1
 .W !!,*7,"You have reached the maximum number of payments for a Batch!",!,"You must select another Batch for entering Payments!"
 G MULT
Q1 K FBADJ,FBAADT,FBX,FBAACP,DIC,DIE,X,Y,DIRUT,DUOUT,DTOUT,FBOUT,FBSI,FBMPDT,FBIA,FBDODINV G ^FBAACO:$D(FBMAX),1^FBAACO
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
 ; FB*3.5*143 Adding FB1725 as a parameter to prevent reduction 
 ; of local fee schedule payments
 S FBX=$$GET^FBAAFS($$CPT^FBAAUTL4(FBAACP),$$MODL^FBAAUTL4("FBMODA","E"),FBMPDT,$G(FBZIP),$$FAC^FBAAFS($G(FBHCFA(30))),$G(FBTIME),$G(FB1725))
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
 ; FB*3.5*143 - Preventing 70% reduction of 75th percentile rates
 I FB1725,FBFSUSD'="F" D
 . W !!?2,"**Payment is for emergency treatment under 38 U.S.C. 1725."
 . I FBFSAMT D
 . . S FBFSAMT=$J(FBFSAMT*.7,0,2)
 . . W !?2,"  Therefore, fee schedule amount reduced to $",FBFSAMT," (70%)."
 ;
 I $G(FBUNITS)>1 D
 . W !!?2,"Units Paid = ",FBUNITS
 . Q:FBFSAMT'>0
 . N FBFSUNIT
 . ; determine if fee schedule can be multiplied by units
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
 ;I +Y>FBJ W !!,*7,"Amount paid cannot be greater than the amount claimed." G AMTPD ; Removed in patch FB*143 as overpayment may be allowed per Medicare & Medicaid Services (CMS) reimbursement methodology
 I FBAMFS]"" I +Y>FBAMFS&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) W !!,*7,"You must be a holder of the 'FBAASUPERVISOR' key in order to",!,"exceed the Fee Schedule.",! G AMTPD
 S FBAMTPD=+Y K FBAMFS Q
HELP1 W !!,"Enter a dollar amount that does not exceed the amount claimed.",!
 I FBAMFS>0 W "Only the holder of the 'FBAASUPERVISOR' key may exceed the",!,"Fee Schedule.",!
 Q
 ;
CHKCPT() ; check if CPT/Modifier active on date of service
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
 S FBX=$$GET^FBAAFS($$CPT^FBAAUTL4(FBAACP),$$MODL^FBAAUTL4("FBMODA","E"),FBDT,$G(FBZIP),$$FAC^FBAAFS($G(FBHCFA(30))),$G(FBTIME),$G(FB1725))
 ; set FB1725 flag = true if payment for a 38 U.S.C. 1725 claim
 S FB1725=$S($G(FB583):+$P($G(^FB583(+FB583,0)),U,28),1:0)
 ; adjust amount if mill bill
 I FB1725 S $P(FBX,U)=$J($P(FBX,U)*.7,0,2)
 ; adjust amount if units > 1
 I $G(FBUNITS) D
 . N FBFSUNIT
 . ; determine if fee schedule can be multiplied by units
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
IPACID(FBVEN,FBIPIEN) ; function to return IPAC agreement ID# if exactly 1 active IPAC on file for vendor (FB*3.5*123)
 ; No user interface allowed with this function.  Called by background, Austin transmission process.
 ;
 ; Input:
 ;   FBVEN - Vendor ien (ptr to file 161.2)
 ;
 ; Output:
 ;   Function value = if exactly 1 active IPAC agreement is on file, then this returns the external agreement ID#
 ;                    otherwise, this returns ""
 ;   FBIPIEN (pass by reference) - internal entry ien of the active IPAC agreement on file
 ;
 N X1,X2,RET
 S RET=""       ; default value
 S FBIPIEN=""   ; initialize
 S FBVEN=+$G(FBVEN)
 I '$$IPACREQD(FBVEN) G IPACIDX                            ; IPAC not required
 S X1=+$O(^FBAA(161.95,"AVA",FBVEN,"A",""))                ; first active IPAC entry
 I 'X1 G IPACIDX                                           ; no IPAC data found for vendor so get out
 S X2=+$O(^FBAA(161.95,"AVA",FBVEN,"A",""),-1)             ; last active IPAC entry
 ;
 ; only 1 IPAC on file - retrieve the ID# in this case only
 I X1=X2 S RET=$P($G(^FBAA(161.95,X1,0)),U,1),FBIPIEN=X1   ; IPAC external agreement ID#
 ;
IPACIDX ;
 Q RET
 ;
IPAC(FBVEN) ; Determine if active IPAC agreement data exists for vendor (FB*3.5*123)
 ; Input:
 ;   FBVEN - Vendor ien (ptr to file 161.2)
 ;
 ; Output:
 ;   Function value = -1 if active IPAC records exist, but none were selected (this is an error condition)
 ;                  = ien of IPAC entry in file 161.95 (if only 1 exists, or user selected it)
 ;                  = "" if no IPAC data found or if IPAC not required
 ;
 N FBIA,X1,X2,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S FBIA=""
 S FBVEN=+$G(FBVEN)
 I '$$IPACREQD(FBVEN) G IPACX                          ; IPAC not required
 S X1=+$O(^FBAA(161.95,"AVA",FBVEN,"A",""))            ; first active IPAC entry
 I 'X1 G IPACX                                         ; no IPAC data found for vendor, get out with FBIA=""
 W !!,"This is a Federal Vendor. IPAC payment information is required."
 S X2=+$O(^FBAA(161.95,"AVA",FBVEN,"A",""),-1)         ; last active IPAC entry
 ;
 ; only 1 IPAC on file - select it automatically
 I X1=X2 S FBIA=X1 D
 . W !,"  - Required IPAC agreement information has been found."
 . Q
 ;
 I X1'=X2 S FBIA=$$MULTIPAC(FBVEN)                     ; multiple IPAC selection for vendor
 I FBIA'>0 G IPACX                                     ; get out if user failed to select one
 ;
 S DIR(0)="Y",DIR("A")="Would you like to display the detailed IPAC agreement information"
 S DIR("B")="No"
 W ! D ^DIR K DIR
 I $D(DIRUT) W "  Not displaying detail ... "
 I 'Y G IPACX   ; exit without displaying the data by user choice
 ;
 ; Display the IPAC data
 W !
 D VADISP^FBAAIAU(FBIA,1)
 S DIR(0)="E" D ^DIR K DIR    ; press return to continue
IPACX ;
 Q FBIA
 ;
MULTIPAC(FBVEN) ; multiple IPAC agreement display, lister, selection
 ; same input and output parameters as IPAC above
 ;
 N FBIA,Z,CNT,FBLN,FBG,ID,FY,DESC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,LN,T,W
 S FBVEN=+$G(FBVEN)
 S FBIA=""
 S Z=0,CNT=0 K FBLN
 F  S Z=$O(^FBAA(161.95,"AVA",FBVEN,"A",Z)) Q:'Z  D
 . S FBG=$G(^FBAA(161.95,Z,0)) I FBG="" Q
 . S ID=$P(FBG,U,1)
 . S FY=$P(FBG,U,3)
 . S DESC=$P(FBG,U,5)
 . S CNT=CNT+1,FBLN(CNT)=Z_U_ID_U_FY_U_DESC
 . Q
 ;
 I 'CNT G MULIPACX    ; get out if nothing found (should not happen)
 I CNT=1 S FBIA=$P(FBLN(1),U,1) G MULIPACX       ; only 1 found (also should not happen)
 ;
 ; Multiple found. Build list.
 S DIR(0)="N"_U_"1:"_CNT,LN=0
 S LN=LN+1,DIR("A",LN)=$$GET1^DIQ(161.2,FBVEN_",",.01)_" is a Federal Vendor with"
 S LN=LN+1,DIR("A",LN)=CNT_" active IPAC agreements on file:"
 S LN=LN+1,DIR("A",LN)=" "
 S LN=LN+1,DIR("A",LN)="#   ID          FY   Description"
 S LN=LN+1,DIR("A",LN)="-- ----------  ----  -----------"
 S T=0 F  S T=$O(FBLN(T)) Q:'T  S W=FBLN(T) D
 . S LN=LN+1,DIR("A",LN)=$$LJ^XLFSTR(T,3)_$$LJ^XLFSTR($P(W,U,2),12)_$$LJ^XLFSTR($P(W,U,3),6)_$E($P(W,U,4),1,58)
 . Q
 S LN=LN+1,DIR("A",LN)=" "
 S LN=LN+1,DIR("A",LN)="Please select the IPAC agreement to be used with this invoice."
 S LN=LN+1,DIR("A",LN)="This information is required."
 S DIR("A")="Selection#"
 W ! D ^DIR K DIR
 I Y>0 S FBIA=$P($G(FBLN(Y)),U,1) G MULIPACX    ; user selection is good so set FBIA and get out
 ;
 ; in all other cases, user failed to make a selection so set FBIA=-1
 S FBIA=-1
 W !!,$C(7),"IPAC Agreement Selection is required for this vendor."
 ;
MULIPACX ;
 Q FBIA
 ;
IPACINV(FBDODINV,FBDEF) ; function to get the DoD invoice number for IPAC (FB*3.5*123)
 ; Function value is 1 if the DoD invoice number was obtained.
 ; Function value is 0 if not.
 ; FBDODINV - pass by reference. This is set to the DoD invoice number.
 ; FBDEF is an optional default value
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S FBDODINV="",RET=0   ; initialize
 S DIR(0)="Fr^3:22",DIR("A")="Enter the DoD Invoice Number"
 I $G(FBDEF)'="" S DIR("B")=FBDEF
 S DIR("?",1)="If invoice is a UB-04 look in block 3a."
 S DIR("?",2)="If invoice is a CMS-1500 look in block 26."
 S DIR("?")="You must enter between 3-22 characters."
 W ! D ^DIR K DIR
 I $D(DIRUT),$G(FBDEF)'="" S Y=FBDEF K DIRUT
 I '$D(DIRUT),Y'="" S FBDODINV=Y,RET=1 G IPINVX
 W !!,$C(7),"The DoD Invoice Number is required for IPAC processing."
IPINVX ;
 W !
 Q RET
 ;
IPACREQD(FBVEN) ; Is IPAC data required for vendor?  (FB*3.5*123)
 I $G(FBAAPTC)="R" Q 0      ; IPAC is not applicable for Patient/Veteran reimbursements
 I +$O(^FBAA(161.95,"AVA",+$G(FBVEN),"A","")) Q 1
 Q 0
 ;
IPACDISP(FBIA,FBDODINV) ; Quick display of IPAC data currently on file for this invoice  (FB*3.5*123)
 N G
 S FBIA=+$G(FBIA)
 S G=$G(^FBAA(161.95,FBIA,0))
 I G="",$G(FBDODINV)="" G IDISPX
 W !!,"IPAC Agreement Information on file for this Invoice/Payment"
 W !,"-----------------------------------------------------------"
 W !,"IPAC Agreement ID: ",$P(G,U,1),"  (",$$GET1^DIQ(161.95,FBIA,3),")"
 W !?11,"Vendor: ",$$GET1^DIQ(161.95,FBIA,1)
 W !?6,"Fiscal Year: ",$P(G,U,3)
 W !,"Short Description: ",$P(G,U,5)
 W !?5,"DoD Invoice#: ",$G(FBDODINV)
IDISPX ;
 Q
 ;
ANCIL ;ENTRY POINT FOR multiple ancillary payment option
 S FBCHCO=1 D ^FBAAMP
 K FBCHCO Q
