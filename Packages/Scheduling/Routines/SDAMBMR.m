SDAMBMR ;ALB/MLI - AMBULATORY PROCEDURE MANAGEMENT REPORTS ; 4/24/00 9:20am
 ;;5.3;Scheduling;**140,132,159,180,556**;Aug 13, 1993;Build 3
EN D Q,ASK2^SDDIV G:Y<0 Q S U="^",SDAS=0
1 S SDFL=0 K DIC W !!,"****Date Range Selection****",!!,"Enter fiscal year or date range within fiscal year",!
 S %DT="AE",%DT("A")="   Beginning DATE : " D ^%DT G Q:Y<0,FY:'$E(Y,4,7) S SDB=Y-.1,%DT(0)=Y W ! S %DT("A")="   Ending DATE : " D ^%DT K %DT G:Y<0 Q W ! D CK G:SDFL 1 S SDE=Y+.9
2 R !,"Sort by 'C'linic or 'S'ervice: C// ",X:DTIME G Q:(X="^")!'$T S Z="^CLINIC^SERVICE" W:X["?" !,"Enter: ",!,?5,"'C' to sort data by clinic",!,?5,"'S' to sort by service" I X="" S X="C" W X
 D IN^DGHELP S SDSC=X G 2:%=-1,4:X="C"
3 F SDI=0:0 W !,"Enter Service: " W:'$D(SDS) "ALL//" R X:DTIME Q:X=""!(X="^")!'$T  D:X["?" QS^SDAMBMR1 S Z="^MEDICINE^SURGERY^PSYCHIATRY^REHAB MEDICINE^NEUROLOGY" D IN^DGHELP I %'=-1 S SDS(X)=""
 G Q:X="^"!'$T I X="",'$D(SDS) S SDS="",SDAS=1
 S VAUTC="" G 5
4 S VAUTNI=1 D CLINIC^VAUTOMA G Q:Y<0
5 R !,"Brief or Expanded Report? B//",X:DTIME G Q:X="^"!'$T S Z="^BRIEF^EXPANDED" W:X["?" !,"Enter 'B'rief to see a simple breakdown by clinic or service",!,"or 'E'xpanded to be able to sort by procedure or by patient" I X="" S X="B" W X
 ;D IN^DGHELP S SDRT=X G 5:%=-1,9:X="B"
 D IN^DGHELP S SDRT=X G 5:%=-1 I SDRT="B" S SDMOD=0 G 9
6 R !,"Sort by 'P'rocedure or patient 'N'ame: P//",X:DTIME G Q:X="^"!'$T S Z="^PROCEDURE^NAME" W:X["?" !,"Enter:",!,"'P'to sort by procedure",!,"'N' to sort by patient name" I X="" S X="P" W X
 D IN^DGHELP S SDPN=X G 6:%=-1,8:X="P"
7 S VAUTNI=1 D PATIENT^VAUTOMA G Q:Y<0 D MOD G 9
8 S DIC="^ICPT(",DIC("S")="I $P($$CPT^ICPTCOD(Y),U,7)",VAUTNI=1,VAUTSTR="CPT code",VAUTVB="SD" D FIRST^VAUTOMA G Q:Y<0 S SDP=SD
 I $D(SD) F I=0:0 S I=$O(SD(I)) Q:I'?5AN  S SDP(SD(I))=I K SD(I)
 K SD
 D MOD
PN W !,"Do you want to see patient names" S %=2 D YN^DICN I %Y["?" W !,"Enter 'Y'es to see patients alphabetized within procedure",!,"'N'o to see just subtotals of number of patients receiving each procedure."
 G Q:%Y["^",PN:%'>0 S SDPT=%
9 W !,"*** Note: this report not designed to display on a CRT.  ***" S DGVAR="SDAS^VAUTD#^SDB^SDE^SDSC^SDS#^VAUTC#^SDRT^SDPN^VAUTN#^SDP#^SDPT^SDMOD",DGPGM="10^SDAMBMR" D ZIS^DGUTQ G:POP Q U IO D 10 Q
10 N SDDT,SDOE,SDOE0,SDVIEN,SDOEP,SDCODT,SDVCPT
 K ^TMP("SDVSTS",$J)
 K ^TMP("SDV",$J)
 S SDFG=0
 S VADAT("F")=1,VADAT("D")="/" D ^VADATE
 D INIT^SDAMBMR3
 S SDNOW=$TR($$FMTE^XLFDT(VADATE("I"),"5F")," ","0")
 D KVAR^VADATE
 ;
 S SDDT=SDB F  S SDDT=$O(^SCE("B",SDDT)) Q:'SDDT!(SDDT>SDE)  D
 . S SDI=SDDT
 . S SDOE=0
 . F  S SDOE=$O(^SCE("B",SDDT,SDOE)) Q:'SDOE  D
 . . I $$OKAE^SDVSIT2(SDOE),$D(^SCE(SDOE,0)) D
 . . . S SDOE0=$G(^SCE(SDOE,0))
 . . . S DFN=+$P(SDOE0,U,2)
 . . . S SDVIEN=+$P(SDOE0,U,5)
 . . . S SDOEP=+$P(SDOE0,U,6)
 . . . S SDCODT=+$P(SDOE0,U,7)
 . . . ;
 . . . ; -- checks
 . . . Q:SDOEP                                   ; -- can't have a parent
 . . . Q:'SDCODT                                 ; -- co must be completed
 . . . Q:'$D(^DPT(DFN,0))                        ; -- pat record must exist
 . . . IF SDVIEN,$D(^TMP("SDVSTS",$J,SDVIEN)) Q  ; -- only process visit once
 . . . IF 'SDVIEN,$D(^TMP("SDV",$J,DFN,+$P(+SDOE0,"."),+$P(SDOE,U,4))) Q  ; -- only process dfn/date/clinic once for old encounters
 . . . Q:'$$CPT^SDOE(SDOE)                       ; -- at least one cpt exists
 . . . Q:$P($G(^SC(+$P(SDOE0,U,4),0)),U,3)'="C"  ; -- location must be a clinic
 . . . ;
 . . . D ^SDAMBMR1
 . . . IF SDVIEN S ^TMP("SDVSTS",$J,SDVIEN)=SDOE
 . . . IF 'SDVIEN S ^TMP("SDV",$J,DFN,+$P(+SDOE0,"."),+$P(SDOE,U,4))=SDOE
 K ^TMP("SDVSTS",$J)
 K ^TMP("SDV",$J)
 ;
 D 1^SDAMBMR2:SDTOT,NONE^SDAMBMR1:'SDTOT
Q W ! K SDAGE,SDAGEH,SDAGET,SDAGETT,SDAS,SDB,SDCL,SDCT,SDDIV,SDE,SDF,SDFG,SDFL,SDFY,SDHI,SDI,SDINFO,SDJ,SDN,SDNOW,SDP,SDPG,SDPN,SDPR,SDPRC,SDPRO,SDPT,SDRT,SDS,SDSC,SDSTP,SDSTR,SDSXF,SDSXM,SDT,SDTOT,SDTT,SDTXT,SDVB,SDX,SDY,SDVST
 K %,^TMP($J),%DT,%Y,DFN,DGPGM,DGVAR,DIC,I,I1,J,J1,K,K1,L,L1,M,N,POP,PR,SDMOD,VAUTC,VAUTD,VAUTN,X,Y,Z,QUES,%I,%QMK,%YN,ANS,C,DEF D KVAR^VADPT,KVAR^VADATE,CLOSE^DGUTQ Q
FY S SDFY=$E(Y,1,3),SDB=((SDFY-1_"1001")-.1),SDE=(SDFY_"0930")+.9 G 2
QQ S SDTXT=$P($P(DIC("A")," ",2),":") W !,"Enter a ",SDTXT," or 'return' when all ",SDTXT,"s have been selected",!,"You may select a maximum of 20 ",SDTXT,"s" Q
CK S SDY=$S($E(SDB,4,5)>9:$E(SDB,1,3)+1,1:$E(SDB,1,3)) I Y>(SDY_"1000") W !,"Dates must be within fiscal year" S SDFL=1 Q
 Q
MOD N DIR,Y,DTOUT,DIRUT,DUOUT
 S DIR(0)="Y"
 S DIR("A")="Do you want to include CPT modifiers on the report"
 S DIR("B")="Yes"
 D ^DIR
 I $D(DTOUT)!($D(DIRUT)) G Q
 S SDMOD=+Y
 Q
