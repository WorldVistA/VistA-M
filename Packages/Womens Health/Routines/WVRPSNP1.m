WVRPSNP1 ;HCIOFO/FT,JR-REPORT: SNAPSHOT OF PROGRAM ;7/7/99  11:14
 ;;1.0;WOMEN'S HEALTH;**7**;Sep 30, 1998
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  DISPLAY CODE FOR SNAPSHOT REPORT.  CALLED BY WVRPSNP.
 ;
 ;---> REQUIRED VARIABLES: WVDT=DATE SNAPSHOT WAS RUN.
 ;--->                     WVFAC=FACILITY IEN IN ^DIC(4 - DUZ(2)
 ;--->                     A-L,P,Q = FIELDS #.03-#.16 IN FILE 790.71
 ;
DISPLAY ;EP
 U IO
 S WVTOY=$S($D(WVTOY):WVTOY,1:M),WVPOP=0
 I '$D(WVJDT) S WVJDT=$S(WVTOY="C":WVDT,$E(WVDT,4,5)>9:WVDT,1:WVDT-10000)
 S WVJDTO=$S($G(WVTOY)="F":"Oct 1, ",1:"Jan 1, ")_($E($S($D(WVJDT):WVJDT,1:WVDT),1,3)+1700)_":"
 S WVJTOY=$S(WVTOY="F":"Fiscal Year",1:"Calendar Year")
 D HDR
 ;
 N X,Y
 W !
 S X="Total Active Women in Register:",Y=A D PNUM
 S X="Women Who Are Pregnant:",Y=B D PNUM
 ;S X="Woman Who Are DES Daughters:",Y=C D PNUM
 S X="Women with Cervical Tx Needs not specified or not dated:",Y=D
 D PNUM
 S X="Women with Cervical Tx Needs specified and past due:",Y=E D PNUM
 S X="Women with Breast Tx Needs not specified or not dated:",Y=F D PNUM
 S X="Women with Breast Tx Needs specified and past due:",Y=G D PNUM
 W !
 S X="Total Number of Procedures with a Status of ""OPEN"":",Y=H D DOTS
 S X="Number of OPEN Procedures Past Due (or not dated):",Y=S D DOTS
 W:'WVCRT !
 S X="Total Number of PAP Smears done since "_WVJDTO
 S Y=P D DOTS G:WVPOP=1 EXIT
 S X="Total Number of CBEs done since "_WVJDTO
 S Y=R D DOTS G:WVPOP=1 EXIT
 S X="Total Number of Mammograms done since "_WVJDTO
 S Y=Q D DOTS G:WVPOP=1 EXIT
 W !
 S X="Total Number of Notifications with a Status of ""OPEN"":",Y=J
 D DOTS G:WVPOP=1 EXIT
 S X="Number of OPEN Notifications Past Due (or not dated):",Y=K D DOTS G:WVPOP=1 EXIT
 S X="Number of Letters Queued (for later printing):",Y=L D DOTS G:WVPOP=1 EXIT
 I $G(WVDTIEN)>0 S WVJX=$G(^WV(790.71,WVDTIEN,2)) D
 .F P=1:1:30 S WVI(P)=$P(WVJX,U,P)
 W !!,"   REFUSALS for TREATMENT:"
 S X="Breast Ultrasounds:",Y=WVI(1) D DOTS G:WVPOP=1 EXIT
 S X="Clinical Breast Exams:",Y=WVI(2) D DOTS G:WVPOP=1 EXIT
 S X="Colposcopy Impression (No Bx):",Y=WVI(3) D DOTS G:WVPOP=1 EXIT
 S X="Colposcopy W/Biopsy:",Y=WVI(4) D DOTS G:WVPOP=1 EXIT
 S X="Cone Biopsy:",Y=WVI(5) D DOTS G:WVPOP=1 EXIT
 S X="Cryotherapy:",Y=WVI(6) D DOTS G:WVPOP=1 EXIT
 S X="Ectocervical Biopsy:",Y=WVI(7) D DOTS G:WVPOP=1 EXIT
 S X="Endocervical Currettage:",Y=WVI(8) D DOTS G:WVPOP=1 EXIT
 S X="Endometrial Biopsy:",Y=WVI(9) D DOTS G:WVPOP=1 EXIT
 S X="Fine Needle Aspiration:",Y=WVI(10) D DOTS G:WVPOP=1 EXIT
 S X="General Surgery Consults:",Y=WVI(11) D DOTS G:WVPOP=1 EXIT
 S X="Gyn Onc Consults:",Y=WVI(12) D DOTS G:WVPOP=1 EXIT
 S X="Hysterectomy:",Y=WVI(13) D DOTS G:WVPOP=1 EXIT
 S X="Laser Abilation:",Y=WVI(14) D DOTS G:WVPOP=1 EXIT
 S X="Laser Cone:",Y=WVI(15) D DOTS G:WVPOP=1 EXIT
 S X="Leep:",Y=WVI(16) D DOTS G:WVPOP=1 EXIT
 S X="Lumpectomy:",Y=WVI(17) D DOTS G:WVPOP=1 EXIT
 S X="Mammogram Dx Bilat:",Y=WVI(18) D DOTS G:WVPOP=1 EXIT
 S X="Mammogram Dx Unilat:",Y=WVI(19) D DOTS G:WVPOP=1 EXIT
 S X="Mammogram Screening:",Y=WVI(20) D DOTS G:WVPOP=1 EXIT
 S X="Mastectomy:",Y=WVI(21) D DOTS G:WVPOP=1 EXIT
 S X="Needle Biopsy:",Y=WVI(22) D DOTS G:WVPOP=1 EXIT
 S X="Open Biopsy:",Y=WVI(23) D DOTS G:WVPOP=1 EXIT
 S X="Pap Smear:",Y=WVI(24) D DOTS G:WVPOP=1 EXIT
 S X="Pelvic Ultrasound:",Y=WVI(29) D DOTS G:WVPOP=1 EXIT
 S X="Pregnancy Test:",Y=WVI(25) D DOTS G:WVPOP=1 EXIT
 S X="STD Evaluation:",Y=WVI(26) D DOTS G:WVPOP=1 EXIT
 S X="Stereotactic Biopsy:",Y=WVI(27) D DOTS G:WVPOP=1 EXIT
 S X="Tubal Ligation:",Y=WVI(28) D DOTS G:WVPOP=1 EXIT
 S X="Vaginal Ultrasound:",Y=WVI(30) D DOTS G:WVPOP=1 EXIT
SKIP D:'WVCRT
 .N WVTITLE S WVTITLE="-----  End of Report  -----"
 .D CENTERT^WVUTL5(.WVTITLE) W !!!,WVTITLE
 I WVCRT&('$D(IO("S"))) D DIRZ^WVUTL3 W @IOF
 D ^%ZISC
 Q
 ;
PNUM ;EP
 ;---> PATIENT NUMBERS
 W:'WVCRT ! W !?3,X W $$REPEAT^XLFSTR(" .",(58-$L(X))/2)
 W ?61,".",?62,$J(Y,5) W:A>0 ?69,$J(Y/A*100,3,0),"%"
 Q
 ;
DOTS ;EP
 I $Y+4>IOSL D:WVCRT&('$D(IO("S"))) DIRZ^WVUTL3 Q:$G(WVPOP)=1  D HDR
 W:'WVCRT ! W !?3,X W $$REPEAT^XLFSTR(" .",(58-$L(X))/2)
 W ?61,".",?62,$J(Y,5)
 Q
HDR ;EP
 S WVTITLE="* * *  PROGRAM SNAPSHOT FOR "_$$TXDT^WVUTL5(WVDT)_"  * * *"
 D CENTERT^WVUTL5(.WVTITLE)
 D TOPHEAD1^WVUTL7,HEADER6^WVUTL7
 Q
CH ;
 Q:$Y+4<IOSL
 I WVCRT&('$D(IO("S"))) D DIRZ^WVUTL3 W @IOF
 Q:WVPOP  D HDR
 Q
EXIT ;
 D ^%ZISC,KILLALL^WVUTL8 Q
 K ^TMP("WVF",$J),^TMP("WVREF",$J)
 Q
