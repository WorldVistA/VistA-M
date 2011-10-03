MAGGSFLT ;WOIFO/GEK/SG - Image list Filters utilities ; 3/9/09 12:51pm
 ;;3.0;IMAGING;**7,8,93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
DEL(MAGRY,FLTIEN) ;RPC [MAG4 FILTER DELETE] DELETE A FILTER
 N DIK,DA
 S DIK="^MAG(2005.87,"
 S DA=FLTIEN
 D ^DIK
 D CLEAN^DILF
 S MAGRY="1^Deleted"
 Q
 ;
GETLIST(MAGRY,USER,GETALL) ;RPC [MAG4 FILTER GET LIST] Return a list of filters for a USER
 ; user = DUZ
 ; if user = "" send list of public filters
 ; if user > 0 and GETALL = 1 then send User Private and Public filters.
 N I,MAGADMIN,MAGCLIN
 K ^TMP($J,"MAGGSFLT","RES")
 S USER=$G(USER)
 S MAGRY(0)="0^Retrieving Filter list..."
 ; we'll get public if getall or no user
 D CLSKEYS(.MAGADMIN,.MAGCLIN)
 I $G(GETALL)!('USER) D
 . S I=""
 . F  S I=$O(^MAG(2005.87,"D",1,I)) Q:I=""  D
 . . I '$$HASKEY(I) Q  ; HERE HAVE TO USE DUZ, TO FILTER THE FILTERS BASED ON MAGDISP CLIN AND MAGDISP ADMIN
 . . S ^TMP($J,"MAGGSFLT","RES",$P(^MAG(2005.87,I,0),"^",1)_"-"_I)=I_"^"_$P(^MAG(2005.87,I,0),"^",1)_"^"_$P(^MAG(2005.87,I,1),"^")
 . . ;S MAGRY($O(MAGRY(""),-1)+1)=I_"^"_$P(^MAG(2005.87,I,0),"^",1)_"^"_$P(^MAG(2005.87,I,1),"^")
 . . Q
 I USER D
 . S I=""
 . F  S I=$O(^MAG(2005.87,"C",USER,I)) Q:I=""  D
 . . I '$$HASKEY(I) Q
 . . S ^TMP($J,"MAGGSFLT","RES",$P(^MAG(2005.87,I,0),"^",1)_"-"_I)=I_"^"_$P(^MAG(2005.87,I,0),"^",1)_"^"_$P(^MAG(2005.87,I,1),"^")
 . . ;S MAGRY($O(MAGRY(""),-1)+1)=I_"^"_$P(^MAG(2005.87,I,0),"^",1)_"^"_$P(^MAG(2005.87,I,1),"^")
 . . Q
 ;S MAGRY(0)=$S($G(MAGRY(1)):$O(MAGRY(""),-1),1:"0^ERROR Retrieving Filter list.")
 S MAGRY(0)=$S($D(^TMP($J,"MAGGSFLT","RES")):1,1:"0^ERROR Retrieving Filter list.")
 I MAGRY(0) D
 . ; we have a list of filters, send the default as Piece 1 in 0 node.
 . S $P(MAGRY(0),"^",1)=$$DFTFLT(USER)
 S I=""
 F  S I=$O(^TMP($J,"MAGGSFLT","RES",I),-1) Q:I=""  D
 . S MAGRY($O(MAGRY(""),-1)+1)=^TMP($J,"MAGGSFLT","RES",I)
 Q
 ;
HASKEY(IEN) ; True or False, Does user have Correct Key(s)(ADMIN and/or CLIN) to view this filter.
 N CLS
 S CLS=$P(^MAG(2005.87,IEN,0),"^",3)
 I (CLS="") S CLS="CLIN,ADMIN" ; CLS="", now treat it as both.  (Might rethink, treat it as any ? )
 I (CLS["ADMIN"),(CLS["CLIN") Q (MAGCLIN&MAGADMIN)
 I (CLS["CLIN") Q MAGCLIN
 I (CLS["ADMIN") Q MAGADMIN
 Q 0
 ;
CLSKEYS(ADM,CLIN) ;
 S (ADM,CLIN)=0
 N I,MAGKEY
 D USERKEYS^MAGGTU3(.MAGKEY)
 S I="" F  S I=$O(MAGKEY(I)) Q:I=""  D
 . I MAGKEY(I)="MAGDISP CLIN" S CLIN=1
 . I MAGKEY(I)="MAGDISP ADMIN" S ADM=1
 . Q
 Q
 ;
GET(MAGRY,FLTIEN,FLTNAME,USER) ;RPC [MAG4 FILTER DETAILS] Return a filter
 N FLTC,I,MAGV,X
 K MAGRY
 ;--- Validate parameters
 I '$G(FLTIEN) S FLTIEN=$$RSLVIEN($G(FLTNAME),$G(USER))
 I 'FLTIEN S MAGRY(0)="0^Can not resolve Filter name in VistA." Q
 I '$D(^MAG(2005.87,FLTIEN))  D  Q
 . S MAGRY(0)="0^Filter ID #"_FLTIEN_" Doesn't exist."
 . Q
 ;--- Load the filter data
 S FLTC=FLTIEN_","
 S MAGRY(0)="1^Filter "_$P(^MAG(2005.87,FLTIEN,0),"^",1)_" # "_FLTIEN
 D GETS^DIQ(2005.87,FLTC,".01:16","EI","MAGV")
 ;--- Reformat the dates (FROM and UNTIL)
 F I=6,7  S X=$G(MAGV(2005.87,FLTC,I,"I"))  D:X'=""
 . S MAGV(2005.87,FLTC,I,"E")=$$FMTE^XLFDT(X,"2Z")
 . Q
 ;--- Add the filter data to the result array
 S MAGRY(1)=FLTIEN
 F I=.01,1:1:9  S MAGRY(1)=MAGRY(1)_U_$G(MAGV(2005.87,FLTC,I,"E"))
 F I=10:1:16  S MAGRY(1)=MAGRY(1)_U_$G(MAGV(2005.87,FLTC,I,"I"))
 Q
 ;
RSLVIEN(NAME,USER) ; Return an IEN from the NAME and USER
 N I,IEN S I=""
 I NAME="" Q 0
 S IEN=0
 F  S I=$O(^MAG(2005.87,"B",NAME,I)) Q:'I  D
 . I $P(^MAG(2005.87,I,1),"^")=USER S IEN=I
 Q IEN
 ;
DFTFLT(USER) ; Create a Default Filter for user. Or Return Existing.
 ;  Plus this call, makes sure the Default Filter is valid.
 ; USER is the IEN in the New Person file
 ;   default to DUZ if ""
 N FLTIEN,XIEN
 S USER=$S($G(USER):USER,1:$G(DUZ))
 S XIEN=$O(^MAG(2006.18,"AC",USER,"")) Q:XIEN="" 0
 S FLTIEN=$P($G(^MAG(2006.18,XIEN,"LISTWIN1")),"^",3)
 I FLTIEN D  Q FLTIEN
 . I $D(^MAG(2005.87,FLTIEN)) Q  ; Valid filter Quit.
 . ; Users dflt filter invalid. Set dflt as first private or first public
 . ;   We dont' create the Admin All, or Clin All a second time.
 . S FLTIEN=$O(^MAG(2005.87,"C",USER,"")) ; get first private
 . I 'FLTIEN S FLTIEN=$O(^MAG(2005.87,"D",1,"")) ; return first public
 . S $P(^MAG(2006.18,XIEN,"LISTWIN1"),"^",3)=FLTIEN
 . Q
 ; 
 ;  Here we'll create Private filters for a user or send first existing 
 ;  private filter as the default.
 N MAGADMIN,MAGCLIN,MAGY,MAGX
 S FLTIEN=$O(^MAG(2005.87,"C",USER,"")) ; get first private
 I FLTIEN S $P(^MAG(2006.18,XIEN,"LISTWIN1"),"^",3)=FLTIEN Q FLTIEN
 D CLSKEYS(.MAGADMIN,.MAGCLIN)
 I MAGADMIN D
 . ; Create a Filter for All Admin add to IMAGE LIST FILTERS File for this user.
 . S MAGX(1)="USER^"_USER
 . S MAGX(2)=".01^Admin All"
 . S MAGX(3)="2^ADMIN"
 . D SET^MAGGSFL1(.MAGY,.MAGX)
 . S FLTIEN=$S(+MAGY:+MAGY,1:"")
 . Q
 K MAGY,MAGX
 I MAGCLIN D
 . ;Create a Filter for All Clin add to IMAGE LIST FILTERS File for this user.
 . S MAGX(1)="USER^"_USER
 . S MAGX(2)=".01^Clinical All"
 . S MAGX(3)="2^CLIN"
 . D SET^MAGGSFL1(.MAGY,.MAGX)
 . S FLTIEN=$S(+MAGY:+MAGY,1:"")
 . Q
 Q:'FLTIEN 0
 S $P(^MAG(2006.18,XIEN,"LISTWIN1"),"^",3)=FLTIEN
 Q FLTIEN
