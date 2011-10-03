ORWOD1 ; SLC/GSS - Utility for Order Dialogs ; 10/01/09 11:28am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243,296,280**;DEC 17, 1997;Build 85
 ;
NTRY ;Entry point
 N TXT
 F NXTLINE=1:1 S TXT=$P($T(TXT+NXTLINE),";;",2) Q:TXT="Q"  S ^TMP("OR",$J,"MAIL",NXTLINE,0)=TXT
 Q
TXT ;Text for report follows
 ;;         Quick Orders Which Should be Considered for Editing
 ;;
 ;;CPRS 27 has added three new fields (Route, IV Type, and Schedule) to the
 ;;IV Order Dialog. For all IV orders the Route and IV Type must be defined.
 ;;For Intermittent IV Type orders the schedule field must be defined. CPRS
 ;;will not process the orders unless these fields are defined.
 ;;
 ;;The following table of Quick Orders (QO) was compiled by examining the
 ;;QOs and whether or not they were contained in another entry of the Order
 ;;Dialog file, e.g., Order Menu, Order Set and/or the Reminder Dialog
 ;;file. QOs which are contained in those files should be edited ASAP after
 ;;CPRS v27 is installed. QOs not contained in those files are less critical
 ;;but should still be edited. Note that if the ORCM SEARCH/REPLACE option
 ;;is used, it does not look for usage in the Reminder Dialog file and thus
 ;;may give different results than the table below.
 ;;
 ;;The Quick Orders are listed in alphabetical order by QO name and include
 ;;the QO's IEN (internal reference number), display name, and Legend code.
 ;;The Legend code corresponds to a letter or letters in the Legend (see
 ;;below.) You will need to evaluate each quick order and update it based on
 ;;the Legend code(s).
 ;;
 ;;A Quick Order can be edited by using the "Enter/edit quick orders" option
 ;;on the Order Menu Management menu in VistA (roll and scroll). At the
 ;;prompt, "Select QUICK ORDER NAME:", enter the name of the Quick Order.
 ;;The QO will then be displayed for your editing.  The "Enter/edit quick
 ;;orders" option can also be used to edit a Personal Quick Order.
 ;;
 ;;Additionally, when OR*3.0*301 is released, it will include a new option
 ;;entitled, Convert IV Inpatient QO to Infusion QO [OR CONVERT INP TO QO].
 ;;This option will be on the ORDER MENU MANAGEMENT [ORCM MENU] menu. This
 ;;option enables CACs at sites to convert an IV quick order that is set-up
 ;;as an Inpatient quick order to the new Infusion quick order format. 
 ;;
 ;;QO Edit Hint:
 ;;In addition to entering the QO name, users may also edit a Quick Order by
 ;;entering the back tick (`) and the IEN at the "Select QUICK ORDER NAME:"
 ;;prompt. For example, if the Quick Order name is PSI SICU CAM DOBUTAMINE 500
 ;;MG and the IEN is 6200, a user may enter "`6200" at the "Select QUICK ORDER
 ;;NAME:" prompt. This will save the time required to type the name of the Quick
 ;;Order in at the "Select QUICK ORDER NAME:" prompt.
 ;;
 ;;Note: The term 'null', as used below, can be viewed as meaning 'not defined'.
 ;;
 ;;Legend:
 ;;A...Problem: The IV type is null or the route is null.
 ;;    Action:  Please edit the IV Type or route fields with the appropriate
 ;;      information.
 ;;B...Problem: The IV type is 'I' and the schedule is null.
 ;;    Action:  For Intermittent IV Orders a schedule is needed to process the
 ;;      order.  Enter a schedule which denotes the Intermittent IV dose.
 ;;C...Problem: Continuous IV Type does not have a rate defined. When accepting
 ;;      the order in CPRS, rate is required and must be between 1 and 9999.9,
 ;;      a whole number, or text that contains an '@'. Some continuous IV Type
 ;;      Quick Orders may not include a rate to allow provider to define at
 ;;      time of order.
 ;;    Action:  Evaluate need for rate default and assign in Quick Order if
 ;;      appropriate. The infusion rate must be a number up to four digits and
 ;;      it will allow up to one decimal place. If IV Type is not defined in
 ;;      the Quick Order, then an IV Type must be defined in the Quick Order
 ;;      set-up.
 ;;D...Problem:  The IV type is 'I' but the rate is not a whole number minute
 ;;      or hour yet not null.
 ;;    Action:  A valid "Infuse Over" value must be assigned to the Quick
 ;;      Order. Using the Quick Order Editor, add an "Infuse Over" value in
 ;;      the number of minutes (maximum of 9999).
 ;;E...Problem:  The IV limit or duration (limitation) value was other than
 ;;      null or a whole number.
 ;;    Action:  This field is not required but if it exists, it must be a
 ;;      whole number. To correct this, follow the Help Text for the Limitation
 ;;      Prompt in the Quick Order editor for this Quick Order.
 ;;F...Problem:  The Order Dialogs with 'MM' in the display text
 ;;    Action:  MMOL (millimole) has been added as a unit of measure.  Please 
 ;;      replace 'MM' with MMOL.
 ;;G...Problem:  Auto Accept Quick Order which was 'Y'es and now set to 'N'o.
 ;;    Action:  These Quick Orders were converted from an Auto Accept Quick
 ;;      Order to a non-Auto Accept Quick because they have at least one
 ;;      invalid field. Please correct the problems identified by the Legend
 ;;      code(s) for the Quick Order before setting the Quick Order back to
 ;;      an Auto-Accept Quick Order.
 ;;
 ;;H...Problem:  Continuous IV Quick Orders do not have an Additive Frequency assigned for every additives.
 ;;    Action:  These Quick Orders need to have an Additive Frequency value assigned for
 ;;      each additive in the quick order.
 ;;      
 ;;Note: QO Names and QO Display Names over 30 characters are truncated at 30
 ;;      characters.  If in doubt on the Name you can use the IEN to edit the
 ;;      Quick Order (see above).
 ;;
 ;;                            -----------------------
 ;;                            
 ;;  IEN Name                           Display Name                   Legend
 ;;===== ============================== ============================== ======
 ;;Q
