SDUNC1 ;MAN/GRR - UNCANCEL CLINIC ; 04 APR 84  10:36 am
 ;;5.3;Scheduling;;Aug 13, 1993
ERRM W !,*7,*7,"This clinic date cannot be restored using the Restore Option because the",!,"pattern was for particular dates only and was created prior to"
 W !,"Scheduling Version 3.55. Availability patterns created with Version",!,"3.55 and beyond WILL be able to be restored using the Restore Option."
 W !,"To restore this particular pattern you will have to use the Set-up",!,"Clinic option and create a new availability for this one date"
 W !,"This will work nicely even if the date cancelled was a partial",!,"cancellation! No appointments will be lost" Q
