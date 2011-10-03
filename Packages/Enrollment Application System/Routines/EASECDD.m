EASECDD ;ALB/LBD - Executable help for fields in file #408.21  ;4 SEP 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,34,40,100**;Mar 15, 2001;Build 6
 ;
8 ; Social Security
 W !,?8,"Enter in this field the annual amount of Social Security"
 W !,?8,"received during the current calendar year."
 W !!,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
9 ; US Civil Service
 W !,?8,"Enter in this field the annual amount of U.S. Civil Service"
 W !,?8,"received during the current calendar year."
 W !!,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
10 ; US Railroad Retirement
 W !,?8,"Enter in this field the annual amount of U.S. Railroad Retirement"
 W !,?8,"received during the current calendar year."
 W !!,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
11 ; Military Retirement
 W !,?8,"Enter in this field the annual amount of Military Retirement"
 W !,?8,"received during the current calendar year."
 W !!,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
12 ; Unemployment Compensation
 W !,?8,"Enter in this field the annual amount of Unemployment Compensation"
 W !,?8,"received during the current calendar year."
 W !!,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
13 ; Other Retirement
 W !,?8,"Enter in this field the annual amount of Other Retirement received"
 W !,?8,"during the current calendar year.  This includes company, state,"
 W !,?8,"local, etc."
 W !!,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
14 ; Total Income from Employment
 W !,?8,"Enter in this field the annual amount of Gross Income received during"
 W !,?8,"the current year.  This includes, but is not limited to, wages and"
 W !,?8,"income from a business, bonuses, tips, severance pay, accrued"
 W !,?8,"benefits, cash gifts."
 W !!,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
15 ; Interest, Dividend or Annuity (Original 10-10EC)
 ; Net Income from Farm, Ranch or Business (Revised 10-10EC)
 ;  Display a different message for the revised 10-10EC form.
 ;  Modified for LTC IV (EAS*1*40)
 I $G(DGFORM) D
 .W !,?8,"Enter in this field the annual amount of Net Income received during"
 .W !,?8,"the current calendar year from the operation of a farm, ranch,"
 .W !,?8,"property or business."
 I '$G(DGFORM) D
 .W !,?8,"Enter in this field the annual amount of Interest and Dividend"
 .W !,?8,"Income received during the current calendar year (i.e., interest"
 .W !,?8,"income, standard dividend income from non tax deferred annuities)."
 W !!,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
16 ; Workers Comp or Black Lung
 W !,?8,"Enter in this field the annual amount of Workers Compensation or"
 W !,?8,"Black Lung Benefits received during the current calendar year."
 W !!,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
17 ; All Other Income
 ;  Display a different message for the revised 10-10EC form.
 ;  Modified for LTC IV (EAS*1*40)
 I $G(DGFORM) D
 .W !,?8,"Enter in this field the annual amount of All Other Income received"
 .W !,?8,"during the current calendar year, including retirement and pension"
 .W !,?8,"income, Social Security Retirement and Social Security Disability"
 .W !,?8,"income, compensation benefits such as unemployment, Workers and"
 .W !,?8,"Black Lung, or VA disability.  Also cash gifts, court mandated"
 .W !,?8,"payments, inheritance amounts, tort settlement payments, interest"
 .W !,?8,"and dividends, including tax exempt earnings and distributions from"
 .W !,?8,"Individual Retirement Accounts (IRAs) or annuities."
 I '$G(DGFORM) D
 .W !,?8,"Enter in this field the annual amount of All Other Income"
 .W !,?8,"received during the current calendar year (i.e., inheritance amounts,"
 .W !,?8,"tort settlement payments)."
 ;W !!,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
101 ; Medical Expenses
 W !,?8,"Enter in this field the total amount of unreimbursed medical expenses"
 W !,?8,"paid by the veteran during the current calendar year.  The expenses"
 W !,?8,"can be for the veteran or for members of the veteran's family."
 W !,?8,"Reportable medical expenses include amounts paid for the following:"
 W !,?8,"fees of physicians, dentists, and other providers of health services;"
 W !,?8,"hospital and nursing home fees; medical insurance premiums (including"
 W !,?8,"the Medicare premium); drugs and medicines; eyeglasses; any other"
 W !,?8,"expenses that are reasonable related to medical care.  The expenses"
 W !,?8,"must actually have been paid by the veteran.  Do not list expenses"
 W !,?8,"which have not been paid or which have been paid by someone other"
 W !,?8,"than the veteran.  Do not list expenses which the veteran has paid if"
 W !,?8,"the veteran expects to receive reimbursement from insurance or some"
 W !,?8,"other source."
 W !
 W !,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
102 ; Funeral and Burial Expenses
 ;   Modified wording for LTC Phase III (EAS*1*34)
 W !,?8,"Enter in this field amounts paid by the veteran during the current"
 W !,?8,"calendar year for funeral or burial expenses of the veteran's"
 W !,?8,"spouse or child, or pre-paid arrangements for the veteran."
 W !,?8,"Do not report amounts paid for funeral or burial expenses of other"
 W !,?8,"relatives such as parents, siblings, etc."
 W !
 W !,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
103 ; Educational Expenses
 W !,?8,"Enter in this field the total amount paid by the veteran for"
 W !,?8,"educational expenses during the current calendar year.  This"
 W !,?8,"includes educational expenses for the veteran, spouse and children."
 W !,?8,"Educational expenses are tuition, fees, and books if enrolled in a"
 W !,?8,"program of education."
 W !
 W !,?8,"A monthly amount can be entered with an '*' after it.",!
 S X="?"
 Q
201 ; Cash
 ;  Display a different message for the revised 10-10EC form.
 ;  Modified for LTC IV (EAS*1*40)
 W !,?8,"Enter in this field cash and amounts in bank accounts.  This"
 W !,?8,"includes checking accounts, savings accounts, money markets,"
 W !,?8,"interest, dividends from IRA, 401K's, and other tax deferred"
 W !,?8,"annuities.",!
 ;If this is the revised 10-10EC form, also print the message for stocks.
 I $G(DGFORM) G 202
 S X="?"
 Q
202 ; Stock, bonds, mutual funds
 W !,?8,"Enter in this field the current value of stocks, bonds, mutual"
 W !,?8,"funds, SEP's, and other retirement accounts (e.g., IRA, 401K,"
 W !,?8,"annuities, self-employed person).",!
 S X="?"
 Q
