SDHPIENV ;MTC,PKE/ALB - Health Services R&D- ENVIRONMENT CHECK; 3/12/96 [ 10/21/96   8:19 AM ]
 ;;5.3;Scheduling;**141**;DEC 18, 1997
 ;
 ; 
ENVIR N SDSITE
 S SDSITE=+$$SITE^VASITE()
 I 'SDSITE DO  QUIT
 . W !!?3,"A call to $$SITE^VASITE() does not return your Station Number"
 . W !?3,"Please correct this before installing this Patch"
 .;
 . I '$G(XPDENV) Q
 . S XPDQUIT=2
 ;
 I $D(DUZ)'=11 DO
 . W !!?3,"Please set DUZ variables, D ^XUP"
 . I '$G(XPDENV) Q
 . S XPDQUIT=2
 ;
 ; default no to disable option/protocols
 I $G(XPDENV)=1 S XPDDIQ("XPZ1","B")="NO"
 ;
 Q
 ;
PRETRANS ;
 ;load table of station numbers, ssn from temporary file
 ;
 ;format of table "sd",station,N sequential)=SSN piece string
 ;n winds up not sequential for integration sites
 ; 
 M @XPDGREF@("SDHPI")=^XTMP("SDHPIENV")
 ;remove legacy stations
 K @XPDGREF@("SDHPI",505)
 K @XPDGREF@("SDHPI",513)
 K @XPDGREF@("SDHPI",522)
 K @XPDGREF@("SDHPI",533)
 K @XPDGREF@("SDHPI",535)
 ;
 K @XPDGREF@("SDHPI",566) K @XPDGREF@("SDHPI",641)
 K @XPDGREF@("SDHPI",569)
 K @XPDGREF@("SDHPI",574)
 K @XPDGREF@("SDHPI",579)
 K @XPDGREF@("SDHPI",592)
 K @XPDGREF@("SDHPI",591)
 K @XPDGREF@("SDHPI",604)
 ;
 K @XPDGREF@("SDHPI",611) K @XPDGREF@("SDHPI",685)
 K @XPDGREF@("SDHPI",627)
 K @XPDGREF@("SDHPI",640)
 K @XPDGREF@("SDHPI",645)
 K @XPDGREF@("SDHPI",680)
 K @XPDGREF@("SDHPI",686)
 ;
 K @XPDGREF@("SDHPI",691) K @XPDGREF@("SDHPI",752)
 ;
 W !?9,"removed ..."
 ;merge legacy stations to primary
 ;
 M @XPDGREF@("SDHPI",512)=^XTMP("SDHPIENV",566)
 M @XPDGREF@("SDHPI",512)=^XTMP("SDHPIENV",641)
 ;
 M @XPDGREF@("SDHPI",528)=^XTMP("SDHPIENV",513)
 M @XPDGREF@("SDHPI",537)=^XTMP("SDHPIENV",535)
 M @XPDGREF@("SDHPI",549)=^XTMP("SDHPIENV",522)
 M @XPDGREF@("SDHPI",555)=^XTMP("SDHPIENV",592)
 M @XPDGREF@("SDHPI",561)=^XTMP("SDHPIENV",604)
 M @XPDGREF@("SDHPI",568)=^XTMP("SDHPIENV",579)
 M @XPDGREF@("SDHPI",597)=^XTMP("SDHPIENV",574)
 M @XPDGREF@("SDHPI",599)=^XTMP("SDHPIENV",640)
 M @XPDGREF@("SDHPI",610)=^XTMP("SDHPIENV",569)
 M @XPDGREF@("SDHPI",619)=^XTMP("SDHPIENV",680)
 M @XPDGREF@("SDHPI",620)=^XTMP("SDHPIENV",533)
 M @XPDGREF@("SDHPI",646)=^XTMP("SDHPIENV",645)
 ;
 M @XPDGREF@("SDHPI",665)=^XTMP("SDHPIENV",691)
 M @XPDGREF@("SDHPI",665)=^XTMP("SDHPIENV",752)
 ;
 M @XPDGREF@("SDHPI",671)=^XTMP("SDHPIENV",591)
 ;                                      
 M @XPDGREF@("SDHPI",674)=^XTMP("SDHPIENV",611)
 M @XPDGREF@("SDHPI",674)=^XTMP("SDHPIENV",685)
 ;
 M @XPDGREF@("SDHPI",677)=^XTMP("SDHPIENV",686)
 M @XPDGREF@("SDHPI",663)=^XTMP("SDHPIENV",505)
 M @XPDGREF@("SDHPI",689)=^XTMP("SDHPIENV",627)
 ;
 Q
 ;
POSTINST ;
 ;install station specific table of SSNs.
 N SDSITE
 S SDSITE=+$$SITE^VASITE() I 'SDSITE QUIT
 ;
 K ^XTMP("SDHPI")
 S ^XTMP("SDHPI",0)=$$FMADD^XLFDT(DT,9)
 ;
 I '$D(@XPDGREF@("SDHPI",SDSITE)) DO  QUIT
 . S ^XTMP("SDHPI","S",SDSITE,"ERROR","NO DATA REQUESTED")=DT
 ;
 M ^XTMP("SDHPI","S",SDSITE)=@XPDGREF@("SDHPI",SDSITE)
 ;
 Q
STATION ;
 ;;358;363;402;405;436;437;438;442;452;459;460;463;
 ;;500;501;502;503;504;505;506;508;509;512;513;514;515;516;517;518;519;
 ;;520;521;522;523;525;526;527;528;529;531;532;533;534;535;537;538;539;
 ;;540;541;542;543;544;546;548;549;550;552;553;554;555;556;557;558;
 ;;561;562;564;565;566;567;568;569;570;573;574;575;578;579;
 ;;580;581;583;584;585;586;589;590;591;592;593;594;595;596;597;598;599;
 ;;600;603;604;605;607;608;609;610;611;612;613;614;617;618;619;
 ;;620;621;622;623;626;627;629;630;631;632;635;636;637;
 ;;640;641;642;644;645;646;647;648;649;
 ;;650;652;653;654;655;656;657;658;659;
 ;;660;662;663;664;665;666;667;668;670;671;672;673;674;676;677;678;679;
 ;;680;685;686;687;688;689;691;692;693;695;752;756;757;758;
 Q
 ;checklist
 ; SDSITE=512 M (566),(641) ;baltimore/perrypt/fthoward
 ; SDSITE=528 M (513) ;buffalo/batavia
 ; SDSITE=537 M (535) ;westside/lakeside
 ; SDSITE=549 M (522) ;dallas/bonham
 ; SDSITE=555 M (592) ;desmoines/knoxville
 ; SDSITE=561 M (604) ;eastorange/lyons
 ; SDSITE=568 M (579) ;fortmead/hotsprings
 ; SDSITE=597 M (574) ;lincoln/grandisland
 ; SDSITE=599 M (640) ;paloalto/livermore
 ; SDSITE=610 M (569) ;marion/fortwayne
 ; SDSITE=619 M (680) ;montgomery/tuskegee
 ; SDSTIE=620 M (533) ;montrose/castle pt
 ; SDSITE=646 M (645) ;pittsburguniv/highlandrive
 ; SDSITE=663 M (505) ;seatle/americTN=
 ; SDSITE=665 M (752) ;sepulvada/la opc
 ; SDSITE=671 M (591) ;sanantonio/kerrvile
 ; SDSITE=674 M (611),(685) ;temple/waco/marlin
 ; SDSITE=677 M (686) ;topeka/leavenworth
 ; SDSITE=689 M (627) ;westhaven/newington
 Q
