DGPFHLF ;SHRPE/SGM - PRF REFRESH ASSIGNMENT ; Aug 21, 2018 11:30
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;    Last edited: SHRPE/SGM - Nov 15,, 2018 14:25
 ;
 QUIT
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  -------------------------
 ; 2056  Sup   ^DIQ
 ; 3277  Sup   OWNSKEY^XUSRB
 ;10103  Sup   ^XLFDT: $$FMTE, $$NOW
 ;10112  Sup   $$SITE^VASITE
 ;
RF ; Option: DGPF RECORD REFRESH
 ;  .DGPFA() - contains the assignment data
 ;  if Ownership failure choice selected then certain values may change
 ;
 N I,J,X,NOW,SITE,TXT,USER
 N DGIEN,DGPFA,DGPFAH,DGWHO,DGWHY
 N DGAHIEN,DGERR,DGIEN,DGPFA,DGPFAH
 ;   Introductory text
 K TXT D TXT(.TXT,10,0,1)
 W @IOF F I=1:1 Q:'$D(TXT(I))  W !,TXT(I)
 W !
 ;
 ;   Authorization check
 Q:'$$CHECK
 ;
 ;   select PRF Assignment
 S DGIEN=$$SELASGN^DGPFUT6("I $P(^(0),U,2)[""(26.15,""")
 Q:DGIEN<1
 ;
 ;   attempt to obtain lock on assignment record
 I '$$LOCK^DGPFAA3(DGIEN) D  Q
 . K TXT D TXT(.TXT,26,0,1) W !!,TXT(1)
 . Q
 ;
 ;   get assignment into DGPFA array
 I '$$GETASGN^DGPFAA(DGIEN,.DGPFA,1) D  G OUT
 . K TXT D TXT(.TXT,28,0,1) W !!,TXT(1)
 . Q
 ;
 ;   prompt for reason for doing refresh
 ;   if OWNER SITE update needed, prompt for OWNER SITE value
 S DGWHY=$$PROMPT I $S(DGWHY'?1U:1,1:"OU"'[DGWHY) G OUT
 I DGWHY="O" D  I DGWHO<1 G OUT
 . S DGWHO=$$OWNER I DGWHO<1 Q
 . I DGWHO=DGPFA("OWNER") Q
 . S DGPFA("OWNER")=DGWHO
 . I '$$ISDIV^DGPFUT(+DGWHO) S DGPFA("REVIEWDT")=""
 . I '$D(^DG(40.8,"APRF",+DGWHO)) S DGPFA("REVIEWDT")=""
 . Q
 ;
 ;   add or rest some DGPFA()
 S NOW=$$NOW^XLFDT,$P(NOW,U,2)=$$FMTE^XLFDT(+$E(NOW,1,12))
 S SITE=$$SITE^VASITE
 S USER=$$DIQ^DGPFUT(200,DUZ,.01)
 S DGPFA("ACTION")=7+DGPFA("STATUS")
 ;
 ;   build DGPFAH()
 S DGPFAH("ASSIGN")=DGIEN_U_$P(DGPFA("DFN"),U,2)
 S DGPFAH("ASSIGNDT")=+NOW
 S DGPFAH("ACTION")=DGPFA("ACTION")
 S DGPFAH("ENTERBY")=DUZ
 S DGPFAH("APPRVBY")=DUZ
 S DGPFAH("TIULINK")=""
 S DGPFAH("ORIGFAC")=+SITE
 ;
 K TXT D TXT(.TXT,1,1,0)
 S $P(TXT(4,0),":",2)=" "_$P(SITE,U,2)
 S $P(TXT(5,0),":",2)=" "_USER
 S $P(TXT(6,0),":",2)=" "_$P(NOW,U,2)
 M DGPFAH("COMMENT")=TXT
 ;
 S J=0 F I=0:0 S I=$O(DGPFA("DBRS#",I)) Q:'I  D
 . S X=$P(DGPFA("DBRS#",I),U)
 . S $P(X,U,2)=$P($G(DGPFA("DBRS OTHER",I)),U)
 . S $P(X,U,3)=$P($G(DGPFA("DBRS DATE",I)),U)
 . S $P(X,U,5)=$P($G(DGPFA("DBRS SITE",I)),U)
 . S $P(X,U,4)="N"
 . S J=J+1,DGPFAH("DBRS",J)=X
 . Q
 ;
 ;   Display flag assignment review screen to user
 ;   9/6/2018 - business analyst said to not show the display screen
 ; S X="DGPF FLAG ASSIGNMENT REFRESH"
 ; S X(0)="^^ASSIGNMENT REFRESH^"
 ; D REVIEW^DGPFUT3(.DGPFA,.DGPFAH,DGIEN,X,X(0))
 ;
 ;   display message about the choices made
 K TXT D TXT(.TXT,41,0,1)
 W ! I DGWHY="O" W !,TXT(1),!,TXT(2)_$P(DGWHO,U,2)
 W !,TXT(3),!,TXT(4),!
 ;
 ;   prompt if which to continue
 S X="Do you wish to send an HL7 update message now"
 I $$ANSWER^DGPFUT(X,"NO","YO")<1 G OUT
 ;
 ;   if refresh due to change of ownership update, then file assignment
 K DGERR,TXT
 D TXT(.TXT,46,0,1)
 I +$G(DGWHO) D  I $D(DGERR) G OUT
 . D STOASGN^DGPFAA(.DGPFA,.DGERR,"D")
 . I $D(DGERR) W !!,TXT(1),!,TXT(2),!
 . Q
 ;   create History record, display message if failed
 W !!,TXT(3)
 S DGAHIEN=$$STOHIST^DGPFAAH(.DGPFAH,.DGERR)
 I $D(DGERR) W !,TXT(4),!,TXT(2) G OUT
 ;
 ;   send HL7 update message to refresh assignment of a CAT I flag
 S X=$$SNDORU^DGPFHLS(DGIEN) W ! W:X TXT(5) W:'X TXT(6)
 ;
OUT ;
 ;   release lock
 D UNLOCK^DGPFAA3(DGIEN)
 W ! I $$ANSWER^DGPFUT("Press any key to continue",,"E")
 Q
 ;
 ;---------------------------------------------------------------------
CHECK() ;   validate user authorized to run this Option
 N X,Y,DGRET,KEY,TXT
 S KEY="DGPF TRANSMISSIONS"
 D OWNSKEY^XUSRB(.DGRET,KEY,DUZ)
 S Y=(DGRET(0)=1)
 S X=($G(DUZ(0))="@")
 I X,Y Q 1
 D TXT(.TXT,8,0,1) W !!,TXT(1),!
 Q 0
 ;
OWNER() ;   prompt user for site to be assignment owner
 ;   code copied from CHANGE OWNERSHIP action CO^DGPFLMA4
 ;   do not remove current facility from list
 N I,X,DFN,DGOWN,DIR0,DIRA,DIRS,DIV,TXT
 S DFN=+DGPFA("DFN")
 ;
 ;   add treating facilities to selection list for Cat I assignments
 ;   display message if no other facilities found for patient
 I '$$BLDTFL^DGPFUT2(DFN,.DGOWN) D  Q 0
 . D TXT(.TXT,36,0,1)
 . W ! F I=1:1 Q:'$D(TXT(I))  W !,TXT(I)
 . W !
 . Q
 S DIV=0 F I=0:0 S DIV=$O(^DG(40.8,"APRF",DIV)) Q:'DIV  D
 . I $$TF^XUAF4(DIV) S DGOWN(DIV)=""
 . Q
 ;
 S DIRA="Select new owner site for this record flag assignment"
 S DIR0="P^4:EMZ"
 S DIRS="I $D(DGOWN(+Y))"
 W ! S X=$$ANSWER^DGPFUT(DIRA,,DIR0,,DIRS)
 I X>0 S $P(X,U,2)=$$NAME^XUAF4(+X)
 Q X
 ; 
PROMPT() ;   prompt user for reason for running this option
 N X,DIR0,DIRA,DGDIRH,TXT
 S DIR0="SO^U:Update failed;O:Ownership transfer failed"
 S DIRA="Reason for refreshing data"
 D TXT(.DGDIRH,30,0,1)
 S DGDIRH="   "
 S X=$$ANSWER^DGPFUT(DIRA,,DIR0,.DGDIRH)
 Q X
 ;
TXT(TXT,ST,ZERO,PAD) ;
 N I,J,X S J=0
 F I=ST:1 S J=J+1,X=$P($T(T+I),";",3,99) Q:X?1"[end]".E  D
 . I $G(PAD) S X="   "_X
 . I $G(ZERO) S TXT(J,0)=X
 . E  S TXT(J)=X
 . Q
 Q
 ;
T ;
1 ;;Updated PRF Assignment with the current data from this site.
 ;;This action will make all the recipients of the HL7 message to
 ;;update their assignment to exactly match the data in this message.
 ;;  Originating Facility:
 ;;  Updated By          :
 ;;  Date action taken   :
 ;;[end]
8 ;;Sorry, you are not authorized to run this Option.
 ;;[end]
10 ;;This option is designed to resynchronize a Flag Assignment which has
 ;;differing values at various VAMC facilities where the patient has
 ;;been registered.  The data on this system will be considered the
 ;;authorized source of that information for this flag assignment at
 ;;this time.
 ;;
 ;;Please make sure all the data associated with this Flag Assignment
 ;;is correct.  If not, make those corrections before running this
 ;;option for all flag assignment fields except for the OWNER SITE
 ;;field.
 ;;
 ;;If you are running this option because a previous CHANGE OF
 ;;OWNERSHIP action failed to properly update all facilities, then this
 ;;option will prompt you for the name of that facility which is to be
 ;;the OWNER SITE for this flag assignment.
 ;;[end]
26 ;;Record flag assignment currently in use, cannot be edited!
 ;;[end]
28 ;;Unable to retrieve the record flag assignment selected.
 ;;[end]
30 ;;Enter the reason for exercising this option.
 ;;Enter 'O' if a change of ownership was done but some HL7 update
 ;;  message failed resulting if various facilities having a different
 ;;  value for the OWNER SITE field for this assignment.
 ;;Enter 'U' for all other reasons.
 ;;[end]
36 ;;Your TREATING FACILITY LIST file does not show any other VAMC
 ;;facilities as having registered this patient.  Please use one of the
 ;;other Patient Record Flag options to correct the data for this flag
 ;;assignment.
 ;;[end]
41 ;;You have selected this Facility/Division as the OWNER SITE:
 ;;    
 ;;This assignment will now be refreshed/resent to all sites where
 ;;this patient has been registered.
 ;;[end]
46 ;;PRF Assignment update for change of ownership failed.
 ;;No HL7 update messages were sent to the other sites.
 ;;Creating a PRF Assignment History record of this action.
 ;;PRF Assignment History record was not filed successfully.
 ;;HL7 message sent...updating patient's sites of record.
 ;;HL7 message **NOT** sent updating patient's sites of record.
 ;;[end]
