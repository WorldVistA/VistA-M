DENTQ ;ISC2/SAW-DENTAL PATIENT INQUIRY ;4/17/90  16:13 ;
 ;;VERSION 1.2;;**11**; 
 W !! S DIC="^DPT(",DIC(0)="AEMQZ" D ^DIC G EXIT:Y<0 S DFN=+Y D ALL^VADPT
 S X="",$P(X,"-",81)="" W @IOF,$C(13),X
 W !,"NAME: ",VADM(1),?35,"SSN: ",$P(VADM(2),"^",2),?55,"AGE: ",VADM(4),?67,"SEX: ",$P(VADM(5),"^",2),!,X
 W !!,"ELIGIBILITY: ",$P(VAEL(1),"^",2),!!,"LEGAL RESIDENCE: ",VAPA(1)
 W:VAPA(2)]"" !,?17,VAPA(2) W:VAPA(3)]"" !,?17,VAPA(3) W !,?17 W:VAPA(4)]"" VAPA(4),", " W:VAPA(5)]"" $P(VAPA(5),"^",2) W:VAPA(6)]"" "  ",VAPA(6) W:VAPA(8)]"" !,?17,VAPA(8)
 I 'VAIN(1) W !!,"PATIENT IS NOT CURRENTLY ADMITTED." G REM
 W !!,"ADMISSION DATE: ",$P(VAIN(7),"^",2) W ?37,"WARD: ",$P(VAIN(4),"^",2),?55,"ROOM-BED: ",VAIN(5)
 W:VAIN(9)]"" !,"ADMITTING DIAGNOSIS: ",VAIN(9)
REM W:VADM(7)]"" !!,"REMARKS: ",VADM(7) D KVAR^VADPT G DENTQ
EXIT K DIC,X,Y Q
Q1 W !!,"Enter 'Y' or 'Yes' to enable a range of treatment data for re-release.",!,"Press return or enter 'N' or 'No' if you do not want to enable a range",!,"of treatment data for re-release.  Enter an uparrow (^) to exit." Q
Q2 W !!,"Enter 'Y' or 'Yes' to edit or display this data entry.  Press return or",!,"enter 'N' or 'No' if you do not want to edit or display this data entry.",!,"Enter an uparrow (^) to exit." Q
Q3 W !,"Enter 'Y' or 'Yes' to enable this data for re-release.  Press return or",!,"enter 'N' or 'No' if you do not want to enable this data for re-release.",!,"Enter an uparrow (^) to exit." Q
Q4 W !!,"Enter a 'Y' or 'Yes' if you are ready to transmit this data to Austin.",!,"Press return or enter an uparrow (^) if you want to re-edit the data or",!,"are not sure you want to release the data at this time." Q
Q5 W !!,"Enter 'Y' or 'Yes' to include composite time value (CTV) information in this",!,"report.  Press return if you do not want to include CTV information.",!,"Enter an uparrow (^) to exit this option entirely." Q
Q6 W !!,"Enter 'Y' or 'Yes' to include dollar values along with CTV values in this",!,"report.  Press return if you do not want to include dollar values.",!,"Enter an uparrow (^) to exit this option entirely." Q
