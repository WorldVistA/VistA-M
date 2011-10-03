MCARENV ;WISC/MLH-MEDICINE PACKAGE INSTALLATION-ENVIRONMENT CHECK ROUTINE #1 ;10/19/92  09:31
 ;;2.3;Medicine;;09/13/1996
 ;
 N AA,DDR,BB,FOUND
 W:$D(IOF) @IOF ;    clear screen
 W !,"ENVIRONMENT CHECK:"
 ;
 ;    Look at every file in Medicine (690-701 inclusive) for pointers
 ;    to files 3-6-16.  If any exist, stop here and instruct the user
 ;    to repoint these entries to File 200 (NEW PERSON).
 W !,"Before initialization, this routine will verify whether the"
 W !,"package file entries have been converted to the NEW PERSON file."
 W !!,"Checking..."
 S (FOUND,END)=0
 S AA=690
 FOR  D  Q:FOUND!END
 .  W "." ;    let user know we're making progress
 .  S BB=0
 .  FOR  S BB=$O(^DD(AA,BB)) Q:'BB  D  Q:FOUND
 ..    S DDR=^DD(AA,BB,0) ;    main data dictionary record
 ..    F II=1:1:4 S DDR(II)=$P(DDR,"^",II)
 ..    ;
 ..    S FIL=$P($P(DDR(3),"DIC(",2),",",1)
 ..    I (FIL=3)!(FIL=6)!(FIL=16) S FOUND=1
 ..    Q
 .  ;END FOR
 .  IF 'FOUND D
 ..    S AA=$O(^DD(AA))
 ..    I 'AA!(AA'<705) S END=1
 ..    Q
 .  ;END IF
 .  Q
 I FOUND D  ;    Abort the init with an explanation.
 .  S OKTOGO=0
 E  D
 .  S OKTOGO=1
 .  W !!,"OK, there aren't any unconverted pointers."
 .  S DIR(0)="E",DIR("A")="Hit <RETURN> to continue" D ^DIR ;    pause before the next round
 Q
