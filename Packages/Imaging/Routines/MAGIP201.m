MAGIP201 ;WOIFO/NST - Install code for MAG*3.0*201 ; Jan 22, 2019@09:15 AM
 ;;3.0;IMAGING;**201**;Mar 19, 2002;Build 2461;Jan 18, 2012
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
 ; There are no environment checks here but the MAGIP201 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;***** POST-INSTALL CODE
POS ;
 N CALLBACK
 D CLEAR^MAGUERR(1)
 ;
 D UPDATE()
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
 ;
 ;+++++ Various updates
UPDATE() ;
 N ANSERV,I,ITEM,MAGFDA,MAGERR,MAGIENS,MSG,IEN1,IEN2,IENS
 ;
 ; Add "PRECACHE" to WORKLIST file (#2006.9412)
 K MAGFDA,MAGERR
 S ITEM="PRECACHE"
 I '$O(^MAGV(2006.9412,"B",ITEM,0)) D
 . S MAGFDA(2006.9412,"+1,",.01)=ITEM
 . S MAGFDA(2006.9412,"+1,",1)=1 ;ACTIVE
 . D UPDATE^DIE("","MAGFDA","","MAGERR")
 . Q
 I $D(MAGERR) S MSG(1)=MAGERR("DIERR",1,"TEXT",1) D BMES^MAGKIDS("Error in Updating: ",.MSG) ;ERROR
 ;
 ; Add "ACQUISITION", "REGISTRATION" and "REMOTEPRIOR" to MAG WORK ITEM SUBTYPE file (#2006.9414)
 ;
 K MAGFDA,MAGERR
 F ITEM="ACQUISITION","REGISTRATION","REMOTEPRIOR" D
 . I '$O(^MAGV(2006.9414,"B",ITEM,0)) D
 . . S MAGFDA(2006.9414,"+1,",.01)=ITEM
 . . D UPDATE^DIE("","MAGFDA","","MAGERR")
 . . Q
 . I $D(MAGERR) S MSG(1)=MAGERR("DIERR",1,"TEXT",1) D BMES^MAGKIDS("Error in Updating: ",.MSG)  ;ERROR
 . Q
 ;
 ; Add MAG PRECACHE as a subscriber of RA REG
 ;
 K MAGFDA
 S IEN1=$$FIND1^DIC(101,"","BX","RA REG") ; Get [RA REG] IEN
 I 'IEN1 D  Q
 . S MSG(1)="RA REG protocol not found"
 . D BMES^MAGKIDS("Error in Updating: ",.MSG)
 . Q
 ;
 S IEN2=$$FIND1^DIC(101,"","BX","MAG PRECACHE") ; Get [MAG PRECACHE] IEN
 I 'IEN2 D  Q
 . S MSG(1)="MAG PRECACHE protocol not found"
 . D BMES^MAGKIDS("Error in Updating: ",.MSG)
 . Q
 ;
 S IENS="?+1,"_IEN1_","
 S MAGFDA(101.0775,IENS,.01)=IEN2
 D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 I $D(DIERR) D  Q
 . D MES^MAGKIDS("Error in updating event driver protocol [RA REG].")
 . F I=1:1 Q:'$D(MAGERR("DIERR",1,"TEXT",I))  D
 . . D MES^MAGKIDS(MAGERR("DIERR",1,"TEXT",I))
 . . Q
 . Q
 ;
 ; **** Convert external Annotation service value to internal value
 S IEN1=0
 F  S IEN1=$O(^MAG(2005.003,IEN1)) Q:'IEN1  D
 . S IEN2=0
 . F  S IEN2=$O(^MAG(2005.003,IEN1,1,IEN2)) Q:'IEN2  D
 . . S ANSERV=$P($G(^MAG(2005.003,IEN1,1,IEN2,0)),"^",7)
 . . Q:(ANSERV>0)!(ANSERV="")
 . . N X,DIC S DIC=49,DIC(0)="B",X=ANSERV D ^DIC S ANSERV=$S(+Y:+Y,1:"") ;SERVICE/SECTION
 . . K MAGFDA,MAGIENS,MAGERR
 . . S IENS=IEN2_","_IEN1_","
 . . S MAGIENS(1)=IEN1
 . . S MAGIENS(2)=IEN2
 . . S MAGFDA(2005.0031,IENS,7)=ANSERV     ;SERVICE/SECTION
 . . D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 . . I $D(MAGERR) D
 . . . D MES^MAGKIDS("Error in updating event driver protocol [RA REG].")
 . . . F I=1:1 Q:'$D(MAGERR("DIERR",1,"TEXT",I))  D
 . . . . D MES^MAGKIDS(MAGERR("DIERR",1,"TEXT",I))
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
