DPTLK7A ;OAK/MKO-MAS PATIENT LOOKUP ENTERPRISE SEARCH (cont) ;13 May 2020  1:13 PM
 ;;5.3;Registration;**1024,1139**;Aug 13, 1993;Build 2
 ;**1024,Story 1258907 (mko): Routine created with subroutines ADDTF and CHKSRCID
 Q
 ;
ADDTF(DFN,IDS) ;Add the Treating Facility returned from the Enterprise Search
 ;In: DFN = DFN of patient
 ;    IDS(seq#,"ID")=Source ID
 ;    IDS(seq#,"IDTYPE")=Source ID Type (e.g., "PI")
 ;    IDS(seq#,"ISSUER")=Assigning Authority (e.g., "USVHA")
 ;    IDS(seq#,"SOURCE")=Facility (e.g., 500M, "200ESR")
 ;    IDS(seq#,"STATUS")=ID Status (e.g., "A", "H")
 N AA,IDSTAT,IDTYPE,SEQ,SRCID,STAIEN,STANUM
 D FILE^VAFCTFU(DFN,+$$SITE^VASITE,1,1,,,DFN,"A","USVHA","PI")
 S SEQ="" F  S SEQ=$O(IDS(SEQ)) Q:SEQ=""  D
 . S STANUM=$G(IDS(SEQ,"SOURCE"))
 . S STAIEN=$$IEN^XUAF4($G(IDS(SEQ,"SOURCE"))) Q:STAIEN'>0
 . S SRCID=$$CHKSRCID($G(IDS(SEQ,"ID")),STANUM) Q:SRCID=""
 . S IDSTAT=$G(IDS(SEQ,"STATUS"))
 . S AA=$G(IDS(SEQ,"ISSUER"))
 . S IDTYPE=$G(IDS(SEQ,"IDTYPE"))
 . D FILE^VAFCTFU(DFN,STAIEN,1,1,,,SRCID,IDSTAT,AA,IDTYPE)
 Q
 ;
CHKSRCID(SRCID,FCLTY) ;Strip leading and trailing 0s from 200ESR source IDs
 N CNT
 Q:$G(FCLTY)'="200ESR"!($G(SRCID)="") $G(SRCID)
 F CNT=1:1 Q:$E(SRCID,CNT)'=0
 S SRCID=$E(SRCID,CNT,999)
 S:SRCID?10N1"V"6N1."0" SRCID=$E(SRCID,1,17)
 Q SRCID
 ;
 ;**1139 VAMPI-26417 (jfw) - Routine DPTLK7 exceeded Max size after updates
 ;                           moved FORMATR and new Tag GETCNTY to free up space!
FORMATR(DGF,DGM,DG20NAME) ; - merge MPI and user input (MPI authorative)
 N DGX,DGY,DGZ
 S DGX=$O(DGM(0)) Q:'DGX
 S DG20NAME("FAMILY")=$G(DGM(DGX,"Surname"))
 S DG20NAME("GIVEN")=$G(DGM(DGX,"FirstName"))
 S DG20NAME("MIDDLE")=$G(DGM(DGX,"MiddleName"))
 S DG20NAME("PREFIX")=$G(DGM(DGX,"Prefix"))
 S DG20NAME("SUFFIX")=$G(DGM(DGX,"Suffix"))
 S DG20NAME("DEGREE")=$G(DGM(DGX,"Degree"))
 ;Reconstruct name
 S DG20NAME=$$NAMEFMT^XLFNAME(.DG20NAME,"F","CFL30")
 ;Format the .01 value
 M DGY=DG20NAME
 S DGF(.01)=$$FORMAT^XLFNAME7(.DGY,3,30,,2)
 S DGF(.02)=$G(DGM(DGX,"Gender"))
 S DGF(.03)=$G(DGM(DGX,"DOB"))
 S DGF(.09)=$G(DGM(DGX,"SSN"))
 S DGF(.2403)=$G(DGM(DGX,"MMN"))
 S DGF(.092)=$G(DGM(DGX,"POBCity"))
 S DGY=$S($G(DGM(DGX,"POBState"))]"":$O(^DIC(5,"C",DGM(DGX,"POBState"),0)),1:"")
 S DGF(.093)=DGY
 ;**1139 VAMPI-26417 (jfw) - Convert to new RESIDENTIAL address fields
 S:$G(DGM(DGX,"ResAddL1"))]"" DGF(.1151)=DGM(DGX,"ResAddL1")
 S:$G(DGM(DGX,"ResAddL2"))]"" DGF(.1152)=DGM(DGX,"ResAddL2")
 S:$G(DGM(DGX,"ResAddL3"))]"" DGF(.1153)=DGM(DGX,"ResAddL3")
 S:$G(DGM(DGX,"City"))]"" DGF(.1154)=DGM(DGX,"City")
 S:$G(DGM(DGX,"ResAddCity"))]"" DGF(.1154)=DGM(DGX,"ResAddCity")
 ;
 S DGY=$S($G(DGM(DGX,"ResAddState"))]"":$O(^DIC(5,"C",DGM(DGX,"ResAddState"),0)),1:"")
 S:DGY DGF(.1155)=DGY
 S DGY=$S($G(DGM(DGX,"Country"))]"":$O(^HL(779.004,"B",DGM(DGX,"Country"),0)),1:"")
 S:DGY DGF(.11573)=DGY
 S DGY=$S($G(DGM(DGX,"ResAddCountry"))]"":$O(^HL(779.004,"B",DGM(DGX,"ResAddCountry"),0)),1:"")
 S:DGY DGF(.11573)=DGY
 S:$G(DGM(DGX,"PCode"))]"" DGF(.11572)=DGM(DGX,"PCode")
 S:$G(DGM(DGX,"ResAddPCode"))]"" DGF(.11572)=DGM(DGX,"ResAddPCode")
 S:$G(DGM(DGX,"Province"))]"" DGF(.11571)=DGM(DGX,"Province")
 S:$G(DGM(DGX,"ResAddProvince"))]"" DGF(.11571)=DGM(DGX,"ResAddProvince")
 ;**967, Story 827326 (jfw) - Ensure Dash is removed if exists
 S:$G(DGM(DGX,"ResAddZip4"))]"" DGF(.1156)=$TR(DGM(DGX,"ResAddZip4"),"-","")
 S:$G(DGM(DGX,"ResPhone"))]"" DGF(.131)=DGM(DGX,"ResPhone")
 ;**1139 VAMPI-26417 (jfw) - Added CORRESPONDENCE address fields
 S:$G(DGM(DGX,"CorAddL1"))]"" DGF(.111)=DGM(DGX,"CorAddL1")
 S:$G(DGM(DGX,"CorAddL2"))]"" DGF(.112)=DGM(DGX,"CorAddL2")
 S:$G(DGM(DGX,"CorAddL3"))]"" DGF(.113)=DGM(DGX,"CorAddL3")
 S:$G(DGM(DGX,"CorAddCity"))]"" DGF(.114)=DGM(DGX,"CorAddCity")
 S DGY=$S($G(DGM(DGX,"CorAddState"))]"":$O(^DIC(5,"C",DGM(DGX,"CorAddState"),0)),1:"")
 S:DGY DGF(.115)=DGY
 S DGY=$S($G(DGM(DGX,"CorAddCountry"))]"":$O(^HL(779.004,"B",DGM(DGX,"CorAddCountry"),0)),1:"")
 S:DGY DGF(.1173)=DGY
 S:$G(DGM(DGX,"CorAddPCode"))]"" DGF(.1172)=DGM(DGX,"CorAddPCode")
 S:$G(DGM(DGX,"CorAddProvince"))]"" DGF(.1171)=DGM(DGX,"CorAddProvince")
 S:$G(DGM(DGX,"CorAddZip4"))]"" DGF(.1112)=$TR(DGM(DGX,"CorAddZip4"),"-","")
 N DGI F DGI=.1112,.1156  D
 .Q:'$G(DGF(DGI))
 .N DGCNTY S DGCNTY=$$GETCNTY(DGF(DGI))
 .I DGCNTY]"" S DGF($S(DGI=.1112:.117,1:.1157))=DGCNTY
 ;**1139 VAMPI-26417 (jfw) - End Changes
 ; alias loop
 S DGZ=0 F  S DGZ=$O(DGM(DGX,"ALIAS",DGZ)) Q:'DGZ  D
 . N DGY,DG20NAME
 . I $G(DGM(DGX,"ALIAS",DGZ,"Surname"))]"" D
 .. S DG20NAME("FAMILY")=$G(DGM(DGX,"ALIAS",DGZ,"Surname"))
 .. S DG20NAME("GIVEN")=$G(DGM(DGX,"ALIAS",DGZ,"FirstName"))
 .. S DG20NAME("MIDDLE")=$G(DGM(DGX,"ALIAS",DGZ,"MiddleName"))
 .. S DG20NAME("PREFIX")=$G(DGM(DGX,"ALIAS",DGZ,"Prefix"))
 .. S DG20NAME("SUFFIX")=$G(DGM(DGX,"ALIAS",DGZ,"Suffix"))
 .. S DG20NAME("DEGREE")=$G(DGM(DGX,"ALIAS",DGZ,"Degree"))
 .. ;Reconstruct name
 .. S DG20NAME=$$NAMEFMT^XLFNAME(.DG20NAME,"F","CFL30")
 .. ;Format the .01 value
 .. M DGY=DG20NAME
 .. S DGF("ALIAS",DGZ,.01)=$$FORMAT^XLFNAME7(.DGY,3,30,,2)
 . I $G(DGM(DGX,"ALIAS",DGZ,"SSN"))]"" S DGF("ALIAS",DGZ,1)=DGM(DGX,"ALIAS",DGZ,"SSN")
 S:$G(DGM(DGX,"ICN"))]"" DGF("ICN")=DGM(DGX,"ICN")
 ;
 ; - Story 338378 (elz) handle pseudo SSN
 I $G(DGF(.09))'?9N S DGF(.09)=$$PSEUDO^DPTLK7($G(DGF(.01)),$G(DGF(.03)))
 E  K DGF(.0906) ; remove pseudo reason if we have a ssn
 ;
 Q
 ;
 ;**1139 VAMPI-26417 (jfw) - Pulled logic from FORMATR to be reuseable
 ;Input: DGVAL - Zip+4 or Residential Zip+4
 ;Output: Code that identifies the County for the Zip+4
GETCNTY(DGVAL) ;
 N DGX,DGCNTY S DGCNTY=""
 D POSTAL^XIPUTIL(DGVAL,.DGX)
 I $G(DGX("FIPS CODE"))]"",$G(DGX("STATE POINTER")) D
 .S DGCNTY=$$FIND1^DIC(5.01,","_DGX("STATE POINTER")_",","MOXQ",$E($G(DGX("FIPS CODE")),3,5),"C")
 Q DGCNTY
 ;
