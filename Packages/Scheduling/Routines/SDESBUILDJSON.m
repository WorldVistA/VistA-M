SDESBUILDJSON ;ALB/RRM - BUILD JSON RETURN FORMAT VISTA SCHEDULING RPCS ;MAY 27, 2022@11:48
 ;;5.3;Scheduling;**818**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
BUILDJSON(JSONRETURN,INPUT) ;
 ; Input:
 ; JSONRETURN [Required] = destination variable for the string array formatted as JSON
 ; INPUT      [Required] = closed array reference for M representation of object
 ;
 ; Output:
 ; JSONRETURN = the string array formatted as JSON
 ;
 N JSONERROR
 S JSONERROR=""
 D ENCODE^XLFJSON("INPUT","JSONRETURN","JSONERROR")
 Q
 ;
