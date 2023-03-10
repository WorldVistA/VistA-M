MAGGNTI2 ;WOIFO/GEK - Imaging interface to TIU. RPC Calls etc. ; OCT 12, 2020@10:02 AM
 ;;3.0;IMAGING;**46,59,282**;Nov 27, 2007;Build 18
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;      
 Q
 ; gek/9/23/2020  Modification to return only TIU TITLES that are 
 ;  exact Matches with the user input
 ;  Also, enable sending '[]' as place holder for space
 ;  this function will $TRanspose '[]'  into ' ' 
 ;  IA#2322 covers calls to TIU Routine TIULP
LIST(MAGRY,CLASS,MYLIST) ; RPC [MAG3 TIU LONG LIST OF TITLES]
 ; Get a list of Document Titles
 ; CLASS         = ("," delimited string of one or More of) "NOTE,DS,CONS,CP,SUR,<CLASS IEN>"
 ;                             CLASS IEN is any IEN of TIU 8925.1  that is a Class
 ;                "|" delimited string of Class| text | Direction
 ; 3.0.282         if 'text'   contains ';1'   i.e.  'text;1'
 ;                 then the result array will only contain exact
 ;                 matches to 'text'
 ; MYLIST                = [1|""]   optional
 ;                               If MYLIST=1 then return
 ;                               TIU PERSONAL TITLE LIST       PERSLIST^TIUSRVD 
 ;                                       
 ; Note : sending CLASS IEN isn't used in p282.
 ; 
 K MAGRY
 ; was a Global, now leave it an Array, only getting 44
 N I,T,CL,CLN,CLNOTE,CLDS,CLCP,CLCONS,CLSUR,IL,J,TX,TXC,TX2,TX1,DFLT
 N INTXT,UPDN,TARR,ALTLKP
 S MYLIST=$G(MYLIST)
 ; ALTLKP (MAG*3.0*282) determines if alternate lookups
 ; are used. If ALTLKP=1 perform the Exact Hit lookup.
 S ALTLKP=0
 S INTXT=$P(CLASS,"|",2)
 S INTXT=$TR(INTXT,"[]"," ")
 S ALTLKP=+$P(INTXT,";",2)
 S INTXT=$P(INTXT,";",1)
 S UPDN=$S(+$P(CLASS,"|",3):+$P(CLASS,"|",3),1:1)
 S CLASS=$P(CLASS,"|",1)
 I $L(CLASS)=0 S MAGRY(0)="0^Invalid Selection: CLASS." Q
 ;  get the IEN's for the CLASS's
 S CLNOTE=3 ; It is hard coded in TIU code.  Note Class
 S CLDS=244 ; It is hard coded in TIU code.  Discharge Summary Class
 D CPCLASS^TIUCP(.CLCP)
 D CNSLCLAS^TIUSRVD(.CLCONS)
 D SURGCLAS^TIUSRVD(.CLSUR)
 S MAGRY(0)="0^0 Items match Input: "_INTXT_" for Class: "_CLASS
 S MAGRY(1)="key word^TITLE^CLASS"
 S I=""
 F I=1:1:$L(CLASS,",") D
 . S CL=$P(CLASS,",",I)
 . S CLN=$S(+CL:+CL,CL="NOTE":3,CL="DS":CLDS,CL="CP":CLCP,CL="CONS":CLCONS,CL="SUR":CLSUR,1:-1)
 . I MYLIST D  Q
 . . D MYLIST(CLN,.TARR)
 . . I $O(TARR(""))'="" S MAGRY(0)="1^Personal List"
 . . S J="" F  S J=$O(TARR(J)) Q:J=""  D
 . . . S TX1=$P(TARR(J),"^",1)
 . . . ; output has 'd' or 'i' as first character, we need to get rid of it.
 . . . I $E(TX1)="d" S DFLT=$E(TX1,2,999),MAGRY(0)=DFLT_"^Personal list"
 . . . S TX1=$E(TX1,2,999)
 . . . S TX=$P(TARR(J),"^",2),TX2=$P(TX,"<",2) S:$L(TX2) TX=$P(TX,"<",1) S:$L(TX2) TX2="<"_TX2
 . . . S MAGRY($O(MAGRY(""),-1)+1)=TX_"^"_TX2_"^"_CL_"|"_TX1
 . . . Q
 . . Q
 . ; 
 . I ALTLKP=1 D EXACTHIT(.MAGRY,INTXT,CLN,CL) Q
 . K TARR
 . D BLDLIST(CLN,.TARR,INTXT,UPDN)
 . S J="" F  S J=$O(TARR(J)) Q:J=""  D
 . . S TX=$P(TARR(J),"^",2)
 . . S TX1=$P(TARR(J),"^",1)
 . . I $L(TX,"<")>1 S TX=$P(TX,"<",1)_"^<"_$P(TX,"<",2)
 . . E  S TX=TX_"  ^<"_TX_">"
 . . S MAGRY($O(MAGRY(""),-1)+1)=TX_"^"_CL_"|"_TX1
 . . Q
 . Q
 I '$D(MAGRY(2)) K MAGRY(1) Q
 E  S MAGRY(0)="1^Success"_"^"_$G(DFLT)_"^"
 Q
 ;
INACL(INTXT,CLID,CLNAME,CLIEN,DESC) ;
 ; Here we check to see if our IEN (CLIEN) is in the 
 ; ACL Index for the Class (CLID)
 ; DESC is passed by Reference and returned formatted.
 N FROM,I,DA,FOUND,DONE,TX,TX1,TX2
 S I=0
 S FROM=$E(INTXT,1,$L(INTXT)-1)
 S FOUND=0
 F  S FROM=$O(^TIU(8925.1,"ACL",CLID,FROM)) Q:FROM=""  D  Q:FOUND
 . S DA=0
 . F  S DA=$O(^TIU(8925.1,"ACL",CLID,FROM,DA)) Q:+DA'>0  D
 . . Q:DA'=CLIEN  ; we're only checking for IEN we sent.
 . . ;IA#2322  for CANENTR and ;IA#2322 for CANPICK
 . . I $S(+$$CANENTR^TIULP(DA)'>0:1,+$$CANPICK^TIULP(DA)'>0:1,1:0) Q
 . . ;We're here, so the CLIEN we were checking is good.
 . . S FOUND=1
 . . ; Reformat the Output
 . . S TX=FROM
 . . S TX1=DA
 . . I $L(TX,"<")>1 S TX=$P(TX,"<",1)_"^<"_$P(TX,"<",2)
 . . E  S TX=TX_"  ^<"_TX_">"
 . . S DESC=TX_"^"_CL_"|"_TX1
 . . Q
 Q FOUND
 ;
EXACTHIT(MAGRY,INTXT,CLID,CLNAME) ;
 ; We are here if INTXT is formatted   xxx;1  this tells us the caller
 ;  wants ONLY TIU TITLEs that Match the input xxx for the CLASS. 
 ; CLID is the ID of the CLASS of Title. 
 ;        i.e.  (NOTE,CONS,DS etc) that we are looking for.
 N IN29,TLST,IL,ECT,THIEN,FANY,MAGM,MCT,DESC
 N ISCONS
 ; Here we are looking into TIU DOCUMENT DEFINITION file for entries
 ;  starting with INTXT, and are Type = DOC  (DOC is a set, it converts to TITLE)
 ;  Search on first 29 Characters
 S IN29=$E(INTXT,1,29)
 D LKP^MAGGNLKP(.TLST,"8925.1^101^"_IN29_"^^I $P(^TIU(8925.1,Y,0),U,4)=""DOC""")
 I '$D(TLST(0)) Q
 S MCT=1,FANY=0
 S ECT=$P(TLST(0),"^",1) I ECT=0 Q
 S IL=0
 F  S IL=$O(TLST(IL)) Q:'IL  D  ;
 . ; check that the found entries, match the user input.
 . I $E($P(TLST(IL),"^",1),1,$L(INTXT))'=INTXT Q
 . S ISCONS=0
 . S THIEN=$P(TLST(IL),"^",2)
 . I CLNAME="NOTE" D  Q:ISCONS
 . . D ISCNSLT^TIUCNSLT(.ISCONS,THIEN)
 . . Q
 . S DESC=""
 . IF $$INACL(INTXT,CLID,CLNAME,THIEN,.DESC) D  ;
 . . S MCT=MCT+1,MAGM(MCT)=DESC,FANY=1
 . Q
 I 'FANY Q  ;
 S IL=0 F  S IL=$O(MAGM(IL)) Q:IL=""  D  ;
 . S MAGRY($O(MAGRY(""),-1)+1)=MAGM(IL)
 Q
MYLIST(CLN,TARR) ;
 ; if not short list, default is listed twice, (This is how CPRS displays it)
 K TARR
 D PERSLIST^TIUSRVD(.TARR,DUZ,CLN)
 Q
BLDLIST(CLN,TARR,STC,UPDN) ;
 ;
 S UPDN=$S(+$G(UPDN):+$G(UPDN),1:1)
 K TARR
 D LONGLIST^TIUSRVD(.TARR,CLN,STC,UPDN)
 Q
ADMNCLOS(MAGRY,MAGDFN,MAGTIUDA,MAGMODE) ; calls TIU API to set as Admin Closed.
 ; RPC Call to Administratively Close a TIU Note.  
 ; - - - Required - - - 
 ; MAGDFN    - Patient DFN
 ; MAGTIUDA  - Note IEN in File 8925
 ; - - - Optional - - - 
 ; MAGMODE   - "S" Scanned Document "M" - Manual closure  "E" - Electronically Filed.
 ;
 S MAGDFN=$G(MAGDFN),MAGTIUDA=$G(MAGTIUDA),MAGMODE=$G(MAGMODE,"S")
 I '$$VALDATA(.MAGRY,MAGDFN,MAGTIUDA) Q
 ; Calling TIU SET ADMINISTRATIVE CLOSURE
 ; MAGMODE can be "S" for SCANNED DOCUMENT  <- HIMS may get this changed
 ;                                            to Electronically Filed.
 ;             or "M" for MANUAL CLOSURE or "E" for ELECTONICALL FILE  
 D ADMNCLOS^TIUSRVPT(.MAGRY,MAGTIUDA,MAGMODE)
 ;   on success MAGRY  = MAGTIUDA
 ;   on error   MAGRY  = 0^<message>
 I MAGRY S MAGRY=MAGRY_"^Success: Administrative Closure."
 Q
VALES(X) ; Validate the esig
 N MAGY S MAGY=0
 D HASH^ROUTINE
 I X]"",(X=$P($G(^VA(200,+DUZ,20)),U,4)) S MAGY=1
 Q MAGY
VALDATA(RY,MAGDFN,MAGTIUDA) ; Validate the TIUDA and the DFN
 S MAGTIUDA=$G(MAGTIUDA),MAGDFN=$G(MAGDFN)
 I 'MAGDFN S RY="0^Invalid data: Patient DFN invalid: "_MAGDFN Q 0
 I '$D(^DPT(+MAGDFN,0)) S RY="0^Invalid data: Patient DFN invalid: "_MAGDFN Q 0
 I 'MAGTIUDA S RY="0^Invalid Note IEN: "_MAGTIUDA Q 0
 I '$D(^TIU(8925,MAGTIUDA,0)) S RY="0^Invalid Note IEN: "_MAGTIUDA Q 0
 I $P(^TIU(8925,MAGTIUDA,0),"^",2)'=MAGDFN S RY="0^Invalid Patient DFN: "_MAGDFN_" for Note: "_MAGTIUDA Q 0
 S RY="1^Validated OK."
 Q 1
