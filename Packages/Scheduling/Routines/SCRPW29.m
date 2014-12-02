SCRPW29 ;RENO/KEITH - ACRP Ad Hoc Report (cont.) ;03 Aug 98  8:56 PM
 ;;5.3;Scheduling;**144,593**;AUG 13, 1993;Build 13
 ;
XY(X) ;Maintain $X, $Y
 ;Required input: X=screen handling
 N DX,DY S DX=$X,DY=$Y W X X SDXY Q ""
 ;
MAR ;Margin note
 I $G(SDPAR("F",2))!$D(SDPAR("PF")),$P(SDPAR("F",6),U)="F" W !,"This report requires 132 column output!",!
 Q
 ;
PFC() ;Print field choice
 Q $S('$D(SDPAR("F",3)):"","EB"[$P(SDPAR("F",3),U):"X:ADDL. PRINT FIELDS;",1:"")
 ;
PF ;Print fields prompter
 Q:SDOUT!'$D(SDPAR("F",3))  Q:SDOUT!("EB"'[$P(SDPAR("F",3),U))
 K SDBOT S SDBOT(1)="Additional print field selection",SDBOT(2)="Additional print fields that are selected will be included in the output of",SDBOT(3)="encounter, visit, or unique patient detail lists,"
 D DISP^SCRPW23("A D D I T I O N A L   P R I N T   F I E L D S",.SDBOT)
 S SDD=$P($G(SDPAR("F",4)),U) Q:SDOUT!(SDD="")  S SDD=$S(SDD="E":1,1:2),SDS1="PF",(SDOUT,SDNUL)=0
 D PFL S SDS1="PF" F  Q:SDOUT!SDNUL  D PF1
 Q
 ;
PF1 W !!?10,$$XY(IORVON),"Select additional print fields for patient detail:  (optional)",$$XY(IORVOFF)
 K DIR S DIR("A")="Specify additional print field",DIR("?")="These fields will be included in the patient detail list output."
 S S1=$$DIR^SCRPW23(.DIR,1,"","","O",SDD) Q:SDOUT!SDNUL
 K DIR S DIR("A")="Select "_$P(S1,U,2)_" category",S2=$$DIR^SCRPW23(.DIR,2,"",$P(S1,U),"O",SDD,1) Q:SDOUT  I SDNUL S SDNUL=0 Q
 S SDSEL=$P(S1,U)_$P(S2,U) G:$D(SDPAR("PFX",SDSEL)) PFD
 S SDS2=$P(^TMP("SCRPW",$J,"ACT",SDSEL),T,11),SDS3=$O(SDPAR(SDS1,SDS2,""),-1)+1,SDPAR(SDS1,SDS2,SDS3)=SDSEL_U_$P(S1,U,2)_U_$P(S2,U,2),SDPAR("PFX",SDSEL,SDS2,SDS3)=""
 Q
 ;
PFD N DIR S DIR(0)="Y",DIR("A")="This item is already selected as a print field, do you want to delete it",DIR("B")="NO" D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 I Y S S1=$O(SDPAR("PFX",SDSEL,"")),S2=$O(SDPAR("PFX",SDSEL,S1,"")) K SDPAR("SDX",SDSEL),SDPAR("PF",S1,S2) W !,"deleted..."
 Q
 ;
PFL ;List print field selections
 Q:SDOUT!'$D(SDPAR("PF"))  N SDOUT,SDI,SDX S (SDI,SDOUT)=0 W !!,"Additional print fields currently selected:"
 F S1=2,1 S S2=0 F  S S2=$O(SDPAR("PF",S1,S2)) Q:SDOUT!'S2  S SDI=SDI+1 D:SDI#10=0 WAIT Q:SDOUT  S SDX=SDPAR("PF",S1,S2) W !,$J($P(SDX,U,2)_": ",30),$P(SDX,U,3)
 Q:SDOUT  D WAIT Q
 ;
WAIT N DIR S DIR(0)="E" W ! D ^DIR S:'Y SDOUT=1 W ! Q
 ;
PFR ;Remove print fields per parameter re-edits
 I $P($G(SDPAR("F",1)),U)="S"!($P($G(SDPAR("F",3)),U)="D") K SDPAR("PF"),SDPAR("PFX") Q
 Q:SDOUT!($P($G(SDPAR("F",4)),U)="E")
 S S2=0 F  S S2=$O(SDPAR("PF",1,S2)) Q:SDOUT!'S2  S SDSEL=$P(SDPAR("PF",1,S2),U) K SDPAR("PFX",SDSEL),SDPAR("PF",1,S2)
 Q
 ;
APFP ;Addl. print fields print
 N SDC,SDC1,SDII,SDIII,S1,S2,SDX,SDY,SDACT,SDOE0 S SDII=0,SDC=$S(SDF(4)="E":81,SDF(4)="V":70,1:63) D:'SDI APF(2) D APF(1) W:$D(SDPAR("PF")) ! Q
 ;
APF(S1) ;Addl. print field
 S S2=0 F  S S2=$O(SDPAR("PF",S1,S2)) Q:SDOUT!'S2  S SDY=SDPAR("PF",S1,S2),SDACT=^TMP("SCRPW",$J,"ACT",$P(SDY,U)) D:$Y>(IOSL-4) HDR1 Q:SDOUT  W:SDII ! W ?(SDC),$P(SDACT,T),": " S SDII=SDII+1 D APF1
 Q
 ;
APF1 N DIWL,DIWF,SDL2
 K SDX S SDOE0=$$OE0() X $P(SDACT,T,7) S SDIII=0,SDX="",SDC1=SDC+2+$L($P(SDACT,T))
 S DIWL=1 S DIWF="C"_(51-(SDC1-SDC)+(81-SDC))_"|"
 F  S SDX=$O(SDX(SDX)) Q:SDOUT!(SDX="")  D:$Y>(IOSL-2) HDR1 Q:SDOUT  D
 . K ^UTILITY($J,"W") S X=$P(SDX(SDX),U,2) D ^DIWP
 . F SDL2=1:1:^UTILITY($J,"W",DIWL) D  S SDIII=SDIII+1
 . . W:SDIII ! W ?(SDC1),$E(^UTILITY($J,"W",DIWL,SDL2,0),1,(51-(SDC1-SDC)+(81-SDC)))
 Q
 ;
OE0() ;Get encounter node
 Q:SDOUT!("UV"[SDF(4)) U_DFN_U
 Q $$GETOE^SDOE(SDOE)
 ;
HDR1 D HDR("Report Detail"),HD2,DPHD S SDI=0,(SDII,SDIII)=1 Q
 ;
VF(SDISP) ;Verify format parameters
 N SDX,SDI,SDV S SDX=$G(SDPAR("F",1)) I '$L(SDX) S SDV="Format" G VQ
 G @("VF"_$P(SDX,U))
 ;
VFD K SDPAR("F",2) F SDI=3,6 S SDV=$D(SDPAR("F",SDI)) Q:'SDV
 I 'SDV S SDV="Format" G VQ
 S SDV=$P(SDPAR("F",3),U) I "EB"[SDV,'$D(SDPAR("F",4)) S SDV="Format" G VQ
 I "DB"[SDV,'$D(SDPAR("F",5)) S SDV="Format" G VQ
 Q 0
 ;
VFS F SDI=3,4,5 K SDPAR("F",SDI)
 F SDI=2,6 S SDV=$D(SDPAR("F",SDI)) Q:'SDV
 I 'SDV S SDV="Format" G VQ
 Q 0
 ;
VP(SDISP) ;Verify perspective parameters
 I '$D(SDPAR("P",1)) S SDV="Perspective" G VQ
 I $P(SDPAR("F",1),U)="D",'$D(SDPAR("P",1,4)) S SDV="Perspective" G VQ
 Q 0
 ;
VL(SDISP) ;Verify limitation parameters
 N SDI,SDV F SDI=1,2 S SDV=$D(SDPAR("L",SDI)) Q:'SDV
 I 'SDV S SDV="Limitation" G VQ
 Q 0
 ;
VO(SDISP) ;Verify output order parameter
 I '$D(SDPAR("O",1)) S SDV="Order" G VQ
 Q 0
 ;
VQ ;Prompt for re-edit
 ;Required input: SDV=validation area
 I $G(SDISP) W !,$C(7),$$XY(IORVON)," ",SDV," parameters are incomplete.",$$XY(IORVOFF) S SDOUT=1 Q 0
 N DIR S DIR(0)="Y",DIR("A")=SDV_" parameters are incomplete.  Re-edit",DIR("B")="YES" D ^DIR I $D(DTOUT)!$D(DUOUT)!'$G(Y) S SDOUT=1 Q 0
 Q 1
 ;
 ; Verify diagnoses specified as Report Perspective or Report Limitations have a valid / common
 ; code set (ICD-9-CM / ICD-10-CM) that matches the Report Limitation date range.
VERICD(ICDERR) ;
 N SDX,SDI,SDV,I10DTI,I10DTE,CSYS
 ;
 ; Retrieve the ICD-10 implementation date.
 S Y=$$IMP^SCRPWICD(30) S I10DTI=Y X ^DD("DD") S I10DTE=Y
 ; 
 ; Find the expected diagnosis code set given the Report Limitation date range.
 S CSYS=$S($P(SDPAR("L",1),U,1)<I10DTI:1,1:30)
 ;
 ; If diagnoses are specified for the Report Perspective, find the code set of the first diagnosis.
 ; (All the diagnoses should / must always be of the same code set.)
 ; Throw an error if the code set does not match the expected code set.
 ; The error is described as a Report Limitation date range error simply because the Report Perspective is entered first.
 D
 . S SDX=$P($G(SDPAR("P",1)),U,1) Q:SDX'="DX"
 . S SDX=$P($G(SDPAR("P",1,1)),U,1) Q:(SDX'="PD")&(SDX'="SD")&(SDX'="AD")
 . S SDX=$P($G(SDPAR("P",1,2)),U,1) Q:(SDX="N")
 . S SDX=$O(SDPAR("P",1,5,"")) Q:SDX=""
 . S SDX=$$CSI^SCRPWICD(80,SDX) Q:SDX=""  Q:SDX=CSYS
 . S:SDX=1 ICDERR="The Report Limitation dates must be before "_I10DTE_" to match the (ICD-9-CM) diagnoses specified in the Report Perspective."
 . S:SDX=30 ICDERR="The Report Limitation dates must be on or after "_I10DTE_" to match the (ICD-10-CM) diagnoses specified in the Report Perspective."
 ;
 Q:$G(ICDERR)]"" 1
 ;
 ; If diagnoses are specified for the Report Limitations, find the code set of the first diagnosis in each set of diagnoses.
 ; (All the diagnoses in a set should / must always be of the same code set.) 
 ; Throw an error if the code set does not match the expected code set.
 S SDI=2
 F  S SDI=$O(SDPAR("L",SDI)) Q:SDI=""  D  Q:$G(SDV)]""
 . S SDX=$P(SDPAR("L",SDI),U,1) Q:SDX'="DX"
 . S SDX=$P(SDPAR("L",SDI,1),U,1) Q:(SDX'="PD")&(SDX'="SD")&(SDX'="AD")
 . S SDX=$P(SDPAR("L",SDI,2),U,1) Q:(SDX="N")
 . S SDX=$O(SDPAR("L",SDI,5,"")) Q:SDX=""
 . S SDX=$$CSI^SCRPWICD(80,SDX) Q:SDX=""  Q:SDX=CSYS
 . S ICDERR="All Report Limitation diagnoses must be ("_$S(CSYS=30:"ICD-10-CM",1:"ICD-9-CM")_") to match the report dates."
 ;
 Q:$G(ICDERR)]"" 1
 ;
 Q 0
 ;
DDPH(SDI) ;Detail dx/procedure header
 Q:SDOUT  N SDX S SDX=$E(SDF(5)) I $L(SDF(5))>1 F SDII=2:1:$L(SDF(5)) S SDX=SDX_" "_$E(SDF(5),SDII)
 S SDX="D E T A I L   O F   T O P   "_SDX_$S(SDI="D":"   D I A G N O S I S E S",1:"   P R O C E D U R E S")
 W !?(IOM-$L(SDX)\2),SDX,!?(IOM-$L(SDX)\2),$E(SDLINE,1,$L(SDX))
 I SDI="D" W !?(SDCOL),"Diagnosis",?(SDCOL+49),"Primary",?(SDCOL+62),"Secondary",?(SDCOL+81),"Total"
 I SDI="D" W !?(SDCOL),"------------------------------------------",?(SDCOL+46),"----------",?(SDCOL+61),"----------",?(SDCOL+76),"----------"
 I SDI="P" W !?(SDCOL+13),"Procedures",?(SDCOL+61),"Total",!?(SDCOL+13),"--------------------------------------",?(SDCOL+56),"----------"
 Q
 ;
DPHD ;Detail patient subheader
 Q:SDOUT  N SDX S SDX="D E T A I L   O F   P A T I E N T   "_$S(SDF(4)="E":"E N C O U N T E R S",SDF(4)="V":"V I S I T S",1:"U N I Q U E S")
 W !?(IOM-$L(SDX)\2),SDX,!?(IOM-$L(SDX)\2),$E(SDLINE,1,$L(SDX))
 I SDF(4)="E" W !?(SDCOL),"Patient:",?(SDCOL+20),"SSN:",?(SDCOL+32),"Date:",?(SDCOL+52),"Location:" D APFH(81) W !?(SDCOL),$E(SDLINE,1,18),?(SDCOL+20),$E(SDLINE,1,10),?(SDCOL+32),$E(SDLINE,1,18),?(SDCOL+52),$E(SDLINE,1,28) D APFL(81)
 I SDF(4)="V" W !?(SDCOL+13),"Patient:",?(SDCOL+45),"SSN:",?(SDCOL+57),"Date:" D APFH(70) W !?(SDCOL+13),$E(SDLINE,1,30),?(SDCOL+45),$E(SDLINE,1,10),?(SDCOL+57),$E(SDLINE,1,11) D APFL(70)
 I SDF(4)="U" W !?(SDCOL+19),"Patient:",?(SDCOL+51),"SSN:" D APFH(63) W !?(SDCOL+19),$E(SDLINE,1,30),?(SDCOL+51),$E(SDLINE,1,10) D APFL(63)
 Q
 ;
APFH(SDC) ;Addl. print field subheader
 Q:SDOUT!'$D(SDPAR("PF"))  W ?(SDC),"Additional print fields:" Q
 ;
APFL(SDC) ;Addl. print field subheader, cont.
 Q:SDOUT!'$D(SDPAR("PF"))  W ?(SDC),$E(SDLINE,1,51) Q
 ;
HD1 ;Subheader for summary
 Q:SDOUT  I SDCOL=0 W !?77,"Prior",?87,"Prior",?97,"Prior",?105,"Percent",?115,"Percent",?125,"Percent"
 I SDCOL=0 W !?78,"Year",?88,"Year",?98,"Year",?106,"Change",?116,"Change",?126,"Change"
 W !?(SDCOL),$P(SDPAR("P",1,1),U,2),":",?(SDCOL+44),"Encount.",?(SDCOL+56),"Visits",?(SDCOL+65),"Uniques"
 I SDCOL=0 W ?74,"Encount.",?86,"Visits",?95,"Uniques",?104,"Encount.",?116,"Visits",?125,"Uniques"
 W !?(SDCOL),"------------------------------------------  --------  --------  --------  " W:SDCOL=0 "--------  --------  --------  --------  --------  --------" Q
 ;
HD2 Q:SDOUT  N SDI F SDI=1,2 W !?(IOM-$L(SDPTX(SDI))\2),SDPTX(SDI)
 W !,SDLINE Q
 ;
HDR(SDTITL) ;Print report header
 I $E(IOST)="C",SDPAGE>1 N DIR S DIR(0)="E" D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP^SCRPW26 Q:SDOUT  I '$L($G(SDXY)) S SDXY=^%ZOSF("XY")
 D:'$G(SDHIN) HIN^SCRPW27 W:SDPAGE>1 @IOF N DX,DY S (DX,DY)=0 X SDXY
 W SDLINE,!?(IOM-28\2),"<*>  ACRP AD HOC REPORT  <*>" I $L(SDTITLX) W !?(IOM-$L(SDTITLX)\2),SDTITLX
 W !?(IOM-$L(SDTITL)\2),SDTITL,!,SDLINE,! I $L(SDPBDT),$L(SDPEDT) W "For date range: ",SDPBDT," to ",SDPEDT,!
 W "Date printed: ",SDPNOW,?(IOM-7-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1 Q
