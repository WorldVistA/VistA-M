SROASWP ;B'HAM ISC/MAM - ASSESSMENT CONVERSION DESCRIPTION ; 29 DEC 1992 10:45 am
 ;;3.0; Surgery ;;24 Jun 93
 W @IOF,!,SRLINE,!,"This option is used to move the risk assessment data entered through the",!,"""stand-alone"" Surgery Risk Assessment Module into the DHCP Surgery pacakge."
 W !,"The computer will ask you to select a starting date to move the assessments.",!,"All assessments with an operation date prior to this start date will be deleted"
 W !,"prior to converting the remaining entries.  The software will then begin the ",!,"conversion process.  Upon completion of the conversion, there should be no"
 W !,"entries in the SURGERY RISK ASSESSMENT file (139).  The computer will then ",!,"remove that file from your system.",!,SRLINE
 D RET I SRSOUT Q
 W @IOF,!,SRLINE,!,"The conversion process will merge only those data elements that are not already",!,"part of the DHCP Surgery database.  You should only convert the assessments if"
 W !,"the information contained in your surgery database has been kept up to date.",!!,"The following information will NOT be moved from the ""stand-alone"" Surgery",!,"Risk Assessment Module:"
 W !!,"1. Operative Procedures and CPT Codes",!,"2. Diagnosis Information",!,"3. Complications",!,"4. ASA Classification",!,"5. Anesthesia Technique",!,"6. Concurrent Cases",!,"7. Returns to Surgery",!,SRLINE
 D RET I SRSOUT Q
 W @IOF,!,SRLINE,!,"All assessments that have been completed, but not transmitted will have their",!,"status changed to ""INCOMPLETE"" after they are converted.  You should review"
 W !,"these assessments to determine if any of the fields which are not merged need",!,"updated.",!!,"The conversion process will begin by deleting all assessments with a date of"
 W !,"operation prior to the start date selected and all entries in the SURGERY RISK",!,"ASSESSMENT file (139) that have been entered for log purposes only.  These",!,"entries contain no assessment information."
 W !!,"The computer will then automatically merge those assessments for which the ",!,"patient has only one surgical case and one surgery risk assessment for the",!,"date entered in the SURGERY RISK ASSESSMENT file (139)."
 W "  If the patient has ",!,"more than one surgical case on that date, or if there is not any surgical case",!,"entered for the corresponding date in the SURGERY RISK ASSESSMENT file, that"
 W !,"assessment will need to be manually matched.",!,SRLINE
RET W !!,"Press RETURN to continue, or '^' to quit: " R X:DTIME I X["^" S SRSOUT=1
 Q
