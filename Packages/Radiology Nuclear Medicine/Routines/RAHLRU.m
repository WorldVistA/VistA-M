RAHLRU ;HISC/GJC - utilities for HL7 messaging ;10 Sep 2019 3:57 PM
 ;;5.0;Radiology/Nuclear Medicine;**10,25,81,103,47,125,162**;Mar 16, 1998;Build 2
 ;
 ; 08/13/2010 BP/KAM RA*5*103 Outside Report Status Code needs 'F'
 ;Integration Agreements
 ;----------------------
 ;$$GET1^DIQ(2056); $$HLDATE^HLFNC(10106); INIT^HLFNC2(2161)
 ;GENERATE^HLMA(2164); $$NOW^XLFDT(10103); $$PATCH^XPDUTL(10141)
 ;$$VERSION^XPDUTL(10141)
 ;
 ;IA:  global read .01 field, file ^HL(771,
 ;IA:  global read .01 field, file ^HL(771.2,
 ;IA:  global read .01 field, file ^HL(771.5,
 ;IA:  global read .01 field, file ^HL(779.001,
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
 S HLCS=$E(HL("ECH"))
 S HLSCS=$E(HL("ECH"),4)
 S HLREP=$E(HL("ECH"),2)
 Q
 ;
DOB(X) ;strip off trailing "0"'s from the date of birth
 I $E(X,5,6)="00" S X=$E(X,1,4) ;if no month then no day, return year
 E  I $E(X,7,8)="00" S X=$E(X,1,6) ;if month & no day, return month/year
 Q X
 ;
CPTMOD(RAIEN,HLECH,DT) ;return OBX-5 as it pertains to CPT Modifiers
 ;called from: RAHLRPT2 & RAHLR1A
 ;input: RAIEN=IEN of the record in file 81.3
 ;       HLECH=HL7 encoding characters
 ;          DT=today's date
 N X S X=$$BASICMOD^RACPTMSC(RAIEN,DT)
 ;1st piece=IEN #81.3; 3rd piece=versioned name; 5th piece=coding sys
 ;Q RAIEN_$E(HLECH,1)_$$ESCAPE^RAHLRU($P(X,U,3))_$E(HLECH,1)_$P(X,U,5)
 ;9/5/08 the above line changed to below per IMAGING
 Q $P(X,U,2)_$E(HLECH,1)_$$ESCAPE^RAHLRU($P(X,U,3))_$E(HLECH,1)_"C4"
 ;
GETSFLAG(SAN,MTN,ETN,VER) ;Return HL message flag (79.721,1)
 Q:'$L(SAN)!'$L(MTN)!'$L(ETN)!'$L(VER) 0
 S SAN=$O(^HL(771,"B",SAN,0)) Q:'SAN 0
 S MTN=$O(^HL(771.2,"B",MTN,0)) Q:'MTN 0
 S ETN=$O(^HL(779.001,"B",ETN,0)) Q:'ETN 0
 S VER=$O(^HL(771.5,"B",VER,0)) Q:'VER 0
 Q +$P($G(^RA(79.7,SAN,1,MTN,1,ETN,1,VER,0)),U,2)
 ;
OBR21(HLECH,RA7002) ;builds the OBR-21 field; called from RAHLR1A
 ;Input
 ;  HLECH=encoding characters (required for $$ESCAPE^RAHLRU)
 ; RA7002=zero node of the REGISTERED EXAMS sub-file of the RAD/NUC MED
 ;        PATIENT (#70) file.
 ;Return:
 ; Component one (derived from file #79.2)
 ;   ABBREVIATION(#3)_NAME(#.01)
 ; Component two (derived from file #79.1)
 ;   File 79.1 IEN_NAME(#.01) of the HOSPITAL LOCATION(#44) record.
 ; Component three (derived from file #79)
 ;   DIVISION(#.01)_NAME(#.01) of the INSTITUTION(#4) record.
 ;
 ;Components as separated by the accent grave "`" (RAPCS); subcomponents by the
 ;underscore "_" (RAPSS)
 ;
 ; Ex: RAD_GENERAL RADIOLOGY`1_TD-RAD`660_SALT LAKE CITY
 ;
 N RAX S RAPCS="`",RAPSS="_",RAX=""
 S RA792Q=+$P(RA7002,U,2) ;imaging type pointer
 S RA792Q(0)=$G(^RA(79.2,RA792Q,0)) ;imaging type zero node
 ;create the i-type abbreviation, component separator, and full name string
 S RAX=$P(RA792Q(0),U,3)_RAPSS_$P(RA792Q(0),U)
 ;get hospital location and institution file data...
 S RA791Q=+$P(RA7002,U,4) ;imaging location pointer
 S RA44Q=+$P($G(^RA(79.1,RA791Q,0)),U) ;hospital location pointer
 S RA44Q(0)=$$GET1^DIQ(44,RA44Q,.01) ;hospital location name
 S RA4Q=+$P(RA7002,U,3) ;rad/nuc med division pointer dinum'd to INSTITUTION (#4) file
 S RA4Q(0)=$$GET1^DIQ(4,RA4Q,.01) ;institution name
 S RAX=RAX_RAPCS_RA791Q_RAPSS_RA44Q(0)_RAPCS_RA4Q_RAPSS_RA4Q(0)
 K RA4Q,RA44Q,RA791Q,RA792Q,RAPCS,RAPSS
 Q $$ESCAPE^RAHLRU(RAX)
 ;
BLDHLP ;build the HLP("EXCLUDE SUBSCRIBER",n) array
 ; is HLP("EXCLUDE SUBSCRIBER",n) defined? If yes get 'n'
 N RAX,RAY S RAX="EXCLUDE SUBSCRIBER"
 S RAY=$$HLPEXSUB(.HLP)
 I RAY="" M HLP(RAX)=RASSS(RAX) Q
 N RAI S RAI=0
 F  S RAI=$O(RASSS(RAX,RAI)) Q:RAI'>0  D
 .S RAY=RAY+1,HLP(RAX,RAY)=RASSS(RAX,RAI)
 .Q
 Q
 ;
HLPEXSUB(A) ;determine the last subscript (n) of a local array
 ;whose format is: A("EXCLUDE SUBSCRIBER",n)
 ;Input: A = local array name;
 Q $O(A("EXCLUDE SUBSCRIBER",$C(32)),-1)
 ;
GENERATE ;Broadcast the HL7 message (courtesy of the VistA HL7 application)
 N HLEID,HLARYTYP,HLFORMAT,HLMTIEN,HLP
 S HLEID=RAEID,HLARYTYP="LM",HLFORMAT=1,HLMTIEN="",HLP("PRIORITY")="I"
 ;
 ;1 - RASSSX is set by the 'Resend Radiology HL7 Messages By Date Range'
 ;    option. GETHLP sets the HLP("EXCLUDE SUBSCRIBER" array
 D:$D(RASSSX(HLEID)) GETHLP^RAHLRS1(HLEID,.HLP,"RASSSX") ;RA5P125
 ;
 ;2 - Do we return this HL7 message to the application that broadcasted
 ;    it? The following code also sets the HLP("EXCLUDE SUBSCRIBER" array
 D:$D(RASSS("EXCLUDE SUBSCRIBER"))\10 BLDHLP ;RA5P125
 ;
 ;Note: Events 1 & 2 are independent of one another. They will never
 ;      set the HLP array in the same process.
 ;
 ;//RA5P162 update //
 ;3 - exclude subscribers that are not teleradiology (file: 79.7)
 D:$D(RASSSX1(HLEID)) GETHLP^RAHLRS1(HLEID,.HLP,"RASSSX1")
 ;//RA5P162 update end //
 ;
 D GENERATE^HLMA(RAEID,HLARYTYP,HLFORMAT,.HLRESLT,HLMTIEN,.HLP)
 D GSTATUS^RAHLACK(.HLRESLT,RAEID) K HLRESLT
 ;
EXIT ;kill the variables; exit the process...
 K HL771RF,HL771SF,HL7STRG,HLA,HLARYTYP,HLCS,HLDOM,HLECH,HLEID,HLES,HLES2,HLFORMAT
 K HLFS,HLINSTN,HLMTIEN,HLN,HLP,HLPARAM,HLPID,HLQ,HLREC,HLREP,HLRFREQ,HLSAN,HLSCS
 K HLSFREQ,HLTYPE,HLX,OCXSEG,OCXTSPI,RAOBR,RAORC,RAPID,RAPURGE,RAPV1,RAREFDOC,RAZCPT
 K RAZDAYCS,RAZDTE,RAZMODE,RAZNME,RAZORD,RAZORD1,RAZPHONE,RAZPMOD,RAZPREG,RAZPROC
 K RAZRPT,RAZRXAM,RAZTRANS,RAZXAM,HLRESLT
 K ^UTILITY($J,"W") ;note HLCS, HLREP, & HLSCS are set in INIT^RAHLRU
 Q
 ;
