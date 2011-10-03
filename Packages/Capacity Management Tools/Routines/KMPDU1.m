KMPDU1 ;SF/RAK - CM Developer Tools Utilities ;2/17/04  09:49
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
GBLCHK(KMPDY,KMPDGBL) ;-- check global name.
 ;----------------------------------------------------------------------
 ; KMPDGBL... Global name.
 ;
 ; Check to make sure global name is in format for subscript indirection.
 ;----------------------------------------------------------------------
 ;
 K KMPDY
 ;
 I $G(KMPDGBL)="" S KMPDY(0)="[Global name not defined]" Q
 ;
 I $E(KMPDGBL)["?" D  Q
 .S KMPDY(0)="['"_KMPDGBL_" is an incorrect global name]"
 ;
 I KMPDGBL["*" S KMPDY(0)="['"_KMPDGBL_" is an incorrect global name]" Q
 ;
 N GLOBAL
 ;
 S GLOBAL=KMPDGBL
 ; make sure begins with up-arrow (^).
 I $E(GLOBAL)'="^" S GLOBAL="^"_GLOBAL
 ; make sure contains a '('.
 I GLOBAL'["(" S GLOBAL=GLOBAL_"("
 ; if ends with comma (,) then remove comma.
 I $E(GLOBAL,($L(GLOBAL)))="," S $E(GLOBAL,($L(GLOBAL)))=""
 ; make sure ends with a ')'.
 I $E(GLOBAL,$L(GLOBAL))'=")" S GLOBAL=GLOBAL_")"
 ; if ends with comma (,) then remove comma.
 I $E(GLOBAL,($L(GLOBAL)-1))="," S $E(GLOBAL,($L(GLOBAL)-1))=""
 ; if global contains () then change to ("").
 I $E(GLOBAL,($L(GLOBAL)-1),$L(GLOBAL))="()" D 
 .S $E(GLOBAL,$L(GLOBAL))=""""")"
 ;
 S KMPDY(0)=GLOBAL
 ;
 Q
 ;
GBLLIST(KMPDY,KMPDGBL,KMPDST,KMPDLN) ;-- get global data
 ;----------------------------------------------------------------------
 ; KMPDGBL... Global name.
 ; KMPDST... Starting global node.  If this is a continuation then use
 ;           this entry as starting point.  If original time through
 ;           this should be set to null ("").
 ; KMPDLN... Number of lines to fill before quitting.
 ;----------------------------------------------------------------------
 ;
 K KMPDY
 ;
 S KMPDGBL=$G(KMPDGBL),KMPDST=$G(KMPDST),KMPDLN=+$G(KMPDLN)
 ;
 I 'KMPDLN S KMPDY(0)="[Number of lines not defined]" Q
 ;
 N GBL,GLOBAL,LAST,LEN,LN
 ;
 D GBLCHK(.KMPDY,KMPDGBL)
 ; if error.
 I $E($G(KMPDY(0)))="[" Q
 ;
 S GLOBAL=$G(KMPDY(0))
 I GLOBAL="" S KMPDY(0)="[Unable to process]" Q
 I $Q(@GLOBAL)="" S KMPDY(0)="<No Data to Report>" Q
 ;
 S GBL=$E(GLOBAL,1,$L(GLOBAL)-1)
 ; if GLOBAL("") then just use GLOBAL.
 S:$E(GBL,$L(GBL))="""" GBL=$P(GBL,"(")
 S LEN=80,LN=1
 ;
 ; if data in GLOBAL.
 I KMPDST=""&(GLOBAL'["("""")") I $D(@GLOBAL)#2 D 
 .S KMPDY(LN)=GLOBAL_" = "_@GLOBAL,LN=LN+1
 ;
 S:KMPDST]"" GLOBAL=KMPDST
 ;
 F  S GLOBAL=$Q(@GLOBAL) Q:GLOBAL=""!($E(GLOBAL,1,$L(GBL))'=GBL)  D  Q:LN>KMPDLN
 .S LAST=GLOBAL
 .S KMPDY(LN)=GLOBAL_" = "
 .; if fits within LEN.
 .I $L(@GLOBAL)'>LEN S KMPDY(LN)=KMPDY(LN)_@GLOBAL,LN=LN+1 Q
 .; parse data to fit on line.
 .D PARSE(LEN)
 ;
 S KMPDY(0)=GLOBAL
 ; if no more subscripts.
 ;($E(GLOBAL,1,$L(GBL))'=GBL)
 I GLOBAL="" S KMPDY(0)="***end of list***"
 E  I $E($Q(@GLOBAL),1,$L(GBL))'=GBL S KMPDY(0)="***end of list***"
 ;
 Q
 ;
PARSE(LEN) ;
 ;  if length of data is greater than current position to the end
 ;  of the screen the data must be broken down and printed on
 ;  separate lines so that $Y will continue to be updated
 ;
 S LEN=+$G(LEN) Q:'LEN  N C
 F C=0:1 Q:$E(@GLOBAL,(LEN*C),(LEN*(C+1)-1))']""  D 
 .S:$G(KMPDY(LN))="" KMPDY(LN)="               "
 .S KMPDY(LN)=$G(KMPDY(LN))_$E(@GLOBAL,(LEN*C),(LEN*(C+1)-1))
 .S LN=LN+1
 ;
 Q
