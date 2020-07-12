TIUCOPUT ;SLC/TDP - Copy/Paste API and RPC utilities ;03/22/2016  10:31
 ;;1.0;TEXT INTEGRATION UTILITIES;**290**;Jun 20, 1997;Build 548
 ;
 ;   DBIA 10006  ^DIC
 ;   DBIA  2051  $$FIND1^DIC
 ;   DBIA  2056  $$GET1^DIQ
 ;   DBIA 10103  $$FMADD^XLFDT
 ;
DFNCHK(DFN) ;Verify user is valid
 N ERR
 Q $S(+$$FIND1^DIC(200,"","","`"_DFN,"","","ERR")>0:1,1:0)
 ;
DTCHK(DT) ;Verify date is valid
 N BDD,CDTM,DD,MM,TM,VLD,X,YY,%,%H,%I
 I DT'?7N1"."1.6N Q 0
 S YY=+$E(DT,1,3)
 S MM=+$E(DT,4,5) I ((MM<1)!(MM>12)) Q 0
 S DD=+$E(DT,6,7) D  Q:BDD=1 0
 . S BDD=0
 . I $S(((YY#4=0)&(MM=2)&(DD>29)):1,((YY#4'=0)&(MM=2)&(DD>28)):1,1:0) S BDD=1 Q
 . I $S((((MM=1)!(MM=3)!(MM=5)!(MM=7)!(MM=8)!(MM=10)!(MM=12))&(DD>31)):1,(((MM=4)!(MM=6)!(MM=9)!(MM=11))&(DD>30)):1,1:0) S BDD=1 Q
 . I DD<1 S BDD=1 Q
 S TM=+$P(DT,".",2) I (TM<0)!(TM>235959) Q 0
 Q 1
 ;
UNQDT(TIUDT) ;Make sure paste date is unique
 N X,UNIQ
 S UNIQ=0
 I '$D(^TIU(8925.04,"B",TIUDT)) Q
 F X=1:1 Q:UNIQ=1  D
 . S TIUDT=$$FMADD^XLFDT(TIUDT,0,0,0,X)
 . I '$D(^TIU(8925.04,"B",TIUDT)) S UNIQ=1
 Q
 ;
GDPKG(IEN,PKG,SRC) ; Package and ien are valid
 ;            GMRC = Consults (#123)
 ;            TIU  = Text Integration Utilities (#8925)
 ;            OR   = CPRS (#100)
 N FILE,GBL,SRCPKG
 I IEN="" Q 0
 I PKG="" S PKG="TIU"
 I SRC'="P",SRC'="C" S SRC="P"
 ;Possibly use a parameter to get package/global list for next 2 lines.
 ;Can also set up file structure information if needed.
 I SRC="P" S SRCPKG="GMRC,TIU,OR"
 I SRC="C" S SRCPKG="GMRC,TIU,OR,OUT"
 I SRCPKG'[PKG Q 0
 I PKG="GMRC" S PKG="GMR",FILE=123
 I PKG="OR" S FILE=100
 I PKG="TIU" S FILE=8925
 S GBL="^"_PKG
 I '$D(@GBL@(FILE,IEN,0)) Q 0
 Q 1
 ;
GDFIL(IEN,FILE,FILNM) ; File and ien are valid
 N GBL,DIC,ENTRY,FILIEN,X,Y
 I IEN="" Q 0
 I FILE="" S FILE="8925" ;Default to TIU DOCUMENT (#8925) file
 S DIC="^DIC(",DIC(0)="NOX"
 S X=FILE
 D ^DIC I (Y=-1)!(Y="") Q 0
 S FILIEN=$P(Y,U,1)
 S FILNM=$P(Y,U,2)
 S GBL=$$GET1^DIQ(1,FILIEN_",",1)
 S ENTRY=GBL_IEN_",0)"
 I '$D(@ENTRY) Q 0
 I FILE'=FILIEN S FILE=FILIEN
 Q 1
 ;
VROOT(ERARY) ;Check for invalid error array
 I ERARY'["(" Q 0
 I $E(ERARY,$L(ERARY))=")",$F(ERARY,")")>($F(ERARY,"(")+1) Q 0
 Q 1
 ;
ERMSG(TYPE) ;Send an error message to TIU CACS mail group
 ;
 Q
 ;
CPYTXT(PSTXT,TIUCPRCD,C) ;FORMAT COPIED TEXT
 N CTMP,LN,SMPST,TXT,X
 S SMPST=0
 S X=""
 F  S X=$O(PSTXT(TIUCPRCD,0,X)) Q:X=""  D
 . S CTMP(TIUCPRCD,0,X)=$G(PSTXT(TIUCPRCD,0,X))
 S (TXT,X)=0
 F  S X=$O(CTMP(TIUCPRCD,0,X)) Q:X=""  D  Q:TXT=1  ;Remove leading blank lines
 . I $TR($G(CTMP(TIUCPRCD,0,X))," ")]"" S TXT=1 Q
 . K CTMP(TIUCPRCD,0,X)
 S TXT=0
 S X=999999999
 F  S X=$O(CTMP(TIUCPRCD,0,X),-1) Q:X=0  Q:X=""  D  Q:TXT=1  ;Remove trailing blank lines
 . I $TR($G(CTMP(TIUCPRCD,0,X))," ")]"" S TXT=1 Q
 . K CTMP(TIUCPRCD,0,X)
 S LN=0
 F  S LN=$O(PSTXT(TIUCPRCD,0,LN)) Q:LN=""  D
 . S C(LN)=$G(PSTXT(TIUCPRCD,0,LN))
 I +$O(C(0))>0 S SMPST=1
 Q SMPST
 ;
RBLDARY(PSTXT,TIUCPRCD,CRGLN,PCT) ;Save new array values
 N ENT,ETXT,EXT,LN,LNCNT,NTXT,NOTXT,PARNT,TEXT,TIUCNT,TIULN,TIULNG
 N TMPARY,TXTDATA,X,CNTR,Y,SUB
 S (CNTR,X)=0
 ;F  S X=$O(FSD(X)) Q:X=""  D
 F  S X=$O(PSTXT(TIUCPRCD,"Paste",X)) Q:X=""  D
 . S CNTR=CNTR+1
 . I CNTR=1 S PARNT=TIUCPRCD
 . S ENT=($O(PSTXT(""),-1)+1)
 . S PSTXT(ENT,0)=$G(PSTXT(TIUCPRCD,0))
 . S $P(PSTXT(ENT,0),U,7)=-1
 . S $P(PSTXT(ENT,0),U,9)=PARNT
 . S Y=0
 . ;F  S Y=$O(FSD(X,Y)) Q:Y=""  D
 . F  S Y=$O(PSTXT(TIUCPRCD,"Paste",X,Y)) Q:Y=""  D
 .. S TXTDATA=$G(PSTXT(TIUCPRCD,"Paste",X,Y))
 .. ;S TIULNG=$L($G(FSD(X,Y)),CRGLN)
 .. S TIULNG=$L(TXTDATA,CRGLN)
 .. ;S TXTDATA=$G(FSD(X,Y))
 .. F TIULN=1:1:TIULNG D
 ... S SUB=$$SUB^TIUCOPSU("T",X)
 ... S TMPARY(X,SUB)=$P(TXTDATA,CRGLN,TIULN)
 . S LN=0,LNCNT=0,NOTXT=0
 . F  S LN=$O(TMPARY(X,LN)) Q:LN=""  D
 .. S TEXT=$G(TMPARY(X,LN))
 .. I TEXT="" S TEXT=" "
 .. I LN=1,$$TRIM^TIUCOPSU($G(TEXT),0)="" K TMPARY(X,LN) Q
 .. I LN>1 D
 ... S NOTXT=1
 ... S NTXT=""
 ... I $$TRIM^TIUCOPSU($G(TEXT),0)'="" S NOTXT=0
 ... I $$TRIM^TIUCOPSU($G(TEXT),0)="" D
 .... F NTXT=LN-1:-1:1 I $D(PSTXT(ENT,NTXT)),$$TRIM^TIUCOPSU($G(PSTXT(ENT,(NTXT))),0)'="" S NOTXT=0
 .... I NOTXT=1 K TMPARY(X,LN) Q
 .. I NOTXT=0 S LNCNT=LNCNT+1 S PSTXT(ENT,LNCNT)=$G(TMPARY(X,LN))
 . S ETXT=""
 . S LN=999999999
 . F  S LN=$O(PSTXT(ENT,LN),-1) D  Q:ETXT'=""
 .. S ETXT=$$TRIM^TIUCOPSU($G(PSTXT(ENT,LN)),0)
 .. I ((ETXT="")!(LN=0)) K PSTXT(ENT,LN)
 . K TMPARY
 Q
 ;
