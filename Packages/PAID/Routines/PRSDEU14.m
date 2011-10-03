PRSDEU14 ;HISC/MGD-PAID EDIT AND UPDATE DOWNLOAD RECORD 14 LAYOUT ;08/26/2003
 ;;4.0;PAID;**78,82**;Sep 21, 1995
 F CC=1:1 S GRP=$T(@CC) Q:GRP=""  S GRPVAL=$P(RCD,":",CC) I GRPVAL'="" S GNUM=$P(GRP,";",4),LTH=$P(GRP,";",5),PIC=$P(GRP,";",6) D:PIC=9 PIC9^PRSDUTIL F EE=1:1:GNUM S FLD=$T(@CC+EE) D EPTSET^PRSDSET
 Q
 ; The RECORD line tag shows represents ;; Record #;# of Groups
 ;
 ; The Groups are defined as follows:
 ;
 ; Line Tag      ;;3;4;5;6
 ;
 ; Where piece
 ;       3 = The Group number withing the Record.  Each Record is an
 ;            individual line in the ^XMB(3.9 mail global.
 ;       4 = The number of fields in the group
 ;       5 = The number of bytes in the group
 ;       6 = Special formatting information
 ; 
 ; Each individual line under the numeric line tag represents the
 ; following:
 ;
 ; Where piece
 ;       3 = The Central PAID field name
 ;       4 = VistA PAID/ETA field name
 ;       5 = Starting Byte
 ;       6 = Ending Byte
 ;       7 = Node in PAID EMPLOYEE (#450)
 ;       8 = Piece within the Node in #450
 ;       9 = Formatting information
 ;      10 = Node in PAID PAYRUN DATA (#459)
 ;      11 = Piece within the Node in #459
 ;      12 = Field # within #459
 ;
RECORD ;;Record 13;21
 ;;
1 ;;Group 1;1;23;X
 ;;SBONDS-ADDR-LINE1-4;SAVINGS BOND-4 ADD LINE-1;1;23;BOND4;1;;;;735
 ;;
2 ;;Group 2;1;23;X
 ;;SBONDS-ADDR-LINE2-4;SAVINGS BOND-4 ADD LINE-2;1;23;BOND4;2;;;;736
 ;;
3 ;;Group 3;1;16;X
 ;;SBONDS-ADDR-LINE3-4;SAVINGS BOND-4 ADD LINE-3;1;16;BOND4;3;;;;737
 ;;
4 ;;Group 4;1;9;X
 ;;SBONDS-COST-4;BOND BALANCE - NOT USED;1;9;;;;;;
 ;;
5 ;;Group 5;1;1;X
 ;;SBONDS-BENE-CODE-4;SAVINGS BOND-4 BENE CODE;1;1;BOND4;5;;;;739
 ;;
6 ;;Group 6;1;28;X
 ;;SBONDS-COOWNER-4;SAVINGS BOND-4 CO-OWNER;1;28;BOND4;6;;;;740
 ;;
7 ;;Group 7;1;9;X
 ;;SBONDS-COOWNER-SSN-4;SAVINGS BOND-4 CO-OWNER SSN;1;9;BOND4;7;;;;741
 ;;
8 ;;Group 8;1;7;9
 ;;SBONDS-DED-BAL-4;SAVINGS BOND-4 DED BALANCE;1;7;BOND4;8;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;742
 ;;
9 ;;Group 9;1;7;9
 ;;SBONDS-DED-PAY-PERIOD-4;SAVINGS BOND-4 DED EPPD;1;7;BOND4;9;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;743
 ;;
10 ;;Group 10;1;1;X
 ;;SBONDS-DENOM-4;SAVINGS BOND-4 DENOMINATION;1;1;BOND4;10;;;;744
 ;;
11 ;;Group 11;1;6;
 ;;SBONDS-EFFT-DATE-4;SAVINGS BOND-4 EFFECTIVE DATE;1;6;BOND4;11;S:DATA'="" DATA=DATA_"01" D DATE^PRSDUTIL;;;745
 ;;
12 ;;Group 12;1;32;X
 ;;SBONDS-OWNER-4;SAVINGS BOND-4 OWNER;1;32;BOND4;12;;;;746
 ;;
13 ;;Group 13;1;9;X
 ;;SBONDS-OWNER-SSN-4;SAVINGS BOND-4 OWNER SSN;1;9;BOND4;13;;;;747
 ;;
14 ;;Group 14;1;9;9
 ;;SBONDS-ZIP-CODE-4;SAVINGS BOND-4 ZIP CODE;1;9;BOND4;14;D ZIP^PRSDUTIL;;;748
 ;;
15 ;;Group 15;1;1;
 ;;SBONDS-TYPE-4;SAVINGS BOND-4 TYPE;1;1;BOND4;15;;;;749
 ;;
16 ;;Group 16;1;7;9
 ;;MIB1BAL;SAVINGS BOND-1 DED BALANCE;1;7;BOND1;9;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;351
 ;;
17 ;;Group 17;1;7;9
 ;;MKB2BAL;SAVINGS BOND-2 DED BALANCE;1;7;BOND2;8;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;365
 ;;
18 ;;Group 18;1;5;9
 ;;VOL-ALLOT-AMT-3;VOLUNTARY ALLOTMENT-3 AMT;1;5;VALLOT;6;D SIGN^PRSDUTIL S DATA=+DATA;;;439.1
 ;;
19 ;;Group 19;1;4;9
 ;;VOL-ALLOT-CNTL-3;VOLUNTARY ALLOTMENT-3 CTRL NO;1;4;VALLOT;7;;;;439.2
 ;;
20 ;;Group 20;1;5;9
 ;;VOL-ALLOT-AMT-4;VOLUNTARY ALLOTMENT-4 AMT;1;5;VALLOT;8;D SIGN^PRSDUTIL S DATA=+DATA;;;439.3
 ;;
21 ;;Group 21;1;4;9
 ;;VOL-ALLOT-CNTL-4;VOLUNTARY ALLOTMENT-4 CTRL NO;1;4;VALLOT;9;;;;439.4
 ;;
