PRSDEU01 ;HISC/GWB-PAID EDIT AND UPDATE DOWNLOAD RECORD 1 LAYOUT ;7/7/93  14:16
 ;;4.0;PAID;;Sep 21, 1995
 F CC=1:1 S GRP=$T(@CC) Q:GRP=""  S GRPVAL=$P(RCD,":",CC) I GRPVAL'="" S GNUM=$P(GRP,";",4),LTH=$P(GRP,";",5),PIC=$P(GRP,";",6) D:PIC=9 PIC9^PRSDUTIL F EE=1:1:GNUM S FLD=$T(@CC+EE) D EPTSET^PRSDSET
 Q
RECORD ;;Record 1;9
 ;;
1 ;;Group 1;3;13;X
 ;;MXSTANO;STATION NUMBER;1;3;0;7;;;;6
 ;;MXSSN;SSN;4;12;0;9;;;;8
 ;;MXSSNSUB;SSN SUFFIX;13;13;;;;;;
 ;;
2 ;;Group 2;7;35;X
 ;;MXNAME;EMPLOYEE NAME;1;27;0;1;S NAME450=$P(^PRSPC(IEN,0),"^",1) S:NAME450'=DATA ^TMP($J,"PRSNC",DATA,SSN)="old name: "_NAME450 K NAME450;;;.01
 ;;MXTITLE;SEX;28;28;0;32;;;;31
 ;;MXSUPLEV;SUPERVISORY LEVEL;29;29;0;40;;;;39
 ;;MXTLUNIT;T & L UNIT;30;32;0;8;S NODE="";;;7
 ;;MXCITIZ;CITIZENSHIP;33;33;0;5;;;;4
 ;;MXPERFCD;PERF/PROFCY RATING CODE;34;34;0;23;;;;22
 ;;MXMGTDEV;MPI PARTICIPATION IND;35;35;;;;;;
 ;;
3 ;;Group 3;3;3;X
 ;;MXINTPER;INTER-AGENCY LWOP IND;1;1;LWOP;2;;;;516
 ;;MXCENTRL;CENTRALIZED POSITION IND;2;2;1;6;;;;53
 ;;MXFIREFG;FIRE FIGHTER;3;3;1;12;;;;59
 ;;
4 ;;Group 4;3;3;X
 ;;MXMEDCOD;MEDICARE STATUS CODE;1;1;MEDICARE;7;;;;256
 ;;MXPRBAPP;PROBATIONARY APPOINTMENT IND;2;2;1;25;;;;72
 ;;MXPAYRTD;PAY RATE DETERMINANT;3;3;0;22;;;;21
 ;;
5 ;;Group 5;5;8;X
 ;;MXEIC;EARNED INCOME CREDIT CODE;1;1;MISC4;9;S:DATA=0 DATA="";;;448
 ;;MXDUTYST;DUTY STATION;2;3;1;42;;;;590
 ;;MXFLDSTA;STATION MAINTAINING OPF;4;6;0;37;;;;36
 ;;MXBULKCH;BULK CHECK OPTION;7;7;MISC4;4;;;;443
 ;;MXTEMPHB;TEMPORARY HEALTH INSURANCE IND;8;8;0;41;;;;40
 ;;
6 ;;Group 6;9;17;X
 ;;MXOPMSER/MXTITCOD;OCCUPATION SERIES & TITLE;1;6;0;17;D TITLE^PRSDUTIL;;;16
 ;;MXASSGCD;ASSIGNMENT;7;8;0;4;;;;3
 ;;MXPLAN;PAY PLAN;9;9;0;21;;;;20
 ;;MXPPLAN;PROPER PAY PLAN;10;10;1;27;;;;74
 ;;MXPAYBAS;PAY BASIS;11;11;0;20;;;;19
 ;;MXDTYBAS;DUTY BASIS;12;12;0;10;;;;9
 ;;MXNORMHR;8B NORMAL HOURS;13;15;0;16;D SIGN^PRSDUTIL,NH^PRSDUTIL;;;15
 ;;MXFTEEAJ;FTE EQUIVALENT;16;16;MISC4;11;D SIGN^PRSDUTIL,FTE^PRSDCOMP;;;450
 ;;MXTYPAPP;TYPE OF APPOINTMENT;17;17;0;43;;;;42
 ;;
7 ;;Group 7;12;68;X
 ;;MXGRADE;GRADE;1;2;0;14;;;;13
 ;;MXSTEPN;STEP;3;4;0;39;D STEP^PRSDUTIL;;;38
 ;;MXPGRADE;PROPER GRADE;5;6;1;26;;;;73
 ;;MXWIGELG;WGI ELIGIBILITY;7;7;0;45;;;;44
 ;;MXSALRPY;SALARY;8;16;0;29;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;28
 ;;MXSALRSC;SCHEDULED SALARY RATE;17;25;0;30;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;29
 ;;MXSALDAT;SALARY DATE;26;33;0;28;D DATE^PRSDUTIL;;;27
 ;;MXGAPAMT;GAP AMT;34;40;1;36;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;83
 ;;MXFRGBEN;PURCHASE AND HIRE CASH PAYMENT;41;47;MISC;4;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;533
 ;;MXPHYSPC;SPECIAL PAY ANNUAL AMT;48;56;T38;24;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;142
 ;;MXNTWYTD;FEDERAL NONTAXABLE WAGES YTD;57;65;FED;1;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;212
 ;;MXPREMPR;PREMIUM PAY PCT;66;68;PREMIUM;14;D SIGN^PRSDUTIL,DDD^PRSDUTIL;;;556
 ;;
8 ;;Group 8;13;44;X
 ;;MXNONPEM;NONPAY IND;1;1;1;20;;;;67
 ;;MXMONOWK;MONTHLY NON-WORK IND;2;2;1;14;;;;61
 ;;MXCHGYR;BASE PAY CHANGE YEAR;3;6;PAY;3;;;;536
 ;;MXCHGPP;BASE PAY CHANGE PPD;7;8;PAY;2;;;;535
 ;;MXFLSA;FLSA;9;9;0;12;;;;11
 ;;MXMAILCD;CHECK DISTRIBUTION CODE;10;10;MISC4;5;;;;444
 ;;MXBANKCD;BANK EFT ROUTING NUMBER;11;19;MISC4;3;;;;442
 ;;MXACCNO;BANK ACCOUNT NUMBER;20;36;MISC4;1;;;;440
 ;;MXTYPACC;BANK ACCOUNT TYPE;37;37;MISC4;2;;;;441
 ;;MXSTRES;RESIDENCE STATE;38;39;ADD;6;;;;186
 ;;MXAUOPCT;AUO PERCENT;40;42;PREMIUM;2;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;544
 ;;MXMSDIND;MSD IND;43;43;MSD2;6;;;;281
 ;;MXPRPYCD;PREMIUM PAY IND;44;44;PREMIUM;6;S:DATA=0 DATA="";;;548
9 ;;Group 9;5;8;X
 ;;MXSKILLS;SPECIALIZED SKILLS IND;1;1;MISC;5;;;;601
 ;;MXANNUIT;ANNUITANT IND;2;2;MISC;6;;;;602
 ;;MXVETSTATUS;VET STATUS;3;3;MISC;7;;;;603
 ;;MXEQAIND;LEVEL;4;4;MISC;8;;;;604
 ;;MXSCHID;SCHEDULE NUMBER;5;8;MISC;9;;;;605
