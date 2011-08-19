DGPTMOVE ;ALB/JDS - MOVE DRG FY DATA TO UPPER LEVEL ; 26 AUG 84  14:15
 ;;5.3;Registration;**78,158,178,256**;Aug 13, 1993
 ;
EN F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="END"  W !,X
 S DGFLAG=0
 D WHICH
 I 'DGFLAG D FY
 I 'DGFLAG D SET
Q K DGFLAG,DGFY,DGFY2K,DGWHICH,I,X
 Q
 ;
 ;
WHICH ; select which option (local or all)
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR(0)="SM^A:ALL;L:LOCAL",DIR("A")="Copy which trim values"
 S DIR("?",1)="Enter LOCAL if you want to use the local and national trim"
 S DIR("?",2)="values from last year until new trim values are offically"
 S DIR("?",3)="released.  This will copy the local and national trim"
 S DIR("?",4)="values into the next fiscal year.  It will also copy the"
 S DIR("?",5)="local trim values to the upper level of the DRG file for"
 S DIR("?",6)="use on the <701> screen and in the DRG Calculation option."
 S DIR("?",7)=" "
 S DIR("?",8)="Choose ALL if local and national trim values have already"
 S DIR("?",9)="been entered for the current fiscal year and you wish to"
 S DIR("?",10)="copy those figures to the upper level of the DRG file for"
 S DIR("?",11)="use on the <701> screen and in the DRG Calculation option."
 S DIR("?",12)=" "
 S DIR("?")="Choose L LOCAL or A for ALL."
 D ^DIR
 S DGWHICH=Y
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) S DGFLAG=1 Q
 Q
 ;
 ;
FY ; select fiscal year to copy from
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR(0)="F^2:2^I X'?2N K X",DIR("A")="Enter FISCAL YEAR to copy data from"
 S DIR("?",1)="Enter the fiscal year from which you want to copy the trim"
 S DIR("?",2)="values.  The values you selected will be copied from this"
 S DIR("?",3)="year to the upper level of the file."
 I DGWHICH="L" D
 . S DIR("?",3)=DIR("?",3)_"  It will also copy"
 . S DIR("?",4)="all trim data (local and national) to the fiscal year"
 . S DIR("?",5)="following the year you select."
 . S DIR("?",6)=" "
 E  D
 . S DIR("?",4)=" "
 S DIR("?")="Enter the fiscal year as NN (ex: '94' for fiscal year 1994)."
 D ^DIR
 S DGFY=Y
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) S DGFLAG=1 Q
 S DGFY2K=$$DGY2K^DGPTOD0(DGFY)
 I '$D(^ICD("AFY",DGFY2K)) W !!,"No information has been entered yet for the selected fiscal year.",*7,! G FY
 Q
 ;
 ;
SET ; set values into upper level and next fiscal year
 N I,MULT,NODE,UPPER,Y
 S Y=DGFY2K
 X ^DD("DD")
 W !!,"Copying WWU, ALOS, high trims, and low trims from FY",Y," to upper level of file."
 I DGWHICH="L" D
 .W !,"Also copying values from FY",Y," multiple to FY"
 .S Y=DGFY2K+10000 X ^DD("DD") W Y," multiple."
 W ".."
 W ! F I=0:0 S I=$O(^ICD(I)) Q:I'>0  I $D(^ICD(I,"FY",DGFY2K,0)) D
 . N NODE,MULT,UPPER
 . S NODE=$G(^ICD(I,0)),MULT=$G(^ICD(I,"FY",DGFY2K,0))
 . S $P(NODE,"^",15)="",$P(MULT,"^",15)="" ; ensures '^'s out to end of node
 . I DGWHICH="A" D
 . . S UPPER=$P(NODE,U,1)_U_$P(MULT,U,2,4)_U_$P(NODE,U,5,6)_U_$P(MULT,U,8,9)_U_$P(MULT,U,6,7)_U_$P(MULT,U,10)_U_$P(NODE,U,12)
 . I DGWHICH="L" D
 . . S UPPER=NODE
 . . S $P(UPPER,"^",9)=$P(MULT,"^",6),$P(UPPER,"^",10)=$P(MULT,"^",7) ; sets local figures into upper level
 . . S ^ICD(I,"FY",DGFY2K+10000,0)=(DGFY2K+10000)_"^"_$P(MULT,"^",2,10)
 . S ^ICD(I,0)=UPPER
 . W "."
 W !!?17,"******  COPY COMPLETED  ******",!!
 Q
 ;
 ;
TEXT ;
 ;;This option is used to copy values from the FISCAL YEAR WEIGHTS&TRIMS
 ;;multiple of the DRG File for display purposes on the <701> screen and
 ;;in the DRG Calculation option and for the processing of the DRG Reports.
 ;; 
 ;;Values are copied to the upper level of the DRG File for display purposes
 ;;and may also be copied from a fiscal year to the next fiscal year to
 ;;temporarily use a prior fiscal year's values until the current fiscal
 ;;year's values are available.
 ;; 
 ;;Local values must previously have been entered into the DRG File through
 ;;the use of the 'Trim Point Entry' option.
 ;;
 ;;
 ;;END
