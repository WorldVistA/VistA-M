YSMHMENU ;SLC/TGA,HIOFO/hrubovcak-MENTAL HEALTH MENU HEADINGS ;10/25/11 9:10am
 ;;5.01;MENTAL HEALTH;**60**;Dec 30, 1994;Build 47
 ;
 Q
 ;
CLIN ; Called as ENTRY action in option YSCLINRECORD
 N H2,L2 S H2="*** MENTAL HEALTH ***",L2="Clinical Record" D WRT
 Q
 ;
MHS ; Called as ENTRY action in option YSMANAGER
 N H2,L2 S H2="*** MENTAL HEALTH ***",L2="MHS Manager Functions" D WRT
 Q
 ;
WRT ;
 W @IOF,$J(" ",IOM-$L(H2)\2)_H2,!,$J(" ",IOM-$L(L2)\2)_L2
 Q
 ; 13 October 2011
 ;
