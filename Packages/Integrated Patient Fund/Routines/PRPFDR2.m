PRPFDR2 ;BAYPINES/MJE  VPFS DATA MIGRATION ROUTINE 2 ;05/15/03
 ;;3.0;PATIENT FUNDS DIAG V5.9;**15**;JUNE 1, 1989
 ;ENTRY AT LINETAG ONLY
 Q
LEG ;ENTRY POINT FOR LEGACY SYSTEM
 D SETUP
 D SUM
 W !
 W !,"NOTE: In addition to the summary report there is an available detail"
 W !,"report, this report can be sent to any device or flat file if required."
 W !,""
 W !,">>>>> The detail diagnostic report will contain "_CNTERR(100)_" lines."
 W !,""
 W !,"If you still desire the detail report, then please input the name of the"
 W !,"device that the report will be sent to."
 W !,""
 W !,"If the detail report is not desired then input ""^"" at the device prompt and the detail report will not print."
 W !,""
 D REP
 K ^TMP("PRPF_DIAGX")
 D KILLIT^PRPFDR4
 Q
REP S (PFX,PFY,PFZ,PFNAME)=""
 S %ZIS("B")="",%ZIS("HFSMODE")="W" D ^%ZIS K XION R X:2
 I POP K ^TMP("PRPF_DIAGX") Q
 U IO
 D SUM
 F  S PFX=$O(^TMP("PRPF_DIAGX",$J,PFX)) Q:PFX=""  D
 .F  S PFY=$O(^TMP("PRPF_DIAGX",$J,PFX,PFY)) Q:PFY=""  D
 ..F  S PFZ=$O(^TMP("PRPF_DIAGX",$J,PFX,PFY,PFZ)) Q:PFZ=""  D
 ...S PFTEMP=^TMP("PRPF_DIAGX",$J,PFX,PFY,PFZ)
 ...W !,"STATION ID="_PFX_"^ERR#="_PFY_"^NAME="_PFZ_"^DESC="_$P(PFTEMP,"^",2)_"^VALUE=>"_$P(PFTEMP,"^",3)_"<"
 D ^%ZISC
 Q
SUM W !,"**************************************************************************"
 W !,"**      Patient Funds Diagnostic Summary      (version 5.9)             **"
 W !,"**************************************************************************"
 D NOW^%DTC S Y=% D DD^%DT
 W !,"Run Date: "_$P(Y,"@",1)_"  Run Time: "_$P(Y,"@",2),?72,"**"
 W !,"Total accounts processed = "_CNTREC,?72,"**"
 W !,"Total balance of accounts for migration = $"_$FN(CNTBAL,",",2),?72,"**"
 W !,"**************************************************************************"
 W !,"Err#    Field           Error                                        Total"
 W !," #      Name            Description                                  Count"
 W !,"**************************************************************************"
 W !," #1     NAME            Name is blank",?72,CNTERR(1)
 W !," #2     NAME            Name contains invalid data",?72,CNTERR(2)
 W !," #3     SSN             SSN is blank",?72,CNTERR(3)
 W !," #4     SSN             SSN contains invalid data",?72,CNTERR(4)
 W !," #5     SSN             SSN contains duplicate value",?72,CNTERR(5)
 W !," #6     SSN             SSN contains Pseudo SSN value",?72,CNTRPSU
 W !," #7     DOB             DOB is blank",?72,CNTERR(7)
 W !," #8     DOB             DOB contains invalid date",?72,CNTERR(8)
 W !," #9     WARD            Ward loc invalid length",?72,CNTERR(9)
 W !," #10    CLAIM           Claim # contains invalid data",?72,CNTERR(10)
 W !," #11    ZIP             Zipcode contains invalid data",?72,CNTERR(11)
 W !," #12    REGION OFFICE   Regional Office ID invalid data",?72,CNTERR(12)
 W !," #13    ICN             ICN Duplicate",?72,CNTERR(13)
 W !," #14    ICN             ICN unassigned or invalid",?72,CNTERR(14)
 W !," #15    PROVIDER AUTHR  Provider Name contains invalid data",?72,CNTERR(15)
 W !,"*#16    PROVID AUTH DT  Date of current restriction invalid date",?72,CNTERR(16)
 W !,"*#17    NO DEMO RECORD  No demographic record for account",?72,CNTERR(17)
 W !,"*#18    ACCOUNT STATUS  Account status not (A),I,Blank="_PRPFBC18,?72,CNTERR(18)
 W !,"*#19    PATIENT TYPE    Patient type not L,R,(U),X,Blank="_PRPFBC19,?72,CNTERR(19)
 W !,"*#20    PAT TYPE/PHY    Patient type L or R without Phy name",?72,CNTERR(20)
 W !,"*#21    PATIENT STATUS  Patient Status not A,R,C,N,(X),Blank="_PRPFBC21,?72,CNTERR(21)
 W !,"*#22    INDIGENT        Indigent status not (N),Y,Blank="_PRPFBC22,?72,CNTERR(22)
 W !,"*#23    APPORTIONEE $   Apportionee amount invalid or < $0 or > $99,999",?72,CNTERR(23)
 W !,"*#24    GUARDIAN $      Guardian amount invalid or < $0 or > $99,999",?72,CNTERR(24)
 W !,"*#25    INSTITUT AWARD  Institut award invalid or < $0 or > $99,999",?72,CNTERR(25)
 W !,"*#26    OTHER ASSETS    Other assets invalid or < $0 or > $99,999",?72,CNTERR(26)
 W !,"*#27    STORED BALANCE  Stored balance invalid or < $0 or > $99,999",?72,CNTERR(27)
 W !,"*#28    STORED PRIVATE  Stored private invalid or < $0 or > $99,999",?72,CNTERR(28)
 W !,"*#29    STORED GRATUIT  Stored gratuitous invalid or < $0 or > $99,999",?72,CNTERR(29)
 W !,"*#30    RESTRCT MONTH   Restricted Monthly invalid or < $0 or > $99,999",?72,CNTERR(30)
 W !,"*#31    RESTRCT WEEKLY  Restricted Weekly invalid or < $0 or > $99,999",?72,CNTERR(31)
 W !,"*#32    RESTRCT AMT ER  Restrict Mnthly amount < (5X) weekly amt",?72,CNTERR(32)
 W !,"*#33    RESTRCT AMT ER  Restrict Mnthly amount < weekly amt",?72,CNTERR(33)
 W !,"*#34    MINIMUM BAL     Minimum balance #1 invalid or < $0 or > $99,999",?72,CNTERR(34)
 W !,"*#35    MAXIMUM BAL     Maximum balance #1 invalid or < $0 or > $99,999",?72,CNTERR(35)
 W !,"*#36    NO BALANCE REC  Balance record missing for account",?72,CNTERR(36)
 W !,"*#37    INCOME PAYEE    Income payee blank, Income source present",?72,CNTERR(37)
 W !,"*#38    INCOME AMOUNT   Income amount error, Income source present",?72,CNTERR(38)
 W !,"*#39    INCOME AMOUNT   Income amount < $1 or > $99,999",?72,CNTERR(39)
 W !,"*#40    INCOME FREQCY   Income frequency not D,W,M,Y,X,V,O,Blank="_PRPFBC40,?72,CNTERR(40)
 W !,"*#41    STATION ID      Station ID blank or unassigned",?72,CNTERR(41)
 W !," #42    STATION ID      Station ID invalid",?72,CNTERR(42)
 W !,"*#43    SUSPENSE DATE   Suspense date has invalid date",?72,CNTERR(43)
 W !,"*#44    SUSPENSE ID     Suspense ID has Invalid data",?72,CNTERR(44)
 W !,"*#45    SUSPENSE TEXT   Suspense text is < 1 or > 255 characters",?72,CNTERR(45)
 W !,"*#46    DEFERRED TRANS  There are "_PRPFDEFR_" deferred transactions",?72,PRPFDEFR
 W !,"*#47    TRANSACTION REC Transaction record missing, blank or ID invalid",?72,CNTERR(47)
 W !,"*#48    PATIENT NAME    Patient name does not match deferred trans",?72,CNTERR(48)
 W !,"*#49    PATIENT TRANS # Patient transaction # invalid",?72,CNTERR(49)
 W !,"*#50    DEFR AMOUNT     Deferred amount invalid",?72,CNTERR(50)
 W !,"*#51    TRANSACTN DATE  Transaction date Invalid",?72,CNTERR(51)
 W !,"*#52    DT TRAN ENTD    Date transaction entered Invalid",?72,CNTERR(52)
 W !,"*#53    REFERENCE       Reference Invalid < 1 or > 10 in length",?72,CNTERR(53)
 W !,"*#54    DEPOSIT/WTHDRWL Deposit/Withdrawal status Invalid",?72,CNTERR(54)
 W !,"*#55    CASH/CHECK/OTR  Cash/Check/Other status Invalid",?72,CNTERR(55)
 W !,"*#56    SOURCE          Transaction source invalid",?72,CNTERR(56)
 W !,"*#57    FORM            Form does not match",?72,CNTERR(57)
 W !,"*#58    PRVT SOURCE AMT Private source amount invalid or < 0 or > 99999",?72,CNTERR(58)
 W !,"*#59    GRATUITOUS AMT  Gratuitous amount invalid or < 0 or > 99999",?72,CNTERR(59)
 W !,"*#60    PFUNDS CLERK    PFunds clerk invalid",?72,CNTERR(60)
 W !,"**************************************************************************"
 Q
SETUP ;SETUP PARAMS GET DATA
 K ^TMP("PRPF_DIAGX")
 S ^TMP("PRPF_DIAGX",$J,0)=DTIME_"^"_"DTIME"_"^"_"PRPF MIGRATION DIAGNOSTIC TEMP DATA"
 S (PRPFDEFR,PRPFBBAL,PRPFBDMO,PRPFHLD1,PRPFHLD2,PRPFHLD3,PRPFHLD4,CNTBAL,CNTREC,CNTRPSU,PFG,PFSTDBAL)=0
 S (PRPFBC18,PRPFBC19,PRPFBC21,PRPFBC22,PRPFBC40)=0
 F I=1:1:100 D
 .S CNTERR(I)=0
 F  S PRPFHLD1=$O(^PRPF(470,PRPFHLD1)) Q:'PRPFHLD1  D
 .S PFG=PFG+1 I PFG=100 W "." S PFG=0
 .S ND=""
 .S CNTREC=CNTREC+1
 .D:$G(^PRPF(470,PRPFHLD1,0))'="" COMPU
 .I $D(^PRPF(470,PRPFHLD1,12)) I $G(^PRPF(470,PRPFHLD1,12))'="" D
 ..I $D(^DIC(4,^PRPF(470,PRPFHLD1,12),99)) I $P(^DIC(4,^PRPF(470,PRPFHLD1,12),99),"^",1)'="" D
 ...S PFSTAID=^PRPF(470,PRPFHLD1,12)
 ...D NODE12^PRPFDR1
 ..I $D(^DIC(4,^PRPF(470,PRPFHLD1,12),99)) I $P(^DIC(4,^PRPF(470,PRPFHLD1,12),99),"^",1)="" D
 ...S PFSTAID="ERRBADID1"
 ...D NODE12^PRPFDR1
 ..I '$D(^DIC(4,^PRPF(470,PRPFHLD1,12),99)) D
 ...S PFSTAID="ERRBADID"
 ...D NODE12^PRPFDR1
 .I '$D(^PRPF(470,PRPFHLD1,12)) S PFSTAID="ERRNOID" D NODE12X^PRPFDR1
 .I $D(^PRPF(470,PRPFHLD1,12)) I $G(^PRPF(470,PRPFHLD1,12))="" D
 ..S PFSTAID="ERRNOID1"
 ..D NODE12X^PRPFDR1
 .D:$G(^PRPF(470,PRPFHLD1,0))'="" NODE0^PRPFDR5
 .D:$G(^PRPF(470,PRPFHLD1,0))="" NODE0X^PRPFDR5
 .D:$G(^PRPF(470,PRPFHLD1,1))'="" NODE1^PRPFDR4
 .D:$G(^PRPF(470,PRPFHLD1,1))="" NODE1X^PRPFDR4
 .D:$G(^PRPF(470,PRPFHLD1,2))'="" NODE2^PRPFDR4
 .D:$O(^PRPF(470,PRPFHLD1,4,0))>0 NODE4^PRPFDR1
 .D:$O(^PRPF(470,PRPFHLD1,5,0))>0 NODE5^PRPFDR1
 .D:$O(^PRPF(470,PRPFHLD1,6,0))>0 NODE6^PRPFDR4
 Q
 ;***************************************************************
COMPU ; SPECIFIC PATIENT INFO LOOKUP
 S PFNAME=$P($G(^DPT(PRPFHLD1,0)),"^",1)
 S PFSSN=$P($G(^DPT(PRPFHLD1,0)),"^",9)
 I PFNAME="" I PFSSN'="" S PFNAME="NAME-MISSING-SSN#"_PFSSN
 I PFNAME="" I PFSSN="" S PFNAME="NAME-MISSING-NO-SSN-IEN#"_PRPFHLD1
 S PFDOB=$P($G(^DPT(PRPFHLD1,0)),"^",3)
 S PFWARD=$P($G(^DPT(PRPFHLD1,.1)),"^",1)
 S PFCLAIM=$P($G(^DPT(PRPFHLD1,.31)),"^",3)
 S PFADDR1=$P($G(^DPT(PRPFHLD1,.11)),"^",1)
 S PFADDR2=$P($G(^DPT(PRPFHLD1,.11)),"^",2)
 S PFADDR3=$P($G(^DPT(PRPFHLD1,.11)),"^",3)
 S PFCITY=$P($G(^DPT(PRPFHLD1,.11)),"^",4)
 S PFSTATE=$P($G(^DPT(PRPFHLD1,.11)),"^",5)
 S PFZIP=$P($G(^DPT(PRPFHLD1,.11)),"^",6)
 S PFSITE=$P($$SITE^VASITE(),"^",3)
 S:PFSITE="" PFSITE="###"
 S PFAUTH=$P(^PRPF(470,PRPFHLD1,0),"^",13)
 Q
