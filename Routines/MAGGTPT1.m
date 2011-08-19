MAGGTPT1 ;WOIFO/GEK/SG - Delphi-Broker calls for patient lookup and information ; 1/20/09 11:59am
 ;;3.0;IMAGING;**16,8,92,46,59,93**;Dec 02, 2009;Build 163
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
FIND(MAGRY,ZY) ;RPC [MAGG PAT FIND]
 ; Call to Do a lookup using FIND^DIC
 ; MAGRY is the Array to return.
 ; ZY is parameter sent by calling app (Delphi)
 ;   NUM TO RETURN ^ TEXT TO MATCH ^ TYPE OF OUPUT FORMAT ^ SCREEN ($P 5-99)
 ; MAGRY(0)="0^Error message"
 ; or 
 ; MAGRY(0)=Found 100 entries matching "" there are more
 ;
 ; if $P(ZY,"^",4)'=2 then
 ; MAGRY(1..n)     = Patient Name _" " _ Date Of Birth _" "_ Male/Female _ " "_ Ward ^ DFN^ICN
 ; if $P(ZY,"^",4)=2 then
 ; MAGRY(1) = "Patient Name^DOB~S1^Sex^Ward"
 ;   MAGRY(2..n)  =   Patient Name^Date Of Birth^Male/Female^Ward | DFN^ICN
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 ;
 N X,Y,I,Z,MAGDFN,WARD
 N FILE,IENS,FLDS,FLAGS,VAL,NUM,INDEX,SCR,IDENT,TROOT
 N RTYPE,SEX,ICN,PNAME
 S (FILE,IENS,FLDS,FLAGS,VAL,NUM,INDEX,SCR,IDENT,TROOT)=""
 ;
 S FILE=2 ; Patient File
 ;          Number of entries to return, If 0 we'll stop at 100
 S NUM=$S(+$P(ZY,U,1):+$P(ZY,U,1),1:100)
 S VAL=$P(ZY,U,2) ; this is the starting value i.e. 'Smi'
 S SCR=$P(ZY,U,5,99)
 S FLDS=$P(ZY,U,3)
 S RTYPE=$P(ZY,U,4)
 ;  If specific fields aren't requested, 
 ;     Get Identifiers, and ward as FLDS
 ;I '$L(FLDS) S FLDS=FLDS_";.1;.03;.09;.301;391"
 I '$L(FLDS) S FLDS=FLDS_";.1;.02;.301;391"
 ;  we'll add ACN to the index to search, for ward
 ; for speed we'll decide which xref to use
 S INDEX=$S(VAL?9N:"SSN^ACN",VAL?1U1.N:"BS5^ACN",1:"B^ACN")
 ;
 K ^TMP("DILIST",$J)
 K ^TMP("DIERR",$J)
 ;  VAL is the initial value to search for. i.e. the user input.
 ;  Next line is to stop the FM Infinite Error Trap problem.
 I $L(VAL)>30 S MAGRY(0)="0^Invalid: Input '"_$E(VAL,1,40)_"...' is too long. "_$L(VAL)_" characters." Q
 D FIND^DIC(FILE,IENS,FLDS,FLAGS,VAL,NUM,INDEX,SCR,IDENT,TROOT)
 ;
 ;  if no Match or ERROR  we return 0 as 1st '^' piece.
 ;
 I '$D(^TMP("DILIST",$J,1)) S I=1 D  Q
 . I $D(^TMP("DIERR",$J)) D FINDERR(I) Q
 . S MAGRY(I)="NO MATCH for lookup on """_$P(ZY,"^",2)_""""
 ;
 ;  so we have some matches, (BUT we could still have an error)
 ;  so first list all matches, then the Errors, if any.
 S I="" F  S I=$O(^TMP("DILIST",$J,1,I)) Q:I=""  D
 . S PNAME=^TMP("DILIST",$J,1,I) ; Name
 . S MAGDFN=+^TMP("DILIST",$J,2,I) ; DFN
 . S SEX=^TMP("DILIST",$J,"ID",I,.02)
 . S WARD=^TMP("DILIST",$J,"ID",I,.1)
 . K ^TMP("DILIST",$J,"ID",I,.1)
 . S ICN=$$GETICN^MPIF001(MAGDFN)
 . S ICN=$S(ICN'<0:ICN,1:"")
 . I RTYPE=2 D
 . . S MAGRY(I+1)=PNAME_U_$$DOB^DPTLK1(MAGDFN)_U_SEX_U_WARD_"|"_MAGDFN_U_ICN
 . I RTYPE'=2 D
 . . S X=PNAME
 . . I $E(WARD,1,$L(VAL))=VAL S X=WARD_"   "_PNAME
 . . S X=X_"   "_$$DOB^DPTLK1(MAGDFN)_"   "_$$SSN^DPTLK1(MAGDFN)
 . . S Z=0
 . . ; We are displaying other identifiers with each patient.
 . . F  S Z=$O(^TMP("DILIST",$J,"ID",I,Z)) Q:Z=""  S X=X_"   "_^(Z)
 . . S MAGRY(I)=X_"^"_(+MAGDFN)_"^"_ICN  ;SG
 I RTYPE=2 S MAGRY(1)="Patient Name^DOB~S1^Sex^Ward"
 ;
 I $D(^TMP("DIERR",$J)) D FINDERR() Q
 I '$D(^TMP("DILIST",$J,0)) Q
 S X=^TMP("DILIST",$J,0)
 S I=$O(MAGRY(""),-1)+1
 S MAGRY(0)="Found "_$P(X,"^")_" entr"_$S((+X=1):"y",1:"ies")_" matching """_$P(ZY,"^",3)_""""
 I $P(X,"^",3)>0 S MAGRY(0)=MAGRY(0)_" there are more"
 Q
FINDERR(XI) ;
 I '+$G(XI) S XI=$O(MAGRY(""),-1)+1
 S MAGRY(XI)="ERROR^"_^TMP("DIERR",$J,1,"TEXT",1)
 Q
INFO(MAGRY,DATA) ;RPC [MAGG PAT INFO]  Call to  Return patient info.
 ; Input parameters 
 ;    DATA:  MAGDFN ^ NOLOG ^ ISICN
 ;       MAGDFN -- Patient DFN
 ;       NOLOG  -- 0/1; if 1, then do NOT update the Session log
 ;       ISICN  -- 0/1  if 1, then this is an ICN, if 0 (default) this is a DFN ; Patch 41
 ;  MAGRY is a string, we return the following :
 ; //$P     1        2      3     4     5     6     7     8        9                     10
 ; //    status ^   DFN ^ name ^ sex ^ DOB ^ SSN ^ S/C ^ TYPE ^ Veteran(y/n)  ^ Patient Image Count
 ; //$P    11            12              13
 ;        ICN       SITE Number   ^ Production Account 1/0
 ; VADM(1)=Patient's name
 ; VADM(5)=Patient's sex (M^MALE)
 ; VADM(3)=Patient's DOB (internal^external)
 ; VADM(2)=Patient's SSN (internal^external)
 ; VAEL(3)=Patient's Service Connected? (#.301) (1=yes)
 ; VAEL(4)=Patient's Veteran Y/N (#1901) (1=yes)
 ; VAEL(6)=Patient's Type (#391) (internal^external)
 ;
 N MAGDFN,DFN,X,NOLOG,VADM,VAEL,VAERR,ISICN
 S MAGDFN=$P(DATA,U),NOLOG=+$P(DATA,U,2),ISICN=+$P(DATA,U,3)
 I ISICN D GETDFN^VAFCTFU1(.DFN,MAGDFN)
 E  S DFN=+MAGDFN
 D DEM^VADPT,ELIG^VADPT
 I VAERR S MAGRY="0^"_"Entry not found in Patient file." Q
 S X=$TR($$FMTE^XLFDT($P(VADM(3),"^"),"2FD")," ",0)
 ; //           status ^   DFN ^ name ^ sex ^ DOB ^ SSN    ^ S/C ^ TYPE ^ Veteran(y/n)  ^ Patient Image Count
 S $P(MAGRY,"^",1,2)="1^"_DFN
 ;          Fields:      NAME,           SEX,      DATE OF BIRTH,    SSN
 S $P(MAGRY,"^",3,6)=$G(VADM(1))_"^"_$P(VADM(5),"^",2)_"^"_X_"^"_$P(VADM(2),"^")
 ;          Fields:  Service Connected?,       Type,                   Veteran Y/N?     
 S $P(MAGRY,"^",7,9)=$S(+VAEL(3):"YES",1:"")_"^"_$P(VAEL(6),"^",2)_"^"_$S(+VAEL(4):"YES",1:"")
 ;          Fields:  Patient Image Count   
 S $P(MAGRY,"^",10)=$$IMGCT(DFN)_"^"
 ;  Additions. for Patch 41
 ;          Fields :   Patient ICN
 S $P(MAGRY,"^",11)=$$GETICN^MPIF001(DFN)
 S X=$$SITE^VASITE
 ;          Fields:   Site Number       Prod Acct
 S $P(MAGRY,"^",12)=$P($G(X),"^",3)_"^"_"1" ; We'll default to Production Account = Yes.
 ; NEED KERNEL PATCH XU*8.0*284 FOR PROD^XUPROD
 ;          Fields :   the Actual value for Prod Acct
 I $L($T(PROD^XUPROD)) S $P(MAGRY,"^",13)=+$$PROD^XUPROD
 S $P(MAGRY,"^",14)="^"
 ; AGE
 S $P(MAGRY,"^",15)=VADM(4)_"^"
 D KVAR^VADPT,KVA^VADPT
 I NOLOG  ; Don't update session log
 ;  We'll track DFN:ICN
 E  D ACTION^MAGGTAU("PAT^"_DFN_$S(ISICN:"-"_MAGDFN,1:""))
 Q
IMGCT(DFN) ; RETURN TOTAL NUMBER OF IMAGES FOR A PATIENT;
 ;
 N I,CT,RDT,PRX,IEN
 S CT=0
 S RDT="" F  S RDT=$O(^MAG(2005,"APDTPX",DFN,RDT)) Q:RDT=""  D
 . S PRX="" F  S PRX=$O(^MAG(2005,"APDTPX",DFN,RDT,PRX)) Q:PRX=""  D
 . . S IEN="" F  S IEN=$O(^MAG(2005,"APDTPX",DFN,RDT,PRX,IEN)) Q:IEN=""  S:'$$ISDEL^MAGGI11(IEN) CT=CT+1
 Q CT
BS5CHK(MAGRY,MAGDFN) ;RPC [MAGG PAT BS5 CHECK]
 ; Call to check the BS5 cross ref 
 ; and see if any similar patients exist.
 ; If yes, all matching patients will be listed and shown to the user.
 ;
 N MAGX,MAGDPT,XDFN,XSSN,CT,LNTH
 S LNTH=0
 S MAGRY(1)="-1^Error checking cross reference"
 D GUIBS5A^DPTLK6(.MAGRY,MAGDFN)
 I MAGRY(1)=0 Q
 S CT=$O(MAGRY(""),-1)+1
 S MAGRY(CT)=MAGRY(CT-1),MAGRY(CT-1)="0^ "
 S I="" F  S I=$O(MAGRY(I)) Q:'I  D
 . I $P(MAGRY(I),U)=0 Q
 . I $L($P(MAGRY(I),U,3))>LNTH S LNTH=$L($P(MAGRY(I),U,3))
 S LNTH=LNTH+1
 S I=1 F  S I=$O(MAGRY(I)) Q:'I  D
 . I $P(MAGRY(I),U)="0" S MAGRY(I)=$P(MAGRY(I),U,2) Q
 . S XDFN=$P(MAGRY(I),U,2)
 . I +XDFN=+MAGDFN S MAGX="   >>>>>> "
 . E  S MAGX="          "
 . S XSSN=$$SSN^DPTLK1(XDFN) I XSSN?9N S XSSN=$E(XSSN,1,3)_"-"_$E(XSSN,4,5)_"-"_$E(XSSN,6,9)
 . S MAGDPT=$P(MAGRY(I),U,3),$E(MAGDPT,LNTH)=" "
 . S MAGX=MAGX_MAGDPT_"   "_$$DOB^DPTLK1(XDFN)_"   "_XSSN
 . S MAGRY(I)=MAGX
 Q
