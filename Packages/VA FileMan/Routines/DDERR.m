DDERR ;SLC/MKB -- Entity Error Handler ;9/10/18  14:33
 ;;22.2;VA FileMan;**9**;Jan 05, 2016;Build 73
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
QRY ; -- save Query error
 N ERROR
 S ERROR="Entity "_$G(DTYPE)_" query: "_$$EC^%ZOSV
 G CONT
 ;
ONE ; -- save Record error
 N ERROR
 S ERROR="Entity "_$G(DTYPE)_"/ID "_$G(DLIST(DDEN))_": "_$$EC^%ZOSV
 ;
CONT ; -- Save error in trap, return array
 ;
 ;Add message to return error array
 D:$D(ERROR) ERROR^DDEGET(ERROR)
 ;
 ;Log the error, continue to next record
 D ^%ZTER,UNWIND^%ZTER
 Q
