DGPFUT63 ;SHRPE/SGM - PRF UTILITIES FOR DBRS# ; Apr 3, 2018 14:18
 ;;5.3;Registration;**960**;Aug 13, 1993;Build 22
 ;     Last Edited: SHRPE/sgm - May 24, 2018 10:42
 ;
 ;  No routines should invoked this routine directly.  See DGPFUT6
 ;  This routine will be called directly by the following routines
 ;  as part of patch 960.  Once patch DG*5.3*951 is released the
 ;  routines listed should be converted to calling the API in the
 ;  DGPFUT6 routine.
 ;     DGPFRAL1 := LOCAL+5     S LOC=$$LOC^DGPFUT63(.TMP)
 ;
 ; ICR# TYPE DESCRIPTION
 ;----- ---- -----------------------------
 ;
 Q
 ;
LOC(DGIN) ;  BOOLEAN
 ;   Determine if History record was created locally or at another VAMC
 ;   May or may not have DG*5.3*951
 ; INPUT: .DGIN - required - a copy of DGPFAH()
 ;         INST - optional - pointer to file 4
 ; RETURN: 1 if History created at this facility
 ;         0 if History created at other facility
 ;         0 if unable to determine if record local or not
 ;   DGPFAH - Output array containing the field values
 ;            Subscript    Field#
 ;            ----------   ------
 ;            "ENTERBY"     .04
 ;            "APPRVBY"     .05
 ;            "ORIGFAC"     .09
 ;
 N I,J,X,ISLOC,ORIG,RET,STN,WHO
 S ORIG=+$G(DGIN("ORIGFAC")) I $$ISDIV^DGPFUT(ORIG)>0 Q 1
 ;
 ; CREATED BY SITE field not present (dg*5.3*951) or not valued
 S WHO=+$G(DGIN("APPRVBY"))
 I 'WHO S WHO=+$G(DGIN("ENTERBY"))
 Q (WHO>.9)
