LA7VHLU3 ;DALOI/JMC - HL7 Segment Utility ;Feb 13, 2009
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,68,74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
NTE(LA7ARRAY,LA7TXT,LA7TYP,LA7FS,LA7ECH,LA7NTESN,LA7CMTYP,LA7FMT) ; Build NTE segment -  notes and comments
 ; Call with LA7ARRAY = array to return NTE segment, pass by reference
 ;             LA7TXT = text to send (by value if format=0, by reference if format>0)
 ;             LA7TYP = source of comment - HL table 0105 Default to L (ancilliary/filler)
 ;              LA7FS = HL field separator
 ;             LA7ECH = HL encoding characters
 ;           LA7NTESN = segment SET ID (pass by reference)
 ;           LA7CMTYP = comment type code (HL table 0364)
 ;             LA7FMT = format of text (0=single, 1=multi-line formatted text, 2=multi-line repetition)
 ;
 N LA7CTYPE,LA7NTE,LA7TEXT
 ;
 S LA7FS=$G(LA7FS),LA7TXT=$G(LA7TXT),(LA7CTYPE,LA7TEXT)="",LA7FMT=$G(LA7FMT)
 ;
 ; Remove leading "~" from comments and escape encode text
 I 'LA7FMT D
 . I $E(LA7TXT,1)="~" S LA7TXT=$$TRIM^XLFSTR(LA7TXT,"L","~")
 . S LA7TXT=$$TRIM^XLFSTR(LA7TXT,"R"," ")
 . S LA7TEXT=$$CHKDATA^LA7VHLU3(LA7TXT,LA7FS_LA7ECH)
 ;
 I LA7FMT>0 D
 . N LA7I,LA7J
 . S (LA7I,LA7J)=0
 . F  S LA7I=$O(LA7TXT(LA7I)) Q:'LA7I  D
 . . S LA7J=LA7J+1
 . . I $E(LA7TXT(LA7I),1)="~" S LA7TXT(LA7I)=$$TRIM^XLFSTR(LA7TXT(LA7I),"L","~")
 . . S LA7TXT(LA7I)=$$TRIM^XLFSTR(LA7TXT(LA7I),"R"," ")
 . . S LA7TXT(LA7I)=$$CHKDATA^LA7VHLU3(LA7TXT(LA7I),LA7FS_LA7ECH)
 . . I LA7FMT=1 S LA7TEXT(LA7I)=LA7TEXT_$S(LA7J>1:$E(LA7ECH,3)_".br"_$E(LA7ECH,3),1:"")_LA7TXT(LA7I) Q
 . . I LA7FMT=2 S LA7TEXT(LA7I)=LA7TEXT_$S(LA7J>1:$E(LA7ECH,2),1:"")_LA7TXT(LA7I) Q
 ;
 ; Update segment SET ID
 S LA7NTESN=$G(LA7NTESN)+1
 ;
 ; Default source of comment if undefined
 I $G(LA7TYP)="" S LA7TYP="L"
 ;
 ; Encode HL7 table 0364 with comment type
 ; If no type passed then default to REmark
 ; If 'code' not found in table then send 'code' in text (2nd component).
 I $G(LA7CMTYP)="" S LA7CMTYP="RE"
 I '$D(^TMP($J,"HL70364")) D HL70364
 S LA7X=$G(^TMP($J,"HL70364",LA7CMTYP))
 I LA7X="" S $P(LA7CTYPE,$E(LA7ECH,1),2)=$$CHKDATA^LA7VHLU3(LA7CMTYP,LA7FS_LA7ECH)
 E  D
 . S LA7CTYPE=LA7CMTYP
 . S $P(LA7CTYPE,$E(LA7ECH,1),2)=$$CHKDATA^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 . S $P(LA7CTYPE,$E(LA7ECH,1),3)="HL70364"
 ;
 S LA7NTE(0)="NTE"
 S LA7NTE(1)=LA7NTESN
 S LA7NTE(2)=LA7TYP
 M LA7NTE(3)=LA7TEXT
 S LA7NTE(4)=LA7CTYPE
 ;
 D BUILDSEG^LA7VHLU(.LA7NTE,.LA7ARRAY,LA7FS)
 ;
 Q
 ;
 ;
CHKDATA(LA7IN,LA7CH) ; Check data to be built into an HL7 field for characters that
 ; conflict with encoding characters. Convert conflicting character using HL7 escape encoding.
 ;
 ; Call with LA7IN = data to be checked
 ;           LA7CH = HL7 delimiters to check for
 ;
 ; Returns LA7OUT - checked data, converted if appropriate
 ;
 N J,LA7ESC,LA7LEN,LA7OUT,X
 ;
 S LA7IN=$G(LA7IN),LA7CH=$G(LA7CH),LA7OUT=""
 ;
 I LA7IN=""!(LA7CH="") Q LA7OUT
 ;
 ; Build array of encoding characters to check
 S LA7LEN=$L(LA7CH),LA7ESC=$E(LA7CH,4)
 F J=1:1:LA7LEN S LA7CH($E(LA7CH,J))=$E("FSRET",J)
 ;
 ; Check each character and convert if appropriate
 F J=1:1:$L(LA7IN) D
 . S X=$E(LA7IN,J)
 . I $D(LA7CH(X)) S X=LA7ESC_LA7CH(X)_LA7ESC
 . S LA7OUT=LA7OUT_X
 ;
 Q LA7OUT
 ;
 ;
CNVFLD(LA7IN,LA7ECH1,LA7ECH2) ; Convert an encoded HL7 segment/field from one encoding scheme to another
 ; Call with   LA7IN = data to be converted
 ;           LA7ECH1 = delimiters of input
 ;           LA7ECH2 = delimiters of output
 ;
 ; Returns    LA7OUT = segment/field converted to new encoding scheme
 ;
 N J,LA7ECH,LA7ESC,LA7OUT,X
 ;
 S LA7IN=$G(LA7IN),LA7ECH1=$G(LA7ECH1),LA7ECH2=$G(LA7ECH2),LA7OUT=""
 ;
 I LA7IN=""!(LA7ECH1="")!(LA7ECH2="") Q LA7OUT
 ;
 ; Abort if input encoding length greater than output
 I $L(LA7ECH1)>$L(LA7ECH2) Q LA7OUT
 ;
 ; If same then return input as output
 I LA7ECH1=LA7ECH2 Q LA7IN
 ;
 S LA7ESC=$E(LA7ECH2,4)
 ;
 ; Build array to convert source encoding to target encoding
 F J=1:1:$L(LA7ECH1) S LA7ECH($E(LA7ECH1,J))=$E(LA7ECH2,J)
 ;
 ; Check each character and convert if appropriate
 ; If source conflicts with target encoding character then convert to escape encoding
 ; If match on source encoding character - convert to new encoding
 F J=1:1:$L(LA7IN) D
 . S X=$E(LA7IN,J)
 . I '$D(LA7ECH(X)),LA7ECH2[X S X=LA7ESC_$E("FSRET",($F(LA7ECH2,X)-1))_LA7ESC
 . I $D(LA7ECH(X)) S X=LA7ECH(X)
 . S LA7OUT=LA7OUT_X
 ;
 Q LA7OUT
 ;
 ;
UNESC(LA7X,LA7CH) ; Unescape data using HL7 escape encoding
 ; Call with  LA7X = string to decode
 ;           LA7CH = HL7 delimiters (both field separator & encoding characters)
 ;
 ; Returns string of unencoded data.
 ;
 N J,LA7ESC
 ;
 ; If data does not contain escape encoding then return input string as output
 S LA7ESC=$E(LA7CH,4)
 I LA7X'[LA7ESC Q LA7X
 ;
 ; Build array of encoding characters to replace
 F J=1:1:$L(LA7CH) S LA7CH(LA7ESC_$E("FSRET",J)_LA7ESC)=$E(LA7CH,J)
 ;
 Q $$REPLACE^XLFSTR(LA7X,.LA7CH)
 ;
 ;
UNESCFT(LA7X,LA7CH,LA7Y) ; Unescape formatted text data using HL7 escape encoding
 ; Call with  LA7X = array to decode (pass by reference)
 ;           LA7CH = HL7 delimiters (both field separator & encoding characters)
 ;
 ; Returns    LA7Y =  array of unencoded data.
 ;
 N J,K,LA7ESC,LA7I,LA7Z,SAVX,SAVY,Z
 ;
 S J=0,LA7ESC=$E(LA7CH,$L(LA7CH)-1),(LA7I,SAVX,SAVY)=""
 F  S LA7I=$O(LA7X(LA7I)) Q:LA7I=""  D
 . S J=J+1
 . I LA7X(LA7I)'[LA7ESC,SAVY="" S LA7Y(J,0)=LA7X(LA7I) Q
 . F K=1:1:$L(LA7X(LA7I)) D
 . . S Z=$E(LA7X(LA7I),K)
 . . I Z=LA7ESC D  Q
 . . . I SAVY="" S SAVY=Z Q
 . . . S SAVY=SAVY_Z
 . . . I $P(SAVY,LA7ESC,2)=".br" S LA7Y(J,0)=$S(SAVX]"":SAVX,1:" "),SAVX="",J=J+1
 . . . I $E(SAVY,2)'="." S SAVX=SAVX_$$UNESC(SAVY,LA7CH)
 . . . S SAVY=""
 . . I SAVY]"" S SAVY=SAVY_Z Q
 . . S SAVX=SAVX_Z
 . S LA7Y(J,0)=SAVX,SAVX=""
 S LA7Y=J
 ;
 Q
 ;
 ;
HL70364 ; Build HL7 table 0364 - Comment Type
 ;
 S ^TMP($J,"HL70364","PI")="Patient Instructions"
 S ^TMP($J,"HL70364","AI")="Ancillary Instructions"
 S ^TMP($J,"HL70364","GI")="General Instructions"
 S ^TMP($J,"HL70364","1R")="Primary Reason"
 S ^TMP($J,"HL70364","2R")="Secondary Reason"
 S ^TMP($J,"HL70364","GR")="General Reason"
 S ^TMP($J,"HL70364","RE")="Remark"
 S ^TMP($J,"HL70364","DR")="Duplicate/Interaction Reason"
 S ^TMP($J,"HL70364","VA-LR001")="Order Comment"
 S ^TMP($J,"HL70364","VA-LR002")="Result Comment"
 S ^TMP($J,"HL70364","VA-LR003")="Result Interpretation"
 S ^TMP($J,"HL70364","VA-LRMI001")="Comment on Specimen (#.99)"
 S ^TMP($J,"HL70364","VA-LRMI010")="Bact Rpt Remark (#13)"
 S ^TMP($J,"HL70364","VA-LRMI011")="Preliminary Bact Comment (#1)"
 S ^TMP($J,"HL70364","VA-LRMI012")="Bacteriology Test(s) (#1.5)"
 S ^TMP($J,"HL70364","VA-LRMI013")="Bacteriology Smear/Prep (#11.7)"
 S ^TMP($J,"HL70364","VA-LRMI020")="Parasite Rpt Remark (#17)"
 S ^TMP($J,"HL70364","VA-LRMI021")="Preliminary Parasite Comment (#16.5)"
 S ^TMP($J,"HL70364","VA-LRMI022")="Parasite Test(s) (16.4)"
 S ^TMP($J,"HL70364","VA-LRMI023")="Parasitology Smear/Prep (#15.51)"
 S ^TMP($J,"HL70364","VA-LRMI030")="Mycology RPT Remark (#21)"
 S ^TMP($J,"HL70364","VA-LRMI031")="Preliminary Mycology Comment (#20.5)"
 S ^TMP($J,"HL70364","VA-LRMI032")="Mycology Test(s) (#20.4)"
 S ^TMP($J,"HL70364","VA-LRMI033")="Mycology Smear/Prep (#19.6)"
 S ^TMP($J,"HL70364","VA-LRMI040")="TB Rpt Remark (#27)"
 S ^TMP($J,"HL70364","VA-LRMI041")="Preliminary TB Comment (#26.5)"
 S ^TMP($J,"HL70364","VA-LRMI042")="TB Test(s) (#26.4)"
 S ^TMP($J,"HL70364","VA-LRMI050")="Virology Rpt Remark (#37)"
 S ^TMP($J,"HL70364","VA-LRMI051")="Preliminary Virology Comment (#36.5)"
 S ^TMP($J,"HL70364","VA-LRMI052")="Virology Test (#36.4)"
 Q
 ;
 ;
PCENC(LRDFN,LRSS,LRIDT) ; Find PCE encounter for an entry in file #63
 ;
 ; Call with LRDFN = entry in file #63
 ;            LRSS = file #63 subscript
 ;           LRIDT = inverse date/time of specimen in file #63
 ;
 ; Returns   LA7ENC = related PCE encounter
 ;
 N LA7ENC,LA7UID,LA7X,LA7Y,LRODT,LRSN
 S LA7ENC="",LA7UID=$P($G(^LR(LRDFN,LRSS,LRIDT,"ORU")),"^")
 I LA7UID'="" D
 . S LA7X=$$CHECKUID^LRWU4(LA7UID)
 . I 'LA7X Q
 . S LA7Y=$G(^LRO(68,$P(LA7X,"^",2),1,$P(LA7X,"^",3),1,$P(LA7X,"^",4),0))
 . S LRODT=+$P(LA7Y,"^",4),LRSN=+$P(LA7Y,"^",5)
 . I $P(LA7Y,"^",2)=2,LRODT,LRSN S LA7ENC=$G(^LRO(69,LRODT,1,LRSN,"PCE"))
 ;
 Q LA7ENC
 ;
 ;
SDENC(LA7PCE) ; Find SD Outpatient Encounter for an entry in file #63
 ;
 ; Call with LA7PCE = PCE encounters from file #69
 ;
 ; Returns   LA7ENC = related SD encounter
 ;
 N LA7ENC,LA7X,LA7Y,LA7Z
 ;
 S LA7ENC=""
 F LA7I=1:1 S LA7X=$P(LA7PCE,";",LA7I) Q:LA7X=""  D  Q:LA7ENC'=""
 . K LA7Y
 . D LISTVST^SDOERPC(.LA7Y,LA7X)
 . S LA7Z=$Q(@LA7Y)
 . I $QS(LA7Z,1)="SD ENCOUNTER LIST",$QS(LA7Z,2)=$J S LA7ENC=$QS(LA7Z,3)
 . K @LA7Y
 ;
 Q LA7ENC
