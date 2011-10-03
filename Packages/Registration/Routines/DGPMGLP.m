DGPMGLP ;ALB/LM/MJK - G&L PRINT ROUTINE; 27 APR 2003
 ;;5.3;Registration;**20,134,515,713**;Aug 13, 1993
 ;
A S DIE="^DG(43,",DA=1,DR="50///NOW" D ^DIE K DA,DR,DIE
 S (RA,LA)="",$P(RA,"-",66)="",$P(LA,"-",66)="" ;  RA=Right Arrows "-"   LA=Left Arrows "-"
 D 8
 F DGDIV=0:0 S DGDIV=$O(^UTILITY("DGT",$J,DGDIV)) Q:DGDIV=""  S DGINST=DGDIV F DGSRV=0:0 S DGSRV=$O(^UTILITY("DGT",$J,DGDIV,DGSRV)) D:'DGSRV COR Q:'DGSRV  D DIVHD,SRVHD,SCAN S:'$D(TTNAME) TTNAME="NT" D:$D(LEG)&(TTNAME'["NO TRANSACTION") FOOT
 S DGINST=$P(^DG(40.8,DGINST,0),"^",7),DGINST=$P(^DIC(4,DGINST,0),"^") D COR1
K K TTNAME,FMNAME,NAME,PTDATA,C,C1,DFN,FM,I,I1,I2,I3,L,LA,RA,TT,X,X1,Y,DGCR,DGDIV6,DGX,Y,J,DGINST
 S DA=1,DIE="^DG(43,",DR="61///NOW;50///@" D ^DIE
 K DA,DR,DIE
 Q
 ;
8 ; If there are no transactions
 F ORDER=0:0 S ORDER=$O(^DIC(42,"AGL",ORDER)) Q:'ORDER  F WARD=0:0 S WARD=$O(^DIC(42,"AGL",ORDER,WARD)) Q:'WARD  I $D(^DIC(42,WARD,0)) S X1=$P(^DIC(42,WARD,0),"^",3) I X1]"",X1'="NC" S DGSRV=$S(X1="NH":2,X1="D":3,1:1) D 88
 Q
88 S DGDIV=$S($P(^DIC(42,WARD,0),"^",11)']"":+$P(DGPM("GL"),"^",3),1:$P(^DIC(42,WARD,0),"^",11)) D PARAM S:'$D(^UTILITY("DGT",$J,DGDIV,DGSRV)) ^UTILITY("DGT",$J,DGDIV,DGSRV,"8888")=""
 Q
 ;
PARAM ; --check combine/separate parameter in 40.8
 S DGDIV6=$S($D(^DG(40.8,DGDIV,0)):+$P(^(0),"^",6),1:0),DGSRV=$S('DGDIV6:1,1:DGSRV) Q
 ;
DIVHD I $D(FF) W @IOF
 S FF=1
 W !?94,"Date/Time Printed: ",DGNOW
 W !?RM-22\2,"GAINS AND LOSSES SHEET"
 S X=$$NAME^VASITE(RD)
 I X']"" D
 .S X="VA MEDICAL CENTER"
 .S X=X_$S($D(^DG(40.8,+DGDIV,0)):", "_$P(^(0),"^"),1:"") S:DGDIV']"" X=X_" at "_DGINST
 W !?RM-$L(X)\2,X
 S X=RD D DW^%DTC
 S Z="PERIOD ENDING MIDNIGHT "_X_", "
 S Y=RD X ^DD("DD")
 S X=Z_Y
 W !?RM-$L(X)\2,X
 K X,Z,Y
 Q
 ;
SRVHD ; -- print service head
 S X=$P("MEDICAL CENTER^NHCU^DOMICILIARY","^",DGSRV)_" TOTALS"
 W !?RM-$L(X)\2,X
 Q
 ;
SCAN ; -- scan entries
 F TT=0:0 S TT=$O(^UTILITY("DGT",$J,DGDIV,DGSRV,TT)) Q:'TT  S TTNAME=$S($D(^DG(405.3,+TT,0)):$P(^(0),"^"),TT=9999:"NON-LOSSES",TT=8888:"NO TRANSACTION",1:"UNKNOWN TRANSACTION TYPE")_"(S): "_$J(+^UTILITY("DGT",$J,DGDIV,DGSRV,TT),4) D ^DGPMGLP1
 Q
 ;
FOOT W ! W:UL["-" !
 F L=1:1:131 W UL
 S C=0,X=""
 F I="+","*","#","!","a","b","c","g","r" S C=C+1 I $D(LEG(I)) S X="'"_I_"' - "_$P($T(LEG+C),";;",2)_"; " W:$X>(131-$L(X)) ! W X
 W !
 Q
 ;
LEG ;  Legend
 ;;Third Party Reimbursement Candidate
 ;;While in Absent Sick in Hospital Status (ASIH)
 ;;Discharge within 48 hours of admission
 ;;While in Absence Status (authorized/unauthorized absence)
 ;;MT Copay Exempt
 ;;Category 'B' Veteran
 ;;MT Copay Required
 ;;GMT Copay Required
 ;;Current Means Test Required but not completed
 Q
 ;
LINES W !!!
 Q
COR ;  From the Medical Center Division File, Census Multiple, Corrections to the Previous G&L's word processing field
 ;
 I $D(^DG(40.8,DGDIV,"CEN",RD,"A")) F I=0:0 S I=$O(^DG(40.8,DGDIV,"CEN",RD,"A",I)) Q:I=""  D:$Y>62 DIVHD,LINES W !,^DG(40.8,DGDIV,"CEN",RD,"A",I,0)
 Q
 ;
COR1 ;  From the G&L Corrections File
 ;
 I '$D(^UTILITY($J,"CR")) F I=0:0 S I=$O(^DGS(43.5,"B",RD,I)) Q:I=""  I $D(^DGS(43.5,I,0)) S DGCR=^(0),^UTILITY($J,"CR",$S($D(^DPT(+$P(DGCR,"^",5),0)):$P(^(0),"^",1),1:"")_I)=DGCR
 I $D(^UTILITY($J,"CR")) D DIVHD,LINES ; to print G&L Corrections File on separate page
 S I="" F J=0:0 S I=$O(^UTILITY($J,"CR",I)) Q:I=""  S DGCR=^(I) D COR2,CORR
 Q
 ;
COR2 Q:'$D(DGCR)
 S DGX=$S($D(^DG(43.61,$P(DGCR,"^",2),0)):$P(^DG(43.61,$P(DGCR,"^",2),0),"^"),1:"")
 Q
 ;
CORR D:$Y>62 DIVHD,LINES
 W !,DGX ; Type of change
 W " For ",$S($D(^DPT(+$P(DGCR,"^",5),0)):$P(^(0),"^",1)_"  "_$E($P(^(0),"^",9),6,9),1:" ") ; Patient name and SSN
 I $P(DGCR,"^",6)]"" S Y=$P(DGCR,"^",6) X ^DD("DD") W " For admission of ",Y
 I $P(DGCR,"^",9)]"" S Y=$P(DGCR,"^",9) X ^DD("DD") W ", transfer of ",Y
 I $P(DGCR,"^",3)]"" W " Old value: ",$P(DGCR,"^",3)
 I $P(DGCR,"^",4)]"" W " New value: ",$P(DGCR,"^",4)
 Q
