LA7VIN7 ;DALOI/JDB - HANDLE ORU OBX FOR MICRO/AP ;11/18/11  14:13
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Continuation of LA7VIN1 and is only called from there.
 ; Process OBX segments for "MI" subscript tests.
 Q
 ;
 ;
OBX ;
 ;
 N ALTCONC,CODSYS,DATA,DIERR,DSOBX3,DSOBX5,ISCOMP,OBX3,OBX4,OBX5,OBX6,OBX8,OBX11,OBX15
 N LA76247,LA7612,LA74,LA7RLNC,LA7RNLT,LA7SCT,LA7SUBFL,LA7VTYP,LAX,LAY
 ;
 ; Note: LA7OBR25 holds the OBR's report status (OBR-25)
 K LA7RMK,^TMP("LA7TREE",$J)
 ;
 ; OBX Set ID
 S LA7SOBX=$$P^LA7VHLU(.LA7SEG,2,LA7FS)
 ;
 ; Value type - type of data from Table 0125
 S LA7VTYP=$P($$P^LA7VHLU(.LA7SEG,3,LA7FS),LA7CS)
 ;
 S OBX3=$$FIELD^LA7VHLU7(3)
 D FLD2ARR^LA7VHLU7(.OBX3)
 I $D(OBX3)>1 S ISCOMP("OBX3")=1
 ; step through code tuplets until we find one we can process
 S DSOBX3=$$DBSTORE^LA7VHLU7(.OBX3,1,,,LA76248,.DATA)
 ; check for LN and/or 99VA64 code systems
 K CODSYS D CODSYS^LA7VHLU7(.OBX3,.CODSYS)
 ; Result's LOINC code
 S LAX=+$O(CODSYS("B","LN",0))
 S LA7RLNC=""
 I LAX S LA7RLNC=OBX3(LAX-2) S LA7RLNC(1)=OBX3(LAX-1)
 ; Result's NLT code
 S LAX=+$O(CODSYS("B","99VA64",0))
 S LA7RNLT=""
 I LAX S LA7RNLT=OBX3(LAX-2) S LA7RNLT(1)=OBX3(LAX-1)
 K CODSYS
 ;
 ; OBX3 cannot be mapped. Stop processing.
 ; No File #62.47 mapping found for OBX-3
 I +DSOBX3'>0 D  Q  ;
 . N LA7OBX3
 . S LA7OBX3=OBX3 ;needed for log
 . S LA7OBX3=$$UNESC^LA7VHLU3(LA7OBX3,LA7FS_LA7ECH)
 . D CREATE^LA7LOG(200)
 . S LA7KILAH=1 S LA7QUIT=2
 ;
 S LA76247=$P(DSOBX3,"^",1)
 ;
 ;
 S OBX4=$$FIELD^LA7VHLU7(4)
 S OBX5=$$FIELD^LA7VHLU7(5)
 I OBX5="" D CREATE^LA7LOG(17) Q
 ;
 S (DSOBX5,LA7SCT)="",LA7612=0
 ;
 ; String Data/ Formatted Text/ Text Data
 ;I LA7VTYP?1(1"FT",1"ST",1"TX") D
 ;I LA7VTYP="FT" D
 ;. K LAX
 ;. D PA^LA7VHLU(.LA7SEG,6,LA7FS,.LAX)
 ;. D UNESCFT^LA7VHLU3(.LAX,LA7FS_LA7ECH,.LA7WP)
 ;
 I LA7VTYP?1(1"CE",1"CM",1"CNE",1"CWE") D
 . D FLD2ARR^LA7VHLU7(.OBX5)
 . I $D(OBX5)>1 S ISCOMP("OBX5")=1
 . ; step through code tuplets until we find one we can process
 . K DATA
 . S DSOBX5=$$DBSTORE^LA7VHLU7(.OBX5,2,1,+LA76247,+$G(LA76248),.DATA)
 . K CODSYS
 . D CODSYS^LA7VHLU7(.OBX5,.CODSYS)
 . ; No Coding System found is an error
 . ; Prevent new File #61.2 entries created from bad OBX-5
 . I $O(CODSYS("B",0))="" D  Q  ;
 . . N LA7VOBX5
 . . S LA7VOBX5=OBX5
 . . S LA7VOBX5=$$UNESC^LA7VHLU3(LA7VOBX5,LA7FS_LA7ECH)
 . . D CREATE^LA7LOG(203)
 . . S LA7KILAH=1 S LA7QUIT=2
 . ;
 . ; get SCT code if present
 . S LAX=$O(CODSYS("B","SCT",0)) I LAX S LA7SCT=$G(OBX5(LAX-2))
 . ;
 ;
 Q:$G(LA7QUIT)
 ;
 ; Need to check data storage type of DSOBX3 and compare to data in OBX-5.
 ; If OBX5 is a CE but DSOBX3 shows text (data type mismatch)
 ; then check if there's an ALTERNATIVE CONCEPT for LA76247
 S ALTCONC=$$ALCONCPT^LA7VHLU6(LA76247)
 I ALTCONC>0 I ALTCONC'=LA76247 D  ;
 . N R64061,SS,TLC,X,FILE,FLD,LAOUT,LAMSG,LADT1,LADT2
 . N DATAOK,X
 . S DATAOK=0
 . S FILE=$P(DSOBX3,"^",3)
 . S FLD=$P(DSOBX3,"^",4)
 . ; data type of current storage location
 . S LADT1=$$GET1^DID(FILE,FLD,"","TYPE","LAOUT","LAMSG")
 . I LADT1["POINTER",LA7VTYP?1(1"CE",1"CM",1"CNE",1"CWE") Q
 . S DATAOK=0
 . I LADT1="SET" D  Q:DATAOK  ;
 . . ; 7,21 can be reported as CE/SCT which get translated to SET
 . . I "^7^21^"[("^"_LA76247_"^") S DATAOK=1 Q
 . . S DATAOK=$$DATAOK(FILE,FLD,OBX5)
 . ;
 . I LADT1'="SET",LADT1'["POINTER",LA7VTYP'?1(1"CE",1"CM",1"CNE",1"CWE") Q
 . Q:DATAOK
 . ; get alternate concept data
 . S X=$G(^LAB(62.47,ALTCONC,0))
 . S R64061=$P(X,U,3)
 . S SS=$P(X,U,2)
 . S X=$G(^LAB(64.061,R64061,63))
 . S FILE=$P(X,U,2)
 . S FLD=$P(X,U,3)
 . I 'FILE I 'FLD Q
 . S TLC=$P(X,U,4) ;SCT Top Level
 . S LADT2=$$GET1^DID(FILE,FLD,"","TYPE","LAOUT","LAMSG")
 . I LADT1=LADT2 Q
 . I LA7VTYP?1(1"CE",1"CM",1"CNE",1"CWE") D
 . . I LADT1["POINTER" Q
 . . S DSOBX3(1)=DSOBX3
 . . S DSOBX3=ALTCONC_"^"_SS_"^"_FILE_"^"_FLD_"^"_TLC
 . I LA7VTYP'?1(1"CE",1"CM",1"CNE",1"CWE") D
 . . I LADT1'["POINTER" Q
 . . S DSOBX3(1)=DSOBX3
 . . S DSOBX3=ALTCONC_"^"_SS_"^"_FILE_"^"_FLD_"^"_TLC
 . ;
 ;
 ;
 I LA7VTYP?1(1"CE",1"CM",1"CNE",1"CWE") D
 . ; Do only if Concept (#62.47) is not a susceptibility concept (susc reported as SCT code)
 . ; Create new file entry if needed
 . I LA76247'=7,LA76247'=21,LA7SS="MI",(+DSOBX5<-1!(+DSOBX5=0)) D
 . . ; Stage Result may be reported as SCT code
 . . I LA76247=13 I LA7SCT'="" S X=$$SCT2PSTG^LA7VHLU6(LA7SCT,,"SCT") Q:X'=""
 . . ; add entry (add local code to #62.47 if needed?)
 . . ; If SCT was passed use that one, else use primary component
 . . N FILE,TXT,FLD,MSG
 . . S FILE=$P(DSOBX3,"^",3)
 . . S FLD=$P(DSOBX3,"^",4)
 . . S X=$$GET1^DID(FILE,FLD,"","TYPE","","MSG")
 . . I X'="POINTER" S FILE=""
 . . I X="POINTER" S FILE=$$GET1^DID(FILE,FLD,"","POINTER","","MSG")
 . . I FILE'="" D  ;
 . . . ; no API to convert global root [ie LAHM(62.48)] to file #
 . . . S FILE="^"_FILE
 . . . S FILE=$$TRIM^XLFSTR(FILE,"R",",")
 . . . I $P(FILE,"(",2)'="" S FILE=FILE_"," ;^XX( or ^XX(nn
 . . . S FILE=FILE_"0)"
 . . . I FILE'="" S FILE=$G(@FILE)
 . . . S FILE=+$P(FILE,U,2)
 . . ;
 . . N LAHLSEGS,LA74,SCTINOBX
 . . S SCTINOBX=0
 . . ;S TXT=OBX5(2)
 . . I LA7SCT'="" D  ;
 . . . S LAX=$O(CODSYS("B","SCT",0))
 . . . I LAX S SCTINOBX=LAX
 . . . ;S TXT=OBX5(LAX-1)
 . . ;S TXT=$$UNESC^LA7VHLU3(TXT,LA7FS_LA7ECH)
 . . S LA74=$$LKUP^XUAF4(LA7SFAC)
 . . S LAHLSEGS("R4")=LA74
 . . S LAHLSEGS("R6247")=$G(LA76247)
 . . S LAHLSEGS("FSEC")=LA7FS_LA7ECH
 . . S LAHLSEGS("MSH",3)=LA7SAP
 . . S LAHLSEGS("MSH",4)=LA7SFAC
 . . S LAHLSEGS("MSH",5)=LA7RAP
 . . S LAHLSEGS("MSH",6)=LA7RFAC
 . . S LAHLSEGS("MSH",11)=$G(LA7MID)
 . . S LAHLSEGS("OBX",3)=OBX3
 . . S LAHLSEGS("OBX",5)=OBX5
 . . ; ? Should we try SCT first no matter which codeset it is?
 . . ; try primary codeset first
 . . S TXT=$G(OBX5(2))
 . . S TXT=$$UNESC^LA7VHLU3(TXT,LA7FS_LA7ECH)
 . . S X=$S(SCTINOBX=3:LA7SCT,1:"") ;SCT in 1st component?
 . . S X=$$EN^LRSCTX(FILE,TXT,X,.LAHLSEGS,,1)
 . . ; try secondary codeset
 . . I X'>0 D  ;
 . . . S TXT=$G(OBX5(5))
 . . . S TXT=$$UNESC^LA7VHLU3(TXT,LA7FS_LA7ECH)
 . . . I TXT="" S X=0 Q
 . . . S X=$S(SCTINOBX=6:LA7SCT,1:"") ;SCT in 2nd component?
 . . . S X=$$EN^LRSCTX(FILE,TXT,X,.LAHLSEGS,,1)
 . . ; no matches so add new entry using codeset 1
 . . I X'>0 D  ;
 . . . S TXT=$G(OBX5(2))
 . . . S TXT=$$UNESC^LA7VHLU3(TXT,LA7FS_LA7ECH)
 . . . S X=$S(SCTINOBX=3:LA7SCT,1:"")
 . . . S X=$$EN^LRSCTX(FILE,TXT,X,.LAHLSEGS)
 . . I X'>0 D  Q  ; create error log:  Could not create new entry in file
 . . . N LA7STR,LRFILE,LRINFO
 . . . S LA7STR("^")="~U~",LRFILE=FILE,LRINFO="for OBX sequence "_LA7SOBX_" OBX(5) data: "_$$REPLACE^XLFSTR(OBX5,.LA7STR)
 . . . D CREATE^LA7LOG(206)
 . . . S LA7KILAH=1,LA7QUIT=2
 . . . ;
 . . I FILE=61.2 S LA7612=+X
 . . K DATA,LAHLSEGS
 . . S DSOBX5=$$DBSTORE^LA7VHLU7(.OBX5,2,1,+LA76247,+$G(LA76248),.DATA)
 . . K DATA
 . S LAX=OBX5 K OBX5 S OBX5=LAX ;delete OBX5 array but keep OBX5
 . K CODSYS
 ;
 Q:$G(LA7QUIT)
 ;
 ;
 S OBX6=$$FIELD^LA7VHLU7(6)
 S OBX8=$$FIELD^LA7VHLU7(8)
 ;
 ; Observation result status - Table 0085
 S OBX11=$$FIELD^LA7VHLU7(11)
 ;
 ; Producer's ID
 S OBX15=$$FIELD^LA7VHLU7(15)
 S (LA74,LA7PRODID)=$$RESFID^LA7VHLU2(OBX15,LA7SFAC,LA7CS)
 ;
 ; Responsible Observer
 S LA7RO=$$XCNTFM^LA7VHLU9($$FIELD^LA7VHLU7(16),LA7ECH)
 S LA7SUBFL=""
 ;
 ; Process MI or AP subscripts
 I $G(LA7SS)'="" D
 . I LA7SS="MI" D  Q
 . . D PROCESS^LA7VIN71
 . . S LA7SUBFL=63.05
 . I LA7SS?1(1"SP",1"CY",1"EM") D  Q
 . . D PROCESS^LA7VIN6
 . . S LA7SUBFL=$S(LA7SS="SP":63.08,LA7SS="CY":63.09,LA7SS="EM":63.02,1:"")
 ;
 ; Set flags for alerts and bulletins
 I LA7INTYP=10,LA7MTYP="ORU",OBX11'="" D  ;
 . I "CDW"'[OBX11 D  Q
 . . ; flag for new results alert
 . . S ^TMP("LA7-ORU",$J,LA76248,LA76249,LA7SS)=""
 . ;
 . Q:'LA7SUBFL
 . ; Set flag to send amended results bulletin
 . N DATA,X,X2,Y,LA7I
 . S LA7I=$O(^TMP("LA7 AMENDED RESULTS",$J,""),-1)
 . S LA7I=LA7I+1
 . S DATA=LA7LWL_"^"_LA7ISQN_"^"_LA7SUBFL_"^"_LA76248_"^"_LA76249_"^"_$TR(OBX11,"^","?")
 . S X2=""
 . I LA7RNLT'="" S X2=LA7RNLT_"^"_LA7RNLT(1)
 . I LA7RLNC'="" S X2=LA7RLNC_"^"_LA7RLNC(1)
 . ; If no NLT or LOINC use 1st codeset of OBX3
 . I X2="" D  ;
 . . S Y=OBX3
 . . D FLD2ARR^LA7VHLU7(.OBX3,LA7FS_LA7ECH)
 . . S X2=$$UNESC^LA7VHLU3($G(OBX3(1)),LA7FS_LA7ECH)
 . . S X2=X2_"^"_$$UNESC^LA7VHLU3($G(OBX3(2)),LA7FS_LA7ECH)
 . . K OBX3 S OBX3=Y
 . S DATA=DATA_"^"_X2_"^"_$TR(OBX8,"^","?")
 . ; only register amended if not already registered
 . I LA7UID'="" I '$D(^LAH("LA7 AMENDED RESULTS",LA7UID,LA7SUBFL,LA7LWL,LA7ISQN)) D  ;
 . . S ^TMP("LA7 AMENDED RESULTS",$J,LA7I)=DATA
 . ;
 . I LA7UID'="" S ^LAH("LA7 AMENDED RESULTS",LA7UID,LA7SUBFL,LA7LWL,LA7ISQN)=DATA
 ;
 Q
 ;
 ;
DATAOK(FILE,FLD,VAL) ;
 ; Checks if a value is appropriate for storing in the field
 ; Inputs
 ;  FILE : File #
 ;   FLD : Field #
 ;   VAL : Value of the field
 ;
 ; Returns 0 (invalid) or 1 (valid)
 ;
 N LRNOECHO,MSG,OUT,STATUS
 ;
 ; LRNOECHO used to suppress echo when input transform calls COM^LRNUM
 S STATUS=0,LRNOECHO=1
 D CHK^DIE(FILE,FLD,"",VAL,.OUT,"MSG")
 I $G(OUT)'="^" S STATUS=1
 I $D(MSG) S STATUS=0
 ;
 Q STATUS
