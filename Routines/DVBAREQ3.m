DVBAREQ3 ;ALB/GTS-557/THM-PRINT ROUTINE NEW REQUEST RPT ;21 JUL 89
 ;;2.7;AMIE;**17,160**;Apr 10, 1995;Build 1
 ;
PRINT S:$D(DVBATASK) ^TMP($J,LPDIV,DA)="" ;**Only 1 7131 printed per division
 S:'$D(DVBATASK) ^TMP($J,DA)="" ;**Only 1 7131 printed.
 S DFN=$P(^DVB(396,DA,0),U,1),ADMDT=$P(^(0),U,4),RDATE=$P(^(1),U,1),PNAM=$P(^DPT(DFN,0),U,1),SSN=$P(^(0),U,9),CNUM=$S($D(^(.31)):$P(^(.31),U,3),1:"Unknown"),DOCTYPE=$P(^DVB(396,DA,2),U,10)
 S ADIV=$S($D(^DVB(396,DA,2)):$P(^(2),U,9),1:"")
 I DVBSEL="D" Q:'$D(XDIV)  D HEADER
 I DVBSEL="N" D HEADER2
 S NODTA=1
 W !,PNAM,?49,"SSN: ",SSN,!,?44,"CLAIM NO: ",CNUM,!,?38,$S(DOCTYPE="L":" ACTIVITY DATE: ",1:"ADMISSION DATE: "),$$FMTE^XLFDT(ADMDT,"5DZ"),!
 W ?40,"REQUEST DATE: ",$$FMTE^XLFDT(RDATE,"5DZ"),!!,?3,"Items Requested:",!
 ;
ITEMS F Q=5,6,7,8,16,18,20,22,24,27 I $P(^DVB(396,DA,0),U,Q)'="NO" D PRINT1
 I $P(^DVB(396,DA,0),U,25)'="" S Q=25 D GETDIV S MC=$T(@Q),MD=$P(MC,";;",2) S GDIV=" ("_$E(GDIVNAM,1,(20+(23-$L(MC))))_")" W !,?8,MD,GDIV,": ",$P(^DVB(396,DA,0),U,25)
 S DVBAWO="N"
 K ^UTILITY($J,"W") W !!,"Remarks: " S DIWL=5,DIWR=65,DIWF="WB5I9"
 F LPCNT=1:1 Q:'$D(^DVB(396,DA,5,LPCNT,0))  S X=$G(^DVB(396,DA,5,LPCNT,0)) D ^DIWP S DVBAWO="Y"
 K LPCNT,DIWL,DIWR,DIWF
 I DVBAWO="Y" D ^DIWW
 K DVBAWO W !! W:$D(^DVB(396,DA,2)) "Requested by: ",$S($P(^DVB(396,DA,2),U,8)]"":$P(^(2),U,8),1:" (Not specified)")," AT ",$S($P(^(2),U,7)]"":$P(^(2),U,7),1:" (Not specified) "),!
 I $D(^DVB(396,DA,1)) I $P(^DVB(396,DA,1),U,12)'="" S FNLDT=$P(^(1),U,12) W !!,"This record was FINALIZED on ",$$FMTE^XLFDT(FNLDT,"5DZ")
 I ADIV="" W !,?5,"**Request is incomplete, contact the Regional Office to complete**"
 I IOST?1"PK-"!(IOST?1"P-") W !!!!!,"Record Processing Notes: " F LN=1:1:50 W "-" ;print processing notes for admin folder if not going to a screen
 W !! D TOP
 Q
 ;
HEADER W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 W !!!!!,"AMIE 7131 NEW REQUEST REPORT FOR ",$$FMTE^XLFDT(BDT,"5DZ")," TO ",$$FMTE^XLFDT(EDT,"5DZ")_" * LONG VERSION *",!
 I ADIV="" W ?5,"FOR ",HOSP,", DIVISION NOT GIVEN"
 I ADIV'="" S DIVHD=$S($D(^DG(40.8,ADIV,0)):$P(^(0),U,1),1:"") W ?5,"FOR ",HOSP W:DIVHD]"" ", DIVISION ",DIVHD,!! I DIVHD="" W ", UNABLE TO DETERMINE DIVISION",!!
 S DVBAON2=""
 Q
 ;
PRINT1 D GETDIV
 I QQ S MC=$T(@Q),MD=$P(MC,";;",2) S GDIV=" ("_$E(GDIVNAM,1,(9+(23-$L(MD))))_")" W !,?8,MD,GDIV S QQ='QQ Q
 I 'QQ S MC=$T(@Q),MD=$P(MC,";;",2) S GDIV=" ("_$E(GDIVNAM,1,(9+(22-$L(MD))))_")" W ?46,MD,GDIV S QQ='QQ
 Q
 ;
TOP K ANS I IOST?1"C-".E,'$D(NOASK) W !!,*7,"Press RETURN to continue or ""^"" to stop   " R ANS:DTIME S:'$T ANS=U I ANS=U S DA="",MA=9999999
 Q
 ;
HEADER2 ;prints a heading for the name selection
 I IOST?1"C-".E!($D(DVBAON2)) DO
 .S VAR(1,0)="0,0,0,0,1^"
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .Q
 S VAR(1,0)="0,0,0,4:1,0^AMIE 7131 NEW REQUEST REPORT FOR "_PNAM_" **Long Version**"
 I ADIV="" S VAR(2,0)="0,0,5,0,0^FOR "_HOSP_", DIVISION NOT GIVEN"
 I ADIV'="" DO
 .S DIVHD=$S($D(^DG(40.8,ADIV,0)):$P(^(0),U,1),1:"")
 .S VAR(2,0)="0,0,5,1:2,0^FOR "_HOSP_", DIVISION "_$S(DIVHD]"":DIVHD,1:"UNABLE TO DETERMINE")
 .Q
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
 ;
GETDIV ;** Get the division for 7131 Rpt
 I $D(^DVB(396,DA,6)) DO
 .I Q=5 S GDIVPTR=$P(^DVB(396,DA,6),"^",9)
 .I Q=6 S GDIVPTR=$P(^DVB(396,DA,6),"^",11)
 .I Q=7 S GDIVPTR=$P(^DVB(396,DA,6),"^",13)
 .I Q=8 S GDIVPTR=$P(^DVB(396,DA,6),"^",15)
 .I Q=24 S GDIVPTR=$P(^DVB(396,DA,6),"^",7)
 .I Q>15&(Q'=24) DO
 ..S DVBAPCE=Q+1
 ..S GDIVPTR=$P(^DVB(396,DA,6),"^",DVBAPCE)
 ..K DVBAPCE
 S:'$D(GDIVPTR) GDIVPTR=$P(^DVB(396,DA,2),"^",9)
 I $D(GDIVPTR),(GDIVPTR="") S GDIVPTR=$P(^DVB(396,DA,2),"^",9)
 S GDIVNAM=$P(^DG(40.8,GDIVPTR,0),"^",1)
 K GDIVPTR
 Q
 ;
FIELDS ;
5 ;;NOTICE OF DISCHARGE
6 ;;HOSPITAL SUMMARY
7 ;;21-DAY CERTIFICATE
8 ;;OTHER/EXAM REVIEW RMKS
16 ;;SPECIAL REPORT
18 ;;COMPETENCY REPORT
20 ;;VA FORM 21-2680
22 ;;ASSET INFORMATION
24 ;;ADMISSION REPORT
25 ;;OPT TREATMENT REPORT
27 ;;BEGINNING DATE/CARE
 Q
