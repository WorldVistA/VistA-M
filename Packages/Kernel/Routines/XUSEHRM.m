XUSEHRM ; BA/OAK - EHRM REVERSED LOCK ; Jan 19, 2022@03:34:43
 ;;8.0;KERNEL;**758**;Jul 10, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
1 ;Assign Replacement Program Key to ALL Users (this option needs the XUPROG Key assigned)
  D 1^XUSEHRM1
  Q
  ;
2 ;Remove Replacement Program Key from ALLL User (this option needs the XUPROG Key assigned)
  D 2^XUSEHRM1
  Q
  ;
3 ;Allocation of Security Keys
  ;D 3^XUSEHRM1
  Q
  ;
4 ;Deallocation of Security Keys
  ;D 4^XUSEHRM1
  Q
  ;
5 ;Assign Replacement Program Key to EVERSE/NEGATIVE LOCK
  D 5^XUSEHRM1
  Q
  ;
6 ;Remove Replacement Program Key from EVERSE/NEGATIVE LOCK
  D 6^XUSEHRM1
  Q
  ;
7 ;List Users Holding a Certain Program Replacement Key (our criteria adds CSV functionality)
  D 7^XUSEHRM2
  Q
  ;
8 ;List Users who do not have a certain Program Replacement Key
  D 8^XUSEHRM2
  Q
9 ;Lst Options with a Replacement Program Key
  D 9^XUSEHRM2
  Q
  ;
10 ;List Options that do not have a Replacement Program Key
  D 10^XUSEHRM2
  Q
