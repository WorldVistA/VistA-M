WVRPCPR1 ;HIOFO/FT-WV PROCEDURE file (790.1) RPCs (cont.) ;1/2/04  12:24
 ;;1.0;WOMEN'S HEALTH;**16**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
NORMAL(WVIEN) ; Function determines if a result/dx entry (FILE 790.31) is
 ; categorized as Normal or Abnormal.
 ;  Input: WVIEN - FILE 790.31 entry
 ;
 ; Output:   0 - NORMAL
 ;           1 - ABNORMAL
 ;           2 - NO RESULT
 ;        null - not in FILE 790.31
 ;
 Q $P($G(^WV(790.31,+WVIEN,0)),U,21)
 ;
DXNAME(WVIEN) ; Function to return the name of an entry in the
 ; WV RESULTS/DIAGNOSIS file (#790.31).
 ;  Input: WVIEN = FILE 790.31 ien
 ; Output: .01 value or null
 I '$G(WVIEN) Q ""
 Q $P($G(^WV(790.31,+WVIEN,0)),U,1)
 ;
ERROR() ; Function to return the IEN of the "Error/disregard" result/dx from
 ; FILE 790.31.
 ;  Input: <none>
 ; Output: FILE 790.31 IEN for "Error/disregard"
 Q $O(^WV(790.31,"B","Error/disregard",0))
 ;
BRTXIEN(WVNAME) ; Function converts WV BREAST TX NEED (#790.51) name to ien
 ;  Input: WVNAME = FILE 790.51 name (.01 value)
 ; Output: FILE 790.51 IEN or 0 (zero)
 ;
 I $G(WVNAME)="" Q 0
 Q +$O(^WV(790.51,"B",WVNAME,0))
 ;
CXTXIEN(WVNAME) ; Function converts WV CERVICAL TX NEED (#790.5) name to ien
 ;  Input: WVNAME = FILE 790.5 name (.01 value)
 ; Output: FILE 790.5 IEN or 0 (zero)
 ;
 I $G(WVNAME)="" Q 0
 Q +$O(^WV(790.5,"B",WVNAME,0))
 ;
