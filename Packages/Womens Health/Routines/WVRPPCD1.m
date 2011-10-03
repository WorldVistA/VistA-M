WVRPPCD1 ;HCIOFO/FT,JR-REPORT: PROCEDURE STATISTICS; ;7/24/01  13:55
 ;;1.0;WOMEN'S HEALTH;**4,12**;Sep 30, 1998
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  DISPLAY CODE FOR PROCEDURE STATISTICS REPORT.  CALLED BY WVRPPCD.
 ;
 ; This routine uses the following IAs:
 ; <NONE>
 ;
DISPLAY ;EP
 ;---> WVTITLE=TITLE AT TOP OF DISPLAY HEADER.
 ;---> WVSUBH=CODE TO EXECUTE FOR SUBHEADER (COLUMN TITLES).
 ;---> WVCRT=1 IF OUTPUT IS TO SCREEN (ALLOWS SELECTIONS TO EDIT).
 ;
 U IO
 W:$E(IOST)="C" @IOF
 S WVTITLE="* * *  WOMEN'S HEALTH: PROCEDURE STATISTICS REPORT  * * *"
 D CENTERT^WVUTL5(.WVTITLE)
 S WVSUBH="SUBHEAD^WVRPPCD1"
 D TOPHEAD^WVUTL7
 S (WVPOP,N)=0
 ;
DISPLAY1 ;EP
 N WVFAC,WVSB1
 S FE="",WVFAC=0
 F  S FE=$O(^TMP("WVAR",$J,FE)) Q:FE=""!(WVPOP)!($G(ZTSTOP)=1)  S FI=0 F  S FI=$O(^TMP("WVAR",$J,FE,FI)) Q:'FI!(WVPOP)!($G(ZTSTOP)=1)  D
 .I WVFAC'=FI D:WVCRT&(WVFAC) DIRZ^WVUTL3 Q:WVPOP  S WVFAC=FI D HEADER3 Q:$G(ZTSTOP)=1
 .S N=0 F  S N=$O(^TMP("WVAR",$J,FE,FI,N)) Q:N=""!(WVPOP)  D
 ..I $Y+12>IOSL D:WVCRT DIRZ^WVUTL3 Q:WVPOP  D  Q:$G(ZTSTOP)=1
 ...S WVPAGE=WVPAGE+1
 ...D HEADER3 Q:$G(ZTSTOP)=1
 ..S Y=^TMP("WVAR",$J,FE,FI,N)
 ..S WVARJ=$S($P(Y,U)["MAMMOGRAM":1,$P(Y,U)["ULTRASOUND":1,1:0)
 ..S WVAGRP=$$WVAGRP($P(Y,U,16))
 ..;---> QUIT IF DISPLAYING "ALL AGES" ONLY (NOT GROUPED BY AGE).
 ..Q:WVAGRP=1
 ..S WVPCD="< "_$P(Y,U)_": "_WVAGRP_" >",WVPCDL=$L(WVPCD)
 ..S X=$E(WVLINE,1,31-(WVPCDL/2))
 ..W !!?2,X,WVPCD,X
 ..I WVARJ W !?68," CREDIT"
 ..W !?28,"COUNT",?43,"VETS",?56,"NON-VETS"
 ..I WVARJ W ?66," REG.   NO CR"
 ..W !?26,"----------",?40,"----------",?55,"----------"
 ..I WVARJ W ?67,"-----  -----"
 ..D VERTICAL
 ..Q
 .Q
 I WVPOP!($G(ZTSTOP)=1) D ^%ZISC Q
 D FACLIST^WVRPPCD3
 N WVNAME,WVIEN,WVCNT,WVCNT1
 S WVNAME="",WVCNT=0
 F  S WVNAME=$O(WVSB1(WVNAME)) Q:WVNAME=""  D
 .S WVIEN=0
 .F  S WVIEN=$O(WVSB1(WVNAME,WVIEN)) Q:'WVIEN  D
 ..Q:$D(^TMP("WVAR",$J,WVNAME,WVIEN))
 ..S WVCNT=WVCNT+1
 ..Q
 .Q
 I WVCNT=0 G JUMP2
 I '$D(^TMP("WVAR",$J)) G JUMP1
 I WVCRT&('$D(IO("S")))&('WVPOP) D DIRZ^WVUTL3 D  Q:WVPOP
 .D:WVPOP ^%ZISC
 .Q
JUMP1 ;
 S WVNAME="",WVCNT1=0
 F  S WVNAME=$O(WVSB1(WVNAME)) Q:WVNAME=""!(WVPOP)!($G(ZTSTOP)=1)  D
 .S WVIEN=0
 .F  S WVIEN=$O(WVSB1(WVNAME,WVIEN)) Q:'WVIEN!(WVPOP)!($G(ZTSTOP)=1)  D
 ..Q:$D(^TMP("WVAR",$J,WVNAME,WVIEN))
 ..S WVCNT1=WVCNT1+1,WVPAGE=1
 ..D HEADER4
 ..Q:$G(ZTSTOP)=1
 ..Q:WVCNT=WVCNT1
 ..I WVCRT&('$D(IO("S")))&('WVPOP) D DIRZ^WVUTL3
 ..Q
 .Q
JUMP2 ;
 I WVPOP!($G(ZTSTOP)=1) D ^%ZISC Q
 I $O(^TMP("WVNOHCF",$J,0))'>0 D ENDREP^WVUTL7() Q
 I WVCRT&('$D(IO("S")))&('WVPOP) D DIRZ^WVUTL3 D  Q:WVPOP
 .D:WVPOP ^%ZISC
 .Q
JUMP3 ;
 D NOFAC^WVRPPCD3 ;records with no facility
 D ENDREP^WVUTL7()
 Q
 ;
VERTICAL ;EP
 ;---> DISPLAY IN VERTICAL FORMAT.
 F X=1:1:24 S:$P(Y,U,X)="" $P(Y,U,X)=0
 F X=25:1:40 S:$P(Y,U,X)'>0 $P(Y,U,X)=""
 D PG
 W !?14,$S($P(Y,U)="PREGNANCY TEST":"NOT PREG",1:"NORMAL:")
 W ?24,$J($P(Y,U,4),5),?30,"(",$J($P(Y,U,5),3),"%)"
 W ?38,$J($P(Y,U,17),5),?44,PG(1),?47,$J($P(Y,U,4)-$P(Y,U,17),8)
 W ?59,PG(2)
 I WVARJ W ?64,$J($P(Y,U,25),5),?72,$J($P(Y,U,33),5)
 W !?2,"PROCEDURES"
 W ?14,$S($P(Y,U)="PREGNANCY TEST":"PREGNANT:",1:"ABNORMAL:")
 W ?24,$J($P(Y,U,8),5),?30,"(",$J($P(Y,U,9),3),"%)"
 W ?38,$J($P(Y,U,19),5),?44,PG(3),?47,$J($P(Y,U,8)-$P(Y,U,19),8)
 W ?59,PG(4)
 I WVARJ W ?64,$J($P(Y,U,27),5),?72,$J($P(Y,U,35),5)
 W !?14,"NO RESULT:",?24,$J($P(Y,U,12),5),?30,"(",$J($P(Y,U,13),3),"%)"
 W ?38,$J($P(Y,U,21),5),?44,PG(5),?47,$J($P(Y,U,12)-$P(Y,U,21),8)
 W ?59,PG(6)
 I WVARJ W ?64,$J($P(Y,U,29),5),?72,$J($P(Y,U,37),5)
 W !?14,"TOTAL:",?24,$J($P(Y,U,15),5),?38,$J($P(Y,U,23),5)
 W ?44,PG(7),?47,$J($P(Y,U,15)-$P(Y,U,23),8)
 W ?59,PG(8)
 I WVARJ W ?64,$J($P(Y,U,31),5),?72,$J($P(Y,U,39),5)
 W !!?14,$S($P(Y,U)="PREGNANCY TEST":"NOT PREG:",1:"NORMAL:")
 W ?24,$J($P(Y,U,2),5),?30,"(",$J($P(Y,U,3),3),"%)"
 W ?38,$J($P(Y,U,18),5),?44,PG(9),?47,$J($P(Y,U,2)-$P(Y,U,18),8)
 W ?59,PG(10)
 I WVARJ W ?64,$J($P(Y,U,26),5),?72,$J($P(Y,U,34),5)
 W !?2,"PATIENTS"
 W ?14,$S($P(Y,U)="PREGNANCY TEST":"PREGNANT:",1:"ABNORMAL:")
 W ?24,$J($P(Y,U,6),5),?30,"(",$J($P(Y,U,7),3),"%)"
 W ?38,$J($P(Y,U,20),5),?44,PG(11),?47,$J($P(Y,U,6)-$P(Y,U,20),8)
 W ?59,PG(12)
 I WVARJ W ?64,$J($P(Y,U,28),5),?72,$J($P(Y,U,36),5)
 W !?14,"NO RESULT:",?24,$J($P(Y,U,10),5),?30,"(",$J($P(Y,U,11),3),"%)"
 W ?38,$J($P(Y,U,22),5),?44,PG(13),?47,$J($P(Y,U,10)-$P(Y,U,22),8)
 W ?59,PG(14)
 I WVARJ W ?64,$J($P(Y,U,30),5),?72,$J($P(Y,U,38),5)
 W !?14,"TOTAL:",?24,$J($P(Y,U,14),5),?38,$J($P(Y,U,24),5)
 W ?44,PG(15),?47,$J($P(Y,U,14)-$P(Y,U,24),8)
 W ?59,PG(16)
 I WVARJ W ?64,$J($P(Y,U,32),5),?72,$J($P(Y,U,40),5)
 Q
PG ;FIGURES %'S FOR VETS & NON VETS
 F JC=1:1:25 S PG(JC)=0
 I $P(Y,U,4)'=0 S PG(1)=100*$P(Y,U,17)/$P(Y,U,4)
 I $P(Y,U,8)'=0 S PG(3)=100*$P(Y,U,19)/$P(Y,U,8)
 I $P(Y,U,12)'=0 S PG(5)=100*$P(Y,U,21)/$P(Y,U,12)
 I $P(Y,U,15)'=0 S PG(7)=100*$P(Y,U,23)/$P(Y,U,15)
 I $P(Y,U,2)'=0 S PG(9)=100*$P(Y,U,18)/$P(Y,U,2)
 I $P(Y,U,6)'=0 S PG(11)=100*$P(Y,U,20)/$P(Y,U,6)
 I $P(Y,U,10)'=0 S PG(13)=100*$P(Y,U,22)/$P(Y,U,10)
 I $P(Y,U,14)'=0 S PG(15)=100*$P(Y,U,24)/$P(Y,U,14) D T
 S PG(2)=$S($P(Y,U,4)'=0:100-PG(1),1:0)
 S PG(4)=$S($P(Y,U,8)'=0:100-PG(3),1:0)
 S PG(6)=$S($P(Y,U,12)'=0:100-PG(5),1:0)
 S PG(8)=$S($P(Y,U,15)'=0:100-PG(7),1:0)
 S PG(10)=$S($P(Y,U,2)'=0:100-PG(9),1:0)
 S PG(12)=$S($P(Y,U,6)'=0:100-PG(11),1:0)
 S PG(14)=$S($P(Y,U,10)'=0:100-PG(13),1:0)
 S PG(16)=$S($P(Y,U,14)'=0:100-PG(15),1:0)
 ;PAD %'S WITH BLANKS
 F JC=1:1:16 S PG(JC)="  "_PG(JC) D
 .S PG(JC)=$E(PG(JC),$L(PG(JC))-2,$L(PG(JC)))
 .S PG(JC)="("_PG(JC)_"%)"
 Q
T ;ELIMINTE DECIMAL POINT IN %
 N S F S=1,3,5,7,9,11,13,15 D
 .S:$E($P(PG(S),".",2))'<.5 PG(S)=PG(S)+1 S PG(S)=$P(PG(S),".")
 Q
 ;
WVAGRP(AGE) ;EP
 ;Q:AGE="ALL" "All ages"
 Q:AGE="ALL" $S(WVAGRP'=1:"Total for selected ages",1:"All ages")
 Q:AGE=1 1
 N I,X,Y,Z S X=WVAGRG
 F I=1:1:$L(X,",")  S Y=$P($P(X,",",I),"-",2)  Q:AGE'>Y
 S Z=$P($P(X,",",I),"-")
 Q:AGE<Z "Under "_Y_" yrs"
 Q:AGE>Y "Over "_Y_" yrs"
 Q $P(X,",",I)_" yrs"
 ;---> PUT A FINAL CHECK IN HERE??  *COMEBACK
 Q "Unknown age"
 ;
 ;
SUBHEAD ;EP
 ;---> SUB HEADER FOR PROCEDURE BROWSE OUTPUT.
 W !?5,"NOTE: Patient numbers are not intended to total.  "
 W "Patients may be"
 W !,"           included in more than one category.",!
 W $$REPEAT^XLFSTR("=",80)
 Q
HEADER3 ;EP
 ;---> REQUIRED VARIABLES: WVBEGDT,WVCRT,WVENDDT,WVPAGE,WVTITLE,DUZ(2)
 ;---> OPTIONAL VARIABLE:  WVSUBH (SUBHEADER).
 N X
 W:$Y>0 @IOF
 W !,WVTITLE,?70,"page: ",WVPAGE
 W !,$$RUNDT^WVUTL1A("C")
 W !!,"Facility: ",$$INSTTX^WVUTL6($S($G(WVFAC):WVFAC,1:DUZ(2)))
 W ?53,"From: ",$$SLDT2^WVUTL5(WVBEGDT)
 W " to ",$$SLDT2^WVUTL5(WVENDDT)
 W !,$$REPEAT^XLFSTR("=",80)
 I $D(WVSUBH) D @WVSUBH
 I $D(ZTQUEUED) D STOPCHK^WVUTL10(1) Q:$G(ZTSTOP)=1
 Q
HEADER4 ; Header and message for facilities without data
 N X
 W:$Y>0 @IOF
 W !,WVTITLE,?70,"page: ",WVPAGE
 W !,$$RUNDT^WVUTL1A("C")
 W !!,"Facility: "_WVNAME
 W ?53,"From: ",$$SLDT2^WVUTL5(WVBEGDT)
 W " to ",$$SLDT2^WVUTL5(WVENDDT)
 W !,$$REPEAT^XLFSTR("=",80)
 I $D(ZTQUEUED) D STOPCHK^WVUTL10(1) Q:$G(ZTSTOP)=1
 W !!?5,"No records match the selected criteria for this facility.",!
 Q
