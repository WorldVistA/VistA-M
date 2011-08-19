SCMSPX1 ;ALB/JRP - EXPORTED ROUTINE SDM WITH PATCH 41 APPLIED TO IT;03-JUL-96
 ;;5.3;Scheduling;**44**;AUG 13, 1993
SDM ;SF/GFT,ALB/BOK - MAKE AN APPOINTMENT ; 14 SEP 84  9:38 am
 ;;5.3;Scheduling;**5,32,38,41,44**;AUG 13, 1993
 ;                                           If defined...
 ; appt mgt vars:  SDFN := DFN of patient....will not be asked
 ;                SDCLN := ifn of clinic.....will not be asked    
 ;              SDAMERR := returned if error occurs
 ; 
 S:'$D(SDMM) SDMM=0
EN1 L  W !! D I^SDUTL I '$D(SDCLN) S DIC="^SC(",DIC(0)="AEMZQ",DIC("A")="Select CLINIC: ",DIC("S")="I $P(^(0),U,3)=""C""" D ^DIC K DIC G:Y<0!'$D(^("SL")) END
 K SDAPTYP,SDIN,SDRE,SDXXX S:$D(SDCLN) Y=+SDCLN
 I $D(^SC(+Y,"I")) S SDIN=+^("I"),SDRE=+$P(^("I"),U,2)
 K SDINA I $D(SDIN),SDIN S SDINA=SDIN K SDIN
 I $D(SD),$D(SC),+Y'=+SC K SD
 S SL=^SC(+Y,"SL"),X=$P(SL,U,3),STARTDAY=$S(X:X,1:8),SC=Y,SB=STARTDAY-1/100,X=$P(SL,U,6),HSI=$S(X=1:X,X:X,1:4),SI=$S(X="":4,X<3:4,X:X,1:4),STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz",SDDIF=$S(HSI<3:8/HSI,1:2) K Y
 I $D(^SC(+SC,"SDPROT")),$P(^("SDPROT"),U)="Y",'$D(^SC(+SC,"SDPRIV",DUZ)) W !,*7,"Access to this clinic is prohibited!!",!,"Only users with a special code may access this clinic",*7 S:$D(SDCLN) SDAMERR="" G END:$D(SDCLN),SDM
 D CS^SDM1A S SDW="",WY="Y"
 I '$D(ORACTION),'$D(SDFN) S (DIC,DIE)="^DPT(",DIC(0)="AQZME" D ^DIC S DFN=+Y G:Y<0 END:$D(SDCLN),^SDM0:X[U,SDM
 S:$D(SDFN) DFN=SDFN
 I $D(^DPT(DFN,.35)),$P(^(.35),U)]"" W !?10,*7,"PATIENT HAS DIED." S:$D(SDFN) SDAMERR="" G END:$D(SDFN),SDM
 D ^SDM4 I $S('$D(COLLAT):1,COLLAT=7:1,1:0) G:$D(SDCLN) END G SDM
 K SDXXX D EN G END:$D(SDCLN),SDM
EN K SDMLT1 W:$P(VAEL(9),U,2)]"" !!,?15,"MEANS TEST STATUS: ",$P(VAEL(9),U,2),!
 S Y=DFN,Y(0)=^DPT(DFN,0) I VADM(7)]"" W !?3,*7,VADM(7)
 I $D(^DGS(41.1,"B",DFN)) F I=0:0 S I=$N(^DGS(41.1,"B",DFN,I)) Q:I'>0  I $P(^DGS(41.1,I,0),U,2)'<DT&('$P(^DGS(41.1,I,0),U,13)) W !,"SCHEDULED FOR ADMISSION ON " S Y=$P(^(0),U,2) D DT^SDM0
PEND W:$N(^DPT(DFN,"S",DT))'>DT !,"NO PENDING APPOINTMENTS" I $N(^DPT(DFN,"S",DT))>DT R !,"DISPLAY PENDING APPOINTMENTS: NO//",X:DTIME S:X="^" SDMLT1=1 G END:X["^",HELP:"YN"'[X I X["Y" W $P("YES",X,2)
 I  F Y=DT:0 S Y=$N(^DPT(DFN,"S",Y)) Q:Y'>0  I "I"[$P(^(Y,0),U,2) D CHKSO W:$X>9 ! W ?11 D DT^SDM0 W ?32 S DA=+SSC W SDLN,$S($D(^SC(DA,0)):$P(^(0),U),1:"DELETED CLINIC "),COV,"  ",SDAT16
 ;Prompt for RACE if no value is currently on file
 S DA=DFN,DR=$S($P(^DPT(DFN,0),U,6)="":.06,1:"")
 I DR]"" S DIE="^DPT(" D ^DIE K DR
 S DA=DFN,DR=$S('$D(^DPT(DA,.11)):"[SDM1]",$P(^(.11),U)="":"[SDM1]",1:"")
 S DIE="^DPT(" D ^DIE:DR]"" K DR Q:$D(SDXXX)
E S Y=$P(SL,U,5)
 S SDW="" I $D(^DPT(DFN,.1)) S SDW=^(.1) W !,"NOTE - PATIENT IS NOW IN WARD "_SDW
 Q:$D(SDXXX)
EN2 F X=0:0 S X=$N(^DPT(DFN,"DE",X)) Q:'$D(^(X,0))  I ^(0)-SC=0!'(^(0)-Y) F XX=0:0 S XX=$N(^DPT(DFN,"DE",X,1,XX)) Q:XX<1  S SDDIS=$P(^(XX,0),U,3),SDPRCL=Y D WRT S Y=SDPRCL K SDPRCL G ^SDM0:'SDDIS
 W *7,!?9,"PATIENT NOT ENROLLED IN CLINIC!" S X=$S(VADM(5)["F":"ER",1:"IM") I '$D(^SC(+Y,0)) S Y=+SC
 S Y=$P(^SC(Y,0),U)
 ; SCRESTA = Array of pt's teams causing restricted consults
 N SCRESTA
 S SCREST=$$RESTPT^SCAPMCU4(DFN,DT,"SCRESTA")
 IF SCREST D
 .N SCTM
 . S SCCLNM=Y
 . W !,?5,"Patient has restricted consults due to team assignment(s):"
 .S SCTM=0
 .F  S SCTM=$O(SCRESTA(SCTM)) Q:'SCTM  W !,?10,SCRESTA(SCTM)
 IF SCREST&'$G(SCOKCONS) D  Q
 .W !,?5,"This patient may only be given appointments and enrolled in clinics via"
 .W !,?15,"Make Consult Appointment Option, and"
 .W !,?15,"Edit Clinic Enrollment Data option"
ENR S %="",DTOUT=0 W !?9,"WANT TO ENROLL H"_X_" IN "_Y D YN^DICN I '%,%Y]"" W !,"RESPOND YES (Y) OR NO (N)" G ENR
 Q:'DTOUT&(%<0)  G:(%-1) ASKC S SDY=Y
GETED D BEFORE^SCMCEV3(DFN)
 R !,?9,"DATE OF ENROLLMENT: NOW// ",X:DTIME Q:X["^"  S:X="" X="NOW" S %DT="EXT" D ^%DT G:Y<0 GETED S HEY=Y
 S DA=DFN,DR="3///"_SDY,(DIE,DIC)="^DPT(",DP=2,DR(2,2.001)=".01///"_SDY_";1///"_HEY,DR(3,2.011)=".01///"_HEY_";S DIE(""NO^"")="""";1" D ^DIE
 D MAIL^SCMCCON(DFN,.SCCLNM,1,DT,"SCRESTA")
 N TMPY
 I $D(Y) S TMPY=Y
 K DR,DP,SCCLNM,SCREST
 D AFTER^SCMCEV3(DFN),INVOKE^SCMCEV3(DFN)
 I $D(TMPY) S Y=TMPY
 I '$D(TMPY) K Y
 K TMPY
 G ^SDM0:'$D(Y)
 Q
 ;
ASKC S %="" W !,"WANT TO SCHEDULE PATIENT FOR CONSULT" D YN^DICN Q:%<0  I '% W !,"REPLY YES (Y) OR NO (N)" G ASKC
 Q:(%-1)  D:$G(SCREST) MAIL^SCMCCON(DFN,.SCCLNM,2,DT,"SCRESTA") K DR,SCREST,SCCLNM G ^SDM0
CHKSO S COV=$S($P(^DPT(DFN,"S",Y,0),U,11)=1:" (COLLATERAL)",1:""),HY=Y,SSC=^(0),SDAT16=$S($D(^SD(409.1,+$P(SSC,U,16),0)):$P(^(0),U),1:"")
 F SDJ=3,4,5 I $P(^DPT(DFN,"S",HY,0),U,SDJ)]"" S Y=$P(^(0),U,SDJ) W:$X>9 ! W ?10,"*" D DT^SDM0 W ?32,$S(SDJ=3:"LAB",SDJ=4:"XRAY",1:"EKG")
 S SDLN="" F J=0:0 S J=$N(^SC(+SSC,"S",HY,1,J)) Q:J<0  I $D(^(J,0)),+^(0)=DFN S SDLN="("_$P(^(0),U,2)_" MINUTES) " Q
 S Y=HY Q
END D KVAR^VADPT K SDAPTYP,SDSC,%,%DT,ASKC,COV,DA,DIC,DIE,DP,DR,HEY,HSI,HY,J,SB,SC,SDDIF,SDJ,SDLN,SD17,SDMAX,SDU,SDYC,SI,SL,SSC,STARTDAY,STR
 K WY,X,XX,Y,S,SD,SDAP16,SDEDT,SDTY,SM,SS,ST,ARG,CCX,CCXN,HX,I,PXR,SDINA,SDW,COLLAT,SDDIS I $D(SDMM) K:'SDMM SDMM
 I '$D(SDMLT) K SDMLT1
 Q
OERR S XQORQUIT=1 Q:'$D(ORVP)  S DFN=+ORVP G SDM
HELP W !,"YES - TO DISPLAY FUTURE APPOINTMENTS",!,"NO - FUTURE APPOINTMENTS NOT DISPLAYED" G PEND
WRT W !,$S('SDDIS:"CURRENT  ",1:"PREVIOUS "),"ENROLLMENT: ",$S($P(^DPT(DFN,"DE",X,1,XX,0),U,2)["O":"OPT",1:"AC") I SDDIS W ?41,"DISCHARGED FROM CLINIC: " S Y=SDDIS D DT^DIQ
 Q
