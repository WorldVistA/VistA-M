XLFNAME5 ;SFISC/MKO-INTERACTIVE OPTION TO CONVERT NAMES ;11:32 AM  28 Jan 2000
 ;;8.0;KERNEL;**134**;Jul 10, 1995
CONVERT ;Convert Names
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,XUIEN,XUNMSP,X,Y
 S XUNMSP="XLFNAME"
 ;
 D CINTRO
 S DIR(0)="YO",DIR("A")="Do you wish to continue"
 S DIR("?",1)="  Enter 'Y' to convert the Names in the New Person file"
 S DIR("?",2)="  to standard form, and to store the component parts of"
 S DIR("?")="  the Names in the new Name Components file."
 W ! D ^DIR K DIR Q:$D(DIRUT)!'Y
 ;
 ;Check if the conversion was already run.
 ;Determine which record to start with.
 S XUIEN=+$P($G(^XTMP(XUNMSP,0)),U,4)
 I XUIEN D  Q:$D(DIRUT)
 . I $O(^VA(200,XUIEN)) D
 .. W !!,"It appears that the conversion has already been performed through"
 .. W !,"record #"_XUIEN_" in the New Person file."
 .. W !!,"Do you want to continue the conversion from after this point"
 .. W !,"or convert the entries from the beginning of the file."
 .. S DIR(0)="S^C:Continue the conversion after record #"_XUIEN_";S:Start again from the beginning of the file"
 .. S DIR("?",1)="  Enter 'C' to start the conversion and parsing process from the"
 .. S DIR("?",2)="  after record #"_XUIEN_" in the New Person file."
 .. S DIR("?",3)=" "
 .. S DIR("?",4)="  Enter 'B' to start the conversion and parsing process from the"
 .. S DIR("?",5)="  the beginning of the New Person file."
 .. S DIR("?",6)=" "
 .. S DIR("?",7)="  NOTE: There is no harm in running the conversion again from the"
 .. S DIR("?",8)="  beginning. However, if the conversion routine previously parsed a name"
 .. S DIR("?",9)="  into its component parts incorrectly, and you corrected those problems"
 .. S DIR("?",10)="  by manually editing the name components, your corrections will be lost"
 .. S DIR("?")="  if you run the conversion again."
 .. D ^DIR K DIR Q:$D(DIRUT)
 .. S:Y="S" XUIEN=0
 . E  D
 .. W !!,"It appears that the conversion has already been performed on all entries"
 .. W !,"in the New person file.",!
 .. S DIR(0)="YO",DIR("A")="Do you want to run the conversion again"
 .. S DIR("?",1)="  Enter 'Y' if you wish to run the New Person Name conversion again."
 .. S DIR("?",2)=" "
 .. S DIR("?",3)="  NOTE: There is no harm in running the conversion again. However, if the"
 .. S DIR("?",4)="  conversion routine previously parsed a name into its component parts"
 .. S DIR("?",5)="  incorrectly, and you corrected those problems by manually editing the"
 .. S DIR("?",6)="  name components, your corrections will be lost if you run the conversion"
 .. S DIR("?")="  again."
 .. D ^DIR K DIR S:'Y DIRUT=1 Q:$D(DIRUT)
 .. S XUIEN=0
 ;
 D NEWPERS^XLFNAME3("CPR"_$E("K",'XUIEN),+XUIEN)
 S:$D(^XTMP(XUNMSP,0))#2 $P(^(0),U,3)="Created by CONVERT~XLFNAME"
 Q
 ;
CINTRO ;Print introductory comments
 ;;This routine will run the New Person Name Standardization conversion. It
 ;;will loop through the entries in the New Person file and:
 ;;
 ;;  1. Convert the Names (field #.01) in the New Person file to standard
 ;;     form.
 ;;
 ;;  2. Parse each Name into its component parts and store those parts
 ;;     in the new Name Components file (#20).
 ;;
 ;;  3. Establish a pointer from each New Person entry to the
 ;;     corresponding entry in the Name Components that contains the
 ;;     Name parts.
 ;;
 ;;  4. Record in ^XTMP all changes that were made, and any problems
 ;;     or questionable assumptions that are encountered in
 ;;     standardizing the name or parsing it into its component parts.
 ;;$$END
 N I,T F I=1:1 S T=$P($T(CINTRO+I),";;",2,999) Q:T="$$END"  W !,T
 Q
 ;
GENERATE ;Generate ^XTMP
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,XUIEN,XUNMSP,X,Y
 S XUNMSP="XLFNAME"
 ;
 D GINTRO
 S DIR(0)="YO",DIR("A")="Do you wish to continue"
 S DIR("?",1)="  Enter 'Y' to store information in ^XTMP about changes that"
 S DIR("?")="  will take place when the CONVERT^XLFNAME entry point is run."
 W ! D ^DIR K DIR Q:$D(DIRUT)!'Y
 ;
 ;Check if the conversion was already run.
 ;Determine which record to start with.
 I $P($G(^XTMP(XUNMSP,0)),U,4) D  Q:$D(DIRUT)
 . W !!,"It appears that the conversion of New Person Names (routine CONVERT^XLFNAME)"
 . W !,"has already been run. If you continue, the information already stored in"
 . W !,"^XTMP about records that have been converted will be lost.",!
 . S DIR(0)="YO",DIR("A")="Are you sure you wish to continue"
 . S DIR("?")="  Enter 'Y' if you wish to replace the information already in ^XTMP."
 . D ^DIR K DIR S:'Y DIRUT=1
 ;
 D NEWPERS^XLFNAME3("KR")
 S:$D(^XTMP(XUNMSP,0))#2 $P(^(0),U,3)="Created by GENERATE~XLFNAME"
 Q
 ;
GINTRO ;Print introductory comments
 ;;This entry point loops through the records in the New Person file and
 ;;determines the standard form of each Name. It also tries to determine the
 ;;component parts of the name. If the standard form of the name is different
 ;;from the current form, or if any questionable assumptions need to made in
 ;;determining the component parts of the name, information about that name
 ;;is stored in ^XTMP("XLFNAME"). You can later print the information stored
 ;;in ^XTMP via the PRINT^XLFNAME entry point.
 ;;
 ;;NOTE: This entry point makes no changes to the NEW PERSON file or the new
 ;;      NAME COMPONENTS file.
 ;;$$END
 N I,T F I=1:1 S T=$P($T(GINTRO+I),";;",2,999) Q:T="$$END"  W !,T
 Q
