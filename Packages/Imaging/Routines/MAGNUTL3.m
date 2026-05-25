MAGNUTL3 ;HIE/ZEB - C/VIX subroutines for RPC calls ; 2 JUL 2024@10:31
 ;;3.0;IMAGING;**365**;July 2, 2024;Build 19
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
CACHEORD(MAGMSG) ;Imaging Precache based on order updates
 ;Protocol: MAG PRECACHE ORDER SIGNED
 ;That, in turn, is called from the OR EVSEND RA and RA EVSEND OR protocols
 Q:'$D(MAGMSG)
 N LN,MAGSEG,MAGCPT,CPTIENS,MAGDFN,ORDIENS,ORDFDA,OIIENS,ITMIENS,ACTION,MAGOBR4,RAPIENS,RAPFDA,MAGCPTS,RACPTIEN,DESCIEN
 ;reindex message by segment instead of by line
 S LN=0
 F  S LN=$O(MAGMSG(LN)) Q:LN=""  S MAGSEG($P(MAGMSG(LN),"|",1))=MAGMSG(LN)
 ;make sure order is new and isn't being dc'd
 S ACTION=$P(MAGSEG("ORC"),"|",2)
 Q:$S(ACTION="NW":0,ACTION="XX":0,ACTION="SN":0,1:1)  ;NW is a newly signed order, XX is a corrected order, SN is used by rad orders
 ;get information needed to create work item
 S MAGDFN=$P(MAGSEG("PID"),"|",4)
 Q:MAGDFN=""
 ;try OBR segment if present
 I $D(MAGSEG("OBR")) D  I 1
 . S MAGOBR4=$P(MAGSEG("OBR"),"|",5)
 . S MAGCPT=$P(MAGOBR4,"^",1)
 . ;start with CPT from OBR-4^1
 . I MAGCPT]"" D
 .. S CPTIENS=$$CPTIENS(MAGCPT)
 .. Q:CPTIENS=-1
 .. ;interneral value of YES is 1 (and NO is 0), abort if CPT code not affimatively set to precache
 .. Q:'$$GET1^DIQ(2006.14,CPTIENS,1,"I")
 .. S MAGCPTS(MAGCPT)=""
 ;check Rad Procedure from OBR-4^4 if no CPT
 I '$D(MAGCPTS) D
 . S RAPIENS=$P(MAGOBR4,"^",4)
 . Q:RAPIENS=""
 . S RAPIENS=RAPIENS_","
 . D GETS^DIQ(71,RAPIENS,"9;300*","I","RAPFDA")
 . ;this is already a CPT IEN, not a free text code
 . I RAPFDA(71,RAPIENS,9,"I")]"" D
 .. S CPTIENS=$$CPTIENS("",RAPFDA(71,RAPIENS,9,"I"))
 .. Q:CPTIENS=-1
 .. ;interneral value of YES is 1 (and NO is 0), abort if CPT code not affimatively set to precache
 .. Q:'$$GET1^DIQ(2006.14,CPTIENS,1,"I")
 .. S MAGCPTS($$GET1^DIQ(81,RAPFDA(71,RAPIENS,9,"I"),".01"))=""
 . F LN=1:1 Q:'$D(RAPFDA(71.05,LN_","_RAPIENS))  D
 .. S DESCIEN=RAPFDA(71.05,LN_","_RAPIENS,.01,"I")
 .. S RACPTIEN=$$GET1^DIQ(71,DESCIEN,9,"I")
 .. Q:RACPTIEN=""
 .. S CPTIENS=$$CPTIENS("",RACPTIEN)
 .. Q:CPTIENS=-1
 .. ;interneral value of YES is 1 (and NO is 0), abort if CPT code not affimatively set to precache
 .. Q:'$$GET1^DIQ(2006.14,CPTIENS,1,"I")
 .. S MAGCPTS($$GET1^DIQ(81,RACPTIEN,".01"))=""
 ;fall back to order if no OBR (only works for OR-initiated orders, not RA-initiated ones)
 I ('$D(MAGSEG("OBR"))),($P(MAGSEG("MSH"),"|",3)="ORDER ENTRY") D
 . S ORDIENS=$P($P(MAGSEG("ORC"),"|",3),";",1)_","
 . D GETS^DIQ(100,ORDIENS,".1*","I","ORDFDA")
 . S OIIENS=""
 . ;loop over orderable items in the original order
 . F  S OIIENS=$O(ORDFDA(100.001,OIIENS)) Q:OIIENS=""  D
 .. S ITMIENS=ORDFDA(100.001,OIIENS,.01,"I")_","
 .. S MAGCPT=$$GET1^DIQ(101.43,ITMIENS,3)
 .. ;see if procedure code is in precache settings
 .. S CPTIENS=$$CPTIENS(MAGCPT)
 .. Q:CPTIENS=-1
 .. ;interneral value of YES is 1 (and NO is 0), abort if CPT code not affimatively set to precache
 .. Q:'$$GET1^DIQ(2006.14,CPTIENS,1,"I")
 .. S MAGCPTS(MAGCPT)=""
 ;create work items for appropriate CPTs
 S MAGCPT=""
 F  S MAGCPT=$O(MAGCPTS(MAGCPT)) Q:MAGCPT=""  D
 . D CREATEWI(MAGDFN,MAGCPT)
 Q
 ;
CPTIENS(CPT,CPTIEN) ;Return the IENS in the PRECACHE SETTINGS multiple for a CPT code
 ;Will return -1 if a matching row was not found
 N ISPIEN,LN
 S:$G(CPTIEN)="" CPTIEN=$$CODEN^ICPTCOD(CPT)
 Q:CPTIEN=-1 -1 ;Couldn't find an IEN for CPT code
 S ISPIEN=$O(^MAG(2006.1,"B",DUZ(2),""))
 Q:ISPIEN="" -1 ;Couldn't find IMAGING SITE PARAMETERS for user's division
 S LN=$O(^MAG(2006.1,ISPIEN,"PRECACHE","B",CPTIEN,""))
 Q:LN]"" LN_","_ISPIEN_","
 Q -1 ;Couldn't find a matching line for the CPT
 ;
CREATEWI(MAGDFN,MAGCPT) ;Create a MAG WORK ITEM entry to precache remote priors for a patient and CPT code
 Q:$G(MAGDFN)=""
 Q:$G(MAGCPT)=""
 N MAGOUT,PLACEID,MSGTAGS,TAG,MAGICN,MAGI
 ;Get treating facility list
 D FACLIST^MAGJLST1(.MAGOUT,MAGDFN)
 Q:MAGOUT(0)'>0  ;No treating facilities
 ;Get place ID
 S PLACEID=$$STA^XUAF4(DUZ(2)) ;IA # 2171
 ;Set up tags
 S TAG=0
 S TAG=TAG+1,MSGTAGS(TAG)="patientDfn`"_MAGDFN
 S MAGICN=$$GETICN^MPIF001(MAGDFN)
 S:MAGICN>1 TAG=TAG+1,MSGTAGS(TAG)="patientIcn`"_MAGICN
 S MAGI=0
 F  S MAGI=$O(MAGOUT(MAGI)) Q:'MAGI  D
 . S TAG=TAG+1,MSGTAGS(TAG)="treatingStation"_MAGI_"`"_$P(MAGOUT(MAGI),"^")
 S TAG=TAG+1,MSGTAGS(TAG)="CPT`"_MAGCPT
 S TAG=TAG+1,MSGTAGS(TAG)="remoteprior`1"
 ;Actually create the work item
 D CRTITEM^MAGVIM01(.MAGOUT,"PRECACHE","REMOTEPRIOR","New",PLACEID,0,.MSGTAGS,DUZ,"PRECACHE")
 Q
 ;
