PRSDEU13 ;HISC/GWB-PAID EDIT AND UPDATE DOWNLOAD RECORD 13 LAYOUT ;02/13/2003
 ;;4.0;PAID;**78**;Sep 21, 1995
 F CC=1:1 S GRP=$T(@CC) Q:GRP=""  S GRPVAL=$P(RCD,":",CC) I GRPVAL'="" S GNUM=$P(GRP,";",4),LTH=$P(GRP,";",5),PIC=$P(GRP,";",6) D:PIC=9 PIC9^PRSDUTIL F EE=1:1:GNUM S FLD=$T(@CC+EE) D EPTSET^PRSDSET
 Q
 ; The RECORD line tag shows represents ;; Record #;# of Groups
 ;
 ; The Groups are defined as follows:
 ;
 ; Line Tag      ;;3;4;5;6
 ;
 ; Where piece
 ;       3 = The Group number within the Record.  Each Record is an
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
RECORD ;;Record 13;15
 ;;
1 ;;Group 1;1;23;X
 ;;SBONDS-ADDR-LINE1-3;SAVINGS BOND-3 ADD LINE-1;1;23;BOND3;1;;;;720
 ;;
2 ;;Group 2;1;23;X
 ;;SBONDS-ADDR-LINE2-3;SAVINGS BOND-3 ADD LINE-2;1;23;BOND3;2;;;;721
 ;;
3 ;;Group 3;1;16;X
 ;;SBONDS-ADDR-LINE3-3;SAVINGS BOND-3 ADD LINE-3;1;16;BOND3;3;;;;722
 ;;
4 ;;Group 4;1;9;X
 ;;SBONDS-COST-3;BOND BALANCE - NOT USED;1;9;;;;;;
 ;;
5 ;;Group 5;1;1;X
 ;;SBONDS-BENE-CODE-3;SAVINGS BOND-3 BENE CODE;1;1;BOND3;5;;;;724
 ;;
6 ;;Group 6;1;28;X
 ;;SBONDS-COOWNER-3;SAVINGS BOND-3 CO-OWNER;1;28;BOND3;6;;;;725
 ;;
7 ;;Group 7;1;9;X
 ;;SBONDS-COOWNER-SSN-3;SAVINGS BOND-3 CO-OWNER SSN;1;9;BOND3;7;;;;726
 ;;
8 ;;Group 8;1;7;9
 ;;SBONDS-DED-BAL-3;SAVINGS BOND-3 DED BALANCE;1;7;BOND3;8;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;727
 ;;
9 ;;Group 9;1;7;9
 ;;SBONDS-DED-PAY-PERIOD-3;SAVINGS BOND-3 DED EPPD;1;7;BOND3;9;D SIGN^PRSDUTIL,DD^PRSDUTIL;;;728
 ;;
10 ;;Group 10;1;1;X
 ;;SBONDS-DENOM-3;SAVINGS BOND-3 DENOMINATION;1;1;BOND3;10;;;;729
 ;;
11 ;;Group 11;1;6;
 ;;SBONDS-EFFT-DATE-3;SAVINGS BOND-3 EFFECTIVE DATE;1;6;BOND3;11;S:DATA'="" DATA=DATA_"01" D DATE^PRSDUTIL;;;730
 ;;
12 ;;Group 12;1;32;X
 ;;SBONDS-OWNER-3;SAVINGS BOND-3 OWNER;1;32;BOND3;12;;;;731
 ;;
13 ;;Group 13;1;9;X
 ;;SBONDS-OWNER-SSN-3;SAVINGS BOND-3 OWNER SSN;1;9;BOND3;13;;;;732
 ;;
14 ;;Group 14;1;9;9
 ;;SBONDS-ZIP-CODE-3;SAVINGS BOND-3 ZIP CODE;1;9;BOND3;14;D ZIP^PRSDUTIL;;;733
 ;;
15 ;;Group 15;1;1;
 ;;SBONDS-TYPE-3;SAVINGS BOND-3 TYPE;1;1;BOND3;15;;;;734
 ;;
