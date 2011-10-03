IBCISC ;DSI/ESG - IB EDIT SCREENS ?CLA FUNCTIONALITY ;23-FEB-2001
 ;;2.0;INTEGRATED BILLING;**161,348**;21-MAR-94;Build 5
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Cannot be called from the top
 Q
 ;
CLA(IBIFN) ; Entry point for ?CLA processing
 ; This is called by routine IBCSCH.
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
0 ; Clear screen and display header information
 W @IOF
 W !!?21,"VistA-ClaimsManager Interface Options"
 ;
 ; Check the bill form type to make sure it's a 1500.
 I $$CK1^IBCIUT1(IBIFN) D  G CLAX
 . W !!?5,"ClaimsManager is only available for CMS-1500 claims."
 . W !!?5,"The form type of the bill you're editing"
 . W " (",$G(IBBNO),") is "
 . W $$EXTERNAL^DILFD(399,.19,"",$P(^DGCR(399,IBIFN,0),U,19)),"."
 . I $P(^DGCR(399,IBIFN,0),U,27) D
 .. W !?5,"The charge type of this bill is "
 .. W $$EXTERNAL^DILFD(399,.27,"",$P(^DGCR(399,IBIFN,0),U,27)),"."
 .. Q
 . D EOP
 . Q
 ;
 ; Check for a form type change
 D CKFT^IBCIUT1(IBIFN)
 ;
 ; Display the options available and let the user choose
 S DIR("A")="Select option or press RETURN to continue"
 S DIR(0)="SO^1:Test Send to ClaimsManager;2:Display ClaimsManager Errors;3:Show ClaimsManager Information"
 D ^DIR K DIR
 I 'Y G CLAX
 I Y=1 D TESTSEND G CLAX
 I Y=2 D DISPERR G CLAX
 I Y=3 D STATS G CLAX
CLAX ;
 Q
 ;
 ;
TESTSEND ;
 ; Send the data to ClaimsManager as it currently exists
 ; and display any errors that ClaimsManager finds.
 ;
 NEW NUMBER,IBCISNT,IBCISTAT,IBCIREDT,IBCIERR
 ;
 ; Check for the ClaimsManager working OK flag
 I '$$CK2^IBCIUT1() D  G TSTSNDX
 . W !!?5,"The VistA-ClaimsManager Interface is not currently working."
 . W !!?5,"Please try again later."
 . D EOP
 . Q
 ;
 ; Check to see if the bill is no longer editable.  We only want to
 ; do test sends if the bill is still editable.
 I '$F(".1.","."_$P($G(^DGCR(399,IBIFN,0)),U,13)_".") D  G TSTSNDX  ;DSI/DJW 3/21/02
 . W !!?5,"This bill is no longer editable.  The ClaimsManager interface"
 . W !?5,"Test Send functionality is not available for this bill."
 . D EOP
 . Q
 ;
 ; Refresh the data in file 351.9 if either of these functions 
 ; report that there are no line items.  We've got to know what's
 ; going on in this case.  (esg - 3/20/02)
 I '$$LITMS^IBCIUT1(IBIFN)!'$$CKLI^IBCIUT1(IBIFN) D UPDT^IBCIADD1
 ;
 ; Check for the existence of line items
 I '$$CKLI^IBCIUT1(IBIFN) D MSG4^IBCIST,EOP G TSTSNDX
 ;
 ; Send to ClaimsManager after setting IBCISNT=3 to indicate test send
 S IBCISNT=3
 D ST2^IBCIST
 ;
 ; No errors found by ClaimsManager
 I IBCISTAT=3 D EOP G TSTSNDX
 ;
 ; Errors were found by ClaimsManager
 I IBCISTAT=4 D  G TSTSNDX
 . W !!?5,"ClaimsManager found "
 . S NUMBER=$O(^TMP("IBCITST",$J,""),-1)
 . W NUMBER," error" W:NUMBER>1 "s"
 . W " with this bill."
 . W !?5,"Press RETURN to view the error" W:NUMBER>1 "s" W "."
 . D EOP Q:($D(DTOUT)!$D(DUOUT))
 . ;
 . ; Invoke the utility to display the ClaimsManager errors
 . ;
 . D EN^IBCIWK(0)
 . Q
 ;
 ; At this point, we know that IBCISTAT=6 so there was a communication
 ; problem of some kind.  A more descriptive error message should have
 ; been displayed by IBCIST and a mail message should have been sent.
 ;
 W !!?5,"There was a communications failure:"
 W !?8,$P(IBCIERR,U,2)
 I $P(IBCIERR,U,3)'="" D
 . W !?8,$P($P(IBCIERR,U,3)," - ",1)
 . W !?8,$P($P(IBCIERR,U,3,99)," - ",2,99)
 . Q
 W !!?5,"Please report these errors to your system manager."
 W !?5,"This bill was NOT successfully analyzed by ClaimsManager."
 ;
 D EOP
 ;
TSTSNDX ;
 Q
 ;
DISPERR ; Display the errors that were received during the last transaction
 ; with Ingenix ClaimsManager.  These are the errors that are stored
 ; in the error fields in the CLAIMSMANAGER FILE (#351.9).  These
 ; fields are the ERROR CODE, ERROR DATA, and ERROR TEXT.  They are all
 ; stored at or under the 1 node.
 ;
 I '$P($G(^IBA(351.9,IBIFN,1,0)),U,4) D  G DISPERX
 . W !!?5,"There are no errors recorded in the file."
 . D EOP
 . Q
 ;
 ; At this point we know that some errors exist.  Process and display
 ; the errors stored on the 1 node file 351.9.
 ;
 ; Invoke the utility to display the ClaimsManager errors
 ; '0' indicates 'browse' mode of the ListMan display
 ;
 D EN^IBCIWK(0)
DISPERX ;
 Q
 ;
STATS ; Display the data elements on the 0 node of file 351.9.
 NEW J,IBA0
 S J=30
 S IBA0=$G(^IBA(351.9,IBIFN,0))
 W !!,$J("Current Status: ",J)
 W $$EXTERNAL^DILFD(351.9,.02,"",$P(IBA0,U,2))
 W !!,$J("Times sent to ClaimsManager: ",J)
 W $$EXTERNAL^DILFD(351.9,.04,"",$P(IBA0,U,4))
 W !,$J("Last sent date/time: ",J)
 W $$EXTERNAL^DILFD(351.9,.03,"",$P(IBA0,U,3))
 W !,$J("Last sent by: ",J)
 W $$EXTERNAL^DILFD(351.9,.05,"",$P(IBA0,U,5))
 W !!,$J("Date/time Entered: ",J)
 W $$EXTERNAL^DILFD(351.9,.06,"",$P(IBA0,U,6))
 W !,$J("Entered by: ",J)
 W $$EXTERNAL^DILFD(351.9,.07,"",$P(IBA0,U,7))
 W !,$J("Date/time Last Edited: ",J)
 W $$EXTERNAL^DILFD(351.9,.08,"",$P(IBA0,U,8))
 W !,$J("Last Edited by: ",J)
 W $$EXTERNAL^DILFD(351.9,.09,"",$P(IBA0,U,9))
 W !!,$J("Assigned to: ",J)
 W $$EXTERNAL^DILFD(351.9,.12,"",$P(IBA0,U,12))
 W !,$J("Coder: ",J)
 W $P($$CODER^IBCIUT5(IBIFN),U,3)
 W !,$J("Biller: ",J)
 W $P($$BILLER^IBCIUT5(IBIFN),U,2)
 D EOP
STATSX ;
 Q
 ;
EOP ; End of page
 W !! S DIR("A")="Press RETURN to continue",DIR(0)="E" D ^DIR K DIR
EOPX ;
 Q
 ;
