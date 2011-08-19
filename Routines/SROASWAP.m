SROASWAP ;B'HAM ISC/MAM - MOVE RISK TO FILE 130 ; 13 APR 1992  8:25 am
 ;;3.0; Surgery ;;24 Jun 93
 S SRLINE="" F I=1:1:80 S SRLINE=SRLINE_"-"
 S SRSOUT=0 I DT<2940401 D NOTYET G END
START D ^SROASWP I SRSOUT G END
DATE ; get starting date
 W ! K %DT S %DT="AEX",%DT("A")="Convert existing assessments starting with which date ? " D ^%DT G:X="^" END I Y<0 D NEEDATE G:SRSOUT END G DATE
 S SRDATE=+Y D ^SROASWP0
 K ^TMP("CONVERT") D ^SROASWP2 K ^TMP("CONVERT")
 I $O(^SRA(0)) W @IOF,!,"The SURGERY RISK ASSSESSMENT file (139) still contains entries.  Before you",!,"enter any additional risk assessment information, all entries in this file ",!,"should be converted or deleted." S SRSOUT=0
 I '$O(^SRA(0)) W @IOF,!,"The conversion process has been completed.  Please review your incomplete",!,"assessments." D ^SROASWPD,DEL
 W !!,"Press RETURN to continue  " R X:DTIME
END D ^SRSKILL K SRTN W @IOF
 Q
NOTYET ; can't convert before April 1, 1994
 W @IOF,!,SRLINE,!,"The conversion of the ""stand-alone"" Surgery Risk Assessment Module cannot",!,"be run until after April 1, 1994.  It should only be run after that date"
 W !,"if your Surgery files are complete, including complications, CPT codes and",!,"anesthesia information since installing Surgery Version 3.0.",!,SRLINE
 W !!,"Press RETURN to continue  " R X:DTIME
 Q
NEEDATE ; message if no date is entered
 W !!,"You must select a starting date to begin the conversion process.  All ",!,"assessments with operation dates prior to the start date will be automatically"
 W !,"deleted.  The remaining assessments will then be processed for conversion."
CONT W !!,"Press RETURN to continue, or '^' to quit: " R X:DTIME I X["^" S SRSOUT=1
 Q
DEL ; delete file 139
 W !!,"The SURGERY RISK ASSESSMENT file will now be deleted from your system... "
 K DIU S DIU(0)="DT",DIU=139 D EN^DIU2
 Q
