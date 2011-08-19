RMPREO24 ;HINES/ODJ ;suspense reports - Display all notes
 ;;3.0;PROSTHETICS;**55**;Feb 09, 1996
 ;
 ; ODJ - patch 55 - implement a display of all notes posted to an
 ;                  order in reverse chronological order
 ;                  (nois MIN-0900-41546)
 Q
 ;
 ; This subroutine implements patch 55 and is called from
 ; VIEW^RMPREO23 which is called when a user selects the
 ; View Request option [VR] on the Suspense Processing list
 ; manager screen.
 ;
 ; Inputs
 ; ------
 ;    RMPRIEN - ien of the order in ^RMPR(668
 ;
 ; Output
 ; ------
 ;    RMPREXC - "^" if key press indicates return to menu
 ;
VALL(RMPRIEN,RMPREXC) ;
 N RMPRS,RMPRA,RMPRROW,RMPRX,RMPRI,RMPRNTY,RMPRNDT,Y,RMPRDASH
 N RMPRLL,RMPRSUB,RMPRWP,RMPRCL,RMPRMINL,RMPRUSRI,RMPRUSRC
 S RMPREXC=""
 W @IOF,"Chronological list of notes posted to the request...",!!
 S RMPRCL=3
 S $P(RMPRDASH,"-",81)=""
 S RMPRMINL=5
 ;
 ; build an index RMPRX of notes by date and seq.
 S RMPRS=^RMPR(668,RMPRIEN,0)
 S RMPRNDT=$P(RMPRS,"^",9) ; Initial action date (type 3)
 S RMPRUSRI=$$GETUSR(RMPRIEN,16) ; User entering Init Action
 S RMPRX=1
 S:RMPRNDT'="" RMPRX(RMPRNDT,RMPRX)=3,RMPRX=RMPRX+1
 S RMPRNDT=$P(RMPRS,"^",5) ; Completion date (type 4)
 S:RMPRNDT'="" RMPRX(RMPRNDT,RMPRX)=4,RMPRX=RMPRX+1
 S RMPRUSRC=$$GETUSR(RMPRIEN,6) ; User entering Complete Action
 ;
 ; loop through all other notes (type 1)
 S RMPRI=0
 F  S RMPRI=$O(^RMPR(668,RMPRIEN,1,RMPRI)) Q:'+RMPRI  D
 . S RMPRS=^RMPR(668,RMPRIEN,1,RMPRI,0)
 . S RMPRNDT=$P(RMPRS,"^",1)
 . S RMPRX(RMPRNDT,RMPRX)="1^"_RMPRI,RMPRX=RMPRX+1
 . Q
 ;
 ; If haven't got any notes display message to inform user
 ; and get any key press, then quit
 I RMPRX=1 D  G VALLX
 . W "No notes have been posted to this request"
 . K DIR S DIR(0)="E" D ^DIR K DIR S:Y'=1 RMPREXC="^"
 . Q
 ;
 ; Now use index RMPRX built above to print out the notes
 S RMPRA=""
VALL1 S RMPRA=$O(RMPRX(RMPRA)) ;primary loop on note date
 I RMPRA="" G VALLEND
 S RMPRI=""
VALL2 S RMPRI=$O(RMPRX(RMPRA,RMPRI)) ;loop on seq. within date
 I RMPRI="" G VALL1 ;next note date
 S RMPRS=RMPRX(RMPRA,RMPRI)
 S RMPRNTY=$P(RMPRS,"^",1) ;get note type 1 Other, 3 Init Action
 ;                                        4 Complete
 S Y=RMPRA D DD^%DT S RMPRNDT=Y
 ;
 ; Print the note
 I RMPRNTY=1 D
 . S RMPRSUB=$P(RMPRS,"^",2) ;ien of sub-file
 . S RMPRLL=$O(^RMPR(668,RMPRIEN,1,RMPRSUB,1,":"),-1)
 . Q
 E  D
 . S RMPRLL=$O(^RMPR(668,RMPRIEN,RMPRNTY,1,":"),-1)
 . Q
 I RMPRCL>3,(IOSL-(RMPRLL+RMPRCL))<RMPRMINL D  G:RMPREXC="^" VALLX
 . K DIR S DIR(0)="E" D ^DIR K DIR I Y'=1 S RMPREXC="^" Q
 . S RMPRCL=1 W @IOF
 . Q
 W $S(RMPRNTY=3:"Initial Action Note",RMPRNTY=4:"Completion Note",1:"Other Action Note")," - ",RMPRNDT
 W $S(RMPRNTY=3:"   posted by "_RMPRUSRI,RMPRNTY=4:"   posted by "_RMPRUSRC,1:""),!!
 S RMPRCL=RMPRCL+2
 I RMPRNTY=1 D
 . S RMPRWP=0
 . F  S RMPRWP=$O(^RMPR(668,RMPRIEN,1,RMPRSUB,1,RMPRWP)) Q:'+RMPRWP  D
 .. W ^RMPR(668,RMPRIEN,1,RMPRSUB,1,RMPRWP,0),!
 .. S RMPRCL=RMPRCL+1
 .. Q
 . Q
 E  D
 . S RMPRWP=0
 . F  S RMPRWP=$O(^RMPR(668,RMPRIEN,RMPRNTY,RMPRWP)) Q:'+RMPRWP  D
 .. W ^RMPR(668,RMPRIEN,RMPRNTY,RMPRWP,0),!
 .. S RMPRCL=RMPRCL+1
 .. Q
 . Q
 W RMPRDASH,!
 S RMPRCL=RMPRCL+1
 G VALL2 ;next note seq.
VALLEND I RMPRCL'=1 D
 . K DIR S DIR(0)="E" D ^DIR K DIR S:Y'=1 RMPREXC="^"
 . Q
VALLX Q
 ;
 ; Get username from VA(200
GETUSR(RMPRIEN,RMPRFLD) ;
 N RMPROUP,RMPRIENS,RMPRUSR
 S RMPRUSR=""
 S RMPRIENS=RMPRIEN_","
 D GETS^DIQ(668,RMPRIENS,RMPRFLD,"","RMPROUP",)
 S:$D(RMPROUP) RMPRUSR=RMPROUP(668,RMPRIENS,RMPRFLD)
 Q RMPRUSR
