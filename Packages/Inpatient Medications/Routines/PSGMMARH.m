PSGMMARH ;BIR/CML3-MULTIPLE DAY MARS - HELP MESSAGES ;16 DEC 97 / 1:36 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
BH ;
 W !!,"  Enter a 'Y' to print BLANK (no data) MARs for the following patient(s).  Enteran 'N' (or press the RETURN key) to print MARs complete with orders.  Enter an  '^' to exit this option now." Q
 ;
DH ;
 W !!?2,"Enter the START DATE of the "_PSGMARDF_" days for which this MAR is to print.  Unless",!,"the BLANK MARs are selected, all orders for the patient(s) selected that are",!,"(or were) active during the date range selected will print."
 W !?2,"Time is not required.  Enter a date with time if you want to print only those",!,"orders that are active after the date and time specified.  Enter a date with-",!,"out time if you want to print all orders that are active on that "
 W "date.  If blank",!,"MARs are selected, any time entered will be ignored." Q
 ;
SD ; set-up dir
 K DIR S DIR(0)="SOA^C:CONTINUOUS ONLY;P:PRN ONLY;B:BOTH",DIR("A")="Select TYPE OF SHEETS TO PRINT: ",DIR("B")="BOTH" S:'PSGMARB DIR(0)=DIR(0)_";O:ORDERS ONLY"
 S DIR("?",1)="  Enter 'C' to print ONLY CONTINUOUS sheets for the patient(s) selected.",DIR("?",2)="Enter 'P' to print ONLY PRN sheets.  (One-time and on call orders print on"
 S DIR("?",3)="the PRN sheets.)  Enter 'B' (or press RETURN) to print BOTH sheets." I 'PSGMARB S DIR("?",3)=DIR("?",3)_"  Enter",DIR("?",4)="'O' to print ONLY sheets for which each patient has orders.",N=5
 S:'$T N=4 S DIR("?",N)="CHOOSE FROM:",N=N+1,DIR("?",N)="       C       CONTINUOUS",N=N+1,DIR("?",N)="       P       PRN",N=N+1,DIR("?",N)="       B       BOTH",DIR("?")=" " S:'PSGMARB DIR("?",N+1)="       O       ONLY ORDERS" Q
