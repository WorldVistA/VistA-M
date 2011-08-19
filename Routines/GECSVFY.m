GECSVFY ;WISC/RFJ-verify and check code sheet parameters           ;18 Nov 93
 ;;2.0;GCS;;MAR 14, 1995
 N %,GECSFIX
 S XP="Do you want to check the batch types for errors",XH="Enter 'YES' to start the checker, 'NO' or '^' to exit."
 W ! I $$YN^GECSUTIL(1)'=1 Q
 S XP="When a discrepancy is found, do you want me to try and fix it",XH="Enter 'YES' to fix discrepancies, 'NO' to not fix them, '^' to exit."
 W ! S %=$$YN^GECSUTIL(2) I '% Q
 S GECSFIX=$S(%=1:1,1:0)
 D GO^GECSVFY0
 Q
