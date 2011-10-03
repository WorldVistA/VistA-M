DGEN408T ;ALB/SCK - IVMB SEED THE HEC WITH MPI POST INSTALL ; 5/1/02 12:58pm
 ;;5.3;Registration;**408**;Aug 13,1993
 Q
 ;
EN ; Main entry point to populate the IVMB HEC MPI NOTIFICATION mail
 ; group.  This routine is run as the post-install routine to patch
 ; DG*5.3*408
 ;
 N X,Y,DIR,DIRUT,DUOUT,MGIEN,DIC
 ;
 W !!,?11,"*** SETUP MEMBERS OF HEC MPI NOTIFICATION MAIL GROUP ***",!!
 S DIC=3.8
 S DIC(0)="MZ"
 S X="IVMB HEC MPI NOTIFICATION"
 D ^DIC K DIC
 I '(+Y>0) D  Q
 . W !!?5,*7,"Apparently the IVMB HEC MPI NOTIFICATION mail group was not"
 . W !?5,"created or set up correctly by the DG*5.3*408 patch installation."
 . W !?5,"You will need to either create this mail group, or contact Cutomer"
 . W !?5,"Service for assistance."
 ;
 S MGIEN=+Y
 ;
 D LOCAL(MGIEN)
 ;
 W !
 S DIR(0)="YAO",DIR("B")="NO"
 S DIR("A")="Do you wish to enter any remote members? "
 S DIR("?",1)="Enter 'Yes' to add remote members to the mail group"
 S DIR("?")="Enter 'No' or Press the ENTER key to quit"
 D ^DIR K DIR
 Q:'Y!($D(DIRUT))!($D(DUOUT))
 W !
 ;
 D REMOTE
 ;
 Q
 ;
LOCAL(MGIEN) ; Add local members to mail group
 N I,ABORT,XMY
 ;
 F I=1:1 Q:$G(ABORT)  D
 . S DIR(0)="POA^200:EMZ"
 . S DIR("A")="Select member to add to mail group: "
 . S DIR("?",1)="Select a member to add to the IVMB HEC MPI NOTIFICATION mail group"
 . S DIR("?")="as a local member."
 . D ^DIR K DIR
 . I $D(DIRUT)!($D(DUOUT)) S ABORT=1 Q
 . S XMY(+Y)=""
 . ;
 . S DIR(0)="YA",DIR("B")="NO"
 . S DIR("A")="Add another member? "
 . S DIR("?")="'Yes' to add another local member, 'No' for no more entries"
 . D ^DIR K DIR
 . Q:$D(DIRUT)!($D(DUOUT))
 . S:'Y ABORT=1
 ;
 I $$MG^XMBGRP(MGIEN,"","","",.XMY,"",0)
 ;
 Q
 ;
REMOTE ; Add remote members to mail group
 N I,ABORT,ZFDA,CNT,ZMSG,I1
 ;
 S CNT=2
 F I=1:1 Q:$G(ABORT)  D
 . S DIR(0)="FOA"
 . S DIR("A")="Enter a remote address: "
 . S DIR("?",1)="Enter a remote address (name@domain) or local device (D.device) or"
 . S DIR("?",2)="local server (S.device).  This is free text, validated remote address"
 . S DIR("?")="or local device or server"
 . D ^DIR K DIR
 . I $D(DIRUT)!($D(DUOUT)) S ABORT=1 Q
 . S ZFDA(3.812,"+"_CNT_",?1,",.01)=Y
 . S CNT=CNT+1
 . ;
 . S DIR(0)="YA",DIR("B")="NO"
 . S DIR("A")="Add another remote member? "
 . S DIR("?")="'Yes' to add another remote member, 'No' for no more entries."
 . D ^DIR K DIR
 . Q:$D(DIRUT)!($D(DUOUT))
 . S:'Y ABORT=1
 S ZFDA(3.8,"?1,",.01)="IVMB HEC MPI NOTIFICATION"
 D UPDATE^DIE("","ZFDA","","ZMSG")
 ;
 I $D(ZMSG) D
 . S I=0
 . F  S I=$O(ZMSG("DIERR",I)) Q:'I  D
 . . W !!?3,"Error: "_ZMSG("DIERR",I)
 . . S I1=0
 . . F  S I1=$O(ZMSG("DIERR",I,"TEXT",I1)) Q:'I1  D
 . . . W !?3,ZMSG("DIERR",I,"TEXT",I1)
 ;
 Q
