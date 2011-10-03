TIUFIX1 ; SLC/JER - Resolve Upload Filing Errors Library One ;05/06/2002
 ;;1.0;TEXT INTEGRATION UTILITIES;**131**;Jun 20, 1997
 ;
 ;MAKE is intended to be called by the filing error resolution
 ;code for various types of documents being uploaded into TIU.
 ;It is intended to be used in conjunction with a GETCHECK
 ;module written specifically for the particular type of
 ;document being uploaded. For examples of its use, see
 ;TIUPNFIX and TIUCNFIX.
 ;Since types of documents evolve and change, MAKE must be tested
 ;for each new type of document which uses it, and may require
 ;changes.
 ;MAKE takes a stub IEN or pt/visit/title info, locates or creates
 ;a TIU document, and attempts to complete the upload process
 ;for that document.
 ;                    **WARNING**
 ;MAKE calls FILE, which files ALL NODES of TIUFLDS which it
 ;receives. If data already exist for a given field, such filing
 ;OVERWRITES the existing value with a possibly erroneous,
 ;transcribed value. To prevent such overwriting of critical
 ;fields, MAKE kills certain nodes of TIUFLDS just before calling
 ;FILE. Nodes killed in MAKE include .01, .02, .07, and 1301,
 ;which were NOT previously killed when the header info was
 ;loaded into array TIUHDR. (LOADHDR^TIUFIX2 does NOT kill nodes,
 ;in contrast to LOADTIUX^TIUPEFIX.)
 ;Certain document types may NEED TO KILL ADDITIONAL NODES of
 ;TIUFLDS.  For example, if a document type uploads into an
 ;existing stub which already HAS a Requesting Package value,
 ;that document type should also kill node 1405 of TIUFLDS to
 ;ensure that the existing Requesting Package data is not
 ;overwritten with possibly erroneous, transcribed Requesting
 ;Package data. Such nodes of TIUFLDS can be killed
 ;before calling MAKE.
MAKE(SUCCESS,TIUEVNT,TIUBUF,TIUTYPE,TIUFLDS,DFN,TITLDA,TIU,TIUPRM0,TIUSTUB) ; File
 ;new TIU Document or use stub docmt
 ; SUCCESS = (by ref) Returns TIU DOCUMENT # (PTR to 8925) or
 ;         = 0^Explanatory message if no SUCCESS. Required.
 ; DFN     = Patient (#2). Required if no stub.
 ; TITLDA  = Pointer to TIU Document Definition (#8925.1). Required
 ;           if no stub.
 ; TIU     = Array of demographic and visit attributes. Required if
 ;           no stub.
 ; TIUEVNT = Record number (ien) of event in TIU Upload Log
 ;           file (#8925.4). Required.
 ; TIUTYPE = IEN of docmt def whose Filing Error Resolution Code
 ;           is being invoked. Required.
 ; TIUFLDS = Array of field data from upload buffer. Required.
 ;           MAKE kills certain nodes of TIUFLDS.  Additional
 ;           nodes may need to be killed before calling MAKE.
 ;           See warning, above.
 ; TIUPRM0 = String of upload params like hdr signal. See
 ;           SETPARM^TIULE. Required
 ; TIUSTUB = Valid Record number of stub document.  Required
 ;           if file is being uploaded into a stub
 ;           document.  MAKE assumes flds stuffed in
 ;           STUFREC^TIUPEFIX already exist in stub.  Assumes
 ;           stub is NOT an addendum.
 ;
 ; -- first, get TIU Document record:
 ;
 N TIUDA,LDT,NEWREC,TIUX,TIUTYP,TIUDPRM,TIUCLASS,TIUDTYP,TIUPOST
 N TIUDFLT,TIUREC,TITL1,TIUADD
 ; -- If no docmt type or Upload event, or target file
 ;    is not 8925, QUIT:
 I '$G(TIUTYPE)!'$G(TIUEVNT) S SUCCESS="0^Document type and Upload Log Event Required." Q
 I +$G(^TIU(8925.1,+TIUTYPE,1))'=8925 S SUCCESS="0^Target file not 8925." Q
 ; -- If stub IEN is not defined, create new record with user-
 ;    supplied pt/visit/title info (or return an existing docmt):
 I '$G(TIUSTUB) D  Q:$P($G(SUCCESS),U)=0
 . I $S($D(TIU)'>9:1,+$G(DFN)'>0:1,+$G(TITLDA)'>0:1,1:0) S SUCCESS="0^Invalid Patient, Visit, or Title." Q
 . S TITL1=1_U_TITLDA
 . D DOCPRM^TIULC1(TITLDA,.TIUDPRM)
 . ;    -- NOTE: If GETRECNW finds existing documents which have
 . ;       requesting packages (e.g. Consults), it ignores them
 . ;       and returns exclusively new documents.
 . S TIUDA=$$GETRECNW^TIUEDI3(DFN,.TIU,TITL1,.NEWREC,.TIUDPRM)
 . I +TIUDA'>0 S SUCCESS="0^Document could not be filed even though data appear complete and consistent."
 ; -- If stub IEN is defined, set docmt IEN = stub
 I $G(TIUSTUB) D  Q:$P($G(SUCCESS),U)=0
 . I $D(^TIU(8925,TIUSTUB,0)) S TIUDA=TIUSTUB Q
 . S SUCCESS="0^The stub document does not exist in TIU."
 ; -- Leave lock til later; check GUI - when does it lock? 4/21/02
 ; -- Lock Document:
 ;L +^TIU(8925,TIUDA):1
 ;E  S SUCCESS="0^Document is being edited by another user; please try again later." Q
 ; -- If docmt is not new (new docmts leave GETRECNW already
 ;    released) and is already released, create an addendum
 ;    (addm does its own stuffing, filing, ... post filing):
 I '$G(NEWREC),+$P(^TIU(8925,TIUDA,0),U,5)'<4 D  Q:$P($G(SUCCESS),U)=0  G MAKEX
 . D MAKEADD(.TIUADD,+TIUDA,TIUBUF,.TIUFLDS,TIUPRM0)
 . S SUCCESS=TIUADD
 . I SUCCESS S TIUDA=+TIUADD ;browse addm, not docmt
 S SUCCESS=1
 ; -- Stuff visit-related data:
 I '$G(TIUSTUB) D STUFREC^TIUPEFIX(TIUDA,$G(DFN),0,.TIU) ;0 parent
 ; -- Kill header array nodes that have already been filed
 ;    in GETRECNW^TIUEDI3 or STUFREC^TIUPEFIX and which mustn't
 ;    be overwritten with possibly erroneous, transcribed data:
 K TIUFLDS(.01),TIUFLDS(.02),TIUFLDS(.03),TIUFLDS(.05),TIUFLDS(.07)
 K TIUFLDS(.13),TIUFLDS(1205),TIUFLDS(1211),TIUFLDS(1301)
 ; -- File transcribed header fields (those not killed) in Document
 ;    and create missing field errors:
 D FILE(+TIUDA,.TIUFLDS,TITLDA)
 ; -- Load transcribed text into TIUX array and merge into TEMP array:
 D LOADTEXT(.TIUX,TIUBUF,TIUPRM0)
 K ^TIU(8925,+TIUDA,"TEMP")
 M ^TIU(8925,+TIUDA,"TEMP")=TIUX("TEXT")
 ; -- File text in Document:
 I '$D(TIU) D GETTIU^TIULD(.TIU,+TIUDA)
 D MERGTEXT^TIUEDI1(+TIUDA,.TIU)
 S TIUPOST=$$POSTFILE^TIULC1(TITLDA)
 S TIUREC("#")=TIUDA
 I TIUPOST]"" X TIUPOST
MAKEX D ALERTDEL^TIUPEVNT(+TIUBUF)
 D RESOLVE^TIUPEVNT(TIUEVNT,1)
 D BUFPURGE^TIUPUTC(+TIUBUF)
 K ^TIU(8925,+TIUDA,"TEMP") W "Done."
 ;L -^TIU(8925,TIUDA)
 I +$G(TIUDA),+$D(^TIU(8925,+$G(TIUDA),0)) D
 . N TIU D GETTIU^TIULD(.TIU,+TIUDA)
 . D EN^VALM("TIU BROWSE FOR MRT")
 Q
LOADTEXT(TIUARR,TIUBUF,TIUPRM0) ; Load array TIUARR with text
 N TIUI,TIUBGN,TIULINE
 S TIUBGN=$P(TIUPRM0,U,12)
 S TIUI=0 F  S TIUI=$O(^TIU(8925.2,+TIUBUF,"TEXT",TIUI)) Q:+TIUI'>0  D
 . S TIULINE=$G(^TIU(8925.2,+TIUBUF,"TEXT",TIUI,0))
 . I TIULINE[TIUBGN D
 . . N TIUJ S TIUJ=0
 . . F  D  Q:+TIUI'>0
 . . . S TIUI=$O(^TIU(8925.2,+TIUBUF,"TEXT",TIUI)) Q:+TIUI'>0
 . . . S TIUJ=TIUJ+1
 . . . S TIUARR("TEXT",TIUJ,0)=$G(^TIU(8925.2,+TIUBUF,"TEXT",TIUI,0))
 Q
MAKEADD(TIUDADD,TIUDA,TIUBUF,TIUFLDS,TIUPRM0) ; Create an addendum record
 ; [TIUDADD] - passed back = IEN of addm to docmt TIUDA
 N DIE,DR,DA,DIC,X,Y,DLAYGO,TIUATYP,TIUCAN,TIUFPRIV,TIU,TIUX S TIUFPRIV=1
 N TIUDTTL,TIUPOST,TIUREC
 S TIUDTTL=+$G(^TIU(8925,+TIUDA,0))
 S TIUATYP=+$$WHATITLE^TIUPUTU("ADDENDUM")
 S (DIC,DLAYGO)=8925,DIC(0)="L",X=""""_"`"_TIUATYP_""""
 D ^DIC
 S TIUDADD=+Y
 I +Y'>0 S TIUDADD="0^Could not create addendum." Q
 D GETTIU^TIULD(.TIU,TIUDA)
 S TIU("DOCTYP")=TIUATYP_U_$$PNAME^TIULC1(TIUATYP)
 D STUFREC^TIUPEFIX(TIUDADD,DFN,+TIUDA,.TIU)
 ; -- Kill header array nodes that have already been filed
        ;    when addm created or in STUFREC^TIUPEFIX, and which mustn't
        ;    be overwritten with possibly erroneous, transcribed data:
 K TIUFLDS(.01),TIUFLDS(.02),TIUFLDS(.07),TIUFLDS(1301)
 ; -- File header fields in addendum record:
 D FILE(+TIUDADD,.TIUFLDS,TIUATYP)
 ; -- Load text into TIUX array and merge into TEMP array:
 D LOADTEXT(.TIUX,TIUBUF,TIUPRM0)
 K ^TIU(8925,+TIUDADD,"TEMP")
 M ^TIU(8925,+TIUDADD,"TEMP")=TIUX("TEXT")
 ; -- File text in addendum record:
 D MERGTEXT^TIUEDI1(+TIUDADD,.TIU)
 S TIUPOST=$$POSTFILE^TIULC1(TIUDTTL)
 S TIUREC("#")=TIUDADD
 I TIUPOST]"" X TIUPOST
 Q
FILE(TIUDA,TIUFLDS,RTYPE) ; File header data; set missing field
 ;alerts for fields that fail to file
 ;   [TIUDA] - IEN of 8925 document
 ; [TIUFLDS] - array of header data from upload buffer record.
 ;             ALL nodes received by FILE will be filed.  See
 ;             warning for MAKE, concerning possible overwriting
 ;             of good data with faulty data.
 ;    [RTYPE] - Record type, i.e. IEN of 8925.1 title of docmt
 N FDA,FDARR,IENS,FLAGS,TIUMSG,MSG,REQMSG
 S IENS=""""_TIUDA_",""",FDARR="FDA(8925,"_IENS_")",FLAGS="KE"
 M @FDARR=TIUFLDS
 D FILE^DIE(FLAGS,"FDA","TIUMSG") ; File record
 I $D(TIUMSG)>9 D
 . D MAIN^TIUPEVNT(TIUBUF,2,"",$P($G(^TIU(8925.1,+RTYPE,0)),U),.FDA,.TIUMSG)
 Q
