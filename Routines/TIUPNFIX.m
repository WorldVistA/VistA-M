TIUPNFIX ; SLC/MAM - Resolve Upload Filing Errors for Progress Notes ;05/06/02
 ;;1.0;TEXT INTEGRATION UTILITIES;**131**;Jun 20, 1997
PNFIX ; Progress Note Filing Error Resolution Code
 ; Requires: TIUEVNT - 8925.4 Upload Log Event IEN
 ; Requires: TIUTYPE - IEN of Docmt Def whose Filing Error
 ;                     Resolution Code is being invoked.
 ;                     Taken from alert or filing error.
 ;                     
 ; NOTE: Module PNFIX is written as Filing Error Resolution Code
 ;for uploading Progress Notes into TIU, replacing the old Filing
 ;Error Resolution Code, GETPN^TIUCHLP.
 ;It has been rewritten to take advantage of new generic upload
 ;modules such as MAKE^TIUFIX1.  In its use of these new modules,
 ;it may serve as a model for uploading other types of documents
 ;such as Consults or Operative Reports into TIU. See also TIUCNFIX.
 ;All code which is specific to Progress Notes is included
 ;in module GETCHECK, before MAKE^TIUFIX1 is called.
 N TIUFLDS,TIUBUF,SUCCESS,OLDTYPE,DFN,TITLDA,TIU
 S SUCCESS=0
 I '$D(^TIU(8925.1,+$G(TIUTYPE),0)) S SUCCESS="0^Document type is missing or invalid." G PNFIXX
 I '$D(^TIU(8925.4,+$G(TIUEVNT),0)) S SUCCESS="0^Upload Log event is missing or invalid." G PNFIXX
 S TIUBUF=$$BUFFER^TIUFIX2(TIUEVNT) I +TIUBUF'>0 S SUCCESS=TIUBUF G PNFIXX
 I '$D(TIUPRM0) D SETPARM^TIULE ; Sets TIUPRM0 with hdr signal, etc
 ; -- Load hdr data from buffer into array TIUFLDS:
 D LOADHDR^TIUFIX2(.TIUFLDS,TIUBUF,TIUPRM0,TIUTYPE)
 ; -- Get from user all data needed to create a new document
 ;    of the given type; Cross-check user data for consistency.
 S OLDTYPE=TIUTYPE
 D GETCHECK(.SUCCESS,.TIUTYPE,.TIUFLDS,.DFN,.TITLDA,.TIU)
 I 'SUCCESS G PNFIXX
 ; -- Create new document; file all TIUFLDS nodes which have
 ;    not been killed, execute post-file code, etc.:
 D MAKE^TIUFIX1(.SUCCESS,TIUEVNT,TIUBUF,.TIUTYPE,.TIUFLDS,.DFN,.TITLDA,.TIU,TIUPRM0)
 ; -- If docmt filed successfully, set flag to stop - don't go
 ;    on and try to resolve error by editing buffer and refiling. 
PNFIXX I +SUCCESS S TIUDONE=1 Q
 W !!,"Filing error could not be resolved."
 I $P(SUCCESS,U,2)]"" W !,$P(SUCCESS,U,2)
 W !,"If you wish to try a different approach, edit the buffered data directly",!,"and refile it, or simply exit and try again later.",!
 Q
 ;
GETCHECK(SUCCESS,TIUTYPE,TIUFLDS,DFN,TITLDA,TIU) ; Get and
 ;check data
 ;
 ;This is written for Progress Notes (PN), but may also serve
 ;as a model for the use of new generic modules such as
 ;MAKE^TIUFIX1 in uploading other types of documents such
 ;as Consults or Operative Reports. See also TIUCNFIX.
 ;The new generic modules accommodate only documents which
 ;are uploaded into the TIU DOCUMENT file.
 ;
 ;Since a filing error occurred when filer could not locate
 ;or create a TIU document using data from buffer, we ask the
 ;user for all data needed to locate/create a document, and
 ;use that data, instead of the buffer data, to locate/create
 ;the document.
 ;Data are acquired from the user is such a way as to guarantee
 ;that all data necessary to go ahead and create a Progress Note
 ;are complete and consistent
 ;
 ; SUCCESS = 1 - Data are complete and consistent or
 ;         = 0^Explanatory msg
 ; TIUTYPE = Docmt Def whose methods are being invoked.
 ; TIUFLDS     - array of fields to be filed later in FILE^TIUFIX1.
 ;               See warning in MAKE^TIUFIX1 concerning possible
 ;               need to kill nodes of TIUFLDS before calling MAKE.
 ; DFN, TITLDA, TIU - Patient, Document title, Demographics
 ;                    /visit array.
 ;                    Must be gotten from user and passed back.
 ;                    Used in GETRECNW to create docmt, in MERGTEXT
 ;                    to create components.
 N DEFAULT,BADTYPES,ASK
 ; -- Initialize SUCCESS to 0^Error msg:
 S SUCCESS="0^Patient, visit, and title are required."
 ; -- Get patient and visit, and title:
 S DFN=+$$PATIENT^TIULA Q:DFN'>0
 D ENPN^TIUVSIT(.TIU,+DFN,1)
 I '$D(TIU) Q
 ; -- TIU*1*131 - cf GETPN^TIUCHLP: Before 131, if user
 ;    up-arrowed at OK?, code continued.
 I '$$CHEKPN^TIUCHLP(.TIU) K TIU Q
 ; -- Screen out consult titles; don't ask about changing type:
 S BADTYPES=+$$CLASS^TIUCNSLT,ASK=0
 D GETTITLE^TIUFIX(.SUCCESS,TIUTYPE,.TIUFLDS,.TITLDA,BADTYPES,ASK)
 Q:TITLDA'>0
 ; -- If consistent and complete, set SUCCESS=1: 
 S SUCCESS=1
GETX ;
 Q
