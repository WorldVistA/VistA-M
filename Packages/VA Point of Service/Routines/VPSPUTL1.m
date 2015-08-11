VPSPUTL1 ;DALOI/KML -  PDO OUTPUT DISPLAY - UTILITIES ;11/20/11 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Oct 21, 2011;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
SETFLD(STR,VAR,COLATTR) ; -- set field in var
 ; INPUT 
 ;   STR     : string to insert
 ;   VAR     : destination string
 ;   COLATTR : column attributes
 Q $$SETSTR(STR,VAR,+$P(COLATTR,U),+$P(COLATTR,U,2))
 ;
SETSTR(S,V,X,L) ; -- insert text(S) into variable(V)
 ; INPUT 
 ;    S : string to insert
 ;    V : destination string
 ;    X : insert @ col X
 ;    L : clear # of chars (length)
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
 ;
ADDLN(PDONOTE,STR) ; add a line to note
 ; INPUT 
 ;   PDONOTE : global or local array containing the lines of the note
 ;   STR     : string of data that gets assigned to a subscript in the local or global array (PDONOTE)
 N L
 S L=$O(@PDONOTE@(""),-1)+1
 S @PDONOTE@(L,0)=STR
 Q
 ;
PDOERR(LMRARDT,PTIEN) ; update PDO INVOCATION ERROR field when PDO was requested after the PDO INVOCABLE PERIOD
 ; INPUT:
 ;    LMRARDT = Fileman date representing the last MRAR on record
 ;    PTIEN = DFN
 N VPSFDA
 S VPSFDA(853.51,LMRARDT_","_PTIEN_",",72)="E"
 D FILE^DIE("","VPSFDA","")
 Q
 ;
FCOMM(COM,WIDTH,NCOM) ; reformat comments to to fit in column on note
 ; INPUT
 ;   COM   : comments array
 ;   WIDTH : amount of characters available for column 
 ; OUTPUT
 ;   NCOM  : array built with the re-formatted contents of COM
 ;          ^TMP("VPSPUTL1",$J) = maintain overall counter for comment reformatting purposes
 N C1,START,END,CTR,SAV,QUIT
 I '$D(^TMP("VPSPUTL1",$J)) S ^($J)=0
 S C1=0,CTR=^TMP("VPSPUTL1",$J)+1
 F  S C1=$O(COM(C1)) Q:'C1  D
 . S QUIT=0,START=1
 . I '$D(SAV) S END=WIDTH
 . E  S CTR=SAV
 . F CTR=CTR:1 S NCOM(CTR)=$G(NCOM(CTR))_$E(COM(C1),START,END) D  Q:QUIT
 . . I NCOM(CTR)="" K NCOM(CTR) S QUIT=1 Q  ; no more comments to format
 . . I $L(NCOM(CTR))<WIDTH S SAV=CTR S END=WIDTH-$L(NCOM(CTR)) S QUIT=1 Q  ; start any next line of comments where last one left off
 . . S START=END+1,END=END+WIDTH
 S ^TMP("VPSPUTL1",$J)=CTR
 Q
 ;
REACT(STAFF,LMRARDT,PTIEN,A2,COL,FLD03,NCOMM) ;  format allergy reactions
 ; INPUT
 ;   STAFF   : is MRAR staff-facing interface ?
 ;   LMRARDT : Fileman date representing the last MRAR on record
 ;   PTIEN   : DFN
 ;   A2      : allergy sub-entry ien
 ;   COL     : COLUMN ATTRIBUTE ARRAY used when formatting the string for each line on the note
 ;   FLD03   : array of reactions
 ; INPUT/OUTPUT:
 ;   NCOMM   : reactions and staff facing comments array formatted for display on PDO ouput
 ; 
 N TEMP,ARRAY
 K NCOMM
 D FCOMM(.FLD03,$P(COL("REACTION"),U,2),.TEMP)
 M ARRAY=TEMP
 I STAFF D ALLCOMM(LMRARDT,PTIEN,A2,.COL,.ARRAY)
 S ^TMP("VPSPUTL1",$J)=0 D FCOMM(.ARRAY,$P(COL("REACTION"),U,2),.NCOMM)
 Q
 ;
ALLCOMM(LMRARDT,PTIEN,A2,COL,ARRAY) ; format allergy section comments from staff-facing
 ; INPUT
 ;   LMRARDT : Fileman date representing the last MRAR on record
 ;   PTIEN   : DFN
 ;   A2      : allergy sub-entry ien
 ;   COL     : COLUMN ATTRIBUTE ARRAY used when formatting the string for each line on the note
 ; INPUT/OUTPUT
 ;   ARRAY - reactions AND staff facing comments array formatted for display on PDO ouput
 ;
 N COMMENTS,TEMP
 S COMMENTS=$$GET1^DIQ(853.52,A2_","_LMRARDT_","_PTIEN_",",2,"","COMMENTS")  ; staff facing staff view comments
 I COMMENTS]"" S COMMENTS(1)=";"_COMMENTS(1) D FCOMM(.COMMENTS,$P(COL("REACTION"),U,2),.TEMP)
 M ARRAY=TEMP
 K COMMENTS,TEMP
 S COMMENTS=$$GET1^DIQ(853.52,A2_","_LMRARDT_","_PTIEN_",",3,"","COMMENTS")  ; staff facing vet view comments
 I COMMENTS]"" S COMMENTS(1)=";"_COMMENTS(1) D FCOMM(.COMMENTS,$P(COL("REACTION"),U,2),.TEMP)
 M ARRAY=TEMP
 Q
 ;
SIG(LMRARDT,PTIEN,FLD13,COL,SIG) ;  format patient instructions
 ; INPUT:
 ; LMRARDT = Fileman date representing the last MRAR on record
 ; PTIEN = DFN
 ; FLD13 - patient instructions (sig) at 853.54,13
 ; COL - COLUMN ATTRIBUTE ARRAY used when formatting the string for each line on the note
 ; INPUT/OUTPUT:
 ; SIG - patient instructions formatted in an array for display on PDO output
 K SIG
 N PSIG
 S PSIG(1)=FLD13 ; set up string into array format
 S ^TMP("VPSPUTL1",$J)=0
 D FCOMM(.PSIG,$P(COL("SIG"),U,2),.SIG)
 I $D(SIG(3)) S SIG(2)=$E(SIG(2),1,$P(COL("SIG"),U,2)-4)_"..."  ; display just up to 2 lines of patient instructions; if 3rd line exists indicate more instructions by "..."
 Q
 ;
GCOMM(LMRARDT,PTIEN,MIEN,STAFF,COL,PATCOMM) ;  get unstructured comment fields and reformat to fit TIU note
 ; per PROVIDER FACING OUTPUT requirements; comments have a specific display format
 ; unstructured comments from patient facing and provider facing (staff view and vet view) can exist and are stored as discrete fields in 853.54 sub=file
 ; the potential exists for all 3 fields to be sent in a single MRAR session and comments about a medication need to be displayed at a specific column when
 ; displaying the MRAR PDO.
 ; INPUT:
 ; LMRARDT = Fileman date representing the last MRAR on record
 ; PTIEN = DFN
 ; MIEN - medication sub-entry ien
 ; STAFF - output represents content coming from staff-facing interface
 ; COL - COLUMN ATTRIBUTE ARRAY used when formatting the string for each line on the note
 ; INPUT/OUTPUT:
 ; PATCOMM -  array built in this procedure that reformats word processing fields from 853.54 to fit into PDO OUTPUT (tiu note)
 N LSS,QUOTE,XXX,NFLD23,NFLD24,NFLD25,FLD23,FLD24,FLD25,TEMP
 S QUOTE=""""
 S FLD23=$$GET1^DIQ(853.54,MIEN_","_LMRARDT_","_PTIEN_",",23,"","FLD23")  ; medication comments from patient-facing (word processing  field)
 S FLD24=$$GET1^DIQ(853.54,MIEN_","_LMRARDT_","_PTIEN_",",24,"","FLD24")  ; medication comments from staff-facing staff view (word processing  field)
 S FLD25=$$GET1^DIQ(853.54,MIEN_","_LMRARDT_","_PTIEN_",",25,"","FLD25")  ; medication comments from staff-facing vet view (word processing  field)
 I 'STAFF,FLD23]"" D  Q
 . S XXX=0 F  S XXX=$O(FLD23(XXX)) Q:'XXX
 . S FLD23(1)="PATIENT COMMENTS: "_FLD23(1)
 . D FCOMM(.FLD23,$P(COL("COMMENTS"),U,2),.PATCOMM)
 ;if fields at 23&24&25 populated
 ;23 needs to have the 'PATIENT COMMENTS:' in front of comment string and since the comments come from patient facing it needs to be in quotes; 24 and 25 need to have a pre-pended ";"
 I (FLD23]"")&(FLD24]"")&(FLD25]"") D
 . S XXX=0 F  S XXX=$O(FLD23(XXX)) Q:'XXX  S LSS=XXX
 . S FLD23(1)="PATIENT COMMENTS: "_QUOTE_FLD23(1),FLD23(LSS)=FLD23(LSS)_QUOTE
 . D FCOMM(.FLD23,$P(COL("COMMENTS"),U,2),.NFLD23)
 . S FLD24(1)=";"_FLD24(1) D FCOMM(.FLD24,$P(COL("COMMENTS"),U,2),.NFLD24)
 . S FLD25(1)=";"_FLD25(1) D FCOMM(.FLD25,$P(COL("COMMENTS"),U,2),.NFLD25)
 . M TEMP=NFLD23,TEMP=NFLD24,TEMP=NFLD25
 ;if fields at 23&24&'25 populated
 ;23 needs to have the 'PATIENT COMMENTS:' in front of comment string and since the comments come from patient facing it needs to be in quotes; 24 needs to have a pre-pended ";" 
 I (FLD23]"")&(FLD24]"")&(FLD25']"") D
 . S X=0 F  S X=$O(FLD23(X)) Q:'X  S LSS=X
 . S FLD23(1)="PATIENT COMMENTS: "_QUOTE_FLD23(1),FLD23(LSS)=FLD23(LSS)_QUOTE
 . D FCOMM(.FLD23,$P(COL("COMMENTS"),U,2),.NFLD23)
 . S FLD24(1)=";"_FLD24(1) D FCOMM(.FLD24,$P(COL("COMMENTS"),U,2),.NFLD24)
 . M TEMP=NFLD23,TEMP=NFLD24
 ; if '23&24&25
 ; 24 needs to have the 'PATIENT COMMENTS:' in front of comment string;  25  needs to have a pre-pended ";"
 I (FLD23']"")&(FLD24]"")&(FLD25]"") D
 . S FLD24(1)="PATIENT COMMENTS: "_FLD24(1) D FCOMM(.FLD24,$P(COL("COMMENTS"),U,2),.NFLD24)
 . S FLD25(1)=";"_FLD25(1) D FCOMM(.FLD25,$P(COL("COMMENTS"),U,2),.NFLD25)
 . M TEMP=NFLD24,TEMP=NFLD25
 ; if 23&'24&'25
 ; 23 needs to have the 'PATIENT COMMENTS:' in front of comment string and since the comments come from patient facing it needs to be in quotes
 I (FLD23]"")&(FLD24']"")&(FLD25']"") D
 . S XXX=0 F  S XXX=$O(FLD23(XXX)) Q:'XXX  S LSS=XXX
 . S FLD23(1)="PATIENT COMMENTS: "_QUOTE_FLD23(1),FLD23(LSS)=FLD23(LSS)_QUOTE
 . D FCOMM(.FLD23,$P(COL("COMMENTS"),U,2),.NFLD23)
 . M TEMP=NFLD23
 ;if '23&24&'25
 ;24 needs to have the 'PATIENT COMMENTS:' in front of comment string ; 
 I (FLD23']"")&(FLD24]"")&(FLD25']"") D
 . S FLD24(1)="PATIENT COMMENTS: "_FLD24(1)
 . D FCOMM(.FLD24,$P(COL("COMMENTS"),U,2),.NFLD24)
 . M TEMP=NFLD24
 ;if '23&'24&25
 ; 25 needs to have the 'PATIENT COMMENTS:' in front of comment string
 I (FLD23']"")&(FLD24']"")&(FLD25]"") D
 . S FLD25(1)="PATIENT COMMENTS: "_FLD25(1)
 . D FCOMM(.FLD25,$P(COL("COMMENTS"),U,2),.NFLD25)
 . M TEMP=NFLD25
 S ^TMP("VPSPUTL1",$J)=0 D FCOMM(.TEMP,$P(COL("COMMENTS"),U,2),.PATCOMM)  ; produce displayable version of comments
 Q
