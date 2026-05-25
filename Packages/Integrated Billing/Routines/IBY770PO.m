IBY770PO ;EDE/JWS - POST-INSTALL FOR IB*2.0*770 ;
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IA# 10141 - MES^XPDUTL
 ; IA#4677 - $$CREATE^XUSAP
 ; IA# 1472 - RESCH^XUTMOPT
 ; ICR #1157 - $$ADD^XPDMENU
 ; ICR #7204 - READ WRITE ACCESS TO WEB SERVER FILE (18.12)
 ; ICR #7205 - READ WRITE ACCESS TO WEB SERVICE FILE (18.02)
 ; 
 ;
EN ;Entry Point
 N IBA
 S IBA(2)="IB*2*770 Post-Install...",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 D REINDEX364P8
 ;D REINDEX364P92  ;TPF;IB*2*770v24
 D ADDPROXY
 ; D ACCDEF ;v45;went another direction.
 D PSCH
 D ACCMENU
 D WEBSTUFF
 D PUT^IBY770PRE
 D REINDEX364P92  ;TPF;IB*2*770v24
 S IBA(2)="IB*2*770 Post-Install Complete.",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
REINDEX364P8 ;reindex new stile xref since a subscript was added
 D MES^XPDUTL("reindexing 364.8 New Style XREF")
 N DIK
 S DIK="^IBA(364.8,"
 S DIK(1)=.08
 K ^IBA(364.8,"IBATSDB"),^("IBTASDB")
 D ENALL^DIK
 D MES^XPDUTL("364.8 reindex completed")
 Q
 ;
REINDEX364P92 ;RE-INDEX ACC ACTIVITY CODES
 D MES^XPDUTL("Reindexing 364.92")
 N DIK
 S DIK="^IBA(364.92,"
 K ^IBA(364.92,"AC"),^("AD")
 ;D IXALL2^DIK  ;THIS DOES WHAT THE ABOVE LINE IS DOING BUT KILLS ALL X-REFS
 ;D ENALL^DIK
 D IXALL^DIK   ;THIS ACTUALLY REINDEXES FOR THE ENTIRE FILE THE LINE ABOVE ONLY FOR ONE ENTRY
 D MES^XPDUTL("Reindexing 364.92 finished")
 Q
 ;
ADDPROXY ;Add APPLICATION PROXY user to file 200.  Supported by IA#4677.
 N IEN200
 D MES^XPDUTL("Adding entry 'AUTHORIZER,IB ACC' to the New Person file (#200)")
 ;S IEN200=$$CREATE^XUSAP("AUTHORIZER,IB ACC","","")
 S IEN200=$$CREATE^XUSAP("AUTHORIZER,IB ACC","")   ;WCJ;IB770v17
 I +IEN200=0 D MES^XPDUTL("........'AUTHORIZER,IB ACC' already exists.")
 I +IEN200>0 D MES^XPDUTL("........'AUTHORIZER,IB ACC' added.")
 I IEN200<0 D MES^XPDUTL("........'ERROR: AUTHORIZER,IB ACC' NOT added.")
 Q
 ;
ACCDEF ;Defaults for ACC Purge fields
 Q   ;WCJ;v45;decided to put in 364.991 (a VTU able file)
 N DA,DIE,DR,DTOUT
 D MES^XPDUTL("Setting defaults for Automated Community Care Purge.")
 S DIE=350.9,DA=1,DR="275///45;276///60;277///30"
 D ^DIE
 D MES^XPDUTL("Defaults for Automated Community Care Purge have been set.")
 Q
 ;
PSCH ;Schedule monthly purge
 N DA,DATE,DAY,DIE,DR,DTOUT,MON,OPTNAME,TIME,YR
 D MES^XPDUTL("Scheduling ACC X12 ENCOUNTER FILE Purge.")
 S OPTNAME="IBACC MONTHLY ENCOUNTER PURGE"
 S YR=$E(DT,1,3),MON=$E(DT,4,5),DAY=$E(DT,6,7)
 I DAY>13 S MON=MON+1 I MON>12 S YR=YR+1,MON=1
 S DATE=YR_$E(100+MON,2,3)_13_.0200
 I DATE<$$NOW^XLFDT S MON=MON+1 I MON>12 S YR=YR+1,MON=1
 D RESCH^XUTMOPT(OPTNAME,DATE,,"1M","L")  ;ICR #1472
 D MES^XPDUTL("ACC X12 ENCOUNTER FILE Purge has been scheduled.")
PSCHQ ;
 Q
 ;
ACCMENU ; add ACC Options to ACC Menu - ICR #1157  for the usage of $$ADD^XPDMENU
 D BMES^XPDUTL("Add options to Automated Community Care Menu")
 ;
 N IBMENU,IBOPT,IBOER,IBRET,IBSYN
 S IBMENU="IBACC WORKLIST MENU"
 S IBOPT="IBACC ACC ENCOUNTER PURGE",IBRET=$$ADD^XPDMENU(IBMENU,IBOPT)
 D MES^XPDUTL("Option: "_IBOPT_$S('IBRET:" NOT",1:"")_" added to menu: "_IBMENU)
 S IBOPT="IBACC WL ACC CLAIMS WORKLIST",IBRET=$$ADD^XPDMENU(IBMENU,IBOPT)
 D MES^XPDUTL("Option: "_IBOPT_$S('IBRET:" NOT",1:"")_" added to menu: "_IBMENU)
 S IBOPT="IBACC WL PREVIOUS ACT. REVIEW",IBRET=$$ADD^XPDMENU(IBMENU,IBOPT)
 D MES^XPDUTL("Option: "_IBOPT_$S('IBRET:" NOT",1:"")_" added to menu: "_IBMENU)
 ;
 S IBOPT=IBMENU,IBMENU="IBCE 837 EDI MENU",IBRET=$$ADD^XPDMENU(IBMENU,IBOPT,"ACC")
 D MES^XPDUTL("Option: "_IBOPT_$S('IBRET:" NOT",1:"")_" added to menu: "_IBMENU)
 ;
 S IBMENU="KPA FRT MAIN MENU" I $$LKOPT^XPDMENU(IBMENU) D
 . S IBRET=$$ADD^XPDMENU(IBMENU,IBOPT,"ACC")
 . D MES^XPDUTL("Option: "_IBOPT_$S('IBRET:" NOT",1:"")_" added to menu: "_IBMENU)
 ;
 S IBMENU="IBCN INSURANCE MGMT MENU" I $$LKOPT^XPDMENU(IBMENU) D
 . S IBRET=$$ADD^XPDMENU(IBMENU,IBOPT,"ACC")
 . D MES^XPDUTL("Option: "_IBOPT_$S('IBRET:" NOT",1:"")_" added to menu: "_IBMENU)
 ;
 S IBMENU="IBT USER MENU (IR)" I $$LKOPT^XPDMENU(IBMENU) D
 . S IBRET=$$ADD^XPDMENU(IBMENU,IBOPT,"ACC")
 . D MES^XPDUTL("Option: "_IBOPT_$S('IBRET:" NOT",1:"")_" added to menu: "_IBMENU)
 ;
 D MES^XPDUTL("Menus for Automated Community Care created/updated.")
 Q
 ;
WEBSTUFF ; added entries to 18.02 and 18.12
 ; stole from GMRCDST
 N FDA     ; -- FileMan Data Array
 N WEBVICE ; -- Web Service Internal Entry Number
 N WEBVER  ; -- Web Server Internal Entry Number
 N MULTIEN ; -- Web Service Multiple Internal Entry Number
 N WSTAT   ; -- Web Service Status
 N IENROOT,MSGROOT,IENROOT1,VICEIEN
 ;
 N SERVER,STATION,XUPROD
 S SERVER=""
 D SERVER
 S STATION=$P($$SITE^VASITE,U,3)
 ;
 S XUPROD=$$PROD^XUPROD
 I XUPROD S SERVER=$G(SERVER(STATION))
 ;
 I 'XUPROD,STATION=528 S SERVER="oitphcwebvirr2t.domain.ext"
 I SERVER="" D MES^XPDUTL("Web Service not added - no server defined for this station in this environment") Q
 ;
 K FDA
 S WEBVICE=$O(^XOB(18.02,"B","IBACC VIRR WEB SERVICE",0))
 S WEBVICE=$S(WEBVICE:WEBVICE,1:"+1")
 S FDA(18.02,WEBVICE_",",.01)="IBACC VIRR WEB SERVICE"                  ; NAME
 S FDA(18.02,WEBVICE_",",.02)="REST"                                ; TYPE
 S FDA(18.02,WEBVICE_",",.03)=$$NOW^XLFDT                              ; Date Registered
 S FDA(18.02,WEBVICE_",",200)="api/eps/acc/scrub"                           ; CONTEXT ROOT
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 ;
 K IENROOT,MSGROOT,FDA
 ;
 S WEBVER=$O(^XOB(18.12,"B","IBACC VIRR SERVER",0))
 S WEBVER=$S(WEBVER:WEBVER,1:"+1")
 S FDA(18.12,WEBVER_",",.01)="IBACC VIRR SERVER"                        ; NAME
 S FDA(18.12,WEBVER_",",.03)="8443"                                     ; PORT
 S FDA(18.12,WEBVER_",",.04)=SERVER                                     ; SERVER  determined by VISN
 S FDA(18.12,WEBVER_",",.06)="ENABLED"                                  ; STATUS 1-ENABLED / 0-DISABLED
 S FDA(18.12,WEBVER_",",.07)=15                                         ; DEFAULT HTTP TIMEOUT
 S FDA(18.12,WEBVER_",",1.01)="NO"                                      ; LOGIN REQUIRED
 S FDA(18.12,WEBVER_",",3.01)="TRUE"                                    ; SSL ENABLED
 S FDA(18.12,WEBVER_",",3.02)="encrypt_only_tlsv12"                     ; SSL CONFIGURATION
 S FDA(18.12,WEBVER_",",3.03)="8443"                                    ; SSL PORT
 ;Need to determine if we are creating a new file, or updating an existing one
 N NEW
 S NEW=1
 I $D(^XOB(18.12,WEBVER,0)) S NEW=0
 I NEW=1 D
 . D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 I NEW=0 D
 . D FILE^DIE("E","FDA","MSGROOT")
 ;
 S IENROOT1=$G(IENROOT(1)),MULTIEN=0
 ;
 S WEBVER=$S(IENROOT1:IENROOT1,1:WEBVER)
 K IENROOT,MSGROOT,FDA
 S VICEIEN=0 F  S VICEIEN=$O(^XOB(18.12,WEBVER,100,"B",VICEIEN)) Q:'VICEIEN  I $$GET1^DIQ(18.02,VICEIEN,.01)="IBACC VIRR WEB SERVICE" S MULTIEN=VICEIEN Q
 S MULTIEN=$S(MULTIEN:MULTIEN,1:"+1")
 S FDA(18.121,MULTIEN_","_WEBVER_",",.01)="IBACC VIRR WEB SERVICE"       ; WEB SERVICE
 S FDA(18.121,MULTIEN_","_WEBVER_",",.06)="ENABLED"                  ; STATUS 1-ENABLED / 0-DISABLED
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 Q
 ;
SERVER ;
 ;VISN 1 - oitphcwebvirr01.domain.ext
 S SERVER(402)="oitphcwebvirr01.domain.ext" ;Togus
 S SERVER(405)="oitphcwebvirr01.domain.ext" ;White River Junction
 S SERVER(523)="oitphcwebvirr01.domain.ext" ;Boston
 S SERVER(608)="oitphcwebvirr01.domain.ext" ;Manchester
 S SERVER(650)="oitphcwebvirr01.domain.ext" ;Providence
 S SERVER(689)="oitphcwebvirr01.domain.ext" ;West Haven
 S SERVER(518)="oitphcwebvirr01.domain.ext" ;Bedford
 S SERVER(631)="oitphcwebvirr01.domain.ext" ;North Hampton
 ;
 ;VISN 2 - oitphcwebepsv2.r04.domain.ext
 S SERVER(526)="oitphcwebepsv2.r04.domain.ext" ;Bronx
 S SERVER(528)="oitphcwebepsv2.r04.domain.ext" ;Upstate NY
 S SERVER(561)="oitphcwebepsv2.r04.domain.ext" ;East Orange
 S SERVER(620)="oitphcwebepsv2.r04.domain.ext" ;Hudson Valley
 S SERVER(630)="oitphcwebepsv2.r04.domain.ext" ;NY Harbor
 S SERVER(632)="oitphcwebepsv2.r04.domain.ext" ;NorthPort
 ;
 ;VISN 4 - oitphcwebvirr04.domain.ext
 S SERVER(595)="oitphcwebvirr04.domain.ext" ;Lebanon
 S SERVER(503)="oitphcwebvirr04.domain.ext" ;Altoona
 S SERVER(529)="oitphcwebvirr04.domain.ext" ;Butler
 S SERVER(542)="oitphcwebvirr04.domain.ext" ;Coatesville
 S SERVER(562)="oitphcwebvirr04.domain.ext" ;Erie
 S SERVER(642)="oitphcwebvirr04.domain.ext" ;Philadelphia
 S SERVER(646)="oitphcwebvirr04.domain.ext" ;Pittsburgh
 S SERVER(693)="oitphcwebvirr04.domain.ext" ;Wilkes-Barre
 S SERVER(460)="oitphcwebvirr04.domain.ext" ;Wilmington
 ;
 ;VISN 5 - oitphcwebvirr05.domain.ext
 S SERVER(512)="oitphcwebvirr05.domain.ext" ;Baltimore
 S SERVER(613)="oitphcwebvirr05.domain.ext" ;Martinsburg
 S SERVER(688)="oitphcwebvirr05.domain.ext" ;Wash DC
 S SERVER(517)="oitphcwebvirr05.domain.ext" ;Beckley
 S SERVER(540)="oitphcwebvirr05.domain.ext" ;Clarksburg
 S SERVER(581)="oitphcwebvirr05.domain.ext" ;Huntington
 ;
 ;VISN 6 - oitphcwebvirr06.domain.ext
 S SERVER(637)="oitphcwebvirr06.domain.ext" ;Asheville
 S SERVER(558)="oitphcwebvirr06.domain.ext" ;Durham
 S SERVER(565)="oitphcwebvirr06.domain.ext" ;Fayetteville NC
 S SERVER(590)="oitphcwebvirr06.domain.ext" ;Hampton
 S SERVER(673)="oitphcwebvirr06.domain.ext" ;Richmond
 S SERVER(658)="oitphcwebvirr06.domain.ext" ;Salem
 S SERVER(659)="oitphcwebvirr06.domain.ext" ;Salisbury
 ;
 ;VISN 7 - oitphcwebvirr07.domain.ext
 S SERVER(508)="oitphcwebvirr07.domain.ext" ;Atlanta
 S SERVER(509)="oitphcwebvirr07.domain.ext" ;Augusta
 S SERVER(521)="oitphcwebvirr07.domain.ext" ;Birmingham
 S SERVER(619)="oitphcwebvirr07.domain.ext" ;Central Alabama
 S SERVER(534)="oitphcwebvirr07.domain.ext" ;Charleston
 S SERVER(544)="oitphcwebvirr07.domain.ext" ;Columbia SC
 S SERVER(557)="oitphcwebvirr07.domain.ext" ;Dublin
 S SERVER(679)="oitphcwebvirr07.domain.ext" ;Tuscaloosa
 ;
 ;VISN 8 - oitphcwebvirr08.domain.ext
 S SERVER(516)="oitphcwebvirr08.domain.ext" ;Bay-Pines
 S SERVER(546)="oitphcwebvirr08.domain.ext" ;Miami
 S SERVER(573)="oitphcwebvirr08.domain.ext" ;North Florida (Gainesville)
 S SERVER(675)="oitphcwebvirr08.domain.ext" ;Orlando
 S SERVER(672)="oitphcwebvirr08.domain.ext" ;San Juan
 S SERVER(673)="oitphcwebvirr08.domain.ext" ;Tampa
 S SERVER(548)="oitphcwebvirr08.domain.ext" ;West Palm Beach
 ;
 ;VISN 9 - oitphcwebvirr09.domain.ext
 S SERVER(596)="oitphcwebvirr09.domain.ext" ;Lexington
 S SERVER(603)="oitphcwebvirr09.domain.ext" ;Louisville
 S SERVER(614)="oitphcwebvirr09.domain.ext" ;Memphis
 S SERVER(621)="oitphcwebvirr09.domain.ext" ;Mountain Home
 S SERVER(626)="oitphcwebvirr09.domain.ext" ;Tennessee Valley
 ;
 ;VISN 10 - oitphcwebvirr10.domain.ext
 S SERVER(538)="oitphcwebvirr10.domain.ext" ;Chillicothe
 S SERVER(539)="oitphcwebvirr10.domain.ext" ;Cincinnati
 S SERVER(541)="oitphcwebvirr10.domain.ext" ;Cleveland
 S SERVER(757)="oitphcwebvirr10.domain.ext" ;Columbus OH
 S SERVER(552)="oitphcwebvirr10.domain.ext" ;Dayton
 S SERVER(506)="oitphcwebvirr10.domain.ext" ;Ann Arbor
 S SERVER(515)="oitphcwebvirr10.domain.ext" ;Battle Creek
 S SERVER(559)="oitphcwebvirr10.domain.ext" ;Danville
 S SERVER(553)="oitphcwebvirr10.domain.ext" ;Detroit
 S SERVER(583)="oitphcwebvirr10.domain.ext" ;Indianapolis
 S SERVER(610)="oitphcwebvirr10.domain.ext" ;Northern Indiana
 S SERVER(655)="oitphcwebvirr10.domain.ext" ;Saginaw
 ;
 ;VISN 12 oitauswebvirr12.domain.ext
 S SERVER(537)="oitauswebvirr12.domain.ext" ;CHD - Chicago
 S SERVER(578)="oitauswebvirr12.domain.ext" ;HIN - Hinds
 S SERVER(585)="oitauswebvirr12.domain.ext" ;IRO - Iron Mountain
 S SERVER(607)="oitauswebvirr12.domain.ext" ;MAD - Madison
 S SERVER(695)="oitauswebvirr12.domain.ext" ;MIW - Milwaukee
 S SERVER(556)="oitauswebvirr12.domain.ext" ;NCH - North Chicago
 S SERVER(676)="oitauswebvirr12.domain.ext" ;TOM - Tomah
 ;
 ;VISN 15 - oitauswebvirr15.domain.ext VA Heartland Network
 ; Includes Columbia, Eastern Kansas, Kansas City, Leavenworth
 ; Marion, Poplar Bluff, Topeka, St. Louis, and Wichita
 S SERVER(657)="oitauswebvirr15.domain.ext" ;Heartland East
 S SERVER(589)="oitauswebvirr15.domain.ext" ;Heartland West
 ;
 ;VISN 16 - oitauswebvirr16.domain.ext
 S SERVER(502)="oitauswebvirr16.domain.ext" ;Alexandria
 S SERVER(520)="oitauswebvirr16.domain.ext" ;Biloxi
 S SERVER(564)="oitauswebvirr16.domain.ext" ;Fayetteville
 S SERVER(580)="oitauswebvirr16.domain.ext" ;Houston
 S SERVER(586)="oitauswebvirr16.domain.ext" ;Jackson
 S SERVER(598)="oitauswebvirr16.domain.ext" ;Little Rock
 S SERVER(623)="oitauswebvirr16.domain.ext" ;Muskogee
 S SERVER(629)="oitauswebvirr16.domain.ext" ;New Orleans
 S SERVER(635)="oitauswebvirr16.domain.ext" ;Oklahoma City
 S SERVER(667)="oitauswebvirr16.domain.ext" ;Shreveport
 ;
 ;VISN 17 - oitauswebvirr17.domain.ext
 S SERVER(674)="oitauswebvirr17.domain.ext" ;Central Texas
 S SERVER(549)="oitauswebvirr17.domain.ext" ;North Texas
 S SERVER(671)="oitauswebvirr17.domain.ext" ;South Texas
 S SERVER(740)="oitauswebvirr17.domain.ext" ;Valley Coastal Bend
 ;
 ;VISN 18 - oitdvrwebvirr18.domain.ext
 S SERVER(501)="oitdvrwebvirr18.domain.ext" ;Albuquerque
 S SERVER(504)="oitdvrwebvirr18.domain.ext" ;Amarillo
 S SERVER(519)="oitdvrwebvirr18.domain.ext" ;Big Spring
 S SERVER(756)="oitdvrwebvirr18.domain.ext" ;El Paso
 S SERVER(644)="oitdvrwebvirr18.domain.ext" ;Phoenix
 S SERVER(649)="oitdvrwebvirr18.domain.ext" ;Prescott
 S SERVER(678)="oitdvrwebvirr18.domain.ext" ;Tucson
 ;
 ;VISN 19 - oitdvrwebvirr19.domain.ext
 S SERVER(442)="oitdvrwebvirr19.domain.ext" ;Cheyenne
 S SERVER(554)="oitdvrwebvirr19.domain.ext" ;Denver
 S SERVER(436)="oitdvrwebvirr19.domain.ext" ;Fort Harrison
 S SERVER(575)="oitdvrwebvirr19.domain.ext" ;Grand Junction
 S SERVER(660)="oitdvrwebvirr19.domain.ext" ;Salt Lake City
 S SERVER(666)="oitdvrwebvirr19.domain.ext" ;Sheridan
 ;
 ;VISN 20 - oitauswebvirr20.domain.ext
 S SERVER(463)="oitauswebvirr20.domain.ext" ;Anchorage
 S SERVER(531)="oitauswebvirr20.domain.ext" ;Boise
 S SERVER(648)="oitauswebvirr20.domain.ext" ;Portland
 S SERVER(663)="oitauswebvirr20.domain.ext" ;Puget Sound
 S SERVER(653)="oitauswebvirr20.domain.ext" ;Roseburg
 S SERVER(668)="oitauswebvirr20.domain.ext" ;Spokane
 S SERVER(687)="oitauswebvirr20.domain.ext" ;Walla Walla
 S SERVER(692)="oitauswebvirr20.domain.ext" ;White City
 ;
 ;VISN 21 - oitauswebvirr21.domain.ext
 S SERVER(570)="oitauswebvirr21.domain.ext" ;Fresno
 S SERVER(459)="oitauswebvirr21.domain.ext" ;Honolulu
 S SERVER(612)="oitauswebvirr21.domain.ext" ;Martinez
 S SERVER(640)="oitauswebvirr21.domain.ext" ;Palo Alto
 S SERVER(654)="oitauswebvirr21.domain.ext" ;Reno
 S SERVER(662)="oitauswebvirr21.domain.ext" ;San Francisco
 ;
 ;VISN 22 - oitdvrwebvirr22.domain.ext
 S SERVER(691)="oitdvrwebvirr22.domain.ext" ;Greater Los Angeles
 S SERVER(593)="oitdvrwebvirr22.domain.ext" ;Las Vegas
 S SERVER(605)="oitdvrwebvirr22.domain.ext" ;Loma Linda
 S SERVER(600)="oitdvrwebvirr22.domain.ext" ;Long Beach
 S SERVER(664)="oitdvrwebvirr22.domain.ext" ;San Diego
 ;
 ;VISN 23
 S SERVER(568)="oitauswebvirr23.domain.ext" ;Black Hills
 S SERVER(437)="oitauswebvirr23.domain.ext" ;Fargo
 S SERVER(618)="oitauswebvirr23.domain.ext" ;Minneapolis
 S SERVER(636)="oitauswebvirr23.domain.ext" ;Omaha - Includes Grand Island, Lincoln, Iowa City, Hot Springs,Ft. Meade, and Central Iowa
 S SERVER(656)="oitauswebvirr23.domain.ext" ;St. Cloud
 S SERVER(438)="oitauswebvirr23.domain.ext" ;Sioux Falls
 ;
 Q
 ;
 N VISN
 S VISN(1)="" ; VA New England Healthcare System
 S VISN(2)="" ; New York/New Jersey VA Health Care Network
 S VISN(4)="" ; VA Healthcare - VISN 4
 S VISN(5)="" ; VA Capitol Health Care Network
 S VISN(6)="" ; Mid-Atlantic Health Care Network
 S VISN(7)="" ; Southeast Network
 S VISN(8)="" ; VA Sunshine Healthcare Network
 S VISN(9)="" ; VA MidSouth Healthcare Network
 S VISN(10)="" ; VA Healthcare System
 S VISN(12)="" ; VA Great Lakes Health Care System
 S VISN(15)="" ; VA Heartland Network
 S VISN(16)="" ; South Central VA Health Care Network
 S VISN(17)="" ; VA Heart of Texas Health Care Network
 S VISN(19)="" ; Rocky Mountain Network
 S VISN(20)="" ; Northwest Network
 S VISN(21)="" ; Sierra Pacific Network
 S VISN(22)="" ; Desert Pacific Healthcare Network
 S VISN(23)="" ; VA Midwest Health Care Network
