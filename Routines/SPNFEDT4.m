SPNFEDT4 ;HISC/DAD-INPUT/OUTPUT PROCESS FOR SURVEY (ROLL&SCROLL) ;9/25/95  09:04
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
ADDEDIT(SPNFTYPE,SPNFDFN) ; *** Choose add / edit a record
 ;  SPNFTYPE = 1 - Four Level Functional Measure
 ;             2 - Clinician reported FIM
 ;  SPNFDFN  = IEN in PATIENT file (#2)
 S SPNFFLAG=$$FIND^SPNFEDT2(SPNFTYPE,SPNFDFN),SPNEXIT=0
 W !!,$P($G(^DPT(SPNFDFN,0)),U) S Y=+$P(SPNFFLAG,U,2)
 W " has ",$S(Y=-1:"no",Y=0:"one",1:Y)
 W " ",$S(SPNFTYPE=1:"Four Level Functional Measure",SPNFTYPE=2:"Clinician Reported FIM",1:"???")
 W " record",$S(Y:"s",1:""),"."
 K DIR S DIR(0)="SOM^A:Add a new record;"
 S DIR("A")="Choose"
 S DIR("?",1)="   Enter 'A' to create a new record for the selected patient."
 I $P(SPNFFLAG,U,2)'<0 D
 . S DIR(0)=DIR(0)_"E:Edit an existing record;"
 . S DIR("?",2)="   Enter 'E' to edit a pre-existing record for the selected patient."
 . S DIR("?")="   Choose either 'A' or 'E'."
 . Q
 E  D
 . S DIR("?")="   Enter 'A' to add a record, <RETURN> or '^' to exit."
 . Q
 D ^DIR W ! S SPNFACTN=Y I $D(DIRUT) S SPNEXIT=1 Q
 ;
 I SPNFACTN="A" D
 . ; *** Add a FIM
 . K DD,DIC,DINUM,DO
 . S SPNFD0=-1
 . S DIC="^SPNL(154.1,",DIC(0)="L"
 . S DLAYGO=154.1,X=SPNFDFN
 . D FILE^DICN W ! S SPNFD0=+Y
 . K DR S DR=".02///^S X="_SPNFTYPE_";.04///TODAY;.04DATE RECORDED"
 . D EDITFIM^SPNFEDT3(SPNFD0,.DR)
 . Q
 I SPNFACTN="E" D
 . ; *** Edit a FIM
 . S SPNEXIT=0
 . I $P(SPNFFLAG,U,2)>0 D  Q:SPNEXIT
 .. ; *** If more than one record, select record to edit
 .. K DIC S DIC="^SPNL(154.1,",DIC(0)="AEQSZ"
 .. S DIC("A")="Select DATE RECORDED: ",DIC("W")=""
 .. S DIC("S")="I $P(^(0),U,1,2)="""_SPNFDFN_U_SPNFTYPE_""""
 .. S D="C"
 .. D IX^DIC S SPNFD0=+Y I Y'>0 S SPNEXIT=1
 .. Q
 . E  D
 .. ; *** If only one record, select it for editing
 .. S SPNFD0=+$P(SPNFFLAG,U)
 .. Q
 . Q
 Q
 ;
CHKREC(SPNLD0,SPNFD0) ; *** Check record for consistency
 ;  SPNLD0 = IEN in SCD file (#154)
 ;  SPNFD0 = IEN in FIM file (#154.1)
 N SPNFDATA,SPNFFLD,SPNLDATA,SPNLFLD,SPNPROB
 F SPNLFLD=2.4,2.5,5.01 D
 . S SPNLDATA(SPNLFLD)=$$GET1^DIQ(154,SPNLD0_",",SPNLFLD)
 . Q
 F SPNLFLD=5.06:.01:5.1 D
 . S SPNLDATA(SPNLFLD)=$$GET1^DIQ(154,SPNLD0_",",SPNLFLD,"I")
 . Q
 F SPNFFLD=2.08:.01:2.11 D
 . S SPNFDATA(SPNFFLD)=$$GET1^DIQ(154.1,SPNFD0_",",SPNFFLD)
 . Q
 F SPNFFLD=2.08:.01:2.11 D
 . S SPNFDATA(SPNFFLD)=$$GET1^DIQ(154.1,SPNFD0_",",SPNFFLD,"I")
 . Q
 S SPNPROB=0
 W !!,$TR($J("",80)," ","="),!,"Checking data for inconsistencies...",!
 I SPNLDATA(5.01)'["OTHER",SPNLDATA(2.4)]"" D
 . W !,"CAUSE OF INJURY is not 'OTHER', DESCRIBE CAUSE OTHER should be blank.",$C(7)
 . S SPNPROB=SPNPROB+1
 . Q
 I SPNLDATA(5.06)=1,SPNLDATA(5.08)=1 D
 . W !,"ONE ARM AFFECTED and BOTH ARMS AFFECTED are both answered 'YES'.",$C(7)
 . S SPNPROB=SPNPROB+1
 . Q
 I SPNLDATA(5.07)=1,SPNLDATA(5.09)=1 D
 . W !,"ONE LEG AFFECTED and BOTH LEGS AFFECTED are both answered 'YES'.",$C(7)
 . S SPNPROB=SPNPROB+1
 . Q
 I SPNLDATA(5.1)'>0,SPNLDATA(2.5)]"" D
 . W !,"OTHER BODY PART AFFECTED is 'NO', DESCRIBE OTHER BODY PART should be blank.",$C(7)
 . S SPNPROB=SPNPROB+1
 . Q
 I SPNFDATA(2.08)'>0,SPNFDATA(2.09) D
 . W !,"HELP DURING LAST 2 WEEKS is 'NO', NUMBER OF HOURS OF HELP should be blank.",$C(7)
 . S SPNPROB=SPNPROB+1
 . Q
 I SPNFDATA(2.1)>4,SPNFDATA(2.11)>0 D
 . W !,"RECEIVED MOST MEDICAL CARE is 'NON-VA ONLY' or 'DID NOT SEE DOCTOR/NURSE"
 . W !,"LAST 5 YRS', VA MOST USED FOR MEDICAL CARE should be blank.",$C(7)
 . S SPNPROB=SPNPROB+1
 . Q
 W:SPNPROB !!
 W SPNPROB," inconsistenc",$S(SPNPROB=1:"y",1:"ies")," found."
 Q
