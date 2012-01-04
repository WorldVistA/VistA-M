MAGGNTI2 ;WOIFO/GEK - Imaging interface to TIU. RPC Calls etc. ; 04 Apr 2002  2:37 PM
 ;;3.0;IMAGING;**46,59**;Nov 27, 2007;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.        |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging |
 ;; | Development Office of the Department of Veterans Affairs,  |
 ;; | telephone (301) 734-0100.          |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.      |
 ;; +---------------------------------------------------------------+
 ;;      
 Q
LIST(MAGRY,CLASS,MYLIST) ; RPC [MAG3 TIU LONG LIST OF TITLES]
 ; Get a list of Document Titles
 ; CLASS         = ("," delimited string of one or More of) "NOTE,DS,CONS,CP,SUR,<CLASS IEN>"
 ;                             CLASS IEN is any IEN of TIU 8925.1  that is a Class
 ;                "|" delimited string of Class| text | Direction
 ; MYLIST                = [1|""]   optional
 ;                               If MYLIST=1 then return
 ;                               TIU PERSONAL TITLE LIST       PERSLIST^TIUSRVD 
 ;                                       
 ; Note : sending CLASS IEN isn't used in p59.
 ; 
 K MAGRY
 ; was a Global, now leave it an Array, only getting 44
 N I,T,CL,CLN,CLNOTE,CLDS,CLCP,CLCONS,CLSUR,IL,J,TX,TXC,TX2,TX1,DFLT
 N INTXT,UPDN,TARR
 S MYLIST=$G(MYLIST)
 S INTXT=$P(CLASS,"|",2)
 S UPDN=$S(+$P(CLASS,"|",3):+$P(CLASS,"|",3),1:1)
 S CLASS=$P(CLASS,"|",1)
 I $L(CLASS)=0 S MAGRY(0)="0^Invalid Selection Class." Q
 S CLNOTE=3 ; It is hard coded in TIU code.  Note Class
 S CLDS=244 ; It is hard coded in TIU code.  Discharge Summary Class
 D CPCLASS^TIUCP(.CLCP)
 D CNSLCLAS^TIUSRVD(.CLCONS)
 D SURGCLAS^TIUSRVD(.CLSUR)
 S MAGRY(0)="0^Error: While accessing a list of Note Titles."
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
 . ; here add line as a break between Personal List and Start of Total List
 . K TARR
 . D BLDLIST(CLN,.TARR,INTXT,UPDN)
 . S J="" F  S J=$O(TARR(J)) Q:J=""  D
 . . S TX=$P(TARR(J),"^",2),TX2=$P(TX,"<",2) S:$L(TX2) TX=$P(TX,"<",1) S:$L(TX2) TX2="<"_TX2
 . . S TX1=$P(TARR(J),"^",1)
 . . S MAGRY($O(MAGRY(""),-1)+1)=TX_"^"_TX2_"^"_CL_"|"_TX1
 . . Q
 . Q
 I '$D(MAGRY(2)) K MAGRY(1) S MAGRY(0)="0^0 Items match input: "_INTXT
 E  S MAGRY(0)="1^Success"_"^"_$G(DFLT)_"^"
 Q
 ;
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
 D HASH^XUSHSHP
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
