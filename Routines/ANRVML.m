ANRVML ;AUG/JLTP - MAILING LABELS FOR VIST FM SORT ; 28 Apr 98 / 2:09 PM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
EN ;------ The print template should call this tag ------
 N ADD,AD1,AD2,CTY,ST,SN,ZIP
 D GETADR
PRINT ;
 I $D(NULL),NULL Q
 W !,DPT01 S LINE=1
 I $D(AD1),$L(AD1) W !,AD1 S LINE=LINE+1
 I $D(AD2),$L(AD2) W !,AD2 S LINE=LINE+1
 I $L(CTY)!$L(ST)!$L(ZIP) W ! S LINE=LINE+1
 W:$L(CTY) CTY_", " W:$L(ST) ST_" " W:$L(ZIP) ZIP
 F I=1:1:6-LINE W !
QUIT ;
 K DPT01,LINE,NULL
 Q
GETADR ;
 S NULL=0,DPT01=$P(^DPT(DFN,0),U),DPT01=$P(DPT01,",",2)_" "_$P(DPT01,",",1)
 D ADD^VADPT
 S AD1=VAPA(1),AD2=VAPA(2),CTY=VAPA(4),ZIP=VAPA(6)
 S ST=+VAPA(5) I ST S ST=$P(^DIC(5,ST,0),"^",2)
 I ST=0 S ST=""
 Q
TEST ;------ Call this line tag to test label alignment ------
 K DIR S DIR(0)="Y^A",DIR("A")="Do you want to test label alignment",DIR("B")="YES" D ^DIR G:$D(DUOUT)!$D(DTOUT) EXIT
 Q:Y=0
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="DEV^ANRVML",ZTDESC="PRINT TEST LABEL",ZTDTH=$H D ^%ZTLOAD Q
DEV  U IO D TLBL,^%ZISC Q
TLBL ;------ Print test label ------
 S DPT01="JOHN DOE"
 S AD1="ONE FREEDOM WAY"
 S AD2="APT C-13"
 S CTY="MUSKOGEE"
 S ST="OK"
 S ZIP=79285
 D PRINT
EXIT K AD1,AD2,CTY,DPT01,DTOUT,DUOUT,DIRUT,DIROUT,LINE,ST,ZIP Q
