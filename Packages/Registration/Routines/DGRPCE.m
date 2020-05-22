DGRPCE ;ALB/MRL,KV,PJR,BRM,ERC,TDM,LBD - CONSISTENCY CHECKER, EDIT INCONSISTENCIES ;10/20/10 3:52pm
 ;;5.3;Registration;**121,122,175,297,342,451,626,689,653,754,797,855,952**;Aug 13, 1993;Build 160
 ;Per VHA Directive 6402, this routine should not be modified.
 ;
 ;KV;11/15/00;DG*5.3*297;Disable addition of CD Elig Code in Reg. Screens
 ;                      ;Adding CD Elig Codes in Load/Edit Screen used to
 ;                      ;cause undefined line tag error.
 ;
 S DGVTYN=$P($G(^DPT(DFN,"VET")),"^",1),DGDR="DR",(DR,DGD,DGDRC,DGCCF)="",DGASK=",",DGER=","_DGER D ^DGRPCE1
 S DGEK=0 F I=9,10,11,12,13,14,18,19,20,22,24,36,51 Q:DGEK  I DGER[(","_I_",") S DGEK=1 Q
 I 'DGKEY(1) D:DGEK ELDR S I=15 D SASK S I=23 D SASK
 F I=29,30,31,32,33,43,44,45,48,56 D SASK,MON:DGCCF S DGCCF=0
 G NKEY:DGKEY(3) F I=25,26,27,28,34,35 D SASK
 I DGASK'[26 F I=41,42 I DGASK'[41 D SASK
 I DGASK'[27 S I=60 I DGASK'[25 D SASK
 I DGASK'[34 F I=37,38 I DGASK'[37 D SASK
 I DGASK'[35 F I=39,40 I DGASK'[39 D SASK
NKEY D ^DGRPCE1
 I $S(DGER[49:1,(DGER[",50,"):1,(DGER[52):1,1:0) D
 .I $G(DGPRFLG) D PREG^IBCNBME(DFN) Q
 .D REG^IBCNBME(DFN)
 .Q
 D Q
 ;*952 Stop it asking for Patient Type twice
 I DR["391;391;" S DR=$P(DR,"391;",1)_$P(DR,"391;",2,999)
 S DIE="^DPT(",(DA,Y)=DFN D ^DIE:$D(DR)
 I DGER[54 D GETREL^DGMTU11(DFN,"SD",$$LYR^DGMTSCU1(DT)) D
 . I $D(DGREL("S")),($$SSN^DGMTU1(+DGREL("S"))']"") D ASKSSN(DGREL("S"))
 . F DGDEP=0:0 S DGDEP=$O(DGREL("D",DGDEP)) Q:'DGDEP  I $$SSN^DGMTU1(+DGREL("D",DGDEP))']"" D ASKSSN(DGREL("D",DGDEP))
 ;
 I DGER[59 D CATDIB
 I DGER["82" D EN2^DGRP6CL
 ;
 ;Use Screen 6.1 to edit inconsistencies with MSE data (DG*5.3*797)
 ;DG*5.3*855 
 I $$MSERR^DGRPCE1,$G(DGVTYN)="Y" D EN^DGRP61(DFN)
 ;
 I (DGER[301)!(DGER[303)!(DGER[304)!(DGER[307) D
 . N DEPFLD
 . S DEPFLD=""
 . I DGER[301 S DEPFLD=".01;"
 . I (DGER[303)!(DGER[304) S DEPFLD=DEPFLD_".02;"
 . I DGER[307 S DEPFLD=DEPFLD_".1;"
 . D GETREL^DGMTU11(DFN,"SD",$$LYR^DGMTSCU1(DT))
 . I $D(DGREL("S")) D DEPEDT(DGREL("S"),DEPFLD)
 . F DGDEP=0:0 S DGDEP=$O(DGREL("D",DGDEP)) Q:'DGDEP  D DEPEDT(DGREL("D",DGDEP),DEPFLD)
 ;
 K DGREL,DGDEP
KVAR K DR,DGEDCN,DGCT,DGER,DGINC55,DGRPADI,DGRPOUT,DGVTYN
Q K %,C,DA,DGASK,DGCCF,DGCT1,DGCT2,DGCT3,DGD,DGD1,DGD2,DGDR,DGDRC,DGECODE,DGEDIT,DGEK,DGKEY,DGP,DGRPADI,DGRPE,DIC,DIE,DIK,I,I1,J,X,X1,X2
 K DGCOMLOC,DGCOMBR,FRDT,DGFRDT,DGCTZ7
 D KVAR^VADPT
 Q
SASK I DGER[(","_I_","),DGASK'[(","_I_",") S DGD=$P($T(@I),";;",2,999),DGASK=DGASK_I_",",DGCCF=1 D SAVE
 Q
SAVE I $L(@DGDR)+$L(DGD)<241 S @DGDR=@DGDR_DGD,DGD="" Q
 S DGDRC=DGDRC+1,DGDR="DR(1,2,"_DGDRC_")",@DGDR=DGD,DGD="" Q
ELDR S DGASK=DGASK_"9,10,11,12,13,14,18,19,20,24,29,30,31,34,36,37,38,"
 I 'DGKEY(1) S DGD="391;1901;S DGVTYN=$S($D(^DPT(DFN,""VET"")):$P(^(""VET""),""^"",1),1:"""");S:X'=""Y"" Y=""@1"";.301;S:X'=""Y"" Y=""@1"";.302;@1;" D SAVE
 I 'DGKEY(2) F I=29,30,31 S DGD=$P($T(@I),";;",2,999) D SAVE
 ;DG*5.3*855
 D:DGD]"" SAVE I 'DGKEY(3) S DGD=$P($T(34),";;",2,999) D SAVE
 I 'DGKEY(1) D ELIG^DGRPCE1
 Q
MON I $S(I<40:1,I=56:1,1:0) D SAVE Q
 I $S(I<46:1,1:0),DGASK'[(","_(I-14)_",") D SAVE Q
 I DGASK'[(","_(I-15)_",") D SAVE
 Q
 ;
15 ;;.152;S:X']"" Y="@15";S DIE("NO^")="";.307;I X']"" W !!,*7,"But I need a reason why this applicant is ineligible!" S Y=.152;@15;K DIE("NO^");
23 ;;.3611;S:X'="V" Y="@23";.3612;S DIE("NO^")="";I X']"" W !!,*7,"But I need to know the date eligibility was verified!";@23;K DIE("NO^");
25 ;;.323;.32102;S:X'="Y" Y="@25";.32107;.3211;.32109;.3213;@25;
26 ;;
27 ;;
28 ;;
29 ;;.36205;S:X'="Y" Y="@29";I DGVTYN'="Y" W !,"Patient not a veteran-can't claim A&A" S Y=.36205;.36295;@29;
30 ;;.36215;S:X'="Y" Y="@30";I DGVTYN'="Y" W !,"Patient not a veteran-can't claim HOUSEBOUND" S Y=.36215;.36295;@30;
31 ;;.36235;S:X'="Y" Y="@31";I DGVTYN'="Y" W !,"Patient not a veteran-can't claim VA PENSION" S Y=.36235;.36295;@31;
32 ;;.36255;S:X'="Y" Y="@32";I DGVTYN'="Y" W !,"Patient not a veteran-can't claim MIL. RET." S Y=.36255;.3625;@32;
33 ;;
34 ;;.525;S:X'="Y" Y="@34";I DGVTYN'="Y" W !,"Patient not a veteran-can't claim POW STATUS" S Y=.525;.526:.528;@34;
35 ;;
37 ;;.525;S:X'="Y" Y="@37";.526:.528;@37;
38 ;;.525;S:X'="Y" Y="@38";.526:.528;@38;
39 ;;.5291;S:X'="Y" Y="@39";.5292:.5294;@39;
40 ;;.5291;S:X'="Y" Y="@40";.5292:.5294;@40;
41 ;;.32101;S:X'="Y" Y="@41";.32104;.32105;@41;
42 ;;.32101;S:X'="Y" Y="@42";.32104;.32105;@42;
43 ;;
44 ;;
45 ;;
46 ;;
47 ;;
48 ;;.36265;S:X'="Y" Y="@48";.3626;@48;
 ;DG*5.3*855
51 ;;S Y="@51";I DGVTYN'="Y" S Y="@51";.324:.328;@51;
56 ;;.3025;S:X'="Y" Y="@56";.36295;@56;
60 ;;.32102;S:X'="Y" Y="@60";.32107;.3211;.32109;.3213;@60;
 ;
 ; NOTE: #46 & 47 REMOVED WITH PIMS5.3
 ;
ASKSSN(DEP) ;edit ssns if missing
 ;
 ; input:  DEP as string for dependent (from GETREL)
 ;
 W !,$$NAME^DGMTU1(+DEP)
 S DA=+$P(DEP,"^",2),DIE="^DGPR(408.13,",DR=.09 D ^DIE
PS ;
 S DA=+$P(DEP,"^",2),DIE="^DGPR(408.13,",DR=.09 D ^DIE
 I $$GET1^DIQ(408.13,DA_",",.09)["P" D
 . S DR=.1,DA=$P(DA,";") D ^DIE
 . I X']"" W !,"If SSN is a Pseudo SSN, the Pseudo SSN Reason field is required." G PS
 K DA,DR,DIE
 Q
 ;
CATDIB ;
 ;Could be inconsistent because there is the catastrophic disability
 ;code without supporting information, or visa versa
 ;
 N DGCDIS,CODE,INFO
 S (INFO,CODE)=0
 I $$GET^DGENCDA(DFN,.DGCDIS),DGCDIS("DATE") S INFO=1
 S CODE=$$HASCAT^DGENCDA(DFN)
 I CODE D  Q
 .W !!,">>> Catastrophically Disabled eligibility requires additional information <<<"
 .D EDITCD^DGENCD(DFN)
 I INFO D
 . ;KV;11/15/00;DG*5.3*297;Start of modifications
 . W !!,"The patient record indicates that a  determination was made "
 . W "that the patient",!,"is catastrophically disabled."
 . W !!,"To add Catastrophic Disability Eligibility Code(s), please use "
 . W "the menu option",!,"DGEN PATIENT ENROLLMENT.",!!
 .I $$ASKDEL() D
 .. I $$DELETE^DGENCDA1(DFN) D
 ...W !,">>> Determination Deleted <<<"
 ..;
 ..;could fail if lock could not be obtained
 ..E  W !,"Catastrophic disability determination can not be deleted at this time.",!,"Please try again later."
 ;KV;11/15/00;DG*5.3*297;End of modifications
 Q
 ;
ASKDEL() ;
 ;ask whether to delete catastrophic disability determination
 N DIR
 S DIR(0)="Y"
 ;KV;11/15/00;DG*5.3*297;Cosmetic change for DIR("A")
 S DIR("A")="Do you want to delete the determination showing that patient is catastrophically disabled"
 S DIR("B")="YES"
 D ^DIR
 Q:$D(DIRUT) 0
 Q $S(Y=1:1,1:0)
 ;
DEPEDT(DEP,FLD) ;edit dependent fields if missing or invalid
 ;
 ; input:  DEP as string for dependent (from GETREL)
 ;         FLD as 408.13 field(s) to edit (separated by ';')
 ;
 Q:$G(FLD)=""
 W !!,$$NAME^DGMTU1(+DEP)
 S DA=+$P(DEP,"^",2),DIE="^DGPR(408.13,",DR=FLD D ^DIE
 K DA,DR,DIE
 Q
