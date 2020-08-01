C0CDACI ; GPL - Patient Portal - CCDA Routines ;09/17/13  17:05
 ;;0.1;JJOHPP;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 Q
 ;
IMMU(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N CCDAV,CCDAV1
 S @CCDARPT@("STATUS")="EXTRACTING"
 S @CCDARPT@("EXTRACT-BEGIN")=$$NOW^XLFDT
 D GETPAT^C0CDACE(.CCDAV1,DFN,"immunizations")
 I '$D(CCDAV1) Q  ;
 I +$G(CCDAV1("results","immunizations@total"))=0 D  Q  ;
 . Q  ; turned off because it caused a validation error
 . N ISECT S ISECT=$NA(@CCDAWRK@("IMMUSECT"))
 . D GET^C0CDACU(ISECT,"TNOIMMU^C0CDACI")
 . D QUEUE^MXMLTMPL(BLIST,ISECT,1,@ISECT@(0))
 I CCDAV1("results","immunizations@total")=1 D  ;
 . M CCDAV(1)=CCDAV1("results","immunizations")
 E  M CCDAV=CCDAV1("results","immunizations")
 S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 ;
 ; immunizations section html
 ;
 N C0HTML,C0ARY
 S C0ARY("TITLE")="Immunization"
 S C0ARY("HEADER",1)="Date"
 S C0ARY("HEADER",2)="Vaccine"
 S C0ARY("HEADER",3)="Location"
 ;
 D  ;
 . N C0N S C0N=0
 . N C0I S C0I=0
 . F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . . N C0DATE S C0DATE=$G(CCDAV(C0I,"immunization","administered@value"))
 . . S CCDAV(C0I,"immunization","uri")="uri_9000010_11-"_$G(CCDAV(C0I,"immunization","id@value"))
 . . Q:$$REDACT^C0CDACV(CCDAV(C0I,"immunization","uri"),.PARMS)
 . . S C0ARY(C0N,1,"uri")=$G(CCDAV(C0I,"immunization","uri"))
 . . S C0N=C0N+1
 . . I C0DATE'="" S C0ARY(C0N,1)=$$HTMLDT^C0CDACU(C0DATE) ; immunization date
 . . E  S C0ARY(C0N,1)=""
 . . S C0ARY(C0N,1,"ID")=$G(CCDAV(C0I,"immunization","uri"))
 . . N INAME S INAME=$G(CCDAV(C0I,"immunization","name@value")) ; immunization name
 . . S C0ARY(C0N,2)=INAME
 . . N CVX ; look up CVX code here
 . . I '$D(^JJOHcodeMap("immunizations")) D SETMAP
 . . S CVX=$O(^JJOHcodeMap("immunizations","B",INAME,""))
 . . N PNAME
 . . I CVX'="" D  ;
 . . . S PNAME=$G(^JJOHcodeMap("immunizations",CVX,"preferredName"))
 . . I $G(PNAME)'="" D  ;
 . . . I CVX=999 Q  ;
 . . . S CCDAV(C0I,"immunization","displayName")=PNAME
 . . . S C0ARY(C0N,2)=PNAME
 . . I CVX="" S CVX=999
 . . S CCDAV(C0I,"immunization","CVX")=CVX
 . . S C0ARY(C0N,2)=C0ARY(C0N,2)_" (CVX: "_+CVX_") ("_INAME_")"
 . . S C0ARY(C0N,3)=$G(CCDAV(C0I,"immunization","facility@name")) ; 
 ;
 I +$O(C0ARY("AAAAA"),-1)=0 Q  ; all immunizations have been redacted
 ;
 ; the immunization section component
 ;
 N ISECT S ISECT=$NA(@CCDAWRK@("IMMUSECT"))
 D GET^C0CDACU(ISECT,"TIMMUSEC^C0CDACI")
 D QUEUE^MXMLTMPL(BLIST,ISECT,1,@ISECT@(0))
 ;
 ; immunization html digest generation
 ;
 N IHTML S IHTML=$NA(@CCDAWRK@("IMMUHTML"))
 D GENHTML^C0CDACU(IHTML,"C0ARY")
 D QUEUE^MXMLTMPL(BLIST,IHTML,1,@IHTML@(0))
 ;
 ; immunization xml generation
 ;
 N WRK
 N C0I S C0I=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"immunization","administered@value"))
 . I C0DATE'="" S C0ARY("immuTime")=$$FMDTOUTC^C0CDACU(C0DATE) ; immunization date
 . E  S C0ARY("immuTime")="UNK"
 . I $$REDACT^C0CDACV(CCDAV(C0I,"immunization","uri"),.PARMS) D  Q  ;
 . S C0ARY("uri")=$G(CCDAV(C0I,"immunization","uri"))
 . N PNAME S PNAME=$G(CCDAV(C0I,"immunization","displayName"))
 . I PNAME'="" S C0ARY("CVXname")=PNAME
 . E  S C0ARY("CVXname")=$G(CCDAV(C0I,"immunization","name@value")) ; immu name
 . S C0ARY("CVXcode")=$G(CCDAV(C0I,"immunization","CVX")) ; immu code
 . S C0ARY("immuLocation")=$G(CCDAV(C0I,"immunization","facility@name"))
 . S C0ARY("immuGuid")=$$UUID^C0CDACU() ; random
 . ;S C0ARY("orgOID")=$$ORGOID^C0CDACU() ; fetch organization OID
 . ;
 . ; immunizaiton
 . S WRK=$NA(@CCDAWRK@("IMMU",C0I))
 . D GETNMAP^C0CDACU(WRK,"TIMMU^C0CDACI","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 ; 
 ; immunization section ending
 ;
 N IMMUEND S IMMUEND=$NA(@CCDAWRK@("IMMUEND"))
 D GET^C0CDACU(IMMUEND,"TIMMUEND^C0CDACI")
 D QUEUE^MXMLTMPL(BLIST,IMMUEND,1,@IMMUEND@(0))
 ;
 Q
 ;
TIMMUSEC ; 
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.2.1"/>
 ;;<code code="11369-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="History of immunizations"/>
 Q
 ;
TIMMU ;
 ;;<entry>
 ;;<substanceAdministration moodCode="EVN" classCode="SBADM" negationInd="true">
 ;;<!-- Immunization Activity entry template -->
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.52"/>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.52" extension="2015-08-01"/>
 ;;<id root="@@immuGuid@@"/>
 ;;<statusCode code="completed"/>
 ;;<effectiveTime value="@@immuTime@@"/>
 ;;<consumable>
 ;;<manufacturedProduct classCode="MANU">
 ;;<!-- Immunization Medication Information template -->
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.54"/>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.54" extension="2014-06-09"/>
 ;;<manufacturedMaterial>
 ;;<code code="@@CVXcode@@" displayName="@@CVXname@@" codeSystem="2.16.840.1.113883.12.292" codeSystemName="Vaccines administered (CVX)">
 ;;<originalText>
 ;;<reference value="#@@uri@@"/>
 ;;</originalText>
 ;;</code>
 ;;</manufacturedMaterial>
 ;;<manufacturerOrganization>
 ;;<name>Influenza Vaccine Company</name>
 ;;</manufacturerOrganization>
 ;;</manufacturedProduct>
 ;;</consumable>
 ;;</substanceAdministration>
 ;;</entry>
 Q
 ;
TIMMUEND ; end of section
 ;;</section>
 ;;</component>
 Q
 ;
SETMAP ;
 N G S G=$NA(^JJOHcodeMap("immunizations"))
 K @G
 S @G@(1,"CPT")=90701
 S @G@(1,"CVXcode")=1
 S @G@(1,"altName",1)="DIP,PERT,TET (DPT)"
 S @G@(1,"altName",2)="DIP.,PERT.,TET. (DPT)"
 S @G@(1,"preferredName")="DTP"
 S @G@(2,"CPT")=90712
 S @G@(2,"CVXcode")=2
 S @G@(2,"altName",1)="ORAL POLIOVIRUS"
 S @G@(2,"preferredName")="OPV"
 S @G@(3,"CPT")=90707
 S @G@(3,"CVXcode")=3
 S @G@(3,"altName",1)="MMR1"
 S @G@(3,"altName",2)="MEASLES,MUMPS,RUBELLA (MMR)"
 S @G@(3,"altName",3)="MEASLES,MUMPS,RUBELLA PED #1"
 S @G@(3,"altName",4)="MEASLES,MUMPS,RUBELLA PED #2"
 S @G@(3,"preferredName")="MMR"
 S @G@(4,"CPT")=90708
 S @G@(4,"CVXcode")=4
 S @G@(4,"altName",1)="MEASLES,RUBELLA (MR)"
 S @G@(4,"preferredName")="M/R"
 S @G@(5,"CPT")=90705
 S @G@(5,"CVXcode")=5
 S @G@(5,"altName",1)="MEASLES"
 S @G@(5,"preferredName")="measles"
 S @G@(6,"CPT")=90706
 S @G@(6,"CVXcode")=6
 S @G@(6,"altName",1)="RUBELLA"
 S @G@(6,"preferredName")="rubella"
 S @G@(7,"CPT")=90704
 S @G@(7,"CVXcode")=7
 S @G@(7,"altName",1)="MUMPS"
 S @G@(7,"preferredName")="mumps"
 S @G@(8,"CPT")=90744
 S @G@(8,"CVXcode")=8
 S @G@(8,"altName",1)="HEP B PED/ADOL 3 DOSE"
 S @G@(8,"altName",2)="HEPB PED/ADOL-2"
 S @G@(8,"altName",3)="HEPB PED/ADOL-3"
 S @G@(8,"altName",4)="HEPB PED/ADOL-4"
 S @G@(8,"altName",5)="HEPB, PED/ADOL-1"
 S @G@(8,"preferredName")="Hep B, adolescent or pediatric"
 S @G@(9,"CPT")=90718
 S @G@(9,"CVXcode")=9
 ; astro gpl
 ;S @G@(9,"altName",1)="TETANUS DIPTHERIA (TD-ADULT)"
 ; end astro
 S @G@(9,"preferredName")="Td (adult), adsorbed"
 S @G@(10,"CPT")=90713
 S @G@(10,"CVXcode")=10
 S @G@(10,"altName",1)="IPV4"
 S @G@(10,"altName",2)="IPV1"
 S @G@(10,"altName",3)="IPV2"
 S @G@(10,"altName",4)="IPV3"
 S @G@(10,"altName",5)="POLIOVIRUS PED #1"
 S @G@(10,"altName",6)="POLIOVIRUS PED #2"
 S @G@(10,"altName",7)="POLIOVIRUS PED #3"
 S @G@(10,"altName",8)="POLIOVIRUS PED #4"
 S @G@(10,"preferredName")="IPV"
 S @G@(12,"CPT")=90296
 S @G@(12,"CVXcode")=12
 S @G@(12,"preferredName")="diphtheria antitoxin"
 S @G@(13,"CPT")=90389
 S @G@(13,"CVXcode")=13
 S @G@(13,"preferredName")="TIG"
 S @G@(14,"CPT")=90741
 S @G@(14,"CVXcode")=14
 S @G@(14,"altName",1)="GAMMA GLOBULIN"
 S @G@(14,"preferredName")="IG, unspecified formulation"
 S @G@(16,"CPT")=90659
 S @G@(16,"CVXcode")=16
 S @G@(16,"altName",1)="FLU,WHOLE"
 S @G@(16,"preferredName")="influenza, whole"
 S @G@(17,"CPT")=90737
 S @G@(17,"CVXcode")=17
 S @G@(17,"altName",1)="INFLUENZA B"
 S @G@(17,"preferredName")="Hib, unspecified formulation"
 S @G@(18,"CPT")=90675
 S @G@(18,"CVXcode")=18
 S @G@(18,"altName",1)="RABIES,IM"
 S @G@(18,"preferredName")="rabies, intramuscular injection"
 S @G@(19,"CPT")=90728
 S @G@(19,"CVXcode")=19
 S @G@(19,"altName",1)="BCG,PERCUT"
 S @G@(19,"preferredName")="BCG"
 S @G@(20,"CVXcode")=20
 S @G@(20,"altName",1)="DIP.,PERT.,TET. (DPT) PED 5"
 S @G@(20,"altName",2)="DIP.,PERT.,TET. (DPT) PED 1"
 S @G@(20,"altName",3)="DIP.,PERT.,TET. (DPT) PED 2"
 S @G@(20,"altName",4)="DIP.,PERT.,TET. (DPT) PED 3"
 S @G@(20,"altName",5)="DIP.,PERT.,TET. (DPT) PED 4"
 S @G@(20,"preferredName")="DTaP"
 S @G@(21,"CPT")=90716
 S @G@(21,"CVXcode")=21
 S @G@(21,"altName",1)="VZV2 INFANT"
 S @G@(21,"altName",2)="CHICKENPOX"
 S @G@(21,"altName",3)="VZV1 INFANT"
 S @G@(21,"preferredName")="varicella"
 S @G@(22,"CPT")=90720
 S @G@(22,"CVXcode")=22
 S @G@(22,"altName",1)="DTB/HIB"
 S @G@(22,"preferredName")="DTP-Hib"
 S @G@(23,"CPT")=90727
 S @G@(23,"CVXcode")=23
 S @G@(23,"altName",1)="PLAGUE"
 S @G@(23,"preferredName")="plague"
 S @G@(24,"CPT")=90581
 S @G@(24,"CVXcode")=24
 S @G@(24,"altName",1)="ANTHRAX,SC"
 S @G@(24,"preferredName")="anthrax"
 S @G@(25,"CPT")=90690
 S @G@(25,"CVXcode")=25
 S @G@(25,"altName",1)="TYPHOID,ORAL"
 S @G@(25,"preferredName")="typhoid, oral"
 S @G@(26,"CPT")=90725
 S @G@(26,"CVXcode")=26
 S @G@(26,"altName",1)="CHOLERA, ORAL"
 S @G@(26,"altName",2)="CHOLERA"
 S @G@(26,"preferredName")="cholera"
 S @G@(27,"CPT")=90287
 S @G@(27,"CVXcode")=27
 S @G@(27,"preferredName")="botulinum antitoxin"
 S @G@(28,"CPT")=90702
 S @G@(28,"CVXcode")=28
 S @G@(28,"altName",1)="DIPTHERIA-TETANUS (DT-PEDS)"
 S @G@(28,"preferredName")="DT (pediatric)"
 S @G@(29,"CPT")=90291
 S @G@(29,"CVXcode")=29
 S @G@(29,"preferredName")="CMVIG"
 S @G@(30,"CPT")=90371
 S @G@(30,"CVXcode")=30
 S @G@(30,"preferredName")="HBIG"
 S @G@(32,"CPT")=90733
 S @G@(32,"CVXcode")=32
 S @G@(32,"altName",1)="MENINGOCOCCAL"
 S @G@(32,"preferredName")="meningococcal MPSV4"
 S @G@(33,"CPT")=90732
 S @G@(33,"CVXcode")=33
 S @G@(33,"altName",1)="PNEUMOVAX"
 S @G@(33,"altName",2)="PNEUMOCOCCAL"
 S @G@(33,"preferredName")="pneumococcal polysaccharide PPV23"
 S @G@(34,"CPT")=90376
 S @G@(34,"CVXcode")=34
 S @G@(34,"preferredName")="RIG"
 S @G@(35,"CPT")=90703
 S @G@(35,"CVXcode")=35
 S @G@(35,"altName",1)="TETANUS TOXOID"
 S @G@(35,"preferredName")="tetanus toxoid, adsorbed"
 S @G@(36,"CPT")=90396
 S @G@(36,"CVXcode")=36
 S @G@(36,"preferredName")="VZIG"
 S @G@(37,"CPT")=90717
 S @G@(37,"CVXcode")=37
 S @G@(37,"altName",1)="YELLOW FEVER"
 S @G@(37,"preferredName")="yellow fever"
 S @G@(38,"altName",1)="RUBELLA, MUMPS"
 S @G@(39,"CPT")=90735
 S @G@(39,"CVXcode")=39
 S @G@(39,"altName",1)="ENCEPHALITIS"
 S @G@(39,"preferredName")="Japanese encephalitis SC"
 S @G@(40,"CPT")=90676
 S @G@(40,"CVXcode")=40
 S @G@(40,"altName",1)="RABIES,ID"
 S @G@(40,"preferredName")="rabies, intradermal injection"
 S @G@(41,"CPT")=90692
 S @G@(41,"CVXcode")=41
 S @G@(41,"altName",1)="TYPHOID,H-P,SC/ID"
 S @G@(41,"preferredName")="typhoid, parenteral"
 S @G@(42,"CPT")=90745
 S @G@(42,"CVXcode")=42
 S @G@(42,"altName",1)="HEP B4 INFANT"
 S @G@(42,"altName",2)="HEP B1 INFANT"
 S @G@(42,"altName",3)="HEP B2 INFANT"
 S @G@(42,"altName",4)="HEP B3 INFANT"
 S @G@(42,"preferredName")="Hep B, adolescent/high risk infant"
 S @G@(43,"CPT")=90746
 S @G@(43,"CVXcode")=43
 S @G@(43,"altName",1)="SWINE FLU BIVAL"
 S @G@(43,"preferredName")="Hep B, adult"
 S @G@(44,"CPT")=90747
 S @G@(44,"CVXcode")=44
 S @G@(44,"altName",1)="HEPB, ILL PAT"
 S @G@(44,"preferredName")="Hep B, dialysis"
 S @G@(45,"CPT")=90731
 S @G@(45,"CVXcode")=45
 S @G@(45,"altName",1)="HEPATITIS B"
 S @G@(45,"preferredName")="Hep B, unspecified formulation"
 S @G@(46,"CPT")=90646
 S @G@(46,"CVXcode")=46
 S @G@(46,"altName",1)="HIB,PRP-D"
 S @G@(46,"preferredName")="Hib (PRP-D)"
 S @G@(47,"CPT")=90645
 S @G@(47,"CVXcode")=47
 S @G@(47,"altName",1)="HIB PED 4"
 S @G@(47,"altName",2)="HIB PED 1"
 S @G@(47,"altName",3)="HIB PED 2"
 S @G@(47,"altName",4)="HIB PED 3"
 S @G@(47,"altName",5)="HIB,HBOC"
 S @G@(47,"preferredName")="Hib (HbOC)"
 S @G@(48,"CPT")=90648
 S @G@(48,"CVXcode")=48
 S @G@(48,"altName",1)="HIB,PRP-T"
 S @G@(48,"preferredName")="Hib (PRP-T)"
 S @G@(49,"CPT")=90647
 S @G@(49,"CVXcode")=49
 S @G@(49,"altName",1)="HiB3"
 S @G@(49,"altName",2)="HIB,PRP-OMP"
 S @G@(49,"altName",3)="HiB1"
 S @G@(49,"altName",4)="HiB2"
 S @G@(49,"preferredName")="Hib (PRP-OMP)"
 S @G@(50,"CPT")=90721
 S @G@(50,"CVXcode")=50
 S @G@(50,"preferredName")="DTaP-Hib"
 S @G@(51,"CPT")=90748
 S @G@(51,"CVXcode")=51
 S @G@(51,"altName",1)="HEPB/HIB"
 S @G@(51,"preferredName")="Hib-Hep B"
 S @G@(52,"CPT")=90632
 S @G@(52,"CVXcode")=52
 S @G@(52,"altName",1)="HEPA ADULT"
 S @G@(52,"preferredName")="Hep A, adult"
 S @G@(53,"CPT")=90693
 S @G@(53,"CVXcode")=53
 S @G@(53,"altName",1)="TYPHOID,AKD,SC"
 S @G@(53,"preferredName")="typhoid, parenteral, AKD (U.S. military)"
 S @G@(54,"CPT")=90476
 S @G@(54,"CVXcode")=54
 S @G@(54,"altName",1)="ADENOVIRUS,TYPE 4"
 S @G@(54,"preferredName")="adenovirus, type 4"
 S @G@(55,"CPT")=90477
 S @G@(55,"CVXcode")=55
 S @G@(55,"altName",1)="ADENOVIRUS,TYPE 7"
 S @G@(55,"preferredName")="adenovirus, type 7"
 S @G@(62,"CPT")=90649
 S @G@(62,"CVXcode")=62
 S @G@(62,"preferredName")="HPV, quadrivalent"
 S @G@(66,"CPT")=90665
 S @G@(66,"CVXcode")=66
 S @G@(66,"altName",1)="LYME DISEASE"
 S @G@(66,"preferredName")="Lyme disease"
 S @G@(71,"CPT")=90379
 S @G@(71,"CVXcode")=71
 S @G@(71,"preferredName")="RSV-IGIV"
 S @G@(75,"altName",1)="SMALLPOX"
 S @G@(79,"CPT")=90393
 S @G@(79,"CVXcode")=79
 S @G@(79,"preferredName")="vaccinia immune globulin"
 S @G@(83,"CPT")=90633
 S @G@(83,"CVXcode")=83
 S @G@(83,"altName",1)="HEP A2 PEDS"
 S @G@(83,"altName",2)="HEP A1 PEDS"
 S @G@(83,"altName",3)="HEPA,PED/ADOL-2"
 S @G@(83,"preferredName")="Hep A, ped/adol, 2 dose"
 S @G@(84,"CPT")=90634
 S @G@(84,"CVXcode")=84
 S @G@(84,"altName",1)="HEP A3 PEDS"
 S @G@(84,"altName",2)="HEPA,PED/ADOL-3 DOSE"
 S @G@(84,"preferredName")="Hep A, ped/adol, 3 dose"
 S @G@(85,"CPT")=90730
 S @G@(85,"CVXcode")=85
 S @G@(85,"altName",1)="HEPATITIS A"
 S @G@(85,"preferredName")="Hep A, unspecified formulation"
 S @G@(86,"CPT")=90281
 S @G@(86,"CVXcode")=86
 S @G@(86,"preferredName")="IG"
 S @G@(87,"CPT")=90283
 S @G@(87,"CVXcode")=87
 S @G@(87,"preferredName")="IGIV"
 S @G@(88,"CPT")=90724
 S @G@(88,"CVXcode")=88
 S @G@(88,"altName",1)="INFLUENZA"
 S @G@(88,"preferredName")="influenza, unspecified formulation"
 S @G@(90,"CPT")=90726
 S @G@(90,"CVXcode")=90
 S @G@(90,"altName",1)="RABIES"
 S @G@(90,"preferredName")="rabies, unspecified formulation"
 S @G@(91,"CPT")=90714
 S @G@(91,"CVXcode")=91
 S @G@(91,"altName",1)="TYPHOID"
 S @G@(91,"preferredName")="typhoid, unspecified formulation"
 S @G@(93,"CPT")=90378
 S @G@(93,"CVXcode")=93
 S @G@(93,"preferredName")="RSV-MAb"
 S @G@(94,"CPT")=90710
 S @G@(94,"CVXcode")=94
 S @G@(94,"altName",1)="MEA-MUMPS-RUB-VARCELLA"
 S @G@(94,"preferredName")="MMRV"
 S @G@(100,"CPT")=90669
 S @G@(100,"CVXcode")=100
 S @G@(100,"altName",1)="PNEUMOCOCCAL PED 4"
 S @G@(100,"altName",2)="PNEUMOCOCCAL PED 1"
 S @G@(100,"altName",3)="PNEUMOCOCCAL PED 2"
 S @G@(100,"altName",4)="PNEUMOCOCCAL PED 3"
 S @G@(100,"altName",5)="PNEUMOCOCCAL,PED"
 S @G@(100,"preferredName")="pneumococcal conjugate PCV 7"
 S @G@(101,"CPT")=90691
 S @G@(101,"CVXcode")=101
 S @G@(101,"altName",1)="TYPHOID"
 S @G@(101,"preferredName")="typhoid, ViCPs"
 S @G@(104,"CPT")=90636
 S @G@(104,"CVXcode")=104
 S @G@(104,"altName",1)="HEPA/HEPB ADULT"
 S @G@(104,"preferredName")="Hep A-Hep B"
 S @G@(106,"CPT")=90700
 S @G@(106,"CVXcode")=106
 S @G@(106,"altName",1)="DTaP5"
 S @G@(106,"altName",2)="DIP,PERT,TET (DPT) PED 1"
 S @G@(106,"altName",3)="DIP,PERT,TET (DPT) PED 2"
 S @G@(106,"altName",4)="DIP,PERT,TET (DPT) PED 3"
 S @G@(106,"altName",5)="DIP,PERT,TET (DPT) PED 4"
 S @G@(106,"altName",6)="DIP,PERT,TET (DPT) PED 5"
 S @G@(106,"altName",7)="DIP-TET-a/PERT"
 S @G@(106,"altName",8)="DTaP1"
 S @G@(106,"altName",9)="DTaP2"
 S @G@(106,"altName",10)="DTaP3"
 S @G@(106,"altName",11)="DTaP4"
 ; astro gpl
 S @G@(106,"altName",12)="TETANUS DIPTHERIA (TD-ADULT)"
 ; end astro
 S @G@(106,"preferredName")="DTaP, 5 pertussis antigens"
 S @G@(110,"CPT")=90723
 S @G@(110,"CVXcode")=110
 S @G@(110,"preferredName")="DTaP-Hep B-IPV"
 S @G@(111,"CPT")=90660
 S @G@(111,"CVXcode")=111
 S @G@(111,"altName",1)="FLU,NASAL"
 S @G@(111,"preferredName")="influenza, live, intranasal"
 S @G@(113,"CVXcode")=113
 S @G@(113,"preferredName")="Td (adult) preservative free"
 S @G@(114,"CPT")=90734
 S @G@(114,"CVXcode")=114
 S @G@(114,"preferredName")="meningococcal MCV4P"
 S @G@(115,"CPT")=90715
 S @G@(115,"CVXcode")=115
 S @G@(115,"altName",1)="TETANUS, DIPTHERIA AND PERTUSSIS"
 S @G@(115,"preferredName")="Tdap"
 S @G@(116,"CPT")=90680
 S @G@(116,"CVXcode")=116
 S @G@(116,"altName",1)="RV 4 PEDS"
 S @G@(116,"altName",2)="ROTOVIRUS,ORAL"
 S @G@(116,"altName",3)="RV 1 PEDS"
 S @G@(116,"altName",4)="RV 2 PEDS"
 S @G@(116,"altName",5)="RV 3 PEDS"
 S @G@(116,"preferredName")="rotavirus, pentavalent"
 S @G@(118,"CPT")=90650
 S @G@(118,"CVXcode")=118
 S @G@(118,"preferredName")="HPV, bivalent"
 S @G@(119,"CPT")=90681
 S @G@(119,"CVXcode")=119
 S @G@(119,"preferredName")="rotavirus, monovalent"
 S @G@(120,"CPT")=90698
 S @G@(120,"CVXcode")=120
 S @G@(120,"preferredName")="DTaP-Hib-IPV"
 S @G@(121,"CPT")=90736
 S @G@(121,"CVXcode")=121
 S @G@(121,"preferredName")="zoster"
 S @G@(125,"CPT")=90664
 S @G@(125,"CVXcode")=125
 S @G@(125,"preferredName")="Novel Influenza-H1N1-09, nasal"
 S @G@(126,"CPT")=90666
 S @G@(126,"CVXcode")=126
 S @G@(126,"preferredName")="Novel influenza-H1N1-09, preservative-free"
 S @G@(127,"CPT")=90668
 S @G@(127,"CVXcode")=127
 S @G@(127,"preferredName")="Novel influenza-H1N1-09"
 S @G@(128,"CPT")=90663
 S @G@(128,"CVXcode")=128
 S @G@(128,"preferredName")="Novel Influenza-H1N1-09, all formulations"
 S @G@(130,"CPT")=90696
 S @G@(130,"CVXcode")=130
 S @G@(130,"preferredName")="DTaP-IPV"
 S @G@(131,"altName",1)="TYPHUS"
 S @G@(133,"CPT")=90670
 S @G@(133,"CVXcode")=133
 S @G@(133,"altName",1)="PCV5 PEDS"
 S @G@(133,"altName",2)="PCV1 PEDS"
 S @G@(133,"altName",3)="PCV2 PEDS"
 S @G@(133,"altName",4)="PCV3 PEDS"
 S @G@(133,"altName",5)="PCV4 PEDS"
 S @G@(133,"preferredName")="Pneumococcal conjugate PCV 13"
 S @G@(134,"CPT")=90738
 S @G@(134,"CVXcode")=134
 S @G@(134,"preferredName")="Japanese Encephalitis IM"
 S @G@(135,"CPT")=90662
 S @G@(135,"CVXcode")=135
 S @G@(135,"preferredName")="Influenza, high dose seasonal"
 S @G@(136,"CVXcode")=136
 S @G@(136,"preferredName")="Meningococcal MCV4O"
 S @G@(140,"CPT")=90656
 S @G@(140,"CVXcode")=140
 S @G@(140,"preferredName")="Influenza, seasonal, injectable, preservative free"
 S @G@(141,"CPT")=90658
 S @G@(141,"CVXcode")=141
 S @G@(141,"altName",1)="FLU,3 YRS"
 S @G@(141,"preferredName")="Influenza, seasonal, injectable"
 S @G@(144,"CPT")=90654
 S @G@(144,"CVXcode")=144
 S @G@(144,"preferredName")="influenza, seasonal, intradermal, preservative free"
 S @G@(148,"CPT")=90644
 S @G@(148,"CVXcode")=148
 S @G@(148,"preferredName")="Meningococcal C/Y-HIB PRP"
 S @G@(149,"CPT")=90672
 S @G@(149,"CVXcode")=149
 S @G@(149,"preferredName")="influenza, live, intranasal, quadrivalent"
 S @G@(150,"CPT")=90686
 S @G@(150,"CVXcode")=150
 S @G@(150,"preferredName")="influenza, injectable, quadrivalent, preservative free"
 S @G@(153,"CPT")=90661
 S @G@(153,"CVXcode")=153
 S @G@(153,"preferredName")="Influenza, injectable, MDCK, preservative free"
 S @G@(155,"CPT")=90673
 S @G@(155,"CVXcode")=155
 S @G@(155,"preferredName")="influenza, recombinant, injectable, preservative free"
 S @G@(158,"CPT")=90688
 S @G@(158,"CVXcode")=158
 S @G@(158,"preferredName")="influenza, injectable, quadrivalent"
 ; astro gpl
 S @G@(166,"preferredName")="influenza, intradermal, quadrivalent, preservative free"
 S @G@(166,"altName",1)="INFLUENZA-H1N1-09, NOVEL (PANDEMIC)"
 S @G@(166,"CVXcode")=166
 ; end astro
 S @G@(999,"CPT")=90749
 S @G@(999,"CVXcode")=999
 S @G@(999,"preferredName")="unknown"
 S @G@("B","ADENOVIRUS,TYPE 4",54)=""
 S @G@("B","ADENOVIRUS,TYPE 7",55)=""
 S @G@("B","ANTHRAX,SC",24)=""
 S @G@("B","BCG",19)=""
 S @G@("B","BCG,PERCUT",19)=""
 S @G@("B","CHICKENPOX",21)=""
 S @G@("B","CHOLERA",26)=""
 S @G@("B","CHOLERA, ORAL",26)=""
 S @G@("B","CMVIG",29)=""
 S @G@("B","DIP,PERT,TET (DPT)",1)=""
 S @G@("B","DIP,PERT,TET (DPT) PED 1",106)=""
 S @G@("B","DIP,PERT,TET (DPT) PED 2",106)=""
 S @G@("B","DIP,PERT,TET (DPT) PED 3",106)=""
 S @G@("B","DIP,PERT,TET (DPT) PED 4",106)=""
 S @G@("B","DIP,PERT,TET (DPT) PED 5",106)=""
 S @G@("B","DIP-TET-a/PERT",106)=""
 S @G@("B","DIP.,PERT.,TET. (DPT)",1)=""
 S @G@("B","DIP.,PERT.,TET. (DPT) PED 1",20)=""
 S @G@("B","DIP.,PERT.,TET. (DPT) PED 2",20)=""
 S @G@("B","DIP.,PERT.,TET. (DPT) PED 3",20)=""
 S @G@("B","DIP.,PERT.,TET. (DPT) PED 4",20)=""
 S @G@("B","DIP.,PERT.,TET. (DPT) PED 5",20)=""
 S @G@("B","DIPTHERIA-TETANUS (DT-PEDS)",28)=""
 S @G@("B","DT (pediatric)",28)=""
 S @G@("B","DTB/HIB",22)=""
 S @G@("B","DTP",1)=""
 S @G@("B","DTP-Hib",22)=""
 S @G@("B","DTaP",20)=""
 S @G@("B","DTaP, 5 pertussis antigens",106)=""
 S @G@("B","DTaP-Hep B-IPV",110)=""
 S @G@("B","DTaP-Hib",50)=""
 S @G@("B","DTaP-Hib-IPV",120)=""
 S @G@("B","DTaP-IPV",130)=""
 S @G@("B","DTaP1",106)=""
 S @G@("B","DTaP2",106)=""
 S @G@("B","DTaP3",106)=""
 S @G@("B","DTaP4",106)=""
 S @G@("B","DTaP5",106)=""
 S @G@("B","ENCEPHALITIS",39)=""
 S @G@("B","FLU,3 YRS",141)=""
 S @G@("B","FLU,NASAL",111)=""
 S @G@("B","FLU,WHOLE",16)=""
 S @G@("B","GAMMA GLOBULIN",14)=""
 S @G@("B","HBIG",30)=""
 S @G@("B","HEP A1 PEDS",83)=""
 S @G@("B","HEP A2 PEDS",83)=""
 S @G@("B","HEP A3 PEDS",84)=""
 S @G@("B","HEP B PED/ADOL 3 DOSE",8)=""
 S @G@("B","HEP B1 INFANT",42)=""
 S @G@("B","HEP B2 INFANT",42)=""
 S @G@("B","HEP B3 INFANT",42)=""
 S @G@("B","HEP B4 INFANT",42)=""
 S @G@("B","HEPA ADULT",52)=""
 S @G@("B","HEPA,PED/ADOL-2",83)=""
 S @G@("B","HEPA,PED/ADOL-3 DOSE",84)=""
 S @G@("B","HEPA/HEPB ADULT",104)=""
 S @G@("B","HEPATITIS A",85)=""
 S @G@("B","HEPATITIS B",45)=""
 S @G@("B","HEPB PED/ADOL-2",8)=""
 S @G@("B","HEPB PED/ADOL-3",8)=""
 S @G@("B","HEPB PED/ADOL-4",8)=""
 S @G@("B","HEPB, ILL PAT",44)=""
 S @G@("B","HEPB, PED/ADOL-1",8)=""
 S @G@("B","HEPB/HIB",51)=""
 S @G@("B","HIB PED 1",47)=""
 S @G@("B","HIB PED 2",47)=""
 S @G@("B","HIB PED 3",47)=""
 S @G@("B","HIB PED 4",47)=""
 S @G@("B","HIB,HBOC",47)=""
 S @G@("B","HIB,PRP-D",46)=""
 S @G@("B","HIB,PRP-OMP",49)=""
 S @G@("B","HIB,PRP-T",48)=""
 S @G@("B","HPV, bivalent",118)=""
 S @G@("B","HPV, quadrivalent",62)=""
 S @G@("B","Hep A, adult",52)=""
 S @G@("B","Hep A, ped/adol, 2 dose",83)=""
 S @G@("B","Hep A, ped/adol, 3 dose",84)=""
 S @G@("B","Hep A, unspecified formulation",85)=""
 S @G@("B","Hep A-Hep B",104)=""
 S @G@("B","Hep B, adolescent or pediatric",8)=""
 S @G@("B","Hep B, adolescent/high risk infant",42)=""
 S @G@("B","Hep B, adult",43)=""
 S @G@("B","Hep B, dialysis",44)=""
 S @G@("B","Hep B, unspecified formulation",45)=""
 S @G@("B","HiB1",49)=""
 S @G@("B","HiB2",49)=""
 S @G@("B","HiB3",49)=""
 S @G@("B","Hib (HbOC)",47)=""
 S @G@("B","Hib (PRP-D)",46)=""
 S @G@("B","Hib (PRP-OMP)",49)=""
 S @G@("B","Hib (PRP-T)",48)=""
 S @G@("B","Hib, unspecified formulation",17)=""
 S @G@("B","Hib-Hep B",51)=""
 S @G@("B","IG",86)=""
 S @G@("B","IG, unspecified formulation",14)=""
 S @G@("B","IGIV",87)=""
 S @G@("B","INFLUENZA",88)=""
 S @G@("B","INFLUENZA B",17)=""
 ; astro gpl
 S @G@("B","INFLUENZA-H1N1-09, NOVEL (PANDEMIC)",166)=""
 ; end gpl 
 S @G@("B","IPV",10)=""
 S @G@("B","IPV1",10)=""
 S @G@("B","IPV2",10)=""
 S @G@("B","IPV3",10)=""
 S @G@("B","IPV4",10)=""
 S @G@("B","Influenza, high dose seasonal",135)=""
 S @G@("B","Influenza, injectable, MDCK, preservative free",153)=""
 S @G@("B","Influenza, seasonal, injectable",141)=""
 S @G@("B","Influenza, seasonal, injectable, preservative free",140)=""
 S @G@("B","Japanese Encephalitis IM",134)=""
 S @G@("B","Japanese encephalitis SC",39)=""
 S @G@("B","LYME DISEASE",66)=""
 S @G@("B","Lyme disease",66)=""
 S @G@("B","M/R",4)=""
 S @G@("B","MEA-MUMPS-RUB-VARCELLA",94)=""
 S @G@("B","MEASLES",5)=""
 S @G@("B","MEASLES,MUMPS,RUBELLA (MMR)",3)=""
 S @G@("B","MEASLES,MUMPS,RUBELLA PED #1",3)=""
 S @G@("B","MEASLES,MUMPS,RUBELLA PED #2",3)=""
 S @G@("B","MEASLES,RUBELLA (MR)",4)=""
 S @G@("B","MENINGOCOCCAL",32)=""
 S @G@("B","MMR",3)=""
 S @G@("B","MMR1",3)=""
 S @G@("B","MMRV",94)=""
 S @G@("B","MUMPS",7)=""
 S @G@("B","Meningococcal C/Y-HIB PRP",148)=""
 S @G@("B","Meningococcal MCV4O",136)=""
 S @G@("B","Novel Influenza-H1N1-09, all formulations",128)=""
 S @G@("B","Novel Influenza-H1N1-09, nasal",125)=""
 S @G@("B","Novel influenza-H1N1-09",127)=""
 S @G@("B","Novel influenza-H1N1-09, preservative-free",126)=""
 S @G@("B","OPV",2)=""
 S @G@("B","ORAL POLIOVIRUS",2)=""
 S @G@("B","PCV1 PEDS",133)=""
 S @G@("B","PCV2 PEDS",133)=""
 S @G@("B","PCV3 PEDS",133)=""
 S @G@("B","PCV4 PEDS",133)=""
 S @G@("B","PCV5 PEDS",133)=""
 S @G@("B","PLAGUE",23)=""
 S @G@("B","PNEUMOCOCCAL",33)=""
 S @G@("B","PNEUMOCOCCAL PED 1",100)=""
 S @G@("B","PNEUMOCOCCAL PED 2",100)=""
 S @G@("B","PNEUMOCOCCAL PED 3",100)=""
 S @G@("B","PNEUMOCOCCAL PED 4",100)=""
 S @G@("B","PNEUMOCOCCAL,PED",100)=""
 S @G@("B","PNEUMOVAX",33)=""
 S @G@("B","POLIOVIRUS PED #1",10)=""
 S @G@("B","POLIOVIRUS PED #2",10)=""
 S @G@("B","POLIOVIRUS PED #3",10)=""
 S @G@("B","POLIOVIRUS PED #4",10)=""
 S @G@("B","Pneumococcal conjugate PCV 13",133)=""
 S @G@("B","RABIES",90)=""
 S @G@("B","RABIES,ID",40)=""
 S @G@("B","RABIES,IM",18)=""
 S @G@("B","RIG",34)=""
 S @G@("B","ROTOVIRUS,ORAL",116)=""
 S @G@("B","RSV-IGIV",71)=""
 S @G@("B","RSV-MAb",93)=""
 S @G@("B","RUBELLA",6)=""
 S @G@("B","RUBELLA, MUMPS",38)=""
 S @G@("B","RV 1 PEDS",116)=""
 S @G@("B","RV 2 PEDS",116)=""
 S @G@("B","RV 3 PEDS",116)=""
 S @G@("B","RV 4 PEDS",116)=""
 S @G@("B","SMALLPOX",75)=""
 S @G@("B","SWINE FLU BIVAL",43)=""
 ; astro gpl
 ;S @G@("B","TETANUS DIPTHERIA (TD-ADULT)",9)=""
 S @G@("B","TETANUS DIPTHERIA (TD-ADULT)",106)=""
 ; end astro
 S @G@("B","TETANUS TOXOID",35)=""
 S @G@("B","TETANUS, DIPTHERIA AND PERTUSSIS",115)=""
 S @G@("B","TIG",13)=""
 S @G@("B","TYPHOID",91)=""
 S @G@("B","TYPHOID",101)=""
 S @G@("B","TYPHOID,AKD,SC",53)=""
 S @G@("B","TYPHOID,H-P,SC/ID",41)=""
 S @G@("B","TYPHOID,ORAL",25)=""
 S @G@("B","TYPHUS",131)=""
 S @G@("B","Td (adult) preservative free",113)=""
 S @G@("B","Td (adult), adsorbed",9)=""
 S @G@("B","Tdap",115)=""
 S @G@("B","VZIG",36)=""
 S @G@("B","VZV1 INFANT",21)=""
 S @G@("B","VZV2 INFANT",21)=""
 S @G@("B","YELLOW FEVER",37)=""
 S @G@("B","adenovirus, type 4",54)=""
 S @G@("B","adenovirus, type 7",55)=""
 S @G@("B","anthrax",24)=""
 S @G@("B","botulinum antitoxin",27)=""
 S @G@("B","cholera",26)=""
 S @G@("B","diphtheria antitoxin",12)=""
 S @G@("B","influenza, injectable, quadrivalent",158)=""
 S @G@("B","influenza, injectable, quadrivalent, preservative free",150)=""
 S @G@("B","influenza, live, intranasal",111)=""
 S @G@("B","influenza, live, intranasal, quadrivalent",149)=""
 S @G@("B","influenza, recombinant, injectable, preservative free",155)=""
 S @G@("B","influenza, seasonal, intradermal, preservative free",144)=""
 S @G@("B","influenza, unspecified formulation",88)=""
 S @G@("B","influenza, whole",16)=""
 S @G@("B","measles",5)=""
 S @G@("B","meningococcal MCV4P",114)=""
 S @G@("B","meningococcal MPSV4",32)=""
 S @G@("B","mumps",7)=""
 S @G@("B","plague",23)=""
 S @G@("B","pneumococcal conjugate PCV 7",100)=""
 S @G@("B","pneumococcal polysaccharide PPV23",33)=""
 S @G@("B","rabies, intradermal injection",40)=""
 S @G@("B","rabies, intramuscular injection",18)=""
 S @G@("B","rabies, unspecified formulation",90)=""
 S @G@("B","rotavirus, monovalent",119)=""
 S @G@("B","rotavirus, pentavalent",116)=""
 S @G@("B","rubella",6)=""
 S @G@("B","tetanus toxoid, adsorbed",35)=""
 S @G@("B","typhoid, ViCPs",101)=""
 S @G@("B","typhoid, oral",25)=""
 S @G@("B","typhoid, parenteral",41)=""
 S @G@("B","typhoid, parenteral, AKD (U.S. military)",53)=""
 S @G@("B","typhoid, unspecified formulation",91)=""
 S @G@("B","unknown",999)=""
 S @G@("B","vaccinia immune globulin",79)=""
 S @G@("B","varicella",21)=""
 S @G@("B","yellow fever",37)=""
 S @G@("B","zoster",121)=""
 S @G@("CPT",90281,86)=""
 S @G@("CPT",90283,87)=""
 S @G@("CPT",90287,27)=""
 S @G@("CPT",90291,29)=""
 S @G@("CPT",90296,12)=""
 S @G@("CPT",90371,30)=""
 S @G@("CPT",90375,34)=""
 S @G@("CPT",90376,34)=""
 S @G@("CPT",90378,93)=""
 S @G@("CPT",90379,71)=""
 S @G@("CPT",90389,13)=""
 S @G@("CPT",90393,79)=""
 S @G@("CPT",90396,36)=""
 S @G@("CPT",90470,128)=""
 S @G@("CPT",90476,54)=""
 S @G@("CPT",90477,55)=""
 S @G@("CPT",90581,24)=""
 S @G@("CPT",90585,19)=""
 S @G@("CPT",90632,52)=""
 S @G@("CPT",90633,83)=""
 S @G@("CPT",90634,84)=""
 S @G@("CPT",90636,104)=""
 S @G@("CPT",90644,148)=""
 S @G@("CPT",90645,47)=""
 S @G@("CPT",90646,46)=""
 S @G@("CPT",90647,49)=""
 S @G@("CPT",90648,48)=""
 S @G@("CPT",90649,62)=""
 S @G@("CPT",90650,118)=""
 S @G@("CPT",90654,144)=""
 S @G@("CPT",90655,140)=""
 S @G@("CPT",90656,140)=""
 S @G@("CPT",90657,141)=""
 S @G@("CPT",90658,141)=""
 S @G@("CPT",90659,16)=""
 S @G@("CPT",90660,111)=""
 S @G@("CPT",90661,153)=""
 S @G@("CPT",90662,135)=""
 S @G@("CPT",90663,128)=""
 S @G@("CPT",90664,125)=""
 S @G@("CPT",90665,66)=""
 S @G@("CPT",90666,126)=""
 S @G@("CPT",90668,127)=""
 S @G@("CPT",90669,100)=""
 S @G@("CPT",90670,133)=""
 S @G@("CPT",90672,149)=""
 S @G@("CPT",90673,155)=""
 S @G@("CPT",90675,18)=""
 S @G@("CPT",90676,40)=""
 S @G@("CPT",90680,116)=""
 S @G@("CPT",90681,119)=""
 S @G@("CPT",90685,150)=""
 S @G@("CPT",90686,150)=""
 S @G@("CPT",90688,158)=""
 S @G@("CPT",90690,25)=""
 S @G@("CPT",90691,101)=""
 S @G@("CPT",90692,41)=""
 S @G@("CPT",90693,53)=""
 S @G@("CPT",90696,130)=""
 S @G@("CPT",90698,120)=""
 S @G@("CPT",90700,106)=""
 S @G@("CPT",90701,1)=""
 S @G@("CPT",90702,28)=""
 S @G@("CPT",90703,35)=""
 S @G@("CPT",90704,7)=""
 S @G@("CPT",90705,5)=""
 S @G@("CPT",90706,6)=""
 S @G@("CPT",90707,3)=""
 S @G@("CPT",90708,4)=""
 S @G@("CPT",90710,94)=""
 S @G@("CPT",90712,2)=""
 S @G@("CPT",90713,10)=""
 S @G@("CPT",90714,91)=""
 S @G@("CPT",90715,115)=""
 S @G@("CPT",90716,21)=""
 S @G@("CPT",90717,37)=""
 S @G@("CPT",90718,9)=""
 S @G@("CPT",90720,22)=""
 S @G@("CPT",90721,50)=""
 S @G@("CPT",90723,110)=""
 S @G@("CPT",90724,88)=""
 S @G@("CPT",90725,26)=""
 S @G@("CPT",90726,90)=""
 S @G@("CPT",90727,23)=""
 S @G@("CPT",90728,19)=""
 S @G@("CPT",90730,85)=""
 S @G@("CPT",90731,45)=""
 S @G@("CPT",90732,33)=""
 S @G@("CPT",90733,32)=""
 S @G@("CPT",90734,114)=""
 S @G@("CPT",90735,39)=""
 S @G@("CPT",90736,121)=""
 S @G@("CPT",90737,17)=""
 S @G@("CPT",90738,134)=""
 S @G@("CPT",90740,44)=""
 S @G@("CPT",90741,14)=""
 S @G@("CPT",90743,43)=""
 S @G@("CPT",90744,8)=""
 S @G@("CPT",90745,42)=""
 S @G@("CPT",90746,43)=""
 S @G@("CPT",90747,44)=""
 S @G@("CPT",90748,51)=""
 S @G@("CPT",90749,999)=""
 Q
 ;
TNOIMMU ; 
 ;;<component>
 ;;<section>
 ;; <templateId root="2.16.840.1.113883.10.20.22.2.2.1"/>
 ;; <code code="11369-6" codeSystem="2.16.840.1.113883.6.1" displayName="History of immunizations" codeSystemName="LOINC"/>
 ;; <title>Immunizations</title>
 ;; <!--**** Immunzations Section Narrative Block ****-->
 ;; <text>
 ;;  <paragraph>
 ;;   <content ID="ZImmunizations.Immunizations.ORD-PHL02-NO-DATA">No immunizations administered or ordered.</content>
 ;;  </paragraph>
 ;; </text>
 ;; <entry typeCode="DRIV">
 ;;  <!--**** Immunzations Section Narrative Block ****-->
 ;;   <substanceAdministration classCode="SBADM" moodCode="INT" negationInd="false">   
 ;;   <templateId root="2.16.840.1.113883.10.20.22.4.52"/>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.52" extension="2015-08-01"/>
 ;;   <id nullFlavor="NI"/>
 ;;   <statusCode code="completed"/>
 ;;   <effectiveTime nullFlavor="NI"/>
 ;;   <consumable>
 ;;    <manufacturedProduct classCode="MANU">
 ;;     <templateId root="2.16.840.1.113883.10.20.22.4.54"/>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.54" extension="2014-06-09"/>
 ;;     <manufacturedMaterial>
 ;;       <code code="998" displayName="No Immunization administered" codeSystem="2.16.840.1.113883.12.292" codeSystemName="CVX"/>    
 ;;     </manufacturedMaterial>
 ;;     </manufacturedProduct>
 ;;   </consumable>
 ;;  </substanceAdministration>
 ;; </entry>
 ;;</section>
 ;;</component>
 Q
 ;
