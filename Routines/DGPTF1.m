DGPTF1 ;ALB/JDS - PTF ENTRY/EDIT ; 5/17/05 3:29pm
 ;;5.3;Registration;**69,114,195,397,342,415,565,664**;Aug 13, 1993;Build 15
 ;
 I '$D(IOF) S IOP="HOME" D ^%ZIS K IOP
 S:'$D(IOST) IOST="C" S DGVI="""""",DGVO=DGVI I $D(IOST(0)) S:$D(^%ZIS(2,IOST(0),5)) I=^(5) S:$L($P(I,U,4)) DGVI=$P(I,U,4) S:$L($P(I,U,5)) DGVO=$P(I,U,5) I $L(DGVI_DGVO)>4 S X=132 X ^%ZOSF("RM")
WR G GET:'$D(A)!('$D(B)) W @IOF,HEAD,?72,@DGVI,"<101>",@DGVO
FAC I $D(DGCST) W !?40,"Census Status: ",$P($P($P(^DD(45,6,0),"^",3),+DGCST_":",2),";")
 W !! S Z=1 D Z W "   Facility: " S Z=$P(B(0),U,3)_$P(B(0),U,5),Z1=23 D Z1
MAR S Z=2 D Z W " Marit Stat: ",$S($D(^DIC(11,+$P(A(0),U,5),0)):$P(^(0),U,1),1:"")
SA W !," Source of Adm: ",$S($D(^DIC(45.1,+B(101),0)):$P(^(0),U,5),1:"")
 N VADM D DEM^VADPT
 W ?39,"Ethnic: " D
 .I 'VADM(11) W "" Q
 .N NODE,NUM,ETHNIC,I
 .S I=0
 .F NUM=0:1 S I=+$O(VADM(11,I)) Q:'I  D
 ..S X=$$PTR2CODE^DGUTL4(+VADM(11,I),2,4)
 ..S ETHNIC=$S(X="":"?",1:X)
 ..S X=$$PTR2CODE^DGUTL4(+$G(VADM(11,I,1)),3,4)
 ..S ETHNIC=ETHNIC_$S(X="":"?",1:X)
 ..I NUM S ETHNIC=","_ETHNIC
 ..W ETHNIC
 W ?55,"Race: " D
 .I 'VADM(12) W "" Q
 .N NODE,NUM,RACE,I
 .S I=0
 .F NUM=0:1 S I=+$O(VADM(12,I)) Q:'I  D
 ..S X=$$PTR2CODE^DGUTL4(+VADM(12,I),1,4)
 ..S RACE=$S(X="":"?",1:X)
 ..S X=$$PTR2CODE^DGUTL4(+$G(VADM(12,I,1)),3,4)
 ..S RACE=RACE_$S(X="":"?",1:X)
 ..I NUM S RACE=","_RACE
 ..W RACE
 K VADM
 W !," Source of Pay: " S L=";"_$P(^DD(45,22,0),U,3),L1=";"_$P(B(101),U,3)_":" W $P($P(L,L1,2),";",1)
SEX S SEX=$P(A(0),U,2) W ?39,"           Sex: ",$S(SEX="M":"MALE",SEX="F":"FEMALE",1:"")
 W !,"Trans Facility: ",$P(B(101),U,5)_$P(B(101),U,6)
DOB S DOB=$P(A(0),U,3),Y=DOB D D^DGPTUTL W ?39," Date of Birth: ",Y
CAT I DGPTFMT<2 W !,"    Cat of Ben: ",$S($D(^DIC(45.82,+$P(B(101),U,4),0)):$E($P(^(0),U,2),1,26),1:"")
 W:$X>50 !
 W "    Admit Elig: "_$S(+$P(B(101),U,8):$P($G(^DIC(8,+$P(B(101),U,8),0)),U),1:"UNKNOWN") W ?50,"SCI: " S L=";"_$P(^DD(2,57.4,0),U,3),L1=";"_$P(A(57),U,4)_":" W $P($P(L,L1,2),";",1)
VIET W ! S Z=3 D Z W "Vietnam SRV: " S L=$P(A(.321),U,1),Z=$S(L="Y":"YES",L="N":"NO",1:"UNKNOWN"),Z1=27 D Z1
ST S Z=4 D Z W $S('$$FORIEN^DGADDUTL($P(A(.11),U,10))!('$P(A(.11),U,10)):"  State: "_$S($D(^DIC(5,+$P(A(.11),U,5),0)):$P(^(0),U,1),1:""),1:"Country: "_$$CNTRYI^DGADDUTL($P(A(.11),U,10)))
POW W !?11,"POW: " S L=$P(A(.52),U,5) W $S(L="Y":"YES",L="N":"NO",1:"UNKNOWN")
ZIP W ?42,$S('$$FORIEN^DGADDUTL($P(A(.11),U,10))!('$P(A(.11),U,10)):"   Zip Code: "_$P(A(.11),U,6),1:"Postal Code: "_$P(A(.11),U,9))
POS W !,?6," POW SRV: " S L=$P(A(.52),U,6) W $E($S($D(^DIC(22,+L,0)):$P(^(0),U,1),1:""),1,23)
COU W ?45,$S('$$FORIEN^DGADDUTL($P(A(.11),U,10))!('$P(A(.11),U,10)):"  County: "_$S($D(^DIC(5,+$P(A(.11),U,5),1,+$P(A(.11),U,7),0)):$P(^(0),U,1),1:""),1:"Province: "_$P(A(.11),U,8))
ION W !,"   Ion Rad Exp: " S L=$P(A(.321),U,3) W $S(L="Y":"YES",L="N":"NO",1:"UNKNOWN")
METH S L=$P(A(.321),U,12) W:L'="" ?38,"Exposure Method: ",$S(L="N":"Nagasaki/Hiroshima",L="T":"Nuclear Testing",L="B":"Both",1:"")
AO W !,"    AO Exp/Loc: " S L=$P(A(.321),U,2) W $S(L="Y":"YES",L="N":"NO",1:"UNKNOWN")
 S L=$P(A(.321),U,13) W:L'="" $S(L="V":"/VIET",L="K":"/DMZ",L="O":"/OTHER",1:"")
SHAD W ?40,"PROJ 112/SHAD: ",$S(A("SHAD")=1:"YES",1:"NO")
MST W !,"    Claims MST: " S L=$P(A("MST"),U) W $S(L="Y":"YES",L="N":"NO",L="D":"DECLINED TO ANSWER",1:"UNKNOWN") ; added 6/17/98 for MST enhancement
NTR W ?39,"    N/T Radium: " S L=A("NTR") W $E($S(L'="":L,1:"UNKNOWN"),1,25)
CV S L=$S($P(A("CV"),U,1)>0:1,1:0)
 W !,"Combat Veteran: ",$S(L:"YES",1:"NO")
 I L S Y=$P(A("CV"),U,2) D D^DGPTUTL W ?45,"End Date: ",Y
 ;
 D EN^DGPTF4 K A,B Q:DGPR
 ;
JUMP F I=$Y:1:20 W !
 G 101^DGPTFJC:DGN S (DGZM0,DGZS0)=0
 R "Enter:  <RET> for <MAS>,",!,"1-7 to edit,'^N' for screen N, or '^' to abort: <MAS>// ",X:DTIME S:'$T X="^",DGPTOUT=""
 G ^DGPTFM:X="",Q:X="^"
 I X?1"^".E S DGPTSCRN=101 G ^DGPTFJ
 G PR:X?.N&($L(X)>2)
 I X["-" S K=X,X="" F I=1:1 S J=$P(K,",",I) Q:J']""  I +J<8 S:J'["-" X=X_J_"," I J["-"&(+J) I +J<+$P(J,"-",2) F L=+J:1:+$P(J,"-",2) S:L<8 X=X_L_","
 I X'[",",1234567'[X G PR
 F I=1:1 S J=$P(X,",",I) Q:'J  G:J<1!(J>7)!(J'?1N) PR
 I X<1!(X>7) G PR
 S (PT(1),PT(2))="",DGJUMP=X,DA=PTF,DIE="^DGPT(",DR="[DG101"_$E("F",DGPTFE)_"]" D ^DIE
 ;--
 N DGPMCA,DGPMAN D PM^DGPTUTL
 I '$G(DGADM) S DGADM=+^DGPT(PTF,0)
 D MT^DGPTUTL
GET F I=.32,.52,57,.521,0,.321,.11,.3 S A(I)="" S:$D(^DPT(DFN,I))&('DGST) A(I)=^(I) I DGN S:$D(^DGP(45.84,PTF,$S('I:10,1:I))) A(I)=^($S('I:10,1:I))
 ; The following line added for MST enhancement 4/21/99
 S A("MST")=$P($$GETSTAT^DGMSTAPI(DFN),U,2,5)
 K DGNTARR
 S A("NTR")=$S($$GETCUR^DGNTAPI(DFN,"DGNTARR")>0:DGNTARR("INTRP"),1:"")
 K DGNTARR
 F I=0,101,70 S B(I)="" S:$D(^DGPT(PTF,I)) B(I)=^(I)
 S DGDD=+B(70),DGFC=+$P(B(0),U,3)
 S A("CV")=$$CVEDT^DGCV(DFN,$P($G(B(0)),U,2))
 S A("SHAD")=$$GETSHAD^DGUTL3(DFN)
 K PT G DGPTF1
PR W !,"Enter '^' to stop the display and edit of data",!,"'^N' to jump to screen #N (screen # appears in upper right of screen '<N>')",!,"<RET> to continue on to the next screen or 1-7 to edit:"
 W !?10,"1-Facility, Source of admis, Payment, Transf facil, and Cat. of Benef",!?10,"2-Marital Stat, Race, Ethnicity, Sex, SCI, DOB"
 W !?10,"3-Agent Orange, Prisoner of War, Ionizing Radiation, MST, N/T Radium",!?10,"4-State, County, Zip code"
 W !?10,"5-Discharge date, type & specialty",!?10,"6-Outpatient treat & VA Auspices",!?10,"7-Receiving Facility, ASIH Days & C&P Status"
 W !,"You may also enter any combination of the above, separated by commas(ex:1,3,5)",!
 R !!,"Enter <RET> : ",X:DTIME G WR
Q G Q^DGPTF
 Q
Z I 'DGN S Z=$S(IOST="C-QUME"&($L(DGVI)'=2):Z,1:"["_Z_"]") W @DGVI,Z,@DGVO
 E  W "   "
 Q
Z1 F I=1:1:(Z1-$L(Z)) S Z=Z_" "
 W Z
