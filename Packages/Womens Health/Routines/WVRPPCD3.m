WVRPPCD3 ;HCIOFO/FT,JR-REPORT: PROCEDURES STATISTICS; ;7/23/01  13:33
 ;;1.0;WOMEN'S HEALTH;**12**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; <NONE>
 ;
FLATFL ;EP
 ;---> WRITE OUT RESULTS AND PECENTAGES IN A FLAT FILE.
 ;---> PIECE VALUES: 1=PROC TYPE, 2=NORMAL PATS, 3=NORMAL PATS%
 ;--->               4=NORMAL PROC    5=NORMAL PROC%   6=ABNORM PATS
 ;--->               7=ABNORM PATS%   8=ABNORM PROC    9=ABNORM PROC%
 ;--->               10=NO RES PATS   11=NO RES PATS%  12=NO RES PROC
 ;--->               13=NO RES PROC%  14=TOTAL PATS    15=TOTAL PROC,
 ;--->               16=AGE GROUP,             17=NORM VETS PROC. 
 ;--->               18=NORM VETS PATIENTS,    19=ABN VETS PROC.
 ;--->               20=ABN VETS PATIENTS,     21=NO RES VETS PROC
 ;--->               22=NO RES VETS PATIENTS   23=TOT # VET PATIENTS
 ;--->               24=TOT VET PROCEDURES
 S FE=""
 F  S FE=$O(^TMP("WVRES",$J,FE)) Q:FE=""  S FI=0 F  S FI=$O(^TMP("WVRES",$J,FE,FI)) Q:'FI  S N=0 F  S N=$O(^TMP("WVRES",$J,FE,FI,N)) Q:'N  D
 .S M=0,(WVPN,X)=$P($G(^WV(790.2,N,0)),U)
 .F  S M=$O(^TMP("WVRES",$J,FE,FI,N,M)) Q:'M  D
 ..S X=WVPN,(T,P)=0,J=""
 ..S PA=$G(^TMP("WVRES",$J,FE,FI,N,M,"VT","PA"))
 ..S CM=$G(^TMP("WVRES",$J,FE,FI,N,M,"CM","PA",0))
 ..S CM2=$G(^TMP("WVRES",$J,FE,FI,N,M,"CM","PA",2))
 ..S (TR2,JR2,TR,JR)="" F I=0,1,2 D
 ...S X=X_U_^TMP("WVRES",$J,FE,FI,N,M,I,"P")
 ...S X=X_U_$J((^TMP("WVRES",$J,FE,FI,N,M,I,"P")*100/^TMP("WVRES",$J,FE,FI,N,M,"P")),1,0)
 ...S X=X_U_^TMP("WVRES",$J,FE,FI,N,M,I,"T")
 ...S X=X_U_$J((^TMP("WVRES",$J,FE,FI,N,M,I,"T")*100/^TMP("WVRES",$J,FE,FI,N,M,"T")),1,0)
 ...S J=J_U_$G(^TMP("WVRES",$J,FE,FI,N,M,I,"VT","T")) ;# of procedures total/result
 ...S J=J_U_$G(^TMP("WVRES",$J,FE,FI,N,M,I,"VT","P")) ;# of pat having this procedure
 ...S T=T+$G(^TMP("WVRES",$J,FE,FI,N,M,I,"VT","T"))
 ...S JR=$G(JR)_U_$G(^TMP("WVRES",$J,FE,FI,N,M,I,"CM","T",0)) ;# of procedures total/result
 ...S JR=JR_U_$G(^TMP("WVRES",$J,FE,FI,N,M,I,"CM","P",0)) ;# of pat having this procedure
 ...S TR=TR+$G(^TMP("WVRES",$J,FE,FI,N,M,I,"CM","T",0))
 ...S JR2=$G(JR2)_U_$G(^TMP("WVRES",$J,FE,FI,N,M,I,"CM","T",2)) ;# of procedures total/result
 ...S JR2=JR2_U_$G(^TMP("WVRES",$J,FE,FI,N,M,I,"CM","P",2)) ;# of pat having this procedure
 ...S TR2=TR2+$G(^TMP("WVRES",$J,FE,FI,N,M,I,"CM","T",2))
 ..S X=X_U_^TMP("WVRES",$J,FE,FI,N,M,"P")_U_^TMP("WVRES",$J,FE,FI,N,M,"T")_U_M_J_U_T_U_PA_JR_U_TR_U_CM_JR2_U_TR2_U_CM2
 ..S ^TMP("WVRES",$J,"R",FE,FI,WVPN,M)=X
 .;--->
 .;---> NOW GET TOTALS FOR THIS PROCEDURE.
 .N A,B,C,D,E,F,G,H,I,J,K,L,M,O,WA,WB,WC,WD,WE,WF,WG,WH,WI,WJ,WK,WL
 .S (A,B,C,D,E,F,G,H,I,K,L,M,R,O,WA,WB,WC,WD,WE,WF,WG,WH,WI,WJ,WK,WL)=0
 .F  S M=$O(^TMP("WVRES",$J,"R",FE,FI,WVPN,M)) Q:'M  D
 ..S J=$O(^WV(790.2,"B",WVPN,""))
 ..S Y=^TMP("WVRES",$J,"R",FE,FI,WVPN,M)
 ..S A=A+$P(Y,U,2),B=B+$P(Y,U,4),C=C+$P(Y,U,6)
 ..S D=D+$P(Y,U,8),E=E+$P(Y,U,10),F=F+$P(Y,U,12)
 ..S H=H+$P(Y,U,17),I=I+$P(Y,U,18),K=K+$P(Y,U,19)
 ..S L=L+$P(Y,U,20),R=R+$P(Y,U,21),O=O+$P(Y,U,22)
 ..S WA=WA+$P(Y,U,25),WB=WB+$P(Y,U,26),WC=WC+$P(Y,U,27)
 ..S WD=WD+$P(Y,U,28),WE=WE+$P(Y,U,29),WF=WF+$P(Y,U,30)
 ..S WG=WG+$P(Y,U,33),WH=WH+$P(Y,U,34),WI=WI+$P(Y,U,35)
 ..S WJ=WJ+$P(Y,U,36),WK=WK+$P(Y,U,37),WL=WL+$P(Y,U,38)
 .S X=WVPN_U_A_U_$J(A*100/^TMP("WVRES",$J,FE,FI,N,"P"),1,0)
 .S X=X_U_B_U_$J(B*100/^TMP("WVRES",$J,FE,FI,N,"T"),1,0)
 .S X=X_U_C_U_$J(C*100/^TMP("WVRES",$J,FE,FI,N,"P"),1,0)
 .S X=X_U_D_U_$J(D*100/^TMP("WVRES",$J,FE,FI,N,"T"),1,0)
 .S X=X_U_E_U_$J(E*100/^TMP("WVRES",$J,FE,FI,N,"P"),1,0)
 .S X=X_U_F_U_$J(F*100/^TMP("WVRES",$J,FE,FI,N,"T"),1,0)
 .S X=X_U_^TMP("WVRES",$J,FE,FI,N,"P")_U_^TMP("WVRES",$J,FE,FI,N,"T")_U_"ALL"
 .S J=U_H_U_I_U_K_U_L_U_R_U_O_U
 .S J=J_$G(^TMP("WVRES",$J,FE,FI,N,"VT","T"))_U_$G(^TMP("WVRES",$J,FE,FI,N,"VT","PA"))
 .S J=J_U_WA_U_WB_U_WC_U_WD_U_WE_U_WF
 .S J=J_U_$G(^TMP("WVRES",$J,FE,FI,N,"CM","T",0))_U_$G(^TMP("WVRES",$J,FE,FI,N,"CM","PA",0))
 .S J=J_U_WG_U_WH_U_WI_U_WJ_U_WK_U_WL
 .S J=J_U_$G(^TMP("WVRES",$J,FE,FI,N,"CM","T",2))_U_$G(^TMP("WVRES",$J,FE,FI,N,"CM","PA",2))
 .S ^TMP("WVRES",$J,"R",FE,FI,WVPN,"ALL")=X_J
 Q
NOFAC ; List records with no health care facility
 W:$Y>0 @IOF
 W !!,"The following Women's Health procedures are not associated with a facility:",!
 N WVAN,WVCMN,WVIEN,WVNODE,WVPN
 S WVIEN=0
 F  S WVIEN=$O(^TMP("WVNOHCF",$J,WVIEN)) Q:'WVIEN!(WVPOP)  D
 .S WVNODE=$G(^WV(790.1,WVIEN,0))
 .S WVAN=$P(WVNODE,U,1) ;accession #
 .S:WVAN="" WVAN="IEN is "_WVIEN
 .S WVPN=+$P(WVNODE,U,2)
 .S WVCMN=$$CMGR^WVUTL1(WVPN)
 .I $Y+6>IOSL D:WVCRT DIRZ^WVUTL3 Q:WVPOP  D NOFACHDR
 .W !,"Accession #: "_WVAN,?30,"Case Manager: "_WVCMN
 .Q
 Q
NOFACHDR ; No Facility Header
 W:$Y>0 @IOF
 Q
FACLIST ; create array to identify facilities chosen
 N WVIEN,WVIEN1,WVNAME
 K WVSB1
 I '$D(WVSB("ALL")) D
 .S WVIEN=0
 .F  S WVIEN=$O(WVSB(WVIEN)) Q:'WVIEN  D
 ..S WVIEN1=$P($G(^WV(790.02,WVIEN,0)),U,1)
 ..Q:'WVIEN1!(WVIEN'=WVIEN1)
 ..S WVNAME=$$INSTTX^WVUTL6(WVIEN)
 ..Q:WVNAME=""
 ..S WVSB1(WVNAME,WVIEN)=""
 ..Q
 .Q
 I $D(WVSB("ALL")) D
 .S WVIEN=0
 .F  S WVIEN=$O(^WV(790.02,WVIEN)) Q:'WVIEN  D
 ..S WVIEN1=$P($G(^WV(790.02,WVIEN,0)),U,1)
 ..Q:'WVIEN1!(WVIEN'=WVIEN1)
 ..S WVNAME=$$INSTTX^WVUTL6(WVIEN)
 ..Q:WVNAME=""
 ..S WVSB1(WVNAME,WVIEN)=""
 ..Q
 .Q
 Q
