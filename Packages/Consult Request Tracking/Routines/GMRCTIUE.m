GMRCTIUE ;SLC/DCM,DLT,JFR - Complete/Update TIU notes ;07/10/03 15:26
 ;;3.0;CONSULT/REQUEST TRACKING;**4,10,14,12,15,17,35**;DEC 27, 1997
 ;
 ; This routine invokes IA #2410,#2694,#2833,#2699,#2700
 ;
 Q
ENTER(GMRCO) ; Enter a note in TIU for the consult result
 ;If consult from list is defined in GMRCO, then use it.
 K GMRCQUT N TIUDA,TIUCLASS,GMRCLCK
 N GMRCMC
 I '$L($G(GMRCO)) D SELECT^GMRCA2(.GMRCO)
 Q:$D(GMRCQUT)!'$L($G(GMRCO))
 I $P($G(^GMR(123,GMRCO,12)),U,5)="P" D  D EDEX Q
 . N DIR
 . W !,"The requesting facility may not complete an inter-facility "
 . W "consult."
 . S DIR(0)="E" D ^DIR
 I '$$LOCK^GMRCA1(GMRCO) D EDEX Q
 S GMRCLCK=1
 D CHKSTS I $G(GMRCQUT) D EDEX Q
 I $D(VALM) D FULL^VALM1
 ;
 ;Find out access if a Clinical Procedure request
 N GMRCCP
 S GMRCCP=$$CPACTM^GMRCCP(+GMRCO)
 ;
 ;If service administrative user, then use administrative complete logic
 N GMRCAU
 S GMRCAU=$$VALID^GMRCAU($P(^GMR(123,GMRCO,0),U,5))
 I GMRCAU=3 D  Q
 . I $P(^GMR(123,+GMRCO,0),U,12)'=2,'GMRCCP S GMRCMC=$$MED(GMRCO)
 . I $G(GMRCMC),$P(^GMR(123,+GMRCO,0),U,12)=2 D EDEX Q
 . W !,$$CJ^XLFSTR("- Proceeding with Administrative Complete -",80)
 . D COMP^GMRCAAC(+GMRCO)
 . D EDEX
 ;
 I GMRCAU=4 D  I $G(GMRCQIT)=1 D EDEX Q
 . N DIRUT
 . I $P(^GMR(123,+GMRCO,0),U,12)'=2,'GMRCCP S GMRCMC=$$MED(GMRCO)
 . I $G(GMRCMC),$P(^GMR(123,+GMRCO,0),U,12)=2 Q
 . S DIR(0)="YA",DIR("A")="Administratively complete this request? "
 . D ^DIR I $D(DIRUT) S GMRCQIT=1 Q
 . I Y<1 Q
 . W !,$$CJ^XLFSTR("- Proceeding with Administrative Complete -",80)
 . D COMP^GMRCAAC(+GMRCO) S GMRCQIT=1
 . Q 
 ;
 ;Assume the user is a clinical user
 I GMRCCP=0 S GMRCMC=$$MED(GMRCO) ;only go med if not a CP
 ;If a Procedure, allow Medicine or fall through to a note
 I $G(GMRCMC) D  I $G(GMRCQIT)=1 D EDEX Q
 . N DUOUT,DTOUT,DIROUT,DIRUT,X,Y,DIR
 . W !
 . S DIR(0)="YA",DIR("B")="Y",DIR("A")="Continue with Note Entry? "
 . D ^DIR I Y<1 S GMRCQIT=1
 . W !
 . Q
 ;
 ;Get list of notes If no new notes, add new then quit
 S GMRCDFN=$P(^GMR(123,+GMRCO,0),"^",2)
 I $D(VALM) D FULL^VALM1
 I '$$GETLIST(GMRCDFN,GMRCO,.GMRCTIUC) D  D EDEX Q
 . I GMRCCP>1,GMRCCP'=4 D CPGUI Q
 . D NEW
 ;
 ;If TIU Document already exists, use single record edit, and quit
 S GMRCVF="TIU(8925,"
 I GMRCTIUC(GMRCVF)=1 D  Q
 . I GMRCCP=3 D CPGUI Q  ;incomplete CP document, must go to GUI
 . N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 . D SHOWTIU^GMRCTIUL
 . S DIR(0)="YA",DIR("B")="Yes",DIR("A")="Edit/Review this note? "
 . D ^DIR I Y>0 D
 .. S GMRCTUFN=$$SINGLE(GMRCVF)
 .. I +GMRCTUFN D EDITNOTE(GMRCTUFN)
 . S DIR(0)="YA"
 . S DIR("B")="No",DIR("A")="Would you like to enter a new note? "
 . W ! D ^DIR I Y>0 D NEW
 . D EDEX
 . Q
 ;
 ;Show the list of multiple tiu results for selection
 D SHOWTIU^GMRCTIUL
 ;
 ;Select a note from the list and then get the TIU internal entry
 S GMRCSELR=$$SELR^GMRCTIUL(.GMRCTIUC)
 I $D(GMRCQUT) D EDEX Q
 I '+(GMRCSELR) D  D EDEX Q
 . ;didn't select existing note, allow a new entry
 . N DIR,X,Y
 . S DIR(0)="Y",DIR("A")="Would you like to enter a new note"
 . S DIR("B")="N" D ^DIR
 . I Y<1 K DTOUT,DUOUT,X,Y Q
 . D NEW
 S GMRCTUFN=$$GETTUFN(GMRCSELR)
 ;
 I +GMRCTUFN D EDITNOTE(GMRCTUFN)
 ;
 D EDEX
 Q
 ;
MED(GMRCO) ;allow med results if appropriate
 ;If a Procedure and setu properly, allow Medicine
 N GMRCMED,GMRCQIT S GMRCMED=0
 I $P(^GMR(123,+GMRCO,0),U,17)="P" D
 . Q:'$P(^GMR(123.3,+$P(^GMR(123,+GMRCO,0),U,8),0),U,5)
 . D FULL^VALM1
 . N DIR,DIROUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="YA",DIR("B")="Y"
 . S DIR("A",1)="  ",DIR("A")="Attach Medicine Results? "
 . D ^DIR Q:Y<1
 . K DIR
 . S GMRCMED=1
 . D ARMED^GMRCAR
 Q GMRCMED
 ;
SAUSER() ; admin user?
 N GMRCSS,GMRCADUS
 S GMRCSS=+$P($G(^GMR(123,+GMRCO,0)),"^",5) Q:'+GMRCSS 0
 I $D(^GMR(123.5,+$P($G(^GMR(123,+GMRCO,0)),"^",5),123.33,"B",DUZ)) Q 1
 I '$L($TEXT(VALIDU^GMRCAU)) Q 0
 S GMRCADUS=0
 I $L($TEXT(VALIDU^GMRCAU)) D TEAM^GMRCAU(.GMRCADUS,123.34,DUZ)
 Q +GMRCADUS
 ;
CHKSTS ;Check the order status before allowing entry of a note
 N STATUS S STATUS=$P($G(^GMR(123,+GMRCO,0)),"^",12)
 I $S(STATUS=1:1,STATUS=13:1,1:0) D
 . W !,"This order has been "
 . W $S(STATUS=1:"DISCONTINUED",1:"CANCELLED")
 . W ".  A note cannot be entered."
 . D PAUSE S GMRCQUT=1
 Q
 ;
EDITNOTE(GMRCTUFN) ;use TIU LM for an existing note
 I +$D(^TIU(8925,+GMRCTUFN,0)) D  Q
 . D EXSTNOTE^TIUBR1(+GMRCDFN,+GMRCTUFN)
 ;
 ; link is missing
 W !,"A note #"_+GMRCTUFN_" is linked to the consult,"
 W !,"  but the note is no longer in TIU!"
 D PAUSE
 Q
 ;
SINGLE(GMRCVF) ;Get the single result entry from the list for the file type
 N RSLT,GMRCVP
 S RSLT="",GMRCVP=0
 F  S RSLT=$O(^TMP("GMRC50",$J,RSLT)) Q:RSLT=""  D  Q:+GMRCVP
 . I $P(RSLT,";",2)=GMRCVF S GMRCVP=RSLT
 Q +GMRCVP
 ;
GETTUFN(GMRCSELR) ;Get the result entry from the selected entry
 N RSLT
 S RSLT=$O(^TMP("GMRC50R",$J,GMRCSELR,""))
 Q RSLT
 ;
NEW ;Enter a new result through TIU if implemented or old Completion logic
 S TIUCLASS=+$$CLASS(+$$CPACTM^GMRCCP(+GMRCO))
 I TIUCLASS'>0 D  Q
 . W !!,$C(7),"Consult Resulting through TIU is not yet implemented."
 . W !,"Proceeding with Administrative Complete."
 . D COMP^GMRCAAC(+GMRCO)
 ;
 N GMRCTIDA
 D MAIN^TIUEDIT(TIUCLASS,.GMRCTIDA,GMRCDFN,"","","","",1)
 ;
 Q
 ;
CLASS(CPSTAT) ; Get TIU doc def for CONSULTS OR clinical procedures
 N GMRCY,GMRCDTYP,ERR
 I 'CPSTAT D
 . S GMRCY=$$FIND1^DIC(8925.1,,"X","CONSULTS","B",,"ERR")
 I '$D(GMRCY) D
 . S GMRCY=$$FIND1^DIC(8925.1,,"X","CLINICAL PROCEDURES","B",,"ERR")
 S GMRCDTYP=$$GET1^DIQ(8925.1,+GMRCY,.04,"I")
 I +GMRCY>0,$S(GMRCDTYP="CL":0,GMRCDTYP="DC":0,1:1) S GMRCY=0
 Q GMRCY
 ;
GETLIST(GMRCDFN,GMRCO,GMRCLIST) ;
 ;
 N GMRCVF
 ;
 D GETLIST^GMRCTIUL(GMRCO,2,1,.GMRCTIUC)
 S GMRCVF="TIU(8925,"
 Q +$G(GMRCTIUC(GMRCVF))
 ;
ADDEND(GMRCO) ; Make an addendum action for a selected consult
 N TIUDA,GMRCTX,GMRCDFN,GMRCADUZ,RSLTINFO,GMRCACT,GMRCTIUC
 N GMRCLCK,RSLTIEN
 K GMRCQUT
 I '$L($G(GMRCO)) D SELECT^GMRCA2(.GMRCO)
 Q:$D(GMRCQUT)!'+($G(GMRCO))
 ;
 ;If service administrative user, then QUIT.
 I $$VALID^GMRCAU($P(^GMR(123,+GMRCO,0),U,5))=3 D  Q
 . D EXAC^GMRCADC("You do not have the ability to edit this note.")
 ;
 ;Assume the user is a clinical user
 ;
 ;Get list of notes for this consult. if no notes, then quit.
 S GMRCDFN=$P(^GMR(123,+GMRCO,0),"^",2)
 I '$$GETLIST(GMRCDFN,+GMRCO,.GMRCTIUC) D  Q
 . W !,"This consult does not yet have an associated note."
 . W !,"  Use the Complete action to enter a new note."
 . D PAUSE,EDEX
 ;
 I '$$LOCK^GMRCA1(GMRCO) D EDEX Q
 S GMRCLCK=1
 ;If TIU Document already exists, use single record edit, and quit
 S GMRCVF="TIU(8925,"
 I GMRCTIUC(GMRCVF)=1 D  D EDEX Q
 . S GMRCTUFN=$$SINGLE(GMRCVF)
 . Q:'+GMRCTUFN
 . D SHOWTIU^GMRCTIUL
 . N GMRCVP,RSLTINFO,AUTHOR
 . S GMRCVP=+GMRCTUFN_";"_GMRCVF
 . S RSLTIEN=$O(^TMP("GMRC50",$J,GMRCVP,0))
 . S RSLTINFO=$G(^TMP("GMRC50",$J,GMRCVP,RSLTIEN))
 . I $P(RSLTINFO,"^",6)="completed" D ADDEND1(+GMRCTUFN) Q
 . I (DUZ=+$P(RSLTINFO,"^",4)) D EDITNOTE(+GMRCTUFN) Q
 . W !,"You may not addend to the incomplete associated note."
 . W !,"You are not the author of the existing note."
 . I $$READ^GMRCACMT("Y","Do you want to add a new note ","YES") D NEW
 . Q
 ;
 ;Show the list of multiple tiu results for selection
 D SHOWTIU^GMRCTIUL
 ;
 ;Select a note from the list and then get the TIU internal entry
 S GMRCSELR=$$SELR^GMRCTIUL(.GMRCTIUC)
 I $D(GMRCQUT)!'+(GMRCSELR) D EDEX Q
 S GMRCTUFN=$$GETTUFN(GMRCSELR)
 ;
 I +GMRCTUFN D ADDEND1(+GMRCTUFN),EDEX Q
 ;
 D EDEX
 Q
ADDEND1(TIUDA) ;Add an addendum
 ;
 D FULL^VALM1,ADDEND1^TIURA1
 Q
 ;
EDEX ;
 I $G(GMRCLCK) D UNLOCK^GMRCA1(GMRCO)
 K GMRCDFN,GMRCO,GMRCQUT,GMRCTUFN,GMRCSEL,GMRCQIT
 Q
 ;
PAUSE ; Pause for user
 ;
 N X W !,"Press <RETURN> to continue: " R X:DTIME E  W " (timeout)"
 Q
 ;
CPGUI ;it's GUI way or no way
 N MSG
 S MSG="You must use the CPRS GUI to complete this Clinical Procedure"
 D EXAC^GMRCADC(MSG)
 Q
