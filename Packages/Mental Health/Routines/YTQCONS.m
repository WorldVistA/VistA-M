YTQCONS ;ASF/ALB - MHA3 CONSULTS ; 8/1/11 2:30pm
 ;;5.01;MENTAL HEALTH;**103**;Dec 30, 1994;Build 27
 ;Reference to TIUPUTU API supported by DBIA #3351
 ;Reference to TIUSRVA API supported by DBIA #5541
 ;Reference to VADPT API supported by DBIA #10061
 ;Reference to TIUSRVP API supported by DBIA #3535
 ;Reference to PXAPI API supported by DBIA #1889
 ;Reference to TIUSRVR1 API supported by DBIA #2944
 ;Reference to ^GMR(123 global supported by DBIA #2586
 ;Reference to ORQQCN1 API supported by DBIA #5608
 ;Reference to TIUCNSLT API supported by DBIA #5546
 ;Reference to TIUSRVR API supported by DBIA #3436
 ;Reference to FILE 8925 supported by DBIA #3268
 ;Reference to FILE 8925.1 supported by DBIA #5540
 Q
CCREATE(YSDATA,YS) ;consult entry
 ;Input AD AS ien of 601.84 mh administration
 ; YS(1...X) as text of note
 N DFN,N,N1,N2,Y,Y1,J1,J2,YSAD,YSAVED,YSENC,YSHOSP,YSOK,YSORD,YSRPRIVL,YST,YSTIT,YSTS,YSVISIT,YSVSIT,YSVSTR,YST1,YSTIUX,YSTIUDA
 N YSPNOK,YSINS,YSPNAC,YSPNTIT,VA,VADM,X,YSAGE,YSB,YSDOB,YSG,YSHDR,YSNM,YSSEX,YSSSN,YSCREQ,YSPCS,YSCON,YSISC
 S YSDATA(1)="[ERROR]"
 S YSAD=$G(YS("AD"),0)
 I '$D(^YTT(601.84,YSAD,0)) S YSDATA(2)="bad ad" Q  ;-->out
 S YSHOSP=$P(^YTT(601.84,YSAD,0),U,11)
 I YSHOSP'>0 S YSDATA(2)="no location" Q  ;-->out
 S YSPCS=$G(YS("COSIGNER")) ;ASF 8/1/20011
 S DFN=$$GET1^DIQ(601.84,YSAD_",",1,"I")
 I DFN'>0  S YSDATA(2)="bad dfn" Q  ;-->out
 S YSAVED=$$GET1^DIQ(601.84,YSAD_",",4,"I")
 S YSORD=$$GET1^DIQ(601.84,YSAD_",",5,"I")
 ;check consult request
 S YSCON=$G(YS("CON"),0)
 I '$D(^GMR(123,YSCON,0)) S YSDATA(2)="bad consult/request" Q  ;-->out
 D GETCSLT^ORQQCN1(.Y,YSCON)
 S YSTIUDA=$P(Y(0),U,20)
 ;
 ;asf 3/10/08 create pnote only when GENERATE '=n and not inactive
 S YSINS=$$GET1^DIQ(601.84,YSAD_",",2,"I")
 S YSPNOK=$$GET1^DIQ(601.71,YSINS_",",28,"I")
 Q:YSPNOK="N"  ;-->out no note for this test
 S YSPNTIT=$$GET1^DIQ(601.71,YSINS_",",30,"E")
 S Y=$$WHATITLE^TIUPUTU(YSPNTIT)
 D ISCNSLT^TIUCNSLT(.YSISC,+Y)
 IF YSISC=0 S Y=$$WHATITLE^TIUPUTU("MHA CONSULT")
 I Y'>0 S YSDATA(2)="pn not setup" Q  ;--->out
 S YSTIT=+Y
 ;
 S YSTS=$$GET1^DIQ(601.84,YSAD_",",2,"I")
 S YSRPRIVL=$$GET1^DIQ(601.71,YSTS_",",9,"E")
 Q:YSRPRIVL'=""  ;-->out  ASF 5/1/07
 ;
 ;set cosigner if required or exit ASF 3/14/08
 D REQCOS^TIUSRVA(.YSCREQ,YSTIT,"",YSORD,"") ;is cosigner required
 ; ASF 8/1/2011
 ;D GETPREF^TIUSRVR(.Y1,YSORD) S YSPCS=$P(Y1,U,9) ; is preferred cosigner set
 Q:YSCREQ&(YSPCS="")  ;-->out required signer not set
 S:YSCREQ&(YSPCS>0) YSTIUX(1208)=YSPCS,YSTIUX(1506)=1
 S YSTIUX(1202)=YSORD
 ;
 D DEM^VADPT,PID^VADPT S YSNM=VADM(1),YSSEX=$P(VADM(5),U),YSDOB=$P(VADM(3),U,2),YSAGE=VADM(4),YSSSN=VA("PID")
 S $P(YSHDR," ",60)="",YSHDR=YSSSN_"  "_YSNM_YSHDR,YSHDR=$E(YSHDR,1,44)_YSSEX_" AGE "_YSAGE
 ;D BOTTOM ;add boilerplate at end
 I YSTIUDA>0 D UPDATE Q  ;-->out
 ;
 D TXTCK(0)
 ;MAKE(SUCCESS,DFN,TITLE,VDT,VLOC,VSIT,TIUX,VSTR,SUPPRESS,NOASF)
 D MAKE^TIUSRVP(.YSOK,DFN,YSTIT,YSAVED,YSHOSP,,.YSTIUX,YSHOSP_";"_YSAVED_";E")
 S ^TMP("YSCON",$J,"ysok")=YSOK
 Q:YSOK'>0  ;-->out
 ;
LINK ;link to request
 N DIE,DA,DR,YSCVP,YSTVP,YSERR
 I +YSOK'>0 Q  ;-->out
 S YSCVP=YSCON_";GMR(123,"
 S DIE=8925,DA=+YSOK,DR="1405////^S X=YSCVP"
 D ^DIE
 ;*** modified by FT on 6/29/11
 N YSFDA
 S YSFDA(123.03,"+1,"_YSCON_",",.01)=YSOK_";TIU(8925,"
 D UPDATE^DIE("","YSFDA","YSERR")
 I $D(YSERR("DIERR")) S YSDATA(1)="[ERROR]",YSDATA(2)="Unable to link to Consult" Q  ;-->out
 ;***
 S YSDATA(1)="[DATA]",YSDATA(2)=YSOK
 S YSVISIT=$$GET1^DIQ(8925,YSOK_",",.03,"I")
 S ^TMP("YSENC",$J,"ENCOUNTER",1,"ENC D/T")=YSAVED
 S ^TMP("YSENC",$J,"ENCOUNTER",1,"HOS LOC")=YSHOSP
 S ^TMP("YSENC",$J,"ENCOUNTER",1,"PATIENT")=DFN
 S ^TMP("YSENC",$J,"ENCOUNTER",1,"SERVICE CATEGORY")="E"
 S ^TMP("YSENC",$J,"ENCOUNTER",1,"ENCOUNTER TYPE")="O"
 S ^TMP("YSENC",$J,"PROCEDURE",1,"ENC PROVIDER")=YSORD
 S ^TMP("YSENC",$J,"PROCEDURE",1,"EVENT D/T")=YSAVED
 S ^TMP("YSENC",$J,"PROVIDER",1,"NAME")=YSORD
 S ^TMP("YSENC",$J,"PROVIDER",1,"PRIMARY")=1
 S YSENC=$$DATA2PCE^PXAPI("^TMP(""YSENC"",$J)",19,"MHA DATA",.YSVISIT,"^TMP(""YSENC"",$J")
 K ^TMP("YSENC",$J)
 Q
UPDATE ;
 K ^TMP("TIUVIEW",$J)
 D TGET^TIUSRVR1(.YST1,YSTIUDA)
 S N1=4,N2=0 ;keep from adding header each time
 F  S N1=$O(^TMP("TIUVIEW",$J,N1)) Q:N1'>0  S N2=N2+1,YSTIUX("TEXT",N2,0)=^TMP("TIUVIEW",$J,N1)
 K ^TMP("TIUVIEW",$J)
 S YSTIUX(.02)=DFN
 S YSTIUX(1301)=YSAVED
 S YSTIUX(1302)=YSORD
 S $P(X,"_",75)=""
 S N2=N2+1,YSTIUX("TEXT",N2,0)=X
 D TXTCK(N2)
 D UPDATE^TIUSRVP(.YSOK,YSTIUDA,.YSTIUX)
 S:YSOK YSDATA(1)="[DATA]",YSDATA(2)=YSOK
 Q
TXTCK(N2) ;clean text
 S N=0,N1=0 F  S N=$O(YS(N)) Q:N'>0  D
 . S YSG=YS(N)
 . I YSG="" S YSB=$G(YSB)+1
 . E  S YSB=0
 . I (YSG="")&(YSB>2) Q  ;no print mult blanks
 . I N>3 Q:($E(YSG,1,51)=$E(YSHDR,1,51))
 . I N>3 Q:YSG?." "1"PRINTED    ENTERED"." "
 . Q:YSG?1"Not valid unless signed: Reviewed by".E
 . Q:YSG?1"Printed by: ".E
 . S N1=N1+1
 . S YSTIUX("TEXT",N1+N2,0)=YS(N) K YS(N)
 Q
