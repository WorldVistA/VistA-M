XUSNPIE3 ;FO-OAKLAND/JLI - NATIONAL PROVIDER IDENTIFIER DATA CAPTURE ;4/8/08  18:18
 ;;8.0;KERNEL;**480**; July 10, 1995;Build 38
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ;
EDITNPI(IEN) ; main entry of NPI value
 ; IEN is the internal entry number in file 200 for the provider
 ;
 N DATEVAL,DESCRIP,DONE,NPIVAL1,NPIVAL2,PROVNAME,I,XX,X,Y,CURRNPI,XUSFLAG
 N ODATEVAL,OIEN,OLDNPI,XUSNONED,DIR,ADDNPI,DELETNPI,NOOLDNPI,XUSQI,NPIUSEDX,XUSRSLT
 S ADDNPI=1,DELETNPI=2,NOOLDNPI=0
 S PROVNAME=$$GET1^DIQ(200,IEN_",",.01)
 ;I $$ACTIVE^XUSER(IEN) W !,"This user isn't currently active" Q
 I $$GETTAXON^XUSNPIED(IEN,.DESCRIP)=-1 W !,"This user doesn't have a Taxonomy Code indicating a need for an NPI." S XUSNONED=1 ; but don't quit on that
 I $$NPISTATS^XUSNPIED(IEN)="D" S XUSNONED=1
 I $$NPISTATS^XUSNPIED(IEN)="E" W !,"This provider has been indicated as being EXEMPT from needing an NPI value.",!,"   Use Exempt option to remove it first" Q
 ; OLDNPI indicates what user wants to do with the current NPI
 ; OLDNPI=0 - User has no current NPI, or user asks to delete current NPI and it's valid
 ; OLDNPI=1 - User asked to Replace current NPI
 ; OLDNPI=2 - User asked to delete current NPI, and it was entered in error.
 ; OLDNPI="NOEDITNPI" - User doesn't want to change current NPI in any way.
 S OLDNPI=NOOLDNPI
 ; Initialize flag indicating that current NPI is in use
 S NPIUSEDX=0
 ; If user already has an NPI, ask them what they want to do with it.
 I $$NPISTATS^XUSNPIED(IEN)="D" D  Q:OLDNPI=NOOLDNPI  ; Quit if no NPI, or delete Valid NPI
 . N I,X,DIR
 . S CURRNPI=$$GET1^DIQ(200,IEN_",",41.99) I CURRNPI="" Q
 . S OIEN=$$SRCHNPI^XUSNPI("^VA(200,",IEN,CURRNPI)
 . I OIEN>0 S ODATEVAL=$P(OIEN,U,2),OIEN=$O(^VA(200,IEN,"NPISTATUS","C",CURRNPI,"A"),-1)
 . I '$D(ODATEVAL) S OLDNPI=2 ; can't find entry in multiple, delete entry at top
 . W !,"This provider already has an NPI value (",CURRNPI,") entered."
 . ; Check whether current NPI is already being used. If so, issue a warning.
 . S NPIUSEDX=$$CHKNPIU(CURRNPI,IEN,2,.XUSRSLT)
 . S DIR(0)="SO^D:Delete;R:Replace"
 . S DIR("A")="Do you want to (D)elete or (R)eplace this NPI value?"
 . S DIR("?")="Enter D or R, ^ to quit or <Enter> to continue without editing NPI"
 . S DIR("?",1)="If this NPI was entered for the incorrect individual, or is no longer valid"
 . S DIR("?",2)="for this individual, enter DELETE. Otherwise, the NPI can be Replaced."
 . S DIR("?",3)=""
 . D ^DIR K DIR
 . Q:$D(DTOUT)
 . ; If user enters null, set OLDNPI to "NOEDITNPI" to indicate no change to NPI
 . S:Y="" OLDNPI="NOEDITNPI"
 . I Y'="D",Y'="R" Q
 . I Y="R" S OLDNPI=ADDNPI Q
 . ; Process request to DELETE NPI.
 . S DIR(0)="S^V:VALID;E:ERROR",DIR("A",1)="Was the original NPI (V)alid for this provider",DIR("A")="or was it entered in (E)rror?",DIR("?")="Enter either V or E or ^ to quit with out editing"
 . S DIR("?",1)="If the NPI value was entered for the incorrect individual, respond E,",DIR("?",2)="otherwise enter V"
 . D ^DIR K DIR
 . Q:"EV"'[Y
 . ; Process DELETE NPI that was Valid for this provider
 . I Y="V" D   S OLDNPI=NOOLDNPI Q
 . . S Y=$$ADDNPI^XUSNPI("Individual_ID",IEN,CURRNPI,$$NOW^XLFDT(),0)
 . . W !,$S(Y>-1:"Entry has been marked inactive.",1:$P(Y,U,2)),!
 . . Q:+Y=-1
 . . N XUFDA
 . . S XUFDA(200,IEN_",",41.98)="@",XUFDA(200,IEN_",",41.99)="@"
 . . D FILE^DIE("","XUFDA") S Y=$$CHEKNPI^XUSNPIED(IEN)
 . . I NPIUSEDX D WARNING("D",PROVNAME,.XUSRSLT)
 . . Q
 . S OLDNPI=DELETNPI
 . Q
 ; If user doesn't want to edit current NPI, quit.
 Q:OLDNPI="NOEDITNPI"
 ; If user is not a provider, and has no NPI, let them know.
 I $$CHEKNPI^XUSNPIED(IEN)=0,OLDNPI=0 W !,"Need for an NPI value isn't indicated - but you can enter an NPI",$C(7)
 I IEN'=DUZ D
 . W !,"Provider: ",PROVNAME,"   ","XXX-XX-"_$E($$GET1^DIQ(200,IEN_",",9),6,9),"   DOB: "
 . S XX=$P($G(^VA(200,IEN,1)),U,3) S:XX'="" XX=$$DATE10^XUSNPIED(XX) W XX Q
 ; Initialize DONE to 0. It will be set to 1 if a new NPI is entered.
 S DONE=0
 ; Allow user to add a new or replacement NPI.
 I OLDNPI'=DELETNPI F  R !,"Enter NPI (10 digits): ",NPIVAL1:DTIME Q:'$T  Q:NPIVAL1=""  Q:NPIVAL1=U  D  Q:DONE
 . I NPIVAL1'?10N D  Q
 . . W !,$C(7),"Enter a 10 digit National Provider Identifier which is obtained ",!,"from 'https://nppes.cms.hhs.gov/NPPES/Welcome.do'"
 . . Q:$$PROD^XUPROD()  W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to generate a test NPI value" D ^DIR Q:'Y
 . . R !,"Enter a nine (9) digit number as the base: ",Y:DTIME Q:Y'?9N
 . . W !,"The complete NPI value is: ",Y_$$CKDIGIT^XUSNPI(Y),!
 . . Q
 . S NPIUSED=$$CHKNPIU(NPIVAL1,IEN,3)
 . ; Quit if error
 . Q:NPIUSED=1
 . ; If warning, see whether they want to continue
 . I NPIUSED=2 D  Q:Y'="Y"
 . . K DIR,Y,X
 . . S DIR(0)="SA^Y:yes;N:no",DIR("B")="N"
 . . S DIR("A")="Do you still want to add this NPI to Provider "_PROVNAME_"? "
 . . S DIR("?")="If you answer YES, make sure both the non-VA and VA Provider are the same person."
 . . S DIR("?",1)="A provider can serve as both a VA and a non-VA provider."
 . . S DIR("?",2)="That is the only case where the same NPI can be assigned to a person"
 . . S DIR("?",3)="in both the VA and the non-VA provider files."
 . . S DIR("?",4)=" "
 . . D ^DIR W !
 . . K DIR,X Q
 . R !,"Please re-enter NPI  : ",NPIVAL2:DTIME Q:'$T  I NPIVAL1'=NPIVAL2 W !,"Values do not match!" Q
 . S DONE=1
 . Q
 ; User asked to DELETE where NPI was entered in error.
 I OLDNPI=DELETNPI D
 . I $D(ODATEVAL) D  S Y=$$CHEKNPI^XUSNPIED(IEN) Q
 . . N DIR S DIR(0)="Y",DIR("A")="Confirm that you want to **DELETE** this incorrectly entered NPI",DIR("B")="NO" D ^DIR Q:'Y
 . . D DELETNPI^XUSNPIE2(IEN,OIEN,ODATEVAL)
 . . D CHKOLD1^XUSNPIE2(IEN) ; check for earlier value, and activate if present
 . . W !,"Entry was DELETED..."
 . . I NPIUSEDX D WARNING("D",PROVNAME,.XUSRSLT)
 . . Q
 . D DELETNPI^XUSNPIE2(IEN) ; clean up where no entry in multiple
 . W !,"Entry was DELETED..."
 . Q
 ; DONE will be set to 1 if a new or replacement NPI was entered by the user.
 I 'DONE Q
 ;N DIR S DIR("A")="Enter the date the provider was issued this number from CMS: ",DIR(0)="D^:"_$$NOW^XLFDT() D ^DIR Q:Y'>0  S DATEVAL=+Y
 S DATEVAL=$$NOW^XLFDT()
 ; mark previous NPI value as inactive
 I OLDNPI=ADDNPI S DONE=$$ADDNPI^XUSNPI("Individual_ID",IEN,CURRNPI,DATEVAL,0) ; set status to INACTIVE
 S DONE=$$ADDNPI^XUSNPI("Individual_ID",IEN,NPIVAL1,DATEVAL)
 I +DONE=-1 D  Q 
 . W !,"Problem writing that value into the database! --  It was **NOT** recorded."
 . W !,$P(DONE,U,2) Q
 W !!,"For provider ",PROVNAME," "_$S('$D(XUSNONED):"(who requires an NPI), ",1:"")_"the NPI ",NPIVAL1,!,"was saved to VistA successfully."
 ; If old NPI was in use by a non-VA provider, issue additional warning.
 I NPIUSEDX D WARNING("C",PROVNAME,.XUSRSLT,NPIVAL1)
 D EDRLNPI^XUSNPIED(IEN)
 Q
 ;
CHKNPIU(XUSNPI,XUSIEN,XUSFLAG,XUSRSLT) ; Return error or warning if current or new NPI is in use
 N XUSQI,NPIUSED,I
 S XUSQI=$$QI^XUSNPI(XUSNPI)
 K XUSRSLT
 S NPIUSED=$$NPIUSED^XUSNPI1(XUSNPI,"Individual_ID",XUSQI,XUSIEN,.XUSRSLT,XUSFLAG)
 ; Display error or warning
 I NPIUSED>0 D
 . W !!
 . F I=0:0 S I=$O(XUSRSLT(I)) Q:'I  D
 . . W XUSRSLT(I),!
 . . K XUSRSLT(I) Q
 . Q
 Q NPIUSED
 ;
WARNING(XUSTYPE,PROVNAME,XUSRSLT,XUSNNPI) ; If old NPI was in use by a non-VA provider, issue warning after REPLACE/DELETE
 ; XUSTYPE = Flag indicating whether NPI was Deleted or Changed
 ; PROVNAME = Name of provider whose NPI was changed/deleted
 ; XUSRSLT = text of warning message
 ; XUSNNPI = New NPI (if NPI was changed)
 N I,X
 ; If NPI was replaced, XUSNNPI contains the new NPI
 S XUSNNPI=+$G(XUSNNPI)
 ; Display the warning message
 W !!
 F I=0:0 S I=$O(XUSRSLT("X",I)) Q:'I  W XUSRSLT("X",I),!
 ; Insert values into the mail message text
 F I=0:0 S I=$O(XUSRSLT("XMSG",I)) Q:'I  S X=XUSRSLT("XMSG",I,0) I X[U D
 . I $G(XUSTYPE)="D" S X=$P(X,U)_"deleted"_$P(X,U,2)_$G(PROVNAME)_$P(X,U,3)
 . E  S X=$P(X,U)_"changed to "_XUSNNPI_$P(X,U,2)_$G(PROVNAME)_$P(X,U,3)
 . S XUSRSLT("XMSG",I,0)=X
 . Q
 ; Send the mail message
 D SNDMSG(DUZ,XUSTYPE,.XUSRSLT)
 Q
 ;
SNDMSG(XMDUZ,XUSTYPE,XUSRSLT) ;Sends msg when NPI is changed/deleted.
 ; XUSTYPE = flag indicating NPI was Deleted or Changed
 ; XUSRSLT = array containing the message text and the recipients
 N XMTEXT,XMSUB,XMMG,I,X
 S X=$S($G(XUSTYPE)="D":"deleted",1:"changed")
 S XMSUB="An NPI Number shared by a VA and Non-VA provider was "_X
 S XMTEXT="XUSRSLT(""XMSG"","
 F I=0:0 S I=$O(XUSRSLT("XRCPT",I)) Q:'I  S XMY(XUSRSLT("XRCPT",I))=""
 D ^XMD
 I $D(XMMG) W !,XMMG,!
 Q
 ;
 ;
