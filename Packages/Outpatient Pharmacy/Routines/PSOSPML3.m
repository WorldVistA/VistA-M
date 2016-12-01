PSOSPML3 ;BIRM/MFR - ASAP Definitions Listman Driver ;09/01/12
 ;;7.0;OUTPATIENT PHARMACY;**408,451**;DEC 1997;Build 114
 ;
 N ASAPVER,VERLST,DIR,DIRUT,DTOUT,X,Y,DIC,VALM,VALMBG,VALMCNT,VALMHDR,VALMBCK,VALMSG,PSOLSTLN
 ;
VER ; ASAP Version Prompt
 W ! S ASAPVER=$$ASAPVER^PSOSPMU2("A",1) I ASAPVER["^"!(ASAPVER="") G EXIT
 ;
 D EN(ASAPVER,0)
 ;
 G VER
 ;
EN(PSOASVER,PSOSHOW) ; Entry point
 ;Input: (r) PSOASVER - ASAP Version ("3.0", "4.0", etc.)
 ;       (o) PSOSHOW  - 0: Segments Only
 ;                      1: Segments & Data Elements (ID and Name Only)
 ;                      2: Segments & Data Elements (All Details)
 N ASAP
 S PSOSHOW=+$G(PSOSHOW)
 D EN^VALM("PSO SPMP VIEW ASAP DEFINITION")
 D FULL^VALM1
 Q
 ;
HDR ; - Builds the Header section
 N STDIEN,VERIEN,HDR,ELMDELIM,SEGTERM,EOSCHR,STDVDLMS,ALLVDLMS
 S STDVDLMS=$$VERDATA^PSOSPMU0(PSOASVER,"S")
 S ALLVDLMS=$$VERDATA^PSOSPMU0(PSOASVER,"B")
 S STDIEN=$O(^PS(58.4,"B","STANDARD ASAP DEFINITION",0))
 S VERIEN=$O(^PS(58.4,STDIEN,"VER","B",PSOASVER,0))
 S VALM("TITLE")=" ASAP "_$S('VERIEN:"Custom",1:"Standard")_" Version "_PSOASVER_$S('VERIEN:"*",1:"")
 S ELMDELIM=$S(PSOASVER="1995":"N/A",1:$P(ALLVDLMS,"^",2))
 S HDR="Element Delimiter"_$S(($P(STDVDLMS,"^",2)'=""&($P(STDVDLMS,"^",2)'=$P(ALLVDLMS,"^",2))):"*",1:"")_":"_IOINHI_$S(ELMDELIM="":"<NULL>",1:" "_ELMDELIM)_IOINORM
 S SEGTERM=$S(PSOASVER="1995":"N/A",1:$P(ALLVDLMS,"^",3))
 S HDR=HDR_"  Segment Terminator"_$S(($P(STDVDLMS,"^",3)'=""&($P(STDVDLMS,"^",3)'=$P(ALLVDLMS,"^",3))):"*",1:"")_":"_IOINHI_$S(SEGTERM="":"<NULL>",1:" "_SEGTERM)_IOINORM
 S EOSCHR=$S(PSOASVER="1995":"$C(10,13)",1:$P(ALLVDLMS,"^",4))
 S HDR=HDR_"  End Of Line ESC"_$S(($P(STDVDLMS,"^",4)'=""&($P(STDVDLMS,"^",4)'=$P(ALLVDLMS,"^",4))):"*",1:"")_":"_IOINHI_$S(EOSCHR="":"<NULL>",1:" "_EOSCHR)_IOINORM
 D INSTR^VALM1(HDR,1,2)
 Q
 ;
INIT ; Builds the Body section
 N ASAP,LINE,I
 ;
 K ^TMP("PSOSPML3",$J) S VALMCNT=0,LINE=0
 F I=1:1:1000 D RESTORE^VALM10(I)
 I PSOASVER="1995" D
 . D SETSEG95^PSOSPML4("PSOSPML3","") S VALMCNT=LINE
 I PSOASVER'="1995" D
 . D LOADASAP^PSOSPMU0(PSOASVER,"B",.ASAP)
 . D SETSEG("ASAP",0) S VALMCNT=LINE
 . S VALMSG="Enter ?? for more actions|* Custom Segment/Element"
 Q
 ;
 ; Note: Recursivity used because of the 'Tree' nature of the ASAP definition
SETSEG(ARRNAM,LEVEL) ; Set list content with the Segment info
 ;Input: ARRNAM - Name of the Array containing the ASAP definition
 ;       LEVEL  - Level of the Segment
 N ARRAY,COLUMN,TYPE,DETLN,SEGID,JUST,I,J,ELMCNT,LSTELM,ELMNAM,MVALUE,SEGLN,LEVNAM,DESCNT,VALIDX
 ;
 S PSOSHOW=+$G(PSOSHOW)
 S ARRAY=$Q(@ARRNAM) I '+$P(ARRAY,"(",2) Q
 S SEGID=$P(@ARRAY,"^"),COLUMN=(($L(ARRAY,",")-1)*4)
 S JUST="" S:PSOSHOW'=2 JUST=$J("",COLUMN)
 I LEVEL'=$P(ASAP(SEGID),"^",6) D
 . S LEVEL=$P(ASAP(SEGID),"^",6)
 . S LEVNAM=$P("MAIN HEADER^PHARMACY HEADER^PATIENT DETAIL^PRESCRIPTION DETAIL^PHARMACY TRAILER^MAIN TRAILER","^",LEVEL)
 . D SETLN^PSOSPMU1("PSOSPML3",JUST_LEVNAM,0,0,0)
 . D CNTRL^VALM10(LINE,$L(JUST)+1,$L(LEVNAM),IORVON,IORVOFF_IOINORM)
 S SEGLN=JUST_$P(ASAP(SEGID),"^")_$S($$CUSSEG^PSOSPMU3(PSOASVER,SEGID):"*",1:"")_" - "_$P(ASAP(SEGID),"^",2)_$S($P(ASAP(SEGID),"^",4)="N":" (Not Used)",1:"")
 D SETLN^PSOSPMU1("PSOSPML3",SEGLN,0,$S(PSOSHOW'=0:1,1:0),$S($P(ASAP(SEGID),"^",4)="N":0,1:1))
 S LSTELM=+$O(ASAP(SEGID,""),-1)
 I PSOSHOW'=0 D
 . F ELMCNT=1:1:LSTELM D
 . . S:PSOSHOW=1 JUST=$J("",COLUMN+$L(SEGID)+1)
 . . S ELMNAM=JUST_$P(ASAP(SEGID,ELMCNT),"^")_$S($G(ASAP(SEGID,ELMCNT,"CUS")):"*",1:"")_" - "_$P(ASAP(SEGID,ELMCNT),"^",2)
 . . S ELMNAM=ELMNAM_$S((PSOSHOW=1)&($P(ASAP(SEGID,ELMCNT),"^",6)="N"):" (Not Used)",1:"")
 . . D SETLN^PSOSPMU1("PSOSPML3",ELMNAM,0,0,$S((PSOSHOW=1)&($P(ASAP(SEGID,ELMCNT),"^",6)="N"):0,1:1))
 . . I PSOSHOW=1 Q
 . . S DETLN=JUST_"Requirement: "_$S($P(ASAP(SEGID,ELMCNT),"^",6)="R":"Required",$P(ASAP(SEGID,ELMCNT),"^",6)="O":"Optional",$P(ASAP(SEGID,ELMCNT),"^",6)="N":"Not Used",1:"")
 . . S TYPE=$P(ASAP(SEGID,ELMCNT),"^",3)
 . . S $E(DETLN,33)="Format: "_$S(TYPE="AN":"Alphanumeric",TYPE="N":"Numeric",TYPE="D":"Decimal",TYPE="DT":"Date (YYYYMMDD)",TYPE="TM":"Time (HHMMSS or HHMM)",1:"")
 . . S $E(DETLN,62)="Maximum Length: "_$P(ASAP(SEGID,ELMCNT),"^",4)
 . . D SETLN^PSOSPMU1("PSOSPML3",DETLN)
 . . ; Highlighting fields Requirement, Format and Length
 . . D CNTRL^VALM10(LINE,13,10,IOINHI,IOINORM)
 . . D CNTRL^VALM10(LINE,41,20,IOINHI,IOINORM)
 . . D CNTRL^VALM10(LINE,77,5,IOINHI,IOINORM)
 . . F DESCNT=1:1 Q:'$D(ASAP(SEGID,ELMCNT,"DES",DESCNT))  D
 . . . D SETLN^PSOSPMU1("PSOSPML3",JUST_ASAP(SEGID,ELMCNT,"DES",DESCNT))
 . . ; Field M Expression Value
 . . S DETLN="Value: ",MVALUE=""
 . . F VALIDX=1:1 Q:'$D(ASAP(SEGID,ELMCNT,"VAL",VALIDX))  D
 . . . S MVALUE=MVALUE_ASAP(SEGID,ELMCNT,"VAL",VALIDX)
 . . F  Q:MVALUE=""  D
 . . . S $E(DETLN,8)=$E(MVALUE,1,72)
 . . . D SETLN^PSOSPMU1("PSOSPML3",DETLN)
 . . . D CNTRL^VALM10(LINE,8,72,IOINHI,IOINORM)
 . . . S DETLN="",MVALUE=$E(MVALUE,73,999)
 . . D SETLN^PSOSPMU1("PSOSPML3"," ")
 D SETSEG(ARRAY,LEVEL)
 Q
 ;
HELP ; Listman Help
 Q
 ;
EXIT ;
 K ^TMP("PSOSPML3",$J)
 Q
 ;
MEXPRHLP(LEVEL,ELMID) ;MUMPS Expression Help Text
 ;Input: (r) LEVEL - Level of the Segment where the Data Element is located
 ;       (r) ELMID  - Data Element ID ("PHA01", "DSP02", etc.)
 N LEVNAM,DIR,X,Y,DIRUT,DTOUT
 W !,"This is the argument of a MUMPS SET command that will be used to retrieve the"
 W !,"value for the Data Element '",ELMID,"'."
 W !,""
 W !,"Below are some examples of valid values for this field:"
 W !,""
 W !,"Null/Blank : Use """" (two quotes) to force a blank value. Another option to"
 W !,"-----------  force a blank value is to set the Data Element REQUIREMENT field"
 W !,"             to 'N' (NOT USED)."
 W !,""
 W !,"Fixed Value: Use quotes to force a fixed value for this Data Element."
 W !,"-----------  Examples: ""AF290303"", ""SMITH"", ""12345"", etc."
 W !,""
 W !,"MUMPS Code : Use a Mumps expression that can be used as the argument of a SET"
 W !,"-----------  command. Examples:  $P($$SITE^VASITE(),""^"",2)"
 W !,"                                 $E($$GET1^DIQ(52,RXIEN,.01),1,30)"
 W !,"                                 $S(FILLIEN>0:""REFILL"",1:""ORIGINAL"")"
 W !,"                                 $$PHA03^PSOASAP()_""B"""
 W !,""
 W !,"NOTE: The value for a Standard Definition Data Element is returned by a"
 W !,"      function in the format $$SEGNN^PSOASAP(), where 'SEG' is the 2 or"
 W !,"      3-character segment identifier and 'NN' is the 2-digit element"
 W !,"      identifier. Examples: $$IS01^PSOASAP(), $$PRE08^PSOASAP(), etc."
 ;
 K DIR S DIR("A")="Press Return to continue",DIR(0)="E" D ^DIR
 W !,""
 S LEVNAM=$P("^PHARMACY HEADER^PATIENT DETAIL^PRESCRIPTION DETAIL^PHARMACY TRAILER^","^",LEVEL)
 W !,"The following variables are available at the ",LEVNAM," level for"
 W !,"customizing this Data Element:"
 W !,""
 W !,"   STATEIEN - State IEN. Pointer to STATE file (#5)."
 I LEVEL=1!(LEVEL=6) Q
 W !,"   SITEIEN  - Pharmacy Division IEN. Pointer to OUTPATIENT SITE file (#59)."
 I LEVEL=2!(LEVEL=5) Q
 W !,"   PATIEN   - Patient IEN. Pointer to the PATIENT file (#2)."
 I LEVEL=3 Q
 W !,"   RXIEN    - Prescription IEN. Pointer to the PRESCRIPTION file (#52)."
 W !,"   DRUGIEN  - Drug IEN. Pointer to the DRUG File (#50)"
 W !,"   FILLNUM  - Fill Number ('0': Original Fill,'1': Refill #1,'2': Refill #2,"
 W !,"              'P1': Partial #1,'P2': Partial Fill #2, etc.)"
 W !,"   FILLIEN  - Pointer to the REFILL sub-file (#52.1) or PARTIAL sub-file (#52.2)"
 W !,"              ('0': Original, N: Pointer to Refill or Partial fill)"
 W !,"   RPHIEN   - Pharmacist IEN. Pointer to NEW PERSON file (#200)."
 W !,"   PREIEN   - Prescriber IEN.  Pointer to NEW PERSON file (#200)."
 W !,"   RTSREC   - Return To Stock Record? ('1': YES / '0': NO)"
 Q
