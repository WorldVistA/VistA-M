DGRUGMFU ;ALB/GRR - CREATE MFU MESSAGE
 ;;5.3;Registration;**190,349,381**;AUG 13, 1993
EN(DGRSEGC,DGRSEGN,DGRFNUM,DGRFNAM,DGROLDN,DGRENM,DGCIEN) ;
 K ^TMP($J,"DGRUGMFU")
 ;;Input parameters:
 ;;  DGRSEGC - Segment Code (Z36,LOC,STF)
 ;;  DGRSEGN - Segment Name (LOCATION, STAFF)
 ;;  DGRFNUM - File Number of master file
 ;;  DGRFNAM - Master File Name (NEW PERSON)
 ;;  DGROLDN - Value of name prior to change
 ;;  DGRENM - Name field of changed entry
 ;;  DGRCIEN - Internal Entry Number of changed entry
 N DGREC,DGREDT,DGRROOM,DGRBED,DGRWARD,DGRWIEN
 D INIT^HLFNC2("DGRU-RAI-MFU-SERVER",.HL) ;p-381 added
 D NOW^%DTC S DGREDT=$$HLDATE^HLFNC(%) ;Current Date/Time
 S DGREC="MFI"_HL("FS")_DGRSEGC_$E(HL("ECH"))_DGRSEGN_$E(HL("ECH"))_"HL7"_$E(HL("ECH"))_DGRFNUM_$E(HL("ECH"))_DGRFNAM_HL("FS")_HL("FS")_"UPD"_HL("FS")_DGREDT_HL("FS")_HL("FS")_"NE" ;Format MFI HL7 segment
 S ^TMP($J,"DGRUGMFU",1)=DGREC ;Store MFI segment into global array
 S DGREC="MFE"_HL("FS")_"MUP"_HL("FS")_HL("FS")_DGREDT_HL("FS")_DGCIEN_$E(HL("ECH"))_DGROLDN_$E(HL("ECH"))_"HL7" ;Format the MFE HL7 segment
 S ^TMP($J,"DGRUGMFU",2)=DGREC ;Store MFE segment into array
 I DGRSEGC="Z36" D  G EXIT ;If Z36 segment (Insurance), do following and exit
 .S DGREC="Z36"_HL("FS")_DGCIEN_$E(HL("ECH"))_DGRENM ;Format Z36 segment
 .S ^TMP($J,"DGRUGMFU",3)=DGREC ;Store Z36 segment into array
 I DGRSEGC="STF" D  G EXIT ;If STF segment, do following and exit
 .S DGREC="STF"_HL("FS")_DGCIEN_$E(HL("ECH"))_DGROLDN_$E(HL("ECH"))_DGRFNUM_HL("FS")_HL("FS")_$$HLNAME^HLFNC(DGRENM) ;Format the STF segment
 .S $P(DGREC,HL("FS"),19)=$$GET1^DIQ(200,DGCIEN,8,"E") ;Set the Job title into sequence 18 (piece 19)
 .S ^TMP($J,"DGRUGMFU",3)=DGREC ;Store STF segment into array
 I DGRSEGC="LOC" D  G EXIT ;If LOC segment, do the following and exit
 .I DGRFNUM=405.4 D  ;If the LOC is for Room-Bed change, do the following
 ..S DGRROOM=$P(DGRENM,"-") ;Set room variable
 ..S DGRBED=$P(DGRENM,"-",2) ;Set bed variable
 ..S DGRWIEN=$O(^DG(405.4,DGCIEN,"W",0)) ;Set variable to Ward IEN
 ..S I=$P($G(^DG(405.4,DGCIEN,"W",DGRWIEN,0)),"^") ;Set variable to IEN in Room-Bed file
 ..S DGRWARD=$$GET1^DIQ(42,I,.01) ;Set variable to Ward location file name
 ..I DGRWARD]"" S DGRWARD=$$WARDTRAN^DGRUUTL1(I,DGRWARD) ;p-381 added
 ..S $P(^TMP($J,"DGRUGMFU",2),"^",5)=DGRWARD_$E(HL("ECH"))_DGROLDN_$E(HL("ECH"))_"HL7" ;
 .I DGRFNUM=42 D
 ..S DGRROOM="",DGRBED="",DGRWARD=$$GET1^DIQ(42,DGCIEN,.01)
 .I DGRROOM]"" S DGRBH=$$RBTRAN^DGRUUTL1(DGCIEN,DGRROOM_"-"_DGRBED) S DGRROOM=$P(DGRBH,"-",1),DGRBED=$P(DGRBH,"-",2) ;modified p-328
 .I DGRWARD]"" S DGRWARD=$$WARDTRAN^DGRUUTL1(DGCIEN,DGRWARD) ;changed p-349
 .S DGREC="LOC"_HL("FS")_DGRWARD_$E(HL("ECH"))_DGRROOM_$E(HL("ECH"))_DGRBED_$E(HL("ECH"))_$E(HL("ECH"))_$E(HL("ECH"))_"NURSING UNIT"_HL("FS")_HL("FS")_"N"
 .S ^TMP($J,"DGRUGMFU",3)=DGREC
EXIT Q
 ;
ENGET() ;DETERMINE DIVISION TO GET SUBSCRIBERS
 ;
 N I,J,X
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 .S X(I)=HLNODE,J=0
 ..F  S J=$O(HLNODE(J)) Q:'J  S X(I,J)=HLNODE(J)
 ;LOOK FOR LOC segment
 S I=0
 F  S I=$O(X(I)) Q:'I  D
 .I $P(X(I),"^",1)="LOC" D
 ..S DGWARD=$$WARD^DGRUDYN(X(I),2)
 S DGDIV=+$$GET1^DIQ(42,DGWARD,.015,"I")
 Q DGDIV
 ;
