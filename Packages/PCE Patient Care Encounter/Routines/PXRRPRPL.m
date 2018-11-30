PXRRPRPL ;ISL/PKR - Build the Provider list ;01/30/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**10,12,211**;Aug 12, 1996;Build 244
 ;Build the Provider list based upon the Provider selection criteria.
 ;
 ;==========================================
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
 ;==========================================
TEAM ;Build a list of selected providers by CPRS Team.
 ;DBIA #1489 covers access to file #100.21.
 N IEN,PRVDUZ,PRVNAME,X,Y
 K DTOUT,DUOUT
 S NPL=0
 S DIC=100.21
 S DIC(0)="AEQMZ"
 S DIC("A")="Select CPRS Team (OE/RR List): "
 W !
NTEAM I NPL'<1 S DIC("A")="Select another CPRS Team (OE/RR List): "
 D ^DIC
 I X=(U_U) S DTOUT=1
 I $D(DTOUT) Q
 I +Y'=-1 D  G NTEAM
 . S IEN=+$P(Y,U,1)
 . I $P($G(^OR(100.21,IEN,1,0)),U,4)'>0 D  G NTEAM
 .. W !,"There are no providers on this CPRS Team (OE/RR List)!"
 . S PRVDUZ=0
 . F  S PRVDUZ=$O(^OR(100.21,IEN,1,PRVDUZ)) Q:PRVDUZ=""  D
 .. S PRVNAME=$$GET1^DIQ(200,PRVDUZ,.01)
 .. S NPL=NPL+1
 .. S PXRRPRPL(NPL)=PRVNAME_U_PRVDUZ
 E  K DIC
 I (NPL=0)&($D(DIRUT)!$D(DUOUT)) Q
 I $D(DUOUT) G TEAM
 I (NPL=0)&(+Y=-1) W !,"You must select a CPRS Team (OE/RR List)!" G TEAM
 ;
 ;Sort the provider list into ascending order.
 S NPL=$$SORT^PXRRUTIL(NPL,"PXRRPRPL")
 Q
 ;
