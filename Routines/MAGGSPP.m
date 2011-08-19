MAGGSPP ;WOIFO/GEK - Utilities for Post Processing of a new Image Entry
 ;;3.0;IMAGING;**7,8,48**;Jan 11, 2005
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed             |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
 Q
ACTION(MAGRY,MAGIEN) ;RPC [MAG4 POST PROCESSING]
 ; Post processing when Image is sucessfully created in Image
 ;  This is Pre 3.0.8
 ; file and copied to Network.
 ;       MAGRY : is the Return Array
 ;       MAGRY(0)  = 1^SUCCESS
 ;                OR 0^ERROR MESSAGE
 ;       MAGIEN : is the Internal Entry Number in the Image File.
 ;  This call is Post Processing depending on the Type of MAG DESCRIPTIVE CATEGORY
 ;  Does the Image Point to a MagDescriptive Category.
 ;  
 I '+$G(^MAG(2005,MAGIEN,100)) S MAGRY(0)="1^No Post Processing required for Image ID: "_MAGIEN Q
 N MAGCTG S MAGCTG=+^MAG(2005,MAGIEN,100)
 I '+$G(^MAG(2005.81,MAGCTG,1)) S MAGRY(0)="1^No Post Processing required for Image ID: "_MAGIEN Q
 ; SO here we know an action is in play for this Image Category
 N MAGACT
 S MAGACT=$P(^MAG(2005.81,MAGCTG,1),U,3,4)
 ;        D @(TAGRTN_"(.STAT)")
 D @(MAGACT_"(.MAGRY,"_MAGIEN_")")
 ;;
 Q
POSTACT(MAGRY,MAGIEN) ;RPC [MAG4 POST PROCESS ACTIONS]
 ; Post processing when Image is sucessfully created in Image
 ; file and copied to Network. Patch 3.0.8  
 ;       MAGRY : is the Return Array
 ;       MAGRY(0)  = 1^SUCCESS
 ;                OR 0^ERROR MESSAGE
 ; Post Processing Action: depends on Image Type (fld #42 )
 N TYPE,AIEN
 S TYPE=+$P($G(^MAG(2005,MAGIEN,40)),"^",3) I 'TYPE D  Q
 . ; comment out, for backward compatibility
 . ;S MAGRY(0)="1^No Post Processing required for Image ID: "_MAGIEN Q
 . ;This is here so that the new code is backward compatible. If no value for TYPE INDEX, we have to 
 . ;check the MAG DESC CTG field.
 . D ACTION(.MAGRY,MAGIEN)
 . Q
 I '$D(^MAG(2005.86,"ATYPE",TYPE)) S MAGRY(0)="1^No Post Processing required for "_$P(^MAG(2005.83,TYPE,0),U) Q
 S AIEN=$O(^MAG(2005.86,"ATYPE",TYPE,""))
 I '$P(^MAG(2005.86,AIEN,0),"^",2) S MAGRY(0)="1^Action: "_$P(^MAG(2005.86,AIEN,0),"^")_" is Not Active." Q
 ; SO here we know an action is in play for this TYPE INDEX
 N MAGACT
 S MAGACT=$P(^MAG(2005.86,AIEN,0),"^",3,4)
 D @(MAGACT_"(.MAGRY,"_MAGIEN_")")
 Q
HEC(MAGRY,MAGIEN) ;  QUEING OF HEC IMAGES
 S MAGRY(0)=$$GCC^MAGBAPI(MAGIEN,$$DA2PLC^MAGBAPIP(MAGIEN,"F")) ; DBI - SEB 9/23/2002
 S MAGRY(1)=MAGIEN_" "_$$NOW^XLFDT
 D ACTION^MAGGTAU("PPACT^"_$P(^MAG(2005,MAGIEN,0),"^",7)_"^"_MAGIEN_"|HEC-COPY using GCC^MAGBAPI",1)
 ;ACTION(TXT,LOGTM,MAGSESS) ;Call to log actions for Imaging Session.
 ; TXT is "^" delimited string
 ; $P(1) is code   $P(2) is DFN   $P(3) is Image IEN
 ; LOGTM   - [1|0] Flag to indicate whether or not to log the time of the Action.  Default = 0
 ; MAGSESS - Session IEN where the action should be logged.  Default to MAGJOB("SESSION")
 ;
 Q
