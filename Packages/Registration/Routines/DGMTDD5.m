DGMTDD5 ;ALB/AMA,JAM - Executable Help Calls, CON'T ; 8/1/08 1:13pm
 ;;5.3;Registration;**688,1143**;Aug 13, 1993;Build 36
 ;
201 ;Executable Help for Cash, Amount in Bank Accounts (408.21/2.01)
 Q:(X="?")
 I +$$MTVERS^DGMTDD4($G(DGMTI))=0 D  Q
 . ;Help text for pre-Feb 2005 Data Collection format
 . W !?8,"Enter in this field cash and amounts in bank accounts.  This includes"
 . W !?8,"checking accounts, savings accounts, Individual Retirement Accounts,"
 . W !?8,"certificate of deposit, etc."
 . Q
 E  D
 . ;Help text for Feb 2005 Data Collection format
 . W !?8,"Enter in this field cash and amounts in bank accounts.  This includes"
 . W !?8,"checking accounts, savings accounts, Certificates of Deposit (CDs),"
 . W !?8,"Individual Retirement Accounts (IRAs), stocks and bonds, etc."
 Q
203 ;Executable Help for Land, Bldgs Less Mortgage (408.21/2.03)
 Q:(X="?")
 I +$$MTVERS^DGMTDD4($G(DGMTI))=0 D  Q
 . ;Help text for pre-Feb 2005 Data Collection format
 . W !?8,"Enter in this field the current value, less mortgages or other"
 . W !?8,"encumbrances, of any real property (land and buildings) owned."
 . W !?8,"Do not report the value of the veteran's primary residence."
 . W !?8,"If the veteran's primary residence is a multifamily dwelling, report"
 . W !?8,"the value of the building less the value of the unit occupied by"
 . W !?8,"the veteran.  If the veteran lives on a farm, report the value"
 . W !?8,"of the farm less the value of the house occupied by the veteran"
 . W !?8,"and a reasonable surrounding area.  NOTE:  Since the veteran's primary"
 . W !?8,"residence is not reported as an asset, the mortgage may NOT be reported"
 . W !?8,"as a debt.  In addition, the value of any other property owned by the"
 . W !?8,"veteran or spouse will be calculated in the same manner."
 . Q
 E  D
 . ;Help text for Feb 2005 Data Collection format
 . I $G(DGPRTY)="V" D  Q   ;Help text for the veteran
 . . W !?8,"Enter in this field the current value of land and buildings, less"
 . . W !?8,"mortgages and liens."
 . . W !!?8,"Do not report the value of the veteran's primary residence.  If the"
 . . W !?8,"veteran's primary residence is a multifamily dwelling, report the value"
 . . W !?8,"of the building less the value of the unit occupied by the veteran.  If"
 . . W !?8,"the veteran lives on a farm, report the value of the farm less the"
 . . W !?8,"value of the house occupied by the veteran and a reasonable surrounding"
 . . W !?8,"area.  The size of the 'reasonable lot area' that can be excluded from"
 . . W !?8,"net worth consideration is determined by the degree to which the"
 . . W !?8,"property is connected to the dwelling and the typical size of lots in"
 . . W !?8,"the immediate area.  Contiguous land which is closely connected to the"
 . . W !?8,"dwelling in terms of use and which does not greatly exceed the"
 . . W !?8,"customary size of lots in the immediate area is excluded from net worth"
 . . W !?8,"consideration."
 . . W !!?8,"NOTE:  Since the veteran's primary residence is not reported as an"
 . . W !?8,"asset, the mortgage may NOT be reported as a debt.  In addition, the"
 . . W !?8,"value of any other property owned by the veteran, spouse, or dependent"
 . . W !?8,"children will be calculated in the same manner."
 . E  D   ;Help text for the dependents (spouse or child)
 . . W !?8,"Enter in this field the current value of land and buildings, less"
 . . W !?8,"mortgages and liens."
 . . W !!?8,"Do not report the value of the person's primary residence.  If the"
 . . W !?8,"person's primary residence is a multifamily dwelling, report the value"
 . . W !?8,"of the building less the value of the unit occupied by the person.  If"
 . . W !?8,"the person lives on a farm, report the value of the farm less the"
 . . W !?8,"value of the house occupied by the person and a reasonable surrounding"
 . . W !?8,"area.  The size of the 'reasonable lot area' that can be excluded from"
 . . W !?8,"net worth consideration is determined by the degree to which the"
 . . W !?8,"property is connected to the dwelling and the typical size of lots in"
 . . W !?8,"the immediate area.  Contiguous land which is closely connected to the"
 . . W !?8,"dwelling in terms of use and which does not greatly exceed the"
 . . W !?8,"customary size of lots in the immediate area is excluded from net worth"
 . . W !?8,"consideration."
 . . W !!?8,"NOTE:  Since the person's primary residence is not reported as an"
 . . W !?8,"asset, the mortgage may NOT be reported as a debt.  In addition, the"
 . . W !?8,"value of any other property owned by the veteran, spouse, or dependent"
 . . W !?8,"children will be calculated in the same manner."
 Q
204 ;Executable Help for Other Property or Assets (408.21/2.04)
 Q:(X="?")
 I +$$MTVERS^DGMTDD4($G(DGMTI))=0 D  Q
 . ;Help text for pre-Feb 2005 Data Collection format
 . W !?8,"Enter in this field the current market value of other property owned."
 . W !?8,"However, do not report the value of household effects or vehicles"
 . W !?8,"regularly used for family transportation.  Other property may include"
 . W !?8,"an art or stamp collection."
 . Q
 E  D
 . ;Help text for Feb 2005 Data Collection format
 . W !?8,"Enter in this field the current market value of other property or"
 . W !?8,"assets that are owned, minus the amount that is owed on these items."
 . W !?8,"Include the value of farm, ranch, or business assets.  However, do not"
 . W !?8,"report the value of household effects or vehicles regularly used for"
 . W !?8,"family transportation.  Assets may include art, rare coins, or"
 . W !?8,"collectibles."
 Q
 ; DG*5.3*1143 - Modified help text for Email.
133 ;Executable Help for E-Mail Address (2/.133)
 W !?5,"Enter the applicant's email address [6-72 characters]."
 W !?5,"The Username (or local-part) is the part before the"
 W !?5,"'@' symbol and must contain at least 1 and up to 64"
 W !?5,"characters. The first character must be alpha-numeric only."
 W !?5,"The '@' symbol follows the Username."
 W !?5,"The Domain Name is the part after the '@' symbol and must"
 W !?5,"contain at least 1 character and must end with a '.' (dot)"
 W !?5,"followed by at least 2 characters up to a total length"
 W !?5,"not to exceed the 72 character limit for the email address."
 W !?5,"Besides letters and numbers, the username and domain may"
 W !?5,"contain the following characters: ! # $ % & ' * + - / = ? _ { }"
 W !?5,"The domain name must end with an alphanumeric character."
 W !?5,"For example:",!?11,"Lastname_Firstname@yahoo.com"
 W !?11,"lastname-firstname@domain.ext",!?11,"name@state-college.us"
 Q
