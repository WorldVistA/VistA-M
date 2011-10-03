SDAPIER ;ALB/MJK - Outpatient API/Error Processing ; 22 FEB 1994 11:30 am
 ;;5.3;Scheduling;**27**;08/13/93
 ;
ERRFILE(SDERROR,SDATA) ; -- file error
 N SDTEXT,SDTYPE,I,SDERDAT
 S SDERDAT=$$DATA(SDERROR),SDTYPE=$P(SDERDAT,";",3)
 S (I,@SDERROOT@(SDTYPE))=$G(@SDERROOT@(SDTYPE))+1
 S @("SDTEXT="_$P(SDERDAT,";",5)),@SDERROOT@(SDTYPE,I)=SDERROR_U_SDTEXT
 Q
 ;
ERRCHK() ; -- check to see if error ; >1000 are warnings
 Q $G(@SDERROOT@("ERROR"))>0
 ;
DATA(SDERROR) ; -- get error parameters
 N Y,SDTYPE
 S Y=$TEXT(@SDERROR)
 S:Y="" Y="???? ;;E;ERROR;""ERROR HANDLING PROBLEM"""
 S SDTYPE=$P(Y,";",3),$P(Y,";",3)=$S(SDTYPE="E":"ERROR",SDTYPE="W":"WARNING",1:"UNKNOWN")
 Q Y
 ;
TEST ; -- test message
 N Y,ERROR,SDATA
 S SDATA="ONE^TWO^THREE^FOUR^FIVE"
 F  R !,"Enter error#: ",ERROR:DTIME Q:"^"[ERROR  D
 . S Y=$$DATA(ERROR)
 . S @("Y="_$P(Y,";",5)),Y=ERROR_U_Y
 . W !,Y
 Q
 ;
PRINT ; -- print list of errors
 N Y,%ZIS,POP,ZTSK
 W !,">>> Print API Error code Table",!
 S %ZIS="PMQ" D ^%ZIS I POP G PRINTQ
 I '$D(IO("Q")) D START^SDAPIER G PRINTQ
 S Y=$$QUE
PRINTQ D:'$D(ZTQUEUED) ^%ZISC Q
 ;
START ; -- print error table
 U IO
 N SDI,SDATA,SDERROR,SDSECT,SDMSG,SDTYPE,SDASH,SDPAGE,SDERDAT
 S $P(SDASH,"-",IOM)="",SDPAGE=1,SDATA="1 Parameter^2 Parameter^3 Parameter"
 D HDR
 F SDI=2:1 S SDERROR=+$TEXT(ERRORS+SDI) Q:SDERROR=9999  D
 . S SDERDAT=$$DATA(SDERROR),SDTYPE=$P(SDERDAT,";",3),SDSECT=$P(SDERDAT,";",4),@("SDMSG="_$P(SDERDAT,";",5))
 .W !?1,SDERROR,?10,SDTYPE,?25,SDSECT,!?5,"Message: ",SDMSG,!,SDASH
 .I ($Y+6)>IOSL D HDR
STARTQ Q
 ;
HDR ; -- print header
 I SDPAGE>1,$E(IOST,1,2)="C-" D PAUSE^VALM1
 W @IOF,?25,"Outpatient API Error Code Table",?73,"Page: ",SDPAGE,!!
 W !,"Code #",?10,"Type of Code",?25,"Section Affected",!,SDASH
 S SDPAGE=SDPAGE+1
 Q
 ;
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Outpatient API Error Table",ZTRTN="START^SDAPIER"
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
 ;
ERRORS ; -- errors and warning messages
 ;;type;section;message
1 ;;E;BASIC;"No event data array."
2 ;;E;BASIC;"Patient DFN [#"_+SDATA_"] is not valid."
3 ;;E;BASIC;"USER number [#"_+SDATA_"] is not valid."
4 ;;E;BASIC;"CLINIC number [#"_+SDATA_"] is not valid."
5 ;;E;BASIC;"Encounter date is null."
100 ;;E;APPT;"Not a vaild appointment date/time ["_+SDATA_"] for patient [#"_+$P(SDATA,U,2)_"]."
101 ;;E;APPT;"Patient appointment for clinic #"_+SDATA_", not clinic #"_+$P(SDATA,U,2)_", as requested."
102 ;;E;APPT;"Not a vaild appointment slot ["_+SDATA_"] for clinic. [#"_+$P(SDATA,U,2)_"]"
103 ;;E;APPT;"Current appointment status '"_$P(SDATA,U)_"' does not allow check out."
104 ;;E;APPT;"Encounter date/time ["_+SDATA_"] is greater than today. ["_DT_"]."
110 ;;E;APPT;"Encounter ien not available."
130 ;;E;CO;"Hospital Location for appointment is not a clinic. [#"_+SDATA_"]"
1100 ;;W;CO;"Appointment already checked-out."
1030 ;;W;CO;"Appointment does not need to be checked-out. (Before check-out requirement)"
1031 ;;W;CO;"Patient was an inpatient at the time of appointment. ["_+SDATA_"]"
1040 ;;W;CLASS;"Classification data passed but not required. No classification data was filed."
1041 ;;W;CLASS;"Invalid classification code passed: '"_$P(SDATA,U)_"'."
1042 ;;W;CLASS;"Classification '"_$P(SDATA,U)_"' is no longer required for this encounter."
1043 ;;W;CLASS;"Classification '"_$P(SDATA,U)_"' data is uneditable. Not updated."
1044 ;;W;CLASS;"Data for classification '"_$P(SDATA,U)_"' is invalid. [Value:'"_$P(SDATA,U,2)_"']"
1045 ;;W;CLASS;"Deleting classification data may cause encounter status not to be 'checked-out'."
1046 ;;W;CLASS;"Changing 'SC' classification data may cause encounter status not to be 'checked-out'."
1047 ;;W;CLASS;"'"_$P(SDATA,U)_"' classification data not required for this encounter. Data not filed."
1050 ;;W;PROV;"Provider #"_+SDATA_" is not a valid IEN. Data not added."
1051 ;;W;PROV;"Provider #"_+SDATA_" is not a valid IEN. Data not processed."
1052 ;;W;PROV;"Deleting provider #"_+SDATA_" was not attempted. At least one provider is required for 'checked-out'."
1060 ;;W;DX;"Diagnosis code '"_+SDATA_"' is not a valid ICD9 code. Data not added."
1061 ;;W;DX;"Diagnosis code '"_+SDATA_"' is not a valid ICD9 code. Data not processed."
1062 ;;W;DX;"Deleting diagnosis code '"_+SDATA_"' was not attempted. At least one dx code is required for 'checked-out'."
1070 ;;W;STOPS;"Invalid stop code #"_+SDATA_". Code not added."
1071 ;;W;STOPS;"No slots remain to file stop codes and CPT procedure codes."
1072 ;;W;CPT;"CPT code '"_$P(SDATA,U)_"' is not a valid code. Procedure data not added."
1073 ;;W;CPT;"The desired number of CPT code '"_$P(SDATA,U)_"' have already been filed."
1074 ;;W;STOPS;"Error occurred during add/edit backdoor filing."
1075 ;;W;STOPS;"Invalid stop code #"_+SDATA_". Code not processed."
1076 ;;W;CPT;"CPT code '"_$P(SDATA,U)_"' is not a valid code. Code not processed."
1077 ;;W;STOPS;"Stop code '"_$P(SDATA,U)_"' did not exist for encounter. Nothing to delete."
1078 ;;W;CPT;"The number of CPT code '"_$P(SDATA,U)_"' to delete was larger than what was entered for encounter."
9999 ;;
