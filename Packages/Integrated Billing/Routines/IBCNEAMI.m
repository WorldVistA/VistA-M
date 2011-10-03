IBCNEAMI ;DAOU/ESG - IIV AUTO MATCH INPUT TRANSFORM ;06-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ITAM ; Input Transform Code for the .01 field - auto match value
 NEW MSG,MSGNUM,AMHIT,INSNAME
 I $L(X)>30 D ERRMSG("Response is too long.  30 characters maximum.") K X G ITAMX
 I $L(X)<3 D ERRMSG("Response is too short.  3 characters minimum.") K X G ITAMX
 I X["*",$L($TR(X,"*"))<4 D ERRMSG("Wildcarded entries must have at least 4 non-wildcard characters.") K X G ITAMX
 ;
 S X=$$UP^XLFSTR(X)      ; make it all uppercase
 S X=$$TRIM^XLFSTR(X)    ; strip leading & trailing spaces
 ;
 ; Translate multiple asterisks into a single asterisk
 I X["**" F  S X=$P(X,"**",1)_"*"_$P(X,"**",2,999) Q:X'["**"
 ;
 I $G(DIUTIL)="VERIFY FIELDS" G ITAMX
 ;
 I X["*" D
 . D ICH(X,1)   ; procedure builds a scratch global of hits
 . ;
 . ; check to see if no hits at all, display message, then quit
 . I '$D(^TMP($J,"IBCNEAME ICH")) D  Q
 .. S MSG(1)=" For your information, no insurance company names or synonyms passed"
 .. S MSG(2)=" a pattern match on '"_X_"'."
 .. S MSG(3)=""
 .. S MSG(1,"F")="!!"
 .. DO EN^DDIOL(.MSG)
 .. Q
 . ;
 . ; At this point, we know we got some hits
 . S MSG(1)=" For your information, the following insurance company names and"
 . S MSG(2)=" synonyms passed a pattern match on '"_X_"':"
 . S MSG(3)=""
 . S MSG(1,"F")="!!"
 . S AMHIT="",MSGNUM=3
 . F  S AMHIT=$O(^TMP($J,"IBCNEAME ICH",AMHIT)) Q:AMHIT=""  D
 .. ;
 .. ; If the $D at this level is either 1 or 11, then we want to
 .. ; display the data.  If the $D at this level is a 10, then we
 .. ; don't want to display this data at this time.
 .. ;
 .. I $D(^TMP($J,"IBCNEAME ICH",AMHIT))'=10 D
 ... S MSGNUM=MSGNUM+1
 ... S MSG(MSGNUM)="   "_AMHIT
 ... Q
 .. S INSNAME=""
 .. F  S INSNAME=$O(^TMP($J,"IBCNEAME ICH",AMHIT,INSNAME)) Q:INSNAME=""  D
 ... S MSGNUM=MSGNUM+1
 ... S MSG(MSGNUM)="   "_AMHIT_" (Synonym for "_INSNAME_")"
 ... Q
 .. Q
 . S MSGNUM=MSGNUM+1
 . S MSG(MSGNUM)=""    ; one more blank line on the screen
 . DO EN^DDIOL(.MSG)
 . KILL ^TMP($J,"IBCNEAME ICH")    ; clean up scratch global
 . Q
 ;
ITAMX ;
 Q
 ;
ITIC ; Input Transform Code for the .02 field - ins company name
 ; This field must be a valid, active insurance company name
 I $L(X)>30 D ERRMSG("Response is too long.  30 characters maximum.") K X G ITICX
 S X=$$UP^XLFSTR(X)
 S X=$$TRIM^XLFSTR(X)
 ;
 I $G(DIUTIL)="VERIFY FIELDS" G ITICX
 ;
 ; Call the IB insurance company lister function
 S X=$$DICINS^IBCNBU1(X,1,10)
 ;
 ; Make sure the user chose a valid insurance company name
 I X=0!(X=-1) D ERRMSG("You must choose a valid insurance company name.  Enter ?? for more info.") K X G ITICX
ITICX ;
 Q
 ;
ERRMSG(Z) ; Display an error message
 D EN^DDIOL(Z,"","!!")
ERRMSGX ;
 Q
 ;
ICH(AMV,ACTIVE) ; Insurance Company Hits
 ; This procedure will return a global array of insurance company
 ; names and synonyms that passed a pattern match of a given
 ; wildcarded auto-match entry.
 ;
 ; Input
 ;   AMV      auto match value with *'s
 ;   ACTIVE   0/1 flag indicating to screen for active insurance
 ;            companies (default is 0 - don't screen)
 ; Output
 ;   ^TMP($J,"IBCNEAME ICH",name) = ""
 ;   ^TMP($J,"IBCNEAME ICH",synonym,name) = ""
 ;
 NEW IBSUB,INSIEN,INSNAME,INSTXT,NOMATCH,SEED,STOP
 KILL ^TMP($J,"IBCNEAME ICH")
 I AMV'["*" G ICHX              ; no wildcard characters
 I $L($TR(AMV,"*"))<4 G ICHX    ; not enough non-wildcard characters
 S ACTIVE=$G(ACTIVE,0)          ; active/inactive flag - default 0
 ;
 ; build the NOMATCH check
 D AMC^IBCNEUT1("INSTXT",AMV,.NOMATCH,0)
 ;
 F IBSUB="B","C" D
 . S SEED=$P(AMV,"*",1),INSTXT=""
 . I SEED'="" S INSTXT=$O(^DIC(36,IBSUB,SEED),-1)
 . F  S INSTXT=$O(^DIC(36,IBSUB,INSTXT)) Q:INSTXT=""  Q:(SEED'=""&($E(INSTXT,1,$L(SEED))'=SEED))  D
 .. I @NOMATCH Q
 .. S (INSIEN,STOP)=0     ; loop thru ien's below
 .. F  S INSIEN=$O(^DIC(36,IBSUB,INSTXT,INSIEN)) Q:'INSIEN  D  Q:STOP
 ... I ACTIVE,$P($G(^DIC(36,INSIEN,0)),U,5) Q     ; inactive
 ... I ACTIVE,$P($G(^DIC(36,INSIEN,5)),U,1) Q     ; sched. for deletion
 ... S INSNAME=$P($G(^DIC(36,INSIEN,0)),U,1) Q:INSNAME=""
 ... ;
 ... ; If looping thru names, we can stop here
 ... I IBSUB="B" S ^TMP($J,"IBCNEAME ICH",INSTXT)="",STOP=1 Q
 ... ;
 ... ; Looping thru synonyms...keep going
 ... S ^TMP($J,"IBCNEAME ICH",INSTXT,INSNAME)=""
 ... Q
 .. Q
 . Q
ICHX ;
 Q
 ;
