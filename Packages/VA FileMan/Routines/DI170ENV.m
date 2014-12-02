DI170ENV ;OIFO-Oakland/RD - ENVIRONMENT CHECK ROUTINE ;
 ;;22.0;VA FileMan;**170**;Mar 30, 1999;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;this routine is used to test patch DI*22*170
 Q
EN ;Test Remedy ticket 865632
 D I1,I2
 Q
I1 ;issue 1
 N DIC,X,Y,$ESTACK,$ETRAP S $ETRAP="D ERR^DI170ENV"
 W !!,"This routine will test the fixes in patch DI*22*170."
 W !!,"Issue 1: undefined error when user enter '?' after a list and asked to choose."
 W !!," Step 1.  Enter '?' at the 'CHOOSE 1-5:' prompt."
 W !," Step 2.  Enter 'NO' at the 'Do you want... INSTITUTION List?' prompt."
 W !," Step 3.  If you don't get an error, then enter '^' at the next prompt."
 W !!,"Begin Test 1:",!
 S DIC="^DIC(4,",DIC(0)="QEM",X="500G"
 D ^DIC
 W !!,"Test Passed, no error occurred",!!
 Q
I2 ;issue 2
 N DIR,DIRUT,DIOUT,X,Y
 W !!,"Issue 2: User can't '^' out of the reader(DIR) on a pointer field or type."
 W !!," Step 1.  Enter 'VISN' at the 'Select INSTITUTION:' prompt."
 W !," Step 2.  Enter '^' at the 'CHOOSE 1-5:' prompt."
 W !," Step 3.  Hit ""Enter key"" at next two prompts."
 W !!,"Begin Test 2:",!
 S DIR(0)="PO^4:EM"
 D ^DIR
 W !!!,"If you saw a long description about the INSTITUTION file and was prompted"
 W !,"to view the entire INSTITUTION List, then the test FAILED."
 W !!,"If you only saw the 'Select INSTITUTION:' prompt again, the test Passed.",!!!
 Q
ERR ;this is where the error is trapped
 S X=$$EC^%ZOSV ;Get the error code
 W !!,X,!
 W "**Test FAILED**",!!
 D UNWIND^%ZTER
 Q
