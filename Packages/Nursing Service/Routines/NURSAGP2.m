NURSAGP2 ;HIRMFO/MD-ADMINISTRATION/EDUCATION REPORT PROMPTS CONTINUED ;2/27/98  14:25
 ;;4.0;NURSING SERVICE;**9**;Apr 25, 1997
INS ; INSERVICE SELECTION
 S DIR(0)="SO^M:Mandatory Training;C:Continuing Education;O:Other/Miscellaneous;W:Ward/Unit-Location Training;A:All",DIR("A")="Select Sort Parameter(s)" D ^DIR K DIR I $D(DUOUT)!$D(DTOUT)!("^"[X) S NUROUT=1 Q
 S NURSEL=Y
 Q
DATSEL ;
 S DATSEL=U_$G(DATSEL)_U,DIR(0)="SO^C:Calendar Year;F:Fiscal Year;"
 I DATSEL'["^NS^" S DIR(0)=DIR(0)_"S:Selected Date Range;"
 S DIR("A")="Select a Sort Parameter"
 D ^DIR K DIR I $D(DUOUT)!$D(DTOUT)!("^"[X) S NUROUT=1 Q
 S TYP=Y,YR=1700+$E(DT,1,3) I TYP="F" S MN=$E(DT,4,5) S:MN>9 YR=(YR+1)
 S DIR(0)="DA^^K:X'?4N X"
 S X=YR D ^%DT D:+Y D^DIQ S DIR("B")=Y,DIR("?")="This response must be a year i.e. 1990"
 I TYP["C" S DIR("A")="Select "_$S($G(YRSW):"Latest ",1:"")_"Calendar Year: " W ! D
 .D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S NUROUT=1 Q
 .S NYR=$G(Y(0)),YR(6)=$S($G(Y)="":"",1:1700+$E(Y,1,3)),%DT="",X=Y D ^%DT S YRST=+Y,%DT="",X="12/31/"_YR(6) D ^%DT S YREND=+Y K %DT S X1=YRST,X2=-90 D C^%DTC S YRCHK=X
 I TYP["F" S DIR("A")="Select "_$S($G(YRSW):"Latest ",1:"")_"Fiscal Year: " W ! D
 .D ^DIR S NYR=$G(Y(0)),YR(6)=1700+$E(Y,1,3) K DIR I $D(DTOUT)!$D(DUOUT) S NUROUT=1 Q
 .S %DT="",X="10/"_(YR(6)-1) D ^%DT S YRST=+Y S %DT="",X="9/30/"_YR(6) D ^%DT S YREND=+Y K %DT S X1=YRST,X2=-90 D C^%DTC S YRCHK=X
 I TYP["S" K DIR D
 .W ! S X=DT D ^%DT D:+Y D^DIQ S DIR("B")=Y,DIR(0)="DA^::ET",DIR("A")="Start With DATE: ",DIR("?")="^D HELP^%DTC"
 .I DATSEL["^N+^" S DIR(0)="DA^:"_DT_":ET",DIR("?")="^S %DT(0)=-DT D HELP^%DTC"
 .D ^DIR K %DT(0),DIR I $D(DTOUT)!$D(DUOUT)!("^"[X) S NUROUT=1 Q
 .S YRST=+Y,X=DT,%DT(0)=-DT,%DT="T" D ^%DT D:+Y D^DIQ S YRST(1)=$E(YRST,4,5)_"/"_$E(YRST,6,7)_"/"_$E(YRST,2,3) W ! S DIR("B")=Y,DIR("A")="     Go to DATE: "
 .S DIR(0)="DA^"_+YRST_"::ET",DIR("?")="^D HELP^%DTC"
 .I DATSEL["^N+^" S DIR(0)="DA^"_+YRST_":"_DT_":ET",DIR("?")="^S %DT(0)=-DT D HELP^%DTC"
 .D ^DIR K %DT(0),DIR I $D(DTOUT)!$D(DUOUT)!(U[X) S NUROUT=1 Q
 .S X1=YRST,X2=+90 D C^%DTC S YRCHK=X
 .S YREND=+Y_$S(+Y#1:"",1:".2359"),YREND(1)=$E(YREND,4,5)_"/"_$E(YREND,6,7)_"/"_$E(YREND,2,3)
 K DATSEL,YR Q
