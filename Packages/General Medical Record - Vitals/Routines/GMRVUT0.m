GMRVUT0 ;HIOFO/RM,YH,FT-INPUT TRANSFORMS FOR VITAL TYPES ;10/3/07
 ;;5.0;GEN. MED. REC. - VITALS;**23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ;  #4290 - ^PXRMINDX global     (controlled)
 ;
 ; This routine supports the following IAs:
 ; EN1 - 1446                    (controlled)
 ;
EN2 ; CALLED FROM INPUT TRANSFORM OF RATE AND QUALITY SUBFIELDS OF SITE
 ; FIELD OF THE VITAL MEASUREMENT (#120.5) FILE - GMRFLD IS SET BEFORE
 ; ENTRY, BUT KILLED WITHIN THE ROUTINE
 S GMRTYP=$S($D(^GMR(120.5,DA,0)):$P(^(0),U,3),1:"") G K:GMRTYP'>0
 G K:GMRTYP'>0,Q2:$P(^GMRD(120.51,GMRTYP,0),U,$S(GMRFLD=1:4,GMRFLD=2:5,1:3))
K D EN^DDIOL($C(7)_"CANNOT EDIT THIS FIELD FOR THIS TYPE OF MEASUREMENT","","!?5") K X
Q2 K GMRTYP,GMRFLD Q
EN3 ; INPUT TRANSFORM FOR HEIGHT RATES
 N GMR
 S GMR=$P(X,+X,2,10) I GMR="" S X=0 Q
 I $E(GMR)="C"!($E(GMR)="c")&("CMCmcMcm"[GMR) S X=$J(.3937*(+X),0,2) Q
 I $E(GMR)="I"!($E(GMR)="i")!($E(GMR)="""") S X=+X Q
 I $E(GMR)="F"!($E(GMR)="f")!($E(GMR)="'") D FTIN Q
 S X=0
 Q
FTIN ;
 N GMRF,GMRIN,GMRXX,GMRYY
 S GMRF=$E(GMR),GMR=$E(GMR,2,$L(GMR)) F GMRXX=1:0 S GMRYY=$E(GMR) Q:GMRYY?1N!(GMRYY="")  S GMRF=GMRF_GMRYY,GMR=$E(GMR,2,$L(GMR))
 I "FTFtfTft'"'[GMRF Q
 S GMRIN=$P(GMR,+GMR,2) I "INIniNin""''"'[GMRIN!(GMRIN="'") Q
 S X=+X*12+(+GMR)
 Q
EN1 ; ENTRY TO GATHER PATIENT'S VITAL/MEASUREMENT DATA
 ; INPUT VARIABLES:
 ;
 ; DFN = Entry number of patient in Patient file.
 ; GMRVSTR = types of vital/measurements desired.  Use the abbreviations
 ;           found in the Vital Type (120.51) file.  For multiple
 ;           vitals, use the ; as a delimiter.
 ; GMRVSTR(0) = GMRVSTDT^GMRVENDT^GMRVOCC^GMRVSORD
 ;         where GMRVSTDT = The start date/time that the utility will
 ;                          use in obtaining patient data.  (OPTIONAL)
 ;               GMRVENDT = The end date/time that the utility will use
 ;                          to stop the search.  (OPTIONAL)
 ;               GMRVOCC  = The number of occurrences of the data that
 ;                          is desired by the search.  (OPTIONAL)
 ;               GMRVSORD = The sort order desired in output, see OUTPUT
 ;                          VARIABLES section.  (REQUIRED)
 ; GMRVSTR("LT") = ^TYP1^[TYP2^...]  (OPTIONAL)
 ;         THIS VARIABLE IS AN ^ DELIMITED LIST OF HOSPITAL LOCATION
 ;         TYPES TO EXTRACT MEASUREMENT DATA FOR.  E.G., ^C^M^, WILL
 ;         EXTRACT DATA FOR ONLY THOSE MEASUREMENTS TAKEN ON CLINICS
 ;         OR MODULES.
 ;
 ; OUTPUT VARIABLES:
 ;
 ; The utility will create an array with the desired information.  The
 ; array structure will be as follows if '$P(GMRVSTR(0),"^",4):
 ;      ^UTILITY($J,"GMRVD",GMRVTYP,GMRVRDT,GMRVIEN)=GMRVDATA
 ; or if $P(GMRVSTR(0),"^",4) then the following will be returned:
 ;      ^UTILITY($J,"GMRVD",GMRVRDT,GMRVTYP,GMRVIEN)=GMRVDATA
 ; where GMRVRDT  = Reverse FileMan date/time.
 ;                  9999999-Date/time vital/measurement was taken.
 ;       GMRVTYP  = The abbreviation used in the GMRVSTR string for the
 ;                  type of vital/measurement taken.
 ;       GMRVIEN  = Entry number in FILE 120.5 or
 ;                  pseudo entry number for File 704.117
 ;       GMRVDATA = $P(^GMR(120.5,GMRVIEN,0),"^",1,9) will be the patient data as
 ;                  currently defined in the DD for file 120.5.
 ;       $P(GMRVDATA,"^",10) = the first qualifier
 ;       $P(GMRVDATA,"^",11) = the second qualifier
 ;       $P(GMRVDATA,"^",12)= "*" for abnormal measurement, otherwise = ""
 ;       $P(GMRVDATA,"^",13)= values in centigrade for T; KG for WT; 
 ;                            in centimeter for HT and Circumference/Girth;
 ;                            in mmHg for CVP.
 ;       $P(GMRVDATA,"^",14)= Body Mass Index.
 ;       $P(GMRVDATA,"^",15)= L/Min of supplemental O2.
 ;       $P(GMRVDATA,"^",16)= % of supplemental O2.
 ;       $P(GMRVDATA,"^",17)= all qualifiers.
 ; The variable GMRVSTR will be killed.
 Q:'$D(GMRVSTR(0))!'($D(GMRVSTR)#2)!'($D(DFN)#2)  Q:DFN'>0
 N GMVIENGUID
 S GMRSAVE=GMRVSTR,GMRSAVE(0)=GMRVSTR(0),GMVIENGUID=0
 S GMRVSTR="HT" D EN6^GMRVUTL S GMRVSTR=GMRSAVE,GMRVSTR(0)=GMRSAVE(0) S GMRHT=(+$P(X,U,8)*2.54)/100
 I $G(GMRVSTR("LT"))="" S GMRVSTR("LT")=""
 F GMRVSTR(1)=1:1:$L(GMRVSTR,";") D
 .S GMRVSTR("T")=$P(GMRVSTR,";",GMRVSTR(1))
 .I $L(GMRVSTR("T")) D
 ..S GMRVSTR("B")=$S($P(GMRVSTR(0),U,1):$P(GMRVSTR(0),U,1),1:0)
 ..S GMRVSTR("E")=$S($P(GMRVSTR(0),U,2):$P(GMRVSTR(0),U,2),1:9999999)
 ..S GMRVSTR("O")=0,GMRVSTR("E")=GMRVSTR("E")+.000001
 ..D GETD
 K GMRINF,GG,GMRSAVE,GMRHT,GMRVARY,GMRVSTR,GMRSITE,GMRQUAL,GMRVX,GMRZTY,GDATA
 Q
GETD ; LOOP THRU PXRMINDX XREF AND GET PATIENT DATA
 S GMRVSTR("TDA")=$O(^GMRD(120.51,"C",GMRVSTR("T"),0)) Q:'GMRVSTR("TDA")
 I GMRVSTR("T")="BP"!(GMRVSTR("T")="P") D BP^GMRVUT2 Q
 F GMRVSTR("R")=GMRVSTR("E"):0 S GMRVSTR("R")=$O(^PXRMINDX(120.5,"PI",DFN,GMRVSTR("TDA"),GMRVSTR("R")),-1) Q:GMRVSTR("R")<GMRVSTR("B")!(GMRVSTR("R")'>0)  D GETD1 Q:GMRVSTR("TMO")
 Q
GETD1 ;
 N GMVCLIO
 S GMRVSTR("TMO")=0 ;max # of occurrences flag
 S GMRVSTR("IEN")=0
 F  S GMRVSTR("IEN")=$O(^PXRMINDX(120.5,"PI",DFN,GMRVSTR("TDA"),GMRVSTR("R"),GMRVSTR("IEN"))) Q:$L(GMRVSTR("IEN"))'>0  D  Q:GMRVSTR("TMO")
 .I GMRVSTR("IEN")=+GMRVSTR("IEN") D
 ..D F1205^GMVUTL(.GMVCLIO,GMRVSTR("IEN"))
 .I GMRVSTR("IEN")'=+GMRVSTR("IEN") D
 ..D CLIO^GMVUTL(.GMVCLIO,GMRVSTR("IEN"))
 .S GMVCLIO(0)=$G(GMVCLIO(0)),GMVCLIO(5)=$G(GMVCLIO(5))
 .I GMVCLIO(0)=""!($P(GMVCLIO(0),U,8)="") Q
 .D SETU2^GMRVUT2
 .Q
 Q
