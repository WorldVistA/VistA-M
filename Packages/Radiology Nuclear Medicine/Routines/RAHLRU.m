RAHLRU ;HISC/SWM - utilities for HL7 messaging ;03/16/98  11:03
 ;;5.0;Radiology/Nuclear Medicine;**10,25,81,103**;Mar 16, 1998;Build 2
 ;
 ; 08/13/2010 BP/KAM RA*5*103 Outside Report Status Code needs 'F'
 ;IA 2701 used to store ICN in PID-3 ($$GETICN^MPIF001)
 ;IA 3630 used to build the PID segment for our ORM & ORU HL7 messages
 ;
OBX11 ; set OBX-11, = 12th piece of string where piece 1 is "OBX"
 N RARPTIEN,Y
 S RARPTIEN=+$G(RARPT)
 S Y=$P($G(^RARPT(RARPTIEN,0)),U,5)
 ; 08/13/2010 BP/KAM RA*5*103 Remedy Call 363538 Changed next line to
 ;                                               test for 'EF' or 'V'
 ;S $P(HLA("HLS",RAN),HLFS,12)=$S(Y="R":"P",Y="V":"F",1:"I")
 S $P(HLA("HLS",RAN),HLFS,12)=$S(Y="R":"P",(Y="V")!(Y="EF"):"F",1:"I")
 ; END *103 CHANGE
 I $D(^RARPT(RARPTIEN,"ERR")) D  Q
 .S $P(HLA("HLS",RAN),HLFS,12)="C"
 Q
 ;
ESCAPE(XDTA) ;apply the appropriate escape sequence to a string of data
 ; Insert a escape sequence place holder, then swap the escape sequence
 ; place holder with the real escape sequence. This action requires two
 ; passes because the escape sequence uses the escape ("\") character.
 ; Input:  XDTA=data string to be escaped (if necessary)
 ;         HLFS=field separator     (global scope; set in INIT^RAHLR)
 ;        HLECH=encoding characters (global scope; set in INIT^RAHLR)
 ; Return: XDTA=an escaped data string
 ;
 N UFS,UCS,URS,UEC,USS ;field, component, repetition, escape, & subcomponent
 S UFS=HLFS,UCS=$E(HLECH),URS=$E(HLECH,2),UEC=$E(HLECH,3),USS=$E(HLECH,4)
 F  Q:XDTA'[UFS  S XDTA=$P(XDTA,UFS)_$C(1)_$P(XDTA,UFS,2,999)
 F  Q:XDTA'[UCS  S XDTA=$P(XDTA,UCS)_$C(2)_$P(XDTA,UCS,2,999)
 F  Q:XDTA'[URS  S XDTA=$P(XDTA,URS)_$C(3)_$P(XDTA,URS,2,999)
 F  Q:XDTA'[UEC  S XDTA=$P(XDTA,UEC)_$C(4)_$P(XDTA,UEC,2,999)
 F  Q:XDTA'[USS  S XDTA=$P(XDTA,USS)_$C(5)_$P(XDTA,USS,2,999)
 F  Q:XDTA'[$C(1)  S XDTA=$P(XDTA,$C(1))_UEC_"F"_UEC_$P(XDTA,$C(1),2,999)
 F  Q:XDTA'[$C(2)  S XDTA=$P(XDTA,$C(2))_UEC_"S"_UEC_$P(XDTA,$C(2),2,999)
 F  Q:XDTA'[$C(3)  S XDTA=$P(XDTA,$C(3))_UEC_"R"_UEC_$P(XDTA,$C(3),2,999)
 F  Q:XDTA'[$C(4)  S XDTA=$P(XDTA,$C(4))_UEC_"E"_UEC_$P(XDTA,$C(4),2,999)
 F  Q:XDTA'[$C(5)  S XDTA=$P(XDTA,$C(5))_UEC_"T"_UEC_$P(XDTA,$C(5),2,999)
 Q XDTA
 ;
 ;
 ;ESCAPE(STR)    ;'Escape out' the formatting codes in data strings...
 ; Input: Where STR is the data string to 'escape out'.
 ;    ex: "this is a test case^"
 ;Output: "this is a test case\S\"
 ;
 ;assuming the following as our encoding characters (HLECH): "^~\&" 
 ;encoding character position, character representations, & escape seq
 ;1) component separator    "^"  \S\
 ;2) repetition separator   "~"  \R\
 ;3) escape character       "\"  \E\
 ;4) subcomponent separator "&"  \T\
 ;
 ;assuming the following as our field separator (HLFS): "|" the escape
 ;sequence is: \F\. All of the following can be embedded in data, so
 ;field separator and encoding characters have to be converted to the
 ;correct formatting codes (escape sequences). We'll accomplish this by
 ;concatenating the field separator string to the encoding character
 ;string (ENCDE).
 ;
 ;Q:STR="" STR ;no string to escape...
 ;N BUF,ESC,CH,I1,I2,ENCDE S ENCDE=HLFS_HLECH
 ;--- Find all occurences of field separator & encoding
 ;--- characters; save their positions to a local array
 ;F I1=1:1:5  D
 ;. S CH=$E(ENCDE,I1),I2=1
 ;. F  S I2=$F(STR,CH,I2)  Q:'I2  S BUF(I2-1)=I1
 ;Q:$D(BUF)<10 STR
 ;--- Replace HL7 field separator & encoding chars with formatting codes
 ;S (BUF,I2)="",ESC=$E(HLECH,3)  S:ESC="" ESC="\"
 ;F  S I1=I2,I2=$O(BUF(I2))  Q:I2=""  D
 ;. S BUF=BUF_$E(STR,I1+1,I2-1)_ESC_$E("FSRET",BUF(I2))_ESC
 ;Q BUF_$E(STR,I1+1,$L(STR))
 ;
OBXPRC ;Compile 'OBX' Segment for Procedure
 S HLA("HLS",RAN)="OBX"_HLFS_HLFS_"CE"_HLFS_"P"_$E(HLECH)_"PROCEDURE"_$E(HLECH)_"L"_HLFS_HLFS_$P(RACN0,"^",2)
 S X=$S($D(^RAMIS(71,+$P(RACN0,"^",2),0)):$P(^(0),"^"),1:""),HLA("HLS",RAN)=HLA("HLS",RAN)_$E(HLECH)_X_$E(HLECH)_"L" D OBX11
 ; Replace above with following when Imaging can cope with ESC chars
 ; S X=$S($D(^RAMIS(71,+$P(RACN0,"^",2),0)):$P(^(0),"^"),1:""),HLA("HLS",RAN)=HLA("HLS",RAN)_$E(HLECH)_$$ESCAPE(X)_$E(HLECH)_"L" D OBX11
 Q
OBXMOD ; Compile 'OBX' segments for both types of modifiers
 ; Procedure modifiers
 N X3
 D MODS^RAUTL2 S HLA("HLS",RAN)="OBX"_HLFS_HLFS_"TX"_HLFS_"M"_$E(HLECH)_"MODIFIERS"_$E(HLECH)_"L"_HLFS_HLFS_Y D OBX11
 Q:Y(1)="None"
 ; CPT Modifiers
 F RAI=1:1 S X0=$P(Y(1),", ",RAI),X1=$P(Y(2),", ",RAI) Q:X0=""  D
 . S RAN=RAN+1
 . S X3=$$BASICMOD^RACPTMSC(X1,DT)
 . S HLA("HLS",RAN)="OBX"_HLFS_HLFS_"CE"_HLFS_"C4"_$E(HLECH)_"CPT MODIFIERS"_$E(HLECH)_"C4"_HLFS_HLFS_X0_$E(HLECH)_$P(X3,"^",3)_$E(HLECH)_"C4"
 . ; Replace above with following when Imaging can cope with ESC chars
 . ;S HLA("HLS",RAN)="OBX"_HLFS_HLFS_"CE"_HLFS_"C4"_$E(HLECH)_"CPT MODIFIERS"_$E(HLECH)_"C4"_HLFS_HLFS_X0_$E(HLECH)_$$ESCAPE($P(X3,"^",3))_$E(HLECH)_"C4"
 . I $P(X3,"^",4)]"" S HLA("HLS",RAN)=HLA("HLS",RAN)_$E(HLECH)_$P(X3,"^",4)_$E(HLECH)_$P(X3,"^",3)_$E(HLECH)_"C4"
 . ; Replace above with following when Imaging can cope with ESC chars
 . ;I $P(X3,"^",4)]"" S HLA("HLS",RAN)=HLA("HLS",RAN)_$E(HLECH)_$P(X3,"^",4)_$E(HLECH)_$$ESCAPE($P(X3,"^",3))_$E(HLECH)_"C4"
 . D OBX11
 . Q
 Q
 ;
OBXTCM ; Compile 'OBX' segment for latest TECH COMMENT
 ;
 ; Only Released version of Imaging 2.5 able to handle Tech Comments
 Q:'($$PATCH^XPDUTL("MAG*2.5*1")!(+$$VERSION^XPDUTL("MAG")>2.5))
 ;
 N X4,X3
 S X4=$$GETTCOM^RAUTL11(RADFN,RADTI,RACNI)
 Q:X4=""
 S RAN=RAN+1
 S HLA("HLS",RAN)="OBX"_HLFS_HLFS_"TX"_HLFS_"TCM"_$E(HLECH)_"TECH COMMENT"_$E(HLECH)_"L"_HLFS_HLFS
 D OBX11
 I $L(X4)+$L(HLA("HLS",RAN))'>245 D  Q
 .S $P(HLA("HLS",RAN),HLFS,6)=X4
 ;
 ; If Tech Comment is v. long it will need to be
 ; split into two parts. Do not split words if possible....
 ;
 S X3=$E(X4,1,245-$L(HLA("HLS",RAN)))
 I $L(X3," ")>1 S X3=$P(X3," ",1,$L(X3," ")-1)
 S X4=$P(X4,X3,2)
 S $P(HLA("HLS",RAN),HLFS,6)=X3
 S HLA("HLS",RAN,1)=X4_HLFS_$P(HLA("HLS",RAN),HLFS,7,12)
 S HLA("HLS",RAN)=$P(HLA("HLS",RAN),HLFS,1,6)
 Q
 ;
INIT ; initialize HL7 variables; called from RAHLR & RAHLRPT
 Q:'$G(RAEID)  ;undefined server application
 S HLDT=$$NOW^XLFDT(),HLDT1=$$HLDATE^HLFNC(HLDT),EID=RAEID
 S HL="HLS(""HLS"")",INT=1
 D INIT^HLFNC2(EID,.HL,INT)
 Q:'$D(HL("Q"))  ;improperly defined server application
 S HLQ=HL("Q"),HLFS=HL("FS"),HLECH=HL("ECH") K EID,INT
 Q
 ;
DOB(X) ;strip off trailing "0"'s from the date of birth
 I $E(X,5,6)="00" S X=$E(X,1,4) ;if no month then no day, return year
 E  I $E(X,7,8)="00" S X=$E(X,1,6) ;if month & no day, return month/year
 Q X
 ;
CPTMOD(RAIEN,HLECH,DT) ;return OBX-5 as it pertains to CPT Modifiers
 ;called from: RAHLRPT1 & RAHLR2
 ;input: RAIEN=IEN of the record in file 81.3
 ;       HLECH=HL7 encoding characters
 ;          DT=today's date
 N X S X=$$BASICMOD^RACPTMSC(RAIEN,DT)
 ;1st piece=IEN #81.3; 3rd piece=versioned name; 5th piece=coding sys
 Q RAIEN_$E(HLECH,1)_$$ESCAPE^RAHLRU($P(X,U,3))_$E(HLECH,1)_$P(X,U,5)
GETSFLAG(SAN,MTN,ETN,VER) ;Return HL nessage flag (79.721,1)
 Q:'$L(SAN)!'$L(MTN)!'$L(ETN)!'$L(VER) 0
 S SAN=$O(^HL(771,"B",SAN,0)) Q:'SAN 0
 S MTN=$O(^HL(771.2,"B",MTN,0)) Q:'MTN 0
 S ETN=$O(^HL(779.001,"B",ETN,0)) Q:'ETN 0
 S VER=$O(^HL(771.5,"B",VER,0)) Q:'VER 0
 Q +$P($G(^RA(79.7,SAN,1,MTN,1,ETN,1,VER,0)),U,2)
