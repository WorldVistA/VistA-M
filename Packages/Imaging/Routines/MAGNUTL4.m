MAGNUTL4 ;HIE/ZEB - Automatic updates to Imaging Site Parameters (#2006.1)  ; 11 JUL 2024@13:39
 ;;3.0;IMAGING;**365**;July 11, 2024;Build 19
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
SERVER ;entry point from MAG CACHE SETTINGS UPDATE option
 ;Update message must have a subject containing MAG CACHE SETTINGS UPDATE^<Station Number>
 ;The station number must correspond to the INSTITUTION (#4) entry linked to the IMAGING SITE PARAMETERS (#2006.1) entry to be updated
 ; - Example: MAG CACHE SETTINGS UPDATE^756
 ;Each line in the message will be applied to a row in the PRECACHE SETTINGS multiple
 ;There are three valid formats for a line in this message:
 ; - Add/Edit settings for a CPT Code
 ;   - If there's already a row for this code, the settings will be replaced. Otherwise, a new row is created.
 ;   - <CPT code>^<Cache at Order Signed Y/N>^<Cache at Exam Registered Y/N>
 ;   - Example: 76091^Y^N
 ; - Delete settings for a CPT Code
 ;   - Removes settings for a CPT code. This has the effect of disabling caching for that code.
 ;   - <CPT code>^@
 ;   - Example: 76091^@
 ; - Add/Edit settings for ALL CPT Codes
 ;   - As of patch 365, functionality for All CPT Codes is only available for Exam Reg, but the messaging spec includes both.
 ;   - *ALL^<Cache at Order Signed Y/N (currently unsupported)>^<Cache at Exam Registered Y/N>
 ;   - Example: *ALL^^Y
 ;ZEXCEPT: XMZ ;ID of triggering message
 ;Call to XMXAPI covered by IA #2729
 ;Call to XMXUTIL2 covered by IA #2736
 N MAGXMZ,SUBJ,STN,INSTIEN,ISPIEN,CPTCODE,ORDSIGN,EXAMREG,CPTIEN,LN
 S MAGXMZ=$G(XMZ)
 Q:MAGXMZ=""  ;Message unknown
 S SUBJ=$$SUBJ^XMXUTIL2($G(^XMB(3.9,MAGXMZ,0)))
 D:SUBJ["MAG CACHE SETTINGS UPDATE"
 . ;Abort if no valid station number or no corresponding IMAGING SITE PARAMETERS entry
 . S STN=$P(SUBJ,U,2)
 . Q:STN=""
 . S INSTIEN=$O(^DIC(4,"D",STN,""))
 . Q:INSTIEN=""
 . S ISPIEN=$O(^MAG(2006.1,"B",INSTIEN,""))
 . Q:ISPIEN=""
 . ;Process each line in the message
 . N XMZ,XMER,DIK,DA,DIE,DR,DIC,X
 . S XMZ=MAGXMZ
 . F  S MESSAGE=$$READ^XMGAPI1() Q:XMER<0  D
 .. S CPTCODE=$P(MESSAGE,U,1)
 .. S ORDSIGN=$P(MESSAGE,U,2)
 .. S EXAMREG=$P(MESSAGE,U,3)
 .. Q:CPTCODE=""  ;invalid row if no code specified
 .. I CPTCODE="*ALL" D  Q  ;process All CPT Codes settings
 ... S DIE="^MAG(2006.1,"
 ... S DA=ISPIEN
 ... S DR="351///"_$S(EXAMREG="Y":1,1:"@")
 ... D ^DIE
 .. Q:"^Y^N^@^"'[(U_ORDSIGN_U)  ;invalid row if no Y/N or @
 .. I ORDSIGN="@" D  I 1 ;deleting settings for a code
 ... ;find IEN from CPT code
 ... S CPTIEN=$O(^ICPT("B",CPTCODE,""))
 ... ;abort if no record of CPT code
 ... Q:CPTIEN=""
 ... ;find row in settings for CPT code
 ... S LN=$$CPTLNNUM(CPTIEN,ISPIEN)
 ... ;if row exists, delete it
 ... I LN>0 S DIK="^MAG(2006.1,1,""PRECACHE"",",DA=LN,DA(1)=ISPIEN D ^DIK
 .. E  D  ;add/edit settings for a code
 ... Q:"^Y^N^"'[(U_EXAMREG_U)  ;invalid row if no Y/N
 ... ;find IEN from CPT code
 ... S CPTIEN=$O(^ICPT("B",CPTCODE,""))
 ... ;abort if no record of CPT code
 ... Q:CPTIEN=""
 ... ;find row in settings for CPT code
 ... S LN=$$CPTLNNUM(CPTIEN,ISPIEN)
 ... ;if row exists, update On Order Signed and On Exam Registered
 ... I LN>0 D  I 1
 .... S DIE="^MAG(2006.1,"_ISPIEN_",""PRECACHE"","
 .... S DA=LN,DA(1)=ISPIEN
 .... S DR="1///"_$S(ORDSIGN="Y":1,1:"@")
 .... S DR=DR_";2///"_$S(EXAMREG="Y":1,1:"@")
 .... D ^DIE
 ... E  D  ;otherwise add new row
 .... K DO,DA
 .... S DIC="^MAG(2006.1,"_ISPIEN_",""PRECACHE"","
 .... S DIC(0)="FL"
 .... S DA(1)=ISPIEN
 .... S X=CPTIEN
 .... S DIC("DR")=""
 .... S:ORDSIGN="Y" DIC("DR")="1///1"
 .... S:EXAMREG="Y" DIC("DR")=$S(DIC("DR")]"":DIC("DR")_";",1:"")_"2///1"
 .... D FILE^DICN
 N ZTREQ
 D ZAPSERV^XMXAPI("S.MAG CACHE SETTINGS UPDATE",MAGXMZ)
 S ZTREQ="@"
 Q
 ;
CPTLNNUM(CPTIEN,ISPIEN) ;Return the line number in the PRECACHE SETTINGS multiple for a CPT code
 ;will return -1 if a line was not found
 N LN
 S LN=$O(^MAG(2006.1,ISPIEN,"PRECACHE","B",CPTIEN,""))
 Q:LN]"" LN
 Q -1
 ;
