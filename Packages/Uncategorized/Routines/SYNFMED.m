SYNFMED ;OSE/SMH - Add Medications to Patient Record;Dec 24, 2018@21:29
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ; (C) 2018 Sam Habiel
 ; See accompanying license for terms of use.
 ;
 ; TODO list
 ; - Implement Web Services lookup
 ; - See if you can add old meds (not on market) to VistA as patient drugs
 ;
RXN2MEDS(RXN) ; [Public] Get Drugs that are associated with an RxNorm
 Q $$MATCHVM($$RXN2VUI(RXN))
 ;
RXN2VUI(RXN) ; [Public] Get ^ delimited VUIDs for an RxNorm
 N VUIDS S VUIDS=""
 n file
 I $T(^ETSRXN)]"" d  quit VUIDS
 . n fileVUIDs s fileVUIDs=$$ETSRXN2VUID(RXN)
 . n i f i=1:1:$l(fileVUIDs,U) do
 .. n fileVUID s fileVUID=$p(fileVUIDs,U,i)
 .. s file=$p(fileVUID,"~")
 .. i file'=50.68 quit
 .. n vuid s vuid=$p(fileVUID,"~",2)
 .. s VUIDS=VUIDS_vuid_U
 . i $e(VUIDS,$l(VUIDS))=U S $E(VUIDS,$L(VUIDS))=""
 ;
 ; TODO: Rest is not implemented yet.
 N URL S URL="https://rxnav.nlm.nih.gov/REST/rxcui/{RXN}/property.json?propName=VUID"
 N % S %("{RXN}")=RXN
 S URL=$$REPLACE^XLFSTR(URL,.%)
 N C0CRETURN
 D GET(.C0CRETURN,URL)
 N C0COUT
 D DECODE^XLFJSON($NA(C0CRETURN),$NA(C0COUT))
 N J F J=0:0 S J=$O(C0COUT("propConceptGroup","propConcept",J)) Q:'J  D
 . S VUIDS=VUIDS_C0COUT("propConceptGroup","propConcept",J,"propValue")_U
 S $E(VUIDS,$L(VUIDS))="" ; rm trailing ^
 QUIT VUIDS
 ;
RXN2NDC(RXN) ; [Public] Get ^ delimited NDCs for an RxNorm SCD
 I $T(^ETSRXN)]"" Q $$ETSRXN2NDC(RXN)
 ; TODO: Implement web service
 QUIT
 ;
ETSRXN2VUID(RXN) ; [Private] Return delimited list of file~VUID^file~VUID based on ETS
 ; Input: RxNorm Number for IN or CD TTY
 ; Output: file~VUID~name^file~VUID~name..., where file is 50.6 or 50.68.
 ;         or -1^vuid-not-found
 ;
 ; Translate RXN to VUID
 new numVUID set numVUID=+$$RXN2OUT^ETSRXN(RXN)
 if 'numVUID quit:$quit "-1^vuid-not-found" quit
 ;
 ; loop through VUIDs, and grab a good one (CD or IN)
 ; ^TMP("ETSOUT",69531,831533,"VUID",1,0)="296833^831533^VANDF^AB^4031994^N"
 ; ^TMP("ETSOUT",69531,831533,"VUID",1,1)="ERRIN 0.35MG TAB,28"
 new done s done=0
 new out set out=""
 new vuid,name
 new type,file
 new i for i=0:0 set i=$o(^TMP("ETSOUT",$J,RXN,"VUID",i)) quit:'i  do  quit:done
 . new node0 set node0=^TMP("ETSOUT",$J,RXN,"VUID",i,0)
 . new node1 set node1=^TMP("ETSOUT",$J,RXN,"VUID",i,1)
 . set type=$p(node0,U,4)
 . if type'["CD"&(type'["IN") quit
 . ;
 . set vuid=$p(node0,U,5)
 . set file=$s(type["CD":50.68,type["IN":50.6,1:1/0) ; any other type is invalid!
 . set name=node1
 . set out=out_file_"~"_vuid_"~"_name_U
 if $extract(out,$length(out))=U set $extract(out,$length(out))=""
 K ^TMP("ETSOUT",$J)
 quit out
 ;
ETSRXN2NDC(RXN) ; [Private] Return delimited list of NDCs from RxNorm (only active ones)
 ; Translate RXN to VUID
 new numNDC set numNDC=$P($$RXN2OUT^ETSRXN(RXN),U,2)
 if 'numNDC quit:$quit "" quit
 ;
 ; loop through NDCs, and grab good ones
 ; ^TMP("ETSOUT",2199,831533,"NDC")=6
 ; ^TMP("ETSOUT",2199,831533,"NDC",1,0)="600680^831533^831533^RXNORM^N"
 ; ^TMP("ETSOUT",2199,831533,"NDC",1,1)="NDC"
 ; ^TMP("ETSOUT",2199,831533,"NDC",1,2)="00555034458"
 ; ^TMP("ETSOUT",2199,831533,"NDC",2,0)="600681^831533^831533^RXNORM^N"
 ; ^TMP("ETSOUT",2199,831533,"NDC",2,1)="NDC"
 ; ^TMP("ETSOUT",2199,831533,"NDC",2,2)="00555034479"
 new out set out=""
 new type,supp
 new i for i=0:0 set i=$o(^TMP("ETSOUT",$J,RXN,"NDC",i)) quit:'i  do
 . new node0 set node0=^TMP("ETSOUT",$J,RXN,"NDC",i,0)
 . new ndc set ndc=^TMP("ETSOUT",$J,RXN,"NDC",i,2)
 . set type=$p(node0,U,4)
 . set supp=$p(node0,U,5)
 . ;
 . ; We want RxNorm NDCs that are not suppressed.
 . i type'="RXNORM" quit
 . i supp'="N" quit
 . ;
 . set out=out_ndc_U
 if $extract(out,$length(out))=U set $extract(out,$length(out))=""
 K ^TMP("ETSOUT",$J)
 quit out
 ;
RXNCONV(RXN) ; [Private] Convert RxNorm CUI for non SCD to SCD drug
 N FIXED S FIXED=$$RXNBAD(RXN)
 I FIXED Q FIXED
 ;
 I $T(^ETSRXN)]"" Q $$ETSCONV(RXN)
 S $EC=",U-UNIMPLEMENTED,"
 ;
RXNBAD(RXN) ; [Private] Synthea Bad RxNorm Codes Translation
 N RXNBADDATA
 N I,T F I=1:1 S T=$P($T(RXNBADDATA+I),";;",2) Q:T=""  S RXNBADDATA($P(T,";",1))=$P(T,";",2)
 I $D(RXNBADDATA(RXN)) Q RXNBADDATA(RXN)
 Q ""
 ;
RXNBADDATA ;;
 ;;239981;477045
 ;;389128;1363309
 ;;--;--
 ;;308056;1804799
 ;;727374;1660014
 ;;--;--
 ;;564666;705129
 ;;568530;311989
 ;;573839;197319
 ;;575020;105586
 ;;575971;1736776
 ;;596927;596926
 ;;602735;310436
 ;;607015;483438
 ;;608680;313782
 ;;617944;608139
 ;;824184;562251
 ;;849437;198014
 ;;849727;849574
 ;;896188;896209
 ;;904420;904419
 ;;996741;996740
 ;;997221;997223
 ;;1049544;1860154
 ;;1049639;1049221
 ;;1091166;1091392
 ;;1094108;1094107
 ;;1602593;1599803
 ;;1648767;311995
 ;;--;--
 ;;392151;308182
 ;;646250;389221
 ;;727316;1870230
 ;;834060;834061
 ;;834101;834102
 ;;1000128;1000126
 ;;1000158;1000156
 ;;1020137;1043400
 ;;1111011;389221
 ;;1366342;1366343
 ;;1536586;1534809
 ;;1803932;311282
 ;;
ETSCONV(RXN) ; [Private] Convert RxNorm CUI for non SCD to SCD drug using ETS
 N SUC S SUC=$$GETDATA^ETSRXN(RXN)
 I 'SUC Q "0^drug does not exist in RxNorm"
 ;
 ; Is this a semantic clinical drug? If so, just quit, returning this drug.
 N SCD S SCD=$$ETSISSCD(RXN)
 I SCD Q RXN
 ;
 ; Okay it isn't an SCD. Now we need to find out what type it is.
 N TYPE S TYPE=$$ETSTYPE(RXN)
 ;
 ; Now convert the type (SBDC, SBD, SCDC to SCD)
 ; zwrite ^TMP("ETSDATA",$J,RXN,*)
 I TYPE="SBDC" S SCD=$$ETSCONVSBDC(RXN)
 I TYPE="SCDC" S SCD=$$ETSCONVSCDC(RXN)
 I TYPE="SBD"!(TYPE="BPCK") D
 . N VUID S VUID=$$RXN2VUI(RXN)
 . I VUID S SCD=RXN
 . E  S SCD=$$ETSCONVSBD(RXN)
 ;
 ; Must have an SCD at this point
 I 'SCD Q "0^Please send a message for Sam to investigate"
 ;
 QUIT SCD
 ;
ETSISSCD(RXN) ; [Private] Is RXN an SCD?
 N RESULT S RESULT=0
 N I,Z F I=0:0 S I=$O(^TMP("ETSDATA",$J,RXN,"RXCONSO",I)) Q:'I  S Z=^(I,0) D  Q:RESULT
 . I $P(Z,U,4)="SCD" S RESULT=1
 Q RESULT
 ;
ETSISBPCK(RXN) ; [Private] Is RXN a BPCK?
 N RESULT S RESULT=0
 N I,Z F I=0:0 S I=$O(^TMP("ETSDATA",$J,RXN,"RXCONSO",I)) Q:'I  S Z=^(I,0) D  Q:RESULT
 . I $P(Z,U,4)="BPCK" S RESULT=1
 Q RESULT
 ;
ETSTYPE(RXN) ; [Private] What's the type of this RXN? (called only when not SCD)
 N RESULT S RESULT=""
 N I,Z F I=0:0 S I=$O(^TMP("ETSDATA",$J,RXN,"RXCONSO",I)) Q:'I  S Z=^(I,0) D  Q:RESULT]""
 . I $P(Z,U,3)="RXNORM" D
 .. N TYPE S TYPE=$P(Z,U,4)
 .. I TYPE="BPCK" S RESULT=TYPE
 .. I TYPE="SBDC" S RESULT=TYPE
 .. I TYPE="SBD"  S RESULT=TYPE
 .. I TYPE="SCDC" S RESULT=TYPE
 .. I TYPE="SCD"  S RESULT=TYPE
 I "^SBDC^SBD^SCDC^"'[U_RESULT_U S $EC=",U-UNANTICIPATED-RXN-TYPE,"
 Q RESULT
 ;
 ; For the below, everything looks sorta like this.
 ; ^TMP("ETSDATA",1356,1111011,"RXNREL",1,0)="958970^1111011^RB^389221^has_tradename^RXNORM^^4096"
 ; The 4096 we check for means the drug is currently prescribable. This prevents us from reaching
 ; dead ends where the realtionship leads us to a drug not the market and thus may not be a drug
 ; we can write for in VistA.
 ;
ETSCONVSBDC(RXN) ; [Private] Convert RxnCUI SBDC -> SCD
 ; Convert to SCDC first and then to SCD
 N RESULT S RESULT=0
 N I,Z F I=0:0 S I=$O(^TMP("ETSDATA",$J,RXN,"RXNREL",I)) Q:'I  S Z=^(I,0) D  Q:RESULT
 . I $P(Z,U,5)="consists_of",$P(Z,U,8)=4096 S RESULT=$P(Z,U,4)
 N % S %=$$GETDATA^ETSRXN(RESULT) ; **WARNING: CONTEXT CHANGE**
 Q $$ETSCONVSBD(RESULT)
 ;
ETSCONVSBD(RXN)  ; [Private] Convert RxnCUI SBD -> SCD
 N RESULT S RESULT=0
 N I,Z F I=0:0 S I=$O(^TMP("ETSDATA",$J,RXN,"RXNREL",I)) Q:'I  S Z=^(I,0) D  Q:RESULT
 . I $P(Z,U,5)="has_tradename",$P(Z,U,8)=4096 S RESULT=$P(Z,U,4)
 Q RESULT
 ;
ETSCONVSCDC(RXN) ; [Private] Convert RxnCUI SCDC -> SCD
 K ^TMP("SYNDATA",$J,RXN)
 M ^TMP("SYNDATA",$J,RXN)=^TMP("ETSDATA",$J,RXN)
 N RESULT S RESULT=0
 N SYNI,Z F SYNI=0:0 S SYNI=$O(^TMP("ETSDATA",$J,RXN,"RXNREL",SYNI)) Q:'SYNI  S Z=^(SYNI,0) D  Q:RESULT
 . I $P(Z,U,5)="consists_of",$P(Z,U,8)=4096 S RESULT=$P(Z,U,4)
 . I 'RESULT QUIT  ; previous line didn't return anything, try again
 . N % S %=$$GETDATA^ETSRXN(RESULT) ; delete previous data
 . N TYPE S TYPE=$$ETSTYPE(RESULT)  ; uses new context
 . I TYPE'="SCD" S RESULT=0
 . K ^TMP("ETSDATA",$J,RXN) M ^TMP("ETSDATA",$J,RXN)=^TMP("SYNDATA",$J,RXN) ; restore context
 Q RESULT
 ;
MATCHVM(VUIDS) ; [Public] Match delimited list of VUIDs to delimited set of drugs (not one to one)
 N MATCHES S MATCHES=""
 N I,VUID
 F I=1:1 S VUID=$P(VUIDS,U,I) Q:VUID=""  D
 . N MATCH S MATCH=$$MATCHV1(VUID)
 . I MATCH S MATCHES=MATCHES_MATCH_U
 S $E(MATCHES,$L(MATCHES))="" ; rm trailing ^
 QUIT MATCHES
 ;
 ;
MATCHV1(VUID) ; [Public] Match a single VUID to a set of drugs.
 N VAP S VAP=$$VUI2VAP(VUID) ; says it's supposed to be plural, but that's not possible??
 I 'VAP S $EC=",U-VUID-SHOULD-NOT-BE-MISSING,"
 N MEDS S MEDS=$$VAP2MED(VAP)
 QUIT MEDS
 ;
VUI2VAP(VUID) ; $$ Public - Get VA Product IEN(s) from VUID
 ; Input VUID by Value
 ; Output: Extrinsic
 D FIND^DIC(50.68,,"@","QP",VUID,,"AVUID") ; Find all in VUID index
 N O S O="" ; Output
 N I F I=0:0 S I=$O(^TMP("DILIST",$J,I)) Q:'I  S O=O_^(I,0)_U ; Concat results together
 S O=$E(O,1,$L(O)-1) ; remove trailing ^
 Q O
 ;
VAP2MED(VAPROD) ; $$ Public - Get Drug(s) using VA Product IEN
 ; Un-Unit-testable: Drug files differ between sites.
 ; Input: VA Product IEN By Value
 ; OUtput: Caret delimited extrinsic
 ; This code inspired from PSNAPIs
 ; WHY THE HELL WOULD I USE A TEXT INDEX?
 ; It's my only option. Creating new xrefs on the drug file doesn't help
 ; as they are not filled out when adding a drug (IX[ALL]^DIK isn't called).
 N MEDS S MEDS="" ; result
 N PN,PN1 ; Product Name, abbreviated product name.
 S PN=$P(^PSNDF(50.68,VAPROD,0),"^"),PN1=$E(PN,1,30)
 N P50 S P50=0 ; looper through VAPN index which is DRUG file entry
 F  S P50=$O(^PSDRUG("VAPN",PN1,P50)) Q:'P50  D  ; for each text match
 . I $P(^PSDRUG(P50,"ND"),"^",3)=VAPROD S MEDS=$G(MEDS)_P50_U  ; check that the VA PRODUCT pointer is the same as ours.
 S:MEDS MEDS=$E(MEDS,1,$L(MEDS)-1) ; remove trailing ^
 Q MEDS
 ;
ADDDRUG(RXN,BARCODE) ; [Public] Add Drug to Drug File
 ; Input: RXN - RxNorm Semantic Clinical Drug CUI by Value. Required.
 ; Input: BARCODE - Wand Barcode. Optional. Pass exactly as wand reads minus control characters.
 ; Output: Internal Entry Number
 ;
 ; Get first VUID for this RxNorm drug
 N VUID S VUID=+$$RXN2VUI(RXN)
 Q:'VUID ""
 G NEXT
ADDDRUG2(RXN,VUID) ;
 ; ZEXCEPT: NDC,BARCODE
NEXT ;
 N PSSZ S PSSZ=1    ; Needed for the drug file to let me in!
 ;
 ; W "(debug) VUID for RxNorm CUI "_RXN_" is "_VUID,!
 ;
 ; IEN in 50.68
 N C0XVUID ; For Searching Compound Index
 S C0XVUID(1)=VUID
 S C0XVUID(2)=1
 N F5068IEN S F5068IEN=$$FIND1^DIC(50.68,"","XQ",.C0XVUID,"AMASTERVUID")
 Q:'F5068IEN ""
 ;
 ; W "F 50.68 IEN (debug): "_F5068IEN,!
 ;
 ; Guard against adding the drug back in again.
 N EXISTING S EXISTING=$$VAP2MED(F5068IEN)
 I EXISTING Q EXISTING
 ;
 ; FDA Array
 N C0XFDA
 ;
 ; Name, shortened
 S C0XFDA(50,"+1,",.01)=$E($$GET1^DIQ(50.68,F5068IEN,.01),1,40)
 ;
 ; File BarCode as a Synonym for BCMA
 I $L($G(BARCODE)) D
 . S C0XFDA(50.1,"+2,+1,",.01)=BARCODE
 . S C0XFDA(50.1,"+2,+1,",1)="Q"
 ;
 N NDCS S NDCS=$$RXN2NDC^SYNFMED(RXN)
 N NDC S NDC=$P(NDCS,U,1)
 ;
 ; NDC field
 I NDC S C0XFDA(50,"+1,",31)=$E(NDC,1,5)_"-"_$E(NDC,6,9)_"-"_$E(NDC,10,11)
 ;
 ; NDCs to synonyms
 I NDCS]"" N C0XI F C0XI=1:1:$L(NDCS,U) D
 . S NDC=$P(NDCS,U,C0XI)
 . S C0XFDA(50.1,"+"_(C0XI+10)_",+1,",.01)=NDC
 . S C0XFDA(50.1,"+"_(C0XI+10)_",+1,",1)="Q"
 . S C0XFDA(50.1,"+"_(C0XI+10)_",+1,",2)=NDC
 ;
 ; Brand Names & NDCs
 ; N NDCS
 ; N URL S URL="https://rxnav.nlm.nih.gov/REST/rxcui/{RXN}/ndcs.json"
 ; N % S %("{RXN}")=RXN
 ; S URL=$$REPLACE^XLFSTR(URL,.%)
 ; N C0CRETURN
 ; D GET(.C0CRETURN,URL)
 ; N C0COUT
 ; D DECODE^XLFJSON($NA(C0CRETURN),$NA(C0COUT))
 ; ZWRITE C0COUT
 ; QUIT
 ; ;
 ; N BNS S BNS="" ; S BNS=$$RXN2BNS^C0CRXNLK(RXN) ; Brands
 ; I $L(BNS) N I F I=1:1:$L(BNS,U) D
 ; . N IENS S IENS=I+2
 ; . S C0XFDA(50.1,"+"_IENS_",+1,",.01)=$$UP^XLFSTR($E($P(BNS,U,I),1,40))
 ; . S C0XFDA(50.1,"+"_IENS_",+1,",1)="T"
 ;
 ;
 ; Dispense Unit (string)
 S C0XFDA(50,"+1,",14.5)=$$GET1^DIQ(50.68,F5068IEN,"VA DISPENSE UNIT")
 ;
 ; National Drug File Entry (pointer to 50.6)
 S C0XFDA(50,"+1,",20)="`"_$$GET1^DIQ(50.68,F5068IEN,"VA GENERIC NAME","I")
 ;
 ; VA Product Name (string)
 S C0XFDA(50,"+1,",21)=$E($$GET1^DIQ(50.68,F5068IEN,.01),1,70)
 ;
 ; PSNDF VA PRODUCT NAME ENTRY (pointer to 50.68)
 S C0XFDA(50,"+1,",22)="`"_F5068IEN
 ;
 ; DEA, SPECIAL HDLG (string)
 D  ; From ^PSNMRG ; ZEXCEPT: n
 . N CS S CS=$$GET1^DIQ(50.68,F5068IEN,"CS FEDERAL SCHEDULE","I")
 . S CS=$S(CS?1(1"2n",1"3n"):+CS_"C",+CS=2!(+CS=3)&(CS'["C"):+CS_"A",1:CS)
 . S C0XFDA(50,"+1,",3)=CS
 ;
 ; NATIONAL DRUG CLASS (pointer to 50.605) (triggers VA Classification field)
 S C0XFDA(50,"+1,",25)="`"_$$GET1^DIQ(50.68,F5068IEN,"PRIMARY VA DRUG CLASS","I")
 ;
 ; Right Now, I don't file the following which ^PSNMRG does (cuz I don't need them)
 ; - Package Size (derived from NDC/UPN file)
 ; - Package Type (ditto)
 ; - CMOP ID (from $$PROD2^PSNAPIS)
 ; - National Formulary Indicator (from 50.68)
 ;
 ; Next Step is to kill Old OI if Dosage Form doesn't match
 ; Won't do that here as it's assumed any drugs that's added is new.
 ; This happens at ^PSNPSS
 ;
 ; Now add drug to drug file, as we need the IEN for the dosages call.
 N C0XERR,C0XIEN
 D UPDATE^DIE("E","C0XFDA","C0XIEN","C0XERR")
 S:$D(C0XERR) $EC=",U1,"
 ;
 ; Next Step: Kill off old doses and add new ones.
 D EN2^PSSUTIL(C0XIEN(1))
 ;
 ; Mark uses for the Drug; use the undocumented Silent call in PSSGIU
 N PSIUDA,PSIUX ; Expected Input variables
 S PSIUDA=C0XIEN(1),PSIUX="O^Outpatient Pharmacy" D ENS^PSSGIU
 S PSIUDA=C0XIEN(1),PSIUX="U^Unit Dose" D ENS^PSSGIU
 S PSIUDA=C0XIEN(1),PSIUX="X^Non-VA Med" D ENS^PSSGIU
 ;
 ; Get VA Generic text and VA Product pointer for Orderable Item creation plus dosage form information
 N VAGENP S VAGENP=$P(^PSDRUG(C0XIEN(1),"ND"),U) ; VA Generic Pointer
 N VAGEN S VAGEN=$$VAGN^PSNAPIS(VAGENP) ; VA Generic Full name
 N VAPRODP S VAPRODP=$P(^PSDRUG(C0XIEN(1),"ND"),U,3) ; VA Product Pointer
 N DOSAGE S DOSAGE=$$PSJDF^PSNAPIS(0,VAPRODP) ; IEN of dose form in 50.606 ^ Text
 N DOSEPTR S DOSEPTR=$P(DOSAGE,U) ; ditto
 N DOSEFORM S DOSEFORM=$P(DOSAGE,U,2) ;ditto
 ;
 ; Get the (possibly new) Orderable Item Text
 N VAG40 S VAG40=$E(VAGEN,1,40) ; Max length of .01 field
 ;
 ; See if there is an existing orderable item already. If so, populate the Pharmacy Orderable item on drug file.
 N OI S OI=$O(^PS(50.7,"ADF",VAG40,DOSEPTR,""))
 ;
 ; Otherwise, add a new one. (See MCHAN+12^PSSPOIMN)
 N FLAGNEWOI S FLAGNEWOI=0
 I 'OI D
 . N C0XFDA,C0XERR
 . S C0XFDA(50.7,"+1,",.01)=VAG40
 . S C0XFDA(50.7,"+1,",.02)=DOSEPTR
 . D UPDATE^DIE("",$NA(C0XFDA),$NA(OI),$NA(C0XERR))
 . I $D(C0XERR) S $EC=",U1,"
 . S OI=OI(1) ; For ease of use...
 . S FLAGNEWOI=1
 ;
 ; Add the orderable Item to the drug file.
 N C0XFDA,C0XERR S C0XFDA(50,C0XIEN(1)_",",2.1)=OI ; Orderable Item
 D FILE^DIE("",$NA(C0XFDA),$NA(C0XERR))
 ;
 ; Mailman throws an error into DIERR, which ANNOYS me! So we won't check for errors here.
 ; S:$D(C0XERR) $EC=",U1,"
 ; Special $ZSTEP to find the problem: zp @$zpos b:($g(olddierr)'=$g(DIERR))  s olddierr=$g(DIERR) zstep into
 ;
 ; Previously, we did the CPRS HL7 message here; but we don't need to anymore. The OI xref does it for us.
 ;
EX QUIT C0XIEN(1)
 ;
GET(RETURN,URL) ; [Public] Get a URL
 ; ZEXCEPT: %XOBWERR
 ;
 ; Timeout
 N TO S TO=5
 N HEADERS
 ; Action
 N STATUS S STATUS=$$GETURL^XTHC10(URL,TO,$NA(RETURN)),HEADERS("STATUS")=STATUS
 ;
 ; ZWRITE HEADERS
 ; ZWRITE RETURN
 ;
 ; Check status code to be 200.
 I "^200^302^"'[HEADERS("STATUS") S %XOBWERR=HEADERS("STATUS"),$EC=",UXOBWHTTP,"
 QUIT
 ;
WRITERXRXN(PSODFN,RXNCUI,RXDATE) ; [$$/D Public] Create a new prescription for a patient using RxNorm SCD CUI
 ; Input: PSODFN = DFN
 ; Input: RXNCUI = RxNorm CUI. ONLY SCD, SCDC, SBDC, or SBD types only
 ; Input: RXDATE = Prescription Date
 ;
 ; $$ Output: Prescription Number (not IEN) or -1^error message or -2^error message
 ;
 ; Convert RXNCUI to SCD
 N RXNCDCUI S RXNCDCUI=$$RXNCONV(RXNCUI)
 I 'RXNCDCUI Q -2_U_"RxNorm CUI "_RXNCUI_" is not a valid RxNorm. Please check using RxNav or similar"
 ;
 N DRUG S DRUG=$$ADDDRUG(RXNCDCUI)
 I 'DRUG Q -1_U_"RxNorm CUI "_RXNCUI_" could not be resolved into a drug."
 S DRUG=$P(DRUG,U) ; in case we get multiple drugs back; reported by George.
 I $QUIT QUIT $$WRITERXPS(PSODFN,DRUG,RXDATE)
 D WRITERXPS(PSODFN,DRUG,RXDATE)
 QUIT
 ;
WRITERXPS(PSODFN,DRUG,RXDATE) ; [$$/D Public] Create a new prescription for a patient using drug IEN
 ; Input: PSODFN = DFN
 ; Input: DRUG = Drug (file 50) IEN
 ; Input: RXDATE = Prescription Date
 ; $$ Output: Prescription Number (not IEN) or -1^error message
 ;
 ; Site Parameters (see PSOLSET)
 N PSOSITE S PSOSITE=$$PSOSITE^SYNINIT()
 N PSOPAR,PSOPAR7,PSOSYS,PSODTCUT,PSOPRPAS
 S PSOPAR=$G(^PS(59,PSOSITE,1)),PSOPAR7=$G(^PS(59,PSOSITE,"IB")),PSOSYS=$G(^PS(59.7,1,40.1)) D CUTDATE^PSOFUNC
 ;
 ; Add Patient to File 55 DINUMMED to 2
 N FDA,IEN,DIERR
 S FDA(55,"?+1,",.01)="`"_PSODFN
 S IEN(1)=PSODFN
 S FDA(55,"?+1,",3)="OPC" ; A convenient Patient Status
 D UPDATE^DIE("E","FDA","IEN")
 I $D(DIERR) S $EC=",U-UPDATE-FAILED,"
 ;
 ; Pharmacist (we use the value multiple times)
 N SYNPHARM S SYNPHARM=$$PHARM^SYNINIT()
 ; Drug Array we will pass by reference
 N PSONEW
 ;
 ; Call to get drug demographics
 N PSOY
 S PSOY=DRUG
 S PSOY(0)=^PSDRUG(DRUG,0)
 N PSODRUG
 D SET^PSODRG
 M PSONEW=PSODRUG
 ;
 ; Days and refills
 S PSONEW("ISSUE DATE")=RXDATE
 S PSONEW("FILL DATE")=RXDATE
 S PSONEW("DAYS SUPPLY")=30
 S PSONEW("# OF REFILLS")=1
 ;
 ; Pharmacist here!
 S PSONEW("VERIFY")=1
 S PSONEW("PHARMACIST")=SYNPHARM
 S PSONEW("CLERK CODE")=SYNPHARM ; Needed for CPRS for "Entered By" field.
 ;
 ; Provider
 S PSONEW("PROVIDER")=$$PROV^SYNINIT()
 ;
 ; Clinic
 S PSONEW("CLINIC")=$$HL^SYNINIT()
 ;
 ; Get Prescription Number
 D AUTO^PSONRXN
 ;
 N SYNRXN S SYNRXN=PSONEW("RX #")
 ;
 ; Dosage
 S PSONEW("ENT")=1
 S PSONEW("DOSE",PSONEW("ENT"))="ONE TABLET DAILY"
 ;
 ; Copay
 N PSOSCP S PSOSCP=""
 ;
 ; Quantity
 S PSONEW("QTY")=30 ; Non-sense number
 ;
 ; Counseling
 N PSOCOU,PSOCOUU
 S PSOCOU=1,PSOCOUU=1
 ;
 ; Nature of order
 N PSONOOR S PSONOOR="W"
 ;
 ; Mail/Window - defaults to mail; override to Window
 S PSONEW("MAIL/WINDOW")="W"
 ;
 ; Patient Status
 S PSONEW("PATIENT STATUS")=$$FIND1^DIC(53,,"QX","OPC")
 ;
 ; File in 52
 D EN^PSON52(.PSONEW)
 ;
 ; Needed for release later (see PSODISP)
 N PSIN S PSIN=+$P($G(^PS(59.7,1,49.99)),"^",2)
 N SYNRXIEN S SYNRXIEN=PSONEW("IRXN")
 ;
 ; HL7 to OE/RR to update the Order File
 D EOJ^PSONEW
 ;
 ; Print Prescription (required for releasing)
 ; NB: We are not checking for POP
 N IOP S IOP="NULL"
 N %ZIS S %ZIS=0
 D ^%ZIS U IO
 ; Ignore POP as we don't care if we can't write to device. We want IOST specs.
 ; ZEXCEPT: %WNULL from the webserver
 I $D(%WNULL) S IO=%WNULL U %WNULL
 N PPL S PPL=SYNRXIEN_","
 N PDUZ S PDUZ=SYNPHARM
 D DQ^PSOLBL
 ;
 ; Release Prescription
 N POERR S POERR=1
 N RXP S RXP=SYNRXIEN
 N PSRH S PSRH=SYNPHARM
 D BATCH^PSODISP
 I '$D(%WNULL) D ^%ZISC
 ;
 QUIT:$QUIT SYNRXN QUIT
 ;
TEST D EN^%ut("SYNFMEDT",3) QUIT
