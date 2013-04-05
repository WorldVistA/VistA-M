PSGSEL ;BIR/CML3 - SELECT ORDERS BY WARD, WARD GROUP, PATIENT, OR PRIORITY ;05/15/98 9:26 AM
 ;;5.0;INPATIENT MEDICATIONS;**3,111,145,243,283**;DEC 16, 1997;Build 4
SELECT ; give user choice to select search method
 S:'$D(PSGSSH) PSGSSH="GENERIC"
 ;
 ;*283 - Change prompts for NOCL tag
 N PSGWGSTR,PSGCLSTR,PSGCHKSTR S PSGWGSTR=$S($G(PSGNOCL):"WARD GROUP",1:"GROUP"),PSGCLSTR=$S('$G(PSGNOCL):"CLINIC (C), ",1:""),PSGCHKSTR=$S($G(PSGNOCL):",G,P,W,",1:",C,G,P,W,PR,")
 F  W !!,"Select by ",PSGWGSTR," (G), WARD (W), ",PSGCLSTR_$S($G(PSGPRIFL):"PATIENT (P) or PRIORITY (PR)",1:"or PATIENT (P)")_": " R PSGSS:DTIME W:'$T $C(7) S:'$T PSGSS="^" Q:"^"[PSGSS  D CHK I PSGCHKSTR[(","_PSGSS_",") Q
 N PSGPRMT
 S PSGPRMT=$P(XQY0,U,1)
 ;DAM   5-01-07  Adding new prompt.  If user selects to print by WARD, he is prompted to "Include Clinic Orders?"  If user selects to print by CLINIC, he is prompted to "Include Ward Orders?"
 S PSGINCL=""
 I PSGSS["W" D
 . I (PSGPRMT'["MAR") Q
 . N DIR,DUOUT,DIRUT,DTOUT,X,Y
 . S DIR(0)="Y"
 . W !
 . S DIR("A")="Include Clinic Orders"
 . D ^DIR
 . I Y=1 S PSGINCL=1
 . I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)) S Y=0
 ;
 S PSGINWD=""
 I PSGSS["C" D
 . I (PSGPRMT'["MAR") Q
 . N DIR,DUOUT,DIRUT,DTOUT,X,Y
 . S DIR(0)="Y"
 . W !
 . S DIR("A")="Include Ward Orders"
 . D ^DIR
 . I Y=1 S PSGINWD=1
 . I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)) S Y=0
 ;End DAM 5-01-07
 ;
 K PSGSSA Q:PSGSS'="G"
 I $G(PSGNOCL)=1 S PSGSS2="W"
 E  F  R !!,"Select by WARD GROUP (W) or CLINIC GROUP (C): ",PSGSS2:DTIME W:'$T $C(7) S:'$T PSGSS2="^" Q:"^"[PSGSS2  D CHK2 I "CW"[PSGSS2 Q
 G SELECT:PSGSS2="" S PSGSS=$S(PSGSS2="C":"L",1:"G")
 ;
 ;DAM 5-01-07  Adding new prompt.  If user selects to print by WARD GROUP, he is prompted to "Include Clinic Orders?"  If user selects to print by CLINIC GROUP, he is prompted to "Include Ward Orders?"
 S PSGINCLG=""
 I PSGSS2["W" D
 . I (PSGPRMT'["MAR") Q
 . N DIR,DUOUT,DIRUT,DTOUT,X,Y
 . S DIR(0)="Y"
 . W !
 . S DIR("A")="Include Clinic Orders"
 . D ^DIR
 . I Y=1 S PSGINCLG=1
 . I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)) S Y=0
 ;
 S PSGINWDG=""
 I PSGSS2["C" D
 . I (PSGPRMT'["MAR") Q
 . N DIR,DUOUT,DIRUT,DTOUT,X,Y
 . S DIR(0)="Y"
 . W !
 . S DIR("A")="Include Ward Orders"
 . D ^DIR
 . I Y=1 S PSGINWDG=1
 . I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)) S Y=0
 ;End DAM 5-01-07
 ;
 K PSGSSA Q
 ;
CHK ;
 S PSGSSA="" F Q=1:1:$L(PSGSS) S PSGSSA=PSGSSA_$S($E(PSGSS,Q)'?1L:$E(PSGSS,Q),1:$C($A(PSGSS,Q)-32))
 F X=$S($G(PSGNOCL):"GROUP",1:"CLINIC"),"GROUP","WARD","PATIENT",$S($G(PSGPRIFL):"PRIORITY",1:"PATIENT") I $P(X,PSGSSA)="" W $P(X,PSGSSA,2,99) S PSGSS=$S($E(PSGSSA,1,2)="PR":"PR",1:$E(PSGSSA)) Q
 Q:$T  I PSGSS'?1."?" W $C(7),"  ??" S PSGSS="Z" Q
 W ! D @PSGSSH W !!?2,"To leave this option, press the RETURN key or enter '^'." Q
 ;
CHK2 ;
 S PSGSSA="" F Q=1:1:$L(PSGSS2) S PSGSSA=PSGSSA_$S($E(PSGSS2,Q)'?1L:$E(PSGSS2,Q),1:$C($A(PSGSS2,Q)-32))
 F X="WARD","CLINIC" I $P(X,PSGSSA)="" W $P(X,PSGSSA,2,99) S PSGSS2=$E(PSGSSA) Q
 Q:$T  I PSGSS2'?1."?" W $C(7),"  ??" S PSGSS2="Z" Q
 W ! D @PSGSSH W !!?2,"To leave this option, press the RETURN key or enter  '^'." Q
 ;
HELP ; the following are the help text messages for the various options
 ;
GENERIC W !!,?2,"To run this option for an entire WARD GROUP, enter 'G'.  To run this option for a single WARD, enter 'W'.  To run this option for a single PATIENT, enter 'P'." Q
 ;
VBW W !!?2,"To verify all of the orders in an entire WARD GROUP, enter 'G'. To verify"
 W !,"all of the orders in an entire CLINIC GROUP, enter 'CG'. To verify all of the"
 W !,"orders in a single WARD, enter 'W'. To verify all of the orders in a single"
 W !,"CLINIC, enter 'C'. To verify all of the orders for a single PATIENT, enter"
 W !,"'P'."
 I $G(PSGPRIFL) W " To verify all of the orders for a single PRIORITY, enter 'PR'."
 Q
 ;
EXP W !?2,"To print STOP ORDER NOTICES for an entire WARD GROUP, enter 'G'.  To print  notices for a single WARD, enter 'W'.  To print notices for a single PATIENT, enter 'P'." Q
 ;
MAR W !?2,"To run a Medication Administration Record (MAR or CMR) for an entire WARD",!,"GROUP, enter 'G'.  To run an MAR for a single WARD, enter 'W'.  To run an   MAR for a single PATIENT, enter 'P'." Q
 ;
LBL W !?2,"To print labels for all of the orders in an entire WARD GROUP, enter 'G'.   To print labels for all of the orders in a WARD, enter 'W'.  To print the",!,"labels for a single PATIENT, enter 'P'." Q
 ;
TCR W !?2,"To run a TOTAL COST REPORT for an entire WARD GROUP, enter 'G'.  To run the report for a single WARD, enter 'W'.  To run the report for a single PATIENT,",!,"or a set of PATIENTS, enter 'P'." Q
 ;
PPR W !?2,"To print PATIENT PROFILES for an entire WARD GROUP, enter 'G'.  To print    profiles for a single WARD, enter 'W'.  To print a profile for a single",!,"PATIENT, enter 'P'." Q
 ;
AP W !?2,"To print ACTION PROFILES for an entire WARD GROUP, enter 'G'.  To print",!,"ACTION PROFILES for a single WARD, enter 'W'.  To print an ACTION PROFILE",!,"for a single patient, enter 'P'.  PLEASE NOTE that only patients"
 W " with active",!,"orders are selectable, and that only patients with active orders will print for",!,"a ward or ward group." Q
ORVC W !?2,"To complete orders for an entire WARD GROUP, enter 'G'. To complete orders for an entire CLINIC GROUP, enter 'CG'"
 W "To complete orders for a single WARD, enter 'W'.  To complete orders for a single PATIENT, enter",!,"a 'P'." Q
 ;
PRI ; Priompt for Priority along with Group, Ward, Clinic and Patient
 S PSGPRIFL=1 D SELECT K PSGPRIFL
 Q
 ;
NOCL ; *283 - Prompt to only allow Ward Group, Ward, and Patient
 N PSGNOCL S PSGNOCL=1 D SELECT
 Q
