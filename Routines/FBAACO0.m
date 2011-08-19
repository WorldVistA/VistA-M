FBAACO0 ;AISC/GRR-DISPLAY PATIENT ADDRESS DATA AND EDIT ;7/13/2003
 ;;3.5;FEE BASIS;**4,38,52,57,61,75,70**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S FBMST=$S(FBTT=1:"Y",1:""),FBTTYPE="A",FBFDC=""
 N FBEDPTAD S (FBEDPTAD(1),FBEDPTAD(2))=0
 W @IOF,"Patient:  ",$P(^DPT(DFN,0),"^") S (Y(0),HY(0))=$G(^DPT(DFN,.11)) I Y(0)="" W !,*7,"No Address information for this patient!" G EDIT
 S VAPA("P")="" D ADD^VADPT
 S FBEDPTAD(1)=$$ISCCADR()
 S FBEDPTAD(2)="N"
 I $$CCADR(2)
 W !!,"Patient's Permanent address:"
 F Z=1:1:3 I VAPA(Z)]"" W !?2,"Address Line ",Z,":",?18,VAPA(Z)
 W !?2,"City:",?18,VAPA(4),!?2,"State:",?18,$P(VAPA(5),U,2)
 W !?2,"Zip:",?18,$S(+$G(VAPA(11)):$P(VAPA(11),U,2),1:VAPA(6)),!?2,"County",?18,$P(VAPA(7),U,2)
 K VAPA,VAERR
RD W ! S DIR("A")="Want to edit Permanent Address data",DIR("B")="No",DIR(0)="Y" D ^DIR K DIR  S:Y&('$D(DIRUT)) FBEDPTAD(2)="Y" G EDIT
 Q
EDIT I $G(FBEDPTAD(2))'="N" W !! S HY(0)=$G(^DPT(DFN,.11)) D EN^DGREGAED(DFN)
 I $$EDTCCADR()=0 I FBTT'=1 I FBEDPTAD(2)="N" Q
MRA I FBTT=1!($G(^DPT(DFN,.11))'=$G(HY(0))) S FBD1=FTP D ENT^FBAAAUT K FBD1
 Q
FEE ;calculates amount paid based on fee schedule
 N FB1725
 ; set FB1725 flag = true if payment for a 38 U.S.C. 1725 claim
 S FB1725=$S($G(FB583):+$P($G(^FB583(+FB583,0)),U,28),1:0)
 S FBFY=FY-1
 S (FBFSAMT,FBFSUSD)="",FBAMTPD=$S($G(FBAMTPD)>0:FBAMTPD,1:"")
 ; if amount not passed then use fee schedule
 I '$G(FBAMTPD) D
 . N FBX
 . S FBX=$$GET^FBAAFS($$CPT^FBAAUTL4(FBAACP),$$MODL^FBAAUTL4("FBMODA","E"),FBAADT,$G(FBZIP),$$FAC^FBAAFS($G(FBHCFA(30))),$G(FBTIME))
 . ;
 . I '$G(FBAAMM1) D
 . . S FBFSAMT=$P(FBX,U),FBFSUSD=$P(FBX,U,2)
 . E  W !?2,"Payment is for a contracted service so fee schedule does not apply."
 . ;
 . I $P($G(FBX),U)]"" D
 . . W !?2,$S($G(FBAAMM1):"However, f",1:"F")
 . . W "ee schedule amount is $",$P(FBX,U)," from the "
 . . W:$P(FBX,U,3)]"" $P(FBX,U,3)," " ; year if returned
 . . W:$P(FBX,U,2)]"" $$EXTERNAL^DILFD(162.03,45,"",$P(FBX,U,2))
 . E  W !?2,"Unable to determine a FEE schedule amount."
 . ;
 . I FB1725 D
 . . W !!?2,"**Payment is for emergency treatment under 38 U.S.C. 1725."
 . . I FBFSAMT D
 . . . S FBFSAMT=$J(FBFSAMT*.7,0,2)
 . . . W !?2,"  Therefore, fee schedule amount reduced to $",FBFSAMT," (70%)."
 . ;
 . I $G(FBUNITS)>1 D
 . . W !!?2,"Units Paid = ",FBUNITS
 . . Q:FBFSAMT'>0
 . . N FBFSUNIT
 . . ; determine if fee schedule can be multipled by units
 . . S FBFSUNIT=$S(FBFSUSD="R":1,FBFSUSD="F"&(FBAADT>3040930):1,1:0)
 . . I FBFSUNIT D
 . . . S FBFSAMT=$J(FBFSAMT*FBUNITS,0,2)
 . . . W !?2,"  Therefore, fee schedule amount increased to $",FBFSAMT
 . . E  D
 . . . W !?2,"  Fee schedule not complied on per unit basis so amount not adjusted for units."
 . ;
 . I '$G(FBAAMM1) D
 . . ; set default amount paid to lesser of amt claimed (J) or fee sched.
 . . S FBAMTPD=$S(FBFSAMT>J:J,FBFSAMT>0:FBFSAMT,1:"")
 . ;
 . W !
 ;
AMTPD W !,"AMOUNT PAID: "_$S(FBAMTPD]"":FBAMTPD_"//",1:"") R X:DTIME S:X="" X=FBAMTPD G KILL:$E(X)="^",HELP1:$E(X)="?" S:X["$" X=$P(X,"$",2) I +X'=X&(X'?.N.1".".2N)!(+X>+J)!(+X<0) G HELPPD
 I FBAMTPD]"",X>FBAMTPD&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) D  G AMTPD
 .W !!,*7,"You must be a holder of the 'FBAASUPERVISOR' key to",!,"exceed the Fee Schedule. Entering an up-arrow ('^') will",!,"delete the payment or you can accept the default.",!
 S FBAMTPD=X Q
KILL W !!,*7,"Entering an '^' will delete this payment!" R !,?5,"Do you want to delete? No//",X:DTIME S:X="" X="N" D VALCK^FBAAUTL1 G KILL:'VAL,AMTPD:"Nn"[$E(X)
 S DIK="^FBAAC("_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1," D WAIT^DICD,^DIK W !,?3,"<DELETED>" K DA,J,K,DIC,DIK,FBAACP,FBAADT,FBX S Y=0,FBDL=1 Q
HELP1 W !!,"Enter a dollar amount that does not exceed the amount claimed.",!,"Entering an '^' will delete the payment.",!
 I FBAMTPD>0 W !,"Only the holder of the 'FBAASUPERVISOR' key may exceed the",!,"Fee Schedule.",!
 G AMTPD
HELPPD W !!,*7,"Enter a dollar amount that does not exceed the amount claimed.",! G AMTPD
 Q
 ;print Confidential Communication address
 ;ADD^VADPT must be invoked before this call
 ;FBDFN -patient's DFN
 ;FBSTPOS - position to start print
 ;returns 0 if there is no active CC address
 ;returns 1 if active
CCADR(FBSTPOS) ;
 N FBACT
 S FBACT=0
 I '$D(VAPA(12)) Q 0  ;if D ADD^VADPT was not invoked before
 I 'VAERR D
 . S FBACT=$$ACTIVECC()
 . Q:'FBACT
 . W !!,"Confidential Communication address until: "_$P($G(VAPA(21)),U,2)
 . I $G(VAPA(13))]"" W !?FBSTPOS,"Line 1: ",$G(VAPA(13))
 . I $G(VAPA(14))]"" W " Line 2: ",$G(VAPA(14))
 . I $G(VAPA(15))]"" W !?FBSTPOS,"Line 3: ",$G(VAPA(15))
 . W !?FBSTPOS,"City:",?9,$S($G(VAPA(16))]"":$G(VAPA(16)),1:"     ")
 . W ?40,"State:",?47,$S($P($G(VAPA(17)),U,2)]"":$P($G(VAPA(17)),U,2),1:"  ")
 . W !?FBSTPOS,"Zip:",?9,$P($G(VAPA(18)),U,2)
 . W ?20,"County:",?28,$P($G(VAPA(19)),U,2)
 Q $G(FBACT)
 ;
 ;is called after ADD^VADPT to verify whether confidential address is 
 ;active or not to encapsulate the logic related to status of CC address
 ;input:  VAPA
ACTIVECC() ;
 Q (+$G(VAPA(12))=1)&($P($G(VAPA(22,3)),"^",3)="Y")
 ;
 ;edit confidential address
 ;returns 1 if CC address has been edited
 ;otherwise - 0
EDTCCADR() ;
 Q:'$G(DFN) 0
 I FBEDPTAD(1)=0 D
 . N VAPA S VAPA("P")="" D ADD^VADPT S FBEDPTAD(1)=$$ISCCADR()
 I FBEDPTAD(1)'="N" D
 . W:FBEDPTAD(1)'="B" !!,"WARNING: The Confidential address is NOT active for the Billing Category."
 . S DIR("A")="Want to edit Confidential Address data"
 E  S DIR("A")="Want to add Confidential Address data"
 W ! S DIR("B")="No",DIR(0)="Y"
 D ^DIR K DIR
 Q:($D(DIRUT)) 0
 ;Registration API
 I Y D QUES^DGRPU1(+DFN,"ADD4") Q 1
 Q 0
 ;
 ;returns "B" if patient has any (active or inactive) CC address and billing category
 ;returns "Y" if patient has any (active or inactive) CC address with another category
 ;otherwise returns "N"
ISCCADR() ;
 Q:($P($G(VAPA(22,3)),"^",3)="Y") "B"
 Q:'$O(VAPA(22,0)) "N"
 Q "Y"
 ;
 ;FBAACO0
