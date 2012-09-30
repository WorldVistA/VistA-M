LRHYU4 ;DALOI/HOAK - GET THE LAB UID ;08/28/2005
 ;;5.2;LAB SERVICE;**405**;Sep 27, 1994;Build 93
 ;
 ; Reference to ^DIC supported by DBIA #916.
 ;
 ; Get the accession number or order number or universal ID
 ;
AA ;
 ;
 I $G(LRORDSIZ) S LRORDSIZ=$L(LRORDSIZ)
 S LRACC="" D ^LRWU4
 QUIT
