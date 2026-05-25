DPTLK7 ;OAK/ELZ,ARF - MAS PATIENT LOOKUP ENTERPRISE SEARCH ;15 May 2020  2:31 PM
 ;;5.3;Registration;**915,919,926,967,981,1000,1024,1111,1139**;Aug 13, 1993;Build 2
 ;
SEARCH(DGX,DGXOLD) ; do a search, pass in what the user entered
 ; DGX is what the user originally entered, name is assumed unless it
 ; is exactly 9 digits, DON'T pass by reference it may change
 ; Return:  DFN (new or found locally), 0 if nothing found/added
 ;
 N DG20NAME,DGMPI,DGFLDS,DGOUT,%,%Y,DGMPIR,DGDFN,DGMPIICN,DGSAVE
 N DGKEYREQ,X,DA,DO,DIC,DGADDREQ,DGMCID
 Q:$G(DGSEARCH) 0
 S (DGKEYREQ,DGOUT,DGADDREQ)=0,DGSEARCH=1,DGSAVE=DGX
 Q:$T(PATIENT^MPIFXMLP)="" 0
 ;
YN ;Enterprise Search?
 W !,"Do you want to do an Enterprise Search"
 D YN^DICN I %=0 W !,"You must enter Yes or No." G YN
 Q:%'=1 0
 ;
 I $G(DGXOLD)]"" S DGX=DGXOLD
 ; if yes then ask questions
 ; if 9 digits entered assume ssn, need to save
PROMPT I DGX?9N S DGFLDS(.09)=DGX,DGX=""
 ; if name in "" need to remove
 I $E(DGX,1)="""" S DGX=$E(DGX,2,99)
 I $E(DGX,$L(DGX))="""" S DGX=$E(DGX,1,$L(DGX)-1)
 D NAME(.DGX,.DG20NAME,.DGOUT) Q:DGOUT 0
 D FLDS(.DGFLDS,DG20NAME,.DGOUT) Q:DGOUT 0
 I $G(DGFLDS(.09))'?9N S DGADDREQ=1
 D:DGADDREQ ADDRESS(.DGFLDS,.DGOUT) Q:DGOUT 0
 I DGADDREQ,'$$ADDREQ(.DGFLDS) D  G PROMPT
 . W !,"You must enter an actual SSN, a COMPLETE Address or Phone to search.",!
 . K DGX,DG20NAME,DGFLDS,DGMPI,DGMPIR
 . S DGX=DGSAVE
 ;
 ; call MPI to get data
 W !!,"Searching the MVI..."
 D FORMAT(.DGMPI,.DG20NAME,.DGFLDS)
 D PATIENT^MPIFXMLP(.DGMPIR,.DGMPI)
 S DGMCID=$G(DGMPIR("mcid"))
 ;
 ; too many matches found, they need to get the numbers down, re-prompt
 I $G(DGMPIR("count"))>10!($G(DGMPIR("Result"))="QE") D  G PROMPT
 . W !,$S(DGMPIR("count")>10:DGMPIR("count"),1:"Too many")," records found, you need to provide more specific criteria.",!
 . K DGX,DG20NAME,DGFLDS,DGMPI,DGMPIR
 . S DGX=DGSAVE
 ;
 ; no matches found on the MPI offer to add
 I '$G(DGMPIR("count")) W !,"No records found on the MVI.",! D  Q DGDFN
 . S DPTX=$G(DGFLDS(.01)) D ASKADD^DPTLK2 I DPTDFN'>0 S DGDFN=0 Q
 . S DGDFN=$$ADD(.DGFLDS,.DG20NAME) Q:'DGDFN
 . ;
 . ; setup DGMPIR since there was nothing
 . M DGMPIR(1)=DGMPI
 . S DGMPIR(+$O(DGMPIR(0)),"DFN")=DGDFN
 . ;
 . S DGMPIR("mcid")=DGMCID
 .;**981 - Story 841885 (ckn)
 . S DGMPIR("SelIdentifier")=""
 . D MPIADD(.DGMPIR)
 ;
 ; do I have some records that are in autolink threshold? - key required
 S X=0 F  S X=$O(DGMPIR(X)) Q:'X  I $G(DGMPIR(X,"Score"))'<$G(DGMPIR("matchThreshold")) S DGKEYREQ=1
 ;
 ; preset list to select patients
 S DGDFN=$$ENP^MPIFVER(.DGMPIR,$G(DGMPIR("matchThreshold")),$G(DGMPIR("dupeThreshold")))
 ;
 ; found and selected local patient
 I DGDFN>0 Q DGDFN
 I DGDFN=-1 S DPTX="" Q 0
 ;
 ; need to add new patient based on return from selection
 I $D(DGMPIR)>1 K DG20NAME D FORMATR^DPTLK7A(.DGFLDS,.DGMPIR,.DG20NAME) S DGDFN=$$ADD(.DGFLDS,.DG20NAME) D:DGDFN  G QUIT
 . ;
 . S DGMPIR(+$O(DGMPIR(0)),"DFN")=DGDFN
 . ;
 . S DGMPIR("mcid")=DGMCID
 .;**981 - Story 841885 (ckn)
 . I $G(DGMPIR(1,"ICN"))'="" S DGMPIR("SelIdentifier")=DGMPIR(1,"ICN")_"^NI^200M^USVHA"
 . ;**1024,Story 1258907 (mko): The TFs are now also returned in "IDS"; Look for the DoD record, but only if ICN is not set
 . ;I $G(DGMPIR(1,"IDS",1,"ID"))'="" S DGMPIR("SelIdentifier")=DGMPIR(1,"IDS",1,"ID")_"^NI^200DOD^USDOD"
 . E  N I S I="" F  S I=$O(DGMPIR(1,"IDS",I)) Q:I=""  I $G(DGMPIR(1,"IDS",I,"ID"))]"",$G(DGMPIR(1,"IDS",I,"ISSUER"))="USDOD",$G(DGMPIR(1,"IDS",I,"SOURCE"))="200DOD" S DGMPIR("SelIdentifier")=DGMPIR(1,"IDS",I,"ID")_"^NI^200DOD^USDOD" Q
 . D MPIADD(.DGMPIR)
 . W !
 . ;
 . ; if known to ESR, send Z11 and monitor for return data
 . I $G(DGMPIR(1,"Z11")) D
 .. W !,"Adding site correlation to MVI "
 .. N DGTIME,DGQRY,DGDONE,DGQSTAT
 .. S (DGQSTAT,DGDONE)=0
 .. F DGTIME=1:1:60 D
 ... I $D(^XTMP("DPTLK7 A24 IN-PROCESS",DGDFN)) W "." H 1 Q
 ... ;
 ... ; not sending, maybe already sent or it is turned off
 ... I 'DGDONE  S DGDONE=1 D  W "." H 1 Q
 .... I $$QRY^DGENQRY(DGDFN) W !,"Enrollment/Eligibility Query processing "
 ... ;
 ... ; check for status until it is returned, end with set to 60 seconds
 ... S DGQRY=$$GET^DGENQRY($$FINDLAST^DGENQRY($G(DGDFN)),.DGQRY) I $G(DGQRY("STATUS"))>2 S DGTIME=60,DGQSTAT=1 Q
 ... W "." H 1
 .. I 'DGQSTAT D
 ... W !,"Query to ES timed out, proceeding with registration."
 ... W !,"The data will be uploaded when received."
 .. W !!
 ;
 ; no one selected but may still need to add based on traits entered
 I DGKEYREQ,'$D(^XUSEC("DG MVI ADD PT",DUZ)) D
 . W !,"The search returned one or more patients above the Auto-Link threshold,"
 . W !,"none of them selected. Security key required to add without selection."
 E  D
 . N DPTDFN,DPTX,Y,%,%Y,DGMPIR
 . M DGMPIR(1)=DGMPI
 . S DPTX=$G(DGFLDS(.01)) D ASKADD^DPTLK2 I DPTDFN'>0 S DGDFN=0 Q
 . S DGDFN=$$ADD(.DGFLDS,.DG20NAME) Q:'DGDFN
 . S DGMPIR(+$O(DGMPIR(0)),"DFN")=DGDFN
 . S DGMPIR("AddType")=$S(DGKEYREQ:"Explicit",1:"Implicit")
 . S DGMPIR("mcid")=DGMCID
 .;**981 - Story 841885 (ckn)
 . S DGMPIR("SelIdentifier")=""
 . D MPIADD(.DGMPIR)
 ;
QUIT Q $S(DGDFN:DGDFN,1:0)
 ;
MPIADD(DGMPIR) ; - call to add patient to the MPI and store ICN locally
 ; - web service call for adding and getting new ICN
 ;**1024,Story 1258907 (mko): Add a flag to indicate a new ICN needs to be added.
 N DGNEWICN
 I '$G(DGMPIR(+$O(DGMPIR(0)),"ICN")) D
 . S DGNEWICN=1
 . W !,"Adding patient to the MVI..."
 . N DGMPIICN
 . I '$D(DGMPIR("AddType")) S DGMPIR("AddType")="Implicit"
 . D GETICN^MPIFXMLI(.DGMPIICN,.DGMPIR)
 . I $G(DGMPIICN("ICN"))>0 S DGMPIR(+$O(DGMPIR(0)),"ICN")=DGMPIICN("ICN")
 . E  D  Q
 .. W !,"Unable to add to MVI!",!,$G(DGMPIICN("ERRTXT")),!
 .. S ^XTMP("MPIF EXPLICIT QUEUE",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^MPIF EXPLICIT QUEUE"
 .. S ^XTMP("MPIF EXPLICIT QUEUE",DGDFN)=DT_"^"_DGMPIR("AddType")_"^"_$G(DGMPIR(+$O(DGMPIR(0)),"mcid"))_"^"_$G(DGMPIICN("ERRTXT"))
 .. S X=$$ICNLC^MPIF001(DGDFN)
 ;
 ; - need to have MPI do MPI fields
 S ^XTMP("DPTLK7 A24 IN-PROCESS",0)=$$FMADD^XLFDT(DT,10)_"^"_DT_"^TRACK PROCESSING OF A24 MESSAGES"
 S ^XTMP("DPTLK7 A24 IN-PROCESS",DGDFN)=DT
 I $G(DGMPIR(+$O(DGMPIR(0)),"ICN")) D VIC40^MPIFAPI(DGDFN,DGMPIR(+$O(DGMPIR(0)),"ICN"))
 ;
 ;**1024,Story 1258907 (mko): Add the TFs returned from the Enterprise Search in case MFN-MF0 hasn't been received and processed by this point
 D:'$G(DGNEWICN)
 . N DGTFARR
 . M DGTFARR=DGMPIR(+$O(DGMPIR(0)),"IDS")
 . D ADDTF^DPTLK7A(DGDFN,.DGTFARR)
 Q
 ;
NAME(DGX,DG20NAME,DGOUT) ;- ask for name components
 N DGC,DGCL,DGCOM,DGCX,DGI,DGY,DIR,X,DGCOMP
START S DGOUT=0
 S DGCOM="FAMILY^GIVEN^MIDDLE^PREFIX^SUFFIX^DEGREE"
 S DGCX=" (LAST) NAME^ (FIRST) NAME^ NAME"
 S DGCL="1:35^1:25^1:25^1:10^1:10^1:10"
 I $G(DGX)'?9N S DGX=$G(DGX) D STDNAME^XLFNAME(.DGX,"C")
 S DGX("SUFFIX")=$$CLEANC^XLFNAME(DGX("SUFFIX"))
 M DG20NAME=DGX
 S DIR("PRE")="D:X'=""@"" NCEVAL^DPTNAME1(DGCOMP,.X)"
 W !,"Patient name components--"
 ;DG*5.3*1111 removed PREFIX (#4) and DEGREE (#6) of the NAME COMPONENTS (#20) file
 ;F DGI=1:1:6 S DGC($P(DGCOM,U,DGI),DGI)=""
 F DGI=1:1:3,5 S DGC($P(DGCOM,U,DGI),DGI)=""
 ;DG*5.3*1111 removed PREFIX (#4) and DEGREE (#6) of the NAME COMPONENTS (#20) file
 ;F DGI=1:1:6 Q:DGOUT  D
 F DGI=1:1:3,5 Q:DGOUT  D
AGAIN .S DGCOMP=$P(DGCOM,U,DGI)
 . S DIR("A")=DGCOMP_$P(DGCX,U,DGI)
 . S DIR(0)=$S(DGI=1:"F^"_$P(DGCL,U,DGI),1:"FO^"_$P(DGCL,U,DGI))
 . S DIR("PRE")="D NCEVAL^DPTNAME1(DGCOMP,.X)"
 . S DIR("B")=$S($D(DG20NAME(DGCOMP)):DG20NAME(DGCOMP),1:$G(DGX(DGCOMP)))
 . K:'$L(DIR("B")) DIR("B")
ASK . D ^DIR I $D(DTOUT)!(X=U) S DGOUT=1 Q
 . I $A(X)=94 D JUMP^DPTNAME1(.DGI) G AGAIN
 . I X="@",DGI=1 W !,$C(7),"Family name cannot be deleted!" G ASK
 . I X="@" S DG20NAME(DGCOMP)="" Q
 . Q:'$L(X)
 . S DG20NAME=X
 . I DGCOMP="SUFFIX" S DG20NAME=$$CLEANC^XLFNAME(DG20NAME)
 . S DG20NAME=$$FORMAT^XLFNAME7(DG20NAME,1,35,,3,,1,1)
 . I '$L(DG20NAME) W "  ??",$C(7) G ASK
 . W:DG20NAME'=X "   (",DG20NAME,")" S DG20NAME(DGCOMP)=DG20NAME
 Q:DGOUT ""
 ; Reconstruct name
 S DG20NAME=$$NAMEFMT^XLFNAME(.DG20NAME,"F","CFL30")
 ; Format the .01 value
 M DGY=DG20NAME
 S DG20NAME=$$FORMAT^XLFNAME7(.DGY,3,30,,2)
 ; Check the length
 I $L(DG20NAME)<3 D  G START
 . W !,"Invalid values to use, full name must be at least 3 characters!",$C(7)
 . K DG20NAME,DGX,DGCOMP
 Q
 ;
 ;**1139 VAMPI-26417 (jfw) - Convert to new RESIDENTIAL address fields
ADDRESS(DGFLDS,DGOUT) ;- prompt for address
 N DGRET,DGVAL
 ; OLD  |  NEW
 ;.111  | .1151 RESIDENTIAL ADDRESS [LINE 1] (both, free text)
 ;.112  | .1152 RESIDENTIAL ADDRESS [LINE 2] (both, free text)
 ;.113  | .1153 RESIDENTIAL ADDRESS [LINE 3] (both, free text)
 ;.114  | .1154 RESIDENTIAL CITY (both, free text)
 ;.115  | .1155 RESIDENTIAL STATE (external^internal)
 ;.117  | .1157 RESIDENTIAL COUNTY (external^internal^code)
 ;.1171 | .11571 RESIDENTIAL PROVINCE (both, free text)
 ;.1172 | .11572 RESIDENTIAL POSTAL CODE (both, free text)
 ;.1112 | .1156  RESIDENTIAL ZIP+4 (both, free text)
 ;.1173 | .11573 RESIDENTIAL COUNTRY (external^internal)
 ;.121 BAD ADDRESS INDICATOR (external^internal)
 W !,"Patient address--"
 D EN^DGREGAED(,,,.DGRET)
 ;ReMap from Original address fields to New RESIDENTIAL Address Fields
 F DGVAL=".111;.1151",".1112;.1156",".112;.1152",".113;.1153",".114;.1154",".115;.1155",".117;.1157",".1171;.11571",".1172;.11572",".1173;.11573"  D
 .S DGFLDS($P(DGVAL,";",2))=$G(DGRET($P(DGVAL,";")))
 S DGFLDS(.121)=$G(DGRET(.121))
 Q
FLDS(DGFLDS,DGNAME,DGOUT) ;- prompt for the various FM fields
 ; Data returned in array
 ;DGFLDS(.09)=SSN*
 ;DGFLDS(.03)=DOB*
 ;DGFLDS(.02)=GENDER*
 ;DGFLDS(391)=TYPE (required)
 ;DGFLDS(1901)=VETERAN (Y/N)? (required)
 ;DGFLDS(.301)=SERVICE CONNECTED? (required)
 ;DGFLDS(.2403)=MMN
 ;DGFLDS(.092)=POB (city)
 ;DGFLDS(.093)=POB (state)
 ;DGFLDS(994)=MBI
 ;DGFLDS(.131)=PHONE
 ;DGFLDS("EDIPI")=EDIPI
 ;
 W !,"Patient identifiers--"
 ; SSN is special handling
 N DGFLD,DIR,X,Y,DG20NAME
 S DIR(0)="F^1:9^K:X'?9N&(X'=""P"")&(X'=""p"") X"
 S DIR("A")="SOCIAL SECURITY NUMBER"
 S:$D(DGFLDS(.09)) DIR("B")=DGFLDS(.09)
 S DIR("?")="Answer with the individual's social security, must be 9 numbers or 'P'."
 D ^DIR
 I $D(DUOUT) S DGOUT=1 Q
 S DGFLDS(.09)=X
 K DIR
 ; Story 338378 (elz) if pseudo, prompt pseudo reason
 I DGFLDS(.09)="P"!(DGFLDS(.09)="p") D PSREASON(.DGFLDS,.DGOUT)  Q:DGOUT
 ; prompt for EDIPI value before the FM fields
 ;S DIR(0)="FO^10^K:X'?10N X"
 ;S DIR("A")="EDIPI"
 ;S DIR("?")="Answer with the individual's EDIPI, must be 10 numbers."
 ;D ^DIR
 ;I $D(DUOUT) S DGOUT=1 Q
 ;S DGFLDS("EDIPI")=X
 ;K DIR
 ;DG*5.3*1111 removed the PLACE OF BIRTH [CITY] (#.092) and PLACE OF BIRTH [STATE] (#.093) of PATIENT (#2) file
 ;F DGFLD=.03,.02,"ASKREQID",.2403,.092,.093,994,.131 D  Q:$D(DTOUT)!($D(DUOUT))
 F DGFLD=.03,.02,"ASKREQID",.2403,994,.131 D  Q:$D(DTOUT)!($D(DUOUT))
 . ;**1000,Story 1171329 (mko): Use ASKREQID as an indicator to prompt for three additional fields at this point
 . ;**1024,Story 1258907 (mko): Merge DPTIDS=DGFLDS. The input transform for VETERAN (Y/N)? looks at DOB response in DPTIDS(.03)
 . I DGFLD="ASKREQID" N DPTIDS M DPTIDS=DGFLDS D ASKREQID(.DGNAME,.DPTIDS) M:'$D(DUOUT) DGFLDS=DPTIDS Q
 . S DIR(0)="2,"_DGFLD_$S(DGFLD=.03:"",DGFLD=.02:"",1:"O")
 . D ^DIR
 . Q:$D(DIRUT)
 . S DGFLDS(DGFLD)=$P(Y,"^")
 S:$D(DTOUT)!($D(DUOUT)) DGOUT=1
 I $L($G(DGNAME)) S DGFLDS(.01)=DGNAME
 Q
 ;
ASKREQID(DGNAME,DPTIDS) ;Use code from CHKID1^DPTLK2 to prompt for additional required identifiers
 ;**1000,Story 1171329 (mko): New subroutine
 ;Returns:
 ;  DPTIDS(field#)=internal form of user response
 ;  DUOUT=1 if ^, timeout, or other issue
 N DFN,DGVV,DIC,DO,DPT,DPTCT,DPTDFN,DPTGID,DPTID,DPTID0,DPTSET,DPTX,I,X,Y
 S DIC="^DPT(",DPTX=$G(DGNAME),DPTDFN=1 ;Variables needed by CHKID1^DPTLK2
 F DPTID=391,1901,.301 D  Q:DPTDFN<0
 . I DPTID=.301,DPTIDS(1901)="N" S DPTIDS(.301)="N" Q
 . D CHKID1^DPTLK2
 S:DPTDFN<0 DUOUT=1
 Q
 ;
PSREASON(DGFLDS,DGOUT) ; - prompts (and requires) pseudo reason
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT,DPTSET,P
 S DPTSET=$P(^DD(2,.0906,0),"^",3)
PSAGAIN S DIR(0)="2,.0906" D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) S DGOUT=1 Q
 I Y="" W *7,"??",!!,"Choose from:" D
 . F P=1:1 Q:$P(DPTSET,";",P)=""  W !,$P($P(DPTSET,";",P),":"),?10,$P($P(DPTSET,";",P),":",2)
 . W ! G PSAGAIN
 I Y["^" S DGOUT=1 Q
 S DGFLDS(.0906)=$P(Y,":")
 Q
FORMAT(DGR,DGN,DGF) ; - format data for MPI call
 N X
 S:$G(DGN("FAMILY"))]"" DGR("Surname")=DGN("FAMILY")
 S:$G(DGN("GIVEN"))]"" DGR("FirstName")=DGN("GIVEN")
 S:$G(DGN("MIDDLE"))]"" DGR("MiddleName")=DGN("MIDDLE")
 S:$G(DGN("SUFFIX"))]"" DGR("Suffix")=DGN("SUFFIX")
 S:$G(DGN("PREFIX"))]"" DGR("Prefix")=DGN("PREFIX")
 S:$G(DGN("DEGREE"))]"" DGR("Degree")=DGN("DEGREE")
 S:$G(DGF(.02))]"" DGR("Gender")=DGF(.02)
 S:$G(DGF(.03))]"" DGR("DOB")=DGF(.03)
 I $G(DGF(.09))]"",DGF(.09)'="P",DGF(.09)'="p" S DGR("SSN")=DGF(.09)
 S:$G(DGF(.2403))]"" DGR("MMN")=DGF(.2403)
 S:$G(DGF(.092))]"" DGR("POBCity")=DGF(.092)
 S:$G(DGF(.093)) DGR("POBState")=$P($G(^DIC(5,DGF(.093),0)),"^",2)
 S:$G(DGF(994))]"" DGR("MBI")=DGF(994)
 S:$G(DGF(.131))]"" DGR("ResPhone")=DGF(.131)
 S:$D(DGF("EDIPI")) DGR("EDIPI")=DGF("EDIPI")
 ;
 ; only include address if deliverable
 ;**1139 VAMPI-26417 (jfw) - Convert to new RESIDENTIAL address fields
 I $G(DGF(.121))]"" D
 . S:$G(DGF(.1151))]"" DGR("ResAddL1")=DGF(.1151)
 . S:$G(DGF(.1156))]"" DGR("ResAddZip4")=DGF(.1156)
 . S:$G(DGF(.1152))]"" DGR("ResAddL2")=DGF(.1152)
 . S:$G(DGF(.1153))]"" DGR("ResAddL3")=DGF(.1153)
 . S:$G(DGF(.1154))]"" DGR("CITY")=DGF(.1154)
 . S:$P($G(DGF(.1155)),"^",2) DGR("ResAddState")=$P($G(^DIC(5,$P(DGF(.1155),"^",2),0)),"^",2)
 . S:$G(DGF(.11571))]"" DGR("ResAddProvince")=DGF(.11571)
 . S:$G(DGF(.11572))]"" DGR("ResAddPCode")=DGF(.11572)
 . S:$P($G(DGF(.11573)),"^")]"" DGR("ResAddCountry")=$P(DGF(.11573),"^")
 Q
 ;
ADD(DGF,DG20NAME) ; - stuff in patient
 ; Pass in the fields to set in the DGF array.
 ; Alaso Name components in DG20NAME array.  Returns new DFN
 N X,Y,SAVY,FDA,IEN,DATA,DO,DIC,DA,X,DLAYGO,REQ,VAFCNO,DGY,DPTX
 I $E($G(DGF(.09)),1,9)'?9N S DGF(.09)=$$PSEUDO(DGF(.01),$G(DGF(.03)))
 ; check for SSN already exist
 S DGY=$O(^DPT("SSN",DGF(.09),0)) I DGY>0,$D(^DPT(DGY,0)) W *7,"  SSN Already used by patient '",$P(^(0),"^"),"'." Q 0
 ;
 S DIC("DR")="",REQ="^.02^.03^.09^"
 S DGF=.01 F  S DGF=$O(DGF(DGF)) Q:'DGF  D
 . ; if the data has a second piece, then that's internal value to use
 . S DATA=$S($P(DGF(DGF),"^",2):$P(DGF(DGF),"^",2),1:DGF(DGF))
 . I DATA]""!(REQ[("^"_DGF_"^")) S DIC("DR")=DIC("DR")_DGF_$S(DATA]"":"////"_DATA,1:"")_";"
 ;**1000,Story 1171329 (mko): Don't default TYPE, VETERAN, or SERVICE CONNECTED
 ;  These values were obtained earlier in the FLDS subroutine above
 ; patient type
 ;S DIC("DR")=DIC("DR")_"391///"_$O(^DG(391,"B","NSC VETERAN",0))_";"
 ; veteran
 ;S DIC("DR")=DIC("DR")_"1901///Y;"
 ; SC
 ;S DIC("DR")=DIC("DR")_".301///N;"
 ; date added
 S DIC("DR")=DIC("DR")_".097////"_DT
 ; who added
 S:$G(DUZ) DIC("DR")=DIC("DR")_";.096////"_DUZ
 ;
 S X=DGF(.01),DIC="^DPT(",DIC(0)="L",DLAYGO=2,VAFCNO=1
 D FILE^DICN
 S SAVY=+Y
 ;**1024
 S DGNEWP=$P(Y,U,3) ; TO ENSURE WE HAVE 3RD PIECE OF Y WHEN WE COME OUT OF ADD OF NEW PATIENT
 ;
 ; alias
 S X=0 F  S X=$O(DGF("ALIAS",X)) Q:'X  D
 . S DGF=0 F  S DGF=$O(DGF("ALIAS",X,DGF)) Q:'DGF  D
 .. S FDA(2.01,"+"_X_","_SAVY_",",.01)=DGF("ALIAS",X,.01)
 .. S:DGF("ALIAS",X,1)]"" FDA(2.01,"+"_X_","_SAVY_",",1)=DGF("ALIAS",X,1)
 ;
 I $D(FDA) D
 . N DG20NAME
 . D UPDATE^DIE("","FDA")
 ;
 ; send bulletin new patient added to system
 I SAVY>0 D BULL(SAVY)
 ;
 Q SAVY
 ;
ADDREQ(DGFLDS) ; - determine if enough address data entered
 ; returns OK to proceed (1) or not (0)
 N DGOK,FIELD
 S DGOK=1
 ; is US or foreign
 ;**1139 VAMPI-26417 (jfw) - Convert to new RESIDENTIAL address fields
 I $$FOR^DGADDUTL($P(DGFLDS(.11573),"^")) D
 . F FIELD=.1151,.1154,.11571,.11572 S:$G(DGFLDS(FIELD))']"" DGOK=0
 E  F FIELD=.1151,.1156,.1154,.1155 S:$G(DGFLDS(FIELD))']"" DGOK=0
 I $L($G(DGFLDS(.131))) S DGOK=1
 Q DGOK
 ;
PSEUDO(NAM,DOB) ; - return pseudo ssn
 N L1,L2,L3,Z
 S NAM=$G(DGF(.01)),DOB=$G(DGF(.03))
 I DOB="" S DOB=2000000
 S L1=$E($P(NAM," ",2),1),L3=$E(NAM,1),NAM=$P(NAM,",",2),L2=$E(NAM,1)
 S Z=L1 D CON^DGRPDD1 S L1=Z,Z=L2 D CON^DGRPDD1
 S L2=Z,Z=L3 D CON^DGRPDD1 S L3=Z
 Q L2_L1_L3_$E(DOB,4,7)_$E(DOB,2,3)_"P"
 ;
BULL(SAVY) ; - send bulletin that new patient added
 N DGTEXT,DGNAM,DGSSN,DGDOB,DGB,DGZ
 S DGB=2
 S DGZ=$G(^DPT(SAVY,0))
 S DGNAM=$P(DGZ,"^"),DGSSN=$P(DGZ,"^",9),DGDOB=$P(DGZ,"^",3)
 S DGSSN=$E(DGSSN,1,3)_"-"_$E(DGSSN,4,5)_"-"_$E(DGSSN,6,10)
 S DGDOB=$$FMTE^XLFDT(DGDOB)
 S XMSUB="NEW PATIENT ADDED TO SYSTEM"
 S DGTEXT(1,0)="NAME:  "_DGNAM
 S DGTEXT(2,0)="SSN :  "_DGSSN
 S DGTEXT(3,0)="DOB :  "_DGDOB
 D ^DGBUL
 Q
