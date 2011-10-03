FBUTL6 ;WIOFO/SAB-FEE BASIS UTILITY ;8/10/2004
 ;;3.5;FEE BASIS;**82**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; IA #4436 allows calls to $$CREATE^DGPTFEE and $$DELETE^DGPTFEE
 Q
 ;
PTFC(DFN,FBDT) ; Create Non-VA PTF Record
 ; Input
 ;   DFN  - IEN of entry in PATIENT (#2) file
 ;   FBDT - Admission Date/Time, FileMan internal format, time optional
 N FBX
 I $G(DFN),$G(FBDT) D WAIT^DICD S FBX=$$CREATE^DGPTFEE(DFN,FBDT,1)
 W $C(7),!?5,$S($G(FBX)>0:"Non-VA PTF Record Created.",1:"Unable to create Non-VA PTF Record."),!
 Q
 ;
PTFD(DFN,FBDT) ; Delete Non-VA PTF Record
 ; Input
 ;   DFN  - IEN of entry in PATIENT (#2) file
 ;   FBDT - Admission Date/Time, FileMan internal format, time optional
 N FBX
 I $G(DFN),$G(FBDT) S FBX=$$DELETE^DGPTFEE(DFN,FBDT)
 W $C(7),!?5,$S($G(FBX)=1:"Non-VA PTF Record Deleted.",1:"Unable to delete Non-VA PTF Record."),!
 Q
 ;
 ;FBUTL6
