GMVRPCHL ;HIOFO/FT-RPC FOR HOSPITAL LOCATION SELECTION ;12/7/05  10:32
 ;;5.0;GEN. MED. REC. - VITALS;**3,22**;Oct 31, 2002;Build 22
 ;
 ; This routine uses the following IAs:
 ;  #1378 - DGPM references        (controlled)
 ;  #2965 - FILE 405.1 references  (controlled)
 ; #10039 - FILE 42 references     (supported)
 ; #10040 - FILE 44 references     (supported)
 ; #10061 - ^VADPT calls           (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ;
 ; This routine supports the following IAs:
 ; #4461 - GMV LOCATION SELECT RPC is called at RPC  (private)
 ;
RPC(RESULTS,OPTION,DATA) ; [Procedure] Main RPC call tag
 ; RPC: [GMV LOCATION SELECT]
 ;
 ; Input parameters
 ;  1. RESULTS [Reference/Required] RPC Return array
 ;  2. OPTION [Literal/Required] RPC Option to execute
 ;  3. DATA [Literal/Required] Other data as required for call
 ;
 S RESULTS=$NA(^TMP("GMVHLOC",$J)) K @RESULTS
 D:$T(@OPTION)]"" @OPTION
 S:'$D(@RESULTS) @RESULTS@(0)="-1^No results returned"
 D CLEAN^DILF,KVAR^VADPT
 Q
NAME ; Return list of clinics and wards by name
 ; DATA=pieceA^pieceB^pieceC
 ;  where pieceA - file number (required)
 ;        pieceB - value to begin search with (required)
 ;        pieceC - field(s) to do the look-up on (optional, defaults to .01 field)
 ;
 ; RESULTS(0)=piece1^piece2
 ; RESULTS(n)=piece3
 ;  where piece1 - -1 if error OR number of entries found
 ;        piece2 - error message if piece1=-1
 ;        piece3 - field values requested.
 ;             n - sequential number starting with 1
 ; 
 N GMVSCRN,GMVFLD,X
 S DATA=$G(DATA)
 I +DATA'>0 D  Q
 .S @RESULTS@(0)="-1^Not a valid file number"
 .Q
 S GMVSCRN=$S(+DATA=44:"I $P(^(0),U,3)'=""Z""",1:"")
 I $P(DATA,"^",3)="" S GMVFLD="@;.01"
 E  S GMVFLD="@;"_$P(DATA,"^",3)
 S GMVFLD=$P(GMVFLD,";",1,5) ; Limit lookup to 4 display fields
 D FIND^DIC(+DATA,"",GMVFLD,"P",$P(DATA,"^",2),"","",GMVSCRN)
 I $D(^TMP("DIERR",$J)) D  Q
 .S @RESULTS@(0)="-1^"_$G(^TMP("DIERR",$J,1,"TEXT",1))
 .Q
 I ^TMP("DILIST",$J,0)<1 D  Q
 .S @RESULTS@(0)="-1^No entries found matching '"_$P(DATA,U,2)_"'."
 .Q
 ;I ^TMP("DILIST",$J,0)>60 D  Q
 ;.S @RESULTS@(0)="-1^Too many matches found, please be more specific."
 ;.Q
 F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  D
 .S @RESULTS@(X)=+DATA_";"_^TMP("DILIST",$J,X,0)
 .Q
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
APPT ; Get patient appointments using SDA^VADPT
 ; DATA=GMVDFN^GMVFROM^GMVTO^GMVFLAG
 ;         GMVDFN - DFN (required)
 ;        GMVFROM - Start date of search (optional)
 ;          GMVTO - End date of search (optional)
 ;        GMVFLAG - kind of appt flag (optional)
 ; RESULTS(0)=piece1^piece2
 ; RESULTS(n)=piece3^piece4^piece5^piece6^piece7^piece8^piece9^piece10
 ;
 ;  where piece1 - -1 if an error OR the number of records returned
 ;        piece2 - an error message if piece1 = -1
 ;        piece3 - appointment date/time (FM internal)
 ;        piece4 - appointment date/time (external)
 ;        piece5 - clinic (internal)
 ;        piece6 - clinic (external)
 ;        piece7 - status (internal)
 ;        piece8 - status (external)
 ;        piece9 - appointment type (external)
 ;        piece10 - appointment type (external)
 ;              n - a sequential number starting with 1 
 ;        
 N GMVARRAY,GMVCNT,GMVE,GMVI,GMVLOOP,GMVDFN,GMVFROM,GMVTO,GMVFLAG
 N DFN,VAERR,VASD
 S DATA=$G(DATA)
 S GMVDFN=$P(DATA,U,1),GMVFROM=$P(DATA,U,2),GMVTO=$P(DATA,U,3),GMVFLAG=$P(DATA,U,4)
 S GMVDFN=+$G(GMVDFN)
 I '$G(GMVDFN) S @RESULTS@(0)="-1^Patient ID is missing" Q
 I $G(GMVFROM)="" S GMVFROM=$$FMADD^XLFDT(DT,-365)
 I $G(GMVTO)="" S GMVTO=DT_".235959"
 S:GMVFLAG="" VASD("W")="123456789"
 S DFN=GMVDFN,VASD("T")=GMVTO,VASD("F")=GMVFROM
 D SDA^VADPT
 I $G(VAERR)=1 S @RESULTS@(0)="-1^DFN or ^DPT(DFN,0) is not defined" Q
 S @RESULTS@(0)=0
 I '$D(^UTILITY("VASD",$J)) Q
 S (GMVCNT,GMVLOOP)=0
 F  S GMVLOOP=$O(^UTILITY("VASD",$J,GMVLOOP)) Q:'GMVLOOP  D
 .S GMVE=$G(^UTILITY("VASD",$J,GMVLOOP,"E"))
 .S GMVI=$G(^UTILITY("VASD",$J,GMVLOOP,"I"))
 .Q:'$P(GMVI,U,1)
 .S GMVCNT=GMVCNT+1
 .S GMVARRAY(9999999.999999-$P(GMVI,U,1))=$P(GMVI,U,1)_U_$P(GMVE,U,1)_U_$P(GMVI,U,2)_U_$P(GMVE,U,2)_U_$P(GMVI,U,3)_U_$P(GMVE,U,3)_U_$P(GMVI,U,4)_U_$P(GMVE,U,4)
 .Q
 S $P(@RESULTS@(0),U,1)=GMVCNT
 K ^UTILITY("VASD",$J)
 S (GMVCNT,GMVLOOP)=0
 F  S GMVLOOP=$O(GMVARRAY(GMVLOOP)) Q:'GMVLOOP  D
 .S GMVCNT=GMVCNT+1
 .S @RESULTS@(GMVCNT)=$G(GMVARRAY(GMVLOOP))
 .Q
 Q
ADMIT ; return a list of admissions
 ; DATA=DFN
 ; RESULTS(0)=piece1
 ; RESULTS(n)=piece2^piece3^piece4^piece5^piece6
 ;   where piece1 - number of records returned
 ;         piece2 - movement date/time (external)
 ;         piece3 - location ien (FILE 44)
 ;         piece4 - location name (FILE 44, Field .01)
 ;         piece5 - type of move
 ;         PIECE6 - movement ien
 ;              n - a sequential number starting with 1
 ;
 N DFN,TIM,MOV,X0,MTIM,XTYP,XLOC,HLOC,ILST
 S DFN=DATA,ILST=0,TIM=""
 I '$G(DFN) Q
 F  S TIM=$O(^DGPM("ATID1",DFN,TIM)) Q:TIM'>0  D
 .S MOV=0
 .F  S MOV=$O(^DGPM("ATID1",DFN,TIM,MOV)) Q:MOV'>0  D
 ..S X0=$G(^DGPM(MOV,0)) I X0']"" Q
 ..S MTIM=$P(X0,U),MTIM=$$FMTE^XLFDT(MTIM,"1P")
 ..S XTYP=$P($G(^DG(405.1,+$P(X0,U,4),0)),U,1)
 ..S XLOC=$P($G(^DIC(42,+$P(X0,U,6),0)),U,1),HLOC=+$G(^(44))
 ..S ILST=ILST+1,@RESULTS@(ILST)=MTIM_U_HLOC_U_XLOC_U_XTYP_U_MOV
 ..Q
 .Q
 S @RESULTS@(0)=ILST
 Q
CLINIC ; Return list of active clinics
 ;     DATA = GMVFROM^GMVMAX^GMVDIR
 ;   Where:
 ;   GMVFROM - Value to begin the search (optional). Default is null (i.e., start
 ;             with the first entry in the B x-ref).
 ;   GMVMAX - Maximum number of entries to return. (optional) Default is 100.
 ;   GMVDIR - Direction of search (optional). 1 means forward and -1 means backwards.
 ;            Default is 1.   
 ; Output
 ;   RESULT(n)=piece1^piece2
 ;   
 ;   where n is a sequential number starting with zero
 ;         piece1 - 44;ien (44, a semi-colon and the entry number)
 ;         piece2 - location name (FILE 44, Field .01)
 ;         
 ;   ex:
 ;   RESULTS(0)=n 
 ;   RESULTS(1)=44;123^TEST CLINIC
 ;   
 ;   If no entries are found, then RESULTS(0)="-1^NO ENTRIES FOUND"
 ;
 N GMVACTIV,GMVCNT,GMVDIR,GMVFROM,GMVIEN,GMVLAST,GMVLOCS,GMVLOOP,GMVMAX,GMVNAME,GMVNODE,GMVX
 S GMVFROM=$P(DATA,U,1),GMVMAX=+$P(DATA,U,2),GMVDIR=$P(DATA,U,3)
 S:'GMVMAX GMVMAX=100
 S GMVDIR=$S(GMVDIR=-1:-1,1:1)
 I GMVFROM]"" D  ;get entry before or after GMVFROM
 .S:GMVDIR=1 GMVLAST=$O(^SC("B",GMVFROM),-1)
 .S:GMVDIR=-1 GMVLAST=$O(^SC("B",GMVFROM))
 .S GMVFROM=$G(GMVLAST)
 .Q
 S GMVCNT=0,GMVNAME=GMVFROM
 F  S GMVNAME=$O(^SC("B",GMVNAME),GMVDIR) Q:GMVNAME=""!(GMVCNT=GMVMAX)  D
 .S GMVIEN=0
 .F  S GMVIEN=$O(^SC("B",GMVNAME,GMVIEN)) Q:'GMVIEN!(GMVCNT=GMVMAX)  D
 ..S GMVNODE=$G(^SC(GMVIEN,0))
 ..Q:$P(GMVNODE,U,1)=""  ;no name
 ..Q:$P(GMVNODE,U,3)'="C"
 ..D  Q  ;clinics
 ...Q:+$G(^SC(GMVIEN,"OOS"))  ;out of service
 ...S GMVACTIV=$G(^SC(GMVIEN,"I"))
 ...I GMVACTIV Q:DT>+GMVACTIV&($P(GMVACTIV,U,2)=""!(DT<$P(GMVACTIV,U,2)))
 ...S GMVCNT=GMVCNT+1
 ...S @RESULTS@(GMVCNT)="44;"_GMVIEN_U_$P(^SC(GMVIEN,0),U)
 ...Q
 ..Q
 .Q
 I GMVCNT=0 S @RESULTS@(0)="-1^NO ENTRIES FOUND"
 I GMVCNT>0 S @RESULTS@(0)=GMVCNT
 Q
