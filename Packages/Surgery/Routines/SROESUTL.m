SROESUTL ;BIR/ADM - SURGERY E-SIG UTILITY ;09/22/04
 ;;3.0; Surgery ;**100,134**;24 Jun 93
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to EXTRACT^TIULQ supported by DBIA #2693
 ;
TIU ; get document specifics from TIU
 D EXTRACT^TIULQ(SRTIU,"SRT",.SRERR)
 S SRDOC=SRT(SRTIU,.01,"E"),SRCASE=$P(SRT(SRTIU,1405,"I"),";")
 Q
DELETE(SRTIU) ; delete action
 N SR,SRCASE,SRDOC,SRERR,SRFLD,SRT D TIU
 S SRFLD=$S(SRDOC["OPERATION":1000,SRDOC["NURSE INTRAOP":1001,SRDOC["PROCEDURE":1002,1:1003) D
 .S SR=$G(^SRF(SRCASE,"TIU"))
 .I SRFLD=1000,$P(SR,"^")=SRTIU D AT Q
 .I SRFLD=1001,$P(SR,"^",2)=SRTIU D AT Q
 .I SRFLD=1002,$P(SR,"^",3)=SRTIU D AT Q
 .I SRFLD=1003,$P(SR,"^",4)=SRTIU D AT
 Q
AT N SRY S SRY(130,SROP_",",SRFLD)="@" D FILE^DIE("","SRY")
 Q
RETRACT(SRTIU) ; retraction action
 D DELETE(SRTIU),ALERT(SRTIU)
 Q
ALERT(SRTIU) ; issue alert to author of document
 N SRAUTHOR,SRDOC,SRCASE,SRERR,SRT
 D TIU S SRAUTHOR=SRT(SRTIU,1202,"I") Q:'SRAUTHOR
 S XQAMSG=SRDOC_" retracted on case #"_SRCASE_"."
 S XQA(SRAUTHOR)="",XQADATA=SRCASE_"^"_SRDOC,XQAROU="ACTION^SROESUTL"
 D SETUP^XQALERT
 Q
ACTION ; alert action
 Q:'$D(XQADATA)  N DFN,SR,SRSDT,SRTN,SRDOC,SRY,VA,VADM,Y
 S SRTN=$P(XQADATA,"^"),SRDOC=$P(XQADATA,"^",2) Q:'SRTN!(SRDOC="")
 S SR=$G(^SRF(SRTN,0)) Q:SR=""
 S DFN=$P(SR,"^") D DEM^VADPT S Y=$P(SR,"^",9) D DD^%DT S SRSDT=Y
 S SRY(1)=SRDOC_" retracted on case #"_SRTN,SRY(1,"F")="!!!"
 S SRY(2)=VADM(1)_" ("_VA("PID")_")   Op Date: "_SRSDT
 S SRY(3)="Principal Procedure: "_$P(^SRF(SRTN,"OP"),"^"),SRY(4)=" " D EN^DDIOL(.SRY)
 Q
STATUS(SRTIU) ; get signature status
 N SRT,STATUS
 D EXTRACT^TIULQ(SRTIU,"SRT",.SRERR,".05") S STATUS=SRT(SRTIU,.05,"I")
 Q STATUS
SIGNED(SRCASE) ;is NIR or AR on this case or on concurrent case signed?
 N SRCONCC,SRI,SRND,SRSINED
 S SRSINED=0,SRND=$G(^SRF(SRCASE,"TIU"))
 F SRI=2,4 S SRTIU=$P(SRND,"^",SRI) I SRTIU,$$STATUS(SRTIU)=7 S SRSINED=1 Q
 S SRCONCC=$P($G(^SRF(SRCASE,"CON")),"^") I SRCONCC D
 .S SRND=$G(^SRF(SRCONCC,"TIU"))
 .F SRI=2,4 S SRTIU=$P(SRND,"^",SRI) I SRTIU,$$STATUS(SRTIU)=7 S SRSINED=1 Q
 Q SRSINED
