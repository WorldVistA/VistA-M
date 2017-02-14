PXAPIDEL ;ISL/dee - PCE's code for the DELVFILE api ;06/02/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**1,9,22,130,168,197,216**;Aug 12, 1996;Build 11
 Q
 ;
DELVFILE(PXAWHICH,PXAVISIT,PXAPKG,PXASOURC,PXAASK,PXAECHO,PXAUSER) ;Deletes the requested data related to the visit.
 ;  PXAWHICH is a ^ delimited string with the last two or three letters
 ;           of the v-files to delete entries from and VISIT for the
 ;           administrative data on the visit and STOP for the stop codes.
 ;           (e.g. for immunization the v-file is AUPNVIMM so IMM is
 ;           passed.)  Or "ALL" to delete all of the data from the 
 ;           V-Files, the Stop Code and Visit.
 ;  PXAVISIT is pointer to a visit for which the related data is be
 ;           deleted.
 ;  PACKAGE  (optional) if passed will only delete items created by
 ;           this package
 ;  SOURCE   (optional) if passed will only delete items created by
 ;           this source
 ;  PXAASK   (optional) if passed and not 0 or "" then will ask the user
 ;           if they are sure that they want to delete
 ;           (suggest 1 if want to ask).
 ;  PXAECHO  (optional) if passed and not 0 or "" then will display to
 ;           the user what is being deleted (suggest 1 if want to echo).
 ;  PXAUSER  (optional) this is the duz of a user if you only want to
 ;           delete entries that this user created.  If it is not passed
 ;           or is 0 or "" then it will not matter who created the
 ;           entries being deleted.
 ;
 ; Returns:
 ;   1  if no errors and process completely
 ;   0  if errors occurred
 ;      or try to delete something that was now allowed to delete
 ;      but deletion processed completely as possible
 ;  -1  if user said not to delete or user up arrows out
 ;        or errors out. In any case nothing was delete.
 ;  -2  if could not get a visit
 ;  -3  if called incorrectly
 ;  -4  if dependent entry count is still greater than zer0
 ;
 ;Good visit?
 Q:'$G(PXAVISIT) -2
 Q:'($D(^AUPNVSIT(PXAVISIT,0))#2) -2
 ;
 ;Get package pointer
 S PACKAGE=$G(PACKAGE)
 I PACKAGE="" S PXAPKG=0
 E  I PACKAGE=+PACKAGE S PXAPKG=PACKAGE
 E  S PXAPKG=$$PKG2IEN^VSIT(PACKAGE) I PXAPKG=-1 W:'$D(ZTQUEUED) !,"Procedure ""DELVFILE^PXAPI"" was called incorrectly without a valid ""PACKAGE"", contact IRM." Q -3
 I PXAPKG>0,'($D(^DIC(9.4,PXAPKG,0))#2) W:'$D(ZTQUEUED) !,"Procedure ""DELVFILE^PXAPI"" was called incorrectly without a valid ""PACKAGE"", contact IRM." Q -3
 ;
 ;Lookup source in PCE DATA SOURCE file (#839.7) with LAYGO
 S SOURCE=$G(SOURCE)
 I SOURCE="" S PXASOURC=0
 E  I SOURCE=+SOURCE S PXASOURC=SOURCE
 E  S PXASOURC=$$SOURCE^PXAPIUTL(SOURCE)
 I +PXASOURC=-1 W:'$D(ZTQUEUED) !,"Procedure ""DELVFILE^PXAPI"" was called incorrectly without a valid ""SOURCE"", contact IRM." Q -3
 ;
 K ^TMP("PXK",$J)
 N PXACOUNT,PXAINDX,PXAVFILE,PXAFILE,PXARET,PXAWFLAG
 N PXALEN,PXAIEN,PXAPIECE,PXAMYSOR
 S PXARET=1
 I PXAWHICH="ALL" S PXAWHICH="VISIT^STOP^CPT^IMM^PED^POV^PRV^SK^TRT^HF^XAM^ICR" ; PX*1*216
 S PXALEN=$L(PXAWHICH,"^")
 Q:PXALEN<1 -3
 E  F PXACOUNT=1:1:PXALEN S PXAVFILE=$P(PXAWHICH,"^",PXACOUNT) D  Q:PXARET<0
 . I "~VISIT~STOP~CPT~IMM~PED~POV~PRV~SK~TRT~HF~XAM~ICR~"'[("~"_PXAVFILE_"~") S PXARET=-3 ; PX*1*216
 Q:PXARET<0 PXARET
 I PXAASK D  Q:PXARET<0 PXARET
 . N DIR,X,Y
 . ;ask the user if they want to delete
 . S DIR(0)="Y"
 . S DIR("A")="Are you sure you want to delete the encounter information"
 . S DIR("B")="NO"
 . D ^DIR
 . I Y'=1 S PXARET=-1 Q
 S PXAMYSOR=$$SOURCE^PXAPIUTL("PCE DELETE V-FILES API")
STOP  ;Do Stop Codes first
  S PXAWFLAG=PXAECHO&'$D(ZTQUEUED)
  I "^"_PXAWHICH_"^"["^STOP^" D
 . S PXAIEN=0
 . F PXACOUNT=0:1 S PXAIEN=$O(^AUPNVSIT("AD",PXAVISIT,PXAIEN)) Q:'PXAIEN  D
 .. I PXAUSER>0,PXAUSER'=$P(^AUPNVSIT(PXAIEN,0),"^",23) Q
 .. I $P($G(^AUPNVSIT(PXAIEN,150)),U,3)="C" Q  ; do not delete credit stop code this time
 .. I $P($G(^AUPNVSIT(PXAIEN,150)),U,3)'="S" Q  ; delete only stop codes
 .. I PXAWFLAG W !,"   ...deleting Stop Codes"
 .. N PXST S PXST=$$STOPCODE^PXUTLSTP(PXAMYSOR,"@",PXAVISIT,PXAIEN) I PXST=-1 D
 ... I PXAWFLAG W !!,$C(7),"Cannot edit at this time, try again later." D PAUSE^PXCEHELP
 ;Set up the visit
 S ^TMP("PXK",$J,"PKG")=PXAPKG
 S ^TMP("PXK",$J,"SOR")=PXAMYSOR
 S ^TMP("PXK",$J,"VST",1,"IEN")=PXAVISIT
 F PXAPIECE=0,21,150,800,811 D
 . S (^TMP("PXK",$J,"VST",1,PXAPIECE,"BEFORE"),^TMP("PXK",$J,"VST",1,PXAPIECE,"AFTER"))=$G(^AUPNVSIT(PXAVISIT,PXAPIECE))
 ;
 F PXACOUNT=1:1:PXALEN S PXAVFILE=$P(PXAWHICH,"^",PXACOUNT) D
 . I PXAVFILE="VISIT" D
 .. ;set fields to @
 .. S $P(^TMP("PXK",$J,"VST",1,0,"AFTER"),"^",18)="@"
 .. F INDEX=1:1:8 S:$P(^TMP("PXK",$J,"VST",1,800,"AFTER"),"^",INDEX)]"" $P(^TMP("PXK",$J,"VST",1,800,"AFTER"),"^",INDEX)="@"
 . E  I PXAVFILE="STOP" ;skip already done
 . E  D  ;the v-files
 .. S PXAWFLAG=PXAECHO&'$D(ZTQUEUED)
 .. S PXAFILE=$P($T(FORMAT^@("PXCE"_$S(PXAVFILE="IMM":"VIMM",1:PXAVFILE))),"~",5)
 .. S PXAIEN=0
 .. F PXAINDX=1:1 S PXAIEN=$O(@(PXAFILE_"(""AD"",PXAVISIT,PXAIEN)")) Q:'PXAIEN  D
 ... I $P($G(@(PXAFILE_"(PXAIEN,812)")),"^",1) S PXARET=0 Q
 ... I PXAUSER>0,PXAUSER'=$P($P($P($G(@(PXAFILE_"(PXAIEN,801)")),"^",2),";",1)," ",2) Q
 ... I PXAPKG>0,PXAPKG'=$P($G(@(PXAFILE_"(PXAIEN,812)")),"^",2) Q
 ... I PXASOURC>0,PXASOURC'=$P($G(@(PXAFILE_"(PXAIEN,812)")),"^",3) Q
 ... S ^TMP("PXK",$J,PXAVFILE,PXAINDX,0,"BEFORE")=@(PXAFILE_"(PXAIEN,0)")
 ... S ^TMP("PXK",$J,PXAVFILE,PXAINDX,0,"AFTER")="@"
 ... S ^TMP("PXK",$J,PXAVFILE,PXAINDX,"IEN")=PXAIEN
 ... I PXAWFLAG D
 .... S PXAWFLAG=0
 .... W !,"   ...deleting "
 .... W $S("CPT"=PXAVFILE:"Procedure","IMM"=PXAVFILE:"Immunizations","PED"=PXAVFILE:"Patient Education","ICR"=PXAVFILE:"Contra/Refusal Event",1:"") ; PX*1*216
 .... W $S("POV"=PXAVFILE:"Diagnoses","PRV"=PXAVFILE:"Providers","SK"=PXAVFILE:"Skin Test","TRT"=PXAVFILE:"Treatments","HF"=PXAVFILE:"Health Factors","XAM"=PXAVFILE:"Exams",1:"")
 ;now process all the data except the stop codes which have already been done
 ;
 ;
 N PXKERROR
 I $D(^TMP("PXK",$J)) D
 . I PXAECHO,'$D(ZTQUEUED) D WAIT^DICD
 . D EN1^PXKMAIN
 . D EVENT^PXKMAIN
 . K ^TMP("PXK",$J)
 ;
DELCR ;Do CREDIT Stop Code if it is the only entry except OE entry, not assoc. with apt
 N SDD S SDD=$$VERAPT(PXAVISIT,.SDD) ; CHECK IF APPOINTMENT IS ASSOCIATED
 I 'SDD D  ; perform IF no appointment is associated with
 .S PXAWFLAG=PXAECHO&'$D(ZTQUEUED)
 .I "^"_PXAWHICH_"^"["^STOP^" D
 ..;VERIFY IF TO DELETE CREDIT STOP CODE AND IF SO THEN BE SURE PRIMARY VISIT WILL BE DELETED
 ..;
 ..S PXAIEN=0
 ..F PXACOUNT=0:1 S PXAIEN=$O(^AUPNVSIT("AD",PXAVISIT,PXAIEN)) Q:'PXAIEN  D
 ...I PXAUSER>0,PXAUSER'=$P(^AUPNVSIT(PXAIEN,0),"^",23) Q
 ...I $P($G(^AUPNVSIT(PXAIEN,150)),U,3)'="C" Q
 ...; check how many entries point to the primary visit
 ...N PXPCNT S PXPCNT=$$DEC^VSITKIL(PXAVISIT) ; CHECK COUNT OF PRIMARY VISIT
 ...; CONTINUE ONLY if there are less than three entries;
 ...; if there are 2 entries one of them would have to be OE
 ...; because if not OE then the second entry would be not PCE one
 ...; and the primary visit cannot be deleted
 ...I PXPCNT>2 Q  ; 
 ...I '$D(^SCE("AVSIT",PXAVISIT)) Q
 ...I PXAWFLAG W !,"   ...deleting Credit Stop Codes"
 ...N PXST S PXST=$$STOPCODE^PXUTLSTP(PXAMYSOR,"@",PXAVISIT,PXAIEN) I PXST=-1 D
 ....I PXAWFLAG W !!,$C(7),"Cannot edit/delete at this time, try again later." D PAUSE^PXCEHELP
 ;
 N PXAKILL
 I "^"_PXAWHICH_"^"["^VISIT^" D
 . S PXAKILL=$$KILL^VSITKIL(PXAVISIT)
 Q $S(PXARET=0!$D(PXKERROR):0,$G(PXAKILL):-4,1:1)
 ;
VERAPT(PXAVISIT,SCDXPOV) ;FUNCTION CALLED TO VERIFY IF VISIT IS ASSOCIATED WITH APPOINTMENT
 N SDARRAY,SDCL,SDATE,SVSTSTR,SDFN,SCDXPOV,SDAPP
 K ^TMP($J,"SDAMA301")
 I '$D(^AUPNVSIT(PXAVISIT,0)) Q $G(SCDXPOV)
 S SVSTSTR=^AUPNVSIT(PXAVISIT,0)
 S SDCL=$P(SVSTSTR,U,22),SDATE=$P(SVSTSTR,U)
 S SDARRAY(1)=SDATE_";"_SDATE,SDFN=$P(SVSTSTR,U,5)
 S SDARRAY(4)=SDFN
 S SDARRAY(2)=SDCL
 S SDARRAY("FLDS")="2;12;16"
 N SDCOUNT S SDCOUNT=$$SDAPI^SDAMA301(.SDARRAY)
 I '$D(^TMP($J,"SDAMA301",SDFN,SDCL,SDATE)) Q $G(SCDXPOV)
 S SDAPP=^TMP($J,"SDAMA301",SDFN,SDCL,SDATE)
 N SDENC S SDENC=$P(SDAPP,U,12) ; OE
 ; get OE from VISIT
 N SDOEP
 K ^TMP($J,"SDAMA301")
 D LISTVST^SDOERPC(.SDOEP,PXAVISIT)
 S SDOEP=$P(SDOEP,")")_","_""""""_")"
 S SDOEP=$O(@SDOEP)
 I SDOEP>0 I SDENC=SDOEP S SCDXPOV=1 Q SCDXPOV  ; active appointment is associated with this visit
 Q $G(SCDXPOV)
 ;
