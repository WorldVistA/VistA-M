DG531065P ;ALB/JAM - EMERGENCY PATCH DG*5.3*1065 POST-INSTALL ROUTINE ;01 October 2021 10:00 AM
 ;;5.3;Registration;**1065**;Aug 13, 1993;Build 6
 ; ICRs:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;         5421 : REGREST^XOBWLIB
 ;         7190 : Access to file 18.02
 ;         2263 : SUPPORTED PARAMETER TOOL ENTRY POINTS
 ;
 Q
POST ; Main entry point for post-install 
 ; - Update the UAM web services to remove the API Key from the Context Root
 ; - Get the API key appropriate for the site and store in the PARAMETERS file (#8989.5)
 ;
 D BMES^XPDUTL(">>> Patch DG*5.3*1065 - Post-install started.")
 N DGPREFIX,DGKEY
 ; Set PREFIX to more quickly change the server/service names per site or for testing
 S DGPREFIX="DG UAM AV " ; include the space at the end of the prefix
 D POST1(.DGKEY)
 D POST2(DGKEY)
 D POST3
 D BMES^XPDUTL(">>> Patch DG*5.3*1065 - Post-install complete.")
 Q
POST1(DGKEY) ; Get the API Key
 ; DGKEY - (Pass by Reference) Set API Key into DGKEY 
 N DGCOUNT,DGDATA,DGSTATION,DGEXIT,DGREGION
 ; Get the current site station number
 S DGSTATION=$P($$SITE^VASITE,"^",3)  ;Output= Institution file pointer^Institution name^station number with suffix
 ; Set the default region 
 S DGREGION="Staging",DGEXIT=0
 ; Loop to find the matching region for the station number
 F DGCOUNT=1:1 S DGDATA=$P($T(REGMAP+DGCOUNT),";;",2) Q:DGDATA="END"  D  Q:DGEXIT
 . I $P(DGDATA,";",1)=DGSTATION S DGREGION=$P(DGDATA,";",3),DGEXIT=1
 ; Get the matching DGKEY for the region
 S DGEXIT=0
 F DGCOUNT=1:1 S DGDATA=$P($T(KEYMAP+DGCOUNT),";;",2) Q:DGDATA="END"  D  Q:DGEXIT
 . I $P(DGDATA,";",1)=DGREGION S DGKEY=$P(DGDATA,";",2),DGEXIT=1
 D BMES^XPDUTL(">UAM Address Validation Key assigned. Region: "_DGREGION)
 Q
 ;
POST2(DGKEY) ; Set the API Key for the site into the PARAMETER file
 N DGFDA,DGERR
 ;
 D BMES^XPDUTL(" o Set Parameter instance DG UAM API KEY in the PARAMETER (#8989.5) file")
 D EN^XPAR("PKG","DG UAM API KEY",1,DGKEY,.DGERR)
 I '$G(DGERR) D MES^XPDUTL(" o DG UAM API KEY Parameter set successfully.")
 I $G(DGERR) D
 . D BMES^XPDUTL(" *** Parameter set failed: "_DGERR)
 . D MES^XPDUTL("  Please log YOUR IT Services ticket. ***")
 Q
 ;
POST3 ; Set services to remove the API Key - use REGREST^XOBWLIB
 N DGI,DGILOWCASE,DGCNTXTRT,DGSRVC
 D BMES^XPDUTL(">Updating WEB SERVICE (#18.02) file...")
 F DGI="CANDIDATE","VALIDATE" D
 . ; use the prefix name from INIT
 . S DGSRVC=DGPREFIX_DGI
 . S DGILOWCASE=$TR(DGI,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 . ; Set the Context Root without the API Key which was set up in patch 1014.
 . IF DGI="CANDIDATE" S DGCNTXTRT="services/address_validation/v2/"_DGILOWCASE
 . IF DGI="VALIDATE" S DGCNTXTRT="services/address_validation/v1/"_DGILOWCASE
 . D REGREST^XOBWLIB(DGSRVC,DGCNTXTRT) ; REGREST^XOBWLIB handles all messaging.
 Q
 ;
REGMAP ; Station-to-Region mapping table - Format: ;;Station ID;VISN;Region;VHA Facility Name
 ;;358;21;Pacific;Manila Outpatient Clinic (Philippines)
 ;;402;1;North Atlantic;VA Maine Healthcare Systems (Togus)
 ;;405;1;North Atlantic;White River Junction VA Medical Center 
 ;;436;19;Continental;VA Montana Health Care System (Ft. Harrison, Miles City)
 ;;437;23;Midwest;Fargo VA Medical Center
 ;;438;23;Midwest;Royal C. Johnson Veterans Memorial Medical Center (Sioux Falls)
 ;;442;19;Continental;Cheyenne VA Medical Center
 ;;459;21;Pacific;VA Pacific Islands Health Care System (Honolulu)
 ;;460;4;North Atlantic;Wilmington VA Medical Center
 ;;463;20;Pacific;Alaska VA Healthcare System (Anchorage)
 ;;501;18;Pacific;New Mexico VA Health Care System (Albuquerque)
 ;;502;16;Continental;Alexandria VA Health Care System (Pineville)
 ;;503;4;North Atlantic;Altoona - James E. Van Zandt VA Medical Center
 ;;504;17;Continental;Amarillo VA Health Care System
 ;;506;11;Midwest;VA Ann Arbor Healthcare System
 ;;508;7;Southeast;Atlanta VA Health Care System
 ;;509;7;Southeast;Charlie Norwood VA Medical Center (Augusta)
 ;;512;5;North Atlantic;VA Maryland Health Care System (Baltimore, Loch Raven, Perry Point)
 ;;515;11;Midwest;Battle Creek VA Medical Center
 ;;516;8;Southeast;C.W. Bill Young VA Medical Center (Bay Pines)
 ;;517;5;North Atlantic;Beckley VA Medical Center
 ;;518;1;North Atlantic;Edith Nourse Rogers Memorial Veterans Hospital (Bedford VA)
 ;;519;17;Continental;West Texas VA Health Care System (Big Spring)
 ;;520;16;Continental;Gulf Coast Veterans Health Care System (Biloxi)
 ;;521;7;Southeast;Birmingham VA Medical Center
 ;;523;1;North Atlantic;VA Boston Health Care System (Jamaica Plain, Brockton, West Roxbury)
 ;;526;3;North Atlantic;James J. Peters VA Medical Center (Bronx, NY)
 ;;528;2;North Atlantic;VA Western New York Healthcare System (Buffalo and Batavia)
 ;;529;4;North Atlantic;VA Butler Healthcare
 ;;531;20;Pacific;Boise VA Medical Center
 ;;534;7;Southeast;Ralph H. Johnson VA Medical Center (Charleston)
 ;;537;12;Midwest;Jesse Brown VA Medical Center (Chicago Westside, Chicago Lakeside)
 ;;538;10;Midwest;Chillicothe VA Medical Center
 ;;539;10;Midwest;Cincinnati VA Medical Center
 ;;540;5;North Atlantic;Louis A. Johnson VA Medical Center (Clarksburg)
 ;;541;10;Midwest;Louis Stokes Cleveland VA Medical Center
 ;;542;4;North Atlantic;Coatesville VA Medical Center
 ;;544;7;Southeast;Wm. Jennings Bryan Dorn VA Medical Center (Columbia)
 ;;546;8;Southeast;Miami VA Healthcare System
 ;;548;8;Southeast;West Palm Beach VA Medical Center
 ;;549;17;Continental;VA North Texas Health Care System (Dallas, Bonham)
 ;;550;11;Midwest;VA Illiana Health Care System  (Danville)
 ;;552;10;Midwest;Dayton VA Medical Center
 ;;553;11;Midwest;John D. Dingell VA Medical Center (Detroit)
 ;;554;19;Continental;VA Eastern Colorado Health Care System (ECHCS) (Denver, Fort Lyon)
 ;;556;12;Midwest;Captain James A. Lovell Federal Health Care Center (North Chicago)
 ;;557;7;Southeast;Carl Vinson VA Medical Center  (Dublin)
 ;;558;6;North Atlantic;Durham VA Medical Center
 ;;561;3;North Atlantic;VA New Jersey Health Care System (East Orange, Lyons)
 ;;562;4;North Atlantic;Erie VA Medical Center
 ;;564;16;Continental;Veterans Health Care System of the Ozarks (Fayetteville)
 ;;565;6;North Atlantic;Fayetteville VA Medical Center
 ;;568;23;Midwest;VA Black Hills Health Care System (Fort Meade, Hot Springs)
 ;;570;21;Pacific;Central California VA Health Care System (Fresno)
 ;;573;8;Southeast;VA North Florida / South Georgia VA Health Care System  (Gainesville, Lake City)
 ;;575;19;Continental;Grand Junction VA Medical Center
 ;;578;12;Midwest;Edward Hines Jr. VA Hospital (Hines)
 ;;580;16;Continental;Michael E. DeBakey VA Medical Center (Houston)
 ;;581;5;North Atlantic;Huntington VA Medical Center
 ;;583;11;Midwest;Richard L. Roudebush VA Medical Center (Indianapolis)
 ;;585;12;Midwest;Oscar G. Johnson VA Medical Center (Iron Mountain)
 ;;586;16;Continental;G.V. (Sonny) Montgomery VA Medical Center (Jackson)
 ;;589;15;Midwest;VA Eastern Kansas Health Care System (Kansas City, Columbia, Topeka, Leavenworth, Wichita) (formerly VA Heartland - West)
 ;;590;6;North Atlantic;Hampton VA Medical Center
 ;;593;21;Pacific;VA Southern Nevada Healthcare System (Las Vegas)
 ;;595;4;North Atlantic;Lebanon VA Medical Center
 ;;596;9;Southeast;Lexington VA Medical Center (Leestown, Cooper)
 ;;598;16;Continental;Central Arkansas Veterans Healthcare System (North Little Rock, Little Rock)
 ;;600;22;Pacific;VA Long Beach Heathcare System
 ;;603;9;Southeast;Robley Rex VA Medical Center (Louisville)
 ;;605;22;Pacific;Jerry L. Pettis Memorial VA Medical Center (Loma Linda)
 ;;607;12;Midwest;William S. Middleton Memorial Veterans Hospital (Madison)
 ;;608;1;North Atlantic;Manchester VA Medical Center
 ;;610;11;Midwest;VA Northern Indiana Health Care System (Marion, Fort Wayne)
 ;;612;21;Pacific;VA Northern California Health Care System (Mather)
 ;;613;5;North Atlantic;Martinsburg VA Medical Center
 ;;614;9;Southeast;Memphis VA Medical Center
 ;;618;23;Midwest;Minneapolis VA Medical Center
 ;;619;7;Southeast;Central Alabama Veterans Health Care System (Tuskegee, Montgomery)
 ;;620;3;North Atlantic;VA Hudson Valley Health Care System (Montrose, Castle Point)
 ;;621;9;Southeast;James H. Quillen VA Medical Center (Mountain Home)
 ;;623;19;Continental;Jack C. Montgomery VA Medical Center (Muskogee)
 ;;626;9;Southeast;VA Tennessee Valley Health Care System (Nashville, Murfreesboro)
 ;;629;16;Continental;Southeast Louisiana Veterans Health Care System (New Orleans)
 ;;630;3;North Atlantic;VA New York Harbor Health Care System (Brooklyn, Manhattan)
 ;;631;1;North Atlantic;VA Central Western Massachusetts Healthcare System (Formerly Northampton VA Medical Center)
 ;;632;3;North Atlantic;Northport VA Medical Center
 ;;635;19;Continental;Oklahoma City VA Medical Center
 ;;636;23;Midwest;VA Nebraska-Western Iowa Health Care System (Omaha, Lincoln, Grand Island of NE, Des Moines, Knoxville, Iowa City of IA) aka VA Central Plains Health Care System
 ;;637;6;North Atlantic;Asheville VA Medical Center
 ;;640;21;Pacific;VA Palo Alto Health Care System (Menlo Park, Palo Alto, Livermore) 
 ;;642;4;North Atlantic;Philadelphia VA Medical Center
 ;;644;18;Pacific;Phoenix VA Health Care System
 ;;646;4;North Atlantic;VA Pittsburgh Health Care System (Pittsburgh University Dr., H. J. Heinz Campus)
 ;;648;20;Pacific;VA Portland Health Care System (Portland, Vancouver) 
 ;;649;18;Pacific;Northern Arizona VA Health Care System (Prescott)
 ;;650;1;North Atlantic;Providence VA Medical Center
 ;;652;6;North Atlantic;Hunter Holmes McGuire VA Medical Center (Richmond)
 ;;653;20;Pacific;VA Roseburg Healthcare System
 ;;654;21;Pacific;VA Sierra Nevada Health Care System (Reno)
 ;;655;11;Midwest;Aleda E. Lutz VA Medical Center (Saginaw)
 ;;656;23;Midwest;St. Cloud VA Health Care System
 ;;657;15;Midwest;VA St. Louis Health Care System (St. Louis, Poplar Bluff, Marion) (formerly VA Heartland East)
 ;;658;6;North Atlantic;Salem VA Medical Center
 ;;659;6;North Atlantic;W.G. (Bill) Hefner VA Medical Center (Salisbury)
 ;;660;19;Continental;VA Salt Lake City Health Care System
 ;;662;21;Pacific;San Francisco VA Medical Center
 ;;663;20;Pacific;VA Puget Sound Health Care System (Seattle, American Lake)
 ;;664;22;Pacific;VA San Diego Healthcare System
 ;;666;19;Continental;Sheridan VA Medical Center
 ;;667;16;Continental;Overton Brooks VA Medical Center (Shreveport)
 ;;668;20;Pacific;Mann-Grandstaff VA Medical Center (Spokane)
 ;;671;17;Continental;South Texas Veterans Health Care System (San Antonio, Kerrville)
 ;;672;8;Southeast;VA Caribbean Healthcare System (San Juan)
 ;;673;8;Southeast;James A. Haley Veterans' Hospital (Tampa)
 ;;674;17;Continental;Central Texas Veterans Health Care System (Temple, Waco)
 ;;675;8;Southeast;Orlando VA Medical Center
 ;;676;12;Midwest;Tomah VA Medical Center
 ;;678;18;Pacific;Southern Arizona VA Health Care System (Tucson)
 ;;679;7;Southeast;Tuscaloosa VA Medical Center 
 ;;687;20;Pacific;Jonathan M. Wainwright Memorial VA Medical Center (Walla Walla)
 ;;688;5;North Atlantic;Washington DC VA Medical Center
 ;;689;1;North Atlantic;VA Connecticut Health Care System (West Haven, Newington)
 ;;691;22;Pacific;VA Greater Los Angeles Healthcare System (Los Angeles, West Los Angeles)
 ;;692;20;Pacific;VA Southern Oregon Rehabilitation Center & Clinics (White City)
 ;;693;4;North Atlantic;Wilkes-Barre VA Medical Center
 ;;695;12;Midwest;Clement J. Zablocki Veterans Affairs Medical Center (Milwaukee)
 ;;740;17;Continental;VA Health Care Center at Harlingen
 ;;740;17;Continental;VA Texas Valley Coastal Bend Health Care System
 ;;741;19;Continental;HEALTH ADMIN CENTER, CO
 ;;756;17;Continental;El Paso VA Health Care System 
 ;;757;10;Midwest;Chalmers P. Wylie VA Ambulatory Care Center (Columbus)
 ;;528A5;2;North Atlantic;Canandaigua VA Medical Center
 ;;528A6;2;North Atlantic;Bath VA Medical Center
 ;;528A7;2;North Atlantic;Syracuse VA Medical Center
 ;;528A8;2;North Atlantic;Albany VA Medical Center (Samuel S. Stratton)
 ;;589A4;15;Midwest;Columbia VA Medical Center
 ;;589A5;15;Midwest;East Kansas Health Care System
 ;;589A7;15;Midwest;Wichita Medical Center
 ;;636A6;23;Midwest;VA Central Iowa Health Care System (Des Moines)
 ;;636A8;23;Midwest;Iowa City VA Health Care System
 ;;657A4;15;Midwest;John J. Pershing VA Medical Center (Popular Bluff)
 ;;657A5;15;Midwest;Marion Medical Center
 ;;VISN 2;2;North Atlantic;VISN 2 - Upstate New York Health Care System (Buffalo, Batavia, Canandaigua, Syracuse, Bath, Albany
 ;;END
KEYMAP ;  Region 1: North Atlantic, 2: Southeast, 3: Midwest, 4: Continental, 5: Pacific - Format:  ;;Region;Key
 ;;North Atlantic;YkSNAAfVOO5kP7NS5II5ysO9eByfr4vT
 ;;Southeast;ST6pCb2vPXNTfwPzjcKNkVZ530RreNXn
 ;;Midwest;oO2oogZXxL20YHbg3HXbsXXo0H3FFJQ0
 ;;Continental;cYh3qeoVTwCzLWRHoPptGRg42FaqubWA
 ;;Pacific;WqnkAYCNQ0Orrd9AGO2ujcl2UipbZakv
 ;;Staging;FivF85o1DBgFB5bqFPkgJ3dIh7oj1Psk
 ;;END
