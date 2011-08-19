MAGGNLKP ;WOIFO/GEK - Lookup from delphi into any file ; [ 06/20/2001 08:56 ]
 ;;3.0;IMAGING;**8,92,46,59**;Nov 27, 2007;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
LKP(MAGRY,MAGIN,DATA) ;RPC [MAG3 LOOKUP ANY] 
 ; Generic lookup using FIND^DIC
 ; MAGRY is the Array to return.
 ; MAGIN is parameter sent by calling app (Delphi)
 ;    FILE NUM ^ NUM TO RETURN ^ TEXT TO MATCH ^ FIELDS ^ SCREEN ($P 5-99)
 ;    
 ; DATA : 
 ;  LVIEW =Piece 1 
 ;     +LVIEW = 1  :  
 ;          result array is formatted for a magListView control
 ;              i.e.  ^ delimiter for data and "|" delimiter for IEN
 ;     +LVIEW = 0  : 
 ;         old way,  "  " delim for data and '^' delim for IEN
 ;  INDX = Piece 2
 ;                       This is the index to search 
 ;                       Defaults to "B"
 ;    
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 ;
 N Y,XI,Z,FI,MAGIEN,INFO,LVIEW,INDX
 N FILE,IENS,FLDS,FLAGS,VAL,NUM,INDEX,SCR,IDENT,TROOT
 S (FILE,IENS,FLDS,FLAGS,VAL,NUM,INDEX,SCR,IDENT,TROOT)=""
 S MAGIN=$G(MAGIN)
 S DATA=$G(DATA)
 ;
 S FILE=+$P(MAGIN,U,1)
 S NUM=$S(+$P(MAGIN,U,2):+$P(MAGIN,U,2),1:200)
 S VAL=$P(MAGIN,U,3)
 S FLDS=$P(MAGIN,U,4)
 S SCR=$P(MAGIN,U,5,99)
 ;
 S LVIEW=+$P(DATA,"^",1)
 S INDX=$S($L($P(DATA,"^",2)):$P(DATA,"^",2),1:"B")
 ;
 I 'FILE S MAGRY(1)="0^ERROR - Invalid Parameter:  File Number ? " Q
 I '$$VFILE^DILFD(FILE) S MAGRY(1)="0^ERROR - Invalid File # - "_FILE Q
 ;          Number of entries to return, If 0 we'll stop at 200
 ;
 K ^TMP("DILIST",$J)
 K ^TMP("DIERR",$J)
 ;  VAL is the initial value to search for. i.e. the user input.
 ;  Next line is to stop the FM Infinite Error Trap problem.
 I $L(VAL)>30 S MAGRY(0)="0^Invalid Input: '"_$E(VAL,1,40)_"...' is too long. "_$L(VAL)_" characters." Q
 D FIND^DIC(FILE,IENS,FLDS,FLAGS,VAL,NUM,INDEX,SCR,IDENT,TROOT)
 ;
 I '$D(^TMP("DILIST",$J,1)) S XI=1 D  Q
 . I $D(^TMP("DIERR",$J)) D FINDERR(XI) Q
 . S MAGRY(XI)="0^NO MATCH for lookup on """_$P(MAGIN,"^",3)_""""
 ;  so we have some matches, (BUT we could still have an error)
 ;  so first list all matches, then the ERROR
 ;  Next lines were Q&D but old .EXE's expect return string with 
 ;  this syntax, when all T11 code is gone, this can be rewritten
 I LVIEW S XI="" F  S XI=$O(^TMP("DILIST",$J,1,XI)) Q:XI=""  S X=^(XI) D
 . S MAGIEN=^TMP("DILIST",$J,2,XI)
 . S Z=".01",FLD="NAME"
 . F  S Z=$O(^TMP("DILIST",$J,"ID",XI,Z)) Q:Z=""  S X=X_"^"_^(Z),FLD=FLD_"^"_$$GET1^DID(FILE,Z,"","LABEL","MAGFLD")
 . S MAGRY(.05)=FLD
 . S MAGRY(XI)=X_"^|"_MAGIEN
 . Q
 I 'LVIEW  S XI="" F  S XI=$O(^TMP("DILIST",$J,1,XI)) Q:XI=""  S X=^(XI) D
 . S MAGIEN=^TMP("DILIST",$J,2,XI)
 . S Z=""
 . F  S Z=$O(^TMP("DILIST",$J,"ID",XI,Z)) Q:Z=""  S X=X_"   "_^(Z)
 . S MAGRY(XI)=X_"^"_MAGIEN
 . Q
 I $D(^TMP("DIERR",$J)) D FINDERR() Q
 I $D(^TMP("DILIST",$J,0)) S INFO=^(0) D
 . S MAGRY(0)=$P(INFO,"^")_U_"Found "_$P(INFO,"^")_" entr"_$S((+INFO=1):"y",1:"ies")_" matching """_$P(MAGIN,"^",3)_""""
 . I $P(INFO,"^",3)>0 S MAGRY(0)=MAGRY(0)_" there are more"
 . Q
 Q
FINDERR(XI) ;
 ;
 I '+$G(XI) S XI=$O(MAGRY(""),-1)+1
 S MAGRY(XI)="ERROR^"_^TMP("DIERR",$J,1,"TEXT",1)
 Q
