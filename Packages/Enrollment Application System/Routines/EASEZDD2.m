EASEZDD2        ;ALB/AMA - EZ help for long texts, con't
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**70**;Mar 15, 2001;Build 26
 ;
H14 ;Employment Income (408.21/.14)
 S DIR("?",1)="This response must be a number.  Enter in this field the gross income amount"
 S DIR("?",2)="received from Employment during the previous calendar year.  This includes"
 S DIR("?",3)="wages, bonuses, salary, earnings, and tips.  Exclude income from your farm,"
 S DIR("?")="ranch, property, or business."
 Q
 ;
H17 ;Farm or Business Income (408.21/.17)
 S DIR("?",1)="This response must be a number.  Enter in this field the net income amount"
 S DIR("?",2)="from your farm, ranch, property, or business received during the previous"
 S DIR("?",3)="calendar year."
 S DIR("?",4)=" "
 S DIR("?",5)="Business or Farm Income.  Net income from operation of a farm or other"
 S DIR("?",6)="business is countable.  If a veteran reports this type of income, have the"
 S DIR("?",7)="veteran complete VA Form 21-4165, Pension Claim Questionnaire for Farm Income,"
 S DIR("?",8)="or VA Form 21-4185, Report of Income from Property or Business.  To identify"
 S DIR("?",9)="the net income, subtract the veteran's business or farm expenses from the"
 S DIR("?",10)="gross income derived from the business or farm.  The result should be entered"
 S DIR("?",11)="in this field.  If the veteran or veteran's spouse or child receives a salary"
 S DIR("?",12)="from the business, it should be reported in the 'Total Employment Income'"
 S DIR("?")="field.  Also, note that depreciation is not a deductible expense for VA purposes."
 Q
H08 ;All Other Income (408.21/.08)
 S DIR("?",1)="This response must be a number.  Enter in this field the annual amount of"
 S DIR("?",2)="other income received during the previous calendar year.  This includes,"
 S DIR("?",3)="but is not limited to, Social Security Retirement and/or Disability Income;"
 S DIR("?",4)="compensation benefits such as VA disability, unemployment, retirement, and"
 S DIR("?",5)="pension income; interest; and dividends.  Exclude welfare, Supplemental"
 S DIR("?",6)="Security Income (SSI), or need-based payments from a governmental agency,"
 S DIR("?",7)="profit from occasional sale of property, reinvested interest on IRAs."
 S DIR("?")="See 38 CFR 3.272 for more information."
 Q
H102 ;Funeral and Burial Expenses (408.21/1.02)
 S DIR("?",1)="This response must be a number.  Enter in this field amounts paid by the"
 S DIR("?",2)="veteran during the previous calendar year for funeral or burial expenses of"
 S DIR("?",3)="the veteran's deceased spouse or child or for pre-paid funeral or burial"
 S DIR("?",4)="expenses of the veteran, spouse, or any dependent child.  Do not report"
 S DIR("?",5)="amounts paid for funeral or burial expenses of other relatives such as"
 S DIR("?")="parents, siblings, etc."
 Q
H201 ;Cash, Amount in Bank Accounts (408.21/2.01)
 S DIR("?",1)="This response must be a number.  Enter in this field cash and amounts"
 S DIR("?",2)="in bank accounts.  This includes checking accounts, savings accounts,"
 S DIR("?",3)="Certificates of Deposit (CDs), Individual Retirement Accounts (IRAs),"
 S DIR("?")="stocks and bonds, etc."
 Q
H203 ;Veteran Land, Bldgs Less Mortgage (408.21/2.03)
 S DIR("?",1)="This response must be a number.  Enter in this field the current value of land"
 S DIR("?",2)="and buildings, less mortgages and liens."
 S DIR("?",3)=" "
 S DIR("?",4)="Do not report the value of the veteran's primary residence.  If the veteran's"
 S DIR("?",5)="primary residence is a multifamily dwelling, report the value of the building"
 S DIR("?",6)="less the value of the unit occupied by the veteran.  If the veteran lives on a"
 S DIR("?",7)="farm, report the value of the farm less the value of the house occupied by the"
 S DIR("?",8)="veteran and a reasonable surrounding area.  The size of the 'reasonable lot"
 S DIR("?",9)="area' that can be excluded from net worth consideration is determined by the"
 S DIR("?",10)="degree to which the property is connected to the dwelling and the typical"
 S DIR("?",11)="size of lots in the immediate area.  Contiguous land which is closely"
 S DIR("?",12)="connected to the dwelling in terms of use and which does not greatly exceed"
 S DIR("?",13)="the customary size of lots in the immediate area is excluded from net worth"
 S DIR("?",14)="consideration."
 S DIR("?",15)=" "
 S DIR("?",16)="NOTE:  Since the veteran's primary residence is not reported as an asset, the"
 S DIR("?",17)="mortgage may NOT be reported as a debt.  In addition, the value of any other"
 S DIR("?",18)="property owned by the veteran, spouse, or dependent children will be"
 S DIR("?")="calculated in the same manner."
 Q
H204 ;Other Property or Assets (408.21/2.04)
 S DIR("?",1)="This response must be a number.  Enter in this field the current market"
 S DIR("?",2)="value of other property or assets that are owned, minus the amount that"
 S DIR("?",3)="is owed on these items.  Include the value of farm, ranch, or business"
 S DIR("?",4)="assets.  However, do not report the value of household effects or vehicles"
 S DIR("?",5)="regularly used for family transportation.  Assets may include art, rare"
 S DIR("?")="coins, or collectibles."
 Q
HD203 ;Dependent Land, Bldgs Less Mortgage (408.21/2.03)
 S DIR("?",1)="This response must be a number.  Enter in this field the current value of land"
 S DIR("?",2)="and buildings, less mortgages and liens."
 S DIR("?",3)=" "
 S DIR("?",4)="Do not report the value of the person's primary residence.  If the person's"
 S DIR("?",5)="primary residence is a multifamily dwelling, report the value of the building"
 S DIR("?",6)="less the value of the unit occupied by the person.  If the person lives on a"
 S DIR("?",7)="farm, report the value of the farm less the value of the house occupied by the"
 S DIR("?",8)="person and a reasonable surrounding area.  The size of the 'reasonable lot"
 S DIR("?",9)="area' that can be excluded from net worth consideration is determined by the"
 S DIR("?",10)="degree to which the property is connected to the dwelling and the typical"
 S DIR("?",11)="size of lots in the immediate area.  Contiguous land which is closely"
 S DIR("?",12)="connected to the dwelling in terms of use and which does not greatly exceed"
 S DIR("?",13)="the customary size of lots in the immediate area is excluded from net worth"
 S DIR("?",14)="consideration."
 S DIR("?",15)=" "
 S DIR("?",16)="NOTE:  Since the person's primary residence is not reported as an asset, the"
 S DIR("?",17)="mortgage may NOT be reported as a debt.  In addition, the value of any other"
 S DIR("?",18)="property owned by the veteran, spouse, or dependent children will be"
 S DIR("?")="calculated in the same manner."
 Q
