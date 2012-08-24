LRHYUTL ;DALOI/HOAK - UNIVERSAL UTILITY ;08/31/2005
 ;;5.2;LAB SERVICE;**405**;Sep 27, 1994;Build 93
 ;
 ; This routine is used to enhance display processes for Vista.
 ;
 ;
GRAFON ;
 D GSET^%ZISS
 QUIT
GRAFOFF ;
 W IOG0 D GKILL^%ZISS
 QUIT
SCRNON ;
 N X,Y
 D ENS^%ZISS
 QUIT
SCRNOFF ;
 N X,Y
 D KILL^%ZISS
 ;
 QUIT
