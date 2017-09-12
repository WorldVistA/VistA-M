PSJ0253 ;BIR/JCH - Remove ON CALL Cross Reference in Schedule Type (#7) field in Non-Verified Orders (#53.1) file ;23 Mar 11 / 7:30 AM
 ;;5.0;INPATIENT MEDICATIONS ;**253**;16 DEC 97;Build 31
 ;
 ;Reference to ^DDMOD is supported by DBIA# 2916.
 ;
 Q
 ;
EN ; Delete the ON CALL Cross Reference from the Schedule Type field in file ^PS(53.1.
 ;
 N PSJFIL,PSJFLD,PSJXREF
 S PSJFIL=53.1,PSJFLD=7,PSJXREF=1
 D DELIX^DDMOD(PSJFIL,PSJFLD,PSJXREF)
 Q
