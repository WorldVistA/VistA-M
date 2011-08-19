EASEZDD ;ALB/CMF - EZ help for long texts  ;22 FEB 2005
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57,70**;Mar 15, 2001;Build 26
 ;
H112 ;Non-Reimbursed Medical Expenses (408.21 / 1.12)
 ;EAS*1.0*70
 S DIR("?",1)="This response must be a number.  Enter the total amount of non-reimbursed"
 S DIR("?",2)="medical expenses paid by the veteran during the previous calendar year.  The"
 S DIR("?",3)="expenses can be for the veteran or for persons that the veteran has a legal or"
 S DIR("?",4)="moral obligation to support.  The expenses must actually have been paid by the"
 S DIR("?",5)="veteran.  Reportable medical expenses include amounts paid for the following:"
 S DIR("?",6)="fees of physicians, dentists, and other providers of health services; hospital"
 S DIR("?",7)="and nursing home fees; medical insurance premiums (including the Medicare"
 S DIR("?",8)="premium); drugs and medicines; eyeglasses; any other expenses that are"
 S DIR("?",9)="reasonably related to medical care.  Do not list expenses which the veteran has"
 S DIR("?",10)="paid if the veteran expects to receive reimbursement from insurance or some"
 S DIR("?",11)="other source."
 S DIR("?",12)=" "
 S DIR("?",13)="By law, not all of the non-reimbursed medical expenses paid by the veteran"
 S DIR("?",14)="during the previous calendar year may be deducted from the total annual income."
 S DIR("?",15)="The total amount of the non-reimbursed medical expenses entered in this field"
 S DIR("?",16)="will be automatically adjusted based upon the veteran's maximum annual pension"
 S DIR("?",17)="amount and number of dependents."
 S DIR("?",18)=" "
 S DIR("?",19)="Intake clerks should remind the veteran to keep receipts for claimed medical"
 S DIR("?")="expenses."
 Q
 ;
H07 ;Amount Contributed to Spouse
 S DIR("?",1)="If the veteran did not live with his or her spouse, enter"
 S DIR("?",2)="in this field the amount the veteran contributed to his"
 S DIR("?",3)="or her spouse last calendar year.  If the amount the"
 S DIR("?",4)="veteran contributed is less than $600, then the spouse"
 S DIR("?")="will not be considered a dependent for financial assessment."
 Q
H18 ;Child 18-23 In School
 S DIR("?",1)="Enter 'Y' if the child is currently 18 to 23 years old"
 S DIR("?",2)="and the child attended school last calendar year.  Enter"
 S DIR("?",3)="'N' if the child is currently 18 to 23 years old but the"
 S DIR("?",4)="child did not attend school last calendar year.  Enter"
 S DIR("?")="'N' if the child is not currently 18 to 23 years old."
 Q
 ;
H19 ;Amount Contributed to Child
 S DIR("?",1)="Enter in this field the dollar amount that the veteran"
 S DIR("?",2)="contributed to the child's support last calendar year."
 S DIR("?",3)="The contributions do not have to be in regular set amounts."
 S DIR("?",4)="For example, a veteran who paid a child's school tuition or"
 S DIR("?")="medical bills would be contributing to the child's support."
 Q
 ;
H362 ;Military Comp
 S DIR("?",1)="Enter '0' or 'NO' if the veteran: --Is NOT retired from the military OR --Is"
 S DIR("?",2)="retired from the military due to length of service AND does NOT have a"
 S DIR("?",3)="disability confirmed by the Military Branch to have been incurred in or "
 S DIR("?",4)="aggravated while on active duty.  Enter '1' or 'YES, RECEIVING MILITARY"
 S DIR("?",5)="RETIREMENT', if the veteran: --Is confirmed by the Military Branch to have"
 S DIR("?",6)="been discharged or released due to a disability incurred in or aggravated"
 S DIR("?",7)="while on active duty AND --Has NOT filed a claim for VA compensation benefits"
 S DIR("?",8)="OR --Has been rated by the VA to be NSC OR --Has been rated by the VA to"
 S DIR("?",9)="have noncompensable 0% SC conditions.  Enter '2' or 'YES, RECEIVING MILITARY"
 S DIR("?",10)="RETIREMENT IN LIEU OF VA COMPENSATION',if the veteran: --Is confirmed by the"
 S DIR("?",11)="Military Branch to have been discharged or released due to a disability"
 S DIR("?",12)="incurred in or aggravated while on active duty, AND --Is receiving military"
 S DIR("?",13)="disability retirement pay AND --Has been rated by VA to have compensable SC"
 S DIR("?")="conditions but is NOT receiving compensation from the VA."
 Q
AC ;Area Code
 S DIR(0)="FO^3:3^K:X'?3N X"
 S DIR("?")="This response must be numeric. Use format nnn. Example 904,412."
 Q
PN ;Phone Number
 S DIR(0)="FO^8:8^K:X'?3N1""-""4N X"
 S DIR("?")="This response must be numeric. Use format nnn-nnnn. Example 222-1234."
 Q
