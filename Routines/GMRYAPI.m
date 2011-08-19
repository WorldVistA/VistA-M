GMRYAPI ;HIOFO/FT-I/O APIs ;1/24/02  14:34
 ;;4.0;Intake/Output;**5**;Apr 25, 1997
 ;
 ; The calls in this routine are documented in IA #3214.
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
INPUT() ; This function returns the number of entries in the GMRY INPUT TYPE
 ; (#126.56) file.
 ;  Input - <none>
 ; Output - the number of entries in FILE 126.56
 Q $P($G(^GMRD(126.56,0)),U,4)
 ;
OUTPUT() ; This function returns the number of entries in the
 ; GMRY OUTPUT TYPE (#126.58) file.
 ;  Input - <none>
 ; Output - the number of entries in FILE 126.58
 Q $P($G(^GMRD(126.58,0)),U,4)
 ;
