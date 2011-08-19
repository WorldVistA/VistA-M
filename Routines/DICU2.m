DICU2 ;SEA/TOAD,SF/TKW-VA FileMan: Lookup Tools, Return IDs ;7/24/98  12:19
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
IDS(DIFILE,DIEN,DIFLAGS,DINDEX,DICOUNT,DIDENT,DILIST,DI0NODE) ;
 ;
 ; ENTRY POINT--add an entry's identifiers to output
 ;
I1 ; setup 0-node and ID array interface, and output IEN
 ;
 I DIFLAGS["h" N F,N,I M F=DIFILE S N=$G(DI0NODE),I=+$G(DIEN) N DIFILE,DI0NODE,DIEN M DIFILE=F S DIEN=I S:N]"" DI0NODE=N K F,N,I
 I '$D(DI0NODE) S DI0NODE=$G(@DIFILE(DIFILE)@(+DIEN,0))
 N DID,DIDVAL
 I DIFLAGS["P" N DINODE S DINODE=+DIEN
 E  S @DILIST@(2,DICOUNT)=+DIEN
 ;
I1A ; output primary value (index for Lister, .01 for Finder)
 ;
 I DIFLAGS'["P",$D(DIDENT(-2)) D
 . N DIOUT S DIOUT=$NA(@DILIST@(1,DICOUNT))
 . I DIFLAGS[3 N DISUB D  Q
 . . F DISUB=0:0 S DISUB=$O(DIDENT(0,-2,DISUB)) Q:'DISUB  D
 . . . I DINDEX("#")'>1 D SET(0,-2,DISUB,DIOUT,.DINDEX) Q
 . . . N I S I=$NA(@DIOUT@(DISUB)) D SET(0,-2,DISUB,I,.DINDEX)
 . I $D(DIDENT(0,-2,.01)) D SET(0,-2,.01,DIOUT,"",.DIFILE)
 . Q
 ;
I2 ; start loop: loop through output values
 ;
 I DIFLAGS["P" N DILENGTH S DILENGTH=$L(DINODE)
 N DICODE,DICRSR,DIOUT,DISUB S DICRSR=-1
 F  S DICRSR=$O(DIDENT(DICRSR)) Q:DICRSR=""!($G(DIERR))  S DID="" F  S DID=$O(DIDENT(DICRSR,DID)) Q:DID=""!($G(DIERR))  S DISUB="" F  D  Q:DISUB=""!$G(DIERR)
 . I DIFLAGS'["P",DID=-2 Q
 . S DISUB=$O(DIDENT(DICRSR,DID,DISUB)) Q:DISUB=""
 . K DIDVAL
I20 . ; output indexed field if "IX" was in FIELDS parameter
 . I DID=0 D  Q
 . . D SET(DICRSR,DID,DISUB,"DIDVAL",.DINDEX,.DIFILE)
 . . I DIFLAGS["P" D ADD(.DIFLAGS,.DINODE,.DILENGTH,DIDVAL,DIEN,DILIST) Q
 . . M @DILIST@("ID",DICOUNT,0,DISUB)=DIDVAL Q
 .
I3 . ; output field
 . ; distinguish between computed and value fields
 .
 . I DID D  Q:$G(DIERR)
 . . ; process fields that are not computed.
 . . I $G(DIDENT(DICRSR,DID,0,"TYPE"))'="C" D
 . . . D SET(DICRSR,DID,DISUB,"DIDVAL",.DINDEX,.DIFILE) Q
 . .
I4 . . ; computed fields
 . . E  D
 . . . N %,%H,%T,A,B,C,D,DFN,I,X,X1,X2,Y,Z,Z0,Z1
 . . . N DA M DA=DIEN S DA=$P(DIEN,",")
 . . . N DIARG S DIARG="D0"
 . . . N DIMAX S DIMAX=+$O(DA(""),-1)
 . . . N DIDVAR F DIDVAR=1:1:DIMAX S DIARG=DIARG_",D"_DIDVAR
 . . . N @DIARG F DIDVAR=0:1:DIMAX-1 S @("D"_DIDVAR)=DA(DIMAX-DIDVAR)
 . . . S @("D"_DIMAX)=DA
 . . . X DIDENT(DICRSR,DID,0) S DIDVAL=$G(X)
 . .
I5 . . ; set field into array or pack node
 . .
 . . I DIFLAGS'["P" M @DILIST@("ID",DICOUNT,DID)=DIDVAL
 . . E  D ADD(.DIFLAGS,.DINODE,.DILENGTH,DIDVAL,DIEN,DILIST)
 .
I6 . ; output display-only identifier
 .
 . E  D
 . . N %,D,DIC,X,Y,Y1
 . . S D=DINDEX
 . . S DIC=DIFILE(DIFILE,"O")
 . . S DIC(0)=$TR(DIFLAGS,"2^fglpqtuv104")
 . . M Y=DIEN S Y=$P(DIEN,",")
 . . S Y1=$G(@DIFILE(DIFILE)@(+DIEN,0)),Y1=DIEN
 . .
I7 . . ; execute the identifier's code
 . .
 . . N DIX S DIX=DIDENT(DICRSR,DID,0)
 . . X DIX
 . . I $G(DIERR) D  Q
 . . . N DICONTXT I DID="ZZZ ID" S DICONTXT="Identifier parameter"
 . . . E  S DICONTXT="MUMPS Identifier"
 . . . D ERR^DICF4(120,DIFILE,DIEN,"",DICONTXT)
 . .
I8 . . ; set output from identifier into output array or pack node
 . . 
 . . N DI,DILINE,DIEND S DI="" S:DIFLAGS'["P" DIEND=$O(@DILIST@("ID","WRITE",DICOUNT,"z"),-1)
 . . I $O(^TMP("DIMSG",$J,""))="" S ^TMP("DIMSG",$J,1)=""
 . . F  D  Q:DI=""!$G(DIERR)
 . . . S DI=$O(^TMP("DIMSG",$J,DI)) Q:DI=""
 . . . S DILINE=$G(^TMP("DIMSG",$J,DI))
 . . . I DIFLAGS["P" D ADD(.DIFLAGS,.DINODE,.DILENGTH,DILINE,DIEN,DILIST,DI) Q
 . . . S DIEND=DIEND+1,@DILIST@("ID","WRITE",DICOUNT,DIEND)=DILINE
 . . . Q
 . . K DIMSG,^TMP("DIMSG",$J)
 ;
I9 ; for packed output, set pack node into output array
 ;
 I '$G(DIERR),DIFLAGS["P" S @DILIST@(DICOUNT,0)=DINODE
 Q
 ;
 ;
SET(DICRSR,DIFID,DISUB,DIOUT,DINDEX,DIFILE) ; Move data to DIOUT.
 N F1,F2
 S F1=$O(DIDENT(DICRSR,DIFID,DISUB,"")),F2=$O(DIDENT(DICRSR,DIFID,DISUB,F1))
 F F1=F1,F2 D:F1]""
 . I DIDENT(DICRSR,DIFID,DISUB,F1)["DIVAL" N DIVAL S @DINDEX(DISUB,"GET")
 . N X S @("X="_DIDENT(DICRSR,DIFID,DISUB,F1))
 . I $G(DIERR),DIFLAGS["h" K DIERR,^TMP("DIERR",$J) S X=DINDEX(DISUB)
 . I X["""" S X=$$CONVQQ^DILIBF(X)
 . I +$P(X,"E")'=X S X=""""_X_""""
 . I F2="" S @(DIOUT_"="_X) Q
 . S O=$NA(@DIOUT@(F1)),@(O_"="_X) Q
 Q
 ;
TRANOUT(DISUB,DIVL) ; Execute TRANSFORM FOR DISPLAY on index value
 N X S X=DIVL
 N DICODE S DICODE=$G(DINDEX(DISUB,"TRANOUT"))
 I DICODE]"" X DICODE
 Q X
 ;
ADD(DIFLAGS,DINODE,DILENGTH,DINEW,DIEN,DILIST,DILCNT) ;
 ;
 ; for Packed output, add DINEW to DINODE, erroring if overflow
 ; xform if it contains ^
 ;
A1 N DINEWLEN,DELIM S DINEWLEN=$L(DINEW),DELIM=$S($G(DILCNT)'>1:"^",1:"~")
 S DILENGTH=DILENGTH+1+DINEWLEN
 I DILENGTH>255 D ERR^DICF4(206,"","","",+DIEN) Q
 I DIFLAGS'[2,DINEW[U S DIFLAGS="2^"_DIFLAGS D ENCODE(DILIST,.DINODE)
 I DIFLAGS[2,DINEW[U!(DINEW["&") S DINEW=$$HTML^DILF(DINEW) Q:$G(DIERR)
 S DINODE=DINODE_DELIM_DINEW
 Q
 ;
ENCODE(DILIST,DINODE) ;
 ;
 ; ADD: HTML encode records already output (we found an embedded ^)
 ; procedure: loop through list encoding &s
 ;
E1 N DILINE,DIRULE S DIRULE(1,"&")="&amp;"
 N DIREC S DIREC=0 F  S DIREC=$O(@DILIST@(DIREC)) Q:'DIREC  D
 . S DILINE=@DILIST@(DIREC,0) Q:DILINE'["&"
 . S @DILIST@(DIREC,0)=$$TRANSL8^DILF(DILINE,.DIRULE)
 I DINODE["&" S DINODE=$$TRANSL8^DILF(DINODE,.DIRULE)
 Q
 ;
