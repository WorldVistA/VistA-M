DPTLK ;ALB/RMO,RTK - MAS Patient Look-up Main Routine ;Nov 26, 2018@09:20
 ;;5.3;Registration;**32,72,93,73,136,157,197,232,265,277,223,327,244,513,528,541,576,600,485,633,629,647,769,857,876,915,919,OSE/SMH**;Aug 13, 1993;Build 4
 ; OSE/SMH changes (c) Sam Habiel 2018
 ; Licensed under Apache 2.0
 ; Changes done for VistA Internationalization
 ;
 ; mods made for magstripe read 12/96 - JFP
 ; mods made for VIC 4.0 (barcode and magstripe) read 4/2012 - ELZ (*857)
 ;
 ;Optional input: DPTNOFZY='1' to suppress fuzzy lookups implemented
 ;                by patch DG*5.3*244
 ;
EN ; -- Entry point
 N DIE,DR,DGSEARCH,DPTXX
 K DPTX,DPTDFN,DPTSAVX I $D(DIC(0)) G QK:DIC(0)["I"!(DIC(0)'["A"&('$D(X)))
 I '$D(^DD("VERSION")) W !!?3,"Unable to proceed. Fileman version node ^DD(""VERSION"") is undefined." G QK
 I '$D(^DPT(0))!(^DD("VERSION")<17.2) W !!?3,"Unable to proceed. ",$S('$D(^DPT(0)):"0th node of ^DPT missing",^DD("VERSION")<17.2:"Fileman version must be at least 17.2",1:""),"." G QK
EN2 K DO,DUOUT,DTOUT S U="^",DIC="^DPT(",DIC(0)=$S($D(DIC(0)):DIC(0),1:"AELMQ") S:DIC(0)'["A" (DPTX,DPTSAVX)=X
 S DPTSZ=1000 I $D(^DD("OS"))#2 S DPTSZ=$S(+$P(^DD("OS",^("OS"),0),U,2):$P(^(0),U,2),1:DPTSZ)
 ;
ASKPAT ; -- Prompt for patient
 I DIC(0)["A" D   G QK:'$T!($E(DPTX)["^")!(DPTX="")
 .K DTOUT,DUOUT,DGNEW,DGSEARCH
 .W !,$S($D(DIC("A")):DIC("A"),1:"Select PATIENT NAME: ") W:$D(DIC("B")) DIC("B"),"// "
 .R X:DTIME
 .S (DPTX,DPTXX)=X S:'$T DTOUT=1 S:$T&(DPTX="")&($D(DIC("B"))) DPTX=DIC("B") S:DPTX["^"&($E(DPTX)'="%") DUOUT=1
 ; -- Check for the IATA magnetic stripe input
 N MAG,GCHK,BARCODE,DGVIC40,DGCAC
 S (MAG,BARCODE,DGVIC40,DGCAC)=0
 I $E(DPTX)="%"!($E(DPTX)=";"),DPTX["?" S MAG=1,(X,DPTX)=$$IATA(DPTX)
 I 'MAG,DPTX?1"%"1N13ANP.3AN S BARCODE=1,(X,DPTX)=$$BARCODE($$UP^XLFSTR(DPTX))
 ; - read other line but don't use dbia#10096 don't display input
 I $G(DGVIC40),'BARCODE X ^%ZOSF("EOFF") R X(1):1 X ^%ZOSF("EON")
 I 'MAG,'BARCODE,DPTX?1N6AN1A7AN1A2AN S DGCAC=1,(X,DPTX)=$$CACCARD($$UP^XLFSTR(DPTX))
 ; fail VHIC card match but starts with %, we're done
 I 'MAG,'BARCODE,'DGCAC,$E(DPTX,1)="%" G CHKDFN
 ;
CHKPAT ; -- Custom Patient Lookup
 D DO^DIC1
 S DIC("W")=$S($D(DIC("W")):DIC("W"),1:"")
 K DPTIFNS,DPTS,DPTSEL
 S DPTCNT=0
 ; -- Check input for format an length
 ; G CHKDFN:DPTX?1A!(DPTX'?.ANP)!($L(DPTX)>30)&('$G(DGVIC40)) ; OSE/SMH - old line
 G CHKDFN:(DPTX'?.ANP)!($L(DPTX)>30)&('$G(DGVIC40)) ; OSE/SMH - new line - Allow one character input for CJK languages
 ; -- Check for null response or abort
 I DPTX=""!(DPTX["^") G ASKPAT:DIC(0)["A",QK
 ; -- Check for question mark
 I DPTX["?" D  G ASKPAT:DIC(0)["A",QK
 .S D="B"
 .S DZ=$S(DPTX?1"?":"",1:"??")
 .G CHKPAT1:DZ="??"
 .N %
 .W !,?1,"Answer with PATIENT NAME, or SOCIAL SECURITY NUMBER, or last 4 digits",!,?4,"of SOCIAL SECURITY NUMBER, or first initial of"
 .W " last name with last",!,?4,"4 digits of SOCIAL SECURITY NUMBER"
 .W !,?1,"Do you want the entire ",+$P($G(^DPT(0)),"^",4),"-Entry PATIENT List" S %=0 D YN^DICN
 .Q:%'=1
 .S DZ="??"
CHKPAT1 .S X=DPTX
 .D DQ^DICQ
 ; -- Check for space bar, return
 I DPTX=" " D  G CHKDFN
 .S Y=$S('($D(DUZ)#2):-1,$D(^DISV(DUZ,"^DPT(")):^("^DPT("),1:-1)
 .D SETDPT^DPTLK1:Y>0
 .S DPTDFN=$S($D(DPTS(Y)):Y,1:-1)
 ; -- Check for DFN look up
 I $E(DPTX)="`" D  G CHKDFN
 .S Y=$S($D(^DPT(+$P(DPTX,"`",2),0)):+$P(DPTX,"`",2),1:-1)
 .D SETDPT^DPTLK1:Y>0
 .S DPTDFN=$S($D(DPTS(Y)):Y,1:-1)
 ; -- Puts input in correct format
 G CHKDFN:DPTX=""
 ; -- Force new entry
 I $E(DPTX)="""",$E(DPTX,$L(DPTX))="""" G NOPAT
 ; -- Check for EDIPI lookup
 I DPTX?10N,DIC(0)["M" D  G:$G(DPTDFN)>0 CHKDFN
 .N DGEDIPI
 .S DGEDIPI=0 F  S DGEDIPI=$O(^DGCN(391.91,"AISS",DPTX,"USDOD","NI",+$$IEN^XUAF4("200DOD"),DGEDIPI)) Q:'DGEDIPI  I $P($G(^DGCN(391.91,DGEDIPI,2)),"^",3)'="H" Q
 .Q:DGEDIPI<1
 .S Y=$P($G(^DGCN(391.91,DGEDIPI,0)),"^")
 .D SETDPT^DPTLK1:Y>0
 .S DPTDFN=$S($D(DPTS(Y)):Y,1:-1)
 ; -- Check for index lookups
 I '$G(DGVIC40)!(DPTX?9N) D ^DPTLK1  D  G QK:$D(DTOUT)!($D(DUOUT)&(DIC(0)'["A")),ASKPAT:$D(DUOUT),CHKPAT:DPTDFN<0,CHKDFN:DPTDFN>0 I DIC(0)["N",$D(^DPT(DPTX,0)) S Y=X D SETDPT^DPTLK1 S DPTDFN=$S($D(DPTS(Y)):Y,1:-1) G CHKDFN
 . I DPTDFN<1,$P($G(XQY0),"^",2)="Register a Patient",$T(PATIENT^MPIFXMLP)'="",'MAG D
 .. S DPTDFN=$$SEARCH^DPTLK7(DPTX,$G(DPTXX))
 .. I DPTDFN<1 K DO,D,DIC("W"),DPTCNT,DPTS,DPTSEL,DPTSZ S DPTDFN=-1,Y=-1,(DPTX,DPTXX)=""
 .. S DPTSZ=1000 I $D(^DD("OS"))#2 S DPTSZ=$S(+$P(^DD("OS",^("OS"),0),U,2):$P(^(0),U,2),1:DPTSZ)
 .. S:DPTDFN>0 DPTS(DPTDFN)=$P(^DPT(DPTDFN,0),"^")_"^"_$P(^DPT(DPTDFN,0),"^")
MAG ; -- No patient found, check for mag stripe input, create stub
 I 'MAG,'BARCODE,'DGCAC G NOPAT
 ; -- Check for ADT option(s) only
 N DGOPT
 S DGOPT=$P($G(XQY0),"^",2)
 I DGOPT'="Load/Edit Patient Data",DGOPT'="Register a Patient" D  G EN2
 .W !,"    ...Patient not in database, use ADT options to load patient" D Q1
 ; -- Prompt for creation of stub
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Patient not found...Create stub entry: "
 S GCHK=$D(^TMP("DGVIC"))
 D ^DIR
 K DIR
 I 'Y D Q1 G EN2
 ; -- Parse IATA fields
 D @$S(DGVIC40:"VIC40(.DGFLDS,DGVIC40,DGCAC)",1:"FIELDS(IATA)")
 I '$D(@DGFLDS) W !,"Could not add patient to patient file" D Q1 G EN2
 ; -- Check for Duplicates, no checking if VIC 4.0 card or CAC card
 D:'$G(DGVIC40) EP2^DPTLK3
 ; -- No check done on VIC 4.0 or CAC card, so skip DPTDFN value
 ;    check, file record
 I 'DGVIC40,DPTDFN<0 D Q1 G EN2
 ; -- Creates Stub entry in patient file
 S Y=$$FILE^DPTLK4(DGFLDS,$G(DGVIC40))
 I $P(Y,"^",3)'=1 W !,"Could not add patient to patient file" D QK1 Q
 D QK1
 Q
 ;
NOPAT ; -- No patient found, ask to add new
 I DIC(0)["L" D ^DPTLK2 S Y=DPTDFN G ASKPAT:DIC(0)["A"&(Y<0)&('$G(DTOUT)),QK1
 ;
CHKDFN ; -- 
 S:'$D(DPTDFN) DPTDFN=-1 I DPTDFN'>0!('$D(DPTS(+DPTDFN))) W:DIC(0)["Q" *7," ??" G ASKPAT:DIC(0)["A",QK
 I DIC(0)["E" D  W $S('$D(DPTSEL)&('$D(DIVP)):$P(DPTS(DPTDFN),U,2)_"  "_$P(DPTS(DPTDFN),U)_"  ",$D(^DPT(DPTDFN,0)):"  "_$P(^(0),U)_"  ",1:"") S Y=DPTDFN X:$D(^DPT(DPTDFN,0)) "N DDS X DIC(""W"")"
 .I $D(DDS) D CLRMSG^DDS S DX=0,DY=DDSHBX+1 X DDXY
 ;
 ; check for other patients in "BS5" xref on Patient file
 ;I '$G(DICR),DPTDFN>0,DIC(0)["E",$$BS5^DPTLK5(+DPTDFN) D  G ASKPAT:DIC(0)["A"&(%'=1),QK:DPTDFN<0
 I DPTDFN>0,DIC(0)["E",$$BS5^DPTLK5(+DPTDFN),'$D(DGSEARCH) D  G ASKPAT:DIC(0)["A"&(%'=1),QK:DPTDFN<0  ;*TEST*
 .N DPTZERO,DPTLSNME,DPTSSN S DPTZERO=$G(^DPT(+DPTDFN,0)),DPTLSNME=$P($P(DPTZERO,U),","),DPTSSN=$E($P(DPTZERO,U,9),6,9)
 .W $C(7),!!,"There is more than one patient whose last name is '",DPTLSNME,"' and"
 .W !,"whose social security number ends with '",DPTSSN,"'."
 .W !,"Are you sure you wish to continue (Y/N)" S %=0 D YN^DICN
 .I %'=1 S DPTDFN=-1
 ;
 ;I '$G(DICR),DPTDFN>0 S Y=DPTDFN D ^DGSEC S DPTDFN=Y G ASKPAT:DIC(0)["A"&(DPTDFN<0),QK:DPTDFN<0
 I DPTDFN>0,DIC(0)["E" S Y=DPTDFN D ^DGSEC S DPTDFN=Y G ASKPAT:DIC(0)["A"&(DPTDFN<0),QK:DPTDFN<0 S DPTBTDT=1
 S DPTX=DPTX_$P(DPTS(DPTDFN),U,2),DPTDFN=DPTDFN_U_$P(^DPT(DPTDFN,0),U)
 ;
Q ; -- 
 S Y=$S('$D(DPTDFN):-1,'$D(DPTS(+DPTDFN)):-1,1:DPTDFN),X=$S($D(DPTX)&(+Y>0):DPTX,$D(DPTSAVX):DPTSAVX,$D(DPTX):DPTX,1:"")
 I Y>0 S:DIC(0)'["F" ^DISV($S($D(DUZ)#2:DUZ,1:0),"^DPT(")=+Y S:DIC(0)["Z" Y(0)=^DPT(+Y,0),Y(0,0)=$P(^(0),U,1)
 ;DG*600
 I DIC(0)["E",$$TESTPAT^VADPT(+Y) W *7,!,"WARNING : You may have selected a test patient."
 I DIC(0)["E",$$BADADR^DGUTL3(+Y) W *7,!,"WARNING : ** This patient has been flagged with a Bad Address Indicator."
 I DIC(0)["E",$$VAADV^DPTLK3(+Y) W *7,!,"** Patient is VA ADVANTAGE."
 ;DG*485
 I $D(^DPT("AXFFP",1,+Y)) D FFP^DPTLK5
 ;Display enrollment information
 I Y>0,DIC(0)["E" D ENR
 ;
 ;Call Combat Vet check
 I Y>0,DIC(0)["E" D CV
 ;
 ; check whether to display Means Test Required message
 D
 .N DPTDIV
 .I '$G(DUZ(2)) Q
 .I Y>0,DIC(0)["E" S DPTDIV=$$DMT^DPTLK5(+Y,DUZ(2)) I DPTDIV D
 ..W $C(7),!!,"MEANS TEST REQUIRED"
 ..W !,?3,$P($G(^DG(40.8,DPTDIV,"MT")),U,2)
 ..H 2
 ;
Q1 ; -- Clean up variables
 K D,DIC("W"),DO,DPTCNT,DPTDFN,DPTIFNS,DPTIX,DPTS
 K:'$G(DICR) DPTBTDT  ; IF DICR LEAVE FOR DGSEC TO HANDLE
 K DPTSAVX,DPTSEL,DPTSZ,DPTX
 ;
 K:$D(IATA) IATA
 K:$D(DGFLDS) @DGFLDS,DGFLDS
 Q
 ;
QK K:'$D(DPTNOFZK) DPTNOFZY G Q
 ;
QK1 K:'$D(DPTNOFZK) DPTNOFZY G Q1
 ;
IX ; --
 I $D(D),$D(^DD(2,0,"IX",D)),($E(D)'="A") S DPTIX=D
 G DPTLK
 ;
IATA(X) ; --
 ;This function pulls off ssn from the IATA track (old card)
 ; - If new card, then use card number to look-up DFN, returned as `DFN
 ;
 ;Input:  X   -  what was read in
 ;Output: SSN -  social security number OR `DFN if new card
 ;          Q -  quit
 ;
 ; Track            Start Sent     End Sent      Field Separator
 ; -----            ----------     --------      ---------------
 ;  IATA (alphanum)      %             ?          {   (Note: VA used ^)
 ;  ABA (numeric)        ;             ?          =    
 ;
 ;N IATA
 S (IATA)=""
 I $E(X)'="%" Q X ; no start sentinel
 I X'["?" Q "Q"
 ; -- Extract data from track
 S IATA=$$TRACK(X,"%","?")
 ; -- checks for no data
 I IATA="" Q "Q"
 ; -- checks for new card, look-up DFN
 I $E(X,1,29)?1"%"9NP1"^"17UNP1"?" D
 . N CARD
 . S CARD=+$P($P(X,"%",2),"^")
 . ; **919, Story 220135 (elz) log the card activity
 . D CARDLOG^MPIFAPI(CARD,"VHIC","SWIPE")
 . S IATA=$$CARD(CARD)
 ; -- Returns SSN or `DFN value
 I IATA'="" Q $P(IATA,"^")
 Q "Q"
 ;
TRACK(X,START,END) ; find track where start/end are sentinels
 ;
 Q $P($P($G(X),START,2),END,1)
 ;
FIELDS(IATA) ; -- Sets fields
 Q:'$D(IATA)
 N CNT,FIELD
 S DGFLDS="^TMP(""DGVIC"","_$J_")",CNT=1
 K @DGFLDS
 F  S FIELD=$P($G(IATA),"^",CNT)  Q:FIELD=""  D
 .S @DGFLDS@(CNT)=FIELD
 .S CNT=CNT+1
 ; -- Define fields for duplicate checker
 S DPTX=$G(@DGFLDS@(2)) ;NAME
 S DPTIDS(.03)=$G(@DGFLDS@(3)) ;DOB
 S DPTIDS(.09)=$G(@DGFLDS@(1)) ;SSN
 Q
BARCODE(X) ;
 ;This function pulls off card number from the barcode scan
 ;  looks up the patient (locally)
 ;  if not locally found, queries mpi 
 ;
 ;Input:  X   -  what was read in
 ;Output: DFN -  `DFN
 ;          Q -  quit
 ;
 ; Input       Start Data   VIC ver     DoD EDI_PIN     VA/VIC II   
 ; --------    ----------   -------     -----------     ----------
 ; alphanum        %           N         alphanum 7     alphanum 6
 ;
 N CARD
 S CARD=$$B32TO10($E(X,10,15)) I 'CARD Q "Q"
 ; **919, Story 220135 (elz) log the card activity
 D CARDLOG^MPIFAPI(CARD,"VHIC","SCAN")
 Q $$CARD(CARD)
 ;
CACCARD(X) ;
 ;This function pulls off EDIPI number from the CAC barcode scan
 ;  looks up the patient (locally)
 ;  if not locally found, queries mpi 
 ;
 ;Input:  X   -  what was read in
 ;Output: DFN -  `DFN
 ;          Q -  quit
 ;
 ; VC     PDI     PT       DoD EDI   PC     BC      CI
 ; --     ---     --       -------   --     ---     ---
 ; "1"    6UN     1U         7UN     1U     1UN     1UN
 ;
 N EDIPI
 S EDIPI=$$B32TO10($E(X,9,15)) I 'EDIPI Q "Q"
 Q $$EDIPI(EDIPI)
 ;
EDIPI(EDIPI) ; - returns `DFN from EDIPI number
 N DFN,VICFAC
 ; **919, Story 220135 (elz) log the card activity
 D CARDLOG^MPIFAPI(EDIPI,"CAC","SCAN")
 S VICFAC=+$$LKUP^XUAF4("200DOD") ; national DOD station number
 S DFN=+$G(^DGCN(391.91,+$O(^DGCN(391.91,"ASID",EDIPI,VICFAC,0)),0))
 S DGVIC40=EDIPI ; saving EDIPI number here so I don't have to look later
 I DFN Q "`"_DFN
 ; - not found locally, need to make sure we don't find anyone DGVIC40
 Q "Q"
CARD(CARD) ; - returns `DFN from card number
 N DFN,VICFAC
 S VICFAC=+$$LKUP^XUAF4("742V1") ; national vic facility number
 S DFN=+$G(^DGCN(391.91,+$O(^DGCN(391.91,"ASID",CARD,VICFAC,0)),0))
 S DGVIC40=CARD ; saving card number here so I don't have to look later
 I DFN Q "`"_DFN
 ; - not found locally, need to make sure we don't find anyone DGVIC40
 Q "Q"
VIC40(DGFLDS,DGVIC40,DGCAC) ; - returns the data used to create the
 ;  patient file entry from mpi
 N X,DGMPI
 S DGFLDS="^TMP(""DGVIC"","_$J_")"
 K @DGFLDS
 I $T(CARDPV^MPIFXMLS)'="" D CARDPV^MPIFXMLS(.DGMPI,DGVIC40,DGCAC)
 S X=0 F  S X=$O(DGMPI(X)) Q:'X  S @DGFLDS@(X)=DGMPI(X)
 Q
ENR ;Display Enrollment information after patient selection
 N DGENCAT,DGENDFN,DGENR,DGEGTIEN,DGEGT
 I '$$GET^DGENA($$FINDCUR^DGENA(+DPTDFN),.DGENR) Q
 S DGENCAT=$$CATEGORY^DGENA4(+DPTDFN)
 S DGENCAT=$$EXTERNAL^DILFD(27.15,.02,"",DGENCAT)
 W !?1,"Enrollment Priority: ",$S($G(DGENR("PRIORITY")):$$EXT^DGENU("PRIORITY",DGENR("PRIORITY")),1:""),$S($G(DGENR("SUBGRP"))="":"",1:$$EXT^DGENU("SUBGRP",$G(DGENR("SUBGRP"))))
 W ?33,"Category: ",DGENCAT
 W ?57,"End Date: ",$S($G(DGENR("END")):$$FMTE^XLFDT(DGENR("END"),"5DZ"),1:""),!
 ;If patient is NOT ELIGIBLE, display Enrollment Status (Ineligible Project Phase I)
 I $G(DGENR("STATUS"))=10!($G(DGENR("STATUS"))=19)!($G(DGENR("STATUS"))=20) D
 . W ?1,"Enrollment Status: ",$S($G(DGENR("STATUS")):$$EXT^DGENU("STATUS",DGENR("STATUS")),1:"") ;H 5
 ;check for Combat Veteran Eligibility, if elig do not display EGT info
 I $$CVEDT^DGCV(+DPTDFN) Q
 ;Get Enrollment Group Threshold Priority and Subgroup
 S DGEGTIEN=$$FINDCUR^DGENEGT
 S DGEGT=$$GET^DGENEGT(DGEGTIEN,.DGEGT)
 Q:$G(DGENR("PRIORITY"))=""!($G(DGEGT("PRIORITY"))="")
 ;Compare Patient's Enrollment Priority to Enrollment Group Threshold
 I '$$ABOVE^DGENEGT1(+DPTDFN,DGENR("PRIORITY"),$G(DGENR("SUBGRP")),DGEGT("PRIORITY"),DGEGT("SUBGRP")) D
 .N X,IORVOFF,IORVON
 .S X="IORVOFF;IORVON"
 .D ENDR^%ZISS
 .W !?32 W:$D(IORVON) IORVON  W "*** WARNING ***" W:$D(IORVOFF) IORVOFF
 .I DGENR("END")'="" W !?14 W:$D(IORVON) IORVON W "*** PATIENT ENROLLMENT END",$S(DT>+DGENR("END"):"ED",1:"S")," EFFECTIVE ",$$FMTE^XLFDT(DGENR("END"),"5DZ")," ***" W:$D(IORVOFF) IORVOFF Q
 .W !?5 W:$D(IORVON) IORVON W "*** PATIENT ENROLLMENT ENDING.  ENROLLMENT END DATE IS NOT KNOWN. ***" W:$D(IORVOFF) IORVOFF
 Q
CV ;check for Combat Vet status
 N DGCV
 S DGCV=$$CVEDT^DGCV(+DPTDFN)
 I $P(DGCV,U)=1 D  Q
 . I '$$GET^DGENA($$FINDCUR^DGENA(+DPTDFN),.DGENR) W !
 . W ?3,"Combat Vet Status: "_$S($P(DGCV,U,3)=1:"ELIGIBLE",1:"EXPIRED"),?57,"End Date: "_$$FMTE^XLFDT($P(DGCV,U,2),"5DZ")
 Q
B32TO10(X) ; - convert from base 32 to base 10
 N I,Y,S S Y=0,S="0123456789ABCDEFGHIJKLMNOPQRSTUV"
 I X[" " S X=$E(X,1,$F(X," ")-2)
 F I=1:1:$L(X) S Y=Y*32+($F(S,$E(X,I))-2)
 Q Y
RPCVIC(RETURN,DPTX) ; - patient lookup from VIC card, rpc/api
 ; non-interactive
 ; this function will return a patient's DFN based on input.  input must
 ; be in the form of the FULL input from a VIC card (magstripe or bar
 ; code), the patient must be locally known (FULL doesn't but can contain
 ; additional card tracks)
 ; RETURN input should be passed by reference
 ;
 ;  Input examples:
 ;     Barcode possibilities:
 ;            NNNNNNNNN (old VIC card, full 9 digit ssn)
 ;            CCCCCCCCCCCCCCCCCC (new VIC 4.0 card, 18 characters with
 ;                                10-15 being compressed card number)
 ;     Magstripe possibilities:
 ;            Must always start with %
 ;            Must contain ?
 ;            $E(X,2,10) = SSN (old card)
 ;            %NNNNNNNNN^CCCCCCCCCCCCCCCCC? (first 29 characters) where
 ;                                          N = card number (new card)
 ;
 ;  Return (pass by reference):  If patient known locally = DFN
 ;                                   If not known locally = -1
 ;
 N MAG,BARCODE
 S (RETURN,MAG,BARCODE)=0
 I '$D(DPTX) Q -1
 S DPTX=$$UP^XLFSTR(DPTX)
 I DPTX["?" S DPTX=$E(DPTX,1,$F(DPTX,"?")-1)
 I DPTX?9N S RETURN=$O(^DPT("SSN",DPTX,0))
 I $E(DPTX)="%"!($E(DPTX)=";"),DPTX["?",'RETURN S MAG=1,DPTX=$$IATA(DPTX)
 I 'MAG,DPTX?1"%"1N13UNP.3UN,'RETURN S BARCODE=1,DPTX=$$BARCODE(DPTX)
 I 'MAG,'BARCODE,DPTX?1N6UN1U7UN1U2UN S DPTX=$$CACCARD(DPTX)
 I 'RETURN,$E(DPTX,2,999) S RETURN=$S($E(DPTX)="`":$E(DPTX,2,999),1:$O(^DPT("SSN",DPTX,0)))
 S RETURN=$S(RETURN:RETURN,1:-1)
 Q
