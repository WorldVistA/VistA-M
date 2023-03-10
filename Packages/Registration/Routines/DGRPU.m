DGRPU ;ALB/MRL,TMK,BAJ,DJE,JAM,JAM,ARF - REGISTRATION UTILITY ROUTINE ;12/20/2005  5:37PM
 ;;5.3;Registration;**33,114,489,624,672,689,688,935,941,997,1014**;Aug 13, 1993;Build 42
 ;
H ;Screen Header
 ;I DGRPS'=1.1 W @IOF S Z=$P($T(H1+DGRPS),";;",2)_", SCREEN <"_DGRPS_">"_$S($D(DGRPH):" HELP",1:""),X=79-$L(Z)\2 D W
 I DGRPS'=1.1,DGRPS'?1"11.5" W @IOF S Z=$P($T(H1+DGRPS),";;",2)_", SCREEN <"_DGRPS_">"_$S($D(DGRPH):" HELP",1:""),X=79-$L(Z)\2 D W ; LEG; DG*5.3*997; excluded 11.5
 I DGRPS=1.1 W @IOF S Z="ADDITIONAL PATIENT DEMOGRAPHIC DATA, SCREEN <"_DGRPS_">"_$S($D(DGRPH):" HELP",1:""),X=79-$L(Z)\2 D W
 ;ASF; DG*5.3*997; add 11.5 screen
 I DGRPS?1"11.5" W @IOF S Z="ADDITIONAL ELIGIBILITY VERIFICATION DATA, SCREEN <"_DGRPS_">"_$S($D(DGRPH):" HELP",1:""),X=79-$L(Z)\2 D W
 S X=$$SSNNM(DFN)
 ;ARF - DG*5.3*1014 standardize heading and add DOB and PREFERRED NAME
 ;I '$D(DGRPH) W !,X S X=$S($D(DGRPTYPE):$P(DGRPTYPE,"^",1),1:"PATIENT TYPE UNKNOWN"),X1=79-$L(X) W ?X1,X
 I '$D(DGRPH) D  ;DG*5.3*1014 begin
 .N DGDOB,DGSSN,DGSSNSTR,DGPREFNM,DGPTYPE,DGNAME,DGMEMID,VADEMO ;DG*5.3*1014 - ARF - updating banner with standard patient data
 .D DEMUPD^VADPT
 .S DGNAME=VADEMO(1)
 .S DGPREFNM=$S(VADEMO(1,1)'="":"("_VADEMO(1,1)_")",1:"")
 .S DGDOB=$P(VADEMO(3),U,2)
 .S DGSSN=$P(VADEMO(2),U,2)
 .S DGSSNSTR=$$SSNNM^DGRPU(DFN)
 .S DGPTYPE=$$GET1^DIQ(391,$$GET1^DIQ(2,DFN_",",391,"I")_",",.01)
 .S:DGPTYPE="" DGPTYPE="PATIENT TYPE UNKNOWN"
 .S DGMEMID=$S($P($P(DGSSNSTR,";",2)," ",2)'="":$E($P($P(DGSSNSTR,";",2)," ",2),1,40)_"    ",1:"")
 .W !,DGNAME W:DGPREFNM'="" " "_DGPREFNM W "    "_DGDOB
 .W ! W:DGMEMID'="" DGMEMID W DGSSN_"    "_DGPTYPE ;DG*5.3*1014 end
 S X="",$P(X,"=",80)="" W !,X Q
 Q
LISTHDR(DGFIRST) ;sets patient data for banners of list manager screens - DG*5.3*1014
 ;DGFIRST - Is the first subscript of VALMHDR array where the patient data should
 ;        be stored. This value is increased for the second line of patient data
 ;        VALMHDR(DGFIRST)="NAME (PREFERRED NAME)    MON DD, YYYY" note: the date is the DOB
 ;        VALMHDR(DGFIRST+1)="EDI/PI    ###-##-####    PATIENT TYPE" note: if there isn't a EDP/PI(member ID) the
 ;                                                                 SSN (###-##-####) begins in the first column
 N DGSSNSTR,DGPTYPE,DGSSN,DGDOB
 S:+DGFIRST=0 DGFIRST=1
 S DGSSNSTR=$$SSNNM^DGRPU(DFN)
 S DGSSN=$P($P(DGSSNSTR,";",2)," ",3)
 S DGDOB=$$GET1^DIQ(2,DFN,.03,"I")
 S DGDOB=$$UP^XLFSTR($$FMTE^XLFDT($E(DGDOB,1,12),1))
 S DGPTYPE=$$GET1^DIQ(391,$$GET1^DIQ(2,DFN_",",391,"I")_",",.01)
 S:DGPTYPE="" DGPTYPE="PATIENT TYPE UNKNOWN"
 S VALMHDR(DGFIRST)=$P(DGSSNSTR,";",1)_$S($$GET1^DIQ(2,DFN,.2405)'="":" ("_$$GET1^DIQ(2,DFN,.2405)_")",1:"")_"    "_DGDOB
 S VALMHDR(DGFIRST+1)=$S($P($P(DGSSNSTR,";",2)," ",2)'="":$E($P($P(DGSSNSTR,";",2)," ",2),1,40)_"    ",1:"")_DGSSN_"    "_DGPTYPE
 Q 
AL(DGLEN) ;DGLEN= Available length of line
A ;Format address(es)
 ; DG*5.3*688 BAJ 12/20/2005 modified for foreign address
 I '$D(DGLEN) N DGLEN S DGLEN=29
 N I,DGX,FILE,IEN,CNTRY,TMP,FNODE,FPCE,ROU
 ; set up variables
 ; jam; DG*5.3*997; foreign address code for NOK/e-contact addresses .21, .211, .33, .331, .34 - country code is in piece 12
 ;S FNODE=$S(DGAD=.121:.122,1:DGAD),FPCE=$S(DGAD=.121:3,DGAD=.141:16,1:10)
 S FNODE=$S(DGAD=.121:.122,1:DGAD),FPCE=$S(DGAD=.121:3,DGAD=.141:16,DGAD=.21:12,DGAD=.211:12,DGAD=.33:12,DGAD=.331:12,DGAD=.34:12,1:10)
 ; collect Street Address info
 F I=DGA1:1:DGA1+2 I $P(DGRP(DGAD),U,I)]"" S TMP(DGA2)=$P(DGRP(DGAD),U,I),DGA2=DGA2+2
 I DGA2=1 S TMP(1)="STREET ADDRESS UNKNOWN",DGA2=DGA2+2
 ; retrieve country info -- PERM country is piece 10 of node .11
 S FOR=0
 ; jam; DG*5.3*997; add the country retrieval for screen 3 - NOK/e-contact/designee addresses
 ;I DGA1=1 D
 I DGA1=1!(DGAD=.21)!(DGAD=.211)!(DGAD=.33)!(DGAD=.331)!(DGAD=.34) D
 . ; JAM; DG*5.3*997 - in the $E below, change the length of the CNTRY from 25 chars to DGLEN chars 
 . S FILE=779.004,IEN=$P(DGRP(FNODE),U,FPCE),CNTRY=$E($$CNTRYI^DGADDUTL(IEN),1,DGLEN) I CNTRY=-1 S CNTRY="UNKNOWN COUNTRY"
 . ; assemble (US) CITY, STATE ZIP or (FOREIGN) CITY PROVINCE POSTAL CODE
 . S FOR=$$FORIEN^DGADDUTL(IEN) I FOR=-1 S FOR=1
 S ROU=$S(FOR=1:"FOREIGN",1:"US")_"(DGAD,.TMP,DGA1,.DGA2)" D @ROU
 ; append COUNTRY to address
 S DGA2=DGA2+2,TMP(DGA2)=$S($G(CNTRY)="":"",1:CNTRY)
 M DGA=TMP
 K DGA1
 Q
 ;
US(DGAD,TMP,DGA1,DGA2) ;process US addresses and format in DGA array
 ; DG*5.3*688 BAJ this is the code for all addresses prior to the addition of Foreign address logic.
 ; Modifications for Foreign address are in Tag FOREIGN
 N DGX,I,J
 ; format STATE field and merge with CITY & ZIP
 S J=$S('$D(^DIC(5,+$P(DGRP(DGAD),U,DGA1+4),0)):"",('$L($P(^(0),U,2))):$P(^(0),U,1),1:$P(^(0),U,2)),J(1)=$P(DGRP(DGAD),U,DGA1+3),J(2)=$P(DGRP(DGAD),U,DGA1+5),TMP(DGA2)=$S(J(1)]""&(J]""):J(1)_","_J,J(1)]"":J(1),J]"":J,1:"UNK. CITY/STATE")
 ; zip code capture
 I ".33^.34^.211^.331^.311^.25^.21"[DGAD D
 .F I=1:1:7 I $P(".33^.34^.211^.331^.311^.25^.21",U,I)=DGAD S DGX=$P($G(^DPT(DFN,.22)),U,I)
 E  D
 .I DGAD=.141 S DGX=$P(DGRP(.141),U,6) Q
 .; JAM - Patch DG*5.3*941, Residential address, zip code is piece 6
 .I DGAD=.115 S DGX=$P(DGRP(.115),U,6) Q
 .S DGX=$P(DGRP(DGAD),U,DGA1+11)
 ; format ZIP+4 with hyphen
 S:$L(DGX)>5 DGX=$E(DGX,1,5)_"-"_$E(DGX,6,9)
 ;combine CITY,STATE and ZIP fields on a single line
 S TMP(DGA2)=$E($P(TMP(DGA2),",",1),1,(DGLEN-($L(DGX)+4)))_$S($L($P(TMP(DGA2),",",2)):",",1:"")_$P(TMP(DGA2),",",2)_" "_DGX
 F I=0:0 S I=$O(TMP(I)) Q:'I  S TMP(I)=$E(TMP(I),1,DGLEN)
 Q
 ;
FOREIGN(DGAD,TMP,DGA1,DGA2) ;process FOREIGN addresses and format in DGA array
 N I,J,CITY,PRVNCE,PSTCD,FNODE
 F I=1:1 S J=$P($T(FNPCS+I),";;",3) Q:J="QUIT"  D
 . I DGAD=$P(J,";",1) S FNODE=$P(J,";",2),CITY=$P(J,";",3),PRVNCE=$P(J,";",4),PSTCD=$P(J,";",5)
 ; Assemble CITY PROVINCE and POSTAL CODE on the same line
 ; NOTE CITY is sometimes on a different node than the PROVINCE & POSTAL CODE
 ; DG*5.3*997; jam; For screen 3 put Province and Postal Code to a separate line
 ;   - for other screens, rearrange output so City is followed by Province and then Postal code
 I $G(DGRPS)=3 D
 . S TMP(DGA2)=$P(DGRP(DGAD),U,CITY)
 . S DGA2=DGA2+2 S TMP(DGA2)=$P(DGRP(FNODE),U,PRVNCE)_" "_$P(DGRP(FNODE),U,PSTCD)
 E  S TMP(DGA2)=$P(DGRP(DGAD),U,CITY)_" "_$P(DGRP(FNODE),U,PRVNCE)_" "_$P(DGRP(FNODE),U,PSTCD)
 F I=0:0 S I=$O(TMP(I)) Q:'I  S TMP(I)=$E(TMP(I),1,DGLEN)
 Q
 ;
W I IOST="C-QUME",$L(DGVI)'=2 W ?X,Z Q
 W ?X,@DGVI,Z,@DGVO
 Q
 ;
 ; JAM - Patch DG*5.3*941, Add Residential address type
 ; JAM - Patch DG*5.3*997, Add NOK/e-contact address types
FNPCS ; Foreign data pieces. Structure-->Description;;Main Node;Data Node;City;Province;Postal code.
 ;;Permanent;;.11;.11;4;8;9
 ;;Temporary;;.121;.122;4;1;2
 ;;Confidential;;.141;.141;4;14;15
 ;;Residential;;.115;.115;4;8;9
 ;;NOK;;.21;.21;6;13;14
 ;;NOK2;;.211;.211;6;13;14
 ;;E;;.33;.33;6;13;14
 ;;E2;;.331;.331;6;13;14
 ;;D;;.34;.34;6;13;14
 ;;QUIT;;QUIT
 ;
H1 ;
 ;;PATIENT DEMOGRAPHIC DATA
 ;;PATIENT DATA
 ;;EMERGENCY CONTACT DATA
 ;;APPLICANT/SPOUSE EMPLOYMENT DATA
 ;;INSURANCE DATA
 ;;MILITARY SERVICE DATA
 ;;ELIGIBILITY STATUS DATA
 ;;FAMILY DEMOGRAPHIC DATA
 ;;INCOME SCREENING DATA
 ;;INELIGIBLE/MISSING DATA
 ;;ELIGIBILITY VERIFICATION DATA
 ;;ADMISSION INFORMATION
 ;;APPLICATION INFORMATION
 ;;APPOINTMENT INFORMATION
 ;;SPONSOR DEMOGRAPHIC INFORMATION
 ;
 ;
INCOME(DFN,DGDT) ; compute income for veteran...if not in 408.21, pass back file 2 data
 ; (called by PTF)
 ;
 ;
 ; Input: DFN as IEN of PATIENT file
 ; DGDT as date to return income as of
 ;
 ; Output: total income (computed function)
 ; (from 408.21 if available...otherwise from file 2)
 ;
 ;
 N DGDEP,DGINC,DGREL,DGTOT,DGX,I S DGTOT=0
 D ALL^DGMTU21(DFN,"V",DGDT,"I")
 S DGX=$G(^DGMT(408.21,+$G(DGINC("V")),0)) I DGX]"" F I=8:1:17 S DGTOT=DGTOT+$P(DGX,"^",I)
 I DGX']"" S DGTOT=$P($G(^DPT(DFN,.362)),U,20)
 Q DGTOT
 ;
 ;
MTCOMP(DFN,DGDT) ; is current means test OR COPAY complete?
 ;
 ; Input: DFN as IEN of PATIENT file
 ; DGDT as 'as of' date
 ;
 ; Output: 1 if means test/COPAY for year prior to DT passed is complete
 ; 0 otherwise
 ; DGMTYPT 1=MT;2=CP;0=NONE
 ;
 N COMP,MT,X,YR
 S YR=$$LYR^DGMTSCU1(DGDT),MT=$$LST^DGMTCOU1(DFN,DGDT)
 S DGMTYPT=+$P(MT,U,5)
 S COMP=1
 I DGMTYPT=1 D  ;MT
 .I $P(MT,"^",4)']""!("^R^N^"[("^"_$P(MT,"^",4)_"^")) S COMP=0
 I DGMTYPT=2 D  ;CP
 .I $P(MT,"^",4)']""!("^I^L^"[("^"_$P(MT,"^",4)_"^")) S COMP=0
 S X=+$P(MT,"^",2) I ($E(X,1,3)-1)*10000<YR S COMP=0
 Q COMP
 ;
HLP1010 ;* This is called by the Executable Help for Patient field #1010.159
 ; (APPOINTMENT REQUEST ON 1010EZ)
 W !!," Enter a 'Y' if the veteran applicant has requested an"
 W !," appointment with a VA doctor or provider and wants to be"
 W !," seen as soon as one becomes available Enter a 'N'"
 W !," if the veteran applicant has not requested an appointment."
 W !!," This question may ONLY be entered ONCE for the veteran."
 W !," The answer to this question CANNOT be changed after the"
 W !," initial entry.",!
 Q
 ;
HLPCS ; * This is called by the Executable Help for Income Relation field #.1
 Q:X="?"
 N DIR,DGRDVAR
 W !?8,"Enter in this field a Yes or No to indicate whether the veteran"
 W !?8,"contributed any dollar amount to the child's support last calendar"
 W !?8,"year. The contributions do not have to be in regular set amounts."
 W !?8,"For example, a veteran who paid a child's school tuition or"
 W !?8,"medical bills would be contributing to the child's support.",!
 W !,"Enter RETURN to continue:" R DGRDVAR:DTIME W !
 Q
 ;
HLP1823 ;*This is called by the Executable Help for Patient Relation field #.18
 N DIR,DGRDVAR
 W !?7,"Enter 'Y' if the child is currently 18 to 23 years old and the child"
 W !?7,"attended school last calendar year. Enter 'N' if the child is currently"
 W !?7,"18 to 23 years old but the child did not attend school last calendar"
 W !?7,"year. Enter 'N' if the child is not currently 18 to 23 years old.",!
 I $G(DA) W !,"Enter RETURN to continue:" R DGRDVAR:DTIME W !
 Q
 ;
HLPMLDS ;* This is called by the Executable Help for Patient field #.362
 ; (DISABILITY RET. FROM MILITARY?)
 N X,Y,DIR
 W !!," Enter '0' or 'NO' if the veteran:"
 W !," -- Is NOT retired from the military OR"
 W !," -- Is retired from the military due to length of service AND"
 W !," does NOT have a disability confirmed by the Military Branch"
 W !," to have been incurred in or aggravated while on active duty."
 W !!," Enter '1' or 'YES, RECEIVING MILITARY RETIREMENT' if the veteran:"
 W !," -- Is confirmed by the Military Branch to have been discharged"
 W !," or released due to a disability incurred in or aggravated"
 W !," while on active duty AND"
 W !," -- Has NOT filed a claim for VA compensation benefits OR"
 W !," -- Has been rated by the VA to be NSC OR"
 W !," -- Has been rated by the VA to have noncompensable 0%"
 W !," SC conditions."
 S DIR(0)="E" D ^DIR Q:+Y<1
 W !!," Enter '2' or 'YES, RECEIVING MILITARY RETIREMENT IN LIEU OF VA"
 W !," COMPENSATION' if the veteran:"
 W !," -- Is confirmed by the Military Branch to have been discharged"
 W !," or released due to a disability incurred in or aggravated"
 W !," while on active duty AND"
 W !," -- Is receiving military disability retirement pay AND"
 W !," -- Has been rated by VA to have compensable SC conditions"
 W !," but is NOT receiving compensation from the VA"
 W !!," Once eligibility has been verified, this field will no longer"
 W !," be editable to any user who does not hold the designated security"
 W !," key."
 Q
HLP3602 ;help text for field .3602, Rec'ing Disability in Lieu of VA Comp
 W !," Enter 'Y' if this veteran applicant is receiving disability"
 W !," retirement pay from the Military instead of VA compensation."
 W !," Enter 'N' if this veteran applicant is not receiving disability"
 W !," retirement pay from the Military instead of VA compensation."
 W !," Once eligibility has been verified by HEC this field will no longer "
 W !," be editable by VistA users. Send updates and/or requests to HEC."
 Q
HLP3603 ;help text for field .3603, Discharge Due to LOD Disability
 W !," Enter 'Y' if this veteran applicant was discharged from the"
 W !," military for a disability incurred or aggravated in the line "
 W !," of duty. Enter 'N' if this veteran applicant was not discharged"
 W !," from the military for a disability incurred or aggravated in the"
 W !," line of duty. Once eligibility has been verified by HEC this field"
 W !," will no longer be editable by VistA users. Send updates and/or requests"
 W !," to HEC."
 Q
SSNNM(DFN) ; SSN, EDIPI and name on first line of screen
 ;DJE - DG*5.3*935 - Add Member ID To Vista Registration Banner
 N X,SSN,EDIPI,IDSTAT,J,ASFC,LIST,PT,STK
 S X=$S($D(^DPT(+DFN,0)):^(0),1:""),SSN=$P(X,"^",9),SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)
 ;
 S PT=DFN_"^PI^USVHA^"_$P($$SITE^VASITE(),U,3)
 D TFL^VAFCTFU2(.LIST,PT)
 S EDIPI="",IDSTAT="",J=1
 S STK="" F  S STK=$O(LIST(STK)) D  Q:STK=""
 .Q:STK=""
 .S ASFC=$P(LIST(STK),U,3)
 .Q:ASFC'="USDOD"
 .S IDSTAT=$P(LIST(STK),U,5)
 .S EDIPI=$P(LIST(STK),U,1)
 .I (IDSTAT="A"),(EDIPI>1) S STK=""  Q  ;First active EDIPI
 .I IDSTAT="H" S EDIPI(J)=EDIPI S J=J+1
 .S EDIPI=""
 I IDSTAT="H" S EDIPI=EDIPI(1) ; First inactive EDIPI
 S X=$P(X,U)_"; "_EDIPI_" "_SSN
 Q X
