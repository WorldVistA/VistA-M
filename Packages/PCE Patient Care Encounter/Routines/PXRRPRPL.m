PXRRPRPL ;ISL/PKR - Build the Provider list ;11/18/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**10,12**;Aug 12, 1996
 ;Build the Provider list based upon the Provider selection criteria.
 ;
 ;=======================================================================
PRV ;Build a list of selected providers.
 N X,Y
 K DTOUT,DUOUT
 S NPL=0
 S DIC=200
 S DIC(0)="AEQMZ"
 S DIC("A")="Select PROVIDER: "
 ;As of April 1996 a determination has been made not to use the provider
 ;key screen.  It has just been commented out because there is a
 ;possibility it may be used in the future.
 ;S DIC("S")="I $D(^VA(200,""AK.PROVIDER"",$P($G(^VA(200,+Y,0)),U)))"
 W !
NPRO I NPL'<1 S DIC("A")="Select another PROVIDER: "
 D ^DIC
 I X=(U_U) S DTOUT=1
 I $D(DTOUT) Q
 I +Y'=-1 D  G NPRO
 . S NPL=NPL+1
 . S PXRRPRPL(NPL)=$P(Y,U,2)_U_$P(Y,U,1)
 E  K DIC
 I (NPL=0)&($D(DIRUT)!$D(DUOUT)) Q
 I $D(DUOUT) G PRV
 I (NPL=0)&(+Y=-1) W !,"You must select a provider!" G PRV
 ;
 ;Sort the provider list into ascending order.
 S NPL=$$SORT^PXRRUTIL(NPL,"PXRRPRPL")
 Q
 ;
