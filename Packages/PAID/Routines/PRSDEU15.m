PRSDEU15 ;HISC/MGD-PAID EDIT AND UPDATE DOWNLOAD RECORD 15 LAYOUT ;09/12/2003
 ;;4.0;PAID;**82**;Sep 21, 1995
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
RECORD ;;Record 15;14
 ;;
1 ;;Group 1;1;4;
 ;;LD-CODE1;LABOR DIST CODE-1;1;4;LD;2;S MULT=1,MFLD=1;;;757
 ;;
2 ;;Group 2;1;3;
 ;;LD-PERCENT1;LABOR DIST CODE-1 PCT;1;3;LD;3;S MULT=1,MFLD=2 D SIGN^PRSDUTIL,DD^PRSDUTIL;;;758
 ;;
3 ;;Group 3;1;4
 ;;LD-CODE2;LABOR DIST CODE-2;1;4;LD;2;S MULT=2,MFLD=1;;;759
 ;;
4 ;;Group 4;1;3
 ;;LD-PERCENT2;LABOR DIST CODE-2 PCT;1;3;LD;3;S MULT=2,MFLD=2 D SIGN^PRSDUTIL,DD^PRSDUTIL;;;760
 ;;
5 ;;Group 5;1;4
 ;;LD-MHORGCOD2;LABOR DIST CODE-2 COST CENTER;1;4;LD;4;S MULT=2,MFLD=3;;;761
 ;;
6 ;;Group 6;1;3
 ;;LD-MHFUNDCP2;LABOR DIST CODE-2 FUND CTRL PNT;1;3;LD;5;S MULT=2,MFLD=4;;;762
 ;;
7 ;;Group 7;1;4
 ;;LD-CODE3;LABOR DIST CODE-3;1;4;LD;2;S MULT=3,MFLD=1;;;763
 ;;
8 ;;Group 8;1;3
 ;;LD-PERCENT3;LABOR DIST CODE-3 PCT;1;3;LD;3;S MULT=3,MFLD=2 D SIGN^PRSDUTIL,DD^PRSDUTIL;;;764
 ;;
9 ;;Group 9;1;4
 ;;LD-MHORGCOD3;LABOR DIST CODE-3 COST CENTER;1;4;LD;4;S MULT=3,MFLD=3;;;765
 ;;
10 ;;Group 10;1;3
 ;;LD-MHFUNDCP3;LABOR DIST CODE-3 FUND CTRL PNT;1;3;LD;5;S MULT=3,MFLD=4;;;766
 ;;
11 ;;Group 11;1;4
 ;;LD-CODE4;LABOR DIST CODE-4;1;4;LD;2;S MULT=4,MFLD=1;;;767
 ;;
12 ;;Group 12;1;3
 ;;LD-PERCENT4;LABOR DIST CODE-4 PCT;1;3;LD;3;S MULT=4,MFLD=2 D SIGN^PRSDUTIL,DD^PRSDUTIL;;;768
 ;;
13 ;;Group 13;1;4
 ;;LD-MHORGCOD4;LABOR DIST CODE-4 COST CENTER;1;4;LD;4;S MULT=4,MFLD=3;;;769
 ;;
14 ;;Group 14;1;3
 ;;LD-MHFUNDCP4;LABOR DIST CODE-4 FUND CTRL PNT;1;3;LD;5;S MULT=4,MFLD=4;;;770
 ;;
