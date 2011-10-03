VAFHLA08 ;ALB/CM HL7 A08 MESSAGE BUILDING ;05/01/95
 ;;5.3;Registration;**91**;Jun 06, 1996
 ;
 ;This routine will build an HL7 A08 Message for an inpatient or
 ;outpatient event depending on the entry point used.
 ;Use IN for inpatient
 ;Use OUT for outpatient
 ;
IN ;
 Q
 ;
OUT(DFN,EVENT,EVDT,VPTR,PISTR,ZSTR,PSTR,XSTR,PDNUM,ZNUM,PNUM,XNUM) ;
 ;DFN - Patient file DFN
 ;EVENT - Event number from pivot file
 ;EVDT - event date/time FileMan format
 ;VPTR - variable pointer
 ;PISTR - fields to be included in PID (null - required fields,
 ;or string of fields seperated by commas)
 ;ZSTR - fields to be included in ZPD (null - required fields,
 ;or string of fields seperated by commas)
 ;PSTR - fields to be included in OPV1
 ;(if null - required fields, if "A" - supported
 ;fields, or string of fields seperated by commas")
 ;XSTR - fields to be included in ODG1
 ;(if null - required fields, if "A" - supported
 ;fields, or string of fields seperated by commas")
 ;PDNUM - ID # for PID (optional)
 ;ZNUM - ID # for ZPD (optional)
 ;PNUM - ID # for OPV1 (optional)
 ;XNUM - ID # for ODG1 (optional)
 ;
 I '$D(PDNUM) S PDNUM=1
 I '$D(ZNUM) S ZNUM=1
 I '$D(PNUM) S PNUM=1
 I '$D(XNUM) S XNUM=1
 S ERR=$$OA08^VAFHCA08($G(DFN),$G(EVENT),$G(EVDT),$G(VPTR),$G(PISTR),$G(ZSTR),$G(PSTR),$G(XSTR),PDNUM,ZNUM,PNUM,XNUM)
 Q ERR
