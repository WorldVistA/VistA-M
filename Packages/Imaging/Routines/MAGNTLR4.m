MAGNTLR4 ;WOIFO/NST - TeleReader Configuration utilities ; 23 Apr 2012 11:19 AM
 ;;3.0;IMAGING;**127**;Mar 19, 2002;Build 4231;Apr 01, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
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
 ;
 ;***** Clone a Reader in TELEREADER READER file (#2006.5843) 
 ; RPC: MAG3 TELEREADER CLONE READER
 ;
 ; Input Parameters
 ; ================
 ;  MAGFROM = Source reader (a pointer to NEW PERSON file (#200)) to be cloned
 ;  MAGTO = An array with target readers (pointers to NEW PERSON file (#200))
 ;
 ; Return Values
 ; =============
 ; MAGRY = An array with results per cloned reader
 ; if error
 ;  MAGRY(0) = 0 ^ Error message
 ; if success
 ;  MAGRY(0) = 1 ^ Number of processed readers
 ;  MAGRY(1..n) = 0|1 ^ Message
 ;                0 failure
 ;                1 success
 ; 
 ; Note: ^TMP("MAGNTLR4",$J) is used during cloning process to store 
 ;       the privileges of the source reader. All the privileges are in 
 ;       multiple ACQUISITION SITE field (#2006.5843,1)
 ;  
CLONE(MAGRY,MAGFROM,MAGTO) ;RPC [MAG3 TELEREADER CLONE READER]
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 N FROMIEN,IEN,I,MAGRES
 N MAGPRIV  ; Reader's privileges
 ;
 I $G(MAGFROM)'>0 S MAGRY(0)="0^The source reader is not provided." Q
 ; Verify input parameters
 S FROMIEN=$O(^MAG(2006.5843,"B",MAGFROM,""))
 I FROMIEN'>0 S MAGRY(0)="0^Reader #"_MAGFROM_" profile is not defined." Q
 ;
 ; Get the source reader profile
 L +^MAG(2006.5843,FROMIEN):10
 E  S MAGRY(0)="0^Cannot lock source reader profile" Q 
 ; Store source reader privileges in temp global
 K ^TMP("MAGNTLR4",$J)
 M ^TMP("MAGNTLR4",$J,FROMIEN,1)=^MAG(2006.5843,FROMIEN,1)
 L -^MAG(2006.5843,FROMIEN)
 S MAGPRIV=$NA(^TMP("MAGNTLR4",$J,FROMIEN,1))
 ;
 S IEN=""
 S I=0
 F  S IEN=$O(MAGTO(IEN)) Q:IEN=""  D
 . ; Clone the reader IEN
 . D CLONE1R^MAGNTLR4(.MAGRES,MAGFROM,IEN,MAGPRIV)
 . S I=I+1,MAGRY(I)=MAGRES
 . Q
 K ^TMP("MAGNTLR4",$J)
 S MAGRY(0)="1^"_I
 Q
 ;
 ;+++++ Clone reader MAGFROM to MAGREADR
 ; 
 ; Input Parameters
 ; ================
 ;  MAGFROM = Source reader
 ;  MAGREADR = Target reader 
 ;  MAGPRIV = A source temp global with a profile configured
 ; 
 ; Return Values
 ; =============
 ;   0|1 ^ Message
 ;   where  
 ;     0 - failure
 ;     1 - success
CLONE1R(MAGRY,MAGFROM,MAGREADR,MAGPRIV) ; Clone one reader
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 N MAGNFDA,MAGNIEN,MAGNXE,MAGRESA
 N IEN,DIK,DA
 ;
 I MAGFROM=MAGREADR S MAGRY="0^Source and target readers are the same" Q
 ; Delete the target reader privileges first
 S DA=$O(^MAG(2006.5843,"B",MAGREADR,""))
 I DA>0 D
 . S DIK="^MAG(2006.5843,"
 . D ^DIK
 . Q
 ;
 ; Clone the reader
 ; Add the new reader first
 S MAGNFDA(2006.5843,"+1,",.01)=MAGREADR
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 ;
 I $D(MAGNXE("DIERR","E")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY="0^"_MAGRESA(1)
 . Q
 ;
 S IEN=MAGNIEN(1) ; New reader IEN
 ; Update the privileges for the reader
 M ^MAG(2006.5843,IEN,1)=@MAGPRIV
 S MAGRY="1^Reader #"_MAGREADR_" profile has been created"
 Q
