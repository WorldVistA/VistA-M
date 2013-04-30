FBAACO3 ;AISC/GRR-ENTER PAYMENT CONTINUED ;7/7/2003
 ;;3.5;FEE BASIS;**4,38,55,61,116,122,133,108,124**;JAN 30, 1995;Build 20
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DOEDIT ;
 N FB1725,FBFPPSC
 W ! S FBAACP(0)=FBAACP
 S DIC="^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,"
 S DIC(0)="EQMZ",DA(3)=DFN,DA(2)=FBV,DA(1)=FBSDI
 S X=$$CPT^FBAAUTL4(FBAACP)
 D ^DIC I Y<0 S FBAAOUT=1 Q
 S (DA,FBAACPI)=+Y,K=$P(Y(0),U,3),FBZBN=$P(Y(0),U,8),FBZBS=$S(FBZBN]"":$P($G(^FBAA(161.7,FBZBN,"ST")),U),1:""),FBAAPTC=$P(Y(0),U,20),J(0)=$P(Y(0),U,2)
 ; set FB1725 true (1) if payment is for a Mill Bill claim
 S FB1725=$S($P(Y(0),U,13)["FB583":+$P($G(^FB583(+$P(Y(0),U,13),0)),U,28),1:0)
 S FBAAMM1=$P($G(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,2)),U,2)
 S FBCNTRP=$P($G(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,3)),U,8)
 S FBFSAMT(0)=$P($G(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,2)),U,12)
 ; determine lesser of original fee schedule amount and amount claimed
 S FBAMTPD(0)=$S(FBFSAMT(0)="":J(0),FBFSAMT(0)>J(0):J(0),1:FBFSAMT(0))
 S FBMODL=$$MODL^FBAAUTL4("^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,"_FBAACPI_",""M"")")
 ; load current adjustment data
 D LOADADJ^FBAAFA(FBAACPI_","_FBSDI_","_FBV_","_DFN_",",.FBADJ)
 ; save adjustment data prior to edit session in sorted list
 S FBADJL(0)=$$ADJL^FBUTL2(.FBADJ) ; sorted list of original adjustments
 ; load current remittance remark data
 D LOADRR^FBAAFR(FBAACPI_","_FBSDI_","_FBV_","_DFN_",",.FBRRMK)
 ; save remittance remarks prior to edit session in sorted list
 S FBRRMKL(0)=$$RRL^FBUTL4(.FBRRMK)
 ; load FPPS data
 S FBFPPSC=$P($G(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,3)),U)
 S FBFPPSL=$P($G(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,3)),U,2)
 I FBZBS=""!(FBZBS="V") D NOGO S FBAAOUT=1 Q
 ; first edit CPT code and modifiers
 D CPTM^FBAALU(FBAADT,DFN,FBAACP(0),FBMODL) I '$G(FBGOT) S FBAAOUT=1 Q
 ; if CPT was changed then update file
 I FBAACP'=FBAACP(0) D  I FBAACP="@" S FBAAOUT=1 Q
 . N FBIENS,FBFDA
 . S FBIENS=FBAACPI_","_FBSDI_","_FBV_","_DFN_","
 . S FBFDA(162.03,FBIENS,.01)=FBAACP
 . D FILE^DIE("","FBFDA") D MSG^DIALOG()
 ; if modifiers changed then update file
 I FBMODL'=$$MODL^FBAAUTL4("FBMODA") D REPMOD^FBAAUTL4(DFN,FBV,FBSDI,FBAACPI)
 ; now edit remaining fields
 D SETO K DR
 S DR="48;47;S FBUNITS=X;42R;S FBZIP=X;S:$$ANES^FBAAFS($$CPT^FBAAUTL4(FBAACP)) Y=""@2"";43///@;S FBTIME=X;S Y=""@3"";@2;43R;S FBTIME=X;@3"
 ; fb*3.5*116 remove edit of interest indicator (162.03,34) to prevent different interest indicator values at line item level; interest indicator set at invoice level only
 S DR(1,162.03,1)="S FBAAMM=$S(FBAAPTC=""R"":"""",1:1);D PPT^FBAACO1(FBAAMM1,FBCNTRP,1);34///@;34////^S X=FBAAMM1;54///@;54////^S X=FBCNTRP;30R;S FBHCFA(30)=X;1;S J=X;Q"
 ;S DR(1,162.03,1)="30R;S FBHCFA(30)=X;1;S J=X;Q"
 S DR(1,162.03,2)="D FEEDT^FBAACO3;44///@;44///^S X=FBFSAMT;45///@;45///^S X=FBFSUSD;S:FBAMTPD'>0!(FBAMTPD=FBAMTPD(0)) Y=""@4"";2///^S X=FBAMTPD;@4;2//^S X=FBAMTPD;D CHKIT^FBAACO3;S K=X"
 ;S DR(1,162.03,3)="3//^S X=$S(J-K:J-K,1:"""");4;S:X'=4 Y=6;22;6////^S X=DUZ;13;33"
 S DR(1,162.03,3)="K FBADJD;M FBADJD=FBADJ;S FBX=$$ADJ^FBUTL2(J-K,.FBADJ,2,,.FBADJD,1)"
 S DR(1,162.03,4)="S:FBFPPSC="""" Y=13;W !,""FPPS CLAIM ID: ""_FBFPPSC;S FBX=$$FPPSL^FBUTL5(FBFPPSL,,1);51///^S X=FBX;S FBFPPSL=X;@13;13;I $$BADDATE^FBAACO3(FBAADT,X) S Y=""@13"";33"
 S DR(1,162.03,5)="S:$$EXTPV^FBAAUTL5(FBPOV)=""01"" Y=""@1"";S Y=$S('$D(FB7078):28,FB7078]"""":31,1:28);@5;28R;S:$$INPICD9^FBCSV1(X,"""",$G(FBAADT)) Y=""@5"";31;32R;S Y=""@7"";@1;28;I X]"""" S:$$INPICD9^FBCSV1(X,"""",$G(FBAADT)) Y=""@1"";31"
 S DR(1,162.03,6)="@7;K FBRRMKD;M FBRRMKD=FBRRMK;S FBX=$$RR^FBUTL4(.FBRRMK,2,,.FBRRMKD)"
 S DR(1,162.03,7)="73;74;75;58;59;60;61;62;63;64;65;66;67;76;77;78;79;68;69"
 S DIE="^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,",DIE("NO^")="",FBOT=1
 D LOCK^FBUCUTL("^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,",FBAACPI) I 'FBLOCK S FBAAOUT=1 Q
 D ^DIE
 ; if adjustment data changed then file
 I $$ADJL^FBUTL2(.FBADJ)'=FBADJL(0) D FILEADJ^FBAAFA(FBAACPI_","_FBSDI_","_FBV_","_DFN_",",.FBADJ)
 ; if remit remark data changed then file
 I $$RRL^FBUTL4(.FBRRMK)'=FBRRMKL(0) D FILERR^FBAAFR(FBAACPI_","_FBSDI_","_FBV_","_DFN_",",.FBRRMK)
 L -^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI) K FBOT,DIE,DR,DA
 Q:$D(FBDL)
 I $G(FBAAIN) S FBINTOT=0 D CALC
 Q
 ;
BADDATE(FBDOS,INVRCVDT) ;Reject entry if InvRcvDt is Prior to the Date of Service on the Invoice
 I INVRCVDT<FBDOS D  Q 1 ;Reject entry
 .N SHOWDOS  S SHOWDOS=$E(FBDOS,4,5)_"/"_$E(FBDOS,6,7)_"/"_$E(FBDOS,2,3) ;Convert FBDOS into display format for error message
 .W *7,!!?5,"*** Invoice Received Date cannot be prior to the",!?8," Date of Service ("_SHOWDOS_") !!!"
 Q 0 ;Accept entry
 ;
SETO S FY=$E(FBAADT,1,3)+1700+$S($E(FBAADT,4,5)>9:1,1:0)
 Q
OUT ;
 ; FB*3.5*116 count line items that have 0.00 amount paid
 ;I K>0 S Z1=$P(^FBAA(161.7,FBAABE,0),"^",11)+1,$P(^(0),"^",11)=Z1,FBINTOT=FBINTOT+K
 S Z1=$P(^FBAA(161.7,FBAABE,0),"^",11)+1,$P(^(0),"^",11)=Z1,FBINTOT=FBINTOT+K
 Q
CKMAX S (FBAOT,A)=0,O="" F Z=S-.1:0 S Z=$O(^FBAAC(DFN,"AB",Z)) Q:Z'>0!(Z>R)  F Q=0:0 S Q=$O(^FBAAC(DFN,"AB",Z,Q)) Q:Q'>0  S W=$O(^FBAAC(DFN,"AB",Z,Q,0)) I $D(^FBAAC(DFN,1,Q,1,W,0)) D SMORE
 I A>$P(FBSITE(1),"^",9) G NO
 Q
SMORE N FBA,FBB S FBB=$P($G(^FBAAC(+DFN,1,+Q,1,+W,0)),U,4),E=0
 F  S E=$O(^FBAAC(DFN,1,Q,1,W,1,E)) Q:'E  S FBA=$G(^(E,0)) I $P(FBA,"^",9)=2,$P(FBA,"^",18)'=1 D
 .I $$IDCHK^FBAAUTL3(DFN,FBB) S A=A+$P(FBA,"^",3) Q
 .S FBAOT=FBAOT+$P(FBA,U,3)
 Q
NO W !!,*7,"Warning Patient already at maximum allowed for month of service",! Q
WARN W !!,*7,"You have reached the maximum number of payments for a Batch!",!,"You must select another Batch for entering Payments!"
CALC ;Calculate Current Invoice Total
 F J=0:0 S J=$O(^FBAAC("C",FBAAIN,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("C",FBAAIN,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("C",FBAAIN,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("C",FBAAIN,J,K,L,M)) Q:M'>0  D CALC1
 K J,K,L,M,FZNODE Q
CALC1 S FZNODE=^FBAAC(J,1,K,1,L,1,M,0),A2=$P(FZNODE,"^",3),FBINTOT=FBINTOT+A2,FBAAID=$P(FZNODE,"^",15),FBAAVID=$P($G(^FBAAC(J,1,K,1,L,1,M,2)),"^")
 Q
FEEDT ;
 ; input FB1725 - true (=1) when edited payment is for a Mill Bill claim
 N FBX
 D SETO:'$G(FY) S FBFY=FY-1
 S (FBFSAMT,FBFSUSD)="",FBAMTPD=$G(FBAMTPD)
 S FBX=$$GET^FBAAFS($$CPT^FBAAUTL4(FBAACP),$$MODL^FBAAUTL4("FBMODA","E"),FBAADT,$G(FBZIP),$$FAC^FBAAFS($G(FBHCFA(30))),$G(FBTIME))
 I '$G(FBAAMM1) D
 . S FBFSAMT=$P(FBX,U),FBFSUSD=$P(FBX,U,2)
 E  D
 . W !,?2,"Payment is for a contracted service so fee schedule does not apply."
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
 . S FBFSUNIT=$S(FBFSUSD="R":1,FBFSUSD="F"&(FBAADT>3040930):1,1:0)
 . I FBFSUNIT D
 . . S FBFSAMT=$J(FBFSAMT*FBUNITS,0,2)
 . . W !?2,"  Therefore, fee schedule amount increased to $",FBFSAMT
 . E  D
 . . W !?2,"  Fee schedule not complied on per unit basis so amount not adjusted by units."
 ;
 I '$G(FBAAMM1) D
 . ; set default amount paid to lesser of amt claimed (J) or fee sched.
 . S FBAMTPD=$S(FBFSAMT'>0:J,FBFSAMT>J:J,1:FBFSAMT)
 W !
 Q
CHKIT I X>FBAMTPD&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) W !!,"You must be a holder of the 'FBAASUPERVISOR' security key in order to",!,"exceed the Fee Schedule.",! S $P(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,0),"^",3)=K,Y=2 Q
 Q
NOGO W !!,*7,"This payment CANNOT be edited.  The batch the payment is in",!,"has been Vouchered.  You may void the payment with the Void Payment option.",!
 Q
 ;
SC W *7,!?4,"Suspense code is required!",! S Y="@4" Q
 ;
DEL ;delete date of service if no service provided entered
 I '$O(^FBAAC(DFN,1,FBV,1,FBSDI,1,0)) D
 .S DIK="^FBAAC(DFN,1,FBV,1,",DA(2)=DFN,DA(1)=FBV,DA=FBSDI D ^DIK W !!?5,*7,"Incomplete payment entry deleted.",!
 K DIK,DA Q
