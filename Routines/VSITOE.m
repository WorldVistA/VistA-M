VSITOE ;ISL/ARS - VISIT TRACKING API UTILITIES FOR OE ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996
 Q
 ;
VSITAPI(DFN,SDT,EDT,HOSLOC,ENCTYPE,NENCTYPE,SERVCAT,NSERVCAT,LASTN) ;
 ;pass (DFN, Start Date, End Date, Hospital Location,
 ;      Enounter types, Not Encounter types,
 ;      Service Categories, Not Service Categories,
 ;      How many starting with the End Date an going backwards)
 ;ONLY THE DFN IS REQUIRED
 ; Encounter types is a string of all the encounter types wanted.
 ;   e.g. "OA" for only Ancillary and Occasion of service
 ; Not Encounter types is a string of all the encounter types not wanted.
 ;   e.g. "T" for do not include Telephone
 ; If Encounter types and Not Encounter types are null or not passed
 ;   then all encounter types will be included.
 ; Service Categories is a string of all the service categories to 
 ;   include. If non is passed all is assumed.
 ;   e.g. "H" for just historical.
 ;        "T" for just Telephone.
 ;        "AIT" for ambulatory (in and out patient) and Telephone.
 ; Not Service categories is a string of all the service categories to
 ;   not include. 
 ;Returns:: ^TMP("VSIT",$J,vsit ien,#)=
 ;Piece 1:: Date and Time from the Vsit File Entry
 ;Piece 2:: Hospital Location ien(pointer to file#44) ";" External Value
 ;       :: If service category = "H" then this Piece becomes the followi
 ;       :: Location of Encounter ien(Pointer to file #9999999.06) ";"
 ;       :: External Value
 ;Piece 3:: Service Category (Value of field .07 set of codes)
 ;Piece 4:: Service Connected (Value of field 80001 External Value)
 ;Piece 5:: Patient Status in/out (Value of field 15002 set of codes)
 ;Piece 6:: Clinic Stop ien (Pointer to file # 40.7) ";" External value)
 ;
 K ^TMP("VSIT",$J)
 Q:'$G(DFN)  ;-1
 ;
 N VSITPAT,VSITSDT,VSITEDT,VSITHLOC,VSITLAST
 N VSITSTOP,VSITNUM,VSITODT,VSITLOC,VSITETYP,VSITIEN
 ;
 S VSITPAT=$G(DFN),VSITSDT=$G(SDT),VSITEDT=$G(EDT)
 S VSITHLOC=+$G(HOSLOC),VSITLAST=+$G(LASTN)
 ;if now encounter type then use "P"
 S ENCTYPE=$G(ENCTYPE)
 S NENCTYPE=$G(NENCTYPE)
 S SERVCAT=$G(SERVCAT)
 S NSERVCAT=$G(NSERVCAT)
 I VSITSDT>.0001 S VSITSDT=VSITSDT-.0000001
 E  S VSITSDT=.0000001
 I VSITEDT>0 S VSITEDT=VSITEDT+$S(VSITEDT#1:.0000001,1:.7)
 E  S VSITEDT=9999999
 ;
 S VSITSTOP=0
 S VSITNUM=0
 S VSITODT=VSITEDT
 F  S VSITODT=$O(^AUPNVSIT("AET",VSITPAT,VSITODT),-1) Q:VSITODT<VSITSDT  D  Q:VSITSTOP
 .S VSITLOC=0
 .F  S VSITLOC=$O(^AUPNVSIT("AET",VSITPAT,VSITODT,VSITLOC)) Q:'VSITLOC  D
 ..I VSITHLOC'=0,VSITLOC'=VSITHLOC Q
 ..S VSITETYP=""
 ..F  S VSITETYP=$O(^AUPNVSIT("AET",VSITPAT,VSITODT,VSITLOC,VSITETYP)) Q:VSITETYP=""  D  Q:VSITSTOP
 ...I ENCTYPE'="",ENCTYPE'[VSITETYP Q
 ...I NENCTYPE'="",NENCTYPE[VSITETYP Q
 ...S VSITIEN=0
 ...F  S VSITIEN=$O(^AUPNVSIT("AET",VSITPAT,VSITODT,VSITLOC,VSITETYP,VSITIEN)) Q:'VSITIEN  D  Q:VSITSTOP
 ....I NSERVCAT'="",NSERVCAT[$P($G(^AUPNVSIT(VSITIEN,0)),"^",7) Q
 ....I SERVCAT'="",SERVCAT'[$P($G(^AUPNVSIT(VSITIEN,0)),"^",7) Q
 ....S VSITNUM=VSITNUM+1
 ....D OUTPUT(VSITIEN,VSITNUM)
 ....I VSITLAST,VSITLAST'>VSITNUM S VSITSTOP=1
 ;
 Q  ;VSITNUM
 ;
OUTPUT(VSITIEN,VSITNUM) ;
 N VSIT0,VSITDILF,VSITDSS,VSITSCAT,VSITLOC,VSITSC
 S VSIT0=$G(^AUPNVSIT(VSITIEN,0))
 ;
 ; -- Clinic
 S VSITDSS=$$EXTERNAL^DILFD(9000010,.08,"",$P(VSIT0,"^",8),"VSITDILF")
 I VSITDSS]"" S VSITDSS=$P(VSIT0,"^",8)_";"_VSITDSS
 ;
 ; -- Service Category
 S VSITSCAT=$P(VSIT0,U,7)
 ;
 ; -- Location of Encounter
 I VSITSCAT="H" D
 . S VSITLOC=$$EXTERNAL^DILFD(9000010,.06,"",$P(VSIT0,"^",6),"VSITDILF")
 . I VSITLOC]"" S VSITLOC=$P(VSIT0,"^",6)_";"_VSITLOC
 E  D
 . ; -- Hospital Location
 . S VSITLOC=$$EXTERNAL^DILFD(9000010,.22,"",$P(VSIT0,"^",22),"VSITDILF")
 . I VSITLOC]"" S VSITLOC=$P(VSIT0,"^",22)_";"_VSITLOC
 ;
 ;--Service Connected
 S VSITSC=$$EXTERNAL^DILFD(9000010,80001,"",$P($G(^AUPNVSIT(VSITIEN,800)),"^",1),"VSITDILF")
 ;I VSITSC]"" S VSITSC=$P($G(^AUPNVSIT(VSITIEN,800)),"^",1)_";"_VSITSC
 ;
 ; -- Set Tmp node
 S ^TMP("VSIT",$J,VSITIEN,VSITNUM)=$P(VSIT0,U,1)_"^"_VSITLOC_"^"_VSITSCAT_"^"_VSITSC_"^"_$P($G(^AUPNVSIT(VSITIEN,150)),U,2)_"^"_VSITDSS
 ;
 Q
 ;
