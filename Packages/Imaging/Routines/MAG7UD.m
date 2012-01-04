MAG7UD ;WOIFO/MLH - Imaging - HL7 - utilities - dates ; 11/15/2006 08:35
 ;;3.0;IMAGING;**49**;Mar 19, 2002;Build 2033;Apr 07, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
STRIP0(XDATELOC) ; FUNCTION - strip zeros off HL7 dates
 ; input:  XDATELOC   variable containing any 8-digit HL7 date with or w/o TZ offset (+/-ZZZZ)
 ; function return:   always 0 (success)
 ; 
 N MAGDATE ; -- working date
 N OFSGN ; ---- offset sign
 N TZ ; ------- time zone offset
 ;
 ; '*' for offset sign means there isn't one, but the date is valid
 S MAGDATE=@XDATELOC
 S OFSGN=$S(MAGDATE?1.N1"-"1.N:"-",MAGDATE?1.N1"+"1.N:"+",MAGDATE?1.N:"*",1:"")
 I OFSGN="" Q ""
 S TZ=$P(MAGDATE,OFSGN,2),MAGDATE=$P(MAGDATE,OFSGN,1)
 I MAGDATE?6N1"00" S MAGDATE=MAGDATE/100
 I MAGDATE?4N1"00" S MAGDATE=MAGDATE/100
 S @XDATELOC=MAGDATE_$S(OFSGN'="*":OFSGN,1:"")_TZ
 Q 0 ; success always
