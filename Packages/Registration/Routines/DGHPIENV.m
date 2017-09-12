DGHPIENV ;MTC,PKE/ALB - Health Services R&D- ENVIRONMENT CHECK; 3/12/96 [ 10/21/96   8:19 AM ]
 ;;5.3;Registration;**221**;Aug 13, 1993
 ;
 ; 
ENVIR N DGSITE
 S DGSITE=+$P($$SITE^VASITE(),U,3)
 I 'DGSITE DO  QUIT
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
 ;format of table "dg",station,N sequential)=SSN piece string
 ;n winds up not sequential for integration sites
 ; 
 M @XPDGREF@("DGHPI")=^XTMP("DGHPIENV")
 ;remove legacy stations
 K @XPDGREF@("DGHPI",505)
 K @XPDGREF@("DGHPI",513)
 K @XPDGREF@("DGHPI",522)
 K @XPDGREF@("DGHPI",533)
 K @XPDGREF@("DGHPI",535)
 ;
 K @XPDGREF@("DGHPI",566) K @XPDGREF@("DGHPI",641)
 K @XPDGREF@("DGHPI",569)
 K @XPDGREF@("DGHPI",574)
 K @XPDGREF@("DGHPI",579)
 K @XPDGREF@("DGHPI",592)
 K @XPDGREF@("DGHPI",591)
 K @XPDGREF@("DGHPI",604)
 ;
 K @XPDGREF@("DGHPI",611) K @XPDGREF@("DGHPI",685)
 K @XPDGREF@("DGHPI",627)
 K @XPDGREF@("DGHPI",599)
 K @XPDGREF@("DGHPI",645)
 K @XPDGREF@("DGHPI",680)
 K @XPDGREF@("DGHPI",686)
 ;
 K @XPDGREF@("DGHPI",665) K @XPDGREF@("DGHPI",752)
 K @XPDGREF@("DGHPI",594)
 K @XPDGREF@("DGHPI",617)
 ;
 W !?9,"removed ..."
 ;merge legacy stations to primary
 ;
 M @XPDGREF@("DGHPI",512)=^XTMP("DGHPIENV",566)
 M @XPDGREF@("DGHPI",512)=^XTMP("DGHPIENV",641)
 ;
 M @XPDGREF@("DGHPI",528)=^XTMP("DGHPIENV",513)
 M @XPDGREF@("DGHPI",537)=^XTMP("DGHPIENV",535)
 M @XPDGREF@("DGHPI",549)=^XTMP("DGHPIENV",522)
 M @XPDGREF@("DGHPI",555)=^XTMP("DGHPIENV",592)
 M @XPDGREF@("DGHPI",561)=^XTMP("DGHPIENV",604)
 M @XPDGREF@("DGHPI",568)=^XTMP("DGHPIENV",579)
 M @XPDGREF@("DGHPI",597)=^XTMP("DGHPIENV",574)
 M @XPDGREF@("DGHPI",640)=^XTMP("DGHPIENV",599)
 M @XPDGREF@("DGHPI",610)=^XTMP("DGHPIENV",569)
 M @XPDGREF@("DGHPI",619)=^XTMP("DGHPIENV",680)
 M @XPDGREF@("DGHPI",620)=^XTMP("DGHPIENV",533)
 M @XPDGREF@("DGHPI",646)=^XTMP("DGHPIENV",645)
 ;
 M @XPDGREF@("DGHPI",691)=^XTMP("DGHPIENV",665)
 M @XPDGREF@("DGHPI",691)=^XTMP("DGHPIENV",752)
 ;
 M @XPDGREF@("DGHPI",671)=^XTMP("DGHPIENV",591)
 ;                                      
 M @XPDGREF@("DGHPI",674)=^XTMP("DGHPIENV",611)
 M @XPDGREF@("DGHPI",674)=^XTMP("DGHPIENV",685)
 ;
 M @XPDGREF@("DGHPI",677)=^XTMP("DGHPIENV",686)
 M @XPDGREF@("DGHPI",663)=^XTMP("DGHPIENV",505)
 M @XPDGREF@("DGHPI",689)=^XTMP("DGHPIENV",627)
 M @XPDGREF@("DGHPI",573)=^XTMP("DGHPIENV",594)
 M @XPDGREF@("DGHPI",436)=^XTMP("DGHPIENV",617)
 ;
 Q
 ;
POSTINST ;
 ;install station specific table of SSNs.
 N DGSITE
 S DGSITE=+$P($$SITE^VASITE(),U,3) I 'DGSITE QUIT
 ;
 K ^XTMP("DGHPI")
 S ^XTMP("DGHPI",0)=$$FMADD^XLFDT(DT,9)
 ;
 I '$D(@XPDGREF@("DGHPI",DGSITE)) DO  QUIT
 . S ^XTMP("DGHPI","S",DGSITE,"ERROR","NO DATA REQUESTED")=DT
 ;
 M ^XTMP("DGHPI","S",DGSITE)=@XPDGREF@("DGHPI",DGSITE)
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
 ; DGSITE=512 M (566),(641) ;baltimore/perrypt/fthoward
 ; DGSITE=528 M (513) ;buffalo/batavia
 ; DGSITE=537 M (535) ;westside/lakeside
 ; DGSITE=549 M (522) ;dallas/bonham
 ; DGSITE=555 M (592) ;desmoines/knoxville
 ; DGSITE=561 M (604) ;eastorange/lyons
 ; DGSITE=568 M (579) ;fortmead/hotsprings
 ; DGSITE=597 M (574) ;lincoln/grandisland
 ; DGSITE=640 M (599) ;paloalto/livermore
 ; DGSITE=610 M (569) ;marion/fortwayne
 ; DGSITE=619 M (680) ;montgomery/tuskegee
 ; DGSTIE=620 M (533) ;montrose/castle pt
 ; DGSITE=646 M (645) ;pittsburguniv/highlandrive
 ; DGSITE=663 M (505) ;seatle/americTN=
 ; DGSITE=691 M (752) ;sepulvada/la opc
 ; DGSITE=671 M (591) ;sanantonio/kerrvile
 ; DGSITE=674 M (611),(685) ;temple/waco/marlin
 ; DGSITE=677 M (686) ;topeka/leavenworth
 ; DGSITE=689 M (627) ;westhaven/newington
 ; DGSITE=573 M (594) ;North Florida South Georgia
 ; DGSITE=436 M (617) ;Montana
 Q
