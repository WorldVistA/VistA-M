TIUPFFIX ; SLC/JMH - Resolve Upload Filing Errors for PRF Notes ;7/29/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**184**;Jun 20, 1997
PFFIX ; PRF (Patient Record Flag) Note Filing Error Resolution Code - COPIED FROM TIUPNFIX
 N TIUFLDS,TIUBUF,SUCCESS,OLDTYPE,DFN,TITLDA,TIU
 S SUCCESS=0
 I '$D(^TIU(8925.1,+$G(TIUTYPE),0)) S SUCCESS="0^Document type is missing or invalid." G PFFIXX
 I '$D(^TIU(8925.4,+$G(TIUEVNT),0)) S SUCCESS="0^Upload Log event is missing or invalid." G PFFIXX
 S TIUBUF=$$BUFFER^TIUFIX2(TIUEVNT) I +TIUBUF'>0 S SUCCESS=TIUBUF G PFFIXX
 I '$D(TIUPRM0) D SETPARM^TIULE ; Sets TIUPRM0 with hdr signal, etc
 ; -- Load hdr data from buffer into array TIUFLDS:
 D LOADHDR^TIUFIX2(.TIUFLDS,TIUBUF,TIUPRM0,TIUTYPE)
 ; -- Get from user all data needed to create a new document
 ;    of the given type; Cross-check user data for consistency.
 S OLDTYPE=TIUTYPE
 D GETCHECK(.SUCCESS,.TIUTYPE,.TIUFLDS,.DFN,.TITLDA,.TIU)
 I 'SUCCESS G PFFIXX
 ; -- Create new document; file all TIUFLDS nodes which have
 ;    not been killed, execute post-file code, etc.:
 D MAKE^TIUFIX1(.SUCCESS,TIUEVNT,TIUBUF,.TIUTYPE,.TIUFLDS,.DFN,.TITLDA,.TIU,TIUPRM0)
 K ^TMP("TIUPRFUP",$J) ;in case MAKE didn't call post-file code
 ; -- If docmt filed successfully, set flag to stop - don't go
 ;    on and try to resolve error by editing buffer and refiling. 
PFFIXX I +SUCCESS S TIUDONE=1 Q
 W !!,"Filing error could not be resolved."
 I $P(SUCCESS,U,2)]"" W !,$P(SUCCESS,U,2)
 W !,"If you wish to try a different approach, edit the buffered data directly",!,"and refile it, or simply exit and try again later.",!
 Q
 ;
GETCHECK(SUCCESS,TIUTYPE,TIUFLDS,DFN,TITLDA,TIU) ; Get and
 ;check data
 ;
 ;Since a filing error occurred when filer could not locate
 ;or create a TIU document using data from buffer, we ask the
 ;user for all data needed to locate/create a document, and
 ;use that data, instead of the buffer data, to locate/create
 ;the document.
 ;Data are acquired from the user is such a way as to guarantee
 ;that all data necessary to go ahead and create a PRF Note
 ;are complete and consistent
 ;
 ; SUCCESS = 1 - Data are complete and consistent or
 ;         = 0^Explanatory msg
 ; TIUTYPE = Docmt Def whose methods are being invoked.  Users may
 ;           select titles of type TIUTYPE.  If not ALL titles of
 ;           type TIUTYPE should be selectable, screen them out
 ;            with BADTYPES.
 ; TIUFLDS     - array of fields to be filed later in FILE^TIUFIX1.
 ;               See warning in MAKE^TIUFIX1 concerning possible
 ;               need to kill nodes of TIUFLDS before calling MAKE.
 ; DFN, TITLDA, TIU - Patient, Document title, Demographics
 ;                    /visit array.
 ;                    Must be gotten from user and passed back.
 ;                    Used in GETRECNW to create docmt, in MERGTEXT
 ;                    to create components.
 K ^TMP("TIUPRFUP",$J)
 N DEFAULT,BADTYPES,ASK,TIURET
 ; -- Initialize SUCCESS to 0^Error msg:
 S SUCCESS="0^Patient, visit, and title are required."
 ; -- Get patient and visit, and title:
 S DFN=+$$PATIENT^TIULA Q:DFN'>0
 D ENPN^TIUVSIT(.TIU,+DFN,1)
 I '$D(TIU) Q
 I '$$CHEKPN^TIUCHLP(.TIU) K TIU Q
 ; -- Don't screen out titles (we are already permitting only PRF titles and we don't need to further screen them; don't ask about changing type:
 S BADTYPES="",ASK=0
 D GETTITLE^TIUFIX(.SUCCESS,TIUTYPE,.TIUFLDS,.TITLDA,BADTYPES,ASK)
 Q:TITLDA'>0
 S TIURET=$$SELECT^TIUPRF1(+TITLDA,DFN)
 I 'TIURET S SUCCESS="0^Patient Record Flag Action is Required." Q
 S ^TMP("TIUPRFUP",$J)=TIURET
 ; -- If consistent and complete, set SUCCESS=1: 
 S SUCCESS=1
GETX ;
 Q
