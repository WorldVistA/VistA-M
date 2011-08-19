PSGDCT1 ;BIR/DAV,MLM-DRUG COST TOTALS SORTING ;21 MAY 96 / 7:49 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 K ^TMP($J) S PSGP2=$S(PSGDCT=1:0,1:$D(PSGDISP)),ST=SD F  S ST=$O(^PS(57.6,ST)) Q:'ST!(ST>FD)  D
 .S W=0 F  S W=$O(^PS(57.6,ST,1,W)) Q:W=""  D
 ..S WD=+$G(^PS(57.6,ST,1,W,0)) Q:$S('$D(PSGDCLW):0,PSGDCLW="ALL":0,1:'$D(PSGDCLW(WD)))  S S3=$S($D(PSGDCLW):WD,1:"ZZ") S:S3 S3=$P($G(^DIC(42,WD,0)),U)_U_WD
 ..S PR=0 F  S PR=$O(^PS(57.6,ST,1,W,1,PR)) Q:PR=""  D
 ...S DRG=0 F  S DRG=$O(^PS(57.6,ST,1,W,1,PR,1,DRG)) Q:'DRG  D SET
 Q
SET ; Set subscripts.
 S ND=^PS(57.6,ST,1,W,1,PR,1,DRG,0),ND50=$G(^PSDRUG(+DRG,0)),S2=$$SETDRG("DISPENSE DRUG",$P(ND50,U),+DRG)
 I PSGDCT=1 D:'$$EXCLUDE(DRG) SETTMP(S2,S2,S3,ND) Q
 I PSGDCT=2 S OI=+$P($G(^PSDRUG(+DRG,2)),U) Q:$$EXCLUDE(OI)  S S1=$$OIDF(OI) D SETTMP(S1,S2,S3,ND) Q
 S S1=$$SETDRG("VA CLASS",$P($G(^PSDRUG(DRG,0)),U,2),"") D:'$$EXCLUDE(S1) SETTMP(S1,S2,S3,ND) Q
 Q
 ;
EXCLUDE(X) ; Check if item is to be included in report.
 S X=$P(X,U)
 Q $S($G(PSGDCTD)="ALL":0,X="":1,1:'$D(PSGDCTD(X)))
 ;
SETDRG(TYP,X,IEN) ;TYP=TYPE OF DATA, X=DATA NAME, IEN=IEN OF DATA.
 Q $S(X]"":X_U_IEN,1:"Unknown "_TYP_" ("_IEN_")")
 ;
OIDF(OIND)    ; Return Orderable Item name and Dosage form.
 ;; +OIND = orderable item IEN
 NEW X,NAME
 S X=$G(^PS(50.7,+OIND,0))
 S:$P(X,U)]"" NAME=$P(X,U)_" "_$P($G(^PS(50.606,+$P(X,U,2),0)),U)_U_OIND
 Q $S($G(NAME)]"":NAME,1:"Unknown ORDERABLE ITEM "_"("_OIND_")")
 ;
SETTMP(S1,S2,S3,ND) ; Set TMP by select type, dispense drug, and maybe ward.
 S ^TMP($J,"S1",S1,0)=$$INC($G(^TMP($J,"S1",S1,0)),ND) S:PSGDCT=1 $P(^(0),U,3)=$P(ND50,U,9)
 I S2]"",$D(PSGDISP) S ^TMP($J,"S1",S1,S2,0)=$$INC($G(^TMP($J,"S1",S1,S2,0)),ND),$P(^(0),U,3)=$P(ND50,U,9)
 I S3'="ZZ" S X="^TMP($J,""S1"",S1,"_$S('PSGP2:"S3",1:"S2,S3")_",0)",@X=$$INC($G(@X),ND)
 Q
 ;
INC(X,ND) ;Increment amount and cost.
 Q +X+$P(ND,U,2)-$P(ND,U,4)_U_($P(X,U,2)+$P(ND,U,3)-$P(ND,U,5))
 ;
CLM ;
 W !!?2,"Enter a number (dollar amount) to be the lower limit for this report.  This   number may be zero (0) to include all drugs with a positive cost.  A NULL",!,"response will include all drugs.  Enter an '^' to terminate  this report." Q
 ;
ALM ;
 W !!?2,"Enter a number to be the lower dispensing limit (inclusive) for this report.",!,"This number may be zero (0) to include all drugs with a positive dispensing",!,"amount.  A NULL response will include all drugs.  Enter an '^' to "
 W !,"terminate this report."
 Q
 ;
SDH ;
 W !!?2,"Select a DRUG for which you wish to have cost data print."
 Q
 ;
SBCHK ;
 W !!,"Enter '",$E(PSGDCT(1),1),"' to have this report print the drugs in order of ",PSGDCT(2),".",!,"Enter 'C' to have this report print the drugs in descending order of TOTAL COST."
 W !,"Enter 'A' to have this report print the drugs in descending order of the",!,"AMOUNT DISPENSED (in UNITS)." S PSGDCTS=""
 Q
 ;
ENQH ;
 W !!,"Enter the category that the drugs on the report will be selected by...",!,"Enter 'D' for Dispensed Drug",!,"Enter 'O' for Orderable Item",!,"Enter 'V' for VA Class...."
 Q
WDHLP ;
 W !!,"Enter ""YES"" to include dispensing amounts and cost by ward.",!
 Q
