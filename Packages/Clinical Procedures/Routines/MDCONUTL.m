MDCONUTL ; WOIFO/KLM - CP Conversion Utility ;31 Oct 2018 2:31 PM
 ;;1.0;CLINICAL PROCEDURES;**65**;Apr 01, 2004;Build 2
 ; This utility is based on Shirley Ackerman's ZZNACVT and ZZNACVT1 
 ; class III conversion routines.
 ;
 ; Integration Agreements:
 ; IA# 2638 [Controlled] File 100.01,
 ; IA# 3067 [Private] FM R/W File 123
 ; IA# 5062 [Private] ^GMR(123,"AE"
 ; IA# 6926 [Private] File 123.3
 ; IA# 6927 [Private] File 123.5
 ; IA# 6959 [Private] ^MAG(2006.5831,
 ;
CONVERT ; Convert consults to procedures.
 ;;MDOPT defined from the entry action of the option used.
 Q:'$D(MDOPT)#2
 N MDCOUNT,MDCP,MDCPR,MDCPRST,MDCPST,MDFDA,MDFILE,MDL,MDLP,MDSERV,MDIEN,MDTE,MDTOS,MDFR
 N MDFRE,MDTOSE,MDCPRE,MDX
 S MDFILE=123
 S MDCOUNT=0
 I $D(MDOPT("CONCONVERT"))#2 D 
 .D CSCVRT
 .Q
 E  D
 .D PRCVRT
 .Q
 I '$G(MDX) D START
 Q
CSCVRT ;Select consult service and procedure for conversion
 W !!,"This routine utility will get all the pending consults of "
 W !,"a selected REQUEST SERVICE and convert them to a selected GMRC procedures.",!
 W !,"Note that consults that are currently setup with DICOM (in the CLINICAL "
 W !,"SPECIALTY DICOM & HL7 file) cannot be converted to CP with this utility."
 W !,"DICOM consults will need to discontinued and re-ordered.",!
 D SETTS I '$G(MDTOS) S MDX=1 Q
 S MDF=1 D SETPR(MDF) I '$G(MDCPR) S MDX=1 Q
 K MDF
 Q
PRCVRT ;Select consult service and procedures for conversion
 W !!,"This routine utility will get all the pending, active, and"
 W !,"scheduled procedures of a selected REQUEST SERVICE and convert"
 W !,"them to a selected GMRC procedures.",!
 W !,"Note that Procedures that are currently setup with DICOM (in the CLINICAL "
 W !,"SPECIALTY DICOM & HL7 file) cannot be converted to CP with this utility."
 W !,"DICOM procedures will need to discontinued and re-ordered.",!
 S MDF=0 D SETPR(MDF) I '$G(MDTOS)!('$G(MDFR)) S MDX=1 Q
 S MDF=1 D SETPR(MDF) I '$G(MDCPR) S MDX=1 Q
 K MDF
 Q
START ; Start process conversion
 S MDCP=$$GET1^DIQ(123.3,+MDCPR_",",.04,"I")
 I 'MDCP D
 .W !,"Missing Clinical Procedure Definition in ",$$GET1^DIQ(123.3,+MDCPR,.01),!
 .S DIC="^MDS(702.01,",DIC(0)="AEMNQ"
 .D ^DIC Q:Y<1!($D(DTOUT))!($D(DUOUT))
 .S MDCP=+Y
 .S MDFDA(123.3,MDCPR_",",.04)=+MDCP
 .L +^GMR(123.3,MDCPR):1 I '$T Q
 .D FILE^DIE("","MDFDA") K MDFDA
 .L -^GMR(123.3,MDCPR)
 .Q
 I 'MDCP W !,"Still missing CP Definition." Q
 I $D(MDOPT("CONCONVERT"))#2 D
 .W !!,"We will proceed to convert ",MDTOSE," consults to"
 .Q
 E  D
 .W !!,"We will proceed to convert ",MDFRE," in ",MDTOSE," to "
 .Q
 W !,MDCPRE," procedures...",!
 W ! S MDSERV=$$GETSER(+MDCPR) I 'MDSERV W !,"RELATED SERVICE missing from "_$S($D(MDCPRE):MDCPRE,1:MDFRE)_" - no records converted" Q
 S MDL="" F  S MDL=$O(^GMR(MDFILE,"AE",MDTOS,MDL)) Q:MDL<1  D
 .S MDCPST=MDL
 .S MDCPRST=$$GET1^DIQ(100.01,MDCPST_",",.01,"E")
 .I MDCPRST'="PENDING"&(MDCPRST'="ACTIVE")&(MDCPRST'="SCHEDULED") Q
 .S MDTE=0 F  S MDTE=$O(^GMR(MDFILE,"AE",MDTOS,MDL,MDTE)) Q:MDTE<1  D
 ..S MDLP=0 F  S MDLP=$O(^GMR(MDFILE,"AE",MDTOS,MDL,MDTE,MDLP)) Q:MDLP<1  D
 ...I $D(MDOPT("CONCONVERT"))#2,$$GET1^DIQ(MDFILE,MDLP_",",13,"I")="P" Q
 ...I $D(MDOPT("PROCONVERT"))#2 D  Q:(MDX'["GMR(123.3")!(+MDX'=+MDFR)
 ....S MDX=$$GET1^DIQ(MDFILE,MDLP_",",4,"I")
 ....Q
 ...S MDIEN=MDLP
 ...S MDFDA(123,MDIEN_",",1)=+MDSERV
 ...S MDFDA(123,MDIEN_",",1.01)=+MDCP
 ...S MDFDA(123,MDIEN_",",4)=+MDCPR_";"_"GMR(123.3,"
 ...S MDFDA(123,MDIEN_",",13)="P"
 ...L +^GMR(123,MDIEN):1 I '$T Q
 ...D FILE^DIE("","MDFDA")
 ...L -^GMR(123,MDIEN)
 ...S MDCOUNT=MDCOUNT+1 W !," Record # ",MDIEN," converted." Q
 ..Q
 .Q
 W !!,"Total Records converted = ",MDCOUNT
 Q
GETSER(MDNUM) ; Get the Consult service
 N MDK,MDIENS,MDARY,MDY
 S MDIENS=MDNUM_","
 D GETS^DIQ(123.3,MDIENS,"2*","I","MDARY")
 S MDK=0 F  S MDK=$O(MDARY(123.32,MDK)) Q:'MDK  S MDY=$G(MDARY(123.32,MDK,.01,"I"))
 Q:$D(MDY) MDY
 Q 0
SETTS ;Set Consult 'TO SERVICE'
 N DIC,X,Y,DTOUT,DUOUT
 S DIC="^GMR(123.5,",DIC(0)="AEMNQ"
 ;No DICOM consults allowed
 S:$D(MDOPT("CONCONVERT"))#2 DIC("S")="I $$DICSRN^MDCONUTL(+Y)"
 D ^DIC I Y<1!($D(DTOUT))!($D(DUOUT)) Q
 S MDTOS=+Y,MDTOSE=$P(Y,U,2)
 Q
SETPR(MDF) ;Set Procedure
 ;MDF=0 : Convert FROM, MDF=1 : Convert TO
 N DIC,X,Y,DTOUT,DUOUT,MDQ
 ;Convert FROM selection to include the related service of selected procedure. No DICOM procedures allowed.
 F  Q:'$D(MDF)  D
 .S DIC="^GMR(123.3,",DIC(0)="AEMNQ",DIC("A")="Select a GMRC Procedure to convert "_$S(MDF>0:"TO: ",1:"FROM: ")
 .D ^DIC I Y<1!($D(DTOUT))!($D(DUOUT)) K MDF Q
 .I MDF=0,$$GET1^DIQ(123.3,+Y,.04)]"" W !!,"This procedure is already a CP - cannot convert",! Q
 .I MDF S MDCPR=+Y,MDCPRE=$P(Y,U,2) K MDF
 .E  S MDFR=+Y,MDFRE=$P(Y,U,2) K MDF
 .Q
 I '$D(MDFR)!($D(MDTOS)) Q
 ;Related Service[123.32P]
 N DIC,X,Y,DTOUT,DUOUT
 ;Only allow service related to selected procedure
 S DIC="^GMR(123.5,",DIC(0)="AEMNQ",DIC("S")="I ($D(^GMR(123.3,MDFR,2,""B"",+Y)))"
 D ^DIC I Y<1!($D(DTOUT))!($D(DUOUT)) Q
 I $D(^MAG(2006.5831,"C",+Y,MDFR)) W !!,"Procedure/Service setup for DICOM - Cannot convert" Q
 S MDTOS=+Y,MDTOSE=$P(Y,U,2)
 Q
DICSRN(MDCON) ;Screen for DICOM consults
 ;Check each entry for a procedure.  If no procedure, it's setup as a consult
 ;and will be screened. Procedure/consult combo is a separate screen on the
 ;procedure conversion option.
 N MDDA,MDS S MDS=1
 S MDDA="" F  S MDDA=$O(^MAG(2006.5831,"B",MDCON,MDDA)) Q:MDDA=""  D  Q:'MDS 
 .S:$$GET1^DIQ(2006.5831,MDDA,2)="" MDS=0
 .Q
 Q MDS
