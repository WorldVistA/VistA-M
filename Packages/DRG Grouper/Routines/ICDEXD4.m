ICDEXD4 ;SLC/KER - ICD Extractor - DRG APIs (cont) ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICD("B")           N/A
 ;    ^ICD9("BA")         N/A
 ;    ^ICDID("B")         N/A
 ;    ^ICDIP("B")         N/A
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    ^DIC                ICR  10006
 ;               
 Q
ICDID(FILE,ID,CODE) ; Check if ICD identifier exist
 ; 
 ; Input:
 ;
 ;   FILE     File Number or root (required)
 ;              80 or ^ICD9     = File #80
 ;              80.1 or ^ICD0   = File #80.1
 ;   ID       Diagnosis/Procedure code identifier (required)
 ;   CODE     Diagnosis/Procedure code IEN (required)
 ;  
 ; Output:
 ;
 ;   $$ICDID  Boolean value
 ;              1 if identifier was found
 ;              0 if identifier was not found
 ;              
 ;             or upon error -1^error message
 ;
 N ICDC,ICDF,ICDI,ICDID,ICDIDI,ICDRT S ICDF=$$FILE^ICDEX($G(FILE))
 I "^80^80.1^"'[("^"_ICDF_"^") Q "-1^Invalid File"
 S ICDID=$G(ID),(ICDI,ICDC)=$G(CODE)
 I ICDID="" Q "-1^Missing identifier"
 S ICDRT=$$ROOT^ICDEX(ICDF)
 I "^ICD9(^ICD0(^"'[("^"_$E(ICDRT,2,$L(ICDRT))_"^") Q "-1^Invalid Global"
 I '$D(@(ICDRT_+ICDI_")")),$D(@(ICDRT_"""BA"","""_($G(ICDC)_" ")_""")")) D
 . S ICDI=$O(@(ICDRT_"""BA"","""_($G(ICDC)_" ")_""",0)"))
 Q:+ICDI'>0!('$D(@(ICDRT_+ICDI_")"))) "-1^Invalid IEN"
 S ICDRT=$$ROOT^ICDEX(ICDF)
 S ICDIDI=$$IDIEN(ICDF,ID) I +ICDIDI'>0 Q "-1^Invalid identifier"
 I $D(@(ICDRT_ICDI_",73,""B"","_ICDIDI_")")) Q 1
 Q 0
IDIEN(FILE,ID) ; Get IEN for identifier
 N ICDF,ICDID S ICDF=$$FILE^ICDEX($G(FILE))
 I "^80^80.1^"'[("^"_FILE_"^") Q ""
 S ICDID=$G(ID) Q:'$L($G(ICDID)) ""
 Q:ICDF=80 $O(^ICDID("B",ICDID,""))
 Q:ICDF=80.1 $O(^ICDIP("B",ICDID,""))
 Q ""
IDSTR(FILE,IEN) ; Return ICD identifier string (legacy)
 ; 
 ; Input:
 ;
 ;   FILE      File Number or root (required)
 ;               80 or ^ICD9     = File #80
 ;               80.1 or ^ICD0   = File #80.1
 ;   IEN       Diagnosis/Procedure code IEN (required)
 ;   
 ; Output:
 ; 
 ;   $$IDSTR   String of Identifiers delimited by a semi-colon
 ;   
 ;               ID;ID;ID
 ;   
 N ICDA,ICDT,ICDS,ICDI S ICDT=$$ICDIDS($G(FILE),$G(IEN),.ICDA),ICDS=""
 S ICDI="" F  S ICDI=$O(ICDA(ICDI)) Q:'$L(ICDI)  S ICDS=ICDS_";"_ICDI
 F  Q:$E(ICDS,1)'=";"  S ICDS=$E(ICDS,2,$L(ICDS))
 Q ICDS
ICDIDS(FILE,IEN,ARY) ; Return array of ICD identifiers
 ; 
 ; Input:
 ;
 ;   FILE      File Number or root (required)
 ;               80 or ^ICD9     = File #80
 ;               80.1 or ^ICD0   = File #80.1
 ;   IEN       Diagnosis/Procedure code IEN (required)
 ;   ARY       Array Name passed by reference (required)
 ;   
 ; Output:
 ; 
 ;   $$ICDIDS  Number of Identifiers found
 ;             0 (zero) if no identifiers found
 ;             
 ;             or upon error -1^error message 
 ;                
 ;   ARY       Array of identifiers found
 ;                ARY(<identifier>)=""
 ;                
 K ARY N ICDC,ICDF,ICDI,ICDID,ICDIDI,ICDRT,ICDRTI,ICDSTR,ICDX,ICDP,ICDCS
 S ICDF=$$FILE^ICDEX($G(FILE)),(ICDI,ICDC)=$G(IEN)
 I "^80^80.1^"'[("^"_ICDF_"^") Q "-1^Invalid File"
 S ICDRT=$$ROOT^ICDEX(ICDF),ICDRTI=$S(ICDF=80:"^ICDID(",1:"^ICDIP(")
 I "^ICD9(^ICD0(^"'[("^"_$E(ICDRT,2,$L(ICDRT))_"^") Q "-1^Invalid Global"
 I '$D(@(ICDRT_+ICDI_")")),$D(@(ICDRT_"""BA"","""_($G(ICDC)_" ")_""")")) D
 . S ICDI=$O(@(ICDRT_"""BA"","""_($G(ICDC)_" ")_""",0)"))
 Q:+ICDI'>0!('$D(@(ICDRT_+ICDI_")"))) "-1^Invalid IEN"
 S ICDCS=+($P($G(@(ICDRT_+ICDI_",1)")),"^",1))
 S (ICDC,ICDIDI)=0 F  S ICDIDI=$O(@((ICDRT_+ICDI_",73,"_+ICDIDI_")"))) Q:+ICDIDI'>0  D
 . S ICDID=$G(@((ICDRT_+ICDI_",73,"_+ICDIDI_",0)")))
 . S ICDID=$P($G(@((ICDRTI_+ICDID_",0)"))),"^",1) Q:'$L(ICDID)
 . I '$D(ARY(ICDID)) S ARY(ICDID)="",ICDC=ICDC+1
 I ICDC'>0,ICDCS>0,ICDCS'>2 D
 . N ICDV I ICDF=80 D
 . . S ICDV="^H^V^p^F^J^T^A^P^d^Y^t^r^l^E^K^R^O^I^G^D^m^S^u^X^a^B^"
 . . S ICDV=ICDV_"b^z^M^U^L^v^k^h^i^j^Q^W^Z^c^s^g^1^2^3^4^5^6^*^"
 . I ICDF=80.1 D
 . . S ICDV="^H^N^E^g^a^K^S^T^O^L^I^c^n^s^d^z^y^e^D^R^P^o^l^b^t^B^"
 . . S ICDV=ICDV_"h^p^m^M^q^r^u^x^F^k^f^V^C^Q^I^J^1^2^3^4^6^7^"
 . S ICDSTR=$P($G(@(ICDRT_+ICDI_",1)")),"^",2) I $L(ICDSTR) D
 . . N ICDX,ICDP F ICDP=1:1 S ICDX=$E(ICDSTR,ICDP) Q:'$L(ICDX)  D
 . . . I $L(ICDX),$L(ICDRTI),$D(@(ICDRTI_"""B"")")) D  Q
 . . . . I $D(@(ICDRTI_"""B"","""_$G(ICDX)_""")")) D
 . . . . . S ARY(ICDX)="",ICDC=ICDC+1
 . . . I ICDV[("^"_ICDX_"^") D  Q
 . . . . I '$D(ARY(ICDX)) S ARY(ICDX)="",ICDC=ICDC+1
 Q ICDC
ISOWNCC(IEN,CDT,FMT) ; Return CC if DX is Own CC
 ; 
 ; Input:
 ;
 ;   IEN        Internal Entry Number for file 80 (required)
 ;   CDT        Date to use to extract CC (default TODAY)
 ;   FMT        Output Format
 ;                 0 = CC only (default)
 ;                 1 = CC ^ Effective Date
 ; Output:
 ; 
 ;   $$ISOWNCC  Complication/Comorbidity (CC) 
 ;  
 ;              DX is Own CC  Format  Output
 ;              ------------  ------  -------------------------
 ;                   Yes        0     CC Value
 ;                   Yes        1     CC Value ^ Effective Date
 ;                   No        N/A    0 (zero)
 ;              
 ;             or upon error -1^error message 
 ;                
 N ICDC,ICDCC,ICDCCI,ICDD,ICDFMT,ICDI,ICDN,ICDOWN,ICDRT
 S (ICDI,ICDC)=$G(IEN),ICDRT=$$ROOT^ICDEX(80)
 I '$D(^ICD9(+ICDI,0)),$D(^ICD9("BA",(ICDC_" "))) D
 . S ICDI=$O(^ICD9("BA",(ICDC_" "),0))
 Q:+ICDI'>0!('$D(^ICD9(+ICDI,0))) "-1^Invalid IEN"
 S ICDD=$P($G(CDT),".",1) S:ICDD'?7N ICDD=$$DT^XLFDT
 S ICDFMT=+($G(FMT)) S:ICDFMT'=1 ICDFMT=0
 S ICDD=$O(^ICD9(+ICDI,69,"B",CDT+.0001),-1) Q:'$L(ICDD) 0
 S ICDCCI=$O(^ICD9(+ICDI,69,"B",ICDD,""),-1)
 S ICDN=^ICD9(+ICDI,69,+ICDCCI,0),ICDOWN=$P(ICDN,U,3)
 Q:'ICDOWN 0  S ICDCC=$P(ICDN,U,2)
 S:ICDFMT>0 ICDCC=ICDCC_"^"_$P(^ICD9(+ICDI,69,+ICDCCI,0),U,1)
 Q ICDCC
ICDRGCC(DRG,CDT) ; Get CC/MCC flag from DRG
 ; 
 ; Input:
 ;
 ;   DRG        Internal Entry Number for file 80.2 (required)
 ;   CDT        Date to use to extract CC/MCC flag (default TODAY)
 ;   
 ; Output:
 ; 
 ;   $$ICDRGCC  Complication/Comorbidity/Major CC flag
 ;   
 ;                 0   No CC or MCC
 ;                 1   CC present 
 ;                 2   MCC present
 ;                 3   CC or MCC present
 ;  
 ;             or upon error -1^error message 
 ;                
 N ICDAI,ICDCC,ICDD,ICDDA,ICDDE,ICDRG,ICDI
 S ICDRG=$G(DRG),ICDD=$P($G(CDT),".",1) S:ICDD'?7N ICDD=$$DT^XLFDT
 S ICDDE=$$FMTE^XLFDT($P(ICDD,".",1),"5Z"),ICDCC="-1^DRG not found"
 S ICDI=$O(^ICD("B","DRG"_ICDRG,"")) I ICDI D
 . S ICDCC="-1^No DRG for date"_$S($L($G(ICDDE)):(" "_$G(ICDDE)),1:"")
 . S ICDDA=$O(^ICD(ICDI,2,"B",(ICDD_".1")),-1) I ICDDA D
 . . S ICDAI=$O(^ICD(ICDI,2,"B",ICDDA,"")) I ICDAI D
 . . . S ICDCC=$P(^ICD(ICDI,2,ICDAI,0),U,4)
 Q ICDCC
INQ ; Inquire to ICD codes (interactive)
 ; 
 ; User will be prompted for:
 ;   
 ;           Effective Date
 ;           File
 ;           Code
 ;   
 ; Displays  Code
 ;           Short Text
 ;           Description
 ;           Description Warnings (if any)
 ;             Text may be inaccurate, Effective Date
 ;                Predates Code Set Versioning
 ;                Predates Coding System Implementation
 ;                Predates Initial Activation Date
 ;           Activation Warnings (if any)
 ;              Code is Inactive
 ;              Code is pending (activated in the future)
 ;   
 N DIC,DIROUT,DIRUT,DTOUT,DUOUT,ICDA,ICDACT,ICDC,ICDCOM,ICDCS
 N ICDCSI,ICDDAT,ICDDT,ICDEFF,ICDF,ICDFMT,ICDI,ICDIA,ICDIEN
 N ICDIMP,ICDINA,ICDLT,ICDMSG,ICDR,ICDSO,ICDST,ICDSTA,ICDT,Y
INQ2 ; Inquire to ICD codes (recursive)
 S ICDDT=$$EFD^ICDEX,ICDEFF=$P(ICDDT,"^",1) I ICDEFF'?7N W !!,"   Effective Date not specified" Q
 W ! S ICDCS=$$CS^ICDEX(,,ICDEFF) I +ICDCS'>0 W !!,"   File not specified" Q
 S ICDCSI=$$SINFO^ICDEX(+ICDCS),ICDF=$P(ICDCSI,"^",4),(DIC,ICDR)=$$ROOT^ICDEX(ICDF),DIC(0)="AEQMZ"
 S DIC("A")=" Select "_$P($P(ICDCSI,"^",2)," ",1)_" "_$P(ICDCSI,"^",6)_" Code:  ",ICDFMT=2
 W ! D ^DIC W:$D(DTOUT) !!,"   Try again later" Q:$D(DTOUT)  Q:$D(DUOUT)!($D(DIRUT))!($D(DIROUT))
 W:+($G(Y))'>0 !!,"   Code not selected" Q:+($G(Y))'>0  S ICDIEN=+($G(Y)),ICDCS=$$CSI^ICDEX(ICDF,+ICDIEN)
 S ICDCSI=$$SINFO^ICDEX(+ICDCS) S:ICDF=80 ICDDAT=$$ICDDX^ICDEX(+ICDIEN,ICDEFF,,"I")
 S:ICDF=80.1 ICDDAT=$$ICDOP^ICDEX(+ICDIEN,ICDEFF,,"I") S ICDSO=$G(Y(0,0))
 S:ICDF="80" ICDST=$P(ICDDAT,"^",4) S:ICDF="80.1" ICDST=$P(ICDDAT,"^",5)
 S ICDLT=$G(Y(0,2)) K ICDA S ICDC=$$LD^ICDEX(ICDF,ICDIEN,ICDEFF,.ICDA,64) I $P(ICDC,"^",1)="-1" D
 . N ICDCOM,ICDT S ICDCOM="" I $P(ICDLT,"^",1)="-1",$L($P(ICDLT,"^",2)) D
 . . S ICDCOM="No description available for "_$$FMTE^XLFDT(ICDEFF)
 . K ICDA S ICDC=$$LD^ICDEX(ICDF,ICDIEN,9990101,.ICDA,64)
 S ICDSTA=$P(ICDDAT,"^",10),ICDINA=$P(ICDDAT,"^",12)
 S:ICDF="80" ICDACT=$P(ICDDAT,"^",17) S:ICDF="80.1" ICDACT=$P(ICDDAT,"^",13)
 S ICDMSG(1)=$$MSG^ICDEX(ICDEFF,+($G(ICDCS)))
 S:$L(ICDMSG(1)) ICDMSG(1)="Descriptive text may be inaccurate, predates Code Set Versioning"
 S ICDIMP=$$IMP^ICDEX(+($G(ICDCS))),ICDIA=$$IA^ICDEX(ICDF,+ICDIEN)
 I ICDIMP?7N,ICDEFF?7N,ICDEFF<ICDIMP D
 . N ICDT S ICDT=$P($P($G(ICDCSI),"^",2)," ",1)
 . S ICDMSG(1)="Descriptive text may be inaccurate, predates implementation date"
 . S:$L(ICDT) ICDMSG(1)="Descriptive text may be inaccurate, user input predates "
 . S:$L(ICDT) ICDMSG(1)=ICDMSG(1)_ICDT_" implementation date of "_$$FMTE^XLFDT(ICDIMP,"5Z")
 I ICDIA?7N,ICDEFF?7N,ICDEFF<ICDIA D
 . N ICDT S ICDT=$P($P($G(ICDCSI),"^",2)," ",1)
 . S ICDMSG(1)="Descriptive text may be inaccurate, predates the initial activation date"
 . S:$L(ICDT) ICDMSG(1)="Descriptive text may be inaccurate, user input predates "
 . S:$L(ICDT) ICDMSG(1)=ICDMSG(1)_" the code's initial activation date of "
 . S:$L(ICDT) ICDMSG(1)=ICDMSG(1)_$$FMTE^XLFDT(ICDIA,"5Z")
 D:$L($G(ICDMSG(1))) PAR^ICDEX(.ICDMSG,64)
 W !!," ",ICDSO,?15,ICDST S (ICDC,ICDI)=0 F  S ICDI=$O(ICDA(ICDI)) Q:+ICDI'>0  D
 . Q:'$L($G(ICDA(ICDI)))  S ICDC=ICDC+1
 . W ! W:ICDC=1 !," Description" W ?15,$G(ICDA(ICDI))
 W:$L($G(ICDMSG(1))) ! F ICDI=1:1:3 W:$L($G(ICDMSG(ICDI))) !,?15,$G(ICDMSG(ICDI))
 I +($G(ICDSTA))'>0,$G(ICDINA)?7N D
 . W !!,?15,"      ** CODE INACTIVE AS OF:  ",$$FMTE^XLFDT(ICDINA,"5Z")," **",!
 I +ICDSTA>0,ICDACT>ICDEFF D
 . W !!,?15,"      ** PENDING ACTIVATION ON:  ",$$FMTE^XLFDT(ICDACT,"5Z")," **",!
 G INQ2
 Q 
