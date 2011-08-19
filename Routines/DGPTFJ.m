DGPTFJ ;ALB/MRL - JUMP BETWEEN PTF SCREENS ; 12/12/06 9:04am
 ;;5.3;Registration;**58,517,635,729**;Aug 13, 1993;Build 59
 ;
TEST K S,M G Q^DGPTF:X="^" S Z="^101^401^501^601^701^801^MAS^CDR",X1=X,X=$P($E(X,2,99),"-",1) G QUES:X1?1"^?".E Q:X=""  D IN^DGHELP G QUES:%=-1
 S Z=$T(@X) I Z="" W !!,"*** Undefined screen number. Valid screens are: ",! G QUES
 I X=4!(X=5) S @($S(+X=5:"DGZM0",1:"DGZS0"))=$S(X1["-":+$P(X1,"-",2),1:1)
 I X=6 S DGZP=$S(X1["-":+$P(X1,"-",2),1:1)
 I X=8 S ANS="F"_$P(X1,"-",2)
 K M,L1,T G @($P(Z,";",3))
 ;
HELP W !!,"PTF Screens are: ",! F I=1,5,4,6,7,8,"M","C" S T=$T(@I) Q:T=""  W !?5,I,?10,$P(T,";",4)
 Q
QUES D HELP W !!,"Press Return to continue: " R X:4
 I $D(DGPTSCRN) S Z=$P($T(@$E(DGPTSCRN)),";",3) K DGPTSCRN G:Z]"" @Z
 G WR^DGPTF1
Q G Q^DGPTF
 ;
PROG ;
1 ;;WR^DGPTF1;'101' Screen--Admission/disposition Transaction
5 ;;EN^DGPTFM4;'501' Screen--Patient movement transaction
4 ;;EN^DGPTFM5;'401' Screen--Surgical/procedure entry
6 ;;E^DGPTFM1;'601' Screen--Procedure entry (AVAILABLE FOR DISCHARGES AFTER 10/1/87)
7 ;;EN1^DGPTF4;'701' Screen--PDXLS/DRG print
8 ;;F^DGPTFM2;'801' Screen--CPT entry (CPT and HCPCS)
M ;;^DGPTFM;'MAS' screen--surgery/procedure/diagnosis code edits
C ;;EN^DGPTFM7;'MPCR' screen--displays MPCR information
 Q
SA ;called from input transform on SOURCE OF ADMISSION field (#20) PTF file (#45)
 S DGER=$S('$D(PTF):1,'$D(^DGPT(PTF,0)):1,1:0) Q:DGER!("^48^49^50^"'[(U_Y_U))  S DGSU1=$P(^(0),"^",5),DGSU0=$S($D(^DGPT(PTF,101)):$P(^(101),"^",6),1:"")
 S DGSTATYP=$S(Y=48:11,Y=49:40,Y=50:30)
 D NUMACT^DGPTSUF(DGSTATYP)
 I DGANUM>0 D
 .I Y=48 F I=1:1:DGANUM S DGER=$S(((DGSU1=DGSUFNAM(DGANUM))!(DGSU1=""))&((DGSU0=DGSUFNAM(DGANUM))!(DGSU0="")):0,1:1)
 .I Y=49!(Y=50) F I=1:1:DGANUM S DGER=$S((Y=49&(DGSU1=DGSUFNAM(DGANUM))&("^9AA^9AB^9AC^9AD^9AE^"[(U_DGSU0_U))):0,(Y=50&(DGSU1=DGSUFNAM(DGANUM))&("^BU^BV^BW^BX^"[(U_DGSU0_U))):0,1:1)
 K DGANUM,DGSTATYP,DGSUFNAM,I
 Q
