PXBGSC ;SLC/PKR - Get the V Standard Codes before data. ;08/29/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
SC(VISIT,SCIENLST) ;--Gather the entries in the V Standard Codes file
 N CODE,CODESYS,DA,DIC,DIQ,DR,IEN,PLIEN
 N SOURC,TEMP
 ;
 ;Looking at PXBGHF and PXAIHF there is a lot of data built in 
 ;PXBGHF that is never used in PXAIHF. The main thing it does is to
 ;return a list of IENs to PXAIHF. We do the same thing here for SC.
 I '$D(^AUPNVSC("AD",VISIT)) Q
 S IEN=0
 F  S IEN=$O(^AUPNVSC("AD",VISIT,IEN)) Q:IEN'>0  D
 . S TEMP=^AUPNVSC(IEN,0)
 . S CODE=$P(TEMP,U,1)
 . S CODESYS=$P(TEMP,U,5)
 . S SCIENLST(CODE,CODESYS,IEN)=""
 Q
 ;
 ;WHAT DOES THIS DO?
 ;D PL^PXBGPL(PATIENT)
 Q
 ;
