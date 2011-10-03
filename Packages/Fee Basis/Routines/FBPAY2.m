FBPAY2 ;AISC/DMK,GRR,TET - OUTPATIENT PAYMENT HISTORY SORT/PRINT ;7/9/2001
 ;;3.5;FEE BASIS;**4,32,55,69**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;entry point
 I FBSORT S FBPNAME=FBNAME,FBPID=FBID,(DFN,J)=FBIEN D SORT
 I 'FBSORT S FBVNAME=$E(FBNAME,1,23),FBVID=FBID,FBVI=FBIEN,J=0 F  S J=$O(^FBAAC("AB",FBVI,J)) Q:J'>0  S DFN=J,FBPID=$$SSN^FBAAUTL(DFN),FBPNAME=$P($G(^DPT(DFN,0)),U) D SORT
KILL ;kill variables set in this routine
 K A1,A2,A3,B3,C3,D,D2,FBAACPTC,FBBN,FBCP,FBDOS,FBDT,FBDT1,FBIN,FBOB,FBP,FBPAT,FBPDX,FBSC,FBTA,FBTRDT,FBTRX,FBTYPE,FBVEN,FBVP,I,J,K,L,M,T,Y,FBMODLE,FB1725
 K FBCSID,FBADJLA,FBADJLR,FBRRMKL,FBUNITS,TAMT,T,FBADJ,FBY3,FBFPPSC,FBFPPSL,FBAARCE
 K:FBSORT FBVNAME,FBVID
 K:'FBSORT FBPNAME,FBPID,FBTRCK
 Q
SORT S I=FBBEG F  S I=$O(^FBAAC(J,"AB",I)) Q:'I!(I>FBEND)  F K=0:0 S K=$O(^FBAAC(J,"AB",I,K)) Q:'K  I FBSORT!(('FBSORT)&(K=$G(FBVI))) F L=0:0 S L=$O(^FBAAC(J,"AB",I,K,L)) Q:'L  D SETTR F M=0:0 S M=$O(^FBAAC(J,1,K,1,L,1,M)) Q:'M  D SET,SETTMP
 Q
SET ;set variables & sort - also entry point from FBPAY67
 N FBX
 S Y=$G(^FBAAC(J,1,K,1,L,1,M,0)) I '+$P(Y,U,9)!($G(^FBAAC(J,1,K,1,L,1,M,"FBREJ"))]"") S FBOUT=1 Q
 ; if user wants just mill bill or just non-mill bill then check payment
 ;   and skip if associated with an mill bill claim
 I "^M^N^"[(U_$G(FB1725R)_U) S FB1725=$S($P(Y,U,13)["FB583":+$P($G(^FB583(+$P(Y,U,13),0)),U,28),1:0) I $S(FB1725R="M"&'FB1725:1,FB1725R="N"&FB1725:1,1:0) S FBOUT=1 Q
 S FBY=$G(^FBAAC(J,1,K,1,L,1,M,2))
 S FBY3=$G(^FBAAC(J,1,K,1,L,1,M,3))
 S FBAARCE=$$GET1^DIQ(162.03,M_","_L_","_K_","_J_",",48) ;revenue code
 D FBCKO^FBAACCB2(J,K,L,M)
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_J_",1,"_K_",1,"_L_",1,"_M_",""M"")","E")
 S:FBSORT FBVNAME=$E($P($G(^FBAAV(K,0)),U),1,23),FBVID=$S(FBVNAME]"":$P(^(0),U,2),1:"")
 S FBP=+$P(Y,U,9),FBSC=$P(Y,U,27),FBPDX=+$P(Y,U,23)
 S FBSC=$S(FBSC="Y":"YES",FBSC="N":"NO",1:"-")
 S FBPDX=$$ICD9EX^FBCSV1(FBPDX,3,18,+$G(^FBAAC(J,1,K,1,L,0)))
 S T=$P(Y,U,5),D2=$P(Y,U,6),FBDOS=D2,D2=$$DATX^FBAAUTL(D2),FBCP=$P(Y,U,18),FBCP=$S(FBCP=1:"(C&P)",1:"")
 S FBAACPTC=$$CPT^FBAAUTL4($P(Y,U))
 S FBOB=$P(Y,U,10)
 I T]"" S T=$P($G(^FBAA(161.27,+T,0)),U) ;suspend code
 S TAMT=$FN($P(Y,U,4),"",2) ;suspend amount
 S FBUNITS=$P(FBY,U,14) ;units paid
 S FBCSID=$P(FBY,U,16) ;patient control number
 S FBFPPSC=$P(FBY3,U) ; fpps claim id
 S FBFPPSL=$P(FBY3,U,2) ; fpps line item
 S FBX=$$ADJLRA^FBAAFA(M_","_L_","_K_","_J_",")
 S FBADJLR=$P(FBX,U) ;adjustment codes
 S FBADJLA=$P(FBX,U,2) ;adjustment amounts
 S FBRRMKL=$$RRL^FBAAFR(M_","_L_","_K_","_J_",") ;remit remarks
 S FBTYPE=$P(Y,U,20),FBVP=$P(Y,U,21),FBIN=$P(Y,U,16),FBBN=$P(Y,U,8),FBBN=$S(FBBN']"":"",$D(^FBAA(161.7,FBBN,0)):$P(^(0),U),1:""),FBBN=$S(FBBN="":"",1:$E("00000",$L(FBBN)+1,5)_FBBN)
 S FBVEN=FBVNAME_";"_FBVID,FBPAT=FBPNAME_";"_DFN
 ;output format
 S A1=$J($P(Y,U,2),6,2),A2=$J($P(Y,U,3),6,2),FBIN=$J(FBIN,7)
 S A2=A2_$$APS^FBAAUTL4(J,K,L,M) ; append symbol
 S FBDT1=$S(FBVP="VP":"#",1:"")_$S(FBTYPE="R":"*",1:" ")_FBDT
 Q
SETTMP ;sort data by fee program, vendor, patient, date
 I '$D(FBPROG(+$P(Y,U,9)))!($P(Y,U,9)'=FBPI)!($G(^FBAAC(J,1,K,1,L,1,M,"FBREJ"))]"") S FBOUT=1 G SETTMP1
 ; if user wants just mill bill or just non-mill bill then check payment
 ;   and skip if associated with an mill bill claim
 I "^M^N^"[(U_$G(FB1725R)_U) S FB1725=$S($P(Y,U,13)["FB583":+$P($G(^FB583(+$P(Y,U,13),0)),U,28),1:0) I $S(FB1725R="M"&'FB1725:1,FB1725R="N"&FB1725:1,1:0) S FBOUT=1 G SETTMP1
 S ^TMP($J,"FB",FBP,FBVEN,FBPAT,I,L,M)=FBDT1_U_FBAACPTC_FBCP_$S($G(FBMODLE)]"":"-"_FBMODLE,1:"")_U_A1_U_A2_U_T_U_FBBN_U_FBIN_U_D2_U_FBSC_U_FBPDX_U_FBOB
 S ^TMP($J,"FB",FBP,FBVEN,FBPAT,I,L,M,"FBCK")="^"_FBCK_"^"_FBCKDT_"^"_FBCANDT_"^"_FBCANR_"^"_FBCAN_"^"_FBDIS_"^"_FBCKINT
 S ^TMP($J,"FB",FBP,FBVEN,FBPAT,I,L,M,"FBADJ")=TAMT_U_FBUNITS_U_FBADJLR_U_FBADJLA_U_FBRRMKL_U_FBCSID_U_FBFPPSC_U_FBFPPSL_U_FBAARCE
SETTMP1 D PMTCLN^FBAACCB2
 Q
SETTR S D=$S($D(^FBAAC(J,1,K,1,L,0)):$P(^(0),"^",1),1:""),A3=""
 ; if just mill bill (FB1725R="M") requested then skip travel payments
 I D]"",$D(^FBAAC(J,3,"AB",D)),$G(FB1725R)'="M" S (FBTA,FBCTR)=0 F  S FBTA=$O(^FBAAC(J,3,"AB",D,FBTA)) Q:'FBTA  S A3=$P($G(^FBAAC(J,3,FBTA,0)),"^",3) I A3>0 D
 .D FBCKT^FBAACCB0(J,FBTA) S FBCTR=FBCTR+1,^TMP($J,"FBTR",FBPNAME,D,FBCTR)=$J(A3,6,2)_"^"_FBCK_"^"_FBCKDT_"^"_FBCANDT_"^"_FBCANR_"^"_FBCAN_"^"_FBDIS_"^"_FBCKINT
 K A3,B3,FBTA,FBCTR
 S FBDT=$$DATX^FBAAUTL(D)
 Q
EN1 ;entry point to set variables, called by fbpay67, oth & anc
 N FBVEN,FBPAT,FBDT1
 D SETTR,SET
 Q
WMSG ;write message if no matches found
 W !!,"There are no outpatient payments on file for specified date range"
 W:'FBPROG !?3," and selected Fee programs"
 W ".",*7,!!
 Q
