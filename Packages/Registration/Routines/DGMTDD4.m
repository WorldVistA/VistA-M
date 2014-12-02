DGMTDD4 ;ALB/AMA - Individual Annual Income file (#408.21) Data Dictionary Calls, CON'T ; 10/3/07 1:44pm
 ;;5.3;Registration;**688,812**;Aug 13, 1993;Build 19
 ;
14 ;Executable Help for Total Employment Income (408.21/.14)
 Q:(X="?")
 I +$$MTVERS($G(DGMTI))=0 D  Q
 . ;Help text for pre-Feb 2005 Data Collection format
 . W !?8,"Enter in this field the annual amount of Total Income from Employment"
 . W !?8,"received during the previous calendar year.  This includes wages,"
 . W !?8,"salary, earnings and tips."
 . W !!?8,"A monthly amount can be entered with an '*' after it."
 . Q
 E  D
 . ;Help text for Feb 2005 Data Collection format
 . W !?8,"Enter in this field the gross income amount received from Employment"
 . W !?8,"during the previous calendar year.  This includes wages, bonuses,"
 . W !?8,"salary, earnings, and tips.  Exclude income from your farm, ranch,"
 . W !?8,"property, or business."
 . W !!?8,"A monthly amount can be entered with an '*' after it."
 Q
17 ;Executable Help for Net Income from Farm (408.21/.17)
   ;DG*5.3*812
 Q:(X="?")
 N DGAIA
 I +$$MTVERS($G(DGMTI))=0 D  Q
 . ;Help text for pre-Feb 2005 Data Collection format
 .S DGAIA(1)="Enter in this field the annual amount of All Other Income received"
 .S DGAIA(1,"F")="!,?8"
 .S DGAIA(2)="during the previous calendar year."
 .S DGAIA(2,"F")="!,?8"
 .S DGAIA(3)="Business or Farm Income.  Net income from operation of a farm or other"
 .S DGAIA(3,"F")="!,?8"
 .S DGAIA(4)="business is countable.  If a veteran reports this type of income, have"
 .S DGAIA(4,"F")="!,?8"
 .S DGAIA(5)="the veteran complete VA Form 21-4165, Pension Claim Questionnaire for"
 .S DGAIA(5,"F")="!,?8"
 .S DGAIA(6)="Farm Income, or VA Form 21-4185, Report of Income from Property or"
 .S DGAIA(6,"F")="!,?8"
 .S DGAIA(7)="Business.  Subtract the veteran's business or farm expenses from gross"
 .S DGAIA(7,"F")="!,?8"
 .S DGAIA(8)="income.  The result should be entered in this field.  If the veteran or"
 .S DGAIA(8,"F")="!,?8"
 .S DGAIA(9)="veteran's spouse or child receives a salary from the business, it"
 .S DGAIA(9,"F")="!,?8"
 .S DGAIA(10)="should be reported in the 'Total Employment Income' field.  Also, note"
 .S DGAIA(10,"F")="!,?8"
 .S DGAIA(11)="that depreciation is not a deductible expense for VA purposes."
 .S DGAIA(11,"F")="!,?8"
 .S DGAIA(12)="A monthly amount can be entered with an '*' after it."
 .S DGAIA(12,"F")="!!,?8"
 .S DGAIA(13,"F")="!"
 .D EN^DDIOL(.DGAIA)
 . Q
 E  D
 . ;Help text for Feb 2005 Data Collection format
 .S DGAIA(1)="Enter in this field the net income amount from your farm, ranch,"
 .S DGAIA(1,"F")="!,?8"
 .S DGAIA(2)="property, or business received during the previous calendar year."
 .S DGAIA(2,"F")="!,?8"
 .S DGAIA(3)="Business or Farm Income.  Net income from operation of a farm or other"
 .S DGAIA(3,"F")="!,?8"
 .S DGAIA(4)="business is countable.  If a veteran reports this type of income, have"
 .S DGAIA(4,"F")="!,?8"
 .S DGAIA(5)="the veteran complete VA Form 21-4165, Pension Claim Questionnaire for"
 .S DGAIA(5,"F")="!,?8"
 .S DGAIA(6)="Farm Income, or VA Form 21-4185, Report of Income from Property or"
 .S DGAIA(6,"F")="!,?8"
 .S DGAIA(7)="Business.  To identify the net income, subtract the veteran's business"
 .S DGAIA(7,"F")="!,?8"
 .S DGAIA(8)="or farm expenses from the gross income derived from the business or"
 .S DGAIA(8,"F")="!,?8"
 .S DGAIA(9)="farm.  The result should be entered in this field.  If the veteran or"
 .S DGAIA(9,"F")="!,?8"
 .S DGAIA(10)="veteran's spouse or child receives a salary from the business, it"
 .S DGAIA(10,"F")="!,?8"
 .S DGAIA(11)="should be reported in the 'Total Employment Income' field.  Also, note"
 .S DGAIA(11,"F")="!,?8"
 .S DGAIA(12)="that depreciation is not a deductible expense for VA purposes."
 .S DGAIA(12,"F")="!,?8"
 .S DGAIA(13)="A monthly amount can be entered with an '*' after it."
 .S DGAIA(13,"F")="!!,?8"
 .S DGAIA(14,"F")="!"
 .D EN^DDIOL(.DGAIA)
 Q
8 ;Executable Help for Other Income Amounts (408.21/.08)
 Q:(X="?")
 I +$$MTVERS($G(DGMTI))=0 D  Q
 . ;Help text for pre-Feb 2005 Data Collection format
 . W !?8,"Enter in this field the annual amount of Social Security received"
 . W !?8,"during the previous calendar year.  Do not include SSI."
 . W !!?8,"A monthly amount can be entered with an '*' after it."
 . Q
 E  D
 . ;Help text for Feb 2005 Data Collection format
 . W !?8,"Enter in this field the annual amount of other income received during"
 . W !?8,"the previous calendar year.  This includes, but is not limited to,"
 . W !?8,"Social Security Retirement and/or Disability Income; compensation"
 . W !?8,"benefits such as VA disability, unemployment, retirement, and pension"
 . W !?8,"income; interest; and dividends.  Exclude welfare, Supplemental"
 . W !?8,"Security Income (SSI), or need-based payments from a governmental"
 . W !?8,"agency, profit from occasional sale of property, reinvested interest"
 . W !?8,"on IRAs.  See 38 CFR 3.272 for more information."
 . W !!?8,"A monthly amount can be entered with an '*' after it."
 Q
112 ;Executable Help for Total Non-Reimbursed Medical Expenses (408.21/1.12)
 Q:(X="?")
 I +$$MTVERS($G(DGMTI))=0 D  Q
 . ;Help text for pre-Feb 2005 Data Collection format
 . W !?8,"Enter the total amount of unreimbursed medical expenses paid by the"
 . W !?8,"veteran during the previous calendar year.  The expenses can be for the"
 . W !?8,"veteran or for persons that the veteran has a legal or moral obligation"
 . W !?8,"to support.  The expenses must actually have been paid by the veteran."
 . W !?8,"Reportable medical expenses include amounts paid for the following:"
 . W !?8,"fees of physicians, dentists, and other providers of health services;"
 . W !?8,"hospital and nursing home fees; medical insurance premiums (including"
 . W !?8,"the Medicare premium); drugs and medicines; eyeglasses; any other"
 . W !?8,"expenses that are reasonable related to medical care.  Do not list"
 . W !?8,"expenses which the veteran has paid if the veteran expects to receive"
 . W !?8,"reimbursement from insurance or some other source."
 . W !!?8,"By law, not all of the unreimbursed medical expenses paid by the veteran"
 . W !?8,"during the previous calendar year may be deducted from the total annual"
 . W !?8,"income.  The total amount of the unreimbursed medical expenses entered"
 . W !?8,"in this field will be automatically adjusted based upon the veteran's"
 . W !?8,"maximum annual pension amount and number of dependents."
 . Q
 E  D
 . ;Help text for Feb 2005 Data Collection format
 . W !?5,"Enter the total amount of non-reimbursed medical expenses paid by the"
 . W !?5,"veteran during the previous calendar year.  The expenses can be for the"
 . W !?5,"veteran or for persons that the veteran has a legal or moral obligation"
 . W !?5,"to support.  The expenses must actually have been paid by the veteran."
 . W !?5,"Reportable medical expenses include amounts paid for the following:"
 . W !?5,"fees of physicians, dentists, and other providers of health services;"
 . W !?5,"hospital and nursing home fees; medical insurance premiums (including"
 . W !?5,"the Medicare premium); drugs and medicines; eyeglasses; any other"
 . W !?5,"expenses that are reasonably related to medical care.  Do not list"
 . W !?5,"expenses which the veteran has paid if the veteran expects to receive"
 . W !?5,"reimbursement from insurance or some other source."
 . W !!?5,"By law, not all of the non-reimbursed medical expenses paid by the"
 . W !?5,"veteran during the previous calendar year may be deducted from the total"
 . W !?5,"annual income.  The total amount of the non-reimbursed medical expenses"
 . W !?5,"entered in this field will be automatically adjusted based upon the"
 . W !?5,"veteran's maximum annual pension amount and number of dependents."
 . W !!?5,"Intake clerks should remind the veteran to keep receipts for claimed"
 . W !?5,"medical expenses."
 Q
102 ;Executable Help for Funeral and Burial Expenses (408.21/1.02)
 Q:(X="?")
 I +$$MTVERS($G(DGMTI))=0 D  Q
 . ;Help text for pre-Feb 2005 Data Collection format
 . W !?8,"Enter in this field amounts paid by the veteran during the previous"
 . W !?8,"calendar year for funeral or burial expenses of the veteran's spouse or"
 . W !?8,"child.  Do not report amounts paid for funeral or burial expenses of"
 . W !?8,"other relatives such as parents, siblings, etc."
 . Q
 E  D
 . ;Help text for Feb 2005 Data Collection format
 . W !?8,"Enter in this field amounts paid by the veteran during the previous"
 . W !?8,"calendar year for funeral or burial expenses of the veteran's deceased"
 . W !?8,"spouse or child or for pre-paid funeral or burial expenses of the"
 . W !?8,"veteran, spouse, or any dependent child.  Do not report amounts paid"
 . W !?8,"for funeral or burial expenses of other relatives such as parents,"
 . W !?8,"siblings, etc."
 Q
MTVERS(DGMTI) ;Determine the Means Test Version Indicator
 I 'DGMTI Q 1
 N MTVERS
 S MTVERS=+$P($G(^DGMT(408.31,DGMTI,2)),"^",11)
 Q MTVERS
