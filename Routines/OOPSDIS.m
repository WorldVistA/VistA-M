OOPSDIS ;HIRMFO/GWB-Display 2162 ;3/5/98
 ;;2.0;ASISTS;;Jun 03, 2002
 W @IOF
 S CAT=$$GET1^DIQ(2260,IEN,2,"I")
 ;Include logic for Non_PAID employee, CAT=6
 ; Patch 5 - added logic for employee CAT >6
 S SUP=$S((CAT=1!(CAT>6)):" SUPERVISOR.............: ",CAT=2:" VOLUNTARY SVC SUP......: ",CAT=3:" CONTRACT ADMINISTRATOR.: ",1:" SAFETY OFFICER.........: ")
 K DIQ,DA,DR S DIC="^OOPS(2260,",DR=".01:99",DA=IEN,DIQ="OOPS" D EN^DIQ1
 W !,"----------------------------------------------------------------------------"
 W !," CASE NUMBER............: ",OOPS(2260,IEN,.01)
 W !," PERSONNEL STATUS.......: ",OOPS(2260,IEN,2)
 W !," TYPE OF INCIDENT.......: ",OOPS(2260,IEN,3)
 W !," CASE STATUS............: ",OOPS(2260,IEN,51)
 W !," INJURY/ILLNESS.........: ",OOPS(2260,IEN,52)
 W !," PERSON INVOLVED........: ",OOPS(2260,IEN,1)
 W !," SSN....................: ",OOPS(2260,IEN,5)
 W !," DATE OF BIRTH..........: ",OOPS(2260,IEN,6)
 W !," SEX....................: ",OOPS(2260,IEN,7)
 W !," HOME ADDRESS...........: ",OOPS(2260,IEN,8)
 I (OOPS(2260,IEN,9)'="")!(OOPS(2260,IEN,10)'="")!(OOPS(2260,IEN,11)'="") W !,"                          ",OOPS(2260,IEN,9),", ",OOPS(2260,IEN,10)," ",OOPS(2260,IEN,11)
 W !," HOME PHONE NUMBER......: ",OOPS(2260,IEN,12)
 W !," STATION NUMBER.........: ",OOPS(2260,IEN,13)
 W !," COST CENTER/ORG........: ",OOPS(2260,IEN,14)
 W !," OCCUPATION.............: ",OOPS(2260,IEN,15)
 W !," GRADE/STEP.............: ",OOPS(2260,IEN,16) W:OOPS(2260,IEN,16)'="" "/" W OOPS(2260,IEN,17)
 W !," EDUCATION..............: ",OOPS(2260,IEN,18)
 W !,SUP,OOPS(2260,IEN,53)
 W !," SECONDARY SUPERVISOR...: ",OOPS(2260,IEN,53.1)
 W !," DATE/TIME OF OCCURRENCE: ",OOPS(2260,IEN,4)
 W !,"----------------------------------------------------------------------------"
 ; Patch 8 - leave this code, other routines rely on it, clean up
 ;           in other routines.
 S SUP=OOPS(2260,IEN,53)
 K OOPS,DIQ,DIC,DR,DA,CAT Q
