HLDIE ;CIOFO-O/LJA - Direct 772 & 773 Sets ; 08/05/2009 16:00
 ;;1.6;HEALTH LEVEL SEVEN;**109,122,142,145**;Oct 13,1995;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; Rules: if any of these rules is broken, FILE^DIE is called instead
 ;
 ;         * Can't edit files other than 772,773
 ;         * Don't pass IENS value with multiples IENs.  You can only
 ;             edit one IEN at a time!
 ;         * Only flag "S" is honored.  Flag "K" is ignored. Other
 ;             flags result in FILE^DIE being called.
 ;         * Can't edit ^HLMA(IEN,90) data.
 ;         * Can't edit ^HLMA(IEN,91) data.
 ;         * Can't edit ^HL(772,IEN,"IN") data (field #200, MESSAGE TEXT)
 ;         * No checking of data performed!  (Data format MUST be OK.)
 ;         * No locking of records in files 772 or 773. (Locks on queues.)
 ;
FILE(FLAGS,ROOT,ERR,SUB,RTN) ; FILE^DIE functional equivalent...
 ; This call has similar parameters to FILE^DIE, but changes data
 ; using hard sets.  The first two parameters of this API are the
 ; same as FILE^DIE.  So, if any file other than 772 or 773 is being
 ; edited, this API just passes on the FLAGS,ROOT,ERR parameters to
 ; FILE^DIE and quits.  If file 772 or 773 is being edited, the hard
 ; set code in HLDIE772 and HLDIE773 is called. 
 ;
 N DEBUG,FILE,HLEDITOR,LERR,IEN,X,XECMCODE
 ;
 S DT=$$NOW^XLFDT\1
 ;
 D BEGIN ; Debug call at beginning or process
 ;
 ; Check FILE, IEN, FIELDs passed, etc...
 I '$$CHECKS D  QUIT  ;->
 .
 .  S HLEDITOR="FILE^DIE"
 .
 .  ; Call FILEMAN...
 .  D FILE^DIE($G(FLAGS),$G(ROOT),$G(ERR))
 .
 .  ; Debug call made even with Fileman...
 .  D END
 ;
 S HLEDITOR="FILE^HLDIE"
 ;
 ; If this point is reached, file 772 or 773 is being edited, data
 ; in ROOT() has been checked, and data is being hard set...
 ;
 ;
 ; Make sure ERR is defined...
 I $G(ERR)']"" N HLERR S ERR="HLERR"
 ;
 ; All editing occurs in this call...
 D EDITALL(.ROOT,FILE,IEN)
 ;
 ; Store debug data if XTMP debug string set...
 D END
 ;
 ;check if ROOT needs to be retained
 I FLAGS'["S" K @ROOT,FLAGS
 ;
 Q
 ;
EDITALL(ROOT,FILE,IEN) ; Edit 772 or 773 by direct sets...
 ;
 ; FILE,IEN -- optional (parsed from ROOT())
 ;
 N ERRNO,FIELD,GBL,NODE,ROUTINE,TAG,VALUE,XRF
 ;
 S GBL=$$GBL(FILE,+IEN)
 ;
 ;check if .01="@" for deletion of record...
 I $G(@ROOT@(FILE,IEN,.01))="@" D  Q
 .I FILE=773 D DEL773^HLUOPT3(+IEN) Q
 .I FILE=772 D DEL772^HLUOPT3(+IEN)
 ;
 ; patch HL*1.6*122: MPI-client/server
 ; If no data in record passed in, log an error and quit...
 ; I '$D(@GBL) D  Q  ; Remember.  GBL contains IEN...
 N HLDGBL
 F  L +@GBL:10 Q:$T  H 1
 ; patch HL*1.6*142: MPI-client/server start
 N COUNT
 F COUNT=1:1:15 Q:$D(@GBL)  H COUNT
 ; patch HL*1.6*142: MPI-client/server end
 S HLDGBL=$D(@GBL)
 L -@GBL
 I 'HLDGBL D  Q  ; Remember.  GBL contains IEN...
 .  S ERRNO=$$ERRNO(601,"The entry does not exist.",FILE,2)
 .  S @ERR@("DIERR",+ERRNO,"PARAM","IENS")=IEN_$S(IEN'[",":",",1:"")
 ;
 ;
 ; What routine holds the file-specific field/xref set code?
 S ROUTINE=$S(FILE=772:"HLDIE772",FILE=773:"HLDIE773",1:"")
 ;
 ; Load NODEs...
 D GETNODES(FILE,+IEN,.NODE)
 ;
 ; When a field is edited, the NODE(1) is changed
 ;
 ; Edit NODE(1), adding new values, and set XRF(XREF) nodes...
 S FIELD=0
 F  S FIELD=$O(@ROOT@(FILE,IEN,FIELD)) Q:FIELD'>0  D
 .  ; VALUE = value passed in by process that is to be stored in file
 .  S VALUE=$G(@ROOT@(FILE,IEN,FIELD))
 .
 .  ; If field should be deleted, VALUE will equal @...
 .  I VALUE="@" S VALUE=""
 .
 .  ; Get and check tag...
 .  S TAG="F"_(FILE-770)_$TR(FIELD,".","")_U_ROUTINE
 .  S TAG(1)=$T(@TAG) I TAG(1)']"" D  QUIT  ;->
 .  .  S ERRNO=$$ERRNO(501,"No set logic for file #"_FILE_"'s field# "_FIELD,FILE,3)
 .  .  S @ERR@("DIERR",+ERRNO,"PARAM",1)=FIELD
 .  .  S @ERR@("DIERR",+ERRNO,"PARAM","FIELD")=FIELD
 .
 .  ; Call the subroutine below that is for the specific field...
 .  ; (No editing of xrefs or global data occurs in these calls.)
 .  D @("F"_(FILE-770)_$TR(FIELD,".","")_U_ROUTINE)
 ;
 ; If no data actually changed, quit...
 QUIT:'$D(NODE("CHG"))  ;->
 ;
 ; patch HL*1.6*142 start: MPI-client/server
 ; Store changes in the global now...
 D STORE(FILE,IEN,.NODE)
 ;
 ; patch HL*1.6*122: MPI-client/server
 I FILE=773 D
 . F  L +^HLMA(+IEN):10 Q:$T  H 1
 E  D
 . F  L +^HL(772,+IEN):10 Q:$T  H 1
 ;
 ; Set xrefs to correspond to the just-stored data...
 S XRF=""
 F  S XRF=$O(XRF(XRF)) Q:XRF']""  D
 .  D @("XRF"_XRF_U_ROUTINE)
 .  ; create x-ref: ^HLMA("AH-NEW")
 .  ; it is also defined in DD of field #2 (messsage ID)
 .  I (FILE=773),(XRF="AH") D
 ..  ; patch HL*1.6*145
 ..  ; N HDR,FLD
 ..  N HDR,FLD,COUNT,AH
 ..  ; the following code not work for all, such as outgoing msg
 ..  ; F COUNT=1:1:15 Q:$D(^HLMA(+IEN,"MSH",1,0))  H COUNT
 ..  ; patch HL*1.6*145 end
 ..  S HDR=$G(^HLMA(+IEN,"MSH",1,0))
 ..  Q:HDR']""
 ..  S HDR(2)=$G(^HLMA(+IEN,"MSH",2,0))
 ..  S:HDR(2)]"" HDR=HDR_HDR(2)
 ..  S FLD=$E(HDR,4)
 ..  Q:FLD']""
 ..  S HDR=$P(HDR,FLD,3,6)
 ..  I HDR]"" D
 ...  ; patch HL*1.6*145
 ...  ; S ^HLMA("AH-NEW",HDR,+$P($G(^HLMA(+IEN,0)),"^",2),+IEN)=""
 ...  ; the following code not work for all, such as outgoing msg
 ...  ; F COUNT=1:1:15 Q:($P($G(^HLMA(+IEN,0)),"^",2)]"")  H COUNT
 ...  S AH=$P($G(^HLMA(+IEN,0)),"^",2)
 ...  I AH]"" D
 ....  S ^HLMA("AH-NEW",HDR,AH,+IEN)=""
 ....  S HL("HDR FLDS:3-6")=HDR
 ...  ; patch HL*1.6*145 end
 ;
 ; patch HL*1.6*122: MPI-client/server
 I FILE=773 L -^HLMA(+IEN)
 E  L -^HL(772,+IEN)
 ; patch HL*1.6*142 end
 ;
 Q
 ;
GETNODES(FILE,IEN,NODE) ; Load pre-change data for each node in 
 ; NODE(node,0), and load node to be changed in NODE(node,1).
 ; GBL -- req
 ;
 ; patch HL*1.6*142 start: MPI-client/server 
 F  L +@GBL:10 Q:$T  H 1
 F NODE=0,1,2,"P","S" D
 .  ; After setting, NODE(NODE,0) will equal each other.
 .  ; However, after each edited field is processed, the pieces of
 .  ; data in NODE(NODE,1) will be changed.  The pre and post nodes
 .  ; then are of comparison value.
 .  S NODE(NODE,0)=$G(@GBL@(NODE)) ; Pre-change node
 .  ;
 .  ; for MPI-client/server environment:
 .  ; if it is going to update field #773,3 (Transmission type)
 .  ; field #773,2 (message ID) should be existed, otherwise,
 .  ; wait until it is available on this client node
 .  I FILE=773,$D(@ROOT@(3)),$P(NODE(NODE,0),"^",2)']"" D
 ..  N COUNT
 ..  F COUNT=1:1:15 Q:($P(NODE(NODE,0),"^",2)]"")  D  H COUNT
 ...  S NODE(NODE,0)=$G(@GBL@(NODE))
 .  S NODE(NODE,1)=NODE(NODE,0) ; Node that is changed
 L -@GBL
 ; patch HL*1.6*142 end 
 Q
 ;
STORE(FILE,IEN,NODE) ; Store changes in file...
 N DATA,ND
 ;
 ; Loop thru change nodes, get changed data, and store it...
 S ND=""
 F  S ND=$O(NODE("CHG",ND)) Q:ND']""  D
 .  S DATA=$G(NODE(ND,1))
 .  ; Even if no data no node, store it.  (Will be removed by purge.)
 .  ;
 .  ; patch HL*1.6*142: MPI-client/server start
 .  ; I FILE=772 S ^HL(772,+IEN,ND)=DATA
 .  I FILE=772 D
 ..  F  L +^HL(772,+IEN,ND):10 Q:$T  H 1
 ..  S ^HL(772,+IEN,ND)=DATA
 ..  L -^HL(772,+IEN,ND)
 .  ; I FILE=773 S ^HLMA(+IEN,ND)=DATA
 .  I FILE=773 D
 ..  F  L +^HLMA(+IEN,ND):10 Q:$T  H 1
 ..  S ^HLMA(+IEN,ND)=DATA
 ..  L -^HLMA(+IEN,ND)
 .  ; patch HL*1.6*142: MPI-client/server end
 ;
 QUIT
 ;
GBL(FILE,IEN) QUIT $S(FILE=772:"^HL(772,"_+IEN_")",1:"^HLMA("_+IEN_")")
 ;
CHKFLD(FILE,FIELD) ; Does passed-in field exist?
 ; Returns -- @ERR@(...) ->
 ;
 ; Quit if field exists...
 QUIT:$D(^DD(+FILE,+FIELD)) 1 ;->
 ;
 ; Field doesn't exist.  Log error...
 S ERRNO=$$ERRNO(501,"File #"_FILE_" does not contain a field "_FIELD_".",FILE,3)
 S @ERR@("DIERR",+ERRNO,"PARAM",1)=FIELD
 S @ERR@("DIERR",+ERRNO,"PARAM","FIELD")=FIELD
 ;
 Q ""
 ;
ERRNO(NUM,TXT,FILE,PNO) ; Return next ERROR number and create general data...
 N NO
 S NO=$G(@ERR@("DIERR"))+1,@ERR@("DIERR")=+NO_U_+NO
 S @ERR@("DIERR",NO)=NUM
 S @ERR@("DIERR",NO,"PARAM",0)=PNO
 S @ERR@("DIERR",NO,"PARAM","FILE")=FILE
 S @ERR@("DIERR",NO,"TEXT",1)=TXT
 S @ERR@("DIERR","E",NUM,NO)=""
 Q NO
 ;
GENLERR(ETXT) ; Store GENERAL (and fatal) error...
 ; ERR -- req
 N NO
 S NO=$G(@ERR@("DIERR"))+1,@ERR@("DIERR")=+NO_U_+NO
 S @ERR@("DIERR",NO)=999_U_ETXT ; Made up error number
 Q
 ;
CHECKS() ; Check ROOT() for file and validity of data...
 ; FLAGS, ROOT() -- req --> FILE,IEN
 N I,OK,FIELD
 ;
 ;check the file & ien
 S FILE=$O(@ROOT@(0))
 I FILE'=772,FILE'=773 D  QUIT "" ;->
 .  S IEN=$S(FILE:$O(@ROOT@(FILE,0)),1:0) ; Set for debugging
 ;
 ; ;shouldn't be more than 1 file!
 QUIT:$O(@ROOT@(FILE)) "" ;->
 ;
 ;check the ien structure, and that only ien passed...
 S IEN=$O(@ROOT@(FILE,0))
 ; Structure check...
 QUIT:$P(IEN,",")'=+IEN_"," "" ;->
 ; Is it numeric?
 QUIT:'(+IEN) "" ;->
 ; Has more than one IEN been passed?
 QUIT:($O(@ROOT@(FILE,IEN))'="") "" ;->
 ;
 ;check the flags.  Only K and S flags allowed...
 I $L(FLAGS) D  QUIT:'OK "" ;->
 .  S OK=1
 .  F I=0:1:$L(FLAGS) I $E(FLAGS,I)'="K",$E(FLAGS,I)'="S" S OK=0
 ;
 ; Check for existence of FIELD in FILE's DD & if an excluded field.
 ; (See rules for fields which cannot be updated by FILE^HLDIE.)
 S FIELD=0,OK=1
 F  S FIELD=$O(@ROOT@(FILE,IEN,FIELD)) Q:FIELD=""  D  Q:'OK
 .  I '$$CHKFLD(FILE,FIELD) S OK=0 Q
 .  I FILE=773,FIELD\1=90 S OK=0 Q
 .  I FILE=773,FIELD\1=91 S OK=0 Q
 .  I FILE=772,FIELD=200 S OK=0 Q
 ;
 ; If not OK to use FILE^HLDIE, skip any further testing...
 QUIT:'OK "" ;->
 ;
 ;                    *** WARNING ***
 ; The following check **MUST** be removed after FILE^HLDIE is working.
 ;
 ; Final check for whether FILE^HLDIE should be used...
 I $G(^XTMP("HLDIE-DEBUG","CALL"))]"" QUIT "" ;->
 ; If this node exists and follows null, FILE^DIE will be used.
 ; Otherwise, execution defaults to using FILE^HLDIE.
 ;
 Q OK
 ;
BEGIN ; Always call here before any ^HLDIE or ^DIE calls...
 D DEBUG(1)
 Q
 ;
END ; Always call here after all ^HLDIE or ^DIE actions...
 D DEBUG(2)
 Q
 ;
DEBUG(LOC) ; Debug presets and setup...
 ; Most variables created here should be left around.  These variables
 ; are newed above.
 N STORE
 ;
 S RTN=$G(RTN),SUB=$G(SUB)
 ;
 ; First-time (beginning) call setups...
 I LOC=1 D
 .  S RTN=$S(RTN]"":RTN,1:"HLDIE")_"~"_$S(RTN="HLDIE":"FILE",1:SUB)
 .  S DEBUG=$G(^XTMP("HLDIE-DEBUG","STATUS"))
 .  S XECMCODE=$P(DEBUG,U,3)
 ; DEBUG is always called at beginning (LOC=1) and end (LOC=2) or
 ; FILE^HLDIE.  So, set up variables only once, at beginning...
 ;
 ; Setup that is individual to each (1 or 2) call...
 S STORE=$P(DEBUG,U,LOC),STORE=$S(STORE=1:1,STORE=2:2,1:"")
 ; Some, All, or no data stored?
 ;
 ; If no STORE instructions, and no M code to specify STORE, quit...
 QUIT:'STORE&($G(XECMCODE)'=1)  ;->
 ;
 ; Call DEBUG to STORE data...
 D DEBUG^HLDIEDBG(RTN,LOC,STORE,XECMCODE)
 ;
 Q
 ;
EOR ;HLDIE - Direct 772 & 773 Sets ; 11/18/2003 11:17
