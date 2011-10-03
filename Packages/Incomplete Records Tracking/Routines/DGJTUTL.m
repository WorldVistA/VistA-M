DGJTUTL ;ALB/MIR - ZSECUTABLE HELP FOR EVENT DATE IN INCOMPLETE RECORD FILE ; 04 JAN 91
 ;;1.0;Incomplete Records Tracking;;Jun 25, 2001
 N DFN,I,J,OK,PTF S DFN=+^VAS(393,DA,0)
 D WARN
 ;
 W !,"Choose from:"
 F I=0:0 S I=$O(^UTILITY("DGJTADM",$J,I)) Q:'I  S Y=+^DGPM(I,0) X ^DD("DD") W !?5,Y
 ;
PTF ;Check to make sure PTF exists and it is not closed
 S OK=$S('$D(^DGPT(+PTF)):0,$D(^DGP(45.84,+PTF)):0,1:1)
 Q
PHYSRTRG S DGJTEST=$P(^VAS(393,D0,0),"^",11) S X=$S(DGJTEST=$O(^DG(393.2,"B","TRANSCRIBED",0)):0,DGJTEST=$O(^DG(393.2,"B","SIGNED",0)):0,DGJTEST=$O(^DG(393.2,"B","REVIEWED",0)):0,1:1) K DGJTEST Q
LESS48 ;Checking for discharge summary less than 48 hours.
 I $D(^VAS(393,DA,"DT")),$P(^("DT"),"^",1)]"" S X=0 Q
 S (DGJTX4,X1)=$P(^DGPM(+$P(DGJTNO,"^",4),0),"^",1),DGJTX3=+$P(DGJTNO,"^",3) S X2=2 D C^%DTC I DGJTX3<X&($P(DGJTNO,"^",3)>DGJTX4) D ASK K DGJTX3,DGJTX4
 Q
ASK W !!,"Will this Discharge Summary <48 hrs need to be dictated? "
 S %=2 D YN^DICN I '% W !,"ENTER:",!?10,"Y for YES",!?10,"N for NO",!?10,"^ to EXIT" G ASK
 S X=$S(%=2:1,%=-1:"-1",1:0)
 Q
TS D FULL^VALM1 D EXP^DGJTEE1 G TSQ
TSQ D EVDT^DGJTEE S VALMBG=1,VALMBCK="R" Q
WARN K ^UTILITY("DGJTADM",$J)
 S DGJTCNT=0 F I=0:0 S I=$O(^DGPM("ATID1",DFN,I)) Q:'I  S IFN=$O(^(I,0)) I $D(^DGPM(IFN,0)),($P(^(0),"^",2)=1) S DGJTCNT=DGJTCNT+1,^UTILITY("DGJTADM",$J,DGJTCNT,IFN)=""
 I '$D(^UTILITY("DGJTADM",$J)) W !!,*7,"   Patient has no admissions on file in this facility",! Q
 K OK,I,PTF
 Q
 ;
 ;
WR ;write node from delinquent records file
 N X,Y
 S X=$P(DGJT,"^",2)
 W $S(X]""&($D(^VAS(393.3,+X,0))):$P(^VAS(393.3,+X,0),"^",1),1:"UNKNOWN DEFICIENCY")
 S Y=$P(DGJT,"^",3) I Y]"" X ^DD("DD") W ?45,Y
 Q
 ;
 ;
WARD ; -- find last ward for event driver
 ; input CA = ifn of cors adm
 N IDT,MVT,M
 S X=""
 F IDT=0:0 S IDT=$O(^DGPM("APMV",DFN,CA,IDT)) Q:'IDT  F MVT=0:0 S MVT=$O(^DGPM("APMV",DFN,CA,IDT,MVT)) Q:'MVT  I $D(^DGPM(MVT,0)) S M=^(0) I "^13^43^44^45^"'[(U_$P(M,U,18)_U),$D(^DIC(42,+$P(M,U,6),0)) S X=+$P(M,U,6) G WARDQ
WARDQ Q
PHYDEF ;Cross-reference on the Date Transcribed,10.03; Transcribed By,10.04
 ; Date Signed,10.05; Signed By,10.06
 ;to update the Physician for Deficiency field (#.14)
 ;in the Incomplete Records Tracking file (#393)
 N DGJX,DGJTNOD,DGJTDV,DGJTDN,DGJTPD,DGJNDT
 S DGJTNOD=$G(^VAS(393,DA,0)),DGJTDV=$P(DGJTNOD,"^",6)
 S DGJTDV=$G(^DG(40.8,DGJTDV,"DT"))
 I $D(DGJATTD) I $P(DGJTNOD,"^",11)=$O(^DG(393.2,"B","TRANSCRIBED",0))&($P(DGJTDV,"^",10)="A")!($P(DGJTNOD,"^",11)=$O(^DG(393.2,"B","SIGNED",0))&($P(DGJTDV,"^",4)="A")) S DGJX=$P(DGJTNOD,"^",10) D SET K DGJATTD Q
 S DGJTPD=$P(DGJTNOD,"^",14)
 S DGJNDT=$G(^VAS(393,DA,"DT"))
 I $D(DGJFDIC) D  K DGJFDIC Q
 .S DGJX=$S($P(DGJNDT,"^",2)]""&($P(DGJNDT,"^",1)]""):$P(DGJNDT,"^",2),$P(DGJTNOD,"^",12)]"":$P(DGJTNOD,"^",12),1:$P(DGJTNOD,"^",9)) D SET Q
 I $D(DGJFSIG) D  K DGJFSIG Q
 .I $P(DGJNDT,"^",3)']""!($P(DGJNDT,"^",4)']"") S DGJX=$S($P(DGJNDT,"^",2)]"":$P(DGJNDT,"^",2),$P(DGJTNOD,"^",12)]"":$P(DGJTNOD,"^",12),1:$P(DGJTNOD,"^",9)) D SET Q
 .S DGJX=$S($P(DGJTDV,"^",10)="P":$P(DGJTNOD,"^",9),$P(DGJTDV,"^",10)="A":$P(DGJTNOD,"^",10),1:"") Q:DGJX=DGJTPD  D SET Q
 I $D(DGJFREV) D  K DGJFREV Q
 .I $P(DGJNDT,"^",5)']""!($P(DGJNDT,"^",6)']"") I $P(DGJNDT,"^",2)]"" S DGJX=$S($P(DGJTDV,"^",10)="P":$P(DGJTNOD,"^",9),$P(DGJTDV,"^",10)="A":$P(DGJTNOD,"^",10),1:"") D SET Q
 .I $P(DGJNDT,"^",5)']""!($P(DGJNDT,"^",6)']"") I $P(DGJNDT,"^",2)']"" S DGJX=$S($P(DGJTNOD,"^",12)]"":$P(DGJTNOD,"^",12),$P(DGJTNOD,"^",9)]"":$P(DGJTNOD,"^",9),1:"") D SET Q
 .S DGJX=$S($P(DGJTDV,"^",3)=0:$P(DGJNDT,"^",6),$P(DGJTDV,"^",4)="P":$P(DGJTNOD,"^",9),$P(DGJTDV,"^",4)="A":$P(DGJTNOD,"^",10),1:"") D SET Q
 I $D(DGJREVD) D  K DGJREVD Q
 .I $P(DGJNDT,"^",7)']""!($P(DGJNDT,"^",8)']"") S DGJX=$S($P(DGJTDV,"^",4)="P":$P(DGJTNOD,"^",9),$P(DGJTDV,"^",4)="A":$P(DGJTNOD,"^",10),1:"") D SET Q
 .S DGJX=$S($P(DGJNDT,"^",7)]""&($P(DGJNDT,"^",8)]""):$P(DGJNDT,"^",8),$P(DGJTDV,"^",4)="P":$P(DGJTNOD,"^",9),$P(DGJTDV,"^",4)="A":$P(DGJTNOD,"^",10),1:"") D SET Q
 Q
SET S $P(^VAS(393,DA,0),"^",14)=DGJX Q
Q K DGJTDV,DGJTDEL
QUIT K DA,DFN,DIC,DIE,DIR,DR,DTOUT,I,IFN,PTF,VAIP,DGA1,DGJC,DGJT,DGJTADN,DGJTAIFN,DGJTADTP,DGJTAT,DGJTCNT,DGJTCT,DGJTDT,DGJTDBY,DGJTDD,DGJTEDT,DGJTOUT,DGJTOA,DGJTOUT,DGJTRC,DGJTSBY,DGJTSDT,DGJTSP,DGJTSV,DGJTST,DGJTTBY,DGJTWD1,DGJFFL,DGJTPR
 K DGT,DGJTCFLG,DGJTSDT,DGJTTBY,DGJTTD,DGJTYP,DGJTWD,DGJTX,DGPM2X,DGPMCA,DGPMDCD,DGPMT,DGPMVI,DGPMY,DIV,X,^UTILITY("DGJTADM",$J),Y,OK,POP,VAERR,DGJT1PH,DGJT2PH,DGJTCH,DGJTCH1,DGJTFG,DGJTFL,DGJTDDT,DGJTF,VAINDT
 K DIC("S"),DIC("A") Q
