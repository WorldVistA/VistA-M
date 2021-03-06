IB2P567A ;ALB/RRA UPDATE PAYER FILE- ;06/07/2016
 ;;2.0;INTEGRATED BILLING;**567**;21-MAR-94;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Compare local PAYER file with national and
 ; update missing entries
 Q
 ;
 ;
PAYER ;PAYER NAME^VA NAT ID^EDI ID NUM-PROF^EDI ID NUM-INST^NAT ACTIVE^IDENT REQ SUB ID^FUT SERV DAYS^PAST SERV DAYS^AUTO-ACCEPT
 ;;MAGELLAN BEHAVIORAL HEALTH^VA1984^1260^12X27^Y^Y^0^0^Y
 ;;MAGNACARE^VA2066^11303^11303^Y^Y^9999^9999^N
 ;;MAIL HANDLERS BENEFIT PLAN^VA86^62413^62413^Y^N^90^545^Y
 ;;MANAGED CARE OF AMERICA^VA2273^25168^25168^Y^N^9999^9999^N
 ;;MAPFRE LIFE PUERTO RICO^VA2640^L0160^L0160^Y^Y^0^0^N
 ;;MEDBEN (NEWARK OH)^VA1944^74323^74323^Y^N^9999^9999^N
 ;;MEDCOST BENEFIT SERVICES^VA1053^56205^56205^Y^Y^9999^9999^N
 ;;MEDICA^VA171^94265^94265^Y^Y^31^365^Y
 ;;MEDICAL ASSOCIATES HEALTH PLAN^VA2521^MAHC1^MAHC1^Y^N^0^0^N
 ;;MEDICAL CARD SYSTEM^VA1705^L0170^L0170^Y^Y^9999^9999^Y
 ;;MEDICAL MUTUAL OF OHIO (MMO)^VA100^29076^29076^Y^N^0^0^Y
 ;;MEDICO INSURANCE COMPANY^VA1784^23160^23160^Y^N^9999^9999^Y
 ;;MEDIGOLD HEALTH PLANS^VA2664^95655^95655^Y^Y^30^365^N
 ;;MEGALIFE (OKLAHOMA CITY)^VA136^59227^59227^Y^Y^9999^9999^N
 ;;MERCYCARE HEALTH PLANS (WI)^VA2743^39114^39114^Y^N^0^0^N
 ;;MERITAIN HEALTH-AGENCY SERVICES^VA1806^64158^64158^Y^Y^9999^9999^Y
 ;;MHNET BEHAVIORAL HEALTH^VA1725^74289^74289^Y^N^90^545^Y
 ;;MMSI (MAYO)^VA348^41154^41154^Y^Y^9999^9999^Y
 ;;MODA HEALTH^VA2417^13350^13350^Y^N^30^365^Y
 ;;MOLINA HEALTHCARE OF CALIFORNIA^VA101^38333^38333^Y^Y^9999^9999^Y
 ;;MOLINA HEALTHCARE OF FLORIDA^VA827^51062^51062^Y^Y^9999^9999^N
 ;;MOLINA HEALTHCARE OF ILLINOIS^VA2209^20934^20934^Y^Y^9999^9999^N
 ;;MOLINA HEALTHCARE OF MICHIGAN^VA102^38334^38334^Y^Y^9999^9999^N
 ;;MOLINA HEALTHCARE OF NEW MEXICO^VA165^9824^^Y^Y^31^365^N
 ;;MOLINA HEALTHCARE OF OHIO^VA244^20149^20149^Y^Y^9999^9999^Y
 ;;MOLINA HEALTHCARE OF SOUTH CAROLINA^VA2210^46299^46299^Y^Y^9999^9999^N
 ;;MOLINA HEALTHCARE OF TEXAS^VA465^^^Y^Y^9999^9999^N
 ;;MOLINA HEALTHCARE OF UTAH^VA103^SX109^^Y^Y^9999^9999^N
 ;;MOLINA HEALTHCARE OF WASHINGTON^VA104^38336^38336^Y^Y^9999^9999^Y
 ;;MOLINA HEALTHCARE OF WISCONSIN^VA2211^ABRI1^ABRI1^Y^Y^9999^9999^N
 ;;MUNICIPAL HEALTH BENEFIT FUND^VA2437^81883^81883^Y^N^0^0^N
 ;;MUTUAL HEALTH SERVICES^VA2561^34192^34192^Y^N^30^547^N
 ;;MUTUAL OF OMAHA^VA466^71412^71412^Y^Y^9999^9999^Y
 ;;MVP HEALTH CARE^VA180^38224^38224^Y^Y^9999^9999^Y
 ;;MVP HEALTH CARE (NEW YORK)^VA2312^14165^14165^Y^Y^0^0^Y
 ;;NALC - NATL ASSN OF LTR CARRIERS^VA64^53011^53011^Y^Y^0^0^Y
 ;;NATIONAL TELECOMMUNICATIONS CO. ASSOC.(NTCA)^VA2006^52120^52120^Y^Y^0^0^N
 ;;NBF 1199 NATIONAL BENEFIT FUND^VA2247^13162^13162^Y^Y^9999^9999^N
 ;;NEIGHBORHOOD HEALTH PARTNERSHIP^VA166^96107^96107^Y^Y^0^365^N
 ;;NETWORK HEALTH PLAN^VA2292^39144^39144^Y^N^9999^9999^N
 ;;NEW ERA LIFE INSURANCE COMPANY^VA2317^75281^75281^Y^N^0^0^N
 ;;NOVA HEALTHCARE ADMINISTRATORS^VA1445^16644^16644^Y^N^31^9999^N
 ;;NOVASYS HEALTH^VA1054^71080^71080^Y^Y^9999^9999^N
 ;;OPTIMA/SENTARA^VA1485^54154^54154^Y^Y^31^9999^N
 ;;OXFORD HEALTH PLANS (UHC)^VA22^6111^6111^Y^N^31^365^Y
 ;;PACIFIC SOURCE HEALTH PLAN^VA965^93029^93029^Y^N^60^365^Y
 ;;PACIFICARE (PPO)^VA1055^95999^95999^Y^Y^9999^9999^N
 ;;PACIFICARE OF NEVADA (HMO)^VA1056^^^Y^Y^9999^9999^Y
 ;;PAN-AMERICAN LIFE INSURANCE^VA2663^4218^4218^Y^N^0^0^N
 ;;PANAM LIFE PUERTO RICO (PALIC)^VA1826^L0180^L0180^Y^Y^9999^9999^Y
 ;;PARAMOUNT HEALTH^VA2186^SX158^SX158^Y^Y^30^365^N
 ;;PHCS SAVILITY PAYERS^VA864^13306^13306^Y^Y^9999^9999^N
 ;;PHYSICIANS HEALTH PLAN OF NORTHERN IN^VA2294^12399^12399^Y^Y^9999^30^N
 ;;PHYSICIANS MUTUAL INSURANCE CO^VA404^47027^47027^Y^Y^9999^9999^Y
 ;;PIEDMONT WELLSTAR HEALTH PLANS^VA2519^251PD^251PD^Y^N^9999^9999^N
 ;;PITTMAN AND ASSOCIATES^VA606^37224^37224^Y^Y^9999^9999^Y
 ;;PLANNED ADMINISTRATORS INC^VA2106^37287^37287^Y^N^9999^9999^N
 ;;PREFERRED ONE^VA133^^^Y^N^9999^9999^Y
 ;;PREMIER HEALTH^VA2520^251PR^251PR^Y^N^0^0^N
 ;;PRINCIPAL FIN GRP - NIPPON LIFE^VA70^81264^81264^Y^Y^9999^9999^Y
 ;;PRIORITY HEALTH^VA1124^38217^38217^Y^Y^9999^9999^Y
 ;;PROFESSIONAL BENEFITS ADMIN^VA225^36331^36331^Y^Y^0^0^Y
 ;;PROVIDENCE HEALTH PLAN^VA486^SX133^^Y^N^31^547^Y
 ;;PUBLIC EMPLOYEES HEALTH PLAN (PEHP)^VA2207^12X36^SX106 ^Y^Y^0^0^N
 ;;PURITAN LIFE INSURANCE^VA2032^75300^75300^Y^Y^0^0^N
 ;;QUALCARE^VA2313^23342^23342^Y^N^9999^365^N
 ;;RELIANCE STANDARD LIFE INS CO^VA158^36088^36088^Y^Y^9999^9999^N
 ;;RESERVE NATIONAL INSURANCE COMPANY^VA2600^73066^73066^Y^N^0^365^N
 ;;ROCKY MOUNTAIN HEALTH PLAN^VA487^SX141^84065^Y^N^31^365^N
 ;;ROYAL NEIGHBORS OF AMERICA^VA2033^75300^75300^Y^Y^0^0^N
 ;;S AND S HEALTHCARE STRATEGIES^VA2208^31441^31441^Y^N^0^0^N
 ;;SCOTT & WHITE HEALTH PLAN^VA1057^TH002^12T05^Y^N^9999^9999^Y
 ;;SECURE HEALTH PLANS OF GEORGIA^VA2206^28530^28530^Y^N^0^365^N
 ;;SECURITY HEALTH PLAN^VA2477^39045^39045^Y^Y^0^0^Y
 ;;SELECT HEALTH UTAH^VA1464^SX107^12X37^Y^Y^9999^9999^N
 ;;SHENANDOAH LIFE INSURANCE^VA2034^54307^^Y^Y^0^0^N
 ;;SIERRA HEALTH SERVICES^VA2416^76342^76342^Y^Y^30^547^Y
 ;;SIGNIFICA BENEFIT SERVICES^VA13^23250^23250^Y^Y^9999^9999^N
 ;;STANDARD INS CO OF NEW YORK^VA161^13411^13411^Y^Y^9999^9999^N
 ;;STANDARD LIFE AND ACCIDENT INSURANCE COMPANY^VA2665^73099^73099^Y^N^0^0^N
 ;;STAR - HRG^VA106^59225^^Y^Y^9999^9999^Y
 ;;STATE FARM^VA1764^31053^31053^Y^Y^9999^9999^N
 ;;STATE MUTUAL MED SUPP^VA2035^75300^75300^Y^Y^0^0^N
 ;;STAYWELL^VA2252^14163^14163^Y^N^0^365^N
 ;;STERLING INVESTORS LIFE INSURANCE^VA2036^75300^75300^Y^Y^0^0^N
 ;;STUDENT INSURANCE^VA179^^^Y^Y^9999^9999^N
 ;;SUMMACARE HEALTH PLAN^VA972^95202^95202^Y^N^60^365^Y
 ;;TEXANPLUS NORTH TEXAS AREA^VA1585^13185^13185^Y^Y^9999^9999^N
 ;;TEXANPLUS SOUTHEAST TEXAS AREA^VA1584^76045^76045^Y^Y^9999^9999^N
 ;;TIME INSURANCE COMPANY (FIC)^VA87^39065^39065^Y^Y^9999^9999^Y
 ;;TMG NETWORK HEALTH INSURANCE CORP^VA2476^77076^77076^Y^N^0^0^Y
 ;;TODAYS OPTION^VA1244^48055^48055^Y^Y^9999^9999^Y
 ;;TRICARE^VA63^57106^57106^Y^Y^0^0^Y
 ;;TRICARE FOR LIFE^VA2269^SX176^12X43^Y^Y^9999^9999^Y
 ;;TRICARE OVERSEAS^VA2270^SX163^12X46^Y^Y^9999^9999^N
 ;;TRUSTMARK INSURANCE^VA117^61425^61425^Y^Y^9999^9999^Y
 ;;TUFTS HEALTH PLAN^VA24^^^Y^Y^31^9999^Y
 ;;UCARE OF MINNESOTA^VA2336^SX178^12X50^Y^Y^60^365^Y
 ;;UMR (WAUSAU)^VA1184^39026^39026^Y^N^9999^9999^Y
 ;;UMWA HEALTH AND RETIREMENT FUNDS^VA2581^52180^52180^Y^Y^9999^9999^N
 ;;UNICARE^VA844^80314^80314^Y^Y^31^545^Y
 ;;UNION PACIFIC RAILROAD EMP HLTH SYS^VA1264^87042^87042^Y^N^9999^9999^Y
 ;;UNION SECURITY INSURANCE CO (FBIC)^VA88^70408^70408^Y^Y^9999^9999^Y
 ;;UNITED AMERICAN INSURANCE COMPANY^VA2248^SX175^SX175^Y^N^9999^9999^Y
 ;;UNITED HEALTH CARE^VA25^87726^87726^Y^Y^31^547^Y
 ;;UNITED HEALTH PLAN RIVER VALLEY^VA1224^95378^95378^Y^N^31^365^Y
 ;;UNITY HEALTH PLANS^VA2272^66705^66705^Y^Y^60^365^N
 ;;UNIVERA^VA1444^^12X18^Y^Y^31^366^N
 ;;UNIVERSITY OF MISSOURIE^VA724^87043^87043^Y^N^90^545^N
 ;;UNIVERSITY OF UTAH HEALTH PLAN^VA2249^SX155^SX155^Y^Y^0^0^N
 ;;UPMC HEALTH PLAN (TRISTATE)^VA1058^23281^23281^Y^N^9999^9999^Y
 ;;USAA-MEDICARE SUPPLEMENTAL^VA386^74095^74095^Y^N^0^0^Y
 ;;VIVA HEALTH INC^VA2436^63114^63114^Y^N^9999^9999^N
 ;;WASHINGTON NATIONAL^VA2498^11285^11285^Y^Y^30^365^N
 ;;WEA TRUST^VA1484^39151^39151^Y^Y^9999^9999^N
 ;;WEB-TPA^VA1424^75261^75261^Y^N^9999^9999^Y
 ;;WELLCARE HEALTH PLANS^VA1344^14163^14163^Y^N^0^365^Y
 ;;WELLS FARGO THIRD PARTY(CHIP PEIA)^VA121^87815^87815^Y^Y^31^365^Y
 ;;WESTERN HEALTH ADVANTAGE^VA495^68039^68039^Y^N^0^365^N
 ;;WPS HEALTH INSURANCE^VA2275^SX022^12X29^Y^Y^9999^9999^Y
 ;;ACORDIA NATIONAL-MOHWK/HCKRY SPRGS^VA1045^^^N^N^9999^9999^N
 ;;AMC - HEALTH FUTURE^VA108^30946^^N^Y^9999^9999^N
 ;;AMC - MESA MENTAL HEALTH^VA128^85035^85035^N^Y^9999^9999^N
 ;;AMC - POLY AMERICA^VA72^32680^32680^N^Y^9999^9999^N
 ;;AMC - TOUCHSTONE^VA73^13402^13402^N^Y^9999^9999^N
 ;;AMC -AMERICAN GENERAL LIFE & ACCDNT^VA71^62030^62030^N^Y^9999^9999^Y
 ;;AMC-ALASKA ELEC HEALTH AND WLFR FND^VA127^92600^92600^N^Y^9999^9999^N
 ;;AMERICAN COMMUNITY MUTUAL^VA184^60305^60305^N^N^9999^9999^Y
 ;;ARIZONA PHYSICIANS IPA (APIPA)^VA122^^^N^Y^31^365^N
 ;;BCBS PUERTO RICO (TRIPLE-S)^VA1704^SB980^12B48^N^Y^9999^9999^Y
 ;;BEST CHOICE HEALTH PLAN^VA968^75278^75278^N^Y^9999^9999^N
 ;;BRAVO HEALTH INC.^VA506^52192^52192^N^Y^9999^9999^N
 ;;CARESOURCE HEALTH^VA496^31114^37311^N^Y^31^365^N
 ;;CARITEN HEALTHCARE^VA118^62073^62073^N^Y^9999^9999^Y
 ;;CARPENTERS HEALTH AND WELFARE^VA1324^25125^25125^N^N^9999^9999^Y
 ;;CENTRAL RESERVE INSURANCE^VA624^34097^34097^N^N^9999^9999^N
 ;;CHA HEALTH (KENTUCKY)^VA544^23171^23171^N^N^31^365^N
 ;;CHCCARES-SOUTH CAROLINA^VA664^25151^25151^N^N^90^545^N
 ;;CIGNA NATIONAL^VA11^62308^62308^N^Y^9999^9999^N
 ;;CIGNA VIRGINIA^VA12^^^N^Y^9999^9999^N
 ;;CIMARRON COMMERCIAL^VA137^TH058^12T13^N^Y^9999^365^N
 ;;COLUMBIA UNITED PROVIDERS^VA967^91162^91162^N^Y^60^365^Y
 ;;COMMUNITY HEALTHPLAN OF WASHINGTON^VA824^SB613^12T30^N^N^9999^9999^N
 ;;CONTINENTAL GENERAL INSURANCE^VA625^71404^71404^N^N^9999^9999^N
 ;;CORESOURCE (AZ MN)^VA76^41045^41045^N^Y^9999^9999^N
 ;;CORESOURCE (NC IN)^VA79^35180^35180^N^Y^9999^9999^N
 ;;CORPORATE BENEFIT SERVICE^VA1048^41124^41124^N^Y^9999^9999^N
 ;;COVENTRY ADVANTRA FREEDOM^VA471^25152^25152^N^N^90^545^N
 ;;COVENTRY HEALTH CARE CARENET^VA34^25142^25142^N^N^88^545^N
 ;;COVENTRY HEALTH CARE DELAWARE CARE^VA35^^^N^N^88^545^N
 ;;COVENTRY HEALTH CARE KANSAS-WICHITA^VA38^25134^25134^N^N^90^545^N
 ;;COVENTRY HEALTH CARE OF ST. LOUIS^VA44^^^N^N^88^545^Y
 ;;COVENTRY HEALTH CARE OF USA (HCUSA)^VA45^25143^25143^N^N^90^545^N
 ;;DIRECTORS GUILD^VA92^23706^23706^N^Y^9999^9999^N
 ;;ECOMPPO (CONSOLIDATED RAILROAD)^VA81^75284^75284^N^Y^9999^9999^N
 ;;ECOMPPO (LINN COUNTY)^VA82^75283^75283^N^Y^9999^9999^N
 ;;ELDER HEALTHCARE^VA504^^^N^N^9999^9999^N
 ;;FALLON HEALTH PLAN^VA83^SX072^22254^N^Y^9999^9999^N
 ;;FAMILY HEALTH SYSTEMS (COMMERCIAL)^VA14^39167^39167^N^N^365^365^N
 ;;FIRST GUARD^VA130^90060^90060^N^Y^9999^9999^N
 ;;GERBER LIFE INSURANCE^VA2027^71412^71412^N^Y^0^0^N
 ;;GILSBAR^VA1204^7205^7205^N^Y^9999^9999^Y
 ;;GROUP BENEFITS ADMINISTRATORS^VA138^37283^37283^N^Y^9999^9999^N
 ;;HEALTH ALLIANCE MEDICAL PLANS (HAP)^VA2226^77950^77950^N^N^0^9999^N
 ;;HEALTH CHOICE OF MEMPHIS^VA15^^^N^N^9999^9999^N
 ;;HEALTH NET OF NORTHEAST & AZ^VA95^38309^6108^N^Y^9999^9999^N
 ;;HEALTH PLAN OF NEW YORK (VYTRA)^VA605^22264^22264^N^N^9999^9999^Y
 ;;HEALTHCARE INC. (PROMINA)^VA36^25145^25145^N^Y^90^545^N
 ;;HEALTHMARKETS - MEGA LIFE AND HEALTH^VA96^59221^59221^N^N^9999^9999^Y
 ;;HEALTHMARKETS - MID-WEST NATIONAL LIFE^VA97^59224^59224^N^N^9999^9999^Y
 ;;HEALTHMARKETS - TRANSAMERICA LIFE^VA99^59222^59222^N^Y^9999^9999^N
 ;;HEALTHMARKETS-CHESAPEAKE NATIONAL^VA98^59223^59223^N^N^9999^9999^N
 ;;HEALTHNET OF CALIFORNIA^VA124^95570^95568^N^Y^31^365^N
 ;;HEALTHNET OF OREGON^VA125^95567^95567^N^Y^31^365^N
 ;;HEARTLAND NATIONAL LIFE^VA2028^87012^87012^N^Y^0^0^N
 ;;INLAND EMPIRE HEALTH^VA497^IEHP1^^N^Y^31^365^N
 ;;INTER VALLEY HEALTH PLAN^VA498^^^N^Y^31^365^N
 ;;JACKSON MEMORIAL HSPTL HEALTH PLAN^VA499^^^N^Y^31^365^N
 ;;JEFFERSON PILOT^VA186^^^N^Y^9999^9999^N
 ;;JP FARLEY CORPORATION^VA174^34136^34136^N^Y^9999^9999^Y
 ;;KAISER FDN HEALTHPLAN- MID-ATLANTIC^VA111^52095^52095^N^N^9999^1095^Y
 ;;KAISER FDN HEALTHPLAN- OHIO^VA113^^^N^Y^9999^9999^Y
 ;;LUMENOS^VA164^54195^54195^N^Y^9999^9999^N
 ;;MAMSI HEALTH PLAN^VA172^52148^52148^N^Y^9999^9999^Y
 ;;MANAGED HEALTH NETWORK^VA2315^22771^22771^N^N^9999^9999^N
 ;;MARICOPA COUNTY TOBACCO PROGRAM^VA500^^^N^Y^31^365^N
 ;;MASSACHUSETTS MEDICAID^VA1144^SKMA0^12K14^N^N^31^395^Y
 ;;MEDICARE TWO WNR^VA1684^SMTX1^12M61^N^Y^9999^9999^Y
 ;;MEDICARE WNR^VA1084^SMTX1^12M61^N^Y^9999^9999^Y
 ;;MEMORIAL CARE TPA^VA484^^^N^Y^31^365^N
 ;;METROPOLITAN HEALTH PLAN (MHP)^VA206^10850^10850^N^Y^9999^9999^Y
 ;;MISSISSIPPI ADMIN SERVICES^VA224^^^N^Y^9999^9999^N
 ;;MOLINA HEALTHCARE OF INDIANA^VA245^^^N^Y^9999^9999^N
 ;;MS STATE EMPLOYEES TCHRS HLTH PLAN^VA505^SB731^^N^Y^9999^9999^N
 ;;NATIONWIDE HEALTH PLANS^VA21^31417^^N^N^9999^9999^Y
 ;;OMNICARE^VA119^25150^25150^N^N^90^545^N
 ;;OPTUM HEALTH BEHAVIORAL (OHB)^VA2480^87726^87726^N^N^9999^9999^N
 ;;PACIFICARE OF ARIZONA (HMO)^VA134^95964^95964^N^Y^31^365^Y
 ;;PACIFICARE OF CALIFORNIA (HMO POS)^VA26^95959^95959^N^Y^9999^9999^N
 ;;PACIFICARE OF COLORADO (HMO)^VA135^95962^95962^N^Y^31^365^Y
 ;;PACIFICARE OF OKLAHOMA  (HMO POS)^VA27^95973^95973^N^Y^9999^9999^N
 ;;PACIFICARE OF OREGON  (HMO POS)^VA28^95975^95975^N^Y^9999^9999^N
 ;;PACIFICARE OF TEXAS (HMO POS)^VA29^95969^95969^N^Y^9999^9999^N
 ;;PACIFICARE OF WASHINGTON (HMO POS)^VA30^95977^95977^N^Y^9999^9999^Y
 ;;PASSPORT HEALTH PLAN^VA644^61129^61129^N^N^9999^365^N
 ;;PHOENIX HEALTH PLAN^VA485^SX146^3440^N^Y^31^365^N
 ;;PLAN DE SALUD HOSPITAL MENONITA^VA1827^L0190^L0190^N^Y^9999^9999^Y
 ;;PREFERRED HEALTH SYSTEMS^VA105^60110^^N^Y^9999^9999^N
 ;;PRIMEWEST HEALTH^VA1104^61604^61604^N^N^9999^9999^Y
 ;;PRINCIPAL FIN GRP - PRINCIPAL LIFE^VA23^61271^61271^N^Y^9999^9999^Y
 ;;SAN FRANCISCO HEALTH PLAN^VA488^^^N^Y^31^365^N
 ;;SAN JOAQUIN HEALTH PLAN^VA489^68035^68035^N^Y^31^365^N
 ;;SANFORD HEALTH PLAN^VA1384^91184^91184^N^Y^9999^9999^Y
 ;;SENIOR CARE ACTION NTWK (SCAN) HMO^VA490^^^N^Y^31^365^N
 ;;SRT ADMINISTRATORS, INC.^VA175^^^N^Y^9999^9999^N
 ;;STANDARD INS CO^VA160^93024^93024^N^Y^9999^9999^N
 ;;STANISLAUS COUNTY MIA PROGRAM^VA491^^^N^Y^31^365^N
 ;;SUPERIOR ADMINISTRATORS, INC.^VA176^23218^23218^N^Y^9999^9999^N
 ;;TEXAS CHIP^VA265^^^N^N^9999^9999^N
 ;;TLC FAMILY (MEMPHIS MANAGED CARE)^VA492^36193^36193^N^Y^31^365^N
 ;;TOTAL HEALTH CHOICE^VA107^^^N^Y^9999^9999^N
 ;;TOTAL HEALTHCARE^VA120^^^N^Y^9999^9999^N
 ;;UNDERWRITERS, SAFETY & CLAIMS^VA177^^^N^Y^9999^9999^Y
 ;;UNIVERSAL CARE OF CALIFORNIA^VA493^33001^33001^N^Y^31^365^N
 ;;UNIVERSITY FAMILY CARE^VA494^SX148^^N^Y^31^365^N
 ;;VERMONT MEDICAID^VA1164^SKVT0^12K26^N^Y^9999^9999^Y
 ;;VISTA (MCD, FHK, LTC)^VA904^55248^55248^N^N^90^545^N
 ;;WOODS & GROOMS BENEFIT SERVICES^VA178^^^N^Y^9999^9999^N
 ;;WORLD INSURANCE (ARIC)^VA183^75276^75276^N^N^9999^9999^Y
 ;;WRITERS GUILD^VA93^23710^23710^N^Y^9999^9999^Y
 ;;EXIT
