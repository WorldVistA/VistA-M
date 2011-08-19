XIPENV ;ALB/BRM,OIFO/SO - STANDARD ENVIRONMENT CHK FOR XIP PACKAGE;12:02 PM  8 Jul 2003
 ;;8.0;KERNEL;**292**;Jul 10, 1995
 ;
 ; This routine is executed from the top for the environment check
 ; portion of the install.
ENVCHK ; Environment check to ensure the STATE file has all of the
 ; necessary entries to properly point the 5.12 and 5.13 files to
 ; the appropriate entry.
 ;
 N TAG,DATA,SFIPS,ST,STATE,FIXST,OLDST,IEN5,DISPTXT
STCHK ; Check STATE(#5) for problems
 F TAG=1:1 Q:TAG=99999  I $T(@TAG)]"" D
 .S DATA=$P($T(@TAG),";;",2),ST=$P(DATA,"^",2)
 .S STATE=$P(DATA,"^"),SFIPS=$P(DATA,"^",3)
 .S IEN5=$O(^DIC(5,"C",ST,""))
 .S:'IEN5 IEN5=$O(^DIC(5,"B",STATE,""))
 .S:'IEN5 IEN5=$O(^DIC(5,"C",SFIPS,""))
 .Q:$P($G(^DIC(5,+IEN5,0)),"^",1,3)=DATA
 .S OLDSTATE=$P($G(^DIC(5,+IEN5,0)),"^",2) S:OLDSTATE="" OLDSTATE=0_"^"_ST
 .S FIXST(ST)=DATA,OLDST(OLDSTATE)=$P($G(^DIC(5,+IEN5,0)),"^",1,3)
 I '$D(FIXST) D MES^XPDUTL("  Your STATE(#5) file is fine.") Q
 S XPDQUIT=2
 D BMES^XPDUTL("  ******************************************************************")
 D MES^XPDUTL("    The following State file (#5) entries are missing or need editing.")
 D MES^XPDUTL("    If you uncomfortable using the instructions in the patch to make the")
 D MES^XPDUTL("    corrections, please log a NOIS for assistance in resolving this issue.")
 D BMES^XPDUTL("  ******************************************************************")
 D BMES^XPDUTL("  Your site shows the following:")
 D MES^XPDUTL("      ABBREVIATION    VA STATE CODE    STATE NAME")
 D MES^XPDUTL("      ------------    -------------    ----------")
 S ST="" F  S ST=$O(OLDST(ST)) Q:ST=""  D
 .S DISPTXT="      "_$J($P(OLDST(ST),"^",2),7)_"         "_$J($P(OLDST(ST),"^",3),7)_"          "_$P(OLDST(ST),"^")
 .D MES^XPDUTL(DISPTXT)
 D BMES^XPDUTL("  The below entries should be added and/or corrected as follows:")
 D MES^XPDUTL("      ABBREVIATION    VA STATE CODE    STATE NAME")
 D MES^XPDUTL("      ------------    -------------    ----------")
 S ST="" F  S ST=$O(FIXST(ST)) Q:ST=""  D
 .D MES^XPDUTL("      "_$J($P(FIXST(ST),"^",2),7)_"         "_$J($P(FIXST(ST),"^",3),7)_"          "_$P(FIXST(ST),"^"))
 ;
PTCHK ; Check 5.12 & 5.13 for unknown "PT" nodes
 ; IA# 4136
 I $D(^DD(5.12,0,"PT")) D
 . N FILE
 . S FILE=0
 . F  S FILE=$O(^DD(5.12,0,"PT",FILE)) Q:'FILE  D
 .. N FIELD
 .. S FIELD=0
 .. F  S FIELD=$O(^DD(5.12,0,"PT",FILE,FIELD)) Q:'FIELD  D
 ... N X
 ... S X="  File #: "_FILE_"  Field #: "_FIELD_" is Pointing To File # 5.12.  Please remove this dependency!"
 ... D MES^XPDUTL(X) S XPDQUIT=1
 ;
 ; IA# 4137
 N FILE
 S FILE=0
 F  S FILE=$O(^DD(5.13,0,"PT",FILE)) Q:'FILE  I FILE'=5.12 D
 . N FIELD
 . S FIELD=0
 . F  S FIELD=$O(^DD(5.13,0,"PT",FILE,FIELD)) Q:'FIELD  D
 .. N X
 .. S X="  File #: "_FILE_"  Field #: "_FIELD_" is Pointing To File # 5.13.  Please remove this dependency!"
 .. D MES^XPDUTL(X) S XPDQUIT=2
 I '$D(XPDQUIT) D
 . N X
 . S X="Your STATE(#5) file is fine.  No unknown ""PT"" where found.  Continuing the installation."
 . D MES^XPDUTL(X)
 ;
 ; End of Envirment Check
 Q
 ;
 ; **** Below Data is used to validate state file - do not modify ****
 ; The '^' pieces are as follows:
 ; $P(#1)=NAME, $P(#2)=ABBV, and $P(#3)=VA STATE CODE
1 ;;ALABAMA^AL^01
2 ;;ALASKA^AK^02
4 ;;ARIZONA^AZ^04
5 ;;ARKANSAS^AR^05
6 ;;CALIFORNIA^CA^06
8 ;;COLORADO^CO^08
9 ;;CONNECTICUT^CT^09
10 ;;DELAWARE^DE^10
11 ;;DISTRICT OF COLUMBIA^DC^11
12 ;;FLORIDA^FL^12
13 ;;GEORGIA^GA^13
15 ;;HAWAII^HI^15
16 ;;IDAHO^ID^16
17 ;;ILLINOIS^IL^17
18 ;;INDIANA^IN^18
19 ;;IOWA^IA^19
20 ;;KANSAS^KS^20
21 ;;KENTUCKY^KY^21
22 ;;LOUISIANA^LA^22
23 ;;MAINE^ME^23
24 ;;MARYLAND^MD^24
25 ;;MASSACHUSETTS^MA^25
26 ;;MICHIGAN^MI^26
27 ;;MINNESOTA^MN^27
28 ;;MISSISSIPPI^MS^28
29 ;;MISSOURI^MO^29
30 ;;MONTANA^MT^30
31 ;;NEBRASKA^NE^31
32 ;;NEVADA^NV^32
33 ;;NEW HAMPSHIRE^NH^33
34 ;;NEW JERSEY^NJ^34
35 ;;NEW MEXICO^NM^35
36 ;;NEW YORK^NY^36
37 ;;NORTH CAROLINA^NC^37
38 ;;NORTH DAKOTA^ND^38
39 ;;OHIO^OH^39
40 ;;OKLAHOMA^OK^40
41 ;;OREGON^OR^41
42 ;;PENNSYLVANIA^PA^42
44 ;;RHODE ISLAND^RI^44
45 ;;SOUTH CAROLINA^SC^45
46 ;;SOUTH DAKOTA^SD^46
47 ;;TENNESSEE^TN^47
48 ;;TEXAS^TX^48
49 ;;UTAH^UT^49
50 ;;VERMONT^VT^50
51 ;;VIRGINIA^VA^51
53 ;;WASHINGTON^WA^53
54 ;;WEST VIRGINIA^WV^54
55 ;;WISCONSIN^WI^55
56 ;;WYOMING^WY^56
60 ;;AMERICAN SAMOA^AS^60
64 ;;FEDERATED STATES OF MICRONESIA^FM^64
66 ;;GUAM^GU^66
68 ;;MARSHALL ISLANDS^MH^68
69 ;;NORTHERN MARIANA ISLANDS^MP^69
70 ;;PALAU^PW^70
72 ;;PUERTO RICO^PR^72
78 ;;VIRGIN ISLANDS^VI^78
85 ;;ARMED FORCES AMER (EXC CANADA)^AA^85
87 ;;ARMED FORCES AF,EU,ME,CA^AE^87
88 ;;ARMED FORCES PACIFIC^AP^88
99999 ;;LAST LINE
