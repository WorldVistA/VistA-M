OOPSDM ;HINES/WAA-Utilities Routines ;5/26/98
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
 ; This routine is to display all the report that a person has
 ; access to.
EN1 ;
 N POP
 D DEVICE Q:POP
 D:'$D(IO("Q")) PRINT
 D EXIT
 Q
EXIT ;
 K IO("Q")
 Q
DEVICE ; This is the device selection routine.
 ;
 S %ZIS="QM" D ^%ZIS I POP Q
 I $D(IO("Q")) D  Q
 .S ZTRTN="PRINT^OOPSDM",ZTDESC="Print Employee Bill of Rights"
 .D ^%ZTLOAD D HOME^%ZIS Q
 .Q
 Q
PRINT ; This is the main print portion of the routine
 U IO
 W !,?6,"EMPLOYEES' BILL OF RIGHTS FOR ACCIDENT AND OCCUPATIONAL ILLNESSES"
 ; Added new text with patch 10 - removed all commented lines
 W !!?6,"The Federal Employees' Compensation Act (FECA) describes an employee's"
 W !?6,"rights and entitlements to benefits following a work-related"
 W !?6,"injury or illness."
 W !!?6,"You have the right to file a CA-1 (injury) or CA-2 (illness), to apply"
 W !?6,"for compensation."
 W !!?6,"Entitlements include the option to receive medical treatment by either"
 W !?6,"the VA Employee Health Unit or by your primary care physician."
 W !!?6,"You have the right to request union representation."
 W !!?6,"For additional information and explanation of your rights and"
 W !?6,"responsibilities, contact your Workers' Compensation"
 W !?6,"Specialist/Coordinator/Manager."
 ; W !,?6,"You have the right to select the physician or facility to provide"
 ; W !,?6,"treatment for the sustained injury or illness.  The VA facility is"
 ; W !,?6,"available for examination and treatment, but cannot mandate use of"
 ; W !,?6,"the facility to the exclusion of your choice of medical care.",!
 ; W !,?6,"You have the right to file a CA-1 (injury) or CA-2 (illness) to"
 ; W !,?6,"apply for compensation.",!
 ; W !,?6,"You have the right to union representation at any time.",!
END ; exit the report
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
